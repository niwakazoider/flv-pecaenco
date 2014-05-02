package net.fukure.pecaenco.stream 
{
	import flash.events.EventDispatcher;

	public class MyBroadcastStream extends EventDispatcher
	{
		import flash.events.Event;
		import flash.events.TimerEvent;
		import flash.events.NetStatusEvent;
		import flash.events.SecurityErrorEvent;
		import flash.net.NetConnection;
		import flash.net.NetStream;
		import flash.net.ObjectEncoding;
		import flash.utils.Timer;
		import net.fukure.pecaenco.event.MyEvent;
		import net.fukure.pecaenco.bcmedia.MyMedia;
	
		private var nc:NetConnection;
		private var ns:NetStream;
		private var media:MyMedia;
		private var timeout:Timer;
		private var streamType:String;
		private const rtmpUrl:String = "rtmp://localhost/live";
		
		public function MyBroadcastStream(media:MyMedia) 
		{
			this.media = media;
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
		}
		
		public function connect():void {
			nc = new NetConnection();
			nc.client = new NetConnectionClient();
			nc.connect(rtmpUrl);
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			timeout = new Timer(2000, 1);
			timeout.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				if (!nc.connected) {
					close();
				}
			});
			timeout.start();
		}
		
		public function close():void {
			try {
				if (ns != null) {
					ns.close();
					ns = null;
				}
				if (nc != null) {
					nc.close();
					nc = null;
				}
			}catch (e:Error) {
				
			}
		}
		
		public function publish():void {
			//H264Stream.setStreamSetting(ns, media.getCamera());
			ns.attachCamera(media.getCamera());
			ns.attachAudio(media.getMic());
			ns.publish("livestream", "live");
		}
		
		public function play():void {
			ns.play("livestream");
			media.getVideo().attachNetStream(ns);
		}
		
		private function onPlay():void {
			streamType = "play";
			dispatchEvent(new MyEvent(MyEvent.PLAY));
		}
		
		private function onPublish():void {
			var meta_data:Object = MyMetaDataCreator.create(ns, media.getCamera(), media.getMic());
			ns.send("@setDataFrame", "onMetaData", meta_data);
			streamType = "publish";
			dispatchEvent(new MyEvent(MyEvent.PUBLISH));
		}
		
		private function onClose():void {
			if (streamType == "publish") {
				dispatchEvent(new MyEvent(MyEvent.UNPUBLISH));
			}
			if (streamType == "play") {
				dispatchEvent(new MyEvent(MyEvent.STOP));
			}
			if (streamType == null) {
				dispatchEvent(new MyEvent(MyEvent.ERROR));
			}
			dispatchEvent(new MyEvent(MyEvent.CLOSE));
		}
		
		private function onConnect():void {
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, function(e:NetStatusEvent):void {
				switch(e.info.code){
					case "NetStream.Publish.Start":
						onPublish();
						break;
					//case "NetStream.Unpublish.Success":
					//	onUnPublish();
					//	break;
					case "NetStream.Play.Start":
						onPlay();
						break;
					//case "NetStream.Play.Stop":
					//	onStop();
					//	break;
				}
			});
			dispatchEvent(new MyEvent(MyEvent.CONNECT));
		}
		
		private function netStatusHandler(e:NetStatusEvent):void {
			switch (e.info.code) {
				case "NetConnection.Connect.Success":
					//nc.call("checkBandwidth", null);
					onConnect();
					break;
				case "NetConnection.Connect.Closed" :
					onClose();
					break;
				case "NetConnection.Connect.Failed":
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
	}
}

class NetConnectionClient {
	public function onBWCheck(... rest):Number {
		return 0;
	}
	public function onBWDone(... rest):void {
		var bandwidthTotal:Number;
		if (rest.length > 0){
			bandwidthTotal = rest[0];
			trace("bandwidth = " + bandwidthTotal + " Kbps.");
		}
	}
}
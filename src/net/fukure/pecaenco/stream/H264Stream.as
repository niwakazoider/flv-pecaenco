package net.fukure.pecaenco.stream 
{
	import flash.media.Camera;
	import flash.media.H264Level;
	import flash.media.H264VideoStreamSettings;
	import flash.media.H264Profile;
	import flash.net.NetStream;
	
	public class H264Stream 
	{
		
		public function H264Stream() 
		{
			
		}
		
		public static function setStreamSetting(stream:NetStream, camera:Camera):void
		{
			try {
				var h264Settings:H264VideoStreamSettings = new H264VideoStreamSettings();
				h264Settings.setProfileLevel(H264Profile.MAIN,H264Level.LEVEL_5_1);
				h264Settings.setQuality(0,0);
				h264Settings.setKeyFrameInterval(15);
				h264Settings.setMode(camera.width,camera.height,camera.fps);
				stream.videoStreamSettings = h264Settings;
			}catch (e:Error) {
				trace(e);
			}
		}
		
	}

}
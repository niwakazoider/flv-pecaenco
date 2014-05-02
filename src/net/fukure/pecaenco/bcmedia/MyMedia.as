package net.fukure.pecaenco.bcmedia 
{
	public class MyMedia 
	{
		import flash.media.Camera;
		import flash.media.Microphone;
		import flash.media.Video;
		import net.fukure.pecaenco.bcmedia.MyCamera;
		import net.fukure.pecaenco.bcmedia.MyMicrophone;
	
		private var camera:Camera;
		private var mic:Microphone;
		private var video:Video;
		private var width:int;
		private var height:int;
		
		public function MyMedia(w:int = 320, h:int = 240) {
			width = w;
			height = h;
		}
		
		public function init(camera_name:String, mic_name:String):void {
			var camera_fps:Number = 20;
			camera = MyCamera.getCamera(camera_name);
			camera.setMode(width, height, camera_fps);
			camera.setQuality(512*1024/8, 0);
			
			mic = MyMicrophone.getMic(mic_name);
			mic.setSilenceLevel(0);
			mic.rate = 44;
			mic.encodeQuality = 8;
			
			video = new Video(width, height);
			video.attachCamera(camera);
		}
		
		public function getCamera():Camera {
			return camera;
		}
		public function getVideo():Video {
			return video;
		}
		public function getMic():Microphone {
			return mic;
		}
		public function setVideoFps(fps:int):void {
			if (0<fps && fps<=30){
				camera.setMode(camera.width, camera.height, fps);
			}
		}
		public function setVideoQuality(kbitrate:int, quality:int):void {
			if(0<=quality && quality<=100){
				camera.setQuality(kbitrate * 1024 / 8, quality);
			}
		}
		public function setMicQuality(quality:int):void {
			if (0 <= quality && quality <= 10) {
				mic.encodeQuality = quality;
			}
		}
		public function setMicRate(rate:int):void {
			var rates:Array = [5, 8, 11, 22, 44];
			for (var i:int = 0; i < rates.length; i++) {
				if (rates[i] == rate) {
					mic.rate = rate;
				}
			}
		}
		public function setMicVolume(volume:int):void {
			if(0<=volume && volume<=100){
				mic.gain = volume;
			}
		}
		
	}

}
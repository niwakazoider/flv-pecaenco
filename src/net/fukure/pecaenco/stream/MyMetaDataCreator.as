package net.fukure.pecaenco.stream 
{
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.NetStream;
		
	public class MyMetaDataCreator
	{
		public static function create(ns:NetStream, camera:Camera = null ,mic:Microphone = null):Object {
			var meta_data:Object = new Object();
			if (camera != null) {
				meta_data.width = new Number(camera.width);
				meta_data.height = new Number(camera.height);
				meta_data.framerate = new Number(camera.fps);
				meta_data.videocodecid = new Number(2.0);
				meta_data.videodatarate = new Number(camera.bandwidth*8/1024);
			}
			if (ns.videoStreamSettings.codec == "H264Avc"){
				meta_data.videocodecid = "avc1";
			}
			if (mic != null) {
				if (mic.rate == 8) {
					meta_data.audiocodecid = new Number(5.0);
				}else {
					meta_data.audiocodecid = new Number(6.0);
				}
				if (mic.rate == 5) {
					meta_data.audiodatarate = new Number(5.0);
				}else if (mic.rate == 8) {
					meta_data.audiodatarate = new Number(8.0);
				}else if (mic.rate == 11) {
					meta_data.audiodatarate = new Number(11.0);
				}else if (mic.rate == 22) {
					meta_data.audiodatarate = new Number(22.0);
				}else if (mic.rate == 44) {
					meta_data.audiodatarate = new Number(44.0);
				}
			}
			return meta_data;
		}
	}

}
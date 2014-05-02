package net.fukure.pecaenco.bcmedia 
{
	import flash.media.Microphone;
	
	public class MyMicrophone 
	{
		
		public function MyMicrophone() 
		{
			
		}
		
		public function getList():Array {
			return Microphone.names;
		}
		
		public static function getMic(mic:String):Microphone {
			for (var i:int = 0; i < Microphone.names.length; i++) 
			{
				if (Microphone.names[i] == mic) {
					return Microphone.getMicrophone(i);
				}
			}
			return null;
		}
		
	}

}
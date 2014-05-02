package net.fukure.pecaenco.bcmedia 
{
	import flash.media.Camera;
	 
	public class MyCamera 
	{
		
		public function MyCamera() 
		{
		}
		
		public function getList():Array {
			return Camera.names;
		}
		
		public static function getCamera(camera:String):Camera {
			for (var i:int = 0; i < Camera.names.length; i++) 
			{
				if (Camera.names[i] == camera) {
					return Camera.getCamera(i.toString());
				}
			}
			return null;
		}
		
	}

}
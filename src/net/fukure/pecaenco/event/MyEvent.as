package net.fukure.pecaenco.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author petit
	 */
	public class MyEvent extends Event
	{
		public static const CONNECT:String = "connect";
		public static const CLOSE:String = "close";
		public static const PUBLISH:String = "publish";
		public static const UNPUBLISH:String = "unpublish";
		public static const PLAY:String = "play";
		public static const STOP:String = "stop";
		public static const ERROR:String = "error";
		
		public function MyEvent(type:String)
		{
			super(type);
		}
		
		public override function clone():Event
		{
			return new MyEvent(type);
		}
		
		public override function toString():String
		{
			return formatToString("MyEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}

}
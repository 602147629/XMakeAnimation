package com
{
	import flash.events.Event;
	
	public class EditEvent extends Event
	{
		public static const PROPERTY_VALUE_CHANGE:String = "propertyValueChange";
		
		public static const CLICK_ONE_BRUSH:String = "CLICK_ONE_BRUSH";
		
		public var data:Object;
		public function EditEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
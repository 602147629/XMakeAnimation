package com
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		public static const EVENT_SOURCE_UPDATE:String = "event_source_update";
		public static const DRAWLAYER_CLICK:String = "drawlayer_click";
		
		private var _data:*;
		public function DataEvent(type:String, data:*)
		{
			_data = data;
			super(type, false, false);
		}

		public function get data():*
		{
			return _data;
		}

		public function set data(value:*):void
		{
			_data = value;
		}

	}
}
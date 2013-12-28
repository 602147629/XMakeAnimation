package com
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DispatcherManager extends EventDispatcher
	{
		
		private static var _instance:DispatcherManager;
		public function DispatcherManager(target:IEventDispatcher=null)
		{
			super(target);
		}

		public static function getInstance():DispatcherManager
		{
			if(_instance == null) _instance = new DispatcherManager();
			return _instance;
		}

	}
}
package com.demo.net.loader
{
	import com.demo.core.animation.BitmapFrameData;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * @author Sampson
	 */
	public class StaticDataModel extends EventDispatcher {
		private static var _instance : StaticDataModel ;
		public var animCache : Dictionary;
		public static var currIndex:int = 0;
		public var linkState:Boolean = false;
		public function StaticDataModel() {
			
			animCache = new Dictionary();
		}

		public static function get instance():StaticDataModel
		{
			if(null == _instance)
				_instance = new StaticDataModel();
			return _instance;
		}

		public function Init(xml:XML) : void {
		}

		protected function getPoint(x : int, y : int) : Point {
			return new Point(x, y);
		}

		public function setOffset(packid : int, action : int, vect : Vector.<BitmapFrameData>) : void {
			if (!vect)
				return;
			var key : String = packid + "_" + action;
			var offsets : Array = animCache[key];
			if (offsets) {
				var len : int = Math.min(offsets.length, vect.length);
				var point : Point;
				for (var i : int = 0; i < len; i++) {
					point = offsets[i];
					vect[i].offsetX = point.x;
					vect[i].offsetY = point.y;
				}
			}
		}
		public function setOffsetFrameData(packid : int, action : int, pos:Point) : void 
		{
			var key : String = packid + "_" + action;
			var offsets : Array = animCache[key];
			var index:int = action - 1;
				
			if (offsets) 
			{
				var point : Point = offsets[index];
				if(null == point)
				{
					point = new Point();
					offsets[index] = point;
				}
				point.x = pos.x;
				point.y = pos.y;
			}
		}
	}
}

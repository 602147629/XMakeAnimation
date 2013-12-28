package com.demo.define {
	import com.demo.core.KeySets;
	import com.demo.core.creature.BaseActionType;
	
	import flash.filesystem.File;

	/**
	 * @author Sampson
	 */
	public class Config {
		
		public static var projectPath:String = "";
//				public static const swfPath : String = resPath + "runtime\\";
		public static const imageScaleRate : Number = 1;
		
		/**
		 *检查碰撞 
		 */		
		public static const BOX_TYPE_HIT:int = 0;
		/**
		 *设置重心 
		 */		
		public static const BOX_TYPE_FOCUS:int = 1;
		
		public static var keySets:KeySets = new KeySets();
		
		public static function get resPath():String
		{
			return projectPath + "/xml/";
		}
		
		public static function get swfPath():String
		{
			return projectPath + "/swf/";
		}
		
		
		public static function getTypeStr(type:int):String
		{
			switch(type)
			{
				case BaseActionType.ATK:
					return "攻击";
				case BaseActionType.FALL_DOWN:
					return "跌倒";
				case BaseActionType.GET_UP:
					return "浮空";
				case BaseActionType.JUMP_ATK:
					return "跳跃";
				case BaseActionType.IDLE:
					return "站立";
				case BaseActionType.WALK:
					return "行走";
				case BaseActionType.RUN:
					return "跑步";
			}
			return "呼吸";
		}
		public static function getBoxTypeStr(type:int):String
		{
			switch(type)
			{
				case BOX_TYPE_HIT:
					return "碰撞检测";
				case BOX_TYPE_FOCUS:
					return "重心点";
			}
			return "碰撞检测";
		}
		public static function getBoxType(type:String):int
		{
			switch(type)
			{
				case "碰撞检测":
					return BOX_TYPE_HIT;
				case "重心点":
					return BOX_TYPE_FOCUS;
			}
			return BOX_TYPE_HIT;
		}
	}
}

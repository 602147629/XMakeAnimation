package com.vo
{
	/**
	 *	动作参数类型 
	 */	
	public class ActionParameterType
	{
		/**
		 * loop:播放几次（无限循环填-1） 
		 delay:帧之间的间隔毫秒  
		 frames:播放帧号的帧序列
		 ATK为攻击中的连击子动作 
		 | id为连击id，
		 | dx为攻击时往攻击方向所位移的速度 
		 | nextType：下个连击的id(终止为-1) 
		 | nextFrame:到第几帧时，方可进入下个连击 
		 | slides:按幀來偏移人物位置 
		 | offsetFrame:第几帧开始时，使用slide偏移位置控制移动
		 hit攻击信息==> weaponType:武器类型 
		 modeName:碰撞类型（只能填写 单次碰撞或多次碰撞）
		 typeName:攻击属性 halfH:碰撞检测的z景深    
		 dist:击退距离  
		 hitWaitSelf:击中敌人后自己的硬直帧数 
		 keys:第几帧出现攻击判定矩形 
		 sames:1为攻击后，敌人向攻击者位移 2为敌人向攻击方向位移 
		 sources:攻击矩形大小位置（相对于人物脚底中心)(用;分割，填写多个，与keys对应，若数量不足keys数量，则以最后一个矩形补足剩下keys
		 JUMP_ATK==> jumpHigh:跳跃高度  
		 atkFrames:跳跃攻击帧  
		 invalidFrames:跳跃攻击不响应帧
		 BE_HIT==> fadeFrames:被击动作1序列帧 
		 bentFrames:被击动作2序列帧 
		 * */
		public static const  LOOP : uint = 1;
		public static const  DELAY : uint = 2;
		public static const  FRAMES : uint = 3;
		public static const  ID : uint = 4;
		public static const  DX : uint = 5;
		public static const  NEXTTYPE : uint = 6;
		public static const  NEXTFRAME : uint = 7;
		public static const  SLIDES : uint = 8;
		public static const  OFFSETFRAME : uint = 9;
		public static const  WEAPONTYPE : uint = 10;
		public static const  MODENAME : uint = 11;
		public static const  TYPENAME : uint = 12;
		public static const  DIST : uint = 13;
		public static const  HITWAITSELF : uint = 14;
		public static const  KEYS : uint = 15;
		public static const  SAMES : uint = 16;
		public static const  SOURCES : uint = 17;
		public static const  JUMPHIGH : uint = 18;
		public static const  ATKFRAMES : uint = 19;
		public static const  INVALIDFRAMES : uint = 20;
		public static const  FADEFRAMES : uint = 21;
		public static const  BENTFRAMES : uint = 22;
		
		public static const  LOOP_STRING : String = "loop";
		public static const  DELAY_STRING : String = "delay";
		public static const  FRAMES_STRING : String = "frames";
		public static const  ID_STRING : String = "id";
		public static const  DX_STRING : String = "dx";
		public static const  NEXTTYPE_STRING : String = "nexttype";
		public static const  NEXTFRAME_STRING : String = "nextframe";
		public static const  SLIDES_STRING : String = "slides";
		public static const  OFFSETFRAME_STRING : String = "offsetframe";
		public static const  WEAPONTYPE_STRING : String = "weapontype";
		public static const  MODENAME_STRING : String = "modename";
		public static const  TYPENAME_STRING : String = "typename";
		public static const  DIST_STRING : String = "dist";
		public static const  HITWAITSELF_STRING : String = "hitwaitself";
		public static const  KEYS_STRING : String = "keys";
		public static const  SAMES_STRING : String = "sames";
		public static const  SOURCES_STRING : String = "sources";
		public static const  JUMPHIGH_STRING : String = "jumphigh";
		public static const  ATKFRAMES_STRING : String = "atkframes";
		public static const  INVALIDFRAMES_STRING : String = "invalidframes";
		public static const  FADEFRAMES_STRING : String = "fadeframes";
		public static const  BENTFRAMES_STRING : String = "bentframes";
		
		/**
		 *	根据参数ID得到Key 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function  getContentFromID(id:int):Object
		{
			switch(id)
			{
				case LOOP:
					return {tips:"播放几次(无限循环填-1)", key:"loop", data:"", index:0};
				case DELAY:
					return {tips:"帧之间的间隔毫秒", key:"delay", data:"", index:1};
				case FRAMES:
					return {tips:"播放帧号的帧序列", key:"frames", data:"", index:2};
				case ID:
					return {tips:"ATK为攻击中的连击子动作,id为连击id", key:"id", data:"", index:3, input:"false"};
				case DX:
					return {tips:"dx为攻击时往攻击方向所位移的速度", key:"dx", data:"", index:4};
				case NEXTTYPE:
					return {tips:"nextType：下个连击的id(终止为-1) ", key:"nextType", data:"", index:5};
				case NEXTFRAME:
					return {tips:"nextFrame:到第几帧时，方可进入下个连击", key:"nextFrame", data:"", index:6};
				case SLIDES:
					return {tips:"slides:按幀來偏移人物位置 ", key:"slides", data:"", index:7};
				case OFFSETFRAME:
					return {tips:"offsetFrame:第几帧开始时，使用slide偏移位置控制移动", key:"offsetFrame", data:"", index:8};
				case WEAPONTYPE:
					return {tips:"hit攻击信息==> weaponType:武器类型 ", key:"weaponType", data:"", index:9};
				case MODENAME:
					return {tips:"modeName:碰撞类型（只能填写 单次碰撞或多次碰撞）", key:"modeName", data:"", index:10};
				case TYPENAME:
					return {tips:"typeName:攻击属性 halfH:碰撞检测的z景深", key:"typeName", data:"", index:11};
				case DIST:
					return {tips:"dist:击退距离", key:"dist", data:"", index:12};
				case HITWAITSELF:
					return {tips:"hitWaitSelf:击中敌人后自己的硬直帧数", key:"hitWaitSelf", data:"", index:13};
				case KEYS:
					return {tips:"keys:第几帧出现攻击判定矩形 ", key:"keys", data:"", index:14};
				case SAMES:
					return {tips:"sames:1为攻击后，敌人向攻击者位移 2为敌人向攻击方向位移", key:"sames", data:"", index:15};
				case SOURCES:
					return {tips:"sources:攻击矩形大小位置（相对于人物脚底中心)\n(用;分割，填写多个，与keys对应，\n若数量不足keys数量，则以最后一个矩形补足剩下keys", key:"sources", data:"", index:16};
				case JUMPHIGH:
					return {tips:"JUMP_ATK==> jumpHigh:跳跃高度", key:"jumpHigh", data:"", index:17};
				case ATKFRAMES:
					return {tips:"atkFrames:跳跃攻击帧", key:"atkFrames", data:"", index:18};
				case INVALIDFRAMES:
					return {tips:"invalidFrames:跳跃攻击不响应帧", key:"invalidFrames", data:"", index:19};
				case FADEFRAMES:
					return {tips:"BE_HIT==> fadeFrames:被击动作1序列帧", key:"fadeFrames", data:"", index:20};
				case BENTFRAMES:
					return {tips:"bentFrames:被击动作2序列帧", key:"bentFrames", data:"", index:21};
				default:
						return null;
			}
		}
		
		/**
		 *	根据ID得到内容 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function  getKeyFromID(id:int):String
		{
			switch(id)
			{
				case LOOP:
					return LOOP_STRING;
				case DELAY:
					return DELAY_STRING;
				case FRAMES:
					return FRAMES_STRING;
				case ID:
					return ID_STRING;
				case DX:
					return DX_STRING;
				case NEXTTYPE:
					return NEXTTYPE_STRING;
				case NEXTFRAME:
					return NEXTFRAME_STRING;
				case SLIDES:
					return SLIDES_STRING;
				case OFFSETFRAME:
					return OFFSETFRAME_STRING;
				case WEAPONTYPE:
					return WEAPONTYPE_STRING;
				case MODENAME:
					return MODENAME_STRING;
				case TYPENAME:
					return TYPENAME_STRING;
				case DIST:
					return DIST_STRING;
				case HITWAITSELF:
					return HITWAITSELF_STRING;
				case KEYS:
					return KEYS_STRING;
				case SAMES:
					return SAMES_STRING;
				case SOURCES:
					return SOURCES_STRING;
				case JUMPHIGH:
					return JUMPHIGH_STRING;
				case ATKFRAMES:
					return ATKFRAMES_STRING;
				case INVALIDFRAMES:
					return INVALIDFRAMES_STRING;
				case FADEFRAMES:
					return FADEFRAMES_STRING;
				case BENTFRAMES:
					return BENTFRAMES_STRING;
				default:
					return "";
			}
		}
	}
}
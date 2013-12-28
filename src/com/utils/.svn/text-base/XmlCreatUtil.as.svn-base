package com.utils
{
	import com.DataManager;
	import com.demo.core.animation.BitmapFrameData;
	import com.demo.core.creature.BaseActionType;
	import com.demo.define.Config;
	import com.view.AnimationVo;
	import com.view.RolePropertyVo;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;

	/**
	 * 生成xml的工具类
	 */
	public class XmlCreatUtil
	{
		private var _fileAnimtionOffset:File;
		private var _animationOffsetXml:XML;
		private var _dataXml:XML;
		private var _fileStream:FileStream;
		public function XmlCreatUtil(app:AnimationEdit)
		{
			_animationOffsetXml = DataManager.getInstance().getXmlByID("animationoffset");
			if(null == _animationOffsetXml || 0 == _animationOffsetXml.config.length())
			{
				_animationOffsetXml = new XML("<config></config>");
			}
			_fileAnimtionOffset = new File();
			_fileStream = new FileStream();
		}
		
		private function getRectType(type:int):String
		{
			switch(type)
			{
//				case Config.BOX_TYPE_BODY:
//					return "body";
				case Config.BOX_TYPE_HIT:
					return "hit";
				case Config.BOX_TYPE_FOCUS:
					return "focus";
			}
			return "hit";
		}
//		public function writeAnimationOffset(path:String) : void
//		{
//			_fileAnimtionOffset = _fileAnimtionOffset.resolvePath(Config.resPath + "AnimationOffset.xml");
//			//xml
//			_fileStream.open(_fileAnimtionOffset, FileMode.WRITE);
//			_fileStream.writeUTFBytes(_animationOffsetXml);
//			Alert.show("文件写入成功！\n保存路径：" + _fileAnimtionOffset.nativePath);
//			_fileStream.close();
//			return;
//		}
		private function creatAnimtionOffset(actionNode:XML, pos:Point, index:int, key:String):void
		{
			if(null == actionNode) return;

			var tempXml:XML = new XML("<offset></offset>");
			tempXml.@x = -Math.abs(pos.x);
			tempXml.@y = -Math.abs(pos.y);
			tempXml.@index = index;
//			tempXml.@id = key;
			actionNode.appendChild(tempXml);
		}
		private function getXmlByID(parter:XML, xml:XMLList, id:String, nodeStr:String):XML
		{
			for each(var tmpXml:* in xml)//帧
			{
				var str:String;
				switch(nodeStr)
				{
					case "<action></action>":
						str = tmpXml.@type;
						break;
					default :
						str = tmpXml.@id;
						break;
				}
				if(id == str)
					return tmpXml;
			}
			return appendChildByType(parter, id, nodeStr);
		}
		private function  appendChildByType(parter:XML, id:String, nodeStr:String):XML
		{
			var node:XML = new XML(nodeStr);
			switch(nodeStr)
			{
				case "<action></action>":	
					node.@type = id;
					break;
				default :
					node.@id = id;
					break;
			}
			parter.appendChild(node);
			return node;
		}
//		//AnimationOffset 文件生成
//		public function CreatXml():void
//		{
//			var dic:Dictionary = DataManager.getInstance().animationVOs;
//			if(null == dic)
//			{
//				Alert.show("你还没有绘制任何类型的方块");
//				return;
//			}
//			for each(var animationVo:AnimationVo in dic)//帧
//			{
//				if(null == animationVo)
//					continue;
////				var typeNode:XML = getXmlByID(_animationOffsetXml,
////												_animationOffsetXml.type, 
////												animationVo.id.toString(),
////												"<type></type>");
////				
////				var idNode:XML = getXmlByID(typeNode, 
////											typeNode.id,
////											animationVo.type.toString(),
////											"<id></id>");
//				
//				var actionNode:XML = getXmlByID(_animationOffsetXml, 
//												_animationOffsetXml.action,
//												animationVo.action.toString(),
//												"<action></action>");
//				
//				var index:int = 1;
//				for each(var bitmapFrame:BitmapFrameData in animationVo.animation.frames)//类型
//				{
//					var has:Boolean = false;
//					for each(var offset:XML in actionNode.offset)
//					{
//						if(offset.@index == index)
//						{
//							offset.@x = -Math.abs(bitmapFrame.offsetX);
//							offset.@y = -Math.abs(bitmapFrame.offsetY);
//							offset.@index = index;
//							has = true;
//							break;
//						}
//					}
//					if(has) 
//					{
//						index ++;
//						break;
//					}
//					
//					creatAnimtionOffset(actionNode,
//						new Point(bitmapFrame.offsetX, bitmapFrame.offsetY),index, "");
//					index ++;
//				}
//				
//				//生成
//				var _name:String = animationVo.id + "_" + animationVo.type + "_offset" ;
//				writeXml(Config.resPath, _name, _animationOffsetXml);
//			}
//		}
//		//生成actions
//		public function CreatActionsXml():void
//		{
//			var dic:Dictionary = new Dictionary();
//			var animVo:AnimationVo;
//			for each(animVo in DataManager.getInstance().animationVOs)
//			{
//				if(null == animVo.propertyVo)
//					continue;
//				
//				var key:String =  animVo.id + "_" + animVo.type;
//				var _arr:Array = dic[key];
//				if(null == _arr)
//				{
//					_arr = [];
//					dic[key] = _arr;
//				}
//				_arr.push(animVo);
//			}
//			animVo = null;
//			for each(var arr:Array in dic)
//			{
//				//1
//				var _xml:XML = new XML("<config></config>");
//				var node:XML = new XML("<id></id>");
//				node.@id = "1";//现在只有 1
//				_xml.appendChild(node);
//				
//				for(var i:int = 0; i<arr.length; ++i)
//				{
//					animVo = arr[i];
//					if(null == arr)
//						continue;
//					var acttionXml:XML = new XML("<action></action>");
//					acttionXml.@type = animVo.action;
//					node.appendChild(acttionXml);
//					if(BaseActionType.ATK == animVo.action)
//					{
//						for(var n:int = 0; n<animVo.linkPropertyVo.length; n++)
//						{
//							if(null == animVo.linkPropertyVo[n])
//								continue;
//							CreatParamsNode(acttionXml, animVo.linkPropertyVo[n].proDic);
//						}
//					}else
//					{
//						CreatParamsNode(acttionXml, animVo.propertyVo.proDic);
//					}
//				}
//				//生成
//				var _name:String = animVo.id + "_" + animVo.type;
//				writeXml(Config.resPath, _name, _xml);
//			}
//		}
		private function CreatParamsNode(parter:XML, proDic:Dictionary):XML
		{
			var paramsXml:XML = new XML("<params></params>");
			for(var animKey:* in proDic)
			{
				var str:String = "@" + animKey;
				var obj:Object = proDic[animKey];
				if(String(obj["data"]).length == 0)
					continue;
				paramsXml[str] = obj["data"];
			}
			parter.appendChild(paramsXml);
			return paramsXml;
		}
		
		
		//生成data
		public function CreatDataXml():void
		{
			var dic:Dictionary = DataManager.getInstance().basePtDic;
			var animDic:Dictionary = DataManager.getInstance().animationVOs;
			var animVo:AnimationVo;
			for each(var ppt:RolePropertyVo in dic)
			{
				var _xml:XML = new XML("<config></config>");
				
				var node:XML = new XML("<data></data>");
				var charID:int = ppt.proDic["id"]["data"];
//				node.@charID = charID;

				for(var key:* in ppt.proDic)
				{
					var str:String = "@" + key;
					var obj:Object = ppt.proDic[key];
					if(String(obj["data"]).length == 0)
						continue;
					
					node[str] = obj["data"];
				}
				_xml.appendChild(node);
				
				for each(animVo in animDic)
				{
					if(animVo.id == charID)
					{
						var acttionXml:XML = new XML("<action></action>");
						acttionXml.@type = animVo.action;
						node.appendChild(acttionXml);
						
						if(BaseActionType.ATK == animVo.action)
						{
							for(var n:int = 0; n<animVo.linkPropertyVo.length; n++)
							{
								if(null == animVo.linkPropertyVo[n])
									continue;
								CreatParamsNode(acttionXml, animVo.linkPropertyVo[n].proDic);
							}
						}else
						{
							CreatParamsNode(acttionXml, animVo.propertyVo.proDic);
						}
					}
				}
				
				//生成
				var _name:String = ppt.proDic["id"]["data"];
				writeXml(Config.resPath, _name, _xml);
			}
			
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//private
/////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 *	保存xml 
		 */		
		private var _f:File = new File();
		private function writeXml(path:String, name:String, xml:XML) : void
		{
			_f = _f.resolvePath(Config.resPath + name+".xml");
			//xml
			_fileStream.open(_f, FileMode.WRITE);
			_fileStream.writeUTFBytes(xml);
			//			Alert.show("文件写入成功！\n保存路径：" + _fileAnimtionOffset.nativePath);
			//			AnimationEdit.main.traceTxt.text += "文件写入成功！\n保存路径：" + _fileAnimtionOffset.nativePath;
			_fileStream.close();
			_f = new File();
			return;
		}
	}
}
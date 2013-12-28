package com.utils
{
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;

	public class AnimationXMLReader
	{
		private var _xml:XML;
		public function AnimationXMLReader(xml:XML)
		{
			_xml = xml;
		}
		
		public function get xmlString():String
		{
			return _xml.toXMLString();
		}
		
		public function getBaseDataProperty(propertyName:String):String
		{
			return _xml.data[0]["@"+propertyName].toString();
		}
		
		public function setBaseDataProperty(propertyName:String,value:String):void
		{
			_xml.data[0]["@"+propertyName] = value;
		}
		
		public function removeHitXML(actionID:String, paramID:String, effectID:String):void
		{
			// TODO Auto Generated method stub
//			var xmlStr:String = this.xmlString;
//			var index1:int = xmlStr.indexOf("type=\""+actionID+"\"",0);
//			var index2:int;
//			if(paramID!=null)
//			{
//				index2 = xmlStr.indexOf("id=\""+paramID+"\"",index1);
//				
//			}
//			else
//			{
//				if(effectID)
//			}
		}
		
		public function getEffectXML(actionType:String,paramsID:String,effectID:String):XML
		{
			if(paramsID == null)
			{
				paramsID = "0";
			}
			var aList:XMLList = _xml.action;
			var pList:XMLList;
			var effectList:XMLList;
			for each(var action:XML in aList)
			{
				if(action.@type == actionType)
				{
					pList = action.params;
					for each(var param:XML in pList)
					{
						if(param.@id == paramsID || param.@id.toString() == "")
						{
							effectList = param.effect;
							for each(var effect:XML in effectList)
							{
								if(effect.@id == effectID)
								{
									return effect;
								}
							}
						}
					}
				}
			}
			return null;
		}
		
		
		public function getParamXML(actionType:String,paramsID:String):XML
		{
			var aList:XMLList = _xml.action;
			var pList:XMLList;
			var tempStr:String;
			for each(var action:XML in aList)
			{
				if(action.@type == actionType)
				{
					pList = action.params;
					for each(var param:XML in pList)
					{
						if(param.@id == paramsID || param.@id.toString()=="")
						{
							return param;
						}
					}
				}
			}
			return null;
		}
		
		public function getParamContainsHit(actionType:String,paramsID:String):XML
		{
			var aList:XMLList = _xml.action;
			var pList:XMLList;
			var effectList:XMLList;
			for each(var action:XML in aList)
			{
				if(action.@type == actionType)
				{
					pList = action.params;
					for each(var param:XML in pList)
					{
						if(param.@id == paramsID  ||  paramsID == null)
						{
							if(param.hit.length()>0)
							{
								return param.hit[0];
							}
							return null;
						}
					}
				}
			}
			return null;;
		}
		
		public function getEffectContainsHit(actionType:String,paramsID:String,effectID:String):XML
		{
			var aList:XMLList = _xml.action;
			var pList:XMLList;
			var effectList:XMLList;
			for each(var action:XML in aList)
			{
				if(action.@type == actionType)
				{
					pList = action.params;
					for each(var param:XML in pList)
					{
						if(param.@id == paramsID ||  paramsID == null)
						{
							effectList = param.effect;
							for each(var effect:XML in effectList)
							{
								if(effect.@srcId == effectID)
								{
									
									if(effect.hit.length() >0)
									{
										return effect.hit[0];
									}
									else
									{
										return null;
									}
								}
							}
						}
					}
				}
			}
			
			return null;
		}
		
		public function updateAnimationOffset(actionID:String,frameIndex:int,pos:Point):void
		{
			var actions:XMLList = _xml.offset[0].action;
			for each(var action:XML in actions)
			{
				if(action.@type == actionID)
				{
					var offsets:XMLList = action.offset;
					var offset:XML = offsets[frameIndex];
					offset.@x = pos.x;
					offset.@y = pos.y;
				}
			}
		}
		
		public function getAnimationOffsetList(actionID:String,paramsID:String):XMLList
		{
			var actions:XMLList = _xml.offset[0].action;
			var paramActions:XMLList = _xml.action;
			
			for each(var action:XML in actions)
			{
				if(action.@type == actionID)
				{
					return action.offset;
				}
			}
			return null;
		}
		
		public function getEffectList(actionID:String,paramsID:String):XMLList
		{
			var actions:XMLList = _xml.action;
			for each(var action:XML in actions)
			{
				if(action.@type == actionID)
				{
					var pL:XMLList = action.params;
					if(pL.length()>1)
					{
						for each(var p:XML in pL)
						{
							if(p.@id == paramsID)
							{
								return p.effect;
							}
						}
					}
					else
					{
						return pL[0].effect;
					}
				}
			}
			return null;
		}
		
		
		
		public function getActionTreeData():XMLList
		{
			
			var xmlTree:XML = new XML("<treeData></treeData>");
			var actionList:XMLList =  _xml.action;
			var paramList:XMLList;
			var effectList:XMLList;
			var tempXML:XML;
			var paramXML:XML;
			var effectXML:XML;
			var param:XML;
			var effect:XML;
			var hasHitStr:String = "";
			var index:int = 0;
			for each(var action:XML in actionList)
			{
				paramList = action.params;
				hasHitStr = ""
				if(paramList.length() == 1 && paramList[0].hit.length()>0)
				{
					paramList[0].@id = "0"
					hasHitStr = "(hit)"
				}
				tempXML = new XML("<action label=\""+action.@type+hasHitStr+"\" type=\"action\" value=\""+action.@type+"\"></action>"); 
				if(paramList.length()>1)
				{
					for(var i:int=0;i<paramList.length();i++)
					{
						
						param = paramList[i];
						hasHitStr = ""
						if(param.hit!=null && param.hit.length()>0)
						{
							hasHitStr = "(hit)"
						}
						paramXML = new XML("<params label=\"part "+(i+1)+hasHitStr+"\" type=\"param\" value=\""+param.@id+"\"></params>");
						index = 0;
						for each(effect in param.effect)
						{
							effect.@id = index.toString();
							hasHitStr = ""
							if(effect.hit!=null && effect.hit.length()>0)
							{
								hasHitStr = "(hit)"
							}
							effectXML = new XML("<effect label=\"effect "+effect.@srcId+hasHitStr+"\" type=\"effect\" value=\""+effect.@id+"\"></effect>");
							paramXML.appendChild(effectXML);
							index ++;
						}
						tempXML.appendChild(paramXML);
					}
				}
				else if(paramList[0].effect.length()>0)
				{
					paramList[0].@id = "0";
					index = 0;
					for each(effect in paramList[0].effect)
					{
						effect.@id = index.toString();
						hasHitStr = ""
						if(effect.hit!=null && effect.hit.length()>0)
						{
							hasHitStr = "(hit)"
						}
						effectXML = new XML("<effect label=\"effect "+effect.@srcId+hasHitStr+"\" type=\"effect\" value=\""+effect.@id+"\"></effect>");
						tempXML.appendChild(effectXML);
						index ++;
					}
				}
				xmlTree.appendChild(tempXML);
			}
			return xmlTree.action;
		}
	}
}
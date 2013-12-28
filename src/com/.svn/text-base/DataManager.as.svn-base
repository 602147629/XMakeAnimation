package com
{
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.animation.BitmapFrameData;
	import com.demo.core.animation.WrapperedAnimation;
	import com.demo.core.creature.BaseActionType;
	import com.demo.define.Config;
	import com.view.BuildBrush;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;

	public class DataManager
	{
		private static var _instance:DataManager;
		
		private var _animationVOs:Dictionary = new Dictionary();//所有的编辑动画
		
		private var _selectBrush:BuildBrush;
		
		public var linkActId:uint = BaseActionType.LINK_1;
		
		private var _xmlDic:Dictionary = new Dictionary();
		
		private var _basePtDic:Dictionary = new Dictionary();
		private var _allRoleData:Dictionary = new Dictionary();
		/**
		 *	动作参数 
		 */		
		private var _actionParameterDic:Dictionary = new Dictionary();
		
		public function DataManager()
		{
			if (_instance != null)
			{
				throw new Error("use PlatyerManager.getInstance()");
			}
			_instance = this;
		}
		public function addXml(key:String, xml:XML):XML
		{
			if(_xmlDic[key])
				return _xmlDic[key];
			_xmlDic[key] = xml;
			return _xmlDic[key];
		}
		public function getXmlByID(key:String):XML
		{
			return _xmlDic[key];
		}
		
		public function getEffectBaseXML(srcId:String):XML
		{
			if(_xmlDic[srcId] == null)
			{
				var file:File = new File(Config.resPath+"effect/"+srcId+".xml");
				var fs:FileStream = new FileStream();
				fs.open(file,FileMode.READ);
				var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
				fs.close();
				_xmlDic[srcId] = xml;
			}
			return _xmlDic[srcId];
		}
		
		public function getHitXMLModel():XML
		{
			if(_xmlDic["xmlModel"] == null)
			{
				loadXMLModel()
			}
			var xmlModel:XML = _xmlDic["xmlModel"];
			return xmlModel.hit[0];
		}
		
		public function getParamsXMLModel():XML
		{
			if(_xmlDic["xmlModel"] == null)
			{
				loadXMLModel()
			}
			var xmlModel:XML = _xmlDic["xmlModel"];
			return xmlModel.params[0];
		}
		
		public function getEffectXMLModel():XML
		{
			if(_xmlDic["xmlModel"] == null)
			{
				loadXMLModel()
			}
			var xmlModel:XML = _xmlDic["xmlModel"];
			return xmlModel.effect[0];
		}
		
		public function getActionXMLModel():XML
		{
			if(_xmlDic["xmlModel"] == null)
			{
				loadXMLModel()
			}
			var xmlModel:XML = _xmlDic["xmlModel"];
			return xmlModel.action[0];
		}
		
		private function loadXMLModel():void
		{
			var file:File = new File(Config.resPath+"/xmlModel.xml");
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			fs.close();
			_xmlDic["xmlModel"] = xml;
		}
		
		public function clear():void
		{
		}
		
		public static function getInstance():DataManager
		{
			if(_instance == null) _instance = new DataManager();
			return _instance;
		}

	}
}
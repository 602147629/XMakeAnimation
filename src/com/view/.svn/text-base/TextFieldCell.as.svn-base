package com.view
{
	import com.DataManager;
	
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	public class TextFieldCell extends Canvas
	{
		private var text:Label = new Label();
		private var _inputText:TextInput = new TextInput();
		private var _property:PropertyVo;
		public function TextFieldCell()
		{
			super();
			this.addElement(text);
			this.addElement(_inputText);
			_inputText.x = 100;
			_inputText.width = 200;
			styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("fontSize",12);   
			styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("backgroundColor","#33CC99");
		}
		
		public function setContext(key:String, tips:String, input:String, property:PropertyVo):void
		{
			_property = property;
			text.text = key;
			
			_inputText.editable = !(input == "false");
			text.toolTip = tips;
			if(property.proDic["id"] && property.proDic["id"]["data"] != null && key == "id")
				_inputText.text = property.proDic["id"]["data"];
			if(property.proDic[key])
			{
				var data:String = property.proDic[key]["data"];
				if(data && data.length>0)
					_inputText.text = property.proDic[key]["data"];
			}
			
			if(_inputText.editable)
			{
				if(!_inputText.hasEventListener(Event.CHANGE))
					_inputText.addEventListener(Event.CHANGE, textChange);
			}
		}
		
		protected function textChange(event:TextOperationEvent):void
		{
			_property.updatePropertyVo(text.text, _inputText.text);
			trace("存入:key "+ text.text + "data "+_inputText.text);
		}
		public function get inputText():String
		{
			return _inputText.text;
		}
		public function set inputText(str:String):void
		{
			_inputText.text = str;
			_property.updatePropertyVo(text.text, _inputText.text);
		}
		public function clear():void
		{
			text.text = "";
			_inputText.text = "";
			_inputText.removeEventListener(Event.CHANGE, textChange);
		}
	}
}
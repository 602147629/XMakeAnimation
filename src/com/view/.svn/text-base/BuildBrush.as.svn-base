package com.view
{
	import com.DataEvent;
	import com.DispatcherManager;
	import com.EditEvent;
	import com.demo.define.Config;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Endian;
	
	public class BuildBrush extends Sprite
	{
		private var _hitSprite:Sprite = new Sprite();
		private var _type:int = 0;
		private var _color:uint = 0xffff00;
		private var _pos:Point;
		private var _rect:Rectangle;
		private var _selected:Boolean = false;
		public function BuildBrush(rect:Rectangle,pos:Point)
		{
			_rect = rect;
			_pos = pos;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, MouseEventClick);
			this.selected = true;
			updatePos();
		}
		
		private function updatePos():void
		{
			this.x = _pos.x + _rect.x;
			this.y = _pos.y + _rect.y;
		}
		
		protected function MouseEventClick(event:MouseEvent):void
		{
			if(this.parent!=null)
			{
				this.parent.addChild(this);
			}
			this.dispatchEvent(new EditEvent(EditEvent.CLICK_ONE_BRUSH,true));
		}
		
		public function getDataStr():String
		{
			return _rect.x + "," + _rect.y + "," + _rect.width + "," + _rect.height;
		}
		
		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}
		
		public function disPose():void
		{
			if(this.parent && this.parent.contains(this))
			{
				this.parent.removeChild(this);
			}
		}

		public function get rect():Rectangle
		{
			return _rect;
		}
		
		public function set rect(r:Rectangle):void
		{
			_rect = r;
			selected = true;
			updatePos();
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected == false)
			{
				_color = 0x54FF9F;
			}else
			{
				_color = 0xFF0000;
			}
			this.graphics.clear();
			this.graphics.lineStyle(1, _color);
			this.graphics.beginFill(_color, 0.2);
			this.graphics.drawRect(0, 0, rect.width, rect.height);
			this.graphics.endFill();
		}
	}
}
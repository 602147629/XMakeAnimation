package com.view
{
	import com.DataEvent;
	import com.DataManager;
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.animation.WrapperedAnimation;
	import com.demo.define.Config;
	import com.demo.net.loader.ImageModel;
	import com.utils.HashMap;
	import com.windows.AnimationEditTab;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;

	public class AnimationPanel extends UIComponent
	{
		public static const EDIT_WIDTH:uint=660;
		public static const EDIT_HEIGHT:uint=460;

		private var _rect:Rectangle=new Rectangle();
		private var _currColor:uint=0;
		private var _brushGraphics:Shape=new Shape();
		private var _loader:URLLoader=new URLLoader();
		private var _root:AnimationEditTab;

		private var _uiContainer:UIComponent=new UIComponent();
		private var _pos:Shape=new Shape();
		private var _posPoint:Point;
		private var _dragContainer:UIComponent=new UIComponent();

		private var _floorEffectContainer:UIComponent=new UIComponent();
		private var _sceneEffectContainer:UIComponent=new UIComponent();
		
		private var _brushContainer:UIComponent = new UIComponent();


		private var _isShowPropertyWnd:Boolean;
		//保存当前选择的框
		private var _currentBuildBrush:BuildBrush;
		
		
		private var _animation:BitmapAnimation;
		
		private var _curIndex:int;
		
		private var curActionPosXMLList:XMLList;
		
		private var _effectAnimMap:HashMap = new HashMap();
		
		private var _effectXMLMap:HashMap = new HashMap();
		
		private var _curHitXML:XML;
		
		private var _paramXML:XML;
		private var _roleSliderArr:Array = [];
		
		private var _curEffectID:String;
		
		private var _brushShowFrames:Array = [];
		private var _brushRects:Array = [];
		
		private const DEFAULT_BRUSH_RECT:Rectangle = new Rectangle(-10,-100,300,100);
		private const DEFAULT_BRUSH_RECT_STR:String = "-10,-100,300,100";

		public function AnimationPanel(app:AnimationEditTab)
		{
			_root=app;
			super();
			_dragContainer.mouseChildren=false;
			_uiContainer.mouseEnabled=false;
			//参考点
			_pos.graphics.beginFill(0x00ff00);
			_pos.graphics.drawCircle(0, 0, 4);
			_pos.graphics.endFill();
			this.addChild(_pos);
			_pos.x=_root.animation.width / 5;
			_pos.y=_root.animation.height - 12;
			
			_posPoint = new Point(_pos.x,_pos.y);
			
			_uiContainer.x = _posPoint.x;
			_uiContainer.y = _posPoint.y;

			this.addChild(_floorEffectContainer);
			this.addChild(_uiContainer);
			this.addChild(_sceneEffectContainer);
			
			this.addChild(_brushContainer);

			this.graphics.lineStyle(2, 0xccffdd);
			this.graphics.drawRect(0, 0, EDIT_WIDTH, EDIT_HEIGHT);
			this.graphics.beginFill(0, 0.1);
			this.graphics.drawRect(0, 0, EDIT_WIDTH, EDIT_HEIGHT);
			this.graphics.endFill();
			
			

			this.addEventListener(Event.ADDED_TO_STAGE,onAddTostage);
//			updateType(0);
		}
		
		public function dispose():void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouse_Down);
			clear();
			clearHit();
			clearEffect();
		}
		
		protected function onAddTostage(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddTostage);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,mouse_Down);
		}
		
		public function get curHitXML():XML
		{
			return _curHitXML;
		}

		public function setCurHitXML(value:XML,effectID:String = null):void
		{
			_curHitXML = value;
			clearHit();
			if(_curHitXML!=null)
			{
				_brushShowFrames = String(_curHitXML.@keys).split(",");
				_brushRects = String(_curHitXML.@sources).split(";");
				for(var i:int=0;i<_brushShowFrames.length;i++)
				{
					_brushShowFrames[i] = int(_brushShowFrames[i]);
					if(i>= _brushRects.length)
					{
						_brushRects.push(_brushRects[_brushRects.length-1]);
					}
				}
				_curHitXML.@sources = _brushRects.join(";");
				clearBrush();
				checkShowBrush();
			}
			_curEffectID = effectID;
			if(_curEffectID!=null)
			{
				var exml:XML;
				exml = _effectXMLMap.get(_curEffectID) as XML;
				gotoStop(1);
			}
		}
		
		private function clearHit():void
		{
			// TODO Auto Generated method stub
			_brushShowFrames = [];
			_brushRects = [];
			clearBrush();
		}
		
		public function updateHitParams(hitBack:String, hitHeight:String, attackDepth:String, pauseSelf:String,manyTime:Boolean):void
		{
			// TODO Auto Generated method stub
			if(_curHitXML!=null)
			{
				_curHitXML.@dist = hitBack;
				_curHitXML.@high = hitHeight;
				_curHitXML.@halfH = attackDepth;
				_curHitXML.@hitWait = pauseSelf;
				_curHitXML.@modeName = manyTime ? "多次碰撞" : "单次碰撞";
			}
		}
		
		private function checkShowBrush():void
		{
			// TODO Auto Generated method stub
			var index:int = _brushShowFrames.indexOf(_curIndex);
			if(index != -1)
			{
				showBrush(index);
			}
			else
			{
				clearBrush();
			}
		}
		
		private function showBrush(index:int):void
		{
			// TODO Auto Generated method stub
			index = index>=_brushRects.length ? _brushRects.length-1 : index;
			var rectStr:String = _brushRects[index];
			var rect:Rectangle = new Rectangle(int(rectStr.split(",")[0]),int(rectStr.split(",")[1]),int(rectStr.split(",")[2]),int(rectStr.split(",")[3]));
			if(_currentBuildBrush==null)
			{
				_currentBuildBrush = new BuildBrush(rect,_posPoint);
				_brushContainer.addChild(_currentBuildBrush);
			}
			_currentBuildBrush.rect = rect;
			_root.updateJudgeBrush(_currentBuildBrush.getDataStr());
		}
		
		private function clearBrush():void
		{
			// TODO Auto Generated method stub
			if(_brushContainer)
			{
				while(_brushContainer.numChildren)
				{
					_brushContainer.removeChildAt(0);
					_currentBuildBrush = null;
				}
			}
		}
		
		public function copyPreJudge():void
		{
			// TODO Auto Generated method stub
			var index:int ;
			var copyData:String;
			if(_currentBuildBrush == null)
			{
				if(_brushShowFrames.length==0 || (_brushShowFrames.length>0 && _curIndex<=_brushShowFrames[0]))
				{
					Alert.show("没有可以复制的判定");
					return;
				}
				_brushShowFrames.push(_curIndex);
				_brushShowFrames.sort(Array.NUMERIC);
				index= _brushShowFrames.indexOf(_curIndex);
				copyData = _brushRects[index-1];
				if(index == _brushRects.length)
				{
					_brushRects.push(copyData);
				}
				else
				{
					for(var i:int = _brushRects.length;i>0 ;i--)
					{
						_brushRects[i] = _brushRects[i-1];
						if(i-1 == index)
						{
							_brushRects[i-1] = copyData;
							break;
						}
					}
				}
				
				_currentBuildBrush = new BuildBrush(getRectByDataStr(copyData),_posPoint);
				_brushContainer.addChild(_currentBuildBrush);
				_curHitXML.@keys = _brushShowFrames.join(",");
				_curHitXML.@sources = _brushRects.join(";");
			}
			else
			{
				if(_curIndex<=_brushShowFrames[0])
				{
					Alert.show("没有可以复制的判定");
				}
				else
				{
					index= _brushShowFrames.indexOf(_curIndex);
					copyData = _brushRects[index-1];
					_brushRects[index] = _brushRects[index-1];
					_currentBuildBrush.rect = getRectByDataStr(copyData)
					_curHitXML.@keys = _brushShowFrames.join(",");
					_curHitXML.@sources = _brushRects.join(";");
				}
			}
		}
		
		public function toBeforeJudge():void
		{
			// TODO Auto Generated method stub
			if(_brushShowFrames.length<=1 || (_brushShowFrames.length>1 && _curIndex<=_brushShowFrames[0]))
			{
				Alert.show("没有可选的判定");
				return;
			}
			else
			{
				var index:int =0;
				while(_curIndex>=_brushShowFrames[index] && index<_brushShowFrames.length)
				{
					index ++;
				}
				gotoStop(_brushShowFrames[index]);
			}
		}
		
		public function toNextJudge():void
		{
			// TODO Auto Generated method stub
			if(_brushShowFrames.length<=1 || (_brushShowFrames.length>1 && _curIndex>=_brushShowFrames[_brushShowFrames.length-1]))
			{
				Alert.show("没有可选的判定");
				return;
			}
			else
			{
				var index:int = _brushShowFrames.length-1;
				while(_curIndex<=_brushShowFrames[index] && index>=0)
				{
					index --;
				}
				gotoStop(_brushShowFrames[index+1]);
			}
		}
		
		private function getRectByDataStr(dataStr:String):flash.geom.Rectangle
		{
			// TODO Auto Generated method stub
			var strArr:Array = dataStr.split(",");
			return new Rectangle(int(strArr[0]),int(strArr[1]),int(strArr[2]),int(strArr[3]));
		}
		
		public function addJudgeBrush():void
		{
			// TODO Auto Generated method stub
			if(_curHitXML == null)
			{
				_root.createHitXML();
				return;
			}
			if(_currentBuildBrush == null)
			{
				_brushShowFrames.push(_curIndex);
				_brushShowFrames.sort(Array.NUMERIC);
				var index:int = _brushShowFrames.indexOf(_curIndex);
				if(index == _brushRects.length)
				{
					_brushRects.push(DEFAULT_BRUSH_RECT_STR);
				}
				else
				{
					for(var i:int = _brushRects.length;i>0 ;i--)
					{
						_brushRects[i] = _brushRects[i-1];
						if(i-1 == index)
						{
							_brushRects[i-1] = DEFAULT_BRUSH_RECT_STR;
							break;
						}
					}
				}
				_currentBuildBrush = new BuildBrush(DEFAULT_BRUSH_RECT,_posPoint);
				_brushContainer.addChild(_currentBuildBrush);
				_curHitXML.@keys = _brushShowFrames.join(",");
				_curHitXML.@sources = _brushRects.join(";");
			}
		}
		
		public function removeJudgeBrush():void
		{
			// TODO Auto Generated method stub
			if(_currentBuildBrush != null)
			{
				var index:int = _brushShowFrames.indexOf(_curIndex);
				_brushShowFrames.splice(index,1);
				_brushRects.splice(index,1);
				_curHitXML.@keys = _brushShowFrames.join(",");
				_curHitXML.@sources = _brushRects.join(";");
				clearBrush();
				if(_brushRects.length == 0)
				{
					_root.removeHitXML();
					_curHitXML = null;
					clearHit();
				}
			}
		}
		
		public function updateJudgeBrush(rx:int, ry:int, rw:int, rh:int):void
		{
			// TODO Auto Generated method stub
			if(_currentBuildBrush!=null)
			{
				var rect:Rectangle = new Rectangle(rx,ry,rw,rh);
				_currentBuildBrush.rect = rect;
				var index:int = _brushShowFrames.indexOf(_curIndex);
				_brushRects[index] = _currentBuildBrush.getDataStr();
				_curHitXML.@keys = _brushShowFrames.join(",");
				_curHitXML.@sources = _brushRects.join(";");
			}
		}
		
		private function saveBrushData():void
		{
			// TODO Auto Generated method stub
			var index:int = _brushShowFrames.indexOf(_curIndex);
			_brushRects[index] = _currentBuildBrush.getDataStr();
			_curHitXML.@keys = _brushShowFrames.join(",");
			_curHitXML.@sources = _brushRects.join(";");
			_root.updateJudgeBrush(_currentBuildBrush.getDataStr());
		}	


		public function updateAllFrames(frames:Array):void
		{
			if(_animation)
			{
				_animation.resetFramesArr(frames);
				gotoStop(1);
			}
		}
		
		public function updateDelay(delay:int):void
		{
			if(_animation)
			{
				_animation.renderSpeed = 1000/delay;
			}
		}
		
		public function get animation():BitmapAnimation
		{
			return _animation;
		}

		public function update(resType:String, animationID:String, actionType:String,frames:Array,posList:XMLList,paramXML:XML):void
		{
			clear();
			_paramXML = paramXML;
			_roleSliderArr = String(_paramXML.@slides).split(",");
			curActionPosXMLList = posList;
			selectLoad(resType,  int(animationID), int(actionType),frames,paramXML.@delay);
		}
		
		public function addEffect(effectList:XMLList):void
		{
			clearEffect();
			if(effectList!=null && effectList.length()>0)
			{
				for each(var exml:XML in effectList)
				{
					addEffectAnimation(exml);
				}
				checkEveryEffect();
			}
		}
		
		public function getAllEffect():HashMap
		{
			return _effectAnimMap;
		}
		
		private function clearEffect():void
		{
			// TODO Auto Generated method stub
			var animArr:Array = _effectAnimMap.values;
			for each(var anim:BitmapAnimation in animArr)
			{
				anim.dispose(true);
			}
			_effectAnimMap.clear();
			_effectXMLMap.clear();
		}
		
		private function addEffectAnimation(effectXML:XML):void
		{
			ImageModel.instance.getAnimRes("effect", int(effectXML.@srcId), 0, function(frames:WrapperedAnimation):void
			{
				var effectAnim:BitmapAnimation;
				effectAnim = new BitmapAnimation();
				effectAnim.renderSpeed = int(effectXML.@delay);
				effectAnim.setFrames(frames.frames);
				effectAnim.name = effectXML.@srcId;
				if(effectXML.@layer == "scene")
				{
					_sceneEffectContainer.addChild(effectAnim);
				}
				else
				{
					_floorEffectContainer.addChild(effectAnim);
				}
				effectAnim.resetFramesArr(effectXML.@frames.toString().split(","));
				_effectAnimMap.add(effectXML,effectAnim);
				_effectXMLMap.add(String(effectXML.@id),effectXML);
			});
			checkShowEffect(effectXML);
		}
		
		private function checkEveryEffect():void
		{
			var keys:Array = _effectAnimMap.keys;
			for each(var effectXML:XML in keys)
			{
				checkShowEffect(effectXML)
			}
		}
		
		private function checkShowEffect(effectXML:XML):void
		{
			var anim:BitmapAnimation=_effectAnimMap.get(effectXML) as BitmapAnimation;
			if(anim == null)
			{
				return;
			}
			if(int(effectXML.@frame)> _curIndex || _curIndex >=effectXML.@frames.toString().split(",").length +int(effectXML.@frame) )
			{
				anim.visible = false;
			}
			else
			{
				anim.visible = true;
				anim.gotoAndStop(_curIndex - int(effectXML.@frame)+1);
			}
		}

		private function clear():void
		{
			while (_uiContainer.numChildren)
			{
				_uiContainer.removeChildAt(0);
			}
			_animation = null;
		}

		/**
		 *	下载
		 * @param packId	角色ID
		 * @param imageId	资源名字（action type）
		 * @param xml
		 *
		 */
		protected function selectLoad(resType:String, animationID:int, actionType:int,allFrames:Array,frameTime:int):void
		{
			ImageModel.instance.getAnimRes(resType, animationID, actionType, function(frames:WrapperedAnimation):void
			{
				_animation = new BitmapAnimation();
				_animation.renderSpeed = frameTime;
				_animation.setFrames(frames.frames);
				_animation.name = animationID.toString();
				_animation.resetFramesArr(allFrames);
				_uiContainer.addChild(_animation);
				gotoStop(1);
			});
			
		}



		public function setOffset():void
		{

			if (_animation&&_animation.currentFramData && _animation.playFrames.length >=_curIndex)
			{
				var offset:XML =  curActionPosXMLList[_animation.playFrames[_curIndex-1]];
				var _offsetX:int=offset.@x;//_animation.currentFramData.offsetX;
				var _offsetY:int=offset.@y;//_animation.currentFramData.offsetY;
				var ox:int = 0;
				if(_curIndex>=int(_paramXML.@offsetFrame) && _curIndex - int(_paramXML.@offsetFrame)<_roleSliderArr.length)
				{
					ox = int(_roleSliderArr[ _curIndex - int(_paramXML.@offsetFrame)]);
				}
				else
				{
					ox = _paramXML.@dx;
				}
				_animation.x = _offsetX + ox;
				_animation.y = _offsetY;
//				_uiContainer.x=_offsetX + _pos.x;
//				_uiContainer.y=_offsetY + _pos.y;

				trace("setoffet" + _animation.x + "-" + _animation.y);
			}
			
			var effects:Array = _effectAnimMap.keys;
			var effectAnim:BitmapAnimation;
			var effectBaseXML:XML;
			var offsetL:XMLList;
			var effectOffset:XML;
			for each(var effectXML:XML in effects)
			{
				effectAnim = _effectAnimMap.get(effectXML) as BitmapAnimation;
				if(effectAnim.visible)
				{
					effectBaseXML = DataManager.getInstance().getEffectBaseXML(effectXML.@srcId);
					offsetL = effectBaseXML.offset[0].action[0].offset;
					effectOffset = offsetL[effectAnim.playFrames[_curIndex-int(effectXML.@frame)]];
					effectAnim.x = int(effectOffset.@x) + _pos.x + int(effectXML.@ox);
					effectAnim.y = int(effectOffset.@y) + _pos.y + int(effectXML.@oy);
				}
			}
		}

		private var _boxType:int=0;

		public function updateType(type:int):void
		{
			_boxType=type;
			if (_boxType == Config.BOX_TYPE_FOCUS)
			{
				_uiContainer.mouseChildren=false;
				copyToDragContainer();
			}
			else
			{
				_uiContainer.mouseChildren=true;
				if (this.contains(_dragContainer))
					this.removeChild(_dragContainer);
			}
		}

		public function updateDragContainerPos(type:int, pos:Point):void
		{
			_dragContainer.x=(_pos.x + pos.x);
			_dragContainer.y=(_pos.y + pos.y);
			stopDraw();
		}

		public function updateRect(rect:Rectangle):void
		{
			if (null == _currentBuildBrush)
				return;

			_currentBuildBrush.rect = rect;
			//更新基础属性
		}

		public function get uiContainer():UIComponent
		{
			return _uiContainer;
		}

		//draw
		protected function mouse_Up(event:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouse_Up);
			var selfRect:Rectangle = this.getRect(this.stage);
			if (_boxType == Config.BOX_TYPE_HIT && _currentBuildBrush!=null)
			{
				if (!_rect)
				{
					trace("点击的不是绘制层");
					clearBrushGraphics();
					return;
				}
				var x:int=event.stageX;
				var y:int=event.stageY;
				_rect.width=x-selfRect.x - _rect.x;
				_rect.height=y - selfRect.y - _rect.y;

				if (_rect.width <= 0 || _rect.height <= 0)
				{
					_rect.x=_rect.y=0;
					clearBrushGraphics();
					return;
				}
				//转换坐标系
				_rect.x=_rect.x - _posPoint.x;
				_rect.y=_rect.y - _posPoint.y;
				
				_currentBuildBrush.rect = _rect.clone();
				_currentBuildBrush.selected = true;
				_brushContainer.addChild(_currentBuildBrush);
				_rect=null;
				clearBrushGraphics();
				saveBrushData();
			}
			else if(_boxType == Config.BOX_TYPE_FOCUS)
			{
				stopDraw();
				if (null == _animation)
					return;
			}
		}
		
		private function clearBrushGraphics():void
		{
			
			_brushGraphics.graphics.clear();
			if (this.contains(_brushGraphics))
				this.removeChild(_brushGraphics);
		}

		private function stopDraw():void
		{
			_dragContainer.stopDrag();
			if (null == _animation)
				return;
			_animation.alpha=1;

			//计算重心点
			var point:Point=new Point(_dragContainer.x - _pos.x, _dragContainer.y - _pos.y);
			var offset:XML =  curActionPosXMLList[_animation.playFrames[_curIndex-1]];
			offset.@x = point.x;
			offset.@y = point.y;
			
			_animation.x = point.x;
			_animation.y = point.y;

//			_uiContainer.x=_dragContainer.x;
//			_uiContainer.y=_dragContainer.y;

			trace("stopDraw" + _animation.x + "-" + _animation.y);
		}

		protected function mouse_Down(event:MouseEvent):void
		{
			var selfRect:Rectangle = this.getRect(this.stage);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouse_Up);
			if (null == _animation || !selfRect.contains(event.stageX,event.stageY))
				return;

			if (_boxType == Config.BOX_TYPE_HIT && _currentBuildBrush!=null)
			{
				if (null == _rect)
					_rect=new Rectangle();
				_rect.x=event.stageX - selfRect.x;
				_rect.y=event.stageY - selfRect.y;
				//添加移动事件
				_currColor=0xff0000; //BuildBrush.updateColorByType(_boxType);
				this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				if (!this.contains(_brushGraphics))
					this.addChild(_brushGraphics);
//				}

			}
			else if(_boxType == Config.BOX_TYPE_FOCUS)
			{
				_dragContainer.startDrag();
				_animation.alpha=0.5;
			}
			else
			{
				this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouse_Up);
			}
		}

		protected function mouseMove(e:MouseEvent):void
		{
			var selfRect:Rectangle = this.getRect(this.stage);
			var _w:int=e.stageX - selfRect.x - _rect.x;
			var _h:int=e.stageY - selfRect.y - _rect.y;
			_brushGraphics.graphics.clear();
			_brushGraphics.graphics.lineStyle(1, _currColor);
			_brushGraphics.graphics.drawRect(_rect.x-this.x, _rect.y - this.y, _w, _h);
		}

		private var dragBitmap:Bitmap;

		private function copyToDragContainer():void
		{
			while (_dragContainer.numChildren)
			{
				_dragContainer.removeChildAt(0);
			}
			if (null == _animation)
				return;
			dragBitmap=new Bitmap(_animation.currentFramData.bitmapData);
			_dragContainer.addChild(dragBitmap);
			_dragContainer.filters=[new GlowFilter(0xffff00)];
			if (!this.contains(_dragContainer))
				this.addChild(_dragContainer);
			//转换坐标系
			var pos:Point=_uiContainer.localToGlobal(new Point(_animation.x, _animation.y));
			pos=this.globalToLocal(new Point(pos.x, pos.y));
			_dragContainer.x=pos.x;
			_dragContainer.y=pos.y;
			//更新界面xy
//			_root.updateXY(new Point(_offsetX, _offsetY), _animationVO.action);
			trace("copyToDragContainer" + _dragContainer.x + "-" + _dragContainer.y);
			trace("copyTo  ui" + _uiContainer.x + "-" + _uiContainer.y);
		}

		public function gotoStop(index:int):void
		{
			if(_animation == null || curActionPosXMLList==null || _animation.currentFramData ==null)
			{
				return;
			}
			if(_curEffectID!=null)
			{
				index  =index + int(XML(_effectXMLMap.get(_curEffectID)).@frame) -1;
			}
			if(_animation.totalFrames>=index)
			{
				_animation.gotoAndStop(index);
			}
			_curIndex = index;
			checkEveryEffect();
			setOffset();
			//copy
			if (_boxType == Config.BOX_TYPE_FOCUS)
			{
				copyToDragContainer();
				clearBrush();
			}
			else if(_boxType == Config.BOX_TYPE_HIT)
			{
				checkShowBrush();
				if (this.contains(_dragContainer))
					this.removeChild(_dragContainer);
			}
			else
			{
				if (this.contains(_dragContainer))
					this.removeChild(_dragContainer);
			}
		}
		
		public function updateRoleSlides():void
		{
			// TODO Auto Generated method stub
			_roleSliderArr = String(_paramXML.@slides).split(",");
			gotoStop(_curIndex);
		}
	}
}

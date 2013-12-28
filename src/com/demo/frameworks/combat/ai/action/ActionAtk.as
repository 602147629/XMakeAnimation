package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.BaseActionType;
	import com.demo.core.creature.EnityState;
	import com.demo.core.creature.EnityView;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * 动作攻击
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class ActionAtk extends BaseAction {
		protected var _atkHits : Dictionary;
		protected var _atkRangeMaxX : int;
		protected var _atkRangeMaxY : int;
		
		protected var _isFly : Boolean;

		override protected function onChange(value : BitmapAnimation) : void {
			checkGhost(value);
			checkBrave(value);
			checkEffect(value);
			checkHit(value);
		}

		protected function checkBrave(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : EnityView = EnityView(value.parent.parent.parent);
			if (current == _braveStart) {
				value.filters = [EnityState.BRAVE_FILTER];
				view.state.isBrave = true;
			} else if (current == _braveEnd) {
				value.filters = [];
				view.state.isBrave = false;
			}
		}

		protected function checkHit(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var rect:Rectangle = _atkHits[current];
			if(rect)
			{
				var view : EnityView = EnityView(value.parent.parent.parent);
//				showHit(view, rect, value);
				 rect.y += (view.y + value.currentFramData.offsetY);
				 if(value.flipH)//左 true
				 {
					 rect.x = (view.x - value.currentFramData.offsetX)- rect.x - rect.width;
				 }else
				 {
					 rect.x += (view.x + value.currentFramData.offsetX);
				 }
				 view.mapView.checkOnAttack(rect, view, _isFly);
			}
		}
		private function showHit(view:EnityView, rect:Rectangle, value : BitmapAnimation):void
		{
			if(view)
			{
				view.graphics.clear();
				view.graphics.lineStyle(1, 0xff0000);
				if(value.flipH)//左 true
				{
					var _x:int = value.currentFramData.offsetX/2;
					view.graphics.drawRect(rect.x-_x, 
						rect.y+value.currentFramData.offsetY, rect.width, rect.height);
				}else
				{
					view.graphics.drawRect(rect.x+value.currentFramData.offsetX,
						rect.y+value.currentFramData.offsetY, rect.width, rect.height);
				}
			}
		}
		protected function onComplete(value : BitmapAnimation) : void {
			if (_debug) {
				return;
			}
			end(EnityView(value.parent.parent.parent));
		}

		public function ActionAtk() {
			super();
			_loop = 1;
			_type = BaseActionType.ATK;
			_atkHits = new Dictionary();
			_change = onChange;
			_complete = onComplete;
		}

		override public function reset(view : EnityView) : void {
			super.reset(view);
			view.stopMove();
			view.state.hits.splice(0);
		}
		public function addAtkHit(n_AtkHit:Array, id:int):void
		{
		}
		// public function addAtkHit(value : N_AtkHit) : void {
		// _atkHits[value.weaponType * 10] = value;
		// _atkRangeMaxX = Math.max(_atkRangeMaxX, value.rangeX);
		// _atkRangeMaxY = Math.max(_atkRangeMaxY, value.rangeY);
		// }
		// public function getHitBy(key : int, weaponType : int = 0) : N_HitData {
		// var atkHit : N_AtkHit = _atkHits[weaponType * 10];
		// if (atkHit == null) {
		// return null;
		// } else {
		// return atkHit.getBy(key);
		// }
		// }
		public function atAtkRange(dx : int, dy : int) : Boolean {
			if (dx > _atkRangeMaxX) {
				return false;
			}
			if (dy > _atkRangeMaxY) {
				return false;
			}
			return true;
		}

		override public function end(view : EnityView) : void {
			view.restore();
			// if (view.ai != null) {
			// view.ai.onAttackEnd();
			// }
		}

		public function set atkRangeMaxX(atkRangeMaxX : int) : void {
			_atkRangeMaxX = atkRangeMaxX;
		}

		public function set atkRangeMaxY(atkRangeMaxY : int) : void {
			_atkRangeMaxY = atkRangeMaxY;
		}

		public function get isFly():Boolean
		{
			return _isFly;
		}

		public function set isFly(value:Boolean):void
		{
			_isFly = value;
		}

	}
}

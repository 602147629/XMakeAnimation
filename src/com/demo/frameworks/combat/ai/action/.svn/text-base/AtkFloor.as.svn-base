package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.util.PhysicUtil;

	/**
	 * 砸地动作
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class AtkFloor extends ActionAtk {
		protected var _dist : int;
		protected var _high : int;
		protected var _total : int;
		protected var _distX : Array;
		protected var _distZ : Array;
		protected var _half : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : EnityView = EnityView(value.parent.parent);
			if (current < _total) {
				view.high = _distZ[current];
				view.mapView.scrollControl.offsetTo(0, view.shadow.y);
				var dx : int = _distX[current];
				view.offsetTo((value.flipH ? -dx : dx), 0);
			} else if (current == _total) {
				view.mapView.scrollControl.startShock(8);
			}
			checkGhost(value);
			checkBrave(value);
			checkEffect(value);
			checkHit(value);
		}

		public function AtkFloor() {
			super();
		}

		override public function atAtkRange(dx : int, dy : int) : Boolean {
			if (dx < _dist) {
				return false;
			}
			if (dx > _dist + _atkRangeMaxX) {
				return false;
			}
			if (dy > _atkRangeMaxY) {
				return false;
			}
			return true;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_dist = value.params.dist;
			_high = value.params.high;
			_total = value.params.total;
			_distX = new Array();
			PhysicUtil.getUniformBacks(_distX, _dist, _total);
			_distZ = new Array();
			PhysicUtil.getAirH(_distZ, _high, _total);
			for (var i : int = 0;i < 12;i++) {
				_distX.push(0);
				_distZ.push(0);
			}
			_half = _total * 0.5;
		}
	}
}

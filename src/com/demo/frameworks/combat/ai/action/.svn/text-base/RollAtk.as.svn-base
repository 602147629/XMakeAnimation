package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.core.data.PlayData;

	/**
	 * 滚动攻击
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public final class RollAtk extends ActionAtk {
		private var _start : PlayData;
		private var _roll : PlayData;
		private var _end : PlayData;
		private var _step : int;

		override protected function onComplete(value : BitmapAnimation) : void {
			value.playBy(_roll);
		}

		private function rollChange(value : BitmapAnimation) : void {
			var dx : int = value.flipH ? -_step : _step;
			var view : EnityView = EnityView(value.parent.parent);
			view.offsetTo(dx, 0);
			var current : int = value.currentFrame;
//			var hitData : N_HitData = getHitBy(current);
//			if (hitData == null) {
//				return;
//			}
//			hitData.reset(view.x, view.y, value.y, value.flipH);
//			var map : IMapView = view.parent.parent as IMapView;
//			if (map == null) {
//				return;
//			}
//			var isHit : Boolean = map.checkAtk(hitData, view);
//			if (isHit) {
//				value.wait = hitData.owner.hitWait;
//				if (hitData.owner.mode == N_HitMode.ONCE) {
//					value.playBy(_end);
//				}
//			}
		}

		private function rollComplete(value : BitmapAnimation) : void {
			value.playBy(_end);
		}

		private function endComplete(value : BitmapAnimation) : void {
			if (_debug) {
				return;
			}
			var view : EnityView = EnityView(value.parent.parent);
			view.restore();
//			view.ai.onAttackEnd();
		}

		public function RollAtk() {
			_type = N_ActionType.ROLL_ATK;
			_change = null;
		}

		override public function atAtkRange(dx : int, dy : int) : Boolean {
			if (dx > _roll.frames.length * _step + _atkRangeMaxX) {
				return false;
			}
			if (dy > _atkRangeMaxY) {
				return false;
			}
			return true;
		}

		override public function reset(value : EnityView) : void {
			super.reset(value);
			_delay = _start.delay;
			_frames = _start.frames;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_start = new PlayData();
			_start.parseObj(value.params.start);
			_roll = new PlayData();
			_roll.parseObj(value.params.roll);
			_roll.change = rollChange;
			_roll.complete = rollComplete;
			_end = new PlayData();
			_end.parseObj(value.params.end);
			_end.complete = endComplete;
			_step = value.params.step;
		}
	}
}

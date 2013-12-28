package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.core.data.PlayData;

	/**
	 * 冲撞动作
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class DashAtk extends ActionAtk {
		private var _start : PlayData;
		private var _atk : PlayData;
		private var _end : PlayData;
		private var _noHit : PlayData;
		private var _step : int;
		private var _isHit : Boolean;

		override protected function onComplete(value : BitmapAnimation) : void {
			value.playBy(_atk);
		}

		private function atkChange(value : BitmapAnimation) : void {
			var dx : int = value.flipH ? -_step : _step;
			var view : EnityView = EnityView(value.parent.parent);
			view.offsetTo(dx, 0);
			var current : int = value.currentFrame;
			checkEffect(value);
			checkGhost(value);
//			var hitData : N_HitData = getHitBy(current);
//			if (hitData == null) {
//				return;
//			}
//			hitData.reset(view.x, view.y, value.y, value.flipH);
//			var map : IMapView = view.parent.parent as IMapView;
//			var isHit : Boolean = map.checkAtk(hitData, view);
//			if (isHit) {
//				_isHit = true;
//				value.wait = hitData.owner.hitWait;
//				if (hitData.owner.mode == N_HitMode.ONCE) {
//					value.playBy(_end);
//				}
//			}
		}

		private function atkComplete(value : BitmapAnimation) : void {
			if (_isHit) {
				value.playBy(_end);
			} else {
				value.playBy(_noHit);
			}
		}

		private function endComplete(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
			view.restore();
//			view.ai.onAttackEnd();
		}

		public function DashAtk() {
			_type = N_ActionType.DASH;
			_change = null;
		}

		override public function atAtkRange(dx : int, dy : int) : Boolean {
			if (dx > _atk.frames.length * _step + _atkRangeMaxX) {
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
			_isHit = false;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_start = new PlayData();
			_start.parseObj(value.params.start);
			_atk = new PlayData();
			_atk.parseObj(value.params.atk);
			_atk.change = atkChange;
			_atk.complete = atkComplete;
			_end = new PlayData();
			_end.parseObj(value.params.end);
			_end.complete = endComplete;
			_noHit = new PlayData();
			_noHit.parseObj(value.params.noHit);
			_noHit.complete = endComplete;
			_step = value.params.step;
		}
	}
}

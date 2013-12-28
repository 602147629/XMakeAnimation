package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.core.creature.RoleView;
	import com.demo.util.PhysicUtil;

	/**
	 * @author flashpf
	 * @version 20120516
	 */
	public final class JumpAtk extends ActionAtk {
		private var _atkFrames : Array;
		private var _invalidFrames : Array;
		private var _total : int;
		private var _half : int;
		private var _valid : int;
		private var _invalid : int;
		private var _distZ : Array;

		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : RoleView = RoleView(value.parent.parent.parent);
			view.high = _distZ[current];
			view.checkMove();
//			view.mapView.scrollControl.offsetTo(0, view.shadow.y);//地图偏移效果 去掉
			var hitFrame : int = view.state.hitFrame;
			if (hitFrame > 0) {
				if (current < hitFrame) {
					return;
				}
				// var hitData : N_HitData = getHitBy(current - hitFrame);
				// if (hitData != null) {
				// hitData.reset(view.x, view.y, value.y, value.flipH);
				// if (view.mapView != null) {
				// var isHit : Boolean = view.mapView.checkAtk(hitData, view);
				// if (isHit) {
				// value.wait = hitData.owner.hitWait;
				// }
				// }
				// }
				return;
			}
			if (hitFrame == 0) {
				view.state.canFlipH = false;
				if (current < _half) {
					view.state.hitFrame = _half;
					value.changeFrames(view.state.hitFrame, _atkFrames);
				} else if (current < _valid) {
					view.state.hitFrame = current + 1;
					value.changeFrames(view.state.hitFrame, _atkFrames);
				} else if (current < _invalid) {
					value.changeFrames(current + 1, _invalidFrames);
				}
			}
		}

		public function JumpAtk() {
			_distZ = new Array();
		}

		override public function reset(view : EnityView) : void {
			super.reset(view);
			view.state.canFlipH = true;
			if (_debug) {
				view.state.hitFrame = 0;
			} else {
				view.state.hitFrame = -1;
			}
		}

		public function set jumpHigh(value : int) : void {
			PhysicUtil.getAirH(_distZ, value, _frames.length);
		}

		override public function end(view : EnityView) : void {
			if (view.state.hitFrame != -1) {
				view.state.isRun = false;
			} else if (!view.state.isLeft && !view.state.isRight) {
				view.state.isRun = false;
			}
			view.restore();
		}

		public function init() : void {
			_total = _frames.length;
			_half = _frames.length * 0.5;
			_valid = _frames.length - _atkFrames.length;
			_invalid = _frames.length - _invalidFrames.length;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_atkFrames = value.params.atkFrames;
			_invalidFrames = value.params.invalidFrames;
			init();
		}

		public function set atkFrames(atkFrames : Array) : void {
			_atkFrames = atkFrames;
		}

		public function set invalidFrames(invalidFrames : Array) : void {
			_invalidFrames = invalidFrames;
		}
	}
}

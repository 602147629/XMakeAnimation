package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 反弹动作-被动
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public final class BounceAction extends BaseAction {
		private var _rollFrames : Array;
		private var _rollEnd : int;
		private var _lieBentFrame : int;
		private var _lieFadeFrame : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
//			var move : Move3d = view.move;
//			if (move.hasNext()) {
//				view.high = move.moveZ.current;
//				view.offsetTo(move.moveX.step, move.moveY.step);
//			}
		}

		public function onComplete(value : BitmapAnimation) : void {
			value.y = 0;
			var view : EnityView = EnityView(value.parent.parent);
			view.shadow.y = 0;
			if (_debug) {
				return;
			}
			if (view.state.isDead) {
//				view.setActionBy(N_ActionType.DEAD);
//				if (view.ai != null) {
//					view.ai.onDead();
//				}
			} else {
//				view.setActionBy(N_ActionType.STAND);
			}
		}

		public function BounceAction() : void {
			_change = onChange;
			_complete = onComplete;
		}

		override public function debug(view : EnityView) : void {
			super.debug(view);
			var dist : int = -50;
			var high : int = 100;
//			view.move.moveX.init(view.x, dist, view.enityData.base.airSpeedX, MoveMode.SUB);
//			view.move.moveY.init(view.y, 0, view.enityData.base.airSpeedX, MoveMode.SUB);
//			view.move.moveZ.init(view.player.y, view.player.y - high, view.enityData.base.airSpeedZ, MoveMode.AIR);
//			view.move.bounce(0.3, -20, 12);
//			resetFrames(view.move.total);
		}

		public function resetFrames(total : int, wait : int = 0) : void {
			_frames.splice(0);
			var i : int;
			if (_rollFrames != null) {
				while (_frames.length < total) {
					_frames.push(_rollFrames[i++ % _rollFrames.length]);
				}
				_frames[_frames.length - 1] = _rollEnd;
			} else {
				var half : int = total * 0.5;
				for (i = 0;i < half;i++) {
					_frames.push(_lieBentFrame);
				}
				for (i = half;i < total;i++) {
					_frames.push(_lieFadeFrame);
				}
				var frame : int = _frames[0];
				for (i = 0;i < wait;i++) {
					_frames.unshift(frame);
				}
			}
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_rollFrames = (value.params.rollFrames != null ? value.params.rollFrames : null);
			_rollEnd = (value.params.rollEnd != null ? value.params.rollEnd : -1);
			_lieBentFrame = (value.params.lieBentFrame != null ? value.params.lieBentFrame : -1);
			_lieFadeFrame = (value.params.lieFadeFrame != null ? value.params.lieFadeFrame : -1);
		}
	}
}

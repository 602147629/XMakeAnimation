package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 掉落动作-被动
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public final class DropAction extends BaseAction {
		private var _rollFrames : Array;
		private var _rollEnd : int;
		private var _pushFrame : int;
		private var _bentFrame : int;
		private var _fadeFrame : int;
		private var _lieBentFrame : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
//			if (view.move.hasNext()) {
//				view.high = view.move.moveZ.current;
//				view.offsetTo(view.move.moveX.step, view.move.moveY.step);
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

		public function DropAction() : void {
			_change = onChange;
			_complete = onComplete;
		}

		override public function reset(view : EnityView) : void {
			super.reset(view);
			view.stopMove();
		}

		override public function debug(view : EnityView) : void {
			super.debug(view);
			var dist : int = -50;
			view.player.y = -100;
//			view.move.moveX.init(view.x, dist * 0.5, view.enityData.base.airSpeedX, MoveMode.UNIFORM);
//			view.move.moveY.init(view.y, 0, view.enityData.base.airSpeedX, MoveMode.UNIFORM);
//			view.move.moveZ.init(view.player.y, 0, view.enityData.base.airSpeedZ, MoveMode.AIR);
//			view.move.reset();
//			resetFrames(view.move.total);
		}

		public function resetFrames(total : int, wait : int = 0) : void {
			_frames.splice(0);
			var i : int = 0;
			if (_rollFrames != null) {
				while (_frames.length < total) {
					_frames.push(_rollFrames[i++ % _rollFrames.length]);
				}
				_frames[_frames.length - 1] = _rollEnd;
			} else if (_pushFrame != -1) {
				for (i = 0;i < total;i++) {
					_frames.push(_pushFrame);
				}
			} else {
				var dropHalf : int = total * 0.5;
				var half : int = Math.round(dropHalf * 0.5);
				for (i = 0;i < half;i++) {
					_frames.push(_bentFrame);
				}
				for (i = half;i < dropHalf;i++) {
					_frames.push(_fadeFrame);
				}
				for (i = dropHalf;i < total;i++) {
					_frames.push(_lieBentFrame);
				}
			}
			var frame : int = _frames[0];
			for (i = 0;i < wait;i++) {
				_frames.unshift(frame);
			}
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_rollFrames = (value.params.rollFrames != null ? value.params.rollFrames : null);
			_rollEnd = (value.params.rollEnd != null ? value.params.rollEnd : -1);
			_pushFrame = (value.params.pushFrame != null ? value.params.pushFrame : -1);
			_bentFrame = (value.params.bentFrame != null ? value.params.bentFrame : -1);
			_fadeFrame = (value.params.fadeFrame != null ? value.params.fadeFrame : -1);
			_lieBentFrame = (value.params.lieBentFrame != null ? value.params.lieBentFrame : -1);
		}
	}
}

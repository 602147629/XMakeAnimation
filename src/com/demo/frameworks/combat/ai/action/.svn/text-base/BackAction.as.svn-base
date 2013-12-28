package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 后退动作
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class BackAction extends BaseAction {
		protected var _fadeFrames : Array;
		protected var _bentFrames : Array;
		protected var _fadeFrame : int;
		protected var _bentFrame : int;
		protected var _index : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
//			var move : Move3d = view.move;
//			if (move.hasNext()) {
//				value.y = move.moveZ.current;
//				view.shadow.y = value.y * 0.1;
//				view.offsetTo(move.moveX.step, move.moveY.step);
//			}
		}

		protected function onComplete(value : BitmapAnimation) : void {
			if (_debug) {
				return;
			}
			var view : EnityView = EnityView(value.parent.parent);
			view.state.isRun = false;
			if (view.state.isDead) {
//				view.setActionBy(N_ActionType.DEAD);
//				if (view.ai != null) {
//					view.ai.onDead();
//				}
			} else {
				view.restore();
//				if (view.ai != null) {
//					view.ai.onBackEnd();
//				}
			}
		}

		public function BackAction() {
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
//			view.move.moveX.init(view.x, dist, view.enityData.base.backSpeed, MoveMode.SUB);
//			view.move.moveY.init(view.y, 0, view.enityData.base.airSpeedX, MoveMode.SUB);
//			view.move.moveZ.init(0, 0, view.enityData.base.airSpeedZ, MoveMode.AIR);
//			view.move.reset();
//			resetFrames(view.move.total, 0);
		}

		public function resetFrames(total : int, wait : int) : void {
			_frames.splice(0);
			var i : int = 0;
			if (_fadeFrames != null && _bentFrames != null) {
				var list : Array;
				if (_index == 0) {
					_index = 1;
					list = _fadeFrames;
				} else {
					_index = 0;
					list = _bentFrames;
				}
				i = 0;
				while (_frames.length < total) {
					_frames.push(list[i++ % list.length]);
				}
			} else {
				var frame : int;
				if (_index == 0) {
					_index = 1;
					frame = _fadeFrame;
				} else {
					_index = 0;
					frame = _bentFrame;
				}
				for (i = 0;i < total;i++) {
					_frames.push(frame);
				}
			}

			frame = _frames[0];
			for (i = 0;i < wait;i++) {
				_frames.unshift(frame);
			}
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_fadeFrames = (value.params.fadeFrames != null ? value.params.fadeFrames : null);
			_bentFrames = (value.params.bentFrames != null ? value.params.bentFrames : null);
			_fadeFrame = (value.params.fadeFrame != null ? value.params.fadeFrame : -1);
			_bentFrame = (value.params.bentFrame != null ? value.params.bentFrame : -1);
		}
	}
}

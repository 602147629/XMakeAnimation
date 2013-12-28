package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityState;
	import com.demo.core.creature.EnityView;
	import com.demo.util.PhysicUtil;

	/**
	 * 连续攻击
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class LinkAtk extends ActionAtk {
		private var _offsetFrame : int;
		private var _nextFrame : int;
		private var _nextType : int;
		private var _dx : int;
		private var _slides : Array;

		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var dx : int;
			var sx : int;
			var flipH : Boolean = value.flipH;
			if (current < _offsetFrame) {
				dx = (value.flipH ? -_dx : _dx);
				sx = _dx * 2;
			} else {
				dx = 0;
				sx = _slides[current - _offsetFrame];
			}
			var view : EnityView = EnityView(value.parent.parent);
			var state : EnityState = view.state;
			if (current > _nextFrame) {
//				if (_nextType != -1 && view.state.linkAction != null) {
//					value.onComplete(value);
//					return;
//				}
				if (view.state.nextType != -1) {
					nextAtk(value);
					return;
				}
			}
			if (state.firstLeft) {
				if (state.isLeft) {
					dx = (flipH ? -sx : 0);
				} else if (state.isRight) {
					dx = (flipH ? 0 : sx);
				}
			} else {
				if ( state.isRight) {
					dx = (flipH ? 0 : sx);
				} else if (state.isLeft) {
					dx = (flipH ? -sx : 0);
				}
			}
			if (dx != 0) {
				view.offsetTo(dx, 0);
			}
			super.onChange(value);
		}

		private function nextAtk(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
			value.flipH = view.state.getMoveFlipH(value.flipH);
//			view.action = view.getActionBy(view.state.nextType);
		}

		public function LinkAtk() {
			_slides = new Array();
		}

		override public function reset(value : EnityView) : void {
			super.reset(value);
		}

		public function get nextType() : int {
			return _nextType;
		}

		public function get nextFrame() : int {
			return _nextFrame;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_nextType = (value.params.nextName != null ? N_ActionType.getType(value.params.nextName) : -1);
			_offsetFrame = value.params.offsetFrame;
			_nextFrame = value.params.nextFrame;
			_dx = value.params.dx;
			PhysicUtil.getBacks(_slides, 20, _frames.length - _offsetFrame);
		}
	}
}

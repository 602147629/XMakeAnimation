package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * @author flashpf
	 */
	public final class BackJump extends BaseAction {
		private var _breathFrame : int;
		private var _backJumpFrame : int;
		private var _dist : int;
		private var _high : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
//			if (view.move.hasNext()) {
//				value.y = view.move.moveZ.current;
//				view.shadow.y = value.y * 0.1;
//				view.offsetTo(view.move.moveX.step, view.move.moveY.step);
//			}
		}

		private function onComplete(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
			view.state.isRun = false;
			view.restore();
		}

		public function BackJump() {
			_change = onChange;
			_complete = onComplete;
		}

		override public function reset(value : EnityView) : void {
			value.stopMove();
//			value.move.moveX.init(value.x, (value.flipH ? _dist : - _dist), 10, MoveMode.UNIFORM);
//			value.move.moveY.init(value.y, 0, 10, MoveMode.UNIFORM);
//			value.move.moveZ.init(value.player.y, -_high, 10, MoveMode.AIR);
//			value.move.reset();
//			resetFrame(value.move.total);
		}

		public function resetFrame(total : int) : void {
			_frames.splice(0);
			_frames.push(_breathFrame);
			for (var i : int = 0;i < total - 2;i++) {
				_frames.push(_backJumpFrame);
			}
			_frames.push(_breathFrame);
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_breathFrame = value.params.breathFrame;
			_backJumpFrame = value.params.backJumpFrame;
			_high = value.params.high;
			_dist = value.params.dist;
		}
	}
}

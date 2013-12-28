package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 后退动作
	 * 
	 * @author bright
	 * @version 20120523
	 */
	public final class SuckedAction extends BaseAction {
		private var _suckedFrames : Array;
		private var _suckedFrame : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
//			var move : Move3d = view.move;
//			if (move.hasNext()) {
//				view.high = move.moveZ.current;
//				view.offsetTo(move.moveX.step, move.moveY.step);
//			}
		}

		public function SuckedAction() {
			_change = onChange;
		}

		override public function reset(view : EnityView) : void {
			super.reset(view);
			view.stopMove();
		}

		override public function debug(view : EnityView) : void {
//			view.move.moveX.init(view.x, 100, 10, MoveMode.ADD);
//			view.move.moveY.init(view.y, 0, 10, MoveMode.ADD);
//			var high : int = view.block.hitRect.height - 80;
//			view.move.moveZ.init(view.player.y, high - view.player.y, 10, MoveMode.ADD);
//			view.move.reset();
//			resetFrames(view.move.total);
		}

		public function resetFrames(total : int) : void {
			_frames.splice(0);
			var i : int = 0;
			if (_suckedFrames != null) {
				while (_frames.length < total) {
					_frames.push(_suckedFrames[i++ % _suckedFrames.length]);
				}
			} else {
				for (i = 0;i < total;i++) {
					_frames.push(_suckedFrame);
				}
			}
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_suckedFrames = (value.params.suckedFrames != null ? value.params.suckedFrames : null);
			_suckedFrame = (value.params.suckedFrame);
		}
	}
}

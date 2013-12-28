package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 站起动作-被动
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class StandAction extends BaseAction {
		protected var _lieFrame : int;
		protected var _squatFrame : int;
		protected var _lieTimes : int;

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
//					view.ai.onStandEnd();
//				}
			}
		}

		protected function resetFrames() : void {
			_frames.splice(0);
			_ignoreStart = 1;
			for (var i : uint = 0;i < _lieTimes;i++) {
				_frames.push(_lieFrame);
			}
			_ignoreEnd = _lieTimes - 1;
			_frames.push(_squatFrame);
			_frames.push(_squatFrame);
			_frames.push(_squatFrame);
			_frames.push(_squatFrame);
		}

		public function StandAction() {
			_change = checkIgnore;
			_complete = onComplete;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			if (value.params == null) {
				return;
			}
			_lieFrame = (value.params.lieFrame != null ? value.params.lieFrame : -1);
			_squatFrame = (value.params.squatFrame != null ? value.params.squatFrame : -1);
			_lieTimes = (value.params.lieTimes != null ? value.params.lieTimes : -1);
			resetFrames();
		}
	}
}

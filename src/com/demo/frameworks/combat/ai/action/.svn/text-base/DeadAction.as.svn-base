package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * @author flashpf
	 */
	public class DeadAction extends BaseAction {
		protected function onComplete(value : BitmapAnimation) : void {
			if (_debug) {
				return;
			}
			var view : EnityView = EnityView(value.parent.parent.parent);
			view.dead();
		}

		public function DeadAction() {
			_complete = onComplete;
		}
	}
}

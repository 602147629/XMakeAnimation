package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityState;
	import com.demo.core.creature.EnityView;

	/**
	 * 自爆
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public class SelfExplode extends ActionAtk {
		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			if (current == 10) {
				value.filters = [];
			}
			checkHit(value);
			checkEffect(value);
		}

		override protected function onComplete(value : BitmapAnimation) : void {
			value.filters = [];
			if (_debug) {
				return;
			}
			var view : EnityView = EnityView(value.parent.parent);
			view.dead();
		}

		public function SelfExplode() {
			complete = onComplete;
		}

		override public function reset(view : EnityView) : void {
			super.reset(view);
			view.state.isIgnore = true;
			view.player.filters = [EnityState.SELF_EXPLODE_FILTER];
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
		}
	}
}

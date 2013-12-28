package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.core.creature.RoleView;

	/**
	 * @author flashpf
	 */
	public final class RunAtk extends ActionAtk {
		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var dx : int = 0;
			if (current < 9) {
				dx = (value.flipH ? -7 : 7);
			} else if (current < 10) {
				dx = (value.flipH ? -4 : 4);
			} else if (current < 11) {
				dx = (value.flipH ? -2 : 2);
			} else if (current < 12) {
				dx = (value.flipH ? 3 : -3);
			} else if (current < 13) {
				dx = (value.flipH ? -1 : 1);
			}
			var view : EnityView = EnityView(value.parent.parent);
			if (dx != 0) {
				view.offsetTo(dx, 0);
			}
//			var hitData : N_HitData = getHitBy(current, 0);
//			if (hitData != null) {
//				hitData.reset(view.x, view.y, value.y, value.flipH);
//				if (view.mapView != null) {
//					var isHit : Boolean = view.mapView.checkAtk(hitData, view);
//					if (isHit) {
//						value.wait = hitData.owner.hitWait;
//					}
//				}
//			}
		}

		override protected function onComplete(value : BitmapAnimation) : void {
			var view : RoleView = RoleView(value.parent.parent);
			view.state.isRun = false;
			view.restore();
		}

		public function RunAtk() {
		}
	}
}

package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;
	import com.demo.core.creature.RoleView;

	/**
	 * @author bright
	 */
	public final class Bloodlust extends ActionAtk {
		private var _frontX : int;
		private var _distY : int;
		private var _behindX : int;
		private var _dx : int;
		private var _dz : int;

		override protected function onChange(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : EnityView = EnityView(value.parent.parent);
			var suckedT : EnityView;
			checkEffect(value);
//			if (current == 15) {
//				suckedT = view.mapView.find(view, _frontX, _distY, _behindX);
//				view.state.suckedT = suckedT;
//				if (view.state.suckedT != null) {
//					view.state.isIgnore = true;
//					var dx : int = (value.flipH ? -_dx : _dx);
//					suckedT.move.moveX.init(suckedT.x, view.x - suckedT.x + dx, 20, MoveMode.ADD);
//					suckedT.move.moveY.init(suckedT.y, view.y - suckedT.y + 1, 10, MoveMode.ADD);
//					var high : int = suckedT.block.hitRect.height - 80;
//					if (high > 0) {
//						high = 0;
//					}
//					suckedT.move.moveZ.init(suckedT.player.y, high - suckedT.player.y, 10, MoveMode.ADD);
//					suckedT.move.reset();
//					suckedT.flipH = !view.flipH;
//					suckedT.ai.pause = true;
//					var sucked : SuckedAction = SuckedAction(suckedT.getActionBy(N_ActionType.SUCKED));
//					sucked.resetFrames(suckedT.move.total);
//					suckedT.action = sucked;
//					suckedT.startShock();
//					view.wait = suckedT.move.total;
//				}
//			} else if (current == 16) {
//				if (view.state.suckedT != null) {
//					view.wait = 15;
//				} else {
//					view.endEffect();
//					view.restore();
//				}
//			} else if (current == 17) {
//				if (view.state.suckedT != null) {
//					suckedT = view.state.suckedT;
//					view.mapView.scrollControl.startShock(12);
//					var hitData : N_HitData = getHitBy(current, 0);
//					if (hitData != null) {
//						view.offsetTo(0, -1);
//						hitData.reset(view.x, view.y, value.y, value.flipH);
//						MonsterView(suckedT).checkDmg(hitData, RoleView(view).data.careerData);
//						MonsterView(suckedT).resetHit(hitData);
//					}
//				}
//			}
		}

		public function Bloodlust() : void {
			_frontX = 200;
			_distY = 40;
			_behindX = -60;
			_dx = 55;
			_dz = -50;
		}

		override public function reset(value : EnityView) : void {
			super.reset(value);
			value.state.suckedT = null;
		}
	}
}

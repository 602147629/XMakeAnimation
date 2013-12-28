package com.demo.frameworks.combat.ai.behavior {
	import com.demo.core.creature.BaseActionType;
	import com.demo.core.creature.EnityView;
	import com.demo.core.render.FrameRender;
	import com.demo.frameworks.combat.ai.action.N_ActionType;
	import com.demo.util.MathUtil;

	/**
	 * @author bright
	 * @version 20120614
	 */
	public class MoveBehavior extends AIBehavior {
		protected var _dx : int;
		protected var _dy : int;
		protected var _reverse : Boolean;

		public function MoveBehavior(value : EnityView) {
			super(value);
			_name = "漫游";
			// _color = Color.LITTLE_YELLOW_DATA;
			_endTime = 20;
			_reverse = false;
		}

		override public function start() : void {
			super.start();
			_dx = FrameRender.elapsed * .15;
//			_dx =  MonsterView(_view).data.monsterBase.walkSpeedX * 1.5;
			_dy = _dx * 0.7;
			var distX : int = _view.mapView.myRoleView.x - _view.x;
			if (Math.abs(distX) < 70) {
				if (distX > 0) {
					_dx = -_dx;
				}
			} else if (MathUtil.random(0, 1) == 0) {
				_dx = -_dx;
			}
			var distY : int = _view.mapView.myRoleView.y - _view.y;
			if (Math.abs(distY) < 30) {
				if (distY > 0) {
					_dy = -_dy;
				}
			} else if (MathUtil.random(0, 1) == 0) {
				_dy = -_dy;
			}
			_view.actionType = BaseActionType.WALK;
		}

		override public function execute() : void {
			if (_isEnd) {
				return;
			}
			_count++;
			if (_count > _endTime) {
				end();
				return;
			}
			var oldX : int = _view.x;
			var oldY : int = _view.y;
			_view.offsetTo(_dx, _dy);
			if (_view.x == oldX) {
				_dx = -_dx;
				return;
			}
			if (_view.y == oldY) {
				_dy = -_dy;
				return;
			}
			if (_dx > 0) {
				_view.player.isReverse = !_view.player.flipH;
			} else {
				_view.player.isReverse = _view.player.flipH;
			}
		}
	}
}

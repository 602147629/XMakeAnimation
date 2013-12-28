package com.demo.frameworks.combat.ai.behavior {
	import com.demo.core.creature.BaseActionType;
	import com.demo.core.creature.EnityView;
	import com.demo.core.render.FrameRender;
	import com.demo.frameworks.combat.ai.action.N_ActionType;
	import com.demo.util.MathUtil;

	/**
	 * @author bright
	 */
	public class FleeBehavior extends AIBehavior {
		protected var _dx : int;
		protected var _dy : int;

		public function FleeBehavior(value : EnityView) {
			super(value);
			_name = "逃跑";
			// _color = Color.WHITE_DATA;
			_endTime = 30;
		}

		override public function start() : void {
			super.start();
			_dx = FrameRender.elapsed * .15;
			// _dx = MonsterView(_view).data.monsterBase.walkSpeedX * 1.2;
			_dy = _dx * 0.7;
			if (_dy < 1) {
				_dy = 1;
			}
			var distX : int = _view.mapView.myRoleView.x - _view.x;
			if (distX > 0) {
				_dx = -_dx;
			}
			if (MathUtil.random(1, 100) < 50) {
				_dy = -_dy;
			}
			_view.actionType = BaseActionType.WALK;
		}

		override public function execute() : void {
			if (_isEnd) {
				return;
			}
			if (_count > _endTime) {
				_isEnd = true;
				_count = 0;
				return;
			}
			var oldX : int = _view.x;
			var oldY : int = _view.y;
			_view.offsetTo(_dx, _dy);
			if (_view.x == oldX) {
				_dx = -_dx;
			}
			if (_view.y == oldY) {
				_dy = -_dy;
			}
			_count++;
		}
	}
}

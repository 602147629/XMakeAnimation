package com.demo.frameworks.combat.ai.behavior {
	import com.demo.core.creature.BaseActionType;
	import com.demo.core.creature.EnityView;
	import com.demo.core.render.FrameRender;
	import com.demo.frameworks.combat.ai.action.N_ActionType;

	/**
	 * @author flashpf
	 */
	public class SeekBehavior extends AIBehavior {
		public var seeX : int;
		public var seeY : int;
		protected var _speedX : Number;
		protected var _speedY : Number;
		protected var _distX : int;
		protected var _distY : int;
		protected var _dx : int;
		protected var _dy : int;

		public function SeekBehavior(view : EnityView) {
			super(view);
			_name = "追捕";
			// _color = GColor.LIGHT_PURPLE;
			_endTime = 50;
			seeX = 300;
			seeY = 150;
		}

		public function canSeek() : Boolean {
			var distX : int = Math.abs(_view.mapView.myRoleView.x - _view.x);
			if (distX > seeX) {
				return false;
			}
			var distY : int = Math.abs(_view.mapView.myRoleView.y - _view.y);
			if (distY > seeY) {
				return false;
			}
			return true;
		}

		override public function start() : void {
			super.start();
			_speedX = FrameRender.elapsed * .15;
			// _speedX = MonsterView(_view).data.monsterBase.walkSpeedX * 1.5;
			_speedY = _speedX * 0.5;
			_view.actionType = BaseActionType.WALK;
		}

		override public function execute() : void {
			if (_isEnd) {
				return;
			}
			if (_count > _endTime) {
				end();
				return;
			}
			if (_count % 5 == 0) {
				_distX = _view.mapView.myRoleView.x - _view.x;
				_distY = _view.mapView.myRoleView.y - _view.y;
//				if (_view.enityData.base.atAtkRange(Math.abs(_distX), Math.abs(_distY))) {
//					_isEnd = true;
//					return;
//				}
				_distX += (_distX > 0 ? -70 : 70);
				_dx = (_distX > 0 ? _speedX : -_speedX);
				_dy = (_distY > 0 ? _speedY : -_speedY);
			}
			if (_distX > 0) {
				if (_distX - _dx < 0) {
					_dx = _distX;
					_distX = 0;
				} else {
					_distX -= _dx;
				}
			} else if (_distX < 0) {
				if (_distX - _dx > 0) {
					_dx = _distX;
					_distX = 0;
				} else {
					_distX -= _dx;
				}
			} else {
				_dx = 0;
			}
			if (_distY > 0) {
				if (_distY - _dy < 0) {
					_dy = _distY;
					_distY = 0;
				} else {
					_distY -= _dy;
				}
			} else if (_distY < 0) {
				if (_distY - _dy > 0) {
					_dy = _distY;
					_distY = 0;
				} else {
					_distY -= _dy;
				}
			} else {
				_dy = 0;
			}
			var oldX : int = _view.x;
			var oldY : int = _view.y;
			_view.offsetTo(_dx, _dy);
			if (oldX == _view.x) {
				_distX = 0;
				_dx = 0;
			}
			if (oldY == _view.y) {
				_distY = 0;
				_dy = 0;
			}
			if (_distX == 0 && _distY == 0) {
				_isEnd = true;
				return;
			}
			if (_dx > 0) {
				_view.player.isReverse = !_view.player.flipH;
			} else {
				_view.player.isReverse = _view.player.flipH;
			}
			_count++;
		}
	}
}

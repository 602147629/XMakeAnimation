package com.demo.frameworks.combat.ai.core {
	import com.demo.core.creature.MonsterView;
	import com.demo.frameworks.combat.ai.action.N_ActionType;
	import com.demo.frameworks.combat.ai.data.AIDataList;
	import com.demo.util.MathUtil;

	/**
	 * 漫游者
	 * 
	 * @author bright
	 * @version 20120612
	 */
	public class MonsterAI extends AIEngine {
		protected var _monsterView : MonsterView;

		protected function checkCounterAtk() : void {
			if (_pause) {
				return;
			}
			if (_view.mapView.myRoleView.state.isDead) {
				return;
			}
			var dx : int = Math.abs(_view.mapView.myRoleView.x - _view.x) ;
			var dy : int = Math.abs(_view.mapView.myRoleView.y - _view.y) ;
			// _view.enityData.base.canAtk(_atks, dx, dy);
			if (_atks.length > 0) {
				if (MathUtil.random(1, 100) < _data.counterAtkCost) {
					_current = _atk;
					showState(_current);
					_atk.atk = _atks[MathUtil.random(0, _atks.length - 1)];
					_current.start();
					_current.execute();
					_pause = false;
					return;
				}
			}
			_current = _flee;
			showState(_current);
			_current.start();
		}

		public function MonsterAI(value : MonsterView) {
			super(value);
			_monsterView = value;
			_data.seekCost = 40;
			_data.moveCost = 40;
			_data.atkCost = 80;
			_data.seeX = 500;
			_data.seeY = 250;
			_data.seekEndTime = 40;
		}

		override public function reset(hard : int) : void {
			super.reset(hard);
			_current = _wait;
			_current.start();
			// AIDataList.initData(_data, _monsterView.data, hard);
			_seek.endTime = _data.seekEndTime;
			_seek.seeX = _data.seeX;
			_seek.seeY = _data.seeY;
		}

		override public function think() : void {
			if (_pause) {
				return;
			}
			var flipH : Boolean = (_view.x > _view.mapView.myRoleView.x);
			if (_view.player.flipH != flipH) {
				_view.player.flipH = flipH;
			}
			if (!_current.isEnd) {
				_current.execute();
				return;
			}
			if (_view.mapView.myRoleView.state.isDead) {
				_current = _wait;
				_current.start();
				_current.execute();
				return;
			}
			var dx : int = Math.abs(_view.mapView.myRoleView.x - _view.x) ;
			var dy : int = Math.abs(_view.mapView.myRoleView.y - _view.y) ;
			 _view.data.canAtk(_atks, dx, dy);
			if (_atks.length > 0) {
				var isAtk : Boolean = false;
				if (_current != _atk) {
					isAtk = MathUtil.random(1, 100) < _data.atkCost;
				} else {
					isAtk = MathUtil.random(1, 100) < _data.againAtkCost;
				}
				if (isAtk) {
					_current = _atk;
					showState(_current);
					_atk.atk = _atks[MathUtil.random(0, _atks.length - 1)];
					_current.start();
					_current.execute();
					_pause = true;
					return;
				}
			}
			// if (_view.getActionBy(N_ActionType.WALK) == null) {
			if (MathUtil.random(0, 100) > 50) {
				_current = _wait;
			} else {
				var isSeek : Boolean = false;
				if (MathUtil.random(1, 100) < _data.seekCost) {
					isSeek = _seek.canSeek();
				}
				if (isSeek) {
					_current = _seek;
				} else {
					if (MathUtil.random(1, 100) < _data.moveCost) {
						_current = _move;
					} else {
						_current = _wait;
					}
				}
				_current.start();
				if (MathUtil.random(1, 100) < 10) {
					// _view.showFace(_restFaces[MathUtil.random(0, _restFaces.length - 1)]);
				}
			}
			showState(_current);
			_current.execute();
		}

		override public function onBackEnd() : void {
			checkCounterAtk();
		}

		override public function onStandEnd() : void {
			checkCounterAtk();
		}

		/**
		 * 当MISS时
		 */
		override public function onMiss() : void {
			checkCounterAtk();
			if (MathUtil.random(1, 100) < 20) {
				// _view.showFace("miss_001");
			}
		}
	}
}

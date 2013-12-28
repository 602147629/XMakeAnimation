package com.demo.core.creature {
	import com.demo.core.RenderCall;
	import com.demo.core.animation.WrapperedAnimation;
	import com.demo.core.base.GBaseData;
	import com.demo.core.data.BlockData;
	import com.demo.core.data.CreatureData;
	import com.demo.core.render.FrameRender;
	import com.demo.core.render.SyncMove;
	import com.demo.define.N_ActionType;
	import com.demo.define.N_SkillType;
	import com.demo.net.loader.ImageModel;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * 角色视图
	 * 
	 * @author bright
	 * @version 20120508
	 */
	public final class RoleView  extends EnityView {
		public var isTransing : Boolean;
		public var canTrans : Boolean = true;
		public var countAtk : uint;
		public var afterCountFun : Function;
		public var insideTrans : Boolean;
		// public var comboCastData : ComboCastData;
		// private var _roleData : RoleData;
		private var _move_rc : RenderCall;
		private var _syncMove : SyncMove;
		private var _autoGo : Bitmap;
		private var _titleMc : MovieClip;

		override protected function onShow() : void {
			super.onShow();
		}

		override public function stopMove() : void {
			_state.canMove = false;
			_state.canFlipH = false;
			FrameRender.instance.remove(_move_rc);
		}

		private function getSpeedX() : int {
			// var base : N_CareerBase = _roleData.careerData.careerBase;
			// if (_action.type != N_ActionType.JUMP_ATK) {
			if (_state.isRun) {
				return FrameRender.elapsed * .35;
			} else {
				return FrameRender.elapsed * .2;
			}
			// } else {
			// if (_state.isRun) {
			// return base.jumpRunSpeedX;
			// } else {
			// return base.jumpWalkSpeedX;
			// }
			// }
		}

		private function getSpeedY() : int {
			// var base : N_CareerBase = _roleData.careerData.careerBase;
			// if (_action.type != N_ActionType.JUMP_ATK) {
			if (_state.isRun) {
				return FrameRender.elapsed * .2;
			} else {
				return FrameRender.elapsed * .1;
			}
			// } else {
			// if (_state.isRun) {
			// return base.jumpRunSpeedY;
			// } else {
			// return base.jumpWalkSpeedY;
			// }
			// }
		}

		public function checkMove() : void {
			var dx : int = 0;
			var dy : int = 0;
			var speed : int = getSpeedX();
			if (_state.firstLeft) {
				if (state.isLeft) {
					dx = - speed ;
				} else if (_state.isRight) {
					dx = speed;
				}
			} else {
				if (_state.isRight) {
					dx = speed;
				} else if (_state.isLeft) {
					dx = -speed;
				}
			}
			speed = getSpeedY();
			if (_state.firstUp) {
				if (_state.isUp) {
					dy = - speed;
				} else if (_state.isDown) {
					dy = speed;
				}
			} else {
				if (_state.isDown) {
					dy = speed;
				} else if (_state.isUp) {
					dy = - speed;
				}
			}
			offsetTo(dx, dy);
		}

		// /**
		// * 进行换装
		// */
		// private function avatar_changeHandler(event : Event) : void {
		// _player.list = _roleData.list;
		// }
		public function RoleView() {
			var base : GBaseData = new GBaseData();
			super(base);
			_block = new BlockData();
			_state = new EnityState();
			_move_rc = new RenderCall(checkMove);
			_syncMove = new SyncMove();
			_syncMove.view = this;
		}

		override public function set data(value : CreatureData) : void {
			_data = value;
			_block.reset(value.halfW, value.halfH, value.source);
		}

		// public function set data(value : RoleData) : void {
		// _roleData = value;
		// _enityData = data.careerData;
		// _block.reset(_enityData.base.halfW, _enityData.base.halfH, _enityData.base.source);
		// _syncMove.isMy = _roleData.isMy;
		// _player.list = _roleData.list;
		// _name_lb.text = _roleData.showName;
		// _name_lb.x = -int(_name_lb.width * 0.5);
		// _name_lb.y = _player.list.getAt(0).offsetY - _name_lb.height;
		// _name_lb.show();
		// _name_lb.textColor = _roleData.isMy ? Color.SKY_BLUE_DATA : 0xFFFFFF;
		// _roleData.addEventListener(RoleData.AVATAR_CHANGE, avatar_changeHandler);
		// }
		// public function get data() : RoleData {
		// return _roleData;
		// }
		public function reset(newX : int, newY : int, flipH : Boolean = false) : void {
			moveTo(newX, newY);
			_player.flipH = flipH;
			_block.moveTo(x, y);
			_block.flipH = flipH;
			_state.reset();
			actionType = BaseActionType.IDLE;
			// if (_mapView is N_CombatMapView) {
			// action = _roleData.careerData.getAction(N_ActionType.COMBAT_BREATHE);
			// } else {
			// action = _roleData.careerData.getAction(N_ActionType.BREATHE);
			// }
		}

		override public function set actionType(value : uint) : void {
			super.actionType = value;
			if (value == _actionType)
				return;
			_player.reset();
			if (value == 0) {
				_actionType = 0;
				return;
			}
			_state.isBrave = false;
			_state.isIgnore = false;
			_actionType = value;
			_action = null;
			var playFrames : Array;
			switch(_actionType) {
				case BaseActionType.IDLE:
					_stats.text = "待机";
					break;
				case BaseActionType.WALK:
					_stats.text = "行走";
					break;
				case BaseActionType.RUN:
					_stats.text = "奔跑";
					break;
				case BaseActionType.FALL_DOWN:
					_stats.text = "倒下";
					break;
				case BaseActionType.GET_UP:
					_stats.text = "起身";
					break;
				case BaseActionType.ATK:
					_stats.text = "攻击";
					break;
				case BaseActionType.JUMP_ATK:
					_stats.text = "跳跃/攻击";
					playFrames = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
					if (_action == null || !(_action is JumpAtk)) {
						_action = new JumpAtk();
						_action.frames = playFrames;
						_action.delay = 33;
						_action.loop = 2;
						JumpAtk(_action).jumpHigh = 86;
						JumpAtk(_action).atkFrames = [2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8];
						JumpAtk(_action).invalidFrames = [1, 1, 1];
						JumpAtk(_action).init();
					}
					break;
			}
			if (_action)
				_action.reset(this);
			trace("action:", value);
			ImageModel.instance.getAnimRes(301, 1, _actionType, function(frames : WrapperedAnimation) : void {
				// _player.xOffset = -400;
				// _player.yOffset = -500;
				_player.renderSpeed = frames.renderSpeed;
				StaticDataModel.instance.setOffset(301, 1, _actionType, frames.frames);
				_player.setFrames(frames.frames);
				if (_action)
					_player.playBy(_action);
				if (_player.parent == null)
					_playerContainer.addChild(_player);
				_player.play();
			});
		}

		// override public function setActionBy(type : int) : void {
		// action = _roleData.careerData.getAction(type);
		// }
		//
		// override public function getActionBy(type : int) : BaseAction {
		// return _roleData.careerData.getAction(type);
		// }
		/**
		 * 偏移至新的坐标点
		 */
		override public function offsetTo(dx : int, dy : int) : Boolean {
			_mapView.checkHit(_block, dx, dy);
			if (x != _block.x || y != _block.y) {
				dx = _block.x - x;
				dy = _block.y - y;
				x = _block.x;
				y = _block.y;
				_mapView.depthSort.reset(this);
				_mapView.scrollControl.checkScroll(x, y, dx, dy);
				_mapView.checkAlpha();
				// if (_roleData.isMy) {
				// if (Common.smallMapPanel != null) {
				// Common.smallMapPanel.drowPlayer(x, y);
				// }
				// if (_mapView != null) {
				// _mapView.syncMove(x, y);
				// }
				// if (Common.rolePanel != null) {
				// Common.rolePanel.showMyPos(x, y);
				// }
				// if (Common.currentMapView != null) {
				// TransUtil.checkNeedTrans(this, Common.currentMapView.data);
				// }
				// }
				return true;
			}
			return false;
		}

		public function clearAutoGo() : void {
			if (_autoGo && _autoGo.visible) {
				// VisitNpcUtil.clearAutoGo();
			}
		}

		public function startMove() : void {
			if (!_state.canMove) {
				return;
			}
			if (_syncMove.isEnd == false) {
				stopSyncMove();
			}
			if (_state.isRun) {
				actionType = BaseActionType.RUN;
				// setActionBy(N_ActionType.RUN);
			} else {
				actionType = BaseActionType.WALK;
				// setActionBy(N_ActionType.WALK);
			}
			_move_rc.reset();
			FrameRender.instance.add(_move_rc);
		}

		public function resetMove() : void {
			if (!_state.canMove) {
				return;
			}
			if (_state.isMove) {
				if (_state.isRun) {
					actionType = BaseActionType.RUN;
					// setActionBy(N_ActionType.RUN);
				} else {
					actionType = BaseActionType.WALK;
					// setActionBy(N_ActionType.WALK);
				}
				if (_state.firstLeft) {
					_player.flipH = (_state.isLeft ? true : !_state.isRight);
				} else {
					_player.flipH = (_state.isRight ? false : _state.isLeft);
				}
				_move_rc.reset();
				FrameRender.instance.add(_move_rc);
			} else {
				// if (_mapView is N_CombatMapView) {
				// setActionBy(N_ActionType.COMBAT_BREATHE);
				// } else {
				// setActionBy(N_ActionType.BREATHE);
				// }
				actionType = BaseActionType.IDLE;
				FrameRender.instance.remove(_move_rc);
			}
		}

		override public function restore() : void {
			super.restore();
			_state.canMove = true;
			_state.canFlipH = true;
			_state.nextType = -1;
			resetMove();
		}

		public function startJump() : void {
			if (!_state.canMove) {
				return;
			}
			// if (_action.type == N_ActionType.JUMP_ATK) {
			// return;
			// }
			if (_actionType == BaseActionType.JUMP_ATK) {
				return;
			}
			actionType = BaseActionType.JUMP_ATK;
		}

		public function startAtk() : Boolean {
			if (_action) {
				if (_action.type == N_SkillType.IN_DEVIL_ESCRIME_3) {
					_state.devilNext = -1;
					return true;
				} else if (N_SkillType.isDevilLink(_action.type)) {
					_state.devilNext = LinkAtk(_action).nextType;
					if (_state.linkNext != -1) {
						_state.nextType = _state.linkNext;
					} else {
						_state.nextType = N_ActionType.LINK_0;
					}
					return true;
				}
				_state.devilNext = -1;
				if (_action is LinkAtk) {
					_state.nextType = LinkAtk(_action).nextType;
					return true;
				}
				if (_action is JumpAtk) {
					if (_state.hitFrame == -1) {
						_state.hitFrame = 0;
					}
					return true;
				}
				if (_action.type == N_ActionType.RUN) {
					FrameRender.instance.remove(_move_rc);
					_state.canMove = _state.canFlipH = false;
					// action = _roleData.careerData.getAction(N_ActionType.RUN_ATK);
					return true;
				}
			}
			if (_state.canMove) {
				actionType = BaseActionType.ATK;
				// _state.canMove = false;
				// action = _roleData.careerData.getAction(N_ActionType.LINK_0);
				return true;
			} else {
				return false;
			}
		}

		//
		// public function startSkill(value : int) : void {
		// var skillData : N_SkillData = _roleData.careerData.getSkill(value);
		// if (skillData == null || state.place == PlaceType.TOWN) {
		// return;
		// }
		// var skillAction : BaseAction = _roleData.careerData.getAction(skillData.base.type);
		// _state.stoneType = skillData.stoneType;
		// if (value == N_SkillType.IN_DEVIL_ESCRIME) {
		// if (_action.type == N_SkillType.IN_DEVIL_ESCRIME_3) {
		// _state.linkNext = -1;
		// return;
		// } else if (N_SkillType.isDevilLink(_action.type)) {
		// _state.nextType = LinkAtk(_action).nextType;
		// return;
		// } else if (N_ActionType.isLinkAtk(_action.type)) {
		// _state.linkNext = LinkAtk(_action).nextType;
		// if (_state.devilNext != -1) {
		// _state.nextType = _state.devilNext;
		// } else {
		// _state.nextType = N_SkillType.IN_DEVIL_ESCRIME;
		// }
		// return;
		// }
		// } else if (value == N_SkillType.BACK_JUMP) {
		//				//  后跳终止连招
		// if (_state.linkAction != null && _player.y == 0) {
		// _state.linkAction = null;
		// action = skillAction;
		// }
		// }
		// _state.linkNext = -1;
		// if (skillAction.isForce) {
		// if (_action is LinkAtk) {
		// action = skillAction;
		// }
		// }
		// if (_state.canMove) {
		// action = skillAction;
		// }
		// }
		//
		// /**
		// * 开始连招
		// */
		// public function startLink(value : int) : void {
		// var linkAction : LinkAction = _roleData.careerData.careerBase.getLinkAt(value);
		// if (linkAction != null && state.place != PlaceType.TOWN) {
		// if (_action is LinkAtk || _state.canMove) {
		// linkAction.start(this);
		// }
		// }
		// }
		public function syncMove(x : int, y : int, endDo : Function = null, clearEndFunc : Boolean = true) : void {
			_syncMove.moveTo(x, y, endDo, clearEndFunc);
		}

		public function syncMoveByPath(path : Vector.<Point>, endFun : Function = null) : void {
			_syncMove.moveByPath(path, endFun);
		}

		public function stopSyncMove() : void {
			_syncMove.stop();
			_syncMove.stopMove();
			clearAutoGo();
		}

		public function get autoGo() : Bitmap {
			return _autoGo;
		}
	}
}

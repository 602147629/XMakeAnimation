package com.demo.core.creature {
	import com.demo.core.animation.WrapperedAnimation;
	import com.demo.core.base.GBaseData;
	import com.demo.core.data.BlockData;
	import com.demo.core.data.CreatureData;
	import com.demo.frameworks.combat.ai.core.MonsterAI;
	import com.demo.system.model.ImageModel;
	import com.demo.system.model.StaticDataModel;

	/**
	 * 怪物视图
	 * 
	 * @author bright
	 * @version 20120607
	 */
	public final class MonsterView extends EnityView {
		public static var debug : Boolean = false;
		// private var _data : MonsterData;
		private var _combatHitDamage : uint;
		private var _wholeDamage : uint;
		private var _isBoss : Boolean;
		public var countAtk : uint;
		public var afterCountFun : Function;
		public var hasFoundPlayer : Boolean;

		public function MonsterView() : void {
			var base : GBaseData = new GBaseData();
			base.enabled = false;
			super(base);
			_block = new BlockData();
			_ai = new MonsterAI(this);
		}

		override public function set data(value : CreatureData) : void {
			_data = value;
			_block.reset(value.halfW, value.halfH, value.source);
		}

		// public function set data(value : MonsterData) : void {
		// _data = value;
		// _enityData = _data;
		// _isBoss = (_data.rankType + 1 >= RankType.ORANGE);
		// _block.reset(_enityData.base.halfW, _enityData.base.halfH, _enityData.base.source);
		// //  _player.list = _data.monsterBase.list;
		// action = _data.monsterBase.getActionBy(N_ActionType.BREATHE);
		// }
		// public function get data() : MonsterData {
		// return _data;
		// }
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

			var playFrames : Array;
			switch(_actionType) {
				case BaseActionType.IDLE:
					_action = null;
					_stats.text = "待机";
					break;
				case BaseActionType.WALK:
					_action = null;
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
			}
			if (_action)
				_action.reset(this);
			trace("action:", value);
			ImageModel.instance.getAnimRes(_data.type, _data.id, _actionType, function(frames : WrapperedAnimation) : void {
				// _player.xOffset = -400;
				// _player.yOffset = -500;
				_player.renderSpeed = frames.renderSpeed;
				StaticDataModel.instance.setOffset(_data.type, _data.id, _actionType, frames.frames);
				_player.setFrames(frames.frames);
				if (_action)
					_player.playBy(_action);
				if (_player.parent == null)
					_playerContainer.addChild(_player);
				_player.play();
			});
		}

		public function reset(newX : int, newY : int, flipH : Boolean = false, hard : int = 0) : void {
			moveTo(newX, newY);
			_block.moveTo(x, y);
			_player.flipH = flipH;
			_block.flipH = flipH;
			// _data.reset();
			_ai.reset(hard);
			actionType = BaseActionType.IDLE;
		}

		/**
		 * 还原状态
		 * @private
		 */
		override public function restore() : void {
			if (_state.isDead) {
				_ai.onDead();
				// action = _data.monsterBase.getActionBy(N_ActionType.DEAD);
				return;
			}
			_ai.pause = false;
			_ai.reset(1);
			actionType = BaseActionType.IDLE;
		}

		override public function dead() : void {
			hide();
			// if (!hasEventListener(MonsterEvent.UPDATA_HP))
			// addEventListener(MonsterEvent.UPDATA_HP, MonsterManage.updateHp);
			// _mapView.removeEnity(this);
			// for each (var data:DropBirth in _drops) {
			// var view : DropView = DropView(DropView.pool.borrowObj());
			// view.data = data;
			// view.reset(x, y, _player.y);
			// _mapView.addEnity(view);
			// }
		}

		/**
		public function checkAtk(hitData : N_HitData, view : EnityView) : Boolean {
		if (_state.isDead) {
		return false;
		}
		if (_state.isIgnore) {
		return false;
		}
		if (!hitData.checkHit(_block)) {
		return false;
		}
		if (hitData.owner.mode == N_HitMode.ONCE) {
		var index : int = view.state.hits.indexOf(this);
		if (index == -1) {
		view.state.hits.push(this);
		} else {
		return false;
		}
		}
		var career : N_CareerData;
		if (view is RoleView) {
		career = N_CareerData(view.enityData);
		} else if (view is BulletView) {
		career = N_CareerData(BulletData(view.enityData).owner);
		}
		var hitRate : int = career.prop.hitRate * 0.1 + 100 - _data.prop.evasion * 0.1 ;
		if (MathUtil.random(1, 100) > hitRate) {
		_missTip.moveTo(0, _player.y - 90);
		_missTip.miss();
		if (_ai != null) {
		_ai.onMiss();
		}
		return false;
		}
		checkDamage(hitData, career);
		return true;
		}

		public function checkDamage(hitData : N_HitData, career : N_CareerData) : void {
		var atk : int;
		var def : Number;
		var damage : int;
		if (hitData.owner.type == N_HitType.PHYSIC) {
		atk = career.prop.physicDamage * hitData.owner.percent * 0.01 + hitData.owner.fixed;
		def = _data.prop.physicDef / (career.level * 200 + _data.prop.physicDef);
		damage = atk * (1 - def) - _data.prop.constitution * 0.2 + MathUtil.random(0, 4) * MathUtil.random(0, 4);
		} else if (hitData.owner.type == N_HitType.MAGIC) {
		atk = career.prop.magicDamage * hitData.owner.percent * 0.01 + hitData.owner.fixed;
		def = _data.prop.magicDef / (career.level * 200 + _data.prop.magicDef);
		damage = atk * (1 - def) - _data.prop.mens * 0.2 + MathUtil.random(0, 4) * MathUtil.random(0, 4);
		}
		if (damage < 1) {
		damage = 1;
		}
		var rect : Rectangle = hitData.hitRect.intersection(_block.hitRect);
		var damage_x : int = rect.x + rect.width * 0.5 - x;
		var damage_y : int = rect.y + rect.height * 0.5 - y;
		_damageTip.addDamage(damage_x, _player.y - 60, damage);
		_data.hp = Math.max(0, _data.hp - damage);
		_blood_pb.value = _data.hp;
		_blood_pb.show();
		var className : String = (MathUtil.random(0, 1) == 0 ? "knock_small" : "knock_large");
		var list : BDList = BDUtil.getBDList(new AssetData(className, Common.ui001Lib.key));
		list.create(true, false);
		var playData : PlayData = new PlayData(66, [0, 0, 1, 2, 2]);
		var flipH : Boolean = hitData.flipH;
		if (hitData.same == 1) {
		flipH = !flipH;
		} else if (hitData.same == 2) {
		flipH = hitData.x > x;
		}
		_damageTip.addHit(damage_x, damage_y, !flipH, list, playData);
		SoundUtil.instance.playSound("gn_hit_sound", "sounds");
		if (_ai != null) {
		ai.onHit();
		}
		if (_isBoss) {
		dispatchEvent(new MonsterEvent(MonsterEvent.UPDATA_HP));
		}
		if (_data.hp == 0) {
		_state.isDead = true;
		}
		resetHit(hitData);
		}
		 * 
		 */
		// public function get monsterHeight() : uint {
		// return _player.list.getAt(0).bd.height;
		// }
		public function get combatHitDamage() : uint {
			return _combatHitDamage;
		}

		public function get wholeDamage() : uint {
			return _wholeDamage;
		}

		// public function get monsterID() : String {
		// return _data.guid;
		// }
		public function get centerY() : int {
			return y - _block.hitRect.height * 0.5;
		}

		public function get isBoss() : Boolean {
			return _isBoss;
		}
		//
		// override public function setActionBy(type : int) : void {
		// action = _data.monsterBase.getActionBy(type);
		// }
		//
		// override public function getActionBy(type : int) : BaseAction {
		// return _data.monsterBase.getActionBy(type);
		// }
	}
}

package com.demo.core.creature {
	import com.demo.core.data.CreatureData;
	import com.demo.core.RenderCall;
	import com.demo.core.Scene;
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.base.GBase;
	import com.demo.core.base.GBaseData;
	import com.demo.core.data.BlockData;
	import com.demo.core.render.FrameRender;
	import com.demo.frameworks.combat.ai.action.BaseAction;
	import com.demo.frameworks.combat.ai.core.AIEngine;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;

	/*
	 * 玩家,怪物,物品,子弹等视图基类
	 * 
	 * @author bright
	 * @version 20120423
	 */
	public class EnityView extends GBase {
		protected var _shadow : Sprite;
		protected var _shadow_bp : Bitmap;
		protected var _layer : Sprite;
		protected var _playerContainer : Sprite;
		protected var _player : BitmapAnimation;
		// protected var _blood_pb : GProgressBar;
		// protected var _name_lb : GLabel;
		// protected var _damageTip : DamageTip;
		// protected var _missTip : MissTip;
		protected var _mapView : Scene;
		protected var _actionType : uint;
		protected var _action : BaseAction;
		// protected var _enityData : EnityData;
		protected var _state : EnityState;
		protected var _ai : AIEngine;
		// protected var _move : Move3d;
		protected var _drops : Array;
		protected var _shock_rc : RenderCall;
		protected var _effects : Array;
		protected var _block : BlockData;
		protected var _stats : TextField;
		protected var _data : CreatureData;

		override protected function create() : void {
			_shadow = new Sprite();
			_shadow.mouseEnabled = _shadow.mouseChildren = false;
			_shadow_bp = new Bitmap();
			_shadow_bp.alpha = 0.5;
			_shadow.addChild(_shadow_bp);
			addChild(_shadow);
			_layer = new Sprite();
			_layer.mouseEnabled = _layer.mouseChildren = false;
			_playerContainer = new Sprite();
			_playerContainer.mouseEnabled = _playerContainer.mouseChildren = false;
			addChild(_layer);
			_player = new BitmapAnimation(null, true);

			_layer.addChild(_playerContainer);
			// _player.setFrames(ImageModel.createFrameDatas(idle));
			// _player = new BDPlayer();
			// _player.shadow = _shadow_bp;
			// _layer.addChild(_player);

			_stats = new TextField();
			_stats.mouseEnabled = false;
			_stats.width = 55;
			_stats.height = 20;
			_layer.addChild(_stats);
		}

		protected function checkShock() : void {
			var count : int = _shock_rc.count;
			if (count > 8) {
				FrameRender.instance.remove(_shock_rc);
				_player.x = 0;
			}
			// _player.x = (count % 2 == 0 ? (_player.flipH ? -4 : 4) : 0);
		}

		public function EnityView(base : GBaseData) {
			super(base);
			_state = new EnityState();
			// _move = new Move3d();
			_effects = new Array();
			_drops = new Array();
			_shock_rc = new RenderCall(checkShock);
		}

		// public function get enityData() : EnityData {
		// return _enityData;
		// }
		public function get block() : BlockData {
			return _block;
		}

		// public function get name_lb() : GLabel {
		// return _name_lb;
		// }
		public function set mapView(value : Scene) : void {
			_mapView = value;
		}

		public function get mapView() : Scene {
			return _mapView;
		}

		public function get player() : BitmapAnimation {
			return _player;
		}

		public function get shadow() : Sprite {
			return _shadow;
		}

		public function set flipH(value : Boolean) : void {
			_player.flipH = value;
			// _player.flipH = value;
			// _block.flipH = value;
		}

		// public function get flipH() : Boolean {
		// return _player.flipH;
		// }
		public function get state() : EnityState {
			return _state;
		}

		public function stopMove() : void {
		}

		public function restore() : void {
		}

		public function dead() : void {
		}

		public function set ai(value : AIEngine) : void {
			_ai = value;
		}

		public function get ai() : AIEngine {
			return _ai;
		}

		// public function showFace(key : String) : void {
		// var list : BDList = BDUtil.getBDList(new AssetData(key, "faces"));
		// if (list != null) {
		// _face_bp.list = list;
		// _face_bp.moveTo(_player.list.getAt(0).offsetX, _player.list.getAt(0).offsetY - _face_bp.list.maxHeight);
		// _face_bp.show();
		// _face_bp.play(33, null, 1);
		// }
		// }
		public function offsetTo(dx : int, dy : int) : Boolean {
			_block.moveTo(x, y);
			_mapView.checkHit(_block, dx, dy);
			if (x != _block.x || y != _block.y) {
				x = _block.x;
				y = _block.y;
				_mapView.depthSort.reset(this);
				return true;
			}
			return false;
		}

		public function set high(value : int) : void {
			trace("high:", value);
			_player.y = value + _player.yOffset;
			_block.z = value;
			_shadow.y = Math.round(value * 0.1);
		}

		// public function get move() : Move3d {
		// return _move;
		// }
		// public function setActionBy(type : int) : void {
		// type;
		// }
		//
		// public function getActionBy(type : int) : BaseAction {
		// type;
		// return null;
		// }
		//
		public function set actionType(value : uint) : void {
			

			// _player.playBy(_action);
		}

		public function set action(value : BaseAction) : void {
			if (value == _action || (_action != null && _action.type == value.type))
				return;
			_action = value;
			actionType = value.type;
			// _player.playBy(_action);
		}

		//
		// public function get action() : BaseAction {
		// return _action;
		// }
		/**
		public function resetHit(hitData : N_HitData) : void {
		// 被击终止招连
		_state.linkAction = null;
		if (_state.isBrave) {
		return;
		}
		var dist : int = hitData.owner.dist * (MathUtil.random(90, 110) * 0.01);
		if (dist > 0) {
		dist += _enityData.base.fixedDist;
		if (dist < 0) {
		dist = 0;
		}
		}
		var flipH : Boolean = hitData.flipH;
		if (hitData.same == 1) {
		flipH = !flipH;
		} else if (hitData.same == 2) {
		flipH = hitData.x > x;
		}
		if (flipH) {
		dist = -dist;
		}
		var high : int = hitData.owner.high * (MathUtil.random(90, 110) * 0.01) ;
		if (high > 0) {
		high += _enityData.base.fixedHigh;
		if (high < 0) {
		high = 0;
		}
		}
		var wait : int = _enityData.base.hitWait;
		var airAction : AirAction = AirAction(getActionBy(N_ActionType.AIR));
		var dropAction : DropAction = DropAction(getActionBy(N_ActionType.DROP));
		if (_player.y < 0) {
		if (high > 0) {
		if (airAction != null) {
		_move.moveX.init(x, dist, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveY.init(y, 0, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveZ.init(_player.y, _player.y - high, _enityData.base.airSpeedZ, MoveMode.AIR);
		_move.reset(wait);
		airAction.resetFrames(_move.upT, _move.dropT, wait);
		action = airAction;
		return;
		}
		}
		_move.moveX.init(x, dist * 0.5, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveY.init(y, 0, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveZ.init(_player.y, 0, _enityData.base.airSpeedZ, MoveMode.AIR);
		_move.reset(wait);
		dropAction.resetFrames(_move.total, wait);
		action = dropAction;
		return;
		}
		if (high > 0) {
		if (airAction != null) {
		_move.moveX.init(x, dist, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveY.init(y, 0, _enityData.base.airSpeedX, MoveMode.SUB);
		_move.moveZ.init(_player.y, -high, _enityData.base.airSpeedZ, MoveMode.AIR);
		_move.reset(wait);
		airAction.resetFrames(_move.upT, _move.dropT, wait);
		action = airAction;
		return;
		}
		}
		_move.moveX.init(x, dist, _enityData.base.backSpeed, MoveMode.SUB);
		_move.moveY.init(y, 0, _enityData.base.backSpeed, MoveMode.SUB);
		_move.moveZ.init(0, 0, _enityData.base.airSpeedZ, MoveMode.AIR);
		_move.reset(wait);
		var backAction : BackAction = BackAction(getActionBy(N_ActionType.BACK));
		backAction.resetFrames(_move.total, wait);
		action = backAction;
		}
		 **/
		public function startShock() : void {
			_shock_rc.reset();
			FrameRender.instance.add(_shock_rc);
		}

		public function set wait(value : int) : void {
			// _player.wait = value;
			// for each (var bp:BDPlayer in _effects) {
			// bp.wait = value;
			// }
		}

		public function get actionType() : uint {
			return _actionType;
		}

		public function get action() : BaseAction {
			return _action;
		}

		public function get data() : CreatureData {
			return _data;
		}

		public function set data(data : CreatureData) : void {
			_data = data;
		}
	}
}

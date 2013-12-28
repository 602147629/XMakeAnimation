package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityState;
	import com.demo.core.creature.EnityView;
	import com.demo.core.data.PlayData;

	/**
	 * 动作基类
	 * 
	 * @author bright
	 * @version 20120530
	 */
	public class BaseAction extends PlayData {
		protected var _name : String;
		protected var _type : int;
		protected var _isForce : Boolean;
		protected var _braveStart : int;
		protected var _braveEnd : int;
		protected var _ignoreStart : int;
		protected var _ignoreEnd : int;
		protected var _ghostStart : int;
		protected var _ghostEnd : int;
		protected var _effectIds : Array;
		protected var _debug : Boolean;
		protected var _libs : Array;

		protected function onChange(value : BitmapAnimation) : void {
		}

		protected function checkIgnore(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : EnityView = EnityView(value.parent.parent.parent);
			if (current == _ignoreStart) {
				value.filters = [EnityState.IGNORE_FILTER];
				view.state.isIgnore = true;
			} else if (current == _ignoreEnd) {
				value.filters = [];
				view.state.isIgnore = false;
			}
		}

		protected function checkEffect(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			var view : EnityView = EnityView(value.parent.parent.parent);
			if (_effectIds == null) {
				return;
			}
//			var effect : EffectData;
//			for each (var effectId:int in _effectIds) {
//				effect = EffectList.getBy(effectId);
//				if (current == effect.start) {
//					view.addEffect(effect);
//				}
//			}
		}

		protected function checkGhost(value : BitmapAnimation) : void {
			var current : int = value.currentFrame;
			if (current < _ghostStart || current > _ghostEnd) {
				return;
			}
			if ((current - _ghostStart) % 3 == 1) {
				var view : EnityView = EnityView(value.parent.parent.parent);
//				var ghost : Ghost = Ghost(Ghost.pool.borrowObj());
//				ghost.reset(view.x, view.y, value.y, value.unit);
//				view.mapView.depthSort.add(ghost);
			}
		}

		public function BaseAction() {
			super();
			_type = N_ActionType.NONE;
			_debug = false;
			_libs = new Array();
		}

		public function get name() : String {
			return _name;
		}

		public function get type() : int {
			return _type;
		}

		public function get libs() : Array {
			return _libs;
		}

		public function get isForce() : Boolean {
			return _isForce;
		}

		public function reset(view : EnityView) : void {
			view.state.isBrave = false;
			view.state.isIgnore = false;
			view.state.nextType = -1;
			view.player.filters = [];
		}

		public function end(view : EnityView) : void {
		}

		public function debug(view : EnityView) : void {
			view;
			_debug = true;
		}

		override public function parseObj(value : Object) : void {
			super.parseObj(value);
			_name = value.name;
			_type = N_ActionType.getType(_name);
			switch(_type) {
				case N_ActionType.BREATHE:
					_loop = 0;
					break;
				case N_ActionType.COMBAT_BREATHE:
					_loop = 0;
					break;
				case N_ActionType.WALK:
					_loop = 0;
					break;
				case N_ActionType.RUN:
					_loop = 0;
					break;
				case N_ActionType.FLY:
					_loop = 0;
					break;
			}
			_isForce = (value.isForce != null ? value.isForce : true);
			_braveStart = (value.braveStart != null ? value.braveStart : -1);
			_braveEnd = (value.braveEnd != null ? value.braveEnd : -1);
			_ghostStart = (value.ghostStart != null ? value.ghostStart : -1);
			_ghostEnd = (value.ghostEnd != null ? value.ghostEnd : -1);
			_effectIds = (value.effectIds != null ? value.effectIds : null);
		}
	}
}

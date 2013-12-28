package com.demo.core.data {
	import com.demo.frameworks.combat.ai.action.ActionAtk;
	import com.demo.frameworks.combat.ai.action.BaseAction;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * @author flashpf
	 */
	public class CreatureData {
		protected var _id : int;
		protected var _name : String;
		protected var _halfW : int;
		protected var _halfH : int;
		protected var _source : Rectangle;
		protected var _fixedDist : int;
		protected var _fixedHigh : int;
		protected var _backSpeed : int;
		protected var _airSpeedX : int;
		protected var _airSpeedZ : int;
		protected var _hitWait : int;
		protected var _key : String;
		protected var _lib : String;
		// protected var _list : BDList;
		protected var _actions : Dictionary;
		protected var _atks : Array;
		protected var _height : int;
		protected var _libs : Array;
		protected var _type : int;

		public function CreatureData() {
			_actions = new Dictionary();
			_atks = new Array();
			_libs = new Array();
		}

		public function get id() : int {
			return _id;
		}

		public function get name() : String {
			return _name;
		}

		public function get halfW() : int {
			return _halfW;
		}

		public function get halfH() : int {
			return _halfH;
		}

		public function get source() : Rectangle {
			return _source;
		}

		public function get fixedDist() : int {
			return _fixedDist;
		}

		public function get fixedHigh() : int {
			return _fixedHigh;
		}

		public function get backSpeed() : int {
			return _backSpeed;
		}

		public function set id(newId : int) : void {
			_id = newId;
		}

		public function get airSpeedX() : int {
			return _airSpeedX;
		}

		public function get airSpeedZ() : int {
			return _airSpeedZ;
		}

		public function get hitWait() : int {
			return _hitWait;
		}

		public function get libs() : Array {
			return _libs;
		}

		public function canAtk(atks : Array, dx : int, dy : int) : void {
			atks.splice(0);
			for each (var atk:ActionAtk in _atks) {
				if (atk.atAtkRange(dx, dy)) {
					atks.push(atk);
				}
			}
		}

		public function atAtkRange(dx : int, dy : int) : Boolean {
			for each (var atk:ActionAtk in _atks) {
				if (atk.atAtkRange(dx, dy)) {
					return true;
				}
			}
			return false;
		}

		public function render() : void {
		}

		public function addAction(value : BaseAction) : void {
			_actions[value.type] = value;
			if (value is ActionAtk) {
				_atks.push(value);
			}
			// GArrayUtil.copyUnique(_libs, value.libs);
		}

		public function getActionBy(value : int) : BaseAction {
			return _actions[value];
		}

		public function get actions() : Dictionary {
			return _actions;
		}

		public function getAtkAt(value : int) : BaseAction {
			return _atks[value];
		}

		public function get atks() : Array {
			return _atks;
		}

		public function getActionNames() : Array {
			var names : Array = new Array();
			for each (var action:BaseAction in _actions) {
				names.push(action.name);
			}
			return names;
		}

		public function parseObj(value : Object) : void {
			_id = value.id;
			_name = value.name;
			_halfW = (value.halfW != null ? value.halfW : 0);
			_halfH = (value.halfH != null ? value.halfH : 0);
			if (value.source != null) {
				_source = new Rectangle(value.source.x, value.source.y, value.source.width, value.source.height);
			}
		}

		public function set halfW(halfW : int) : void {
			_halfW = halfW;
		}

		public function set halfH(halfH : int) : void {
			_halfH = halfH;
		}

		public function set source(source : Rectangle) : void {
			_source = source;
		}

		public function set atks(atks : Array) : void {
			_atks = atks;
		}

		public function get type() : int {
			return _type;
		}

		public function set type(type : int) : void {
			_type = type;
		}
	}
}

package com.demo.core {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.ui.Keyboard;

	/**
	 * 按键设置
	 * 
	 * @author bright
	 * @version 20110919
	 */
	public class KeySets extends EventDispatcher {
		public static const MODE_CHANGE : String = "modeChange";
		public static const RIGHT_MOVE : int = 0;
		public static const LEFT_MOVE : int = 1;
		public static const DEFINE : int = 2;
		public var upKey : uint;
		public var downKey : uint;
		public var leftKey : uint;
		public var rightKey : int;
		public var attackKey : int;
		public var jumpKey : int;
		public var skillKey : int;
		public var skill_0 : int;
		public var skill_1 : int;
		public var skill_2 : int;
		public var skill_3 : int;
		public var skill_4 : int;
		public var use_0 : int;
		public var use_1 : int;
		public var use_2 : int;
		public var use_3 : int;
		public var use_4 : int;
		private var _mode : int;
		private var _moveKeyArray : Array;
		private var _allKeyArray : Array;
		private var _leftMoveArray : Array = ["Y", "U", "I", "O", "P"];
		private var _rightMoveArray : Array = ["A", "S", "D", "F", "G"];
		public var esc : uint = Keyboard.ESCAPE;
		private static var _frist : Boolean = false;

		public function KeySets() {
			_mode = -1;
			_moveKeyArray = new Array();
			_allKeyArray = new Array();
			reset(LEFT_MOVE);
		}

		public function reset(mode : int) : void {
			if (_mode == mode) {
				return;
			}
			_mode = mode;
			_moveKeyArray = new Array();
			_allKeyArray = new Array();
//			var cells : Array = Common.controlView.cells;
			switch(_mode) {
				case RIGHT_MOVE:
					upKey = Keyboard.UP;
					downKey = Keyboard.DOWN;
					leftKey = Keyboard.LEFT;
					rightKey = Keyboard.RIGHT;
					attackKey = Keyboard.X;
					jumpKey = Keyboard.C;
					skillKey = Keyboard.Z;
					skill_0 = Keyboard.A;
					skill_1 = Keyboard.S;
					skill_2 = Keyboard.D;
					skill_3 = Keyboard.F;
					skill_4 = Keyboard.G;
//					for (var i : int = 0; i < _rightMoveArray.length; i++) {
//						SkillCell(cells[i + 5]).typeText = _rightMoveArray[i];
//					}
					break;
				case LEFT_MOVE:
					upKey = Keyboard.W;
					downKey = Keyboard.S;
					leftKey = Keyboard.A;
					rightKey = Keyboard.D;
					attackKey = Keyboard.J;
					jumpKey = Keyboard.K;
					skillKey = Keyboard.L;
					skill_0 = Keyboard.Y;
					skill_1 = Keyboard.U;
					skill_2 = Keyboard.I;
					skill_3 = Keyboard.O;
					skill_4 = Keyboard.P;
//					for (var j : int = 0; j < _leftMoveArray.length; j++) {
//						SkillCell(cells[j + 5]).typeText = _leftMoveArray[j];
//					}
					break;
			}
			use_0 = Keyboard.NUMBER_1;
			use_1 = Keyboard.NUMBER_2;
			use_2 = Keyboard.NUMBER_3;
			use_3 = Keyboard.NUMBER_4;
			use_4 = Keyboard.NUMBER_5;
			initKeyArray();
			dispatchEvent(new Event(MODE_CHANGE));
		}

		private function initKeyArray() : void {
			_moveKeyArray.push(upKey);
			_moveKeyArray.push(downKey);
			_moveKeyArray.push(leftKey);
			_moveKeyArray.push(rightKey);
			_moveKeyArray.push(jumpKey);

			_allKeyArray.push(upKey);
			_allKeyArray.push(downKey);
			_allKeyArray.push(leftKey);
			_allKeyArray.push(rightKey);
			_allKeyArray.push(jumpKey);
			_allKeyArray.push(attackKey);
			_allKeyArray.push(skillKey);
			_allKeyArray.push(skill_0);
			_allKeyArray.push(skill_1);
			_allKeyArray.push(skill_2);
			_allKeyArray.push(skill_3);
			_allKeyArray.push(skill_4);

			_allKeyArray.push(use_0);
			_allKeyArray.push(use_1);
			_allKeyArray.push(use_2);
			_allKeyArray.push(use_3);
			_allKeyArray.push(use_4);
		}

		public function get mode() : int {
			return _mode;
		}

		public function get moveKeyArray() : Array {
			return _moveKeyArray;
		}

		public function get allKeyArray() : Array {
			return _allKeyArray;
		}
	}
}

package com.demo.core.creature {
	import flash.filters.GlowFilter;

	/**
	 * @author bright
	 */
	public class EnityState {
		public static const BRAVE_FILTER : GlowFilter = new GlowFilter(0xFFFF00, 1, 2, 2, 17, 1, false, false);
		public static const IGNORE_FILTER : GlowFilter = new GlowFilter(0xFFFFFF, 1, 2, 2, 17, 1, false, false);
		public static const SELF_EXPLODE_FILTER:GlowFilter=new GlowFilter(0xFF0000, 0.7, 10, 10, 2, 1, true, false);
		public var place : int;
		public var isDead : Boolean;
		public var isUp : Boolean;
		public var isDown : Boolean;
		public var isLeft : Boolean;
		public var isRight : Boolean;
		public var firstUp : Boolean;
		public var firstLeft : Boolean;
		public var isRun : Boolean;
		public var canFlipH : Boolean;
		public var canMove : Boolean;
		public var hitFrame : int;
		public var nextType : int;
		public var linkNext : int;
		public var devilNext : int;
		public var isBrave : Boolean;
		public var isIgnore : Boolean;
		public var suckedT : EnityView;
		public var stoneType : int;
		// public var linkAction : LinkAction;
		protected var _hits : Array;

		public function EnityState() {
			reset();
			_hits = new Array();
		}

		public function reset() : void {
			isDead = false;
			isRun = false;
			canFlipH = true;
			canMove = true;
			nextType = -1;
			linkNext = -1;
			devilNext = -1;
			stoneType = 0;
		}

		public function get isMove() : Boolean {
			return isLeft || isRight || isUp || isDown;
		}

		public function getMoveFlipH(flipH : Boolean) : Boolean {
			if (firstLeft) {
				if (isLeft) {
					return true;
				} else if (isRight) {
					return false;
				}
			} else {
				if (isRight) {
					return false;
				} else if (isLeft) {
					return true;
				}
			}
			return flipH;
		}

		public function get hits() : Array {
			return _hits;
		}
	}
}
package com.demo.frameworks.combat.ai.core {
	import com.demo.core.creature.EnityView;
	import com.demo.frameworks.combat.ai.behavior.AIBehavior;
	import com.demo.frameworks.combat.ai.behavior.AtkBehavior;
	import com.demo.frameworks.combat.ai.behavior.FleeBehavior;
	import com.demo.frameworks.combat.ai.behavior.MoveBehavior;
	import com.demo.frameworks.combat.ai.behavior.SeekBehavior;
	import com.demo.frameworks.combat.ai.behavior.WaitBehavior;
	import com.demo.frameworks.combat.ai.data.AIData;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * AI引擎
	 * 
	 * @author bright
	 * @version 20120612
	 */
	public class AIEngine {
		protected var _view : EnityView;
		protected var _current : AIBehavior;
		protected var _atk : AtkBehavior;
		protected var _seek : SeekBehavior;
		protected var _move : MoveBehavior;
		protected var _wait : WaitBehavior;
		protected var _flee : FleeBehavior;
		protected var _pause : Boolean;
		protected var _restFaces : Array;
		protected var _state_tf : TextField;
		protected var _atks : Array;
		protected var _data : AIData;

		protected function showState(value : AIBehavior) : void {
			_state_tf.text = value.name;
			_state_tf.textColor = value.color;
			_state_tf.x = - _state_tf.width * 0.5;
		}

		public function AIEngine(value : EnityView) {
			_view = value;
			var format : TextFormat = new TextFormat();
			format.size = 14;
			format.color = 0xffffff;
			_state_tf = new TextField();
			_state_tf.mouseEnabled = false;
			_state_tf.width = 55;
			_state_tf.height = 20;
			_pause = false;
			if (_view != null) {
				_view.addChild(_state_tf);
			}
			_restFaces = ["find_001", "find_002", "hit_001"];
			_wait = new WaitBehavior(_view);
			_move = new MoveBehavior(_view);
			_atk = new AtkBehavior(_view);
			_seek = new SeekBehavior(_view);
			_flee = new FleeBehavior(_view);
			_atks = new Array();
			_data = new AIData();
		}

		public function reset(hard : int) : void {
		}

		public function think() : void {
		}

		public function set pause(value : Boolean) : void {
			_pause = value;
		}

		public function get pause() : Boolean {
			return _pause;
		}

		public function get current() : AIBehavior {
			return _current;
		}

		/**
		 * 当MISS时
		 */
		public function onMiss() : void {
		}

		/**
		 * 当攻击结束时
		 */
		public function onAttackEnd() : void {
			if (_current == _atk) {
				_current.end();
			}
		}

		/**
		 * 当被击退结束时
		 */
		public function onBackEnd() : void {
		}

		/**
		 * 当站立结束时
		 */
		public function onStandEnd() : void {
		}

		/**
		 * 被击中
		 */
		public function onHit() : void {
			_pause = true;
			_current.end();
			_state_tf.text = "被打";
			_state_tf.textColor = 0xcccccc;
		}

		/**
		 * 被打死
		 */
		public function onDead() : void {
			_pause = true;
			_current.end();
			_state_tf.text = "死亡";
			_state_tf.textColor = 0xcccccc;
		}

		public function dispose() : void {
		}

		public function toString() : String {
			return "pause:" + _pause + ",current:" + (_current != null ? _current.name : "none");
		}
	}
}

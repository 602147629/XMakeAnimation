package com.demo.frameworks.combat.ai.action {
	import com.demo.core.animation.BitmapAnimation;
	import com.demo.core.creature.EnityView;

	/**
	 * 连招动作
	 * 
	 * @author bright
	 * @version 20120624
	 */
	public final class LinkAction {
		private var _id : int;
		private var _name : String;
		private var _index : int;
		private var _list : Array;

		protected function onComplete(value : BitmapAnimation) : void {
			var view : EnityView = EnityView(value.parent.parent);
			_index++;
			if (_index < _list.length) {
				next(view);
			} else {
//				view.action.end(view);
//				view.state.linkAction = null;
			}
		}

		protected function next(view : EnityView) : void {
			var type : int = _list[_index];
//			var action : BaseAction = view.getActionBy(type);
//			if (view.action != action) {
//				view.action = action;
//			} else {
//				action.reset(view);
//				view.player.playBy(action);
//			}
//			view.player.onComplete = onComplete;
		}

		public function LinkAction() : void {
		}

		public function get id() : int {
			return _id;
		}

		public function start(view : EnityView) : void {
//			if (view.state.linkAction != null) {
//				return;
//			}
//			view.state.linkAction = this;
//			_index = 0;
//			next(view);
		}

		public function parseObj(value : Object) : void {
			_id = value.id;
			_name = value.name;
			_list = new Array();
			for each (var name:String in value.names) {
				_list.push(N_ActionType.getType(name));
			}
		}
	}
}

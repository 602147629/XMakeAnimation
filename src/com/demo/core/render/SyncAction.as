package com.demo.core.render {
	import com.demo.core.IFrame;
	import com.demo.core.creature.RoleView;

	/**
	 * 同步动作
	 * 
	 * @author bright
	 * @version 20111205
	 */
	public class SyncAction implements IFrame{
		protected var _type : int;
		protected var _view : RoleView;
		protected var _isEnd : Boolean;

		public function SyncAction() {
			_isEnd = false;
		}

		public function get type() : int {
			return _type;
		}

		public function set view(value : RoleView) : void {
			_view = value;
		}

		public function get isEnd() : Boolean {
			return _isEnd;
		}
		
		public function stop():void{
			FrameRender.instance.remove(this);
		}

		public function refresh() : void {
		}
	}
}

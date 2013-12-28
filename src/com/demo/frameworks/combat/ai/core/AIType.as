package com.demo.frameworks.combat.ai.core {
	/**
	 * AI类型
	 * 
	 * @author bright
	 * @version 20120418
	 */
	public class AIType {
		private static const _list : Array = ["漫游者", "追捕者"];
		public static const NONE : int = -1;
		public static const WANDER : int = 0;
		public static const PURSUER : int = 1;

		public static function getType(value : String) : int {
			return _list.indexOf(value);
		}
	}
}

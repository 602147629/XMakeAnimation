package com.demo.frameworks.combat.ai.core {
	import com.demo.core.creature.EnityView;

	/**
	 * @author flashpf
	 */
	public class EmptyAI extends AIEngine {
		public function EmptyAI(value : EnityView) {
			super(value);
			_pause = true;
		}
		
		override public function onAttackEnd() : void {
		}

		override public function onHit() : void {
		}
		
		override public function onDead() : void {
		}
	}
}

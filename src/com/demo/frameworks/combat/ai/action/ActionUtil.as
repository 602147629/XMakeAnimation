package com.demo.frameworks.combat.ai.action {
	import com.demo.define.N_SkillType;

	/**
	 * @author flashpf
	 */
	public class ActionUtil {
		public static function create(item : Object, mode : int) : BaseAction {
			var type : int = N_ActionType.getType(item.name);
			var action : BaseAction;
			switch(type) {
				case N_ActionType.LINK_0:
					action = new LinkAtk();
					break;
				case N_ActionType.LINK_1:
					action = new LinkAtk();
					break;
				case N_ActionType.LINK_2:
					action = new LinkAtk();
					break;
				case N_ActionType.JUMP_ATK:
					action = new JumpAtk();
					break;
				case N_ActionType.BACK:
					action = new BackAction();
					break;
				case N_ActionType.AIR:
					action = new AirAction();
					break;
				case N_ActionType.DROP:
					action = new DropAction();
					break;
				case N_ActionType.BOUNCE:
					action = new BounceAction();
					break;
				case N_ActionType.STAND:
					action = new StandAction();
					break;
				case N_ActionType.SUCKED:
					action = new SuckedAction();
					break;
				case N_ActionType.RUN_ATK:
					action = new RunAtk();
					break;
				case N_ActionType.ATK:
					action = new ActionAtk();
					break;
				case N_ActionType.ROLL_ATK:
					action = new RollAtk();
					break;
//				case N_ActionType.SHOOT:
//					action = new ShootAtk();
//					break;
				case N_ActionType.DEAD:
					action = new DeadAction();
					break;
				case N_ActionType.DASH:
					action = new DashAtk();
					break;
				case N_ActionType.ATK_FLOOR:
					action = new AtkFloor();
					break;
				case N_ActionType.SELF_EXPLODE:
					action = new SelfExplode();
					break;
				case N_SkillType.BACK_JUMP:
					action = new BackJump();
					break;
				case N_SkillType.BLOODLUST:
					action = new Bloodlust();
					break;
				case N_SkillType.IN_DEVIL_ESCRIME:
					action = new LinkAtk();
					break;
				case N_SkillType.IN_DEVIL_ESCRIME_1:
					action = new LinkAtk();
					break;
				case N_SkillType.IN_DEVIL_ESCRIME_2:
					action = new LinkAtk();
					break;
				case N_SkillType.IN_DEVIL_ESCRIME_3:
					action = new LinkAtk();
					break;
				case N_SkillType.HILL_BREAKER:
					action = new HillBreaker();
					break;
				default:
					if (mode == 1) {
						action = new ActionAtk();
					} else if (mode == 2) {
//						action = new ShootAtk();
					} else {
						action = new BaseAction();
					}
					break;
			}
			action.parseObj(item);
			return action;
		}
	}
}

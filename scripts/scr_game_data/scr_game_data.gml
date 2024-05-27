// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

randomize()

//Action Library
global.actionLibrary = 
{
	attack :
	{
		name: "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation: "attack",
		effectSprite : spr_attack_bonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			battle_change_hp(_targets[0], -_damage, 0);
			//with (_targets[0]) hp = max(0, hp - _damage);
		}
	},
	
	fireball :
	{
		name: "Fire",
		description : "{0} throws a fireball!",
		subMenu : "Magic",
		mpCost: 4,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation: "fireball",
		effectSprite : spr_attack_fireball,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = irandom_range(10,15)
			battle_change_hp(_targets[0], -_damage, 0);
			//battle_change_mp(_user, -mpCost)
		}
	}
		
}		
		
		
enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}


global.party=
[
	{
		name: "Fructose",
		hp: 30,
		hpMax: 30,
		strength : 6,
		sprites : { idle: spr_player_down, downed: spr_player_downed },	
		actions : [global.actionLibrary.attack]
	}
	,
	{
		name: "Maize",
		hp: 30,
		hpMax: 30,
		strength: 4,
		sprites : { idle: spr_player_down,downed: spr_player_downed },
		actions : [global.actionLibrary.attack, global.actionLibrary.fireball]
	}


];

global.enemies =
{
	slimeG:
	{
		name: "Slime",
		hp: 30,
		hpMax: 30,
		strength: 2,
		sprites : { idle: spr_enemy1, downed: spr_enemy1_downed },
		actions: [global.actionLibrary.attack],
		AIscript: function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
}
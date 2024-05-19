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
		sprites : { idle: spr_player_down }
	}
	,
	{
		name: "Maize",
		hp: 30,
		hpMax: 30,
		strength: 4,
		sprites : { idle: spr_player_down }
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
		sprites : { idle: spr_enemy1 }
	}
}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

randomize() //RANDOMISE


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
		targetAll : MODE.VARIES,//MODE.VARIES,//MODE.NEVER,
		userAnimation: "fireball",
		effectSprite : spr_attack_fireball,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(15,200); //,20
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75); //Reduces damage in varies mode where all selected
				battle_change_hp(_targets[i], -_damage);
			}
			//Check MP before attack damage, then change mp or not use attack and give message (or line 88 on obj_battle create event)
			//battle_change_mp(_user, -mpCost) //MP cost yet unimplemented
			
			
			//var _damage = irandom_range(10,15)
			//battle_change_hp(_targets[0], -_damage, 0);
			//battle_change_mp(_user, -mpCost)
		}
	},
	
	slash :
	{
		name: "Slash",
		description : "{0} swipes!",
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
	
	swipe :
	{
		name: "Swipe",
		description : "{0} slashes!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.ALWAYS,
		userAnimation: "attack",
		effectSprite : spr_attack_bonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{			
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				battle_change_hp(_targets[i], -_damage);
			}
		}
	}
		
}		
		
		
enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}






function random_part_set() {
	var head_index = irandom(2); // 0 to 2
	var torso_index = irandom(2);
	var legs_index = irandom(2);
	
	return {
		head: asset_get_index("spr_head_" + string(head_index + 1)),
		torso: asset_get_index("spr_torso_" + string(torso_index + 1)),
		legs: asset_get_index("spr_legs_" + string(legs_index + 1))
	};
}















global.party=
[
	{
		name: "Fructose",
		hp: 30,
		hpMax: 30,
		strength : 6,
		sprites : random_part_set(),		//TEST THIS #todo
		actions : [global.actionLibrary.attack, global.actionLibrary.swipe, global.actionLibrary.fireball]
		//Add another attribute for which sprites are randomly selected
	}
	,
	{
		name: "Maize",
		hp: 30,
		hpMax: 30,
		strength: 4,
		sprites : { head : spr_head_3, torso : spr_torso_2, legs : spr_legs_2 },	
		actions : [global.actionLibrary.attack, global.actionLibrary.fireball, global.actionLibrary.slash, global.actionLibrary.swipe]
	}
	,
	{
		name: "Buttermilk",
		hp: 30,
		hpMax: 30,
		strength: 6,
		sprites : { head : spr_head_1, torso : spr_torso_2, legs : spr_legs_1 },	
		actions : [global.actionLibrary.attack, global.actionLibrary.fireball, global.actionLibrary.slash, global.actionLibrary.swipe]
	}
	,
	{
		name: "Wheaty",
		hp: 30,
		hpMax: 30,
		strength: 4,
		sprites : { head : spr_head_2, torso : spr_torso_2, legs : spr_legs_1 },	
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
		strength: 2,//2,
		sprites : { head : spr_head_1, torso : spr_torso_2, legs : spr_legs_3 },	
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
	},
	
	skeleton:
	{
		name: "Skeleton",
		hp: 30,
		hpMax: 30,
		strength: 2,//2,
		sprites : { head : spr_head_1, torso : spr_torso_2, legs : spr_legs_3 },	
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
	},
	
	mergedenemy:
	{
		name: "Merged enemy",
		hp: 30,
		hpMax: 30,
		strength: 2,//2,
		sprites : { head : spr_head_1, torso : spr_torso_2, legs : spr_legs_3 },	
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
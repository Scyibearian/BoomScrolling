instance_deactivate_all(true);

units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

//enemies = [];

//Make enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+250+(i*10), y+68+(i*20), depth-10, obj_battle_unit_enemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+70+(i*10), y+68+(i*15), depth-10, obj_battle_unit_pc, global.party[i]);
	array_push(units, partyUnits[i]);
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();
		

function BattleStateSelectAction()
{
	//Get current unit
	var _unit = unitTurnOrder[turn]; //untTurnOrder causes array expected error
	
	//is the unit dead or unable to act?
	if (!instance_exists(_unit)) || (_unit.hp <= 0)
	{
		battleState = BattleStateVictoryCheck;
		exit;
	}
	
	//Select an action to peform
	//BeginAction(_unit.id, global.actionLibrary.attack, _unit.id);	
	
	//if unit is player controled:
	if (_unit.object_index == obj_battle_unit_pc)
	{
		//attack random party member
		var _action = global.actionLibrary.attack;
		var _possibleTargets = array_filter(obj_battle.enemyUnits, function(_unit, _index)
		{
			return (_unit.hp > 0);
		});
		var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
		BeginAction(_unit.id, _action, _target);
	}
	else
	{
		//if unit is AI controlled:
		var _enemyAction = _unit.AIscript();
		if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
	}
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (_user)
	{
		acting = true;
		//Play user animation if it is defined for that action and that user
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	battleState = BattleStatePerformAction;
	
	
}

function BattleStatePerformAction()
{
	
	//if animation etc is still playing
	if (currentUser.acting)
	{
		//When it ends, perform action effect if it exists
		if (currentUser.image_index >= currentUser.image_number -1)
		{
			with(currentUser)
			{
			sprite_index = sprites.idle;
			image_index = 0;
			acting = false;
			}
			
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) || ( (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1) )
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth-1,obj_battle_effect,{sprite_index : currentAction.effectSprite});
					}
				}
				else //play it at 0,0
				{
					var _effectSprite = currentAction.effectSprite;
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x,y,depth-100,oBattleEffect,{sprite_index : _effectSprite});
				}
			}
			currentAction.func(currentUser, currentTargets);
		}
	}
	else
	{
		if (!instance_exists(obj_battle_effect))
		{
			battleWaitTimeRemaining--
			if (battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
			
}


function BattleStateVictoryCheck()
{
	battleState = BattleStateTurnProgression; //Currently battle going infinitely
}

function BattleStateTurnProgression()
{
	turnCount++;
	turn++;
	//Loop turns
	if (turn >array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;


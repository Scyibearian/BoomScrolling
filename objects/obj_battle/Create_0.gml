instance_deactivate_all(true);

units = [];

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
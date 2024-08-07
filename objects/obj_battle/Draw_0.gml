draw_sprite(battleBackground,0,x,y);

//Draw units in depth order
var unitWithCurrentTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		draw_self();
	}
}


//Draw UI boxes
draw_sprite_stretched(spr_box,0,x+76,y+120,210,60);
draw_sprite_stretched(spr_box,0,x+1,y+120,73,60);


//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
//#macro COLUMN_MP 220

//Draw headings
//draw_set_font();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x+COLUMN_ENEMY,y+120,"ENEMY");
draw_text(x+COLUMN_NAME,y+120,"NAME");
draw_text(x+COLUMN_HP,y+120,"HP");

//Draw enemy names
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
var draw_limit = 3;
var drawn = 0;
for (var i = 0; (i < array_length(enemyUnits)) && (drawn < draw_limit); i++)
{
	var char = enemyUnits[i];
	if (char.hp > 0)
	{
		drawn++;
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		if (char.id == unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY,y+130+(i*12),char.name);
	}
}

//Draw party info
for (var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var char = partyUnits[i];
	if (char.id == unitWithCurrentTurn) draw_set_color(c_yellow);
	if(char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+130+(i*12),char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	//if (char.hp < char.hp_max * 0.5)) draw_set_color(c_orange);
	if (char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+50,y+130+(i*12),string(char.hp)); // + "/" + string(char.hp_max));
	
	draw_set_color(c_white);
}


//Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		if (activeTarget != noone)
		{
			if (!is_array(activeTarget))
			{
				draw_sprite(spr_pointer,0,activeTarget.x,activeTarget.y);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1);
				for(var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(spr_pointer,0,activeTarget[i].x,activeTarget[i].y);
				}
				draw_set_alpha(1.0);
			}
		}
	}
}
	
//Draw battle text
if (battleText != "")
{
	var _w = string_width(battleText)+20;
	draw_sprite_stretched(spr_box,0,x+160-(_w*0.5),y+5,_w,25);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(x+160,y+10,battleText);
}

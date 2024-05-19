event_inherited();
if (hp <= 0)
{
	sprite_index = sprites.downed; //image_blend = c_red;
	image_alpha -= 0.01; //Make enemy switch to sprite and fade out when defeated
}


event_inherited();
if (hp <=0)
{
	sprite_index = sprites.downed;
}
else
{
	if (sprite_index == sprites.downed) sprite_index = sprites.idle; //Returns to idle if revived
}
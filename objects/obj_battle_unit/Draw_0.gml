//null (override)

//This is where code will be for combnined sprite

//if sprites.head AND sprites.torso AND sprites.legs is not null then
// instead of draw_self
// draw head
// draw torso
// draw legs
//(randomly chosen on creation in game_data......)

//if (sprites.head) && (sprites.legs)
//{
	//draw_self();
draw_sprite(spr_head_1, image_index, x, y);
draw_sprite(spr_torso_1, image_index, x, y); //for second argument subimage, 0 means first "animation panel" and image_index or -1 means whole animation
draw_sprite(spr_legs_1, image_index, x, y);
//I can now assign a different head and legs for each unit like this
	//Causes problems with downed sprites though
	//Simple fix is change the angle of the drawn 2 sprites by 90 degrees
//}
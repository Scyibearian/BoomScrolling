right_key = keyboard_check(vk_right); //var right_key = keyboard_check(vk_right); //Arrow key controlled movement
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

//get speeds
xspd =  (right_key - left_key) * move_spd;
yspd =  (down_key - up_key) * move_spd;



//sprite animation
mask_index = sprite[DOWN]; //Collision mask is always down sprite collision mask for all direction
if yspd == 0 { //latest input doesn't overwrite facing direction on diagonal movement
	if xspd > 0 {face = RIGHT};
	if xspd < 0 {face = LEFT};
}
if xspd > 0 && face == LEFT {face = RIGHT};
if xspd < 0 && face == RIGHT {face = LEFT};
if xspd == 0 {
	if yspd > 0 {face = DOWN};
	if yspd < 0 {face = UP};
}
if yspd > 0 && face == UP {face = DOWN};
if yspd < 0 && face == DOWN {face = UP};
sprite_index = sprite[face];




//Check collision
if place_meeting(x + xspd, y, obj_wall) == true{ //if horizontal movement would result in player inside wall
	xspd = 0;
}
if place_meeting(x, y + yspd, obj_wall) == true{
	yspd = 0;
}

//player moves
x += xspd;
y += yspd;


//animate
if xspd == 0 && yspd == 0 { //if not moving, stop animation
	image_index = 0;
}





// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_move_right(){
	var hspd = 2;
	var not_wall = !place_meeting(x + hspd, y, obj_solid);
	var not_ledge = instance_position(x + (sprite_width / 2) + 1, y + (sprite_height / 2) + 1, obj_solid);
	
	if (not_wall and not_ledge)
	{
		x += hspd;
	}
	else
	{
		state = scr_move_left;
	}
}
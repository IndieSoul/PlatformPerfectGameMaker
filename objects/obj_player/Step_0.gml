// Platform physics

var rkey = keyboard_check(vk_right);
var lkey = keyboard_check(vk_left);

var jkey = keyboard_check_pressed(ord("Z"));
var jkeyreleased = keyboard_check_released(ord("Z"));

var dashkey = keyboard_check(ord("X"));
var dashkeyreleased = keyboard_check_released(ord("X"));

var move = rkey - lkey;
if (move != 0) lastmovepos = move;

// Check for ground
if(place_meeting(x, y + 1, obj_solid_ref))
{
	vspd = 0;
	airjump = 1;
	
	coyote_counter = coyote_max;
}
else 
{
	coyote_counter--;
	
	// Gravity
	if (vspd < 10) vspd += grav;
}

// Jumping
if(jkey and coyote_counter > 0)
{
	vspd = -jspd;
}

if (vspd < 0 && jkeyreleased)
{
	vspd = 0;
}

// Moving
hspd = spd * move;

if (place_meeting(x - 1, y, obj_solid_ref) and !place_meeting(x + 1, y, obj_solid_ref) and lkey)
{
	if (jkey) 
	{
		vspd = -jspd;
		airjump = 1;
		if (!place_meeting(x, y + 1, obj_solid_ref)) hspd += jspd;
	}
	if (move != 0 and vspd > 0) vspd *= 0.4;
}

if (place_meeting(x + 1, y, obj_solid_ref) and !place_meeting(x - 1, y, obj_solid_ref) and rkey)
{
	if (jkey) 
	{
		vspd = -jspd;
		airjump = 1;
		if (!place_meeting(x, y + 1, obj_solid_ref)) hspd -= jspd;
	}
	if (move != 0 and vspd > 0) vspd *= 0.2;
}

// Dash
if (dashkey)
{
	if (dashduration == -1 and place_meeting(x, y + 1, obj_solid_ref)) dashduration = 18;
	if (dashduration > 0) 
	{
		hspd = lastmovepos * dashspd;
		sprite_index = spr_player;
		mask_index = spr_player;
		dashduration--
	} 
}

if (dashkeyreleased) dashduration = -1;

if (!place_meeting(x, y + 1, obj_solid_ref) and dashduration > 0) dashduration = 2;

if (!place_meeting(x + 1, y, obj_solid_ref) and dashkey and jkey) dashduration = 2;
if (!place_meeting(x - 1, y, obj_solid_ref) and dashkey and jkey) dashduration = 2;

if (dashduration <= 0) 
{
	sprite_index = spr_playerIdle;
	mask_index = spr_playerIdle;
	if(place_meeting(x, y, obj_solid_ref) and mask_index == spr_playerIdle)
	{
		sprite_index = spr_player;
		mask_index = spr_player;
		hspd = lastmovepos * dashspd;
	}
}

// Horizontal collisions
if (place_meeting(x + hspd, y, obj_solid_ref))
{
	while (!place_meeting(x + sign(hspd), y, obj_solid_ref))
	{
		x += sign(hspd); 
	}
	hspd = 0;
}

// Move X
x += hspd;

// Horizontal collisions
if (place_meeting(x, y + vspd, obj_solid_ref))
{
	while (!place_meeting(x, y + sign(vspd), obj_solid_ref))
	{
		y += sign(vspd); 
	}
	vspd = 0;
}

// Move Y
y += vspd; 
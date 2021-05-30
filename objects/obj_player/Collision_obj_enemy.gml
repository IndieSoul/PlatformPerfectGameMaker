/// @desc Enemy collision
if (y < other.y - vspd)
{
	with (other)
	{
		instance_destroy();
	}
	vspd = -jspd;
}
else
{
	game_restart();	
}
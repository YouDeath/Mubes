function destroy(){
	if step < pi{
		alpha = sin(step)
	}
	else{
		instance_create_layer(x,y,"Menu",obj_levels_cheker)
		instance_destroy()
	}
}

if global.lastRoom == game{
	instance_create_layer(x,y,"Menu",obj_levels_cheker)
	instance_destroy()
}
global.lastRoom = menu
step = pi/2
alpha = 1
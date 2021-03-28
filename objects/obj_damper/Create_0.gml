function destroy(){
	if step < pi{
		alpha = sin(step)
	}
	else{
		instance_create_layer(x,y,"Menu",obj_chapters_controller)
		instance_destroy()
	}
}

if global.lastRoom == menu{
	instance_create_layer(x,y,"Menu",obj_chapters_controller)
	instance_destroy()
}

step = pi/2
alpha = 1
function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		if move == false{
			show_debug_message("s-1")
			room_goto(menu)
		}
		instance_destroy()
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
		y-=2
	}
	else{
		needCreate = false
	}
}

move = false
alpha = 0;
needDestroy = false
needCreate = true
image_xscale = obj_camera.scaleParametr
image_yscale = obj_camera.scaleParametr
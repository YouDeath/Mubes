function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		instance_destroy()
		//room_goto(menu)
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

alpha = 0;
needDestroy = false
needCreate = true
image_xscale = obj_camera.scaleParametr
image_yscale = obj_camera.scaleParametr
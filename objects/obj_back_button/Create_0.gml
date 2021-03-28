function destroy(){
	if alpha > 0{
		alpha-=0.05
	}
	else{
		instance_destroy()
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
	}
	else{
		needCreate = false
	}
}

alpha = 0;
needDestroy = false
needCreate = true
image_xscale = obj_camera_menu.scaleParametr
image_yscale = obj_camera_menu.scaleParametr
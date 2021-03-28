function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		needDestroy = false
		instance_destroy()
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
		y-=2
		moveX = x
		moveY = y
	}
	else{
		needCreate = false
	}
}


needCreate = true
needDestroy = false
number = 0
info = 0
alpha = 0
deltaScale = 0
scale = obj_camera_menu.scaleParametr+1
image_xscale = scale
image_yscale = scale

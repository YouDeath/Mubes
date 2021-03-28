function expansion(){
	if step < pi/2{
		addScaleX = sin(step)*maxScaleX
		addScaleY = sin(step)*maxScaleY
	}
	else{
		global.scaleX = addScaleX
		global.scaleY = addScaleY
		global.inSelected = true
		room_goto(menu)
	}
}	

function create(){
	if step < pi/2{
		alpha = sin(step)
	}
	else{
		needCreate = false
		step = 0
	}
}

function move_to(moveX,moveY){
	x += (moveX-x)/10
	y += (moveY-y)/10
}

needCreate = true
chapterName = noone
step = 0
x_to = x
alpha = 0

step = 0
maxScaleX = obj_camera_selected.sizeX/24-obj_camera_selected.scaleParametr-8
maxScaleY = obj_camera_selected.sizeY/28-obj_camera_selected.scaleParametr-8
addScaleX = 0;
addScaleY = 0;
goBig = false
press = false
image_xscale = obj_camera_selected.scaleParametr+8
image_yscale = obj_camera_selected.scaleParametr+8

draw_set_halign(fa_center)
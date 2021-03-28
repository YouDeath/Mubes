function expansion(){
	if step < pi/2{
		addScaleX = sin(step)*maxScaleX
		addScaleY = sin(step)*maxScaleY
	}
	else{
		global.scaleX = addScaleX
		global.scaleY = addScaleY
		room_goto(selected)
	}
}	

step = 0
maxScaleX = obj_camera_main.sizeX/48-obj_camera_main.scaleParametr
maxScaleY = obj_camera_main.sizeY/52-obj_camera_main.scaleParametr
addScaleX = 0;
addScaleY = 0;
goBig = false
press = false
image_xscale = obj_camera_main.scaleParametr+1
image_yscale = obj_camera_main.scaleParametr+1

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(buttons)
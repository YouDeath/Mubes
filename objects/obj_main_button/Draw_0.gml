if goBig == false{
	draw_sprite_ext(spr_main_button,0,x,y,addScaleX+obj_camera_main.scaleParametr+1,addScaleY+obj_camera_main.scaleParametr+1,0,noone,1)
	draw_text_color(x,y,"PLAY",c_white,c_white,c_white,c_white,1)
}
else{
	draw_sprite_ext(spr_main_button,1,x,y,addScaleX+obj_camera_main.scaleParametr+1,addScaleY+obj_camera_main.scaleParametr+1,0,noone,1)
}
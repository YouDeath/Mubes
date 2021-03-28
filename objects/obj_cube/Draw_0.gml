draw_sprite_ext(spr_cubes,cube-1,x,y-2*3,obj_camera.scaleParametr+deltaScale,obj_camera.scaleParametr+deltaScale,0,noone,alpha)
if cube != 1{
	draw_set_font(numbers)
	draw_text_ext_color(x,y,string(cubeNumber),32,32,c_white,c_white,c_white,c_white,alpha)
}
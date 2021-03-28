draw_set_font(textSmall)
draw_text_color(x,y-22*(obj_camera_selected.scaleParametr+8),chapterName,c_black,c_black,c_black,c_black,alpha)
if goBig == false{
	draw_sprite_ext(spr_select_chapter,position*2,x,y,addScaleX+obj_camera_selected.scaleParametr+8,addScaleY+obj_camera_selected.scaleParametr+8,0,noone,alpha)
}
else{
	draw_sprite_ext(spr_select_chapter,position*2+1,x,y,addScaleX+obj_camera_selected.scaleParametr+8,addScaleY+obj_camera_selected.scaleParametr+8,0,noone,alpha)
}
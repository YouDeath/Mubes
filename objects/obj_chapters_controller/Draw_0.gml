draw_set_font(text)
draw_text_color(obj_camera_selected.x+obj_camera_selected.sizeX/2,obj_camera_selected.y+100,"CHAPTERS",c_black,c_black,c_black,c_black,alpha)
draw_set_font(selecter)
for (i = 0; i < howChapters; i++){
	if i != position{
		draw_text_color(obj_camera_selected.x+(i-(howChapters-1)/2)*30+obj_camera_selected.sizeX/2,obj_camera_selected.y+(obj_camera_selected.scaleParametr+8)*24+obj_camera_selected.sizeY/2,"·",c_gray,c_gray,c_gray,c_gray,1)
		//draw_circle_color(obj_camera_selected.x+(i-(howChapters-1)/2)*30+obj_camera_selected.sizeX/2,obj_camera_selected.y+(obj_camera_selected.scaleParametr+8)*30+obj_camera_selected.sizeY/2,5,c_gray,c_gray,false)
	}
	else{
		draw_text_color(obj_camera_selected.x+(i-(howChapters-1)/2)*30+obj_camera_selected.sizeX/2,obj_camera_selected.y+(obj_camera_selected.scaleParametr+8)*24+obj_camera_selected.sizeY/2,"·",c_black,c_black,c_black,c_black,1)
	}	
}
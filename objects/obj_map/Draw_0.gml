draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_alpha(alpha)
draw_set_font(text)

draw_rectangle_color(drawBackFX,drawBackSY,drawBackSX,drawBackSY+20,levelColorDark,levelColorDark,levelColorDark,levelColorDark,false)
draw_rectangle_color(drawBackFX,drawBackFY,drawBackSX,drawBackSY,levelColor,levelColor,levelColor,levelColor,false)

draw_text_color(obj_camera.x+obj_camera.sizeX/2,obj_camera.y+100,string(global.chapter+1)+"-"+string(global.level+1),c_black,c_black,c_black,c_black,alpha)
buffer = 0
for (i = 0; i < 4; i++){
	colorNow = ds_list_find_value(colors,i)
	valueNow = ds_list_find_value(values,i)
	switch(colorNow){
		case 1:{
			drawValueColor = levelTaskGreen
			break
		}
		case 2:{
			drawValueColor = levelTaskRed
			break
		}
		case 3:{
			drawValueColor =  levelTaskYellow
			break
		}
		case 4:{
			drawValueColor =  levelTaskBlue
			break
		}
	}
	if colorNow != 0{
		buffer++
		draw_text_color(obj_camera.x+obj_camera.sizeX/2-120*((howTask+1)/2)+buffer*120,obj_camera.y+obj_camera.sizeY/2+(obj_camera.scaleParametr)*44*3,string(valueNow),drawValueColor,drawValueColor,drawValueColor,drawValueColor,alpha)
	}
}
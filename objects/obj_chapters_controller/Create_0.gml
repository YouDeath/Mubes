function create(){
	if step < pi/2{
		alpha = sin(step)
	}
	else{
		needCreate = false
	}
}

function chapters_info(){
	file = file_text_open_read("ChaptersInfo.txt")
	if file == -1{
		file = file_text_open_write("ChaptersInfo.txt")
		file_text_write_real(file,0)
		position = 0
		file_text_close(file);
	}
	else{
		position = file_text_read_real(file)
		file_text_close(file);
	}			
}

function chapters_create(){
	for (i = 0; i < howChapters; i++){
		file = file_text_open_read("chapter"+string(i)+".txt")
			
		chapter_id = instance_create_layer(obj_camera_selected.x+obj_camera_selected.sizeX/2+obj_camera_selected.sizeX*(i-position),obj_camera_selected.y+obj_camera_selected.sizeY/2,"Damper",obj_chapter)
		chapter_id.chapterName = file_text_read_string(file)
		chapter_id.position = i
		//chapter_id.x-=obj_camera_selected.sizeX*position
			
		file_text_close(file);
	}
}

howChapters = 3
position = 0
needCreate = true
canMove = true
step = 0
alpha = 0
draw_set_halign(fa_center)
//draw_set_valign(fa_middle)
draw_set_font(text)

chapters_info()
chapters_create()

if global.chapter != position{
	position = global.chapter
	with obj_chapter{
		x_to = obj_camera_selected.x+obj_camera_selected.sizeX/2+obj_camera_selected.sizeX*(position-obj_chapters_controller.position)
	}
}

//instance_create_layer(obj_camera_selected.x+obj_camera_selected.sizeX/2,obj_camera_selected.y+obj_camera_selected.sizeY/2,"Damper",obj_chapter)
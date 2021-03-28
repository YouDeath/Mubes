if canMove == true{
	angle = arctan2(mouse_y-dragY,mouse_x-dragX)
	angle = radtodeg(angle)
	show_debug_message(angle)
	if angle > 90 and angle < 270{
		if position+1 < howChapters{
			position++
			file = file_text_open_write("ChaptersInfo.txt")
			file_text_write_real(file,position)
			file_text_close(file);
			with obj_chapter{
				x_to = obj_camera_selected.x+obj_camera_selected.sizeX/2+obj_camera_selected.sizeX*(position-obj_chapters_controller.position)
			}
		}
	}
	else{
		if position-1 > -1{
			position--
			file = file_text_open_write("ChaptersInfo.txt")
			file_text_write_real(file,position)
			file_text_close(file);
			with obj_chapter{
				x_to = obj_camera_selected.x+obj_camera_selected.sizeX/2+obj_camera_selected.sizeX*(position-obj_chapters_controller.position)
			}
		}
	}
}


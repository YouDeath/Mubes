if press == false and needCreate == false{
	
	file = file_text_open_write("ChaptersInfo.txt")
	file_text_write_real(file,position)
	file_text_close(file);
	
	goBig = true	
	global.chapter = position
	obj_chapters_controller.canMove = false
}	
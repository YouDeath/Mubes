if canMove == true and pause == false{
	canMove = false
	show_debug_message("move")
	angle = arctan2(mouse_y-dragY,mouse_x-dragX)
	angle = radtodeg(angle)
	
	for (i = 0; i < mapSizeX; i++){
		for (j = 0; j < mapSizeY; j++){
			backMap[i,j] = 0
			backMapNumberMask[i,j] = -1
		}
	}
	
	with obj_cube{
		obj_map.backMap[positionX, positionY] = cube
		obj_map.backMapNumberMask[positionX, positionY] = cubeNumber
	}
	ds_stack_push(stepsCubes,copyArr(backMap))
	ds_stack_push(stepsNumbers,copyArr(backMapNumberMask))
	
	obj_step_back_button.can = true
	
	move_command(angle)
}

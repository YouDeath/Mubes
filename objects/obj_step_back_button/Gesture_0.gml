if needDestroy == false and obj_map.alpha == 1 and can == true and obj_map.pause == false{
	with obj_map{
		backMap = ds_stack_top(stepsCubes)
		backMapNumberMask = ds_stack_top(stepsNumbers)
		live_derender_level()
		pause = true
		//render_back_level(backMap, backMapNumberMask
		show_debug_message("show info")
		show_debug_message(ds_stack_top(stepsCubes))
		show_debug_message(ds_stack_top(stepsNumbers))
		map = ds_stack_top(stepsCubes)
		mapNumberMask = ds_stack_top(stepsNumbers)
		ds_map_add(level, "map", map)
		ds_map_add(level, "mapNumberMask", mapNumberMask)
		moveMap = ds_stack_top(stepsCubes)
		moveMapNumberMask = ds_stack_top(stepsNumbers)
		moveCubeIdArr = copyArr(cubeIdArr)
		show_debug_message("stackSize "+string(ds_stack_size(stepsNumbers)))
		show_debug_message(moveMap)
		show_debug_message(moveMapNumberMask)
		show_debug_message(cubeIdArr)
		ds_stack_pop(stepsNumbers)
		ds_stack_pop(stepsCubes)
		if ds_stack_empty(stepsCubes) == true{
			obj_step_back_button.can = false
		}
	}
}
/*
with obj_map{
	save_level(level)
}
needDestroy = true
obj_map.needDestroy = true
obj_cell.needDestroy = true
obj_cube.needDestroy = true
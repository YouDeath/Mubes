if howReadyBack != howReady or mapCubes != mapCubesBack{
	show_debug_message("howReady: "+string(howReady))
	show_debug_message("mapCubes: "+string(mapCubes))
	show_debug_message("canMove: "+string(canMove))
	show_debug_message("pause: "+string(pause))
}
if howReady >= mapCubes{
	isResult = true
	isSolution = false
	howNeedSolutions = 0
	
	for (i = 0; i < 4; i++){
		colorNow = ds_list_find_value(colors,i)
		valueNow = ds_list_find_value(values,i)
		if colorNow == 0{
			howTaskReady[i] = 1
		}
		else{
			howNeedSolutions++
			howTaskReady[i] = 0
		}
	}
	if instance_exists(obj_cube){
		with obj_cube{
			if cube != 1{
				is = false
				for (i = 0; i < 4; i++){
					colorNow = ds_list_find_value(obj_map.colors,i)
					valueNow = ds_list_find_value(obj_map.values,i)
					if cube-1 == colorNow and valueNow == cubeNumber and obj_map.howTaskReady[i] != 1{
						obj_map.howTaskReady[i] = 1
						is = true
						break
					}
				}
				if is == false{
					obj_map.isResult = false
				}
			}
		}
	}
	
	isSolution = true
	howSolutions = 0
	
	for (i = 0; i < 4; i++){
		if howTaskReady[i] == 0{
			isSolution = false
		}
		else{
			howSolutions++
		}
	}
	//show_debug_message("solutions "+string(howSolutions))
	if isSolution == false or isResult == false{
		cubeIdArr = copyArr(moveCubeIdArr)
		bufferMapNumberMask = copyArr(moveMapNumberMask)
		bufferMap = copyArr(moveMap)
		
		for (i = 0; i < mapSizeX; i++){
			for (j = 0; j < mapSizeY; j++){
				moveMap[i,j] = 0
				moveMapNumberMask[i,j] = -1
				moveCubeIdArr[i,j] = 0
			}
		}

		ds_map_set(level, "map", bufferMap)
		ds_map_set(level, "mapNumberMask", bufferMapNumberMask)
	
	
		howReady = 0
		canMove = true
	}
	else{
		if howNeedSolutions == (instance_number(obj_cube)-mapBlocks){
			nextLevel = true
			obj_menu_button.move = true
			obj_restart_button.move = true
			obj_step_back_button.move = true
			needDestroy = true
			obj_cell.needDestroy = true
			if instance_exists(obj_cube){
				obj_cube.needDestroy = true
			}
			obj_menu_button.needDestroy = true
			obj_restart_button.needDestroy = true
			obj_step_back_button.needDestroy = true
		}
	}
}

if needDestroy == true{
	destroy()
}

if needCreate == true{
	create()
}

if liveDerender == true and instance_number(obj_cube) == 0{
	liveDerender = false
	render_back_level(backMap, backMapNumberMask)
}

howReadyBack = howReady
mapCubesBack = mapCubes
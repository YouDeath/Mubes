function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		needDestroy = false
		instance_destroy()
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
		y-=2
		moveX = x
		moveY = y
	}
	else{
		needCreate = false
		obj_map.isCreateAll = true
		with obj_cube{
			if obj_map.isCreateAll == true and needCreate = true{
				obj_map.isCreateAll = false
			}
		}
		if obj_map.isCreateAll == true{
			obj_map.pause = false 
		}
	}
}

function in_map_size(mapSizeX, mapSizeY, checkX, checkY){
	if (checkX > -1 and checkX < mapSizeX) and (checkY > -1 and checkY < mapSizeY){
		return true;
	}
	else{
		return false;
	}
}

function move_help(moveCellX,moveCellY){
	obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = cube
	obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = cubeNumber
	positionX = positionX+moveCellX
	positionY = positionY+moveCellY
	needChangePosition = true
	moveX = moveX+32*obj_camera.scaleParametr*moveCellX
	moveY = moveY+32*obj_camera.scaleParametr*moveCellY
	obj_map.moveCubeIdArr[positionX,positionY] = id
}

function operator_help(moveCellX,moveCellY){
	first = cube
	map = ds_map_find_value(obj_map.level,"map")
	second = map[positionX+moveCellX,positionY+moveCellY]
	move = true
	if ((first == 2 or first == 3) and second == 5) or (first == 5 and (second == 2 or second == 3)){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if first == 2 or first == 3{
			if ((cubeNumber mod secindId.cubeNumber) != 0){
				move = false
			}
		}
		else{
			if ((secindId.cubeNumber mod cubeNumber) != 0){
				move = false
			}
		}
	}
	if move == true{
		operator = true
		needChangePosition = true
		moveX = moveX+32*3*moveCellX
		moveY = moveY+32*3*moveCellY
		mX = moveCellX
		mY = moveCellY
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if secindId != 0{
			with secindId{
				add_eat_animaiton()
			}
		}
	}
	else{
		obj_map.moveMap[positionX,positionY] = cube
		obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
		obj_map.moveCubeIdArr[positionX,positionY] = id
		obj_map.howReady++;
	}
}

function stay_help(){
	obj_map.moveMap[positionX,positionY] = cube
	obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
	obj_map.moveCubeIdArr[positionX,positionY] = id
	obj_map.howReady++
}

function operator_check(moveCellX,moveCellY){
	first = cube
	map = ds_map_find_value(obj_map.level,"map")
	second = map[positionX+moveCellX,positionY+moveCellY]
	// ++
	if first == 2 and second == 2{
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		secindId.cubeNumber += cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// --
	if first == 3 and second == 3{
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		secindId.cubeNumber += cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// +-
	if (first == 2 and second == 3) or (first == 3 and second == 2){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if second == 2{
			secindId.cubeNumber -= cubeNumber
		}
		else{
			secindId.cubeNumber = cubeNumber-secindId.cubeNumber
		}
		if secindId.cubeNumber < 0{
			secindId.cube = 3
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 3
			secindId.cubeNumber = abs(secindId.cubeNumber);
		}
		else{
			secindId.cube = 2
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 2
		}
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// +*
	if (first == 2 and second == 4) or (first == 4 and second == 2){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if second == 4{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 2
			secindId.cube = 2
		}
		secindId.cubeNumber*=cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// -*
	if (first == 3 and second == 4) or (first == 4 and second == 3){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if second == 4{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 3
			secindId.cube = 3
		}
		secindId.cubeNumber*=cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// **
	if first == 4 and second == 4{
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		secindId.cubeNumber+=cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// +/
	if (first == 2 and second == 5) or (first == 5 and second == 2){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if second == 5{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 2
			secindId.cube = 2
			secindId.cubeNumber = cubeNumber/secindId.cubeNumber
		}
		else{
			secindId.cubeNumber /= cubeNumber
		}
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// -/
	if (first == 3 and second == 5) or (first == 5 and second == 3){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if second == 5{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 3
			secindId.cube = 3
			secindId.cubeNumber = cubeNumber/secindId.cubeNumber
		}
		else{
			secindId.cubeNumber /= cubeNumber
		}
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	// */
	if (first == 4 and second == 5) or (first == 5 and second == 4){
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		if first == 4{
			result = cubeNumber-secindId.cubeNumber
		}
		else{
			result = secindId.cubeNumber-cubeNumber
		}
		if result < 0{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 5
			secindId.cube = 5
			secindId.cubeNumber = abs(result)
		}
		else{
			obj_map.moveMap[positionX+moveCellX,positionY+moveCellY] = 4
			secindId.cube = 4
			secindId.cubeNumber = result
		}
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	if first == 5 and second == 5{
		secindId = obj_map.cubeIdArr[positionX+moveCellX,positionY+moveCellY]
		secindId.cubeNumber+=cubeNumber
		obj_map.moveMapNumberMask[positionX+moveCellX,positionY+moveCellY] = secindId.cubeNumber
	}
	show_debug_message("destroy")
	obj_map.mapCubes = instance_number(obj_cube)-obj_map.mapBlocks-1
	instance_destroy()
}

function move_cell(moveCellX,moveCellY){
	map = ds_map_find_value(obj_map.level,"map")
	mapNumberMask = ds_map_find_value(obj_map.level,"mapNumberMask")
	mapSizeX = array_height_2d(map)
	mapSizeY = array_length_2d(map,0)
	if in_map_size(mapSizeX,mapSizeY,positionX+moveCellX,positionY+moveCellY){
		if map[positionX+moveCellX,positionY+moveCellY] != 1{
			if map[positionX+moveCellX,positionY+moveCellY] == 0{
				move_help(moveCellX,moveCellY)
				show_debug_message("perm free")
			}
			else{
				isFree = false
				map = ds_map_find_value(obj_map.level,"map")
				anyDelete = false
				meDelete = false
				for (i = 1; i < 6; i++){
					if in_map_size(mapSizeX,mapSizeY,positionX+moveCellX*i,positionY+moveCellY*i){
						first = map[positionX+moveCellX*(i-1),positionY+moveCellY*(i-1)]
						second = map[positionX+moveCellX*i,positionY+moveCellY*i]
						if map[positionX+moveCellX*i,positionY+moveCellY*i] == 0{
							isFree = true
							break;
						}
						if map[positionX+moveCellX*i,positionY+moveCellY*i] == 1{
							break;
						}
						if ((first == 2 or first == 3) and second == 5) or (first == 5 and (second == 2 or second == 3)){
							mapNumberMask = ds_map_find_value(obj_map.level,"mapNumberMask")
							firstCubeNumber = mapNumberMask[positionX+moveCellX*(i-1),positionY+moveCellY*(i-1)]
							secondCubeNumber = mapNumberMask[positionX+moveCellX*i,positionY+moveCellY*i]
							if first == 2 or first == 3{
								if ((firstCubeNumber mod secondCubeNumber) == 0){
									if i == 1{
										meDelete = true
										show_debug_message(string(id)+"meDelete")
									}
									else{
										anyDelete = true
										show_debug_message(string(secondCubeNumber)+" "+string(firstCubeNumber)+" any2 "+string(i))
									}
								}
							}
							else{
								if ((secondCubeNumber mod firstCubeNumber) == 0){
									if i == 1{
										meDelete = true
										show_debug_message(string(id)+"meDelete")
									}
									else{
										anyDelete = true
										show_debug_message(string(secondCubeNumber)+" "+string(firstCubeNumber)+" any2 "+string(i))
									}
								}
							}
						}
						else{
							if i == 1{
								meDelete = true
							}
							else{
								anyDelete = true
							}
						}
					}
					else{
						break
					}
				}
				if isFree == false{ 
					if in_map_size(mapSizeX,mapSizeY,positionX+moveCellX*2,positionY+moveCellY*2){
						if map[positionX+moveCellX*2,positionY+moveCellY*2] == 1{
							operator_help(moveCellX,moveCellY)
						}
						else{
							if anyDelete == true{
								show_debug_message("anyDELETE")
								move_help(moveCellX,moveCellY)
							}
							else{
								show_debug_message(string(id)+" "+string(meDelete))
								if meDelete == true{
									operator_help(moveCellX,moveCellY)
									show_debug_message(string(id)+" isDelete")
								}
								else{
									stay_help()
									show_debug_message(string(id)+" mestay")
								}
							}
						}
					}
					else{
						anyDelete = false
						operator_help(moveCellX,moveCellY)
						show_debug_message("info info")
					}
				}
				else{
					anyDelete = false
					move_help(moveCellX,moveCellY)
					show_debug_message("free")
				}
			}
		}
		else{
			stay_help()
		}
	}
	else{
		stay_help()
	}
}

function move_to(moveX,moveY){
	x += (moveX-x)/3
	y += (moveY-y)/3
	if !((abs(moveX-x) > 1) or (abs(moveY-y) > 1)){
		needChangePosition = false
		if operator == true{
			operator = false
			operator_check(mX,mY)
		}
		obj_map.howReady++
	}
}

function eat_animaiton(step){
	deltaScale = sin(step/10)/2
	if step/10 > pi{
		needEatAnimation = false
		deltaScale = 0
		depth++
	}
}

function add_eat_animaiton(){
	depth--
	show_debug_message("where")
	step = 0
	needEatAnimation = true
}

meDelete = false
anyDelete = false
step = 0
needEatAnimation = false
deltaScale = 0
operator = false
alpha = 0;
needDestroy = false
needChangePosition = false
needCreate = true
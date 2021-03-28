function in_map_size(mapSizeX, mapSizeY, checkX, checkY){
	if (checkX > -1 and checkX < mapSizeX) and (checkY > -1 and checkY < mapSizeY){
		return true;
	}
	else{
		return false;
	}
}

function is_block_close(mapSizeX, mapSizeY, checkX, checkY){
	for (var i = -1; i < 2; i++){
		for (var j = -1; j < 2; j++){
			if i*j == 0{
				if in_map_size(mapSizeX, mapSizeY, checkX+i, checkY+j){
					if map[checkX+i, checkY+j] == 1{
						return true;		
					}	
				}
				else{
					return true;
				}
			}
		}
	}
	return false;
}

function generate_random_level(mapSizeX, mapSizeY, cubes, howBlocks, howCubesResult, howStep){
	random_set_seed(current_time)
	for (var i = 0; i < mapSizeX; i++){
		for (var j = 0; j < mapSizeY; j++){
			map[i,j] = 0;
			mapNumberMask[i,j] = -1;
		}
	}
	needBlocks = howBlocks
	while needBlocks > 0{
		blockX = irandom(mapSizeX-1)
		blockY = irandom(mapSizeY-1)
		if map[blockX,blockY] == 0{
			map[blockX,blockY] = 1;
			needBlocks--;
		}
	}
	needCubes = howCubesResult
	while needCubes > 0{
		cubeX = irandom(mapSizeX-1)
		cubeY = irandom(mapSizeY-1)
		if map[cubeX,cubeY] == 0{
			if !is_block_close(mapSizeX, mapSizeY, cubeX, cubeY) {
				typeRandom = random(1)
				if typeRandom <= 0.25{
					map[cubeX,cubeY] = 2;
				}
				else{
					if typeRandom <= 0.5 {
						map[cubeX,cubeY] = 3;
					}
					else{
						if typeRandom <= 0.75{
							map[cubeX,cubeY] = 4
						}
						else{
							map[cubeX,cubeY] = 5
						}
					}
				}
				mapNumberMask[cubeX,cubeY] = irandom_range(1,50)
				needCubes--;
			}
		}
	}
	result = ds_list_create();
	ds_list_add(result,map)
	ds_list_add(result,mapNumberMask)
	return result;
}

function derender_level(){
	derender = true
	needDestroy = true
	if instance_exists(obj_cell){
		obj_cell.needDestroy = true
	}
	if instance_exists(obj_cube){
		obj_cube.needDestroy = true
	}
}

function live_derender_level(){
	liveDerender = true
	if instance_exists(obj_cube){
		obj_cube.needDestroy = true
	}
}

function render_level(level){
	if instance_exists(obj_cell){
		obj_cell.needDestroy = true
	}
	if instance_exists(obj_cube){
		obj_cube.needDestroy = true
	}
	map = ds_map_find_value(level,"map")
	mapNumberMask = ds_map_find_value(level,"mapNumberMask")
	backMap = ds_map_find_value(level,"map")
	backMapNumberMask = ds_map_find_value(level,"mapNumberMask")
	mapCubes = 0
	canMove = true
	for (var i = 0; i < array_height_2d(map); i++){
		for (var j = 0; j < array_length_2d(map,0); j++){
			createX = obj_camera.x+obj_camera.sizeX/2+(32*obj_camera.scaleParametr)*(i-(array_height_2d(map)-1)/2)
			createY = obj_camera.y+obj_camera.sizeY/2+(32*obj_camera.scaleParametr)*(j-(array_length_2d(map,0)-1)/2)
			cellId = instance_create_layer(createX,createY,"Cells",obj_cell)
			cellIdArr[i,j] = cellId
			cellId.positionX = i
			cellId.positionY = j
			if map[i,j] != 0{
				cubeId = instance_create_layer(createX,createY,"Cubes",obj_cube)
				cubeIdArr[i,j] = cubeId
				cubeId.positionX = i
				cubeId.positionY = j
				cubeId.cube = map[i,j]
				if map[i,j] != 1{
					mapCubes++
				}
				cubeId.cubeNumber = mapNumberMask[i,j]
			}
		}
	}
}

function render_back_level(map, mapNumberMask){
	if instance_exists(obj_cube){
		obj_cube.needDestroy = true
	}
	
	for (i = 0; i < mapSizeX; i++){
		for (j = 0; j < mapSizeY; j++){
			cubeIdArr[i,j] = noone
		}
	}
	
	mapCubes = 0
	canMove = true
	for (var i = 0; i < array_height_2d(map); i++){
		for (var j = 0; j < array_length_2d(map,0); j++){
			createX = obj_camera.x+obj_camera.sizeX/2+(32*obj_camera.scaleParametr)*(i-(array_height_2d(map)-1)/2)
			createY = obj_camera.y+obj_camera.sizeY/2+(32*obj_camera.scaleParametr)*(j-(array_length_2d(map,0)-1)/2)
			if map[i,j] != 0{
				cubeId = instance_create_layer(createX,createY,"Cubes",obj_cube)
				cubeIdArr[i,j] = cubeId
				cubeId.positionX = i
				cubeId.positionY = j
				cubeId.cube = map[i,j]
				if map[i,j] != 1{
					mapCubes++
				}
				cubeId.cubeNumber = mapNumberMask[i,j]
			}
		}
	}
	show_debug_message("info")
	moveCubeIdArr = copyArr(cubeIdArr)
	howReady = mapCubes
}

function move_command(angle){
	if instance_exists(obj_cube){
		if angle >= -135 and angle < -45{
				with obj_cube{
					if cube != 1{
						move_cell(0,-1)
					}
					else{
						obj_map.moveMap[positionX,positionY] = cube
						obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
					}
				}
		}
		if angle >= -45 and angle < 45{
			with obj_cube{
				if cube != 1{
					move_cell(1,0)
				}
				else{
					obj_map.moveMap[positionX,positionY] = cube
					obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
				}
			}
		}
		if angle >= 45 and angle < 135{
			with obj_cube{
				if cube != 1{
					move_cell(0,1)
				}
				else{
					obj_map.moveMap[positionX,positionY] = cube
					obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
				}
			}
		}
		if (angle >= 135 and angle <= 180) or (angle < -135 and angle >= -180){
			with obj_cube{
				if cube != 1{
					move_cell(-1,0)
				}
				else{
					obj_map.moveMap[positionX,positionY] = cube
					obj_map.moveMapNumberMask[positionX,positionY] = cubeNumber
				}
			}
		}
	}
}

function copyArr(arr){
	for (i = 0; i < 6; i++){
		var info = arr[i,0]
		arr[i,0] = -100;
		arr[i,0] = info
	}
	return arr
}

function generateLevel(){
	derender = false
	level = ds_map_create()
	result = generate_random_level(mapSizeX,mapSizeY,1,mapBlocks,mapCubes,4)
	ds_map_add(level, "map", ds_list_find_value(result,0))
	ds_map_add(level, "mapNumberMask", ds_list_find_value(result,1))
	return level
}

function save_level(level){
	file = file_text_open_read("level.txt")
	if file != -1{
		file_text_close(file)
		file_delete("level.txt")
	}
	file = file_text_open_write("level.txt")
	map = ds_map_find_value(level,"map")
	mapNumberMask = ds_map_find_value(level,"mapNumberMask")
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,map[i,j])
		}
	}
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,mapNumberMask[i,j])
		}
	}
	file_text_close(file)
}

function destroy(){
	if alpha > 0{
		alpha-=0.05
		drawBackFY+=2
		drawBackSY+=2
	}
	else{
		needDestroy = false
		if derender == false{
			if nextLevel == true{
				
				if instance_exists(obj_cube){
					instance_destroy(obj_cube)
				}
				if instance_exists(obj_cell){
					instance_destroy(obj_cell)
				}
				
				file = file_text_open_write("level"+string(global.chapter)+"-"+string(global.level)+"-info.txt")
				file_text_write_real(file, 2)
				file_text_close(file)
				global.level++
				show_debug_message("level: "+string(global.level))
				if global.level < 25{
					file = file_text_open_read("level"+string(global.chapter)+"-"+string(global.level)+"-info.txt")
					if file_text_read_real(file) == 0{
						file_text_close(file)
						file = file_text_open_write("level"+string(global.chapter)+"-"+string(global.level)+"-info.txt")
						file_text_write_real(file, 1)
						file_text_close(file)
					}
					file_text_close(file)
					instance_create_layer(x,y,"Service",obj_map)
				}
				else{
					if global.chapter < 2{
						global.chapter++
						file = file_text_open_read("level"+string(global.chapter)+"-"+"0"+"-info.txt")
						if file_text_read_real(file) == 0{
							file_text_close(file)
							file = file_text_open_write("level"+string(global.chapter)+"-"+"0"+"-info.txt")
							file_text_write_real(file, 1)
							file_text_close(file)
						}
						file_text_close(file)
					}
					global.lastRoom = menu
					room_goto(selected)
				}
			}
			instance_destroy()
		}
		else{
			file = file_text_open_read("level"+string(global.chapter)+"-"+string(global.level)+".txt")

			for (i = 0; i < 6; i++){
				for (j = 0; j < 6; j++){
					map[i,j] = file_text_read_real(file)
				}
			}
			for (i = 0; i < 6; i++){
				for (j = 0; j < 6; j++){
					mapNumberMask[i,j] = file_text_read_real(file)
				}
			}
			level = ds_map_create()
			ds_map_add(level, "map", map)
			ds_map_add(level, "mapNumberMask", mapNumberMask)
			file_text_close(file)
			
			derender = false
			show_debug_message("derender")
			if instance_exists(obj_cube){
				instance_destroy(obj_cube)
			}
			if instance_exists(obj_cell){
				instance_destroy(obj_cell)
			}
			needCreate = true
			render_level(level)
		}
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
		drawBackFY-=2
		drawBackSY-=2
	}
	else{
		needCreate = false
		pause = false
	}
}

drawBackFX = obj_camera.x+obj_camera.sizeX/2-3.3*32*obj_camera.scaleParametr
drawBackFY = obj_camera.y+obj_camera.sizeY/2-3.3*32*obj_camera.scaleParametr
drawBackSX = obj_camera.x+obj_camera.sizeX/2+3.3*32*obj_camera.scaleParametr
drawBackSY = obj_camera.y+obj_camera.sizeY/2+3.3*32*obj_camera.scaleParametr
alpha = 0;
needDestroy = false
needCreate = true
derender = false
nextLevel = false
liveDerender = false
pause = true
mapSizeX = 6
mapSizeY = 6
mapCubes = 4
mapBlocks = 0
canMove = true
howReady = 0
howReadyBack = 0
mapCubesBack = 0
stepsCubes = ds_stack_create()
stepsNumbers = ds_stack_create()
switch global.chapter{
	case 0:{
		levelColor = make_color_rgb(38,204,27)
		levelColorDark = make_color_rgb(33,178,23)
		break
	}
	case 1:{
		levelColor = make_color_rgb(35,176,229)
		levelColorDark = make_color_rgb(27,137,178)
		break
	}
	/*
	case 1:{
		levelColor = make_color_rgb(213,1,2)
		levelColorDark = make_color_rgb(178,0,1)
		break
	}
	*/
	case 2:{
		levelColor = make_color_rgb(225,193,25)
		levelColorDark = make_color_rgb(229,173,22)
		break
	}
}

levelTaskGreen = make_color_rgb(33,178,23)
levelTaskRed = make_color_rgb(213,1,2)
levelTaskYellow = make_color_rgb(255,193,25)
levelTaskBlue = make_color_rgb(35,176,229)
inputQueue = ds_queue_create()

for (i = 0; i < mapSizeX; i++){
	for (j = 0; j < mapSizeY; j++){
		moveMap[i,j] = 0
		moveMapNumberMask[i,j] = -1
		moveCubeIdArr[i,j] = 0;
		backMap[i,j] = 0
		backMapNumberMask[i,j] = -1
		bufferMapNumberMask[i,j] = -1
		bufferMap[i,j] = -1;
	}
}

ids = ds_map_create()
ds_map_add(ids,"info",[])

file = file_text_open_read("level"+string(global.chapter)+"-"+string(global.level)+".txt")
if file == -1{
	file = file_text_open_write("level"+string(global.chapter)+"-"+string(global.level)+".txt")
	level = generateLevel()
	map = ds_map_find_value(level,"map")
	mapNumberMask = ds_map_find_value(level,"mapNumberMask")
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,map[i,j])
		}
	}
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,mapNumberMask[i,j])
		}
	}
	file_text_close(file)
}
else{
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			map[i,j] = file_text_read_real(file)
			if map[i,j] == 1{
				mapBlocks++
			}
		}
	}
	for (i = 0; i < 6; i++){
		for (j = 0; j < 6; j++){
			mapNumberMask[i,j] = file_text_read_real(file)
		}
	}
	level = ds_map_create()
	ds_map_add(level, "map", map)
	ds_map_add(level, "mapNumberMask", mapNumberMask)
	
	colors = ds_list_create()
	values = ds_list_create()
	howTask = 0
	for (z = 0; z < 4; z++){
		newColor = file_text_read_real(file)
		newValue = file_text_read_real(file)
		if newColor != 0{
			howTask++
		}
		ds_list_add(colors,newColor)
		ds_list_add(values,newValue)
		show_debug_message(newColor)
		show_debug_message(newValue)
	}
	
	file_text_close(file)
	
	file = file_text_open_write("level"+string(global.chapter)+"-"+string(global.level)+".txt")
	for (z = 0; z < 6; z++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,map[z,j])
		}
	}
	for (z = 0; z < 6; z++){
		for (j = 0; j < 6; j++){
			file_text_write_real(file,mapNumberMask[z,j])
		}
	}
	for (z = 0; z < 4; z++){
		newColor = ds_list_find_value(colors,z)
		newValue = ds_list_find_value(values,z)
		//show_debug_message(newColor)
		//show_debug_message(newValue)
		file_text_write_real(file, newColor)
		file_text_write_real(file, newValue)
	}
	file_text_close(file)
}

render_level(level)

global.lastRoom = game

instance_create_layer(obj_camera.x+90,obj_camera.y+130,"Interface",obj_menu_button)
instance_create_layer(obj_camera.x+obj_camera.sizeX-90,obj_camera.y+130,"Interface",obj_restart_button)
instance_create_layer(obj_camera.x+obj_camera.sizeX/2, obj_camera.y+obj_camera.sizeY/2-(obj_camera.scaleParametr)*42*3,"Interface",obj_step_back_button)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(numbers)
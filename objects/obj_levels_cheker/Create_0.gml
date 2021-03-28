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

function generateLevel(){
	derender = false
	level = ds_map_create()
	result = generate_random_level(mapSizeX,mapSizeY,1,mapBlocks,mapCubes,4)
	ds_map_add(level, "map", ds_list_find_value(result,0))
	ds_map_add(level, "mapNumberMask", ds_list_find_value(result,1))
	return level
}

function levels_check(howLevels){
	for (i = 0; i < howLevels; i++){
		file = file_text_open_read("level"+string(global.chapter)+"-"+string(i)+".txt")
		if file == -1{
			file = file_text_open_write("level"+string(global.chapter)+"-"+string(i)+".txt");
			level = generateLevel()
			map = ds_map_find_value(level,"map")
			mapNumberMask = ds_map_find_value(level,"mapNumberMask")
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
			file_text_write_real(file,0)
			file_text_write_real(file,irandom_range(1,4))
			file_text_write_real(file,irandom_range(5,40))
			for (z = 0; z < 2; z++){
				if random(1) > 0.5{
					file_text_write_real(file,irandom_range(1,4))
					file_text_write_real(file,irandom_range(5,40))
				}
				else{
					file_text_write_real(file,0)
					file_text_write_real(file,0)
				}
			}
			levelId = instance_create_layer(x,y,"Menu",obj_menu_level)
			levelId.number = i
			levelId.info = 0 
			with levelId{
				howX = 5 //obj_camera_menu.sizeX/((24+3)*scale)
				howY = 5
				positionX = number mod howX
				positionY = number div howX
				x = (obj_camera_menu.x+obj_camera_menu.sizeX/2)+(positionX-(howX-1)/2)*30*scale
				y = (obj_camera_menu.y+obj_camera_menu.sizeY/2)+(positionY-(howY-1)/2)*30*scale
			}
			file_text_close(file);
		}
		else{
			file_text_close(file);
			file = file_text_open_read("level"+string(global.chapter)+"-"+string(i)+"-info.txt")
			levelId = instance_create_layer(x,y,"Menu",obj_menu_level)
			levelId.number = i
			levelId.info = file_text_read_real(file) 
			with levelId{
				howX = 5 //obj_camera_menu.sizeX/((24+3)*scale)
				howY = 5
				positionX = number mod howX
				positionY = number div howX
				x = (obj_camera_menu.x+obj_camera_menu.sizeX/2)+(positionX-(howX-1)/2)*30*scale
				y = (obj_camera_menu.y+obj_camera_menu.sizeY/2)+(positionY-(howY-1)/2)*30*scale
			}
			file_text_close(file);
		}
	}	
}

function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		needDestroy = false
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
	}
	else{
		needCreate = false
	}
}

mapSizeX = 6
mapSizeY = 6
mapCubes = 4
mapBlocks = 2

needCreate = true
needDestroy = false
alpha = 0
goRoom = -1

howLevel = 25;
levels_check(howLevel);
draw_set_halign(fa_center)
show_debug_message("create")
instance_create_layer(obj_camera_menu.x+90,obj_camera_menu.y+100,"Menu",obj_back_button)
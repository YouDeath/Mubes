function destroy(){
	if alpha > 0{
		alpha-=0.05
		y+=2
	}
	else{
		/*
		if obj_map.derender == false{
			obj_map.derender = true
			with obj_map{
				level = ds_map_create()
				result = generate_random_level(6,6,1,2,4,4)
				ds_map_add(level, "map", ds_list_find_value(result,0))
				ds_map_add(level, "mapNumberMask", ds_list_find_value(result,1))

				render_level(level)
			}
		}
		*/
		needDestroy = false
		instance_destroy()
	}
}

function create(){
	if alpha < 1{
		alpha+=0.05
		y-=2
	}
	else{
		needCreate = false
	}
}
alpha = 0;
needDestroy = false
needCreate = true
positionX = 0
positionY = 0
cube = 0
cubeNumber = 0
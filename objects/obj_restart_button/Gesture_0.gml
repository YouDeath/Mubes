if needDestroy == false and obj_map.alpha == 1 and obj_map.pause = false{
	with obj_map{
		derender_level();
		pause = true
		//render_level(level)
	}
	obj_step_back_button.can = false
}
/*
with obj_map{
	save_level(level)
}
needDestroy = true
obj_map.needDestroy = true
obj_cell.needDestroy = true
obj_cube.needDestroy = true
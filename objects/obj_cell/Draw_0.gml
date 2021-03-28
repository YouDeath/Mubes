draw_sprite_ext(spr_cell,((positionX+positionY) mod 2)*2,x,y,obj_camera.scaleParametr,obj_camera.scaleParametr,0,noone,alpha)
if positionY == obj_map.mapSizeY-1{
	draw_sprite_ext(spr_cell,((positionX+positionY) mod 2)*2+1,x,y,obj_camera.scaleParametr,obj_camera.scaleParametr,0,noone,alpha)
}
if info == 0{
	draw_sprite_ext(spr_cubes,0,x,y,scale+deltaScale,scale+deltaScale,0,noone,alpha)
}
if info == 1{
	draw_sprite_ext(spr_cubes,3,x,y,scale+deltaScale,scale+deltaScale,0,noone,alpha)
}
if info == 2{
	draw_sprite_ext(spr_cubes,1,x,y,scale+deltaScale,scale+deltaScale,0,noone,alpha)
}

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(numbers)
if info != 0{
	draw_text_ext_color(x,y,string(number+1),32,32,c_white,c_white,c_white,c_white,alpha)
}
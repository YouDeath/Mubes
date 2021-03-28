camera = camera_create()

displayWidth = display_get_width()
displayHeight = display_get_height()

sizeX = displayWidth
sizeY = displayHeight
 
scaleParametr = floor(displayWidth/(7*32))
 
room_width = sizeX
room_height = sizeY

window_set_size(sizeX,sizeY)

x = 0
y = 0

vm = matrix_build_lookat(0, 0, -10, 0, 0, 0, 0, 1, 0)
pm = matrix_build_projection_ortho(sizeX, sizeY, 1, 10000)
camera_set_view_mat(camera, vm)
camera_set_proj_mat(camera, pm)

room_set_view_enabled(room,true)
view_camera[view_current] = camera


surface_resize(application_surface, sizeX, sizeY);
display_reset(0, false);

x-=sizeX/2
y-=sizeY/2

bgColorALL = make_color_rgb(256,256,256)

/*
bgColorLU = make_color_rgb(00,79,91)
bgColorRU= make_color_rgb(00,79,91)
bgColorLD = make_color_rgb(78,255,214)
bgColorRD= make_color_rgb(78,255,214)
*/
bgColorLU = make_color_rgb(240,240,240)
bgColorRU = make_color_rgb(240,240,240)
bgColorLD = make_color_rgb(240,240,240)
bgColorRD = make_color_rgb(240,240,240)

global.lastRoom = main

instance_create_layer(x+sizeX/2,y+sizeY/2,"Menu",obj_main_button)
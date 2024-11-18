// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CamWrap(cam_width, cam_height) constructor{
	WIDTH=cam_width;
	HEIGHT=cam_height;
	TOP_LEFT=0;
	TOP_RIGHT=1;
	BOTTOM_LEFT=2;
	BOTTOM_RIGHT=3;
	TOP=0;
	LEFT=1;
	BOTTOM=2;
	RIGHT=3;
	view = -1;
	proj = -1;
	main_camera = -1;
	corner_cameras = [-1,-1,-1,-1];
	view_camera_side = [-1,-1,-1,-1];
	edge_cameras = [-1,-1,-1,-1];

	/// builds the camera matrices, is being called in update function
	static _build_cameras = function(cam_x, cam_y, camDist, camFov, camAsp){
 
		view = matrix_build_lookat(cam_x, cam_y, camDist, cam_x, cam_y, 0, 0, 1, 0);
		proj = matrix_build_projection_perspective_fov(camFov, camAsp, 3, 30000);

		main_camera = camera_get_active();
		camera_set_proj_mat(main_camera, proj)
		camera_set_view_mat(main_camera, view);

		for(var i = 0; i < 4; i++) {
			view_camera_side[i] = SideFlags.none
			corner_cameras[i] = camera_create_view(0, 0, WIDTH, HEIGHT, 0, -1, 0, 0, 0, 0)
			camera_set_proj_mat(corner_cameras[i], proj)
			camera_set_view_mat(corner_cameras[i], view);
			edge_cameras[i] = camera_create_view(0, 0, WIDTH, HEIGHT, 0, -1, 0, 0, 0, 0)
			camera_set_proj_mat(edge_cameras[i], proj)
			camera_set_view_mat(edge_cameras[i], view);
		}
	}
	
	//===================== functions ========================//
	
	/// call when camera wrap object is destroyed to free cameras from memory
	static cleanup = function(){
		for(var i = 0; i < 4; i++) {
			camera_destroy(corner_cameras[i]);
			camera_destroy(edge_cameras[i]);
		}	
	};
	
	/// call in the update event, pass in the 3D viewport properties
	static update = function(camDist, camFov, camAsp){

		var xx = camera_get_view_x(main_camera);
		var yy = camera_get_view_y(main_camera);
		
		_build_cameras(xx, yy, camDist, camFov, camAsp);

		camera_set_view_size(main_camera, WIDTH, HEIGHT);
		for (var i = 0; i < 4; i++) {
			camera_set_view_size(corner_cameras[i], WIDTH, HEIGHT);
			camera_set_view_size(edge_cameras[i], WIDTH, HEIGHT);
		}

		camera_set_view_pos(corner_cameras[TOP_LEFT], xx - room_width, yy - room_height)
		camera_set_view_pos(corner_cameras[TOP_RIGHT], xx + room_width, yy - room_height)
		camera_set_view_pos(corner_cameras[BOTTOM_LEFT], xx - room_width, yy + room_height)
		camera_set_view_pos(corner_cameras[BOTTOM_RIGHT], xx + room_width, yy + room_height)

		camera_set_view_pos(edge_cameras[TOP], xx, yy - room_height)
		camera_set_view_pos(edge_cameras[LEFT], xx - room_width, yy)
		camera_set_view_pos(edge_cameras[BOTTOM], xx, yy + room_height)
		camera_set_view_pos(edge_cameras[RIGHT], xx + room_width, yy)

		var sideFlags = SideFlags.none
		var center_x, center_y;

		if (xx < 0) {
			center_x = -xx
			sideFlags = sideFlags | SideFlags.left
		} else if (xx + WIDTH >= room_width) {
			center_x = xx + WIDTH - room_width
			sideFlags = sideFlags | SideFlags.right
		}

		if (yy < 0) {
			center_y = -yy
			sideFlags = sideFlags | SideFlags.top
		} else if (yy + HEIGHT >= room_height) {
			center_y = yy + HEIGHT - room_height
			sideFlags = sideFlags | SideFlags.bottom
		}

		view_set_camera(0, main_camera)
		switch (sideFlags) {
			case SideFlags.none:
				for (var i = 1; i < 4; i++) {
					view_set_visible(i, false);
				}
				break;
			case SideFlags.top:
			case SideFlags.left:
			case SideFlags.bottom:
			case SideFlags.right:
				view_set_visible(1, true);
				for (var i = 2; i < 4; i++) {
					view_set_visible(i, false);
				}
				break;
			case SideFlags.topLeft:
			case SideFlags.topRight:
			case SideFlags.bottomLeft:
			case SideFlags.bottomRight:
				for (var i = 1; i < 4; i++) {
					view_set_visible(i, true);
				}
				break;
		}

		view_set_visible(0, true);
		view_camera_side[0] = sideFlags

		switch (sideFlags) {
			case SideFlags.none:
				view_set_xport(0, 0)
				view_set_yport(0, 0)
				break;
			case SideFlags.top:
				view_set_xport(0, 0)
				view_set_yport(0, center_y)
				camera_set_view_size2(main_camera, WIDTH, HEIGHT - center_y)
				view_set_xport(1, 0)
				view_set_yport(1, 0)
				view_set_camera(1, edge_cameras[BOTTOM])
				camera_set_view_size2(edge_cameras[BOTTOM], WIDTH, center_y)
				view_camera_side[1] = SideFlags.bottom
				break;
			case SideFlags.left:
				view_set_xport(0, center_x)
				view_set_yport(0, 0)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT)
				view_set_xport(1, 0)
				view_set_yport(1, 0)
				view_set_camera(1, edge_cameras[RIGHT])
				camera_set_view_size2(edge_cameras[RIGHT], center_x, HEIGHT)
				view_camera_side[1] = SideFlags.right
				break;
			case SideFlags.bottom:
				view_set_xport(0, 0)
				view_set_yport(0, 0)
				camera_set_view_size2(main_camera, WIDTH, HEIGHT - center_y)
				view_set_xport(1, 0)
				view_set_yport(1, HEIGHT - center_y)
				view_set_camera(1, edge_cameras[TOP])
				camera_set_view_size2(edge_cameras[TOP], WIDTH, center_y)
				view_camera_side[1] = SideFlags.top
				break;
			case SideFlags.right:
				view_set_xport(0, 0)
				view_set_yport(0, 0)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT)
				view_set_xport(1, WIDTH - center_x)
				view_set_yport(1, 0)
				view_set_camera(1, edge_cameras[LEFT])
				camera_set_view_size2(edge_cameras[LEFT], center_x, HEIGHT)
				view_camera_side[1] = SideFlags.left
				break;
			case SideFlags.topLeft:
				view_set_xport(0, center_x)
				view_set_yport(0, center_y)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT - center_y)
				view_set_xport(1, 0)
				view_set_yport(1, 0)
				view_set_camera(1, corner_cameras[BOTTOM_RIGHT])
				camera_set_view_size2(corner_cameras[BOTTOM_RIGHT], center_x, center_y)
				view_camera_side[1] = SideFlags.bottomRight
				view_set_xport(2, center_x)
				view_set_yport(2, 0)
				view_set_camera(2, corner_cameras[BOTTOM_LEFT])
				camera_set_view_size2(corner_cameras[BOTTOM_LEFT], WIDTH - center_x, center_y)
				view_camera_side[2] = SideFlags.bottomLeft
				view_set_xport(3, 0)
				view_set_yport(3, center_y)
				view_set_camera(3, corner_cameras[TOP_RIGHT])
				camera_set_view_size2(corner_cameras[TOP_RIGHT], center_x, HEIGHT - center_y)
				view_camera_side[3] = SideFlags.topRight
				break;
			case SideFlags.topRight:
				view_set_xport(0, 0)
				view_set_yport(0, center_y)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT - center_y)
				view_set_xport(1, 0)
				view_set_yport(1, 0)
				view_set_camera(1, corner_cameras[BOTTOM_RIGHT])
				camera_set_view_size2(corner_cameras[BOTTOM_RIGHT], WIDTH - center_x, center_y)
				view_camera_side[1] = SideFlags.bottomRight
				view_set_xport(2, WIDTH - center_x)
				view_set_yport(2, 0)
				view_set_camera(2, corner_cameras[BOTTOM_LEFT])
				camera_set_view_size2(corner_cameras[BOTTOM_LEFT], center_x, center_y)
				view_camera_side[2] = SideFlags.bottomLeft
				view_set_xport(3, WIDTH - center_x)
				view_set_yport(3, center_y)
				view_set_camera(3, corner_cameras[TOP_LEFT])
				camera_set_view_size2(corner_cameras[TOP_LEFT], center_x, HEIGHT - center_y)
				view_camera_side[3] = SideFlags.topLeft
				break;
			case SideFlags.bottomLeft:
				view_set_xport(0, center_x)
				view_set_yport(0, 0)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT - center_y)
				view_set_xport(1, 0)
				view_set_yport(1, 0)
				view_set_camera(1, corner_cameras[BOTTOM_RIGHT])
				camera_set_view_size2(corner_cameras[BOTTOM_RIGHT], center_x, HEIGHT - center_y)
				view_camera_side[1] = SideFlags.bottomRight
				view_set_xport(2, center_x)
				view_set_yport(2, HEIGHT - center_y)
				view_set_camera(2, corner_cameras[TOP_LEFT])
				camera_set_view_size2(corner_cameras[TOP_LEFT], WIDTH - center_x, center_y)
				view_camera_side[2] = SideFlags.topLeft
				view_set_xport(3, 0)
				view_set_yport(3, HEIGHT - center_y)
				view_set_camera(3, corner_cameras[TOP_RIGHT])
				camera_set_view_size2(corner_cameras[TOP_RIGHT], center_x, center_y)
				view_camera_side[3] = SideFlags.topRight
				break;
			case SideFlags.bottomRight:
				view_set_xport(0, 0)
				view_set_yport(0, 0)
				camera_set_view_size2(main_camera, WIDTH - center_x, HEIGHT - center_y)
				view_set_xport(1, WIDTH - center_x)
				view_set_yport(1, HEIGHT - center_y)
				view_set_camera(1, corner_cameras[TOP_LEFT])
				camera_set_view_size2(corner_cameras[TOP_LEFT], center_x, center_y)
				view_camera_side[1] = SideFlags.topLeft
				view_set_xport(2, WIDTH - center_x)
				view_set_yport(2, 0)
				view_set_camera(2, corner_cameras[BOTTOM_LEFT])
				camera_set_view_size2(corner_cameras[BOTTOM_LEFT], center_x, HEIGHT - center_y)
				view_camera_side[2] = SideFlags.bottomLeft
				view_set_xport(3, 0)
				view_set_yport(3, HEIGHT - center_y)
				view_set_camera(3, corner_cameras[TOP_RIGHT])
				camera_set_view_size2(corner_cameras[TOP_RIGHT], WIDTH - center_x, center_y)
				view_camera_side[3] = SideFlags.topRight
				break;

		}

		for (var i = 0; i < 4; i++) {
			var camera = view_get_camera(i)
			view_set_wport(i, camera_get_view_width(camera))
			view_set_hport(i, camera_get_view_height(camera))
		}
	}
	
	/// if you want to draw this in debug mode
	static draw_debug = function(){
		if (debug_mode) {
			var color = c_white;
			switch (view_current) {
				case 0:
					color = c_red
					break
				case 1:
					color = c_lime
					break
				case 2:
					color = c_aqua
					break
				case 3:
					color = c_fuchsia
					break
			}
			draw_set_color(color)
			draw_rectangle(0, 0, room_width, room_height, true)
			draw_set_color(c_white)
		}
	}
	
}

enum SideFlags {
	none = 0,
	top = 1,
	left = 2,
	bottom = 4,
	right = 8,
	topLeft = 3,
	bottomLeft = 6,
	bottomRight = 12,
	topRight = 9
}
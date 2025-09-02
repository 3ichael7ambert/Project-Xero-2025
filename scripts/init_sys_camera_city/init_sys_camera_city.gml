// Initialize the camera system for the game
function init_sys_camera_city() {
    // Define a global object 'CameraManager' to manage camera properties and behaviors
    global.CameraManager = {
        target: noone, // The object the camera is currently following
        id: 0,         // Camera ID
        x: 0,          // Camera's X position
        y: 0,          // Camera's Y position
        w: 320,        // Camera's width
        h: 180,        // Camera's height
        w_screen: 320, // Width of the screen/window
        h_screen: 180, // Height of the screen/window
        xOff: 0,       // Horizontal offset for effects like shaking
        yOff: 0,       // Vertical offset for effects like shaking
        shake: 0,      // Shake intensity
        scale: 2,      // Scaling factor for the camera
        shakeMag: 32,  // Magnitude of the shake effect
        lerpRatio: 0.25,// Ratio for linear interpolation (smoothing camera movement)
        borderless: false, // Whether the camera is restricted by room bounds
        timer: 0,      // A timer for internal use
        xmin: 0,       // Minimum X boundary for the camera
        ymin: 0,       // Minimum Y boundary for the camera
        xmax: 0,       // Maximum X boundary for the camera
        ymax: 0,       // Maximum Y boundary for the camera
        active_border: 128, // Active border size for object activation
		logical_x: 0,   // continuous (unbounded) camera X we follow
		logical_y: 0,   // keep Y if you care about vertical
		wrap_w: 0,      // set to room_width in reset()


        // Update function to control the camera behavior each frame
        update: function(_deactiveObjectParent = noone) {
		    if (instance_exists(self.target)) {
		        var _xto = self.target.x - self.w * 0.5;
		        var _yto = self.target.y - self.h * 0.5;

		        var ratio = (self.timer++ < room_speed) ? 1 : self.lerpRatio;
		        self.logical_x = lerp(self.logical_x, _xto, ratio);
		        self.logical_y = lerp(self.logical_y, _yto, ratio);

		        if (!self.borderless) {
		            self.logical_y = clamp(self.logical_y, self.ymin, self.ymax - self.h);
		        }
		    }

		    if (self.shake > 0) {
		        self.xOff = random_range(-0.5, 0.5) * self.shakeMag;
		        self.yOff = random_range(-0.5, 0.5) * self.shakeMag;
		        self.shake--;
		    } else {
		        self.xOff = 0; self.yOff = 0;
		    }

		    // wrap X into [0, room_width)
		    var wx = self.wrap_w; // set in reset() to room_width
			var cam_x_wrapped = ((self.logical_x + self.xOff) mod wx + wx) mod wx;
			var cam_y_final   = self.logical_y + self.yOff;

			camera_set_view_pos(view_camera[self.id], cam_x_wrapped, cam_y_final);
			
		    if (_deactiveObjectParent >= 0) {
		        var b2 = self.active_border * 2;
		        instance_deactivate_object(_deactiveObjectParent);
		        instance_activate_region(cam_x_wrapped - self.active_border, cam_y_final - self.active_border, self.w + b2, self.h + b2, true);
		    }

		    var smoother = self.scale * 2;
		    camera_set_view_pos(
		        view_camera[self.id],
		        round(cam_x_wrapped * smoother) / smoother,
		        round(cam_y_final   * smoother) / smoother
		    );
		},



        // Reset function to reinitialize camera properties
        reset: function(width=480, height=270, scaling=2, obj=noone) {
		    view_enabled = true;
		    view_visible[0] = true;
		    self.w = width; self.h = height;
		    self.w_screen = self.w * scaling; self.h_screen = self.h * scaling;
		    self.scale = scaling;
		    self.target = obj;
		    self.timer = 0;

		    self.xmin = 0; self.ymin = 0; self.xmax = room_width; self.ymax = room_height;
		    self.wrap_w = room_width;

		    var cam = camera_create_view(0, 0, width, height);
		    view_set_camera(self.id, cam);

		    window_set_size(self.w_screen, self.h_screen);
		    surface_resize(application_surface, self.w_screen, self.h_screen);
		    display_set_gui_size(self.w_screen, self.h_screen);

		    // snap logical to target right away
		    if (instance_exists(obj)) {
		        self.logical_x = obj.x - self.w * 0.5;
		        self.logical_y = obj.y - self.h * 0.5;
		    }
		},


        // Debug function to print camera properties for troubleshooting
        debug: function() {
            var _str = "-------------------------------------------";
            _str += "\ntarget: " + string(self.target) + "\nid: " + string(self.id) + "\nx: " + string(self.x) + "\ny: " + string(self.y);
            _str += "\nw: " + string(self.w) + "\nh: " + string(self.h) + "\nxOff: " + string(self.xOff) + "\nshake: " + string(self.shake);
            _str += "\nshakeMag: " + string(self.shakeMag) + "\n-------------------------------------------";
            return (_str);
        },

        // Function to set the room boundaries for the camera
        setBounds: function(x1, y1, x2, y2) {
            self.xmin = x1;
            self.ymin = y1;
            self.xmax = x2;
            self.ymax = y2;
        },
			check_active_rectangle: function(px, py){
	var _w2 = self.active_border * 2;
	var _x1 = self.x - self.active_border;
	var _y1 = self.y - self.active_border;
	var _x2 = _x1 + self.w + _w2;
	var _y2 = _y1 + self.h + _w2;
	return point_in_rectangle(px, py, _x1, _y1, _x2, _y2);
},
		
				


    }
}

/// call this to resize the view area
function cam_reset_city(width=480,height=270,scaling=2,obj=noone){
	global.CameraManager.reset(width,height,scaling,obj);
}
/// call this to shake the camera
function cam_shake_city(time, mag){
	global.CameraManager.setShake(time, mag);
}
/// call this to update the camera position
function cam_update_city(){
	global.CameraManager.update();
}
/// call this to modify the boundaries the camera can move in
function cam_set_bounds_city(x1, y1, x2, y2){
	global.CameraManager.setBounds(x1, y1, x2, y2);
}

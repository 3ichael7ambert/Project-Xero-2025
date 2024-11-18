// Initialize the camera system for the game
function init_sys_camera_lava() {
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

        // Update function to control the camera behavior each frame
        update: function(_deactiveObjectParent = noone) {
    // Move the camera towards the target object
    if (instance_exists(self.target)) {
        var _xto = self.target.x - self.w * 0.5;
        var _yto = self.target.y - self.h * 0.5;

        // Linearly interpolate camera position for smooth movement
        var ratio = self.lerpRatio;
        if (self.timer++ < room_speed) {
            ratio = 1; // Snap to target initially
        }
        self.x = lerp(self.x, _xto, ratio);
        self.y = lerp(self.y, _yto, ratio);
    }

    // Implement camera shake effect
    if (self.shake > 0) {
        self.xOff = random_range(-0.5, 0.5) * self.shakeMag;
        self.yOff = random_range(-0.5, 0.5) * self.shakeMag;
        self.shake--;
    } else {
        // Reset offset after shaking ends
        self.xOff = 0;
        self.yOff = 0;
    }

    // Activate or deactivate objects around the camera
    if (_deactiveObjectParent >= 0) {
        var b2 = active_border * 2;
        instance_deactivate_object(_deactiveObjectParent);
        instance_activate_region(self.x - active_border, self.y - active_border, self.w + b2, self.h + b2, true);
    }

    // Set the actual view position of the camera in the game
    var smoother = self.scale * 2;
    camera_set_view_pos(view_camera[self.id], round((self.x + self.xOff) * smoother) / smoother, round((self.y + self.yOff) * smoother) / smoother);

    // Make the room infinite by resetting the camera position when it reaches the room bounds
    if (self.borderless) {
        if (self.x < 0) self.x = room_width - self.w;
        if (self.y < 0) self.y = room_height - self.h;
        if (self.x > room_width - self.w) self.x = 0;
        if (self.y > room_height - self.h) self.y = 0;
    }
},


        // Reset function to reinitialize camera properties
        reset: function(width = 480, height = 270, scaling = 2, obj = noone) {
            // Setup the view and window properties
            view_enabled = true;
            view_visible[0] = true;
            self.w = width;
            self.h = height;
            self.w_screen = self.w * scaling;
            self.h_screen = self.h * scaling;
            self.scale = scaling;
            self.target = obj;
            self.timer = 0;
            // Reset room boundaries to the whole room
            self.xmin = 0;
            self.ymin = 0;
            self.xmax = room_width;
            self.ymax = room_height;

            // Create and assign a new camera view
            var cam = camera_create_view(0, 0, width, height);
            view_set_camera(self.id, cam);
            // Resize the game window and surface to match the camera
            window_set_size(self.w_screen, self.h_screen);
            surface_resize(application_surface, self.w_screen, self.h_screen);
            display_set_gui_size(self.w_screen, self.h_screen);
        },

        // Function to set the shake effect properties
        setShake: function(time, mag) {
            self.shake = time * room_speed;
            self.shakeMag = mag;
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
function cam_reset_lava(width=480,height=270,scaling=2,obj=noone){
	global.CameraManager.reset(width,height,scaling,obj);
}
/// call this to shake the camera
function cam_shake_lava(time, _lmag){
	global.CameraManager.setShake(time, mag);
}
/// call this to update the camera position
function cam_update_lava(){
	global.CameraManager.update();
}
/// call this to modify the boundaries the camera can move in
function cam_set_bounds_lava(x1, y1, x2, y2){
	global.CameraManager.setBounds(x1, y1, x2, y2);
}

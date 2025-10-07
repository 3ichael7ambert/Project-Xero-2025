// Size your camera to your game’s view (change if you want)
cam_w = 1280;
cam_h = 720;

// Create a view camera and enable Viewport 0
cam = camera_create_view(0, 0, cam_w, cam_h, 0, -1, 0, 0, 0, 0);
view_enabled = true;               // turn on views globally
view_visible[0] = true;            // show viewport 0
view_camera[0]  = cam;             // assign our camera

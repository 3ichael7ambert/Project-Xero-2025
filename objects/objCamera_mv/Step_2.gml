// Follow the player freely in X; keep Y fixed (0) since you have a solid roof/floor.
// If you want vertical follow later, nudge cy toward player.y instead.
if (instance_exists(objPlayer_mv)) {
    var target = instance_find(objPlayer_mv, 0);
    var cx = round(target.x - cam_w * 0.5);
    var cy = 0;
    camera_set_view_pos(cam, cx, cy);
}

/// bbox_rotate(bbox, angle)
// Rotates a bounding box (defined by its top-left and bottom-right coordinates) by the specified angle.
// Returns the rotated bounding box as an array [left, top, right, bottom].
function bbox_rotate(bbox, angle) {
    var cos_angle = dcos(angle);
    var sin_angle = dsin(angle);

    var cx = (bbox[0] + bbox[2]) / 2;  // Calculate the center X coordinate
    var cy = (bbox[1] + bbox[3]) / 2;  // Calculate the center Y coordinate

    var new_left = cx + (bbox[0] - cx) * cos_angle - (bbox[1] - cy) * sin_angle;
    var new_top = cy + (bbox[0] - cx) * sin_angle + (bbox[1] - cy) * cos_angle;
    var new_right = cx + (bbox[2] - cx) * cos_angle - (bbox[3] - cy) * sin_angle;
    var new_bottom = cy + (bbox[2] - cx) * sin_angle + (bbox[3] - cy) * cos_angle;

    return [new_left, new_top, new_right, new_bottom];
}

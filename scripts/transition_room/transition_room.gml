/// transition_room(_target_room, _style, _dur_out, _dur_in, _snd)
function transition_room(_rm, _style = "fade", _dur_out = 30, _dur_in = 24, _snd = noone) {
    if (instance_exists(objRoomTransition)) return;
    var tr = instance_create_layer(0, 0, layer, objRoomTransition);
    tr._rm        = _rm;
    tr.style      = _style;     // "fade","shade","distort"
    tr.dur_out    = max(1, _dur_out);
    tr.dur_in     = max(1, _dur_in);
    tr._snd       = _snd;
    return tr;
}

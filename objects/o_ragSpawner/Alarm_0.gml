///@desc:Delayed init
_inited = 1;

with (ins_legF_a) {
	seg_calculate(2, foot.phy_position_x, foot.phy_position_y + parent.len_leg_h*4);
};
with (ins_legB_a) {
	seg_calculate(2, foot.phy_position_x, foot.phy_position_y + parent.len_leg_h*4);
};
with (ins_armF_a) {
	seg_calculate(2, seg_x[0], parent.j_y_legf_b);
};
with (ins_armB_a) {
	seg_calculate(2, seg_x[0], parent.j_y_legf_b);
};

with (o_ragParent) {
    if parent = other {
		phy_active = 1;
	};
}
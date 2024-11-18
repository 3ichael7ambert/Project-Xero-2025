if hit exit;
//if other = other.parent.ins_head || other = other.parent.ins_chest {
var pow = 5*other.phy_mass;
other.phy_speed_x += -phy_col_normal_x*pow;
other.phy_speed_y += -phy_col_normal_y*pow;
hit = 1;
//};
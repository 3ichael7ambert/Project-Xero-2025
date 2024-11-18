///@desc:Update IK Arm destination
//This event will be called from the leg instance.
var feetDistance = 0;

//Check if the ragdoll is moving forward.
var gbalMul = 1 + g_movingForward*.1;
var gimpMul = max(1, abs(g_impulse)/3);
g_legStep_sPos[0] = j_x_legf_a + g_bal*gbalMul*gimpMul;
g_legStep_sPos[1] = j_y_legf_a + g_legs_maxSLength;

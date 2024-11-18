/*
	[1] Object Role
	 |
	 |  This object will mainly act as 6 type of body parts, 
	 |  depending on its tag & fixture that is given from o_ragSpawner on ragdoll creation.
	 |  	- (Front & Back) Thigh
	 |  	- (Front & Back) Lower leg
	 |  	- (Front & Back) Foot
	 |  You may refer to 'segTag' enumerator to find tag types (e.g. segTag.head).
	 | 
	[-]
	
	[2] Mechanics
	 |
	 |  The whole leg, from thigh to foot, is driven by an IK (Inverse Kinematics) Arm,
	 |  which is controlled by thigh instance (segTag.legF_a & segTag.legB_a) of that leg.
	 |  
	 |  When the ragdoll begins balancing, the thigh of the current active leg will calculate
	 |  where the foot should be - affected by 'g_bal' variable from o_ragSpawner.
	 |
	 |  Then followed by IK Arm, it moves the foot to its destination while automatically 
	 |  computing a proper position for each leg segment linked to that foot.
	 | 
	 |  Finally, each segment fixtures will be manipulated to synchronize to the IK segment.
	 | 
	[-]
*/


#region Initialize some variables
fSticking = 0;
footst = footSt.air;
fAng = 0
stepping = 0;
tarX = 0; tarY = 0; 
tarD = 0; liftH = 0;
acx = 0; acy = 0;
startX = 0; startY = 0;
tarReached = 0;
lLeg = -1;
lm_prev = 0;
_fH = 0;
#endregion


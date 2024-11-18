/*
	[1] Object Role
	 |
	 |  This object will mainly act as 4 type of body parts, 
	 |  depending on its tag & fixture that is given from o_ragSpawner on ragdoll creation.
	 |  	- (Front & Back) Arm
	 |  	- (Front & Back) Forearm
	 |  You may refer to 'segTag' enumerator to find tag types (e.g. segTag.head).
	 | 
	[-]
	
	[2] Mechanics
	 |
	 |  The whole arm is driven by an IK (Inverse Kinematics) Arm, which is 
	 |  controlled by instance tagged as 'segTag.armF_a' or 'segTag.armB_a' of that arm.
	 |  
	 |  When the ragdoll begins balancing, the controller arm will calculate where the
	 |  forearm should be - affected by 'g_bal' variable from o_ragSpawner.
	 |
	 |  Then followed by IK Arm, it moves the forearm to its destination while automatically 
	 |  computing a reasonable position for each arm segment linked to that forearm.
	 | 
	 |  Meanwhile, a counterbalancing force will be applied to the chest instance, in order to
	 |  mimic a 'arm balancing action'.
	 | 
	 |  Finally, each segment fixtures will be manipulated to synchronize to the IK segment.
	 | 
	[-]
*/


#region Initialize some variables
fSticking = 0;
tarX = 0; tarY = 0;
tarReached = 0;
acx = 0; acy = 0;
#endregion

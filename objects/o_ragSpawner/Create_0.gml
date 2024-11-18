/*
	[1] Object Role
	 |
	 |  This object mainly act as database & spawner of a ragdoll.
	 |  In every step event, this object will calculate & manipulate most of the gravity- 
	 |  related parameters, and furthermore, maintains the balance of the ragdoll.
	 | 
	[-]

	[2] Mechanics
	 |
	 |	When you spawning a ragdoll, this object is created on the given position.
	 |
	 |	[User Event 1]
	 |		This Event is called from the script 'ragdoll_spawn' as a create event.
	 |		Every ragdoll body part will be created & adjusted to their proper positions,
	 |		then linked together by a few revolute joints.
	 |	
	 |	[Step Event]
	 |		First, the COM (Center of Mass) of the ragdoll will be calculated via some black magic.
	 |		Next, the balance of the entire body is stabilized by using the COM variable
	 |		'g_com' & 'g_bal' we got from earlier, to create two counter forces and applying
	 |		them to the chest & hip separately.
	 |		Finally, some other variables used to generate leg & arm animations will be prepared.
	 |	
	 |	As for explanation of the leg/arm animations, see in the relative object 'o_ragLeg' & 'o_ragArm'.
	 |	
	 |  !NOTE: Each body segment created by their spawner will have a variable called 'parent' inside,
	 |  which is actually pointing to its spawner instead of 'o_ragParent'.
	 |	
	[-]
*/
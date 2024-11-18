/*
	[1] Object Role
	 |
	 |  This object is mainly controlled by its parent object 'o_ragParent' and 
	 |  its controller object 'o_ragSpawner'.
	 |  
	 |  This object will mainly act as 2 type of body parts: chest / hip, 
	 |  depending on its tag & fixture that is given from o_ragSpawner on ragdoll creation.
	 |  You may refer to 'segTag' enumerator to find tag types (e.g. segTag.head).
	 |  
	[-]

	[2] Mechanics
	 |  
	 |  The reason why is a body needed two parts, is that the best solution of maintaining
	 |  the vertical balance without glitching out the whole ragdoll, is to apply two counter 
	 |  forces to chest & hip separately.
	 |  
	[-]
*/
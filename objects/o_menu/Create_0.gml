width=64;
height=104;

op_border=8;
op_space=16;
pos = 0;
var _c=c_white;

option[0,0]="Adventure";
option[0,1]="Battle";
option[0,2]="Sports";
option[0,3]="Minigames";
option[0,4]="ONLINE";
option[0,5]="Options";
option[0,6]="Quit Game";

option[1,0]="Character";
option[1,1]="Level";
option[1,2]="";
option[1,3]="Back";

option[2,0]="Start Game";
option[2,1]="Settings";
option[2,2]="Quit Game";



op_length=0;
menu_level=0;


// Menu element names. This will be what is actually drawn
menu[0] = "Adventure";
menu[1] = "Battle";
menu[2] = "Sports";
menu[3] = "Minigames";
menu[4] = "Options";
menu[5] = "Exit";

menuA[1] = "AR3NA";
menuA[2] = "Back";

menuB[0] = "Battle Arena";
menuB[1] = "Mana";
menuB[2] = "Sumo";
menuB[3] = "Snowball Fight";
menuB[4] = "";
menuB[5] = "Back";

menuS[0] = "Soccer";
menuS[1] = "Archery";
menuS[2] = "Paintball";
menuS[3] = "Capture the Flag";
menuS[4] = "Lasertag";
menuS[5] = "Back";

menuM[0] = "Birdpoop";
menuM[1] = "Snowman";
menuM[2] = "Catch the Pig";
menuM[3] = "Back";

menu_set=0;


// cursorLevitate will be used to keep a variable that
// oscillates and moves the cursor back and forth
cursorLevitate = 0;


// cursorTime will be used as the "angle" of a sin function
// in conjunction with cursorlevitate to oscillate the cursor
cursorTime = 0;

// The rate at which the cursor oscillates. Higher value means faster
leviRate = 1.5;


// Holds what menu element is selected. Ex: if selected = 1, 
// then the selected element is Options.
selected = 0;
selectLerp = 0; // Same as previous line but for lerp (smooth movement)
lerpAmt = 0.2; // Higher number -> faster cursor (between 0 and 1)


// Spacing between each menu element when drawn
spacing = 16;


// Color of the menu element when selected
selectedCol = c_gray;

// Color of the menu element when not selected
notSelectedCol = c_black;

// Game title color
titleCol = c_white;


// Title of your game
gameTitle = "Your Game";

// Size of the title
titleSize = 2;


// Button to move up the menu
upButt = vk_up;

// Button to move down the menu
downButt = vk_down;

// Button to confirm menu choice
confirmButt = vk_space;








//GPT
// Menu options
var menuOptions = [
    "Adventure",
    "Survival",
    "Cityscape",
    "Dungeons"
];
var selectedOption = 0; // Tracks the currently selected option

// Second menu options (One Player, Two Player, etc.)
var playerOptions = [
    "One Player",
    "Two Player",
    "Three Player",
    "Four Player",
    "Co-op",
    "Online"
];
var selectedPlayerOption = 0; // Tracks the currently selected player option

// Control options
var controlOptions = [
    "Keyboard & Mouse",
    "Gamepad",
    "Other"
];
var selectedControlOption = 0; // Tracks the currently selected control option

// Menu state
var showOptions = false; // Indicates whether the Options menu is visible

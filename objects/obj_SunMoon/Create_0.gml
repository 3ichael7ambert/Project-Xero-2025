/// @description Insert description here
// You can write your code in this editor


xCenter=room_width/2;
yCenter=room_height/2;

// Calculate angle based on current hour
var angle = (current_hour % 24) / 24 * 360; // Normalize to a 0-360 range

// Calculate position for the sun
var sunRadius = 10000; // Adjust the radius as needed
xSun = xCenter + lengthdir_x(angle, sunRadius);
ySun = yCenter + lengthdir_y(angle, sunRadius);
zSun = 5000;
// Calculate position for the moon
var moonRadius = 10000; // Adjust the radius as needed
xMoon = xCenter + lengthdir_x(angle + 180, moonRadius); // 180 degrees opposite to the sun
yMoon = yCenter + lengthdir_y(angle + 180, moonRadius);
zMoon = 5000;

target=objMazePlayer;

//lensflar

// Lens flare
    flareCount = 10;
    randImg = array_create(flareCount,noone);
	 // Generate random image indices for each lens flare
    for (var i = 0; i < flareCount; i++) {
        randImg[i] = irandom_range(2, 31);
    }













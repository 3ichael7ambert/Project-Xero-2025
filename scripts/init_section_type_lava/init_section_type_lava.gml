// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_section_type_lava(n){

			sec1 = generateRandomSection();
            sec2 = generateRandomSection();
            sec3 = generateRandomSection();
            sec4 = generateRandomSection();
            sec5 = generateRandomSection();
            sec6 = generateRandomSection();
            sec7 = generateRandomSection();
            sec8 = generateRandomSection();
            sec9 = generateRandomSection();
            sec10 = generateRandomSection();
			
}		

// Helper function to generate a random section with "e" at the first and last spots and more "o"s than "x"s
function generateRandomSection() {
    var section = ["e"];

    for (var i = 1; i < 31; i++) {
        if (i == 30) {
            section[i] = "e";
        } else {
            // Randomly choose between "x" and "o", ensuring there are more "o"s than "x"s
            if (choose("o", "o", "o", "x") == "x") {
                section[i] = "x";
            } else {
                section[i] = "o";
            }
        }
    }

    return section;
}


/*
section_type = irandom(n);

/// obj_section Create Event

// Define the section layouts (you can customize these arrays)
switch (section_type) {
	case 0:
sec1 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec2 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec3 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec4 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec5 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec6 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec7 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec8 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec9 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec10 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
		break;
case 1:
sec1 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec2 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec3 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec4 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec5 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec6 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec7 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec8 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec9 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
sec10 = ["e", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e",
		"o", "o", "x", "o","x", "o", "x", "o",
        "o", "x", "o", "x","o", "x", "o", "e"];
		break;
case 2:
sec1 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec2 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec3 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec4 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec5 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec6 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec7 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec8 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec9 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
sec10 = ["e", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "x",
		"x", "o", "o", "x","x", "o", "o", "e",];
		break;
}

}
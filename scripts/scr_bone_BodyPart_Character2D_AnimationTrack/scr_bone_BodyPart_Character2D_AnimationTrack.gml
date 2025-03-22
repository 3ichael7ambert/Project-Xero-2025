/// @description 2D Character Rigging System
/// A modular system for creating 2D character rigs with bone hierarchies

/// Bone Constructor - Base element for the skeletal system
function Bone(_name, _x, _y, _angle = 0, _length = 32) constructor {
    name = _name;
    x = _x;
    y = _y;
    angle = _angle;
    length = _length;
    parent = undefined;
    children = [];
    
    // Calculate end position based on angle and length
    endX = x + lengthdir_x(length, angle);
    endY = y + lengthdir_y(length, angle);
    
    // Method to add a child bone
    static AddChild = function(_bone) {
        _bone.parent = self;
        array_push(children, _bone);
        return _bone;
    }
    
    // Method to set bone position
    static SetPosition = function(_x, _y) {
        var dx = _x - x;
        var dy = _y - y;
        
        x = _x;
        y = _y;
        endX += dx;
        endY += dy;
        
        // Update all children recursively
        for (var i = 0; i < array_length(children); i++) {
            children[i].SetPosition(endX, endY);
        }
    }
    
    // Method to set bone rotation
    static SetRotation = function(_angle) {
        var oldEndX = endX;
        var oldEndY = endY;
        
        angle = _angle;
        endX = x + lengthdir_x(length, angle);
        endY = y + lengthdir_y(length, angle);
        
        // Calculate offset for children
        var dx = endX - oldEndX;
        var dy = endY - oldEndY;
        
        // Update all children recursively
        for (var i = 0; i < array_length(children); i++) {
            children[i].SetPosition(children[i].x + dx, children[i].y + dy);
        }
    }
    
    // Method to draw the bone (for debugging)
    static Draw = function() {
        draw_line_width(x, y, endX, endY, 2);
        draw_circle(x, y, 4, false);
        draw_circle(endX, endY, 4, false);
        
        // Draw all children
        for (var i = 0; i < array_length(children); i++) {
            children[i].Draw();
        }
    }
}

/// BodyPart Constructor - Attaches sprites to bones
function BodyPart(_bone, _sprite, _xOffset = 0, _yOffset = 0, _xScale = 1, _yScale = 1) constructor {
    bone = _bone;
    sprite = _sprite;
    xOffset = _xOffset;
    yOffset = _yOffset;
    xScale = _xScale;
    yScale = _yScale;
    
    // Set the sprite origin to its center by default
    sprite_set_offset(sprite, sprite_get_width(sprite) / 2, sprite_get_height(sprite) / 2);
    
    static Draw = function() {
        var drawX = bone.x + lengthdir_x(xOffset, bone.angle) - lengthdir_y(yOffset, bone.angle);
        var drawY = bone.y + lengthdir_y(xOffset, bone.angle) + lengthdir_x(yOffset, bone.angle);
        
        draw_sprite_ext(
            sprite,
            0,
            drawX,
            drawY,
            xScale,
            yScale,
            bone.angle,
            c_white,
            1
        );
    }
}

/// Character Constructor - Manages an entire character rig
function Character2D(_x, _y) constructor {
    x = _x;
    y = _y;
    rootBone = undefined;
    bodyParts = [];
    
    // Initialize the character's skeletal structure
    static Initialize = function() {
        // Create root bone (typically at the hip/pelvis)
        rootBone = new Bone("root", x, y, 0, 10);
        
        // Create torso
        var torso = rootBone.AddChild(new Bone("torso", rootBone.endX, rootBone.endY, -90, 30));
        
        // Create head
        var neck = torso.AddChild(new Bone("neck", torso.endX, torso.endY, -90, 10));
        var head1 = neck.AddChild(new Bone("head", neck.endX, neck.endY, -90, 20));
        
        // Create arms
        var leftShoulder = torso.AddChild(new Bone("leftShoulder", torso.endX, torso.endY, -180, 15));
        var leftElbow = leftShoulder.AddChild(new Bone("leftElbow", leftShoulder.endX, leftShoulder.endY, -180, 15));
        var leftHand = leftElbow.AddChild(new Bone("leftHand", leftElbow.endX, leftElbow.endY, -180, 10));
        
        var rightShoulder = torso.AddChild(new Bone("rightShoulder", torso.endX, torso.endY, 0, 15));
        var rightElbow = rightShoulder.AddChild(new Bone("rightElbow", rightShoulder.endX, rightShoulder.endY, 0, 15));
        var rightHand = rightElbow.AddChild(new Bone("rightHand", rightElbow.endX, rightElbow.endY, 0, 10));
        
        // Create legs
        var leftLeg = rootBone.AddChild(new Bone("leftLeg", rootBone.endX, rootBone.endY, -160, 20));
        var leftKnee = leftLeg.AddChild(new Bone("leftKnee", leftLeg.endX, leftLeg.endY, -160, 20));
        var leftFoot = leftKnee.AddChild(new Bone("leftFoot", leftKnee.endX, leftKnee.endY, -90, 10));
        
        var rightLeg = rootBone.AddChild(new Bone("rightLeg", rootBone.endX, rootBone.endY, -20, 20));
        var rightKnee = rightLeg.AddChild(new Bone("rightKnee", rightLeg.endX, rightLeg.endY, -20, 20));
        var rightFoot = rightKnee.AddChild(new Bone("rightFoot", rightKnee.endX, rightKnee.endY, -90, 10));
        
        return self;
    }
    
    // Add a body part to the character
    static AddBodyPart = function(_bone, _sprite, _xOffset = 0, _yOffset = 0, _xScale = 1, _yScale = 1) {
        var part = new BodyPart(_bone, _sprite, _xOffset, _yOffset, _xScale, _yScale);
        array_push(bodyParts, part);
        return part;
    }
    
    // Method to update the entire character (call this in Step event)
    static Update = function() {
        // You can add logic for animation, physics, or other updates here
        // This could include IK solvers, physics simulations, etc.
    }
    
    // Method to draw the character (call this in Draw event)
    static DrawCharacter = function() {
        // Draw all body parts
        for (var i = 0; i < array_length(bodyParts); i++) {
            bodyParts[i].Draw();
        }
    }
    
    // Method to draw the skeleton (for debugging)
    static DrawSkeleton = function() {
        if (rootBone != undefined) {
            rootBone.Draw();
        }
    }
    
    // Move the entire character
    static Move = function(_x, _y) {
        var dx = _x - x;
        var dy = _y - y;
        
        x = _x;
        y = _y;
        
        if (rootBone != undefined) {
            rootBone.SetPosition(rootBone.x + dx, rootBone.y + dy);
        }
    }
    
    // Pose a specific bone
    static PoseBone = function(_boneName, _angle) {
        var bone = FindBone(_boneName);
        if (bone != undefined) {
            bone.SetRotation(_angle);
            return true;
        }
        return false;
    }
    
    // Helper to find a bone by name (private method)
    static FindBone = function(_name) {
        return FindBoneRecursive(rootBone, _name);
    }
    
    // Recursive helper for FindBone
    static FindBoneRecursive = function(_currentBone, _name) {
        if (_currentBone == undefined) return undefined;
        
        if (_currentBone.name == _name) {
            return _currentBone;
        }
        
        for (var i = 0; i < array_length(_currentBone.children); i++) {
            var found = FindBoneRecursive(_currentBone.children[i], _name);
            if (found != undefined) {
                return found;
            }
        }
        
        return undefined;
    }
}






////COMMENTED OUT
/// Example usage in Create event of a controller object:
/*
// Create a new character
myCharacter = new Character2D(room_width/2, room_height/2).Initialize();

// Add body parts (assumes you have sprites defined)
myCharacter.AddBodyPart(myCharacter.FindBone("head"), spr_head);
myCharacter.AddBodyPart(myCharacter.FindBone("torso"), spr_torso);
myCharacter.AddBodyPart(myCharacter.FindBone("leftLeg"), spr_leg);
myCharacter.AddBodyPart(myCharacter.FindBone("rightLeg"), spr_leg, 0, 0, -1, 1); // Flipped sprite

// In Step event:
myCharacter.Update();

// In Draw event:
myCharacter.DrawCharacter();
// myCharacter.DrawSkeleton(); // Uncomment for debugging
*/




/// Animation System for the Character
function AnimationTrack(_character, _duration = 60) constructor {
    character = _character;
    duration = _duration;
    currentFrame = 0;
    isPlaying = false;
    isLooping = false;
    keyframes = {}; // Keyframes stored by bone name
    
    // Add a keyframe for a specific bone
    static AddKeyframe = function(_boneName, _frame, _angle) {
        if (!variable_struct_exists(keyframes, _boneName)) {
            keyframes[$ _boneName] = [];
        }
        
        // Store keyframe data
        array_push(keyframes[$ _boneName], {
            frame: _frame,
            angle: _angle
        });
        
        // Sort keyframes by frame
        array_sort(keyframes[$ _boneName], function(_a, _b) {
            return _a.frame - _b.frame;
        });
        
        return self;
    }
    
    // Play the animation
    static Play = function(_loop = false) {
        isPlaying = true;
        isLooping = _loop;
        currentFrame = 0;
        return self;
    }
    
    // Stop the animation
    static Stop = function() {
        isPlaying = false;
        currentFrame = 0;
        return self;
    }
    
    // Pause the animation
    static Pause = function() {
        isPlaying = false;
        return self;
    }
    
    // Update the animation (call this in Step event)
    static Update = function() {
        if (!isPlaying) return;
        
        // Apply the current keyframe values to all bones
        var boneNames = variable_struct_get_names(keyframes);
        for (var i = 0; i < array_length(boneNames); i++) {
            var boneName = boneNames[i];
            var boneKeyframes = keyframes[$ boneName];
            
            // Find the current and next keyframes
            var currentKf = undefined;
            var nextKf = undefined;
            
            for (var j = 0; j < array_length(boneKeyframes); j++) {
                if (boneKeyframes[j].frame > currentFrame) {
                    nextKf = boneKeyframes[j];
                    if (j > 0) currentKf = boneKeyframes[j-1];
                    break;
                } else if (j == array_length(boneKeyframes) - 1) {
                    currentKf = boneKeyframes[j];
                }
            }
            
            // Apply the interpolated angle
            if (currentKf != undefined) {
                var angle = currentKf.angle;
                
                // Interpolate between keyframes if we have a next keyframe
                if (nextKf != undefined) {
                    var t = (currentFrame - currentKf.frame) / (nextKf.frame - currentKf.frame);
                    angle = lerp(currentKf.angle, nextKf.angle, t);
                }
                
                character.PoseBone(boneName, angle);
            }
        }
        
        // Advance the animation
        currentFrame++;
        if (currentFrame >= duration) {
            if (isLooping) {
                currentFrame = 0;
            } else {
                isPlaying = false;
            }
        }
    }
}




/// Example of creating an animation:
/*
// Create an idle animation
var idleAnim = new AnimationTrack(myCharacter, 60);
idleAnim.AddKeyframe("leftLeg", 0, -160);
idleAnim.AddKeyframe("leftLeg", 30, -150);
idleAnim.AddKeyframe("leftLeg", 60, -160);

idleAnim.AddKeyframe("rightLeg", 0, -20);
idleAnim.AddKeyframe("rightLeg", 30, -30);
idleAnim.AddKeyframe("rightLeg", 60, -20);

// Play the animation
idleAnim.Play(true);

// In Step event:
idleAnim.Update();
*/




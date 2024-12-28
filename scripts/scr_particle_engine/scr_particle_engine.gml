/**
* @file particle_engine.js
* @brief Sets up and manages a particle engine system for use in a game.
*
* self script initializes a particle engine with two systems (top and bottom layers),
* provides methods for particle management, and allows for easy emission of particles
* from specified shapes or object bounding boxes.
*/

/**
* @brief Sets up the global particle engine.
*
* self function initializes a new particle system with two layers (top and bottom),
* defines methods for managing particles, and initializes the system.
* It also provides utility functions for emitting particles from various shapes.
*/
function setup_particle_engine() {
    /*
    Created by: Rayu Johnson
    */

    /// The global ParticleEngine object
    global.ParticleEngine = {
        /// Top particle system layer
        sysTop: part_system_create(),
        /// Bottom particle system layer
        sysBot: part_system_create(),
        /// List to store created particle types
        partList: [],
        
        /**
        * @brief Initializes the particle system layers with their respective depths.
        * @param depthHigh The depth for the top particle layer.
        * @param depthLow The depth for the bottom particle layer.
        */
        init: function(depthHigh=-3000, depthLow=0){
            part_system_depth(self.sysTop, depthHigh); ///< Set top system depth to -3000.
            part_system_depth(self.sysBot, depthLow); ///< Set bottom system depth to 0.
        },

        /**
        * @brief Adds a particle type to the managed list.
        * @param part The particle type to add.
        */
        addPart: function(part){
            array_push(self.partList, part);
        },

        /**
        * @brief Destroys the particle systems and their associated types.
        *
        * Cleans up by destroying both particle systems and all stored particle types.
        */
        destroy: function(){
            part_system_destroy(self.sysTop); ///< Destroy the top system.
            part_system_destroy(self.sysBot); ///< Destroy the bottom system.

            /// Remove and destroy all particle types
            var len = array_length(self.partList);
            for (var i = 0; i < len; i++){
                part_type_destroy(self.partList[i]);
            }
        },

        /**
        * @brief Emits particles randomly within a rectangular region.
        * @param x1 The left boundary of the rectangle.
        * @param y1 The top boundary of the rectangle.
        * @param x2 The right boundary of the rectangle.
        * @param y2 The bottom boundary of the rectangle.
        * @param top Boolean indicating whether to use the top or bottom system.
        * @param part_id The ID of the particle type to emit.
        * @param number The number of particles to emit.
        */
        burstBox: function(x1, y1, x2, y2, top, part_id, number){
            var sys = top ? self.sysTop : self.sysBot; ///< Select system based on `top`.
            repeat(number){
                var xx = irandom_range(x1, x2); ///< Random x within bounds.
                var yy = irandom_range(y1, y2); ///< Random y within bounds.
                part_particles_create(sys, xx, yy, part_id, 1); ///< Create particle.
            }
        },

        /**
        * @brief Emits particles randomly within a circular region.
        * @param x The x-coordinate of the circle's center.
        * @param y The y-coordinate of the circle's center.
        * @param radius The radius of the circle.
        * @param above Boolean indicating whether to use the top or bottom system.
        * @param part_id The ID of the particle type to emit.
        * @param number The number of particles to emit.
        */
        burstCircle: function(x, y, radius, above, part_id, number){
            var sys = above ? self.sysTop : self.sysBot; ///< Select system based on `above`.
            repeat(number){
                var distance = irandom(radius); ///< Random distance within radius.
                var angle = irandom(360); ///< Random angle in degrees.
                var xx = x + lengthdir_x(distance, angle); ///< X-coordinate in circle.
                var yy = y + lengthdir_y(distance, angle); ///< Y-coordinate in circle.
                part_particles_create(sys, xx, yy, part_id, 1); ///< Create particle.
            }
        },

        /**
        * @brief Clears all particles from both systems.
        */
        clear: function(){
            part_system_clear(self.sysTop); ///< Clear top system.
            part_system_clear(self.sysBot); ///< Clear bottom system.
        }
    };
    
    /// Initialize the particle engine
    global.ParticleEngine.init();
}

/**
* @brief Emits particles from a rectangular region.
* @param x1 The left boundary of the rectangle.
* @param y1 The top boundary of the rectangle.
* @param x2 The right boundary of the rectangle.
* @param y2 The bottom boundary of the rectangle.
* @param top Boolean indicating whether to use the top or bottom system.
* @param part_id The ID of the particle type to emit.
* @param number The number of particles to emit.
*/
function particles_emit_from_box(x1, y1, x2, y2, top, part_id, number){
    global.ParticleEngine.burstBox(x1, y1, x2, y2, top, part_id, number);
};

/**
* @brief Emits particles from a circular region.
* @param x1 The x-coordinate of the circle's center.
* @param y1 The y-coordinate of the circle's center.
* @param radius The radius of the circle.
* @param above Boolean indicating whether to use the top or bottom system.
* @param part_id The ID of the particle type to emit.
* @param number The number of particles to emit.
*/
function particles_emit_from_circle(x1, y1, radius, above, part_id, number){
    global.ParticleEngine.burstCircle(x1, y1, radius, above, part_id, number);
};

/**
* @brief Emits particles from the bounding box of an object.
* @param obj The object with a defined bounding box.
* @param top Boolean indicating whether to use the top or bottom system.
* @param part_id The ID of the particle type to emit.
* @param number The number of particles to emit.
*/
function particles_emit_from_bbox(obj, top, part_id, number){
    var x1 = obj.bbox_left; ///< Left boundary of the bounding box.
    var y1 = obj.bbox_top; ///< Top boundary of the bounding box.
    var x2 = obj.bbox_right; ///< Right boundary of the bounding box.
    var y2 = obj.bbox_bottom; ///< Bottom boundary of the bounding box.
    global.ParticleEngine.burstBox(x1, y1, x2, y2, top, part_id, number);
};


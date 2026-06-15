/******************************************************************************
This script allows you to select which faces on industrial_exp have a pipe connection

16JUN2026
This script is unlikely to receive any updates.
******************************************************************************/

include <lib/coreVars.scad>

module connectors_on_top() {
	for (i=[0:45:90]) {
		rotate([0, 0, i])
		intersection() {
			translate([0, 0, 46])
			cube([500, 500, 20], center = true);
			import(str(fsPrefix, dome_folder, "industrial_exp_blank.stl"));
		}
	}
}

module get_blank_chunk() {
	intersection() {
		cube([500, 500, 36]);
		rotate([0, 0, 45]) cube([500, 500, 36]);
		import(str(fsPrefix, dome_folder, "industrial_exp_blank.stl"));
	}
}

module get_pipe_chunk() {
	intersection() {
		cube([500, 500, 36]);
		rotate([0, 0, 45]) cube([500, 500, 36]);
    	import(str(fsPrefix, dome_folder, "industrial_exp_full.stl"));
	}
}

module generate_entire_level(faces) {
	for ( i = [1:8]) {
		rotate([0, 0, i*45]) {
			if (len(search(i, faces)) > 0) {
				get_pipe_chunk();
			} else {
				get_blank_chunk();
			}
		}
	}
}

faces_for_pipe = [1, 5];


union() {
	// Generate single level
	generate_entire_level(faces_for_pipe);

	// Add second level, in case you want to print larger pieces
	translate([0, 0, 36]) {
		generate_entire_level();
		connectors_on_top();

		for (i = [0:45:360]) {
			rotate([0, 0, i]) translate([39, 0, 3]) cube([5, 6, 6], center=true);
		}
	}

	// Add connectors to top for alignment
	//translate([0, 0, -0.1]) connectors_on_top();

	// Add "brim" to stop bottom level being a dum-dum
	// (This may be unnecessary depending on your printer settings)
	*for (i = [0:45:360]) {
		rotate([0, 0, i]) translate([39, 0, 0.1]) cube([5, 6, 0.2], center=true);
	}
}
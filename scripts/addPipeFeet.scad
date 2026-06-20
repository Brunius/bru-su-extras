include <lib/coreVars.scad>
include <lib/commonFuncs.scad>
include <lib/pipelineFuncs.scad>

feetPath = str(pipes_2_folder, "PipeStand.stl");

module newFoot() {
	translate([0, 0, 7.9/2]) rotate([0, -90, 0]) import(feetPath, center=true);

	// Add a tiny bit to where it contacts the pipe to prevent z-fighting
	translate([0, 0, 30.5/2]) rotate([0, 90, 0]) difference() {
		cylinder(h=5.5, d=23, center=true);
		cylinder(h=500, d=19, center=true);
		// Trim off the top
		translate([-500/2+7.35, 0, 0]) cube([500, 500, 500], center=true);
	}
}

// Used for reference - not present in output
%translate([-30.5/2+1-30.5, 0, 0]) import(str(pipes_2_folder, "T_305.stl"));


// Foot at 0/0
*newFoot();


union() {
translate([30.5/2, 0, 0])
	newFoot();
translate([-30.5/2, 0, 0])
	newFoot();

// Add pipe item
nameOfPipeFile = "61_T_V1.stl";
lengthInUnits = 2; // This is in units of 30.5mm - so 2 == 61mm
translate([30.5*(lengthInUnits-1), 0, 30.5/2-1]) 
	rotate([0, -90, 0])
	import(str(pipes_2_folder, nameOfPipeFile));
}

translate([0, 0, 30.5]) import(str(pipes_2_folder, "305_Straight.stl"));
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
%*translate([-30.5/2+1-30.5, 0, 0]) import(str(pipes_2_folder, "T_305.stl"));

module pipes2(filename, length = 1) {
	addFeet(length)
		translate([30.5*(length/2), 0, 30.5/2-1]) 
		rotate([0, -90, 0])
		import(str(pipes_2_folder, filename));
}

module addFeet(length = 1) {
	for (i = [-(length-1)/2:(length-1)/2]) {
		translate([i*30.5, 0, 0])
			newFoot(); 
	}

	children();
}

module cutoutHollow(length = 1) {
	difference() {
		union() {
			children();
		}
		translate([0, 0, 30.5/2-1]) 
			rotate([0, 90, 0]) 
			translate([0, 0, -(length-1)/2*30.5]) 
			pipelineCentreCutout();
		translate([0, 0, 30.5/2-1]) 
			rotate([0, -90, 0]) 
			translate([0, 0, -(length-1)/2*30.5]) {
				pipelineCentreCutout();
				cylinder(h=50000, d=interfaceMagnetDiameter2+tolerance*2, center=true);
			}
	}

}

*cutoutHollow(1)
	addFeet(1)
		translate([-303.15, 164.82, 1.25])
		import(str(pipes_folder, "30.5_S.stl"));

*cutoutHollow(2)
	addFeet(2)
		translate([-30.5/2-303.15, 375, 1.25])
		import(str(pipes_folder, "61_S.stl"));

*difference() {
cutoutHollow(2)
	addFeet(2)
		translate([-30.5/2-303.15, 195.615, 1.25])
		import(str(pipes_folder, "61_T1.stl"));
	translate([0, 0, 30.5/2-1]) rotate([-90, 0, 0]) pipelineCentreCutout();
}

*cutoutHollow(3)
	addFeet(3)
		translate([-30.5/2-303.15-30.5/2, 375+30.25, 1.25])
		import(str(pipes_folder, "91.5_S.stl"));

*cutoutHollow(4)
	addFeet(4)
		translate([56, 458, 1.25])
		import(str(pipes_folder, "ST1_clean_full.stl"));

cutoutHollow(4)
	addFeet(4)
		translate([0, -1, 1])
		translate([0, 0, 28.5/2])
		import(str(pipes_folder, "ST3_full.stl"), center=true);


*#translate([30.5*1.5, 0, 0])
	pipes2("305_Straight.stl");
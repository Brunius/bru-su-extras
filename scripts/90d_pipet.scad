include <lib/coreVars.scad>
include <lib/commonFuncs.scad>
include <lib/pipelineFuncs.scad>

difference() {
	union() {
		translate([0, 0, 30.5]) 
			rotate([0, -90, 0]) 
			import(str(pipes_2_folder, "90d_standard.stl"));

		difference() {
			translate([-26/2-1.25, 1+30.5/2, 30.5/2-1])
				rotate([90, 0, 0])
				import(str(pipes_2_folder, "305_Straight.stl"));
			translate([-250, 0, 0]) 
				cube([500, 500, 500]);
		}
	}
	#translate([-26/2-1.25, 1, 30.5/2-1])
		rotate([-90, 0, 0]) 
		pipelineCentreCutout();
	translate([-26/2-1.25, 0, 30.5/2])
		rotate([0, 0, 0]) 
		pipelineCentreCutout();
	translate([-30.5/2+1, 0, 0]) {
		cylinder(d=15, h=22.5);
		translate([10, 0, 21]) 
			rotate([90, -90, 0]) 
			rotate_extrude(90) translate([10, 0]) circle(d=15);
	}
}
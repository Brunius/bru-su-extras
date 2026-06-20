include <lib/coreVars.scad>
include <lib/commonFuncs.scad>
include <lib/pipelineFuncs.scad>


/******************************************************************************
Constructs a 90d pipe with an outlet on the side (looking from above, the
original 90d outlet is at 12 o clock, while the side outlet is at 3 o clock)
******************************************************************************/
module sideWaysOutlet() {
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
		translate([-26/2-1.25, 1, 30.5/2-1])
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
}

/******************************************************************************
Constructs a 90d pipe with an outlet on the front (looking from above, the
original 90d outlet is at 12 o clock, while the front outlet is at 6 o clock)
******************************************************************************/
module frontWaysOutlet() {
	difference() {
		union() {
			translate([0, 0, 30.5]) 
				rotate([0, -90, 0]) 
				import(str(pipes_2_folder, "90d_standard.stl"));

			difference() {
				//translate([-26/2-1.25, 1+30.5/2, 30.5/2-1])
				translate([2, 0, 30.5/2-1])
					rotate([0, -90, 0])
					import(str(pipes_2_folder, "305_Straight.stl"));
				translate([-30.5/2, -250, 0]) 
					cube([500, 500, 500]);
			}
		}
		translate([-26/2, 0, 30.5/2-1])
			rotate([0, 90, 0]) 
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
}

frontWaysOutlet();
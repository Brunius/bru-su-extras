/******************************************************************************
16JUN2026
This script is unlikely to receive any updates.
******************************************************************************/

include <lib/coreVars.scad>

pipe_radius = 6;

%import(str(fsPrefix, dome_folder, "industrial_exp_full.stl"));
%translate([0, 0, 36]) import(str(fsPrefix, dome_folder, "industrial_exp_full.stl"));
	
rotate([0, 0, 180+90+22.5]) 
*translate([50, 0, 0])
	import("indutrial_pipe_90d.stl");

module connectorPort() {
	translate([0, -39.25, 21]) {
		rotate([90, 0, 0]) {
		cylinder(h=10.75, r=pipe_radius);
		cylinder(h=3, r1=6.5, r2=pipe_radius);
		}
		translate([0, -10.75, 0]) {
			sphere(r=pipe_radius);
		}
	}
}

module verticalPipeSupportStrut() {
	cylinder(r=pipe_radius+1.5, h=1.5, center=true);
	translate([pipe_radius+0.75, 11.25/2, 0]) cube([1.5, 11.25, 1.5], center=true);
	translate([-(pipe_radius+0.75), 11.25/2, 0]) cube([1.5, 11.25, 1.5], center=true);
}

module horizontalPipeSupportStrut() {
	#translate([0, 0, 21]) rotate([-90, 0, 90]) {
		cylinder(r=pipe_radius+1.5, h=1.5, center=true);
		translate([pipe_radius+0.75, 21/2, 0]) cube([1.5, 21, 1.5], center=true);
		translate([-(pipe_radius+0.75), 21/2, 0]) cube([1.5, 21, 1.5], center=true);
	}
}

module connectorVertical() {
	connectorPort();
	translate([0, 0, 36]) connectorPort();
	translate([0, -39.25-10.75, 21+36/2]) {
		cylinder(r=pipe_radius, h=36, center=true);
		translate([0, 0, 8]) verticalPipeSupportStrut();
		translate([0, 0, -8]) verticalPipeSupportStrut();
	}
}

module connectorHorizontal(angle=45) {
	connectorPort();
	rotate([0, 0, angle]) connectorPort();
	rotate([0, 0, -90]) rotate_extrude(angle=angle) translate([50, 21, 0]) circle(r=pipe_radius);
	translate([0, -50, 0]) horizontalPipeSupportStrut();
}

rotate([0, 0, 22.5]) {
	connectorHorizontal(45);
	connectorVertical();
}
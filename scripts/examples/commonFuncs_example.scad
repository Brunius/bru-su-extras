include <../lib/coreVars.scad>
include <../lib/commonFuncs.scad>
include <../lib/pipelineFuncs.scad>

mirror([0, 0, 1]) {
	// Simple pipeline interface (note that the internals are NOT cutout)
	pipelineInterface();

	// Pipeline interface w/ internals cut
	translate([heightMultiple, 0, 0]) difference() {
		pipelineInterface();
		pipelineCentreCutout();
	}
}

// Attaching pipeline to a cube (without cutout)
translate([heightMultiple*3, 0, 0]) {
	difference() {
		union() {
		translate([0, 0, (heightMultiple-interfaceMagnetHeight)])
			cube([
				(heightMultiple-interfaceMagnetHeight)*2,
				(heightMultiple-interfaceMagnetHeight)*2,
				(heightMultiple-interfaceMagnetHeight)*2
			], center = true);
		translate([0, heightMultiple/2, heightMultiple/2]) rotate([90, 0, 0]) pipelineInterface();
		}
		translate([0, heightMultiple/2, heightMultiple/2]) rotate([90, 0, 0]) pipelineCentreCutout();
	}
}
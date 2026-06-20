include <lib/coreVars.scad>
include <lib/commonFuncs.scad>
include <lib/pipelineFuncs.scad>

shimLength = 2;

difference() {
	union() {
		// Generate shim outer
		cylinder(h=shimLength, d=interfaceOuterDiameter, center=true);

		// Generate inner/connectorzone
		cylinder(h=interfaceInnerHeight*2+shimLength, d=interfaceInnerDiameter-tolerance*2, center=true);
	}
	cylinder(h=500, d=interfaceInnerDiameter-wallThickness*2, center=true);
}
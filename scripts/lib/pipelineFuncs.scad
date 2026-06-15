include <coreVars.scad>
include <commonFuncs.scad>

/******************************************************************************
Definition for a blank pipe
Centered on 0,0
Oriented along the Z axis
******************************************************************************/
module blankStraightPipe(lengthUnits = 1) {
	translate([0, 0, -30.5/2*(lengthUnits-1)]) difference() {
		union() {
			// both ends of the pipe
			pipelineInterface();
			translate([0, 0, heightMultiple*(lengthUnits-1)])
				rotate([180, 0, 0])
				pipelineInterface();
			
			// the blank featureless pipe itself
			translate([0, 0, -heightMultiple/2]) cylinder(h=heightMultiple*lengthUnits, d=pipeOuterDiameter);
		}

		// remove cutouts at ends for magnet placement
		pipelineCentreCutout();
		translate([0, 0, heightMultiple*(lengthUnits-1)])
			rotate([180, 0, 0])
			pipelineCentreCutout();

		// remove centre, to make it hollow like the SU originals
		cylinder(h=500, d=interfaceMagnetDiameter2, center=true);
	}
}
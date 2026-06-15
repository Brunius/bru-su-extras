include <coreVars.scad>

/******************************************************************************
Definition for the centre cutout of a pipeline interface
Centered on the 0,0 location of a single length pipe, in the -Z direction
******************************************************************************/
module pipelineCentreCutout () {
	translate([0, 0, -heightMultiple/2]) {
		translate([0, 0, -0.01])
			cylinder(
				h=interfaceInnerHeight+0.01,
				d=interfaceInnerDiameter+tolerance*2
			);
		translate([0, 0, interfaceInnerHeight-0.01])
			cylinder(
				h=interfaceMagnetHeight+0.02,
				d1=interfaceMagnetDiameter1+tolerance*2,
				d2=interfaceMagnetDiameter2+tolerance*2
			);
	}
}

/******************************************************************************
Definition for a pipeline interface
Centered on the 0,0 location of a single length pipe, in the -Z direction
******************************************************************************/
module pipelineInterface() {
	translate([0, 0, -heightMultiple/2]) {
		difference() {
			union() {
				cylinder(h=interfaceOuterHeight, d=interfaceOuterDiameter);
				translate([0, 0, interfaceInnerHeight]) cylinder(h=interfaceMagnetHeight,
					d1=interfaceMagnetDiameter1+wallThickness*2,
					d2=interfaceMagnetDiameter2+wallThickness*2);
			}
			pipelineCentreCutout();
		}
	}
}
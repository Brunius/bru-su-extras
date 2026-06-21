include <lib/coreVars.scad>
include <lib/commonFuncs.scad>
include <lib/pipelineFuncs.scad>

// Central hole size
centreHole = 40;

// Grid multiples to lay out walkways on
gridSize = 61;

// Walkway thickness (for generation of edge banding)
walkwayThickness = 5;

// Width of banding
bandingWidth = walkwayThickness;

module createWalkwayGrid(units = [1, 1], gS = gridSize) {
	xUnits = units[0];
	yUnits = units[1];
	for (i = [-(xUnits-1)/2 : (xUnits-1)/2]) {
		for (j = [-(yUnits-1)/2 : (yUnits-1)/2]) {
			translate([i*gS, j*gS, 0]) {
				// This currently always uses the same walkway - 
				// there's no reason you couldn't swap the walkway,
				// or randomly assign one each time
				*import(str(sm_support_pillars, "Walkway_61x61_1.stl"), center=true);

				// In fact, here's a snippet to select a random one each time
				listOfWalkways = [
					str(sm_support_pillars, "Walkway_61x61_1.stl"),
					str(sm_support_pillars, "Walkway_61x61_2.stl"),
					str(sm_support_pillars, "Walkway_61x61_3.stl")
				];

				numberOfWalkway = ceil(rands(0, len(listOfWalkways), 1)[0]);
				import(listOfWalkways[numberOfWalkway-1], center=true);
			}
		}
	}
}

module makeCutoutWalkway(cH = centreHole, gS = gridSize) {
	// Compute how many walkways are needed to surround centreHole
	walkwayUnits = ceil(cH/gS);


	difference() {
		createWalkwayGrid([walkwayUnits, walkwayUnits], gS);
		cylinder(h=5000, d=cH+tolerance*2, center=true);
	}
}

module addCutoutEdging(cH = centreHole) {
	difference() {
		cylinder(h=walkwayThickness, d=cH+bandingWidth*2+tolerance*2, center=true);
		cylinder(h=5000, d=cH+tolerance*2, center=true);
		

		// Get arty and add some screw holes or something
		//numScrewHoles = 8;
		
		// Calculate number of screw holes by distance between, rather than by direct integer
		distanceBetweenScrews = 15;
		perimeter = 2*3.141*(cH/2+tolerance+bandingWidth/2);
		numScrewHoles = ceil((perimeter/distanceBetweenScrews)/4)*4;
		for (i = [1:numScrewHoles]) {
			rotate([0, 0, i*(360/numScrewHoles)])
				translate([cH/2+tolerance+bandingWidth/2, 0, 0])
				cylinder(h=5000, d=bandingWidth/4);
		}
	}
}

module walkwayComplete(cH = centreHole, gS = gridSize) {
	makeCutoutWalkway(cH+bandingWidth*2, gS);
	addCutoutEdging(cH);
}

walkwayComplete(80);
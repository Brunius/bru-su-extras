include <../lib/coreVars.scad>
include <../lib/commonFuncs.scad>
include <../lib/pipelineFuncs.scad>

translate([0, 0, 0]) {
	// 1-unit pipe
	blankStraightPipe();
}
translate([0, heightMultiple, 0]) {
	// 2-unit pipe
	blankStraightPipe(2);
}
translate([0, heightMultiple*2, 0]) {
	// ...you get the idea
	blankStraightPipe(3);
}
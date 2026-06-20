// Minimum angle for a line segment, in degrees
// If preview - 3°. If build, 1°
$fa= $preview ? 3 : 1;
// Minimum length of line segment
// If preview - 0.5. If build, 0.05
$fs= $preview ? 0.5 : 0.05;

// Filesystem prefix pointing to SevenUnited download folder
fsPrefix = "../../";
// Include list of folder names
include <fsFolders.scad>

// Tolerances to allow push-fit / etc
tolerance = 0.1; // Per side

// Desired wall thickness
wallThickness = 2;

// Definitions for pipeline end (for interface)
// These are derived from SevenUnited designs as I have no access to original SM items
interfaceOuterDiameter = 26;
interfaceOuterHeight = 2.5;
interfaceInnerDiameter = 20;
interfaceInnerHeight = 2;

// Definitions for pipeline end cone/magnet interface
interfaceMagnetHeight = 10;
interfaceMagnetDiameter1 = 19.5;
interfaceMagnetDiameter2 = 12;

// Pipe straight-through (ie od of centre)
pipeOuterDiameter = 18;

// Multiplier to use for length of pipes / height of items
// 30.5 matches SM parts (according to multiple source)
heightMultiple = 30.5;
knobThickness=7;
spokeNippleSplineCoreDia=5.2;
spokeNippleSplineOuterDia=6.4;  // from Park tool SW-12 specs
spokeNippleSplineToothWidth=1.2;
spokeNippleSplineTolerance=0.15;
spokeDia=3.3; // actual spoke diameter, measured
spokeSlotClearance=0.1; // space to allow on either side for spoke to go through the slot
splineCount=7;

knobCoreOuterDia=20; // adjust to allow snug fit for hex flat - box end wrench
knobCoreThickness=9;

spokeNippleSplineToothHeight=spokeNippleSplineOuterDia-spokeNippleSplineCoreDia;
knobDia=55;

toothSlotAlignmentAdjust=360/(splineCount*2);  // degrees


overlap=0.01;
$fn=50;

difference() {
    union() {
        cylinder(d=knobDia, h=knobThickness);
        cylinder(d=knobCoreOuterDia, h=knobThickness+knobCoreThickness, $fn=6);
    }
    for (i=[1:splineCount-1]) {
        rotate([0,0,360/splineCount*i])
            translate([knobDia/2,0,-overlap])
                //cylinder(d=knobDia/3, h=knobThickness+overlap*2);
                translate([-knobDia/12,-knobDia/12,0])
                cube([knobDia/3,knobDia/6,knobThickness+overlap*2]);
    }
    translate([0,0,-overlap])
        spokeNippleSplineShape();
    // Spoke insertion slot
    translate([0,-(spokeDia+spokeSlotClearance*2)/2,-overlap])
        cube([knobDia/2+overlap,(spokeDia+spokeSlotClearance*2),
            knobThickness+knobCoreThickness+overlap*2]);

}

module spokeNippleSplineShape() {
    union() {
        cylinder(d=spokeNippleSplineCoreDia+spokeNippleSplineTolerance*2, 
                h=knobThickness+knobCoreThickness+overlap*2);
        for (i=[0:splineCount-1]) {
            rotate([0,0,toothSlotAlignmentAdjust+(360/splineCount*i)])
                translate([0,-spokeNippleSplineToothWidth/2-spokeNippleSplineTolerance,0])
                    cube([spokeNippleSplineCoreDia/2+spokeNippleSplineToothHeight+spokeNippleSplineTolerance, 
                        spokeNippleSplineToothWidth+spokeNippleSplineTolerance*2,
                        knobThickness+knobCoreThickness+overlap*2]);
        }
    }
}
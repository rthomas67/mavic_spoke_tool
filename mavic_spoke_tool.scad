knobThickness=7;
spokeNippleSplineCoreDia=5.5;
spokeNippleSplineOuterDia=7;
spokeNippleSplineToothWidth=1.75;
spokeNippleSplineTolerance=0.15;
spokeDia=4;

spokeNippleSplineToothHeight=spokeNippleSplineOuterDia-spokeNippleSplineCoreDia;
knobDia=spokeNippleSplineCoreDia*10;


overlap=0.01;
$fn=50;

difference() {
    union() {
        cylinder(d=knobDia, h=knobThickness);
        cylinder(d=spokeNippleSplineCoreDia*3, h=knobThickness*2);
    }
    for (i=[0:6]) {
        rotate([0,0,360/6*i])
            translate([knobDia/2,0,-overlap])
                cylinder(d=knobDia/3, h=knobThickness+overlap*2);
    }
    translate([0,0,-overlap])
        spokeNippleSplineShape();
    // Spoke insertion slot
    translate([0,-spokeDia/2,-overlap])
        cube([knobDia/2+overlap,spokeDia,knobThickness*2+overlap*2]);

}

module spokeNippleSplineShape() {
    union() {
        cylinder(d=spokeNippleSplineCoreDia+spokeNippleSplineTolerance*2, h=knobThickness*2+overlap*2);
        for (i=[0:6]) {
            rotate([0,0,360/6*i])
                translate([0,-spokeNippleSplineToothWidth/2-spokeNippleSplineTolerance,0])
                    cube([spokeNippleSplineCoreDia/2+spokeNippleSplineToothHeight+spokeNippleSplineTolerance, 
                        spokeNippleSplineToothWidth+spokeNippleSplineTolerance*2,knobThickness*2+overlap*2]);
        }
    }
}
barDiameter=10.5;
angle=37;
$fn=64;

connectorOffset=40;
connectorWidth=20;
connectorHeight=110;
connectorDepth=15;
connectorDrop=30;

cutOutLength=200;
cutOutClip=0.85;

verticalRotation=30;

mirror([0,0,0])
    pannierClip();

module pannierClip() {
    rotate([0,-90,0])
    translate([connectorOffset,0,0]){
    difference(){
        color("blue")
        translate([-connectorOffset,0,-connectorDrop])
            rotate([90,0,0])
                linear_extrude(connectorDepth,center=true)
                    square([connectorWidth,connectorHeight]);
            
        cutOut(cutOutLength, barDiameter, angle, cutOutClip);
    }
    //cutOut(cutOutLength, barDiameter, angle, cutOutClip);
}
}

module cutOut(length, diameter, angle, clip){
    color("red") 
    rotate([0,-verticalRotation,0]) {
        // Upper Bar
        bar(diameter, length);
        translate([diameter,0,0])
            linear_extrude(length)
                square([diameter*2,diameter*clip],center=true);
        translate([diameter*5.5,0,0])
            linear_extrude(length)
                square([diameter*10,diameter*2],center=true);
        //Lower Bar
        rotate([0,-angle,0]) {
            bar(diameter, length);
            translate([-diameter*1,0,0])
                linear_extrude(length)
                    square([diameter*2,diameter*clip],center=true);
            translate([-diameter*4.5,-diameter/2*clip,0])
                linear_extrude(length)
                    square([diameter*4,diameter*2]);
        }
    }
}

module bar(diameter, length) {
    linear_extrude(length)
        circle(d = diameter);
}
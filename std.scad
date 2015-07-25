include <const.scad>

module LM8UU() {
    difference() {
        cylinder(r = LM8UU_d_out/2, h = LM8UU_h, $fn = 30);
        translate([0,0,-1]) cylinder(r = LM8UU_d_in/2, h = LM8UU_h + 2, $fn = 30);
    }
}

module endStop() {
    //板
    difference() {
        translate([0,0,5]) 
            rotate([-15,0,0])
                cube([4.16, 12, 0.5], center = true);
        translate([0,0,1])
            cube([1.5,20,10],center = true);
    }
    //主体
    difference() {
        cube([endStopWidth, endStopLength, endStopHeight], center = true);
        //孔
        translate([0,6.10/2,-2.1]) 
            rotate([0,90,0]) 
                cylinder(r = endStopHoleRadius, h = 10, center = true, $fn = 30);
        //孔
        translate([0,-6.10/2,-2.1]) 
            rotate([0,90,0]) 
                cylinder(r = endStopHoleRadius, h = 10, center = true, $fn = 30);
 
    }
    //脚
    translate([0,0,-4]) 
        cube([0.5,0.2,3], center = true);
    translate([0,5.5,-4]) 
        cube([0.5,0.2,3], center = true);
    translate([0,-5.5,-4]) 
        cube([0.5,0.2,3], center = true);
}

module screwsM2_20() {
    screws(m2_head_d/2, m2_head_h, m2_body_d/2, m2_20_body_h);
}

module screws(headR, headH, bodyR, bodyH) {
    translate([0,0,(headH + bodyH)/2]) 
        cylinder(r = headR, h = headH, center = true, $fn = 30);
    cylinder(r = bodyR, h =  bodyH, center = true, $fn = 30);
}

module test() {
//    LM8UU();
//    endStop();
    screwsM2_20();
}

test();
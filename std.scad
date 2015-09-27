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

module servoArm1() {
difference() {
    union() {
        h_tmp = servo_9g_small_h;
        //big circle
        cylinder(r = servo_9g_arm1_r2, h = h_tmp, $fn = 100, center = false);
        //small circle
        translate([0,servo_9g_length_of_circle,0]) {
            cylinder(r = servo_9g_arm1_r1, h = h_tmp, $fn = 100, center = false);
        }
        //polygon
        linear_extrude(height = h_tmp, center = false) {
            polygon(points=[
                            [0,0],
                            [servo_9g_arm1_r2,0],
                            [servo_9g_arm1_r1,servo_9g_length_of_circle],
                            [0,servo_9g_length_of_circle]
                            ], paths=[[0,1,2,3]]);
        }
        mirror() {
        linear_extrude(height = h_tmp, center = false) {
            polygon(points=[
                            [0,0],
                            [servo_9g_arm1_r2,0],
                            [servo_9g_arm1_r1,servo_9g_length_of_circle],
                            [0,servo_9g_length_of_circle]
                            ], paths=[[0,1,2,3]]);
            }
        }
        //pipe
        translate([0,0,0]) {
            cylinder(r=servo_9g_arm1_r2, h=servo_9g_h, $fn=100);
        }
    }
    translate([0,0,-1]) {
        cylinder(r=(servo_9g_arm1_r2-servo_9g_hole_t), h=(servo_9g_h+2), $fn=100);
    }
}
}

module pipe(r_out, t, h, center = true) {
    difference() {
        cylinder(r = r_out, h = h, center = center, $fn = 100);
        translate([0,0,-1]) {
            cylinder(r = (r_out - t), h = (h + 2), center = center, $fn = 100);
        }
    }
}

module test() {
//    LM8UU();
//    endStop();
//    screwsM2_20();
    servoArm1();
}

test();
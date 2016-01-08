include <const.scad>

module LM8UU() {
    difference() {
        cylinder(r = LM8UU_d_out/2, h = LM8UU_h, $fn = 100);
        translate([0,0,-1]) cylinder(r = LM8UU_d_in/2, h = LM8UU_h + 2, $fn = 100);
    }
}

module belling608() {
    pipe(r_out = r_out_608, t = (r_out_608 - r_in_608), h = h_608);
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

module screwsM4_10() {
    screws(m4_head_d/2, m4_head_h, m4_body_d/2, m4_10_body_h);    
}

module screws(headR, headH, bodyR, bodyH) {
    translate([0,0,(headH + bodyH)/2]) 
        cylinder(r = headR, h = headH, center = true, $fn = 30);
    cylinder(r = bodyR, h =  bodyH, center = true, $fn = 30);
}

module servoArm1() {
difference() {
    union() {
        h_tmp = servo_9g_arm1_small_h;
        //big circle
        cylinder(r = servo_9g_arm1_r2, h = h_tmp, $fn = 100, center = false);
        //small circle
        translate([0,servo_9g_arm1_length_of_circle,0]) {
            cylinder(r = servo_9g_arm1_r1, h = h_tmp, $fn = 100, center = false);
        }
        //polygon
        linear_extrude(height = h_tmp, center = false) {
            polygon(points=[
                            [0,0],
                            [servo_9g_arm1_r2,0],
                            [servo_9g_arm1_r1,servo_9g_arm1_length_of_circle],
                            [0,servo_9g_arm1_length_of_circle]
                            ], paths=[[0,1,2,3]]);
        }
        mirror() {
        linear_extrude(height = h_tmp, center = false) {
            polygon(points=[
                            [0,0],
                            [servo_9g_arm1_r2,0],
                            [servo_9g_arm1_r1,servo_9g_arm1_length_of_circle],
                            [0,servo_9g_arm1_length_of_circle]
                            ], paths=[[0,1,2,3]]);
            }
        }
        //pipe
        translate([0,0,0]) {
            cylinder(r=servo_9g_arm1_r2, h=servo_9g_arm1_h, $fn=100);
        }
    }
    translate([0,0,-1]) {
        cylinder(r=(servo_9g_arm1_r2-servo_9g_arm1_hole_t), h=(servo_9g_arm1_h+2), $fn=100);
    }
}
}

module pipe(r_out, t, h, center = true, a_fn=16) {
    difference() {
        cylinder(
            r = r_out,
            h = h,
            center = center,
            $fn = a_fn
        );
        translate([0,0,-1]) {
            cylinder(
                r = (r_out - t), 
                h = (h + 4),
                center = center,
                $fn = a_fn
            );
        }
    }
}

module test() {
//    LM8UU();
//    endStop();
//    screwsM2_20();
//    servoArm1();
//    rect(w=10,h=10,r=2);
//    %square([10,10],center=true);
//    servo_9g();
//    servo9gRotator1();
    servo_sg5010(false,false,0);
    joint_sg5010();
//    arm_sg5010();
//    battery_18650();
}

//servo_sg5010_arm1_l = 38.6;
//servo_sg5010_arm1_w = 12.78l
//servo_sg5010_arm1_h = 5.83;
//servo_sg5010_arm1_wings_h = 2.38;
//servo_sg5010_arm1_wings_w1 = 9.3;
//servo_sg5010_arm1_wings_w2 = 5.28;
//servo_sg5010_arm1_wings_l = 14.74;
//servo_sg5010_arm_axis_d = 8.84;
//servo_sg5010_arm_axis_t = 1.8;

module mock_axis_sg5010(a_fn=16) {

    //cylinder for mock axis
    color([1,0,1]) {
        translate([
            0,
            servo_sg5010_l/2-servo_sg5010_axis_center_right_margin,
            -(servo_sg5010_h+2)/2]
        ) {
            cylinder(
                center=true,
                d=servo_sg5010_axis_plane_d-1,
                h=2,
                $fn=a_fn);
        }
        translate([
            0,
            servo_sg5010_l/2-servo_sg5010_axis_center_right_margin,
            -(servo_sg5010_h)/2-servo_sg5010_axis_h]
        ) {
            cylinder(
                center=true,
                d=servo_sg5010_axis_d,
                h=servo_sg5010_axis_h,
                $fn=a_fn);
        }
    }

}

module joint_bottom_frame_sg5010(a_fn=16) {
    //bottom frame
    difference() {
        union() {
            //bottom panel
            translate([0,0,-(servo_sg5010_h+2)/2]) {
                cube(
                    center=true,
                    [servo_sg5010_w,servo_sg5010_l,
                    2]);
            }
        }
        //cylinder for hole
        union() {
            translate([
                0,
                servo_sg5010_l/2-servo_sg5010_axis_center_right_margin,
                0]) {
                cylinder(
                    center=true,
                    d=servo_sg5010_axis_plane_d,
                    h=60,
                    $fn=a_fn);
            }
            translate([
                0,
                -(servo_sg5010_l/2-servo_sg5010_axis_center_right_margin),
                0]) {
                cylinder(
                    center=true,
                    d=servo_sg5010_axis_plane_d,
                    h=60,
                    $fn=a_fn);
            }
        }

    }
    
    //x
    translate([
        (servo_sg5010_w+2)/2,
        6,
        -(servo_sg5010_h)/2+1]) {
        cube(center=true,[2,3,6]);
    }
    translate([
        (servo_sg5010_w+2)/2,
        -6,
        -(servo_sg5010_h)/2+1]) {
        cube(center=true,[2,3,6]);
    }
    //-x
    mirror([1,0,0]) {
        translate([
            (servo_sg5010_w+2)/2,
            6,
            -(servo_sg5010_h)/2+1]) {
            cube(center=true,[2,3,6]);
        }
        translate([
            (servo_sg5010_w+2)/2,
            -6,
            -(servo_sg5010_h)/2+1]) {
            cube(center=true,[2,3,6]);
        }
    }
    //y
    translate([
        (servo_sg5010_w-3)/2,
        (servo_sg5010_l+2)/2,
        -(servo_sg5010_h)/2+1]) {
        cube(center=true,[3,2,6]);
    }
    translate([
        -(servo_sg5010_w-3)/2,
        (servo_sg5010_l+2)/2,
        -(servo_sg5010_h)/2+1]) {
        cube(center=true,[3,2,6]);
    }
    //-y
    mirror([0,1,0]) {
        translate([
            (servo_sg5010_w-3)/2,
            (servo_sg5010_l+2)/2,
            -(servo_sg5010_h)/2+1]) {
            cube(center=true,[3,2,6]);
        }
        translate([
            -(servo_sg5010_w-3)/2,
            (servo_sg5010_l+2)/2,
            -(servo_sg5010_h)/2+1]) {
            cube(center=true,[3,2,6]);
        }
    }

}

module hook_top_sg5010(a_fn=16) {
    if(false){
        %translate([
            0,
            (servo_sg5010_l/2-servo_sg5010_axis_center_right_margin),
            0
        ]) {
            cylinder(center=true,d=32+3,h=60,$fn=100);
            cylinder(center=true,d=32,h=60,$fn=100);
        }
    }

    color([0,0,1]) {
        difference() {
            translate([
                0,
                (servo_sg5010_l/2-servo_sg5010_axis_center_right_margin)+5.5,
                0
            ]) {
                difference() {
                    cube(
                        center=true,
                        [10,24,servo_sg5010_h+16]
                    );
                    union() {
                        translate([0,-3,0]) {
                            cube(
                                center=true,
                                [10+2,24-3,servo_sg5010_h+16-8]
                            );
                        }
                    }
                }
            }
            union() {
                translate([
                    0,
                    (servo_sg5010_l/2-servo_sg5010_axis_center_right_margin),
                    0]) {
                            cylinder(
                                center=true,
                                d=servo_sg5010_axis_d,
                                h=53,
                                $fn=a_fn);
                            cylinder(
                                center=true,
                                d=2,
                                h=60,
                                $fn=a_fn);
                }
                translate([0,5,0]) {
                    cube(center=true,[1,10,100]);
                }
                translate([0,5.5,servo_sg5010_h/2+6]) {
                    rotate([0,90,0]) {
                        cylinder(
                            center=true,
                            d=2,
                            h=20,
                            $fn=a_fn
                        );
                    }
                }
                translate([0,5.5,-(servo_sg5010_h/2+6)]) {
                    rotate([0,90,0]) {
                        cylinder(
                            center=true,
                            d=2,
                            h=20,
                            $fn=a_fn
                        );
                    }
                }
            }
        }
    }
}

module joint_sg5010(a_fn=16) {
    joint_bottom_frame_sg5010();
    mock_axis_sg5010();
//    joint_sg5010();
    hook_top_sg5010();
}

module arm_sg5010() {
    color([0.2,0.2,0.2]) {
        difference() {
            union() {
                {
                    cylinder(
                        center=true,
                        d=servo_sg5010_arm1_w,
                        h=servo_sg5010_arm1_wings_h,
                        $fn=28);
                    //right
                    translate([
                        0,
                        servo_sg5010_arm1_l/2-servo_sg5010_arm1_wings_w2/2,
                        0]) {
                        cylinder(
                            center=true,
                            d=servo_sg5010_arm1_wings_w2,
                            h=servo_sg5010_arm1_wings_h,
                            $fn=28);
                    }
                    translate([
                        0,
                        -(servo_sg5010_arm1_l/2-servo_sg5010_arm1_wings_w2/2),
                        0]) {
                        cylinder(
                            center=true,
                            d=servo_sg5010_arm1_wings_w2,
                            h=servo_sg5010_arm1_wings_h,
                            $fn=28);
                    }
                }
                {
                    //polygon
                    translate([0,2,0]) {
                        linear_extrude(
                            height = servo_sg5010_arm1_wings_h,
                            center = true) {
                            polygon(points=[
                            [ servo_sg5010_arm1_wings_w1/2, 0],
                            [-servo_sg5010_arm1_wings_w1/2, 0],
                            [-servo_sg5010_arm1_wings_w2/2,servo_sg5010_arm1_wings_l],
                            [servo_sg5010_arm1_wings_w2/2,servo_sg5010_arm1_wings_l]
                            ], paths=[[0,1,2,3]]);
                        }
                    }
                    mirror([0,1,0]) {
                        translate([0,2,0]) {
                            linear_extrude(
                                height=servo_sg5010_arm1_wings_h,
                                center=true) {
                                polygon(points=[
                                [ servo_sg5010_arm1_wings_w1/2, 0],
                                [-servo_sg5010_arm1_wings_w1/2, 0],
                                [-servo_sg5010_arm1_wings_w2/2,servo_sg5010_arm1_wings_l],
                                [ servo_sg5010_arm1_wings_w2/2,servo_sg5010_arm1_wings_l]
                                ], paths=[[0,1,2,3]]);
                            }
                        }
                    }
                }
                {
                    translate([0,0,(servo_sg5010_arm1_h-servo_sg5010_arm1_wings_h)/2]) {
                        cylinder(center=true, d=servo_sg5010_arm_axis_d, h=servo_sg5010_arm1_h);
                    }
                }
            }
            cylinder(center=true,d=servo_sg5010_arm_axis_d-servo_sg5010_arm_axis_t*2,h=10);
        }
    }
}

module battery_18650() {
    color([1,1,1]) {
        translate([0,0,(battery_18650_h+2)/2]) {
            cylinder(center=true, d=battery_18650_d-3, h=2);
        }
    }
    color([1,0.5,1]) {
        cylinder(center=true, d=battery_18650_d, h=battery_18650_h);
    }
}

module rect(w,h,r=0) {
    d = r*2;
    width=w-d;
    height=h-d;
    if (0!=r) {
        square([width,height],center=true);
        translate([-width/2,-height/2,0]) {circle(r=r,$fn=100,center=true);}
        translate([width/2,-height/2,0]) {circle(r=r,$fn=100,center=true);}
        translate([-width/2,height/2,0]) {circle(r=r,$fn=100,center=true);}
        translate([width/2,height/2,0]) {circle(r=r,$fn=100,center=true);}

        translate([0,(height+r)/2,0]) {square([width,r],center=true);}
        translate([0,-(height+r)/2,0]) {square([width,r],center=true);}
        translate([(width+r)/2,0,0]) {square([r,height],center=true);}
        translate([-(width+r)/2,0,0]) {square([r,height],center=true);}
    } else {
        square([width,height],center=true);
    }
}

module servo_9g(a_left_wings=true, a_right_wings=true) {
       servoBase(
        [0,0,1],
        servo_9g_w,
        servo_9g_h,
        servo_9g_l,
        servo_9g_wings_w,
        servo_9g_wings_h,
        servo_9g_wings_l,
        servo_9g_wings_top_margin,
        servo_9g_axis_d,
        servo_9g_axis_h,
        servo_9g_axis_center_right_margin,
        servo_9g_axis_plane_d,
        servo_9g_axis_plane_h,
        a_left_wings,
        a_right_wings
    ); 
}

module servo_sg5010(
        a_left_wings=true,
        a_right_wings=true,
        a_arm=0) {

    if (1==a_arm) {
        translate([0,servo_sg5010_w/2,servo_sg5010_h/2 + 7]) {
            rotate([180,0,0]) {
                arm_sg5010();
            }
        } 
    }
    servoBase(
        [0.2,0.2,0.2],
        servo_sg5010_w,
        servo_sg5010_h,
        servo_sg5010_l,
        servo_sg5010_wings_w,
        servo_sg5010_wings_h,
        servo_sg5010_wings_l,
        servo_sg5010_wings_top_margin,
        servo_sg5010_axis_d,
        servo_sg5010_axis_h,
        servo_sg5010_axis_center_right_margin,
        servo_sg5010_axis_plane_d,
        servo_sg5010_axis_plane_h,
        a_left_wings,
        a_right_wings
    );
    
}

module servoBase(
        a_color,
        a_servo_w,
        a_servo_h,
        a_servo_l,
        a_servo_wings_w,
        a_servo_wings_h,
        a_servo_wings_l,
        a_servo_wings_top_margin,
        a_servo_axis_d,
        a_servo_axis_h,
        a_servo_axis_center_right_margin,
        a_servo_axis_plane_d,
        a_servo_axis_plane_h,
        a_left_wings=true,
        a_right_wings=true,
        a_fn=16
    ) {

    //axis
    color([1,1,1]) {
        translate([
                    0,
                    a_servo_l/2-a_servo_axis_center_right_margin,
                    (a_servo_h+a_servo_axis_h)/2+a_servo_axis_plane_h
                    ]) {
            cylinder(center=true,d=a_servo_axis_d,h=a_servo_axis_h,$fn=a_fn);
        }
    }
    //axis panel
    color (a_color) {
        translate([
            0,
            a_servo_l/2-a_servo_axis_center_right_margin,
            (a_servo_h+a_servo_axis_plane_h)/2
                ]) {
            cylinder(
                center=true,
                d=a_servo_axis_plane_d,
                h=a_servo_axis_plane_h);
        }
    }
    //body
    color (a_color) {
        cube(center=true,[a_servo_w,a_servo_l,a_servo_h]);
    }
    //wings
    color (a_color) {
        if (a_left_wings) {
            translate([
                0,
                (a_servo_l+a_servo_wings_l)/2,
                (a_servo_h-a_servo_wings_h)/2-a_servo_wings_top_margin
                        ]) {
                cube(
                    center=true,
                    [a_servo_wings_w, a_servo_wings_l, a_servo_wings_h]);
            }
        }
        if (a_right_wings) {
            translate([
                0,
                -(a_servo_l+a_servo_wings_l)/2,
                (a_servo_h-a_servo_wings_h)/2-a_servo_wings_top_margin
                        ]) {
                cube(
                    center=true,
                    [a_servo_wings_w, a_servo_wings_l, a_servo_wings_h]);
            }
        }
    }
}

module servo9gRotator1(aFn=16) {
//    color([0,1,0],0.3){
        thin = 2;
        difference() {
            union() {
                //bottom panel
                translate([0,0,-(servo_9g_body_h+thin)/2])
                    cube([servo_9g_body_w, 2*thin+servo_9g_body_l, thin], center=true);

                translate([(servo_9g_body_w+thin)/2,-thin,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);
                translate([(servo_9g_body_w+thin)/2,-thin*3,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);
                translate([(servo_9g_body_w+thin)/2,-thin*5,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);

                translate([-(servo_9g_body_w+thin)/2,-thin,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);
                translate([-(servo_9g_body_w+thin)/2,-thin*3,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);
                translate([-(servo_9g_body_w+thin)/2,-thin*5,-(servo_9g_body_h)/2])
                    cube([thin, thin, thin*2], center=true);

                //left panel
                translate([0,-(servo_9g_body_l+thin)/2,0])
                    cube([servo_9g_body_w,thin,servo_9g_body_h],center=true);
                //right panel
                translate([0,(servo_9g_body_l+thin)/2,0])
                    cube([servo_9g_body_w,thin,servo_9g_body_h],center=true);
         
//                gear_h = 5;
//                //gear
//                translate([0,(servo_9g_body_l+gear_h)/2,(servo_9g_body_h-servo_9g_body_w)/2])
//                    rotate([90,0,0])
//                        cylinder(d=8,h=gear_h,center=true,$fn=aFn);
            }
            //belling cylinder
            translate([0,0,(servo_9g_body_h-servo_9g_body_w)/2])
                rotate([90,0,0])
                    cylinder(d=6,h=60,center=true,$fn=aFn);
        }
//    }
}


test();
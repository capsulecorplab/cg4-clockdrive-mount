$fn = 30;

h_nema17 = 47;
w_nema17 = 42.3;
r_corner = 55.5;
thickness = 2;
w_matingplate = 26;
l_leg = 45.5;
d_shaft2thread = 57.25;
d_mountingscrew = 5;

difference() {
    translate ([0, 0, (h_nema17 + thickness)/2]) {

        // material buffer for nema 17 housing
        intersection() {
            cube([
                (w_nema17 + 2*thickness),
                (w_nema17 + 2*thickness),
                (h_nema17 + 2*thickness)
            ], center=true);
            cylinder(
                r=(r_corner + 2*thickness)/2,
                h=(h_nema17 + thickness),
                center=true
            );
        }

        // material buffer for thumb clearance
        translate([0, 0, - h_nema17/2 - thickness])
        cube([
            w_nema17 + 2*thickness,
            w_matingplate,
            h_nema17/2 + thickness
        ], center=true);

        // thumb plate
        translate([0, 0, h_nema17/2])
        cube([
            2*w_nema17 + 4*thickness,
            w_matingplate,
            thickness
        ], center=true);

        // pylon1 for thumb plate
        translate([
            -w_nema17/2 - thickness,
            w_matingplate/2,
            -h_nema17/2 - thickness/2]
        )
        rotate(a=[0,0,180])
        triangle(
            b=w_nema17/2 + thickness,
            w=thickness,
            h=h_nema17
        );

        // pylon2 for thumb plate
        translate([
            -w_nema17/2 - thickness,
            -w_matingplate/2 + thickness,
            -h_nema17/2 - thickness/2]
        )
        rotate(a=[0,0,180])
        triangle(
            b=w_nema17/2 + thickness,
            w=thickness,
            h=h_nema17
        );
    }

    // nema 17 + clearance
    translate([0, 0, (h_nema17)/2 + thickness]) {

        // nema 17
        intersection() {
            cube([
                w_nema17,
                w_nema17,
                h_nema17],
            center=true);
            cylinder(
                r=r_corner/2,
                h=h_nema17,
                center=true
            );
        }

        // clearance for wires
        translate([w_nema17/2, 0, 0])
        cube([
            2*thickness,
            w_matingplate - 2*thickness,
            h_nema17 - 2*thickness
        ], center=true);

        // clearance for thumb (side)
        translate([-w_nema17/2, 0, 0])
        cube([
            2*thickness,
            w_matingplate - 2*thickness,
            h_nema17 - 2*thickness
        ], center=true);

        // clearance for thumb (bottom)
        translate([0, 0, - h_nema17/2 - thickness])
        cube([
            w_nema17 + 2*thickness,
            w_matingplate - 2*thickness,
            h_nema17/2
        ], center=true);
    }
}

module triangle(b, w, h) {
    translate([0, w/2, h])
    rotate(a=[180,90,90])
    linear_extrude(height = w, center = true)
    polygon(points=[[0,0],[h,0],[0,b]]);
}

// pylon1
translate([
    w_nema17/2 + thickness,
    11,
    0
])
difference() {
    triangle(
        b=d_shaft2thread - (w_nema17/2 + thickness) + w_matingplate/2,
        w=thickness,
        h=h_nema17 + l_leg
    );
    translate([0, 0, h_nema17 + thickness])
    triangle(
        b=d_shaft2thread - w_matingplate/2,
        w=thickness,
        h=h_nema17 + l_leg
    );
}

// pylon2
mirror([0, 1, 0])
translate([
    w_nema17/2 + thickness,
    11,
    0
])
difference() {
    triangle(
        b=d_shaft2thread - (w_nema17/2 + thickness) + w_matingplate/2,
        w=thickness,
        h=h_nema17 + l_leg
    );
    translate([0, 0, h_nema17 + thickness])
    triangle(
        b=d_shaft2thread - w_matingplate/2,
        w=thickness,
        h=h_nema17 + l_leg
    );
}

// mating plate
translate([
    d_shaft2thread,
    0,
    h_nema17 + l_leg + thickness/2
])
difference() {
    cube([w_matingplate, w_matingplate, thickness], center=true);
    // slotted hole for mounting screw
    union() {
        slotwidth = 4;
        cube([
            slotwidth,
            d_mountingscrew,
            thickness],
        center=true);
        translate([-slotwidth/2, 0, 0])
        cylinder(
            r=d_mountingscrew/2,
            h=thickness,
            center=true
        );
        translate([slotwidth/2, 0, 0])
        cylinder(
            r=d_mountingscrew/2,
            h=thickness,
            center=true
        );
    }
}

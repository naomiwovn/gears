use  <NopSCADlib/core.scad>
use  <NopSCADlib/utils/gears.scad>

//
// NopSCADlib Copyright Chris Palmer 2020
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// This file is part of NopSCADlib.
//
// NopSCADlib is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// NopSCADlib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with NopSCADlib.
// If not, see <https://www.gnu.org/licenses/>.
//
include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/gears.scad>


/* [Gear Settings] */
// Gear Teeth
gearTeeth = 30; // [7 : 1 : 99]
//  Modulus
modulus = 1; // [0.1 : 0.1 : 5.0]
// Pressure angle
pa = 25; // [14.5, 20, 22.5, 25]
// Gear Height
gearheight = 8;

/* [Key dimensions] */
keydiam = 20.03;
keylen = 3.95;
keydepth = 1.73;



/* [Inner cylinder outerdiameter]*/
innercylOD = 27;
innercylheight = 2;


module Gear(gearTeeth=gearTeeth, modulus=modulus) {
    color(pp1_colour)
        rotate(-$t * 360)
            linear_extrude(gearheight, center = true, convexity = gearTeeth)
                difference() {
                    involute_gear_profile(modulus, gearTeeth, pa);
                    circle(r = modulus * gearTeeth / 10);
                }
 }

module KeyHole(diam,key){
    // Inner cylinder and cube for keyed slot
    cylinder(d=diam,h=2*gearheight+innercylheight+0.1,center=true);
    translate([diam/2+keydepth-keylen/2,0,0])
        cube([key,key,2*gearheight+innercylheight+0.1],center=true);
}


// // Put pices together Double Gear 
// difference(){
//     union(){
//         Gear(gearTeeth=64,modulus=0.9375);
//         translate([0,0,gearheight/2+innercylheight/2])
//             Gear();
//     }
//     KeyHole(keydiam,keylen);
// }


// Gear with cylinder spacer
difference(){
    union(){
       Gear();
       translate([0,0,gearheight/2])
            cylinder(d=innercylOD, h = innercylheight);
   }
   KeyHole(keydiam,keylen);
}










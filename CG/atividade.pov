#include "colors.inc"
// Atividade 1
// camera{
//     location <5, 10, -20>
//     look_at 0
//     angle 45
// }
// light_source{ <500, 500, -1000> White }
// plane{ y, -20
//     pigment{ White }
// }
// union{
//     box { <0, 0, 0>, <1, 1, 1>
//         pigment{ Red }
//     }
//     sphere { <1, 1, 0>, 0.5
//         pigment{ Blue }
//     }
// }
// difference {
//     box { <2, 0, 0>, <3, 1, 1>
//         pigment{ Red }
//     }
//     sphere { <3, 1, 0>, 0.5
//         pigment{ Blue }
//     }
// }

// intersection {
//     box { <4, 0, 0>, <5, 1, 1>
//         pigment{ Red }
//     }
//     sphere { <5, 1, 0>, 0.5
//         pigment{ Blue }
//     }
// }

// //Atividade2
camera{
    location <10, 10, -10>
    look_at 0
    angle 45
}
light_source{ <500, 500, -1000> White }
light_source{ <0, 0, 0> White }
plane{ y, -20
    pigment{ White }
}

// difference{
    intersection{
        box { 
            <-2.5, -2.5, -2.5>, 
            <2.5, 2.5, 2.5>
            pigment{Red}
        }
        sphere { 
            <0, 0,0>, 
            3.35
            pigment{Blue}
            }

    }
    // union{
    //     cylinder {<-5,0,0>, <5,0,0>, 1.5 pigment { Green }}
    //     cylinder {<0,-5,0>, <0,5,0>, 1.5 pigment { Green }}
    //     cylinder {<0,0,-5>, <0,0,5>, 1.5 pigment { Green }}
    // }
// }


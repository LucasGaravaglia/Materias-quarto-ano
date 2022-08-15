#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
light_source{ <50, 300, 100> White }
light_source{ <50, 10, 100> White }


// Camera1
light_source{ <0, 200, -130> White }
camera{
    location <-10, 200, -110>
    look_at  <80, 100, 10>
}


// Camera2
// light_source{ <-20, 200, 220> White }
// camera{
//     location <-30, 200, 200>
//     look_at <80, 50, 50>
// }

// Camera3
light_source{ <-100, 220, 50> White }
camera{
    location <-90, 200, 80>
    look_at <5, 120, 70>
}

// Camera4
  // camera{
  //     location <-90, 20, 50>
  //     look_at <5, 50, 50>
  // }

// camera{
//     location <100, 300, 70>
//     look_at <100, 0, 70>
// }

// Camera5
// camera{
//     location <-70, 10, -70>
//     look_at <100, 50, 70>
// }


plane{ y, -50
    pigment{ White }
}
plane{<0,1,0>,1 hollow
  texture{
    pigment{ bozo turbulence 0.92
      color_map {
      [0.00 rgb <0.2, 0.3, 1>*0.5]
      [0.50 rgb <0.2, 0.3, 1>*0.8]
      [0.70 rgb <1,1,1>]
      [0.85 rgb <0.25,0.25,0.25>]
      [1.0 rgb <0.5,0.5,0.5>]}
      scale<1,1,1.5>*2.5
      translate<1.0,0,-1>
      }// end of pigment
    finish {ambient 1 diffuse 0}
  }// end of texture
  scale 10000
}// end of plane


// box { <0, 0, 0>,  <1000, 1, 1> pigment{Red} }// X
// box { <0, 0, 0>,  <1, 1000, 1> pigment{Green}  }// Y
// box { <0, 0, 0>,  <1, 1, 1000> pigment{Blue}}// Z

#declare Green_Metal = texture {pigment{color rgb <0, 1, 0>} finish { ambient 0.35 brilliance 2 diffuse 0.3 metallic specular 0.80 roughness 1/20 reflection 0.1}}

#declare pneu = union{
  // Borracha do pneu
  difference{
    union {
      torus {
        22, 5 // major radius, minor radius
         texture{ pigment{ color rgb<1,1,1>*0.15}
           normal { bumps .5 scale .005}
           finish { diffuse .9 phong .2}}
        rotate z*90
        translate <5, 16, 0> // <x, y, z> 
      }
      cylinder {
        <0,15,0>,<10,15,0>,23 
         texture{ pigment{ color rgb<1,1,1>*0.15}
           normal { bumps .5 scale .005}
           finish { diffuse .9 phong .2}
           }
      }
    }
    cylinder {<-3,15,0>,<13,15,0>,20 texture {Silver_Metal}}
  }
  // Parte metalica no centro
  difference{
    union {
      difference{
        cylinder {<0,15,0>,<10,15,0>,20 texture {Silver_Metal}}
        cylinder {<-1,15,0>,<1,15,0>,18 texture {Silver_Metal}}
      }
      cone{<2,15,0>, 15, <-1,15,0>, 12 texture {Silver_Metal}}
    }
    difference{
      union{
          cylinder {<-40,16,0>,<50,16,0>, 4 texture {pigment{Black}}}
          cone{<-2,19,0>, 2, <-2,23,0>, 3 texture {pigment{Black}}}
          cone{<-2,23,0>, 3, <-2,27,0>, 2 texture {pigment{Black}}}
          cone{<-2,13,0>, 2, <-2,8,0>, 3 texture {pigment{Black}}}
          cone{<-2,8,0>, 3, <-2,3,0>, 2 texture {pigment{Black}}}
          cone{<0,16,3>, 2, <0,16,8>, 3 texture {pigment{Black}}}
          cone{<0,16,8>, 3, <0,16,12>, 2 texture {pigment{Black}}}
          cone{<0,16,-3>, 2, <0,16,-8>, 3 texture {pigment{Black}}}
          cone{<0,16,-8>, 3, <0,16,-12>, 2 texture {pigment{Black}}}
      }
      union{
          cylinder {<1,15,0>,<8,15,0>, 30 texture {pigment{Black}}}
          cylinder {<-3,15,0>,<-8,15,0>, 30 texture {pigment{Black}}}
      }
    }
  }  
}

#declare parte_suporte = union{
  difference{
    difference {
      difference {
        difference {
          difference {
            union {
              torus {16, 3 texture{ pigment{ Black}} rotate z*90 translate <1, 30, 19>}
              box {<-1, 0, 0>, <5, 27, 6> pigment{Black}}
              box {<-1, 44, 15>, <5, 48, 30> pigment{Black}} 
            }
            box {<-3, 0, 6>, <9, 26, 40> pigment{Black}}
          }
          box {<-3, 15, 20>, <8, 44, 40> pigment{Black}}
        }
        box {<-3, 30, 30>, <8, 50, 35> pigment{Black}}
      }
      box {<-4, -1, -1>, <0, 70, 70> pigment{Black}}
    }
    box {<2, -1, -1>, <8, 70, 70> pigment{Black}}
  }
}

#declare suporte = union {
  object{ parte_suporte translate <0, 0, 0> }
  object{ parte_suporte translate <4, 0, 0> }
}

#declare parafuso_pneu = difference {
  cylinder {<0, 0, 0>, <0, 0, 2>, 1 texture {pigment {Gray}}}
  cylinder {<0, 0, -1>, <0, 0, 3>, 0.5 texture {pigment {Gray}}}
}

#declare eixo_roda_suporte = union {
  cylinder { <0, 0, 0>, <0, 3, 0>, 3 texture{Chrome_Metal}}
  cylinder { <0, -2, 0>, <0, 0, 0>, 1 texture{Silver_Metal}}
  box {<-4, -5, -1>, <5, -2, 1> }
}

//DESCOMENTAR AQUI
#declare roda_suporte = union {
  object{ suporte translate <-3, 7, -25> rotate <0, -90, 0> }
  object{ pneu translate <0, -3, 0> }
  object{ eixo_roda_suporte translate <5, 57, 0> }
  
  cylinder {<9, 16, 0>, <26, 16, 0>, 2 texture {Metal}}
  object{ parafuso_pneu translate <20.3, 15, -4> }
  object{ parafuso_pneu translate <23.5, 15, -4> }
  object{ parafuso_pneu translate <20.3, 18, -4> }
  object{ parafuso_pneu translate <23.5, 18, -4> }

  object{ parafuso_pneu translate <20.3, 15, 2> }
  object{ parafuso_pneu translate <23.5, 15, 2> }
  object{ parafuso_pneu translate <20.3, 18, 2> }
  object{ parafuso_pneu translate <23.5, 18, 2> }
}

#declare apoio_motores = union {
  difference {
    box {<0, 0, 0>, <10, 5, 30> pigment{Gray}}
    box {<1, 1, -10>, <9, 4, 40> texture{Metal}}
  }
  difference {
    box {<0, 0, 35>,<10, 5, 90> pigment{Gray} }
    box {<1, 1, 20>,<9, 4, 100> texture{Metal} }
    rotate <-30, 0, 0> translate <0, -17, 0>
  }
}

#declare eixo_apoio_motor = union {
  box {<-1, 3, 1.5>,<3, 4, 6> pigment{Green} }
  box {<-1, 3, -1.5>,<3, 4, -6> pigment{Green} }

  box {<0, 0, 3>,<3, 3, 4> texture{Green_Metal} }
  box {<0, 0, -3>,<3, 3, -4> texture{Green_Metal} }
  difference{
    difference{
      cylinder {<1, 0, 0>, <2, 0, 0>, 3 texture{Green_Metal}}
      cylinder {<0, 0, 0>, <3, 0, 0>, 2.5}
    }
    box {<-2, -1.5, -3>,<5, 1.5, 5> pigment{Black} }
  }
  
  difference{
    cylinder {<0, 0, 0>, <2, 0, 0>, 4 texture{Green_Metal}}
    cylinder {<-1, 0, 0>, <3, 0, 0>, 3}
  }
  difference{
    cylinder {<0, 0, 0>, <2, 0, 0>, 2.5 texture{Silver_Metal}}
    cylinder {<-1, 0, 0>, <3, 0, 0>, 2.3}
  }
  difference{
    cylinder {<0, 0, 0>, <2, 0, 0>, 1.5 texture{Silver_Metal}}
    cylinder {<-1, 0, 0>, <3, 0, 0>, 1}
  }
  difference{
    cylinder {<0, 0, 0>, <2, 0, 0>, 2.3 pigment{Black}}
    cylinder {<-1, 0, 0>, <3, 0, 0>, 1.5}
  }
  cylinder {<-2, 0, 0>, <3, 0, 0>, 1 texture{Metal}}
}

#declare eixo_apoio_motor_parafuso = union{
  object{ eixo_apoio_motor translate <0, 0, 0> }
  cylinder {<1, 2, 5>, <1, 3, 5>, 0.8}
  cylinder {<1, 2, -5>, <1, 3, -5>, 0.8}
}

#declare apoio_motor_completo = union {
  difference{
    object{ apoio_motores translate <-10, 0, -80> rotate <0,180,0>}
    object{ eixo_apoio_motor_parafuso translate <-3, 30, 0> }
  }
  difference{
    object{ apoio_motores translate <0, 0, -75> }
    object{ eixo_apoio_motor_parafuso translate <-3, 30, 0> }
  }
  object{ eixo_apoio_motor_parafuso translate <-4, 30, 0> }
  object{ eixo_apoio_motor_parafuso translate <11, 30, 0> }
  
}

#declare motor_dupla = union {
  object{ apoio_motor_completo translate <0, 60, 70> }
  object{ roda_suporte translate <0, 0, 0> }
  object{ roda_suporte translate <0, 0, 145> }

}

#declare diff_barra_aluminio_menor = union{
  box {<2, 4, -6>, <3, 6, 166> }
  box {<1.4, 3.8, -6>, <3.6, 4.2, 166>}
}

#declare barra_aluminio_menor = union {
  difference{
    difference{
      difference{
        difference{
          difference {
            box {<0, 0, 0>, <5, 5, 130> texture{Chrome_Metal}}
            box {<1.5, 1.5, -6>, <3.5, 3.5, 160> }
          }
          object{ diff_barra_aluminio_menor translate <0, 0, 0> }
        }
        object{ diff_barra_aluminio_menor translate <0, -5, 5> rotate <0,0,90>}
      }
      object{ diff_barra_aluminio_menor translate <-5, 0, 5> rotate <0,0,-90>}
    }
    object{ diff_barra_aluminio_menor translate <-5, -5, 5> rotate <0,0,180>}
  }
}

#declare diff_barra_aluminio_maior = union{
  box {<2, 4, -6>, <3, 6, 220> }
  box {<1.4, 3.8, -6>, <3.6, 4.2, 220>}
}

#declare barra_aluminio_maior = union {
  difference{
    difference{
      difference{
        difference{
          difference {
            box {<0, 0, 0>, <5, 5, 212> texture{Chrome_Metal}}
            box {<1.5, 1.5, -6>, <3.5, 3.5, 215> }
          }
          object{ diff_barra_aluminio_maior translate <0, 0, 0> }
        }
        object{ diff_barra_aluminio_maior translate <0, -5, 5> rotate <0,0,90>}
      }
      object{ diff_barra_aluminio_maior translate <-5, 0, 5> rotate <0,0,-90>}
    }
    object{ diff_barra_aluminio_maior translate <-5, -5, 5> rotate <0,0,180>}
  }
}

#declare suporte_barra_direcao = union {
  cylinder {<0, 0, 0>, <0, 33, 0>, 1 texture { Gold_Metal}}
  cylinder {<0, 2, 0>, <0, 10, 0>, 1.5 texture { Gold_Metal}}
  cylinder {<0, 22, 0>, <0, 30, 0>, 1.5 texture { Gold_Metal}}
  sphere {<0, 0, 0>, 2 texture { Gold_Metal}}
  sphere {<0, 33, 0>, 2 texture { Gold_Metal}}
}

#declare tampa_azul = union {
  difference {
    box { <0, 0, 0>, <19, 1, 140> pigment{Blue}}
    union {
      cylinder {<5, -1, 61>, <5, 2, 61>, 1.4 }
      cylinder {<14, -1, 61>, <14, 2, 61>, 1.4 }
      cylinder {<5, -1, 74>, <5, 2, 74>, 1.4 }
      cylinder {<14, -1, 74>, <14, 2, 74>, 1.4 }
      
    }
  }
  object{ parafuso_pneu translate <5, 61, -2> rotate <90, 0, 0> }
  object{ parafuso_pneu translate <14, 61, -2> rotate <90, 0, 0> }
  object{ parafuso_pneu translate <5, 74, -2> rotate <90, 0, 0> }
  object{ parafuso_pneu translate <14, 74, -2> rotate <90, 0, 0> }
}

#declare barra_com_apoio_completo = union {
  object{ barra_aluminio_menor translate <8, 94, 0> }
  object{ barra_aluminio_menor translate <-6, 94, 0> }
  object{ motor_dupla translate <0, 0, -7> }
  object{ suporte_barra_direcao translate <-1.5, 63, -9.4>}
  object{ tampa_azul translate <-6, 99, -5>}
}

#declare barra_ferro_direcao = union {
  box { <0, 0, 0>, <200, 5, 5> }
}

#declare suporte_tampa = union {
  difference{
    difference{
      box { <25, 16, 25>, <35, 20, 25.5> texture {Gold_Metal}}
      cylinder { <27, 18, 25>, <27, 18, 26.5>, 0.5 texture {Brass_Metal}}
    }
    cylinder { <32.5, 18, 25>, <32.5, 18, 26.5>, 0.5 texture {Brass_Metal}}
  }
  difference{
    difference{
      box { <25, 22, 25>, <35, 26, 25.5> texture {Gold_Metal}}
      cylinder { <27, 24, 25>, <27, 24, 26.5>, 0.5 texture {Brass_Metal}}
    }
    cylinder { <32.5, 24, 25>, <32.5, 24, 26.5>, 0.5 texture {Brass_Metal}}
  }
  union {
    difference{
      difference {
        cylinder { <25, 21, 25>, <35, 21, 25>, 1 texture {Gold_Metal}}
        cylinder { <27, 21, 25>, <29, 21, 25>, 1.1 texture {Bronze_Metal}}
      }
      cylinder { <31, 21, 25>, <33, 21, 25>, 1.1 texture {Bronze_Metal}}
    }
    cylinder { <27, 21, 25>, <29, 21, 25>, 1 texture {Bronze_Metal}}
    cylinder { <31, 21, 25>, <33, 21, 25>, 1 texture {Bronze_Metal}}
  }
}

#declare caixa_papelao = union {
  difference {
    box { <13, 0, 0>, <187, 20, 25> texture {pigment{Blue}}}
    box { <14, 1, 1>, <186, 32, 24> texture {DMFWood4}}
  }
  difference {
    box { <13, 22, 23>, <187, 46, 25> texture {pigment{Blue}}}
    box { <12, 21, 22>, <189, 47, 24> texture {DMFWood4}}
  }
  object{ suporte_tampa translate <0, 0, 0>}
  object{ suporte_tampa translate <140, 0, 0>}
  
}

object{ caixa_papelao translate <0, 80, 7>}
object{ caixa_papelao translate <0, 80, 95>}

object{ barra_ferro_direcao translate <0, 94, -12>}
object{ barra_aluminio_maior translate <-135, 94, -6> rotate <0,90,0>}
union{
  object{ barra_aluminio_maior translate <0, 94, -6> rotate <0,90,0>}
  cylinder { <100, 94, -6>, <100, 94, 1.5>, 1.8 texture {Chrome_Metal}}
  cylinder { <100, 94, -8>, <100, 94, 0>, 1 texture {Chrome_Metal}}
}

object{ barra_com_apoio_completo translate <0, 0, 0> }
object{ barra_com_apoio_completo translate <-200, 0, 0> scale<-1,1,1> }

// camera{
//     location <-40, 70, -40>
//     look_at  <0, 20, 0>
// }

// union {
//   difference {
//     box {<0, 0, 0>, <10, 5, 30> pigment{Gray}}
//     box {<1, 1, -10>, <9, 4, 40> texture{Metal}}
//   }
//   difference {
//     box {<0, 0, 35>,<10, 5, 90> pigment{Gray} }
//     box {<1, 1, 20>,<9, 4, 100> texture{Metal} }
//     rotate <-30, 0, 0> translate <0, -17, 0>
//   }
// }

//     7
//  3     6
// 1 2   4 5

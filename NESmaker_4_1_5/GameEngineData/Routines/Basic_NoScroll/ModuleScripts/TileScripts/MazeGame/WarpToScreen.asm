
 cpx player1_object
 BNE dontDoWarp_tile
 LDA warpMap
 sta currentMap
 clc
 ADC #$01
 STA temp
 GoToScreen warpToScreen, temp, #$02

 dontDoWarp_tile


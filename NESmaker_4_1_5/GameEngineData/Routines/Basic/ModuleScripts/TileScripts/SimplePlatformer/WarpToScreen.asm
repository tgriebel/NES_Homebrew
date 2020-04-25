
; cpx player1_object
; BNE dontDoWarp_tile
; LDA warpMap
; sta currentMap
; clc
; ADC #$01
; STA temp
; GoToScreen warpToScreen, temp

; dontDoWarp_tile

LDA #$00
STA newGameState
 LDA warpMap
sta currentMap
 clc
 ADC #$01
 STA temp
 GoToScreen #$00, temp, #$03
 LDA #$00
 STA playerToSpawn
 LDX player1_object
 DeactivateCurrentObject
 LDA #$01
 STA loadObjectFlag
 
LDA mapPosX
STA newX
LDA mapPosY
STA newY
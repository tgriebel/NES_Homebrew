
LDA navFlag
AND #%00000001
BEQ +

LDX player1_object
DeactivateCurrentObject
LDA #$01
STA loadObjectFlag

LDA warpMap
sta currentMap
clc
ADC #$01
STA temp
GoToScreen navToScreen, temp, #$02

+
RTS
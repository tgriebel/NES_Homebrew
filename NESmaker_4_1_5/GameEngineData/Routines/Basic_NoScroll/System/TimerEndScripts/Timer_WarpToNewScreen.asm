;;warp to new screen
LDA warpMap
sta currentMap
clc
ADC #$01
STA temp
GoToScreen warpToScreen, temp, #$02
	LDA navFlag
	ORA #%00000010
	STA navFlag
LDX player1_object
ChangeObjectState #$00, #$10

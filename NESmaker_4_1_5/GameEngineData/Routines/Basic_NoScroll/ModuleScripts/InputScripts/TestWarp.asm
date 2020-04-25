;;; test warp
	
LDA #$00
STA newGameState
 LDA warpMap
sta currentMap
 clc
 ADC #$01
 STA temp
 GoToScreen warpToScreen, temp, #$02
 LDA #$00
 STA playerToSpawn
 LDX player1_object
 DeactivateCurrentObject
 LDA #$01
 STA loadObjectFlag
 PlaySound #SND_ENTER

	RTS
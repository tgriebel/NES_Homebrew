
;;; do loss of life stuff here
	DEC myLives
	LDA myLives
	BNE gameNotOver
	;;do gameover stuff here.  Warp to screen?  Show animation?  Just restart?
	JMP RESET
	
gameNotOver:

;;;;;
;;; do warp to continue screen stuff here.
LDA #$00
STA newGameState
 LDA continueMap
 clc
 ADC #$01
 STA temp
 GoToScreen continueScreen, temp, #$04
 LDA #$00
 STA playerToSpawn
; LDX player1_object
; DeactivateCurrentObject
 LDA #$01
 STA loadObjectFlag
 
LDA continuePositionX
STA newX
LDA continuePositionY
STA newY

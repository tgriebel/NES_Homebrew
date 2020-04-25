
MACRO ContinueText arg0, arg1
	;; arg0 = x (in tiles)
	;; arg1 = y (in tiles)
	inc updateHUD_offset
	inc updateHUD_offset ;; one to get off the more value, one to get passed the skip line.
	LDA updateHUD_offset
	STA hudTileCounter
	
	LDA #$01
	STA writingText
	
	LDA arg0
	STA tileX
	LDA arg1
	STA tileY 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JSR coordinatesToNametableValue
ENDM 
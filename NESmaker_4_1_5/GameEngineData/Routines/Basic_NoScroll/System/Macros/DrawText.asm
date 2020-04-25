
MACRO DrawText arg0, arg1
	;; arg0 = x (in tiles)
	;; arg1 = y (in tiles)

	LDA #$00
	STA stringEnd;; sets more or whatever else might be needed at the end of the text string

	LDA #$00
	STA hudTileCounter
	STA updateHUD_offset
	LDA #$01
	STA writingText

	
	LDA arg0
	STA tileX
	LDA arg1
	STA tileY 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JSR getUpdateTileOffsetPosition
	;JSR coordinatesToNametableValue
	;; establishes updateNT_pos and updateNT_pos+1
	;;; FIRST, IF this has been tripped, blank all of the values
	

	ENDM
	bit $2002
	LDA ActivateHudUpdate
	BNE +

	
	LDA textboxHandler
	AND #%00010000
	;;;; this bit is whether or not we are in the text writing phase of a text box
	;;;; it will update one chr at a time.
	BEQ skipUpdateInNMI
+
	LDA updateHUD_fire_Address_Hi
	BEQ +
	;; draw one character.
	LDA $2002
	LDA updateHUD_fire_Address_Hi
	STA $2006
	LDA updateHUD_fire_Address_Lo
	STA $2006
	LDA updateHUD_fire_Tile
	STA $2007
	;; jmp skipUpdateInNMI
	;LDA #$00
	;STA writingText
+
skipUpdateInNMI:
		
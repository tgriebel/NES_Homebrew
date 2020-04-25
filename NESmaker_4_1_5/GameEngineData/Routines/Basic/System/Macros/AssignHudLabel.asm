MACRO AssignHudLabel arg0
	LDA #<arg0
	STA updateHUD_POINTER
	LDA #>arg0
	STA updateHUD_POINTER+1
	ENDM
	
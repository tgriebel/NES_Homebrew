MACRO LoadBackgroundPaletteLabel arg0
	;; This loads the background palette by name

	;; arg0 = label of palette to load
	
	LDA currentBank
	STA prevBank
	LDY #BANK_PALETTES
	JSR bankswitchY
	
	LDA #<arg1
	STA temp16
	LDA #>arg1
	STA temp16+1
	
	LDy #$00
doLoadBckPalLoop:
	LDA (temp16),y
	STA bckPal,y
	STA bckPalFade,y
	INY
	CPY #$10
	BNE doLoadBckPalLoop
	
	LDY prevBank
	JSR bankswitchY
	
	LDA #$01
	STA updatePalettes
	ENDM 
	
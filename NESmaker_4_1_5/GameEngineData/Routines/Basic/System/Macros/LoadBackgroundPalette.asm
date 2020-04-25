MACRO LoadBackgroundPalette arg0
	;; This loads the background palette based on what is loaded into temp16
	;; arg0 = label of palette to load
	
	LDA currentBank
	STA prevBank
	LDY #BANK_PALETTES
	JSR bankswitchY
	
	LDy #$00
doLoadBckPalLoop:
	LDA (temp16),y
	STA bckPal,y
	;STA bckPalFade,y
	INY
	CPY #$10
	BNE doLoadBckPalLoop
	
	LDY prevBank
	JSR bankswitchY
	
	LDA #$01
	STA updatePalettes
	ENDM 
	


	LDA #$3f
	STA $2006
	LDA #$10
	STA $2006
	LDX #$00
LoadSpritePal:
	LDA spritePalFade,x
	STA $2007
	INX
	CPX #$10
	BNE LoadSpritePal
	
;; load backgrounds last so that the *background* color gets overwritten correctly	
	
	LDA $2002
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDX #$00
LoadBackgroundPal:
	LDA bckPal,x;bckPalFade,x
	STA $2007
	INX
	CPX #$10
	BNE LoadBackgroundPal
	
	LDA #$00
	STA updatePalettes
	

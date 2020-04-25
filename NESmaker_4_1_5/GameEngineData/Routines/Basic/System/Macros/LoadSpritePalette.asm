MACRO LoadSpritePalette arg0, arg1, arg2, arg3
	;; Loads the chosen sub palettes for sprites.
	;; arg0-arg3 represent the sub palettes you wish to load for each
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
		LDY arg0
		LDA ObjectPaletteDataLo,y
		STA temp16
		LDA ObjectPaletteDataHi,y
		STA temp16+1
	
	LDY #BANK_PALETTES
	JSR bankswitchY
	;; load the first sub palette.
	LDy #$01
	LDX #$01
doLoadSpr0PalLoop:
	LDA (temp16),y
	STA spriteSubPal_0,y
	STA spritePalFade,x
	INX
	INY
	CPY #$4
	BNE doLoadSpr0PalLoop
	
	
	LDY #$16
	JSR bankswitchY
		LDY arg1
		LDA ObjectPaletteDataLo,y
		STA temp16
		LDA ObjectPaletteDataHi,y
		STA temp16+1
	
	LDY #BANK_PALETTES
	JSR bankswitchY
	
	;INY
	INX
	LDY #$01
doLoadSprite1PalLoop:
	LDA (temp16),y
	STA spriteSubPal_1,y
	STA spritePalFade,x
	INX
	INY
	CPY #$4
	BNE doLoadSprite1PalLoop
	
	
	LDY #$16
	JSR bankswitchY
		LDY arg2
		LDA ObjectPaletteDataLo,y
		STA temp16
		LDA ObjectPaletteDataHi,y
		STA temp16+1
	
	LDY #BANK_PALETTES
	JSR bankswitchY
	;INY
	INX
	LDY #$01
doLoadSprite2PalLoop:
	LDA (temp16),y
	STA spriteSubPal_2,y
	STA spritePalFade,x
	INX
	INY
	CPY #$4
	BNE doLoadSprite2PalLoop
		
	LDY #$16
	JSR bankswitchY
		LDY arg3
		LDA ObjectPaletteDataLo,y
		STA temp16
		LDA ObjectPaletteDataHi,y
		STA temp16+1
	
	LDY #BANK_PALETTES
	JSR bankswitchY
	;INY
	INX
	LDY #$01
doLoadSprite3PalLoop:
	LDA (temp16),y
	STA spriteSubPal_3,y
	STA spritePalFade,x
	INX
	INY
	CPY #$4
	BNE doLoadSprite3PalLoop
		
	
	
donWIthSpritePal
	LDY prevBank
	JSR bankswitchY
	ENDM 
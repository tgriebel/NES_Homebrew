MACRO SetMetaTileToChange arg0, arg1, arg2
	;; arg0 - hi address of change
	;; arg1 - low addres of change
	;; arg2 - change to this tile.
	
	;;; CORRUPTS X, A, temp, temp1 and temp2
	
	;; ** EXPECTS X TO BE SET PRIOR TO CALLING THIS MACRO.
	;; most times, this will be part of a loop.
	
	LDA arg0
	STA updateNT_fire_Address_Hi,x
	LDA arg1
	STA updateNT_fire_Address_Lo,x
	LDA arg2
	STA updateNT_fire_Tile,x
	
	INX
;;;;;;;; SECOND META TILE, ALLOWING CAVEAT FOR ALL BLANK TILES 	
	LDA arg1
	CLC
	ADC #$01
	STA temp
	LDA arg0
	ADC #$00
	STA temp1
	LDA arg2
	CMP #BLANK_TILE
	BNE +
	LDA #BLANK_TILE
	JMP ++
+:
	LDA arg2
	CLC
	ADC #$01
++:
	STA temp2

	LDA temp1
	STA updateNT_fire_Address_Hi,x
	LDA temp
	STA updateNT_fire_Address_Lo,x
	LDA temp2
	STA updateNT_fire_Tile,x
	
	INX
;;;;;;; THIRD META TILE
	LDA arg1
	CLC
	ADC #$20
	STA temp
	LDA arg0
	ADC #$00
	STA temp1
	LDA arg2
	CMP #BLANK_TILE
	BNE +
	LDA #BLANK_TILE
	JMP ++
+:
	LDA arg2
	CLC
	ADC #$10
++:
	STA temp2

	LDA temp1
	STA updateNT_fire_Address_Hi,x
	LDA temp
	STA updateNT_fire_Address_Lo,x
	LDA temp2
	STA updateNT_fire_Tile,x
	
	INX
;;; fourth meta tile
	LDA arg1
	CLC
	ADC #$21
	STA temp
	LDA arg0
	ADC #$00
	STA temp1
	LDA arg2
	CMP #BLANK_TILE
	BNE +
	LDA #BLANK_TILE
	JMP ++
+:
	LDA arg2
	CLC
	ADC #$11
++:
	STA temp2

	LDA temp1
	STA updateNT_fire_Address_Hi,x
	LDA temp
	STA updateNT_fire_Address_Lo,x
	LDA temp2
	STA updateNT_fire_Tile,x
	
	INX ;; in case there are more to follow.
	
	inc tilesToWrite
	ENDM
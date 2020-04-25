
MACRO BlackOutArea arg0, arg1, arg2
	;LDA #$00
	;STA soft2001	
	;JSR WaitFrame
	;arg 0 - start hi
	;arg 1 - start lo
	;arg 2 - number of 8x8 tiles to black out
	LDA arg0
	STA $2006
	LDA arg1
	STA $2006
	LDA #BLANK_TILE
	LDY arg2
LoopBlackoutArea:
	STA $2007
	DEY
	BNE LoopBlackoutArea 
	;LDA #%00011110
	;STA soft2001
	ENDM
	
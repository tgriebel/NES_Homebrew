MACRO DrawSprite arg0, arg1, arg2, arg3, arg4
	;arg0 = x
	;arg1 = y
	;arg2 = chr table value
	;arg3 = attribute data
	;arg3 = starting ram position
	LDA arg4
	STA temp16
	LDA #$02
	STA temp16+1
	
	LDY #$00
	
	LDA arg1
	STA (temp16),y
	INY
	LDA arg2
	STA (temp16),y
	INY 
	LDA arg3
	STA (temp16),y
	INY
	LDA arg0
	STA (temp16),y
	ENDM
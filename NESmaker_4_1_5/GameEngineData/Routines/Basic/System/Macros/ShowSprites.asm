MACRO ShowSprites
	LDA gameHandler
	ORA #%10000000
	STA gameHandler
	ENDM
	
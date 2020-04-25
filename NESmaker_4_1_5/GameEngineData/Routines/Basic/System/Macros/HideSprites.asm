MACRO HideSprites
	LDA gameHandler
	AND #%01111111
	STA gameHandler
	ENDM
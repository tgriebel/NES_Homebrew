;;blank
	CPX player1_object
	BNE dontPickUpShrub
	;; y should still hold collision type, I think?
	LDA gamepad
	AND #%00000010
	BEQ dontPickUpShrub
	ChangeTile #$00, #$00

dontPickUpShrub:
	
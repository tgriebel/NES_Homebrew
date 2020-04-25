
MACRO GoToScreen arg0, arg1, arg2
	; arg 0 = screen to warp to.
	; arg 1 = map
	; arg 2 = transition type

	LDA arg0
	STA temp2
	LDA arg1
	STA temp3
	LDA arg2
	STA temp1
	JSR HandleGoToScreen
	

	
	
	ENDM
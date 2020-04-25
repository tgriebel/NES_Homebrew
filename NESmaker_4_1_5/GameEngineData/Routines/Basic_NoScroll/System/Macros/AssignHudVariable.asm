MACRO AssignHudVariable arg0, arg1
	;arg 0 = hud variable
	;arg 1 = object index
	LDA arg1
	TAX
	LDA arg0,x
	ENDM
MACRO AssignHudVariableImage arg0, arg1
	;; arg 0 is the table
	;; arg 1 is the offset
	AssignHudLabel arg0
	
	LDA arg1
	ASL
	TAX ;; because we're using a dw word, not a db byte
	LDA arg0,x
	STA temp16
	LDA arg0+1,x
	STA temp16+1
	ENDM
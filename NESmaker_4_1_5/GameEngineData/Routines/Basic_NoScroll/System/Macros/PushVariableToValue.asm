MACRO PushVariableToValue arg0
	; arg0 = variable you want to draw the value of
	PushToValLoop:
		LDA arg0,x ;; the variable that you want to push
		STA value,x
		dex
		BPL PushToValLoop
	ENDM
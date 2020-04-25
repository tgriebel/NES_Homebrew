MACRO StopMoving arg0, arg1
	;;; stops moving object in arg0
	;;; in the direction outlined by arg1.
	
	;You can use these constants:
	;STOP_RIGHT = #%01111111
	;STOP_LEFT = #%00111111
	;STOP_UP = #%11001111
	;STOP_DOWN = #%11011111
	;STOP_RIGHT_DOWN = #%01011111
	;STOP_LEFT_DOWN = #%00011111
	;STOP_RIGHT_UP = #%01001111
	;STOP_LEFT_UP = #%00001111


	;arg 0 object to stop moving
	; arg1 stop moving which direction?
	LDX arg0
	LDA Object_movement,x
	AND #arg1
	STA Object_movement,x
	ENDM
	
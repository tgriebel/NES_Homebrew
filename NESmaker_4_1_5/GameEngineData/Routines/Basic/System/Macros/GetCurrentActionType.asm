MACRO GetCurrentActionType arg0
	;;; this reads what action step the object in arg0 is currently on.
	;arg0 = monster
	LDX arg0
	LDA Object_action_step,x
	AND #%00000111
	;; top 5 bits of action step are actually behavior type.
	;;; now, A holds type of action.
	ENDM
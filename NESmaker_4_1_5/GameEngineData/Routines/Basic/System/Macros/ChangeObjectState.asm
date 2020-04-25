

MACRO ChangeObjectState arg0, arg1
	;;arg1 what state to change the object to
	;;arg2 initial animation timer
	LDA Object_action_step,x
	AND #%11111000
	ora arg0
	STA Object_action_step,x
	LDA arg1
	STA Object_animation_timer,x
	LDA Object_animation_frame,x
	AND #%11111000
	STA Object_animation_frame,x
	;;;; We also need to update the vulnerability.
	LDA Object_state_flags,x
	ORA #%11000000
	STA Object_state_flags,x
	ENDM
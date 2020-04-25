
	
MACRO HandleGravity


	;; use MAX_VSPEED
	;;GRAVITY_LO
	;;GRAVITY_HI
;;;; WE ONLY WANT TO ENGAGE GRAVITY IF THE PLACE BELOW OUR FEET IS CLEAR.	
	;;; need to check potential posotion of feet.
	LDA Object_vulnerability,x
	AND #%00100000
	BEQ dontSkipGravity
	JMP skipGravity
dontSkipGravity:
	;LDA Object_physics_byte,x
	;AND #%00000001
	;BNE ignoreGravity
	LDA Object_v_speed_lo,x
	CLC
	ADC #GRAVITY_LO
	STA Object_v_speed_lo,x ;temp
	LDA Object_v_speed_hi,x
	ADC #GRAVITY_HI
	STA Object_v_speed_hi,x ;temp1

;	CMP #MAX_VSPEED
;	BCC thisIsAGoodSpeed
;	JMP maxVSpeedReached
;thisIsAGoodSpeed:
	;; max v speed NOT reached.
;	LDA temp
;	STA Object_v_speed_lo,x
;	LDA temp1
;	STA Object_v_speed_hi,x
;	JMP gotMaxVspeed
;maxVSpeedReached:
;	LDA #$00
;	STA Object_v_speed_lo,x
;	LDA #MAX_VSPEED
;	STA Object_v_speed_hi,x
;gotMaxVspeed:
		LDA Object_y_lo,x
	CLC
	ADC Object_v_speed_lo,x
	STA yHold_lo
	STA Object_y_lo,x
	LDA Object_y_hi,x
	ADC Object_v_speed_hi,x
	STA yHold_hi
	STA Object_y_hi,x
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

	JMP gotNewYPos

ignoreGravity:
skipGravity
	LDA Object_y_lo,x
	;CLC
	;ADC Object_v_speed_lo,x
	STA yHold_lo
	STA Object_y_lo,x
	LDA Object_y_hi,x
;	;ADC Object_v_speed_hi,x
	STA yHold_hi
	STA Object_y_hi,x
;	JMP gotNewYPos

gotNewYPos:	
	
	ENDM
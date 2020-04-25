
	
MACRO HandleZGravity


	;; use MAX_VSPEED
	;;GRAVITY_LO
	;;GRAVITY_HI
;;;; WE ONLY WANT TO ENGAGE GRAVITY IF THE PLACE BELOW OUR FEET IS CLEAR.	
	;;; need to check potential posotion of feet.

	LDA Object_physics_byte,x
	AND #%00000001
	BEQ ignoreGravity
	LDA Object_z_speed_lo,x
	CLC
	ADC #GRAVITY_LO
	STA Object_z_speed_lo,x ;temp
	LDA Object_z_speed_hi,x
	ADC #GRAVITY_HI
	STA Object_z_speed_hi,x ;temp1

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
	LDA Object_z_lo,x
	sec
	sbc Object_z_speed_lo,x
	STA Object_z_lo,x
	LDA Object_z_hi,x
	sbc Object_z_speed_hi,x
	STA Object_z_hi,x
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Check if LANDing
	LDA Object_z_lo,x
	CLC
	ADC #$00
	LDA Object_z_hi,x
	ADC #$00
	BPL + ;; dont land yet
	;; LAND
	LDA Object_physics_byte,x
	AND #%11111110
	STA Object_physics_byte,x
	LDA #$00
	STA Object_z_lo,x
	STA Object_z_hi,x
	STA Object_z_speed_lo,x
	STA Object_z_speed_hi,x
+ ;; dont land yet
ignoreGravity:	

gotNewYPos:	
	
	ENDM


MACRO DeactivateTargetObject arg0
	;; will deactivate object in arg0
	;; will corrupt x
	LDX arg0
	LDA #$FE;
	STA Object_y_hi,x
	LDA #$00
	STA Object_y_lo,x
	LDA #$00
	STA Object_status,x

	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x

	ENDM
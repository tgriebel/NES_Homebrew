
MACRO HandleAimedPhysics
		;;;;; maybe we have another that checks for projectile movement specifically?
	;; below handles projectile movement, for which there still needs to be directions
	;; defined to know whether to add or subtract from the values
	;; this is a way to give it different speeds?

    LDA tempMaxSpeed
    LSR
    LSR
    LSR
    LSR
    LSR
	BNE gotNumberOfLoops
	LDA #$01
gotNumberOfLoops:
	STA temp3 ;; temp3 now equals max speed hi

	LDA Object_h_speed_lo,x
	SEC
	SBC #$80
	STA temp
	BMI subFromXPos
	

	LDA Object_x_lo,x
	CLC
	ADC temp
	STA xHold_lo
	STA Object_x_lo,x
	LDA Object_x_hi,x
	ADC #$00
	STA xHold_hi
	STA Object_x_hi,x
	LDA Object_scroll,x
	ADC #$00
	STA Object_scroll,x
	STA nt_hold
	
	LDY #$00
hLoop0:		
	LDA xHold_lo
	CLC
	ADC temp
	STA xHold_lo
	STA Object_x_lo,x
	LDA xHold_hi
	ADC #$00
	STA xHold_hi
	STA Object_x_hi,x
	LDA Object_scroll,x
	ADC #$00
	STA Object_scroll,x
	STA nt_hold
	INY
	CPY temp3
	BNE hLoop0 ;; do this loop until max speed hi is reached.
				;; this should help it at least somewhat
				;; still observe speed
	
	;LDY Object_type,x
	
	;JSR JustDoHsolidAndBoundsCheck

	JMP doneWithHprojMovement
	
subFromXPos:
	LDA #$00
	SEC
	SBC temp
	STA temp

	LDA Object_x_lo,x
	sec
	sbc temp
	STA xHold_lo
	STA Object_x_lo,x
	LDA Object_x_hi,x
	sbc #$00
	STA xHold_hi
	STA Object_x_hi,x
	LDA Object_scroll,x
	SBC #$00
	STA Object_scroll,x
	STA nt_hold
	
	LDY #$00
hLoop1:
	LDA xHold_lo
	sec
	sbc temp
	STA xHold_lo
	STA Object_x_lo,x
	LDA xHold_hi
	sbc #$00
	STA xHold_hi
	STA Object_x_hi,x
	LDA Object_scroll,x
	SBC #$00
	STA Object_scroll,x
	STA nt_hold
	INY 
	CPY temp3
	BNE hLoop1
	
	;LDY Object_type,x
	;JSR JustDoHsolidAndBoundsCheck
doneWithHprojMovement:	
;;; do vertical chasing movement
	

	LDA Object_v_speed_lo,x
	SEC
	SBC #$80
	STA temp
	BMI subFromYPos


	LDA Object_y_lo,x
	sec
	sbc temp
	STA yHold_lo
	STA Object_y_lo,x
	LDA Object_y_hi,x
	sbc #$00
	STA yHold_hi
	STA Object_y_hi,x

	LDY #$00
vLoop0:
	LDA yHold_lo
	sec
	sbc temp
	STA yHold_lo
	STA Object_y_lo,x
	LDA yHold_hi
	sbc #$00
	STA yHold_hi
	STA Object_y_hi,x
	INY
	CPY temp3
	BNE vLoop0
	
	;LDY Object_type,x
	;JSR JustDoVsolidAndBoundsCheck


	JMP doneWithVprojMovement
	
subFromYPos:
	LDA #$00
	SEC
	SBC temp
	STA temp

	LDA Object_y_lo,x
	clc
	adc temp
	STA yHold_lo
	STA Object_y_lo,x
	LDA Object_y_hi,x
	adc #$00
	STA yHold_hi
	STA Object_y_hi,x
	
	LDY #$00
vLoop1:
	LDA yHold_lo
	clc
	adc temp
	STA yHold_lo
	STA Object_y_lo,x
	LDA yHold_hi
	adc #$00
	STA yHold_hi
	STA Object_y_hi,x
	INY 
	CPY temp3
	BNE vLoop1
	
	;LDY Object_type,x
	
	;JSR JustDoVsolidAndBoundsCheck

doneWithVprojMovement:
	ENDM
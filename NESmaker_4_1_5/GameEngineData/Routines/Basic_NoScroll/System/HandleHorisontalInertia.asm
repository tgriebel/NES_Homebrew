	
MACRO HandleHorizontalInertia
	LDA Object_movement,x
	AND #%10000000 ;; check if L or R is engaged.
	BNE horizontalInputEngaged
	;;; there was no horizontal input, however we still need to see if deceleration needs to happen!
	JMP checkForHdec
horizontalInputEngaged:
	;;;===============================HANDLE HORIZONTAL ACCELERATION==================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;; So, if a horizontal input is engaged, we want the acceleration to be able to swing
	;;;;; from negative max speed to positive max speed.
	;;;;; so the twos compliment of max speed is the negative value.
	;;;;; if the left horizontal input is engaged, speed needs to go down by the acceleration value.
	;;;;; if the right horizontal input is engaged, speed needs to go up by the acceleration value.
	LDA Object_movement,x
	AND #%01000000
	BEQ LeftInputEngaged_forAccHandle
	;;; here, the right input is engaged for acc handling.
	LDA Object_h_speed_lo,x
	CLC
	ADC tempAccAmount
	STA Object_h_speed_lo,x
	LDA Object_h_speed_hi,x
	ADC #$00
	STA Object_h_speed_hi,x
	;;;; we now have values pushed to horizontal speed, 
	;;;; but in order to make this stick, we have to check to see if they've surpassed max speed.
	;;;; For this, we will need a 16 bit comparison.
	LDA Object_h_speed_hi,x
	BMI rightMaxSpeedNotReached
	CMP temp3
	BCC rightMaxSpeedNotReached
	BNE rightMaxSpeedIsReached
	LDA Object_h_speed_lo,x
	CMP temp2
	BCC rightMaxSpeedNotReached
rightMaxSpeedIsReached:
	LDA temp2
	STA Object_h_speed_lo,x
	LDA temp3
	STA Object_h_speed_hi,x
rightMaxSpeedNotReached:
	
	JMP doneGettingInertia

LeftInputEngaged_forAccHandle:
	LDA Object_h_speed_lo,x
	sec
	sbc tempAccAmount
	STA Object_h_speed_lo,x
	LDA Object_h_speed_hi,x
	sbc #$00
	STA Object_h_speed_hi,x
	;;;; we now have values pushed to horizontal speed, 
	;;;; but in order to make this stick, we have to check to see if they've surpassed max speed.
	;;;; For this, we will need a 16 bit comparison.
	LDA Object_h_speed_lo,x
	CLC
	ADC temp2
	LDA Object_h_speed_hi,x
	ADC temp3
	BPL leftMaxSpeedNotReached
	;; max speed is reached;
	LDA #$00
	SEC
	SBC temp2
	STA Object_h_speed_lo,x
	LDA #$00
	;SEC
	SBC temp3
	STA Object_h_speed_hi,x
	
leftMaxSpeedNotReached:
;;;;;;;;;;;;;;;; GET ABSOLUTE VALUE FOR h speeds.
	
	JMP doneGettingInertia
checkForHdec:
	;; here we will be checking for hozizontal deceleration
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
	;;;we need to know whether to ADD or SUBTRACT from speed.
		;;; if the current speed is negative, we need to add to the speed until it passes zero, then zero it out.
		;;; if the current speed is positive, we need to subtract from the speed until it passes zero, then zero it out. 
	BMI hSpeedIsNegative
	;;;; here, hSpeed is positive.
	;;;; so we need to subtract until we cross the zero threshold. 
	LDA Object_h_speed_lo,x
	SEC
	SBC tempAccAmount
	STA Object_h_speed_lo,x
	LDA Object_h_speed_hi,x
	SBC #$00
	STA Object_h_speed_hi,x
	BMI setHspeedToZero
	;;; we had not reached zero yet.
	;;; so keep the new update to speed and
	;;; continue on.
	JMP doneGettingInertia
	
hSpeedIsNegative:
	;;; here, hSpeed is negative
	;;; so we need to add until we cross the zero threshold
	LDA Object_h_speed_lo,x
	CLC
	ADC tempAccAmount
	STA Object_h_speed_lo,x
	LDA Object_h_speed_hi,x
	ADC #$00
	STA Object_h_speed_hi,x
	BPL setHspeedToZero
	;;; we had not reached zero yet
	;;; so keep the new update to speed and
	;;; continue on.
	JMP doneGettingInertia
	
setHspeedToZero:
	LDA #$00
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	JMP doneGettingInertia

	
doneGettingInertia:
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
	BMI inertiaIsNegative
	;;; intertia is positive.
	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	;STA Object_x_lo,x
	STA xHold_lo
	LDA Object_x_hi,x
	ADC Object_h_speed_hi,x
	;STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	ADC #$00
	;STA Object_scroll,x
	STA nt_hold
		
	;;;; here is a macro that handles player guided right scrolling.
	;;;; you can disable right scrolling by simply commenting this one macro out.
	;DoPlayerGuidedRightScroll	
		
	JMP doneGettingNewPotentialHorizintalPosition
	
	
inertiaIsNegative:
	LDA Object_h_speed_lo,x
	EOR #$FF
	STA temp
	LDA Object_h_speed_hi,x
	EOR #$FF
	STA temp1
	LDA Object_x_lo,x
	SEC
	SBC temp
	;STA Object_x_lo,x
	STA xHold_lo
	LDA Object_x_hi,x
	SBC temp1
	;STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	SBC #$00
	;STA Object_scroll,x
	STA nt_hold
	
	
	;;; this handles player guided left scrolling
	;;; to disable left scrolling, simply comment this one macro out.
	;DoPlayerGuidedLeftScroll

	
	;JMP doneGettingNewPotentialHorizintalPosition ;; redundant if flows directly into it.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;========================================================

	
doneGettingNewPotentialHorizintalPosition:
	ENDM
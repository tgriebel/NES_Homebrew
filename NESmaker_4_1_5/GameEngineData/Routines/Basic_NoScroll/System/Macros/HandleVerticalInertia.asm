	
MACRO HandleVerticalInertia
;;VERTICAL MOVEMENT CHECKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA Object_movement,x
	AND #%00100000 ;; check if L or R is engaged.
	BNE verticalInputEngaged
	;;; there was no horizontal input, however we still need to see if deceleration needs to happen!
	JMP checkForVdec
verticalInputEngaged:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;===============================HANDLE Vertial ACCELERATION==================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;; So, if a vertical input is engaged, we want the acceleration to be able to swing
	;;;;; from negative max speed to positive max speed.
	;;;;; so the twos compliment of max speed is the negative value.
	;;;;; if the up vertical input is engaged, speed needs to go down by the acceleration value.
	;;;;; if the down horizontal input is engaged, speed needs to go up by the acceleration value.
	LDA Object_movement,x
	AND #%00010000
	BEQ UpInputEngaged_forAccHandle
	;;; here, the down input is engaged for acc handling.
	LDA Object_v_speed_lo,x
	CLC
	ADC tempAccAmount
	STA Object_v_speed_lo,x
	LDA Object_v_speed_hi,x
	ADC #$00
	STA Object_v_speed_hi,x
	;;;; we now have values pushed to vertical speed, 
	;;;; but in order to make this stick, we have to check to see if they've surpassed max speed.
	;;;; For this, we will need a 16 bit comparison.
	LDA Object_v_speed_hi,x
	BMI downMaxSpeedNotReached
	CMP temp3
	BCC downMaxSpeedNotReached
	BNE downMaxSpeedIsReached
	LDA Object_v_speed_lo,x
	CMP temp2
	BCC downMaxSpeedNotReached
downMaxSpeedIsReached:
	LDA temp2
	STA Object_v_speed_lo,x
	LDA temp3
	STA Object_v_speed_hi,x
downMaxSpeedNotReached:
	
	JMP doneGettingVInertia

UpInputEngaged_forAccHandle:
	LDA Object_v_speed_lo,x
	sec
	sbc tempAccAmount
	STA Object_v_speed_lo,x
	LDA Object_v_speed_hi,x
	sbc #$00
	STA Object_v_speed_hi,x
	;;;; we now have values pushed to vertical speed, 
	;;;; but in order to make this stick, we have to check to see if they've surpassed max speed.
	;;;; For this, we will need a 16 bit comparison.
	LDA Object_v_speed_lo,x
	CLC
	ADC temp2
	LDA Object_v_speed_hi,x
	ADC temp3
	BPL upMaxSpeedNotReached
	;; max speed is reached;
upMaxSpeedIsReached:
	LDA #$00
	SEC
	SBC temp2
	STA Object_v_speed_lo,x
	LDA #$00
	;SEC
	SBC temp3
	STA Object_v_speed_hi,x
	
upMaxSpeedNotReached:
;;;;;;;;;;;;;;;; GET ABSOLUTE VALUE FOR v speeds.
	
	JMP doneGettingVInertia
checkForVdec:
	;; here we will be checking for hozizontal deceleration
	LDA Object_v_speed_lo,x
	CLC
	ADC #$00
	LDA Object_v_speed_hi,x
	ADC #$00
	;;;we need to know whether to ADD or SUBTRACT from speed.
		;;; if the current speed is negative, we need to add to the speed until it passes zero, then zero it out.
		;;; if the current speed is positive, we need to subtract from the speed until it passes zero, then zero it out. 
	BMI vSpeedIsNegative
	;;;; here, hSpeed is positive.
	;;;; so we need to subtract until we cross the zero threshold. 
	LDA Object_v_speed_lo,x
	SEC
	SBC tempAccAmount
	STA Object_v_speed_lo,x
	LDA Object_v_speed_hi,x
	SBC #$00
	STA Object_v_speed_hi,x
	BMI setVspeedToZero
	;;; we had not reached zero yet.
	;;; so keep the new update to speed and
	;;; continue on.
	JMP doneGettingVInertia
	
vSpeedIsNegative:
	;;; here, hSpeed is negative
	;;; so we need to add until we cross the zero threshold
	LDA Object_v_speed_lo,x
	CLC
	ADC tempAccAmount
	STA Object_v_speed_lo,x
	LDA Object_v_speed_hi,x
	ADC #$00
	STA Object_v_speed_hi,x
	BPL setVspeedToZero
	;;; we had not reached zero yet
	;;; so keep the new update to speed and
	;;; continue on.
	JMP doneGettingVInertia
	
setVspeedToZero:
	LDA #$00
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	JMP doneGettingVInertia

	
doneGettingVInertia:
	LDA Object_v_speed_lo,x
	CLC
	ADC #$00
	LDA Object_v_speed_hi,x
	ADC #$00
	BMI VinertiaIsNegative
	;;; intertia is positive.
	LDA Object_y_lo,x
	CLC
	ADC Object_v_speed_lo,x
	;STA Object_y_lo,x
	STA yHold_lo
	LDA Object_y_hi,x
	ADC Object_v_speed_hi,x
	;STA Object_y_hi,x
	STA yHold_hi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; CHECK TO SEE IF BOTTOM BOUNDS IS REACHED.
	LDA Object_y_lo,x
	CLC
	ADC Object_v_speed_lo,x
	LDA Object_y_hi,x
	ADC Object_v_speed_hi,x
	ADC Object_bottom,x
	CMP #BOUNDS_BOTTOM
	BCC +
	JSR doBottomBounds_player
+
	BNE +
	JSR doBottomBounds_player
+

		
	;;;; HERE IS WHERE WE MIGHT ADD DOWNWARD SCROLLING.
	
	JMP doneGettingNewPotentialVerticalPosition
	
	
VinertiaIsNegative:
	LDA Object_v_speed_lo,x
	EOR #$FF
	STA temp
	LDA Object_v_speed_hi,x
	EOR #$FF
	STA temp1
	LDA Object_y_lo,x
	SEC
	SBC temp
	;STA Object_y_lo,x
	STA yHold_lo
	LDA Object_y_hi,x
	SBC temp1
	;STA Object_y_hi,x
	STA yHold_hi
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; CHECK FOR TOP EDGE
	LDA Object_y_lo,x
	SEC
	SBC temp
	LDA Object_y_hi,x
	ADC Object_top,x
	SBC temp1
	BCS +
	JSR doTopBounds_player
	JMP ++
+
	LDA yHold_hi
	CMP #BOUNDS_TOP
	BCS +
	JSR doTopBounds_player
+
++
	
	;;; this handles player guided left scrolling
	;;; to disable left scrolling, simply comment this one macro out.
;	DoPlayerGuidedLeftScroll

	
	JMP doneGettingNewPotentialVerticalPosition ;; redundant if flows directly into it.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;========================================================

	
doneGettingNewPotentialVerticalPosition:
	ENDM
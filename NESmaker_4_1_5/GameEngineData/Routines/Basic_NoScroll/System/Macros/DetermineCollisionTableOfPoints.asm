MACRO DetermineCollisionTableOfPoints arg0
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
	BMI +++ ;;; must have left inertia 

	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	LDA Object_x_hi,x
	ADC Object_h_speed_hi,x
	ADC arg0
	LDA nt_hold
	ADC #$00
	AND #%00000001
	BNE +
	;; is an even table
	LDA collisionTable,y
	JMP ++
+
	
	;; is in an odd table.
	LDA collisionTable2,y
++
	JMP ++++
	
+++
	;;;; WACKY THINGS HAPPEN ON THE EDGE
	;;; USE THIS FOR EDGE CHECKING.  MAY PRODUCE 
	;;; ANOMALOUS RESULTS, try changing the value.
	LDA #$FA
	STA temp2
	
	LDA xHold_hi
	CMP temp2
	BCC +

	LDA collisionTable,y
	JMP ++++
+
	
	LDA nt_hold
	AND #%00000001
	BNE +

	LDA collisionTable,y
	JMP ++++
+
	LDA collisionTable2,y
	
++++


	ENDM

	;LDA Object_h_speed_lo,x
	;CLC
	;ADC #$00
	;LDA Object_h_speed_hi,x
	;ADC #$00
	;;;we need to know whether to ADD or SUBTRACT from speed.
		;;; if the current speed is negative, we need to add to the speed until it passes zero, then zero it out.
		;;; if the current speed is positive, we need to subtract from the speed until it passes zero, then zero it out. 
	;BMI +++ ;movement is negative
	;JMP +++
	; LDA scrollDirection
	; BEQ +++
	
	
	
	; LDA Object_x_lo,x
	; CLC
	; ADC Object_h_speed_lo,x
	; LDA Object_x_hi,x
	; ADC Object_h_speed_hi,x
	; ADC arg0
	; LDA Object_scroll,x
	; ADC #$00
	; CMP nt_hold
	; BEQ +
	; JMP ++++
	
; +++

	; LDA Object_scroll,x
	; CMP nt_hold
	; BEQ +
	
	; JMP ++++
	
	; LDA Object_h_speed_lo,x
	; EOR #$FF
	; STA temp
	; LDA Object_h_speed_hi,x
	; EOR #$FF
	; STA temp1
	


	; LDA Object_x_lo,x
	; sec
	; SBC temp
	; LDA Object_x_hi,x
	; SBC temp1
	; LDA Object_scroll,x
	; SBC #$00
	; CMP nt_hold
	; BEQ +
	; JMP ++++

; ++++

; DifNT
	
	; ;;; point is in a different table
	; ;;; than the scroll value.
	
	; LDA #$01
	; STA tempCol
	; JMP ++
; +
; SameNT


	; ;;; point is in the same table
	; ;;; than the scroll value.
	; LDA #$00
	; STA tempCol
; ++


	;ENDM

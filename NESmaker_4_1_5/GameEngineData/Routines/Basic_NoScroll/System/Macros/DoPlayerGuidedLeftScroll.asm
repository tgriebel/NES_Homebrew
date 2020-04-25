
MACRO DoPlayerGuidedLeftScroll
	;;; handle scroll position updating based on player movement in the negative direction.
;;; First, check to see if x is set to the player object.
;;; in a two player game, you might make an invisible dummy object that always
;;; exists half way between the two players, which this could read instead.
;;;; temp is still the inverted lo speed, and temp1 is still the inverted high speed.

	LdA screenFlags
	AND #%01000000
	BNE skipLeftScrollCheck
	CPX player1_object
	BNE skipLeftScrollCheck
	;;; this is the player.
	LDA scrollDirection
	BEQ scrollDirectionAlreadyLeft
	LDA #$01
	STA forceScroll 
		;;; if we were moving right, and now all the sudden are moving left
		;;; there will be an empty seam, so to fix it we'll force a scroll column update.
	LDA #$00
	STA scrollDirection
scrollDirectionAlreadyLeft:	
;;; We can only scroll right if:
		;;; 1)  this is a scrolling screen.
		;;; 2) this is not a scroling right edge.
		;;; 3) we are beyond the scrolling pad.

	LDA screenFlags
	AND #%00001000 ;; is this a scrolling LR screen?
	BNE dontskipLeftScrollCheck ;; it is not a LR scroller.
	LDA Object_x_lo,x
	sec
	sbc temp
	LDA xScroll
	sbc temp1
	BCS dontskipLeftScrollCheck
	LDA #$00
	STA xScroll
	JMP skipLeftScrollCheck
	
dontskipLeftScrollCheck:	
	LDA Object_x_lo,x
	sec
	sbc temp
	LDA xScroll
	sbc temp1
	LDA xScroll_hi
	sbc #$00
	BMI skipLeftScrollCheck
notLeftScrollEdge:
	
	;;; NOW check the x value against the left pad value 
	LDA Object_x_hi,x
	SEC 
	SBC xScroll
	CLC
	ADC Object_h_speed_hi,x
	CMP #SCROLL_LEFT_PAD 
	BCS skipLeftScrollCheck
playerXreachedLeftPad:

	LDA Object_x_lo,x
	sec
	sbc temp
	LDA xScroll
	sbc temp1
	STA xScroll
	LDA xScroll_hi
	sbc #$00
	STA xScroll_hi
skipLeftScrollCheck:	
	ENDM
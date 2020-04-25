	
	
MACRO DoPlayerGuidedRightScroll
	
	LdA screenFlags
	AND #%01000000
	BNE skipRightScrollCheck
	
;;; handle scroll position updating based on player movement in the positive direction.
;;; First, check to see if x is set to the player object.
;;; in a two player game, you might make an invisible dummy object that always
;;; exists half way between the two players, which this could read instead.
	CPX player1_object
	BNE skipRightScrollCheck
	;;; this is the player.
	LDA scrollDirection
	BNE scrollDirectionAlreadyRight
	LDA #$01
	STA forceScroll ;; if we WERE scrolling left but now are about to start scrolling right
					;;; we will have a blank area on the current seam.
					;;; so if that's the case, we will force a scroll update.
	LDA #$01
	STA scrollDirection
scrollDirectionAlreadyRight:	
	;;; We can only scroll right if:
		;;; 1)  this is a scrolling screen.
		;;; 2) this is not a scroling right edge.
		;;; 3) we are beyond the scrolling pad.

	LDA screenFlags
	AND #%00010000 ;; is this a scrolling LR screen?
	BEQ skipRightScrollCheck ;; it is not a LR scroller.
	;LDA screenFlags
	;AND #%00000100 ;; is this a "right edge type"?
	;BEQ notRightEdgeScroller
	
	
;	JMP skipRightScrollCheck
;notRightEdgeScroller:
	;;; NOW check the x value against the right pad value 
	LDA Object_x_hi,x
	SEC 
	SBC xScroll
	CLC 
	ADC Object_h_speed_hi,x
	CMP #SCROLL_RIGHT_PAD
	BCS playerXreachedRightPad
	;;; right pad was not reached yet.
	JMP skipRightScrollCheck
playerXreachedRightPad	
	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	LDA xScroll
	ADC Object_h_speed_hi,x
	STA xScroll
	LDA xScroll_hi
	ADC #$00
	STA xScroll_hi

skipRightScrollCheck:
	ENDM
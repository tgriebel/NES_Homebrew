doPlayerGuidedScroll:
	CPX player1_object
	BEQ isPlayer1_doPlayerGuidedScroll
	JMP CheckNonPlayerScrollEdge ;; this will turn off monsters if they get to the edges
isPlayer1_doPlayerGuidedScroll:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO A CHECK FOR PLAYER INPUT CONTROLLED SCROLLING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LDA Object_h_speed_hi,x
	BPL scrollDirectionIsRight
	;BNE scrollDirectionIsRight
	JMP scrollDirectionIsLeft ;; for now, normal movement.
scrollDirectionIsRight:
;	LDA columnTracker
	;AND #%00001111
	;CMP #%00001111
	;BNE canScrollRight
	LDA screenFlags
	AND #%00010000
			;|+ can scroll R
			;+- can scroll both ways.
	BNE canScrollRight
	JMP noScrolling
	;; below is necessary for scrolling right, because we need to cross the whole screen
	;; before the update.  But this will trigger the no scroll as soon as the screen is in place
	;; to 00 scroll value.
	;LDA xScroll
	;CLC
	;ADC Object_h_speed_hi,x
	;BCC canScrollRight
	;LDA #$00
	;STA xScroll
	;JMP noScrolling
canScrollRight:
	LDA screenFlags
	AND #%00000100
	BEQ canScrollRight2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA #$00
	STA xScroll
	LDA Object_scroll,x
	STA nt_hold
	JMP noScrollingR
	
canScrollRight2:

	LDA Object_x_hi,x
	SEC 
	SBC xScroll
	CLC 
	ADC Object_h_speed_hi,x
	CMP #SCROLL_RIGHT_PAD
	BCS CanDoScrolling2
	JMP noScrolling
CanDoScrolling2	
	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	;; now we know the carry for updating scroll

	LDA xScroll
	ADC Object_h_speed_hi,x
	STA xScroll
	
	



	JMP noScrolling ;; this is where the x is updated.  so we'll update always.
	
	JMP doneWithPlayerGuidedScrolling
;	
checkLeftNametable:
	
	
	
skipScroll:
	JMP doneWithPlayerGuidedScrolling
	
	
scrollDirectionIsLeft:
	;;; check for edge:
	;;; Do edge check in bounds for normal horizontal scroller.
	LDA screenFlags
	AND #%00010000
			;| + can scroll left
			;+ - scroll both ways
	BNE canScrollLeft

	
	JMP noScrolling
canScrollLeft:
	LDA screenFlags
	AND #%00001000 ;; is left edge
	BEQ skipLeftScrollEdgeCheck
	LDA Object_h_speed_hi,x
	EOR #$FF
	sec 
	adc #$00
	STA temp
	
	
	
	LDA xScroll
	SEC
	SBC temp
	BCS skipLeftScrollEdgeCheck
	
	LDA Object_scroll,x

	STA nt_hold
	JMP noScrollingL

skipLeftScrollEdgeCheck:	
	;;;; invert the scroll for easy carry check.
	;LDA Object_x_hi,x
	LDA Object_x_hi,x
	SEC 
	SBC xScroll
	CLC
	ADC Object_h_speed_hi,x
	CMP #SCROLL_LEFT_PAD 
	BCS noScrolling
	
	
	
	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	;;; now we know the carry for updating the scroll
	;STA Object_x_lo,x
	LDA xScroll

	ADC Object_h_speed_hi,x
	STA xScroll
	;; figure out xScroll_hi
	
	
	
	JMP noScrolling
	JMP doneWithPlayerGuidedScrolling



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; if NOT scrolling, mainly due to either scrolling being off, or
;;; being outside the scroll window, do this:

noScrollingR:
	LDA Object_x_hi,x
	clc
	ADC Object_right,x
;	clc
	ADC Object_h_speed_hi,x
;	CLC
	ADC #$02
	BCC dontSkipScroll
	CPX player1_object
	BEQ isPlayerAgainstRightEdge
	;;; is not player against right edge
	JMP RESET
	JMP noScrolling
isPlayerAgainstRightEdge:
	JMP skipScroll
dontSkipScroll:
	JMP noScrolling
noScrollingL:


	LDA Object_x_hi,x
	SEC
	SBC temp
	BCS isNotAgainstLeftEdge
AgainstEdge:
	JMP RESET
	CPX player1_object
	BEQ isPlayerAgainstLeftEdge
	;; is not player against left edge
	JMP RESET
	JMP noScrolling
isPlayerAgainstLeftEdge:
	LDA #$00
	STA xScroll
	JMP skipScroll
		

isNotAgainstLeftEdge:

	

noScrolling:
	LDA xHold_lo
	STA Object_x_lo,x
	LDA xHold_hi
	STA Object_x_hi,x
	LDA nt_hold
	STA Object_scroll,x
	
doneWithPlayerGuidedScrolling:
	RTS
	
	
	
	
	
	
CheckNonPlayerScrollEdge:
	RTS

	LDA Object_scroll,x
	CMP currentNametable
	BEQ inCurrentNametable
	;; in a different nametable.
	;LDA xScroll
	;EOR #$FF
	;CMP Object_x_hi,x
	BCc doneWithObjectEdgeEval
;	LDA Object_x_hi,x
;	CLC
;	ADC Object_right,x
;	CLC
;	ADC #$08
;	CMP xScroll
;	BCC doneWithObjectEdgeEval
	;DeactivateCurrentObject
	;LDA Object_status,x
	;ORA #%00000100
	;STA Object_status,x ;; this will make it "off screen"
	JMP doneWithObjectEdgeEval
	
inCurrentNametable:
	LDA columnTracker
	AND #%00001111
	STA temp
	LDA Object_x_hi,x
	LSR
	LSR
	LSR
	LSR
	CMP temp
	BNE doneWithObjectEdgeEval
	;DeactivateCurrentObject
	LDA Object_status,x
	ORA #%00000100
	STA Object_status,x ;; this will make it "off screen"
doneWithObjectEdgeEval:
	RTS
	

	
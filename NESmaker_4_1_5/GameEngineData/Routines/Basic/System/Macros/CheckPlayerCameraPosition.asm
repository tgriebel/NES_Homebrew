	
MACRO CheckPlayerCameraPosition	
	
	
	CPX player1_object
    BEQ notdoneWithCameraCheck
	JMP doneWithCameraCheck
notdoneWithCameraCheck:
	LDA gameHandler
	AND #%10000000
	BNE gameIsActive
	JMP doneWithCameraCheck
gameIsActive:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;======== ALIGN SCREEN IF NOT LINED UP WITH NAMETABLE	
	;;; corrupts A
	;;; if value is 1, it will skip gravity
	;TXA
	;STA tempx
	;JSR AlignScreenToNametable

	;BEQ dontAlignScreens
	;JMP doneWithCameraCheck
;dontAlignScreens:
	;LDX tempx
;;;; END HANDLE ALIGN SCREENS
;;;;;;;;======================================	

;;;;; BOTTOM CHECK
	LDA Object_y_lo,x
	CLC
	ADC Object_v_speed_lo,x
	LDA Object_y_hi,x
	ADC Object_v_speed_hi,x
	CMP #BOUNDS_TOP
	BCS notAtBoundsTop
;	LDA xScroll
	;BNE +
	LDA #$00
	STA xScroll
	JSR doTopBounds_player
	RTS
;+:
	JMP notAtBoundsTop ;; comment out if you want to use align screen 
 ;; do alignment of screen if it wasn't aligned.
	;;; if player's scroll is the same as xScroll_hi, we need to reverse scroll.
	;;; otherwise, it should be forward scroll
	LDA Object_scroll,x
	CMP xScroll_hi
	BEQ + ;; need to reverse
	;; forward auto scroll
	LDA #%00000000
	JMP ++
+ ;; need to reverse
	LDA #%10000000
++
	ORA #$02
	STA align_screen_flag
	LDA #ALIGN_TIMER
	STA genericTimer
	LDA #$01
	STA prevent_scroll_flag
	JMP doneWithCameraCheck
notAtBoundsTop:
	LDA Object_y_lo,x
	CLC
	ADC Object_v_speed_lo,x
	LDA Object_y_hi,x
	ADC Object_v_speed_hi,x
	ADC Object_bottom,x
	CMP #BOUNDS_BOTTOM
	BCS atBottomBounds
	JMP notAtBottomBounds
atBottomBounds:
	CPX player1_object
	BEQ isPlayerAtBottomOfScrollingBounds
	;; is not player at scrolling bounds
	;;; check for gravity? if not player and is at bottom bounds, and is a platformer  
	DeactivateCurrentObject
	JMP notAtBottomBounds
isPlayerAtBottomOfScrollingBounds:
	;LDA xScroll
	;BNE +
	LDA #$00
	STA xScroll
	JSR doBottomBounds_player
	RTS
;+: ;; do alignment of screen if it wasn't aligned.
	JMP notAtBottomBounds ;; comment out if want to align screen
	LDA Object_scroll,x
	CMP xScroll_hi
	BEQ + ;; need to reverse
	;; forward auto scroll
	LDA #%00000000
	JMP ++
+ ;; need to reverse
	LDA #%10000000
++
	ORA #$01
	STA align_screen_flag
	LDA #ALIGN_TIMER
	STA genericTimer
	LDA #$01
	STA prevent_scroll_flag
	
	JMP doneWithCameraCheck
notAtBottomBounds:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;; let's check to see if we're against the leftmost edge.
	
	LDA xScroll_hi
	BNE + ; not on screen 0
	;; is on screen zero
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
	BPL + ;; not moving left.
	LDA Object_scroll,x
	BNE +
	LDA xScroll
	CMP xHold_hi
	BCS leftOfCameraForPlayer
	JMP checkRightEdge

+


    LDA nt_hold
    CMP xScroll_hi
    BCC leftOfCameraForPlayer
    BNE checkRightEdge
    LDA xHold_hi
    CMP xScroll
    BCC leftOfCameraForPlayer
    JMP checkRightEdge
leftOfCameraForPlayer:
    ;;; dont update position
    JMP doScrollingLeftBounds
checkRightEdge:
    LDA xScroll_hi
    CLC
    ADC #$01
    STA temp
    
    LDA xScroll
    SEC
    SBC Object_right,x
    STA temp1
    LDA temp
    SBC #$00
    STA temp
    
    
    CMP nt_hold
    BCC rightOfCameraEdgeForPlayer
    BNE doneWithCameraCheck
    LDA temp1
    CMP xHold_hi
    BCC rightOfCameraEdgeForPlayer
    JMP doneWithCameraCheck
rightOfCameraEdgeForPlayer:
    JMP doScrollingRightBounds
  
doScrollingLeftBounds:
    ;;; enter what should happen at bounds for player.
	;;; an RTS here will result in skipping position update.

	JSR doLeftBounds_player
    RTS    
    
doScrollingRightBounds:
    ;;; enter what should happen at bounds for player.
	;;; an RTS here will result in skipping position update.
	
	JSR doRightBounds_player
    RTS
	
doScrollingTopBounds:

	JSR doTopBounds_player
	RTS

doScrollingBottomBounds:
	JSR doBottomBounds_player
	RTS
doneWithCameraCheck:
    ENDM
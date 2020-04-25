ExtraInputControl:
    ;;; if left and right are not pressed

	
	LDA screenFlags
	AND #%00100000 ;; does it use gravity?
					;; if it does not, it would not have jumping or ducking, so
					;; skip state updates for jumping and ducking.
	BNE handleExtraInputControl
	;;; does not use gravity - are there any caveats we need for not handling gravity?
	RTS
handleExtraInputControl:

    ;;; occasionally, there is input code that may be very specific, and it may be 
    ;;; difficult to implement via the visual interface and accompanying scripts.
    ;;; this is a code that runs after all input checks, and allows for custom ASM.
    LDA gameState
    CMP #GS_MainGame
    BEQ doMainGameUpdates
    JMP skipMainGameExtraInputControl
doMainGameUpdates:  
    LDX player1_object

	GetCurrentActionType player1_object
	STA temp
	LDA Object_physics_byte,x
	AND #%00000010
	BEQ isNotClimbing
    LDA temp
    CMP #$04
    BNE isNotClimbing
	LDA gamepad
	AND #%11000000
	BEQ noDirWhileClimbing
	ChangeObjectState #$02, #$04
noDirWhileClimbing:
    ;;; is climbing.
    ;;; which means don't check to change to idle.
   JMP skipMainGameExtraInputControl
isNotClimbing:
    LDA temp
    CMP #$03 ;; is it shooting (shooting is same anim in air and on ground)
    BNE isNotAttackingAction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    JMP skipMainGameExtraInputControl
isNotAttackingAction:   

    
    LDA gamepad
    AND #%11000000 ;;; left and right
    BEQ dontskipMainGameExtraInputControl
	JMP skipMainGameExtraInputControl
dontskipMainGameExtraInputControl:
    ;;; if left and right are not pressed
	
	LDA screenFlags
	AND #%00100000 ;; does it use gravity?
					;; if it does not, it would not have jumping or ducking, so
					;; skip state updates for jumping and ducking.
	BEQ notDucking ;; just will change to idle.

    LDA Object_physics_byte,x
    AND #%00000001 ;; if is in air
    BNE notInAir
    GetCurrentActionType player1_object
    CMP #$02 ;; is it already state 2?
    BEQ skipMainGameExtraInputControl

    ChangeObjectState #$02, #$04
    JMP skipMainGameExtraInputControl
notInAir:
    LDA Object_h_speed_lo,x
    ORA Object_h_speed_hi,x
    BNE skipMainGameExtraInputControl
    ;;;; controller is not pressed
    ;;;; horizontal speed is zero.
    ;; check to see if in air, shooting, etc.
	 LDA gamepad
	AND #%00100000 ; if down is pressed
	BEQ notDucking
	 ChangeObjectState #$5, #$04
	 JMP skipMainGameExtraInputControl
notDucking:
    LDA gamepad
	AND #%11110000
	BNE skipMainGameExtraInputControl
    ChangeObjectState #$00, #$04
skipMainGameExtraInputControl:  
    
    RTS
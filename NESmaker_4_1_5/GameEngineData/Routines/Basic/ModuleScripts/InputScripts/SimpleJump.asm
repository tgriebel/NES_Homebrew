;; THIS CODE IS FOR JUMPING.
   LDX player1_object
   ;;; let's check for if we are standing on a jumpthrough platform,
   ;;; for which "down and jump" will jump downwards through
   ;;; comment this out if you do not want that functionality
   LDA screenFlags
   AND #%00100000 ;; does it use gravity?
					;; In modules where screenFlag 5 gravity,
					;; flipping it on would mean that the screen uses gravity.
					;; If the screen does not use gravity skip the jump code.
   BEQ dontJump
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; PART 1: Use Jumpthrough Platform logic.
 ;; If you want down + jump to allow you to pass downward through a jumpthrough platform, 
 ;; use this code.
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 ;;; Bit 3 of Object_physics_byte is set if you are standing on
	 ;;; a jumpthrough platform.
	 ;  LDA Object_physics_byte,x
	 ;  AND #%00001000
	 ;  BEQ notStandingOnJumpThroughPlatform
	 ;  LDA gamepad
	 ;  AND #%00100000
	 ;  BEQ notStandingOnJumpThroughPlatform
		 ;;; Here, you are standing on a jumpthrough platform
		 ;;; and you are pressing down and jump.  The easiest way to 
		 ;;; now make the player pass through the platform is just manually
		 ;;; change his y value downward by an arbitrary amount, and then
		 ;;; skip the rest of the jump code.
	 ;  LDA Object_y_hi,x
	 ;  CLC
	 ;  ADC #$09  ;; this is an arbitrary value.  
	 ;  STA Object_y_hi,x
	 ;  JMP dontJump
	;notStandingOnJumpThroughPlatform:
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 2: Check under feet for solid or jumpthrough platform.
;; In the base module, bit 0 of Object_physics_byte is flipped if you are
;; on solid ground and bit 2 is flipped if you are on jump through
;; platform.  This happens in the CheckUnderObject macro.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
	   ; LDA Object_physics_byte,x
	   ; AND #%00000001
	   ; BNE canJump
	   ; LDA Object_physics_byte,x
	   ; AND #%00000100
	   ; BEQ dontJump
    
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 3: Actual jumping.
;; This is where the player actually starts moving upwards.
;; For this, a user constant must be created for JUMP_SPEED_LO
;; and JUMP_SPEED_HI.  Alternatively, you could put arbitrary values
;; in their place.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	canJump:
		;;; TURN OFF "STANDING ON JUMPTHROUGH PLATFORM" if it is on
		;;; by zeroing out the jumpthrough bit.
		LDA Object_physics_byte,x
		AND #%11110111
		STA Object_physics_byte,x
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; set the vertical speed to a negative number to make it "jump".
		LDA #$00
		SEC
		SBC #JUMP_SPEED_LO
		STA Object_v_speed_lo,x
		LDA #$00
		SEC
		SBC #JUMP_SPEED_HI
		STA Object_v_speed_hi,x
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; optionally, change the state to your games jumping state.
		;;; The first argument in this macro is what state = jump.
		;;; The second is the length of the first animated frame.  
		;;; Generally, a small number is good for this, especially if 
		;;; there is no animation for jump and it is a single frame.
		ChangeObjectState #$02, #$04
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; and play a jumping sound.
		;;; for this to work, SND_JUMP must be defined in your
		;;; sound effects.
		;PlaySound #SND_JUMP
	dontJump:
		;; return from the subroutine.
		RTS
    RTS
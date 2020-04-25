; a jumps
 
   LDX player1_object
   ;;; let's check for if we are standing on a jumpthrough platform,
   ;;; for which "down and jump" will jump downwards through
   ;;; comment this out if you do not want that functionality
    LDA screenFlags
    AND #%00100000 ;; does it use gravity?
    BEQ dontJump
    
   LDA Object_physics_byte,x
   AND #%00001000
   BEQ notStandingOnJumpThroughPlatform
   LDA gamepad
   AND #%00100000
   BEQ notStandingOnJumpThroughPlatform
   LDA Object_y_hi,x
   CLC
   ADC #$09
   STA Object_y_hi,x
   JMP dontJump
notStandingOnJumpThroughPlatform:
   
   LDA Object_physics_byte,x
   AND #%00000001
   BNE canJump
   LDA Object_physics_byte,x
   AND #%00000100
   BEQ dontJump
    
canJump:
    ;;; TURN OFF "STANDING ON JUMPTHROUGH PLATFORM" if it is on
    LDA Object_physics_byte,x
    AND #%11110111
    STA Object_physics_byte,x
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #$00
    SEC
    SBC #JUMP_SPEED_LO
    STA Object_v_speed_lo,x
    LDA #$00
    SEC
    SBC #JUMP_SPEED_HI
    STA Object_v_speed_hi,x
    GetCurrentActionType player1_object
    CMP #$03 ;; attack
    BEQ +
    ChangeObjectState #$02, #$04
   +
    PlaySound #SND_JUMP
dontJump:
    RTS
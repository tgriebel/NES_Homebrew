CalculateAccAndSpeed:
    LDA update_screen
    BEQ doPhysics
    RTS
doPhysics:
    LDA gameHandler
    AND #%10000000
    BNE doPhysics2
    RTS
doPhysics2:
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA Object_vulnerability,x
    AND #%00000001
    BNE doAimedPhysics
    JMP doNormalPhysics
doAimedPhysics
    HandleAimedPhysics
    JMP donePhysicsUpdate
doNormalPhysics:

    LDA Object_x_hi,x
    STA xPrev
    LDA Object_y_hi,x
    STA yPrev
    LDY Object_type,x ;; now we can read necessary lut table values for this object.
    
    LDA tempMaxSpeed
    ASL
    ASL
    ASL
    STA temp2 ;; temp2 now equals max speed lo

    LDA tempMaxSpeed
    LSR
    LSR
    LSR
    LSR
    LSR
    STA temp3 ;; temp3 now equals max speed hi

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    HandleHorizontalInertia
    ;;;;; What we have here is the new potential position.
    ;;;;; If we check this position for collision, we will move precisely outside of the collision, 
    ;;;;; so that the object bumps right up against the solid.
    ;;;;; The same technique could be used for objects tagged as solid (like NPCs), though then we'll
    ;;;;; have to come up with a way to trigger them.
    ;;;;; all of which will happen before the object is actually drawn.
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;=======================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;=======================================================;;
    LDA Object_vulnerability,x
    AND #%00100000
    BNE noGravityPhysics ;; still handle inertia, even if the screen has gravity but this object does not.

    LDA screenFlags
    AND #%00100000
    BEQ noGravityPhysics
    JMP gravityPhysics
noGravityPhysics:

    HandleVerticalInertia
    ;;;;; What we have here is the new potential position.
    ;;;;; If we check this position for collision, we will move precisely outside of the collision, 
    ;;;;; so that the object bumps right up against the solid.
    ;;;;; The same technique could be used for objects tagged as solid (like NPCs), though then we'll
    ;;;;; have to come up with a way to trigger them.
    ;;;;; all of which will happen before the object is actually drawn.

    JMP donePhysicsUpdate
gravityPhysics:   

    
    HandleGravity

    
donePhysicsUpdate:



    RTS
    
    
    
    
    
    
DoLadderStuff:
    CPX player1_object
    BEQ dontSkipLadderStuff
    JMP skipLadderStuff
dontSkipLadderStuff:
    LDA Object_physics_byte,x ;; on ladder
    ORA #%00000010
    STA Object_physics_byte,x
    LDA gamepad
    AND #%00010000 ; if up is pressed
    BEQ notPressingUpOnLadder
    GetCurrentActionType player1_object
    CMP #$04 ;; action state of climbing ladder #OBJ_INDEX_LADDER ;; compare to ladder type
    BEQ dontChangeToLadderState ;; already is in ladder state
    ChangeObjectState #$04, #$04
dontChangeToLadderState:
    LDA Object_y_lo,x
    SEC
    SBC #LADDER_SPEED_LO 
    STA Object_y_lo,x
    LDA Object_y_hi,x
    SBC #LADDER_SPEED_HI
    STA Object_y_hi,x
    STA yHold_hi
    Cmp #BOUNDS_TOP
    BCS hasNotReachedTop
    
  JSR doTopBounds_player
hasNotReachedTop:
    
    
    JMP skipLadderStuff
notPressingUpOnLadder:
    LDA gamepad
    AND #%00100000 ; if down is pressed
    BEQ notPressingDownOnLadder

    GetCurrentActionType player1_object
    CMP #$04 ; #OBJ_INDEX_LADDER ;; compare to ladder type
    BEQ dontChangeToLadderState2 ;; already is in ladder state
    ChangeObjectState #$04, #$04
dontChangeToLadderState2:
    LDA Object_y_lo,x
    clc
    adc #LADDER_SPEED_LO 
    STA Object_y_lo,x
    LDA Object_y_hi,x
    adc #LADDER_SPEED_HI
    STA Object_y_hi,x
    CMP #BOUNDS_BOTTOM
    CLC
    ADC Object_bottom,x
    BCC skipLadderStuff
   JSR doBottomBounds_player
    
    JMP skipLadderStuff
notPressingDownOnLadder:
skipLadderStuff:
    RTS
    
    

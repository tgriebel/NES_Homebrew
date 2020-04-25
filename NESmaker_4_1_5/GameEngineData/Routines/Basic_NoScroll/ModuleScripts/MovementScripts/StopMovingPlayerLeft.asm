    StopMoving player1_object, STOP_LEFT
    LDA gameSubState
    BEQ +;; map screen - don't switch to idle.
    CMP #$01
    BEQ ++ ;; pacman screen, switch to idle 
    JMP +++
++ ;; pacman screen
    LDX player1_object
    ChangeObjectState #$00, #$04    
    JMP +
+++
    
+
    
    RTS
    RTS
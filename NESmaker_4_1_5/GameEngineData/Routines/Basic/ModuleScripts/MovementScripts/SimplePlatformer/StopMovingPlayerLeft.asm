    StopMoving player1_object, STOP_LEFT
    GetCurrentActionType player1_object
    CMP #$03 ;; attack
    BEQ +
    ChangeObjectState #$00, #$04    
 + 
    RTS
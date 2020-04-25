  
;;;; STOP PLAYER FROM MOVING DOWN
;;; Here, we will stop the player from moving,  

    StopMoving player1_object, STOP_DOWN
    GetCurrentActionType player1_object
    CMP #$02 ;; if the state is invincible
    BCS + 
    LDX player1_object

;;; and we will change the object state to idle.
    ChangeObjectState #$00, #$04  
+ 
    RTS
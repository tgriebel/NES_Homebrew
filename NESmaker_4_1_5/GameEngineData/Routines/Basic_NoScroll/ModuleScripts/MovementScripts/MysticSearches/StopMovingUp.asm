;; HANDLE FACING DIRECTION.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;WHICH STATES SHOULD PLAYER IGNORE DIRECTION CHANGES?
;;IF DIRECTION SHOULD BE IGNORED, SKIP DIRECTION CHANGE.

;; If down is held,
;; Must check left and right for diagonals.
    LDX player1_object

    LDA gamepad 
    AND #PAD_LEFT
    BEQ +
    ;; here left is still pressed
    ;; so just stop moving down, but can still move left.
    StopMoving player1_object, STOP_UP
    JMP ++
+
    LDA Object_movement,x
    AND #%01000000
    BNE +
    StopMoving player1_object, STOP_LEFT_UP
  +   
    LDA gamepad
    AND #PAD_RIGHT
    BEQ +
    StopMoving player1_object, STOP_UP
    JMP ++
+
    StopMoving player1_object, STOP_RIGHT_UP
    
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE handle actual movement.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHICH STATES SHOULD PLAYER IGNORE BEING ABLE TO UPDATE MOVEMENT?

    RTS
    
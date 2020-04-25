;; HANDLE FACING DIRECTION.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;WHICH STATES SHOULD PLAYER IGNORE DIRECTION CHANGES?
;;IF DIRECTION SHOULD BE IGNORED, SKIP DIRECTION CHANGE.
    GetCurrentActionType player1_object
    BEQ +
    ;; is not idle/run/jump
    
    jmp ++
+
;; If down is held,
;; Must check left and right for diagonals.
    LDX player1_object
   
    LDA gamepad 
    AND #PAD_LEFT
    BEQ +
    StartMoving player1_object, MOVE_LEFT_DOWN
    FaceDirection player1_object, FACE_DOWN_LEFT
    LDA Object_movement,x
    ORA #%00001000 ;; turns on "diag" bit
    STA Object_movement,x
    LDA #DIAG_SENSITIVITY
    STA playerDiagTimer
   
    JMP ++
+
    LDA gamepad
    AND #PAD_RIGHT
    BEQ +
    StartMoving player1_object, MOVE_RIGHT_DOWN
    FaceDirection player1_object, FACE_DOWN_RIGHT
    LDA Object_movement,x
    ORA #%00001000 ;; turns on "diag" bit
    STA Object_movement,x
    LDA #DIAG_SENSITIVITY
    STA playerDiagTimer
    
    JMP ++
+
    LDA Object_movement,x
    AND #%00001000
    BNE ++
    StartMoving player1_object, MOVE_DOWN
    FaceDirection player1_object, FACE_DOWN
    
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE handle actual movement.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHICH STATES SHOULD PLAYER IGNORE BEING ABLE TO UPDATE MOVEMENT?

    RTS
    
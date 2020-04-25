;; HANDLE FACING DIRECTION.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;WHICH STATES SHOULD PLAYER IGNORE DIRECTION CHANGES?
;;IF DIRECTION SHOULD BE IGNORED, SKIP DIRECTION CHANGE.
    GetCurrentActionType player1_object
    BEQ +
    ;; is not idle/run/jump
    
    jmp ++
+
    LDX player1_object
;; If down is held,
;; Must check left and right for diagonals.
;    LDA gamepad 
;    AND #PAD_DOWN
;    BEQ +
;    JMP ++
;+
;    LDA gamepad
;    AND #PAD_UP
;    BEQ +
;    JMP ++
;+
;    FaceDirection player1_object, FACE_LEFT
;++

    LDA Object_movement,x
    AND #%00001000
    BNE ++
    StartMoving player1_object, MOVE_LEFT
    FaceDirection player1_object, FACE_LEFT
    
    ++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE handle actual movement.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHICH STATES SHOULD PLAYER IGNORE BEING ABLE TO UPDATE MOVEMENT?

    RTS
    
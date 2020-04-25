    LDX player1_object

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;; this is for platform game.
    GetCurrentActionType player1_object
    CMP #$03 ;; attack
    BEQ +
    CMP #$01
    BEQ +
    LDA Object_physics_byte,x
    AND #%00000001 ;; is it on the ground?
    BEQ +
    ChangeObjectState #$01, #$04
    JMP +
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;; END PLATFORM TYPE GAME
+
    StartMoving player1_object, MOVE_RIGHT
    FaceDirection player1_object, FACE_RIGHT
    
    RTS
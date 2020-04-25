 ;;;;; START MOVING PLAYER LEFT:
 ;;;;; We will use this when the left button is pressed.
 ;;;;; If we are already showing the walking animation, which is for this module
 ;;;;; action step 1, we will skip changing to the walking state.
    LDX player1_object
    GetCurrentActionType player1_object
    CMP #$02 ;; if the state is invincible
    BEQ ++ ;; skip movement if attacking
    CMP #$03
    BEQ ++ ;skip if we are casting spell
    CMP #$01
    BEQ + ;; if the action type already equals 1, jump forward
    ChangeObjectState #$01, #$04
+
;;;;;; Then, we will begin moving.
    StartMoving player1_object, MOVE_LEFT
++
;;;;;; Lastly, we will change the facing direction.
    FaceDirection player1_object, FACE_LEFT
    RTS
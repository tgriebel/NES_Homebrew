
    LDX player1_object
    GetCurrentActionType player1_object
    CMP #$03 ;; attack
    BEQ +
    CMP #01 ;; are we already walking?
    BEQ +
    CMP #$04 ;; climb
    BEQ +
    ChangeObjectState #$01, #$4
 +
    RTS
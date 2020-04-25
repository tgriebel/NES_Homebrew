
    LDX player1_object
    LDA gamepad
    AND #%11110000
    BNE +
    GetCurrentActionType player1_object
    CMP #$02 ;; attack
    BEQ +
    CMP #$04 ;; climb
    BEQ +
    ChangeObjectState #$00, #$02
+
    RTS
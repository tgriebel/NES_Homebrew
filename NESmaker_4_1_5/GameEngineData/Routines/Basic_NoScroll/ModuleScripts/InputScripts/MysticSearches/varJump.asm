;; variable jumping.
    
    LDX player1_object

    LDA Object_z_speed_lo,x
    CLC
    ADC #$00
    LDA Object_z_speed_hi,x
    ADC #$00
    BPL skipVarJump
    LDA Object_z_speed_hi,x
    CMP #$01
    BCC skipVarJump
    LDA #$00
    SEC 
    SBC #$01
    STA Object_z_speed_hi,x
skipVarJump:
    RTS
    
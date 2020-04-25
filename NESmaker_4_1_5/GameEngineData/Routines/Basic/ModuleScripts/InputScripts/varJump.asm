;; Variable jumping code is best used on the jump-button release input.
;; It cuts the value of vertical speed when the jump button is released, if the object
;; is moving vertically.

    LDX player1_object
    LDA screenFlags
	;; Ignore if it does not use gravity.
    AND #%00100000
    BEQ skipVarJump
	;; Here, it uses gravity.
	;; Check to see if it is moving upwards.
    LDA Object_v_speed_lo,x
    CLC
    ADC #$00
    LDA Object_v_speed_hi,x
    ADC #$00
    BPL skipVarJump
    LDA Object_v_speed_hi,x
    CMP #$01 ;A: what is the "change speed" when you let go.
    BCC skipVarJump
	;;; here, it was determined to be moving upwards
    LDA #$00
    SEC 
    SBC #$01 ;B: This number should be the same as A.
    STA Object_v_speed_hi,x
skipVarJump:
    RTS
    
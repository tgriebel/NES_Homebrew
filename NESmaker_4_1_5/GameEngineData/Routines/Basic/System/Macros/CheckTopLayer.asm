MACRO CheckTopLayer

    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    STA tileY
	
    JSR GetTileAtPosition
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
    STA collisionPoint0
	CMP #COL_TOP_LAYER
	BEQ +
	
	LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX

    LDA yHold_hi
    STA tileY
	
    JSR GetTileAtPosition
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
    STA collisionPoint1
	CMP #COL_TOP_LAYER
	BEQ +
	JMP ++
+ ;; there was a top layer detected at the top points of the object.
	LDA Object_state_flags,x
	ORA #%00100000
	STA Object_state_flags,x
++	


	
	ENDM
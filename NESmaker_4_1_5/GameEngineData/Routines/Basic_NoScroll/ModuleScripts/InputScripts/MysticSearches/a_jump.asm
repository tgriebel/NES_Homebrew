	LDX player1_object
	LDA Object_physics_byte,x
	AND #%00000001 ;; one will result in being in the air.
	BEQ + ;; can jump
	;; can not jump
	JMP ++
	
+ ;; can jump

	LDA Object_physics_byte,x
	ORA #%00000001
	STA Object_physics_byte,x
	LDA #$00
    SEC
    SBC #JUMP_SPEED_LO
    STA Object_z_speed_lo,x
    LDA #$00
    SEC
    SBC #JUMP_SPEED_HI
    STA Object_z_speed_hi,x

++

	RTS
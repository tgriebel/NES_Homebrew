
	TXA
	STA tempx
	LDX player1_object
	ChangeObjectState #$02, #$08
	LDA #$00
	STA Object_animation_frame,x
	LDX tempx
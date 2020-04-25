
	TXA
	STA tempx
	TYA 
	STA tempy
	
	;;;;;;;;;;;;;;;;;;;
	LDX player1_object
	LDA Object_x_hi,x
	STA temp
	LDA Object_y_hi,x
	STA temp1
	CreateObject temp, temp1, #$08, #$00
	;; need to do this redundantly, otherwise, the death object will be in same slot as player
	LDX player1_object
	DeactivateCurrentObject
	;;;;;;;;;;;;;;;;;;;
	StopSound
	;PlaySound #$00, #$00
	LDA #$FF
	STA player1_object
	
	LDX tempx
	LDY tempy

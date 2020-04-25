
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

	DeactivateCurrentObject
	
	CreateObject temp, temp1, #OBJ_PLAYER_DEATH, #$00, currentNametable
	;;;;;;;;;;;;;;;;;;;
	StopSound
	;PlaySound #$00, #$00
	LDA #$FF
	STA player1_object
	
	LDX tempx
	LDY tempy

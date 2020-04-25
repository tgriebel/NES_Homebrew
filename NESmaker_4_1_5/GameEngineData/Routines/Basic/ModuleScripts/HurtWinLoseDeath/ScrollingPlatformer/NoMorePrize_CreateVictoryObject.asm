
	TXA
	STA tempx
	LDX player1_object
	LDA Object_x_hi,x
	STA temp
	LDA Object_y_hi,x
	STA temp1
	CreateObject temp, temp1, #OBJ_PLAYER_VICTORY, #$00, currentNametable
	LDX player1_object
	DeactivateCurrentObject
	LDA #$01
	STA loadObjectFlag
	StopSound
	LDA #$ff
	
	PlaySound #SND_VICTORY
	LDX tempx
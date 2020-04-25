;;blank	
	LDA navFlag
	ORA #%00000001
	STA navFlag
	LDA #NAV_4
	STA navToScreen
	LDA #$04
	STA newGameState
	
		LDA npc_collision
	ORA #%00000010
	STA npc_collision
	
	LDA #$03
	STA textVar
	
	LDA #OBJ_PLAYER_4
	STA playerToSpawn
	

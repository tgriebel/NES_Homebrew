;;blank	
		LDA navFlag
	ORA #%00000001
	STA navFlag
	LDA #NAV_3
	STA navToScreen
	LDA #$03
	STA newGameState
	
		LDA npc_collision
	ORA #%00000010
	STA npc_collision
	
	LDA #$02
	STA textVar
	
	LDA #OBJ_PLAYER_3
	STA playerToSpawn
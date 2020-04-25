;;blank	
	LDA navFlag
	ORA #%00000001
	STA navFlag
	LDA #NAV_2
	STA navToScreen
	LDA #$02
	STA newGameState
	
	LDA npc_collision
	ORA #%00000010
	STA npc_collision
	
	LDA #$01
	STA textVar
	
	LDA #OBJ_PLAYER_2
	STA playerToSpawn
;;blank	
	CPX player1_object
	BNE +
	LDA navFlag
	ORA #%00000001
	STA navFlag
	LDA #NAV_1
	STA navToScreen
	LDA #$01
	STA newGameState

	LDA npc_collision
	ORA #%00000010
	STA npc_collision
	
	LDA #$00
	STA textVar
	
	LDA #OBJ_PLAYER_1
	STA playerToSpawn
	
+:
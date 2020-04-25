;;; NPC TILE
	; LDA gamepad
	; AND #%00000010
	; BEQ +
	; LDA textBoxFlag
	; BNE +
	; LDA #$00
	; STA stringTemp
	; LDA #$01
	; STA textBoxFlag

	CPX player1_object
	BNE +
	LDA npc_collision
	ORA #%00000010
	STA npc_collision
	
+:
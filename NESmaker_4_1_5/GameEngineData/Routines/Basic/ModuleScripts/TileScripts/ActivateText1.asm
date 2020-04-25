	; CPX player1_object
	; BNE +
	; LDA npc_collision
	; ORA #%00000010
	; STA npc_collision
; +
;; go to win screen / state	
	LDA #STATE_WIN_GAME
	STA change_state
	LDA #$01
	STA newScreen
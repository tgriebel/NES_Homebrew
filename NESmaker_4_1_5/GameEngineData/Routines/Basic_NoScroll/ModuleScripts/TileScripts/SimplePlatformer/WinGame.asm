;;;; If you touch this tile it will
;;;; jump to the win game screen.
cpx player1_object
BNE dontWintGame_tile
	LDA #STATE_WIN_GAME
	STA change_state
	LDA #$01
	STA newScreen
	
dontWintGame_tile
	
;; Lose invincibility
	TXA
	STA tempx
	PlaySound #SND_POWERDOWN
	LDX player1_object
	ChangeObjectState #$00, #$04 ; change to normal state
	;;; set all monsters to scared state.

	
	LDX tempx
	
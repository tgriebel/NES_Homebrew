;;; Increase Score
;;; works with variable myScore
;;; works with HUD variable HUD_myScore.
	TXA
	STA tempx

	
	AddValue #$08, myScore, #$05, #$00
	
	

	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.
	;STA hudElementTilesToLoad
	;	LDA #$00
	;	STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myScore
		; STA DrawHudBytes
	UpdateHud HUD_myScore
	PlaySound #SND_POWERUP

	LDX player1_object
	ChangeObjectState #$03, #$04 ; change to invincible state
	
	LDA #TIMER_attack_lo
	STA playerTimer_lo
	LDA #TIMER_attack_hi
	STA playerTimer_hi
	LDA playerTimer_state
	ORA #%00000001
	STA playerTimer_state


	LDX tempx

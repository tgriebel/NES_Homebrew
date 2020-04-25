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
	ChangeObjectState #$02, #$04 ; change to invincible state

	;;; set all monsters to scared state.
	LDX #$00
doMonsterScaredloop:
	LDA Object_status,x
	AND #%10000000
	BEQ + ;; not active
	LDA Object_flags,x
	AND #%00001000
	BEQ + ;; not a monster
	;;; is an active monster
	ChangeObjectState #$01, #$04 ;; change to the scared state.
+ ;; skip this monster.
	INX
	CPX #TOTAL_MAX_OBJECTS
	BEQ doneMonsterScaredLoop
	JMP doMonsterScaredloop
doneMonsterScaredLoop:

	LDX tempx

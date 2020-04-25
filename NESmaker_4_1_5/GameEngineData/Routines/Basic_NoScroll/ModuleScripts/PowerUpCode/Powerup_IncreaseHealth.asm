;;; Increase Health code for player.
;;; works with variable myHealth
;;; works with HUD variable HUD_myHealth.
	LDA myHealth
	CLC
	ADC #$01
	CMP #$04
	BCS skipGettingHealth
	
	TXA
	STA tempx
	;;;you may want to test against a MAX HEALTH.
	;;; this could be a static number in which case you could just check against that number
	;;; or it could be a variable you set up which may change as you go through the game.
	inc myHealth
	LDA myHealth
	
	LDX player1_object
	STA Object_health,x

	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.
	STA hudElementTilesToLoad
		LDA #$00
		STA hudElementTilesMax
		; LDA DrawHudBytes
		; ORA #HUD_myHealth
		; STA DrawHudBytes
	UpdateHud HUD_myHealth
	LDX tempx
	
skipGettingHealth:
	PlaySound #SFX_INCREASE_HEALTH
;;; what variables do you want to draw in hud at screen load?

	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.

	
	;LDA #$00
	;ORA HUD_updateHealth	
	;ORA HUD_updateAmmo
	;ORA HUD_updateMoney
	;ORA HUD_updateMisc
	
	;ORA HUD_updateLives			
	;ORA HUD_updateScore	
	;LDA #$00
	;STA DrawHudBytes
	
	
MACRO UpdateHud arg0
	;arg0 = the hud variable to update.
	LDA #HIDE_HUD
	BNE +
	;; this sets up the hud to update on the next frame.
	;STA hudElementTilesToLoad
	LDA HudChecker
	AND #arg0
	BEQ +
	
	LDA #$00
	STA hudElementTilesMax
	LDA DrawHudBytes
	ora #arg0
	STA DrawHudBytes
	
	
+
	ENDM
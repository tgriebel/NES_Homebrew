;;; increase variable for testing hud
    
   LDX #$00
    LDA Object_health,x
    sec
    sbc #$01
    STA Object_health,x
    STA myHealth

    STA hudElementTilesToLoad
    LDA #$00
    STA hudElementTilesMax
    ; LDA DrawHudBytes
    ; ora #HUD_myHealth
    ; STA DrawHudBytes
	UpdateHud HUD_myHealth
    RTS
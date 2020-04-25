;;; increase variable for testing hud
    
    ;LDX #$00
    ;LDA Object_health,x
    ;sec
    ;sbc #$01
    ;STA Object_health,x
    ;STA myHealth

    ;STA hudElementTilesToLoad
    ;LDA #$00
    ;STA hudElementTilesMax
    ;LDA DrawHudBytes
    ;ora #HUD_myHealth
    ;STA DrawHudBytes

   
 
 
    TXA
    STA tempx
    
    AddValue #$02, myScore, #$01, #$00
    
    

    ;;; we also need to set up the routine to update the HUD
    ;; for this to work right, health must be a "blank-then-draw" type element.
    ;STA hudElementTilesToLoad
    ;   LDA #$00
    ;   STA hudElementTilesMax
        ; LDA DrawHudBytes
        ; ora #HUD_myScore
        ; STA DrawHudBytes
    UpdateHud HUD_myScore
    LDX tempx
    RTS
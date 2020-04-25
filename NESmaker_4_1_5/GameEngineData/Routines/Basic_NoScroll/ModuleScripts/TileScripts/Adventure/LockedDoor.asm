	CPX player1_object
	BEQ +
	JMP ++
+
	LDA myKeys
	BNE + ;; if you have no more keys.
	JMP ++
+	
	LDA tileCollisionFlag
	BEQ +
	JMP ++
+
	;;; if you DO have more keys
	LDA #$01
	STA tileCollisionFlag
	ChangeTileAtCollision #$00, #TILE_OPENDOOR

	TXA
	STA tempx	
	SubtractValue #$02, myKeys, #$01, #$00
	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.
	;STA hudElementTilesToLoad
	;	LDA #$00
	;	STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myKeys
		; STA DrawHudBytes
	UpdateHud HUD_myKeys
	PlaySound #SND_UNLOCK
	LDA #$00
	STA value
	STA value+1
	STA value+2
	STA value+3
	STA value+4
	STA value+5
	STA value+6
	STA value+7
	LDX tempx
	TriggerScreen screenType
	
	JMP +++ ;; it is no longer solid.
	
++
	LDA #TILE_SOLID
	STA tile_solidity
+++
	
	;; if you want it solid, declare it at the end

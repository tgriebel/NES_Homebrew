;; COLLECTABLE - this tile requires 
;; HUD to be active and for myScore variable to be drawn.
;; To use this without this feature, comment out lines marked below.
	CPX player1_object
	BEQ isPlayerForCollectableKeys
	JMP ++
isPlayerForCollectableKeys:
	LDA tileCollisionFlag
	BEQ +
	JMP ++
+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TO USE WITHOUT HUD, COMMENT OUT THIS BLOCK
;;; It may result in anomalies if two tiles
;;; register collision simultaneously without
;;; this block.
	LDA #$01
	STA tileCollisionFlag
	ChangeTileAtCollision #$00, #$00
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TXA
	STA tempx	
	AddValue #$02, myKeys, #$01, #$00
	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.
	;STA hudElementTilesToLoad
	;	LDA #$00
	;	STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myKeys
		; STA DrawHudBytes
		
	UpdateHud HUD_myKeys
	
	LDX tempx
	PlaySound #SND_GET
	LDA #$00
	STA value
	STA value+1
	STA value+2
	STA value+3
	STA value+4
	STA value+5
	STA value+6
	STA value+7
	
	TriggerScreen screenType
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


++


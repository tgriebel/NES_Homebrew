;;blank
	CPX player1_object
	BEQ isPlayerForCollectable
	JMP ++
isPlayerForCollectable:
	LDA tileCollisionFlag
	BEQ +
	JMP ++
+
	LDA #$01
	STA tileCollisionFlag
	ChangeTileAtCollision #$00, #$00
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TXA
	STA tempx	
	AddValue #$08, myScore, #$01, #$00
	;;; we also need to set up the routine to update the HUD
	;; for this to work right, health must be a "blank-then-draw" type element.
	;STA hudElementTilesToLoad
	;	LDA #$00
	;	STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myScore
		; STA DrawHudBytes
	UpdateHud HUD_myScore
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
	
	LDX tempx
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC screenPrizeCounter
	BNE ++
	
	;;; do whatever should happen if you collect all of the prizes on this screen.
	JSR HandleNoMorePrizeTiles

++


;; COLLECTABLE - this tile requires 
;; HUD to be active and for myScore variable to be drawn.
;; To use this without this feature, comment out lines marked below.
	CPX player1_object
	BEQ isPlayerForCollectable
	JMP ++
isPlayerForCollectable:
	;LDA tileCollisionFlag
	;BEQ +
	;JMP ++
+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TO USE WITHOUT HUD, COMMENT OUT THIS BLOCK
;;; It may result in anomalies if two tiles
;;; register collision simultaneously without
;;; this block.
	;;LDA #$01
	;STA tileCollisionFlag
	ChangeTileAtCollision #$00, #$00
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TXA
	STA tempx	
	AddValue #$08, myScore, #$01, #$00
	;;; we also need to set up the routine to update the HUD
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


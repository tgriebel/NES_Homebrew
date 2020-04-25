;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;



	LDA screenType
		;; divide by 32
		LSR
		LSR
		LSR 
		;LSR
		;LSR
		;;; now we have the right *byte* out of the 32 needed for 256 screen bytes
		TAY
		LDA screenTriggers,y ;; now the rigth bit is loaded into the accum
		STA temp
		LDA screenType
		AND #%00000111 ;; look at last bits to know what bit to check, 0-7
		TAX
		LDA ValToBitTable_inverse,x
		AND temp
		BEQ thisScreenIsNotTriggered_onScreenLoad
		;; this screen IS triggered
DoDestroyAllTriggerTiles:	
	
	LDY #$00 ;; or, first room collision tile
FindLockedDoorTilesTarget_onScreenLoad:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; FIND TRIGGER TYPE HERE
	LDA collisionTable,y
	CMP #COL_LOCK ;; compare to locked door target type
			;; if your trigger type is NOT #$06
			;; then change this to the tile type
			;; of your trigger
	BNE notALockedDoorTarget_onScreenLoad
	LDA #$00
	STA collisionTable,y ;; collision table is changed.
						;; graphics are a little trickier

	ChangeTile #$00, #TILE_OPENDOOR

notALockedDoorTarget_onScreenLoad:
	INY
	CPY #$F0 ;; or last room collision tile - offset for hud?
	BNE FindLockedDoorTilesTarget_onScreenLoad
	
	;;;;;===================
stillTargetsOnScreen_onScreenload:
;;;;  end what to do if no more objects	
thisScreenIsNotTriggered_onScreenLoad:
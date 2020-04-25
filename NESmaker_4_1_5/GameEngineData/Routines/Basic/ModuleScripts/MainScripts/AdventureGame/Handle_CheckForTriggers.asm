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
		BNE +
		JMP thisScreenIsNotTriggered_onScreenLoad
	+
		;; this screen IS triggered
DoDestroyAllTriggerTiles:	
	;;; HERE:
	;;; all of the tiles you would like to change when this screen is loaded.
	;;; do this routine for:
	;;; FIRST, GET RID OF LOCKS:
	LDA showingNametable
	STA temp
	ChangeAllTilesDirect #COL_LOCK, #$00, #TILE_OPENDOOR, temp
	;;; NOW, GET RID OF KEY TILES:
	LDA showingNametable
	STA temp
	ChangeAllTilesDirect #COL_KEY, #$00, #$00, temp ;; arg2 = floor, null, etc
	;ChangeAllTiles #COL_KEY, #$00, #$00, temp
	

thisScreenIsNotTriggered_onScreenLoad:
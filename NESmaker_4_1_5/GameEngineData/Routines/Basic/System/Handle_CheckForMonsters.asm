;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;
	;; monster bit is: #%00001000 
;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;To change collision type and graphic
	CountObjects #%00001000, #$00 ;; count monsters.
	LDA monsterCounter
	BEQ doNoMoreMonsterCode
	JMP stillMonstersOnScreen_onScreenload
doNoMoreMonsterCode
	;;; all of the tiles you would like to change when this screen is loaded.
	;;; do this routine for:
	;;; FIRST, GET RID OF LOCKS:
	LDA update_screen
	BEQ doScreenOnMonsterCheck
	LDA showingNametable
	STA temp
	ChangeAllTilesDirect #COL_MONSTER_LOCK, #$00, #TILE_OPENDOOR, temp
	JMP stillMonstersOnScreen_onScreenload
doScreenOnMonsterCheck:
	

	;;;;;===================
stillMonstersOnScreen_onScreenload:
;;;;  end what to do if no more objects
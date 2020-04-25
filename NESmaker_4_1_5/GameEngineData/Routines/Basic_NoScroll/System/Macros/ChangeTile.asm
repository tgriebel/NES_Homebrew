MACRO ChangeTile arg0, arg1
	;; this tile uses arg0 to figure an arbitrary place on a the collision table
	;; and then translates it to nametable space.  Arg 1 is the tile starting value
	;; loaded to the PPU.  It uses this to draw a metatile.
	
	;; arg0 - new collion type
	;; arg1 - starting tile number of new metatile
	;LDA xScroll_hi
	;AND #%00000001

	;; even nametable
	LDA arg0
	STA collisionTable,y

	JSR ConvertCollisionToNT
	LDA arg1
	STA updateTile_00
	LDA arg1
	CLC
	ADC #$01
	STA updateTile_01
	LDA arg1
	CLC
	ADC #$10
	STA updateTile_02
	LDA arg1
	CLC
	ADC #$11
	STA updateTile_03
	JSR HandleUpdateNametable
	ENDM
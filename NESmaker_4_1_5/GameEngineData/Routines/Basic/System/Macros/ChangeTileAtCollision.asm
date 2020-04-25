MACRO ChangeTileAtCollision arg0, arg1
	;; this changes a tile at the current point of collision.
	;; collision is determined by what is currently loaded into the
	;; tileX and tileY variables. 
	
	;; arg0 - new collision type
	;; arg1 - starting tile number of new metatile.
	LDA #$01
	STA tileCollisionFlag

	
	JSR GetTileAtPosition
;	TAY
	;LDA arg0
	;STA temp
	LDA Object_scroll,x
	AND #%00000001
	BNE +
	LDA arg0
	STA collisionTable,y
	JMP ++
	
+
	LDA arg0
	STA collisionTable2,y

++
	
	;;;;; this will change the graphics
	JSR ConvertCollisionToNT
	;l0dA #$20
	;STA temp16
	;LDA Object_x_hi,x
	;AND #%11110000
	;CLC
	;ADC #$f0
	;STA temp16+1
	LDA temp16
	STA tempTileUpdate_lo
	LDA temp16+1
	STA tempTileUpdate_hi
	

	LDA arg1
	STA updateTile_00
	STA tempChangeTiles
	LDA arg1
	CLC
	ADC #$01
	STA updateTile_01
	STA tempChangeTiles+1
	LDA arg1
	CLC
	ADC #$10
	STA updateTile_02
	STA tempChangeTiles+2
	LDA arg1
	CLC
	ADC #$11
	STA updateTile_03
	STA tempChangeTiles+3

	;;TXA
	;PHA
	;JSR HandleUpdateNametable
	;PLA 
	;TAX
	LDA #$01
	STA testFlagThing
	
	ENDM
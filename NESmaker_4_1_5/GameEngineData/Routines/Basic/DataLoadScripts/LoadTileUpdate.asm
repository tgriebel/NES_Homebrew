

	;LDA updateNametable
	;BEQ dontUpdateNT_toPPU
	
	;LDA updateTileTotal
	;BEQ dontUpdateNT_toPPU
	bIT $2002
	;LDA UpdateAtt
	;BNE dontUpdateNT_toPPU
	
	LDX #$00
LoadAllCuedTiles:
	LDY #$00
doUpdateNT_toPPU_loop:
;;;;;;;;;DO A LOOP HERE THORUGH ALL 4 possibilities.
	LDA updateNT_fire_Address_Hi,x
	STA $2006
	LDA updateNT_fire_Address_Lo,x
	STA $2006
	LDA updateNT_fire_Tile,x
	STA $2007
	INX
	INY
	CPY #$04
	BNE doUpdateNT_toPPU_loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DEC tilesToWrite
	LDA tilesToWrite
	BEQ doneWithCuedTiles
	

	CPX #$10
	BNE LoadAllCuedTiles
	LDA #$00
	STA updateNametable
	JMP noUpdatesToScreen
	
	
doneWithCuedTiles:
	
	;LDA #$01
	;STA loadMonsterColumnFlag
	
	;STA loadingTilesFlag
	
	LDA #$00 
	STA OverwriteNT_column ;; turns off, and sets this back to 0
	STA OverwriteNT_row
	STA OverwriteNT
	STA updateNametable
	STA loadingTilesFlag

;	LDA gameHandler
	;AND #%00010000
	;BEQ +
	LDA gameHandler
	AND #%11101111
	STA gameHandler
	LDA #$01
	STA UpdateAtt

dontUpdateNT_toPPU:



noUpdatesToScreen:
	;JMP skipNMIupdate
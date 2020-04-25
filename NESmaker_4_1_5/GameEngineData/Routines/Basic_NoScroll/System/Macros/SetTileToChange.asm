MACRO SetTileToChange arg0, arg1, arg2
	;; arg0 - hi address of change
	;; arg1 - low addres of change
	;; arg2 - change to this tile.
	
	;; ** EXPECTS X TO BE SET PRIOR TO CALLING THIS MACRO.
	;; most times, this will be part of a loop.
	
	LDA arg0
	STA updateNT_fire_Address_Hi,x
	LDA arg1
	STA updateNT_fire_Address_Lo,x
	LDA arg2
	STA updateNT_fire_Tile,x
	
	INX
	;INC tilesToWrite
	
	ENDM
LoadChrRam:

	

	LDA currentBank
	STA prevBank	
	LDY tempBank
	JSR bankswitchY
	;; a feeds what 'row' the pattern table will load to
	;; y feeds what 'column'.  it must end in zero (be a multiple of 16)
	;; x feeds which value in the table to load.
	
	;;; wait until rendering is turned off
	;LDA #$00
	;STA soft2001
;	JSR WaitFrame
	
	
	bit $2002
	LDA temp
	LDX temp2
	LDY temp3
	
	
	STA $2006
	STY $2006
	
	
LoadRow:
	LDA #$10
	STA TileCounter
	LDY #$00
LoadTilesLoop:
	LDX #$10
LoadChrRamLoop:
	LDA (temp16),y
	STA $2007
	INY
	DEX
	BNE LoadChrRamLoop
	DEC TileCounter
	BNE keepLoading
	DEC TilesToLoad
	BEQ doneLoadingChrRam
	INC temp16+1
	JMP LoadRow
keepLoading:
	DEC TilesToLoad
	BNE LoadTilesLoop
doneLoadingChrRam:	

	LDY prevBank
	JSR bankswitchY
;
;	LDA #%00011110
;	STA soft2001
	
	RTS
	

	
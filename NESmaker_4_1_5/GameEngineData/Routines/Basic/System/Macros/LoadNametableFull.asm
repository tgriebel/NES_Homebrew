MACRO LoadNametableFull arg0, arg1, arg2, arg3, arg4, arg5
	; arg0 - screen bank
	; arg1 - special screen number
	; arg2 - columns to load
	; arg3 - rows to load
	; arg4 - start position hi
	; arg5 - start position lo
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDY arg1
	
	LDA NameTablePointers,y
	STA temp16
	LDA NameTablePointers+1,y
	STA temp16+1
	
	LDY arg0
	JSR bankswitchY
	
	
	;;;;;;;;;;;;;;Loading8x8NT
	LDA $2002	
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006

;;;;Load nametable loop
	LDX #$04
	LDY #$00
LoadNametableLoop:
	LDA (temp16),y
	STA $2007
	INY
	BNE LoadNametableLoop
	INC temp16+1
	DEX
	BNE LoadNametableLoop
	
	
	;; handle attributes
doneWithNametableLoad:	
	;LDA #%00011110
	;STA soft2001
	LDY prevBank
	JSR bankswitchY
	
	JMP +
	
	
	
	;;;; load the data tables bank
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;; now, load the screen number into y
	LDY arg1
	
	LDA NameTablePointers,y
	STA temp16
	LDA NameTablePointers+1,y
	STA temp16+1

	;; Now we have the nametable index.
	;; time to set up the columns and rows
	LDA arg2
	STA updateNT_columns
	STA updateNT_columnCounter
	
	LDA #$00
	STA updateNT_rowCounter
	LDA arg3
	STA updateNT_rows
	
	;;;; now set up the starting location in the PPU
	LDA arg4 ;; hi byte of starting ppu value, usually going to be #$20
	STA updateNT_pointer+1
	LDA arg5 ;; lo byte of starting ppy value.
	STA updateNT_pointer
	
	;; now change to proper load bank
	;; prev bank still loaded with value before this routine began.
	LDY arg0
	JSR bankswitchY
	
	;;; Now we are ready to load the nametable data.
	JSR LoadNametable
	
+
	ENDM
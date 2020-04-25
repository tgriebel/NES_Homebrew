MACRO LoadNametableMeta arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7
	LDA #$01
	STA skipNMI

	; arg0 - screen bank
	; arg1 - screen map
	; arg2 - screen number
	; arg3 - columns to load
	; arg4 - rows to load
	; arg5 - start position hi
	; arg6 - start position lo
	; arg7 - start column
	

	
	;;;; load the data tables bank
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;; now, load the screen number into y
	LDA arg2
	ASL
	TAY
	LDA arg1 ;; this checks the map number.
	BNE +;; the map is not zero type
	;;;; here the map is the zero type.
	LDA NameTablePointers_Map1,y
	STA temp16
	LDA NameTablePointers_Map1+1,y
	STA temp16+1
	JMP ++
+
	;;;; it was map 2
	LDA NameTablePointers_Map2,y
	STA temp16
	LDA NameTablePointers_Map2+1,y
	STA temp16+1
++
	;; Now we have the nametable index.
	;; time to set up the columns and rows
	LDA arg3
	STA updateNT_columns
	STA updateNT_columnCounter
	
	LDA #$00
	STA updateNT_rowCounter
	LDA arg4
	STA updateNT_rows
	
	;;;; now set up the starting location in the PPU
	LDA arg5 ;; hi byte of starting ppu value, usually going to be #$20
	STA updateNT_pointer+1
	LDA arg6 ;; lo byte of starting ppu value.
	STA updateNT_pointer
	
	;; now change to proper load bank
	;; prev bank still loaded with value before this routine began.
	LDY arg0
	JSR bankswitchY
	LDY arg7 ;; where in the nametable will this begin?

	;;; Now we are ready to load the nametable data.
	JSR LoadMetaTilesWithPaths
	
	;LDY prevBank
	;JSR bankswitchY

	ENDM
	
	
	

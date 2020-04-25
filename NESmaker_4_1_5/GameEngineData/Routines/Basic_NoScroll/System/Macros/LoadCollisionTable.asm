MACRO LoadCollisionTable arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7


	; arg0 - screen bank
	; arg1 - screen map
	; arg2 - screen number
	; arg3 - columns to load
	; arg4 - rows to load
	; arg5 - which collision table
	; arg6 - start position in collision table (smaller, half the column width)
	; arg7 - start column
	

	
	;;;; load the data tables bank
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;; now, load the screen number into y
	LDA arg2

	TAY
	LDA arg1 ;; this checks the map number.
	BNE +;; the map is not zero type
	;;;; here the map is the zero type.
	LDA CollisionTables_Map1_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map1_Hi,y
	STA collisionPointer+1
	JMP ++
+
	;;;; it was map 2
	LDA CollisionTables_Map2_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map2_Hi,y
	STA collisionPointer+1
++
	;; Now we have the nametable index.
	;; time to set up the columns and rows
	LDA arg3
	STA updateCol_columns

	STA updateCol_columnCounter
	
	LDA #$00
	STA updateCol_rowCounter
	LDA arg4
	STA updateCol_rows
	
	;;;; now set up the starting location in the PPU
	;LDA >arg5 ;; hi byte of starting ppu value, usually going to be #$20
	;STA updateNT_pointer+1
	LDA #$00
	STA updateCol_table
	;; if 0, we are updating collisionTable
	;; if 1, we are updating collisionTable2
	
	;; now change to proper load bank
	;; prev bank still loaded with value before this routine began.
	LDY arg0
	JSR bankswitchY
	LDy arg6 ;; where are we pushing to the ram file?
	LDx arg7 ;; where are we pulling from the data file?
	
	;;; Now we are ready to load the nametable data.
	JSR LoadCollisionBytes
	
	
	;JSR HandleScreenLoads
	;LDY prevBank
	;JSR bankswitchY

	ENDM
	
	
	
	
	
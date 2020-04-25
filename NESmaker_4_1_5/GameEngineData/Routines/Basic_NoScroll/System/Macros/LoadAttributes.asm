MACRO LoadAttributes arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7
	; arg0 = bank
	; arg1 = map
	; arg2 = screen number
	; arg3 = columns to load
	; arg4 = rows to load
	; arg5 = start position hi
	; arg6 = start position lo
	; arg7 = start column
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY arg2
	LDA arg1 ;; this checks the map number.
	BNE +;; the map is not zero type
	LDA AttributeTablesMainGameAboveHi,y
	STA temp16+1
	LDA AttributeTablesMainGameAboveLo,y
	STA temp16
	JMP ++
+	
	LDA AttributeTablesMainGameBelowHi,y
	STA temp16+1
	LDA AttributeTablesMainGameBelowLo,y
	STA temp16
++

	LDA arg3
	STA updateNT_attWidth
	LDA arg4
	STA updateNT_rowCounter
	
	LDA arg5
	STA updateNT_pointer+1
	LDA arg6 
	STA updateNT_pointer
	LDY arg0
	JSR bankswitchY
	LDY arg7 ;; start column
	
	JSR LoadAttributesDirect
	
ENDM
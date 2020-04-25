MACRO InitializeColumnWrite
	LDX #$00
 ;; Factor in HUD.
	LDA #BOX_0_HEIGHT
	;;; already in terms of a meta tile.
	;;; there are 16 meta tiles per row.
	;;; but 32 riles.
	ASL
	ASL
	ASL
	ASL
	ASL
	;;; how many extra rows to skip down.
	;;; position requires an extra row, since we 
	;;; are dealing in terms of 
	ASL ;; double that, since here are 2 rows per
		;;; metatile	

	STA temp
	
	LDA OverwriteNT_row
	ASL
	ASL
	ASL
	ASL
	STA temp1
	
	LDA #$01
	STA OverwriteNT_column
	LDX #$00
	LDA columnTracker	
	CLC
	ADC #$18
	AND #%00011111
	
	TAY
	LDA columnTableLo,y
	;;;;;;;;;;;;;;;;;;;;;;;
	CLC
	ADC temp
	CLC
	ADC temp1
	
	STA updateNT_positionToUpdate
	LDA columnTableHi,y
	STA updateNT_positionToUpdate+1

	
	.ENDM
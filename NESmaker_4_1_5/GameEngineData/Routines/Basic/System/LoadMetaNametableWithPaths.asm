
LoadNametable:
	;LDY #$00
	;; y will be loaded in macro
LoadNametableLoop:
	LDA (temp16),y
	STA $2007
	
	;LDA xScroll
	;STA $2005	;reset scroll values to zero
	;LDA yScroll
	;STA $2005	;reset scroll values to zero

	INY
	DEC updateNT_columnCounter
	;; may want to check for rows/columns here for NT restoration
	BEQ doneWithNametableColumn
	JMP LoadNametableLoop
doneWithNametableColumn:
	;; got to the right side of the column.
	;; have to check against rows, but also have to potentially update high address byte.
	INC updateNT_rowCounter
	LDA updateNT_rowCounter
	CMP updateNT_rows
	BEQ noMoreNametable ;;; no more rows, no more columns...this nametable is done.
	LDA updateNT_columns
	STA updateNT_columnCounter
	
	LDA updateNT_pointer
	CLC
	ADC #$20 ;; is this right for main nametables?  Shouldn't this just be #$20?
	STA updateNT_pointer
	LDA updateNT_pointer+1
	ADC #$0 ;; respects the carry.  If there was a carry, it carries here.
	STA updateNT_pointer+1
	JMP LoadNametableLoop
noMoreNametable:
	
	RTS





LoadMetaTilesWithPaths:

	;LDY #$00	
doMetaTileLoop:
	;;; 
	
	LDA updateNT_pointer+1
	STA $2006
	LDA updateNT_pointer
	STA $2006


	LDA (temp16),y
	STA temp
	;;;; now temp is loaded with the prospective tile.

	JSR GetSingleMetaTileValues
	JSR DrawSingleMetatile
doneDrawingThisMetatile:
	INY
	DEC updateNT_columnCounter
	;; may want to check for rows/columns here for NT restoration
	LDA updateNT_columnCounter
	BEQ doneWithMetatableColumn
	
	;; there ARE more metatiles.
	; y is already pointing to the new value.
	; the only thing that needs to be updated is the position to draw,
	;; which shouldbe one more thant updateNT_pointer
	LDA updateNT_pointer
	;; i never restored updateNT_pointer above, so it should be the same as it was previously
	ADC #$02
	STA updateNT_pointer
	;; updateNT_pointer+1 by row
	JMP doMetaTileLoop
doneWithMetatableColumn:
	;;; ok, so now we have to update position and 
	
	
	;;; check rows.
	INC updateNT_rowCounter
	LDA updateNT_rowCounter
	CMP updateNT_rows
	
	BEQ noMoreMetatiles
	LDA updateNT_columns
	STA updateNT_columnCounter
	;JMP noMoreMetatiles
	;; there are still rows left.
moreMetaTiles
	;LDA #$22
	LDA updateNT_columns
	ASL
	STA temp
	LDA updateNT_pointer
	CLC
	ADC #$02
	sec
	sbc temp
	CLC
	ADC #$40
	
	;CLC
	;ADC updateNT_pointer
	;;;
	;LDA updateNT_pointer
	;CLC
	;ADC #$22
	STA updateNT_pointer

	LDA updateNT_pointer+1
	ADC #$0
	STA updateNT_pointer+1
	
	TYA
	SEC
	SBC updateNT_columns
	CLC
	ADC #$10
	TAY

	JMP doMetaTileLoop
noMoreMetatiles:
	
	LDA #$00
	STA skipNMI
	RTS
	
	
	
	
handlePath:
	LDA #$00
	STA TL_path
	STA TR_path
	STA TC_path
	STA CL_path
	STA CR_path
	STA BL_path
	STA BR_path
	STA BC_path
	


	TYA
	STA nt_index_hold ;; nt_index_hold is how we can now restore y if we have to 
				;; corrupt it.
		

	CPY #$10
	BNE notOnFirstPathRow
	;;; is on first path row.
	;; this means that all top paths should read as paths.
	LDA temp
	STA TL_path
	STA TC_path
	STA TR_path
	JMP gotTopPaths
notOnFirstPathRow:
	;; find top left
;	TYA
;	AND #%00001111
;	BNE notOnLeftEdge
	;; it is on left edge
;	so top left is a path (path continues past the screen)
;	LDA temp

;	STA TL_path
;	JMP gotTLpath
notOnLeftEdge:
	TYA 
	SEC
	SBC #$11 ; one row up, one value to the left.
	TAY
	LDA	(temp16),y
	CMP temp
	BNE gotTLpath ;; ignore TL, keep it at zero
					;; because it is not a path
	LDA temp
	STA TL_path
gotTLpath:   ;;; top left path is figured.	

	INY
	LDA (temp16),y ;; this is for top center.
	CMP temp
	BNE gotTCpath ;; ignore TC, keep at zero
	LDA temp
	STA TC_path
gotTCpath:

	INY
	TYA
	AND #%00001111
	BNE notOnRightEdge
	;; it is on right edge
	LDA temp
	STA TR_path
	JMP gotTRpath
notOnRightEdge:
	LDA (temp16),y
	CMP temp
	BNE gotTRpath ;; ignore TR, keep it zero
	LDA temp
	STA TR_path
gotTRpath:
	;;;; ALL top paths have been gotten.
gotTopPaths:

	;;; get center two paths.
	LDY nt_index_hold ;; restore y
	;; first check to see if it's on the left edge
;	TYA 
;	AND #%00001111
;	BNE notOnLeftEdgeC
	;; it is on left edge.
;	LDA temp
;	STA CL_path
;	JMP gotCLpath
notOnLeftEdgeC:
	DEY
	LDA (temp16),y
	CMP temp
	BNE gotCLpath ;; keep cl as zero
	LDA temp
	STA CL_path
gotCLpath:
	LDY nt_index_hold
	INY
	TYA
	AND #%00001111
	BNE notOnRightEdgeC
	LDA temp
	STA CR_path
	JMP gotCRpath
notOnRightEdgeC:

	LDA (temp16),y
	CMP temp
	BNE gotCRpath

	LDA temp
	STA CR_path
gotCRpath:	
	;;;; got center paths.
	;;; now just need bottom paths, then we can 
	;; do basic reads of those variables
	;; to determine which tiles to draw.
	;; first, are we in the bottom row?  The bottom row for this would be
	;; #$0E
	;; skip for now
	LDY nt_index_hold
;	TYA
;	AND #%00001111
;	BNE notOnLeftEdgeB
	;; is on left edge bottom

	;LDA temp
;	STA BL_path
;	JMP gotBLpath
notOnLeftEdgeB:
	TYA
	CLC
	ADC #$0f
	TAY
	LDA (temp16),y
	CMP temp
	BNE gotBLpath ;; skip/ignore, was not path - keep zero
	LDA temp
	STA BL_path
gotBLpath:
	INY
	LDA (temp16),y
	CMP temp
	BNE gotBCpath ;; keep zero
	LDA temp
	STA BC_path
gotBCpath:
	INY
	TYA
	AND #%00001111
	BNE notRightEdgeB
	;; is on right edge
	;LDA temp
	;STA BR_path
	;JMP gotBRpath
notRightEdgeB:
	LDA (temp16),y
	CMP temp
	BNE gotBRpath
	LDA temp
	STA BR_path
gotBRpath:
	LDY nt_index_hold
	LDa nt_index_hold
	
	AND #%00001111
	BNE notOnLeftEdge_safe
	LDA temp
	STA TL_path
	STA CL_path
	STA BL_path
notOnLeftEdge_safe:
	LDA nt_index_hold
	CLC
	ADC #$01
	AND #%00001111
	BNE notOnRightEdge_safe
	LDA temp
	STA TR_path
	STA CR_path
	STA BR_path
notOnRightEdge_safe

	LDA nt_index_hold
	CMP #$e0
	BCC notOnBottomEdge_safe
	LDA temp
	STA BL_path
	STA BC_path
	STA BR_path
notOnBottomEdge_safe:
	LDA nt_index_hold
	CMP #$10
	BCS notOnTopEdge_safe
	LDA temp
	STA TL_path
	STA TC_path
	STA TR_path
notOnTopEdge_safe:
	
	
		;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;; All temp vars are loaded now.
		;;;;;;;;;;;;;;; now we can just go through and populate based on the values.
	;; FIRST lets focus on the TR.  Must check left, top and top left.
	
DoPathTileLoads:
	LDA CL_path
	BNE leftIsAPath
;;===============LEFT IS NOT A PATH============================

	;; left is not a path.
	LDA TC_path
	BNE topCenterIsApath
	;; no left path
	;; no top path
	;; that would make this a top left corner.
	LDA temp
	CLC
	ADC #$01
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topCenterIsApath:
	LDA temp
	clc
	adc #$05
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
	
;;=====================================================

leftIsAPath:
;;===========================================
;; LEFT IS A PATH
	LDA TC_path
	BNE topCenterIsAPath2
	;; left is a path
	;; top is NOT a path
	;; that means this is a *topper*
	LDA temp
	clc
	adc #$02
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topCenterIsAPath2:
	;; top center is a path, left is a path.
	;; if diag is a path, this is full open path
	;; otherwise it is an interior corner
	LDA TL_path
	BNE topLeftIsApath
	;; top left is not a path
	;; so this is an interior corner
	LDA temp
	CLC
	ADC #$0b
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topLeftIsApath:
	;; top left is a path.
	;; so this is a wide open tile
	LDA temp
	STA currentPathTile_TL
	;; last possibility for TL 
topLeftCornerIsDone:
	;;;;; DO TOP RIGHT CORNER.
	LDA CR_path
	BNE topRightIsAPath
	;;;; ==== TOP RIGHT IS NOT A PATH
	LDA TC_path
	BNE topCenterIsAPath3
	;; that would make this a top right corner
	LDA temp
	CLC
	ADC #$04
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topCenterIsAPath3:
	;; so if the right of me is not a path
	;; but the top of me is a path
	;; i need to show the right edge
	LDA temp
	CLC
	ADC #$06
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topRightIsAPath:
	;; right is a path
	;; is above a path?
	LDA TC_path
	BNE topCenterIsAPath4
	;; right is a path.
	;; top center is not a path, which means this is a topper.
	LDA temp
	CLC
	ADC #$03
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topCenterIsAPath4:
	;; right is a path, top center is a path.
	;; check if diag is a path
	LDA TR_path
	BNE topRightIsAPath2
	;; that means this is an interior corner
	LDA temp
	CLC
	ADC #$0d
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topRightIsAPath2:
	;; right is a path, top is a path, diag is a path
	;; full path tile
	LDA temp
	CLC
	ADC #$0F ;; this gives the staggered default tile to top right and bottom left.
	STA currentPathTile_TR
	;; last top right possibility
topRightCornerIsDone:
	;;;;; do bottom left
	LDA CL_path
	BNE leftIsAPath2
	;; left is NOT a path
	;; check bottom
	LDA BC_path
	BNE bottomCenterIsPath
	;; left is not a path
	;; bottom is not a path
	;; that means this is a bottom corner.
	LDA temp
	CLC 
	ADC #$07
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomCenterIsPath:
	;; left is not a path, but bottom is
	;; that means this is an edger
	LDA temp
	CLC
	ADC #$05
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
leftIsAPath2:
	;; if the left IS a path
	;; check bottom
	LDA BC_path
	BNE bottomCenterIsPath2
	;; left is a bath, but bottom is not
	;; this is an bottom edger
	LDA temp
	CLC
	ADC #$08
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomCenterIsPath2
	;; left is a path, bottom is a path
	LDA BL_path
	BNE bottomLeftIsPath
	;; interor
	LDA temp
	CLC
	ADC #$0c
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomLeftIsPath:
	LDA temp
	CLC
	ADC #$0F ;; this gives the staggered default tile to top right and bottom left.
	STA currentPathTile_BL
	;;last possibility
bottomLeftCornerIsDone:
	;;; bottom right corner
	LDA CR_path
	BNE rightIsPath
	;; right is not a path
	LDA BC_path
	BNE bottomCenterIsPath3
	;; no path beneath, no path to the right
	;; this is a bottom right corner.
	LDA temp
	CLC
	ADC #$0a
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomCenterIsPath3:
	;; right is not path
	;; butt below me is
	;; this is a right edger.
	LDA temp
	CLC
	ADC #$06
	STA currentPathTile_BR
	JMP bottomRightIsDone
rightIsPath:
	;; right is path.
	LDA BC_path
	BNE bottomCenterIsPath4
	;;; right is path, but bottom is not.
	;; this is a bottom edger
	LDA temp
	CLC
	ADC #$09
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomCenterIsPath4:
	;; right is path, center is path.
	LDA BR_path
	BNE bottomRightIsPath
	;; right,bottom center are paths, but bottom right is not path.
	;; this is an interior corner
	LDA temp
	CLC
	ADC #$0e
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomRightIsPath
	LDA temp
	STA currentPathTile_BR
	;; last possibility.
bottomRightIsDone:
;;=================================================	
GetPathsDone:
	LDA currentPathTile_TL ;; top left of curent tile / path tile	
	STA updateTile_00
			;; top right of current tile.
			
	LDA currentPathTile_TR
	STA updateTile_01

	LDA currentPathTile_BL
	STA updateTile_02
	LDA currentPathTile_BR
	STA updateTile_03

	RTS
	
	
	
	
	
	
	
	
	
GetSingleMetaTileValues:
	STA temp
	CMP #BLANK_TILE
	BEQ isBlankTile
;;; what other objects should draw a blank tile / special cases?
;;; close / open doors?  Ice versus water?  day / night / saved / unsaved?
;;; Handle triggered here:
	GetTrigger
	BEQ noTriggerState
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;; ALL POSSIBLE "CHANGE TILES", make the caveat here:
	.include SCR_TRIGGERED_TILE_LOADS

noTriggerState:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE other triggered tile types.
	JMP notBlankTile
isBlankTile:
	
	;;; it was a blank tile.  They are all now blank tiles
	STA updateTile_00
	STA updateTile_01
	STA updateTile_02
	STA updateTile_03
	RTS
notBlankTile:
	LDA temp

	CMP #$80
	BEQ doPathUpdate 
	CMP #$90
	BEQ doPathUpdate
	CMP #$A0
	BEQ doPathUpdate
	CMP #$B0
	BEQ doPathUpdate
	JMP notPath
doPathUpdate:
	;; now we have to do evaluations of other tiles around us to know
	;; exactly what to draw here.
	;STA temp3 ;; arbitrary variable - use for comparison to see
				;; if tiles adjacent are same path type
	JSR handlePath
	RTS
notPath:
	
	STA updateTile_00
	INC temp
	LDA temp
	STA updateTile_01
	;;; now, what we need is a row down from our current position...updateNT_pointer
	;;; and temp, increased to its next row.
	CLC
	ADC #$0f
	STA temp
	STA updateTile_02
	INC temp
	LDA temp
	STA updateTile_03
	RTS
	
	
	
DrawSingleMetatile:
	LDA updateNT_pointer+1
	STA $2006
	LDA updateNT_pointer
	STA $2006


	LDA updateTile_00
	STA $2007  ;write 1
	LDA updateTile_01
	STA $2007 ;; write 2
	
	;	LDA xScroll
	;STA $2005	;reset scroll values to zero
	;LDA yScroll
	;STA $2005	;reset scroll values to zero

	;;; now, what we need is a row down from our current position...updateNT_pointer
	;;; and temp, increased to its next row.
	LDA updateNT_pointer+1
	STA $2006
	
	
	LDA updateNT_pointer
	CLC
	ADC #$20 ;; dont store it into updateNT_pointer
			;; because then it will be easy to just add 2 to
			;; for the next place to write.
	STA $2006


	;; now get the tile
	LDA updateTile_02
	STA $2007
	LDA updateTile_03
	STA $2007
	
	;LDA xScroll
	;STA $2005	;reset scroll values to zero
	;LDA yScroll
	;STA $2005	;reset scroll values to zero

	
	RTS
	
HandleUpdateNametable:

	LDX #$00
loadValuesIntoTileToUpdate:

;;;;;;;;;;;;;;;
;;;;;; TILE ONE

	;LDA updateNT_positionToUpdate+1 ;; high
	LDA temp16
	STA updateNT_fire_Address_Hi,x
	;LDA updateNT_positionToUpdate ;; low
									;; needs to be backwards this way
									;; so that we can increase low, use the carry
									;; to increase the high byte when it crosses the page.
	LDA temp16+1
	STA updateNT_fire_Address_Lo,x
	LDA updateTile_00
	STA updateNT_fire_Tile,x

	INX
	
;;;;;;;;;;;;;;;;;;;
;;;;; TILE TWO
	
	LDA temp16+1
	CLC
	ADC #$01
	STA temp16+1
	
	LDA temp16
	STA updateNT_fire_Address_Hi,x
	;LDA updateNT_positionToUpdate ;; low
									;; needs to be backwards this way
									;; so that we can increase low, use the carry
									;; to increase the high byte when it crosses the page.
	LDA temp16+1
	STA updateNT_fire_Address_Lo,x
	LDA updateTile_01
	STA updateNT_fire_Tile,x
	
	
	
	INX
	
;;;;;;;;;;;;;;;;;;
;;;; TILE THREE	
	
	LDA temp16+1
	CLC
	ADC #$1F
	STA temp16+1
	LDA temp16
	ADC #$00
	STA temp16
	
	LDA temp16
	STA updateNT_fire_Address_Hi,x
	;LDA updateNT_positionToUpdate ;; low
									;; needs to be backwards this way
									;; so that we can increase low, use the carry
									;; to increase the high byte when it crosses the page.
	LDA temp16+1
	STA updateNT_fire_Address_Lo,x
	LDA updateTile_02
	STA updateNT_fire_Tile,x
	
	INX

;;;;;;;;;;;;;;;; 
;;;;;; TILE FOUR
	LDA temp16+1
	CLC
	ADC #$01
	STA temp16+1
	
	LDA temp16
	STA updateNT_fire_Address_Hi,x
	;LDA updateNT_positionToUpdate ;; low
									;; needs to be backwards this way
									;; so that we can increase low, use the carry
									;; to increase the high byte when it crosses the page.
	LDA temp16+1
	STA updateNT_fire_Address_Lo,x
	LDA updateTile_03
	STA updateNT_fire_Tile,x 
	
DoneWithTilesUpdates:	
	LDA #$01
	STA tilesToWrite
	LDA #$01
	STA updateNametable
	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
BlackoutBoxArea:

	LDA #BLANK_TILE
	STA updateTile_00
	STA updateTile_01
	STA updateTile_02
	STA updateTile_03
	TXA
	STA tempx
	TYA
	STA tempy
;;;;;;;;;;;;;;;;;
	LDA #$00
	STA updateNT_columnCounter
	STA updateNT_rowCounter
	;LDA #BOX_0_WIDTH 
	;STA updateNT_columns
	;LDA #BOX_0_HEIGHT
	;STA updateNT_rows
	;LDA #BOX_0_ORIGIN_X
	;STA tileX
	;LDA #BOX_0_ORIGIN_Y
	;STA tileY 
	;JSR coordinatesToMetaNametableValue
	;; now, updateNT_pos (16 bit) has the starting position for the box.
	
DoBlackoutLoopColumn:
	LDA updateNT_pos+1
	STA temp16
	LDA updateNT_pos
	STA temp16+1
	JSR HandleUpdateNametable	
	
	JSR WaitFrame
	
	INC updateNT_pos
	INC updateNT_pos
	
	INC updateNT_columnCounter
	LDA updateNT_columnCounter
	CMP updateNT_columns
	BNE DoBlackoutLoopColumn
	;; now we need to add a row.
	LDA updateNT_columns
	ASL 
	STA temp
	
	
	LDA updateNT_pos
	SEC
	SBC temp ;; gets us back to the left of the row.
	CLC
	ADC #$40 ;; jumps down two rows
	STA updateNT_pos
	LDA updateNT_pos+1 ;; while handling 16 bit math for high byte
	ADC #$00
	STA updateNT_pos+1
	LDA #$00
	STA updateNT_columnCounter
	INC updateNT_rowCounter
	LDA updateNT_rowCounter
	CMP updateNT_rows
	BNE DoBlackoutLoopColumn
	
	LDY tempy
	LDX tempx
	RTS

	
	
	
	
	
RestoreBoxArea:
	TYA
	STA tempy

	LDA #$00
	STA updateNT_offset	
	;;; THIS IS THE PART THAT NEEDS TO CHANGE...HOW DO WE GET THE *TILE TO LOAD*
	;;;;; This is the very complicated part, where we have to navigate to the bank,
	;;;;; get the label, navigate to the screen bank, get the offset, read the value,
	;;;;; and extract all four tiles, through the LoadMetaNametableWithPaths function,
	;;;;; and then put those tiles into updateTile byte variables.
	;;;;;;;;; PRESUMES IS IN MAP 1
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDA newScreen

	ASL
	TAY
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
	;;;;; UPDATE THIS TO FIND THE RIGHT MAP
	LDA NameTablePointers_Map1,y
	STA updateNT_ntPointer	
	LDA NameTablePointers_Map1+1,y
	STA updateNT_ntPointer+1
	JMP ++
+	
	LDA NameTablePointers_Map2,y
	STA updateNT_ntPointer	
	LDA NameTablePointers_Map2+1,y
	STA updateNT_ntPointer+1
++
	;;;; now we have the correct label
	LDY screenBank
	jsr bankswitchY
	;;;;; now we're in the right screen bank.  

	LDA #$00
	STA updateNT_columnCounter
	STA updateNT_rowCounter
	;LDA #BOX_0_WIDTH 
	;STA updateNT_columns
	;LDA #BOX_0_HEIGHT
	;STA updateNT_rows
	;LDA #BOX_1_ORIGIN_X
	;STA tileX
	;LDA #BOX_1_ORIGIN_Y
	;STA tileY 
	JSR coordinatesToMetaNametableValue
	
	
	;;; y gets corrupted
	;;; need a variable to push y to and from.
	;; tempy is being used by the outer function, so this needs to be an in-function variable.
	LDA tileX
	ASL
	ASL
	ASL
	ASL
	STA tileX
	LDA tileY
	ASL
	ASL
	ASL
	ASL
	STA tileY
	JSR GetTileAtPosition ;; gives us y based on tileX and tileY
	
	TAY
	
	
;;;; THIS is where we begin to loop. 
;;;; Since y will get corrupted, we need a placeholder.
	
doRestoreNTLoop:
	LDA updateNT_ntPointer
	STA temp16
	LDA updateNT_ntPointer+1
	STA temp16+1
	;LDA tileX
	;STA tileX
	;LDA tileY
	;STA tileY 
	
	;; now the table index should be loaded in y
	

	LDA (temp16),y
	STA temp
	
	;;; Here, we may want to evaluate:
		;;; 1) Is this the type of tile that has an alternative graphic (monster lock).
		;;; 2) If so, weigh it against a screen bit / veriable to determine if it should be flipped.
		;;; 3) Look for the right *under* value.
		;;;;;;;;;;;; problem - how would this work for, say, slashable bushes, destructible terrain? Hm...
		
		;; In any event, we do the valuaton here.  And if it requires and under state, we load it into temp.
		;; otherwise, we maintain what's in temp (and the accumulator) as what is read from the table.
		
	JSR GetSingleMetaTileValues
	
	LDA temp16
	STA updateNT_ntPointer
	LDA temp16+1
	STA updateNT_ntPointer+1


	LDA updateNT_pos+1
	STA temp16
	LDA updateNT_pos
	CLC
	ADC updateNT_offset
	STA temp16+1
	JSR HandleUpdateNametable	
	
	JSR WaitFrame

	INC updateNT_pos
	INC updateNT_pos
	
	
	INC updateNT_columnCounter
	LDA updateNT_columnCounter
	CMP updateNT_columns
	BEQ restoreColumnFinished
	INY 
	JMP doRestoreNTLoop
restoreColumnFinished:
	;; now we need to add a row.
	LDA updateNT_columns
	ASL 
	STA temp
	
	
	LDA updateNT_pos
	SEC
	SBC temp ;; gets us back to the left of the row.
	CLC
	ADC #$40 ;; jumps down two rows
	STA updateNT_pos
	LDA updateNT_pos+1 ;; while handling 16 bit math for high byte
	ADC #$00
	STA updateNT_pos+1
	LDA #$00
	STA updateNT_columnCounter
	
	TYA
	SEC
	SBC updateNT_columns
	CLC
	ADC #$11 ;; jump down a row for tile to evaluate.
				;;; one more than one row, because if skip down a row, never increases y above
	TAY
	
	INC updateNT_rowCounter
	LDA updateNT_rowCounter
	CMP updateNT_rows
	BNE doRestoreNTLoop
	
	
	
	;BNE doRestoreNTLoop
	
	LDY prevBank
	JSR bankswitchY

	
	LDY tempy

	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
FillBoxArea:

	TYA
	STA tempy
;;;;;;;;;;;;;;;;;
	LDA #$00
	STA updateNT_columnCounter
	STA updateNT_rowCounter
;	LDA #BOX_0_WIDTH 
;	STA updateNT_columns
;	LDA #BOX_0_HEIGHT
;	STA updateNT_rows
;	LDA #BOX_0_ORIGIN_X
;	STA tileX
;	LDA #BOX_0_ORIGIN_Y
;	STA tileY 
	JSR coordinatesToMetaNametableValue
	;; now, updateNT_pos (16 bit) has the starting position for the box.

DoFillBoxLoop:
	LDA updateNT_pos+1
	STA temp16
	LDA updateNT_pos
	STA temp16+1
	
	;;;;; now, we have to get the value of the box part.
	
	LDA updateNT_rowCounter
	BNE notFirstRowForTextbox
	;; we are on the first row.
	;; check if it's the first column.  If yes, it is the top corner.
	LDA updateNT_columnCounter
	BNE firstRowButNotFirstColumn
	;;; it is the first row, first column

	LDA #_BOX_0_TL
	CLC
	ADC #HUD_TILES_START
	STA updateTile_00
	JMP gotTL_boxTile
firstRowButNotFirstColumn:
	LDA #_BOX_0_TC
	CLC
	ADC #HUD_TILES_START
	STA updateTile_00
gotTL_boxTile:
	;; is it the last column?
	LDA updateNT_columnCounter
	CLC
	ADC #$01
	CMP updateNT_columns
	BNE firstRowButNotLastColumn
	;;; it is the first row, and it is the last column.
	LDA #_BOX_0_TR
	CLC
	ADC #HUD_TILES_START
	STA updateTile_01
	JMP gotTR_boxTile
firstRowButNotLastColumn:
	LDA #_BOX_0_TC
	CLC
	ADC #HUD_TILES_START
	STA updateTile_01
gotTR_boxTile:
	JMP checkBottomBoxTiles  ;;;; JUMP TO A BOTTOM CHECKER!!!
notFirstRowForTextbox:
	LDA updateNT_columnCounter
	BNE notFirstColumnForBox
	;;; this is the first column, but it wasn't the first row.
	LDA #_BOX_0_L
	CLC
	ADC #HUD_TILES_START
	STA updateTile_00
	JMP gotTL_boxTile2
notFirstColumnForBox:
	;;; this is not the first column or the first row.
	LDA #_BOX_0_C
	CLC
	ADC #HUD_TILES_START
	STA updateTile_00
gotTL_boxTile2:
	LDA updateNT_columnCounter
	CLC
	ADC #$01
	CMP updateNT_columns
	BNE notFirstRowAndNotLastColumn
	;;; it is not the first row but it is the last column.
	LDA #_BOX_0_R
	CLC
	ADC #HUD_TILES_START
	STA updateTile_01
	JMP gotTR_boxTile2
notFirstRowAndNotLastColumn:
	LDA #_BOX_0_C
	CLC
	ADC #HUD_TILES_START
	STA updateTile_01
gotTR_boxTile2:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
checkBottomBoxTiles:
	LDA updateNT_rowCounter
	CLC
	ADC #$01
	CMP updateNT_rows
	BNE notLastRowForBox
	;; we are on the first row.
	;; check if it's the first column.  If yes, it is the top corner.
	LDA updateNT_columnCounter
	BNE lastRowButNotFirstColumn
	;;; it is the first row, first column

	LDA #_BOX_0_BL
	CLC
	ADC #HUD_TILES_START
	STA updateTile_02
	JMP gotBL_boxTile
lastRowButNotFirstColumn:
	LDA #_BOX_0_BC
	CLC
	ADC #HUD_TILES_START
	STA updateTile_02
gotBL_boxTile:
	;; is it the last column?
	LDA updateNT_columnCounter
	CLC
	ADC #$01
	CMP updateNT_columns
	BNE lastRowButNotLastColumn
	;;; it is the first row, and it is the last column.
	LDA #_BOX_0_BR
	CLC
	ADC #HUD_TILES_START
	STA updateTile_03
	JMP gotBR_boxTile
lastRowButNotLastColumn:
	LDA #_BOX_0_BC
	CLC
	ADC #HUD_TILES_START
	STA updateTile_03
gotBR_boxTile:
	JMP doneWithBoxTiles  ;;;; JUMP TO A BOTTOM CHECKER!!!
notLastRowForBox:
	LDA updateNT_columnCounter
	BNE notFirstColumnForBox2
	;;; this is the first column, but it wasn't the last row.
	LDA #_BOX_0_L
	CLC
	ADC #HUD_TILES_START
	STA updateTile_02
	JMP gotTL_boxTile3
notFirstColumnForBox2:
	;;; this is not the first column or the first row.
	LDA #_BOX_0_C
	CLC
	ADC #HUD_TILES_START
	STA updateTile_02
gotTL_boxTile3:
	LDA updateNT_columnCounter
	CLC
	ADC #$01
	CMP updateNT_columns
	BNE notLastRowAndNotLastColumn
	;;; it is not the first row but it is the last column.
	LDA #_BOX_0_R
	CLC
	ADC #HUD_TILES_START
	STA updateTile_03
	JMP gotTR_boxTile4
notLastRowAndNotLastColumn:
	LDA #_BOX_0_C
	CLC
	ADC #HUD_TILES_START
	STA updateTile_03
gotTR_boxTile4:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doneWithBoxTiles:
	
	JSR HandleUpdateNametable	
	
	LDA update_screen
	AND #%10000000 ;; are we cued to update screen?
	BEQ screenIsNotTurnedOff
	JSR UpdateNT_Direct
	
	JMP skipWaitFrameForDirectUpdates
	
screenIsNotTurnedOff:
	JSR WaitFrame
skipWaitFrameForDirectUpdates:
	INC updateNT_pos
	INC updateNT_pos
	
	INC updateNT_columnCounter
	LDA updateNT_columnCounter
	CMP updateNT_columns
	BEQ doneWithFillBoxLoop
	JMP DoFillBoxLoop
doneWithFillBoxLoop:
	;; now we need to add a row.
	LDA updateNT_columns
	ASL 
	STA temp
	
	
	LDA updateNT_pos
	SEC
	SBC temp ;; gets us back to the left of the row.
	CLC
	ADC #$40 ;; jumps down two rows
	STA updateNT_pos
	LDA updateNT_pos+1 ;; while handling 16 bit math for high byte
	ADC #$00
	STA updateNT_pos+1
	LDA #$00
	STA updateNT_columnCounter
	INC updateNT_rowCounter
	LDA updateNT_rowCounter
	CMP updateNT_rows
	BEQ doneWithFillBoxLoop2 
	JMP DoFillBoxLoop
doneWithFillBoxLoop2:
	
	LDY tempy

	RTS
	



UpdateAttributeTable:

	;LDA tileX
	;STA tileX
	;LDA tileY
	;STA tileY 
	
	;LDA updateNT_attWidth
	;STA updateNT_attWidth
	LDA updateNT_attWidth
	STA temp2
	;LDA updateNT_attHeight
	;STA updateNT_attHeight
	LDA updateNT_attHeight
	STA temp3
	
	LDA #$00
	STA updateNT_att_odds
;;; if it *starts* on an odd number x, it needs to skip the left attribute
;;; if it starts on an odd number y, it needs to skip the top attribute.
;;; if x + width is an odd number, it needs to add the left side of the next attribute.
;;; if y + height is an odd number, it needs to add toe top side of the lower attribute.

;; let's get those values and put them into bits.
	LDA tileX
	AND #%00000001
	BEQ dontAddLeftOdd
	LDA updateNT_att_odds
	ORA #%10000000
	STA updateNT_att_odds
	
dontAddLeftOdd:

	LDA tileX
	CLC
	ADC updateNT_columns
	AND #%00000001
	BEQ dontAddRightOdd
	LDA updateNT_att_odds
	ORA #%01000000
	STA updateNT_att_odds
	
dontAddRightOdd:
	LDA tileY
	AND #%00000001
	BEQ dontAddTopOdd
	LDA updateNT_att_odds
	ORA #%00100000
	STA updateNT_att_odds

dontAddTopOdd:
	LDA tileY
	CLC
	ADC updateNT_rows
	AND #%00000001
	BEQ dontAddBottomOdd
	LDA updateNT_att_odds
	ORA #%00010000 ;; bit 0 will be how we know we're cycling the last row.
	STA updateNT_att_odds
dontAddBottomOdd:
	
	JSR GetAttributePosition
	;;correct index is now in y
	STA updateNT_offset
	

	
	
handleThisAttributeByte:
	LDA updateNT_offset
	STA updateNT_fire_att_lo
	
	LDA #$23
	STA updateNT_fire_att_hi
	

	;; we have to do a loop to see if 
	;; the attributes sit inside or outside the box, somehow...
	;; if they are outside the box, we skip their update.
	;; so we're not updating att by att, but rather quadrant by quadrant.
	
	;; 76 54 32 10
	;;           + top left
	;;        +--- top right
	;;     + ----- bottom left
	;; +---------- bottom right
	
	LDA updateNT_attWidth
	CMP temp2
	BNE dontCheckToSkipBasedOnOdds
	
	LDA updateNT_att_odds
	and #%10000000
	BNE skipLeftAttributeUpdate
	
dontCheckToSkipBasedOnOdds:	

	LDA updateNT_attHeight
	CMP temp3
	BNE dontCheckToSkipBasedOnVertOdds
	
	LDA updateNT_att_odds
	AND #%00100000
	BNE skipLeftAttributeUpdate
	
dontCheckToSkipBasedOnVertOdds:
	
	LDA #%11111100
	STA updateNT_attMask
	LDA #%00000011
	STA updateNT_att
;;; check to see if screen is turned off
	LDA update_screen
	AND #%10000000 ; are we cued to update screen?
	BEQ screenIsNotTurnedOff_forAtt_5
	JSR UpdateAtt_Direct
	JMP skipLeftAttributeUpdate ;; skip wait frame
screenIsNotTurnedOff_forAtt_5:
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame

skipLeftAttributeUpdate:

	LDA updateNT_attHeight
	CMP temp3
	BNE dontCheckToSkipBasedOnVertOdds3

	LDA updateNT_att_odds
	AND #%00100000
	BNE skipTopRightAttributeUpdate

dontCheckToSkipBasedOnVertOdds3:		
	
	LDA #%11110011
	STA updateNT_attMask
	LDA #%00001100
	STA updateNT_att
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; check to see if screen is turned off
	LDA update_screen
	AND #%10000000 ; are we cued to update screen?
	BEQ screenIsNotTurnedOff_forAtt_0
	JSR UpdateAtt_Direct
	JMP skipTopRightAttributeUpdate ;; skip wait frame
screenIsNotTurnedOff_forAtt_0:
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame

skipTopRightAttributeUpdate:

	LDA updateNT_attWidth
	CMP temp2
	BNE dontCheckToSkipBasedOnOdds2	
	
	LDA updateNT_att_odds
	AND #%10000000
	BNE skipLeftAttributeUpdate2

dontCheckToSkipBasedOnOdds2:
	LDA updateNT_att_odds
	AND #%00000001 ;; are we doing last 'extra' odd row type stuff?
	BNE skipLeftAttributeUpdate2
	
	LDA #%11001111
	STA updateNT_attMask
	LDA #%00110000
	STA updateNT_att
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; check to see if screen is turned off
	LDA update_screen
	AND #%10000000 ; are we cued to update screen?
	BEQ screenIsNotTurnedOff_forAtt_1
	JSR UpdateAtt_Direct
	JMP skipLeftAttributeUpdate2 ;; skip wait frame
screenIsNotTurnedOff_forAtt_1:
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame
skipLeftAttributeUpdate2:	

	LDA updateNT_att_odds
	AND #%00000001 ;; are we doing last 'extra' odd row type stuff?
	BNE skipLeftAttributeUpdate3

	LDA #%00111111
	STA updateNT_attMask
	LDA #%11000000
	STA updateNT_att
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; check to see if screen is turned off
	LDA update_screen
	AND #%10000000 ; are we cued to update screen?
	BEQ screenIsNotTurnedOff_forAtt_2
	JSR UpdateAtt_Direct
	JMP skipLeftAttributeUpdate3 ;; skip wait frame
screenIsNotTurnedOff_forAtt_2:
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame
skipLeftAttributeUpdate3:

;;;;;; end of updating this particular attribute.
;;;;;; now see if the next attribute should be done as well.

	inc updateNT_offset
	DEC temp2
	BEQ doneWithRestoringAttributeRow
	JMP handleThisAttributeByte
doneWithRestoringAttributeRow:
	
	
	;; check to see if right side ends on an odd.
	LDA updateNT_att_odds
	AND #%01000000
	BEQ rightSideNotAnOdd
	;; if the right side IS an odd, we need to add one more
	
	LDA updateNT_attHeight
	CMP temp3
	BNE dontCheckToSkipBasedOnVertOdds4

	LDA updateNT_att_odds
	AND #%00100000
	BNE topAndRightAreOdd
	
dontCheckToSkipBasedOnVertOdds4:

	LDA updateNT_att_odds
	AND #%00000001
	BEQ notLastRowOfOddBoxAtt
	LDA updateNT_offset
	STA updateNT_fire_att_lo
	LDA #%11111100
	STA updateNT_attMask
	LDA #%00000011
	STA updateNT_att
	JMP gotTopRightBoxEdgeAttribute
notLastRowOfOddBoxAtt:
	;;; this wasn't at the top,
	;; so both top and bottom left
	;; should be changed.
	LDA updateNT_offset
	STA updateNT_fire_att_lo
	LDA #%11001100
	STA updateNT_attMask
	LDA #%00110011
	STA updateNT_att
	JMP gotTopRightBoxEdgeAttribute
topAndRightAreOdd:	
	LDA updateNT_offset
	STA updateNT_fire_att_lo
	LDA #%11001111
	STA updateNT_attMask
	LDA #%00110000
	STA updateNT_att
	
gotTopRightBoxEdgeAttribute	:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; check to see if screen is turned off
	LDA update_screen
	AND #%10000000 ; are we cued to update screen?
	BEQ screenIsNotTurnedOff_forAtt_3
	JSR UpdateAtt_Direct
	JMP skipLeftAttributeUpdate4 ;; skip wait frame
screenIsNotTurnedOff_forAtt_3:
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame
skipLeftAttributeUpdate4:
	
rightSideNotAnOdd:
	LDA updateNT_att_odds
	AND #%000000001
	BNE noMoreBottomRowsToAdd


	LDA updateNT_attWidth
	STA temp2
	DEC temp3
	BEQ doneWithUpdatingAttributesForBox
	LDA updateNT_offset
	SEC
	SBC updateNT_attWidth
	CLC
	ADC #$08
	STA updateNT_offset
	JMP handleThisAttributeByte
doneWithUpdatingAttributesForBox:
	
	;; check to see if bottom was an odd
	LDA updateNT_att_odds
	AND #%00010000
	BEQ noMoreBottomRowsToAdd
	;;;;; this ends on an odd row, so we must
	;;;;; add one more odd row of attributes
	LDA updateNT_offset
	SEC
	SBC updateNT_attWidth
	CLC
	ADC #$08
	STA updateNT_offset
	;;; must check to see if it's left odd
	;;; use #%00000001 on updateNT_att_odds to know whether we're adding one more row.
	LDA updateNT_att_odds
	ORA #%00000001
	STA updateNT_att_odds
	JMP handleThisAttributeByte
	
	
	
noMoreBottomRowsToAdd:
	RTS
	
	
	
	
	
	
	
	
	

ResetAttributeTable:
	TYA
	STA tempy

	LDA #$00
	STA updateNT_offset	
	;;; THIS IS THE PART THAT NEEDS TO CHANGE...HOW DO WE GET THE *TILE TO LOAD*
	;;;;; This is the very complicated part, where we have to navigate to the bank,
	;;;;; get the label, navigate to the screen bank, get the offset, read the value,
	;;;;; and extract all four tiles, through the LoadMetaNametableWithPaths function,
	;;;;; and then put those tiles into updateTile byte variables.
	;;;;;;;;; PRESUMES IS IN MAP 1
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY newScreen
	;;;;; UPDATE THIS TO FIND THE RIGHT MAP
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
	LDA AttributeTablesMainGameAboveLo,y
	STA temp16
	LDA AttributeTablesMainGameAboveHi,y
	STA temp16+1
	JMP ++
+
	LDA AttributeTablesMainGameBelowLo,y
	STA temp16
	LDA AttributeTablesMainGameBelowHi,y
	STA temp16+1
++
	;;;; now we have the correct label
	LDY screenBank
	jsr bankswitchY
	;;;;; now we're in the right screen bank.  
	
	LDA updateNT_attWidth
	;CLC
	;ADC #$01
	STA temp2
	LDA updateNT_attHeight
	;CLC
	;ADC #$01
	STA temp3
	
	JSR GetAttributePosition
	;;correct index is now in y
	STA updateNT_offset

RestoreBoxAttributesLoop:
	LDA updateNT_offset
	STA updateNT_fire_att_lo
	sec
	sbc #$c0
	Sec
	SBC #HUD_ATT_OFFSET  ;; ERASE ME - for hud offset
	TAY ;; offset is the plact to write, plus c0 as defined in the GetAttributePosition routine
		;; but for indexing the table, we want to start at 0

	LDA #$23
	STA updateNT_fire_att_hi
	
	LDA (updateNT_ntPointer),y
	
	STA updateNT_att
	LDA #$00
	STA updateNT_attMask
	LDA #$01
	STA UpdateAtt
	JSR WaitFrame
	
	inc updateNT_offset
	dec temp2
	BNE RestoreBoxAttributesLoop
	LDA updateNT_offset
	SEC
	SBC updateNT_attWidth
	CLC
	ADC #$7
	STA updateNT_offset
	LDA updateNT_attWidth
	CLC
	ADC #$01
	STA temp2
	dec temp3
	BNE RestoreBoxAttributesLoop
	
	
	
	LDY prevBank
	JSR bankswitchY
	LDY tempy
	RTS


	
	
	
UpdateNT_Direct:	
	LDX #$00
doUpdateNT_Direct_loop:

;;;;;;;;;DO A LOOP HERE THORUGH ALL 4 possibilities.
	LDA $2002
	LDA updateNT_fire_Address_Hi,x
	STA $2006
	LDA updateNT_fire_Address_Lo,x
	STA $2006
	LDA updateNT_fire_Tile,x
	STA $2007
	INX
	CPX #$04
	BNE doUpdateNT_Direct_loop
	RTS
	
	
	
UpdateAtt_Direct:
	LDA updateNT_fire_att_hi
	STA $2006
	LDA updateNT_fire_att_lo
	STA $2006
	LDA $2007
	LDA $2007 ;; double read necessary to get this value.
	STA temp
	LDA updateNT_fire_att_hi
	STA $2006
	LDA updateNT_fire_att_lo
	STA $2006
	LDA temp
	AND updateNT_attMask
	ORA updateNT_att
	STA $2007
	LDA #$00
	STA UpdateAtt
	RTS
	
	
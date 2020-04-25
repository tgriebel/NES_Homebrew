HandleTextBox:

;; textboxHandler
 ; 7 - 6 - 5 - 4 - 3 - 2 - 1 - 0
  ;7 = Textbox is active.
   ;    6 = Black box is being created, will then create text.
    ;        5 = Attribute update to black.
     ;           4 = text is being created.
      ;             = loop to 5 if more text.
       ;             3 = Black box is being created, with then restore NT
        ;                 2 = Attributes to main NT
         ;                     1 = restore NT
          ;                          0 = check for "more" text.
			


	LDA textboxHandler
	AND #%10000000
	BNE textboxIsActive
	RTS ;; textbox is inactive.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
textboxIsActive:
	LDA updateNametable
	BEQ notAlreadyWritingToNT
	RTS
notAlreadyWritingToNT
	;HideSprites
;; DO TEXT BOX STUFF.
	;; Which text box stuff to do is determined by the textboxHandler byte.
	;; if it is active, but all other bits are inactive, that means we have just activated and we need to turn
	;; this system on.
	LDA textboxHandler
	AND #%01111111
	BNE textboxSettingsAlreadyOn
	;;; get textbox settings
 ;; skip resetting the offset.
	LDA #$00
	STA updateNT_offset
	STA updateHUD_offset

	STA updateNT_H_offset
	STA updateNT_V_offset
	
	;;; zero out the things offsets and start creating the blackout box.
	LDA #%11000000
	STA textboxHandler ;; flow right into the next.
textboxSettingsAlreadyOn:
	
	LdA textboxHandler
	AND #%01000000
	BEQ notCreatingBlackBox
	;;;; CREATE THE BLACK BOX.
	;;;; The frist phase is to create the black box.
	;;;; no matter what color the text box will be, or which palette it will use
	;;;; it will always first create a box of "blanks" so it can be changed to whatever
	;;;; background attribute you'd like without noticing the attribute change.
	JSR CreateBlackBox
	;;; now the black box has been created.
	
notCreatingBlackBox:
	LDA textboxHandler
	AND #%00100000
	BEQ notSettingTextboxAttributes
	JSR isWritingTextboxAttributes
	RTS
	
	;;; set textbox attributes.
notSettingTextboxAttributes:
	LDA textboxHandler
	AND #%00010000
	BEQ notUpdatingTextboxText
	;; updating textbox text.
	JSR isWritingTextToTextbox

	RTS
notUpdatingTextboxText:
	LDA textboxHandler
	AND #%00001000
	BEQ notErasingTextboxText
	JSR CreateBlackBox
	RTS
notErasingTextboxText:
	LDA textboxHandler
	AND #%00000010
	BEQ notRestoringNametables2
;	JSR CheckForEndOfTextString
;	LDA gameHandler
;	AND #%00100000
;	BEQ notRestoringNametables2 ;; because we have finished.
	JSR RestoreNametableData
notRestoringNametables2
	RTS
	

	
	
	
	
	
	
	
	
	
	
	
	
	
getUpdateTileOffsetPosition:
	LDA xScroll
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC	#BOX_1_ORIGIN_X
	CLC
	ADC updateNT_H_offset
	STA tileX
	
	LDA #BOX_1_ORIGIN_Y
	CLC
	ADC updateNT_V_offset
	STA tileY
	JSR coordinatesToMetaNametableValue
	;;; spits out updateNT_pos as low and updateNT_pos+1 as hi of address to write.
	;;; right now, this is in terms of a single nametable, starting at $20 as the high top left corner high byte.
	
	

	
;;;; FOR HITE BYTE:
;;;; Take columnTracker and divide by 2 so you get a value 0-16
;;;; Add that number to BOX_1_ORIGIN_X.
;;;; If the sum is less than 16, this should stay in the same nametable.
;;;; Otherwise, it should cross nametables.
	Ldy columnTracker
	LDA columnTracker
	AND #%00001111
	CLC
	ADC #BOX_1_ORIGIN_X ;; plus offset of what tile you're drawing.
	CLC
	ADC updateNT_H_offset
	AND #%00010000
	BNE +
	;;; same nametable
	LDA columnTracker
	AND #%00010000
	BNE +++
	;; this started in even table,
	;; so it should stay in even table
	JMP updateIsEvenTable
+++	
	;;; this started in odd table
	;;; so it should stay in odd table.
	JMP updateIsOddTable
+
	;;; different nametable
	LDA columnTracker
	AND #%00010000
	BNE +++
	;; this started in even table
	;; so it should now be odd table.
	JMP updateIsOddTable
+++
	;;; this started in odd table
	;;; so it should now be even table.
	JMP updateIsEvenTable

	

updateIsEvenTable:
	LDA updateNT_pos+1
	AND #%00000011 ;; 0,1,2 or 3
	clc
	adc #$20
	STA updateNT_pos+1
	JMP gotHiUpdatePos
	
updateIsOddTable:
	LDA updateNT_pos+1
	AND #%00000011 ;; 0,1,2 or 3
	CLC
	ADC #$24
	STA updateNT_pos+1
	JMP gotHiUpdatePos
gotHiUpdatePos:

	RTS
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
checkNTforNewTile:
	LDA temp3; updateNT_pos
	AND #%00100000
	CMP #%00100000
	BEQ newTileHasCrossedThreshold
	;; new tile has not crossed threshold.
	;; same nametable

	LDA columnTracker
	AND #%00010000
	BNE updateIsOddTable
	JMP updateIsEvenTable
newTileHasCrossedThreshold:
	
	LDA columnTracker
	AND #%00010000
	BNE updateIsEvenTable
	JMP updateIsOddTable
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;RTS ;; redundant, unnecessary
	
	
isWritingTextToTextbox:
	;;; already in bank 17.
	;; we need to get positioning.

	LDA xScroll
	LSR
	LSR
	LSR
	STA temp
	LDA #BOX_1_ORIGIN_X
	ASL
	CLC
	ADC updateNT_H_offset
	CLC
	ADC temp
	STA temp3
	AND #%00011111
	STA tileX
	
	LDA #BOX_1_ORIGIN_Y
	ASL
	CLC
	ADC updateNT_V_offset
	STA tileY
	
	JSR coordinatesToNametableValue
	JSR checkNTforNewTile
	;; temp has position value.
	;LDA temp
	;STA updateNT_pos
	
	
	
	LDY textVar ;; what string
	LDA screenText,y
	TAY
	LDA stringsTableLo,y
	STA temp16
	LDA stringsTableHi,y
	STA temp16+1
	LDY textboxOffsetHold
	LDA (temp16),y
	
	;; this is where we determine if this is a special character or a normal letter/number to update.
	CMP #_END
	BNE +
;;;; END:
EndText:
	;; this is and _END value.
	;; it turns off writing to the textbox.
	
	LDA textboxHandler
	AND #%01111111
	STA textboxHandler
	;;;;; textbox handler stays on the same state
	;;;;; but deactivates.
	;;;;; it will start again if bbutton is pressed again
	;;;;; on state 00001000, which will begin the 'turn off' process.
	
	JMP doneTextUpdate
+
	CMP #$FE ;; is it a new line?
	BNE notANewLine_text
;;;; NEW LINE:


	LDA #$00
	STA	updateNT_H_offset
	INC updateNT_V_offset
	INC textboxOffsetHold
	
	JMP doneTextUpdate
notANewLine_text:

	CMP #_ENDTRIGGER
	BNE notEndTrigger
	;; is an end trigger
	INC textboxOffsetHold ;; get the very next value.
	LDY textboxOffsetHold
	LDA (temp16),y
	STA temp
	;;;; this now has the trigger to change.
	TriggerScreen temp
	JMP EndText
notEndTrigger:

	CMP #_ENDITEM 
	BNE notEndItem
	;;; gives player an item.
	INC textboxOffsetHold ;; get the very next value.
	LDY textboxOffsetHold
	LDA (temp16),y
	TAY
	;;; this now has the bit to flip in BOSSES DEFEATED constant.
	LDA ValToBitTable_inverse,y
	ORA weaponsUnlocked
	STA weaponsUnlocked
	TriggerScreen screenType ;; will flip the current screen type
	;PlaySound #SFX_DO_TRIGGER
	JMP EndText
	
notEndItem:
	CMP #_MORE
	BNE notMoreText
	LDA #%10000000
	STA textboxHandler
	;; flip a more text flag.
	LDA #$01
	STA moreText
	INC textboxOffsetHold
	JMP EndText
notMoreText:
;;;; NORMAL VALUE
		;;;;; The look up was a normal letter, number, or other hud value.
	CLC 
	ADC #$C0
	STA updateHUD_fire_Tile	
	
	LDA updateNT_pos
	STA updateHUD_fire_Address_Lo
	LDA updateNT_pos+1
	STA updateHUD_fire_Address_Hi
	INC updateNT_H_offset
	INC textboxOffsetHold
doneTextUpdate:	

	RTS
	
	
	
	
	
	
	
	
	
	
	
CreateBlackBox	
	LDX #$00
	
;;; DRAW METATILE 1
	;; this macro SETS it to change on the next vblank update.
	;; starting at address hi-lo, with the tile in the third argument.
	;; if it sees #BLANK_TILE, it will create a meta tile of four blank tiles.
	;; if it sees any other value, it will create a metatile starting with 
	;; that index as the top left corner.
	
	;;;;;;; IF THE GAME DOES NOT SCROLL:
	;;;;;;; You can simply read the box value, do a little math, to get the offset
	;;;;;;; of the address for the top left corner, and skip the whole business of
	;;;;;;; finding the offset based on the scroll.
	
	;;;;;;; IF THE GAME DOES SCROLL:
	;;;;;;; YOu will need to get the offset value so it is at the box value position
	;;;;;;; compared to the CAMERA rather than zero.
	
	;;;;;;; Fortunately, we already have tables set up for columnTableLo and columnTableHi
	;;;;;;; which we use to handle the column for scrolling.  
	;;;;;;; we can use the columnTracker value to help determine the proper offset.
	
	;;;;;;; There can only be 32 columns.
	
	;;;;;;; And we will use updateNT_offset to continue this over frames, 
	;;;;;;; and to handle tile to offset.
	;;;;;;; this will be set to zero wherever HandleTextBox is activated.
	;;;;;;; It needs to, in some way, be boolean (like a key press, or using a boolean var).
	; LDA #$00
	; STA updateNT_H_offset
	; STA updateNT_V_offset
	;; THESE ALSO MUST BE SET IN THE BOOL VAR PLACE
	;; Whatever code is calling this must also set these to zero.

	
	
	
	LDA #$00
	STA tilesToWrite
	LDA #$04
	STA dummyVar2
DoLoopThing:
	JSR getUpdateTileOffsetPosition
	SetMetaTileToChange updateNT_pos+1, updateNT_pos, #BLANK_TILE

 	INC updateNT_H_offset
	LDA updateNT_H_offset
	CMP #BOX_1_WIDTH
	BEQ ++
	DEC dummyVar2
	LDA dummyVar2
	BEQ +
	JMP DoLoopThing
++ ;; width has been reached.
	;; now to test the height, and to move h pos back to the left.

	
	BEQ dontEndCreatingBlackBox
	JMP EndCreatingBlackBox
dontEndCreatingBlackBox:
	
	LDA #$00
	STA updateNT_offset
	STA updateHUD_offset
	STA updateNT_H_offset
	INC updateNT_V_offset


+	

	LDA #$01
	STA updateNametable  ;; turn on write.
	
	LDA updateNT_V_offset
	CMP #BOX_1_HEIGHT
	BCS turnOffCreatingTextBox
	
	LDA updateNT_H_offset
	CMP #BOX_1_WIDTH
	BEQ turnOffCreatingTextBox
	JMP EndCreatingBlackBox
turnOffCreatingTextBox:
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Setup text specifics
	LDA #$00
	STA stringGroupOffset
	STA updateNT_H_offset
	STA updateNT_V_offset
	
	LDA xScroll
	LSR
	LSR
	LSR
	STA temp
	LDA #BOX_1_ORIGIN_X
	ASL
	CLC
	ADC temp
	CLC
	ADC #H_PAD_TEXTBOX
	STA tileX
	LDA #BOX_1_ORIGIN_Y
	ASL
	CLC
	ADC #V_PAD_TEXTBOX
	STA tileY
	
;	LDA #$01
;	STA writingText ;; turn on writing text.
	LDA moreText
	BEQ +
	LDA #$00
	STA moreText
	JMP ++
+
	LDA #$00
	STA textboxOffsetHold
++
	STA updateNT_H_offset
	STA updateNT_V_offset

	LDA textboxHandler
	AND #%00001000
	BEQ continueToUpdatingAttributes
	;;; is turning textbox OFF, so no writing to text.
	;;; will have to allot for changing attributes back with the
	;;; bit 00000100
	LDA #%10101000 ;; turn on attribute update
	STA textboxHandler
	LDA #$00
	STA updateNT_H_offset
	STA updateNT_V_offset
	STA updateNT_offset
	STA updateNT_compensation

;	LDA xScroll_hi

;	AND #%00000001
;	BEQ oddToEven2
;	LDA #$27
;	JMP gotNtDeets2
;oddToEven2:
;	LDA #$23
;gotNtDeets2:
;	STA updateNT_tableLeft
;	STA updateNT_details

	;LDA columnTracker
	LDA #BOX_1_ORIGIN_X
	LSR
	TAY
	LDA attrColumnTableHi,y
	STA updateNT_tableLeft
	STA updateNT_details

	RTS
continueToUpdatingAttributes:
	LDA #%10001000
	STA textboxHandler
	LDA #$00
	STA updateNT_H_offset
	STA updateNT_V_offset
	STA updateNT_offset
	STA updateNT_compensation
	
	
;	LDA xScroll_hi

;	AND #%00000001
;	BEQ oddToEven
;	LDA #$27
;	JMP gotNtDeets:
;oddToEven:
;	LDA #$23
;gotNtDeets:
;	STA updateNT_tableLeft
;	STA updateNT_details
	
	;LDA columnTracker
	LDA updateNT_H_offset
	CLC
	ADC updateNT_offset
	ASL
	CLC
	ADC	columnTracker
	AND #%00011111
	LSR 
	TAY
	LDA attrColumnTableHi,y
	STA updateNT_details
	
	LDA #%10100000
	STA textboxHandler
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RTS
EndCreatingBlackBox:	
	LDA #$01
	RTS
	
	
	
	
RestoreNametableData:

	

	;;; FIRST we need to find the metaNametale value from the ROM.
	;;;;;;;;;;LESSER PRIORITY;;;;;;;;;;;;;;
	;;; THEN we need to check it againt collision type to / screen state to see if it should be 
	;;; change (for instance, a tile that changes at night / saved / changes if no monsters, if there are no monsters, etc)
	;;; THEN, we should probably always just restore the hud at the end.
	;;; the problem is, the data we need to fetch is in bank 16, then screen bank, 
	;;; while we are currently in bank 17 with this routine.
	;;; so restoration of nametable, or at least analysis of whate tiles to write, will have to happen OUTSIDE of this routine
	;;; We handle it in HandleBoxes, which will populate updateTile00-03, and respect paths.
	;;; And we handle POSITION to update here.

	LDX #$00
	LDA #$00
	STA tilesToWrite
	
	JSR getUpdateTileOffsetPosition
	
	

	LDA updateNT_pos
	STA temp
	LDA updateNT_pos+1
	STA temp1
	

	SetTileToChange temp1, temp, updateTile_00
	LDA temp
	CLC
	ADC #$01
	STA temp2
	LDA temp1
	ADC #$00
	STA temp3
	
	
	SetTileToChange temp3, temp2, updateTile_01
	
	LDA temp
	CLC
	ADC #$20
	STA temp2
	LDA temp1
	ADC #$00
	STA temp3
	
	
	SetTileToChange temp3, temp2, updateTile_02
	
	LDA temp
	CLC
	ADC #$21
	STA temp2
	LDA temp1
	ADC #$00
	STA temp3
	
	SetTileToChange temp3, temp2, updateTile_03
	INC tilesToWrite
	LDA #$01
	STA updateNametable
	
	INC updateNT_H_offset
	LDA updateNT_H_offset
	CMP #BOX_1_WIDTH
	BNE dontReturnToGame
	LDA #$00
	STA updateNT_H_offset
	INC updateNT_V_offset
	LDA updateNT_V_offset
	CMP #BOX_1_HEIGHT
	BNE dontReturnToGame
	LDA #$00
	STA textboxHandler
	STA updateHUD_offset
	LDA gameHandler
	AND #%11011111
	STA gameHandler
	;ShowSprites

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; check to see if there is behavior after a text box.

;;;; THIS WOULD WARP YOU TO A SCREEN AFTER TEXTBOX.
	; LDA #$01
	; STA activateWarpFlag
	; PlaySound #SND_ENTER
	; LDX player1_object
	; LDA Object_x_hi,x
	; STA mapPosX
	; LDA Object_y_hi,x
	; STA mapPosY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	
dontReturnToGame:

	RTS
	
	
	
	
	
	
	
	
isWritingTextboxAttributes:
	;; handle all four quadrants of the attribute.
	
	
	RTS
	
	
	
	
	
	
	
	
	
	
	
	

HandleBoxUpdates:
	LDA textboxHandler
	BNE doHandleBoxUpdate
	RTS ;; dont handle box update
doHandleBoxUpdate:

	;; there is a box.  It needs updating.
	;; Finding position for restoring nametables
	;; needs multiple banks, so really can only happen *here* in the static bank, 
	LDA textboxHandler
	AND #%00000010
	BEQ +
	
	JSR GetNametableDataToRestore
	JMP notRestoringNametables
+

	LdA textboxHandler
	AND #%00000100
	BEQ notRestoringNametables
	LDA #$00
	STA updateNT_H_offset
	STA updateNT_V_offset
	STA updateNT_offset
	JSR GetNametableDataToRestore
	;; then continue on, which will handle the actual position to update and whatnot
notRestoringNametables:


	LDA textboxHandler
	AND #%00100000
	BEQ notChangingAttributes
	JSR ChangeAttributes
notChangingAttributes:
	
	LDA currentBank
	STA prevBank
	LDY #$17
	JSR bankswitchY
	JSR HandleTextBox
	LDY prevBank
	JSR bankswitchY
	RTS
	

	
	
	
GetNametableDataToRestore:
	;; this gets the value of the tile to be drawn.
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
	AND #%00011111
	CMP #$10
	BCC restoringSameNametable
	;;;; update the opposite nametable
	
	LDA #$10
	STA temp2
	LDA rightNametable
	JMP +
	
restoringSameNametable:
	;;; update the same nametable
	LDA #$00
	STA temp2
	LDA currentNametable
	
+
	STA temp1
	
	
	LDA #BOX_1_ORIGIN_Y
	CLC
	ADC updateNT_V_offset
	STA tileY	
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC tileX
	SEC
	SBC temp2
	
	STA temp ;; now we have the offset to read from the nametable.
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDA temp1 ;; the screen we are trying to get nametable off - here check left/right nt?
	ASL
	TAY
	;LDA arg1 ;; this checks the map number.
	;BNE +;; the map is not zero type
	;;;; here the map is the zero type.
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
	
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
	LDY screenBank
	JSR bankswitchY
	LDA temp
	TAY
	LDA (temp16),y
	JSR GetSingleMetaTileValues
		;;; now we should have 
	LDY prevBank
	JSR bankswitchY
	
	LDA #%10000010
	STA textboxHandler
	
	RTS

	
	
	
ChangeAttributes:
	
	LDA #$00
	STA temp2 ;; we will use temp2 to hold whether or not rows / columns are odds.
	LDA #BOX_1_HEIGHT
	;CLC
	;ADC #$02
	LSR
	STA updateNT_rowCounter
	LDA #BOX_1_WIDTH
	LSR
	STA updateNT_columnCounter
	

	
	LDX #$00
	;; 33221100 is BR, BL, TR, TL.
	LDA xScroll
	LSR
	LSR
	LSR
	LSR
	clc
	ADC #BOX_1_ORIGIN_X
;	STA tileX
;	LDA #BOX_1_ORIGIN_Y
;	STA tileY
;	JMP ++
;;; now, we will use temp2 to determine "odds".
;;; if it starts an odd x, bit 0 is 1
;;; if it starts on an odd y, bit 1 is 1.
;;; if it ends on an odd x, bit 2 is 1.
;;; if it ends on an odd y, bit 3 is 1.
	AND #%00000001
	BEQ +
	;; is an odd column.
	LdA #$00000001
	STA temp2
	LDA #BOX_1_WIDTH
	LSR
	CLC
	ADC #$01
	STA updateNT_columnCounter 
+

	LDA tileX
	CLC
	ADC #BOX_1_WIDTH
	AND #%00000001
	BEQ +
	LDA temp2
	ORA #%00000100 ;; right ends on odd.
	STA temp2
	LDA #BOX_1_WIDTH
	LSR
	CLC
	ADC #$01
	STA updateNT_columnCounter 
	
+
	
	LDA #BOX_1_ORIGIN_Y
	STA tileY
	AND #%00000001
	BEQ +
	LDA temp2
	ORA #%00000010
	STA temp2
	LDA #BOX_1_HEIGHT
	LSR
	CLC
	ADC #$01
	STA updateNT_rowCounter

	
+
	LDA tileY
	CLC
	ADC #BOX_1_HEIGHT
	AND #%00000001
	BEQ + ;; heights SHOULD end on an odd number, because they are two tiles high.  
			;; 0, 1 (1 is the bottom, if everything is even).
	LDA temp2
	ORA #%00001000
	STA temp2
	
	LDA #BOX_1_HEIGHT
	LSR
	CLC
	ADC #$01
	STA updateNT_rowCounter
+
;++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;	JSR GetAttributePosition
;	STA updateNT_offset	
;	LDA updateNT_V_offset
;	ASL
;	ASL
;	ASL
;	CLC
;	ADC updateNT_offset
;	CLC
;	ADC updateNT_H_offset
	JSR GetAttributeHiAndLow
	
	
SetAttLoop:	

	LDA #%11111111
	STA updateNT_attMask
	STA temp1
	LDA textboxHandler
	AND #%00001000 ;; are we RESTORING attributes?
	BEQ + ;; not restoring attributes

	JSR RestoringAttributes

	JMP ++
+	

	JSR FigureAttributeMask
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; Set up the attribute to change.

	SetAttributeToChange updateNT_details, temp3, temp1
	INC updateNT_H_offset
	LDA updateNT_columnCounter
	CMP updateNT_H_offset
;;;;;;;; if the width was reached, we need to increase the vertical offset
;;;;;;;;; and set the horizontal offset back to 0.
	BEQ updateAttWidthReached
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Att width was not reached, which means we need
;; to get the position of the next offset
;; store it into temp3, and .
	
	;JSR GetAttributePosition

	JSR GetAttributeHiAndLow
	
	
	CPX #$08
	BEQ ++++
	JMP SetAttLoop

updateAttWidthReached:
	LDA #$00
	STA updateNT_H_offset
	INC updateNT_V_offset
	LDA updateNT_rowCounter
	CMP updateNT_V_offset
	BNE +
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; UPDATE TEXBOX HANDLER TO NEXT STATE
	LDA textboxHandler
	AND #%00001000
	BEQ wasNotRestoringAtt
	;; was restoring attributes
	LDA #%10000100
	STA textboxHandler
	JMP gotNewTextboxState
wasNotRestoringAtt:
	LDA #$00
	STA updateHUD_fire_Tile	
	STA updateHUD_fire_Address_Lo
	STA updateHUD_fire_Address_Hi
	LDA #%10010000
	STA textboxHandler
gotNewTextboxState
	LDA #$00
	STA updateNT_H_offset
	STA updateNT_V_offset

	LDA #$01
	STA UpdateAtt
	JMP DoneWithChangingAttributes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+	

++++	

	LDA #$01
	STA UpdateAtt
DoneWithChangingAttributes:
	RTS

	
	
	
getAttributeMask:
	LDA updateNT_H_offset
	CLC
	ADC #$01
	CMP #BOX_1_WIDTH
	BNE notAtBox1Width

	LDA #%10101010
	STA updateNT_attMask
	JMP +++
notAtBox1Width:
	LDA updateNT_H_offset
	BNE +
	LDA temp1
	AND #%00000001
	BNE ++
+
	LDA #%11111111
	STA updateNT_attMask
	JMP +++
++
	LDA #%11001100
	STA updateNT_attMask
+++
	
	
	RTS
	
	

	
	
	
FigureAttributeMask:
	LDA updateNT_V_offset
	BNE + ; is not first row
	;; is first row.
	LDA temp2
	AND #%00000010
	BEQ +++;; first row is even
	;; first row is odd, which means that all in this row will only change
	;; the bottom bits.
	LDA temp1
	AND #%11110000
	STA temp1
	JMP +++
	
+
	;; v offset loaded into A
	LDA updateNT_V_offset
	CLC 
	ADC #$01
	CMP updateNT_rowCounter
	BNE +++ ;done with checking vertical offset

	;; it IS the last row.
	LDA temp2
	AND #%00001000
	BEQ +++
	;;; the last row is odd.
	;;;; which means that all in the TOP row will change, and bottom is outside of box.
	LDA temp1
	AND #%00001111
	STA temp1
	;;; flow right into horizontal checking

+++
	LDA updateNT_H_offset
	BNE +
	;; is first column.
	LDA temp2
	AND #%00000001
	BEQ +++++
		;; first row is odd, which means that in in this row will 
		;; only change left bits.
	LDA temp1
	AND #%11001100
	STA temp1
	JMP +++++
+
	LDA updateNT_H_offset
	CLC 
	ADC #$01
	CMP updateNT_columnCounter
	BNE +++++ ;done with checking horizontal offset

	;; it IS the last column.
	LDA temp2
	AND #%00000100
	BEQ +++++
	;;; the last column is odd.
	;;;; which means that all in the left row will change, and bottom is outside of box.
	LDA temp1
	AND #%00110011
	STA temp1	

+++++
	RTS

	
	
RestoringAttributes:

	LDA #%00000000
	STA updateNT_attMask
	;; we have added c0 to the position
	;; to get the address to write the att to.
	;; so we'll need to subtract it to get the read location
	LDA columnTracker
	CLC
	ADC #BOX_1_ORIGIN_X
	LSR 
	CLC
	ADC updateNT_H_offset
	AND #%00001000
	STA temp
	
	LDA columnTracker
	CLC
	ADC #BOX_1_ORIGIN_X
	LSR 
	CLC
	ADC updateNT_H_offset
	AND #%00001000
	CMP temp
	BNE notTheSameRestoreNTs
	;;; restore NTS are the same.
	LDA currentNametable
	JMP +
notTheSameRestoreNTs:
	LDA rightNametable
+
	STA temp
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY temp
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
	LDY screenBank
	JSR bankswitchY

	
	LDA temp3
	SEC
	SBC #$c0
	TAY

	
	LDA (temp16),y

	STA temp1

	LDY prevBank
	JSR bankswitchY


	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
GetAttributeHiAndLow:
	;;;; here we need to get the low byte, read it from the attributeColumnTableLo, 
	;;;; and store it to temp3.
	;;;; Then get the high byte, read it from attributeColumnTableHi,
	;;;; and store it to updateNT_details
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; get offset in "rows".
	LDA #BOX_1_ORIGIN_Y
	LSR
	CLC
	ADC updateNT_V_offset
	ASL
	ASL
	ASL
	STA temp
	;;;; temp will be the literal offset of the read/write.
	
	;;; now get the offset in columns.
	LDA columnTracker
	CLC
	ADC #BOX_1_ORIGIN_X
	LSR 
	CLC
	ADC updateNT_H_offset
	AND #%00001111
	TAY
	
	LDA attrColumnTableLo,y
	CLC
	ADC temp

	STA temp3
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LDA attrColumnTableHi,y
	STA updateNT_details
	RTS

RestoreBoxArea:
	TYA
	STA tempy

	LDA #$00
	STA updateNT_offset	
	;;; THIS IS THE PAR THAT NEEDS TO CHANGE...HOW DO WE GET THE *TILE TO LOAD*
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
	LDA NameTablePointers_Map1,y
	STA updateNT_ntPointer	
	LDA NameTablePointers_Map1+1,y
	STA updateNT_ntPointer+1
	;;;; now we have the correct label
	LDY screenBank
	jsr bankswitchY
	;;;;; now we're in the right screen bank.  

	LDA #$00
	STA updateNT_columnCounter
	STA updateNT_rowCounter
	LDA #BOX_0_WIDTH 
	STA updateNT_columns
	LDA #BOX_0_HEIGHT
	STA updateNT_rows
	LDA #BOX_0_ORIGIN_X
	STA tileX
	LDA #BOX_0_ORIGIN_Y
	STA tileY 
	JSR coordinatesToNametableValue
	
	
	;;; y gets corrupted
	;;; need a variable to push y to and from.
	;; tempy is being used by the outer function, so this needs to be an in-function variable.
	JSR GetTileAtPosition ;; gives us y based on tileX and tileY
	
	
;;;; THIS is where we begin to loop. 
;;;; Since y will get corrupted, we need a placeholder.
	
doRestoreNTLoop:
	LDA updateNT_ntPointer
	STA temp16
	LDA updateNT_ntPointer+1
	STA temp16+1

	LDY tempz
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

	INC updateNT_offset
	INC updateNT_offset
	
	;BNE doRestoreNTLoop
	
	LDY prevBank
	JSR bankswitchY

	
	LDY tempy

	RTS
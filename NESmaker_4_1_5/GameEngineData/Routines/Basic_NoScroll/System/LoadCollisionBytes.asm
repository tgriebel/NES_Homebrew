
LoadCollisionBytes:

	JSR LoadEvenCollisionPoint
	INX
	DEC updateCol_columnCounter
notEndOfColumn:
	JSR LoadOddCollisionPoint
	INX
	DEC updateCol_columnCounter
	LDA updateCol_columnCounter
	BNE notEndOfColumn2
	;; is end of column.
	
	LDA updateCol_columns
	STA updateCol_columnCounter
	TXA
	SEC
	SBC updateCol_columns
	CLC
	ADC #$10
	TAX
	
	
	LDA updateCol_columns
	LSR
	STA temp2
	TYA
	SEC
	SBC temp2
	CLC
	ADC #$08;; one more will get added below as part of flowing into notEndofColumn2
	TAY
	
	INC updateCol_rowCounter
	LDA updateCol_rowCounter
	CMP updateCol_rows
	BEQ doneWithColBytes
	
notEndOfColumn2:
	INY
	;CPY #$78
	;BEQ doneWithColBytes
	JMP LoadCollisionBytes
doneWithColBytes
	RTS
	
	
	
	
	
	
doEndOfColumn:

	INC updateCol_rowCounter
	LDA updateCol_columns
	STA updateCol_columnCounter
	RTS
	
	
	
	

	
	
LoadEvenCollisionPoint:

;; get the first point:
	LDA (collisionPointer),y
	LSR
	LSR
	LSR
	LSR
	STA temp
;;;;;;;;;;;; CHECK FOR TRIGGERED.
;;;;;;;;;;;; Do all triggered updates here.
	GetTrigger
	BEQ +
	LDA temp
	CMP #COL_INDEX_LOCK
	BNE +
	;;; if it was a locked tile, make sure it is 
	LDA #$00
	STA temp ;; set it to a walkable tile.
	;JMP +
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
+	
	LDA temp
	STA collisionTable,x ;; the collision table 
	;;; handle prize couner type tiles
loaded_FirstPoint:

	RTS
	
LoadOddCollisionPoint:

	LDA (collisionPointer),y
	AND #%00001111
	sta temp
	
	GetTrigger
	BEQ +
	LDA temp
	CMP #COL_INDEX_LOCK
	BNE +
	;;; if it was a locked tile, make sure it is 
	LDA #$00
	STA temp ;; set it to a walkable tile.
	JMP +
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	;
+	
	
	LDA temp
	STA collisionTable,x
	;; handle prize counter loads here.

	
loaded_SecondPoint:

	RTS
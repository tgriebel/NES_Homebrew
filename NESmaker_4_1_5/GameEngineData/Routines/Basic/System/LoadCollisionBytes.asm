
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
	JMP +
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
+	

	;;; this is the first point.
	LDA updateCol_table
	BNE loadFirstPoint_ToSecondNametable
	LDA temp
	STA collisionTable,x ;; the collision table in RAM
	LDA newScreen
	AND #%00000001
	BNE loaded_FirstPoint ;; skip checking for prize counter.
	LDA temp
	CMP #COL_INDEX_PRIZE
	BNE +
	INC screenPrizeCounter
+
	JMP loaded_FirstPoint
loadFirstPoint_ToSecondNametable:
	LDA temp
	STA collisionTable2,x
	LDA newScreen
	AND #%00000001
	BEQ loaded_FirstPoint ;; skip checking for prize counter.
		LDA temp
	CMP #COL_INDEX_PRIZE
	BNE +
	INC screenPrizeCounter
+
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
	

	LDA updateCol_table
	BNE update_CollisionTable2_2
	LDA temp
	STA collisionTable,x
	LDA newScreen
	AND #%00000001
	BNE loaded_SecondPoint ;; skip checking for prize counter.
		LDA temp
	CMP #COL_INDEX_PRIZE
	BNE +
	INC screenPrizeCounter
+
	
	JMP loaded_SecondPoint
update_CollisionTable2_2:
	LDA temp
	STA collisionTable2,x
	LDA newScreen
	AND #%00000001
	BEQ loaded_SecondPoint ;; skip checking for prize counter.
		LDA temp
	CMP #COL_INDEX_PRIZE
	BNE +
	INC screenPrizeCounter
+
	
loaded_SecondPoint:

	RTS
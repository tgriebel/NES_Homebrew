;; shoot fireball straight	
	TXA
	STA tempx
	LDA Object_movement,x
    AND #%00000111
    STA temp3
	TAY
    LDA DirectionMovementTable,y
    ORA temp3
	STA temp3
	;; get offset
    LDA Object_x_hi,x
    STA temp1
    LDA Object_y_hi,x
    STA temp2

   CreateObject temp1, temp2, #$0A, #$00, currentNametable
	
	LDA temp3
    STA Object_movement,x
	LDX tempx
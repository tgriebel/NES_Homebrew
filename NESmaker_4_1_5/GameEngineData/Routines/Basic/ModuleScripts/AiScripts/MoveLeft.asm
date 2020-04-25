
	LDA #%000000110
	STA Object_movement,x
	TAY
    LDA DirectionMovementTable,y
    STA temp
    TYA ;; the 0-7 value for direction
    ORA temp
    STA Object_movement,x
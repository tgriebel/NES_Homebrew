;;;; Choose out of 4 directions, UDLR.
    JSR GetRandomDirection
	AND #%00000110
    TAY
    LDA DirectionMovementTable,y
    STA temp
    TYA ;; the 0-7 value for direction
    ORA temp
    STA Object_movement,x
;;;; Choose out of 2 directions.
   JSR GetRandomDirection
	AND #%00000110

	JSR GetRandomNumber
	AND #%00000001
	BEQ isEvenNumberFor2WayDirection
;	;; is odd number for 2 way direction
	LDA #%00000010 ;; right
	JMP got2DirectionMovement
isEvenNumberFor2WayDirection:
	LDA #%00000110 ;;left
got2DirectionMovement:
	
    TAY
    LDA DirectionMovementTable,y
    STA temp
    TYA ;; the 0-7 value for direction
    ORA temp
    STA Object_movement,x
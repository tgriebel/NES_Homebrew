;;;; Choose out of 2 directions.

	JSR GetRandomNumber
	AND #%00000001
	BEQ isEvenNumberFor2WayDirectionB
	;; is odd number for 2 way direction
	LDA #%00000000 ;; down
	JMP got2DirectionMovementB
isEvenNumberFor2WayDirectionB:
	LDA #%00000100 ;;up
got2DirectionMovementB:
	
    TAY
    LDA DirectionMovementTable,y
    STA temp
    TYA ;; the 0-7 value for direction
    ORA temp
    STA Object_movement,x
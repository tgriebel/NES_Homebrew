;; stop moving
	LDA Object_movement,x
	AND #%00000111
	STA Object_movement,x
populateObjectBytes:

	LDY Object_type,x
	;; now y will be the thing that determines what values are pushed to the bytes for the object in X
	
	LDA ObjectSize,y
	AND #%00000111
	STA Object_height,x
	LDA ObjectSize,y
	LSR
	LSR
	LSR
	AND #%00000111
	STA Object_width,x
	
	RTS
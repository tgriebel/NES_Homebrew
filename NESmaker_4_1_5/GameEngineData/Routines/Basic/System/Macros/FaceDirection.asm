MACRO FaceDirection arg0, arg1
	; This changes the facing-direction of the object
	; defiend by arg0. 
	
	; arg0 - object to change
	; arg1 - dirction to face
	; constant definitions for facing directions are:
	;FACE_DOWN      = #%00000000
	;FACE_DOWN_RIGHT = #%00000001
	;FACE_RIGHT		= #%00000010
	;FACE_UP_RIGHT	= #%00000011
	;FACE_UP		= #%00000100
	;FACE_UP_LEFT	= #%00000101
	;FACE_LEFT		= #%00000110
	;FACE_DOWN_LEFT	= #%00000111
	LDX arg0
	LDA Object_movement,x
	AND #%11111000
	ORA #arg1
	STA Object_movement,x
	ENDM	

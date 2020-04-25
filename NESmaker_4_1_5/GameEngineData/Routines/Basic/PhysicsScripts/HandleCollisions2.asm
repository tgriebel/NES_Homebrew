
HandleNormalCollisions:
	JSR Get4CollisionPoints
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;all four collision points are loaded with collision data.
	;; might only need to check points in terms of direction moving?
	;; for now, load simple four point check.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;Since diagonal movement is its own case for tile ejection
	;;first, we need to check if movement is both h and v.

	
	LDA ObjectMovementByte,x
	AND #%10000000
	BEQ dontCheckHcol
	;;is moving horizontally
	LDA ObjectMovementByte,x
	AND #%01000000
	BEQ checkLeftCol
	;; check right collisions
	LDA collisionPoint2 
	ORA collisionPoint3
	AND #%10000000
	BEQ dontCheckHcol ;;;;; there is no solid collision to the right
	;;;;;There IS a solid collision to the right
	JSR stopMovingRight

	JMP checkVerticalCollisions
	
checkLeftCol:
	LDA collisionPoint1
	ORA collisionPoint4
	AND #%10000000
	BEQ dontCheckHcol ;;;;; there is no solid collision to the left
	;;;;;There IS a solid collision to the left
	JSR stopMovingLeft

	
dontCheckHcol:

checkVerticalCollisions:

	LDA ObjectMovementByte,x
	AND #%00100000
	BEQ doneCheckingCollisions
	;;is moving vertically
	LDA ObjectMovementByte,x
	AND #%00010000
	BEQ checkUpCol
	;; check bottom collisions
	LDA collisionPoint3
	ORA collisionPoint4
	AND #%10000000
	BEQ doneCheckingCollisions ;;;;; there is no solid collision to the bottom
	;;;;;There IS a solid collision to the bottom
	JSR StopMovingV
	
	JMP doneCheckingCollisions
	
checkUpCol:
	LDA collisionPoint1
	ORA collisionPoint2
	AND #%10000000
	BEQ doneCheckingCollisions ;;;;; there is no solid collision to the top
	;;;;;There IS a solid collision to the top
	JSR StopMovingV
	JMP doneCheckingCollisions
dontCheckVcol:

doneCheckingCollisions:

RTS





	
Get4CollisionPoints:

	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	CLC
	ADC ObjectHSpeedHi,x
	STA tileX
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	CLC
	ADC ObjectVSpeedHi,x
	STA tileY
	JSR GetTileType	
	STA collisionPoint1
	
	LDA tileX
	CLC
	ADC ObjectWidth,x

	STA tileX
	JSR GetTileType
	STA collisionPoint2
	
	LDA tileY
	CLC
	ADC ObjectHeight,x
	
	STA tileY
	JSR GetTileType
	STA collisionPoint3
	
	LDA tileX
	SEC
	SBC ObjectWidth,x
	STA tileX
	JSR GetTileType
	STA collisionPoint4
	RTS


	

StopMovingH:
	LDA ObjectMovementByte,x
	AND #%00111111
	STA ObjectMovementByte,x
	LDA #$00
	STA ObjectHSpeedHi,x
	STA ObjectHSpeedLo,x
	RTS
	
StopMovingV:
	LDA ObjectMovementByte,x
	AND #%11001111
	STA ObjectMovementByte,x
	LDA #$00
	STA ObjectVSpeedHi,x
	STA ObjectVSpeedLo,x
	RTS
	
	
	
	
stopMovingRight:
	LDA ObjectXhi,x
	AND #%11110000
	CLC 
	ADC ObjectBboxLeft,x
	SEC
	SBC #$01
	STA ObjectXhi,x
	
	JSR StopMovingH
	RTS
	
stopMovingLeft:
	
	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	AND #%11110000
	sec 
	sbc ObjectBboxLeft,x
	clc
	adc #$01
	STA ObjectXhi,x
	JSR StopMovingH
	RTS
	
	
stopMovingDown:
	
	LDA ObjectYhi,x
	AND #%11110000
	CLC 
	ADC ObjectBboxTop,x
	SEC
	SBC #$01
	STA ObjectYhi,x
	JSR StopMovingV
	RTS

stopMovingUp:
	
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	AND #%11110000
	sec 
	sbc ObjectBboxTop,x
	clc
	adc #$01
	STA ObjectYhi,x
	JSR StopMovingV
	RTS

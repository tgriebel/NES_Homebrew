
HandleNormalCollisions:
	LDA ObjectMovementByte,x
	AND #%10000000
	BEQ skipHorizontalCollisionCheck
	;;is moving horizontally
	LDA ObjectMovementByte,x
	AND #%01000000
	BEQ isMovingLeft
	;;; is moving right
	JSR GetRightCollisionPoints
	JMP checkVerticalCollisions
isMovingLeft:
	JSR GetLeftCollisionPoints
	
	
skipHorizontalCollisionCheck:
checkVerticalCollisions:
	LDA ObjectMovementByte,x
	AND #%00100000
	BEQ skipVerticalCollisionCheck
	;; is moving vertically
	LDA ObjectMovementByte,x
	AND #%00010000
	BEQ isMovingUp
	;; is moving down
	JSR GetBottomCollisionPoints
	JMP skipVerticalCollisionCheck
isMovingUp:
	JSR GetTopCollisionPoints
skipVerticalCollisionCheck:
	RTS

GetLeftCollisionPoints:
	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	CLC
	ADC ObjectHSpeedHi,x
	STA tileX
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	STA tileY
	JSR GetTileType
	STA collisionPoint1
	LDA tileY
	clc
	adc ObjectHeight,x
	SEC
	SBC #$01
	STA tileY
	JSR GetTileType
	STA collisionPoint2
	ORA collisionPoint1
	AND #%10000000
	BEQ noLeftCollision
	JSR stopMovingLeft
noLeftCollision:
	RTS 

GetTopCollisionPoints:
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	CLC
	ADC ObjectVSpeedHi,x
	STA tileY
	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	STA tileX
	JSR GetTileType
	STA collisionPoint1
	LDA tileX
	clc
	adc ObjectWidth,x
	STA tileX
	JSR GetTileType
	STA collisionPoint2
	ORA collisionPoint1
	AND #%10000000
	BEQ noTopCollision
	JSR stopMovingUp
noTopCollision:
	RTS 	
	
GetRightCollisionPoints:
	;;; rather than 4 points that represent the four corners, we
	;;; simply have four bytes that can be used in any order to determine 
	;;; collision data. 
	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	CLC
	ADC ObjectWidth,x
	CLC
	ADC ObjectHSpeedHi,x
	STA tileX
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	STA tileY
	JSR GetTileType
	STA collisionPoint1
	LDA tileY
	CLC
	ADC ObjectHeight,x
	SEC
	SBC #$01
	STA tileY
	JSR GetTileType
	STA collisionPoint2
	ORA collisionPoint1
	AND #%10000000
	BEQ noRightCollision
	JSR stopMovingRight
noRightCollision:
	RTS
	
	
GetBottomCollisionPoints:
	;;; rather than 4 points that represent the four corners, we
	;;; simply have four bytes that can be used in any order to determine 
	;;; collision data. 
	LDA ObjectYhi,x
	CLC
	ADC ObjectBboxTop,x
	CLC
	ADC ObjectHeight,x
	CLC
	ADC ObjectVSpeedHi,x
	STA tileY
	LDA ObjectXhi,x
	CLC
	ADC ObjectBboxLeft,x
	STA tileX
	JSR GetTileType
	STA collisionPoint1
	LDA tileX
	CLC
	ADC ObjectWidth,x
	STA tileX
	JSR GetTileType
	STA collisionPoint2
	ORA collisionPoint1
	AND #%10000000
	BEQ noBottomCollision
	JSR stopMovingDown
noBottomCollision:
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
	CLC
	ADC ObjectBboxTop,x
	CLC
	ADC ObjectHeight,x
	CLC
	ADC ObjectVSpeedHi,x
	
	AND #%11110000
	
	SEC 
	SBC ObjectBboxTop,x
	SEC
	SBC ObjectHeight,x
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

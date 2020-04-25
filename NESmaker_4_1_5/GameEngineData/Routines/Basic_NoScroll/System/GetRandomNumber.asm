GetRandomNumber:
	LDA randomSeed1
	ASL A
	ASL A
	CLC
	ADC temp2
	SEC
	SBC tempx
	ADC #$11
	SBC gamepad
	ADC #$36
	ADC tileY
	SBC temp16
	STA randomSeed1
	ADC #$03
	SBC vBlankTimer
	RTS
	
	
GetRandomDirection:
	JSR GetRandomNumber
	AND #%00000111
	;STA ObjectDirection,x
	RTS
	
ReverseDirection:
	;LDA ObjectDirection,x
	CLC
	ADC #$04
	AND #%00000111
	;STA ObjectDirection,x
	RTS
	
	
OppositeDirection:
	CLC
	ADC #$02
	STA temp
	JSR GetRandomNumber
	AND #%00000001
	CLC
	ADC temp
	STA temp
	JSR GetRandomNumber
	AND #%00000001
	CLC
	ADC temp
	STA temp
	JSR GetRandomNumber
	AND #%00000001
	CLC
	ADC temp
	AND #%00000111
	RTS
	
	
TurnDirection
	LDA Object_movement,x
	AND #%00000110
	CLC
	ADC #$02
	AND #%00000110
	STA temp
	TAY
	LDA DirectionMovementTable,y
	ORA temp
	STA Object_movement,x

	
	LDA #$00
	STA xHold_lo
	STA yHold_lo
	
	
	;LDA Object_animation_offset_speed,x
	;JSR getAnimSpeed
	
	;LDA #$10
	;STA Object_action_timer,x ;; arbitrary 
	
	LDA #$00
	STA Object_animation_frame,x
	RTS	
	


HandleRandomizing:
		;;just handle distoring the random value
	LDA randomSeed1
	ADC $0201 ;; add whatever graphic is in first sprite
	ASL
	SBC vBlankTimer
	ADC gamepad
	STA randomSeed1
	
	LDA randomSeed2
	ADC temp16
	ROL temp
	SBC gamepad
	STA randomSeed2
	RTS
	
	

	
FindFreePosition:
	TYA
	STA tempy
	LDA currentBank
	STA tempBank
	LDY #$1C ;; lut bank
	jSR bankswitchY
	LDy ObjectToLoad


	
FindFreePositionMainLoop:
		JSR GetSpawnBoxX
		JSR findFreePosLoopX
		
	LDA temp	
	STA tileX
	
	

		JSR GetSpawnBoxY
		JSR findFreePosLoopY
	LDA temp
	STA tileY
	
	LDA tileX
	STA spawnX
	LDA tileY
	STA spawnY
	;; check this position for solid.
	;; ObjectToLoad contains type.
	;; go to lut table bank for widths

	
	LDA tileX
	CLC
	ADC ObjectBboxLeft,y
	STA tileX
	LDA tileY
	CLC
	ADC ObjectBboxTop,y
	STA tileY
	JSR GetTileAtPosition
	LDA collisionTable,y
	BEQ TopLeftCollisionFree
	JMP FindFreePositionMainLoop
TopLeftCollisionFree:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA tileX
	CLC
	ADC ObjectWidth,y
	STA tileX
	JSR GetTileAtPosition
	LDA collisionTable,y
	BEQ TopRightCollisionFree
	JMP FindFreePositionMainLoop
TopRightCollisionFree:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA tileY
	CLC
	ADC ObjectHeight,y
	STA tileY
	JSR GetTileAtPosition
	LDA collisionTable,y
	BEQ BottomRightCollisionFree
	JMP FindFreePositionMainLoop
BottomRightCollisionFree:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA tileX
	SEC
	SBC ObjectWidth,y
	STA tileX
	JSR GetTileAtPosition
	LDA collisionTable,y
	BEQ BottomLeftCollisionFree
	JMP FindFreePositionMainLoop
BottomLeftCollisionFree:
;;;;;;;;;;;;;NO COLLISION ISSUES
	LDY tempBank
	JSR bankswitchY
	
	LDY tempy
	LDA spawnX
	STA tileX
	LDA spawnY
	STA tileY
	
	RTS
	
FindFreeEdge:
	TYA
	STA tempy
	
	LDA currentBank
	STA prevBank
	LDY #$1C
	JSR bankswitchY
FindFreeEdgeMainLoop:
	
	JSR GetRandomNumber
	AND #%00000011 ;; get a random value between 0-3
	;; this will determine the "side"; bottom, right, top, left.
	BNE notDownForEdgeSpawn
	;; was zero, so is down for edge spawn
	LDA #BOUNDS_BOTTOM
	;; subtract height
	SEC
	SBC #$10
	AND #%11110000
	STA tileY
	STA spawnY
	JSR GetSpawnBoxX
	JSR findFreePosLoopX
	LDy ObjectToLoad

	STA tileX
	STA spawnX
		CLC
		ADC ObjectBboxLeft,y
		STA tileX	
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopLeftCollisionFree_edge2
		JMP FindFreeEdgeMainLoop
	TopLeftCollisionFree_edge2:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA tileX
		CLC
		ADC ObjectWidth,y
		STA tileX
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopRightCollisionFree_edge2
		JMP FindFreeEdgeMainLoop
	TopRightCollisionFree_edge2:
		JMP doneWithEdgeSpawn
notDownForEdgeSpawn:
	CMP #$01
	BNE notRightForEdgeSpawn
	;; is right for edge spawn
	LDA #BOUNDS_RIGHT
	;SEC
	;SBC #$08 ;; width
	
	;; add height
	AND #%11110000
	STA tileX
	STA spawnX
	JSR GetSpawnBoxY
	JSR findFreePosLoopY
	LDy ObjectToLoad

	STA spawnY
		CLC
		ADC ObjectBboxTop,y
		STA tileY	
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopLeftCollisionFree_edge4
		JMP FindFreeEdgeMainLoop
	TopLeftCollisionFree_edge4:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA tileY
		CLC
		ADC ObjectHeight,y
		STA tileY
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopRightCollisionFree_edge4
		JMP FindFreeEdgeMainLoop
	TopRightCollisionFree_edge4:
	JMP doneWithEdgeSpawn
notRightForEdgeSpawn:
	CMP #$02
	BNE notUpForEdgeSpawn
	;; is up for edge spawn
	LDA #BOUNDS_TOP
	;; add height
	AND #%11110000
	STA tileY
	STA spawnY
	JSR GetSpawnBoxX
	JSR findFreePosLoopX
	LDy ObjectToLoad

	STA spawnX
		CLC
		ADC ObjectBboxLeft,y
		STA tileX	
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopLeftCollisionFree_edge3
		JMP FindFreeEdgeMainLoop
	TopLeftCollisionFree_edge3:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA tileX
		CLC
		ADC ObjectWidth,y
		STA tileX
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopRightCollisionFree_edge3
		JMP FindFreeEdgeMainLoop
	TopRightCollisionFree_edge3:
		JMP doneWithEdgeSpawn


notUpForEdgeSpawn:
	;;; must be left for edge spawn
	LDA #BOUNDS_LEFT
	;SEC
	;SBC #$10 ;; width
	
	;; add height
	AND #%11110000
	STA tileX
	STA spawnX
	JSR GetSpawnBoxY
	JSR findFreePosLoopY
	LDy ObjectToLoad

	STA spawnY
	
		CLC
		ADC ObjectBboxTop,y
		STA tileX	
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopLeftCollisionFree_edge6
		JMP FindFreeEdgeMainLoop
	TopLeftCollisionFree_edge6:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA tileY
		CLC
		ADC ObjectHeight,y
		STA tileY
		JSR GetTileAtPosition
		LDA collisionTable,y
		BEQ TopRightCollisionFree_edge6
		JMP FindFreeEdgeMainLoop
	TopRightCollisionFree_edge6:
	;JMP doneWithEdgeSpawn
	
doneWithEdgeSpawn:
	LDY prevBank
	JSR bankswitchY
	LDY tempy
	LDA spawnX
	
	STA tileX
	LDA spawnY
	STA tileY
	
	RTS
	
	
	
findFreePosLoopX:
		JSR GetRandomNumber
		AND #%11110000 ;; get the high 16 bits of random number.
		;;; is it left of the bounds?
		STA temp
		CMP temp1
		BCC findFreePosLoopX
	;;; it is NOT left of bounds.  Is it right of the bounds?
		;; also, subtract width?
		LDA temp
		CMP temp2
		BCS findFreePosLoopX
		RTS	
findFreePosLoopY:
	JSR GetRandomNumber
	AND #%11110000
		STA temp
	;; it is not right of the bounds.  Is it above the bounds?
		CMP temp1
		BCC findFreePosLoopY
	;; it is not above the bounds.  Is it below the bounds?
		;; also subtract height?
		LDA temp
		CMP temp2
		BCS findFreePosLoopY
		RTS
	
PickRandomMonster:
	TYA 
	STA tempy
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	FindRandomMonsterLoop:
		JSR GetRandomNumber
		AND #%00000011
		STA temp
		;; temp now holds a number, 0-3.
		;; now we check if that monster is allowed.  If so, go forward.  If not, loop.
		TAY
		LDA CurrentMonsterSpawnData
		AND #%00001111
		AND ValMonsterCompare,y
		BEQ FindRandomMonsterLoop	
		LDA monsterGroup
		ASL
		ASL
		CLC
		ADC temp
		TAY
		LDA MonsterGroups,y
		CLC
		ADC #$10 ;; monster type
		STA ObjectToLoad
	LDY prevBank
	JSR bankswitchY
	LDY tempy
	RTS


	
GetSpawnBoxX:
		LDA #BOX_2_ORIGIN_X
		ASL
		ASL
		ASL
		ASL
		STA temp1
		LDA #BOX_2_WIDTH
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC temp1
		STA temp2
	RTS
GetSpawnBoxY:
	LDA #BOX_2_ORIGIN_Y
		ASL
		ASL
		ASL
		ASL
		STA temp1
		LDA #BOX_2_HEIGHT
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC temp1
		STA temp2
		RTS
		
		
HandleDrops:
	.include SCR_HANDLE_DROPS
	RTS
	
	
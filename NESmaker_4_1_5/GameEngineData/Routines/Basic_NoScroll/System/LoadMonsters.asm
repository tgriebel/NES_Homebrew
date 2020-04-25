ResetMonsters:
	LDA currentBank
	STA prevBank
	LDY #BANK_ANIMS
	JSR bankswitchY
	
	LDX #$00
LoopToResetMonsters:
	LDA Object_type,x
	TAY
	LDA ObjectFlags,y ;;
	;;;;; THE REASON WE CAN'T JUST USE Object_flags,x here
	;;;;; is because this will happen on the screen load, before the
	;;;; player object is assigned his Object_flags. This means that on screen 1,
	;;;; he'll get deactivated because this will still read 0.

	AND #%00000001 ;; is it a persistent object?
	BNE objectIsPresistent
	;;; also check for any othyer object types
	;; that you don't want to reset. 
	DeactivateCurrentObject
objectIsPresistent:
	INX
	CPX #TOTAL_MAX_OBJECTS
	BNE LoopToResetMonsters
doneWithResetMonsters:
;;; that's a bit of a misnomer.  That actually reset OBJECTS.  This will reset monsters.
	RTS
	
	
LoadMonsters:
	

	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY

	;;; get monster positions:
	
	LDY #$00
	LDA #$10
	STA temp2

LoadMonsterLoop:

	LDA mon1SpawnData,y 
	
	CMP #$0f
	BNE continueMonsterLoad
	
	JMP dontLoadMon
continueMonsterLoad:
	LDA mon1SpawnData,y 
	
	BNE DoLoadMon 
	JMP dontLoadMon
DoLoadMon:
	STA CurrentMonsterSpawnData
	AND #%11110000
	;;;; if this is 11110000, it means that this monster should spawn randomly.
	CMP #%00010000
	BNE notEdgeSpawner
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateEdgeSpawnedMonster:

	;;; THIS IS AN EDGE SPAWNER
	;JSR PickRandomMonster
	;JSR FindFreeEdge
;JMP CreateTheMonster
	;;;; GENERALLY these monsters are created at the edges after timers go off, not at screen load.
	;; you can use JSR CreateTimedEdgeSpawner to do this all in real time.
	;JSR ReserveObjectSlot
	inc edgeLoaderInCue
	
	JMP dontLoadMon
notEdgeSpawner:
	LDA CurrentMonsterSpawnData
	AND #%11110000
	CMP #%11110000
	BNE DoPlannedMonster
DoRandomMonster:
	;; first, find out which monsters to load, if it is random.
	JSR PickRandomMonster

	;;; pick a random position for this monster.
	;; first, make sure the prospective monster's position is inside the bounds.
		;;get a random position, set it to tileY
		;; get a random position, set it to tileX
		;;; so this would be:
				;; get a number 
	JSR FindFreePosition			
	
	;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;
	JMP CreateTheMonster

DoPlannedMonster:
plannedIndexForThisMonster:	
	LDa objectID,y
	STA ObjectToLoad

	
	
plannedPositioningForThisMonster:	
	LDA mon1SpawnData,y
	AND #%11110000
	STA tileY
	LDA mon1SpawnData,y
	ASL
	ASL
	ASL
	ASL
	STA tileX

CreateTheMonster:
	
	TXA 
	STA temp3
	
	LDX player1_object


	CreateObject tileX,tileY,ObjectToLoad,#$00, currentNametable

	TYA
	STA Object_ID,x
	
dontLoadMon:
	
	INY 
	CPY #$04
	BEQ doneWithMonsterLoop 
	JMP LoadMonsterLoop
doneWithMonsterLoop:
	LDY prevBank
	JSR bankswitchY
	RTS
	
ReserveObjectSlot:
	JSR FindEmptyObjectSlot
	CPX #$FF
	BEQ noFreeSlotsForNewObject_reserved
	LDA #OBJECT_RESERVE
	STA Object_status,x
noFreeSlotsForNewObject_reserved:
	RTS
	
CreateTimedEdgeSpawner:

	JSR PickRandomMonster
	JSR FindFreeEdge
	CreateObject tileX,tileY,ObjectToLoad,#$00, currentNametable
	RTS
	
	
LoadMonsterScrolledScreen
	;; in a scrolling engine, it's possible that we
	;; come up between screens.
	;; this CAN result in there being
	;;;


	RTS
	
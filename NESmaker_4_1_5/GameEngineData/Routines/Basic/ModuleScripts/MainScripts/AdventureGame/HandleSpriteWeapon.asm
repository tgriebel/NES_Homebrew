	GetCurrentActionType player1_object
	CMP #$02 ;; attack state
	BEQ checkSpriteWeapon
	JMP skipSpriteWeaponCheck
checkSpriteWeapon:

	;;;;;;;;;;;;;;;;;;;;;;;;;
	;;here it did equal the melee attack pose.
	LDX player1_object
	LDA Object_movement,x
	AND #%00000111
	TAY ;; direction for offset table index
	LDA Object_x_hi,x
    ;;; offset x for creation
    CLC
    ADC weaponOffsetTableX,y
	STA selfRight
	SEC 
    SBC #$08 ;; width of weapon 
	STA selfLeft
	
	LDA Object_y_hi,x
    ;;; offset x for creation
    CLC
    ADC weaponOffsetTableY,y
	STA selfBottom
	SEC 
    SBC #$08 ;; width of weapon 
	STA selfTop
	;; run through objects.
	
	LDX #$00	
DoMonsterWeaponSpriteLoop:
	LDA Object_flags,x
	AND #%00001000
	BNE +
	JMP ++
+
	JSR GetOtherCollisionBox
	LDA selfRight
	CMP otherLeft
	BCS + ;; no player object collision
	JMP ++
+
	LDA otherRight
	CMP selfLeft
	BCS +
	JMP ++
+
	
	LDA otherBottom
	CMP selfTop
	BCS +
	JMP ++
+
	LDA selfBottom
	CMP otherTop
	BCS +
	JMP ++
+
	LDA Object_x_hi,x
	STA temp
	LDA Object_y_hi,x
	STA temp1
	DeactivateCurrentObject
	CreateObject temp, temp1, #OBJ_MONSTER_DEATH, #$00, currentNametable
    PlaySound #SND_SPLAT

	TXA
	STA tempx
	AddValue #$08, myScore, #$01, #$00

		; LDA DrawHudBytes
		; ora #HUD_myScore
		; STA DrawHudBytes
	UpdateHud HUD_myScore
	LDX tempx
++
	INX 
	CPX #TOTAL_MAX_OBJECTS
	BEQ skipSpriteWeaponCheck ;; done with checking against objects 
	JMP DoMonsterWeaponSpriteLoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
skipSpriteWeaponCheck ;; there is no collision here horizontally.

	
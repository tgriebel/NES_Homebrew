.include "GameData\DataBank01_Includes.asm"
.include SCR_EXTRA_CONTROLLER
.include "GameData\TileTypes.asm"

	
.include "ScreenData\SpecialTiles.dat"

.include ROOT\System\HandleStateChanges.asm

.include SCR_HANDLE_CAMERA

.include SCR_HANDLE_OBJECT_COL

HandleLoadHud:
	.include SCR_HANDLE_HUD ;
	RTS

doPreDraw:
	.include SCR_SPRITE_PREDRAW
	RTS

doRightBounds_player:
	.include SCR_RIGHT_BOUNDS
	RTS
	
doLeftBounds_player:
	.include SCR_LEFT_BOUNDS
	RTS
	
doTopBounds_player:
	.include SCR_TOP_BOUNDS
	RTS
	
doBottomBounds_player:
	.include SCR_BOTTOM_BOUNDS
	RTS
	
HandleNoMorePrizeTiles:
	.include SCR_HANDLE_NO_MORE_PRIZE_TILES
	RTS
	


UnderTilesLookup:
	.db #$00, #$18, #$30

LoadUnderTiles:
	LDA graphicsBank
	SEC
	SBC #$10
	TAY
	LDA UnderTilesLookup,y
	STA temp
	LDA backgroundTilesToLoad
	ASL
	ASL
	CLC
	ADC temp
	;;;; now have the tileset+bank offset
		
	TAY
	LDA Special_Tiles,y
	STA underSlash
	INY
	LDA Special_Tiles,y
	STA underStomp
	INY
	LDA Special_Tiles,y
	STA underSecret
	INY
	LDA Special_Tiles,y
	STA underBoss
	RTS

CheckForTriggers:
	.include SCR_CHECK_FOR_TRIGGERS
	RTS
	
CheckForMonsters:
	.include SCR_CHECK_FOR_MONSTER_LOCKS
	RTS

HandlePickupPowerup:
;;; other is loaded into x
;;; index of other for table reads loade into y
	LDA Object_type,x 
	CMP #$04
	BEQ +
	JMP not4typePowerup
+
	;; is 4 type powerup
	.include Power_Up_00
	JMP doneWithPowerups
not4typePowerup:
	CMP #$05
	BEQ + 
	JMP not5typePowerup
+
	;; is 5 type powerup
	.include Power_Up_01
	JMP doneWithPowerups
not5typePowerup:
	CMP #$06
	BEQ +
	JMP not6typePowerup
	;; is 6 type powerup
+
	.include Power_Up_02
	JMP doneWithPowerups
not6typePowerup:
	CMP #$07
	BEQ +
	JMP not7typePowerup
+
	;; is 7 type powerup
	.include Power_Up_03
	JMP doneWithPowerups
not7typePowerup:
doneWithPowerups:
	RTS

AI_ActionTable_Lo:
	.db <AI_Action_00, <AI_Action_01, <AI_Action_02, <AI_Action_03
	.db <AI_Action_04, <AI_Action_05, <AI_Action_06, <AI_Action_07
	.db <AI_Action_08, <AI_Action_09, <AI_Action_10, <AI_Action_11
	.db <AI_Action_12, <AI_Action_13, <AI_Action_14, <AI_Action_15
	
AI_ActionTable_Hi:
	.db >AI_Action_00, >AI_Action_01, >AI_Action_02, >AI_Action_03
	.db >AI_Action_04, >AI_Action_05, >AI_Action_06, >AI_Action_07
	.db >AI_Action_08, >AI_Action_09, >AI_Action_10, >AI_Action_11
	.db >AI_Action_12, >AI_Action_13, >AI_Action_14, >AI_Action_15



AI_Action_00
	.include ROOT\System\AI_ActionRoutines\AI_Action_00.asm
	RTS
AI_Action_01:
.include ROOT\System\AI_ActionRoutines\AI_Action_01.asm
	RTS
AI_Action_02
	.include ROOT\System\AI_ActionRoutines\AI_Action_02.asm
	RTS
AI_Action_03:
	.include ROOT\System\AI_ActionRoutines\AI_Action_03.asm
	RTS
AI_Action_04:	
	.include ROOT\System\AI_ActionRoutines\AI_Action_04.asm
	RTS
AI_Action_05
	.include ROOT\System\AI_ActionRoutines\AI_Action_05.asm
	RTS
AI_Action_06
	.include ROOT\System\AI_ActionRoutines\AI_Action_06.asm
	RTS
AI_Action_07
	.include ROOT\System\AI_ActionRoutines\AI_Action_07.asm
	RTS
AI_Action_08
	.include ROOT\System\AI_ActionRoutines\AI_Action_08.asm
	RTS
AI_Action_09
	.include ROOT\System\AI_ActionRoutines\AI_Action_09.asm
	RTS
AI_Action_10
	.include ROOT\System\AI_ActionRoutines\AI_Action_10.asm
	RTS
AI_Action_11
	.include ROOT\System\AI_ActionRoutines\AI_Action_11.asm
	RTS
AI_Action_12
	.include ROOT\System\AI_ActionRoutines\AI_Action_12.asm
	RTS
AI_Action_13
	.include ROOT\System\AI_ActionRoutines\AI_Action_13.asm
	RTS
AI_Action_14
	.include ROOT\System\AI_ActionRoutines\AI_Action_14.asm
	RTS
AI_Action_15
	.include ROOT\System\AI_ActionRoutines\AI_Action_15.asm
	RTS
	
	
	
AI_ReactionTable_Lo:
	.db #<Reaction_00, #<Reaction_01, #<Reaction_02, #<Reaction_03
	.db #<Reaction_04, #<Reaction_05, #<Reaction_06, #<Reaction_07
	
AI_ReactionTable_Hi:
	.db #>Reaction_00, #>Reaction_01, #>Reaction_02, #>Reaction_03
	.db #>Reaction_04, #>Reaction_05, #>Reaction_06, #>Reaction_07
	
Reaction_00:
	.include ROOT\System\AI_Reactions\Reaction_00.asm
	RTS
Reaction_01:
	.include ROOT\System\AI_Reactions\Reaction_01.asm
	RTS
Reaction_02:
	.include ROOT\System\AI_Reactions\Reaction_02.asm
	RTS
Reaction_03:
	.include ROOT\System\AI_Reactions\Reaction_03.asm
	RTS
Reaction_04:
	.include ROOT\System\AI_Reactions\Reaction_04.asm
	RTS
Reaction_05:
	.include ROOT\System\AI_Reactions\Reaction_05.asm
	RTS
Reaction_06:
	.include ROOT\System\AI_Reactions\Reaction_06.asm
	RTS
Reaction_07:
	.include ROOT\System\AI_Reactions\Reaction_07.asm
	RTS
	
	
	
	.include SCR_PHYSICS
	.include SCR_TILE_COLLISION
	.include ROOT\System\HUD_Tables.asm

	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
handleAutoScroll:
	LDA screenFlags
	AND #%00000100
	BNE doAutoScroll
	RTS
doAutoScroll:
	LDA screenFlags
	AND #%01000000 ;; checks to see if monster prevents scroll.
	BEQ doAutoScroll2
	RTS
doAutoScroll2:

	LDA screenFlags
	AND #%00010000
	BNE doAutoScrollRight
	LDA screenFlags
	AND #%00001000
	BNE doAutoScrollLeft 
	;;; here, auto scroll was engaged, but with no direction.
	RTS
doAutoScrollRight:
	LDA #$01
	STA scrollDirection
	
	LDA xScroll
	CLC
	ADC #SCROLL_SPEED
	STA xScroll
	LDA xScroll_hi
	ADC #$00
	STA xScroll_hi
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;	
	
	
	LDA Object_x_hi,x
	clc
	adc #SCROLL_SPEED
	STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	ADC #$00
	STA Object_scroll,x
	STA nt_hold
	RTS
doAutoScrollLeft::
	
	LDA #$00
	STA scrollDirection
	LDA xScroll
	sec
	sbc #SCROLL_SPEED
	STA xScroll
	LDA xScroll_hi
	SBC #$00
	STA xScroll_hi
	
	LDA Object_x_hi,x
	sec
	sbc #SCROLL_SPEED
	STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	sbc #$00
	STA Object_scroll,x
	STA nt_hold
notScrollingLeft:
	RTS
	
	
	
	.include ROOT\ModuleScripts\MainScripts\PlayerGuidedScrolling_forPhysics.asm
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
CheckAutoScrollLeftEdge:
	
	LDA screenFlags
	AND #%00010000
	BEQ skipRightScroll_pushingObjectsLeft
	
justPushObjectLeft:

	LDA Object_x_hi,x
	SEC
	SBC #SCROLL_SPEED
	STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	SBC #$00
	STA Object_scroll,x

	CPX player1_object
	BNE +
	LDA Object_x_hi,x
	CMP xScroll
	BNE +
	;;;; DEATH
	JSR HandlePlayerDeath
+
	JMP doneWithEdgePress
	
skipRightScroll_pushingObjectsLeft:

;;;====================================
;;Scrolling Left, check if squashed against right side of screen.
	
	CPX player1_object
	LDA xScroll
	SEC
	SBC Object_right,x
	CMP Object_x_hi,x
	BNE +
	JSR HandlePlayerDeath
	;JMP RESET
+

	LDA Object_x_hi,x
	clc
	adc #SCROLL_SPEED
	STA Object_x_hi,x
	STA xHold_hi
	LDA Object_scroll,x
	adc #$00
	STA Object_scroll,x
	

doneWithEdgePress:
	RTS
	
notPlayer1_forEdgeSquashTest:
	;DeactivateCurrentObject
	RTS
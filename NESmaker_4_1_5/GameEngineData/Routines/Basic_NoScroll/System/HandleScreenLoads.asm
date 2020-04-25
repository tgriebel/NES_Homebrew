HandleScreenLoads:
	LDA update_screen
	AND #%10000000 ;; are we cued to update screen?
	BNE screenIsCued 
	JMP noNewScreen
screenIsCued:
;;;;;;;;;;;;;;;;;;;
;;;; handle how NMI updates will be observed.
	LDA #$00
	STA soft2001	
	JSR WaitFrame
	LDA #$01
	STA canUpdateScreen
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; SET SCREENS RELATIVE TO THE SCREEN TO BE LOADED

	LDA newGameState
	STA gameSubState
	
	LDA loadObjectFlag
	BEQ +
	LDA #$00
	STA loadObjectFlag
	LDA playerToSpawn
	CreateObject newX, newY, playerToSpawn, #$00, currentNametable
	TXA
	STA player1_object
+



	
	LDA newScreen
	STA currentScreen
	STA currentNametable

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA update_screen
	AND #%00001111
	STA gameState
	;;; the high four bits for update screen activate screen updates.
	;;; the low four bits give 16 potential gameStates
	;;; This is loaded in whatever screen the player is moving from,
	;;; whether by a warp or screen edge or whatever.
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; GET THE SCREEN BANK FOR THE SCREEN TO BE LOADED.
	LDA #$00
	STA update_screen_hud_offset

	LDA update_screen_details
	BEQ + ; is special screen
	JMP notSpecialScreenLoad
+

	
	;;;;; THIS SCREEN IS A SPECIAL SCREEN
	;;;;; Special screens are stored in bank #$1E
	LDA #$1E
	STA screenBank
	LDA newScreen
	ASL
	STA temp
	
	LoadNametableFull screenBank, temp, #$10, #$0f, #$20, #$00
	LoadAttributeData screenBank, temp, #$0, #$00
	
	; arg0 - screen bank
	; arg1 - special screen number
	; arg2 - columns to load
	; arg3 - rows to load
	; arg4 - start position hi
	; arg5 - start position lo
	
	;; Need to load background graphics.
	;LDA #$00
	LDA newScreen
	STA backgroundTilesToLoad
;;;;;;;;;;;;;; GET INDEX FOR CHR DATA	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY backgroundTilesToLoad
	
	LDA #CHRAddressLo,y
	STA temp16
	LDA #CHRAddressHi,y
	STA temp16+1
	
	;LDA #<startScreenTiles
	;STA temp16
	;LDA #>startScreenTiles
	;STA temp16+1
	
	LoadChrData #BANK_STARTSCREEN_CHR, #$10, #$0, #$0
;	LoadNametableData #$1E, NT_StartScreen, #$00, #$00, #$00
	LDY prevBank
	JSR bankswitchY

	
	;;;;;;;;;;;;;; GET INDEX FOR PAL data
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY newScreen
	
	LDA #SpecialBackPalLo,y
	STA temp16
	LDA #SpecialBackPalHi,y
	STA temp16+1
	
	LDY prevBank
	JSR bankswitchY
	
	LoadBackgroundPalette ;BckPal00 ;; we need to get this from screen info
	
;	LoadNametableData #$1E, NT_StartScreen, #$00, #$00, #$00
	LDY prevBank
	JSR bankswitchY
	;;;; any other special screen considerations go here.
	JMP EndLoadScreen
notSpecialScreenLoad:
	GetScreenBank newScreen
	;;; The above gets the screen bank of the screen loaded in newScreen.
gotScreenBank:
	
	
	LDA #$01
	STA skipNMI
	
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2	
	BNE +
	LDA #$00
	STA currentMap
	JMP ++
+
	LDA #$01
	STA currentMap
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD SCREEN DATA:	
	
	LoadScreen screenBank, currentMap, newScreen, #SCREEN_DATA_OFFSET
	;;;; if newScreen, the screen that is being loaded
	;;;; is an odd screen, it should load the right nametable, collision and attribute table.
	;;;; otherwise it should load the left.
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD COLLISION TABLES:	
	
	;;; arg 5 is unused.
	LoadCollisionTable screenBank, currentMap, newScreen, #$10, #$0f, #$00, #$00, #$00
	;;; now, we will load the right collision table.
	
;;; COLLISION TABLE IS LOADED
	JSR WaitFrame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD NAMETABLES:	

	LoadNametableMeta screenBank, currentMap, newScreen, #$10, #$0f, #$20, #$00, #$00
	JSR WaitFrame
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD ATTRIBUTES:	
	;;;temp2 is still the bank for the right nametable, and temp3 for the left
	LoadAttributes screenBank, currentMap, newScreen, #$08, #$08, #$23, #$c0, #$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;END LOADING SCREENS.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;HANDLE SPECIAL TILE GRAPHICS.
	
;;;;;;;;;;;;;HANDLE MAIN GAMEPLAY TILE GRAPHICS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDX newPal
	LDA GameBckPalLo,x
	STA temp16
	LDA GameBckPalHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	LoadBackgroundPalette ;BckPal00 ;; we need to get this from screen info

	LDA graphicsBank
	STA update_screen_bck_graphics_bank
	JSR WaitFrame
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDX backgroundTilesToLoad   ;; we get background tiles to load from screen info. 
	LDA #BckCHRAddLo,x
	STA temp16
	LDA #BckCHRAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$10, #$00, #$60
	
	JSR WaitFrame
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDX screenSpecificTilesToLoad   ;; we get background tiles to load from screen info. 
	;LDX #$00
	LDA #BckSSChrAddLo,x
	STA temp16
	LDA #BckSSChrAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$16, #$00, #$20
	
	
	;;=====================NOW LOAD THE PATHS
	; path 0 gets loaded into row 18
	; path 1 gets laoded into row 19
	; path 2 gets loaded into row 1a
	; path 3 gets loaded into row 1b
	
	JSR WaitFrame
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDX pathTile00   ;; we get background tiles to load from screen info. 
	;LDX #$00
	LDA #PathCHRAddLo,x
	STA temp16
	LDA #PathCHRAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$18, #$00, #$10
	
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDX pathTile01   ;; we get background tiles to load from screen info. 
	;LDX #$00
	LDA #PathCHRAddLo,x
	STA temp16
	LDA #PathCHRAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$19, #$00, #$10
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDX pathTile02   ;; we get background tiles to load from screen info. 
	;LDX #$00
	LDA #PathCHRAddLo,x
	STA temp16
	LDA #PathCHRAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$1A, #$00, #$10
	
		LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDX pathTile03   ;; we get background tiles to load from screen info. 
	;LDX #$00
	LDA #PathCHRAddLo,x
	STA temp16
	LDA #PathCHRAddHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	;;; load graphics for new screen

	LoadChrData update_screen_bck_graphics_bank, #$1b, #$00, #$10
	
	;;=====================END LOAD PATHS 
	
	JSR WaitFrame
;;===============LOAD OBJECT GRAPHICS
;;=========================================
	LDA objGraphicsBank
	STA update_screen_bck_graphics_bank
;
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDX objectTilesToLoad   ;; we get background tiles to load from screen info. 
	LDA #MonsterAddressLo,x
	STA temp16
	LDA #MonsterAddressHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
;	
;;; load graphics for new screen
	

	LoadChrData update_screen_bck_graphics_bank, #$08, #$00, #$80

;;==================================================================
;;=================================================================
	
	;;; load palette for new screen
	JSR WaitFrame
	LoadSpritePalette newGO1Pal, newGO2Pal, newObj1Pal, newObj2Pal

	;;; load hud tiles?
	LDA #$02 
	STA backgroundTilesToLoad ;; yikes, we probably want to do something different here.
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDX backgroundTilesToLoad
	LDA #CHRAddressLo,x
	STA temp16
	LDA #CHRAddressHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	
	LoadChrData #$1d, #$1c, #$00, #$40
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; ALL GRAPHICS ARE LOADED.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; GET FLAGS FOR OBJECTS SO WE CAN COUNT UPON LOAD.
	LDA currentBank
	STA prevBank
	LDY #BANK_ANIMATIONS
	JSR bankswitchY
	LDX #$00
DoSetMonsterFlagsLoop:
	LDA Object_status,x
	AND #%01000000 ;; is it about ready to load, but not loaded yet?
	BEQ + ;skip setting flag.
	LDY Object_type,x
	LDA ObjectFlags,y
	STA Object_flags,x
+
	INX
	CPX #TOTAL_MAX_OBJECTS
	BNE DoSetMonsterFlagsLoop
	LDY prevBank
	JSR bankswitchY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; HANDLE LOADING HUD, IF ENABLED
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA #HIDE_HUD
	BEQ dontHideHud
	JMP skipDrawingHud_GameHandler
dontHideHud
	LDA HudHandler
	AND #%10000000
	BNE drawHud_GameHandler
	JMP skipDrawingHud_GameHandler
drawHud_GameHandler:
	LDA screenFlags
	AND #%00000001
	BEQ screenDrawsHud
	JMP skipDrawingHud_GameHandler
screenDrawsHud:
;; check to see if hud is shown.
	;; if hud is hidden, skip
	;; otherwise...
	;;; prep hud area load
	JSR WaitFrame
	LDA #BOX_0_WIDTH 
	STA updateNT_columns
	LDA #BOX_0_HEIGHT
	STA updateNT_rows
	LDA #BOX_0_ORIGIN_X
	STA tileX
	LDA #BOX_0_ORIGIN_Y
	STA tileY
	JSR FillBoxArea
	JSR WaitFrame
	;;;;;;;;;;;;;;;;
	;; set up attribute routine needs
	LDA #BOX_0_ORIGIN_X
	STA tileX
	LDA #BOX_0_ORIGIN_Y
	STA tileY 
	LDA #BOX_0_ATT_WIDTH
	STA updateNT_attWidth
	LDA #BOX_0_ATT_HEIGHT
	STA updateNT_attHeight
	;;;;;;;;;;;;;;;
	JSR UpdateAttributeTable
	;; first turn off drawing sprites.
	;JSR WaitFrame
	LDA #$00
	STA textboxHandler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA currentBank
	STA prevBank
	LDY #$14
	JSR bankswitchY

	;JSR HandleLoadHud
	LDA #HUD_LOAD

	STA DrawHudBytes
	JSR HandleHudData
	LDA #$00
	STA ActivateHudUpdate

	JSR CheckForTriggers
	JSR CheckForMonsters
	
	LDY prevBank
	JSR bankswitchY

	
;	.include ROOT\System\HandleScreenLoadHudDraw.asm
skipDrawingHud_GameHandler:
	;;====================================
	LDA navFlag
	AND #%00000010
	BEQ dontForceSong
	LDA navFlag
	AND #%11111101
	STA navFlag
	JMP +
dontForceSong:
	LDA songToPlay
	STA temp
	
	CMP currentSong ;; the song for this screen is same as last
	BEQ DoneWithThisScreenLoad
	; the song is different
+	
	PlaySong songToPlay
	LDA temp
	STA currentSong

DoneWithThisScreenLoad:	
	;LDA #$00
	;STA update_screen
	;;;
	;; if we are starting game
	;; we use the player position
	;; in the constants as the starting position.

	LDA screen_transition_type
	BNE notStartingGameTransitionType

	;; set newX and newY to the game start positions
	LDA #START_POSITION_PIX_X 
	STA newX
	LDA #START_POSITION_PIX_Y
	STA newY
	JMP doneWithScreenTransition
notStartingGameTransitionType:
	CMP #$01
	BNE notNormalScreenToScreenUpdate

	LDA screenFlags
	AND #%00100000 ;; does it use gravity?
	BNE keepVspeed
	LDX player1_object
	LDA #$00
	STA Object_v_speed_lo,x
	STA Object_v_speed_hi,x
keepVspeed:
	
	;; normal screen to screen update. 
	;; this just skips observing newX and newY load
	JMP doneWithScreenTransition
notNormalScreenToScreenUpdate:
	CMP #$02
	BNE notWarpTypeTransition
	LDX player1_object
	LDA newX
	STA xHold_hi
	STA Object_x_hi,x
	LDA newY
	STA yHold_hi
	STA Object_y_hi,x
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA xHold_lo
	STA yHold_lo
		JMP doneWithScreenTransition
notWarpTypeTransition:
	CMP #$03
	BNE notMapReturnTransition
	LDX player1_object
	LDA mapPosX
	STA xHold_hi
	STA Object_x_hi,x
	LDA mapPosY
	STA yHold_hi
	STA Object_y_hi,x
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA xHold_lo
	STA yHold_lo
		JMP doneWithScreenTransition
	
	
notMapReturnTransition:
	CMP #$04
	BNE notContinueScreen
	LDX player1_object
	LDA continuePositionX
	STA xHold_hi
	STA Object_x_hi,x
	LDA continuePositionY
	STA yHold_hi
	STA Object_y_hi,x
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA xHold_lo
	STA yHold_lo
	;;; any other thing that needs to happen on continuePositionX
	JMP doneWithScreenTransition
notContinueScreen:

doneWithScreenTransition:


EndLoadScreen:



	LDA #$00
	STA updateNT_fire_Att
	STA updateNT_fire_Att+1
	STA updateNT_fire_Att+2
	STA updateNT_fire_Att+3
	STA updateNT_fire_Att+4
	STA updateNT_fire_Att+5
	STA updateNT_fire_Att+6
	STA updateNT_fire_Att+7
	
	STA updateNT_att_fire_Address_lo
	STA updateNT_att_fire_Address_lo+1
	STA updateNT_att_fire_Address_lo+2
	STA updateNT_att_fire_Address_lo+3
	STA updateNT_att_fire_Address_lo+4
	STA updateNT_att_fire_Address_lo+5
	STA updateNT_att_fire_Address_lo+6
	STA updateNT_att_fire_Address_lo+7
	

	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA gameHandler
	ORA #%10000000
	STA gameHandler
	LDA #$00 
	STA update_screen
	STA canUpdateScreen
	LDA #%00011110
	STA soft2001
	
	

	
noNewScreen:	
	RTS	
	
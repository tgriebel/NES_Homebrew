




	LDA #$00
	STA soft2001
	JSR WaitFrame
	STA update_screen_details
	LDA #%10000000
	STA update_screen
	LDA #$00
	STA textboxHandler
	LDA #$00
	STA playerToSpawn
	;LDA #$00
	;STA updateTileTotal
	
	LDA #BOSSES_DEFEATED
	STA weaponsUnlocked
	
	LDA #$FF
	STA currentSong ;; to trigger the right song
	STA player1_weapon
	
	.include "GameData\InitializationScripts\hudVarInits.asm"
	LDA #$01
	STA scrollDirection
	
	;;; this will set the first column of the second nametable.
;	LDA #$00
;	STA columnToUpdate
	
	;LDA #$00
	;STA columnTracker
	;STA collisionColumnTracker
	
	;;; delete me

	;LDA #$00
	;STA testVar

	LDA #$0
	STA checkForSpriteZero
	

	LDA #$00
	STA gameTimerLo		
	STA gameTimerHi		
	LDA #DayNightSpeed ;; not working right now
	STA gameTimer 		
	
	
	
	LDA #%10000000
	STA HudHandler ; make bit 7 zero to hide hud
	
	;; THIS SECTION GETS HUD BITS
					;; get hud bits determines which hud elements to update.
					;; this is important, as if a hud element is inactive and a script tries to write to it,
					;; it will never finish the hud draws and will stop updating the hud until the next screen
					;; load resets it.
					
	LDy #$00
DoHudElementLoop:
	LDA HUD_Element_table,y	
	BNE +
	LDA HudChecker
	ORA ValToBitTable,y
	STA HudChecker
	JMP ++
+
	CMP #$03
	BNE +
	LDA HudChecker
	ORA ValToBitTable,y
	STA HudChecker
	JMP ++
+

++
	INY
	CPY #$08
	BNE DoHudElementLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	.include ROOT\InitializationScripts\LoadFromConstants.asm
	
	LDA #START_ON_SCREEN
	STA continueScreen
	STA currentNametable
	STA leftNametable
	CLC
	ADC #$01
	STA secondNametable
	STA rightNametable
	;SEC
	;SBC #$02
	;STA leftNametable
	
	LDA #START_POSITION_PIX_X
	STA continuePositionX
	LDA #START_POSITION_PIX_Y
	STA continuePositionY
	

	
	
	LDA #<playerCHR
	STA temp16
	LDA #>playerCHR
	STA temp16+1
	
	LoadChrData #BANK_PLAYER_CHR, #$0, #$0, #$80
	
	LDA #PAL_GO_1
	STA newGO1Pal
	LDA #PAL_GO_2 
	STA newGO2Pal
	LDA #$00
	STA newObj1Pal
	STA newObj2Pal
	
	LoadSpritePalette newGO1Pal, newGO2Pal, newObj1Pal, newObj2Pal
	
;;; Load Start Screen:	

	LDA #$00
	STA backgroundTilesToLoad
	

	LDA #<startScreenTiles
	STA temp16
	LDA #>startScreenTiles
	STA temp16+1
	
	LoadChrData #BANK_STARTSCREEN_CHR, #$10, #$0, #$0
;	LoadNametableData #$1E, NT_StartScreen, #$00, #$00, #$00
	LoadAttributeData #$1E, ATT_StartScreen, #$0, #$00
	
	
	LDA #$00
	STA newPal
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDX newPal
	LDA SpecialBackPalLo,x
	STA temp16
	LDA SpecialBackPalHi,x
	STA temp16+1
	LDY prevBank
	JSR bankswitchY
	LoadBackgroundPalette ;Pal_StartScreen
	
	;; load hud
;;	LoadChrData #$1d, #$1c, #$00, #$40, textTiles
	LDA #START_SCREEN_SONG
	STA currentSong
	PlaySong #START_SCREEN_SONG
	
	LDA #%00011110 ;;
	STA soft2001

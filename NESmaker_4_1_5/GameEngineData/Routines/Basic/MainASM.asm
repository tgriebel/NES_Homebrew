;1. iNES header
	.include "GameData\Constants.asm"
	
	.include ROOT\System\Header.asm
	
	

;2. Constants and variables
	;A. First, the constants
	.include "Sound\ggsound.inc"
	.include "GameData\macroList.asm
	.include "ScreenData\init.ini"

	.include SCR_MEMORY_MAP


	;C. then the BANK ASSIGNMENTS
	.include ROOT\System\AssignBanks.asm
;________________________________________
;4 The Reset
	.include ROOT\System\Reset.asm
	
	;; initialize 
	.include ROOT\InitializationScripts\InitLoads.asm
_____________
;Things are initialized.  Jump to the main game loop
;____________________________________________________
	LDA #$00
	STA gameState
	STA textboxHandler

	LDY #BANK_MUSIC
	JSR bankswitchY

	
	lda #SOUND_REGION_NTSC ;or #SOUND_REGION_PAL, or #SOUND_REGION_DENDY
    sta sound_param_byte_0
    lda #<(song_list)
    sta sound_param_word_0
    lda #>(song_list)
    sta sound_param_word_0+1
    lda #<(sfx_list)
    sta sound_param_word_1
    lda #>(sfx_list)
    sta sound_param_word_1+1
    lda #<(instrument_list)
    sta sound_param_word_2
    lda #>(instrument_list)
    sta sound_param_word_2+1
    ;lda #<dpcm_list
    ;sta sound_param_word_3
    ;lda #>dpcm_list
    ;sta sound_param_word_3+1
    jsr sound_initialize


	LDY prevBank
	JSR bankswitchY
nevermindPlaySong:
	LDA #SKIP_START_SCREEN
	BEQ dontSkipStartScreen
	;;;;
;;============================================================
	;;SKIP START SCREEN!
	;;; COMMENT THIS ALL OUT TO OBSERVE START SCREEN AGAIN
	;;; this script does the same as our "press start" function does on start screen,
	;;; except here, it does it automatically on startup
	;LDA #SKIP_START_SCREEN
	;BEQ dontSkipStartScreen
	
	LDA #STATE_START_GAME
	STA change_state
	LDA #%10000000
	STA gameHandler ;; turn sprites on
	;;;;;;;;;
	;;;;END SKIP START SCREEN!
;;============================================================	
dontSkipStartScreen:
	;PlaySong #$00
	JMP MainGameLoop
	
WaitFrame:
	
	
	inc sleeping
	sleepLoop:
		lda sleeping
		BNE sleepLoop
	
	
	RTS
	
;9 NMI
NMI:
	;first push whatever is in the accumulator to the stack
	
	PHA
	LDA doNMI
	BEQ dontSkipNMI
	JMP skipWholeNMI
dontSkipNMI:

	LDA #$01
	STA doNMI
	TXA
	PHA
	TYA
	PHA
	PHP
	
	LDA temp
	PHA ;STA NMItemp
	LDA temp1
	PHA ;STA NMItemp1
	LDA temp2
	PHA ;STA NMItemp2
	LDA temp3
	PHA ;STA NMItemp3
	LDA tempx
	PHA ;STA NMItempx
	LDA tempy
	PHA ;STA NMItempy
	LDA tempz
	PHA ;STA NMItempz

	LDA updateHUD_fire_Address_Lo
	PHA ;STA NMI_updateHud_AddLo
	LDA updateHUD_fire_Address_Hi
	PHA ;STA NMI_updateHud_AddHi
	LDA updateHUD_fire_Tile
	PHA ;STA updateHud_tile
	
	LDA temp16
	PHA ;STA NMItemp16
	LDA temp16+1
	PHA ;STA NMItemp16_plus_1
	
	LDA currentBank
	PHA ;STA NMIcurrentBank
	LDA prevBank
	PHA ;STA NMIprevBank
	LDA tempBank
	PHA ;STA nmiTempBank
	
	
	LDA chrRamBank
	PHA ;STA nmiChrRamBank
	
	LDA skipNMI
	BEQ dontSkipNMI2
	JMP skipNMIstuff
dontSkipNMI2:


	
	LDA #$00
	STA $2000
	LDA soft2001
	STA $2001
	
	;;;Set OAL DMA
	LDA #$00
	STA $2003
	LDA #$02
	STA $4014
	;; Load the Palette
	
	LDA soft2001
	BNE doScreenUpdates
	JMP skipScreenUpdates
doScreenUpdates:
	bit $2002
	LDA updatePalettes
	BNE doPaletteUpdates
	JMP +
doPaletteUpdates:
	.include ROOT\DataLoadScripts\LoadPalettes.asm
	JMP skipScreenUpdates
+
	LDA updateNametable
	BNE doUpdateNametable
	JMP +
doUpdateNametable:;; for nametable changes
	.include ROOT\DataLoadScripts\LoadTileUpdate.asm
	JMP skipScreenUpdates
+
	LDA UpdateAtt
	BNE doUpdateAtt
	JMP +
doUpdateAtt:
	.include ROOT\DataLoadScripts\LoadAttUpdate.asm
	JMP skipScreenUpdates
+


	
skipScreenUpdates:	
	;; always do hud update, otherwise
	;; it's possible that updates to tiles, attributes, or palettes
	;; will cause a skip in hud update.
	.include ROOT\DataLoadScripts\LoadHudData.asm

	LDA xScroll_hi
	AND #%00000001
	STA showingNametable

	
	LDA #CHECK_SPRITE_ZERO
	BEQ skipSprite0Check
	LDA gameState
	CMP #GS_MainGame
	BNE skipSprite0Check
	LDA gameHandler
	AND #%10000000
	BEQ skipSprite0Check
	LDA $0200
	CMP #SPRITE_ZERO_Y
	BNE skipSprite0Check
	;;; do sprite 0 check.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

  LDA #$00         ; start with no scroll for status bar
  STA $2005
  STA $2005
  
  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000        ; start with nametable = 0 for status bar

  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001

;JMP +
WaitNotSprite0:
  lda $2002
  and #%01000000
  bne WaitNotSprite0   ; wait until sprite 0 not hit

WaitSprite0:
  lda $2002
  and #%01000000
  beq WaitSprite0      ; wait until sprite 0 is hit
  
    ldx #SPRITE_ZERO_HBLANK ;;; SET THIS TO A DIFFERENT VALUE FOR OFFSET TO AVOID PIXEL FLICKER
WaitScanline:
	dex
	bne WaitScanline

	LDA soft2001
	STA $2001
skipSprite0Check:
 
	LDA #%10010000
	ORA showingNametable
	STA $2000
	
	LDA xScroll
	STA $2005	;reset scroll values to zero
	LDA yScroll
	STA $2005	;reset scroll values to zero
skipNMIstuff:		


	
	DEC vBlankTimer
	INC randomSeed1
	;;return from this interrupt
	;; music player things
	
	LDA #$0
	STA sleeping

	LDA currentBank
	STA prevBank
	LDY #BANK_MUSIC  ;; switch to music bank
	JSR bankswitchY
	soundengine_update  
	LDY prevBank
	JSR bankswitchY	


	PLA
	STA chrRamBank
	PLA 
	STA tempBank
	PLA 
	STA prevBank
	PLA
	STA currentBank
	PLA
	STA temp16+1
	PLA
	STA temp16
	PLA
	STA updateHUD_fire_Tile
	PLA 
	STA updateHUD_fire_Address_Hi
	PLA 
	STA updateHUD_fire_Address_Lo
	PLA ;LDA NMItempz
	STA tempz
	PLA ;LDA NMItempy
	STA tempy
	PLA ;LDA NMItempx
	STA tempx
	PLA ;LDA NMItemp3
	STA temp3
	PLA ;LDA NMItemp2
	STA temp2
	PLA ;LDA NMItemp1
	STA temp1
	PLA ;LDA NMItemp
	STA temp
	
	LDA #$00
	STA doNMI
	
	PLP
	PLA
	TAY
	PLA
	TAX
skipWholeNMI:	
	PLA

	
	RTI
	
	
MainGameLoop:
;;;;;;;;=========HANDLE FRAME TIMING	
	JSR GamePadCheck
	
	LDA vBlankTimer
vBlankTimerLoop:
	CMP vBlankTimer
	BEQ vBlankTimerLoop
;;;;;;==========END HANDLE FRAME TIMING	
	;; always get input.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;; handle stage changes.
	LDA currentBank
	STA prevBank
	LDY #$14
	JSR bankswitchY
	JSR HandleStateChanges
	JSR HandleHudData
	LDY prevBank
	JSR bankswitchY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JSR HandleScreenLoads
	JSR CheckForUpdateScreenData
	

	;JSR HandleFadeLevels
	;JSR HandleFades
	;JSR HandleUpdateNametable

	
	JSR HandleBoxUpdates


	JSR HandleMusic
	JSR HandleInput
	JSR HandleUpdateObjects
	JSR HandleRandomizing

	JSR HandleGameTimer
	
HandleActivateWarpFlag
	LDA activateWarpFlag
	BEQ +
	LDA #$00
	STA activateWarpFlag

	LDX player1_object
	DeactivateCurrentObject
	LDA #$01
	STA loadObjectFlag
	LDA warpMap
	sta currentMap
	clc
	ADC #$01
	STA temp
	GoToScreen navToScreen, temp, #$02
	JMP ++ ;; skip scroll
+	

	
	
	

	LDA loadingTilesFlag
	BEQ dontUpdateColumn
	TXA
	STA tempx
	JSR updateColumnTiles
	LDX tempx
	JMP ++
dontUpdateColumn:
	LDA testFlagThing
	BEQ +
	LDA tempTileUpdate_lo
	STA temp16
	LDA tempTileUpdate_hi
	STA temp16+1
	LDA tempChangeTiles
	STA updateTile_00
	LDA tempChangeTiles+1
	STA updateTile_01
	LDA tempChangeTiles+2
	STA updateTile_02
	LDA tempChangeTiles+3
	STA updateTile_03
	
	JSR HandleUpdateNametable
	LDA #$00
	STA testFlagThing
	STA tileCollisionFlag
+

	JSR HandleScroll
++

	
	
	;;;;;;;;;;;;;;;;;

	
	;;;;;;;;;;;;;;;
	
	
	JMP MainGameLoop
	
	RTS	
	
;;;;;;;;;;;;;;;;;;;;;
	.include "GameData\ScriptTables.asm"
	.include ROOT\System\IncludeSystemFunctions.asm
	.include "GameData\HUD_DEFINES.dat"

	
	
	
columnTableLo:
	.db #$00, #$02, #$04, #$06, #$08, #$0A, #$0C, #$0E
	.db #$10, #$12, #$14, #$16, #$18, #$1A, #$1C, #$1E
	.db #$00, #$02, #$04, #$06, #$08, #$0A, #$0C, #$0E
	.db #$10, #$12, #$14, #$16, #$18, #$1A, #$1C, #$1E
	
	
columnTableHi:
	.db #$20, #$20, #$20, #$20, #$20, #$20, #$20, #$20
	.db #$20, #$20, #$20, #$20, #$20, #$20, #$20, #$20
	.db #$24, #$24, #$24, #$24, #$24, #$24, #$24, #$24
	.db #$24, #$24, #$24, #$24, #$24, #$24, #$24, #$24
	
attrColumnTableLo:
	.db #$c0, #$c1, #$c2, #$c3, #$c4, #$c5, #$c6, #$c7
	.db #$c0, #$c1, #$c2, #$c3, #$c4, #$c5, #$c6, #$c7
attrColumnTableHi:
	.db #$23, #$23, #$23, #$23, #$23, #$23, #$23, #$23
	.db #$27, #$27, #$27, #$27, #$27, #$27, #$27, #$27
	
	
	
bitwiseLut:
	.db #%10000000, #%01000000, #%00100000, #%00010000, #%00001000, #%00000100, #%00000010, #%00000001
	
bitwiseLut16:
	.db #%10000000, #%01000000, #%00100000, #%00010000, #%00001000, #%00000100, #%00000010, #%00000001
	
directionTable:
	.db #%00110000, #%11110000, #%11000000, #%11100000, #%00100000, #%10100000, #%10000000, #%10100000

;12. Vectors
	.include ROOT\System\Vectors.asm



	
	
	
HandleStateChanges
	LDA change_state
	BNE fireAStateChange
	;; no state change to fire
	rts
fireAStateChange:
	
	CMP #STATE_START_GAME
	BEQ doStartGame
	JMP notStartGame
doStartGame:

;;;;;;;=========================================
;;;;; HERE IS WHAT HAPPENS WHEN THE GAME STARTS:
;;;;;===========================================
	;;;;; 1) First, load the main game state, the 
			LDA #%11000000
				;7 = active
				;6 = 8 or 16 px tiles
			ORA #GS_MainGame
			STA update_screen
			LDA #START_LEVEL
			CLC
			ADC #$01
			;LDA #%00000010
			LDA #$01
			STA update_screen_details ;; load from map 1
			LDA #START_ON_SCREEN
		;	LDA continueScreen

			STA currentNametable
			STA newScreen
			STA currentScreen ;currentScreen

			LDA newScreen
			STA currentScreen
			LSR
			LSR
			LSR
			LSR
			LSR
			STA screenBank
			;; ignores this if is special
			;; adds 08 if it is map 2
			LDA #HUD_TILE_OFFSET
			STA update_screen_hud_offset
			
			LDA #HUD_ATT_OFFSET
			STA update_screen_att_offset
			
			LDA #HUD_COL_OFFSET
			STA update_screen_col_offset
			
	;;;;;; 2) Second, create the player in the correct starting position.
		
		CreateObject continuePositionX, continuePositionY, playerToSpawn, #$00, currentNametable ;; change this to name?
		TXA
		STA player1_object
		
	LDA screenTypeAndSongNumber
	AND #%00001111
	STA temp
	

	PlaySong temp
	LDA temp
	STA currentSong
	
			
	
;;;;=======================================
;;;; END START GAME
;;;======================================	
	LDA #$00
	STA change_state
	RTS
	
notStartGame:
	CMP #STATE_WIN_GAME
	BEQ doWinGame 
	JMP notWinGame
doWinGame:

	LDA #%10000000
				;7 = active
				;6 = 8 or 16 px tiles
	ORA #GS_Win
	STA update_screen
	

	JSR DeactivateAllObjects
	JSR DrawAllSpritesOffScreen
	LDA #%00
	STA gameHandler ;; turn off drawing sprites
	
;	LDA #$00
;	LDx #$00
;turnOffAllObjects:
;	STA Object_status,x
;	STA Object_x_hi,x
;	inx
;	CPX #TOTAL_MAX_OBJECTS
;	BNE turnOffAllObjects
	;; other possibilities go here.
	
	LDA #$01 ;; win screen
	STA newScreen
	LDA #$00
	STA update_screen_hud_offset
	STA update_screen_att_offset
	STA update_screen_col_offset
	LDA #%00000000 ;; special screen
	STA update_screen_details
	

	;; load hud
	;LoadChrData #$1d, #$1c, #$00, #$40, textTiles
	LDA #WIN_SCREEN_SONG
	STA currentSong
	PlaySong #WIN_SCREEN_SONG
	LDA #$00
	STA change_state
	
notWinGame:
	RTS
	

	.include GameData/System_RAM.asm



	; soundfx .dsb 1

	; canUpdateScreen .dsb 1 ;; used for testing tool only.  erase
	; DrawOrderTemp	.dsb 1 ;; temporarily holds draw order during object update.
	; textBoxFlag		.dsb 1 
	; screenText	.dsb 4
	; tempCol		.dsb 1
	; Object_flag_temp	.dsb 1
	

	; stringGroupPointer .dsb 1
	; stringGroupOffset	.dsb 1
	; stringTemp			.dsb 1
	; stringEnd			.dsb 1
	; ObjectToLoad		.dsb 1
	; CurrentMonsterSpawnData .dsb 1
	; spawnX				.dsb 1
	; spawnY				.dsb 1
	
	; gameTimerLo			.dsb 1
	; gameTimerHi			.dsb 1
	; gameTimer 		.dsb 1
	
	; edgeLoaderInCue	.dsb 1
	
	; weaponsUnlocked 	.dsb 1

	; underSlash			.dsb 1
	; underStomp			.dsb 1
	; underSecret			.dsb 1
	; underBoss			.dsb 1
	
	
; ;;************************************************
; ;; Draw Flags
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; DrawFlags .dsb 1
		; ;0 = flicker
		; ;1 = hud
		; ;2 = box - prepare to draw box
		
	; HudHandler .dsb 1
	; SetCountAllMonsters .dsb 1 ;;
								; ;; counting all monsters can really only happen
								; ;; AFTER a hud update, otherwise, the two try to compete.
	; textPointer .dsb 2 
; ;;*************************************
; ;; fire a screen update
; ;;*************************************	
	; update_screen		.dsb 1
		; ;; 7 = activate new update.
		; ;; 6 = 8 or 16 pixel tiles? 0 = 8, 1 = 16
		; ;; 5 = load new collision data (may not want to for menus,etc
		; ;; 4 = load new screen data (may not want to for menus,etc 
		; ;; 3210 = newGameState
		
	; update_screen_details 	.dsb 1
		; ;;10 = screen type, 00 = special, 01 = map1, 02 = map2
	; update_screen_hud_offset .dsb 1
	; update_screen_att_offset .dsb 1
	; update_screen_col_offset .dsb 1
	
	; update_screen_bck_graphics_bank	.dsb 1


	
		; ;;;; MetaTileUpdate
	; updateTile_00 .dsb 1 ;; TL
	; updateTile_01 .dsb 1 ;; TR
	; updateTile_02 .dsb 1 ;; BL
	; updateTile_03 .dsb 1 ;; BR
	; updateTileTotal	.dsb 1
	

	
	; updateNT_fire_att_lo	.dsb 4
	; updateNT_fire_att_hi	.dsb 4
		
	; change_state		.dsb 1
		; ;; fires a state change from the static bank
		; ;; these are a combination of macros and subroutines.
		; ;; #STATE_START_GAME = #$01
		; ;; #STATE_CONTINUE	= #$02
		; ;; #STATE_RESTART_PRESERVED #$03
		
; ;;********************************************************
; ;; for updating nametables, like with a hud or a text box
; ;;********************************************************


	; updateNT_status		.dsb 1
		; ;; 7 = active (updating NT)
		; ;; 6 = revert nametable
		; ;; 5 = 8x8 or metatiles
		; ;; 4 = use label - 0 = fill with blank tiles, 1 = fill with nt from label
		
		
	; updateNT_columns	.dsb 1 ;; how wide
	; updateNT_columnCounter .dsb 1
	; updateNT_rows		.dsb 1 ;; how tall
	; updateNT_rowCounter .dsb 1
	
	; updateNT_attWidth	.dsb 1
	; updateNT_attHeight	.dsb 1
	
	; updateNT_H_offset		.dsb 1 ;; left starting position
	; updateNT_V_offset		.dsb 1 ;; top starting position
	; updateNT_positionToUpdate .dsb 2 ;; NMI will need to know next place to update.
									; ;; this will hold low and high byte.
	; updateNT_bank			.dsb 1 
	; updateNT_offset				.dsb 1


	
	; updateNT_att			.dsb 1
	; updateNT_pointer		.dsb 2
	; updateNT_details		.dsb 1
	; DrawHudBytes			.dsb 1 ;; there are 8 possible "huds" to draw / undraw at a time. Because why not.
	; updateNT_tableLeft		.dsb 1
	; updateNT_attMask		.dsb 1
	; updateNT_holdY			.dsb 1
	
	; updateNT_att_odds		.dsb 1 ;; handles drawing odd attribute tiles.
	
	; dummyVar1				.dsb 1
	; dummyVar2				.dsb 1
	
	; OverwriteNT				.dsb 1
	; UpdateAtt				.dsb 1

		; ;7 = is it in cue
		; ; 6 = main screen is 16x16 (8x8=0)
		
	; updateHUD_fire_Address_Lo .dsb 1
	; updateHUD_fire_Address_Hi .dsb 1
	; updateHUD_fire_Tile	.dsb 1
	; updateHUD_offset	.dsb 1
	; hudElementTilesToLoad .dsb 1
	; hudElementTilesFull	.dsb 1 ;; used for full/empty heart type paradigm.
	; hudTileCounter		.dsb 1
	
	
	; updateCHR_counter	.dsb 1
	; updateCHR_offset	.dsb 1
	; updateCHR_max		.dsb 1
	; updateCHR_translate	.dsb 1
	; updateCHR_pointer	.dsb 1
	
	; updateHUD_ASSET_TYPE	.dsb 1 ;; 8 constant placeholders that can be loaded into these vars
	; updateHUD_ASSET_X		.dsb 1
	; updateHUD_ASSET_Y		.dsb 1
	; updateHUD_IMAGE			.dsb 1
	; updateHUD_STRING		.dsb 1
	; updateHUD_MAX_VALUE		.dsb 1
	; updateHUD_BLANK			.dsb 1
	; updateHUD_ROW			.dsb 1
	; updateHUD_COLUMN		.dsb 1
	
	; updateHUD_POINTER		.dsb 2 ;; used to point to tables for text / images.
	; updateHUD_inverse		.dsb 1 ;; to turn off that particular hud update.
	; hudElementTilesMax		.dsb 1

	; value					.dsb 8
	
	; HudImageToDraw			.dsb 1
	; testVar					.dsb 1
	
	
	; boxToChange_width		.dsb 1
	; boxToChange_height		.dsb 1
	; boxToChangeX			.dsb 1
	; boxToChangeY			.dsb 1
	; boxToChange_attWidth	.dsb 1
	; boxToChange_attHeight	.dsb 1
		
; ;;;===== SONGS AND SFX
	; songToPlay 		.dsb 1
	; sfxToPlay		.dsb 1
	; fireSoundByte	.dsb 1
	; sfxPriority		.dsb 1
	; currentSong		.dsb 1
		
		
		; ;;; NMI temp handlers
	; NMItemp				.dsb 1
	; NMItemp1			.dsb 1
	; NMItemp2			.dsb 1
	; NMItemp3			.dsb 1
	; NMItempx			.dsb 1
	; NMItempy			.dsb 1
	; NMItempz			.dsb 1
	; NMItemp16			.dsb 1
	; NMItemp16_plus_1	.dsb 1
	; NMIcurrentBank		.dsb 1
	; NMIprevBank			.dsb 1
	; nmiTempBank			.dsb 1
	; nmiChrRamBank		.dsb 1
	; NMI_a				.dsb 1
	; NMI_x				.dsb 1
	; NMI_y				.dsb 1	
	; NMI_updateHud_AddLo .dsb 1

	 ; NMI_updateHud_AddHi .dsb 1

	 ; updateHud_tile .dsb 1
	; ActivateHudUpdate 		.dsb 1
	
	
	
	
		; objectFrameCount			.dsb 1
		; currentObject				.dsb 1
		; currentObjectType			.dsb 1
		; otherObject					.dsb 1
		; otherObjectType				.dsb 1
		
	; gameHandler			.dsb 1
		; ;7 draw sprites
		; ;6 handle input
		; ;5 update objects
		; ;6 draw hud if 1
	; screenSpeed 		.dsb 1
	; warpToScreen		.dsb 1
	; warpMap				.dsb 1
	; screenTypeAndSongNumber 	.dsb 1
	
; ;;======================== for monster loads.


	; mon1SpawnData		.dsb 1
	; mon2SpawnData		.dsb 1
	; mon3SpawnData		.dsb 1
	; mon4SpawnData		.dsb 1

	; ;; 8?  or maybe 8 byte variable, to loop through?
	; monsterGroup		.dsb 1
	; maxMonsters			.dsb 1 ;; just temporary - max to load for current screen.
	; objectTilesToLoad	.dsb 1
	
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		; ;; for path loads
	; pathTile00					.dsb 1
	; pathTile01					.dsb 1
	; pathTile02					.dsb 1
	; pathTile03					.dsb 1
	
	; pathBank00					.dsb 1
	; pathBank01					.dsb 1
	; pathBank02					.dsb 1
	; pathBank03					.dsb 1
	
	; ;; for quicker, easier path comparisons
	; TL_path				.dsb 1
	; TC_path				.dsb 1
	; TR_path				.dsb 1
	; CL_path				.dsb 1
	; CR_path				.dsb 1
	; BL_path				.dsb 1
	; BC_path				.dsb 1
	; BR_path				.dsb 1
		
	; currentPathTile_TL	.dsb 1
	; currentPathTile_TR	.dsb 1
	; currentPathTile_BL	.dsb 1
	; currentPathTile_BR	.dsb 1
	
	; xPrev				.dsb 1
	; yPrev				.dsb 1
	
	; backgroundTilesToLoad .dsb 1 
	; screenSpecificTilesToLoad .dsb 1	
	; object1TilesToLoad	.dsb 1	 	
	; TileCounter		.dsb 1		
	; TilesToLoad		.dsb 1	
	; newScreen 		.dsb 1	
	; currentScreen	.dsb 1
	; mapLevel		.dsb 1 ;; ground level
	; object_loading_state .dsb 1
	; nt_var			.dsb 1
; ;;*******************************************************
; ;; localized object vars for quick reference
; ;;*******************************************************
	; myEdgeAction 	.dsb 1
	; mySolidAction	.dsb 1
	; myObjectType	.dsb 1	
	; tempAccAmount	.dsb 1
	; tempMaxSpeed	.dsb 1
	; nt_index_hold	.dsb 1
	
	; skipNMI			.dsb 1
	; screen_transition_type		.dsb 1
		; ;; 0 = starting game, uses constants.
		; ;; 1 = regular map update - places character at opposite side of screen
		; ;; 2 = warp in
	; monsterCounter	.dsb 1
	; targetCounter	.dsb 1
	
	
	; myHvel			.dsb 1
	; myVvel			.dsb 1
	
	; screenTriggers .dsb 32
	; octant			.dsb 1
	
	; colX			.dsb 1 ;; temporary variable used as index for collision behavior / recoil stuff.
	; recoil_selfX	.dsb 1
	; recoil_otherX	.dsb 1
	; recoil_selfY	.dsb 1
	; recoil_otherY 	.dsb 1

	; continueScreen .dsb 1
	; continuePositionX .dsb 1 
	; continuePositionY .dsb 1
	; continueMap		.dsb 1 ;; map 1 or 2
	
	
	; updateOneChrTile	.dsb 1
	; writingText			.dsb 1
; ;;;;; MODULE VARIABLES

	

	
	; updatePalettes	.dsb 1

	
	; objectID 		.dsb 4 ;; one for each object to be loaded to the screen.
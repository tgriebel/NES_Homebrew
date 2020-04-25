	.enum $0000
;;;;;;ZERO PAGE VARIABLES

	.include GameData/ZP_RAM.asm





;****************************************************************
;ZP MUSIC variables
;****************************************************************
	; .include ROOT\System\ggsound_zp.asm
	
	

; ;;*********************************
; ;; TEMP variables and placeholders
; ;;*********************************
	; loopTemp		.dsb 1
	
	; temp			.dsb 1 		
	; temp1	 		.dsb 1
	; temp2			.dsb 1		
	; temp3			.dsb 1		
	
	; tempx			.dsb 1		
	; tempy			.dsb 1		
	; tempz			.dsb 1		
	; temp16			.dsb 2	
	; collisionPointer	.dsb 2
	; updateNT_ntPointer		.dsb 2
	; updateNT_pos			.dsb 2
; ;;************************************
; ;;Object collision checking variables
; ;;************************************
	; selfLeft 		.dsb 1				
	; selfRight		.dsb 1				
	; selfTop			.dsb 1				
	; selfBottom		.dsb 1		
	; selfNT_L		.dsb 1
	; selfNT_R		.dsb 1
	
	; otherLeft		.dsb 1				
	; otherRight		.dsb 1					
	; otherTop		.dsb 1			
	; otherBottom		.dsb 1	
	; otherNT_L		.dsb 1
	; otherNT_R		.dsb 1

	; selfCenterX 	.dsb 1				
	; selfCenterY		.dsb 1				
	; otherCenterX	.dsb 1				
	; otherCenterY	.dsb 1				

	; xHold_lo		.dsb 1
	; xHold_hi		.dsb 1
	; yHold_lo		.dsb 1
	; yHold_hi		.dsb 1

	; collisionPoint0 .dsb 1
	; collisionPoint1 .dsb 1	
	; collisionPoint2 .dsb 1
	; collisionPoint3 .dsb 1
	; collisionPoint4	.dsb 1
	; collisionPoint5 .dsb 1
	
	; tileX					.dsb 1		
	; tileY					.dsb 1	
	; tile_solidity		.dsb 1
	
	; ;;**********************************************
; ;; INPUT VARIABLES
; ;;*************************************************
	; gamepad			.dsb 1 		
	; buttonStates	.dsb 1		
	

; ;;*****************************************
; ;; Timing and sys
; ;;*****************************************
	; vBlankTimer 	.dsb 1  
	; screenTimer 	.dsb 1
	; screenTimerMicro .dsb 1 
	
	; player1_object .dsb 1 ;; these variables determine what *object slot* the player is in.
							; ;; this allows a user to use arbitrary slots to create a player object
							; ;; rather than just always a static value.
	; player2_object .dsb 1
	
	
	
	
; ;;*****************************************
; ;; Screen control variables
; ;;****************************************
	; prevScreen 		.dsb 1					
	; ScreenLoadBits 	.dsb 1			

	; ScreenByte00	.dsb 1 			; 175
	; ;;7 - 6 - 5 - 4 - 3 - 2 - 1 - 0
	 ; ;| - | - | - | - | - | - | - +--------
	 ; ;| - | - | - | - | - | - +------------
	 ; ;| - | - | - | - | - +---------------- ;;?? Monsters Load Ordered ??
	 ; ;| - | - | - | - +-------------------- Boss Room has been activated, so that we can get one frame of drawing before it closes off boss room
	 ; ;| - | - | - +------------------------	All monsters have been defeated, so that this only triggers once.
	 ; ;| - | - +---------------------------- Boss Room
	 ; ;| - +-------------------------------- Monster are to respawn
	 ; ;+------------------------------------ Monsters Can/Will Respawn
	
	; ScreenByte01  .dsb 1				
	 ; ;;7 - 6 - 5 - 4 - 3 - 2 - 1 - 0
	 ; ;| - | - | - | - | - | - | - +--------
	 ; ;| - | - | - | - | - | - +------------
	 ; ;| - | - | - | - | - +----------------
	 ; ;| - | - | - | - +-------------------- activate npc 1 text on room start
	 ; ;| - | - | - +------------------------ dark room
	 ; ;| - | - +---------------------------- use day / night cycle
	 ; ;| - +-------------------------------- Use path maker
	 ; ;+------------------------------------ Draw Hud
	 
	 ; ScreenFlags	.dsb 1			;176
	 ; ;;7 - 6 - 5 - 4 - 3 - 2 - 1 - 0
	 ; ;| - | - | - | - | - | - | - +-------- Day / Night
	 ; ;| - | - | - | - | - | - +------------ switch day/night on next screen
	 ; ;| - | - | - | - | - +---------------- Saved / not saved
	 ; ;| - | - | - | - +-------------------- Dark Screen has been lit
	 ; ;| - | - | - +------------------------ respawn - 0 = no, 1 = yes
	 ; ;| - | - +---------------------------- ;;;;;;;;;;;;;;;;;;;;;;;;;;Dawn/Dusk
	 ; ;| - +-------------------------------- Trigger Flag
	 ; ;+------------------------------------ Monsters all defeated
	 
	; currentAttributeTablePointer 	.dsb 2

	
	; ;;; These three are great for when you need temp offloading of values, to restore the current values.
	; ;;; set these once in the load routines (macros)
; ;;************************************************
; ;; palette variables
; ;;*************************************************
	; bckPal .dsb 16				;
	; bckPalFade .dsb 16
	; spriteSubPal_0 .dsb 4			;playerPal
	; spriteSubPal_1 .dsb 4				;magicPal
	; spriteSubPal_2 .dsb 4				;objPal1
	; spriteSubPal_3 .dsb 4				;objPal2
	; spritePalFade .dsb 16
	
	; bckPalGroup		.dsb 2		;
	; spriteSubPalGroup_0 .dsb 2		; player
	; spriteSubPalGroup_1	.dsb 2		; magic
	; spriteSubPalGroup_2	.dsb 2		; obj1
	; spriteSubPalGroup_3	.dsb 2		; obj2

	
	; newPal			.dsb 1			
	; newGO1Pal		.dsb 1
	; newGO2Pal		.dsb 1 
	; newObj1Pal 		.dsb 1
	; newObj2Pal		.dsb 1

; ;;***************************************************
; ;; used for save data
; ;;***************************************************
	; TargetBank .dsb 1   ;;;used for saving data. Do we need it if we are always using 18?
	; ReturnBank .dsb 1
	; TargetAddress .dsb 1
	; TargetAddress_h .dsb 1
	; SourceAddress .dsb 1
	; SourceAddress_h .dsb 1

; ;;**********************************************
; ;; POINTERS
; ;;**********************************************
	

; ;;****************************************************
; ;;Handlers
; ;;******************************************************
	; soft2000			.dsb 1			
	; soft2001			.dsb 1			
	; sleeping			.dsb 1	

	; randomSeed1	.dsb 1					
	; randomSeed2	.dsb 1				

		; ;;; fade / transition handlers
	; fadeByte		.dsb 1		
		; ; 7 = fade is active
		; ; 6 = fade darker / fade lighter
		; ;_____________________________
		; ; 5 = fade out
		; ; 4 = loading data
		; ; 3 = fade in
		; ;______________________________
		; ; 210 = how many steps to fade? - only 5 possible values.
		
	; fadeSpeed		.dsb 1
	; fadeTimer		.dsb 1 		
	; fadeLevel		.dsb 1
	; fadeSelect_bck		.dsb 2 ;; each bit represents one of 16 palette values
								; ;; that could change.  This gives you color by color
								; ;; control over 'glowing' or 'fading'.
	
; ;;********************************************************
; ;; Bank Handlers
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; currentBank 			.dsb 1		
	; prevBank				.dsb 1	
	; screenBank				.dsb 1	
	; screenType				.dsb 1
	; graphicsBank			. dsb 1		
	; objGraphicsBank			.dsb 1
	; prevScreenBank 			.dsb 1
	; tempBank				.dsb 1
	; chrRamBank				.dsb 1
	

	

	
; ;;****************************************************
; ;; Game states
; ;;****************************************************
	; gameState		.dsb 1		
	; gameSubState	.dsb 1 	
	
	; newGameState		.dsb 1		
	; newX				.dsb 1			
	; newY				.dsb 1			
	
; ;;*************************************************
; ;; drawing variables
; ;;**************************************************
	; spriteOffset		.dsb 1
	; spriteDrawLeft		.dsb 1
	; spriteDrawTop		.dsb 1
	; sprite_drawVoffset			.dsb 1
	; sprite_drawHoffset		.dsb 1
	; sprite_pointer			.dsb 2
	; sprite_tileOffset		.dsb 1
	; tileset_offset				.dsb 1
	
	; drawOrder				.dsb 10
	

; ;;*****************************************************
; ;; loading varioables
; ;;****************************************************

	; SongToPlay		.dsb 1
	

	.ende
	
	

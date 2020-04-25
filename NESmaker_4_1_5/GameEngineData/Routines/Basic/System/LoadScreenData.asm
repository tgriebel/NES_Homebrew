LoadRoomData:
;	LDY screenBank
;LDY #$00
	;JSR bankswitchY
	;;; GET STARTING POSITION FOR ROOM DATA

	;;;;; BYTE 1
	LDY #SCREEN_DATA_OFFSET
	
	LDA (collisionPointer),y
	STA screenType
	
	INY 
	;;;;; BYTE 2, D1
	

;;=========LOAD GRAPHICS BANK
	LDA (collisionPointer),y ;; this is the background graphics bank
	AND #%00001100 ;; this is where the screen graphics bank is.
	LSR
	LSR
	
	CMP #$00
	BNE notZeroGraphicsBank

	;;is zero graphics bank
	LDA #GraphicsBank00
	JMP gotScreenGraphicsBank
notZeroGraphicsBank:
	CMP #$01
	BNE notOneGraphicsBank
	LDA #GraphicsBank01
	JMP gotScreenGraphicsBank
notOneGraphicsBank:
	CMP #$02
	BNE notTwoGraphicsBank
	LDA #GraphicsBank02
	JMP gotScreenGraphicsBank
notTwoGraphicsBank:
	LDA #GraphicsBank03
	
gotScreenGraphicsBank:	
	STA graphicsBank

	INY
	;;;;; BYTE 3, D2
;==============================Load screen palette	3

	LDA (collisionPointer),y ;; this is the palette data
	STA newPal
	
	INY
	;;;;; BYTE 4, D3
	
;;;;;================= this loads the main tiles	4
	
	LDA (collisionPointer),y ;; this is background tiles
	LSR
	LSR
	LSR
	LSR
	STA backgroundTilesToLoad
	;;; this is effectively the tileset

	
		
	;;;;;;================ this is screen specific tiles	
	;; do not increase y - now main tiles and screen tiles use the same byte
	LDA (collisionPointer),y ;; this is screen specific tiles
	AND #%00001111
	STA screenSpecificTilesToLoad
	
	INy
	;;; byte 5, D4
		

;;; ==== loads screen byte 0

	;LDA (collisionPointer),y
	;AND #%00010000 ; is this a boss room that has already been ticked
	;BNE skipLoadingScreenByte
	;LDA (collisionPointer),y
	;STA ScreenByte00
	;JMP doneLoadingScreenByte
skipLoadingScreenByte:	
	LDA (collisionPointer),y
	;AND #%11101111
	;ORA #%00010000
	STA ScreenByte00
doneLoadingScreenByte:
	
	INY
	
	;;;;;;;;;;;;; byte 6, d5
;;======= Loads screen Byte 1	
	LDA (collisionPointer),y
	STA ScreenByte01
	AND #%00000011
	STA screenSpeed
	;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;

notAdarkScreen:
	;;;;;;;;;;;;;;;;;;;;;;
	
	;;; DO OTHER SCREEN BYTE 1 THINGS HERE!
	
	INY
	;;;;;; byte 7, d6
;;================ load path tiles
	LDA (collisionPointer),y
	STA temp
	
	LDY #$00
	LDX #$00
loadPathTilesLoop:
	LDA temp
	AND ValToBitTable,y
	BEQ notFirstPath
	TYA 
	STA pathTile00,x
	INX 
	CPX #$04
	BEQ doneGettingPaths
	INY
	JMP loadPathTilesLoop
notFirstPath:
	INY
	
	JMP loadPathTilesLoop
doneGettingPaths:	
	LDY tempy
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;byte 8, d7
;;;;;;=============== figure warp tiles
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$07
	TAY
	LDA (collisionPointer),y
	;LDA #$67
	STA warpToScreen
	
	

	INY
	;;;;;;;;;byte 9, d8 
	; player y and x if comes through portal
	
	
;;;==== HANDLE WARP
	
;	LDA fadeByte
;	AND #%00000010 ;; is it a warp type fade?
;;; how we will determine if it is a warp?
;	BEQ skipSettingWarpXY
	LDA (collisionPointer),y
	AND #%11110000
	
	STA newY
	
	LDA (collisionPointer),y
	AND #%00001111
	ASL
	ASL
	ASL 
	ASL
	STA newX

;skipSettingWarpXY:
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$3E
	TAY
	LDA (collisionPointer),y
	STA screenFlags

	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$09
	TAY
	;;;;; byte 10, song number
	LDA (collisionPointer),y

	AND #%00001111
	STA screenTypeAndSongNumber
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0a
	TAY ;; needed bits...is warping underground
	LDA (collisionPointer),y
	AND #%00000001

	STA warpMap
	
	LDA (collisionPointer),y
	JSR GetScreenTriggerInfo



	
	
	
	
	JMP doneWithScreenDataLoad

	
;;; ============================
;; here we would determine the screen state...day/night/triggerd.
;; for now, we're just going to use "day".
LoadNormalDayData:
	LDA #%10000000
	STA temp ;; what does temp do?
	JSR GetObjGraphicsBank
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; LOAD STRING DATA
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$22
	TAY 
	LDA (collisionPointer),y
	STA stringGroupPointer
	;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; Put text into screenText variables
	
	JSR getTextForScreen
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0B
	TAY
	LDA (collisionPointer),y
	STA mon1SpawnData
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0C
	TAY
	LDA (collisionPointer),y
	STA mon2SpawnData
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0D
	TAY
	LDA (collisionPointer),y
	STA mon3SpawnData
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$26 ;; hex 38
	TAY
	LDA (collisionPointer),y
	
	STA mon4SpawnData
	;;;; above just got spawn positions.
	;;;; above just got spawn positions.
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$17
	TAY
	LDA (collisionPointer),y
	LSR a
	LSR	a
	AND #%00111111
	STA monsterGroup
	;;; got monster group
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$1A
	TAY
	LDA (collisionPointer),y
	LSR
	LSR
	AND #%00111111
	STA newObj1Pal
	;;; got object palette 1 for this screen
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$1D
	TAY
	LDA (collisionPointer),y
	LSR
	LSR
	AND #%00111111
	STA newObj2Pal
	;;; got object palette 2 for this screen
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$20
	TAY
	LDA (collisionPointer),y
	AND #%00001111
	STA objectTilesToLoad
	;;;;;;;;;;; got object tiles
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$2a
	TAY
	LDA (collisionPointer),y
	STA objectID
	INY 
	LDA (collisionPointer),y
	STA objectID+1
	INY 
	LDA (collisionPointer),y
	STA objectID+2
	INY 
	LDA (collisionPointer),y
	STA objectID+3
	;JSR ResetMonsters
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0b
	TAY ; day normal mon 1
	;;;;; do if for each screen state state here
;	JSR findMaxMonsters
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$3a
	TAY ; day normal mon 1
	LDA (collisionPointer),y
	STA songToPlay
	RTS
	
	
	
LoadTriggeredDayData:
	LDA #%00100000
	STA temp
	JSR GetObjGraphicsBank
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Got Obj Graphic Bank
	;;; Get Text string.
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$24
	TAY
	LDA (collisionPointer),y
	STA stringGroupPointer
	
	JSR getTextForScreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$11
	TAY
	LDA (collisionPointer),y
	STA mon1SpawnData
	INY
	LDA (collisionPointer),y
	STA mon2SpawnData
	INY
	LDA (collisionPointer),y
	STA mon3SpawnData
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$28 ;; hex 40
	TAY
	LDA (collisionPointer),y
	STA mon4SpawnData
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;got spawn positions	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$18
	TAY
	LDA (collisionPointer),y
	ASL
	ASL
	STA temp
	INY
	LDA (collisionPointer),y
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	ORA temp
	AND #%00111111
	STA monsterGroup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; got monster group
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$1B
	TAY
	LDA (collisionPointer),y
	ASL
	ASL
	STA temp
	INY
	LDA (collisionPointer),y
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	ORA temp
	AND #%00111111
	STA newObj1Pal
;;;;;;;;;;;;;;;;;;;;;;;;;;;; got object pal 1
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$1E
	TAY
	LDA (collisionPointer),y
	ASL
	ASL
	STA temp
	INY
	LDA (collisionPointer),y
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	ORA temp
	AND #%00111111
	STA newObj2Pal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; got object pal 2
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$21
	TAY
	LDA (collisionPointer),y
	AND #%00001111
	STA objectTilesToLoad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; got object tiles
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$2e
	TAY
	LDA (collisionPointer),y
	STA objectID
	INY 
	LDA (collisionPointer),y
	STA objectID+1
	INY 
	LDA (collisionPointer),y
	STA objectID+2
	INY 
	LDA (collisionPointer),y
	STA objectID+3

	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$3b
	TAY ; day normal mon 1
	LDA (collisionPointer),y
	STA songToPlay
	
	RTS	
	
	
	
	
GetObjGraphicsBank:
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$09
	TAY
	LDA (collisionPointer),y
	AND temp
	BNE useFirstMonBank
	LDA #ObjectGraphicsBank00
	JMP gotGraphicsBank2
useFirstMonBank:
	LDA #ObjectGraphicsBank01
gotGraphicsBank2:
	STA objGraphicsBank
	RTS
	
	
	
findMaxMonsters:
	LDA gameState
	CMP #GS_MainGame
	BNE noMon3

	LDA #$00
	STA maxMonsters
	LDA (collisionPointer),y
	AND #%11110000
	BEQ noMon1
	inc maxMonsters
noMon1:
	INY
	LDA (collisionPointer),y
	AND #%11110000
	BEQ noMon2
	inc maxMonsters
noMon2
	INY
	LDA (collisionPointer),y
	AND #%11110000
	BEQ noMon3
	inc maxMonsters

noMon3:


	RTS		
	
	
GetScreenTriggerInfo:
		LDA screenType
		;; divide by 32
		LSR
		LSR
		LSR 
		;LSR
		;LSR
		;;; now we have the right *byte* out of the 32 needed for 256 screen bytes
		TAY
		LDA screenTriggers,y ;; now the rigth bit is loaded into the accum
		STA temp
		LDA screenType
		AND #%00000111 ;; look at last bits to know what bit to check, 0-7
		TAX
		LDA ValToBitTable_inverse,x
		AND temp
		BEQ thisScreenIsNotTriggered
		;; this screen IS triggered
		JSR LoadTriggeredDayData
		
		JMP triggeredStateInfoIsLoaded
	thisScreenIsNotTriggered	
		JSR LoadNormalDayData 
	triggeredStateInfoIsLoaded:
	RTS
	
	
	
getTextForScreen:
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	
	LDA stringGroupPointer ;; this is the group of the string. 
	ASL
	ASL
	TAY
	LDA AllTextGroups,y
	STA screenText
	INY
	LDA AllTextGroups,y
	STA screenText+1
	INY
	LDA AllTextGroups,y
	STA screenText+2
	INY
	LDA AllTextGroups,y
	STA screenText+3
	
	LDY prevBank
	JSR bankswitchY		
	RTS
	
	
doneWithScreenDataLoad:	
	;; shall we do a wait frame? Wil that solve it?
	TXA
	PHA
	TYA
	PHA
	
	JSR DrawAllSpritesOffScreen
	JSR ResetMonsters
	JSR LoadMonsters ;;; this loads monsters for this particular screen.
					;; however, we might also have to load mosnters for the part of the screen that was not loaded.

	PLA
	TAY
	PLA
	TAX
	
	

RTS
	
	
	

	
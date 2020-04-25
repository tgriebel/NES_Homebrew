	LDA gameHandler
	AND #%10000000
	BNE mainGameStateLoaded
	RTS
mainGameStateLoaded:
	LDA screenFlags
	AND #%10000000
	BEQ +
	;;; This is a single screen game.
	;;; advised simply for speed and ppu update skips.
	RTS
+
	LDA prevent_scroll_flag
	BEQ canDoScrollUpdate
	
	RTS

canDoScrollUpdate:
;	LDA gameHandler
;	AND #%00010000
;	BEQ notUpdatingOtherTiles
;	RTS
notUpdatingOtherTiles:

    LDA OverwriteNT_column
    BEQ dontDoScrollUpdateYet
	
;;;; is already scrolling.
    JMP doScrollTileUpdate
dontDoScrollUpdateYet:
	LDA forceScroll
	AND #%00000010
	BNE doForceScroll
	
	LDA forceScroll
	AND #%00000001
	BEQ dontForceScroll
	
	LDA updateNametable
	BNE dontForceScroll
	
	LDA #%00000010
	STA forceScroll

	RTS ;; gives a one frame cushion before drawing new column.
dontUpdateForceScrollVar:


	;JMP doScrollTileUpdate
doForceScroll:

	LDA #$00
	STA forceScroll

   JMP skipSettingNewNT ;; so, when the game starts, we need to pretend
                        ;; there is a scroll for position 0.
                        ;; otherwise we'll get a seam.
                        
                        ;; Similarly, we need to force a scroll
                        ;; if we change direction mid-column
                        ;; so we don't get a seam.
dontForceScroll:                        

    ;;;;;;;;;;;;;;;;;;;;; column tracker is zero at the beginning of the game.
    ;;;;;;;;;;;;;;;;;;;; it should also be set to zero at a room load*****

    LDA xScroll
    LSR
    LSR
    LSR
    LSR
    STA scrollColumn ;; this now keeps track of the column out of 32
                    ;; first 16 columns being in the left nt
                    ;; second 16 columns being in the right nt
    
    LDA columnTracker
    AnD #%00001111  ;; what column are we on, in whichever nametable we're on.
    CMP scrollColumn
    BNE timeToUpdateScrollColumn

    JMP skipScroll_notPlayer
timeToUpdateScrollColumn:

    LDA #$01
    STA ObjectSeamLoadFlag
    LDA #$00
    STA objectID_forSeamLoad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; first, update the columnTracker (or should this happen at the end?)
    LDA scrollDirection
    BEQ scrollDirLeft
    ;;;;;;;;;;;;;;;;;;;;;;
    inc columnTracker
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; WE WILL LOOK two COLUMNs AHEAD OF THE RIGHTMOST COLUMN
;;;;; TO SEE WHAT OBJECTS NEED TO BE LOADED.
    LDA columnTracker
    CLC
    ADC #$10
    AND #%00011111
    STA scroll_hold
    
    LDA columnTracker
    AND #%00001111
    ;BNE gotColumnTrackerUpdate
    ;; just reset to zero
    ;INC xScroll_hi
    JMP gotColumnTrackerUpdate
scrollDirLeft:
    dec columnTracker
	
    ;;;;; WE WILL LOOK two COLUMNs BEHIND COLUMN
;;;;; TO SEE WHAT OBJECTS NEED TO BE LOADED.
    LDA columnTracker
	sec
    sbc #$02
    AND #%00001111
    STA scroll_hold
    
   ; LDA columnTracker
  ;  AND #%00001111
  ;  CMP #%00001111
  ;  BNE gotColumnTrackerUpdate
  ;  DEC xScroll_hi
  ;  JMP gotColumnTrackerUpdate
gotColumnTrackerUpdate:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; NORMALIZE COLUMN TRACKER
    LDA columnTracker
    AND #%00011111
    STA columnTracker
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;CHECK BIT 5 to see if we need to change nametable
skipIncDecNT:
    LDA columnTracker
    AND #%00010000
    BEQ showingNTisZero
    LDA showingNametable
    BNE skipSettingNewNT
    LDA #$01
    JMP gotShowingNT
showingNTisZero:
    LDA showingNametable
    BEQ skipSettingNewNT
    LDA #$00
gotShowingNT:
	
    STA showingNametable
    LDA scrollDirection
    BEQ DecreaseNametables
  
    INC currentNametable
    INC leftNametable
    INC rightNametable
   

    
    JMP setNewNT
DecreaseNametables:
	
    DEC currentNametable
    DEC leftNametable
    DEC rightNametable

    
setNewNT: 
  ; LDA currentNametable
   ; STA temp;
   LDA #$01
	STA scrollRoomDataFlag
	;JSR LoadScrollRoomData
    LDA currentNametable
    STA temp;
   
dontUpdateScrollRoomData:

skipSettingNewNT:
    ;LDA columnTracker
    ;AND #%00001111
    ;BNE dontUpdateScrollRoomData


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;NAMETABLE IS NOW ASSIGNED.
;;;;;;;; TIME TO UPDATE DATA -
        ;; TILES
        ;; ATTRIBUTES
        ;; COLLISION
	;;;;;;;;;;;;;;;;;;;;;;;;; We need to check to see if there is a hud.
	;;;;;;;;;;;;;;;;;;;;;;;;; if there is a hud, we need to check the height of the hud.
	;;;;;;;;;;;;;;;;;;;;;;;;; Height of hud = how many tiles the hud takes up.
	;;;;;;;;;;;;;;;;;;;;;;;;; So #$0f - that number = how many tiles to write,
	;;;;;;;;;;;;;;;;;;;;;;;;; and also gives us a starting offset of where to draw tiles.
	

    LDA #$0f
	sec
	SBC #BOX_0_HEIGHT
	STA tilesToWrite ;; how many tiles total will we write, even though we can only write four per frame 
    LDA #$00
	
    STA OverwriteNT_row
    STA rowTracker
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;GET NAMETABLE TO PULL FROM
	
    LDA scrollDirection
    BNE updateNametablesRight
    LDA columnTracker

    AND #%00001000
    BNE ++
    LdA leftNametable
    JMP +
++
    LDA leftNametable
    clc
    adc #$01
+
    STA newNametable
    JMP DoneGettingNTupdate
    
    

updateNametablesRight
	
    LDA columnTracker
    AND #%00001000
    BNE ++
    LdA rightNametable
    JMP +
++
    LDA rightNametable
    CLC
    ADC #$01
+
    STA newNametable
DoneGettingNTupdate:
    LDA #$01
    STA loadingTilesFlag
    ;;; These things only happen once.
    JSR doUpdateAttributeColumn
    JSR doUpdateCollisionColumn
	
	LDA scrollRoomDataFlag
	BEQ skipUpdateToNewNametable

	JSR LoadScrollRoomData
	LDA #$00
	STA scrollRoomDataFlag
skipUpdateToNewNametable:	
doScrollTileUpdate:


doneWithScrolling:
    LDA loadMonsterColumnFlag
    BNE timeToCheckLoadMonsters
    JMP notTimeToLoadMonsters
timeToCheckLoadMonsters:
    ;; time to load monsters
    CheckScrollColumnForNewMonsters #$04
notTimeToLoadMonsters:
    ;;; reload the player in case x was corrupted.
    ;;; this only ever happens in the player object
    ;;; so we it could have only gotten to this point
    ;;; if x was the player object, so return it to that.
    LDX player1_object
skipScroll_notPlayer:
    RTS
    
    
doScrollTileUpdateOverflow
    TXA
    PHA
  ;  JSR doUpdateTileColumn
    PLA
    TAX
    RTS
    
    
    
    
    
    
    
doUpdateCollisionColumn:
    LDA currentBank
    STA prevBank
    LDY #$16 ;; screen bank
    JSR bankswitchY
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    LDY newNametable
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
    LDA CollisionTables_Map1_Lo,y
    STA collisionPointer
    LDA CollisionTables_Map1_Hi,y
    STA collisionPointer+1
	JMP ++
+
   LDA CollisionTables_Map2_Lo,y
    STA collisionPointer
    LDA CollisionTables_Map2_Hi,y
    STA collisionPointer+1
++
    
    LDA #$0f
    STA updateCol_columnCounter

    
;   LDA columnTracker
;   AND #%00000001
;   BNE skipDoingColColumnTracking ;;; only do if even
    LDA columnTracker
    CLC
    ADC #$18
    STA temp
    LDA scrollDirection
    BEQ left_getRightOfScreenSeam
    ;; get left of screen seam

    JMP gotScrollHold ;; where to update objects
left_getRightOfScreenSeam:  

gotScrollHold:
    LDA temp
    AND #%00011111
    STA screenSeam
    AND #%00010000
    BNE oneForUpdateColTable
    LDA #$00
    JMP gotUpdateColTable
oneForUpdateColTable:
    LDA #$01
gotUpdateColTable:
    STA updateCol_table
    
    LDY screenBank ;; screen bank
    JSR bankswitchY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; WRITE TO RIGHT NAMETABLE COLLISION 
    LDA columnTracker
    CLC
    ADC #$18
    AND #%00001111
    TAx
    LSR
    TAy
doUpdateColColLoop:
;;;;;;;;;;;;;
    LDA columnTracker
    AND #%00000001
    BNE loadOddCol
    JSR LoadEvenCollisionPoint
    JMP colLoaded
loadOddCol:
    JSR LoadOddCollisionPoint
colLoaded:
    INX
    DEC updateCol_columnCounter
    LDA updateCol_columnCounter
    BEQ doneWithColColumnUpdate
    ;;;;;;;;;;;;; more to go
    
    TXA
    CLC
    ADC #$0f
    TAX
    TYA
    CLC
    ADC #$08
    TAY
    
    JMP doUpdateColColLoop
doneWithColColumnUpdate:


    LDY prevBank
    JSR bankswitchY
    
    

    RTS
    
    
    
    
    
    
    
    

doUpdateAttributeColumn:

    LDX #$00
    ;;; ok, so we need *half* of the column tracker, since ever attribute takes up two columns.

    LDA columnTracker
    AND #%00111111
    LSR
    CLC
    ADC #$0c
    AND #%00001111
    TAY
    LDA attrColumnTableLo,y
    STA temp
doAttributeColumnLoop:
    LDA temp
    STA updateNT_att_fire_Address_lo,x
    LDA attrColumnTableHi,y
    STA updateNT_att_fire_Address_hi,x
    LDA temp
    CLC
    ADC #$08
    STA temp
    INX
    CPX #$08
    BNE doAttributeColumnLoop


    LDA currentBank
    STA prevBank
    LDY #$16
    JSR bankswitchY

    LDY newNametable
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
	LDA AttributeTablesMainGameAboveLo,y
	STA temp16
	LDA AttributeTablesMainGameAboveHi,y
	STA temp16+1
	JMP ++
+
	LDA AttributeTablesMainGameBelowLo,y
	STA temp16
	LDA AttributeTablesMainGameBelowHi,y
	STA temp16+1
++
    LDY screenBank ;;; screen bank
    JSR bankswitchY
    
    
    ;LDA #%00000000
    ;STA updateNT_attMask ;; update whole byte, replace ALL values
    LDX #$00
    ;LSR ;; half since attributes have half the number of values.
    LDA columnTracker

    AND #%00011111
    LSR
    CLC
    ADC #$0c
    AND #%00000111
    TAY
DoAttributesPullLoop:
    
    LDA (temp16),y
    STA updateNT_fire_Att,x
    TYA
    CLC
    ADC #$08
    TAY
    INX
    CPX #$08
    BNE DoAttributesPullLoop
    LDA #$00
	STA updateNT_attMask
    LDY prevBank
    JSR bankswitchY

    RTS
    

    
    
doUpdateTileColumn:
    RTS
 
    
    
    
    
LoadScrollRoomData:
;;;;; DO ALL UPDATES THAT HAPPEN IN THE "CURRENT NAMETABLE"
	LDA currentNametable
	STA temp;
	JSR GetCollisionMap

    LDA #SCREEN_DATA_OFFSET
    CLC
    ADC #$3E
    TAY
    LDA (collisionPointer),y
    STA screenFlags
	
	LDY #SCREEN_DATA_OFFSET
	LDA (collisionPointer),y
	STA screenType

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Slightly complicated explanation here.
;;;; We may have it where if we destroy all monsters,
;;;; scrolling can resume (there is a bit for that).
;;;; But what if we're not fully loaded onto a particular screen
;;;; when we shoot the last monster and that bit check takes place?
;;;; Here, we will check that bit, since now the new screenFlags for the
;;;; new screen are loaded, and if it's flipped, we will do a monster count.
;;;; if they are all gone, we will turn on scrolling.
	JSR HandleToggleScrolling

	LDY prevBank
    JSR bankswitchY
;;;;;; DO ALL UPDATES THAT HAPPEN IN THE "NEW NAMETABLE"

    RTS
    
    
    

    
    
LoadMonsterAtColumn:
    
    LDA (collisionPointer),y
    AND #%11110000
    STA temp ;; y value
    LDA (collisionPointer),y
    ASL
    ASL
    ASL
    ASL 
    STA temp1
    CreateObject temp1, temp, ObjectToLoad, #$00, tempNT
    ;;;;;;;;;;;;;; x    y    mon   action   nametable 
    LDA objectID_forSeamLoad
    STA Object_ID,x
    LDA Object_status,x
    ORA #%00000100
    STA Object_status,x
    RTS
    
    
    
    
CheckObjectsForRecursiveLoad:
    ; LDA #$00
    ; STA theFlag
    ; TXA
    ; STA tempObj
    ; LDX #$00
; DoCheckObjColumnLoadLoop
    ; LDA Object_status,x
    ; AND #%10000000
    ; BEQ skipThisObject_passedTest
    ; LDA Object_home_screen,x
    ; CMP tempNT ;; where this object will load
    ; BNE skipThisObject_passedTest
    ; ;;; object x is on,
    ; ;;; object x has same home screen as new potential object.
    ; LDA Object_ID,x
    ; CMP objectID_forSeamLoad ;; temp, in this case, is the id of the object being loaded.
    ; BNE skipThisObject_passedTest
    
    ; LDA #$01
    ; STA theFlag
    ; LDX tempObj
    ; RTS
; skipThisObject_passedTest:
    ; INX
    ; CPX #TOTAL_MAX_OBJECTS
    ; BNE DoCheckObjColumnLoadLoop
    ; LDA #$00
    ; STA theFlag
    ; LDX tempObj
    
    RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





HandleToggleScrolling:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; THE FOLLOWING BIT OF CODE
        ;; CAN MAKE NON-SCROLLING SCREENS
        ;; START TO SCROLL IF ALL MONSTERS
        ;; ARE DEFEATED.
        
        ;; GOOD FOR BOSSES IN PLATFORMERS/SHOOTERS
        ;; AND GREAT FOR BEAT EM UPS.
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CountObjects #%00001000, #$01
        ;;; if there was no objects,
        ;;; #$01 is now in the accumulator.
        CMP #$01
        BNE +
   
        LDA screenFlags
		AND #%10111111 ;; flip the zero monsters bit.
						;; which would now allow for scrolling.
		STA screenFlags
     +:
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

	RTS
	
	
	
AlignScreenToNametable:

;; HANDLE ALIGN SCREENS

	LDA align_screen_flag
	BNE dontskipaligningscroll
	LDA #$00
	JMP +++
dontskipaligningscroll:
;;;;;;;;;;======================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

	;; is aligning bottom bounds.
	LDA #$00
	STA gameHandler
	
	LDA align_screen_flag
	AND #%10000000
	BEQ doRightScrollAlign
	;;; do left scroll align.
	LDA xScroll
	sec
	sbc #$04
	BCC doneWithAlign
	STA xScroll
	LDA #$01
	JMP +++
	;JMP gotNewYPos
	
doRightScrollAlign:
	LDA xScroll
	CMP #$04 ;; speed of alignment
	BCC doneWithAlign
	LDA xScroll
	CLC
	ADC #$04
	BCS doneWithAlign
	STA xScroll
	LDA #$01
	JMP +++
	;JMP gotNewYPos
doneWithAlign:
	DEC genericTimer
	BEQ alignTimerIsDone
	LDA #$01
	JMP +++
	;JMP gotNewYPos
alignTimerIsDone:
	LDA #$00
	STA prevent_scroll_flag

	LDX player1_object
	LDA Object_scroll,x
	STA nt_hold
	AND #%00000001
	STA showingNametable

	LDA #$00
	STA xScroll
	STA yScroll
	
	LDA align_screen_flag
	AND #%00000011
	CMP #$01
	BNE +
	LDA #$00
	STA align_screen_flag
	JSR doBottomBounds_player
	LDX tempx
	LDA #$01
	JMP +++
	;JMP gotNewYPos
+
	LDA #$00
	STA align_screen_flag
	JSR doTopBounds_player
	ldx tempx
	;JMP gotNewYPos
	LDA #$01
+++:

	RTS
	
	
	
	
	

	
	
GetCollisionMap:
	LDA currentBank
    STA prevBank
    LDY #$16 ;; screen bank
    JSR bankswitchY
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
	;; temp is screen.
    LDY temp
    
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BNE +
    LDA CollisionTables_Map1_Lo,y
    STA collisionPointer
    LDA CollisionTables_Map1_Hi,y
    STA collisionPointer+1
	JMP ++
+
   LDA CollisionTables_Map2_Lo,y
    STA collisionPointer
    LDA CollisionTables_Map2_Hi,y
    STA collisionPointer+1
++
    LDY screenBank
    JSR bankswitchY

	RTS
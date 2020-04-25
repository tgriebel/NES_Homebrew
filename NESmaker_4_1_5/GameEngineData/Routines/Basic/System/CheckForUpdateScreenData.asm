CheckForUpdateScreenData:
	LDA update_screen_data_flag
	BNE doUpdateScreenData
	RTS
doUpdateScreenData:
	LDA #$00
	STA update_screen_data_flag
	;;; HERE LOAD ALL SCREEN DATA
	;;; Any screen data that will change from crossing the threshold of the screen
	;;; must be loaded here.
	;;; Mostly, warpMap, warpToScreen, and NPC dialog.
	LDA currentBank
    STA prevBank
    LDY #$16 ;; screen bank
    JSR bankswitchY
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
	;; temp is screen.
	LDX player1_object
    LDY Object_scroll,x
    
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
	
	;;;;;also, load warp out, warp in, and warpMap
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$07
	TAY
	LDA (collisionPointer),y
	;LDA #$67
	STA warpToScreen
	
	LDA #SCREEN_DATA_OFFSET
	CLC
	ADC #$0a
	TAY ;; needed bits...is warping underground
	LDA (collisionPointer),y
	AND #%00000001

	STA warpMap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GET TEXT STRINGS FOR THIS NEW SCREEN
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDY prevBank
	JSR bankswitchY

	RTS
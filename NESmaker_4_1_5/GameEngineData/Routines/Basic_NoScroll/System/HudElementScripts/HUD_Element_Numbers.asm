
	LDA updateHUD_active
	AND #%10000000
	BEQ ++
	HudUpdateForNumericDisplay #BOX_0_ASSET_0_STRING
	JMP +++
++
	LDA updateHUD_active
	AND #%01000000
	BEQ ++
	HudUpdateForNumericDisplay #BOX_0_ASSET_1_STRING
	JMP +++
++
	LDA updateHUD_active
	AND #%00100000
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_2_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00010000
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_3_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00001000
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_4_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%000000100
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_5_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00000010
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_6_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00000001
	BEQ ++

	HudUpdateForNumericDisplay #BOX_0_ASSET_7_STRING
	JMP +++
++


+++
	
DoHudElementNumbersLoop:	
	LDA #BOX_0_ORIGIN_X
	STA tileX
	LDA #BOX_0_ORIGIN_Y
	STA tileY 
	JSR coordinatesToMetaNametableValue
	;; establishes updateNT_pos and updateNT_pos+1
	;;; FIRST, IF this has been tripped, blank all of the values
	LDA updateHUD_ASSET_Y
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC updateHUD_ASSET_X
	CLC 
	ADC hudElementTilesFull
	SEC
	SBC updateHUD_offset
	SEC
	SBC #$01
	STA temp
	
	LDA updateHUD_ASSET_Y
	LSR 
	LSR
	LSR
	STA temp1
	
	LDA updateNT_pos 
	CLC
	ADC temp
	STA updateHUD_fire_Address_Lo
	LDA updateNT_pos+1
	ADC temp1
	ADC #$00
	STA updateHUD_fire_Address_Hi
;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDY updateHUD_offset
;;; temp16 was passed from the HudUpdateForNumericDisplay macro
	LDA (temp16),y
	CLC
	ADC #HUD_TILES_START
	CLC
	ADC #$10 ;; alphanumeric offset
	STA updateHUD_fire_Tile
	INC updateHUD_offset
	LDA updateHUD_offset
	SEC
	SBC #$01
	CMP hudElementTilesFull
	BEQ doneWithThisHudElement2
	LDA update_screen
	AnD #%10000000
	BEQ screenNotOffForHud3Update
	
	LDA updateHUD_fire_Address_Hi
	STA $2006
	LDA updateHUD_fire_Address_Lo
	STA $2006
	LDA updateHUD_fire_Tile
	STA $2007
	
	JMP DoHudElementNumbersLoop
screenNotOffForHud3Update:
	LDA #$01
	STA ActivateHudUpdate
	RTS
doneWithThisHudElement2
	;; if we're done...	
	LDA #$00
	STA value
	STA value+1
	STA value+2
	STA value+3
	STA value+4
	STA value+5
	STA value+6
	STA value+7

	LDA #$00
	STA tileCollisionFlag
	
	LDA DrawHudBytes
	AND updateHUD_inverse
	STA DrawHudBytes
	LDA #$00
	STA updateHUD_offset
	STA ActivateHudUpdate
	JMP HandleHudData
	RTS
	
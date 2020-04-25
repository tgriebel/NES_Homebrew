
	LDA update_screen
	AnD #%10000000
	BNE doUpdateHudElementText
	RTS
doUpdateHudElementText:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA updateHUD_active
	AND #%10000000
	BEQ ++
	AssignHudLabel #BOX_0_ASSET_0_STRING
	JMP +++
++
	LDA updateHUD_active
	AND #%01000000
	BEQ ++
	AssignHudLabel #BOX_0_ASSET_1_STRING
	JMP +++
++
	LDA updateHUD_active
	AND #%00100000
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_2_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00010000
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_3_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00001000
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_4_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%000000100
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_5_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00000010
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_6_STRING
	JMP +++
++

	LDA updateHUD_active
	AND #%00000001
	BEQ ++

	AssignHudLabel #BOX_0_ASSET_7_STRING
	JMP +++
++

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DoHudElementAssetDirectLoop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+++
	
	;; screen is turned off.
	;; so do update this asset.
	LDA #BOX_0_ORIGIN_X
	STA tileX
	LDA #BOX_0_ORIGIN_Y
	STA tileY 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	STA temp
	LDA updateHUD_ASSET_Y
	LSR 
	LSR
	LSR
	STA temp1
	
	LDA #$00
	STA hudTileCounter
	
;;; NOW DO IMAGE LOOP:

DoHudElementTextDirectLoop:

	LDA updateNT_pos 
	SEC
	SBC hudTileCounter  ;; using this for rows / handling offset.
	CLC
	ADC updateHUD_offset
	CLC
	ADC temp
	STA updateHUD_fire_Address_Lo
	LDA updateNT_pos+1
	;CLC;
	ADC temp1
	ADC #$00
	STA updateHUD_fire_Address_Hi
	
	LDA updateHUD_POINTER
	sta temp16
	LDA updateHUD_POINTER+1
	STA temp16+1
	LDY updateHUD_offset
	LDA (temp16),y

	;JMP writeThisValue
	CMP #$FE ;; should we go down a line?
	BNE dontSkipLineInHudImageOrText2
	;; do skip a line in hud image or text
	LDA updateNT_pos
	CLC
	ADC #$20
	STA updateNT_pos
	inc updateHUD_offset
	LDA updateHUD_offset
	STA hudTileCounter
	JMP DoHudElementTextDirectLoop
dontSkipLineInHudImageOrText2:
	
	CMP #$FF
	BEQ doneWithHudElementTextDirect
writeThisValue2:
	CLC
	ADC #HUD_TILES_START
	STA updateHUD_fire_Tile
	INC updateHUD_offset
	

	LDA $2002
	LDA updateHUD_fire_Address_Hi
	STA $2006
	LDA updateHUD_fire_Address_Lo
	STA $2006
	LDA updateHUD_fire_Tile
	STA $2007
	JMP DoHudElementTextDirectLoop
doneWithHudElementTextDirect:
	LDA #$00
	STA updateHUD_offset
	
	LDA DrawHudBytes
	AND updateHUD_inverse
	STA DrawHudBytes
	LDA #$00
	STA updateHUD_offset
	STA ActivateHudUpdate	
	JMP HandleHudData
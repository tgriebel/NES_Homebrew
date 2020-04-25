HandleHudData:

	LDA textboxHandler
	BEQ +
	RTS
+
	;; we may have to test to see if any other tiles are updating this frame.
	;; and skip if there are tiles updating.
	;; NOW let's find which element might be updating.
	LDA ActivateHudUpdate
	BEQ + ;; hud is not currently being updated
	;; HUD IS being currently activated
	JMP UpdateHudTiles
+ 
	;;;;;;;;;;;;;;;;;; FIRST, reset values:
	LDA #$00
	STA updateCHR_counter
	STA updateCHR_offset
	
;;; CHECK FIRST ELEMENT
	LDA DrawHudBytes
	AND #%10000000 
	BEQ +
	;; do first element
	LDY #$00
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_0_STRING
	STA updateHUD_STRING
	LDA #BOX_0_ASSET_0_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_0_STRING
	JMP UpdateHudTiles
+
;;; CHECK SECOND ELEMENT
	LDA DrawHudBytes
	AND #%01000000 
	BEQ +
	;; do second element
	LDY #$01
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_1_STRING
	STA updateHUD_STRING
	LDA #BOX_0_ASSET_1_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_1_STRING
	JMP UpdateHudTiles
+
+++++
;;; CHECK THIRD ELEMENT
	LDA DrawHudBytes
	AND #%00100000 
	BEQ +
	;; do third element
	LDY #$02
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_2_STRING
	STA updateHUD_STRING
	LDA #BOX_0_ASSET_2_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_2_STRING
	JMP UpdateHudTiles
+
;;; CHECK FOURTH ELEMENT
	LDA DrawHudBytes
	AND #%00010000
	BEQ +
	;; do fourth element
	LDY #$03
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_3_STRING
	STA updateHUD_STRING
	LDA #BOX_0_ASSET_3_STRING
		LDA #BOX_0_ASSET_3_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_3_STRING
	JMP UpdateHudTiles
+
;;; CHECK FIFTH ELEMENT
	LDA DrawHudBytes
	AND #%00001000 
	BEQ +
	;; do fifth element
	LDY #$04
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_4_STRING
	STA updateHUD_STRING
		LDA #BOX_0_ASSET_4_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_4_STRING
	JMP UpdateHudTiles
+
;;; CHECK SIXTH ELEMENT
	LDA DrawHudBytes
	AND #%00000100 
	BEQ +
	;; do sixth element
	LDY #$05
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_5_STRING
	STA updateHUD_STRING	
	LDA #BOX_0_ASSET_5_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_5_STRING
	JMP UpdateHudTiles
	
+
;;; CHECK SEVENTH ELEMENT
	LDA DrawHudBytes
	AND #%00000010
	BEQ +
	;; do seventh element
	LDY #$06
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_6_STRING
	STA updateHUD_STRING
		LDA #BOX_0_ASSET_6_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_6_STRING
	JMP UpdateHudTiles
+
;;; CHECK EIGHTH ELEMENT
	LDA DrawHudBytes
	AND #%00000001 
	BEQ +
	;; do eigthth element.
	LDY #$07
	JSR LoadHudElementInfo
	LDA #BOX_0_ASSET_7_STRING
	STA updateHUD_STRING
		LDA #BOX_0_ASSET_7_IMAGE
	STA updateHUD_IMAGE
	HudUpdateForNumericDisplay #BOX_0_ASSET_7_STRING
	JMP UpdateHudTiles
+
	
	;; end of checking element bits.
	RTS
	
	
	
UpdateHudTiles:
	
	;;; one of the hud bits was flipped.
	;;; now we have all the necessary data to do the update
	;;; FIRST check the type of asset.
	LDA updateHUD_ASSET_TYPE
	BEQ + ;; is not zero asset type
	JMP notHudElement0
+
	;;;; generally, this is for the Var Image type.
	.include SCR_HUD_ELEMENT_0
	;;; rts is in the script
notHudElement0:
	CMP #$01
	BEQ +
	JMP notHudElement1
+

	.include SCR_HUD_ELEMENT_1
	;; rts is in the script
notHudElement1:
	CMP #$02
	BEQ +
	JMP notHudElement2
+
	.include SCR_HUD_ELEMENT_2
	;; rts is in the script
notHudElement2:
	;;; elements 1 and 2 have no mid-frame updates.
	CMP #$03
	BEQ +
	JMP notHudElelement3
+
	.include SCR_HUD_ELEMENT_3 
	;;; rts is in the script
	
notHudElelement3:

HandleHudData_direct:


SkipHandleHudData:

	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
LoadHudElementInfo:
	;;; hud element loaded into y.
	LDA HudActive,y
	STA updateHUD_active
	LDA HudInverse,y
	STA updateHUD_inverse
	LDA HudAssetTypes,y
	STA updateHUD_ASSET_TYPE
	LDA HudAssetX,y
	STA updateHUD_ASSET_X
	LDA HudAssetY,y
	STA updateHUD_ASSET_Y
	;LDA HudImage,y
	;STA updateHUD_IMAGE
	LDA HudBlank,y
	STA updateHUD_BLANK
	LDA HudRow,y
	STA updateHUD_ROW
	LDA HudColumn,y
	STA updateHUD_COLUMN
	LDA HudMaxValue,y
	STA hudElementTilesFull
	RTS
	
	
	
	
	
GetHudDrawPositionAndOffset:
	;; keep in mind, a HUD will always be in the first nametable.
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
	STA temp
	ORA updateHUD_ASSET_X
	STA temp
	
	LDA updateHUD_ASSET_Y
	LSR 
	LSR
	
	STA temp1
	
	LDA updateNT_pos 
	CLC
	ADC temp
	CLC
	ADC updateHUD_offset
	STA updateHUD_fire_Address_Lo
	LDA updateNT_pos+1
	ADC temp1
	STA updateHUD_fire_Address_Hi
	RTS
	
	
	
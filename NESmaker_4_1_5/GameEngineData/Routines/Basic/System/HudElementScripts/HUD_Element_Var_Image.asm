	;; IS ZERO ASSET TYPE, which is VARIABLE TILES.
	;; Think of this type like a heart health meter or a ammo meter.
	JSR GetHudDrawPositionAndOffset
	;;;; Here, we will check to see if this is happening when screen is off, which means 
	;;;; it's a direct load, or if it is happening between frames during the NMI.
	LDA update_screen
	AND #%10000000
	BNE DoScreenOffHudUpdate
	JMP DoScreenOnHudUpdate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DoScreenOffHudUpdate:
	LDX player1_object
	LDA Object_health,x
    STA myHealth


	STA hudElementTilesToLoad
	LDA #$00
	STA hudElementTilesMax
screenOffLoop
	JSR GetHudDrawPositionAndOffset
	;; now we can just fire these away without waiting for the NMI.
	LDA hudElementTilesMax
	CMP hudElementTilesFull
	BEQ doneWithThisHudElement
	LDA hudElementTilesToLoad
	BEQ FinishWithBlankGraphics2
	DEC hudElementTilesToLoad
	LdA updateHUD_IMAGE
	JMP gotHudElementImage2
FinishWithBlankGraphics2:	
	LDA updateHUD_BLANK
gotHudElementImage2:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLC
	ADC #HUD_TILES_START
	STA updateHUD_fire_Tile
	
	LDA updateHUD_fire_Address_Hi
	STA $2006

	LDA updateHUD_fire_Address_Lo	
	STA $2006
	LDA updateHUD_fire_Tile
	STA $2007
	
	INC updateHUD_offset
	INC hudElementTilesMax
	JMP screenOffLoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DoScreenOnHudUpdate
	;;; Check to see if this is full.
	LDA hudElementTilesMax
	CMP hudElementTilesFull
	BEQ doneWithThisHudElement
	;; not done with this element.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FIGURE TILE TO DrawHudBytes
	LDA player1_object
	CMP #$FF ;; this would mean he's dead.
			;;; if he's dead, fill with empty tiles.
	BEQ FinishWithBlankGraphics
	LDA hudElementTilesToLoad
	BEQ FinishWithBlankGraphics
	DEC hudElementTilesToLoad
	LdA updateHUD_IMAGE
	JMP gotHudElementImage
FinishWithBlankGraphics:	
	LDA updateHUD_BLANK
gotHudElementImage:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	CLC
	ADC #HUD_TILES_START

	STA updateHUD_fire_Tile
	INC updateHUD_offset
	INC hudElementTilesMax
	LDA #$01
	STA ActivateHudUpdate
	RTS
doneWithThisHudElement:
	LDA DrawHudBytes
	AND updateHUD_inverse
	STA DrawHudBytes
	LDA #$00
	STA updateHUD_offset
	STA ActivateHudUpdate
	JMP HandleHudData
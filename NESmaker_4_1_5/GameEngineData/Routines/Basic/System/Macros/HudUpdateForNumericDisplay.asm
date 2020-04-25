MACRO HudUpdateForNumericDisplay arg0	
		LDA updateHUD_ASSET_TYPE
		CMP #$03
		BEQ isNumericAssetType
		JMP skipNumericAssetType

	isNumericAssetType:	
	;; this sets the update to the right variable
		LDA #<arg0
		STA temp16
		LDA #>arg0
		STA temp16+1

	skipNumericAssetType:
	ENDM	
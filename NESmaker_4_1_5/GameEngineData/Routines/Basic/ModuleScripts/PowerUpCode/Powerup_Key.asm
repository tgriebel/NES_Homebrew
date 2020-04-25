;;; blank powerup code

	LDA myKeys
	CLC
	ADC #$01
	CMP #$0A
	BCS noMoreKeys
	STA myKeys
	

;;;;;;;;;;;;; UPDATE HUD

		
		LDA #$01 ;; amount of score places?
		STA hudElementTilesToLoad
		; LDA DrawHudBytes
		; ORA #HUD_myKeys
		; STA DrawHudBytes
		
	UpdateHud HUD_myKeys
;;; trigger screen so it enteres triggered mode
;; and you can't continue to get the key again
	
	TriggerScreen screenType
	
noMoreKeys:
	PlaySound #SFX_GET_KEY
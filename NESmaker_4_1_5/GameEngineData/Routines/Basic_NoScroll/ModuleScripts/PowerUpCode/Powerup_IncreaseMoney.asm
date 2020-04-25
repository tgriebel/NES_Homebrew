;;; blank powerup code

	LDA myMoney+2
	CLC
	ADC #$01
	CMP #$0A
	BCS noMoreMoney
	
	AddValue #$03, myMoney, #$01, #$00
	

;;;;;;;;;;;;; UPDATE HUD

		
		LDA #$01 ;; amount of score places?
		STA hudElementTilesToLoad
		; LDA DrawHudBytes
		; ORA #HUD_myMoney
		; STA DrawHudBytes
	UpdateHud HUD_myMoney
;;; trigger screen so it enteres triggered mode
;; and you can't continue to get the key again
	
	;TriggerScreen screenType
	
noMoreMoney:
	PlaySound #SFX_GET_COIN
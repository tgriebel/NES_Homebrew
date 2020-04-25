;;; assumes myHealth variable
;;; if a different variable should handle health
;;; change thename of myHealth.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; uses timers set in GameData\Constants:
;;OBJECT TIMERS
;HURT_TIMER = #$08
;INVINCIBILITY_TIMER = #$08
;RECOIL_SPEED_HI = #$06
;RECOIL_SPEED_LO = #$00

;;;; To change invincibility time, knock back speed, or hurt duration
;;;; updating the abovevalues in constants.

	LDA Object_health,x
	SEC
	SBC #$01 ;; subtract other's strength
	CMP #$01
	BCS notPlayerDeath
	
	PlaySound #SND_HURT_PLAYER
	JSR HandlePlayerDeath
	JMP doneWithPlayerHurt

notPlayerDeath:
	STA Object_health,x
	STA myHealth
	
	STA hudElementTilesToLoad
		LDA #$00
		STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myHealth
		; STA DrawHudBytes
	UpdateHud HUD_myHealth
    ;; TURN ON handling the hud
	
	LDA Object_status,x
	ORA #%00000001
	STA Object_status,x	

	LDA #HURT_TIMER
	STA Object_timer_0,x
	ChangeObjectState #$00,#$02 ;; uses idle for hurt state.
	
	LDA selfCenterX
	STA recoil_selfX
	LDA selfCenterY
	STA recoil_selfY
	LDA otherCenterX
	STA recoil_otherX
	LDA otherCenterY
	STA recoil_otherY
	
	JSR DetermineRecoilDirection


	;;;;; SCROLLER CAN NOT MAKE USE OF UPDATING HUD THIS WAY.


	
doneWithPlayerHurt:
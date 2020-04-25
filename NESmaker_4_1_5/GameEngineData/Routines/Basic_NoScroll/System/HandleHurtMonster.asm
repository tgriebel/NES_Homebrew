;;; what should we do with the monster?
		LDA Object_status,x
		AND #HURT_STATUS_MASK
		BEQ dontskipHurtingMonster
		JMP skipHurtingMonster
	dontskipHurtingMonster:
		LDA Object_status,x
		ORA #%00000001
		STA Object_status,x
		LDA #HURT_TIMER
		STA Object_timer_0,x
		;;; assume idle is in step 0
		ChangeObjectState #$00,#$02
		;;;; unfortunately this recoil is backwards
		LDA Object_status,x
		AND #%00000100
		BNE skipRecoilBecauseOnEdge
		LDA selfCenterX
		STA recoil_otherX
		LDA selfCenterY
		STA recoil_otherY
		LDA otherCenterX
		STA recoil_selfX
		LDA otherCenterY
		STA recoil_selfY
		JSR DetermineRecoilDirection
	skipRecoilBecauseOnEdge:
		LDA Object_health,x
		SEC
		SBC #$01
		CMP #$01
		BCS notMonsterDeath
		DeactivateCurrentObject
		
		;;;;;;;;;;;;;;;;;; ok, so now we also add points to score
		;LDY Object_type,x
		;LDA ObjectWorth,y
		;STA temp
;		AddValue #$03, GLOBAL_Player1_Score, temp
				;arg0 = how many places this value has.
				;arg1 = home variable
				;arg2 = amount to add ... places?
		;; and this should trip the update hud flag?
		
		;;;; 
		
		;LDA GLOBAL_Player1_Score
;		LDA #$05 ;; amount of score places?
;		STA hudElementTilesToLoad
;		LDA DrawHudBytes
;		ORA HUD_updateScore	
;		STA DrawHudBytes

		UpdateHud HUD_updateScore
		JMP skipHurtingMonster
	notMonsterDeath
		STA Object_health,x
	skipHurtingMonster:
		LDX tempx
		;; what should we do with the projectile?
		DeactivateCurrentObject
;;; what should we do with the monster?
        ;;; monster is loaded in x
        LDA Object_vulnerability,x
        AND #%00000100 ;; is it weapon immune?
        BEQ notWeaponImmune
        ;PlaySound #SFX_MISS
        JMP skipHurtingMonsterAndSound
    notWeaponImmune:
        
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
        LDA Object_vulnerability,x
        AND #%00001000 
        BNE skipRecoilBecauseOnEdge ;; skip recoil because bit is flipped to ignore recoil
        
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
        BCC +
		JMP notMonsterDeath
	+

        DeactivateCurrentObject
        PlaySound #SND_SPLAT
        ;;;;;;;;;;;;;;;;;; ok, so now we also add points to score
        ;LDY Object_type,x
        ;LDA ObjectWorth,y
        ;STA temp
;       AddValue #$03, GLOBAL_Player1_Score, temp
                ;arg0 = how many places this value has.
                ;arg1 = home variable
                ;arg2 = amount to add ... places?
        ;; and this should trip the update hud flag?
        
        ;;;; 
    

	TXA
	STA tempx

	AddValue #$08, myScore, #$01, #$00

	;STA hudElementTilesToLoad
	;	LDA #$00
	;	STA hudElementTilesMax
		; LDA DrawHudBytes
		; ora #HUD_myScore
		; STA DrawHudBytes
	UpdateHud HUD_myScore
	LDX tempx

        JSR HandleDrops
        JSR HandleToggleScrolling
		
		CountObjects #$00001000, #$00
		BEQ +
		JMP ++
	+
		.include SCR_KILLED_LAST_MONSTER
	++
        
        JMP skipHurtingMonster
    notMonsterDeath
        STA Object_health,x
    skipHurtingMonster: 
        ;PlaySound #SFX_MONSTER_HURT
    
    skipHurtingMonsterAndSound:
        LDX tempx
        ;; what should we do with the projectile?
        DeactivateCurrentObject
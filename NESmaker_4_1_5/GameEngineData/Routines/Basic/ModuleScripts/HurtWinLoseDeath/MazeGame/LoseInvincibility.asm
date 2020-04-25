;; Lose invincibility
	TXA
	STA tempx
	PlaySound #SND_POWERDOWN
	LDX player1_object
	ChangeObjectState #$00, #$04 ; change to normal state
	;;; set all monsters to scared state.
	LDX #$00
doMonsterNormalloop:
	LDA Object_status,x
	AND #%10000000
	BEQ + ;; not active
	LDA Object_flags,x
	AND #%00001000
	BEQ + ;; not a monster
	;;; is an active monster
	ChangeObjectState #$00, #$04 ;; change to the scared state.
+ ;; skip this monster.
	INX
	CPX #TOTAL_MAX_OBJECTS
	BEQ doneMonsterNormalLoop
	JMP doMonsterNormalloop
doneMonsterNormalLoop:
	
	LDX tempx
	
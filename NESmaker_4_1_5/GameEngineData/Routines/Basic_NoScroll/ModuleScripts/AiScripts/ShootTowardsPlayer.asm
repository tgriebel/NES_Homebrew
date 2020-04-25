;; shoot towards player.

	TXA
	STA tempx
	
	;; get offset
    LDA Object_x_hi,x
	;CLC
	;ADC #$04 ;; arbitrary...would put an 8x8 proj in the center of a 16x16 object
    STA temp1
	
    LDA Object_y_hi,x
	CLC
	ADC #$10
    STA temp2

    CreateObject temp1, temp2, #OBJ_MONSTER_PROJECTILE, #$00, currentNametable ;; maybe use a different state for ignore physics?
	LDA #$00
	STA Object_movement,x
	;; we will skip traditional movement 
	;; and use direct speed instead.
	;; will this cause deacceleration?
	;; what we need is a bit to "ignore physics engine" which will ignore acc/dec
	
	LDA Object_x_hi,x

	STA temp
	LDA Object_y_hi,x

	STA temp2
	TXA
	STA tempz ;; store the newly created object's x
	;; shoot at player one - if there are two players, will we randomize somhow?
	LDX player1_object
	LDA Object_x_hi,x
	STA temp1
	LDA Object_y_hi,x
	STA temp3
	LDX tempz ;; restore newly created projectile object.

	JSR MoveTowardsPlayer 
	LDX tempz

	LDA myHvel
	
	STA Object_h_speed_lo,x
	LDA #$00
	STA Object_h_speed_hi,x
	LDA myVvel
	STA Object_v_speed_lo,x
	LDA #$00
	STA Object_v_speed_hi,x
	
	
gotVAimSpeeds:	
	
	
	LDX tempx
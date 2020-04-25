 LDA gameHandler
 AND #%00100000
 BEQ notNPCstate_attack
 JMP doneAttacking
notNPCstate_attack
 LDA weaponsUnlocked
 AND #%00000001
 BNE canAttack
 JMP doneAttacking
canAttack:
LDX player1_object
 GetCurrentActionType player1_object

 CMP #$02
 BNE notAlreadyAttacking 
 JMP doneAttacking
notAlreadyAttacking
 ;;; don't attack if already attacking.
 ;;; do we have to check for hurt here?
 ;;;;; Here, we WOULD create melee
 ChangeObjectState #$02, #$02
 LDA Object_movement,x
 AND #%00001111
 STA Object_movement,x
 LDA #$00
 STA Object_h_speed_hi,x
 STA Object_h_speed_lo,x
 STA Object_v_speed_hi,x
 STA Object_v_speed_lo,x
 
 LDA Object_x_hi,x
 STA temp
 LDA Object_y_hi,x
 STA temp1
 
 LDA Object_movement,x
 AND #%00000111
 STA temp2
 AND #%00000010 ;; this will be 0 on up and down, but 1 on left right
 BNE createLRmelee
    LDA temp2
    TAY
    LDA temp
    SEC
    SBC #$08 ;; width of weapon
    CLC
    ADC weaponOffsetTableX,y
    STA temp
    LDA temp1
    SEC
    SBC #$10
    CLC
    ADC weaponOffsetTableY,y
    STA temp1
 
  CreateObject temp, temp1, #$01, #$00
  JMP meleeCreated
createLRmelee:
    LDA temp2
    TAY
    LDA temp
    SEC
    SBC #$10 ;; width of weapon
    CLC
    ADC projOffsetTableX,y
    STA temp
    LDA temp1
    SEC
    SBC #$08
    CLC
    ADC projOffsetTableY,y
    STA temp1
 CreateObject temp, temp1, #$02, #$00
meleeCreated:
    ;;;; x is now the newly created object's x.
    LDA Object_movement,x
    ORA temp2
    STA Object_movement,x
    PlaySound #sfx_slash
doneAttacking:

RTS


;;000 down
;010 right
;100 up
;110 left
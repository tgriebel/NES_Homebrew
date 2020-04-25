 LDA gameHandler
    AND #%00100000
    BEQ notNPCstate_proj
 JMP doneShooting
 notNPCstate_proj
 LDA weaponsUnlocked
 AND #%00000010
 BNE canShoot
 JMP doneShooting
canShoot:
LDX player1_object
 GetCurrentActionType player1_object


 CMP #$02
 BNE notAlreadyShooting
 JMP doneShooting 
notAlreadyShooting
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
 ;;; offset x for creation
 CLC
 ADC #$04
 STA temp
 LDA Object_y_hi,x
 CLC
 ADC #$04
 STA temp1
 
 LDA Object_movement,x
 AND #%00000111
 STA temp2

 
    CreateObject temp, temp1, #$03, #$00
  
    ;;;; x is now the newly created object's x.
    LDA Object_movement,x
    ORA temp2
    STA Object_movement,x
    LDY temp2
    LDA directionTable,y
    ORA Object_movement,x
    STA Object_movement,x
      PlaySound #sfx_shoot
doneShooting:

RTS


;;000 down
;010 right
;100 up
;110 left
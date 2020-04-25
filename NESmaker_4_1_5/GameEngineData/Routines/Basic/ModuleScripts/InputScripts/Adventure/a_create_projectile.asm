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


 CMP #$03
 BNE notAlreadyShooting
 JMP doneShooting 
notAlreadyShooting
 ;;; don't attack if already attacking.
 ;;; do we have to check for hurt here?
 ;;;;; Here, we WOULD create melee
 ChangeObjectState #$03, #$02
 LDA Object_movement,x
 AND #%00001111
 STA Object_movement,x
 LDA #$00
 STA Object_h_speed_hi,x
 STA Object_h_speed_lo,x
 STA Object_v_speed_hi,x
 STA Object_v_speed_lo,x
 
    LDA Object_movement,x
    AND #%00000111
    STA temp2
    TAY ;; now y contains direction, so we can figure out position offset
    
     LDA Object_x_hi,x
     ;;; offset x for creation
     CLC
     ADC weaponOffsetTableX,y
     SEC
     SBC xScroll
     SEC 
     SBC #$08 ;; width of gun 
     STA temp
     LDA Object_y_hi,x
     CLC
     ADC weaponOffsetTableY,y
     sec
     sbc #$08 ;; height of gun
     STA temp1

 
    CreateObject temp, temp1, #OBJ_PLAYER_PROJECTILE, #$00, currentNametable
  
    ;;;; x is now the newly created object's x.
    LDA Object_movement,x
    ORA temp2
    STA Object_movement,x
    LDY temp2
    LDA directionTable,y
    ORA Object_movement,x
    STA Object_movement,x
     PlaySound #SND_SHOOT
doneShooting:

RTS


;;000 down
;010 right
;100 up
;110 left
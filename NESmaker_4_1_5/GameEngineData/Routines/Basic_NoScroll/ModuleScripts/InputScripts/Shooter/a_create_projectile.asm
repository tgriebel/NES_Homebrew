
    LDX player1_object
    GetCurrentActionType player1_object
    CmP #$01
    BNE notAlreadyShooting
    JMP doneShooting 
notAlreadyShooting

     ChangeObjectState #$01, #$02
     LDA #%00000010
    TAY ;; now y contains direction, so we can figure out position offset
    
     LDA Object_x_hi,x
     ;;; offset x for creation
     CLC
     ADC weaponOffsetTableX,y
     ; SEC
     ; SBC xScroll
     SEC 
     SBC #$08 ;; width of gun 
     STA temp
     LDA Object_y_hi,x
     CLC
     ADC weaponOffsetTableY,y
     sec
     sbc #$08 ;; height of gun
     STA temp1

     LDA Object_scroll,x
     STA temp2
 
     CreateObject temp, temp1, #OBJECT_PLAYER_PROJECTILE, #$00, temp2
  
    ;;;; x is now the newly created object's x.
    LDA #%11000010
    STA Object_movement,x
    PlaySound #SND_SHOOT
doneShooting:

RTS

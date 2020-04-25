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
     CMP #$01
     BNE notAlreadyAttacking 
     JMP doneAttacking
notAlreadyAttacking
     ;;; don't attack if already attacking.
     ;;; do we have to check for hurt here?
     ;;;;; Here, we WOULD create melee
     ChangeObjectState #$01, #$02
     LDA Object_physics_byte,x
     AND #%00000001
     BNE + ;; if in air, don't *stop*
     LDA Object_movement,x
     AND #%00001111
     STA Object_movement,x

     LDA #$00
     STA Object_h_speed_hi,x
     STA Object_h_speed_lo,x
     STA Object_v_speed_hi,x
     STA Object_v_speed_lo,x
 +
doneAttacking:

    RTS



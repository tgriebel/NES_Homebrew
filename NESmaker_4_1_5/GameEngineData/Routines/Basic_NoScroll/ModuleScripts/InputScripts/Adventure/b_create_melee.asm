    LDA textboxHandler
    AND #%00010000 ;; if the b button is pressed
                    ;; but the box + text have been activated
                    ;; and also the 'do box' bit is OFF
                    ;; that means this is ready to "go away".
                    
    BEQ checkToTurnTheTextboxOn ;; hasn't started yet
    
    ;; begin turning the textbox off.
    LDA gameHandler
    ORA #%00100000
    STA gameHandler
    ;;; are we turning this on or off?
    ;;; check for more
    ;;; check for 'choice'.
  
    LDA #$00
    STA updateNT_offset
    STA updateNT_H_offset
    STA updateNT_V_offset
    
    LDA #%10001000
    STA textboxHandler
    RTS
   
checkToTurnTheTextboxOn:  
    LDA npc_collision
    BEQ noNPCcollision
    LDA textboxHandler
    AND #%10000000
    BNE noNPCcollision
   LDA gameHandler
    ORA #%00100000
    STA gameHandler
    ;;; are we turning this on or off?
    ;;; check for more
    ;;; check for 'choice'.
 
    PlaySound #SND_TEXTBOX
turnTheTextboxOn:
  
    LDA #%10000000
    STA textboxHandler
    Rts
noNPCcollision:
   
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
 
    PlaySound #SND_ATTACK
doneAttacking:

RTS


;;000 down
;010 right
;100 up
;110 left
       
       

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
  ; LDA npc_collision
  ;  BEQ noNPCcollision
       LDA textboxHandler
      AND #%10000000
     BNE noNPCcollision
   LDA gameHandler
    ORA #%00100000
    STA gameHandler
    ;;; are we turning this on or off?
    ;;; check for more
    ;;; check for 'choice'.
  
   ; StopSound
  ;  LDA #$ff
  ;  STA currentSong
    PlaySound #SND_TEXTBOX
turnTheTextboxOn:
  
    LDA #%10000000
    STA textboxHandler
    
noNPCcollision:
    RTS
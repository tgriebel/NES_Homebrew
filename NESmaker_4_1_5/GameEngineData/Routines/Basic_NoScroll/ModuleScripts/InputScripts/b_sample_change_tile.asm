;;; sample change tiles script. 

   ; JMP RESET
   ChangeAllTiles #COL_INDEX_LOCK, #$00, #$00, #$00
   ChangeAllTiles #COL_INDEX_LOCK, #$00, #$00, #$00
    ChangeAllTiles #COL_INDEX_LOCK, #$00, #$00, #$01
    ;  LDA screenType
    ;  STA temp
    ; TriggerScreen temp
   ;;; change all tiles to:
   ;;; What collision objects are you looking to change?
   ;;; What collision should it change to? 
   ;;; Which is what meta tile?
   ;;; can we just run the loop from here?
    
   RTS
  LDA #STATE_START_GAME
  STA change_state
  
  ;StopSound
  ;PlaySound #$00, $00

  LDA #%10000000
  STA gameHandler ;; turn sprites on
  RTS
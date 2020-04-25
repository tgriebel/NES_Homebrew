;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 1: Prepare the game for a state change.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDA #STATE_START_GAME
  STA change_state
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 2: If a sound is playing and you want it to stop,
;; or if you'd like to play a sound effect to designate
;; the button press, you can do that here;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;StopSound
  ;PlaySound #$00, $00
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 3: Turn on sprites;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDA #%10000000
  STA gameHandler ;; turn sprites on
  RTS
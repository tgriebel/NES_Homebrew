;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 1: Stop the player's movement
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDX player1_object
    StopMoving player1_object, STOP_UP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 2: Check states.
;; If there are any states in which we want
;; letting go to not return us to idle, we can put them here.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; GetCurrentActionType player1_object
	; CMP #$01 ;; if we wanted action state 1 to 
				;; not return to idle when buttn is released.
	; BEQ + ;; skips changing to idle.
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 3: Change to idle
;; If this has not been skipped in part 2, 
;; the object will change to idle upon letting go of
;; this dpad button.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ChangeObjectState #$00, #$04  
+ ;; if change to idle was skipped.
    RTS
;; HANDLE FACING DIRECTION.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;WHICH STATES SHOULD PLAYER IGNORE DIRECTION CHANGES?
;;IF DIRECTION SHOULD BE IGNORED, SKIP DIRECTION CHANGE.

;; If down is held,
;; Must check left and right for diagonals.
    LDX player1_object
	StopMoving player1_object, STOP_LEFT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE handle actual movement.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHICH STATES SHOULD PLAYER IGNORE BEING ABLE TO UPDATE MOVEMENT?

    RTS
    
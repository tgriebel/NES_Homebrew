 
 ;;;;; START MOVING PLAYER UP:
 ;;;;; We will use this when the UP button is held.
 ;;;;; If we are already showing the walking animation, which is for this module
 ;;;;; action step 1, we will skip changing to the walking state.
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; PART 1: Chek player states
 ;; Are there any states the player might be in where he should not
 ;; move, even if the player is holding the dpad?
 
    LDX player1_object
    GetCurrentActionType player1_object
	CMP #$01 ;; A: the "moving" action state.
			;; if we're already in that state, don't change to it.
			;; not only is it redundant, it'll start the animation over
			;; and get locked into frame one of animation.
			
    BEQ + ;; if the action type already equals 1, jump forward
	;;; Do you want it to be able to move while attacking?
	;;; if you don't want to be able to move while
	;;; attacking, check against the attack state.
	
	;; Jump to + if you just want to skip the change of state.
	;; Jump to ++ if you want to skip change of state AND actual movement.
	
   ; CMP #$02 ;; if the state is attacking
				;; assuming attack state is 2
   ; BEQ ++ ; skip starting movement if attacking

    ChangeObjectState #$01, #$04 ;; B: Change the object state
								;; to A from above.  The first argument
								;; here should match the value in the
								;; first compare above.  This is most likely
								;; the normal movement state (walking/running)
								
+ ;; skipped the change of state.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Then, we will begin moving.
    StartMoving player1_object, MOVE_UP
++ ;; skipped the start movement.
;;;;;; Lastly, we will change the facing direction.
	;; comment out if you do not want this dpad push to change
	;; the facing direction.
    FaceDirection player1_object, FACE_UP
    RTS
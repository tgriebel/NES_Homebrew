MACRO CreateObject arg0, arg1, arg2, arg3, arg4  ;; arg 3 = action step?
	
	;arg0 x value
	;arg1 y value
	;arg2 object type
	;arg3 action step - great for creating a 'spawning' effect that is non-zero
						;; or even for creating projectiles that may behave differently, where
						;; a single projectile could have 8 action types that are different, and 
						;; could load that particular action step, which could show a unique animation
						;; with specialized behaviors?  Just a thought.
	; arg 4 - Object_scroll (nametable...current, left or right)
						
	;; first, find a free space

	JSR FindEmptyObjectSlot
	CPX #$FF
	BEQ noFreeSlotsForNewObject
	;; we will do things like create object indirectly
	;; because they may be called from a routine that is not in the static bank
	;; which will make jumping to the animation bank and back unreliable.
	;; we will give the object it's potential X,Y, and type
	;; and give it a cued status
	LDA arg0
	STA Object_x_hi,x
	LDA arg1
	STA Object_y_hi,x
	LDA arg2
	STA Object_type,x
	;; if type = 0, set this to player
;	BNE isNotPlayerObjectType
	;; if it IS the player, we're going to set 	player1_object thi this slot (which is now x).
;	TXA
;	STA player1_object ;; now for routines involving the player
						;; there is an easy reference, to see if x = player1_object
;isNotPlayerObjectType:
	
	LDA arg4
	STA Object_scroll,x
;	STA Object_home_screen,x ;; this is used to determine if an object should *reload*
	
	LDA #$00
	STA Object_v_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_h_speed_hi,x
	STA Object_movement,x
	
	LDA arg3
	STA Object_action_step,x	

	LDA Object_status,x
	ORA #%01000000 ;; activate
	STA Object_status,x

noFreeSlotsForNewObject:

	ENDM
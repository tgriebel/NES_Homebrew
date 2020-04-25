MACRO StartMoving arg0, arg1
	; arg0 object to move
	; arg1 direction
	
	;; This macro uses the built in physics found in default physics scripts.
	;; Which observes acceleratoin and deceleration as long as bounds and tile collision.
	;; It is not a direct movement, but rather turns on a check for whether or not
	;; the object should move.
	
	;; Keep in mind, this does not alter the facing-direction of the object, just
	;; the actual motion.
	
	;constant definitions for direction are:
		;MOVE_RIGHT	= #%11000000
		;MOVE_LEFT 	= #%10000000
		;MOVE_DOWN	= #%00110000
		;MOVE_UP	= #%00100000
		;               +--------Bit 7 is yes or no to h movement
		;				 +----------- if 1, bit 6 is L (0) or R (1)
		;                 +------Bit 5 is yes or no to v movement
		;                  +--------- if 1, bit 4 is U (0) or D (1)
		;DIAGONALS:
		;MOVE_RIGHT_DOWN = #%11110000
		;MOVE_LEFT_DOWN  = #%10110000
		;MOVE_RIGHT_UP	 = #%11100000
		;MOVE_LEFT_UP	 = #%10100000
		
	
	LDX arg0 ;; get the index for the desired object.
				; Most likely, this will be represented by
				; the variable player1_object.
	LDA #arg1 ;; Load the intended direction for this to move.
	STA Object_movement,x  ;; store the new movement direction to the object's
							;; movement variable.
	ENDM

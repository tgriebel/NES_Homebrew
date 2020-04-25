;;; turn.
;; choose any direction other than the direction currently moving.
;; this is meant to be used with 4-directional moving objects.
	
	LDA #$00
	;STA Object_movement,x
	;
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x

	LDA xPrev
	STA Object_x_hi,x
	LDA yPrev
	STA Object_y_hi,x
	
	;; 000 = down
	;; 001 = down right
	;; 010 = right
	;; 011 = up right
	;; 100 = up
	;; 101 = up left
	;; 110 = left
	;; 111 = down left
	
	JSR TurnDirection
	











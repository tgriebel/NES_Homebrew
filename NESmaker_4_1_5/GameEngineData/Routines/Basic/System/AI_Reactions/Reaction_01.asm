;;; REVERSE DIRECTION
	LDA #$00
	;STA Object_movement,x
	;
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x

	LDA xPrev
	STA xHold_hi
	STA Object_x_hi,x
	LDA yPrev
	STA yHold_hi
	STA Object_y_hi,x
	
	LDA Object_movement,x
	AND #%00000111
	JSR ReverseDirection
	STA temp
	TAY
	LDA DirectionMovementTable,y
	ORA temp
	STA Object_movement,x
	LDA #$00
	STA xHold_lo
	STA yHold_lo
	
	
	LDA Object_animation_offset_speed,x
	JSR getAnimSpeed
	
	LDA #$10
	STA Object_action_timer,x ;; arbitrary 
	
	LDA #$00
	STA Object_animation_frame,x
	

	;; negate the speed for a frame ?

	
	
	
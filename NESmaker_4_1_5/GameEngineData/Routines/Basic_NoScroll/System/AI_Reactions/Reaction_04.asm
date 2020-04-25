	LDA #$00
	;STA Object_movement,x
	;
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	LDA xPrev
	STA Object_x_hi,x
	STA xHold_hi
	LDA yPrev
	STA Object_y_hi,x
	STA yHold_hi
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA xHold_lo
	STA yHold_lo
	LDA screenFlags
	AND #%00000010
	BEQ +
	;LDA screenFlags
	;AND #%00000100 ;; left bounds autoscrolling right
	;BEQ +
	; if autoscrolling, use scroll instead of xPrev 
	;LDA xScroll

;	SEC
;	SBC Object_right,x
;	CLC
;	ADC #$FF
	LDA xPrev
	STA Object_x_hi,x
	STA xHold_hi
	;LDA xScroll_hi
	;ADC #$00
	;STA Object_scroll,x
	;STA nt_hold
	
	JMP doneWithUpdateRightScreen
+
;;; check if side triggers change screen...for instance, if hurt, wouldn't, and would instead return *solid*
	LDA #BOUNDS_LEFT
	CLC
	ADC #$02
	STA Object_x_hi,x
	STA xHold_hi
	STA newX
	
	LDA Object_y_hi,x
	STA newY
		LDA #$00
	STA xHold_lo
	STA yHold_lo
	
	LDA Object_scroll,x
			CLC
			ADC #$01
			STA Object_scroll,x
			STA currentNametable
			STA newScreen
			STA currentScreen ;currentScreen
			STA xScroll_hi
			
			clc
			adc #$01
			STA rightNametable
			SEC
			SBC #$02
			STA leftNametable
			
			LDA Object_scroll,x
			AND #%00000001
			STA showingNametable
			
			
			LDA #$01
			STA screen_transition_type
			
			;LDA warpMap
			;CLC
			;ADC #$01
			;STA update_screen_details
			
			;;; update screen details will not change with left, right, up or down movement
			;;; unless the edge of a map should take you to the other map or something.
			;;; warpMap variable is used solely to hold whether the warp-out is to overworld or underworld.
		
	LDA #$01
	STA tile_solidity		
	LDA #$00
	STA gameHandler
		LDA #%11000000
				;7 = active
				;6 = 8 or 16 px tiles
			ORA #GS_MainGame
			ORA #%01000000
			STA update_screen

doneWithUpdateRightScreen:

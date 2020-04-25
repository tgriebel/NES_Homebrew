
	LDX player1_object

	LDA #BOUNDS_BOTTOM
	SEC
	SBC #$02
	SEC
	SBC Object_bottom,x
	STA yHold_hi
	STA Object_y_hi,x
	STA newY

	LDA Object_x_hi,x
	STA xHold_hi
	STA newX
	
	LDA #$00
	STA yHold_lo
	STA xHold_lo
	


				;7 = active
				;6 = 8 or 16 px tiles
			
			;; warp map should stay the same.
			LDA Object_scroll,x
			sec
			sbc #$10
			STA Object_scroll,x
			STA xScroll_hi
			STA newScreen
			STA currentNametable
			STA currentScreen ;currentScreen
			STA newScreen
			STA nt_hold
		;	clc
		;	adc #$01
		;	STA rightNametable
		;	SEC
		;	SBC #$02
			;STA leftNametable
		
			LDA #$01
			STA screen_transition_type
		
			;LDA warpMap
			;CLC
			;ADC #$01
			;STA update_screen_details
			
			;;; update screen details will not change with left, right, up or down movement
			;;; unless the edge of a map should take you to the other map or something.
			;;; warpMap variable is used solely to hold whether the warp-out is to overworld or underworld.
			LDA Object_scroll,x
			AND #%00000001
			STA showingNametable
			
			
	
	LDA #$00
	STA tile_solidity		
	LDA #$00
	STA gameHandler
	LDA #%11000000
	ORA #GS_MainGame
	ORA #%01000000
	STA update_screen
	
	LDA #$00
	STA xScroll
doneTopmBounds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; factor where to place player compared to his scroll in a given screen
;;	
	
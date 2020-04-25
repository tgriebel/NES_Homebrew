	;; used with macro
		
		LDA temp2
			STA Object_scroll,x
			STA currentNametable
			STA newScreen
			STA currentScreen ;currentScreen
			STA xScroll_hi
			STA nt_hold
			LDA Object_scroll,x
			AND #%00000001
			STA showingNametable
			LDA newX
			STA Object_x_hi,x
			STA xHold_hi
			

	LDA temp1
	STA screen_transition_type
		
	LDA temp3
	;LDA warpMap
	STA update_screen_details
	
	;LDA #$01
	;STA tile_solidity		
	LDA #$00
	STA gameHandler
		LDA #%11000000
				;7 = active
				;6 = 8 or 16 px tiles
			ORA #GS_MainGame
			ORA #%01000000
			STA update_screen
	LDA #$00
	STA xScroll
doneWithWarpToScreen:
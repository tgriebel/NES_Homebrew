HandleDrawingSprites:
	;;; HANDLE HURT FLICKER
	;;;;; if you don't want your objects to flicker when hurt, delete this block
	;;; also look down for another block when drawing y value
	LDA Object_status,x
	BNE objectNotDeactivated
	RTS
objectNotDeactivated:
	
	LDA Object_status,x
	AND #HURT_STATUS_MASK
	BEQ ignoreHurtFlicker
	LDA vBlankTimer
	AND #%00000001
	BEQ ignoreHurtFlicker
	LDA #$01
	STA DrawFlags ;; if DrawFlags is 1, do flicker.  If 0, do not.
	JMP gotFlickerValue
ignoreHurtFlicker:
	LDA #$00
	STA DrawFlags
gotFlickerValue:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; END HANDLE HURT FLICKER
	
	
	;; still at the *object* level right now.
	LDA Object_type,x
	CMP #$10
	BCC dontAddTilesetOffset
	;; this offset is added for monsters.
	LDA #$80
	STA tileset_offset
	JMP gotTilesetOffset
dontAddTilesetOffset:
	LDA #$00
	STA tileset_offset
gotTilesetOffset:
	LDA gameHandler
	AND #%10000000 ;; is updating sprites turned on
	BNE skipGettingStartingOffset
	RTS ;; draw no sprites
skipGettingStartingOffset:
	LDY Object_type,x
	LDA ObjectSize,y
	AND #%00000111
	STA tempy ;; is good for height
	LDA ObjectSize,y
	LSR
	LSR
	LSR 
	STA tempx ;; is good for width.
	STA tempz ;; double up on this one, because we'll need to restore it
			;; and won't have access to tempx anymore
			
	;; we also need to know how far beyond our offset we should be.
	;; this can be calculated by the number of ((tiles x 2) x animation offset).  We can find it with a quick loop.	
	LDA #$00
	STA sprite_tileOffset
	LDA Object_animation_frame,x
	BEQ noNeedToFactorForOffset ;; if it is zero, no need for an offset.
	STA temp2

	LDY Object_type,x
GetFrameOffset:
	LDA Object_total_sprites,y
	ASL
	CLC
	ADC sprite_tileOffset
	STA sprite_tileOffset
	DEC temp2
	LDA temp2
	BNE GetFrameOffset

;;;now temp should contain the offset.
noNeedToFactorForOffset:

	
	
	
	;; we want to cycle forward through the sprites if odd frame, backwards through the sprites if even frame?
	;; first, we need to determine where our starting position is:
	LDA Object_movement,x
	AND #%00000111 ;; this is where we'll store direction
	STA temp
	;;;;;multiply that by 8 (directions) to get the starting point of pointers.
	;; so we have to do a quick look up of the anim speed table.
	;; bits 7654 represent the offset, while 3210 represent the animation speed.
	LDA Object_animation_offset_speed,x
	LSR
	AND #%11111000
	CLC 
	ADC temp
	;;; effectively, we're shifting the offset 4 bits,
	;; but then multiplying it by 8 since each "action offset" is 8 values (one for each direction)
	;; so this is a shortcut.  
	
	TAY
	
	
	
	
	LDA Object_x_hi,x

	STA spriteDrawLeft
	
	LDA Object_table_lo_lo,x
	STA temp16
	LDA Object_table_lo_hi,x
	STA temp16+1
	LDA (temp16),y

	STA sprite_pointer
	
	LDA Object_table_hi_lo,x
	STA temp16
	LDA Object_table_hi_hi,x
	STA temp16+1
	LDA (temp16),y
	STA sprite_pointer+1
	

	
	;;;now we have the right grouping for the right direction for the right object.

	;; now, should be able to run right through the values pretty easily.
	;; we're going to pick up wherever the last object left off drawing
	LDA Object_x_hi,x

	STA temp1 ;; this will be used to keep track of horizontal placement, increasing by 8 and 
				;; decreaseing tempx to see if we're out of horizontal spacing.
				clc
				adc Object_origin_x,x
				STA temp3
				
	LDA Object_y_hi,x
	sec
	sbc #$01
	STA temp2	;; this will be used to keep track of vertical placement, increasing by 8 and
				;; decreasing tempy to see if we're out of vertical spacing (ie-done).
				
	CLC
	ADC Object_bottom,x
	SEC
	SBC #$08
	STA temp

;;;; FIND OUT IF THIS SPRITE SHOULD BE DRAWN BEHIND THE BACKGROUND	
	 LDA Object_state_flags,x
	AND #%00100000
	 STA temp3  ;; holds whether or not this object's sprite is drawn behind backgrounds.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TXA
	PHA

	LDY #$00
	LDA (sprite_pointer),y
	STA objectFrameCount
	
	LDX spriteOffset	
	
	LDA sprite_tileOffset  
	CLC 
	ADC #$01
	TAY
DrawSpritesForThisObjectLoop:
	LDA DrawFlags ;; are we flickering?
	BEQ noFlicker
	LDA #$fe
	JMP drawTileOffScreen_flicker
noFlicker:
	LDA temp2 ;; LDA the y value, not drawn off screen
	SEC
	SBC tempZpos
drawTileOffScreen_flicker:
	STA SpriteRam,x ;; store it to the y value byte for this sprite
	INX ;; increase the index to draw to
	LDA (sprite_pointer),y  ;; load the table pointer to the tile number
	CLC
	ADC tileset_offset

	STA SpriteRam,x ;; store to the tile index
	INX ;; increase index
	INY ;; increase the position to read in the table (which alternates tile/attribute)
	LDA temp3
	ORA (sprite_pointer),y ;; load the table pointer to the attribute
	STA SpriteRam,x ;; store it to the attribute index
	INY ;; increase the position to read in the table...this next value is for the next sprite.
	INX ;; increase index
	LdA temp1 ;; load the x value
	STA SpriteRam,x ;; store to the x index
	;;=======================================
	;;;; DONE WITH THIS SPRITE.
	INX  ;; increase index to get ready to draw the next sprite.
	
	DEC tempx ;; decrease the variable holding the width.
	BEQ doneWithSpriteColumns ;; if it is at zero, that means the column is over
	;;; more sprites to draw in this column.
	
	;;;;;;;;;; increase the x value to the next 'column' to draw the next sprite.
		;;;; conceivably, this is where we could put a horizontal offset. 
	LDA temp1 
	CLC
	ADC #$08   ;; each tile is 8 wide.
	STA temp1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JMP DrawSpritesForThisObjectLoop
doneWithSpriteColumns:
	DEC tempy ;; decrease the variable holding height
	BEQ doneDrawingThisObjectsSprites ;; if there is no horizontal, and no vertical tiles left to count
										; then this sprite is done being drawn
	;;; there are still sprites to draw here
	;;; so now, we must:
	LDA tempz
	STA tempx ;; restore the temp size of the column
	;;======= increase the y value by 8px / one tile
	LDA temp2 
	CLC
	ADC #$08
	STA temp2 
	;;==============================================
	;and
	;;======= move horizontal position back all the way to the left
	LDA spriteDrawLeft
	STA temp1
	JMP DrawSpritesForThisObjectLoop
	
doneDrawingThisObjectsSprites:
	TXA
	STA spriteOffset
	;; restore x so we're talking about the right object
	PLA
	TAX
	
	
	JSR getNewEndType
	;;;Handle This object's animation:
	;;; fist, count down the animation timer.
	DEC Object_animation_timer,x
	LDA Object_animation_timer,x
	BNE notAtEndOfFrame
	;; is at end of frame.
	LDA Object_animation_frame,x
	CLC
	ADC #$01
	CMP objectFrameCount
	BNE notTheLastFrameYet
	;; this is the last frame
	;;=========================== check for end animation
	LDA Object_end_action,x
	
	LSR
	LSR
	LSR
	LSR

	BNE checkForEndAnimType

	;;; looping type animation - just reset the frame and continue on.
	LDA #$00
	JMP notTheLastFrameYet 
checkForEndAnimType:
	JSR doMoreThanResetTimer ;; this is in handle update objects
								;;uses the same table as 
								;;action timer end
	LDA #$00 ;; to reset frames.
	;;===================================================
notTheLastFrameYet:
	STA Object_animation_frame,x
		LDA Object_animation_offset_speed,x
		;;; set the initial animation timer
		AND #%00001111 ;; now we have the animation speed value displayed in the tool
						;; are 16 values enough for the slowest?  Or do we want to have multiples?  Or maybe a table read?	
	
		;ASL
		;ASL
		ASL
		STA Object_animation_timer,x

	
notAtEndOfFrame:
	

	
	
	RTS
	
	

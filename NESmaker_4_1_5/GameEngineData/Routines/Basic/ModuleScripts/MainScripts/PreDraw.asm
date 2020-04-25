;; sprite pre-draw
;;; this will allow a user to draw sprites
;;; before object sprites are drawn.
;;; keep in mind, there are still only 64 sprites
;;; that can be drawn on a screen, 
;;; and still only 8 per scan line!

;;; you can use DrawSprite macro directly using the following scheme:
;DrawSprite arg0, arg1, arg2, arg3, arg4
	;arg0 = x
	;arg1 = y
	;arg2 = chr table value
	;arg3 = attribute data
	;arg3 = starting ram position
	
;; x and y are the direct positions on the screen in pixels.
;; chr table value is which sprite you'd like to draw from the ppu table.
;; attribute data is a binary number (starts with #%), and here are how the bits work:
	;;; bit 7 - Flip sprite vertically
	;;; bit 6 - Flip sprite horizontally
	;;; bit 5 - priority (0 in front of background, 1 behind background)
	;;; bit 4,3,2 - (null)
	;;; bit 1,0 - subpalette used (00, 01, 10, 11)
	
	
;;; for starting ram position, use spriteOffset.
;; this is set to 0 just before entering this script (or 4 if sprite 0 hit was used).
;; ***remember to increase spriteOffset by 4 for every sprite that is drawn,
;; including after the last one drawn*****, so that the first object's sprite begins
;; in the next available spot.

;; I have created a macro function to handle updating to the next sprite.  So, to update to the next sprite position,
;; all that you have to do is use the function UpdateSpritePointer

;;EXAMPLE:
; DrawSprite #$80, #$80, #$10, #%00000000, spriteOffset
; UpdateSpritePointer

;;;; DRAW SPRITE ZERO FOR SPRITE ZERO HIT

	LDA gameState
	CMP #GS_MainGame	
	BNE + ;dont draw sprite zero
	LDA #HIDE_HUD
	BNE +
	;DrawSprite #$f8, #$1e, #$7F, #%00000000, spriteOffset
				;248   30    127   bit 5 = priority
	DrawSprite #SPRITE_ZERO_X, #SPRITE_ZERO_Y, #SPRITE_ZERO_INDEX, #%00100000, spriteOffset
	UpdateSpritePointer
;dont draw sprite zero.
+

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	
;;=================== Platform engine
;; In our platform engine, the player can shoot from a 'projectile source'.
;; Since this projectile source does not interact with the background in any way,
;; it is really just a sprite extention of the player, and would be truly foolish to waste
;; an object and processing time on it.  You can, but it would be wasteful.
;; So what we can do instead is use pre-drawn sprites.  If the player is in his attack state,
;; we will check the direction, and then draw the weapon sprite based on which direction he is
;; facing.

	;LDX player1_object ;; we are going to check some player 1 things.
	;;; but getting current action type will set x to this automatically
	JMP doneDrawingWeaponSprite ;;
	GetCurrentActionType player1_object ;; what object is the current player
										;; because if it's attack (3), we should draw weapon.
	CMP #$03
	BNE notAttackingSoDontDrawWeapon
	;;attacking, so draw weapon.
	LDA Object_movement,x
	AND #%00000111
	TAY ;; now y contains direction, so we can figure out position offset
	;CMP #RIGHT
	;BNE directionIsNotRightForDrawingWeapon
	;;; direction is right.
	 LDA Object_x_hi,x
     ;;; offset x for creation
     CLC
     ADC weaponOffsetTableX,y
	 SEC
	 SBC xScroll
     SEC 
     SBC #$08 ;; width of gun 
     STA temp
     LDA Object_y_hi,x
     CLC
     ADC weaponOffsetTableY,y
     sec
     sbc #$08 ;; height of gun
     STA temp1
	 
	 CPY #RIGHT
	 BNE directionIsNotRightForDrawingWeapon
	 ;; it is right, which means draw without flip
	 LDA #%00000001
	 STA temp2
	 JMP doDrawWeapon
directionIsNotRightForDrawingWeapon:
	LDA #%01000001
	STA temp2
doDrawWeapon:
	 
	DrawSprite temp, temp1, #$2c, temp2, spriteOffset
	 JMP doneDrawingWeaponSprite
	
	



doneDrawingWeaponSprite:
	UpdateSpritePointer
	
notAttackingSoDontDrawWeapon:


	

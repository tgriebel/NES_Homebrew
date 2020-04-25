HandleTileCollision:
    ;;;;;ASSUMES vulnerability bit 000x0000, if one, skips collision.
    ;;;;;Six collision points. 
    ;;;;;All collision points checked and registered for all objects.
    ;;;; a solid in any of the points will result in negating all others.
    
        ;;; There are 6 ram variables, collisionPoint0 - collisionPoint5.
        ;;; collisionPoint0 = top left
        ;;; collisionPoint1 = top right
        ;;; collisionPoint2 = bottom right
        ;;; collisionPoint3 = bottom left.
        ;;; collisionPoint4 = mid left
        ;;; collisionPoint5 = mid right.
    
    TXA 
    STA currentObject
    TYA
    STA tempy

	LDA npc_collision
	AND #%11111101
	LDA #$00
	STA npc_collision
	LDA navFlag
	AND #%11111110
	STA navFlag

;;;;;;===================================================
;;;;;;***************************************************
;;;;;; TILE COLLISION FOR TOP DOWN GAMES: 

;;;; Before we update the position, though, if this is a scrolling game, we need to see if the player
;;;; is at the edge of the camera.  If he is at the edge of the camera, it
;;;; will do a bounds check.
	CheckPlayerCameraPosition
	   
;;;; if it turns out we were outside of the camera bounds, the macro
;;;; has RTSed out of this routine, so the hoziontal position will
;;;; never be updated.
 
;;;;;   For top down type games, or games that generally have no gravity but have 4 directional movement,
;;;;;   we only need to check potential position and jump to the appropriate label.
    CheckPotentialPosition



    
    JSR updateHorizontalPosition
    JSR updateVerticalPosition
	
;;;; THis is the end of top down scrolling physics.  It automatically jumps to the proper place.
;;;; Otherwise, if there was no collision, we jump to updating the position.

     JMP DoneWithTileChecksAndUpdatePosition
   
   
   

;;; NO POINTS WERE SOLID    
    ;;;; update hold
DoneWithTileChecksAndUpdatePosition:
   ldx currentObject
    RTS
    
HandleSolidCollision:
	LDA screenFlags
	AND #%00000100 ;; is it autoscrolling?
	BEQ + ;; not autoscrolling
	;;; is auto scrolling
	CPX player1_object
	BNE +
	JSR CheckAutoScrollLeftEdge
	RTS 
+ ;; not auto scrolling.

	LDA xPrev
	STA xHold_hi
	LDA yPrev
	STA yHold_hi
    TYA
    STA tempy
    LDA Object_edge_action,x
    LSR
    LSR
    LSR
    LSR
    BEQ doNothingAtSolid
    TAY
    
    LDA AI_ReactionTable_Lo,y
    STA temp16
    LDA AI_ReactionTable_Hi,y
    STA temp16+1
    
    JSR doReactionTrampolineSolid
    JMP pastReactionTrampolineSolid
doReactionTrampolineSolid:
    JMP (temp16) ;;; this now does the action
            ;; and when it hits the RTS in that action,
            ;; it will jump back to the last JSR it saw,
            ;; which was doNewActionTrampoline...which will immediately
            ;; jump to pastDoNewActionTrampoline.
pastReactionTrampolineSolid:
    ;LDA #$00
    ;STA xHold_lo

doNothingAtSolid:
    ;;;;;;;;;;; Do solid reaction type.
    LDY tempy
    LDX currentObject
    RTS
    
    
ejectUp:
    LDA tileY
    and #%00001111;We can only be 0 to 15 pixels in any given wall
    sta temp
 
    lda Object_y_hi,x
    clc;Subtract one plus that so we're a pixel out of the wall rather than one pixel in it.
    SBC temp
    STA Object_y_hi,x
    LDA #$00
    STA yHold_lo
    STA Object_v_speed_hi,x
    STA Object_v_speed_lo,x
    RTS
    
ejectDown:

    lda tileY
    and #%00001111;we can only be 0 to 15 pixels in any given wall
    eor #%00001111;If we're at position 15 in the tile, we only want to eject 0 (+1) so flip the bits
    sec;Will add the extra one to the position so that we're a pixel out of the wall
    adc Object_y_hi,x;rather than one pixel in it.
    sta Object_y_hi,x
    
    LDA #$00
    STA yHold_lo
    STA Object_v_speed_hi,x
    STA Object_v_speed_lo,x
	
	;;; check the top two collision points to see if is it a prize block.
	LDA collisionPoint0
	CMP #COL_INDEX_PRIZE_BLOCK
	BEQ +
	JMP ++ 
+
	LDA Object_x_hi,x
	CLC
	ADC Object_left,x
	STA tileX
	JMP +++
++
	LDA collisionPoint1
	CMP #COL_INDEX_PRIZE_BLOCK
	BEQ +
	JMP ++
+
	LDA Object_x_hi,x
	CLC
	ADC Object_right,x
	STA tileX
+++


	
	LDA gameHandler
	ORA #%00010000
	STA gameHandler
	;;;;; check other head-hit type objects here.
	;; change collision data.
	;; should still have the correct coordinates in tileX and tileY
	ChangeTileAtCollision #$00, #TILE_INDEX_PRIZE_OFF
	
	TXA
	PHA
	LDA Object_x_hi,x
	STA temp
	LDA Object_y_hi,x
	SEC
	SBC #$12 ;; a bit more than the height of it.
	STA temp1
	LDA Object_scroll,x
	STA temp2
	CreateObject temp, temp1, #OBJ_PRIZE, #$00, temp2
	LDA #$00
	SEC
	SBC #$04
	STA Object_v_speed_hi,x
	
	PLA
	TAX
	
++
    RTS
    
    
    

CheckForCollision:

    ;;;; commonly, we won't want to waste cycling 6 times through this for each object when
    ;;;; all points are at no collision.  If by chance we NEED the zero type collision to do something, 
    ;;;; we can comment out the zero type check in this next line.  But most games are going to have
    ;;;; at least one "blank tile" that does nothing, and most games will use zero for this.
	
	;;;; Another conundrum is that a collision could take place in the current or new nametable.
	;;;; if this collision is of type that draws from screen data (for instance, NPC data or warp data), it could
	;;;; be problematic, as all variables handling these things are loaded with the current collision tables data.
	;;;; tempCol ends up being 0 or 1 based on which collision table this should be referencing.
	
    STA temp
    BNE notZeroTypeCollision
    JMP zeroTypeCollision
notZeroTypeCollision:
    LDA #$00
    STA tile_solidity
DoCheckPointsLoop:
    LDA temp
    TAY
    LDA tileTypeBehaviorLo,y
    STA temp16
    LDA tileTypeBehaviorHi,y
    STA temp16+1
    JSR UseTileTypeTrampoline
    JMP pastTileTypeTrampoline
UseTileTypeTrampoline:
    JMP (temp16)
pastTileTypeTrampoline:
DontCheckTileType0:

    
zeroTypeCollision:
    ldx currentObject
    RTS
    
    
    
    
DetermineCollisionTable:
    LDA tempCol
    BNE colPointInDifferentTable
    ;;;; the collision point is in the current collision table.
    LDA Object_scroll,x
    AND #%00000001
    BNE isInOddTable
    JMP isInEvenTable
colPointInDifferentTable:
    ;;; the collision point to be checked is in the NEXT collision table.
    LDA Object_scroll,x
    AND #%00000001
    BNE isInEvenTable
    JMP isInOddTable
	

isInEvenTable:
    LDA collisionTable,y
    RTS
isInOddTable:
    LDA collisionTable2,y

    RTS


    
    
updateHorizontalPosition:
    LDA xHold_lo
    STA Object_x_lo,x
    LDA xHold_hi
    STA Object_x_hi,x
    LDA nt_hold
	CMP Object_scroll,x
	BEQ justUpdateScroll
	LDA #$01
	STA update_screen_data_flag
	LDA nt_hold
justUpdateScroll:
    STA Object_scroll,x
    
    RTS
    
updateVerticalPosition:
    LDA yHold_lo
    STA Object_y_lo,x
    LDA yHold_hi
    STA Object_y_hi,x   
    RTS
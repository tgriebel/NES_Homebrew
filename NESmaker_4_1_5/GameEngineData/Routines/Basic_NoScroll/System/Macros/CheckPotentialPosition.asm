MACRO CheckPotentialPosition

;;;; RESET SOLID
	LDA #$00
    STA tile_solidity
	Sta collisionPoint0
	STA collisionPoint1
	STA collisionPoint2
	STA collisionPoint3



doLeftCollisionCheck:
	;;;;;;;;;;;;;;;;;;;;;;;;; CHECK ALL LEFT POINTS

    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
	
    JSR GetTileAtPosition
	LDA collisionTable,y
    STA collisionPoint0
    JSR CheckForCollision
	LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   
	;;;; LEFT BOTTOM
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_bottom,x
    STA tileY
    
    JSR GetTileAtPosition
   LDA collisionTable,y
    STA collisionPoint3
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
  
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

;;; RIGHT COLLISION CHECKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    LDA xHold_hi
	CLC
    ADC Object_right,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
    
    JSR GetTileAtPosition
	LDA collisionTable,y
    STA collisionPoint1
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+



    LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX
   
    LDA yHold_hi
    CLC
    ADC Object_bottom,x

    STA tileY
    
    JSR GetTileAtPosition
	LDA collisionTable,y
    STA collisionPoint2
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

DoneWithPotentialPositionCheck:
	ENDM
	
MACRO CheckForHorizontalCollision

;;;; RESET SOLID
	LDA #$00
    STA tile_solidity
	Sta collisionPoint0
	STA collisionPoint1
	STA collisionPoint2
	STA collisionPoint3
	STA collisionPoint4
	STA collisionPoint5
	
;;; RESET LADDER STATE	
	LDA Object_physics_byte,x
	AND #%11111101
	STA Object_physics_byte,x
	
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
	BMI doLeftHorColCheck
	JMP doRightHorColCheck
doLeftHorColCheck:

    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA Object_y_hi,x
    CLC
    ADC Object_top,x
    STA tileY
	
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA collisionTable,y
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +

    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   
	LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
	;;; check bottom left point

    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA Object_y_hi,x
    CLC
    ADC Object_bottom,x
    STA tileY
    
    JSR GetTileAtPosition
   ; JSR DetermineCollisionTable
   	LDA collisionTable,y
    STA collisionPoint3
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +

    ;LDA Object_physics_byte,x
    ;ORA #%01000000 ;; solid was at top.
    ;STA Object_physics_byte,x
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

    LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
;;;;; left middle
	LDA Object_bottom,x
    SEC
    SBC Object_top,x
    LSR 
    STA temp3 ;; temp 3 now equals half of the height of the object, so top+temp3 = mid point vertically.
  
	
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA Object_y_hi,x
    CLC
    ADC Object_top,x
    CLC
    ADC temp3
    STA tileY
    
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA collisionTable,y
    STA collisionPoint4
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +

    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
    	LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
	JMP doneWithHorColCheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doRightHorColCheck:


    LDA xHold_hi
	CLC
    ADC Object_right,x
    STA tileX

    LDA Object_y_hi,x
    CLC
    ADC Object_top,x
    STA tileY
    
    JSR GetTileAtPosition
   ; JSR DetermineCollisionTable
	LDA collisionTable,y
    STA collisionPoint1
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +

    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
	LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

    LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX
   
    LDA Object_y_hi,x
    CLC
    ADC Object_bottom,x

    STA tileY
    
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA collisionTable,y
    STA collisionPoint2
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    ;LDA Object_physics_byte,x
    ;ORA #%01000000 ;; solid was at top.
    ;STA Object_physics_byte,x

    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
    LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    ;;; IF YOU NEED TO FIND OUT THE MID POINT HORIZONTALLY
    ;LDA Object_right,x
    ;SEC
    ;SBC Object_left,x
    ;LSR
    ;STA temp2 ;; temp 2 now equals half the width of the object, so left+temp2 = mid point horizontally.
    
    LDA Object_bottom,x
    SEC
    SBC Object_top,x
    LSR 
    STA temp3 ;; temp 3 now equals half of the height of the object, so top+temp3 = mid point vertically.
    

    LDA Object_y_hi,x
    CLC
    ADC Object_top,x
    CLC
    ADC temp3
    STA tileY

	LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX
     
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA collisionTable,y
    STA collisionPoint5
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
	
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
	LDA tile_solidity
	AND #%00000010
	BEQ +
	LDA Object_physics_byte,x
	AND #%00000010
	BNE +
	;;; DO LADDER STUFF
	JSR DoLadderStuff
+
doneWithHorColCheck:
	ENDM
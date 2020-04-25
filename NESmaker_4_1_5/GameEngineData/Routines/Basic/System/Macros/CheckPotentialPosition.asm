MACRO CheckPotentialPosition

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
;;;; HORIZONTAL COLLISION CHECK
	LDA Object_h_speed_lo,x
	CLC
	ADC #$00
	LDA Object_h_speed_hi,x
	ADC #$00
;	BNE doHcolCheck
;	JMP skipHcolCheck
;doHcolCheck:

	BMI doLeftCollisionCheck
	JMP dontDoLeftCollisionCheck ;; if moving right, skip left check
doLeftCollisionCheck:
	;;;;;;;;;;;;;;;;;;;;;;;;; CHECK ALL LEFT POINTS
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;LDA Object_left,x
	;LDA #$00
	;STA temp
	;DetermineCollisionTableOfPoints temp
	
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
	
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA Object_left,x
	STA temp
	DetermineCollisionTableOfPoints temp
	
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
    ;JSR DetermineCollisionTable
	LDA Object_left,x
	STA temp
	DetermineCollisionTableOfPoints temp
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;; LEFT MIDDLE
	LDA Object_bottom,x
    SEC
    SBC Object_top,x
    LSR 
    STA temp3 ;; temp 3 now equals half of the height of the object, so top+temp3 = mid point vertically.
    
	LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    CLC
    ADC temp3
    STA tileY
    
    JSR GetTileAtPosition
  ;  JSR DetermineCollisionTable
  	LDA Object_left,x
	STA temp
	DetermineCollisionTableOfPoints temp
    STA collisionPoint4
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

	JMP DoneWithPotentialPositionCheck
dontDoLeftCollisionCheck:
;;; RIGHT COLLISION CHECKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
   ; LDA xHold_hi
 ;   CLC
	LDA Object_x_lo,x
	CLC
	ADC Object_h_speed_lo,x
	LDA Object_x_hi,x
	ADC Object_h_speed_hi,x
    ADC Object_right,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
    
    JSR GetTileAtPosition
   ; JSR DetermineCollisionTable
   	LDA Object_right,x
	STA temp
	DetermineCollisionTableOfPoints temp
	
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
   ; JSR DetermineCollisionTable
   	LDA Object_right,x
	STA temp
	DetermineCollisionTableOfPoints temp
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
    
	

    LDA yHold_hi
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
  ;  JSR DetermineCollisionTable
  	LDA Object_right,x
	STA temp
	DetermineCollisionTableOfPoints temp

    STA collisionPoint5
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

skipHcolCheck:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vertical collision check
	LDA Object_v_speed_lo,x
	CLC
	ADC #$00
	LDA Object_v_speed_hi,x
	ADC #$00
;	BNE doVerticalCollisionCheck
;	JMP skipVcolCheck
;doVerticalCollisionCheck:

	BMI doUpCollisionCheck
	JMP dontDoUpCollisionCheck ;; if moving right, skip left check
doUpCollisionCheck:
	;;;;;;;;;;;;;;;;;;;;;;;;; CHECK ALL LEFT POINTS
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;LDA Object_left,x
	;LDA #$00
	;STA temp
	;DetermineCollisionTableOfPoints temp
	
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
	
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
	
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   
;;; top right
	LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
	
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
	
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   

	JMP DoneWithPotentialPositionCheck
dontDoUpCollisionCheck:
;;; DOWN COLLISION CHECKS
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
    ;JSR DetermineCollisionTable
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
	
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   
;;; top right
	LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX

    LDA yHold_hi
    CLC
    ADC Object_bottom,x
    STA tileY
	
    JSR GetTileAtPosition
    ;JSR DetermineCollisionTable
	LDA #$00
	STA temp
	DetermineCollisionTableOfPoints temp
	
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   
skipVcolCheck:
DoneWithPotentialPositionCheck:
	ENDM
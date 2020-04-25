	
MACRO CheckPotentialPositionSafe
	LDA #$00
    STA tile_solidity


    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
    
    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
    
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
    BEQ +
    ;LDA Object_physics_byte,x
    ;ORA #%10000000 ;; solid was at top.
    ;STA Object_physics_byte,x
    JMP HandleSolidCollision ;; hit a solid so won't update position. 
+   

    LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
    LDA yHold_hi
    CLC
    ADC Object_top,x
    STA tileY
    
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint1
    JSR CheckForCollision
    LDA tile_solidity
    BEQ +
    ;LDA Object_physics_byte,x
    ;ORA #%10000000 ;; solid was at top.
    ;STA Object_physics_byte,x
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+


    LDA xHold_hi
    CLC
    ADC Object_right,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
    LDA yHold_hi
    CLC
    ADC Object_bottom,x

    STA tileY
    
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint2
    JSR CheckForCollision
    LDA tile_solidity
    BEQ +
    ;LDA Object_physics_byte,x
    ;ORA #%01000000 ;; solid was at top.
    ;STA Object_physics_byte,x
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
    
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
    LDA yHold_hi
    CLC
    ADC Object_bottom,x
    STA tileY
    
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint3
    JSR CheckForCollision
    LDA tile_solidity
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
    
    LDA xHold_hi
    CLC
    ADC Object_left,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
    LDA yHold_hi
    CLC
    ADC Object_top,x
    CLC
    ADC temp3
    STA tileY
    
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint4
    JSR CheckForCollision
    LDA tile_solidity
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+
    
    LDA yHold_hi
    CLC
    ADC Object_top,x
    CLC
    ADC temp3
    STA tileY
    LDA Object_x_hi,x
    CLC
    ADC Object_right,x
    STA tileX
    LDA #$00
    BCC + ;; has not cross threshold compared to current scroll value
    ;; has crossed the threshold
    LDA #$01
+
    STA tempCol ;;; we will use tempCol to determine if this 
                ;;; collision point should check the same nametable
                ;;; or the next nametable.
     
    JSR GetTileAtPosition
    JSR DetermineCollisionTable
    STA collisionPoint5
    JSR CheckForCollision
    LDA tile_solidity
    BEQ +
    JMP HandleSolidCollision ;; hit a solid so won't update position.
+

	ENDM
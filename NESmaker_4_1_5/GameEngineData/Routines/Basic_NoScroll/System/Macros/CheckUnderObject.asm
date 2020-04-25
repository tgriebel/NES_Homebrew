
	
MACRO CheckUnderObject arg0
	;; arg0: how far below feet to check
	LDA #$00
    STA tile_solidity
	
	LDA Object_physics_byte,x
	AND #%11111011
	STA Object_physics_byte,x
    
    LDA Object_x_hi,x
    CLC
    ADC Object_left,x
    STA tileX
    LDA #$00
    BCC +
    LDA #$01
+
    STA tempCol
    
    LDA yHold_hi
    CLC
    ADC Object_bottom,x
    CLC
    ADC arg0
    STA tileY
    JSR GetTileAtPosition
 ;   JSR DetermineCollisionTable
    ;STA collisionPoint0
	LDA collisionTable,y
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000111
    BEQ +
	
    LDA Object_physics_byte,x
    ORA #%00000001
    STA Object_physics_byte,x
	LDA tile_solidity
	AND #%00000001
	BEQ ++
	LDA Object_physics_byte,x
    ORA #%00000100
    STA Object_physics_byte,x
    JMP ++  
+   



    LDA #$00
    STA tile_solidity 
    LDA Object_x_hi,x
    CLC
    ADC Object_right,x
    STA tileX
    LDA #$00
    BCC +
    LDA #$01
+
    STA tempCol
    
    LDA yHold_hi
    CLC
    ADC Object_bottom,x
    CLC
    ADC arg0
    STA tileY
    JSR GetTileAtPosition
   ; JSR DetermineCollisionTable
    ;STA collisionPoint0
	LDA collisionTable,y
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000111
    BEQ +
	
	
    LDA Object_physics_byte,x
    ORA #%00000001
    STA Object_physics_byte,x
	LDA tile_solidity
	AND #%00000001
	BEQ ++
	LDA Object_physics_byte,x
    ORA #%00000100
    STA Object_physics_byte,x
    JMP ++  
+
    LDA Object_physics_byte,x
    AND #%11111110
    STA Object_physics_byte,x
++
;;;;;;;;;;;;;;;;;;;;; ABOVE CHECKS BOTTOM OF PLAYER
;;;;;;;;;;;;;;;;;;;;; IF bit 0 of object physics bite is 1
;;;;;;;;;;;;;;;;;;;;; that means the object saw a solid collision
;;;;;;;;;;;;;;;;;;;;; and is 'on ground'.
	ENDM
	
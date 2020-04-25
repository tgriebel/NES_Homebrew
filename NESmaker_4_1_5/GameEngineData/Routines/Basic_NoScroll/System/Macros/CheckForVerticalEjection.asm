
MACRO CheckForVerticalEjection
	;;; we only want to eject solid objects, and likely do not want to eject projectiles and weapons
	LDA Object_flags,x
	AND #%00010100
	BEQ doMacroEjection
	JMP doneEjecting
doMacroEjection:
	
    LDA #$00
    STA tile_solidity
    
		

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
    ADC Object_top,x
    STA tileY
    JSR GetTileAtPosition
 ;   JSR DetermineCollisionTable
 	LDA collisionTable,y
    STA collisionPoint0 ;; comment this out?
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    
    JSR ejectDown
    JMP doneEjecting
+
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    ADC Object_top,x
    STA tileY
    JSR GetTileAtPosition
		LDA collisionTable,y
   ; JSR DetermineCollisionTable
    STA collisionPoint1
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JSR ejectDown
    JMP doneEjecting
+   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; check for ejecting up.

	LDA #$00
	STA tile_solidity

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

    STA tileY
    JSR GetTileAtPosition
		LDA collisionTable,y
    ;JSR DetermineCollisionTable
    ;STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
    JSR ejectUp 
    JMP doneEjecting
+   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 LDA tile_solidity
	  AND #%00000010 ;; check ladder type
	  BEQ +
	LDA #$00
	  STA tile_solidity
	; ; ;;; is a ladder type so now we need to do more checks.
	
	  LDA tileY
	  SEC
	  SBC #$04
	  STA tileY
	 JSR GetTileAtPosition
	; JSR DetermineCollisionTable
		LDA collisionTable,y
	 JSR CheckForCollision
	 LDA tile_solidity
	 AND #%00000010
	 BNE +
	 LDA Object_v_speed_lo,x
	 CLC
	 ADC #$00
	 LDA Object_v_speed_hi,x
	 ADC #$00
	 BMI +
	 ;;; now, check to see if we're pressing down, to "enter" the ladder 
	 LDA gamepad
	AND #%00100000 ; if down is pressed
	BEQ ++

	LDA Object_physics_byte,x
	ORA #%00000010
	STA Object_physics_byte,x
	jmp ++++ ;; jump to checking other point.
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA tileY
	CLC
	ADC #$04
	STA tileY
	JSR ejectUp
	LDA Object_physics_byte,x
	AND #%11111101
	STA Object_physics_byte,x
	JMP doneEjecting
 +
;;;;;;;;;;;;; WAS NOT A LADDER TYPE
	;;; check to see if there is a jumpthrough platform below us.
	LDA tile_solidity
	AND #%00000100
	BEQ ++++
	;;;we are colliding with a one way platform.
	;;; we need to check to see if we are on top of the platform.
	LDA Object_v_speed_lo,x
	CLC
	ADC #$00
	LDA Object_v_speed_hi,x
	ADC #$00
	BMI ++++
	;;;; check the space just above to make sure it is clear 
	LDA #$00
	STA tile_solidity
	  LDA tileY
	  SEC
	  SBC #$08
	  STA tileY
	 JSR GetTileAtPosition
	 	LDA collisionTable,y
	; JSR DetermineCollisionTable
	 JSR CheckForCollision
	 LDA tile_solidity
	 AND #%00000100
	 BNE ++++
	 LDA Object_physics_byte,x
	 ORA #%00001000
	 STA Object_physics_byte,x
	 LDA tileY
	 CLC
	 ADC #$08
	 STA tileY
	JSR ejectUp
	JMP doneEjecting

++++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LDA #$00
	STA tile_solidity
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    
    STA tileY
    JSR GetTileAtPosition
		LDA collisionTable,y
   ; JSR DetermineCollisionTable
    ;STA collisionPoint0
    JSR CheckForCollision
    LDA tile_solidity
	AND #%00000001
    BEQ +
	LDA Object_physics_byte,x
	AND #%11111101
	STA Object_physics_byte,x
    JSR ejectUp
    JMP doneEjecting
+   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 LDA tile_solidity
	 AND #%00000010 ;; check ladder type
	 BEQ +
	LDA #$00
	 STA tile_solidity
	; ; ;;; is a ladder type so now we need to do more checks.
	 LDA tileY
	 SEC
	 SBC #$04
	 STA tileY
	 JSR GetTileAtPosition
	 	LDA collisionTable,y
	; JSR DetermineCollisionTable
	 JSR CheckForCollision
	 LDA tile_solidity
	 AND #%00000010
	 BNE +
	 LDA Object_v_speed_lo,x
	 CLC
	 ADC #$00
	 LDA Object_v_speed_hi,x
	 ADC #$00
	 BMI +
	 	 ;;; now, check to see if we're pressing down, to "enter" the ladder 
	 LDA gamepad
	AND #%00100000 ; if down is pressed
	BEQ ++

	LDA Object_physics_byte,x
	ORA #%00000010
	STA Object_physics_byte,x
	jmp doneEjecting
++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA tileY
	CLC
	ADC #$04
	STA tileY
	JSR ejectUp
	 LDA Object_physics_byte,x
	 AND #%11111101
	 STA Object_physics_byte,x
	JMP doneEjecting
 +
 
 ;;;;;;;;;;;;; WAS NOT A LADDER TYPE
	;;; check to see if there is a jumpthrough platform below us.
	LDA tile_solidity
	AND #%00000100
	BEQ ++++
	;;;we are colliding with a one way platform.
	;;; we need to check to see if we are on top of the platform.
	LDA Object_v_speed_lo,x
	CLC
	ADC #$00
	LDA Object_v_speed_hi,x
	ADC #$00
	BMI ++++
	;;;; check the space just above to make sure it is clear 
	LDA #$00
	STA tile_solidity
	  LDA tileY
	  SEC
	  SBC #$08
	  STA tileY
	 JSR GetTileAtPosition
	 	LDA collisionTable,y
	 ;JSR DetermineCollisionTable
	 JSR CheckForCollision
	 LDA tile_solidity
	 AND #%00000100
	 BNE ++++
	 LDA Object_physics_byte,x
	 ORA #%00001000
	 STA Object_physics_byte,x
	 LDA tileY
	 CLC
	 ADC #$08
	 STA tileY
	JSR ejectUp
	JMP doneEjecting

++++
    ;JMP noEjection
doneEjecting:

    LDX currentObject   
    LDY tempy
    ;rts 
;;===============================================
;;===============================================   
noEjection:;;;;;;;;;;;;;;;;;;;
;   JMP UpdatePositionToHold
    
	ENDM
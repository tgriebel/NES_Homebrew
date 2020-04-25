CalculateAccAndSpeed:
	
	TXA
	STA tempx
	TYA
	STA tempy
	
	
	LDA ObjectVulnerability,x
	AND #%00000010 ;; does it ignore groundbytes, here we'll use it for ignoring physics
	BEQ dontIgnorePhysics
	JMP skipCalcAccAndSpeed
dontIgnorePhysics:
	;;;
	;;;; use for testing
	;JMP skipCalcAccAndSpeed 
	;;;
	;;; variables stored
	;;;; NOW handle player caveats for states
	;;; removed for state machine
	LDA ObjectXhi,x
	STA playerPrevX
	LDA ObjectYhi,x
	STA playerPrevY
	
	
	LDA currentBank
	STA prevBank
	LDY #BANK_DATA
	JSR bankswitchY
	
	JSR figureOutSpeedBasedOnLuts
	
	;;; other variable behaviors
	LDY prevBank
	JSR bankswitchY
	
	;;; CHeck for ice, etc
	LDA ObjectAccAmount,x ;; or if not ice, uses the object's acc amount.
	STA tempAccAmount
;;;;;;;;;;;;;;;;;;;;;

	;LDA currentBank
	;STA prevBank
	;LDY #$14
	;JSR bankswitchY
	
	JSR doAccSpeedFetch
	;; now, based on movement bytes, we have the speed, so we can 
		;compare it to position to get new potential position.
	
;	LDY prevBank
	;JSR bankswitchY
	
	JSR HandleNormalCollisions
	
	JMP ThereIsNoSolid


	
		
	
ThereIsASolid:
	;;; PLATFORMING CAVEATS:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDA currentBank
	STA prevBank
	LDY #$14
	jsr bankswitchY
	LDY mySolidAction   ;;; change to solid action
	LDA solidBehaviorLo,y
	sta temp16
	LDA solidBehaviorHi,y
	STA temp16+1
	
	JSR UseSolidTrampoline
	JMP pastSolidTrampoline
UseSolidTrampoline:
	JMP (temp16)
pastSolidTrampoline:
	
	LDY prevBank
	JSR bankswitchY

	LDY tempy
	
	;;; Solid behavior done
	JMP DoneWithXYMovement
ThereIsNoSolid:
;; do XY Movement

	;;; check for monster blockade


	LDA currentBank
	STA prevBank
	LDY #$14
	JSR bankswitchY
	JSR CheckBounds
	LDY prevBank
	JSR bankswitchY
	;;; temp is loaded with one or two.
	;; one does not skip xy movement
	;; two does skip the xy movement.
	LDA temp
	BEQ normalUpdateMovement
	
normalUpdateMovement:
	JSR updateNormalXMovementRoutine
	JSR updateNormalYMovementRoutine
	
	
DoneWithXYMovement:

	;; NOW WE HAVE MOVED TO NEW PLACE
	;; IF WE ARE IN SOMETHING SOLID, WE NEED TO BE EJECTED 
	;; this same trick COULD help with platforms or moving objects meant to push us?
	;; even NPCs?  Good idea!
	;JSR HandleCollisions
	
skipCalcAccAndSpeed:	
	;; variables restore
	LDA tempx
	TAX
	LDY tempy
	TAY
	

	

	RTS
	


	
updateNormalYMovementRoutine:
	LDA ObjectYlo,x
	CLC
	ADC ObjectVSpeedLo,x
	STA ObjectYlo,x
	LDA ObjectYhi,x
	ADC ObjectVSpeedHi,x
	STA ObjectYhi,x
	RTS
updateNormalXMovementRoutine:
	LDA ObjectXlo,x
	CLC
	ADC ObjectHSpeedLo,x
	STA ObjectXlo,x
	LDA ObjectXhi,x
	ADC ObjectHSpeedHi,x
	STA ObjectXhi,x
	RTS
		
		

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;DO HORIZONTAL POSITION FETCH

doAccSpeedFetch:
	.include "Routines\MovementScripts\MoveLR_WithAcceleration.asm"

	.include "Routines\MovementScripts\MoveUD_WithAcceleration.asm"


	RTS	
	
HandleCollisions:
	.include "Routines\PhysicsScripts\HandleCollisions.asm"
	RTS
		

		
	
	
MoveTowardsPlayer:
	MoveTowardsPoint temp, temp1, temp2, temp3, #$01
	RTS		
	
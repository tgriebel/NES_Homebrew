	
MACRO CheckScrollColumnForNewMonsters arg0

	TXA
	STA tempx
	;; arg0: max number of monsters that can be placed for a check.  This is likely going to be 4.
	;; this particular routine only checks for monsters in the right scroll direction.
	LDA objectID_forSeamLoad
	BEQ checkAllMonstersForColumnPositioning
	JMP doneLoadingMonstersForThisColumn
checkAllMonstersForColumnPositioning:
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDA scrollDirection
	BEQ leftScrollDirectionForNtFinder
	LDA columnTracker
	AND #%00001000
	BEQ useNewNametable
	;; use current nametable
	LDA newNametable
	SEC
	SBC #$01
	JMP gotUseNametable
useNewNametable:
	LDA newNametable
gotUseNametable:
	STA tempNT
	JMP +
leftScrollDirectionForNtFinder:
	
	LDA columnTracker
	AND #%00001000
	BEQ useNewNametable2
;	;; use current nametable
	LDA newNametable
;	SEC
;	SBC #$01
	JMP gotUseNametable2
useNewNametable2:
	LDA newNametable
	CLC
	ADC #$01
	;SEC
	;SBC #$01
gotUseNametable2:
	STA tempNT
	JMP +	
+	
	TAY
	LDA update_screen_details
	CMP #$02
	BEQ isMap2forMonsterUpdate
	LDA CollisionTables_Map1_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map1_Hi,y
	STA collisionPointer+1
	JMP gotMapUpdateForMonsterCheck
isMap2forMonsterUpdate:
	LDA CollisionTables_Map2_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map2_Hi,y
	STA collisionPointer+1
gotMapUpdateForMonsterCheck:
;;;;;;;;;;;;;;;; Got map for which collision table to be looking in.
	LDY screenBank
	JSR bankswitchY
	
DoLoadMonsterColumnLoop:
	LDX objectID_forSeamLoad
		
	LDY #$b7 ;; position in collision table where first monster byte is.
	LDA (collisionPointer),y
	LDY objectID_forSeamLoad
	AND DoubleBitTable,y ;; anding to collision pointer.
	CMP DoubleBitTable,y ;; if they're both flipped
	BNE LoadThisObjectOnColumn
	JMP skipLoadingThisObjectOnColumn
LoadThisObjectOnColumn:
	;;; must find position
	LDY ObjectPlacementByteIndex,x ;#$83
	LDA (collisionPointer),y
	AND #%00001111
	STA temp
	LDA columnTracker
	CLC
	ADC #$10
	AND #%00001111
	CMP temp
	BNE skipLoadingThisObjectOnColumn
	;; load this object.
	LDY ObjectIDByteIndex,x ; #$A2
	LDA (collisionPointer),y
	STA ObjectToLoad
	LDY ObjectPlacementByteIndex,x ; #$83

	JSR LoadMonsterAtColumn
	
	
skipLoadingThisObjectOnColumn:
	inc objectID_forSeamLoad
	LDA objectID_forSeamLoad
	CMP arg0 ;; is how many monsters to check to load
	BEQ doneLoadingMonstersForThisColumn
	JMP DoLoadMonsterColumnLoop
	

doneLoadingMonstersForThisColumn:

	LDY prevBank
	JSR bankswitchY

	LDX tempx
	ENDM
	
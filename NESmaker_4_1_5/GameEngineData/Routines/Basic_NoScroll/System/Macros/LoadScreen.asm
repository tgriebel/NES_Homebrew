MACRO LoadScreen arg0, arg1, arg2, arg3


	; arg0 - screen bank
	; arg1 - screen map
	; arg2 - screen number
	; arg3 - screen data offset.
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;; now, load the screen number into y
	LDY arg2
	LDA arg1 ;; this checks the map number.
	BNE +;; the map is not zero type
	;;;; here the map is the zero type.
	LDA CollisionTables_Map1_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map1_Hi,y
	STA collisionPointer+1
	JMP ++
+
	;;;; it was map 2
	LDA CollisionTables_Map2_Lo,y
	STA collisionPointer
	LDA CollisionTables_Map2_Hi,y
	STA collisionPointer+1
++
	LDY arg0
	JSR bankswitchY

	JSR LoadRoomData
	LDY prevBank
	JSR bankswitchY
	
	ENDM
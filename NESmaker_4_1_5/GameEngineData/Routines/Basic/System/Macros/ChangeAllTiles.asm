MACRO ChangeAllTiles arg0, arg1, arg2, arg3
	; arg0 - what tile index (collision) are you trying to change?
	; arg1 - what is the new collision type?
	; arg2 - what is the new top left meta tile value?
	; arg3 - which nametable, left or right.  0 - left, 1 = right
	
	LDA arg0
	STA arg0Temp
	LDA arg1
	STA arg1Temp
	LDA arg2
	STA arg2Temp
	LDA arg3
	STA arg3Temp
	
	
	LDA #$00
	STA updateNametable
	LDA gameHandler
	ORA #%00010000
	STA gameHandler
   
	TYA
	STA tempy

	LDY #$00
-
	LDA updateNametable
   BNE -
	
	LDA arg3Temp
	BEQ +++
	LDA collisionTable2,y
	CMP arg0Temp
	BNE +
	LDA arg1Temp
	STA collisionTable2,y
	JMP ++++
+++	
	LDA collisionTable,y
	CMP arg0Temp
	BNE +
	LDA arg1Temp
	STA collisionTable,y
++++

   ;;; now we have to change this graphic, too.
   LDX player1_object
    JSR ConvertCollisionToNT
	;;; right now, 20 is loaded into temp16
	;LDA arg3Temp
	;BEQ ++
	;LDA temp16
	;CLC
	;ADC #$4
	;STA temp16
;++
	
	
    LDA arg2Temp
    STA updateTile_00
	
    LDA arg2Temp
    CLC
    ADC #$01
    STA updateTile_01

    LDA arg2Temp
    CLC
    ADC #$10
    STA updateTile_02
	
    LDA arg2Temp
    CLC
    ADC #$11
    STA updateTile_03

    JSR HandleUpdateNametable

    INY
	CPY #$F0
	BEQ ++
    JMP -
+ ;; they were not equal.
	
	INy
	CPY #$F0
	BNE -
++
+++++
	LDA gameHandler
   AND #%11101111
   STA gameHandler
   LDY tempy
	
	ENDM
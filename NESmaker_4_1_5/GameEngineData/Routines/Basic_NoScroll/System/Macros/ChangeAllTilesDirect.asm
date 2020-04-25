MACRO ChangeAllTilesDirect arg0, arg1, arg2, arg3
	; arg0 - what tile index (collision) are you trying to change?
	; arg1 - what is the new collision type?
	; arg2 - what is the new top left meta tile value?
	; arg3 - which nametable, left or right.  0 - left, 1 = right
	
	; This is meant to occur when the screen is turned off.
	; If you want to make changes to tiles when the screen is turned on, use ChangeAllTiles instead.
	
	;LDA #$00
	;STA updateNametable
;	LDA gameHandler
	;ORA #%00010000
;	STA gameHandler
   
	;TYA
	;STA tempy

	LDA arg0
	STA arg0Temp
	LDA arg1
	STA arg1Temp
	LDA arg2
	STA arg2Temp
	LDA arg3
	STA arg3Temp
	
	;;; we will use these arg temps, because in some instances,
	;;; loops like below can carry on for too long, and theh args can 
	;;; get corrupted.  So we'll push them to temporary RAM variables
	;;; and use them in the routine instead.
	
	;;; Using these variables in any NMI script would negate their usage by
	;;; corrupting them, so never use them in NMI scripts, or macros embedded in
	;;; other macros where they both make use of them.

	LDY #$00
-
	LDA arg3Temp
	BEQ +++
	LDA collisionTable2,y
	CMP arg0Temp
	BEQ +
	JMP +++++
+
	LDA arg1Temp
	STA collisionTable2,y
	JMP ++++
+++	
	LDA collisionTable,y
	CMP arg0Temp
	BEQ +
	JMP +++++
+
	LDA arg1Temp
	STA collisionTable,y
++++

   ;;; now we have to change this graphic, too.
 
    JSR ConvertCollisionToNT

	;;; convertCollision routine handles which nametable to check in.
	
	LDA temp16
	STA $2006
	LDA temp16+1
	STA $2006
	LDA arg2
	STA $2007


	LDA temp16
	STA $2006
	LDA temp16+1
	CLC
	ADC #$01
	STA $2006
	LDA arg2
	clc
	ADC #$01
	STA $2007
	
  	LDA temp16
	STA $2006
	LDA temp16+1
	CLC
	ADC #$20
	STA $2006
	LDA arg2
	clc
	ADC #$10
	STA $2007
	
  
	LDA temp16

	STA $2006
	LDA temp16+1
	CLC
	ADC #$21
	STA $2006
	LDA arg2
	clc
	ADC #$11
	STA $2007
   
	

    INY
	CPY #$F0
	BEQ ++
    JMP -

+++++	
	INy
	CPY #$F0
	BEQ ++
	JMP -
++

;	LDA gameHandler
 ;  AND #%11101111
;   STA gameHandler
;   LDY tempy
	
	ENDM
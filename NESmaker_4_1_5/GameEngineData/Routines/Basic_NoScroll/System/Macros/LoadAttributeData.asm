MACRO LoadAttributeData arg0, arg1, arg3, arg4
	;arg0 = bank
	;arg1 = address
	;;arg 2 - unused
	;; arg 3 = offset.  40-offset gives number of values to draw.
	;; arg 4 = screen type 00 = special screen, 01 = map 1, 02 = map2
	
	;LDA arg0
	;STA updateNT_bank
	
	LDA #$40
	sec
	sbc arg3
	STA temp
	
	
	LDA currentBank
	STA prevBank
	LDY #$16
	JSR bankswitchY
	LDY newScreen
	LDA arg4
	BNE notSpecialScreenAT
	;; is special screen nt.
	LDA AttributeTablesSpecialLo,y
	STA temp16
	LDA AttributeTablesSpecialHi,y
	STA temp16+1
	JMP GotATIndex
notSpecialScreenAT:
	CMP #$01
	BNE notMap1AT
	LDA AttributeTablesMainGameAboveLo,y
	STA temp16
	LDA AttributeTablesMainGameAboveHi,y
	STA temp16+1
	JMP GotATIndex
notMap1AT:
	;; is map2 nt
	LDA AttributeTablesMainGameBelowLo,y
	STA temp16
	LDA AttributeTablesMainGameBelowHi,y
	STA temp16+1
	JMP GotATIndex
	
GotATIndex:	
	
	
	LDY prevBank
	JSR bankswitchY
	
	ChangeBank arg0 
	
	;LDA temp16
	;STA currentAttributeTablePointer
	;LDA temp16+1
	;STA currentAttributeTablePointer+1
	
	;LDA #$00
	;STA soft2001
	;JSR WaitFrame
	
	
	LDA #$23
	STA $2006
	LDA #$C0
	CLC
	ADC arg3 
	STA $2006
	
	LDY #$00
LoadAttributeLoop:
	LDA (temp16),y
	STA $2007
	INY
	CPY temp 
	BNE LoadAttributeLoop
	
	;LDA #%00011110
	;STA soft2001
	
	ENDM

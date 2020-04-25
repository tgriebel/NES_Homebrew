	LDA UpdateAtt
	BEQ dontUpdateAtt
	LDY #$00
updateAttributeColumnLoop:
	bit $2002
	;;;; UPDATE ATTRIBUTE FOR THIS - is there enough time for all 8?
	;;; will have to or in the proper values, since only doing 1/4 of an att byte at a time.
	;LDA updateNT_fire_att_hi,x
	;STA $2006
	;LDA updateNT_fire_att_lo,x
	;STA $2006
	;LDA $2007
	;LDA $2007 ;; double read necessary to get this value.
	LDA updateNT_att_fire_Address_hi,y
	STA $2006
	LDA updateNT_att_fire_Address_lo,y
	STA $2006
	
	LDA $2007
	LDA $2007

	AND updateNT_attMask
	ORA updateNT_fire_Att,y
	STA temp	
	LDA updateNT_att_fire_Address_hi,y
	STA $2006
	LDA updateNT_att_fire_Address_lo,y
	STA $2006
	LDA temp
;	LDA updateNT_fire_Att,y
	STA $2007
	DEC tilesToWrite
	LDA tilesToWrite
	BEQ turnOffAttUpdate
	INY
	CPY #$08
	BNE updateAttributeColumnLoop
turnOffAttUpdate:
	LDA #$00
	STA UpdateAtt
	STA updateNT_rows
	STA updateNT_columns
	LDA #$01
	STA loadMonsterColumnFlag

dontUpdateAtt:
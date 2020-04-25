HandleUpdateMetaTable:


	LDA currentBank
	STA prevBank
	LDY #$01
	JSR bankswitchY

	;; position to update variables preserved from HandleUPdateNametable routine
	
	LDA #<NT_Rm50

	STA temp16
	LDA #>NT_Rm50

	STA temp16+1
	
	
	LDX #$00
	
	LDY #$02
GetMetaTileLoop:

	LDA (temp16),y
	STA updateNT_fire_Tile,x
	LDA updateNT_positionToUpdate
	STA updateNT_fire_Address_Lo,x
	INC updateNT_positionToUpdate
	INC updateNT_positionToUpdate
	LDA tempy
	STA updateNT_positionToUpdate+1
	STA updateNT_fire_Address_Hi,x

	INY
	inx
	cpx #$08
	BNE GetMetaTileLoop
	 
	LDA updateNT_positionToUpdate
	CLC
	ADC #$20
	STA updateNT_positionToUpdate
	LDA updateNT_positionToUpdate+1
	ADC #$00
	STA updateNT_positionToUpdate
	
	

	
	
	
;	LDA updateNT_status
;	ORA #UPDATE_NT_FINAL
;	STA updateNT_status
	
	LDA updateNT_status
	ORA #UPDATE_NT_WRITE
;	STA updateNT_status
	
	
	LDY prevBank
	JSR bankswitchY
	
	RTS
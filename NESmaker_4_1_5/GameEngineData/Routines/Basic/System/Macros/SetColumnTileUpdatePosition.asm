MACRO SetColumnTileUpdatePosition	
	LDA updateNT_positionToUpdate+1
	STA updateNT_fire_Address_Hi,x
	LDA updateNT_positionToUpdate
	STA updateNT_fire_Address_Lo,x
	INX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA updateNT_positionToUpdate+1
	STA updateNT_fire_Address_Hi,x
	LDA updateNT_positionToUpdate
	CLC
	ADC #$01
	STA updateNT_fire_Address_Lo,x
	INX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA updateNT_positionToUpdate+1
	STA updateNT_fire_Address_Hi,x
	LDA updateNT_positionToUpdate
	CLC
	ADC #$20
	STA updateNT_fire_Address_Lo,x
	INX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA updateNT_positionToUpdate+1
	STA updateNT_fire_Address_Hi,x
	LDA updateNT_positionToUpdate
	CLC
	ADC #$21
	STA updateNT_fire_Address_Lo,x
	INX
	
	.ENDM
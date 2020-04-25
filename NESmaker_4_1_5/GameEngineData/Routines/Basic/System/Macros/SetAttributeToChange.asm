MACRO SetAttributeToChange arg0, arg1, arg2
	;; arg0 - hi address of change
	;; arg1 - low addres of change
	;; arg2 - change to this attribute data.
	
	;; ** EXPECTS X TO BE SET PRIOR TO CALLING THIS MACRO.
	;; most times, this will be part of a loop.
	
	LDA arg0
	STA updateNT_att_fire_Address_hi,x
	LDA arg1
	STA updateNT_att_fire_Address_lo,x
	LDA arg2
	STA updateNT_fire_Att,x
	
	INX

	INC tilesToWrite
	
	ENDM
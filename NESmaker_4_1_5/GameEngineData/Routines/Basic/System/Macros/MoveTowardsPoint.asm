

MACRO MoveTowardsPoint arg0, arg1, arg2, arg3, arg4
	;; arg0 = point of origin, x
	;; arg1 = poinrt of origin y
	;; arg2 = point to move towards x
	;; arg3 = point to move towards y
	
GetAngle:
	Atan2:
		LDA arg0
		SBC arg1
		bcs noEor
		eor #$ff
	noEor:
		TAX 
		rol octant

		lda arg2
		SBC arg3
		bcs noEor2
		eor #$ff
	noEor2:
		TAY 
		rol octant

		lda log2_tab,x
		sbc log2_tab,y
		bcc noEor3
		eor #$ff
	noEor3:
		tax	
		lda octant
		rol
		and #%111
		tay
		lda atan_tab,x
		eor octant_adjust,y
		;; now, loaded into a should be a value between 0 and 255
		;; this is the 'angle' towards the player from the object calling it
	
		TAY
		LDA AngleToHVelLo,y
		STA myHvel
		LDA AngleToVVelLo,y
		STA myVvel
		
	
	

	ENDM 
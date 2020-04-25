ConvertCollisionToNT:


	LDA #$20


	STA temp1
	

	;;y is the point past collision table
	TYA
	STA temp
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	clc
	ADC temp1
	STA temp16
	TYA
	AND #%11110000
	ASL
	ASL
	STA tempz
	TYA
	AND #%00001111
	ASL
	ORA tempz
	STA temp16+1
	LDY temp

	;;;;; now temp16 = the hi address
	;;;;; temp16+1 = the low address
	;;;; based on collision currently observed.
	
	RTS
	
ConvertNTtoCollision:
	STA temp
	;; a is loaded with the number in nt value	
	;; x is easy to get.  just need to cut the value in half.
	LSR a ;; divide in half.
	AND #%00001111
	STA temp1
	LDA temp
	LSR
	LSR
	AND #%11110000
	CLC
	ADC temp1
	
	
	;; now handle high bit
	
	;;; now A is collision / metatile value.
	
	
	RTS
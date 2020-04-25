MACRO SixteenBitDivideByTwo arg0, arg1
	;; arg0 = hi byte
	;; arg1 = low byte
	;;; corrupts temp and temp 1
	LSR arg0
	STA temp
	LSR
	STA temp1
	ENDM
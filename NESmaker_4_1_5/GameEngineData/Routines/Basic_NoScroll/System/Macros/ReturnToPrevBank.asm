MACRO ReturnToPrevBank
	;;; this macro returns to the bank
	;;; stored in the variable prevBank.
	;; it needs no argument.
	LDY prevBank
	JSR bankswitchY
	ENDM
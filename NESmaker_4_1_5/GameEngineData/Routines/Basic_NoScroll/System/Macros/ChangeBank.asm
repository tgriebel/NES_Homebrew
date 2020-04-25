MACRO ChangeBank arg0
	;; this macro changes the swappable bank
	;; to the value in arg0
	LDA currentBank
	STA prevBank
	LDY arg0
	JSR bankswitchY
	ENDM

MACRO AddValue arg0, arg1, arg2, arg3
	TXA
	PHA
	;arg0 = how many places this value has.
	;arg1 = home variable
	;arg2 = amount to add 
	;arg3 = to what place?
	LDX arg0
	--:
		LDA arg1,x ;; the variable that you want to push
		STA value,x
		dex
		BPL --
	LDX arg3 ; sets the place to push.  
	LDA arg2
	JSR valueAddLoop ;value_add1 ;; will add what is in accumulator.
	;;; now value nees to be unpacked back into the variable.
	

		LDX arg0
	-:
		LDA value,x ;; the variable that you want to push
		STA arg1,x
		dex
		BPL -
	PLA
	TAX
	ENDM
MACRO GetAbsoluteValue 
	;;; no argument needed - uses value in accumulator , spits out abs value to accumulator
	BPL +
	EOR #$FF
	CLC
	ADC #$01
+ ;; skips, because value was already positive.
	ENDM
	
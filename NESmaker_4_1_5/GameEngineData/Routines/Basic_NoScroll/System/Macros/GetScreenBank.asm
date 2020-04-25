MACRO GetScreenBank arg0
	;; arg0 = screen number.
	LDA arg0
	LSR
	LSR
	LSR
	LSR
	LSR
	STA temp
	LdA update_screen_details
	CMP #$01
	;;; if it is zero, it is a special screen.
	;;; one is map 1
	;;; two is map 2
	BEQ +
	;;; warping to map 2
	LDA temp
	CLC
	ADC #$08
	JMP ++
+
	LDA temp
++
	STA screenBank
	ENDM
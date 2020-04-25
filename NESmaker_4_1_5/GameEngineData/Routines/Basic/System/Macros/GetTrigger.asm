
MACRO GetTrigger
		;; arg0 = screen to change, usually held in variable screenType
		;; corrupts temp3
		;; which becomes either 0 or 1, depending on if a screen was triggered.

	TXA
	PHA
	TYA
	PHA
	

	
	lda screenType ;; this is the value of the screen to change.
		AND #%00000111 ;; look at last bits to know what bit to check, 0-7
		TAX
		LDA ValToBitTable_inverse,x
		STA temp3
	lda screenType
		LSR
		LSR
		LSR 
		;;; now we have the right *byte* out of the 32 needed for 256 screen bytes
		TAY
		LDA screenTriggers,y ;; now the rigth bit is loaded into the accum
		AND temp3
		STA tempz
	
	PLA 
	TAY	
	PLA 
	TAX
	LDA tempz
	ENDM
;;;;; before this can run,
;;;;; we need to know how many places the variable has
;;;; and we need to know what variable label, which needs as many bytes as places.
;;;; so this is a variable sized variable.  hm....
;;; this has to go somewhere besides normal variable location.

;;; value can have 8 places.
;;; and then AFTER this counter functionality, value can be pushed to the variable, place by place. 
;value_add10000:
;	ldx #$4
;	jmp valueAddLoop

;value_add1000:
;	ldx #$3
;	jmp valueAddLoop

;value_add100:
;	ldx #$2
;	jmp valueAddLoop

;value_add10:
;	ldx #$1
;	jmp valueAddLoop
	
;value_add1:
;	ldx #$0
valueAddLoop:
	;; the accumulator holds how much to add by.
	;; x holds what place is being added to.
	clc
	adc value,x
	cmp #$0A
	bcc skipCarryDecValue
	sec
	sbc #$0A
	sta value,x
	inx
	cpx #$08 ;; how many 'places' the value has
	bcs overflowThisNumber
	lda #$01
	jmp valueAddLoop
skipCarryDecValue:
	sta value,x
overflowThisNumber:
	rts
	
	
	
valueSubLoop:
	;; temp holds the value to subtract.
	lda value,x
	sec 
	sbc temp
	cmp #$00
	bpl skipCarryDecValue2
	clc
	adc #$0A
	sta value,x
	inx
	cpx #$08 ;; how many 'places' the value has
	bcs underflowThisNumber
	lda #$01
	STA temp
	jmp valueSubLoop
skipCarryDecValue2:
	sta value,x
underflowThisNumber:


	rts
	
FindEmptyObjectSlot:
	LDX #$00
FindSlotLoop:
	LDA Object_status,x
	AND #%11000000 ;; is it active or activating?
	BEQ foundFirstFreeSlot
;	; did not find slot
	INX
	CPX #TOTAL_MAX_OBJECTS
	BCC FindSlotLoop
	LDX #$FF ;; there is no slot

foundFirstFreeSlot:


	;; now the first slot is in x
	;; if it has returned FF, then there was no free slots.
	RTS
	
	
	
	
	
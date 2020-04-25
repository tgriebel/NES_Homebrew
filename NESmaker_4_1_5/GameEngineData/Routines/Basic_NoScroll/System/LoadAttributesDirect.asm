LoadAttributesDirect:
	;;;; so here's what needs to happen.
LoadATT_OuterLoop:
	LDX updateNT_attWidth

	LDA updateNT_pointer+1
	STA $2006
	LDA updateNT_pointer
	STA $2006



LoadATTLoop:
	LDA (temp16),y
	STA $2007
	;LDA xScroll
	;STA $2005	;reset scroll values to zero
	;LDA yScroll
	;STA $2005	;reset scroll values to zero

	
	INY
	DEX
	BNE LoadATTLoop
	;;; here, this means we got to the end of the column.
	;;; for now, let's just always load a whole page of columns, which would be 8
	DEC updateNT_rowCounter
	LDA updateNT_rowCounter
	BEQ AttLoadDone
	;;; first, subtract width from y
	TYA
	SEC
	SBC updateNT_attWidth
	CLC
	ADC #$08
	TAY
	
	
	
	LDA updateNT_pointer
	CLC
	ADC #$08
	STA updateNT_pointer
	;;; high byte will always remain the same for attributes...
	;;; (unless we start to implement multi-directional scrolling.  ugh.
	;;; then we'll have to use a look up table of some sort)
	JMP LoadATT_OuterLoop
	;JMP LoadATTLoop
AttLoadDone:
	;;; this means it's done.
	RTS
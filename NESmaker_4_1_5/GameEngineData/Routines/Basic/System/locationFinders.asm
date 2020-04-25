coordinatesToMetaNametableValue:
	;;; Let's use this as essentially a tile space to nametable translation.
	;; tileX is a value 0-15, tileY is a value 0-15
	LDA tileY
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL 
	STA temp
	LDA tileX
	ASL
	;STA updateNT_tableLeft
	AND #%00011110
	CLC
	ADC temp
	STA updateNT_pos
	LDA tileY
	LSR
	LSR
	CLC
	ADC #$20
	STA updateNT_pos+1
	RTS
	
coordinatesToNametableValue:
	;;; Let's use this as essentially a tile space to nametable translation on 8x8 grid.
	;; tileX is a value 0-32, tileY is a value 0-30
	LDA tileY
	LSR
	LSR
	LSR
	STA temp1
	
	LDA tileY 
	ASL
	ASL
	ASL
	ASL
	ASL ;; now this represents 1 row for each value in tileY
	STA temp
	LDA tileX
	clc
	ADC temp
	STA updateNT_pos
	LDA #$20
	CLC
	ADC temp1
	STA updateNT_pos+1
	RTS
	
	
	LDA tileY
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL 
	ASL
	STA temp
	LDA tileX
	ASL
	ASL
	;STA updateNT_tableLeft
	AND #%00011111
	CLC
	ADC temp
	STA updateNT_pos
	LDA tileY
	LSR
	LSR
	LSR
	CLC
	ADC #$20
	STA updateNT_pos+1
	RTS
	
		
	


	
GetTileAtPosition:
	LDA tileY				; loads temp y
	AND #%11110000				; divides then mults by 16 to get tile row
	STA tempz				; stores it into the temp variable
	LDA tileX			; same sort of thing with X
	LSR A
	LSR A
	LSR A
	LSR A
	ORA tempz
	TAY							; stores it into Y, which will be important in checking collision.
	RTS
	
	
GetAttributePosition:
	LDA tileY
	LSR
	
	asl
	asl
	asl ;; each y = one full row of offset...8 values.
	STA tempz
	LDA tileX
	LSR
	clc
	adc tempz
	CLC
	ADC #$c0 ;; because attributes start at 23"co"
	;
	RTS

bankswitchY:
	;STY currentBank
	STY currentBank
bankswitchNoSave:
	;LDA #$00
	;ORA banktable, y
	;STA banktable,y
	LDA currentBank
	AND #%00011111
	ORA chrRamBank
	
	STA $c000
	
	RTS	
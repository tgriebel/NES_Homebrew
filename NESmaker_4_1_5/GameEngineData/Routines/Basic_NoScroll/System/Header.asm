	.db "NES",$1a       ;iNES identifier

	.db $20         ;number of PRG-ROM blocks
	;;32 prg rom blocks
	.db $00         ;number of CHR-ROM blocks
	;;0 chr rom blocks, using chr ram
	.db %11100011 
	;;   ||||
	    ;MAP 3 2 1 0
	
	.db %00010000    ;ROM control bytes: Horizontal mirroring, no SRAM or trainer, Mapper #0
	;;   ||||
	   ; MAP - 7 6 5 4
	;;mapper 30
	
	.db $00,$00,$00,$00,$00,$00,$00,$00   ;filler
	;bank 0 
	.base $8000
	.include ROOT\BankData\Bank00.asm
	.pad $c000
	

		;bank 1
	.base $8000
	.include ROOT\BankData\Bank01.asm
	.pad $c000
	
		;bank 2 
	.base $8000
	.include ROOT\BankData\Bank02.asm
	.pad $c000
	
	
	;bank 3
	.base $8000
	.include ROOT\BankData\Bank03.asm
	.pad $c000
	
		;bank 4 
	.base $8000
	.include ROOT\BankData\Bank04.asm
	.pad $c000
	
		;bank 5
	.base $8000
	.include ROOT\BankData\Bank05.asm
	.pad $c000
	
		;bank 6
	.base $8000
	.include ROOT\BankData\Bank06.asm
	.pad $c000

		;bank 7
	.base $8000
	.include ROOT\BankData\Bank07.asm
	.pad $c000
	

		;bank 8 
	.base $8000
	.include ROOT\BankData\Bank08.asm
	.pad $c000
	
		;bank 10 (09)
	.base $8000
	.include ROOT\BankData\Bank09.asm
	.pad $c000
	
	
	;bank 11 (0a)
	.base $8000
	.include ROOT\BankData\Bank0A.asm
	.pad $c000
	
		;bank 12 (0b)
	.base $8000
	.include ROOT\BankData\Bank0B.asm
	.pad $c000
	
		;bank 13 (oc)
	.base $8000
	.include ROOT\BankData\Bank0C.asm
	.pad $c000
	
		;bank 14 (od)
	.base $8000
	.include ROOT\BankData\Bank0D.asm
	.pad $c000


	;bank 15 (0e)
	.base $8000
	.include ROOT\BankData\Bank0E.asm
	.pad $c000
	

		;bank 16 (0f)
	.base $8000
	.include ROOT\BankData\Bank0F.asm
	.pad $c000
	
		;bank 17 (10)
	.base $8000
	.include ROOT\BankData\Bank10.asm
	.pad $c000
	
	
	;bank 18 (11)
	.base $8000
	.include ROOT\BankData\Bank11.asm
	.pad $c000
	
		;bank 19  (12)
	.base $8000
	.include ROOT\BankData\Bank12.asm
	.pad $c000
	
		;bank 20 (13)
	.base $8000
		.include ROOT\BankData\Bank13.asm
	.pad $c000
	
		;bank 21 (14)
	.base $8000
	.include ROOT\BankData\Bank14.asm
	.pad $c000

	;bank 22 (15)
	.base $8000
	.include ROOT\BankData\Bank15.asm
	.pad $c000
	

		;bank 23 (16)
	.base $8000
		.include ROOT\BankData\Bank16.asm
	.pad $c000
	
		;bank 24 (17)
	.base $8000
		.include ROOT\BankData\Bank17.asm
	.pad $c000
	
	
	;bank 25 (18)
	.base $8000
		.include ROOT\BankData\Bank18.asm
	.pad $c000
	
		;bank 26 (19)
	.base $8000
		.include ROOT\BankData\Bank19.asm
	.pad $c000
	
		;bank 27 (1a)
	.base $8000
		.include ROOT\BankData\Bank1A.asm
	.pad $c000
	
		;bank 28 (1b)
	.base $8000
	.include ROOT\BankData\Bank1B.asm
	.pad $c000

		;bank 29  (1c)
	.base $8000
	.include ROOT\BankData\Bank1C.asm
	.pad $c000
	

		;bank 30 (1d)
	.base $8000
	.include ROOT\BankData\Bank1D.asm
	.pad $c000
	
		;bank 31 (1e)
	.base $8000
	.include ROOT\BankData\Bank1E.asm
	.pad $c000
	

	;bank fixed

	.org $c000 ; because c000 is the last 16kb of memory.  The first 16 starts at 8000, so
				; the swappable banks will go from 8000-bfff
				; everything here will be in the static bank.
				; everything moved into 8000 will be in the swappable 16k bank.
	
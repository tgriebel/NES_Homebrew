TileType00:
	.include ROOT\System\TileTypes\TileType00.asm
	RTS
	
TileType01:
	.include ROOT\System\TileTypes\TileType01.asm
	RTS
	
TileType02:
	.include ROOT\System\TileTypes\TileType02.asm
	RTS
	
TileType03:
	.include ROOT\System\TileTypes\TileType03.asm
	RTS
	
TileType04:
	.include ROOT\System\TileTypes\TileType04.asm
	RTS
	
TileType05:
	.include ROOT\System\TileTypes\TileType05.asm
	RTS
	
TileType06:
	.include ROOT\System\TileTypes\TileType06.asm
	RTS
	
TileType07:
	.include ROOT\System\TileTypes\TileType07.asm
	RTS
	
TileType08:
	.include ROOT\System\TileTypes\TileType08.asm
	RTS
	
TileType09:
	.include ROOT\System\TileTypes\TileType09.asm
	RTS
	
TileType10:
	.include ROOT\System\TileTypes\TileType10.asm
	RTS
	
TileType11:
	.include ROOT\System\TileTypes\TileType11.asm
	RTS
	
TileType12:
	.include ROOT\System\TileTypes\TileType12.asm
	RTS
	
TileType13:
	.include ROOT\System\TileTypes\TileType13.asm
	RTS
	
TileType14:
	.include ROOT\System\TileTypes\TileType14.asm
	RTS
	
TileType15:
	.include ROOT\System\TileTypes\TileType15.asm
	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
;;;============ TILE TYPE LUT
tileTypeBehaviorLo:
	.db <TileType00, <TileType01, <TileType02, <TileType03, <TileType04, <TileType05, <TileType06, <TileType07
	.db <TileType08, <TileType09, <TileType10, <TileType11, <TileType12, <TileType13, <TileType14, <TileType15
tileTypeBehaviorHi:	
	.db >TileType00, >TileType01, >TileType02, >TileType03, >TileType04, >TileType05, >TileType06, >TileType07
	.db >TileType08, >TileType09, >TileType10, >TileType11, >TileType12, >TileType13, >TileType14, >TileType15
	
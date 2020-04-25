	
	.include ROOT\System\BankSwitch.asm
	.include ROOT\System\LoadChrRam.asm
	.include SCR_HANDLE_FADES
	.include SCR_GAMEPAD_READ
	.include ROOT\System\HandleUpdateNametable.asm
	.include ROOT\System\locationFinders.asm
	.include ROOT\System\HandleInput.asm
	.include ROOT\System\LoadAttributesDirect.asm
	.include ROOT\System\LoadCollisionBytes.asm
	.include ROOT\System\LoadScreenData.asm
	.include ROOT\System\CheckForUpdateScreenData.asm

	.include ROOT\System\FindEmptyObjectSlot.asm
	.include ROOT\System\HandleUpdateObjects.asm
	
	
	.include ROOT\System\HandleMusic.asm
	.include ROOT\System\HandleScreenLoads.asm
;	.include ROOT\System\HandleStateChanges.asm
	;.include SCR_PHYSICS
;	.include SCR_TILE_COLLISION
	.include ROOT\System\ZeroOutAssets.asm
	.include SCR_HANDLE_BOUNDS
	

	.include SCR_HANDLE_LOAD_MONSTERS
	.include ROOT\System\LoadMetaNametableWithPaths.asm
	.include ROOT\System\GetRandomNumber.asm

	.include SCR_HANDLE_PLAYER_WIN
	.include ROOT\System\ConvertCollisionToNT.asm
	.include ROOT\System\GetAngleAndVelocity.asm
	.include ROOT\ModuleScripts\UserSubroutines.asm
	;.include ROOT\System\HandleHudData.asm
	.include ROOT\System\LoseLife.asm
	.include ROOT\System\ValueCounters.asm
	.include SCR_HANDLE_BOXES
	.include SCR_HANDLE_GAME_TIMER
	
HandlePlayerDeath:
	.include SCR_HANDLE_PLAYER_DEATH
	RTS
	
HandleGoToScreen:
	.include SCR_HANDLE_GOTO_SCREEN
	RTS
	
	
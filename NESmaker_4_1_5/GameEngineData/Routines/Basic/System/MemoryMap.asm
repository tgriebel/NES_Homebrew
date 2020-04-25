SpriteRam	  = $0200
CollisionRam  = $0300
ObjectRam 	  = $0400 ;; two pages for ObjectRam

userVariableRam = $0600 ;; user defined, game specific variable space.  Currently, 256 bytes capable by default.

FlashRamPage = $0700 ;; also used for a second collision table in this module
CollisionRam2 = $0700	
SoundRam = $0100
;;;;;;;;; SET UP SOUND RAM

	.include ROOT\Variables\ZP_and_vars.asm
	
	.enum SoundRam ;; also used by the stack, 
					;; but should never conflict.
		.include ROOT\System\ggsound_ram.asm
	.ende
	
;;;; SET UP COLLISION RAM	
	.enum CollisionRam
		collisionTable .dsb 256
	.ende
	.enum CollisionRam2
		collisionTable2 .dsb 256
	.ende
	
;; SET UP VARIABLE RAM	
	.enum userVariableRam
	.include ROOT\Variables\SystemVariables.asm
	.include "GameData\Variables\UserVariables.asm"
	.ende
	
	
	.enum ObjectRam
		;;; in some modules, like this base module, you'll need a lot of
		;;; extra variables to handle things like scrolling.
		;;; we'll stick these in the same 512 kb space
		;;; as the object variables.
		
		.include ROOT\Variables\ModuleVariables.asm
		.include GameData/Object_RAM.asm
	.ende
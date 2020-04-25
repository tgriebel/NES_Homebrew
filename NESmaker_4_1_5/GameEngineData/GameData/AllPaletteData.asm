AllPaletteData:

grayPals:
	.db #$0f, #$10, #$00,#$30,#$0f, #$10, #$00,#$30,#$0f, #$10, #$00,#$30,#$0f, #$10, #$00,#$30

	
allBlackPals:
	.db #$0f,#$0f,#$0f,#$0f, #$0f,#$0f,#$0f,#$0f, #$0f,#$0f,#$0f,#$0f, #$0f,#$01,#$05,#$30


;;;;; Palette Data:
;;STartScreen
.include "ScreenData2\Nametables\NT_StartScreen_Pal.txt"

;; Win Screen
.include "ScreenData2\Nametables\NT_WinScreen_Pal.txt"

  





	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; WOLDS DEFAULT	
	;.include "ScreenData\PaletteInfo.pal"
	.include "ScreenData\PaletteInfo.pal"
	.include "ScreenData\ObjectPals.pal"


	
	
Pal_PlayerNormal:	
	.db $0f,$18, $37, $1c


	

	

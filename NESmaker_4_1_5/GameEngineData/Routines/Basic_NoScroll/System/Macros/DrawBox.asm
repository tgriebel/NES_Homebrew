
MACRO DrawBox arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
	;arg 0 = box x origin
	;arg 1 = box y origin
	;arg 2 = box width
	;arg 3 = box height
	;arg 4 = box att width
	;arg 5 = box att height
	;arg 6 = 0= show sprites, 1 = hide sprites
	;arg 7 = just refresh the box
	;arg 8 = use textbox or just use blackout and attribute?


	
	LDA arg2
	STA updateNT_columns
	LDA arg3
	STA updateNT_rows
	LDA arg0
	STA tileX
	LDA arg1
	STA tileY
	JSR coordinatesToMetaNametableValue ;; this should be good for the rest of these routines.
	LDA arg7
	BEQ doFullBoxLoad
	JMP JustRefreshBoxArea
doFullBoxLoad:
	JSR BlackoutBoxArea
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA arg4
	STA updateNT_attWidth
	LDA arg5
	STA updateNT_attHeight

	JSR UpdateAttributeTable
	LDA arg8
	BNE doFillTextBoxArea
	;; don't fill text box area, just use black
	JMP doneWithBox
JustRefreshBoxArea:
	LDA arg8
	BNE doFillTextBoxArea
	JSR BlackoutBoxArea
	JMP doneWithBox
doFillTextBoxArea:
	JSR FillBoxArea
doneWithBox:
	ENDM
	
HandleInput:

	TXA
	STA tempx
	TYA
	STA tempy

	LDA currentBank
	STA tempBank
	

	
	
;;;;;;;;;;;;;;;;;HELD
	LDA #HELD_INPUTS
	BNE doHeldInputs
	JMP doneWithInputLoops_Held
doHeldInputs:
	LDA #$00
	STA loopTemp
GetDefinedInputsLoop_Held:
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Held,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Held
	JMP skipThisInput_Held
inputCheckGameStateIsCorrect_Held:
	;;;; now check gamepad variable against the
	;;; DefinedInputs table to see if the current
	;;; gamepad state matches any of the chosen inputs.
	
	
	
	LDA buttonStates
	
	
	AND DefinedInputs_Held,x ;; this AND checks button states and
								;; logically only checks about those
								;; states being asked about. If we remove this,
								;; the buttons have to be in the exact input state 
								;; as DefinedInputs_Pressed.  With it in, 
								;; left will still do left things even if b-button
								;; is pressed, for example. 
	CMP DefinedInputs_Held,x
	BNE skipThisInput_Held
	

	;LDX tempx
	;;;===========================
	;;;; TRAMPOLINE
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table.
	LDX DefinedTargetObjects_Held,y
	LDA TargetScriptBank,y
	TAY 
	LDA currentBank
	STA prevBank
	
	jsr bankswitchY
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.

	LDA DefinedTargetScripts_Held,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1
	JSR UseInputTrampoline_Held
	JMP passedInputTrampoline_Held
UseInputTrampoline_Held:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputTrampoline_Held:

	LDY prevBank
	JSR bankswitchY
	;;;===========================


skipThisInput_Held:
	INC loopTemp
	LDA loopTemp
	CMP #HELD_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Held
	JMP GetDefinedInputsLoop_Held
doneWithInputLoops_Held:


;;;;;;;;;;;;;;;END HELD	
	
	


;;;;;;;;;;;;;;;;;;;;PRESSED	
	;JMP AllButtonStatesChecked
	
	LDA #PRESSED_INPUTS
	BNE doPressedInputs
	JMP doneWithInputLoops_Pressed
doPressedInputs:
	
	LDA #$00
	STA loopTemp
GetDefinedPressedInputsLoop:
	
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Pressed,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Pressed
	JMP skipThisInput_Pressed
inputCheckGameStateIsCorrect_Pressed:
	
	LDA buttonStates
	AND DefinedInputs_Pressed,x
	BNE skipThisInput_Pressed
	
	LDA gamepad
	AND DefinedInputs_Pressed,x
	BEQ skipThisInput_Pressed
	


DoInputActionTrampoline:
	
	;LDX tempx
	;;;===========================
	;;;; TRAMPOLINE
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table.
	LDX DefinedTargetObjects_Pressed,y
	LDA TargetScriptBank,y
	TAY 
	LDA currentBank
	STA prevBank
	jsr bankswitchY
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.
	LDA DefinedTargetScripts_Pressed,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1

	JSR UseInputTrampoline
	JMP passedInputTrampoline
UseInputTrampoline:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputTrampoline: 

	LDY prevBank
	JSR bankswitchY
	;;;===========================


skipThisInput_Pressed:
	INC loopTemp
	LDA loopTemp
	CMP #PRESSED_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Pressed
	JMP GetDefinedPressedInputsLoop
doneWithInputLoops_Pressed:


;;===============RELEASED
	LDA #RELEASED_INPUTS
	BNE doReleasedInputs
	JMP doneWithInputLoops_Released
doReleasedInputs:
	LDA #$00
	STA loopTemp
GetDefinedInputsReleasedLoop:
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Released,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Released
	JMP skipThisInput_Released
inputCheckGameStateIsCorrect_Released:
	;;;; now check gamepad variable against the
	;;; DefinedInputs table to see if the current
	;;; gamepad state matches any of the chosen inputs.

	
	LDA buttonStates
	AND DefinedInputs_Released,x
	BEQ skipThisInput_Released
	
	LDA gamepad
	AND DefinedInputs_Released,x
	BNE skipThisInput_Released
							

	
DoInputActionTrampoline_Released:
	;JMP AllButtonStatesChecked
	;LDX tempx
	;;;===========================
	;;;; TRAMPOLINE
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table.
	LDX DefinedTargetObjects_Released,y
	;LDA DefinedTargetScripts_Released,y
	;TAY
	LDA TargetScriptBank,y
	TAY 
	LDA currentBank
	STA prevBank
	jsr bankswitchY
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.
	LDA DefinedTargetScripts_Released,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1
	JSR UseInputReleasedTrampoline
	JMP passedInputReleasedTrampoline
UseInputReleasedTrampoline:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputReleasedTrampoline:

	LDY prevBank
	JSR bankswitchY
	;;;===========================

	
skipThisInput_Released:
	INC loopTemp
	LDA loopTemp
	CMP #RELEASED_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Released
	JMP GetDefinedInputsReleasedLoop
doneWithInputLoops_Released:


;=======================

AllButtonStatesChecked:

	LDY #$14
	JSR bankswitchY
	JSR ExtraInputControl

	LDX tempx
	LDY tempy
	
	LDA gamepad
	STA buttonStates
	
	LDy tempBank
	JSR bankswitchY
	
	RTS

	
	
	
;dummy:
;;; no code
;	rts
	
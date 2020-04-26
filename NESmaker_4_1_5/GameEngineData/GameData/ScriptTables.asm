;; *************** ScriptTables.asm ***************
;; Script link export. Saturday, April 25, 2020 7:23:44 PM
ScriptAddressLo:
	.db #<Script00, #<Script01, #<Script02, #<Script03, #<Script04, #<Script05, #<Script06, #<Script07, #<Script08, #<Script09, #<Script0a, #<Script0b
ScriptAddressHi:
	.db #>Script00, #>Script01, #>Script02, #>Script03, #>Script04, #>Script05, #>Script06, #>Script07, #>Script08, #>Script09, #>Script0a, #>Script0b

TargetScriptBank:
	.db #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1

;;=======================PRESSED=======================
DefinedInputs_Pressed:
	.db #%00001000, #%00001000, #%00000010, #%00000001

DefinedScriptGameStates_Pressed:
	.db #GS_StartScreen, #GS_Win, #GS_MainGame, #GS_MainGame

DefinedTargetObjects_Pressed:
	.db #$00, #$00, #$00, #$00

TargetState_Pressed:
	.db #$00, #$00, #$00, #$00

DefinedTargetScripts_Pressed:
	.db #$00, #$01, #$0a, #$0b

;;=======================RELEASE=======================
DefinedInputs_Released:
	.db #%00010000, #%10000000, #%00100000, #%01000000

DefinedScriptGameStates_Released:
	.db #GS_MainGame, #GS_MainGame, #GS_MainGame, #GS_MainGame

DefinedTargetObjects_Released:
	.db #$00, #$00, #$00, #$00

TargetState_Released:
	.db #$00, #$00, #$00, #$00

DefinedTargetScripts_Released:
	.db #$06, #$07, #$08, #$09

;;=======================HOLD=======================
DefinedInputs_Held:
	.db #%00010000, #%10000000, #%00100000, #%01000000

DefinedScriptGameStates_Held:
	.db #GS_MainGame, #GS_MainGame, #GS_MainGame, #GS_MainGame

DefinedTargetObjects_Held:
	.db #$00, #$00, #$00, #$00

TargetState_Held:
	.db #$00, #$00, #$00, #$00

DefinedTargetScripts_Held:
	.db #$02, #$03, #$04, #$05


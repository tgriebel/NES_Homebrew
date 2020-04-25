;; go to prev action
	LDA Object_action_step,x
	AND #%00000111
	BEQ cycleToActionStep7
	SEC
	SBC #$01
	STA temp
	ChangeObjectState temp,#$02
	JMP +
cycleToActionStep7:
	ChangeObjectState #$07,#$02
+
	JSR DoNewAction
;; is advance action
	LDA Object_action_step,x
	AND #%00000111
	CLC
	ADC #$01
	CMP #$08
	BCC isAGoodActionStepValue
	;; is over 8, so go back to 1

	ChangeObjectState #$00,#$02
	JSR DoNewAction
	JMP actionTimerFinished
isAGoodActionStepValue:
	STA temp
	ChangeObjectState temp,#$02
	JSR DoNewAction
	LDA gamepad
	AND #%00000010 ;; is b button pressed?
	BEQ skipShowingText
	
	LDA Object_ID,x
	STA stringTemp ;;  3 will be passed on to text routine
	;;;; it holds the number within the group to draw.
	
	;;; set a flag to handle this next frame
	LDA #$01
	STA textBoxFlag
	
	
skipShowingText:
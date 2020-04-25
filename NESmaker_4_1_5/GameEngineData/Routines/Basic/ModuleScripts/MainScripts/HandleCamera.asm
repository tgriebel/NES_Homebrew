HandleCamera:


	LDA xScroll_hi
	STA camL_hi
	LdA xScroll
	STA camL_lo
	
	LDA xScroll
	CLC
	ADC #$FF
	
	STA camR_lo
	LDA camL_hi
	ADC #$00
	STA camR_hi
	;;;;;;;;;;;;;;;;;;;;;;;;
	;; This is where monsters are gauge to have reached the 'edge' of existable space.
	
	LDA camL_lo
	SEC
	SBC #MONSTER_CAMERA_PAD
	STA camPad_L_lo
	LDA camL_hi
	SBC #$00
	STA camPad_L_hi
	
	LDA camR_lo
	CLC
	ADC #MONSTER_CAMERA_PAD
	STA camPad_R_lo
	LDA camR_hi
	ADC #$00
	STA camPad_R_hi

	
	CPX player1_object
	BNE doHandleCameraBoundsCheck
	RTS
doHandleCameraBoundsCheck:

	JSR HandleCameraBoundsCheck
	RTS

	
	
	;;; HANDLE EDGE BEHAVIOR
DoMonsterEdgeBehavior:	

	;JSR StopAtEdge
	LDA Object_edge_action,x
	AND #%00001111
	BEQ doNothingAtEdge
	STA temp
	
	LDY temp
	LDA AI_ReactionTable_Lo,y
	STA temp16
	LDA AI_ReactionTable_Hi,y
	STA temp16+1
	

	
	JSR doReactionTrampoline
	JMP pastReactionTrampoline
doReactionTrampoline:
	JMP (temp16) ;;; this now does the action
			;; and when it hits the RTS in that action,
			;; it will jump back to the last JSR it saw,
			;; which was doNewActionTrampoline...which will immediately
			;; jump to pastDoNewActionTrampoline.
pastReactionTrampoline:

doNothingAtEdge:

	RTS
	
	
	
	
StopAtEdge:
	LDA xPrev
	STA Object_x_hi,x
	STA xHold_hi
	LDA yPrev
	STA Object_y_hi,x
	STA yHold_hi
	LDA #$00
	STA Object_x_lo,x
	STA xHold_lo
	STA Object_y_lo,x
	STA xHold_lo
	
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	
	LDA Object_movement,x
	AND #%00001111
	STA Object_movement,x
	RTS
	
	
HandleMonsterPadCheck
;;;; CHECK AGAINST CAM LEFT.
	;JMP +
	LDA xHold_hi
	CLC
	ADC Object_left,x
	LDA Object_scroll,x
	ADC #$00
	STA temp
	
	LDA temp
	CMP camPad_L_hi
	BCC ObjectAtPadEdge
	BNE isNotLeftOfPad
	LDA xHold_hi
	CLC
	ADC Object_left,x
	CMP camPad_L_lo
	BCC ObjectAtPadEdge
isNotLeftOfPad:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CHECK AGAINST CAM RIGHT
	LDA xHold_hi
	CLC
	ADC Object_right,x
	LDA Object_scroll,x
	ADC #$00
	STA temp
	LDA camPad_R_hi
	CMP temp
	BCC ObjectAtPadEdge
	BNE isNotRightOfPad
	LDA xHold_hi
	CLC
	ADC Object_right
	STA temp
	LDA camPad_R_lo
	CMP temp
	BCC ObjectAtPadEdge
isNotRightOfPad:
	
	RTS
	
ObjectAtPadEdge:

	DeactivateCurrentObject
	RTS
	
HandleCameraBoundsCheck
	;;; first, check top and bottom.
	

	
	LDA yHold_hi
	CLC
	ADC Object_top,x
	CMP #BOUNDS_TOP
	BCS +
	JMP notOutsideOfCamera ;; this jumps to handling monster edge reaction
+
	LDA yHold_hi
	CLC
	ADC Object_bottom,x
	CMP #BOUNDS_BOTTOM
	BCC +
	JMP notOutsideOfCamera ;; this jumps to handling monster edge reaction
+
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CHECK AGAINST CAM LEFT.
	CPX player1_object
	BNE +
	LDA xScroll_hi
	BNE + ; not on screen 0
	;; is on screen zero

	LDA xScroll
	CLC
	ADC Object_left,x
	CMP xHold_hi
	BCS ObjectAtCameraEdge
+

	LDA xHold_hi
	CLC
	ADC Object_left,x
	LDA Object_scroll,x
	ADC #$00

	CMP camL_hi
	BCC ObjectAtCameraEdge
	BNE isNotLeftOfCam
	; LDA xHold_hi
	; CLC
	; ADC Object_left,x
	; CMP camL_lo
	; BCC ObjectAtCameraEdge
	LDA camL_lo
	CLC
	ADC Object_left,x
	CMP xHold_hi
	BCS ObjectAtCameraEdge
	
	JMP isNotLeftOfCam
isNotLeftOfCam:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CHECK AGAINST CAM RIGHT
	LDA xHold_hi
	CLC
	ADC Object_right,x
	LDA Object_scroll,x
	ADC #$00
	STA temp

	LDA camR_hi
	CMP temp
	BCC ObjectAtCameraEdge
	BNE isNotRightOfCam
	LDA xHold_hi
	CLC
	ADC Object_right,x
	STA temp
	LDA camR_lo
	CMP temp
	BCC ObjectAtCameraEdge
isNotRightOfCam:

	LDA Object_status,x
	AND #%11111011
	STA Object_status,x
	;; show this object
	RTS
ObjectAtCameraEdge:
	LDA Object_status,x
	AND #%00000100
	BEQ notOutsideOfCamera
	JSR HandleMonsterPadCheck
	;;; this object is outside of camera.
	RTS
notOutsideOfCamera:
	JSR DoMonsterEdgeBehavior
	RTS
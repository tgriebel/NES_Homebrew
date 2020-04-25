;; prior to this routine being called, the macro
;; needs info on the timer, so that it can appropriately set it to start with.

HandleFadeLevels:
	LDA fadeByte
	BNE doHandleFadeLevels
	RTS
doHandleFadeLevels:

	LDX #$00 ; start loop
LoadBackgroundPal_FADES:
	CPX #$08
	BCC palValueIsLessThan8
	LDA bitwiseLut,x
	AND fadeSelect_bck+1
	JMP checkThisPalVal
palValueIsLessThan8:
	LDA bitwiseLut,x
	AND fadeSelect_bck
checkThisPalVal:
	BNE getFadedAmountForThisValue 
	LDA bckPal,x
	JMP gotPalValue
getFadedAmountForThisValue:
	LDA fadeLevel
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC bckPal,x
	BPL palValueIsGreaterThanZero
	;;pal value is less than zero.
	;;maintain the actual value for fades, but
	;;anything less than zero in a signed value
	;;draws #$0f (black).
	;; So actual buffer value is in tact for fade math,
	;; but keeps the appearance of fading to black.
	LDA #$0f
	JMP gotPalValue
palValueIsGreaterThanZero:
	CMP #$3c ;; is it as light as it can possibly be?  if so, make it white.
	BCC palValueIsLessThan3c
	LDA #$30
palValueIsLessThan3c:
gotPalValue:
	STA bckPalFade,x
	INX
	CPX #$10
	BNE LoadBackgroundPal_FADES
	RTS


HandleFades:
	LDA fadeByte
	BNE doHandleFades
	RTS
doHandleFades:
	;uses fadeByte	
		; 7 = fade is active
		; 6 = fade darker / fade lighter ;; 0 = fade to dark color, 1 = fade to light color
		;_____________________________
		; 5 = LOOP
		; 4 = loading data
		; 3 = fade in
				;; now that we're doing this way, we can almost certainly
				;; combine this and just have one bit that determines if data is
				;; being loaded, to put fade on pause.
		;______________________________
		; 2 = "snap" fade out. Instant black or instant white, immediate to full step fade out.
			;whether black or white is determined by bit 6
		; 10 = how many steps to fade? - only 4 possible values - all the way out is 5.
		
		
	
	;uses fadeSpeed.
		;7 = load new data? 0=no, 1=yes
		;6 = does "fade out"? 0=no, 1=yes
			;; fade out in this case doesn't necessarily mean 'gets darker'.
			;; it just means ping pongs to the fade in script before
			;; returning to normal game.
		;5 = fade sprites? 0=no, 1=yes.
			;; if no, just the background will fade.
		;43210 = fade speed, *3 (asl x 3)
		
	;; checkFadeTimer
	DEC fadeTimer
	BEQ dontKeepRunningFadeTimer
	JMP keepRunningFadeTimer
dontKeepRunningFadeTimer:
	;;fade timer is up.  First thing to do is reset the timer.
	LDA fadeSpeed
	AND #%00011111
	ASL
	ASL
	STA fadeTimer
	LDA fadeByte
	AND #%01000000 ; is this fade to light or dark?
	BNE fadeToWhite
	;;; fade to black
	LDA fadeLevel
	sec
	sbc #$1
	JMP gotNewPalVal
fadeToWhite:
	LDA fadeLevel
	clc
	adc #$1
gotNewPalVal:
	STA fadeLevel
	BPL positiveValueForFadeLevel
	;; negative value for fade level
	EOR #$ff
	CLC
	ADC #$01

positiveValueForFadeLevel:
	STA temp
	;; first, check if this is looper.
	;; if it is not a looper (pulsing type of fade), then
	;; if this fade level is zero, it should *stop* fading. 
	;; this is the most standard type of fade...fade out, do things, fade back in to 0.
	LDA fadeLevel
	CLC
	ADC #$05
	BEQ stopFading 
	LDA fadeLevel
	SEC
	SBC #$05
	BEQ stopFading
	JMP nevermindCheckingForPalLoop
	
stopFading:	
	;; it is at zero
	LDA fadeByte
	AND #%00100000 ;; is it a looper?
	BEQ checkForPalLoop
	JMP nevermindCheckingForPalLoop ;; yes, it is a looper
checkForPalLoop:
	;;no, it is not a looper
	LDA #$00
	STA fadeByte

	;;;; check for load data first
	;;=================
	
	LDA fadeSpeed
	AND #%10000000 ;; this is the bit, in the byte, that sees if we need to load data
	BNE needToLoadData 
	JMP noNeedToLoadData
needToLoadData:
	;;; yes, we need to load new data.


	;LoadChrData #GraphicsBank01, #$10, #$40, #$0, BckChr00
	;LoadBackgroundPalette BckPal00
	
	;;load the pointer info
	;LDA currentBank
	;STA prevBank
	;LDY #$16
	;JSR bankswitchY
	;;; now we can get the offset from the screen tables.
	;;;;;;; if type is 0, check NameTablePointers
		;;; if type is 1, check NameTablePointers_Map1
		;;; if type is 2, check NameTablePointers_Map2
	;LDA newScreen	
	;ASL			
	;TAX
	;LDA NameTablePointers_Map1+0,X
	;STA temp16
	;LDA NameTablePointers_Map2+1,X
	;STA temp16+1
	
	;LoadNametableData #$01, NT_Rm50, #$01, #$80
	;LoadAttributeData #$01, AT_Rm50, #$38, #$08

	;LDY prevBank
	;JSR bankswitchY
	
	LDA #$00
	STA fadeLevel
	LDA #$00
	STA fadeByte
	
noNeedToLoadData:

	;; Check to see if we load data during fade
	;;====================
	
	JMP doneWithFade
nevermindCheckingForPalLoop:
	
	LDA fadeByte
	AND #%00000011
	CMP temp
	BNE doneWithFade ;; haven't reached the end yet.
	;;; we've reached the last step
	;;; we need to check to see if that's it, or if it should pingpong background

	;; now check to see if we're done or we're going to pingpong
	LDA fadeSpeed
	AND #%01000000 ;; does it pingpong?
	BNE doPingPongFade
	LDA #$00
	STA fadeByte
	JMP doneWithFade
doPingPongFade:
	LDA fadeLevel
	BMI changeToFadeIn
	;; change to fade out
	LDA fadeByte
	AND #%10111111
	JMP pingPongDone
changeToFadeIn:
	LDA fadeByte
	ORA #%01000000
pingPongDone:
	STA fadeByte
	
	
dontChangeThisValue:

	
keepRunningFadeTimer:

doneWithFade:
	RTS
	
	
	

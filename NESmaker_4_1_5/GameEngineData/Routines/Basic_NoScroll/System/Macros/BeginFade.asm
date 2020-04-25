MACRO BeginFade arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7
	;arg0 = FADE_DARKEN or FADE_LIGHTEN
	;arg1 = fadeSpeed
	;arg2 = steps to fade out of 4
	;arg3 = loads new data 0=no, 1=yes
	;arg4 = reverse fade at end FADE_AND_HOLD = no, FADE_AND_RETURN = yes
	;arg5 = loop? FADE_ONCE = no, FADE_LOOP = yes
	;arg6 = values to fade, first set of 8
	;arg7 = values to fade, second set of 8
	

	LDA arg2
	AND #%00000011 ;; force to 4 steps, even if they accidentally put a different number
	ORA #arg0
	ORA #arg5
	ORA #%10000000
	STA fadeByte

	
	LDA arg3
	LSR
	BCC noDataLoad
	;; yes data load
	ORA #%10000000
noDataLoad:
	STA temp
	LDA arg1
	AND #%00011111 ;; force to 5 values for speed
	ORA #arg4
	ORA temp
	STA fadeSpeed
	
	LDA fadeSpeed
	AND #%00011111
	ASL
	ASL
	STA fadeTimer
	
	LDA arg6
	STA fadeSelect_bck
	LDA arg7
	STA fadeSelect_bck+1
	
	ENDM
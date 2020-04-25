MACRO PlaySound arg0
	;;arg0 = song index
	;;arg1 = priority
	LDA arg0
	STA sfxToPlay
	LDA fireSoundByte
	ORA #%00000010
	STA fireSoundByte
	ENDM
	
	
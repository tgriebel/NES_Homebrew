MACRO StopSound
	LDA fireSoundByte
	ORA #%00000001
	STA fireSoundByte
	ENDM
	
	
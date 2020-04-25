MACRO PlaySong arg0
	;;arg0 = song index
	LDA arg0
	STA songToPlay
	LDA fireSoundByte
	ORA #%00000100
	STA fireSoundByte
	ENDM
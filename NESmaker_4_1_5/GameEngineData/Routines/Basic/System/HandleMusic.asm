HandleMusic:

	LDA fireSoundByte
	BEQ skipAllSoundUpdates
	;; there ARE sound bytes

	LDA currentBank
	STA prevBank
	LDY #BANK_MUSIC
	JSR bankswitchY
	
	LDA #$00
	STA sound_param_byte_0
	STA sound_param_byte_1
	
	LDA fireSoundByte
	AND #%00000001
	BEQ notStoppingSound
	;;; is stopping sound.  Is there also a sound effect to play?
	jsr sound_stop
	LDA fireSoundByte
	AND #%11111110
	STA fireSoundByte
	;;;; also check for sound effect, like in a start screen scenario
	LDA fireSoundByte
	AND #%00000010
	BEQ noSFXtoPlay
		
	LDA #$00
	STA fireSoundByte
	LDA sfxToPlay
	STA sound_param_byte_0
	;LDA sfxPriority
	LDA #soundeffect_one
	STA sound_param_byte_1
	jsr play_sfx
	JMP noSoundUpdates
notStoppingSound:
	LDA fireSoundByte
	AND #%00000100
	BEQ noMusicToPlay
	LDA fireSoundByte
	AND #%11111011
	STA fireSoundByte

	LDA songToPlay
	sta sound_param_byte_0
    jsr play_song
	
noMusicToPlay:
	LDA fireSoundByte
	AND #%00000010
	BEQ noSFXtoPlay
	LDA fireSoundByte
	AND #%11111101
	LDA #$00
	STA fireSoundByte
	LDA sfxToPlay

	STA sound_param_byte_0
	;LDA sfxPriority
	LDA #soundeffect_one

	STA sound_param_byte_1
	jsr play_sfx
	
noSFXtoPlay:

noSoundUpdates:
	LDY prevBank
	JSR bankswitchY
skipAllSoundUpdates:

	RTS
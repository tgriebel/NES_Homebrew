	LDA temp
	CMP #TILE_INDEX_LOCK
	BNE ++
	LDA #TILE_OPENDOOR ;; what tile do you want under lock?
	STA temp
	JMP notPath
++
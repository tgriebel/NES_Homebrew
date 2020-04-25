MACRO LoadChrData arg0, arg1, arg2, arg3, arg4
	;; This loads CHR data to the PPU.  
	;; It is designed for updates when rendering is turned OFF.
	
	;; arg0 is what bank to draw from
	;; arg1 feeds what 'row' the pattern table will load to
	;; arg2 feeds what 'column'.  it must end in zero (be a multiple of 16)
	;; arg3 feeds how many tiles load.
	;; arg4 tiles to load - from table.
	
	LDA arg0
	STA tempBank
	LDA arg1
	STA temp
	LDA arg2
	STA temp3
	LDA arg3
	STA TilesToLoad
	JSR LoadChrRam
	ENDM

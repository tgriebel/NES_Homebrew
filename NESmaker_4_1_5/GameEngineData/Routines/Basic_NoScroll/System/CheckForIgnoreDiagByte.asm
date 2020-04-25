
CheckForIgnoreDiagDataByte:
	;; this routine checks to see how to draw
	;; paths, and ignores pathing
	;; when adjacent to an
	;; ignore path value.
	
	;; top, left, bottom, right,** tl, bl, br, tr
	LDA temp
	CLC
	ADC #$10 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ notTopBitPath
	LDA ignorePath
	ORA #%10000000
	STA ignorePath
notTopBitPath:

	LDA temp
	CLC
	ADC #$30 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	TAY
	
	LDA collisionTable,y
	AND #%01000000
	BEQ notBottomBitPath
		
	LDA ignorePath
	ORA #%00100000
	STA ignorePath
notBottomBitPath:
	LDA temp
	CLC
	ADC #$1 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	CLC
	ADC #$20
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ notRightBitPath
	LDA ignorePath
	ORA #%00010000
	STA ignorePath
notRightBitPath:
	LDA temp
	sec
	sbc #$1 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	CLC
	ADC #$20
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ notLeftBitPath
	LDA ignorePath
	ORA #%01000000
	STA ignorePath
notLeftBitPath:
	;; top left
	LDA temp
	CLC
	ADC #$10 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	sec
	SBC #$01
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ upLeftDiagNotAPath
	LDA ignorePath
	ORA #%00001000
	STA ignorePath
	
upLeftDiagNotAPath
;; bottom left
	LDA temp
	CLC
	ADC #$30 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	sec
	SBC #$01
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ downLeftDiagNotAPath
	LDA ignorePath
	ORA #%00000100
	STA ignorePath
downLeftDiagNotAPath:
; bottom right
	LDA temp
	CLC
	ADC #$30 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	clc
	adc #$01
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ downRightDiagNotAPath
	LDA ignorePath
	ORA #%00000010
	STA ignorePath
downRightDiagNotAPath:
; top right
	LDA temp
	CLC
	ADC #$10 ;; 10 more is ntadd +20, - 10 due to coll table being 20 more than.  this gives us above
	clc
	adc #$01
	TAY
	LDA collisionTable,y
	AND #%01000000
	BEQ upRightDiagNotAPath
	LDA ignorePath
	ORA #%00000001
	STA ignorePath
upRightDiagNotAPath:
	RTS
	
	
	
	
	
	
	
		
handelPathTop:
	
	;; i am a path
	;; check if above me is a path
	;; first check to see if i am at the top edge of the screen.
	LDA temp
	CMP #$10
	BCs notPathTopEdge
	;; if it is an edge, assume 'above would be the path', where it continues to the next screen.
	
	JMP aboveMeIsAPath
notPathTopEdge:	

;;;; don't forget...collision table starts at *20, where nametable starts a *00 ... hud values still present in collisionTable
	LDA ignorePath
	AND #%10000000
	BNE aboveMeIsAPath
	
	
	LDY temp
	TYA
	SEC
	SBC #$10
	TAY
	LDA (temp16),y
	;; now we have path above me.
	CMP temp3 ;; if it is also a path
	BEQ notaboveMeNotAPath
	JMP aboveMeNotAPath
notaboveMeNotAPath:
	;; if above me IS a path...check left and right
aboveMeIsAPath:

	LDA temp
	AND #%00001111
	BNE notOnLeftEdge3
	JMP topLeftIsDiagPath ;; this just keeps it full path
notOnLeftEdge3:
	
	;LDA ignorePath
	;AND #%01000000
	;BNE leftIsAPath

	
	LDA ignorePath
	AND #%01000000
	BEQ skipIgnoreLeftPath
	LDA temp3
	STA $2007
	JMP checkTopRightPath
skipIgnoreLeftPath:	
	
	
	;LDY temp
	;TYA
	LDA temp
	SEC
	SBC #$01
	TAY
	LDA (temp16),y
	CMP temp3 ;; if left is a path
	BNE leftIsNotAPath
leftIsAPath:	

	LDA temp
	CMP #$10
	BCc topLeftIsDiagPath
	
	
	LDA ignorePath
	AND #%00001000
	BNE topLeftIsDiagPath
	;;if top and left are a path, check diagonal
	TYA
	SEC
	SBC #$10 ;; check diagonal above
	TAY
	LDA (temp16),y
	CMP temp3
	BNE topLeftDiagNotAPath
	;; if top left diag IS a bath
topLeftIsDiagPath:
	LDA temp3
	STA $2007
	JMP checkTopRightPath
topLeftDiagNotAPath:
	LDA temp3
	clc
	adc #$0b
	STA $2007
	JMP checkTopRightPath
leftIsNotAPath:
	

	LDA temp3
	CLC
	ADC #$05
	STA $2007
	
checkTopRightPath:
	LDA temp
	CLC
	ADC #$01
	AND #%00001111
	BNE notOnLeftEdge4
	JMP topRightIsDiagPath ;; just makes it 'full path'
notOnLeftEdge4:

	LDA ignorePath
	AND #%00010000
	BNE rightIsPath

	LDA temp
	CLC
	ADC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	BNE rightIsNotAPath
rightIsPath:
	
	LDA ignorePath
	AND #%00000001
	BNE topRightIsDiagPath

	LDA temp
	CMP #$10
	BCc topRightIsDiagPath
	
	
	
topRightNotPath:
	LDA ignorePath
	AND #%00010000
	BEQ skipIgnoreRightPath
	LDA temp3
	STA $2007
	JMP aboveMeDone
	
skipIgnoreRightPath:
	
	TYA
	SEC
	SBC #$10
	TAY 
	LDA (temp16),y
	CMP temp3
	BNE topRightDiagNotAPath
topRightIsDiagPath:
	LDA temp3
	STA $2007
	JMP aboveMeDone
topRightDiagNotAPath:
	LDA temp3
	clc
	adc #$0d
	STA $2007
	JMP aboveMeDone
rightIsNotAPath
	LDA temp3
	clc
	adc #$06
	STA $2007
	
	JMP aboveMeDone
	
aboveMeNotAPath:
	;;check left
	LDA temp
	AND #%00001111
	BNE notOnLeftEdge
	JMP leftButNotTopIsAPath
notOnLeftEdge:

	LDA temp
	SEC
	SBC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	;; is top not a path and left is not a path?
	BNE topAndLeftNotPath
	;; top is not but left is a path
leftButNotTopIsAPath:


	LDA temp3
	clc
	adc #$02
	STA $2007
	JMP topLeftIsDone
topAndLeftNotPath:
	LDA temp3
	clc
	adc #$01
	STA $2007
topLeftIsDone:
	;; check top right
	LDA temp
	CLC
	ADC #$01
	AND #%00001111
	BNE notOnRightEdge
	JMP rightButNotTopIsAPath
notOnRightEdge:

	LDA temp 
	CLC
	ADC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	BNE topAndRightNotPath
rightButNotTopIsAPath:
	LDA temp3
	clc
	adc #$03
	STA $2007
	JMP topRightIsDone
topAndRightNotPath:
	LDA temp3
	clc
	adc #$04
	STA $2007
topRightIsDone:
aboveMeDone:	
	RTS
	
	
	
handlePathBottom:
	
	LDA ignorePath
	AND #%00100000
	BNE belowMeIsAPath
	
	TYA
	CLC
	ADC #$10
	TAY
	LDA (temp16),y
	;; now we have path below me.
	CMP temp3 ;; if it is also a path
	BEQ belowMeIsAPath 
	JMP belowMeNotAPath
	;; if above me IS a path...check left and right
belowMeIsAPath:
	LDA temp
	AND #%00001111
	BNE notOnLeftEdge5
	JMP bottomLeftIsDiagPath ;; this just keeps it full path
notOnLeftEdge5:
	
	LDA ignorePath
	AND #%01000000
	BEQ skipIgnoreLeftPath2
	LDA temp3
	STA $2007
	JMP checkBottomRightPath
skipIgnoreLeftPath2:	

	LDA temp
	SEC
	SBC #$01
	TAY
	LDA (temp16),y
	CMP temp3 ;; if left is a path
	BNE leftIsNotAPath2
	;;if top and left are a path, check diagonal
leftIsAPath2:
	LDA ignorePath
	AND #%00000100
	BNE bottomLeftIsDiagPath
	

	TYA
	CLC
	ADC #$10 ;; check diagonal above
	TAY
	LDA (temp16),y
	CMP temp3
	BNE bottomLeftDiagNotAPath
	;; if top left diag IS a bath
bottomLeftIsDiagPath:
	LDA temp3
	STA $2007
	JMP checkBottomRightPath
bottomLeftDiagNotAPath:
	LDA temp3
	clc
	adc #$0c
	STA $2007
	JMP checkBottomRightPath
leftIsNotAPath2:
	
	LDA temp3
	clc
	adc #$05
	STA $2007
	
checkBottomRightPath:
	

	LDA temp
	CLC
	ADC #$01
	AND #%00001111
	BNE notRightEdge
	JMP bottomRightDiagPath
notRightEdge:
	
	LDA ignorePath
	AND #%00010000
	BEQ skipIgnoreRightPath2
	LDA temp3
	STA $2007
	JMP belowMeDone
skipIgnoreRightPath2:

	LDA temp
	CLC
	ADC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	BNE rightIsNotAPath2
rightIsAPath:
	LDA ignorePath
	AND #%00000010
	BNE bottomRightDiagPath

	TYA
	clc
	adc #$10
	TAY 
	LDA (temp16),y
	CMP temp3
	BNE bottomRightDiagNotAPath
bottomRightDiagPath:
	LDA temp3
	STA $2007
	JMP aboveMeDone
bottomRightDiagNotAPath:
	LDA temp3
	clc
	adc #$0e
	STA $2007
	JMP aboveMeDone
rightIsNotAPath2:
	LDA temp3
	clc
	adc #$06
	STA $2007
	
	JMP belowMeDone
	
belowMeNotAPath:
	;;check left
	LDA temp
	AND #%00001111
	BNE notOnLeftEdge2
	JMP leftButNotBottomIsAPath
notOnLeftEdge2:	

	LDA temp
	SEC
	SBC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	;; is top not a path and left is not a path?
	BNE bottomAndLeftNotPath
	;; top is not but left is a path
leftButNotBottomIsAPath:
	LDA temp3
	clc
	adc #$08
	STA $2007
	JMP bottomLeftIsDone
bottomAndLeftNotPath:
	LDA temp3
	clc
	adc #$07
	STA $2007
bottomLeftIsDone:
	;; check top right
	LDA temp
	clc
	adc #$01
	AND #%00001111
	BNE notOnRightEdge2
	JMP rightButNotBotomIsAPath
notOnRightEdge2:

	LDA temp 
	CLC
	ADC #$01
	TAY
	LDA (temp16),y
	CMP temp3
	BNE bottomAndRightNotPath
rightButNotBotomIsAPath:
	LDA temp3
	clc
	adc #$09
	STA $2007
	JMP topRightIsDone
bottomAndRightNotPath:
	LDA temp3
	clc
	adc #$0a
	STA $2007
bottomRightIsDone:
belowMeDone:
	INY
	RTS
	
	
	
	
	

handleBlankTile:
	
	STA $2007
	LDA temp
	;CLC
	;ADC #$01
	;TAY
	LDA #BLANK_TILE
	;; the first tile
	STA $2007
	
	LDA temp
	TAY
	INY	

	RTS	
		
;;;; LOAD FROM CONSTANTS - this may want to change once we're dealing with saves

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Triggers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	LDA #INIT_TRIG_00
	STA screenTriggers+0
	LDA #INIT_TRIG_01
	STA screenTriggers+1
	LDA #INIT_TRIG_02
	STA screenTriggers+2
	LDA #INIT_TRIG_03
	STA screenTriggers+3
	LDA #INIT_TRIG_04
	STA screenTriggers+4
	LDA #INIT_TRIG_05
	STA screenTriggers+5
	LDA #INIT_TRIG_06
	STA screenTriggers+6
	LDA #INIT_TRIG_07
	STA screenTriggers+7
	LDA #INIT_TRIG_08
	STA screenTriggers+8
	LDA #INIT_TRIG_09
	STA screenTriggers+9
	LDA #INIT_TRIG_0a
	STA screenTriggers+10
	LDA #INIT_TRIG_0b
	STA screenTriggers+11
	LDA #INIT_TRIG_0c
	STA screenTriggers+12
	LDA #INIT_TRIG_0d
	STA screenTriggers+13
	LDA #INIT_TRIG_0e
	STA screenTriggers+14
	LDA #INIT_TRIG_0f
	STA screenTriggers+15
	LDA #INIT_TRIG_10
	STA screenTriggers+16
	LDA #INIT_TRIG_11
	STA screenTriggers+17
	LDA #INIT_TRIG_12
	STA screenTriggers+18
	LDA #INIT_TRIG_13
	STA screenTriggers+19
	LDA #INIT_TRIG_14
	STA screenTriggers+20
	LDA #INIT_TRIG_15
	STA screenTriggers+21
	LDA #INIT_TRIG_16
	STA screenTriggers+22
	LDA #INIT_TRIG_17
	STA screenTriggers+23
	LDA #INIT_TRIG_18
	STA screenTriggers+24
	LDA #INIT_TRIG_19
	STA screenTriggers+25
	LDA #INIT_TRIG_1a
	STA screenTriggers+26
	LDA #INIT_TRIG_1b
	STA screenTriggers+27
	LDA #INIT_TRIG_1c
	STA screenTriggers+28
	LDA #INIT_TRIG_1d
	STA screenTriggers+29
	LDA #INIT_TRIG_1e
	STA screenTriggers+30
	LDA #INIT_TRIG_1f
	STA screenTriggers+31
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


	LDX #$00
	LDA #$00
	STA temp
setDrawOrderDefaultValues:
	STA drawOrder,x
	INC temp
	LDA temp
	INX
	CPX #$10
	BNE setDrawOrderDefaultValues
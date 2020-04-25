
RESET:
	SEI		;ignore interrupts for the reset
	LDA #$00	; load the number 00
	STA $2000	; disables NMI
	STA $2001	; disables rendering
	STA $4010	; disables DMC IRQ (needed depending on mapper I guess?)
	STA $4015	; disables APU sound
	LDA #$40	; Loads the number 64
	STA $4017	; disables the APU IRQ
	CLD			; disables decimal mode (why needed?)
	LDX	#$FF		; loads 255 (why?)
	TXS			; initializes the stack
	
;5. First vblank wait
	; what is vblank?
	; NES draws scan lines from top to bottom.  During the time it takes
	; for the light beam to move back up to the top is a waiting period
	; called vblank...it gives us time to update what is drawn to the screen.
	bit $2002
vBlankWait1:
	bit $2002
	BPL vBlankWait1
	
;6. Clear all ram 
	;LDA #$00
	LDX #$00
clrMemLoop:
	LDA #$00
	STA $0000,x
	STA $0100,x 
	;; skip 200, this is where the sprites are drawn
	;; we'll set them to $FE to draw them off screen
	STA $0300,x
	STA $0400,x
	STA $0500,x
	STA $0600,x
	STA $0700,x
	LDA #$FE		; instead of zero, write #$FE to 0200,x
	STA $0200,x		; to place sprites off screen
	INX
	BNE clrMemLoop
	
;7. Second vblank 
vBlankWait2:
	bit $2002
	BPL vBlankWait2
	
	;LDA #$00
	;STA canEnablePPU
;8 Enable NMI
	LDA #%10010000	; turn on NMI, set sprites $0000, bkg to $1000
	STA $2000
;	STA soft2000
	LDA #%00011110
	STA $2001
	STA soft2001
	
	LDA #$00
	sTA $2005
	STA $2005
	;;DON'T TURN ON RENDERING UNTIL FIRST GRAPHICS ARE DRAWN?
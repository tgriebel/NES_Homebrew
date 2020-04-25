






GamePadCheck:
	LDA #$01
	STA $4016
	LSR
	STA $4016
	
	LDA #$80
	STA gamepad
	
ReadControllerBytesLoop:
	LDA $4016
	AND #%00000011
	CMP #%00000001
	ROR gamepad
	BCC ReadControllerBytesLoop
	RTS
	LDA gamepad
	AND #%11000000
	CMP #%11000000
	BNE NoFilter_LR
	
	EOR gamepad
	STA gamepad
NoFilter_LR:
	LDA gamepad
	AND #%00110000
	CMP #%00110000
	BNE NoFilter_UD
	EOR gamepad
	STA gamepad
NoFilter_UD:
	RTS



	
	
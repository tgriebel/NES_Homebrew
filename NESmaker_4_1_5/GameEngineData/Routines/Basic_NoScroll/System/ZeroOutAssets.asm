DrawAllSpritesOffScreen:
	LDA #$FE
	LDY #$00
LoopDrawAllSpritesOffScreen:
	STA $0200,y
	INY
	INY
	INY
	INY
	BNE LoopDrawAllSpritesOffScreen
	RTS
	
	
DeactivateAllObjects:
	LDA #$00
	LDY #$0
LoopDeactivateAllObjects:
	STA Object_status,y
	INY
	CPY #TOTAL_MAX_OBJECTS
	BNE LoopDeactivateAllObjects
	RTS
	
	
MoveTowardsPlayer:
	MoveTowardsPoint temp, temp1, temp2, temp3, #$01
	RTS	

ValMonsterCompare:
	.db #%00001000, #%00000100, #%00000010, #%00000001
	
ValToBitTable:
	.db #%10000000, #%01000000, #%00100000, #%00010000, #%00001000, #%00000100, #%00000010, #%00000001
	
ValToBitTable_inverse:
	.db #%00000001, #%00000010, #%000000100, #%00001000, #%00010000, #%00100000, #%01000000, #%10000000
	
DirectionMovementTable:
	
	.db #%00110000, #%11110000, #%11000000, #%11100000, #%00100000, #%10100000, #%10000000, #%10110000

HexShiftTable:
	.db #$00, #$10, #$20, #$30, #$40, #$50, #$60, #$70, #$80, #$90, #$a0, #$b0, #$c0, #$d0, #$e0, #$f0
	
DoubleBitTable:
	.db #%00000011, #%00001100, #%00110000, #%11000000
	
ObjectPlacementByteIndex:
	.db #$83, #$84, #$85, #$9e ;; monsters, day
	.db #$86, #$87, #$88, #$9f ;; monsters, night
	.db #$8A, #$8B, #$8C, #$a0;; triggered day
	.db #$8e, #$8f, #$90, #$a1 ;; triggered night
	
ObjectIDByteIndex:
	.db #$a2, #$a3, #$a4, #$a5 ;; monsters day	
	.db #$aA, #$aB, #$ac, #$ad ;;monsters night
	.db #$a6, #$a7, #$a8, #$a9 ;;  triggered day
	.db #$aE, #$af, #$b0, #$b1 ;; triggered, night.
	
	
.include "ScreenData\WeaponOffset.dat"

HUD_Element_table:
	.db #BOX_0_ASSET_0_TYPE, #BOX_0_ASSET_1_TYPE, #BOX_0_ASSET_2_TYPE, #BOX_0_ASSET_3_TYPE
	.db #BOX_0_ASSET_4_TYPE, #BOX_0_ASSET_5_TYPE, #BOX_0_ASSET_6_TYPE, #BOX_0_ASSET_7_TYPE


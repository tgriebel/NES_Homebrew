	CPX player1_object
	BEQ +
	JMP dontDoCheckpoint
+

	LDA Object_x_hi,x
	STA continuePositionX
	LDA Object_y_hi,x
	STA continuePositionY
	LDA currentMap
	STA continueMap
	LDA Object_scroll,x
	STA continueScreen
	PlaySound #SND_VICTORY
	TriggerScreen continueScreen
	ChangeTileAtCollision #$00, #TILE_CHECKPOINT_CLEARED
dontDoCheckpoint:
	
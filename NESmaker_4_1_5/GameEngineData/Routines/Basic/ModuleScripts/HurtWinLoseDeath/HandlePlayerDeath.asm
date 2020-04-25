	CPX player1_object
	BNE +
	JSR HandlePlayerDeath
	PlaySound #SND_HURT_PLAYER
+

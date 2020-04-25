;; instant death
	CPX player1_object
	BNE +
	JSR HandlePlayerDeath
+
	RTS
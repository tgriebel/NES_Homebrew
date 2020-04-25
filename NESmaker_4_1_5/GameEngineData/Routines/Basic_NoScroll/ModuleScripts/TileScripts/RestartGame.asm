;; if you wanted a tile that just reset the game.
cpx player1_object
BNE dontResetGame_tile
JSR HandlePlayerDeath

dontResetGame_tile
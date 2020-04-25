;;; Teleport
JSR FindFreePosition		
LDA spawnX
STA Object_x_hi,x
LDA spawnY
STA Object_y_hi,x
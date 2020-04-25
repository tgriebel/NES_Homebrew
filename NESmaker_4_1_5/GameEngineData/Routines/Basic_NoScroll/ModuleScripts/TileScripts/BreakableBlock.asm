;; ASSUMES PROJECTILE or BREAKER OBJECT is #$03

;;; SOLID
;;;This is how to inform a solid collision.
;;; You can also add this to the end of
;;; any tile type if you want it to have an effect AND
;;; be treated like solid.
;;; You could also check to see if it is a non-player object,
;;; and only return solid if it's a not player.  This would
;;; cause monsters to treat things like spikes or ladder or fire
;;; as solid while the player is able to interract with it.





	LDA #TILE_SOLID
	STA tile_solidity
	
	;; if you want it solid, declare it at the end
	LDA Object_type,x
	CMP #$03 ;; is a projectile?  Change this is you want to use a different object #.
	BNE dontBreakThisBlock
	
	
	ChangeTileAtCollision #$00, underStomp
	PlaySound #SFX_BREAKABLE_BLOCK
	
	
dontBreakThisBlock:
	
	
	

;;; SOLID
;;;This is how to inform a solid collision.
;;; You can also add this to the end of
;;; any tile type if you want it to have an effect AND
;;; be treated like solid.
;;; You could also check to see if it is a non-player object,
;;; and only return solid if it's a not player.  This would
;;; cause monsters to treat things like spikes or ladder or fire
;;; as solid while the player is able to interract with it.
	;; for a PLATFORMER, solidity is handled a little bit different.
	
	
;;; RIGHT NOW, you can also use this tile as a MONSTER LOCK or a COLLECTABLE LOCK
;;; tile type 5, by default, simply uses this code, but changes to walkable when monsters are destroyed.
;;; tile type 6, by default, simply uses this code, but changes to walkable and flips screen state when collectables are collected


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ALL THAT IS NEEDED FOR TOP DOWN
	;LDA #TILE_SOLID
	;STA tile_solidity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;; if you want it solid, declare it at the end

	.include Tile_01
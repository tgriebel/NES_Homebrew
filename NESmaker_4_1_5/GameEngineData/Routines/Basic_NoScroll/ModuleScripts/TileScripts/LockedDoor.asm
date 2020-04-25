;;; SOLID
;;;This is how to inform a solid collision.
;;; You can also add this to the end of
;;; any tile type if you want it to have an effect AND
;;; be treated like solid.
;;; You could also check to see if it is a non-player object,
;;; and only return solid if it's a not player.  This would
;;; cause monsters to treat things like spikes or ladder or fire
;;; as solid while the player is able to interract with it.

;;; RIGHT NOW, this changes to the underSecret type tile.
;;; And it changes to the 00 type (walkable) collision.
;;; to change this to a different collision type, for instance a warp,
;;; change the first argument in the ChangeTileAtCollision macro below.

	LDA #TILE_SOLID
	STA tile_solidity
	
	;; if you want it solid, declare it at the end
	

	
	;; is collision position loaded into y?
	; CPX player1_object
	; BNE +
	; LDA myKeys
	; SEC
	; SBC #$01
	; BMI +
	; STA myKeys


		; LDA myKeys
		; LDA #$01 ;; amount of score places?
		; STA hudElementTilesToLoad
		; LDA DrawHudBytes
		; ORA #HUD_myKeys
	; STA DrawHudBytes
	; ChangeTileAtCollision #$02, underSecret
	
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; ;;; IF YOU WANT THE LOCK TO STAY GONE, Trigger the screen.
	; ;;; if not, comment this out.
	; TriggerScreen screenType
	; PlaySound #SFX_LOCKED_DOOR
	
+
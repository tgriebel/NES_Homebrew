;;; This script is designed to work with a button press or release event.
;;; The latter part of the code could be used at any time with any 
;;; conditional that could be turned off after firing if you wanted to draw
;;; a textbox that was not in conjunction with a button press.

;;; It will look at the screen's text group and use what is in the variable textVar as an index.
;;; If textVar is 0, it will activate the first text string in the currently loaded string group for the screen.
;;; If textVar is 1, it will activate the second text string.  Etc etc etc.
	  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 1: Determine if the text box is already drawn		   
;; Especially when using button commands to activate a textbox, we want the first push
;; to activate it, while the second push begins the deactivate process.
;; Bit 4 determines if the box is currently drawn to screen or if there is no box
;; on screen, which tells the game whether to start the box-draw, or start the
;; restoration of nametable draw.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA textboxHandler
		AND #%00010000               
		BEQ checkToTurnTheTextboxOn ;; start textbox
		;; start nametable restoration
		;; first, disable input:
		LDA gameHandler
		ORA #%00100000
		STA gameHandler
		;; Then zero out offsets in case they are not set to zero.
		LDA #$00
		STA updateNT_offset
		STA updateNT_H_offset
		STA updateNT_V_offset
		;;; flipping bit 7 starts the textbox code on next frame.
		;;; Also flipping bit 3 puts it in "restore nametable" mode.
		LDA #%10001000
		STA textboxHandler
		;;; Return from subroutine - textbox is now being
		;;; overwritten by nametable data.
		RTS
	   
	checkToTurnTheTextboxOn:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 2: Check for NPC collision
;; In most standard NPC cases, you want to check an npc_collision flag
;; to see if you are colliding with an NPC or not.  This flag gets set in the
;; Object collision scripts if the object you are colliding with an object tagged
;; as an NPC. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		;LDA npc_collision
		;BEQ doneWithTextboxToggle ;; if it is zero, skip turning on textbox.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 3: Turn on textbox.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; if it is already in the process of loading, do not turn it on.
		LDA textboxHandler
		AND #%10000000
		BNE doneWithTextboxToggle
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; Disable input while textbox is loading.
		LDA gameHandler
		ORA #%00100000
		STA gameHandler
	turnTheTextboxOn:
		;; Flipping this bit starts the textbox drawing process.
		LDA #%10000000
		STA textboxHandler
		
	doneWithTextboxToggle:
	;; if this was used with an input, it needs to return from the subroutine.
		RTS
	
    RTS
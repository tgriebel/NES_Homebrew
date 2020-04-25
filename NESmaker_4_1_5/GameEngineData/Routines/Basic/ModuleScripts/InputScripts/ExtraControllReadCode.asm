;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In this script, you can use extra code to define what may happen
;; with inputs if you are in a particular state.
;; For instance, this could check to see if a player is climbing,
;; and his up/down dpad button are pressed, to determine if 
;; he should change to climbing animation rather than idle animation.

;; Or if he is in attacking action in air versus on ground,
;; it may show a different action state.

;; Basically, this script can be used for any catch all
;; control schemes that simple input handler does not.
;; You could even write an entire input engine here
;; and skip the default input engine used by the GUI. 
;; 

ExtraInputControl:
	
skipMainGameExtraInputControl:  
    
    RTS
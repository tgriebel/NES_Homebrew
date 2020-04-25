
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 1: Set up map
;; You want to put the number map, either 0 or 1, that you want to go to
;; into warpMap.  By default this is loaded with screen data, so if you have
;; the "warp to underground" ticked in screen info, when the screen loaded, it
;; set warpMap to 1.  If not, it set it to zero.  However, if you want to manually 
;; handle this, load 0 to currentMap for overworld, 1 for underworld, instead of 
;; what is stored in warpMap.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	LDA warpMap
	STA currentMap
	;;; GoToScreen's second argument writes to "screen details".
	;;; If it is 0 it indicates a special screen, so
	;;; making it 1 would be overworld and 2 would be underworld.
	;;; This is why we add one to the value of the map
	;;; to get the correct screen details, which this macro uses in its
	;;; second argument.
	CLC
	ADC #$01
	STA temp
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART 2: Start the screen change.
;; The first argument is the screen you will warp to.
;; You can replace this with an arbitrary number if you just want to go to a certain screen.
;; By default, this uses the warpToScreen variable, which is set when you load
;; the screen based on what you have selected in the screen info.
;; Alternatively, you could set up collision with an object or tile type to set
;; the warpToScreen variable.  This is a way to set up multiple
;; warps per screen aside from the warpToScreen value set up in the screen info.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	GoToScreen warpToScreen, temp, #$02
	
	;;;;; If this is used as an input script,
	;;;;; it needs a return from subroutine.
	RTS
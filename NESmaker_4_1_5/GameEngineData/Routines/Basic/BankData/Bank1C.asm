
;;; ALL THE DATA FIRST
.include "ScreenData\ObjectInfo.dat"
.include "ScreenData\ObjectPointers.pnt"
.include "ScreenData\ObjectData\ObjectLutTable.dat"
;=========================================================
ObjectReaction:
.include "ScreenData\ObjectData\SolidEdgeObjectReaction.dat" ;; put this in lut table
;========================================================

;; THEN THE SUB ROUTINES

	.include SCR_HANDLE_DRAWING_SPRITES

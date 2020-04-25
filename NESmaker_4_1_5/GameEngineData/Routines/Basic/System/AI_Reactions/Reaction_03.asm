;; object is outside the camera frame, so "hide" it.  It is still active
;; but won't render or cause collisions.	
	
	LDA Object_status,x
	ORA #%00000100
	STA Object_status,x
	
	
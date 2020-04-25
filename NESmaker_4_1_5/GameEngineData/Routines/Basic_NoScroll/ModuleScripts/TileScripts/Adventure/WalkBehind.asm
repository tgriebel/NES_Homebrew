;; walk behind tile
;; this will push the entire sprite of an object behind the background,
;; so it is best used in conjunction with an "open door" that is transparent.

	LDA Object_state_flags,x
	ORA #%00100000
	STA Object_state_flags,x
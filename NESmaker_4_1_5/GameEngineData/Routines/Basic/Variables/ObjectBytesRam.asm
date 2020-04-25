
	; Object_status .dsb 10 ; required
			; ;;;; bits 765 = activation/deactivation
			; ;;;; bit 3 = reserved for edge/random spawning, but waiting for timer
			; ;;;; bit 2 = active but off screen?
			; ;;;; bit 0 = "hurt and invincible" (used for recoil direction)
			; ;;;; bit 1 = "post-invincible hurt" (still invincible but has regained input control)
	; Object_type .dsb 10 ; required
		; Object_physics_byte	.dsb 10 
		; ;; bit 0 = on ground.
						; ;;;; could handle other bits for wall jump, double jump, etc.
						; ;;; BIT 7 - 6 = top bits were collision
						; ;;; BUT 5 - 4 = bottom bits were collision
	; Object_x_hi	.dsb 10 ; required
		
	; Object_x_lo .dsb 10 ; required
	; Object_y_hi	.dsb 10 ; required
	; Object_y_lo	.dsb 10 ; required 
; ;	Object_max_speed	.dsb 10 ;; NOT REQUIRED, can read from look up.

						
						
	; Object_v_speed_lo	.dsb 10 ;; required
	; Object_v_speed_hi	.dsb 10 ;; required
	; Object_h_speed_lo	.dsb 10	;; required
	; Object_h_speed_hi	.dsb 10


; ;	Object_size			.dsb 10 ;; NOT REQUIRED, can read from look up.,
	; Object_movement		.dsb 10 ;; required 
; ;	Object_bbox_left	.dsb 10 ;; NOT REQUIRED, can read from lookup.
; ;	Object_bbox_top		.dsb 10 ;; NOT REQUIRED, can read from lookup
; ;	Object_width		.dsb 10 ;; NOT REQUIRED, can read from lookup
; ;	Object_height		.dsb 10 ;; NOT REQUIRED, can read from lookup
	; Object_vulnerability .dsb 10 ;; NOT REQUIRED, can read from lookup
	; Object_action_timer	.dsb 10 ;; required
	; Object_animation_timer . dsb 10
	; Object_health		.dsb 10 ;; required
	; Object_animation_frame .dsb 10
	; Object_action_step		.dsb 10  ;; 8 steps, thus 32 potential types of action with remaining bits.
										; ;; xxxxxyyy where y = action step and x = behavior type.
	; Object_animation_offset_speed .dsb 10	;; 7654 = offset, 3210 = speed.
											; ;; to be updated every time animation type changes.
		; Object_end_action				.dsb 10
		; Object_edge_action				.dsb 10
; ;;;=========================================
; ;;These variables are stored pointers to the object'so
; ;; direction table lookup in ram, which points to the
; ;; stuff to draw.  Keeping them with the object should speed things up
; ;; considerably by saving two address jumps for every single tile drawn!

	; Object_table_lo_lo     .dsb 10
	; Object_table_lo_hi		.dsb 10
	; Object_table_hi_lo		.dsb 10
	; Object_table_hi_hi		.dsb 10
	; Object_total_tiles		.dsb 10 
	; ;; these, will be loaded into temp10 or another pointer.  Then an offset will be factored.
	; ;;;
; ;;==============================================
; ;;===============================================
	; Object_timer_0		.dsb 10 ;; generally used for hurt timer.
								; ;; though a state could also be used for a hurt timer, this provides another option.
	
; ;	Object_worth			.dsb 10 ;; NOT REQUIRED, can read from look up
; ;	Object_acc_amount		.dsb 10 ;; NOT REQUIRED, can read from lookup
; ;	Object_strength_defense	.dsb 10 ;; NOT REQUIRED can read from look up
	; Object_flags			.dsb 10 ;;Required if you ever want to use it in collision routines!
								
			
									
						
; ;; SOME OF THE NON-REQUIREDS will only work if being called from static bank
; ;; so, for instance, do collisions in static bank so bboxes, vulnerability, etc
; ;; can be accessed by having anim bank loaded.
; ;;;;;;;;;;;;;;;;;;;
; ; THERE CAN BE ROOM FOR TWO USER DEFINED VARIABLES
; ; AND STILL HAVE ROOM TO PUT SCROLL RAM HERE
	; Object_ID			.dsb 10
							; ;; object ID is not type, it is ID of screen object.
							; ;; this can only be 0-15.
							; ;; that leaves a whole nibble free.
							; ;; we can use bit 0 as the overflow scroll byte.
												
	; Object_home_screen	.dsb 10	
							; ;; we will use this to determine whether or not a placed object
							; ;; has already been created.
							
							; ;; right now, this can just be a flag that never gets unflagged once and object is created
							; ;; unless the object has been un-created
							
							; ;; this can represent an object's home screen.
							; :; Then, it can look through objects
							; ;; to see if any have the same ID?
							
							
							
							
	; Object_scroll		.dsb 10
	; Object_top			.dsb 10
	; Object_bottom		.dsb 10
	; Object_left			.dsb 10
	; Object_right		.dsb 10
	; Object_origin_x		.dsb 10
	; Object_origin_y		.dsb 10


;;;;;;;;;; 432 bytes used by this point, with 12 objects.
;;;;;;;;;; gained 72 bytes by putting it down to 10
;;;;;;;;;. 152 bytes left.



	updateNT_fire_Address_Lo	.dsb 16
	updateNT_fire_Address_Hi	.dsb 16
	updateNT_fire_Tile			.dsb 16
	
	updateNT_att_fire_Address_lo	.dsb 8
	updateNT_att_fire_Address_hi	.dsb 8
	updateNT_fire_Att				.dsb 8
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 8 bytes remain. 
	updateCol_columns .dsb 1
	updateCol_columnCounter .dsb 1
	updateCol_rowCounter .dsb 1
	updateCol_rows .dsb 1
	updateCol_table		.dsb 1
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; collision update stuff stuff	
;;;; FOR SCROLLING
;;;**********************************
;;; SCROLL TEST
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xScroll .dsb 1
	xScroll_hi .dsb 1
	yScroll .dsb 1
	rowTracker .dsb 1
	showingNametable	.dsb 1
	scrollNTCheck		.dsb 1
	checkForSpriteZero	.dsb 1
	doUpdateColumn		.dsb 1
	readyToUpdateScroll .dsb 1
	
	;collisionPointer	.dsb 2
	nametableOffset .dsb 1
	
	columnTracker	.dsb 1 ;; this keeps track of what scroll column is shown.
	;collisionColumnTracker .dsb 1
	columnToPull	.dsb 1 ;; this keeps track of what column of a nametable to pull from
	columnToUpdate	.dsb 1 ;; this keeps track of what column to write to.
	scrollDirection	.dsb 1 ;; 0 = left, 1 is right.

	overwriteAtt_column	.dsb 1
	
	objectScrollOffset		.dsb 1
	
	currentNametable	.dsb 1
	secondNametable		.dsb 1
	rightNametable		.dsb 1
	leftNametable		.dsb 1
	
	newNametable		.dsb 1
	colTemp	.dsb 1
	columnPointer		.dsb 2
	OverwriteNT_column	.dsb 1 
	OverwriteNT_row		.dsb 1
	forceScroll	.dsb 1
	NMI_scrollNT		.dsb 1
	
	
	columnTrackerHi			.dsb 1
	scrollColumn		.dsb 1
	scrollUpdateInProgress	.dsb 1
	screenFlags	.dsb 1
	newNtCued .dsb 1
	nt_hold					.dsb 1
	rNT						.dsb 1
	lNT						.dsb 1
	scroll_hold				.dsb 1
	screenSeam					.dsb 1
	ObjectSeamLoadFlag		.dsb 1
	objectColumnHold		.dsb 1
;	tilesToWrite	.dsb 1
	
	camL_lo					.dsb 1
	camL_hi					.dsb 1
	camR_lo					.dsb 1
	camR_hi					.dsb 1
	tempNT					.dsb 1
	objectID_forSeamLoad		.dsb 1
	theFlag					.dsb 1
	tempObj					.dsb 1
	loadMonsterColumnFlag	.dsb 1
	loadingTilesFlag		.dsb 1

		
	.include GameData/Object_RAM.asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




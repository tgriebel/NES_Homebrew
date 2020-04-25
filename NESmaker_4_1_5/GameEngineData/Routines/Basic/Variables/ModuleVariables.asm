

		HudChecker				.dsb 1

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
	
		
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




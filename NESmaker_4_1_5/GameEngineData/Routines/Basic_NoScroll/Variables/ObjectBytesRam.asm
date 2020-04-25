



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
	
	

		
	.include GameData/Object_RAM.asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




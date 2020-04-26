;; *************** Object_RAM.asm ***************
;; Object RAM export. Saturday, April 25, 2020 7:23:44 PM

TOTAL_MAX_OBJECTS = #$0a

Object_status .dsb 10
Object_type .dsb 10
Object_physics_byte .dsb 10
Object_x_hi .dsb 10
Object_x_lo .dsb 10
Object_y_hi .dsb 10
Object_y_lo .dsb 10
Object_v_speed_lo .dsb 10
Object_v_speed_hi .dsb 10
Object_h_speed_lo .dsb 10
Object_h_speed_hi .dsb 10
Object_movement .dsb 10
Object_vulnerability .dsb 10
Object_action_timer .dsb 10
Object_animation_timer .dsb 10
Object_health .dsb 10
Object_animation_frame .dsb 10
Object_action_step .dsb 10
Object_animation_offset_speed .dsb 10
Object_end_action .dsb 10
Object_edge_action .dsb 10
Object_table_lo_lo .dsb 10
Object_table_lo_hi .dsb 10
Object_table_hi_lo .dsb 10
Object_table_hi_hi .dsb 10
Object_total_tiles .dsb 10
Object_timer_0 .dsb 10
Object_flags .dsb 10
Object_ID .dsb 10
;;;Object_home_screen .dsb 10
Object_scroll .dsb 10
Object_top .dsb 10
Object_bottom .dsb 10
Object_left .dsb 10
Object_right .dsb 10
Object_origin_x .dsb 10
Object_origin_y .dsb 10
Object_state_flags .dsb 10

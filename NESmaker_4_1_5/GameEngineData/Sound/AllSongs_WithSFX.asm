song_index_EmptySong = 0
song_EmptySong = 0

sfx_index_sfx_emptySFX = 0
sfx_emptySFX = 0

song_list:
	.dw EmptySong

sfx_list:
	.dw _sfx_emptySFX

instrument_list:
	.dw Silence_0
	.dw Silent_1

Silence_0:
	.db 5, 7, 9, 11, ARP_TYPE_ABSOLUTE
	.db 0,ENV_STOP
	.db 0,ENV_STOP
	.db 0,DUTY_ENV_STOP
	.db ENV_STOP
Silent_1:
	.db 5, 7, 9, 11, ARP_TYPE_ABSOLUTE
	.db 0,ENV_STOP
	.db 0,ENV_STOP
	.db 0,DUTY_ENV_STOP
	.db ENV_STOP

EmptySong:
	.db 0
	.db 6
	.db 0
	.db 5
	.dw EmptySong_square1
	.dw EmptySong_square2
	.dw EmptySong_triangle
	.dw EmptySong_noise
	.dw 0

EmptySong_square1:
	.db CAL,<(EmptySong_square1_0),>(EmptySong_square1_0)
	.db GOT
	.dw EmptySong_square1

EmptySong_square2:
	.db CAL,<(EmptySong_square2_0),>(EmptySong_square2_0)
	.db GOT
	.dw EmptySong_square2

EmptySong_triangle:
	.db CAL,<(EmptySong_triangle_0),>(EmptySong_triangle_0)
	.db GOT
	.dw EmptySong_triangle

EmptySong_noise:
	.db CAL,<(EmptySong_noise_0),>(EmptySong_noise_0)
	.db GOT
	.dw EmptySong_noise


EmptySong_square1_0:
	.db STI,1,SL8,A0
	.db RET


EmptySong_square2_0:
	.db STI,1,SL8,A0
	.db RET


EmptySong_triangle_0:
	.db STI,1,SL8,A0
	.db RET


EmptySong_noise_0:
	.db STI,1,SL8,0
	.db RET



_sfx_emptySFX:
	.db 0, 1
	.db 0, 1
	.dw 0
	.dw 0
	.dw 0
	.dw 0
	.dw 0



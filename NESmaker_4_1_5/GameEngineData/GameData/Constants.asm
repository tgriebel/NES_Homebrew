;;;;;;;;;;;;;;;;;;;;;;;;;;;
;====CODE DEFINITIONS

	;.include "GameData\CodeTargets.asm"
	.include "ScreenData\Init.ini"
	.include "GameData\SFXLinks.dat"
	.include "GameData\UserDefinedConstants.asm"

;====END CODE DEFINITIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;=========================
;;HUD BIT DEFINES
HUD_ELEMENT_1 = #%10000000
HUD_ELEMENT_2 = #%01000000
HUD_ELEMENT_3 = #%00100000
HUD_ELEMENT_4 = #%00010000
HUD_ELEMENT_5 = #%00001000
HUD_ELEMENT_6 = #%00000100
HUD_ELEMENT_7 = #%00000010
HUD_ELEMENT_8 = #%00000001


;ROOT EQU Routines\Adventure.0

;;===========================

HIDE_SPRITES = #%01111111 ;; gameHandler, bit 7 is sprites
SHOW_SPRITES = #%10000000 ;; 

;;;===============================
;; USED FOR SCROLLING

;SCROLL_LEFT_PAD = #$60 ;; value #$00-#$7f
;SCROLL_RIGHT_PAD = #$90 ;; value #$80-#$FF
;SCROLL_SPEED = #$02


;;=================================


SPRITE_ZERO_MAIN_GAME = #$01

MAX_VSPEED = $6 ;; used for gravity?
;GRAVITY_LO = $40
;GRAVITY_HI = $0
;JUMP_SPEED = #$20

;;============================

TIMER_SPEED = #$20

HUD_TILES_START = $c0

SCREEN_01 EQU NT_Rm50

SCREEN_DATA_OFFSET = #$78

vLog = #$00
vTS = #$00
PAL_GO_1_temp = #$00
PAL_GO_2_temp = #$01

TILE_NOT_SOLID = #$00
TILE_SOLID = #$01
TILE_JUMPABLE = #$02 ; requires a game with 2.5 d
TILE_SINKABLE = #$03 ; requires a game with 2.5 d

;;;;; THESE ARE FOR TABLE LOOKUPS FOR CHR
SCREEN_START = #$00
SCREEN_WIN = #$01
SCREEN_HUD = #$02

;; used for HandleStateChange scripts
STATE_START_GAME = #$01
STATE_CONTINUE	= #$02
STATE_RESTART_PRESERVED = #$03
STATE_WIN_GAME = #$04


;;; TO BE PUT IN INI WHEN WE FIGURE HUD SIZE
HUD_TILE_OFFSET = #$00
HUD_ATT_OFFSET = #$00
HUD_COL_OFFSET = #$00
;;; which also means that any space in there is wasted space.  Something to consider.


DATABANK1 = #$14 
DATABANK2 = #$18
BANK_PALETTES = #$16

FullScreenCHRLoad = #$00
MainGameScreenCHRLoad = #$60
ScreenSpecificGameScreenCHRLoad = #$20
PathGameScreenCHRLoad = #$10
HudScreenCHRLoad		= #$40

MOVE_RIGHT	= #%11000000
MOVE_LEFT 	= #%10000000
MOVE_DOWN	= #%00110000
MOVE_UP		= #%00100000
MOVE_RIGHT_DOWN = #%11110000
MOVE_LEFT_DOWN  = #%10110000
MOVE_RIGHT_UP	 = #%11100000
MOVE_LEFT_UP	 = #%10100000


PAD_RIGHT = #%10000000
PAD_LEFT = #%01000000
PAD_DOWN = #%00100000
PAD_UP = #%00010000
PAD_START = #%00001000
PAD_SELECT = #%00000100
PAD_B = #%00000010
PAD_A = #%00000001



STOP_RIGHT = #%01111111
STOP_LEFT = #%00111111
STOP_UP = #%11001111
STOP_DOWN = #%11011111
STOP_RIGHT_DOWN = #%01011111
STOP_LEFT_DOWN = #%00011111
STOP_RIGHT_UP = #%01001111
STOP_LEFT_UP = #%00001111

		
HUD_UPDATE_SCORE = #%10000000
HUD_UPDATE_STRENGTH = #%01000000
HUD_UPDATE_DEFENSE = #%00100000
HUD_UPDATE_MAGIC = #%00010000
HUD_UPDATE_MUSIC = #%00001000
HUD_UPDATE_CURRENCY = #%00000100
HUD_UPDATE_HEALTH = #%00000010

	
SCREEN_ROW_LENGTH = #$10	
SCREEN_SUB_LENGTH = $12 ;; how many screens does above ground have vs below ground
						;; used to jump to sub set of screens
SCREEN_CAVES = $1B
ICE_ACC_SPEED = #$05


STATUS_COLOR_NORMAL = #$00
STATUS_COLOR_POISONED = #$01
STATUS_COLOR_UNDEAD = #$02
STATUS_COLOR_CONFUSED = #$03
STATUS_COLOR_INVINCIBLE = #$04

DAY_LENGTH = #$4
TOTAL_OBJECT_NUMBER = #$8

STATUS_COLOR_POSITIVEEFFECTS = #$05 ;; this is where music change no longer affects, because is playing music

STATUS_COLOR_REVIVER = #$05

STATUS_POISON = #%00001001
STATUS_UNDEAD = #%11010100
	
AI_Speed_Fast = #$10
AI_Speed_Medium_Fast = #$20
AI_Speed_Medium = #$40
AI_Speed_Medium_Slow = #$60
AI_Speed__Slow = #$80

GraphicsBank00 = #$1d
GraphicsBank01 = #$10
GraphicsBank02 = #$11
GraphicsBank03 = #$12
ObjectGraphicsBank00 = #$15
ObjectGraphicsBank01 = #$13

SCREENCHANGE_FromBottom = #$00
SCREENCHANGE_FromRight = #$01
SCREENCHANGE_FromTop = #$02
SCREENCHANGE_FromLeft = #$03
SCREENCHANGE_nonDirectional = #$04


CON_null = #$00
CON_up = #$01
CON_down = #$02
CON_left = #$03
CON_right = #$04
CON_a = #$05
CON_b = #$06

CON_select_up = #$07
CON_select_down = #$08
CON_select_left = #$09
CON_select_right = #$0A
CON_select_a	= #$0B
CON_select_b	= #$0C

	
		; - Joystick
PAD_A		= $01
PAD_B		= $02
PAD_SELECT 	= $04
PAD_START	= $08
PAD_U		= $10
PAD_D		= $20
PAD_L		= $40
PAD_R		= $80

;; BANKS
BANK_DATA 	= $1A
BANK_MUSIC 	= $1b
BANK_ANIMS 	= $1C
BANK_TILES	= $1D
BANK_STRINGS	= $17
		
		
.include "GameData\HUD_CONSTANTS.dat"
		
		;status
		
STATUS_NORMAL = $00
STATUS_HURT   = $01
STATUS_DIGGING = $02

;object types (should be 64)
;; row 0 = player things
;;row 1 = effects
;starting in row 2, monsters
OBJ_PLAYER	= $00
OBJ_LUTE	= $01 ;; okay, this is simply for an 8x8
					;; collision area, so that it's easy
					;; to define in all directions
					;; later try making tile width and
					;; tile height 0 so it doesn't draw
					;; sprite, but width and height and depth
					;; are still there to create collisions
					;; then attack 'sprites' to drawing function?
					;; like with shadow?
OBJ_CRYSTAL = #$02
OBJ_PROJ	= #$03
OBJ_POWERUP_LIFE = #$04
OBJ_POWERUP_MAGIC = #$05
OBJ_POWERUP_CURRENCY = #$07
OBJ_POWERUP_MUSIC = #$06
OBJ_POOF		= #$08
OBJ_STRIKE		= #$09
OBJ_EXPLOSION	= #$0A


DROP_LIFE	= #$00
DROP_MAGIC	= #$01
DROP_CURRENCY 	= #$02
DROP_MUSIC		= #$03

OBJ_NPC = #$41
					
OBJ_MonsterStartValue = $10 
						;; front load positive objects, back load negative objects
						;; so to start, starting at object 5 will be monsters
						;; however, when we do more updating for npcs and powerups
						;; this number will change
		;;movement types
MOV_SPAWN	= $00
MOV_IDLE 	= $01
MOV_WALK	= $02
MOV_JUMP	= $06
MOV_SPIN	= $04
MOV_STAB	= $05
MOV_CAST	= $06




;sfx

;sfx
SFX_MELEE = $00
SFX_MELEE_STRIKE = $01
SFX_JUMP = $02
SFX_STOMP = $03
SFX_CRYSTAL = $04
SFX_DOOR_OPEN = $05
SFX_DOOR_SLAM = $06
SFX_BOSS_REVEAL = $07
SFX_ENTER_MENU = $08
SFX_EXIT_MENU = $09
SFX_ENTER_NPC = $0A
SFX_EXIT_NPC = $0B
SFX_FALL = $0C
SFX_FOOTSTEPS = $0D
SFX_GAME_START = $0E
SFX_GET_ITEM = $0F
SFX_LAND = $10
SFX_CAST = $11
SFX_DONE_CHARGING = $12
SFX_MAGIC_HIT = $13
SFX_CHANGE_ITEM = $14
SFX_MISS = $15
SFX_MONSTER_DEATH = $16
SFX_PLAYER_DEATH = $17
SFX_PLAYER_HURT = $18
SFX_BOUNCE = $19
SFX_SECRET = $1A
SFX_SPLASH = $1B
SFX_STAIRS = $1C
SFX_SWITCH = $1D
SFX_TEXT = $1E
SFX_UNLOCK = $1F
SFX_UNCHARGE = $20
SFX_VICTORY = $21
SFX_ITEM_SELECT = $22
SFX_NOPE = $23
SFX_USE_MENU_ITEM = $24
SFX_CON_UP_DEAD = $25
SFX_CON_UP_LIVE = $26
SFX_CON_SHIFT_UP_DEAD = $27
SFX_CON_SHIFT_UP_LIVE = $28
SFX_CON_DOWN_DEAD = $29
SFX_CON_DOWN_LIVE = $2A
SFX_CON_SHIFT_DOWN_DEAD = $2b
SFX_CON_SHIFT_DOWN_LIVE = $2c
SFX_CON_LEFT_DEAD = $2d
SFX_CON_LEFT_LIVE = $2e
SFX_CON_SHIFT_LEFT_DEAD = $2f
SFX_CON_SHIFT_LEFT_LIVE = $30
SFX_CON_RIGHT_DEAD = $31
SFX_CON_RIGHT_LIVE = $32
SFX_CON_SHIFT_RIGHT_DEAD = $33
SFX_CON_SHIFT_RIGHT_LIVE = $34
SFX_CON_B_DEAD = $35
SFX_CON_B_LIVE = $36
SFX_CON_SHIFT_B_DEAD = $37
SFX_CON_SHIFT_B_LIVE = $38
SFX_CON_A_DEAD = $39
SFX_CON_A_LIVE = $3A
SFX_CON_SHIFT_A_DEAD = $3b
SFX_CON_SHIFT_A_LIVE = $3c
SFX_STATUS_CHANGE_POS = $3d


		; 'directions'
DOWN		= $00
DOWNRIGHT	= $01
RIGHT		= $02
UPRIGHT		= $03
UP			= $04
UPLEFT		= $05
LEFT		= $06
DOWNLEFT	= $07

		; - Game states
GS_StartScreen 	= $00
GS_MainGame		= $01
GS_Win			= $02



;GS_Hud			= $09 ;; not used really

;GS_Story		= $09


		; sub states
GAME_Normal 	= $00
GAME_Spawning	= $01
GAME_Dying		= $02
GAME_Victory	= $03
GAME_Fading		= $04
GAME_Song		= $05
GAME_NPC		= $06
GAME_Trapped	= $07
GAME_Untrapped	= $08
GAME_changingState = $09
GAME_unChangingState = $0A
GAME_Winning = $0B
GAME_Launching = $0C
GAME_ChangingMagicTile = $0D
GAME_CheckingSongbarriers = $0E
GAME_ChangingTiles = $0F
GAME_Saving	= $10
GAME_Loading = $11

		;fade types
FADE_OutAndIn 	=#%10100000
FADE_OutAndStop	=#%10000000

	;;tile types
TILE_Normal		= #$00 		;; 0000
TILE_Solid		= #$01 ;; any part touching, affects 0001
TILE_Jump		= #$02 ;; any part touching, affects 0010
TILE_Hole		= #$03 ;; all has to be touching  0011
TILE_Ice		= #$04 ;; any part touching, effects  0100
TILE_Hurt		= #$05 ;; all has to be touching   0101
TILE_Swamp		= #$06 ;; all has to be touching  0110
TILE_Warp		= #$07 ;; all has to be touching  0111
TILE_HurtIfNotJump = #$08						; 1000
TILE_StompSecret = #$09		;; all has to be touching 1001	
TILE_StompTrigger	= #$0A 	;;;;;;;;;; 1010			
TILE_MagicTrigger	= #$0B	;;;;;;;;;;;1011			
			;		= #$0C  ;;;;;;;;;;;1100
		;			= #$0d ;;;;;;;;;;;;1101
TILE_NPC			= #$0e ;;;;;;;;;;;;1110
TILE_WarpUp		= #$0F 		;;;;;;;;;;;1111		
TILE_StompBreak = #$10				
TILE_Slashable	= #$11
TILE_HealingPond		= #$16
TILE_WarpOut    = #$17 ;; hex 23
TILE_DoorOpenDay = #$28
TILE_SolidToWarp = #$20
TILE_GravityBlock = #$23
TILE_PlatformBlock1 = #$24
TILE_BottomBlock = #$25


	;; ground types?
GROUND_Hole		= #%10000000
GROUND_JumpOver	= #%01000000
GROUND_WarpUp	= #%00100000
GROUND_StompSecret = #%00010000
GROUND_Ice			= #%00001000
GROUND_Swamp		= #%00000100
GROUND_StompTrigger = #%00000010
GROUND_MagicTrigger = #%00000001
GROUND_StompBreak = #%00000011 ;; will this work?
GROUND_GravityBlock = #%00000111
	;;hit boundary actions
ACTION_NULL					= #$00
ACTION_STOP					= #$01
ACTION_DESTROY_ME			= #$02
ACTION_DESTROY_OTHER 		= #$03
ACTION_REVERSE_DIRECTION 	= #$04
ACTION_UNSPAWN				= #$05
ACTION_OPPOSITE_DIRECTION	= #$06
ACTION_JUMP					= #$07
ACTION_TURN					= #$08


SPAWN_RANDOM_XY 			= #$00
SPAWN_RANDOM_EDGES 			= #$01
SPAWN_POISITION				= #$02



;TOTAL_MAX_OBJECTS = #$0a ; arbitrary.  Should be able to hold up to 20 objects



COL_EMPTY = #%00000000
COL_SOLID = #%10000000



FADE_DARKEN = #%00000000
FADE_LIGHTEN = #%01000000

FADE_AND_HOLD = #%00000000
FADE_AND_RETURN = #%01000000
FADE_LOOP = #%00100000
FADE_ONCE = #%00000000

BLANK_TILE = #$F5


;;;====UPDATE NT MASKS
UPDATE_NT_ACTIVE = #%10000000
UPDATE_NT_TILE_BUFFERING = #%01000000
UPDATE_NT_ATT_BUFFERING	= #%00100000
UPDATE_NT_FINAL 	= #%00010000
UPDATE_NT_FINAL_RESET = #%11101111
UPDATE_NT_WRITE		= #%00001000
UPDATE_NT_WRITE_DONE = #%11110111
UPDATE_NT_LOADNT = #%00000001

UPDATE_NT_START_BLANK = #%11000000
UPDATE_NT_START_ATT = #%11000100
UPDATE_NT_START_NT	= #%11000011

DRAW_HUD_1			= #%00000001
DRAW_HUD_2			= #%00000010
DRAW_HUD_3			= #%00000100
DRAW_HUD_4			= #%00001000
DRAW_HUD_5			= #%00010000
DRAW_HUD_6			= #%00100000
DRAW_HUD_7			= #%01000000
DRAW_HUD_8			= #%10000000

UNDRAW_HUD_1			= #%11111110
UNDRAW_HUD_2			= #%11111101
UNDRAW_HUD_3			= #%11111011
UNDRAW_HUD_4			= #%11110111
UNDRAW_HUD_5			= #%11101111
UNDRAW_HUD_6			= #%11011111
UNDRAW_HUD_7			= #%10111111
UNDRAW_HUD_8			= #%01111111

;;;================================================
;; object constants
;;;;===============================================
MAX_OBJECTS		= #$01

;================================
;misc
;==============================
BANK_STARTSCREEN_CHR = #$1D
BANK_WINSCREEN_CHR = #$1D
BANK_PLAYER_CHR = #$1D
BANK_ANIMATIONS = #$1C


;;==================
;Object Masks
;======================
OBJECT_ACTIVATE = #%01000000
OBJECT_DEACTIVATE = #%00100000
OBJECT_IS_ACTIVE = #%10000000
OBJECT_RESERVE = #%00001000

.include "GameData\HUD_BOX_CONSTANTS.dat"

;;//////////////////////////////
;OBJECT TIMERS
HURT_TIMER = #$08
INVINCIBILITY_TIMER = #$10
RECOIL_SPEED_HI = #$02
RECOIL_SPEED_LO = #$00

HURT_STATUS_MASK = #%00000011
;; seperate player / monster hurt timers?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;===============================
;;BUILD THESE PROCEDURALLY.  THERE WILL BE A LOT!
;================================
TESTER_ONE = #$05

;; BELOW WORKS!!!!!!

HudVarImage_0 EQU Var_hud_image0
HudVarImage_1 EQU Var_hud_image1

TEST_CON_Z0 EQU HudVarImage_
TEST_CON_Z1 EQU "0"



;;====================================
DIR_DOWN = #%00000000
DIR_DOWNRIGHT = #%00000001
DIR_RIGHT = #%00000010
DIR_UPRIGHT = #%00000011
DIR_UP = #%00000100
DIR_UPLEFT = #%00000101
DIR_LEFT = #%00000110
DIR_DOWNLEFT = #%00000111

;;=======================================
	FACE_DOWN      = #%00000000
	FACE_DOWN_RIGHT = #%00000001
	FACE_RIGHT		= #%00000010
	FACE_UP_RIGHT	= #%00000011
	FACE_UP		= #%00000100
	FACE_UP_LEFT	= #%00000101
	FACE_LEFT		= #%00000110
	FACE_DOWN_LEFT	= #%00000111




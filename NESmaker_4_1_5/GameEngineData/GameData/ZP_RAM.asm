;; *************** ZP_RAM.asm ***************
;; Zero Page export. Saturday, April 25, 2020 6:47:15 PM

sound_region .dsb 1
sound_disable_update .dsb 1
sound_local_byte_0 .dsb 1
sound_local_byte_1 .dsb 1
sound_local_byte_2 .dsb 1
sound_local_word_0 .dsb 2
sound_local_word_1 .dsb 2
sound_local_word_2 .dsb 2
sound_param_byte_0 .dsb 1
sound_param_byte_1 .dsb 1
sound_param_byte_2 .dsb 1
sound_param_word_0 .dsb 2
sound_param_word_1 .dsb 2
sound_param_word_2 .dsb 2
sound_param_word_3 .dsb 2
base_address_instruments .dsb 2
base_address_note_table_lo .dsb 2
base_address_note_table_hi .dsb 2
apu_data_ready .dsb 1
apu_square_1_old .dsb 1
apu_square_2_old .dsb 1
song_list_address .dsb 2
sfx_list_address .dsb 2
song_address .dsb 2
apu_register_sets .dsb 20
loopTemp .dsb 1
temp .dsb 1
temp1 .dsb 1
temp2 .dsb 1
temp3 .dsb 1
tempx .dsb 1
tempy .dsb 1
tempz .dsb 1
temp16 .dsb 2
collisionPointer .dsb 2
updateNT_ntPointer .dsb 2
updateNT_pos .dsb 2
selfLeft .dsb 1
selfRight .dsb 1
selfTop .dsb 1
selfBottom .dsb 1
selfNT_L .dsb 1
selfNT_R .dsb 1
otherLeft .dsb 1
otherRight .dsb 1
otherTop .dsb 1
otherBottom .dsb 1
otherNT_L .dsb 1
otherNT_R .dsb 1
selfCenterX .dsb 1
selfCenterY .dsb 1
otherCenterX .dsb 1
otherCenterY .dsb 1
xHold_lo .dsb 1
xHold_hi .dsb 1
yHold_lo .dsb 1
yHold_hi .dsb 1
collisionPoint0 .dsb 1
collisionPoint1 .dsb 1
collisionPoint2 .dsb 1
collisionPoint3 .dsb 1
collisionPoint4 .dsb 1
collisionPoint5 .dsb 1
tileX .dsb 1
tileY .dsb 1
tile_solidity .dsb 1
gamepad .dsb 1
buttonStates .dsb 1
vBlankTimer .dsb 1
screenTimer .dsb 1
screenTimerMicro .dsb 1
player1_object .dsb 1
;;;player2_object .dsb 1
;;;prevScreen .dsb 1
;;;ScreenLoadBits .dsb 1
ScreenByte00 .dsb 1
ScreenByte01 .dsb 1
ScreenFlags .dsb 1
;;;currentAttributeTablePointer .dsb 2
bckPal .dsb 16
;;;bckPalFade .dsb 16
spriteSubPal_0 .dsb 4
spriteSubPal_1 .dsb 4
spriteSubPal_2 .dsb 4
spriteSubPal_3 .dsb 4
spritePalFade .dsb 16
;;;bckPalGroup .dsb 2
;;;spriteSubPalGroup_0 .dsb 2
;;;spriteSubPalGroup_1 .dsb 2
;;;spriteSubPalGroup_2 .dsb 2
;;;spriteSubPalGroup_3 .dsb 2
newPal .dsb 1
newGO1Pal .dsb 1
newGO2Pal .dsb 1
newObj1Pal .dsb 1
newObj2Pal .dsb 1
;;;TargetBank .dsb 1
;;;ReturnBank .dsb 1
;;;TargetAddress .dsb 1
;;;TargetAddress_h .dsb 1
;;;SourceAddress .dsb 1
;;;SourceAddress_h .dsb 1
;;;soft2000 .dsb 1
soft2001 .dsb 1
sleeping .dsb 1
randomSeed1 .dsb 1
randomSeed2 .dsb 1
;;;fadeByte .dsb 1
;;;fadeSpeed .dsb 1
;;;fadeTimer .dsb 1
;;;fadeLevel .dsb 1
;;;fadeSelect_bck .dsb 2
currentBank .dsb 1
prevBank .dsb 1
screenBank .dsb 1
screenType .dsb 1
graphicsBank .dsb 1
objGraphicsBank .dsb 1
;;;prevScreenBank .dsb 1
tempBank .dsb 1
chrRamBank .dsb 1
gameState .dsb 1
gameSubState .dsb 1
newGameState .dsb 1
newX .dsb 1
newY .dsb 1
spriteOffset .dsb 1
spriteDrawLeft .dsb 1
spriteDrawTop .dsb 1
sprite_drawVoffset .dsb 1
sprite_drawHoffset .dsb 1
sprite_pointer .dsb 2
sprite_tileOffset .dsb 1
tileset_offset .dsb 1
drawOrder .dsb 10
;;;SongToPlay .dsb 1
updateNT_pointer .dsb 2
updateHUD_POINTER .dsb 2
npc_collision .dsb 1
textboxHandler .dsb 1
;;;CT_left .dsb 1
;;;CT_right .dsb 1
camPad_L_lo .dsb 1
camPad_L_hi .dsb 1
camPad_R_lo .dsb 1
camPad_R_hi .dsb 1
update_screen_data_flag .dsb 1
textVar .dsb 1
edge_trap_flag .dsb 1
scrollRoomDataFlag .dsb 1
seam_trigger_flag .dsb 1
testFlagThing .dsb 1
tempTileUpdate_lo .dsb 1
tempTileUpdate_hi .dsb 1
tempChangeTiles .dsb 4
screenPrizeCounter .dsb 1
tileCollisionFlag .dsb 1
playerToSpawn .dsb 1
navFlag .dsb 1
navToScreen .dsb 1
loadObjectFlag .dsb 1
activateWarpFlag .dsb 1
mapPosX .dsb 1
mapPosY .dsb 1
doNMI .dsb 1

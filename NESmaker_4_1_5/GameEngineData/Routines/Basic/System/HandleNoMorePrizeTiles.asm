


;;; we can make this activate a warp to the warp out screen.
LDA warpMap
sta currentMap
clc
ADC #$01
STA temp
GoToScreen warpToScreen, temp, #$02


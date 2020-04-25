
   LDA screenFlags
    AND #%00100000
    BEQ + ;; game does not use gravity
    ;; game uses gravity, but perhaps want to check
    ;; if on ladder or something that would cause
    ;; down to have a desired effect.
    
    RTS
 +:
    LDX player1_object
    ;;; check the gae state.
    ;;; we currently have 6 game substates:
        ;; 0 = map
        ;; 1 = pacman like
        ;; 2 = platformer
        ;; 3 = snowmobiling
        ;; 4 = baloon fight like
        ;; 5 = donkey kong like
        ;;; on the map screen, pressing the arrows does not change state.
     LDA gameSubState
    BNE ++  ;; dont change sub state
    JMP ++++
   RTS
++
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;; this is for "pacman type" came
    GetCurrentActionType player1_object
    CMP #$01
    BEQ +
    ChangeObjectState #$01, #$04
    JMP +
    ;; END pacman type game
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+++
    CMP #$02
    BEQ ++
    JMP +++
++
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;; this is for platform game.
    GetCurrentActionType player1_object
    ;  CMP #$02 ;; attack
    ;  BEQ ++
    CMP #$01
    BEQ +
    LDA Object_physics_byte,x
    AND #%00000001 ;; is it on the ground?
    BEQ +
    GetCurrentActionType player1_object
    CMP #$03 ;; is it shooting?
    BEQ +
    ChangeObjectState #$01, #$04
    JMP +
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;; END PLATFORM TYPE GAME
+++
++++
+
    StartMoving player1_object, MOVE_UP
    LDA gameSubState
    CMP #$04 ;; shooter can only face right
    BEQ +
 FaceDirection player1_object, FACE_UP
 +
    RTS
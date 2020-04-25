;;; this will check for engaging ladder physics.
    LDX player1_object
     GetCurrentActionType player1_object
     CMP #$04
     BEQ skipChangeToLadderState ;; already is doing ladder animation.

    ChangeObjectState #$04, #$04 ;; change object state to climbing
skipChangeToLadderState:
    RTS
    
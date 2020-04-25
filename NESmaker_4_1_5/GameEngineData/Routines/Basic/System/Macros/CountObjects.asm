MACRO CountObjects arg0, arg1
	;; arg0: What object flags should we be looking for?
			;; the number of monsters?  the number of monsters + monster projectiles?  The number of NPCs?
			;; the number of triggers?  Pickups?  ALL object types?  
			;; by default, these are set up to be:
			;; #%00000000
			;;         |+--persistent
			;;         +---player
			;;        +----player weapon
			;;       +-----monster 
			;;      +------monster wewapon
			;;     +-------pickup
			;;    +--------target
			;;   +---------NPCs
			;;
			;; So, for instance, to count all monsters + targets, arg0 would be #%01001000
			
	;; arg1 is a bit more nebulous in fucnction.  I like to think of it as "end behavior"
			;; if there is a count returned, A is loaded with zero.
			;; The idea is that after this macro, if A=0, don't do anything.
			;; If it is not zero, A gets loaded with whatever is in arg1.
			;; Then, a user could set up a conditional after this count object macro.
			;; If it is one, do this.  If it is two, do that.  Etc, etc, etc.
			;; This way, a user could even have multiple things happen after object counts
			;; by using the same macro.  If there are no more monsters here, the door opens.
			;; If ther are no more targets there, the item appears.  Etc etc etc.
			;; But all this will be determined by what comes AFTER the macro in code.
			
	;; THIS SCRIPT WILL CORRUPT THE ACCUMULATOR
	LDA arg0
	STA arg0Temp
	LDA arg1
	STA arg1Temp
	
	
	
	LDA #$00
	STA monsterCounter 
	TXA
	PHA ;; push x to the stack
	
	LDX #$00
doCountObjectsLoop:
	LDA update_screen
	BEQ justCheckActiveStatus
	;; check active or spawning.
	LDA Object_status,x
	AND #%11000000 ;; is it active
	BEQ doNotCountThisObject
	JMP doCountThisObject
justCheckActiveStatus:
	LDA Object_status,x
	AND #%10000000 ;; is it active
	BEQ doNotCountThisObject
	JMP doCountThisObject
	;; this object is active.
doCountThisObject:
	LDA Object_flags,x
	AND arg0Temp ;; does it match one of the object types we're looking for?
	BEQ doNotCountThisObject
	;; count this object
	INC monsterCounter
doNotCountThisObject:
	INX
	CPX #TOTAL_MAX_OBJECTS
	BNE doCountObjectsLoop

	PLA ;; restore x.
	TAX
;;; now, all monsters have been checked and counted, and x is restored.
;;; if all we were doing was needing the count of this type, 
;;; it is available in the monsterCounter variable.
;;;	If our goal was to do something if there are zero more monsters,
;;; we will need to check to see if the number is zero, and if it is, put arg1 in the accumulator.
	
	LDA monsterCounter
	BNE +
	;;; there are no more objects of the type on screen.
	LDA arg1Temp ;;; 
	JMP ++
+
	LDA #$00
++

;;;;;;;;;;; SO RETURNING FROM THIS MACRO:
;;; 1) monsterCounter has the number of objects that arg0 determined should be counted.
;;; 2) X has been restored.
;;; 3) The accumulator is corrupted, and it now holds the value in arg1, to be used on whatever comes next.
	ENDM
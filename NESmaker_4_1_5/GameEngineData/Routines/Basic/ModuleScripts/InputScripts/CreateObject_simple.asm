;; Before we even start the attack or object creation, we MAY want to check the weaponsUnlocked
;; variable.  If we always want the player to have the weapon, we do not have to do this part of it.
;; If we want to give the player a weapon or object to create, we can only create it if that particular
;; weapon bit is unlocked.  

;; With this system, we could have 8 unlockable weapons, each represented by a bit.  If the bit is 1,
;; that means we proceed to the rest of the routine.  But if it is zero, we do not.

;; We could create NPCs to "give us weapons" (which flip the bit) by using the end of text action - Gives Item.
;; The first 8 correspond to unlockable weapons.  So if he gives you weapon 0, the first bit of weaponsUnlocked
;; will flip to 1.  If he gives you weapon 7, the last bit of weaponsUnlocked will flip to 1.  

;; You could also make a script that unlocks a weapon.  Maybe this is triggered when you touch a weapon or enter
;; a room or something.  It would ora in the bit that you want to flip.

;; If you don't want object creation to be conditional on this variable, simply comment out these lines.

;;PART 1: Weapon conditional
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;===================================
;; UNCOMMENT IF YOU WANT TO CHECK FOR UNLOCKED STATUS 
;	LDA weaponsUnlocked
;	AND #%00000001
;	BEQ + ;; if bit zero is not flipped, exit this creation routine.
;;;=====================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Here, you may want to check to see if the playter is already in the state of
;; creating the object.  For instance, if this is to create a melee weapon, you wouldn't
;; want the player to create another melee if he's already attacking.  For that, we can
;; check the current state of the player object. 

;; PART 2: Action State conditional
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;===========================================
;; UNCOMMENT IF YOU WANT TO CHECK AGAINST A PARTICULAR STATUS
;	GetCurrentActionType player1_object ;; 
;   CMP #$02 ;; what action stat is your player's attack state?  Change this number accordingly.
;   BEQ + ;; if it is equal to that number, it can not create another object.
;;;===========================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
;; Next, we have to determine if there should be anything that happens to the parent object
;; that is spawning this new object.  For instance, in The Legend of Zelda, Link stops moving
;; when he attacks.  In most games, the player changes to an attack state (if you use Part 2
;; conditional, you should absolutely set the player object to the state represented there).

;; PART 3: Effects to the parent object (usually the player)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;=====================================================
;; UNCOMMENT IF YOU WANT THE PLAYER TO STOP MOVING UPON ATTACK.
; LDX player1_object  ;; Now x is loaded with the player
; LDA #$00
; STA Object_h_speed_hi,x
; STA Object_h_speed_lo,x
; STA Object_v_speed_hi,x
; STA Object_v_speed_lo,x

;; UNCOMMENT IF YOU WANT TO CHANGE THE PLAYER'S STATE
; ChangeObjectState #$02, #$08 ;; the first argument is the state to change to.
								;; chances are you want to change it to the "attack" state
								;; listed above.
								
;; Put any other thing you want to have happen to the creator object here.

;;===============================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Next, we want to determine where this object gets created, and what object we will be creating.
;; We will put the x value we want to create the object at into temp, and the y value into temp1.
;; We will put the type of object we want to create into temp2. 

;; We could use arbitrary numbers.  For instance, putting #$80 into both temp and temp1 would
;; create the object in the middle of the screen, while putting Object_x_hi,x would put the
;; x value at the x position of the player (or current x-loaded object).  We could also use an offset,
;; for instance load the player's x value, add 5 to it, and store that into temp.

;; It is also possible here to make more conditionals, possibly based on the direction a player is facing,
;; so that if he is facing right, it is created to the right of the player, while if he is facing to the left,
;; it is created to the left.  One simple way that we can do this is to use weaponOffsetTableX and weaponOffsetTableY,
;; offset by the direction we are facing.  You can adjust the weaponOffsetTables by clicking on "GameObjects" in the tool.

;; To determine the TYPE of object created, you could create a variable that cycles 0-7 (it would be up to you to 
;; determine how to change this value).  Then, you could create a variable object based on that value.


;; PART 4: Placement and details for the new object.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;============================================
;;CHOICE 1 - UNCOMMENT IF YOU WANT TO PLACE OBJECT AT THE PLAYER'S POSITION
; LDA Object_x_hi,x
; STA temp
; LDA Object_y_hi,x
; STA temp1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Choice 2 - UNCOMMENT IF YOU WANT TO PLACE AN OBJECT AT AN ARBITRARY POSITION
; LDA #$80 ;; wherever you want it on the screen in the x value
; STA temp
; LDA #$80 ;; wherever you want it ont he screen in the y value
; STA temp1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Choice 3 - UNCOMMENT IF YOU WANT TO USE THE OFFSET TABLE
; LDA Object_movement,x
; AND #%00000111 ;; this is now the "facing direction"
; TAY ;; now it is loaded in y.
; LDA weaponOffsetTableX,y
; STA temp
; LDA weaponOffsetTableY,y
; STA temp1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Here, choose the type of object to create.
;; Game Objects are 0-#$0F, #$10-xx are monster objects.

	LDA #$01 ;; what object you want to load.
	STA temp2
	
	
;; If there is anything we want to store from the player, such as his direction
;; so that we can give the newly created weapon the same direction, we can do that here.

	
	
;;==================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Now, let's actually create the object.  You can use the fourth argument to 
;; determine what action state the projectile has when it is created. 

;; PART 5: Create the object.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==============================================

     CreateObject temp, temp1, temp2, #$00, currentNametable
	 
;;===============================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Lastly, if there is anything that you want to happen with the newly created object,
;; such as giving it a speed or a direction, this is where you can do that.
;; CreateObject puts the newly created object in X, so anything to you do to an object
;; loaded into X right now affects the newly created object.



+ ;; done with creating object.
	RTS
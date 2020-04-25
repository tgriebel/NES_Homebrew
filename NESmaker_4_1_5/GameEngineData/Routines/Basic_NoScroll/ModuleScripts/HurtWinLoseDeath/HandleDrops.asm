	RTS ;; skip drops
;;; monster objects drop at random.
	LDA Object_x_hi,x
	STA temp
	LDA Object_y_hi,x
	STA temp1

	JSR GetRandomNumber
	AND #%00000111 ;; now, we have a number between 0 and 7
	BNE notPickup0 ;; 
	;; zero case here;
	;;; here, we'll create health
	CreateObject temp, temp1, #$04, #$00, currentNametable
	JMP donePickup
notPickup0:
	CMP #$01
	BNE notPickup1
	;; one case here;
;;; here, we'll create currency
	CreateObject temp, temp1, #$07, #$00, currentNametable
	JMP donePickup
notPickup1:
	CMP #$02
	BNE notPickup2
	;; two case here;
	;;; here, we'll create currency
	CreateObject temp, temp1, #$07, #$00, currentNametable
	JMP donePickup
notPickup2:
	;;;; do the same for each case.
	;;;; blank cases will simply return 'nothing'.
	
	
	
	
donePickup:	
	;;; ALL cases create a "pow"
	CreateObject temp, temp1, #$09, #$00, currentNametable

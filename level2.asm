include all.inc
																						;  ERROR WITH LINE 506
.model large
;.MODEL FLAT, STDCALL 
.stack 1024h
.data
;PROT32 ; Enable 32-bit addressing mode
    
	;........MENUE PORTION................

textrow db 0 
textcol db 0

	design1 db "|------------------------------------------------|$"
	design2 db " ------------------------------------------------ $"
	
	
	str1 db "|           WELCOME TO AIR XONIX GAME!           |$"
	str20 db "             PLEASE ENTER YOUR NAME:              $"
	str2 db "|    PLEASE CHOOSE FROM THE FOLLOWING OPTIONS    |$"
	str3 db "|                    NEW GAME                    |$"
	str4 db "|                     OPTION                     |$"
	str5 db "|                   HIGH SCORE                   |$"
	str6 db "|                   INFORMATION                  |$"	
	str7 db "|                      EXIT                      |$"
	
	
	str8 db "1. Use left 'a', right 'd', up 'w', and down 's' key(s) to move the spaceship around $"
	str9 db "2. Cut off parts of the playing field by moving the spaceship around the grid and drawing lines $"  
	str10 db "3. Fill as many blocks as you can $"
	
	str30 db "1. Use left arraw '<' to move the spaceship left $"
	str31 db "1. Use rght arraw '>' to move the spaceship right $"
	str32 db "1. Use UP arraw '^' to move the spaceship UP $"
	str33 db "1. Use DOWN arraw '-' to move the spaceship DOWN $"
	str34 db "|                   OPTIONS                      |$"
	
	
	str11 db "              PRESS SPACE TO CONTINUE             $"
	
	;str12 db "|                   INFORMATION                  |$"	
	;str13 db "|                      EXIT                      |$"
	
	
	options db 0		; to get user input on what he wants to do
	username db 15 dup (" ")
		
    nameL dw 0
	strP db  "|               GAME IS PAUSED                   |$"
	
    str12 db "|            THANK YOU FOR PLAYING!              |$"
    
	str13 db "|             PRESS ESCAPE TO EXIT               |$"
	str14 db "|             PRESS ENTER TO RESTART             |$"
	str15 db "|            PRESS SPACE TO CONTINUE             |$"


	strC db  "|               CONGRATULATIONS                  |$"
	
    str27 db "|              LEVEL 1 COMPLETE                  |$"
    
	str28 db "|             PRESS ESCAPE TO EXIT               |$"
	str29 db "|             PRESS ENTER TO Proceed             |$"
	
    
    strS db "Score $"
	strPer db "percent $"

	bin2 db  "kingsv.wav",0			; we will have to change this later -> to save/read data from 
	
	
	filename db 'SCORE_USER.txt', 0
	buffer2 db 100 dup('$') 
	error_msg db 'Error occurred', 0




    temp dw ?


    shipX dw ?
	shipY dw ?
    shipC db ?

    black db 0
    red db 4
    blue db 3

    shipColor db ?

    fireX dw ?
    fireY dw ?
    fireLen dw ?
    fireWid dw ?

	
	
	leftBarX1 dw ?
    leftBarY1 dw ?
    leftBarX2 dw ?
    leftBarY2 dw ?
	

	
	UpBarX1 dw ?
	UpBarY1 dw ?
	UpBarX2 dw ?
	UpBarY2 dw ?
	
	
	rightBarX1 dw ?
    rightBarY1 dw ?
    rightBarX2 dw ?
    rightBarY2 dw ?
	
	
	DownBarX1 dw ?
	DownBarY1 dw ?
	DownBarX2 dw ?
	DownBarY2 dw ?
	
	
	
	cout dw ?
	tempX dw ?
	tempY dw ?
	
	;secrotarX1 dw ?
	;secrotarY1 dw ?
	;secrotarX2 dw ?
	;secrotarY2 dw ?




    finished db "Game Over",0

    strCount byte ?
    colno byte ?
    nameColor byte ?

    alien1Killed dw ?

    win db "You Win, On to Level 2",0

    level1 db "LEVEL 1",0
	level2 db "LEVEL 2",0

    frame_Y_counter dw ?
    frame_X_counter dw ?
	

	
	left_line_x dw ?
	up_line_y dw ?
	right_line_x dw ?
	down_line_y dw ?
	
	for_behind_wall_1 dw ?
	for_behind_wall_2 dw ?
	
	last_key db ?
	
	
	player_life dw 3
	life_x dw 0
    life_y dw 10
	red_dot db 4
	

	ball_1x dw 200
	ball_1y dw 200
	ball_2x dw 100
	ball_2y dw 100
	ball_3x dw 150
	ball_3y dw 150
	ball_direction dw 1
	ball_direction1 dw 4
	ball_direction2 dw 3
	player_death dw 0
	ball_1 dw 1
	ball_2 dw 2
	black_dot db 0
	
	color db ?
	prev_x dw 0
	prev_y dw 0
	
	total_x dw 600 
	total_y dw 460 
	total_pixels dw 0
	total_pixels_ dw 12000
	findcolor db 3
	percent dw 0
	percent_counter dw 0
	highscore dw 220
	
	block_x dw 110
	block_y dw 150
	
	block_2x dw 440
	block_2y dw 150
	
	block_3x dw 150
	block_3y dw 250
	
	block_4x dw 490
	block_4y dw 250
	
	
	number dw 56
    buffer dw 5 dup ('$')  ; buffer to hold the digits
	buffer1 dw 5 dup ('$')  ; buffer to hold the digits
    digit db ?             ; variable to hold each digit
    count db 0             ; counter for the number of digits
	

	

.code

	;...............MENUEPROC.............................
	TextPrint proc 
	T:
		mov  dl,textCol   	;Column
		sub dl,cl
		mov  dh, textRow  	;Row
		mov  bh, 0    		;Display page
		mov  ah, 02h  		;SetCursorPosition
		int  10h
		  
		mov  bh, 0    	;Display page
		mov  bl, 1011b  	;Color is blue
		mov  al, [si]
		mov  ah, 0Eh  
		int  10h
		inc si
	loop T
	ret
	TextPrint endp

main proc

    mov ax, @data
    mov ds, ax
;....................MENUE1....................

I1:

restart0:

;set video mode
mov ah,00h
mov al,10h
int 10h


	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,5

call TextPrint
;...........................................

	mov si,offset str1
	mov cx,lengthof str1
	sub cx,1
	mov textcol,65
	mov textrow,6

call TextPrint
;...........................................

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,7

call TextPrint
;...........................................

      mov si,offset str20
      mov cx,lengthof str20
      sub cx,1
      mov textcol,55
      mov textrow,11

call TextPrint
;...........................................

;...........NAME INPUT......................
mov dx,0 ;.........counter

mov si,offset username
loop1:
mov ah,01
int 21h
mov [si],al
inc si
inc dx
cmp al,13
JNE loop1
mov nameL,dx


menu:

;set video mode
mov ah,00h
mov al,10h
int 10h



; --------- MENU PAGE design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,7

call TextPrint
;...........................................

      mov si,offset str2
      mov cx,lengthof str2
      sub cx,1
      mov textcol,65
      mov textrow,8
	  

call TextPrint
;...........................................

	mov si,offset design1
	mov cx,lengthof design1
	sub cx,1
	mov textcol,65
	mov textrow,9

call TextPrint
;...........................................

      mov si,offset str3
      mov cx,lengthof str3
      sub cx,1
      mov textcol,65
      mov textrow,10
	  

call TextPrint
;...........................................

      mov si,offset str4
      mov cx,lengthof str4
      sub cx,1
      mov textcol,65
      mov textrow,11
	  

call TextPrint
;...........................................

      mov si,offset str5
      mov cx,lengthof str5
      sub cx,1
      mov textcol,65
      mov textrow,12
	  

call TextPrint
;...........................................

      mov si,offset str6
      mov cx,lengthof str6
      sub cx,1
      mov textcol,65
      mov textrow,13
	  

call TextPrint
;...........................................

      mov si,offset str7
      mov cx,lengthof str7
      sub cx,1
      mov textcol,65
      mov textrow,14
	  

call TextPrint
;...........................................

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,15

call TextPrint
;...........................................

;----------- 1st page design ends ----------


mov dx,13		; skip a line before input
mov ah,02
int 21H

mov dx,10
mov ah,02
int 21H


;...........OPTION INPUT......................

mov ah,0
int 16h


cmp al,'1'	
	je start2

cmp al,'2'	
	je opt

cmp al,'3'	
	je high_score

cmp al,'4'	
	je I2

cmp al,'5'
	je exit


jmp new_game2

opt:
	clear
	jmp I3
	clear
	jmp menu
;jmp restart0



high_score:
	clear

	setVideoMode

		printGraphicString str5, 6, 15, 1, 8

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    			
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; user name
	
		printGraphicString username, 8, 33, 1, 8
		
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer
			
			;mov ax,highscore 
			mov ax,highscore
				
			;stores value in buffer
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; hightscore
		
		printGraphicString strS, 10, 30, 1, 8
	
		printGraphicString buffer, 10, 38, 1, 8
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer1
			
			mov ax,percent
				
			;stores value in buffer
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; percentage
	
		printGraphicString strPer, 12, 30, 1, 8
		
		printGraphicString buffer1, 12, 38, 1, 8
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		
	
		
		
		
	call delay
	call delay
	call delay 
	call delay
		
	clear
	jmp menu
;jmp restart0

;jmp restart0




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                                                            ; level 2
																			
;............level2.....................

;.................................

new_game2:
start2:

	mov percent ,0
	mov player_life,3
	mov player_death,0
	mov highscore,220




    setVideoMode
	

    gameBoundary
	
	printGraphicString level2, 15, 35, 1, 2
	
    call delay

    clear

    setVideoMode

    gameBoundary

	printGraphicString username, 0, 35, 1, 8
   
	mov shipX, 400
	mov shipY, 400
	
	;       blocks 
	draw_block block_x,block_y,3
	draw_block block_2x,block_2y,3
	draw_block block_3x,block_3y,3
	draw_block block_4x,block_4y,3
	
	
	
	;       main_player
	
    main_player_triangle shipX,shipY, 8
		
	; enemies
	main_player_box ball_1x,ball_1y, 4
	main_player_box ball_2x,ball_2y, 4
	
	;main_player_box_2 block_2x,block_2y, 3                                                ;   THIS IS THE PROBLEM IF I Comment it out the the game works fine 
																						; BUT IF I RUN WITH IT IT SHOWS ERROR
	
	;draw_bricks b1.life,b1.x1,b1.y1,b1.x2,b1.y2 ;life,x1,y1,x2,y2
	
	.if(player_life>0)

        add life_x,40
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,40
    
    .endif

    .if(player_life>1)

        add life_x,50
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,50
    
    .endif

    .if(player_life>2)

        add life_x,60
        draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
        sub life_x,60
    
    .endif

	

	
	mov ax,0
    .while ah != 1      ;; until escape is entered
	
		resume2:
		
		.if(percent >= 90)
			clear
			jmp winpage
		.endif
		.if(player_death == 3)
			jmp losepage
			;jmp exit
		.endif
	
	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer
			
			;mov ax,highscore 
			mov ax,highscore
				
			;stores value in buffer
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; hightscore
		
		printGraphicString strS, 0, 50, 1, 4
	
		printGraphicString buffer, 0, 56, 1, 4
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer1
			
			
			;mov ax, highscore   ; move the high score to the EAX register
			;mov bx, total_pixels_   ; move the total pixels to the EBX register

			;xor dx, dx   ; clear the high 32 bits of EDX register
			;div bx     ; divide high score by total pixels, quotient will be in AX register

			;mov bx, 100   ; move 100 to BX register
			;mul bx     ; multiply the quotient by 100, result will be in AX register

			;push ax
			.if(percent_counter == 13)
				inc percent
				mov percent_counter,0
			.endif
			
			mov ax,percent
				
			;stores value in buffer
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; percentage
	
		printGraphicString strPer, 0, 64, 1, 4
		
		printGraphicString buffer1, 0, 72, 1, 4
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
		
	
		.if(player_life>0)

			add life_x,40
			draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
			sub life_x,40
		
		.endif

		.if(player_life>1)

			add life_x,50
			draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
			sub life_x,50
		
		.endif

		.if(player_life>2)

			add life_x,60
			draw_life life_x,life_y,red_dot ;Players Life icons to be shown here
			sub life_x,60
		
		.endif

		.if(player_death==3)

			add life_x,40
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,40
			jmp exit
		
		.endif

		.if(player_death==2)

			add life_x,50
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,50
		
		.endif

		.if(player_death==1)

			add life_x,60
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,60
		
		.endif
	
	
			; enemies
		main_player_box ball_1x,ball_1y, 4
		main_player_box ball_2x,ball_2y, 4
		
		mov bx,1000
		
        .while(bx>0)
        
            nop                 ;For Delay in movement of ball
            dec bx
        
        .endw
		;main_player_box ball_1x,ball_1y, 0
		ball_movement ball_1x,ball_1y,ball_direction,player_life,player_death,ball_1

        pop ball_direction
		;pop restarting
		
		;pop prev_x
		;pop prev_y
		
		;.if (restarting == -1)
			;main_player_box prev_x,prev_y,0
		;.endif
		
		
		mov bx,ball_direction
		
		

        cmp bx,1
        je dir1_

        cmp bx,2
        je dir2_

        cmp bx,3
        je dir3_

        cmp bx,4
        je dir4_


		dir1_:

			main_player_box ball_1x,ball_1y, 0
			add ball_1x,4
			sub ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_
		
		dir2_:

			main_player_box ball_1x,ball_1y, 0
			sub ball_1x,4
			sub ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_

		dir3_:
				
			main_player_box ball_1x,ball_1y, 0
			sub ball_1x,4
			add ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_

		dir4_:

			main_player_box ball_1x,ball_1y, 0
			add ball_1x,4
			add ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_
		
		
		keychecks_:
		
		ball_movement ball_2x,ball_2y,ball_direction1,player_life,player_death,ball_2

        pop ball_direction1
		;pop restarting1
		
		;pop prev_x
		;pop prev_y
		
		;.if (restarting1 == -1)
			;main_player_box prev_x,prev_y,0
		;.endif
		
		mov bx,ball_direction1

        cmp bx,1
        je dir11_

        cmp bx,2
        je dir12_

        cmp bx,3
        je dir13_

        cmp bx,4
        je dir14_


		dir11_:

			main_player_box ball_2x,ball_2y, 0
			add ball_2x,5
			sub ball_2y,5
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_
		
		dir12_:

			main_player_box ball_2x,ball_2y, 0
			sub ball_2x,5
			sub ball_2y,5
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		dir13_:
				
			main_player_box ball_2x,ball_2y, 0
			sub ball_2x,5
			add ball_2y,5
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		dir14_:

			main_player_box ball_2x,ball_2y, 0
			add ball_2x,5
			add ball_2y,5
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		keychecks1_:
		
		mov ah,1
		int 16h

		jz resume2

		
		


        mov ah, 00h         ;; get keyboard input
        int 16h
		
		

        .IF ah == 1             ;; escape key
			clear
            jmp exit

        .ENDIF

		.IF (ah == 57)   ;; space key pressed
        
            jmp game_pause2
				
        .ENDIF


        .IF (ah == 4DH)       ;; right key pressed
            
                main_player_triangle shipX,shipY, blue
                ;ship shipX, black
				add shipX, 10
				
				inc percent_counter
				add highscore,10
				
            .IF (rightBarX2 >= 610)
                ;mov shipX, 30                     ; for passing through walls
				sub shipX, 10                      ; for stoping at walls 
            .endif

        .ELSEIF (ah == 4BH)   ;; left key pressed
        
                main_player_triangle shipX,shipY, blue
                ;ship shipX, black
				sub shipX, 10
				
				add highscore,10
				inc percent_counter
            
            .IF (leftBarX1 <= 40 )
			
				;mov shipX, 600                  ; for passing through walls
				add shipX,10
            .endif
			
		.ELSEIF (ah == 48H)   ;; up key pressed
        
                main_player_triangle shipX,shipY, blue
                ;ship shipX, black
				sub shipY, 10
            
				add highscore,10
				inc percent_counter
			
            .IF (UpBarY1 <= 60 )
				;mov shipY, 420
				add shipY,10
            .endif
			
		.ELSEIF (ah == 50H)   ;; down key pressed
        
                main_player_triangle shipX,shipY, blue
                ;ship shipX, black
				add shipY, 10
				
				add highscore,10
				inc percent_counter
			
            .IF (DownBarY2 >= 450 )
                ;mov shipY, 60
				sub shipY,10
            .endif

		.endif


        draw2:
        ;ship shipX, red
		main_player_triangle shipX,shipY, 8
		
		jmp resume2
		
		game_pause2:

        mov ah,1
        int 16h

        jz game_pause2

        mov ah,00h
        int 16h

        cmp al,' '
        je resume2

        jmp game_pause2

    .endw

jmp exit	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;..........................................

;.............INFORMATION PAGE.............

I2:

	mov ah,00h
	mov al,10h
	int 10h


	mov si,offset str6
	mov cx,lengthof str6
	sub cx,1
	mov textcol,65
	mov textrow,5

	call TextPrint

;................INSTRUCTION 1............................

	mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 8   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR

	mov si, offset str8
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print string
	
	;call TextPrint

;................INSTRUCTION 2............................

	mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 11   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR
	
    mov si, offset str9
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print string

    ;call TextPrint

;................INSTRUCTION 3............................


    mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 14   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR

    mov si, offset str10
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print stringt
	
;................INSTRUCTION 4........................

	;mov ah,00h
	;mov al,10h
	;int 10h


	mov si,offset str11
	mov cx,lengthof str11
	sub cx,1
	mov textcol,65
	mov textrow,18

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;              ENTER CONTINUE
	
	.while ah != 1      ;; until escape is entered
		
		mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit

        .ENDIF
		
		.IF (ah == 57)             ;; space key
        
            clear
            jmp menu

        .ENDIF
	
	.endw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


I3:

;................INSTRUCTION 0........................


	mov si,offset str34
	mov cx,lengthof str34
	sub cx,1
	mov textcol,65
	mov textrow,10

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;................INSTRUCTION 1........................


	mov si,offset str30
	mov cx,lengthof str30
	sub cx,1
	mov textcol,65
	mov textrow,12

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;................INSTRUCTION 2........................


	mov si,offset str31
	mov cx,lengthof str31
	sub cx,1
	mov textcol,65
	mov textrow,14

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;................INSTRUCTION 3........................


	mov si,offset str32
	mov cx,lengthof str32
	sub cx,1
	mov textcol,65
	mov textrow,16

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;................INSTRUCTION 4........................


	mov si,offset str33
	mov cx,lengthof str33
	sub cx,1
	mov textcol,65
	mov textrow,18

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay

clear
jmp menu





    delay proc
        pushAll

        mov cx,1000
        mydelay:
            mov bx,750      ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
            mydelay1:
            dec bx
            jnz mydelay1
        loop mydelay

        popall

    ret
    delay endp

winpage:
	
    ; --------- 1st page design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,4

	call TextPrint
	;..........................................

		mov si,offset strC
		mov cx,lengthof strC
		sub cx,1
		mov textcol,65
		mov textrow,5

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,6

	call TextPrint
	
	;...........................................

		mov si,offset design1
		mov cx,lengthof design1
		sub cx,1
		mov textcol,65
		mov textrow,9

	call TextPrint
	;...........................................

		  mov si,offset str27
		  mov cx,lengthof str13
		  sub cx,1
		  mov textcol,65
		  mov textrow,10
		  

	call TextPrint
	;...........................................

		  mov si,offset str28
		  mov cx,lengthof str28
		  sub cx,1
		  mov textcol,65
		  mov textrow,11
		  

	call TextPrint
	;...........................................

		  mov si,offset str29
		  mov cx,lengthof str29
		  sub cx,1
		  mov textcol,65
		  mov textrow,12
		  

	call TextPrint
	
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,13

	call TextPrint 
	;...........................................

	; ---------- exit page design ends ----------


	mov dx,13		; skip a line before input
	mov ah,02
	int 21H

	mov dx,10
	mov ah,02
	int 21H


		;...........OPTION INPUT......................
	mov ax,0
	.while ah != 1      ;; until escape is entered
		
		mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit1

        .ENDIF
		
		.IF (ah == 1Ch)             ;; enter key
        
            clear
            jmp new_game2

        .ENDIF
		
	
	.endw

losepage:

	;setVideoMode
	

    ;gameBoundary

    printGraphicString finished, 15, 35, 1, 2
	
	printGraphicString strS, 17, 34, 1, 2
	
	printGraphicString buffer, 17, 40, 1, 2

    call delay
	call delay
	call delay
	call delay
	call delay

    clear
	
	;jmp menu
	jmp menu
    
exit:
	; printing the menu
	
	;clear
	
	; --------- 1st page design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,4

	call TextPrint
	;..........................................

		mov si,offset strP
		mov cx,lengthof strP
		sub cx,1
		mov textcol,65
		mov textrow,5

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,6

	call TextPrint
	;...........................................

		mov si,offset str12
		mov cx,lengthof str12
		sub cx,1
		mov textcol,65
		mov textrow,8

	call TextPrint
	;...........................................

		  mov si,offset design2
		  mov cx,lengthof design2
		  sub cx,1
		  mov textcol,65
		  mov textrow,9
		  

	call TextPrint
	;...........................................

		  mov si,offset str2
		  mov cx,lengthof str2
		  sub cx,1
		  mov textcol,65
		  mov textrow,10
		  

	call TextPrint
	;...........................................

		mov si,offset design1
		mov cx,lengthof design1
		sub cx,1
		mov textcol,65
		mov textrow,11

	call TextPrint
	;...........................................

		  mov si,offset str13
		  mov cx,lengthof str13
		  sub cx,1
		  mov textcol,65
		  mov textrow,12
		  

	call TextPrint
	;...........................................

		  mov si,offset str14
		  mov cx,lengthof str14
		  sub cx,1
		  mov textcol,65
		  mov textrow,13
		  

	call TextPrint
	;...........................................

		  mov si,offset str15
		  mov cx,lengthof str15
		  sub cx,1
		  mov textcol,65
		  mov textrow,14
		  

	call TextPrint
	
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,15

	call TextPrint 
	;...........................................

	; ---------- exit page design ends ----------


	mov dx,13		; skip a line before input
	mov ah,02
	int 21H

	mov dx,10
	mov ah,02
	int 21H


		;...........OPTION INPUT......................
	mov ax,0

	.while ah != 1      ;; until escape is entered
		
		mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit1

        .ENDIF
		
		.IF (ah == 1Ch)             ;; enter key
        
            clear
            jmp new_game2

        .ENDIF
		
		
		.IF (ah == 57)             ;; space key
        
            clear
            jmp menu

        .ENDIF
		
	
	.endw




exit1:
mov ah,4ch
int 21h
    
main endp

PRINT PROC          
     
    ;initialize count
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0
        je print1     
         
        ;initialize bx to 10
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack
        push dx             
         
        ;increment the count
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit2
         
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
		mov [si],dx
        inc si
         
        ;decrease the count
        dec cx
        jmp print1
exit2:
ret
PRINT ENDP

percentage proc 

	mov bx,total_x
	mov dx,total_y
	mov cx,0
	.while(bx != 0)
			
		.while(dx != 0)
			
			; read color at current position
			mov ah, 0Dh
			mov cx, total_x                 ; hit down wall
			mov dx, total_y
			add dx,17
			int 10H ; AL = COLOR
			
			.if (al == findcolor)
				
				add cx,1
				
			.endif
			
			add total_pixels,1
	
		.endw
	
	
	.endw
	
	mov ax,cx
	
	; Calculate the percentage of blue pixels
    mov bx, 100 ; Multiply by 100 to get percentage
    mul bx ; AX = blue_count * 100
    
	mov cx,total_pixels
	div cx ; AX = blue_count * 100 / total_pixels
    mov percent, ax
	
	push percent
ret
percentage endp


end main
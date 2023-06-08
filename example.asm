.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
;extrn rand : near
extern printf: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "2048 GAME",0
area_width EQU 640
area_height EQU 480
area DD 0
rand_seed DD 0

positionX DD 0
positionY DD 0

moved DD 0

posY DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
posX DD 24, 24, 24,24
	 DD 133,133,133,133
	 DD 242,242,242,242
	 DD 351,351,351,351


	
;arr_pos_blocks DD 24,133, 242, 351 ; varianta simplificata , daca vreau elem de pe linia 2, vec[2][x] asa iau valorile

arr_blocks_value DD 2,0,0,0; stocare valoarea  care se afla in casute 
				 DD	0,0,0,0
				 DD	0,2,0,0
				 DD	0,0,0,0

				 
counter DD 0 ; numara evenimentele de tip timer

cols EQU 4
rows EQU 4

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

;vec_pos DD 
; pos start e 25
symbol_width EQU 10
symbol_height EQU 20
include digits.inc
include letters.inc

.code


create_table macro
local loop_add_blocks,print0,print2,print4,print8,print16,print32,print64,print128,print256,print512,print1024,print2048,to_end_loop
	
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
	
	add_line_vertical_4px 20,20,  440,0h
	add_line_vertical_4px 20,129,440,0h
	add_line_vertical_4px 20,238, 440,0h
	add_line_vertical_4px 20,347, 440,0h
	add_line_vertical_4px 20,456,440,0h

	add_line_horizontal_4px 20, 20,440,0h
	add_line_horizontal_4px 129,20, 440,0h
	add_line_horizontal_4px 238, 20,440,0h
	add_line_horizontal_4px 347, 20,440,0h
	add_line_horizontal_4px 456, 20,440,0h
	
	
	
	mov ecx,15
loop_add_blocks:
	mov edx , [arr_blocks_value+ecx*4]
	
	
	cmp edx,0
	je print0
	
	cmp edx,2
	je print2
	
	cmp edx,4
	je print4
	
	cmp edx,8
	je print8
	
	cmp edx,16
	je print16
	
	cmp edx,32
	je print32
	
	cmp edx,64
	je print64
	
	cmp edx,128
	je print128
	
	cmp edx,256
	je print256
	
	cmp edx,512
	je print512
	
	cmp edx,1024
	je print1024
	
	cmp edx,2048
	je print2048
	
	
		print0:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0cdc1b4h
			
			pop edx
			pop ecx
			pop eax
		
			  jmp to_end_loop
		print2:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0eee4dah
			
			pop edx
			pop ecx
			pop eax
			
			add eax,45
			add edx,45
			make_text_macro '2', area, edx,eax
			
			
		 jmp to_end_loop
	  	
		print4:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0eee1c9h
			
			pop edx
			pop ecx
			pop eax
			
			add eax,45
			add edx,45
			make_text_macro '4', area, edx,eax
			
			
		jmp to_end_loop
		
		 print8:		
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f3b27ah
			
			pop edx
			pop ecx
			pop eax
			
			add eax,45
			add edx,45
			make_text_macro '8', area, edx,eax
		 jmp to_end_loop
		
		print16:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f69664h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			
			add edx,40
			make_text_macro '1', area, edx,eax
			;add eax,15
			add edx,10
			
			make_text_macro '6', area, edx,eax
		jmp to_end_loop
		
		
		print32:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f77c5fh
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			
			add edx,40
			make_text_macro '3', area, edx,eax
			;add eax,15
			add edx,10
			
			make_text_macro '2', area, edx,eax
		jmp to_end_loop
		
		
		print64:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f75f3bh
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			
			add edx,40
			make_text_macro '6', area, edx,eax
			;add eax,15
			add edx,10
			
			make_text_macro '4', area, edx,eax
		jmp to_end_loop
		
		
		
		print128:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0edd073h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			add edx,40
			make_text_macro '1', area, edx,eax
			
			add edx,10
			make_text_macro '2', area, edx,eax
			add edx,10
			make_text_macro '8', area, edx,eax
		jmp to_end_loop
		
		
		print256:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0edcc62h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			add edx,40
			make_text_macro '2', area, edx,eax
			
			add edx,10
			make_text_macro '5', area, edx,eax
			add edx,10
			make_text_macro '6', area, edx,eax
		jmp to_end_loop
		
		
		
		print512:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f69664h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			add edx,40
			make_text_macro '5', area, edx,eax
			
			add edx,10
			make_text_macro '1', area, edx,eax
			add edx,10
			make_text_macro '2', area, edx,eax
		jmp to_end_loop
		
		
		print1024:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f69664h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			add edx,30
			make_text_macro '1', area, edx,eax
			
			add edx,10
			make_text_macro '0', area, edx,eax
			add edx,10
			make_text_macro '2', area, edx,eax
			add edx,10
			make_text_macro '4', area, edx,eax
		jmp to_end_loop
		
		
		print2048:
			mov eax,[posX+4*ecx]
			mov edx,[posY+4*ecx]
			mov [positionX] , eax
			mov [positionY], edx
			
			
			push eax
			push ecx
			push edx
			
			add_square positionX,positionY,105,105,0f69664h
			
			pop edx
			pop ecx
			pop eax
			
			
			add eax,45
			add edx,30
			make_text_macro '2', area, edx,eax
			
			add edx,10
			make_text_macro '0', area, edx,eax
			add edx,10
			make_text_macro '4', area, edx,eax
			add edx,10
			make_text_macro '8', area, edx,eax
		jmp to_end_loop
		 
		 
		to_end_loop:
	 sub ecx,1
	  cmp ecx,0
		jnl loop_add_blocks
	
	
	checkIfLose

endm



add_square macro up, left, lenght, height,color
local bucla_linie,bucla_coloana
	mov eax, up
	mov ecx, height
bucla_coloana:
	push eax
	mov ebx, area_width
	mul ebx
	add eax, left
	shl eax,2
	add eax,area
	
	push ecx
	mov ecx, lenght
		bucla_linie:
			mov dword ptr[eax],color
			add eax,4
	
			loop bucla_linie
	
	pop ecx
	pop eax
	inc eax

loop bucla_coloana
 endm

generate_element macro
local check_if_exists, place_number,substract_4_loop,add_block,check_for_free_positions,give_0_edx
	mov eax,0
check_if_exists:
	push eax
	random_num_generator 15
	pop eax
	inc eax
	cmp eax, 20
	jg give_0_edx
	cmp [arr_blocks_value+edx*4],0
	je place_number
	jne check_if_exists
	give_0_edx:
		mov edx,0
	check_for_free_positions:
		
		
		cmp [arr_blocks_value+edx*4],0
		je place_number
		add edx,4
		cmp edx,60
		jng check_for_free_positions
place_number:
	
	mov ecx, edx ; pozitie in arr_blocks_value
	random_num_generator 1
	inc edx
	shl edx,1
	mov [arr_blocks_value + ecx*4], edx
endm
	
	
random_num_generator macro max; ret  in EDX nr random
    rdtsc
    mov rand_seed, eax
    rdtsc
    xor eax, rand_seed
    mov ebx, max
    xor edx, edx
    div ebx
    
endm

add_line_horizontal_4px macro up, left, lenght,color
local bucla_linie
	mov eax, up
	mov ebx, area_width
	mul ebx
	add eax, left
	shl eax,2
	add eax,area
	mov ecx, lenght
bucla_linie:
	mov dword ptr[eax],color
	mov dword ptr[eax+4*area_width],color
	mov dword ptr[eax+8*area_width],color
	mov dword ptr[eax+12*area_width],color
	add eax,4
	loop bucla_linie
endm





add_line_vertical_4px macro up, left, height,color
local bucla_linie_vertical

	mov eax,up;
	mov ebx, area_width
	mul ebx;
	add eax,left;
	shl eax,2
	add eax,area
	mov ecx,height
bucla_linie_vertical:
	mov dword ptr[eax] , color
	mov dword ptr[eax+4] , color
	mov dword ptr[eax+8] , color
	mov dword ptr[eax+12] , color
	
	add eax,area_width*4
	loop bucla_linie_vertical

endm


make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	;mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm


just_move_down macro
local column_loop,line_loop,equal_0_up,notequal_0_up,to_end
	mov ecx, 0
	column_loop:
			mov eax,48
			mov edx,0
			line_loop:
				cmp [arr_blocks_value+eax+ecx],0
				je equal_0_up
				jmp notequal_0_up
				
				notequal_0_up:
					cmp eax,48
					je to_end
					cmp edx,0
					je to_end
					
					push eax
					push ecx
					add eax,ecx
					mov ecx,[arr_blocks_value+eax]
					
					mov [arr_blocks_value+eax+edx],ecx
					
					mov [arr_blocks_value+eax],0
					pop ecx
					pop eax
					mov [moved],1 ;;;;;;;;;; pt verificare daca se fac mutari
					jmp to_end
				equal_0_up:
					add edx,16
					jmp to_end
	
	
				to_end:
				sub eax,16
				cmp eax, 0
				jnl line_loop 
			
	add ecx,4
	cmp ecx,12
	jng column_loop
endm


just_move_up macro
local column_loop,line_loop,equal_0_up,notequal_0_up,to_end
	mov ecx, 0
	column_loop:
			mov eax,0
			mov edx,0
			line_loop:
				cmp [arr_blocks_value+eax+ecx],0
				je equal_0_up
				jmp notequal_0_up
				
				notequal_0_up:
					cmp edx,0
					je to_end
					
					push eax
					push ecx
					add eax,ecx
					mov ecx,[arr_blocks_value+eax]
					sub eax,edx
					mov [arr_blocks_value+eax],ecx
					add eax,edx
					mov[arr_blocks_value+eax],0
					pop ecx
					pop eax
					mov [moved],1 ;;;;;;;;;; pt verificare daca se fac mutari
					jmp to_end
				equal_0_up:
					add edx,16
					jmp to_end
	
	
				to_end:
				add eax,16
				cmp eax, 48
				jle line_loop 
			
	add ecx,4
	cmp ecx,12
	jng column_loop
endm
just_move_right macro
local elements_loop,line_loop,notequal_0,equal_0,to_end
	mov ecx, 48
	line_loop:
		mov edx, 0
		mov eax, 16
		elements_loop:	
		    sub eax,4
			push ecx
			add ecx, eax
			push eax
			cmp [arr_blocks_value+ecx],0
			je equal_0
			jmp notequal_0
			
			notequal_0:
				cmp edx,0
				je to_end
				
				mov eax,[arr_blocks_value+ecx]
				mov [arr_blocks_value+ecx+ edx] , eax
				mov dword ptr [arr_blocks_value+ecx],0
				mov [moved],1 ;;;;;;;;;; pt verificare daca se fac mutari
				jmp to_end
			equal_0 :
				add edx,4
				jmp to_end
			to_end:
				pop eax
				pop ecx
				cmp eax,0
				jne  elements_loop
	sub ecx,16
	cmp ecx,0	
	jnl line_loop
	
	
	endm
	
just_move_left macro
local elements_loop,line_loop,notequal_0,equal_0,to_end
	mov ecx, 48
	line_loop:
		mov edx, 0
		mov eax, 0
		elements_loop:	
		    
			push ecx
			add ecx, eax
			push eax
			cmp [arr_blocks_value+ecx],0
			je equal_0
			jmp notequal_0
			
			notequal_0:
				cmp edx,0
				je to_end
				
				mov eax,[arr_blocks_value+ecx]
				push ecx
				sub ecx,edx
				mov [arr_blocks_value+ecx] , eax
				pop ecx
				mov dword ptr [arr_blocks_value+ecx],0
				mov [moved],1 ;;;;;;;;;; pt verificare daca se fac mutari
				jmp to_end
			equal_0 :
				add edx,4
				jmp to_end
			to_end:
				pop eax
				pop ecx
				add eax,4
				cmp eax,16
				jne  elements_loop
	sub ecx,16
	cmp ecx,0	
	jnl line_loop
	
	
endm

checkIfLose macro; 1 in ecx daca mai sunt mutari sau pozitii libere , iar 0 in caz contrar
local bucla_linie,bucla_coloana,to_exit_equal,check_under,to_next_element,exit,not_last_line
	mov ecx, 48
	bucla_linie:
		mov eax, 0
		;shl ecx,3
		bucla_coloana:
			cmp [arr_blocks_value+ecx+eax],0
			je to_exit_equal
			
			cmp ecx,48
			jne check_under
			jmp not_last_line
			
			check_under:
			cmp ecx, 48
			jge not_last_line
			mov edx, [arr_blocks_value+ecx+eax]
			cmp [arr_blocks_value+ecx+eax+16],edx
			je to_exit_equal
		
			not_last_line:
			cmp eax, 12
			je to_next_element
			
			mov edx, [arr_blocks_value+ecx+eax]
			cmp [arr_blocks_value+ecx+eax+4],edx
			je to_exit_equal
			
			
			
						
				to_next_element:
		add eax,4
		cmp eax,12
		jle bucla_coloana
					
					
	sub ecx,16
	;shr ecx,3
	cmp ecx, 0
    jge bucla_linie
	
	mov ecx, 0
	add_square 170,170,140,140,0FFh
	make_text_macro 'Y', area, 200, 230
	make_text_macro 'O', area, 210, 230
	make_text_macro 'U', area, 220, 230
	;make_text_macro 'S', area, 130, 100
	make_text_macro 'L', area, 240, 230
	make_text_macro 'O', area, 250, 230
	make_text_macro 'S', area, 260, 230
	make_text_macro 'T', area, 270, 230
	jmp exit
	;;;;;;;;;;;;; daca e lose sa faca orice
	to_exit_equal:
		mov edx , 1
		
		
	exit:
	
endm 

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click, 3 - s-a apasat o tasta)
; arg2 - x (in cazul apasarii unei taste, x contine codul ascii al tastei care a fost apasata)
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	create_table
	
	mov eax, [ebp+arg1]
	cmp eax, 3
	je evt_key
	cmp eax, 1
	je evt_click
	cmp eax, 2
	jz evt_timer 
	jg evt_key
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	jmp afisare_litere

	
evt_key:

	mov eax,[ebp+arg2]
	cmp eax,'W'
	je upMove
	
	mov eax, [ebp+arg2]
	cmp eax, 'A'
	je leftMove
	
	mov eax,[ebp+arg2]
	cmp eax,'S'
	je downMove
	
	mov eax,[ebp+arg2]
	cmp eax,'D'
	je rightMove
upMove:
	mov [moved],0
	just_move_up
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ecx, 0
	column_loop4:
			mov eax,0
			
			line_loop4:
				mov edx,[arr_blocks_value+eax+ecx]
				cmp [arr_blocks_value+eax+ecx+16],edx
				je equal_up
				jmp to_end4
				
				equal_up:
					
					
					; mov ecx,[arr_blocks_value+eax]deja in edx
					shl edx,1
					; sub eax,edx
					mov [arr_blocks_value+eax+ecx],edx
					add [counter],edx
					; add eax,edx
					mov[arr_blocks_value+eax+ecx+16],0
					
					; add eax,16
					jmp to_end4
	
				to_end4:
				add eax,16
				cmp eax, 32
				jle line_loop4 
			
	add ecx,4
	cmp ecx,12
	jng column_loop4
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	just_move_up
	cmp [moved],1
	je gen_elem_up
	jmp exit_up
	gen_elem_up:
		generate_element
	
	exit_up:
	;checkIfLose
	
	create_table
	
	jmp afisare_litere

	
leftMove:
	mov [moved],0
	just_move_left 
	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MERGE TILES
	mov ecx, 48
	line_loop3:
	
		mov eax, 0
		elements_loop3:	

			mov edx , [arr_blocks_value+ecx+eax+4]
			cmp [arr_blocks_value+ecx+eax],edx
			je equal_left
			jmp to_end3
			
			equal_left :
				shl edx,1
				mov [arr_blocks_value+ecx+eax] , edx
				add [counter],edx
				mov dword ptr [arr_blocks_value+ecx+eax+4],0
				jmp to_end3
			to_end3:
				add eax,4
				cmp eax,12
				jne  elements_loop3
	sub ecx,16
	cmp ecx,0	
	jnl line_loop3
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	just_move_left
	
	cmp [moved],1
	je gen_elem_left
	jmp exit_left
	
	gen_elem_left:
	generate_element
	
	exit_left:

	create_table
	;checkIfLose
	jmp evt_click
	
	
downMove:
	mov [moved],0
	just_move_down
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ecx, 0
	column_loop5:
			mov eax,48
			
			line_loop5:
				mov edx,[arr_blocks_value+eax+ecx]
				cmp [arr_blocks_value+eax+ecx-16],edx
				je equal_up5
				jmp to_end5
				
				equal_up5:
					shl edx,1
					mov [arr_blocks_value+eax+ecx],edx	
					add [counter],edx					
					sub eax,16
					mov[arr_blocks_value+eax+ecx],0
					
					jmp to_end5
	
				to_end5:
				sub eax,16
				cmp eax, 16
				jnl line_loop5 
			
	add ecx,4
	cmp ecx,12
	jng column_loop5
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	just_move_down
	
	cmp [moved],1
	je gen_elem_down
	jmp exit_down
	
	gen_elem_down:
	generate_element
	
	exit_down:
		;checkIfLose
	create_table
	
	jmp evt_click

rightMove: ; first moves all tiles, then merges 2 identical, then moves all tiles
	mov [moved],0
	just_move_right
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MERGE TILES
	mov ecx, 48
	line_loop2:
	
		mov eax, 16
		elements_loop2:	
		    sub eax,4

			cmp eax, 0
			je to_end2
			mov edx , [arr_blocks_value+ecx+eax-4]
			cmp [arr_blocks_value+ecx+eax],edx
			je equal_right
			jmp to_end2
			
			equal_right :
				mov edx,[arr_blocks_value+ecx+eax]
				shl edx,1
				mov [arr_blocks_value+ecx+eax] , edx
				mov dword ptr [arr_blocks_value+ecx+eax-4],0
				add [counter],edx
				sub eax,4
				jmp to_end2
			to_end2:
				
				cmp eax,0
				jne  elements_loop2
	sub ecx,16
	cmp ecx,0	
	jnl line_loop2
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	just_move_right
	cmp [moved],1
	je gen_elem_right
	jmp exit_right
	
	gen_elem_right:
	generate_element
	
	exit_right:

	create_table
	;	checkIfLose

	jmp afisare_litere
evt_click:
	
	jmp afisare_litere
	
evt_timer:
	;inc counter
	
afisare_litere:
	;create_table
	; afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 560, 50
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 550, 50
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 540, 50
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 530,50
	
	
	
	 make_text_macro 'S', area, 530, 30
	 make_text_macro 'C', area, 540, 30
	 make_text_macro 'O', area, 550, 30
	 make_text_macro 'R', area, 560, 30
	 make_text_macro 'E', area, 570, 30
	
	;scriem un mesaj
	; make_text_macro 'P', area, 110, 100
	; make_text_macro 'R', area, 120, 100
	; make_text_macro 'O', area, 130, 100
	; make_text_macro 'I', area, 140, 100
	; make_text_macro 'E', area, 150, 100
	; make_text_macro 'C', area, 160, 100
	; make_text_macro 'T', area, 170, 100
	
	; make_text_macro 'L', area, 130, 120
	; make_text_macro 'A', area, 140, 120
	
	; make_text_macro 'A', area, 100, 140
	; make_text_macro 'S', area, 110, 140
	; make_text_macro 'A', area, 120, 140
	; make_text_macro 'M', area, 130, 140
	; make_text_macro 'B', area, 140, 140
	; make_text_macro 'L', area, 150, 140
	; make_text_macro 'A', area, 160, 140
	; make_text_macro 'R', area, 170, 140
	; make_text_macro 'E', area, 180, 140

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start

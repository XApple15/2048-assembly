.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extrn rand : near


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

posX DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
	 DD 24, 133, 242, 351
posY DD 24, 24, 24,24
	 DD 133,133,133,133
	 DD 242,242,242,242
	 DD 351,351,351,351


	
arr_pos_blocks DD 24,133, 242, 351 ; varianta simplificata , daca vreau elem de pe linia 2, vec[2][x] asa iau valorile

arr_blocks_value DD 0,0,0,0; stocare puterea lui 2 care se afla in casute 
				 DD	0,0,0,0
				 DD	0,0,0,0
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
	
	add_square 24,24,105,105,08F807Eh; 1st row
	add_square 24,133,105,105,08F807Eh
	add_square 24,242,105,105,08F807Eh
	add_square 24,351,105,105,08F807Eh
	
	add_square 133,24,105,105,08F807Eh;2nd row
	add_square 133,133,105,105,08F807Eh
	add_square 133,242,105,105,08F807Eh
	add_square 133,351,105,105,08F807Eh
	
	add_square 242,24,105,105,08F807Eh;3rd row
	add_square 242,133,105,105,08F807Eh
	add_square 242,242,105,105,08F807Eh
	add_square 242,351,105,105,08F807Eh
	
	add_square 351,24,105,105,08F807Eh;4th row
	add_square 351,133,105,105,08F807Eh
	add_square 351,242,105,105,08F807Eh
	add_square 351,351,105,105,08F807Eh
	
	;random_num_generator 3
	
endm

generate_element macro
local check_if_exists, place_number,substract_4_loop,add_block
check_if_exists:
	random_num_generator 15
	cmp [arr_blocks_value+edx],0
	je place_number
	jne check_if_exists
place_number:
	mov ecx, edx ; pozitie in arr_blocks_value
	random_num_generator 1
	inc edx
	shl edx,1
	mov [arr_blocks_value + ecx], edx
	
	
	;mov eax,  ecx; auxiliar
	; mov edx, 0;indice pt linie
	; substract_4_loop:; cod pt gasirea pozitiei in matrice
		; cmp ecx, 4
		; jng  add_block
		; sub ecx,4
		; inc edx
		; jmp substract_4_loop
	
		; add_block:
			; mov eax , [arr_pos_blocks+edx]
			; mov ebx, [arr_pos_blocks + ecx]
			; add_square eax,ebx,105,105, 0FF0000h;; color the position
						
endm
	
	
random_num_generator macro max; ret  in EDX nr random
    rdtsc
    mov rand_seed, eax
    rdtsc
    xor eax, rand_seed
    mov ebx, max
    xor edx, edx
    div ebx
    ;add edx, 1  ;; add 1 to the result to get a value between 1 and max
  
		
	; mov ebx, 10
	; mov eax, edx
	;cifra unitatilor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 100, 10
	;cifra zecilor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 90, 10
	;cifra sutelor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 80, 10
	
endm



add_square macro up, left, lenght, height,color
local bucla_linie,bucla_coloana
	;mov edx, up ; pt incrementare
	mov eax, up
	;push eax
	mov ecx, height
bucla_coloana:
	;pop eax
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
	;inc edx
	
loop bucla_coloana


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
	mov dword ptr [edi], 0FFFFFFh
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





; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
; draw proc
	; push ebp
	; mov ebp, esp
	; pusha
	; create_table
	; mov eax, [ebp+arg1]
	; cmp eax, 1
	; jz evt_click
	; cmp eax, 2
	; jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	; mov eax, area_width
	; mov ebx, area_height
	; mul ebx
	; shl eax, 2
	; push eax
	; push 0FAF8EFh
	; push area
	; call memset
	; add esp, 12
	; jmp afisare_litere
	
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
	generate_element
	jmp afisare_litere
leftMove:
downMove:
rightMove:
	
evt_click:
	; mov edi, area
	; mov ecx, area_height
	; mov ebx, [ebp+arg3]
	; and ebx, 7
	; inc ebx
; bucla_linii:
	; mov eax, [ebp+arg2]
	; and eax, 0FFh
	;;provide a new (random) color
	; mul eax
	; mul eax
	; add eax, ecx
	; push ecx
	; mov ecx, area_width
; bucla_coloane:
	; mov [edi], eax
	; add edi, 4
	; add eax, ebx
	; loop bucla_coloane
	; pop ecx
	; loop bucla_linii
	jmp afisare_litere
	
evt_timer:
	inc counter
	
afisare_litere:
	;create_table
	; ; afisam valoarea counter-ului curent (sute, zeci si unitati)
	; mov ebx, 10
	; mov eax, counter
	;cifra unitatilor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 30, 10
	;cifra zecilor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 20, 10
	;cifra sutelor
	; mov edx, 0
	; div ebx
	; add edx, '0'
	; make_text_macro edx, area, 10, 10
	
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

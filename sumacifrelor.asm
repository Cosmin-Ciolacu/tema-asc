org 100h
 
mov bx , 10     ;impartitorul 10 constant   
mov cx, 0       ;initializam cx - counter la 0
mov ax, nr      ;mutam numarul in registerul ax 

desc:
xor dx, dx      ;curatam registerul dx la 0
add cx, 1       ; incrementam cx cu 1
div bx          ; impartim nr la 10, restul inpartirii este pus in registerul dx
push dx         ; salvam dx (cifrele in ordine inversa pe stack)
cmp ax, 0       ; comparam nr ramas cu 0
jne desc        ; daca este 0 continuam executia, altfel ramanem in bucla desc(ompunere in numere)
xor ax, ax      ; resetam registerul ax      
mov dx, offset ms1 ; mutam in resgisterul dx pointer spre adresa de inceput a string-ului ms1
push ax         ; salvam ax pe stack
mov ah, 9       ; punem valoare 9 in registerul ah care indica fuctia de afisare string in urm. instructiune
int 21h         ; accesam DOS API https://en.wikipedia.org/wiki/DOS_API  (int este un software interrupt sau api call)
pop ax          ; readucem pointerul ax de pe stack

suma:           ; bucla suma va rula de cx ori
pop dx          ; returnam valorile cifrelor numarului nostru de pe stack
add bh, dl      ; facem suma in registerul bh pentru a pastra registerul ax pentru afisarea pe ecran       
mov al, dl      ; salvam cifra curenta pentru afisare pe ecran in registerul al
add al, 30h     ; convertim in decimal ca si caracter ascii
mov ah, 0eh     ; setam pointerul ah la 0x0e ce indica spre functia Teletype output (afisare caractere pe ecran)
int 10h         ; acesta este un BIOS interrupt call sau api call
loop suma       ; executam bucla pana cand cx = 0
mov s, bh       ; mutam suma in variabila s pentru siguranta   

mov bx, 10
xor cx, cx      ; resetam cx si ax
xor ax, ax
mov al , s      ; mutam suma in registerul al pentru descompunere in factori

descs:          ; descompunem suma in factori (este descris mai sus pas cu pas si e 3 jumate noaptea si imi este somn :)))   )
xor dx, dx
add cx, 1
div bx
push dx
cmp ax, 0
jne descs 

push ax         ; afisam ms2 pe ecran (ne iese ceva gen Suma cifrelor numarului NR este S)
mov dx, offset ms2
mov ah, 9
int 21h
pop ax

afisares:       ; afisam suma S pe ecran
pop ax
add al, 30h
mov ah, 0eh
int 10h
loop afisares

ret

nr dw 44444 
s db 0   
ms1 db 'Suma cifrelor numarului $'
ms2 db ' este $'




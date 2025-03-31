org 0x0100

table:      equ 0x8000
table_size: equ 15

start:
    mov bx, table
    mov cx, table_size
    mov al, 0

p1:
    mov [bx], al
    inc bx
    loop p1
    mov ax, 2

p2: ; checks if table[bx+ax] is 0 if yes then prime and display otherwise go to p3
    mov bx, table
    add bx, ax
    cmp byte[bx], 0
    jne p3
    push ax
    call display_number
    mov al, 0x2c
    call display_letter
    pop ax

p4: ; marks all multiples of number table[bx] to be 1
    add bx,ax
    cmp bx,table+table_size
    jnc p3
    mov byte [bx],1
    jmp p4

p3: ; increments ax and goes back to p2
    inc ax
    cmp ax, table_size
    jne p2

exit:
    int 0x20

display_number: ; stores quotient in ax and rem in dx pushes rem on stack
    mov dx,0    
    mov cx,10
    div cx
    push dx
    cmp ax,0
    je display_number_1
    call display_number

display_number_1: ; retrieves rem from stack stores in ax and prints it as a string
    pop ax
    add al,'0'
    call display_letter
    ret

display_letter:
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    mov ah, 0x0e
    mov bx, 0x000f
    int 0x10
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
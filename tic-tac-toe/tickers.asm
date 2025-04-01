org 0x0100

board: equ 0x0300

; | | | |  <- row
; -+-+-+-  <- showdiv
; | | | |  <- to go next line use crlf
; -+-+-+-
; | | | |

start:
    mov bx, board
    mov cx, 9
    mov al, '1'

b09:
    mov [bx], al
    inc al
    inc bx
    loop b09

b10:
    call show_board
    int 0x20

show_board:
    mov bx, board
    call show_row
    call show_div
    mov bx, board+3
    call show_row
    call show_div
    mov bx, board+6
    jmp show_row

show_row:
    call show_square
    mov al, 0x7c
    call display_letter
    call show_square
    mov al, 0x7c
    call display_letter
    call show_square

show_crlf:
    mov al, 0x0d
    call display_letter
    mov al, 0x0a
    jmp display_letter

show_div:
    mov al,0x2d
    call display_letter
    mov al,0x2b
    call display_letter
    mov al,0x2d
    call display_letter
    mov al,0x2b
    call display_letter
    mov al,0x2d
    call display_letter
    jmp show_crlf

show_square:
    mov al, [bx]
    inc bx
    jmp display_letter

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
; Kendall Molas
; CSc 211
MODEL SMALL
.CODE
assume cs:cseg, ds:cseg
cseg segment
org 100h

JUMPS

START:
    ; Push Video into ES
    mov ax, 0b800h
    mov es, ax

    ; Clear Screen
    mov ah, 0
    mov al, 03 
    int 10h

    ; Print Messages
    MESSAGE_1:
        mov BYTE PTR es:[420], 'H'
        mov BYTE PTR es:[422], 'o'
        mov BYTE PTR es:[424], 'w'
        mov BYTE PTR es:[428], 't'
        mov BYTE PTR es:[430], 'o'
        mov BYTE PTR es:[434], 'p'
        mov BYTE PTR es:[436], 'l'
        mov BYTE PTR es:[438], 'a'
        mov BYTE PTR es:[440], 'y'
        mov BYTE PTR es:[442], ':'

    xor di, di
    mov di, 421
    COLOR_MSG1:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 444
        jnb MESSAGE_2
        loop COLOR_MSG1

    MESSAGE_2:
        mov BYTE PTR es:[560], 'W'
        mov BYTE PTR es:[562], ':'
        mov BYTE PTR es:[566], 'U'
        mov BYTE PTR es:[568], 'P'

        mov BYTE PTR es:[584], 'R'
        mov BYTE PTR es:[586], ':'
        mov BYTE PTR es:[590], 'R'
        mov BYTE PTR es:[592], 'E'
        mov BYTE PTR es:[594], 'S'
        mov BYTE PTR es:[596], 'E'
        mov BYTE PTR es:[598], 'T'

    xor di, di
    mov di, 561
    COLOR_MSG2:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 600
        jnb MESSAGE_3
        loop COLOR_MSG2

    MESSAGE_3:
        mov BYTE PTR es:[720], 'S'
        mov BYTE PTR es:[722], ':'
        mov BYTE PTR es:[726], 'D'
        mov BYTE PTR es:[728], 'O'
        mov BYTE PTR es:[730], 'W'
        mov BYTE PTR es:[732], 'N'

        mov BYTE PTR es:[744], 'F'
        mov BYTE PTR es:[746], '8'
        mov BYTE PTR es:[748], ':'
        mov BYTE PTR es:[752], 'Q'
        mov BYTE PTR es:[754], 'U'
        mov BYTE PTR es:[756], 'I'
        mov BYTE PTR es:[758], 'T'

    xor di, di
    mov di, 721
    COLOR_MSG3:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 760
        jnb MESSAGE_4
        loop COLOR_MSG3

    MESSAGE_4:
        mov BYTE PTR es:[880], 'A'
        mov BYTE PTR es:[882], ':'
        mov BYTE PTR es:[886], 'L'
        mov BYTE PTR es:[888], 'E'
        mov BYTE PTR es:[890], 'F'
        mov BYTE PTR es:[892], 'T'

    xor di, di
    mov di, 881
    COLOR_MSG4:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 894
        jnb MESSAGE_5
        loop COLOR_MSG4

    MESSAGE_5:
        mov BYTE PTR es:[1040], 'D'
        mov BYTE PTR es:[1042], ':'
        mov BYTE PTR es:[1046], 'R'
        mov BYTE PTR es:[1048], 'I'
        mov BYTE PTR es:[1050], 'G'
        mov BYTE PTR es:[1052], 'H'
        mov BYTE PTR es:[1054], 'T'

    xor di, di
    mov di, 1041
    COLOR_MSG5:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 1056
        jnb MESSAGE_5
        loop COLOR_MSG5

    MESSAGE_6:
        mov BYTE PTR es:[1200], 'S'
        mov BYTE PTR es:[1202], 'P'
        mov BYTE PTR es:[1204], 'A'
        mov BYTE PTR es:[1206], 'C'
        mov BYTE PTR es:[1208], 'E'
        mov BYTE PTR es:[1210], ':'
        mov BYTE PTR es:[1214], 'C'
        mov BYTE PTR es:[1216], 'H'
        mov BYTE PTR es:[1218], 'E'
        mov BYTE PTR es:[1220], 'C'
        mov BYTE PTR es:[1222], 'K'
        mov BYTE PTR es:[1226], 'C'
        mov BYTE PTR es:[1228], 'E'
        mov BYTE PTR es:[1230], 'L'
        mov BYTE PTR es:[1232], 'L'

    xor di, di
    mov di, 1201
    COLOR_MSG6:
        mov BYTE PTR es:[di], 6Eh
        add di, 2
        cmp di, 1234
        jnb MESSAGE_6
        loop COLOR_MSG6

    ; ------------ Board begin -----------------

    ; Set board edges
    mov BYTE PTR es:[0], 201 ; Top Left
    mov BYTE PTR es:[1], 04h
    mov BYTE PTR es:[60], 187 ; Top Right
    mov BYTE PTR es:[61], 04h
    mov BYTE PTR es:[1600], 200; Bottom Left
    mov BYTE PTR es:[1601], 04h
    mov BYTE PTR es:[1660], 188; Bottom Right
    mov BYTE PTR es:[1661], 04h

    mov di,2 

    ; Top Border
    L1:
        mov BYTE PTR es:[di], 205 
        mov BYTE PTR es:[di+1], 04h
        add di, 2 
        cmp di, 60
		je FIX_DI_L2
        loop L1

    FIX_DI_L2: ; Fix di 
        mov di, 160

    ; Left Border
	L2:
		mov BYTE PTR es:[di], 186
        mov BYTE PTR es:[di+1], 04h
        add di, 160
        cmp di, 1600
        jnb FIX_DI_L3
        loop L2

    FIX_DI_L3: ; Fix di 
        mov di, 1602

    ; Bottom Border
    L3: ; Fix di 
		mov BYTE PTR es:[di], 205
        mov BYTE PTR es:[di+1], 04h
        add di, 2
        cmp di, 1660
        jnb FIX_DI_L4
        loop L3

    FIX_DI_L4:
        mov di, 220

    ; Right Border
    L4 :; Fix di 
		mov BYTE PTR es:[di], 186
        mov BYTE PTR es:[di+1], 04h
        add di, 160
        cmp di, 1620
        jnb BOARD_BUILD; debugging purposes
        loop L4
    ; ------------ Board end -----------------

    ; ------------ Build board rows and cols begin ------------
    BOARD_BUILD:
        xor di, di
        mov di, 4 
        mov ax, 60 ; This does tho, USE AX

    ; Create the | at the top border
    TOP_COLUMNS:
        mov BYTE PTR es:[di], 194
        mov BYTE PTR es:[di+1], 04h
        add di, 4 
        cmp di, ax
        jnb SET_ROWS
        loop TOP_COLUMNS 

    ; Place 1604 in di in order to build the bottom row
    SET_ROWS:
        xor di, di
        mov di, 1604
        xor ax,ax
        mov ax, 1660

    ; The ascii added to this row is done every four bites.
    BOT_ROWS:
        mov BYTE PTR es:[di], 193
        mov BYTE PTR es:[di+1], 04h
        add di, 4
        cmp di, ax
        jnb FIX_DI_ROWS
        loop BOT_ROWS

    ; Clear Registers
    FIX_DI_ROWS:
        xor di, di
        mov di, 320
        xor ax, ax
        mov ax, 378

    ; Fix DI so it will start at next row
    BEGIN_ROW_DI:
        add di, 2
        jmp BUILD_ROW
    
    ; Used in loop
    REPEAT_CYCLE_ROW:
        mov BYTE PTR es:[di], 196 ; Place last - in board
        mov BYTE PTR es:[di+1],  04h
        add di, 264
        add ax, 320
        cmp ax, 1658
        jnb fix_di_cols
        jmp BUILD_ROW

    BUILD_ROW:
        mov BYTE PTR es:[di], 196
        mov BYTE PTR es:[di+1], 04h 
        add di, 2
        mov BYTE PTR es:[di], 197
        mov BYTE PTR es:[di+1], 04h 
        add di, 2
        cmp di, ax
        jnb REPEAT_CYCLE_ROW
        loop BUILD_ROW

    ; Clear registers and move values into di and ax
    FIX_DI_COLS:
        xor di, di
        mov di, 162
        xor ax, ax
        mov ax, 218

    ; Offset by 2
    BEGIN_COL_DI:
        add di, 2
        jmp BUILD_COLUMNS

    ; Loop through this until di reaches ax
    REPEAT_CYCLE_COLUMN:
        add di, 264
        add ax, 320
        cmp di, 1498
        jnb CLEAN
        jmp BUILD_COLUMNS

    ; Main column building
    BUILD_COLUMNS:
        mov BYTE PTR es:[di], 179
        mov BYTE PTR es:[di+1], 04h 
        add di, 4
        cmp di, ax
        jnb REPEAT_CYCLE_COLUMN
        loop BUILD_COLUMNS

    ; ----------- END Board Building ---------------

    CLEAN:
        xor ax, ax
        xor dx, dx
        xor cx,cx
        xor bx, bx
        xor di, di
        mov di, 162
        jmp ENABLE_CURSOR_MOVEMENT

    ENABLE_CURSOR_MOVEMENT:
        mov ah, 02h
        mov dh, 1
        mov dl, 1
        int 10h
        mov ch, 48 ; Set 0 to bh
        mov cl, 48 ; Set 0 to bl
        jmp KEYPRESS 

    ; Get keystroke
    KEYPRESS:
        mov ah, 00
        int 16h

        ; check for keypress
        cmp al, 's' ; Move Cursor Down
        je DOWN_KEY

        cmp al, 'w' ; Move Cursor Up
        je UP_KEY

        cmp al, 'd' ; Move Cursor Right
        je RIGHT_KEY

        cmp al, 'a' ; Move Cursor Left
        je LEFT_KEY

        cmp al, 'r' ; Restart
        je START

        cmp ah, 39h ; Check current cell
        je BOMB_CHECK

        cmp ah, 42h ; Exit key
        je DONE

        jne KEYPRESS

    ; Check for bomb in cell
    BOMB_CHECK:
        push ax ; Save current value of ax
        mov ax, di

    BOMB_AREAS:
        cmp ax, 166
        je REVEAL_BOMBS
        cmp ax, 206
        je REVEAL_BOMBS
        cmp ax, 494
        je REVEAL_BOMBS
        cmp ax, 1174
        je REVEAL_BOMBS
        cmp ax, 846
        je REVEAL_BOMBS
        cmp ax, 1142
        je REVEAL_BOMBS
        cmp ax, 1466
        je REVEAL_BOMBS
        cmp ax, 1490
        je REVEAL_BOMBS
        
        pop ax ; Restore value of ax

        jmp ADD_SCORE

    ADD_SCORE:
        mov BYTE PTR es:[di], '1'
        inc cl
        jmp KEYPRESS

    GET_VALUE:
        cmp cl, 59
        jl SINGLE_DIGIT
        jmp TWO_DIGIT

    SINGLE_DIGIT:
        inc cl
        jmp OVER 

    TWO_DIGIT:
        sub cl, 10
        inc ch
        cmp ch, 59
        je OVER
        cmp cl, 59
        jle OVER
        loop TWO_DIGIT

    REVEAL_BOMBS:
        mov BYTE PTR es:[166], 42 ;bomb
        mov BYTE PTR es:[206], 42 ;bomb
        mov BYTE PTR es:[494], 42 ;bomb
        mov BYTE PTR es:[1174], 42 ;bomb
        mov BYTE PTR es:[846], 42 ;bomb
        mov BYTE PTR es:[1142], 42 ;bomb
        mov BYTE PTR es:[1466], 42 ;bomb
        mov BYTE PTR es:[1490], 42 ;bomb
        dec cl ; Get proper score value
        jmp GET_VALUE

    OVER:
        mov BYTE PTR es:[1510], 'G'
        mov BYTE PTR es:[1512], 'A'
        mov BYTE PTR es:[1514], 'M'
        mov BYTE PTR es:[1516], 'E'
        mov BYTE PTR es:[1520], 'O'
        mov BYTE PTR es:[1522], 'V'
        mov BYTE PTR es:[1524], 'E'
        mov BYTE PTR es:[1526], 'R'

        mov BYTE PTR es:[1670], 'P'
        mov BYTE PTR es:[1672], 'R'
        mov BYTE PTR es:[1674], 'E'
        mov BYTE PTR es:[1676], 'S'
        mov BYTE PTR es:[1678], 'S'
        mov BYTE PTR es:[1682], 'R'
        
        mov BYTE PTR es:[1990], 'S'
        mov BYTE PTR es:[1992], 'C'
        mov BYTE PTR es:[1994], 'O'
        mov BYTE PTR es:[1996], 'R'
        mov BYTE PTR es:[1998], 'E'
        mov BYTE PTR es:[2000], ':'

        ;inc ch
        mov BYTE PTR es:[2004], ch
        mov BYTE PTR es:[2006], cl

        ; Disable cursor and ask user to restart game
        mov ah, 01
        mov cx, 2000h
        int 10h

        mov ah, 0
        int 16h

        cmp al, 'r'
        je START

    DOWN_KEY:
        cmp dh, 9 ; Restrict to bounding of box
        jge KEYPRESS
        mov ah, 02h
        add dh, 2
        add di, 320
        int 10h
        jmp KEYPRESS

    UP_KEY:
        cmp dh, 1
        jle KEYPRESS
        mov ah, 02h
        sub dh, 2
        sub di, 320
        int 10h
        jmp KEYPRESS

    RIGHT_KEY:
        cmp dl, 29
        jge KEYPRESS
        mov ah, 02h
        add dl, 2
        add di, 4
        int 10h
        jmp KEYPRESS

    LEFT_KEY:
        cmp dl, 1
        jle KEYPRESS
        mov ah, 02h
        sub dl, 2
        sub di, 4
        int 10h
        jmp KEYPRESS

    ; DONE
    ; Exit game
    DONE:
        mov ah, 0
        mov al, 03 
        int 10h
        mov al, 0
        mov ah, 4ch
        int 21h
    cseg ends

END START

.MODEL SMALL
.STACK 100h

.DATA
    letters DB 41h    ;initialize letters starting with A

.CODE
main PROC
    mov ax, @data     ;load the address of data into ax
    mov ds, ax        ;move data address into ds

    mov cl, 26        ;set loop counter to 26
    mov bh, 0         ;initialize bh to store the number of spaces to print

resetSpace:           ;print spaces before each letter
    mov bl, bh        ;copy the current number of spaces to BL

spaceLoop:
    cmp bl, 0         ;check if space counter is 0
    je printChar      ;if no more spaces, jump to print the character
    mov dl, 20h       ;load space into dl
    mov ah, 02h       ;DOS interrupt for printing a character
    int 21h           ;call DOS interrupt
    dec bl            ;decrement space counter
    jmp spaceLoop     ;repeat until all spaces are printed

printChar:
    mov dl, letters   ;move current letter into dl
    mov ah, 02h       
    int 21h           

    add letters, 32   ;convert letter to lowercase
    mov dl, letters   ;move lowercase letter into dl
    int 21h           ;print lowercase letter

    mov dl, 0Dh       ;carriage return
    int 21h           
    mov dl, 0Ah       ;line feed
    int 21h           

    sub letters, 32   ;convert back to uppercase
    inc letters       ;move to next letter
    inc bh            ;increment the space counter
    loop resetSpace   ;loop until cl becomes 0

    mov ax, 4C00h     ; DOS interrupt to terminate the program
    int 21h           ; Call DOS interrupt

main ENDP
END main              ; End of the program

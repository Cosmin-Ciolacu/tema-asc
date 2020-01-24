.MODEL SMALL

.stack 100H

.DATA                                                   ; the data section contains anything that we want to be automatically
                                                        ; initialized by the system before it calls the entry point of the program.

    VAL1    DB  ?                                       ; Define Byte (the size is 1 byte), VAL1 is a variable, "?" means that the values are not initialized.
    NL1     DB  0AH,0DH, 'ENTER NO: ','$'               ; prints the text, $ means the current address according to the assembler.
    NL2     DB  0AH,0DH, 'IT IS NOT PRIME','$'          ; prints the text, $ means the current address according to the assembler.
    NL3     DB  0AH,0DH, 'IT IS PRIME','$'              ; prints the text, $ means the current address according to the assembler.

    .CODE                                               ; start coding.

MAIN:

    MOV AX,@DATA                                        ; DATA is the name of the Data Segment, we declare our variables in a segment, move DATA to AX.
    MOV DS,AX                                           ; move AX to DS, AX is called Initialization of Data Segment and it makes all the variables in Data Segment accessible.

    LEA DX,NL1                                          ; move NL1 label's data into DX.
    MOV AH,09H                                          ; move the string into AH.
    INT 21H                                             ; standard input and output interrupts are found in the DOS Interrupt.

    MOV AH,01H                                          ; read a character and move into AH.
    INT 21H                                             ; standard input and output interrupts are found in the DOS Interrupt.
    SUB AL,30H                                          ; subtract 30H from the input value.
    MOV VAL1,AL                                         ; save the result into VAL1 label.

    MOV AH,00                                           ; clear AH.

   MOV CL,2                                            ; CL usually used to for loop counters.
    DIV CL                                              ; divides the value by CL and keeps the result's quotient in CL and remainder in CH.
    MOV CL,AL                                           ; move AL to CL.

LBL1:

    CMP CL,1                                            ; compare if the CL value is 1.
    JBE LBL3                                            ; Jump if CL=1 or CL=0.

    MOV AH,00                                           ; clear AH.
    MOV AL,VAL1                                         ; move the value in VAL1 to AL.
    DIV CL                                              ; divides the loop.
    CMP AH,00                                           ; check if AH is 0.
    JZ LBL2                                             ; (Jump if Zero) if CMP returns false, jump to LBL2, else continue.
    DEC CL                                              ; decrea8se the value by 1.
    JMP LBL1                                            ; jump to LBL1.                                           ; Jump if Not Equal to 0.
    JMP LBL3                                            ; jump to LBL3.

LBL2:

    MOV AH,09H                                          ; move the string to AH.
    LEA DX,NL2                                          ; equals to - MOV DX, offset NL2.
    INT 21H                                             ; standard input and output interrupts are found in the DOS Interrupt.
    JMP EXIT                                            ; jump to EXIT label.

LBL3:

    MOV AH,09H                                          ; move the string to AH.
    LEA DX,NL3                                          ; equals to - MOV DX, offset NL3.
    INT 21H                                             ; standard input and output interrupts are found in the DOS Interrupt.

EXIT:

    MOV AH,4CH                                          ; exit from the program.
    INT 21H                                             ; standard input and output interrupts are found in the DOS Interrupt.

    END MAIN 
MYDATA SEGMENT
NUM1 DB 10H
NUM2 DB 20H
NUM3 DB 30H
NUM4 DB 40H
RESULT1 DW ?
RESULT2 DW ?
RESULT3 DW ?
MYDATA ENDS

MYCODE SEGMENT
ASSUME CS:MYCODE, DS:MYDATA
MOV AX,MYDATA
MOV DS,AX
MOV AX,0000H
MOV AL,NUM1
MOV BL,NUM2
MOV CL,NUM3
MOV DL,NUM4
AND AL,BL
OR BL,CL
NOT DL
MOV RESULT1,AL
MOV RESULT2,BL
MOV RESULT3,DL
MYCODE ENDS
END

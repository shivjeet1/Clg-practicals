MYDATA SEGMENT
NUM1 DB 10H
NUM2 DB 20H
RESULT DW ?
MYDATA ENDS

MYCODE SEGMENT
ASSUME CS:MYCODE, DS:MYDATA
MOV AX,MYDATA
MOV DS,AX
MOV AL,NUM1
MOV BL,NUM2
MUL BL
MOV RESULT,AX
MYCODE ENDS
END

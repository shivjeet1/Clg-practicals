MYDATA SEGMENT
ARRAY1 DB 10H,20H,30H,40H,50H
COUNT DB 04H
MYDATA ENDS

MYCODE SEGMENT
ASSUME CS:MYCODE, DS:MYDATA
MOV AX,MYDATA
MOV DS,AX
MOV AX,0000H
MOV DL,COUNT
BACK:MOV CL,DL
	LEA AL,ARRAY1
ABC:MOV AL,[SI]
	CMP AL,[SI+1]
	JGE XYZ
	MOV BL,[SI+1]
	MOV [SI+1],AL
XYZ:INC SI
	DEC CL
	JNZ ABC
	DEC DL
	JNZ BACK
MYCODE ENDS
END

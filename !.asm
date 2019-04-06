DATAS SEGMENT
	i DB 'Please input a positive number:$'
	s DB 'The result is:$'
DATAS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS
START:
	MOV AX,DATAS
	MOV DS,AX
	;导入数据部分,导入之后才能使用
	
	LEA DX,i   
	MOV AH,09
	INT 21H
	;提示用户输入
	
	MOV DL,0AH   
	MOV AH,02
	INT 21H	;0DH是回车,是清除当前行的所有内容,回到当前行首位,0AH是换行,此处为输出一个换行	
	
	MOV AH,01
	INT 21h	
	;获取一个用户输出的字符的  ascii  码值
	
	MOV BL,AL  
	;将用户输入的低8位的 ascii 码值暂存入BL中,防止后面其他int21h 命令时改变AH的值导致AX值改变

	
	MOV DL,0AH   
	MOV AH,02
	INT 21H	;0DH是回车,是清除当前行的所有内容,回到当前行首位,0AH是换行,此处为输出一个换行
	
	LEA DX,s
	MOV AH,09
	INT 21H
	;输出提示语
	
	
	MOV AH,0     
        ;将ax中高8位设置为0,因为上面调用输入函数的时候,将高8位设置为1了,这样才能保证AX中存有的只有输入的低8位
	
	MOV AL,BL
	;将用户输入的低8位的值拿回AL中,
	
	SUB AX,30H
	MOV CX,AX
	;将ASCII码转化成数字,同时将CX赋值
	
	CMP AX,1
	JE FINISH1
	CMP AX,0
	JE FINISH1
	;0和1的特殊情况
	
	LOOP1:	
	DEC CX
	MUL CX
	CMP CX,1
	JNE LOOP1
	;简单的乘方计算
	
	
	MOV DL,AL
	ADD DL,30H
	MOV AH,02
	INT 21H
	;因为本实例只能做0-3的阶乘,所以用AL足够能输出了
	
	
	
	MOV AH,4CH
	INT 21H
	;退出程序
	
	FINISH1:
	MOV DL,1
	ADD DL,30H
	MOV AH,02
	INT 21H
	MOV AH,4CH
	INT 21H
	;处理特殊情况
CODES ENDS
	END START
  
 ;-----------------------------------------------------------------------------------------
 ;AX 构成:
 ;--------------------------------------
 ;|              AX                    |
 ;--------------------------------------
 ;|       AH        |         AL       |
 ;--------------------------------------
 ;存入AL和AH的值也就在AX中

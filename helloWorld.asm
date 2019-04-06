datas segment
	hw db 'Hello world!$'
datas ends

codes segment
	assume cs:codes,ds:datas

start:
	mov ax,datas
	mov ds,ax
	;导入数据部分
	
	lea dx,hw
	mov ah,09
	int 21h
	;输出 hello world
	
	mov ah,4ch
	int 21h
	;结束程序
	
codes ends
	end start

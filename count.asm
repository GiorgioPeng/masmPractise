;统计exercise中e的个数
datas segment
	s db 'exercise$'
	n db 'the number of e is:$'
datas ends

codes segment
	assume cs:codes,ds:datas

start:
	mov ax,datas
	mov ds,ax
	;导入数据
	
	mov al,0
	;用al来统计字符串中出现e的个数
	mov si,offset s
	;将s字符串的首地址赋给si(source index)寄存器
	mov cx,8
	;字符串的长度放入通常用于统计的cx寄存器中
	ack:
		mov bh,[si]
		;或者当前位字符串中的字符
		cmp bh,'e'
		;比较是否获取的字符是否等于e
		jne abe
		;如果不等于,就不增加al(统计e个数的寄存器)的值,如果相等,就增加al的值
		inc al
		;增加al的值
	abe:
	;两种进入方式:如果当前位不是e,则通过跳转进入这个标签,如果当前位是e,则按照程序的默认顺序进入这个标签
		inc si
		;将si指向下一个字节
		dec cx
		;说明进行了第 (字符串总长度-cx寄存器中的值) 个字符
		jnz ack
		;如果cx不为0,则说明还没有完成遍历,继续进行,如果为0,则结束
	
	
	lea dx,n
	mov ah,09
	int 21h
	
	add al,30h
	mov dl,al
	mov ah,2
	int 21h
	;输出结果
	
	mov ah,4ch
	int 21h
	;结束程序
	
codes ends
	end start

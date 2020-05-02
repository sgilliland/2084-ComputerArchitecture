; Sarah Gilliland, David Hawkins, Dakota Wilson
; A collaborative project for CMPS 2084
			.model	small
			.stack	100h
			.data
			.code

; airplane code starts here, assuming DX has its position
DPLANE  	PROC 	NEAR

			;draws the airplane
			push 	AX
			push	BX
			push	CX
			push	DX
			
			;position tail
			MOV 	AH,2	;sets cursor in a specified screen position
			MOV 	BH,0	;define screen page to be used
			PUSH 	DX	; saves position for next line
			INT 	10H	
			mov 	dl,0dch	; prints 
			mov 	ah,2
			int 	21h
			mov 	dl,20h	; prints space
			int 	21h
			mov 	dl,0ddh	; prints 
			int 	21h
			
			;position body
			POP   	DX
			ADD 	DH,1	;sets cursor in the next line (uses the same column)
			INT 	10H
			PUSH 	DX	; saves position for next line
			mov 	dl,0dbh ; prints 
			int 	21h
			mov 	dl,0dbh
			int 	21h
			mov 	dl,0dbh
			int 	21h
			mov 	dl,010h	;prints  
			int 	21h
			
			;position wing
			POP   	DX
			ADD 	DH,1	;sets cursor in the next line (uses the same column)
			INT 	10H
			mov 	dl,20h 	; prints space
			int 	21h
			mov 	dl,20h
			int 	21h
			mov 	dl,0ddh	;prints 
			int 	21h
			
			;restore registers
			pop		dx
			pop 	cx
			pop		bx
			pop 	ax
			ret
DPLANE		ENDP	
;----------------------------------------------------------------------------
EPLANE  	PROC 	NEAR
			
			;erases the airplane
			push 	AX
			push	BX
			push	CX
			push	DX
			
			;position tail
			MOV 	AH,2	;sets cursor in a specified screen position
			MOV 	BH,0	;define screen page to be used
			PUSH 	DX	; saves position for next line
			INT 	10H	
			mov 	dl,020h	; prints 
			mov 	ah,2
			int 	21h
			mov 	dl,20h	; prints space
			int 	21h
			mov 	dl,020h	; prints 
			int 	21h
			
			;position body
			POP   	DX
			ADD 	DH,1	;sets cursor in the next line (uses the same column)
			INT 	10H
			PUSH 	DX	; saves position for next line
			mov 	dl,020h ; prints 
			int 	21h
			mov 	dl,020h
			int 	21h
			mov 	dl,020h
			int 	21h
			mov 	dl,020h	;prints  
			int 	21h
			
			;position wing
			POP   	DX
			ADD 	DH,1	;sets cursor in the next line (uses the same column)
			INT 	10H
			mov 	dl,20h 	; prints space
			int 	21h
			mov 	dl,20h
			int 	21h
			mov 	dl,020h	;prints 
			int 	21h
			
			;restore registers
			pop		dx
			pop 	cx
			pop		bx
			pop 	ax
			ret
EPLANE		ENDP	; end of airplane code

Main:		mov		ax, @data
			mov		ds, ax
			
			; clear the screen
			mov		ax, 0600h
			mov		bh, 7
			mov		cx, 0
			mov		dx, 184fh
			int		10h
			
			; move the cursor
			mov		ah, 2
			mov		bh, 0
			mov		dh, 12			; row number
			mov		dl, 12			; column number
			int 	10h
			
			;call the functions
			call	DPLANE
			
lup:		mov		ah, 7
			int     21h
			
			cmp		al, 73h
			je		right
			
			cmp		al, 61h
			je		left
			
			cmp		al, 77h
			je		up
			
			cmp		al, 7Ah
			je		down
			
			jmp		done
			
right:		cmp		dl, 76
			je		lup
			call	EPLANE
			add		dl, 1
			call	DPLANE
			jmp		lup
			
left:		cmp		dl, 0
			je		lup
			call	EPLANE
			sub		dl, 1
			call	DPLANE
			jmp		lup
			
up:			cmp		dh, 0
			je		lup
			call	EPLANE
			sub		dh, 1
			call	DPLANE
			jmp		lup
			
down:		cmp		dh, 22
			je		lup
			call	EPLANE
			add		dh, 1
			call	DPLANE
			jmp		lup
			
done:		mov		ah, 4ch
			int		21h
			end		Main

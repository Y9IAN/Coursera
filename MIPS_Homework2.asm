		.data

FoundString:	.asciiz "Success!Location: "
NotFoundString:	.asciiz "Fail!"
Hints:		.asciiz "Enter your input string: \n"
Buffer:		.space	128

		.text
main:		la $a0, Hints
		li $v0, 4
		syscall
		
		##Load input string
		la $a0, Buffer
		li $a1, 128
		li $v0, 8
		syscall
		
		##Load input character
receiveChar:	li $v0, 12
		syscall
		
		##Save character to $s0
		move $s0, $v0
		
		li $a0, '\n'
		li $v0, 11
		syscall
		
		beq $s0, '?', exit
		
		#index initial value==1
		li $t0, 1
		la $t1, Buffer
		
		##load each char and compare
searchChar:	lb $t2, ($t1)
		beq $t2, '\0', Fail
		beq $t2, '\n', Fail
		beq $t2, $s0, Success
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		j searchChar
		

Success:	la $a0, FoundString
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		j receiveChar

Fail: 		la $a0, NotFoundString
		li $v0, 4
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		j receiveChar
				
exit:		li $v0, 10
		syscall
		
		

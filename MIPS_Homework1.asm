		.data
UpperCase: 	.asciiz "Alpha", "Bravo", "China", "Delta", "Echo", "Foxtrot", "Golf", 
			"Hotel", "India", "Juliet", "Kilo", "Lima", "Mary", "November", 
			"Oscar", "Paper", "Quebec", "Research", "Sierra", "Tango", 
			"Uniform", "Victor", "Whisky", "X-ray", "Yankee", "Zulu"
ucOffset:	.word  	0,6,12,18,24,29,37,42,48,54,61,66,71,76,85,91,97,104,113,120,126,134,141,148,154,161

LowerCase: 	.asciiz "alpha", "bravo", "china", "delta", "echo", "foxtrot", "golf", 
			"hotel", "india", "juliet", "kilo", "lima", "mary", "november", 
			"oscar", "paper", "quebec", "research", "sierra", "tango", 
			"uniform", "victor", "whisky", "x-ray", "yankee", "zulu"
lcOffset:	.word  	0,6,12,18,24,29,37,42,48,54,61,66,71,76,85,91,97,104,113,120,126,134,141,148,154,161			
			
Digit:		.asciiz	"zero", "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"
numOffset:	.word	0,5,11,18,24,31,37,43,51,58

		.text
main:		li $v0, 12
		syscall
		move $t0, $v0
		beq $t0, '?', exit
		blt $t0, '0', Unknown
		ble $t0, '9', printNum
		blt $t0, 'A', Unknown
		ble $t0, 'Z', printUC
		blt $t0, 'a', Unknown
		ble $t0, 'z', printLC
		j Unknown
				
Unknown:	li $a0, '*'
		li $v0, 11
		syscall
		j endLine	

printUC:	sub $t1, $t0, 'A'		##Get digit number
		sll $t1, $t1, 2			##Get wordoffset index
		la $t2, ucOffset
		add $t3, $t2, $t1
		lw $s1, ($t3)			##Save offset
		la $s2, UpperCase		##Save base address
		add $a0, $s2, $s1		##Get address
		li $v0,4
		syscall
		j endLine		

printLC:	sub $t1, $t0, 'a'		##Get digit number
		sll $t1, $t1, 2			##Get wordoffset index
		la $t2, lcOffset
		add $t3, $t2, $t1
		lw $s1, ($t3)			##Save offset
		la $s2, LowerCase		##Save base address
		add $a0, $s2, $s1		##Get address
		li $v0,4
		syscall
		j endLine	

printNum:	
		sub $t1, $t0, '0'		##Get digit number
		sll $t1, $t1, 2			##Get wordoffset index
		la $t2, numOffset
		add $t3, $t2, $t1
		lw $s1, ($t3)			##Save offset
		la $s2, Digit			##Save base address
		add $a0, $s2, $s1		##Get address
		li $v0,4
		syscall
		j endLine
		
endLine:	li $a0, '\n'
		li $v0, 11
		syscall
		j main		

exit:		li $v0, 10
		syscall
		

		

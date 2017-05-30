.data
	prompt1: .asciiz "\n\n Enter the n please:"
.text



fib_rt: 

		lw $ra, 4($sp) # restore $ra
		addi $sp, $sp, 8 # restore $sp
		li $v0,1
		add $a0,$t0, $zero
		syscall
		jr $ra

fib: 		addi $sp, $sp, -8 # room for $ra and one temporary
		sw $ra, 4($sp) # save $ra
		move $t0, $a0 # pre-load return value as n
		blt $a0, 2, fib_rt # if(n < 2) return n
		sw $a0, 0($sp) # save a copy of n
		addi $a0, $a0, -1 # n - 1
		jal fib # fib(n - 1)
		lw $a0, 1($sp) # retrieve n
		sw $t0, 0($sp) # save result of fib(n - 1)
		addi $a0, $a0, -2 # n - 2
		jal fib # fib(n - 2)
		lw $t1, 0($sp) # retrieve fib(n - 1)
		add $t0, $t0, $t1 # fib(n - 1) + fib(n - 2)
		jr $ra

main:
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $a0, $v0
		j fib

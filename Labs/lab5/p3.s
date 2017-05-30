.data
f: .asciiz "The Fibonacci sequence result is... "
.text
.globl main
main:
       li $s0, 3       # hold fibonnaci number n
       li $s1, 2

fibonacci:
	addiu $sp , $sp , ?12
	sw $ra , 0 ( $sp )
	sw $a0 , 4 ( $sp )
	sw $s0 , 8 ( $sp )

	slt $t0,$s0,$s1
	beq $t0, 1 exit
	j else
else:
	addi $sp, $sp, -8
	sub $s1,$s0,1
	sub $s2,$s0,2
	sw $ra, 4($sp) # save return address
	sw $a0, 0($sp) # save argument

	add $s0, $s1, $s2
	j fibonacci

exit:
	li $v0, 4
	la $a0, f #print f string
	syscall
	li $v0, 1
	move $a0, $s0
    	syscall
    	li $v0, 10

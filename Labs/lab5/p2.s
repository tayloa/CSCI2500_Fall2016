.data
b: .asciiz "BUZZ\n"
f: .asciiz "FIZZ\n"
fb: .asciiz "FizzBuzz\n"
newline: .asciiz "\n"
.text
.globl main
main:
       li $t0, 1       # load immediate t0, store 0 in t0 register, will be the index
       li $t1, 21      # load immediate t1, store 20 in t1 register
       li $s0, 3
	li $s1, 5

loop:
    beq $t0, $t1,exit

	div $t0, $s0 #divide the number by 3
	mfhi $t4

	div $t0, $s1 #divide the number by 5
	mfhi $t6

	beq $t4, 0, fizz
    	beq $t6, 0, buzz #branch equal if the remainder equals 0
    	j else
else:
	li $v0, 1
	move $a0, $t0
    	syscall
    	li $v0, 4
	la $a0, newline #print newlines
	syscall
    	add $t0, $t0, 1 #incriment the index
    	j loop
fizz:
	beq $t6, 0, fizzbuzz #branch equal if the remainder equals 0 when divided by 5
	li $v0, 4
	la $a0, f #print fizz
	syscall
	add $t0, $t0, 1 #incriment the index
	j loop

buzz:
	beq $t4, 0, fizzbuzz #brach equal, if the remainder equals 0 when divided by 3
	li $v0, 4
	la $a0, b #print buzz
	syscall
	add $t0, $t0, 1 #incriment the index
	j loop

fizzbuzz:
	li $v0, 4
	la $a0, fb #print fizzbuzz
	syscall
	add $t0, $t0, 1 #incriment the index
	j loop

exit:
	li $v0, 10

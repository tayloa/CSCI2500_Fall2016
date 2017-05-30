.data
prompt: .asciiz "The sum is... "

.text
.globl main
main:
       li $t0, 0       # load immediate t0, store 0 in t0 register, will be the index
       li $t1, 5       # load immediate t1, store n in v0 register
       li $t2, 0       # load immediate t2, store what will be the sum value in the t2 register
sum:
    beq $t0, $t1,exit
    add $t2, $t2, $t0
    add $t0, $t0, 1 #incriment the index
    j sum


exit:
	li $v0, 4
	la $a0, prompt #print the sum
	syscall
	li $v0, 1
	move $a0, $t2
    	syscall

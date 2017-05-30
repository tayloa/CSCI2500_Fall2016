.data
msg: .asciiz "The GCD is "

.text
.globl main
main:  li $t0, 12       # load immediate t0, store 2 in t0 register
       li $t1, 16       # load immediate v0, store 5 in v0 register

loop:
    beq $t0, $t1,exit
    sgt $s0, $t0, $t1 #store bool in s0, compare t0 and t1
    beq $s0, $1, else 
    subu $t0, $t0, $t1
    j loop  
else:
	subu $t1, $t1, $t0
	j loop

exit:
	li $v0, 4
	 la $a0, msg
	 syscall
	 li $v0, 1
	move $a0, $t0
    	 syscall

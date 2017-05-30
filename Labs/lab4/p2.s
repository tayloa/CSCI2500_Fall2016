.data
msg: .asciiz "The number is less than 5."
msg2: .asciiz "The number is greater than 5."

.text
.globl main
main:  li $t0, 6       # load immediate t0, store 2 in t0 register
       li $t1, 5       # load immediate t1, store 5 in v0 register
        
    slt $s0, $t0, $t1 #store bool in s0, compare t0 and t1
    beq $s0, $zero, greater #brach equal, if the result s0 equals 0
    add $t0, $t0, $t1
    li $v0, 4
    la	$a0, msg
    
    syscall

    greater: 
		li $v0, 4
		la $a0, msg2
		li $v0, 1
		move $a0, $t0
		syscall


	

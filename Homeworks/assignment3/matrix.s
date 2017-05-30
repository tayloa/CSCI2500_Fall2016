#############################################################################
#############################################################################
## Assignment 3: Aaron Taylor
#############################################################################
#############################################################################

#############################################################################
#############################################################################
## Data segment
#############################################################################
#############################################################################

.data

matrix_a:    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
matrix_b:    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
result:      .word 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0,  0,  0,  0,  0

newline:     .asciiz "\n"
tab:         .asciiz "\t"
msg1:	     .asciiz "Enter the values for matrix A:"
msg2: 	   .asciiz "Enter the values for matrix B:"
msg3:	     .asciiz "Product A x B matrices:"
.align 2               # instructions must be on word boundaries

#############################################################################
#############################################################################
## Text segment
#############################################################################
#############################################################################

.text                  # this is program code
.globl main            # main is a global label

.globl matrix_multiply
.globl matrix_print

#############################################################################
start:
#############################################################################
    li $t0, 0		# initialize the index i to 0
    li $v0, 4           # prompt for user to add values to A
    la $a0, msg1        # load prompt
    syscall

    li $v0, 4           # print newline
    la $a0, newline
    syscall
    j add_values_a

##################################################################################
add_values_a:
##################################################################################
    beq $t0, 64, exit_loop_a   # branch if equal to 64, 16 items stored in A,exit

    li $v0, 5       	       # read int
    syscall
    sw $v0, matrix_a($t0)      # store input in array

    addi $t0, $t0, 4           # incriment i by 4, restart the loop
    j add_values_a

################################################################################
exit_loop_a:
################################################################################
    li $t1, 0		# set the index j to 0
    li $v0, 4           # prompt for user to add values to A
    la $a0, msg2        # load prompt
    syscall

    li $v0, 4           # print newline
    la $a0, newline
    syscall
    j add_values_b

###############################################################################
add_values_b:
###############################################################################
    beq $t1, 64,exit_loop_b   # branch if equal to 64, 16 items, go load A,B, and result
    li $v0, 5                 # read int
    syscall
    sw $v0, matrix_b($t1)     # store input in array

    addi $t1, $t1, 4          # incriment i by 4, restart the loop
    j add_values_b

###############################################################################
main:
###############################################################################
    # alloc stack and store $ra
    sub $sp, $sp, 4 # make space for integer on stack
    sw $ra, 0($sp)

    # jump to the input
    jal start

################################################################################
exit_loop_b:
###############################################################################
    # load A, B, and result into arg regs
    la $a1, matrix_a
    la $a2, matrix_b
    la $a3, result
    jal matrix_multiply

    la $a0, result
    jal matrix_print

    # restore $ra, free stack and return
    lw $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra

##############################################################################
matrix_multiply:
##############################################################################
# mult matrices A and B together of square size N and store in result.

    # alloc stack and store regs
    sub $sp, $sp, 24 # alloc stack for 6 integers
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    sw $s1, 16($sp)
    sw $s2, 20($sp)

    #setup for i loop
    addi $t0,$zero, 0

############################################################################
loop1: # loop for i
############################################################################
    # setup for j loop
    addi $t1,$zero, 0 # j = 0

#################################################################################
loop2: # loop for j
#################################################################################
    # setup for k loop
    li $t2,0 # k = 0

    # allocate the space for result in the result array
    sll $t5, $t0, 2    # $t5 = i*2^n
    add $t5, $t5, $t1  # $t5 = (i*2^n) + j
    sll $t5, $t5, 2    # multiply index by 4 to account for offset
    add $t5,$a3, $t5
    lw $t6, 0($t5)     # make space for the result at this address

#########################################
loop3: # loop for k
#########################################
    # compute A[i][k] address and load into $t3
    # matrix[i][k] = matrix[4*row+col]
    sll $t3, $t0, 2    # $t3 = i*2^n
    add $t3, $t3, $t2  # $t3 = (i*2^n) + k
    sll $t3, $t3, 2    # multiply index by 4 to account for offset
    add $t3,$t3,$a1
    lw $s1, 0($t3)

    # compute B[k][j] address and load into $t4
    # matrix[k][j] = matrix[4*row+col]
    sll $t4, $t2, 2   # $t4 = k*2^n
    add $t4, $t4, $t1 # $t4 = (k*2^n) + j
    sll $t4, $t4, 2   # multiply index by 4 to account for offset
    add $t4, $t4, $a2
    lw $s2, 0($t4)

    # invoke mul instruction
    mul $t7, $s1, $s2 # $t7 = t3 x t4

    add $t6, $t6, $t7 # add the product to the other products
    	 	      # $t6 = $t6 + $t7

    # increment k and jump back or exit
    addi $t2,$t2,1
    beq $t2,4, latch2 # if k = 16, (k = 4), exit incriment i
    j loop3

#######################################################
latch2:
#######################################################
    # increment j and jump back or exit
    addi $t1,$t1,1     # j + 1

    # increment i and jump back or exit
    sw $t6, 0($t5)
    beq $t1,4, latch1 # if j = 16 (j = 4), go incriment i
    j loop2

########################################################
latch1:
########################################################

    addi $t0,$t0,1
    beq $t0, 4, exit # if i becomes 16 (i = 4), exit the loop, print the results
    j loop1

###########################################################
exit:
###########################################################
    # retore saved regs from stack
    lw $s2, 20($sp)
    lw $s1, 16($sp)
    lw $s0, 12($sp)
    lw $a1, 8($sp)
    lw $a0, 4($sp)
    lw $ra, 0($sp)

    # free stack and return
    add $sp, $sp, 24
    jr $ra

##############################################################################
matrix_print:
##############################################################################
    # alloc stack and store regs.
    sub $sp, $sp, 16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $a0, 12($sp)

    li $t0, 4 # size of array

    li $v0, 4           # print the string "product of A X B"
    la $a0, msg3
    syscall

    li $v0, 4           # print newline
    la $a0, newline
    syscall

              # do your two loops here
    li $t0, 0 # i = 0
    li $t1, 0 # j = 0, counter to say when to print newline

#############################################################
print_head:
##############################################################
    beq $t0, 16, print_exit

#############################################################
print_body:
############################################################
    sll $t2,$t0,2 # $t2 = i*2^n
    lw $t2, result($t2)

    li $v0, 1          # print the number
    move $a0, $t2
    syscall

    li $v0, 4           # print tab
    la $a0, tab
    syscall
    j print_latch

#####################################################################
print_latch:
#####################################################################
    addi $t0,$t0, 1    # incriment i
    addi $t1,$t1, 1    # incriment j
    li $t3, 4
    div $t1, $t3       # i mod 4
    mflo $t6           # temp for the mod
    beq $t6, 1, print_newline    # if the result is 1, go print a newline
    j print_head

##############################################################
print_newline:
##############################################################
    li $t1, 0
    li $v0, 4
    la $a0, newline
    syscall
    j print_head

##############################################################
print_exit:
##############################################################
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $a0, 12($sp)
    add $sp, $sp, 16
    jr $ra

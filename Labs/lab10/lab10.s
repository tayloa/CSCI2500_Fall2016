.data

array:       .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
newline:     .asciiz "\n"
tab:         .asciiz "\t"

.text
.globl main

main:
    la $s0, array
    # 64 = 16 * 4
    li $s1, 64
    add $s1, $s0, $s1
    j loop_header

loop_header:
    blt $s0, $s1, loop_body
    j loop_exit

loop_body:

    # print the value
    lw $a0, 0($s0)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # incriment the first 4 values
    lw $t0, 0($s0)
    lw $t1, 0($s0)
    lw $t2, 0($s0)
    lw $t3, 0($s0)

    addi $t0, $t0, 1
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    addi $t3, $t3, 1

    sw $t0, 0($s0)
    sw $t1, 0($s0)
    sw $t2, 0($s0)
    sw $t3, 0($s0)

loop_latch:
    add $s0, $s0, 16  # incriment by 4
    j loop_header

loop_exit:
jr $ra          # retrun to caller

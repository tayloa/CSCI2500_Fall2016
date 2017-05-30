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
    li $s3, 0 # counter for outer loop
    li $s4, 5 # limit for outer loop
    add $s2, $s0, $s1
    j loop_header

outer_loop_header:
    blt $s3, $s4, loop_header
    j outer_loop_exit

loop_header:
    blt $s0, $s2, loop_body
    j loop_exit

loop_body:

    # print the value
    lw $a0, 0($s0)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    lw $t0, 0($s0)
    addi $t1, $t0, 1
    sw $t1, 0($s0)

    j loop_latch

loop_latch:
    add $s0, $s0, 4
    j loop_header

loop_exit: # same as the outer loop latch
  la $s0, array     # go back to the start of the array
  li $s1, 64
  add $s2, $s0, $s1
  add $s3, $s3, 1   # incriment the outer loop counter

  li $v0, 4         # print a new line
  la $a0, newline
  syscall

  j outer_loop_header

outer_loop_exit:
  jr $ra          # retrun to caller

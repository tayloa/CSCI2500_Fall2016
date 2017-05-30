.data
	prompt: .asciiz "What is n? " 
	n: "\n"
	star: "*"
.text
main:
	#print the prompt message
	li $v0, 4
	la $a0, prompt
	syscall
	
	#store the value of n
	li $v0, 5
	syscall
	
	#store the entered value and add 1 to it
	move $t0, $v0
	add $t0, $t0, 1
	
	#create incriment value
       	li $t1, 0	
       	
       	#create incriment value for star loop 
       	li $t2, 0
      	
loop_header:
	beq $t0, $t1,exit
  
star_head:
	slt $s0,$t2,$t1      # checks if $s0 > $s1
	beq $s0,0,star_exit     # if $s0 > $s1, goes to label1

star_body:
	#print the star
	li $v0, 4
	la $a0, star
	syscall

star_latch:
	add $t2, $t2, 1 #incriment the index
	j star_head
	
star_exit:
	#print the newline
	li $v0, 4
	la $a0, n
	syscall
	li $t2, 0
  	
latch:
	add $t1, $t1, 1 #incriment the index
    	j loop_header

exit:
	jr $ra
	

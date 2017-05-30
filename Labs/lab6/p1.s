.data
	prompt: .asciiz "What is n? " 
	n: "\n"
.text
main:
	#print the prompt message
	li $v0, 4
	la $a0, prompt
	syscall
	
	#store the value of n
	li $v0, 5
	syscall
	
	#store the entered value 
	move $t0, $v0
	
	#create incriment value
       	li $t1, 0	 
      	
loop_header:
	beq $t0, $t1,exit
		
loop_body:
	#print the counter
	li $v0, 1
	move $a0, $t1
    	syscall
    	
    	#print the newline
	li $v0, 4
	la $a0, n
	syscall
    	
latch:
	add $t1, $t1, 1 #incriment the index
    	j loop_header
exit:
	jr $ra
	

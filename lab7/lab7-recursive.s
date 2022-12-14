.global main
    
.set noreorder

 main:  
                addi $a0, $0, 4         # n = 4
		addi $t0, $0, 2
                jal fib                 # call fib(n); 
		add $0, $0, $0
    fib:        slt $t0, $a0, 3        # t0 = 1 if n < 3
                beq $t0, $0, ELSE    # go to ELSE if n >= 3
                addi $v0, $0, 1      # put return value (1) in $v0
                jr $ra                  # return
    ELSE:       addi $sp, $sp, -12      # PUSH: adjust stack ptr for 3 items
                sw $ra, 0($sp)          # store $ra on stack
                sw $s0, 4($sp)          # store $s0 on stack
                sw $s1, 8($sp)          # store $s1 on stack
                add $s0, $a0, $0     # save n ($a0) in $s0
    firstcall:
                addi $a0, $s0, -1       # put n-1 in $a0
                jal fib                 # recursive call; result will be in $v0
    back: add $s1, $s1, $v0       # save result1 ($v0) in $s1
    secondcall:
                addi $a0, $s0, -2       # put n-2 in $a0
                jal fib                 # recursive call; result will be in $v0
    back_2: add $v0, $s1, $v0       # save result1 + result2 in $v0
    pop:  lw $s1, 8($sp)          # POP: retrieve $s1 from stack
                lw $s0, 4($sp)          # retrieve $s0 from stack
                lw $ra, 0($sp)          # retrieve $ra from stack
                addi $sp, $sp, 12       # restore stack pointer
    return:     jr $ra                  # return



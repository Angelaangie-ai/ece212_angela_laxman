.global main
    
.set noreorder

main: 
    main: addi $a0,$0,10 # n = 8 (find 8th fib number)
    jal fib # call fib(8)
    addi $0, $0, 0 # branch delay slot 

done: j done # infinite loop
    add $0, $0, $0 # branch delay slot

fib:
    addi $t0, $0, 0  # a = 1
    addi $t1, $0, 1  # b = 1
    addi $t2, $0, 1  # i = 1
   
    
    addi $t4, $0, 2 # setting t3 equal to 2
    slt $t5, $a0, $t4 # if n is less than 2
    beq $t5, $0, for
    add $0, $0, $0
    addi $v0, $0, 1 # return 1
    jr $ra 
    add $0, $0, $0
     
  
    for: 
    slt $t6, $t2, $a0   # if i is less than n
    beq $t6, $0, return # return a 
    add $0, $0, $0
    add $t3, $t1, $t0 # c = a+b
    add $t0, $0, $t1 # a = b
    add $t1, $0, $t3 # b=c 
    addi $t2, $t2, 1   # i++
    j for
    add $0, $0, $0

    return:
    addi $v0, $t3, 0
    jr $ra
    add $0, $0, $0


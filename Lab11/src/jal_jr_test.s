   .global main
   .set noreorder
main:
    addi $a0, $0, 7
    addi $a1, $0, 33
    jal  max
    add  $0, $0, $0
    add $t0, $v0, $0
#    sw   $v0, 84($0)

loop:
    j    loop
    add  $0, $0, $0
max:
    slt  $t0, $a0, $a1
    add  $0, $0, $0
    add  $0, $0, $0
    bne  $t0, $0, a1max
    add  $0, $0, $0
    add  $v0, $a0, $0
    jr   $ra
    add  $0, $0, $0
 a1max:
    add  $v0, $a1, $0
    jr  $ra
    add $0, $0, $0




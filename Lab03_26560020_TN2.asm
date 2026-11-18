# Listing 3 - clamp(x, lo, hi)
#Name : Nguy?n Minh Hoàng
#student ID : 26560020.

text
.globl main
main:
    li   $v0, 5                 # read an integer x into $v0
    syscall
    add  $a0, $v0, $zero        # argument 1: x
    addi $a1, $zero, 0          # argument 2: lo = 0
    addi $a2, $zero, 100        # argument 3: hi = 100
    jal  clamp
    add  $a0, $v0, $zero        # print the result
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall
 
# clamp(x = $a0, lo = $a1, hi = $a2): returns x limited to [lo, hi] in $v0
clamp:
     slt  $t0, $a0, $a1      # x < lo ?
    bne  $t0, $zero, lower   # if true, go to lower

    slt  $t0, $a2, $a0      # hi < x ?
    bne  $t0, $zero, upper   # if true, go to upper

    add  $v0, $a0, $zero     # otherwise, result = x
    jr   $ra

lower:
    add  $v0, $a1, $zero     # result = lo
    jr   $ra

upper:
    add  $v0, $a2, $zero     # result = hi
    jr   $ra

# Listing 2 - max2(a, b) returns the larger of a and b
.text
.globl main
main:
    addi $a0, $zero, 15         # a = 15
    addi $a1, $zero, 42         # b = 42
    jal  max2                   # $v0 = max2(15, 42)
    add  $a0, $v0, $zero        # copy the result first,
    li   $v0, 1                 # then print it
    syscall
    addi $a0, $zero, -7         # a = -7
    addi $a1, $zero, -3         # b = -3
    jal  max2                   # $v0 = max2(-7, -3)
    add  $s1, $v0, $zero        # keep the result in $s1
    li   $v0, 10
    syscall
 
# max2(a = $a0, b = $a1): returns the larger one in $v0
max2:
    add  $v0, $a0, $zero        # result = a
    slt  $t0, $a0, $a1          # $t0 = 1 if a < b
    beq  $t0, $zero, max2_end   # a >= b: keep a
    add  $v0, $a1, $zero        # otherwise result = b
max2_end:
    jr   $ra

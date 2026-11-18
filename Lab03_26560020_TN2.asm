# Listing 3 - clamp(x, lo, hi)
# Student Name : Nguyễn Minh Hoàng
#Student ID : 26560020.
.text
.globl main
main:
    li   $v0, 5
    syscall
    add  $a0, $v0, $zero
    addi $a1, $zero, 0
    addi $a2, $zero, 100
    jal  clamp
    add  $a0, $v0, $zero
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall

clamp:
    slt  $t0, $a0, $a1
    bne  $t0, $zero, lower

    slt  $t0, $a2, $a0
    bne  $t0, $zero, upper

    add  $v0, $a0, $zero
    jr   $ra

lower:
    add  $v0, $a1, $zero
    jr   $ra

upper:
    add  $v0, $a2, $zero
    jr   $ra

# Listing 2 - max2(a, b) returns the larger of a and b
.text
.globl main
main:
    addi $a0, $zero, 15
    addi $a1, $zero, 42
    jal  max2
    add  $a0, $v0, $zero
    li   $v0, 1
    syscall
    addi $a0, $zero, -7
    addi $a1, $zero, -3
    jal  max2
    add  $s1, $v0, $zero
    li   $v0, 10
    syscall

max2:
    add  $v0, $a0, $zero
    slt  $t0, $a0, $a1
    beq  $t0, $zero, max2_end
    add  $v0, $a1, $zero
max2_end:
    jr   $ra

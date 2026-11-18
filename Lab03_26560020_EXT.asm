# Extension - min_max(addr, n) returning min in $v0 and max in $v1
# Student Name: Nguyễn Minh Hoàng
#Student ID : 26560020
.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
minA:   .asciiz "Class A min: "
maxA:   .asciiz "Class A max: "
minB:   .asciiz "Class B min: "
maxB:   .asciiz "Class B max: "
nl:     .asciiz "\n"

.text
.globl main
main:
    # --- X? l? Class A ---
    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: n = 10
    jal  min_max                # $v0 = min (39), $v1 = max (94)
    
    add  $t8, $v1, $zero        # lýu t?m max ($v1) vào $t8 v? hàm show s? ghi ðè $v0
    la   $a0, minA
    add  $a1, $v0, $zero        # in min ($v0)
    jal  show
    
    la   $a0, maxA
    add  $a1, $t8, $zero        # in max (ð? lýu ? $t8)
    jal  show

    # --- X? l? Class B ---
    la   $a0, classB            # argument 1: address of classB[0]
    addi $a1, $zero, 8          # argument 2: n = 8
    jal  min_max                # $v0 = min (38), $v1 = max (92)
    
    add  $t8, $v1, $zero        # lýu t?m max ($v1) vào $t8
    la   $a0, minB
    add  $a1, $v0, $zero        # in min ($v0)
    jal  show
    
    la   $a0, maxB
    add  $a1, $t8, $zero        # in max (ð? lýu ? $t8)
    jal  show

    # --- K?t thúc chýõng tr?nh ---
    li   $v0, 10
    syscall

# min_max(addr = $a0, n = $a1): returns min in $v0 and max in $v1
min_max:
    lw   $v0, 0($a0)            # min = array[0]
    lw   $v1, 0($a0)            # max = array[0]
    addi $t0, $zero, 1          # i = 1 (b?t ð?u so sánh t? ph?n t? th? 2)
mm_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 n?u i < n
    beq  $t1, $zero, mm_end     # thoát v?ng l?p n?u i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = ð?a ch? c?a array[i]
    lw   $t3, 0($t2)            # $t3 = array[i]

    # Ki?m tra n?u array[i] < min ($t3 < $v0)
    slt  $t1, $t3, $v0          # $t1 = 1 n?u $t3 < $v0
    beq  $t1, $zero, check_max  # n?u không nh? hõn min th? nh?y sang ki?m tra max
    add  $v0, $t3, $zero        # c?p nh?t min m?i: $v0 = array[i]

check_max:
    # Ki?m tra n?u array[i] > max ($v1 < $t3)
    slt  $t1, $v1, $t3          # $t1 = 1 n?u $v1 < $t3
    beq  $t1, $zero, mm_next    # n?u không l?n hõn max th? chuy?n sang ph?n t? k?
    add  $v1, $t3, $zero        # c?p nh?t max m?i: $v1 = array[i]

mm_next:
    addi $t0, $t0, 1            # i = i + 1
    j    mm_loop
mm_end:
    jr   $ra

# show(msg = $a0, value = $a1): prints msg, value and a new line
show:
    li   $v0, 4
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra

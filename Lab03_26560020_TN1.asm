# Listing 1 - one procedure, called from two places
#Student name: Nguy?n Minh Hoàng
#Student ID: 26560020.
.data
title:    .asciiz "SCORE REPORT\n"
endMsg:   .asciiz "END\n"
line:     .asciiz "----------\n"
starLine: .asciiz "**********\n"

.text
.globl main
main:
    
    li   $v0, 4
    la   $a0, starLine
    syscall

    
    li   $v0, 4
    la   $a0, title
    syscall

    
    jal  sep

    
    li   $v0, 4
    la   $a0, endMsg
    syscall

   
    jal  stars

    
    li   $v0, 10
    syscall


sep:
    li   $v0, 4
    la   $a0, line
    syscall
    jr   $ra


stars:
    li   $v0, 4
    la   $a0, starLine
    syscall
    jr   $ra

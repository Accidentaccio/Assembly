# Author: Davide Caruso

# Traccia: utilizzare il bubblesort per ordinare una stringa acquisita da tastiera.

.data
input: .asciz "Inserisci una stringa: "
str: .space 256
strprova: .space 256
output: .asciz "La stringa ordinata è: "

.text
.globl main

main: 
	la a0, input
	li a7, 4
	ecall
	
	la a0, str
	li a1, 256
	li a7, 8
	ecall
	
	li s2, '\n'
	
	jal bubblesort	
	
	
	
	
	li a7, 10
	ecall
	
	
bubblesort:
	
	mv s0, a0
	# Se la stringa è vuota
	
loop:
	lbu t0, 0(s0)
	lbu t1, 1(s0)
	beq t1, s2, fineCicloInnestato
	
	bgt t0, t1, swap
continue:
	addi s0, s0, 1
	j loop
	
fineCicloInnestato:
	addi a0, a0, 1
	lbu t0, 0(a0)
	beq t0, s2, exit
	la s0, str
	j loop
	
swap:
	sb t0, 1(s0)
	sb t1, 0(s0)
	j continue
	
exit:
	la a0, str
	li a7, 4
	ecall
	
	jr ra
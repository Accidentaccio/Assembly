# Author: Davide Caruso

# Traccia: acquire un array di interi e stamparlo a schermo.

.data
input: .asciz "Quanti interi vuoi inserire? (da 0 a 20): "
intero: .asciz "Inserisci un intero: "
output: .asciz "L'array è: "
separatore: .asciz " "
array: .word 20 

.text
.globl main
main:
	
	
	la a0, input
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv t1, a0
	
	
	jal readArray # In a0 viene restituito l'array
	jal printArray
	
	li a7, 10
	ecall
	 
	  
	  
readArray:
	
	la t3, array
	mv t0, a0
	
loop_read:
	
	beqz t0, exit_read
	addi t0, t0, -1
	
	la a0, intero
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	sw a0, 0(t3)
	addi t3, t3, 4
	
	j loop_read
	
exit_read:
	la a0, array
	jr ra
	

printArray:
	
	mv t3, a0
	la a0, output
	li a7, 4
	ecall
	
loop_print:
	
	beqz t1, exit_print
	addi t1, t1, -1
	
	lw a0, 0(t3)
	addi t3, t3, 4
	
	li a7, 1
	ecall
	
	la a0, separatore
	li a7, 4
	ecall
	
	j loop_print
	
exit_print:
	jr ra
	
	
	
	
	

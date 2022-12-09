# Author: Davide Caruso

# Traccia: Acquisire una stringa da tastiera e stampare le singole parole a rovescio

.data
input: .asciz "Inserisci una stringa: "
output: .asciz "Il risultato è: "
str: .space 200

.text
.globl main
main:

	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco la stringa allocando lo spazio necessario
	la a0, str
	li a1, 200
	li a7, 8
	ecall
	
	li s0, '\n'
	li s1, ' '
	
	la a1, str
	jal stampaARovescio
	
	li a7, 10
	ecall
	
stampaARovescio:

	
	lbu t0, 0(a1)
	addi a1, a1, 1
	beq t0, s0, giraParola
	beq t0, s1, giraParola
	
	addi sp, sp, -4
	sb t0, 0(sp)
	addi t1, t1, 1
	
	
	
	j stampaARovescio
	
	
giraParola:
	
	beqz t1, separatore
	addi t1, t1, -1
	lb a0, 0(sp)
	
	li a7, 11
	ecall
	
	addi sp, sp, 4
	j giraParola
	
separatore:
	
	beq t0, s0, exit
	
	li a0, ' '
	li a7, 11
	ecall
	
	li t1, 0
	j stampaARovescio
	
	
exit:
	jr ra
	
	
	
# Author: Davide Caruso

# Traccia: L'utente inserisce una stringa da tastiera. Il programma la capovolge e la stampa a schermo.

.data
str: .space 100
input: .asciz "Inserisci una stringa: "

.text
.globl main

main:
	
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Carico in a0 l'indirizzo di "str", alloco lo spazio da poter utilizzare in a1 e prelevo da tastiera la stringa	
	la a0, str
	li a1, 100
	li a7, 8
	ecall
	
	# Carico in s2 il newline, che servirà successivamente
	li s2, '\n'
		
stack:
	
	# Prelevo il primo carattere della stringa
	lbu t0, 0(a0)
	
	# Verifico che non sia il newline o il terminatore
	beq t0, s2, stampaCaratteri
	beqz t0, stampaCaratteri
	
	# Alloco lo spazio nello stack, salvo il carattere e faccio avanzare il puntatore sulla stringa
	addi sp, sp, -4
	sb t0, 0(sp)
	addi a0, a0, 1
		
	# t1 variabile di conteggio del numero di caratteri della stringa
	addi t1, t1, 1
	
	# Loop
	j stack

stampaCaratteri:
	
	# La stampa viene interrotta solo quando la variabile di conteggio è azzerata
	beqz t1, exit
	addi t1, t1, -1
	
	# Prelevo dallo stack un carattere, lo stampo e avanzo nello stack	
	lbu a0, 0(sp)
	addi sp, sp, 4
	
	li a7, 11
	ecall
	
	# Loop
	j stampaCaratteri
	
exit:
	
	# Chiusura del programma
	li a7, 10
	ecall
	
	
	
	

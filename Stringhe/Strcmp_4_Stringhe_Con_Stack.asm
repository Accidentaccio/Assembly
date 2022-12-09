# Author: Davide Caruso

# Traccia: allocare in area stack 4 stringhe e stampare a schermo la più piccola e la più grande (con una funzione di strcmp)

.data
input1: .asciz "Inserisci la prima stringa: "
input2: .asciz "Inserisci la seconda stringa: "
input3: .asciz "Inserisci la terza stringa: "
input4: .asciz "Inserisci la quarta stringa: "
output_min: .asciz "La stringa minima è: "
output_max: .asciz "La stringa massima è: "

.text
.globl main
main:
	
	# Acquisisco le 4 stringhe direttamente nello stack, prevedendo per ognuna 25 caratteri, terminatore incluso.
	# Quindi alloco nello stack lo spazio per tutte e 4
	addi sp, sp, -100
	
	# Stampo a schermo la stringa "input"
	la a0, input1
	li a7, 4
	ecall
	
	# Muovo il puntatore dello stack in a0 per acquisire direttamente
	mv a0, sp
	li a1, 24
	li a7, 8
	ecall
	
	# Procendo chiedendo la seconda stringa
	la a0, input2
	li a7, 4
	ecall
	
	# Stesso ragionamento di prima, ma utilizzo la funzione "addi" dal momento che la seconda stringa deve essere presa 25 posizioni dopo
	addi a0, sp, 25
	li a1, 24
	li a7, 8
	ecall
	
	# Procedo in maniera uguale, andando ogni volta ad aumentare il numero addizionato al registro sp di 25 per volta (0, 25, 50, 75)
	la a0, input3
	li a7, 4
	ecall
	
	addi a0, sp, 50
	li a1, 24
	li a7, 8
	ecall
	
	la a0, input4
	li a7, 4
	ecall
	
	addi a0, sp, 75
	li a1, 24
	li a7, 8
	ecall
		
	
	# Fine acquisizione stringhe
	
	# Due funzioni con scambio dei parametri per poter individuare la stringa minore e maggiore
	jal first_String
	jal last_String
	
	# Chiusura del programma
	li a7, 10
	ecall
	


first_String:

	# Salvo nei registri s0 ed s1 i puntatori alla testa delle prime due stringhe (perchè la strcmp che ho scritto lavora su due registri e non direttamente sullo stack)
	mv s0, sp
	addi s1, sp, 25
	
	# Salvo anche il valore di ra per non perdere il riferimento alla funzione chiamante
	mv t6, ra
	
	# Calcolo la minore tra le due (il risultato verrà messo in a0)
	jal inizio_strcmp
	
	# Sposto in s0 la minore tra le due analizzate precedentemente, e carico in s1 la terza stringa
	mv s0, a0
	addi s1, sp, 50
	
	# Confronto
	jal inizio_strcmp
	
	# La minore sempre in s0, e la quarta stringa in s1
	mv s0, a0
	addi s1, sp, 75
	
	# Confronto
	jal inizio_strcmp
	
	# In a0 a questo punto c'è la minima, la stampo a schermo
	li a7, 4
	ecall
	
	# Torno al chiamante con il registro ricaricato in ra
	mv ra, t6
	jr ra
	

last_String:

	# Il ragionamento è lo stesso per la stringa minore, ovviamentte la differenza è che in a0 verranno salvate le stringhe maggiori.
	mv s0, sp
	addi s1, sp, 25
	
	mv t6, ra
	
	jal inizio_strcmpMax
	
	mv s0, a0
	addi s1, sp, 50
	
	jal inizio_strcmpMax
	
	mv s0, a0
	addi s1, sp, 75
	
	jal inizio_strcmpMax
	
	# In a0 c'è la massima
	
	li a7, 4
	ecall
	
	mv ra, t6
	jr ra
	
	

inizio_strcmp:
	
	# Funzione di strcmp. Salvo in s2 e s3 i puntatori alla testa delle stringhe (perchè avanzando con s0 e s1 poi perdo i riferimenti)
	mv s2, s0
	mv s3, s1
	
strcmp:
	# Le due stringhe da comparare devono essere in s0 e s1.
	# Il newline deve essere in s2
	# Lo strcmp è analizzato bene in un altro file, qui non la ricommento.
	
	lbu t0, 0(s0)
	addi s0, s0, 1
	lbu t1, 0(s1)
	addi s1, s1, 1
	
	bgt t0, t1, primaMaggiore
	blt t0, t1, primaMinore
	
	beq t0, s2, stringheUguali
	
	j strcmp
	
	
primaMaggiore:
	# Sposto in a0 il puntatore alla testa della seconda stringa
	mv a0, s3	
	jr ra

primaMinore:
	# Sposto in a0 il puntatore alla testa della prima stringa
	mv a0, s2
	jr ra
	
stringheUguali:
	# Sposto in a0 il puntatore alla testa di una delle due stringhe, tanto sono uguali
	mv a0, s3	
	jr ra
	
	
	
	
	
	
# Funzione identica all'altra ma restituisce la maggiore	
inizio_strcmpMax:

	mv s2, s0
	mv s3, s1
	
strcmpMax:
	# Le due stringhe da comparare devono essere in s0 e s1.
	# Il newline deve essere in s2
	
	lbu t0, 0(s0)
	addi s0, s0, 1
	lbu t1, 0(s1)
	addi s1, s1, 1
	
	bgt t0, t1, primaMaggioreMax
	blt t0, t1, primaMinoreMax
	
	beq t0, s2, stringheUgualiMax
	
	j strcmpMax
	
	
primaMaggioreMax:
	mv a0, s2	
	jr ra

primaMinoreMax:
	
	mv a0, s3
	jr ra
	
stringheUgualiMax:
	
	mv a0, s2	
	jr ra

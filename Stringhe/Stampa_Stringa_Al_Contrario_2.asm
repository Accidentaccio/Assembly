# Author: Davide Caruso

# Traccia: L'utente inserisce una stringa da tastiera. Il programma la capovolge e la stampa a schermo.
# Note: A differenza della soluzione precedente, in cui vado a stampare a schermo carattere per carattere, in questo programma salvo la stringa capovolta in un registro e la stampo tutta insieme.

.data
str: .space 100
str_girata: .space 100
input: .asciz "Inserisci una stringa: "
output: .asciz "La stringa al contrario è: "

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
	
	jal shiftaRegistro
	
	# Sposto momentaneamente il risultato in a1
	mv a1, a0
	# Stampo a schermo la stringa "output"
	la a0, output
	li a7, 4
	ecall
	
	# Stampo a schermo il risultato
	mv a0, a1
	li a7, 4
	ecall
	
	# Chiudo il programma
	li a7, 10
	ecall
	
shiftaRegistro:
	# Sposto la stringa acquisita in a2, solo per comodità, visto che a0 è continuamente utilizzato per qualsiasi cosa
	mv a2, a0

stack:
	
	# Prelevo il primo carattere della stringa
	lbu t0, 0(a2)
	
	# Verifico che non sia il newline o il terminatore
	beq t0, t2, puntaStringaDiOutput
	beqz t0, puntaStringaDiOutput
	
	# Alloco lo spazio nello stack, salvo il carattere e faccio avanzare il puntatore sulla stringa
	addi sp, sp, -4
	addi a2, a2, 1
	sb t0, 0(sp)
	
	# t1 variabile di conteggio del numero di caratteri della stringa
	addi t1, t1, 1
	
	# Loop
	j stack
	
puntaStringaDiOutput:
	
	# A differenza di prima, salvo il risultato in un registro. Quindi carico in a2 la stringa in cui salvare il risultato e alloco lo spazio per poterlo fare
	la a2, str_girata
	li a1, 100

creaStringa:

	# Termino solo quando la variabile di conteggio è azzerata
	beqz t1, exit
	addi t1, t1, -1
			
	# Prelevo i caratteri dallo stack e li inserisco nella nuova stringa
	lbu t0, 0(sp)
	sb t0, 0(a2)
	
	# Facendo avanzare simultaneamente i puntatori sia dello stack che della stringa
	addi sp, sp, 4
	addi a2, a2, 1
	
	# Loop
	j creaStringa
	
exit:
	# Prima di terminare, inserisco il terminatore alla fine della stringa (altrimenti non è possibile stamparla)
	sb zero, 0(a2)
	# Carico in a0 il puntatore alla testa della stringa
	la a0, str_girata
	
	# Torno il risultato al chiamante
	jr ra
	

	
	
	
	

# Author: Daviode Caruso

# Traccia: Acquisire una stringa da tastiera. Il programma la ristampa in Upper Case.

.data
input: .asciz "Inserisci una stringa da trasformare in upper case: "
output: .asciz "La stringa in upperCase è: "
str: .space 100
strUpper: .space 100

.text
.globl main
main:
	
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco la stringa da tastiera preallocando lo spazio necessario
	la a0, str
	li a1, 100
	li a7, 8
	ecall
	
	# Carico in tre registri il newline, e la prima e l'ultima lettera dell'alfabeto minuscole (utili per effettuare confronti tra caratteri ASCII)
	li t2, '\n'
	li t3, 'a'
	li t4, 'z'
	
	# Funzione
	jal shiftaRegistro
	
	# Sposto in a1 per poter utilizzare a0
	mv a1, a0
	
	# Stampo a schermo la stringa "output"
	la a0, output
	li a7, 4
	ecall
	
	# Risposto in a0 il risultato e lo stampo
	mv a0, a1
	li a7, 4
	ecall
	
	# Chiudo il programma
	li a7, 10
	ecall
	
shiftaRegistro:

	# Sposto in a2 la stringa da rendere upperCase
	mv a2, a0
	# In a3 salverò la stringa in upperCasem quindi prealloco lo spazio (lo stesso della stringa in a2)
	la a3, strUpper
	li a1, 100
	
toUpperCase:
	
	# Prelevo il primo carattere della stringa minuscola
	lbu t0, 0(a2)
	
	# Controllo che non sia terminata
	beq t0, t2, exit
	beqz t0, exit
	# Mi sposto in avanti per il prossimo carattere
	addi a2, a2, 1
	
	# Controllo che il carattere analizzato sia un carattere compreso tra a-z. Se non lo è, non ho bisogno di renderlo upperCase, quindi lo memorizzo tale e quale in a3
	blt t0, t3, storeInUpperCase
	bgt t0, t4, storeInUpperCase
	
	# Se invece lo è, devo prendere il corrispettivo maiuscolo, che nella tabella ASCII è a -32 posizioni dalla minuscola.
	addi t0, t0, -32
	
storeInUpperCase:
	
	# In entrambi i casi aggiungo il carattere alla stringa in a3, faccio avanzare il puntatore e ripeto il ciclo
	sb t0, 0(a3)
	addi a3, a3, 1
	
	j toUpperCase
	
exit:
	la a0, strUpper
	jr ra
	

	

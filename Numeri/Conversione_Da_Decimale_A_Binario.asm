# Author: Davide Caruso

# Traccia: L'utente inserisce un intero decimale da tastiera. Il programma ne effettua la conversione in binario e stampa il risultato a schermo

.data
input: .asciz "Inserisci un numero in decimale di cui vuoi effettuare la conversione in binario: "
output: .asciz "Il numero da te inserito in binario è: "

.text
.globl main
main:
	
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco l'intero da tastiera
	li a7, 5
	ecall
	
	# Carico nel registro t5 il numero 2, che servirà più volte successivamente
	li t5, 2
	# Sposto nel registro t0 il numero acquisito dall'utente
	mv t0, a0
	
conversione:

	# Condizione di uscita dal ciclo
	beqz t0, stampa	
	# In t1 metto il resto della divisione tra t0 e 2
	rem t1, t0, t5
	
	# Alloco spazio nello stack e inserisco via via i resti (utilizzo lo stack perchè i resti vanno presi al contrario)
	addi sp, sp, -4
	sb t1, 0(sp)
	
	# Divido il numero per 2
	div t0, t0, t5
	
	# Uso t4 come variabile di conteggio, per sapere durante la fase di stampa quante cifre stampare
	addi t4, t4, 1
	
	# Loop
	j conversione
	
stampa:	
	
	# La fase di stampa termina quando si azzera la variabile di conteggio
	beqz t4, exit
	addi t4, t4, -1
	
	# Prelevo dallo stack la cifra e la stampo a schermo
	lb a0, 0(sp)
	li a7, 1
	ecall
	
	# Prossima cifra nello stack
	addi sp, sp, 4
	
	# Loop
	j stampa
	
	
exit:

	# Chiusura del programma
	li a7, 10
	ecall

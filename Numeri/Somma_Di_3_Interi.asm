# Author: Davide Caruso

# Traccia: L'utente inserisce tre interi da tastiera. Il programma ne effettua la somma e stampa il risultato a schermo
.data
start: .asciz "Inserisci tre numeri uno alla volta: "
end: .asciz "La somma è: "

.text
.globl main
main: 

	# Stampo a schermo la stringa "input"
	la  a0, start
	li  a7, 4
	ecall

	# Acquisisco il primo intero da tastiera e lo sposto in t0
	li  a7, 5
	ecall
	mv  t0, a0
	
	# Acquisisco il secondo da tastiera e lo sposto in t1
	li  a7, 5
	ecall
	mv  t1,a0
	
	# Acquisisco il terzo da tastiera e lo sposto in t2
	li  a7,5
	ecall
	mv  t2,a0
	
	# Effettuo la somma
	add  t0, t0, t1
	add  t0, t0, t2

	# Stampo a schermo la stringa "output"
	la  a0, end
	li  a7, 4
	ecall

	# Stampo a schermo il risultato
	mv  a0, t0
	li  a7, 1
	ecall
	
	# Chiusura del programma
	li a7, 10
	ecall

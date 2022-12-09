# Author: Davide Caruso

# Traccia: L'utente inserisce N interi da tastiera. Il programma ne effettua la somma e stampa il risultato a schermo

.data
input: .asciz "Inserisci il numero di interi da sommare: "
addendo: .asciz "Inserisci un addendo: "
output: .asciz "La somma è: "

.text
.globl main
main:

	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco il numero di interi da sommare da tastiera e lo sposto in t0
	li a7, 5
	ecall
	mv t0, a0
	
	# Effettuo la somma
	jal somma
		
	# Stampa del risultato e chiusura del programma
	j end
	
	
somma:

	# Condizione di uscita, uso t0 (il numero di interi da sommmare) come variabile di conteggio
	beqz t0, return
	
	# Stampo a schermo la stringa "addendo"
	la a0, addendo
	li a7, 4
	ecall
	
	# Acquisisco l'intero da tastiera
	li a7, 5
	ecall
	
	# Lo sommo ai precedenti in t1
	add t1, t1, a0
	
	# Decremento la variabile di conteggio
	addi t0, t0, -1
	
	# Loop
	j somma
	
return:

	# Sposto in a0 il risultato per poterlo restituire al chiamante
	mv a0, t1
	jr ra
	
end:

	# Stampo a schermo la stringa "output"
	la a0, output
	li a7, 4
	ecall
	
	# Stampo a schermo il risultato
	mv a0, t1
	li a7, 1
	ecall
	
	# Chiusura del programma	
	li a7, 10
	ecall

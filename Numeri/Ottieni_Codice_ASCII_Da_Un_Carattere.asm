.data
codice: .asciz "Il codice ASCII è: "
divisione: .asciz "\nIl risultato della divisione è: "
.text
.globl main
main:

	# Per ottenere il codice ASCII di un carattere basta trattarlo come un intero. Quindi stamparlo come un intero, o dividerlo per un numero significa lavorare con il codice ASCII e non con il carattere.

	li s0, 'c'
	
	la a0, codice
	li a7, 4
	ecall
	
	mv a0, s0
	li a7, 1
	ecall
	
	# Carico il 9 in t1
	li t0, 9
	
	# Divido il codice ASCII per 9
	div a0, a0, t0
	
	mv s0, a0
	la a0, divisione
	li a7, 4
	ecall
	
	
	mv a0, s0
	# Stampo il risultato
	li a7, 1
	ecall
	
	li a7, 10
	ecall

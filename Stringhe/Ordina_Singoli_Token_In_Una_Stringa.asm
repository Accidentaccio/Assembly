# Author: Davide Caruso

# Traccia: acquisire una stringa da tastiera. Ordinare i singoli token ignorando gli spazi bianchi ripetuti.

.data
input: .asciz "Inserisci una stringa: "
output: .asciz "La stringa risultante è: "
str: .space 256
whiteSpace: .asciz " "

.text
.globl main
main:

	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco la stringa da tastiera
	la a0, str
	li a1, 256
	li a7, 8
	ecall
	
	# La sposto in s0
	mv s0, a0
	
	# Chiamo la funzione
	jal funzione
	
	# Chiusura del programma
	li a7, 10
	ecall
	
	
########### Divisione in token #############
	
funzione:
	# Inizio della funzione, semplicemente alloco spazio nello stack e muovo a0 sull'inizio dello stack
	li s1, ' '
	li s2, '\n'
	addi sp, sp, -256
	mv a0, sp
	
ordinaToken:
	# Analizzo carattere per carattere.
	lbu t0, 0(s0)
	# Utilizzo la verifica sul terminatore di stringa perchè il newline in questo caso mi è utile, vedi prossimo commento
	beqz t0, exit
	# Nel caso del newline è necessario ordinare tutto quello che è venuto prima del newline, non posso semplicemente interrompere
	beq t0, s2, sort
	
	# Nel caso in cui il carattere prelevato non sia uno spazio bianco, lo inserisco nello stack
	bne t0, s1, insert
	
	# Altrimenti il token è finito e passo ad ordinare
	j sort
	
continue:
	# Sia che venga o meno fatto l'ordinamento del token è necessario analizare il prossimo carattere
	addi s0, s0, 1
	j ordinaToken
	

insert:
	# Inserimento nello stack (lo faccio tramite il puntatore allo stack a0)
	sb t0, 0(a0)
	addi a0, a0, 1
	
	# t1 lo utilizzo un po'come se fosse una variabile booleana. Quando inserisco almeno un carattere nello stack lo porto ad 1, segno che c'è qualcosa da ordinare.
	li t1, 1
	j continue

exit:
	jr ra
	
########### Fine divisione in token #############
	
	
	
	
sort:
	# Prima di passare ad ordinare, nella stringa inserisco il terminatore utile per capire quando fermarmi con l'ordinamento
	sb zero, 0(a0)
	# Effettuo la verifica su t1. Se è 0 non c'è niente da ordinare e vado avanti
	beqz t1, continue
	
	# Utilizzo due puntatori alla stringa da ordinare (classico del bubblesort)
	mv t6, sp
	mv a0, sp
	
	# Non commento dettagliatamente in quanto il codice è già commentato nel file del bubblesort
bubbleSort:
	lbu t0, 0(t6)
	lbu t1, 1(t6)
	beqz t1, fineCicloInnestato
	
	bgt t0, t1, swap
continueSort:
	addi t6, t6, 1
	j bubbleSort
	
fineCicloInnestato:
	mv t6, sp
	addi a0, a0, 1
	lbu t0, 0(a0)
	beqz t0, print
	j bubbleSort
	
swap:
	sb t0, 1(t6)
	sb t1, 0(t6)
	j continueSort
	

print:
	# L'unica differenza è nella funzione di uscita. Qui devo stampare. Quindi riporto il puntatore a0 in testa allo stack e stampo la stringa (alla cui fine c'è sempre il terminatore che ho inserito a mano)
	mv a0, sp
	li a7, 4
	ecall
	
	# Dealloco spazio dallo stack (per cancellare il tutto)
	addi sp, sp, 256
	# Riporto a 0 la mia variabile "booleana"
	li t1, 0
	
	# Stampo lo spazio bianco
	la a0, whiteSpace
	li a7, 4
	ecall
		
	# Vado avanti nella stringa e torno all'inizio
	addi s0, s0, 1
	j funzione
	
	
	
	
	

# Author: Davide Caruso

# Traccia: Acquisire da tastiera due numeri binari. Il programma ne esegue la somma e stampa il risultato

.data
input: .asciz "Inserisci il primo numero binario: "
input2: .asciz "Inserisci il secondo numero binario: "
output: .asciz "Il risultato è: "

.text
.globl main
	
main:
	
	
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco il primo binario (preso come un intero decimale) e lo sposto in s0
	li a7, 5
	ecall
	mv s0, a0
	
	# Stampo a schermo la stringa "input2"
	la a0, input2
	li a7, 4
	ecall
	
	# Acquisisco il secondo binario (preso come un intero decimale) e lo sposto in s1
	li a7, 5
	ecall
	mv s1, a0
	
	jal somma
	
	# Sposto in t0 il risultato (poichè a0 mi serve per stampare a schermo)
	mv t0, a0
	
	# Stampo a schermo la stringa "output"
	la a0, output
	li a7, 4
	ecall
	
	# Risposto il risultato in a0 e lo stampo
	mv a0, t0
	li a7, 1
	ecall
	
	# Chiudo il programma
	li a7, 10
	ecall
	

somma:
	
	# Salvo l'indirizzo del chiamante nello stack(dovendo eseguire più chiamate di funzioni non voglio perdere il riferimento al chiamante)
	addi sp, sp, -4
	sw ra, 0(sp)
	
	# Sposto il primo binario in a1 a cui applico la funzione
	mv a1, s0
	jal convertToBase10
		
	# Sposto il risultato della conversione nuovamente in s0
	mv s0, a1
	
	# Eseguo le stesse operazioni per il secondo binario
	mv a1, s1
	jal convertToBase10
	mv s1, a1
	
	# Li sommo in a0
	add a0, s0, s1
	
	# Riconverto in binario
	#jal convertToBase2
	
	# Torno al chiamante (riprendendo l'indirizzo dallo stack)
	
	lw ra, 0(sp)
	addi sp, sp, 4
	jr ra
	
	
	
convertToBase10:
	
	# Carico il 10 nel registro s0 e 2 nel registro t6
	li t5, 10
	li t6, 2
	
	# Azzero i registri (operazione utile perchè effettuo due volte la conversione)
	li t3, 0
	# Uso a0 come contatore dell'esponenziale da calcolare
	li a0, 0
	
	# Salvo il valore di ra
	addi sp, sp, -4
	sw ra, 0(sp)
	
loop10:
	
	# Prendo l'ultima cifra a destra del numero binario mediante resto della divisione per 10
	rem t0, a1, t5	
	
	# Calcolo il risultato della potenza di 2, che ha come esponente la variabile di conteggio a0. Il risultato viene messo in t6
	jal exp2
	
	# In t1 salvo il risultato della moltiplicazione tra la cifra in t0 e il valore dell'esponenziale di 2 in t6
	mul t1, t0, t6
		
	# Aggiungo il risultato parziale a t3
	add t3, t3, t1	
	
	# Divido il numero per 10
	div a1, a1, t5
	
	# Controllo che il numero abbia ancora più di una cifra, viceversa la conversione è terminata
	beqz a1, exitConversion10
			
	# Incremento la variabile di conteggio e passo il risultato in a0
	addi a0, a0, 1
		
	j loop10
	
	
exitConversion10:

	# Passo il risultato della conversione in a1
	mv a1, t3
	
	# Torno al chiamante caricando l'indirizzo dallo stack
	lw ra, 0(sp)
	addi sp, sp, 4
	jr ra
		
	
	
exp2:

	# In a0 è presente l'esponente

	# Carico 1 nel registro t6 (e non 0 perchè sennò si annullano tutte le moltiplicazioni)
	li t6, 1
	# Per non modificare la variabile di conteggio a0 ne faccio una copia in s6 e lavoro con quella
	mv s6, a0
	
loopExp2:
	
	# Continuo a moltiplicare t6 per 2 fino a che il valore di s6 (esponente) è maggiore di 0
	beqz s6, exitExp2
	mul t6, t6, t6
	
	addi s6, s6, -1
	
	j loopExp2
	
exitExp2:
	# Risultato in t6
	jr ra
	
	

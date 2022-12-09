# Author: Davide Caruso

# Traccia: Acquisire una stringa da tastiera. Stampare il numero di caratteri che la compongono. Distinguere caso con newline e senza.

.data
input: .asciz "Inserisci una stringa: "
str: .space 200
output1: .asciz "Il numero di caratteri ESCLUSO il newline è: "
output2:  .asciz "\nIl numero di caratteri INCLUSO il newline è: "

.text
.globl main
main:
	
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco la stringa da tastiera allocando lo spazio necessario
	la a0, str
	li a1, 200
	li a7, 8
	ecall
	
	# Costante
	li s0, '\n'
		
	jal contaCaratteri # Il risultato lo inserisco nel registro t1
	
	# Stampo a schermo la stringa "output1"
	la a0, output1
	li a7, 4
	ecall
	
	# Stampo il numero di caratteri escluso il newline
	mv a0, t1
	li a7, 1
	ecall
	
	
	# Stampo a schermo la stringa "output2"
	la a0, output2
	li a7, 4
	ecall
	
	# Stampo il numero di caratteri incluso il newline
	addi a0, t1, 1
	li a7, 1
	ecall
	
	# Chiusura programa
	li a7, 10
	ecall
	
	
contaCaratteri:
	
	# Prendo un carattere dalla stringa
	lbu t0, 0(a0)
	
	# Avanzo con il puntatore
	addi a0, a0, 1
		
	# Controllo se è il newline, se lo è il conteoggio è terminato
	beq t0, s0, exit
	
	# Incremento t1, che uso come variabile di conteggio
	addi t1, t1, 1
	
	# Loop
	j contaCaratteri
	
	
exit:
	# Torno al chiamante
	jr ra
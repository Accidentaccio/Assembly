#Author: Davide Caruso
.data
input: .asciz "Inserisci un intero: "
whiteSpace: .asciz " "

.text
.globl main

main:
	
	# Stampo "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco l'intero
	li a7, 5
	ecall
	
	# Salvo due "costanti"
	li t1, 10
	li t2, 2
	
	# Salvo una copia di backup
	mv a1, a0
	
	# Delego il compito
	jal isolaCifra
	
	# Chiudo il programma
	li a7, 10
	ecall
	

isolaCifra:
	
	# Prendo il resto e lo metto in t3
	rem t3, a1, t1
	
	# Inserisco in t4 il resto della cifra isolata diviso 2
	rem t4, t3, t2
	
	# Se il resto è 1, e cioè la cifra analizzata è dispari
	bnez t4, print
# Altrimenti continuo
continue:
	# Divido per 10
	div a1, a1, t1
	
	# Se ho analizzato tutte le cifre del numero vado a "exit"
	beqz a1, exit
	
	j isolaCifra
	
exit:
	# Torno al chiamante
	jr ra
	
print:
	# Stampo la cifra dispari
	mv a0, t3
	li a7, 1
	ecall
	# Stampo uno spazio bianco
	la a0, whiteSpace
	li a7, 4
	ecall
	# Continuo a isolare cifre
	j continue

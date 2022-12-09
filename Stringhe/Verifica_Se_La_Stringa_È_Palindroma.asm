# Author: Davide Caruso

# Traccia: Acquisire una stringa da tastiera e verificare che sia palindroma

.data
input: .asciz "Inserisci una stringa: "
str: .space 200
output_true: .asciz "La stringa che hai inserito è palindroma."
output_false: .asciz "La stringa che hai inserito NON è palindroma."

.text
.globl main
main:
	# Stampo a schermo la stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisisco la stringa preallocando lo spazio necessario
	la a0, str
	li a1, 200
	li a7, 8
	ecall
	
	# carico in so il newline e chiamo la funzione
	li s0, '\n'
	jal putOnStack
	
	# Chiusura del programma
	li a7, 10
	ecall
	
# Per verificare che la stringa la inserisco nello stack e confronto la parola girata con quella originale
putOnStack:
	
	# Carico il primo carattere della stringa in t0
	lbu t0, 0(a0)
	# Se è il newline passo direttamente a confrontare le due stringhe
	beq t0, s0, verificaPalindroma
	# Altrimenti incremento il puntatore alla stringa e continuo a inserire i caratteri nello stack
	addi a0, a0, 1
	
	addi sp, sp, -4
	sb t0, 0(sp)
	
	# t1 variabile di conteggio
	addi t1, t1, 1
	
	# Loop
	j putOnStack
	
verificaPalindroma:
	# Uso questa etichetta intermedia solo per caricare in a0 il puntatore alla testa della stringa (che prima avevo spostato)
	# per caricare i caratteri nello stack
	la a0, str
	
continue:
	# Smetto di fare i confronti quando la variabile di conteggio è azzerata. Se smetto di fare confronti è perchè
	# i caratteri sono tutti uguali. Infatti, nel momento in cui trovo una coppia di caratteri differenti
	# posso immediatamente dire che la stringa non è palindroma
	beqz t1, palindroma_true
	addi t1, t1, -1
	# Prendo uno alla volta i caratteri dello stack e della stringa e li confronto
	lbu t0, 0(a0)
	lbu t2, 0(sp)
	addi a0, a0, 1
	addi sp, sp, 4
	# Se sono uguali continuo il confronto
	beq t0, t2, continue
	
	# Se non lo sono si entra nell'etichetta qui sotto
	
palindroma_false:
	# Se arriva qui non è palindroma, quindi lo stampo a schermo e torno al chiamante
	la a0, output_false
	li a7, 4
	ecall
	
	jr ra
	
palindroma_true:
	# Stampo a schermo e torno al chiamante
	la a0, output_true
	li a7, 4
	ecall
	
	jr ra

	
	
	
	
	
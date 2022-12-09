# Author: Davide Caruso

# Traccia: acquisire una stringa da tastiera. Stampare a schermo le consonanti doppie (senza fare distinzione tra maiuscole e minuscole).
# Le consonanti triple vanno stampate solo una volta. Le quadruple due e così via.

.data
str: .space 256
input: .asciz "Inserisci una stringa: "
output: .asciz "Le consonanti doppie sono: "
separatore: .asciz " "


.text
.globl main
main:
	# Stampa a schermo della stringa "input"
	la a0, input
	li a7, 4
	ecall
	
	# Acquisizione della stringa da tastiera
	la a0, str
	li a1, 256
	li a7, 8
	ecall
	
	# Sposto la stinga acquisita nel registro a2
	mv a2, a0
	# Salvo nei registri s una serie di caratteri costanti che mi serviranno
	li s0, 'a'
	li s1, 'z'
	li s2, 'A'
	li s3, 'Z'
	li s4, '\n'
	
	# Funzione con scambio di parametri
	jal trovaDoppie
	
	# Uscita
	li a7, 10
	ecall
	
	
trovaDoppie:
	# Prelevo il primo carattere dalla stringa
	lbu t0, 0(a2)
	# Se si tratta del newline la stringa è terminata, quindi esco dal programma.
	beq t0, s4, exit
	# Incremento il puntatore alla stringa
	addi a2, a2, 1
	
	# Verifico confrontando i caratteri ASCII se il carattere in questione è una lettera maiuscola o minuscola (perchè ad esempio potrebbe essere anche un carattere).
	# ATTENZIONE perchè i caratteri ASCII delle lettere piccole sono più grandi dei corrispetivi upper case. Bisogna tenerne conto. Questo è il motivo per cui
	# effettuo il controllo prima sulle piccole. 
	bge t0, s0, possibileConsonantePiccola
	bge t0, s2, possibileConsonanteGrande
	
	# Se è un carattere i due branch sopra vengono skippati e semplicemente si passa al prossimo carattere
	j trovaDoppie
	
consonantePiccola:
	
	# Prelevo il carattere successivo a quello analizzato (poichè il puntatore di a2 già è stato incrementato), controllo sempre che non sia il newline.
	lbu t1, 0(a2)
	beq t1, s4, exit
	# Ora confronto i due caratteri. Se sono uguali, o se il primo è uguale al secondo in upper case allora lo stampo a schermo. Viceversa si procede con i prossimi caratteri.
	beq t0, t1, print
	addi t1, t1, +32
	beq t0, t1, print
	
	j trovaDoppie
	
consonanteGrande:
	
	# Prelevo il carattere successivo a quello analizzato (poichè il puntatore di a2 già è stato incrementato), controllo sempre che non sia il newline.
	lbu t1, 0(a2)
	beq t1, s4, exit
	# Ora confronto i due caratteri. Se sono uguali, o se il primo è uguale al secondo in lower case allora lo stampo a schermo. Viceversa si procede con i prossimi caratteri.
	beq t0, t1, print
	addi t1, t1, -32
	beq t0, t1, print
	
	j trovaDoppie
	

possibileConsonantePiccola:
	
	# Quando si entra in questo branch è perchè un carattere potrebbe potenzialmente essere una lettera piccola, ovvero maggiore del carattere 'a'.
	# Qui controllo che sia anche minore di 'z', viceversa skippo
	bgt t0, s1, trovaDoppie
	
	# A questo punto sappiamo che è una lettera piccola, quindi controllo che non sia una vocale
	li t6, 'a'
	beq t0, t6, trovaDoppie
	
	li t6, 'e'
	beq t0, t6, trovaDoppie
	
	li t6, 'i'
	beq t0, t6, trovaDoppie
	
	li t6, 'o'
	beq t0, t6, trovaDoppie
	
	li t6, 'u'
	beq t0, t6, trovaDoppie
	
	# Se il programma skippa tutti i branch di sopra, allora è una consonante piccola, e analizzo questo particolare caso
	j consonantePiccola
	
possibileConsonanteGrande:

	# Quando si entra in questo branch è perchè un carattere potrebbe potenzialmente essere una lettera grande, ovvero maggiore del carattere 'A'.
	# Qui controllo che sia anche minore di 'Z', viceversa skippo
	bgt t0, s3, trovaDoppie
	
	# A questo punto sappiamo che è una lettera grande
	li t6, 'A'
	beq t0, t6, trovaDoppie
	
	li t6, 'E'
	beq t0, t6, trovaDoppie
	
	li t6, 'I'
	beq t0, t6, trovaDoppie
	
	li t6, 'O'
	beq t0, t6, trovaDoppie
	
	li t6, 'U'
	beq t0, t6, trovaDoppie
	
	# Se il programma skippa tutti i branch di sopra, allora è una consonante grande, e analizzo questo particolare caso
	j consonanteGrande
	
	
print:
	# Carico il carattere da stampare in a0, lo stampo col separatore (un semplice spazio bianco, ma si potrebbe fare di meglio)
	mv a0, t0
	li a7, 11
	ecall
	
	la a0, separatore
	li a7, 4
	ecall
	
	# Incremento di nuovo il puntatore (per non stampare eventualmente delle triple)
	addi a2, a2, 1
	
	# Procedo con gli altri caratteri	
	j trovaDoppie
	
exit:
	# Torno al chiamante
	jr ra

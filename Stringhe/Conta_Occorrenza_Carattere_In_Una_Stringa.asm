.data
inputStringa: .asciz "Inserisci una stringa: "
inputOccorrenza: .asciz "Di quale carattere vuoi conoscere l'occorrenza?: "
output: .asciz "\nIl carattere è presente questo numero di volte: "

.text
.globl main
main:
	la a0, inputStringa
	li a7, 4
	ecall
	
	addi sp, sp, -256
	mv a0, sp
	li a1, 254
	li a7, 8
	ecall
	
	mv a2, a0
		
	la a0, inputOccorrenza
	li a7, 4
	ecall
	
	li a7, 12
	ecall
	
	mv a3, a0
	
	jal contaOccorrenze
	
	mv s0, a0
	la a0, output
	li a7, 4
	ecall
	
	mv a0, s0
	li a7, 1
	ecall
	
	li a7, 10
	ecall
	
	

contaOccorrenze:
	li t1, '\n'
	li a0, 0
loop:
	lbu t0, 0(a2)
	addi a2, a2, 1
	beq t0, t1, exit
	beq t0, a3, increment
	j loop
	
increment:
	addi a0, a0, 1
	j loop

exit:
	addi sp, sp, 256
	jr ra
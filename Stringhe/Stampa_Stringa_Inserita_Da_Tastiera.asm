.data

str: .space 100
input: .asciz "Inserisci una stringa: "
output: .asciz "La stringa che hai inserito è: "

.text
.globl main
main:
	la a0, input
	li a7, 4
	ecall
	
	la a0, str
	li a1, 100
	li a7, 8
	ecall
	
	mv a1, a0
	la a0, output
	li a7, 4
	ecall
	
	mv a0, a1
	li a7, 4
	ecall
		
	li a7, 10
	ecall
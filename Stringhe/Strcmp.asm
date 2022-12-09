.data
input1: .asciz "Inserisci la prima stringa: "
str1: .space 200
input2: .asciz "Inserisci la seconda stringa: "
str2: .space 200
output_prima: .asciz "La prima stringa è maggiore della seconda."
output_seconda: .asciz "La prima stringa è minore della seconda."
output_uguali: .asciz "La prima stringa è uguale alla seconda."

.text
.globl main
main:
	la a0, input1
	li a7, 4
	ecall
	
	la a0, str1
	li a1, 200
	li a7, 8
	ecall
	
	mv s0, a0
	
	la a0, input2
	li a7, 4
	ecall
	
	la a0, str2
	li a1, 200
	li a7, 8
	ecall
	
	mv s1, a0
	
	li s2, '\n'
	jal strcmp
	
	li a7, 10
	ecall
	
strcmp:
	
	lbu t0, 0(s0)
	addi s0, s0, 1
	lbu t1, 0(s1)
	addi s1, s1, 1
	
	bgt t0, t1, primaMaggiore
	blt t0, t1, primaMinore
	
	beq t0, s2, stringheUguali
	
	j strcmp
	
	
primaMaggiore:
	la a0, output_prima
	li a7, 4
	ecall
	
	jr ra

primaMinore:
	
	la a0, output_seconda
	li a7, 4
	ecall
	
	jr ra
	
stringheUguali:
	
	la a0, output_uguali
	li a7, 4
	ecall
	
	jr ra
	
	
	
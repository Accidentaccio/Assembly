.data
input1: .asciz "Inserisci la prima stringa: "
str1: .space 200
input2: .asciz "Inserisci la seconda stringa: "
str2: .space 200
output: .asciz "La stringa concatenata è: "
strfinal: .space 400

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
	la a2, strfinal
	
	jal strconcat
	
	li a7, 10
	ecall
	
	
strconcat:
	
	
	lbu t0, 0(s0)
	addi s0, s0, 1
	beq t0, s2, continue
	sb t0, 0(a2)
	addi a2, a2, 1
	
	j strconcat
	
continue:
	
	lbu t0, 0(s1)
	addi s1, s1, 1
	beq t0, s2, exit
	sb t0, 0(a2)
	addi a2, a2, 1
	j continue
	
exit:
	sb zero, 0(a2)
	
	la a0, output
	li a7, 4
	ecall
	
	la a0, strfinal
	li a7, 4
	ecall
	
	jr ra


.data
inputStringa: .asciz "Inserisci una stringa: "
output: .asciz "Le occorrenze sono:\n"
separatore: .asciz " "
newline: .asciz "\n"



.text
.globl main
main:
	la a0, inputStringa
	li a7, 4
	ecall
	
	addi sp, sp, -256
	mv a0, sp
	li a1, 255
	li a7, 8
	ecall
	
	jal sort
	
	
	mv s0, a0
	mv t0, a0
	la a0, output
	li a7, 4
	ecall
	
	mv a0, t0
	
	j printResult
	
close:
	
	li a7, 10
	ecall
	
	
printResult:

	
	li t2, '\n'
	li a2, 0
	
loop_print:
	lbu t0, 0(s0)
	beq t0, t2, close
	lbu t1, 1(s0)
	beq t1, t2, increment
	beq t0, t1, increment
	addi s0, s0, 1
	addi a2, a2, 1
	
print:
	mv a0, t0
	li a7, 11
	ecall
	
	la a0, separatore
	li a7, 4
	ecall
	
	mv a0, a2
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	j printResult
	
increment:
	addi a2, a2, 1
	addi s0, s0, 1
	j loop_print
	
		
	
sort:
	mv s0, a0
	mv s1, a0
	
	li t2, '\n'
	
loop:
	lbu t0, 0(s1)
	lbu t1, 1(s1)
	beq t1, t2, fineCicloInnestato
	bgt t0, t1, swap
continue:
	addi s1, s1, 1
	j loop
	
fineCicloInnestato:
	mv s1, a0
	addi s0, s0, 1
	lbu t0, 0(s0)
	beq t0, t2, exitSort
	j loop
	
swap:
	sb t0, 1(s1)
	sb t1, 0(s1)
	j continue
	
exitSort:
	jr ra
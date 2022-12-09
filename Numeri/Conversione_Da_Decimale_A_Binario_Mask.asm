.data
prompt: 		.asciz "Inserisci il numero decimale da convertire: "
prompt_out: 		.asciz "Il numero in binario è: "
str_bin:		.space 100

.text
.globl main 

main: 
	la a0, prompt
	li a7, 4 
	ecall 
	
	li a7, 5
	ecall 
	
	jal conversion 
	
	li a7, 4
	ecall
	
	li a7, 10
	ecall
	
conversion: 	
	mv t4, a0
	la a1, str_bin
	li t0, '0'
	li t1, '1'
	li t2, 0x80000000
	
loop:
	and t3, t4, t2
	beqz t3, load_zero
	
	sb t1, 0(a1)

continue: 
	srli t2, t2, 1
	addi a1, a1, 1
	beqz t2, exit
	j loop

load_zero: 
	sb t0, 0(a1)
	j continue


exit: 
	sb zero, 0(a1)
	
	la a0, prompt_out
	li a7, 4 
	ecall
	
	la a0, str_bin 
	
	jr ra
	
	
	

#Ho ten SV: Lam Minh Vinh , MSSV: 2120082
#De 3
#Viet chuong trinh mip phat sinh so decimal ngau nhien
# chuyen qua he binary và he hexadecimal sau do in ket qua 
#Data segment
	.data
#Cac cau nhac nhap du lieu
fileout: .asciiz "CHUOISO.txt" # filename for output
prompt: .asciiz "So phat sinh ngau nhien : "
he10: .asciiz "\nKet qua he 10: "
he16: .asciiz "\nKet qua he 16: "
he2: .asciiz "\nKet qua he 2: "

desc: .word 	0
result_bin: 	.asciiz "bbbbbbbbbbbbbbbb"
result_dec:	.asciiz "ddddd"
result_hex: 	.asciiz "hhhh"
#Code segment
	.text
	.globl main

main:
 
#so phat sinh ngau nhien tu 0 den 65355
	addi $v0, $zero, 30        # Syscall 30: System Time 
	syscall                  # $a0 will contain the 32 LS bits of the system time
	add $t0, $zero, $a0     # Save $a0 value in $t0 

	addi $v0, $zero, 40        # Syscall 40: Random seed
	add $a0, $zero, $zero   # Set RNG ID to 0
	add $a1, $zero, $t0     # Set Random seed to
	syscall

	addi $v0, $zero, 42        # Syscall 42: Random int range
	add $a0, $zero, $zero   # Set RNG ID to 0
	addi $a1, $zero, 65536    # Set upper bound to 65536
	syscall                  # Generate a random number and put it in $a0
	add $t1, $zero, $a0     # Copy the random number to $t1
	move $t8,$t1
#Nhap vao so decimal
	la $a0, prompt
	addi $v0, $zero, 4
	syscall

	addi $v0, $zero, 1    
	move $a0,$t1 
	syscall  
#mo file 
la $a0,fileout
addi $a1,$zero,1
addi $v0,$zero,13
syscall
sw $v0,desc


# xu ly
jal hexa # nhay den function hexa
move $t1,$t8 		
jal binary # nhay den function binary	
move $t1,$t8 	
#Decimal 5 chu so
 move	$a0, $t1		#truyen tham so, $a0 = $t1
la	$a1, result_dec		#truyen tham so, $a1 = result_dec
addi 	$a2, $zero, 5		#truyen tham so, $a2 = n = 5
jal	dec_to_str		#goi ham convert decimal to string
 
#ghi file
lw $a0,desc
la $a1,he10
addi $a2,$zero,15
addi $v0,$zero,15
syscall	

lw $a0,desc
la $a1,result_dec
addi $a2,$zero,5
addi $v0,$zero,15
syscall	


			
 # dong file
lw $a0,desc
addi $v0,$zero,16
syscall
 #ket thuc chuong trinh (syscall)
Kthuc:	addi	$v0,$zero,10
	syscall
.end main
 

################binary##############
.globl binary      #Function for binary
.ent binary
binary:	
#Xu ly
	li $s7, 16		 # counter
	la $s6, result_bin	# luu ket quaa
	sll $t1, $t1, 16
Loop_bin:

	beq $s7, $zero, Exit_bin	# re nhanh den exit if counter = 0
	rol $t1, $t1, 1		# xoay 1 bit ve ben trai
	and $s4, $t1, 0x1	# mask voi 0001
	addi $s4, $s4, 48	# su dung ma ascii
End_bin:

	sb $s4, 0($s6)		# luu tru hex digit vao ket qua
	addi $s6, $s6, 1	# tang dan bien dem dia chi
	addi $s7, $s7, -1	# giam dan bien dem counter

j Loop_bin

Exit_bin:
#Xuat ket qua
	la $a0, he2
	addi $v0, $zero, 4
	syscall
	
	la $a0, result_bin
	addi $v0, $zero, 4
	syscall
	
#ghi file
lw $a0,desc
la $a1,he2
addi $a2,$zero,15
addi $v0,$zero,15
syscall	

lw $a0,desc
la $a1,result_bin
addi $a2,$zero,16
addi $v0,$zero,15
syscall	

jr $ra
	
.end binary
 #############hexa##############
 .globl hexa      #Function for Sum
.ent hexa
hexa:
#Xu ly
	li $t0, 4		 # counter
	la $t3, result_hex		# luu ket qua
	sll $t1, $t1, 16
Loop_hex:

	beqz $t0, Exit_hex	# re nhanh den exit if counter = 0
	rol $t1, $t1, 4		# xoay 4 bits ve ben trai
	and $s4, $t1, 0xf	# mask with 1111
	ble $s4, 9, Sum_hex	# neu <= 9 , re nhanh label sum
	addi $s4, $s4, 55	# nguoc lai, them 55

	b End_hex

	Sum_hex:
		addi $s4, $s4, 48	# su dung ma ascii

End_hex:

	sb $s4, 0($t3)		# luu hex digit vao ket qua
	addi $t3, $t3, 1	# tang dan dia chi counter
	addi $t0, $t0, -1	# giam dan bien dem vong lap counter

j Loop_hex

Exit_hex:
#Xuat ket qua
	la $a0, he16
	addi $v0, $zero, 4
	syscall
	
	la $a0, result_hex
	addi $v0, $zero, 4
	syscall
#ghi file
lw $a0,desc
la $a1,he16
addi $a2,$zero,15
addi $v0,$zero,15
syscall	

lw $a0,desc
la $a1,result_hex
addi $a2,$zero,4
addi $v0,$zero,15
syscall	
 jr $ra
.end hexa

# function chuyen tu integer thanh string
#In: a0 = int, a1 = result_dec
#Out: result_dec = ddddd
#-------------------------------------
dec_to_str:
	addi 	$t0, $zero, 5		# counter
	add	$a1, $a1, $a2		
	subi	$a1, $a1, 1		# a1 = result_dec[4]
	addi	$s2, $zero, 10		# t2 = 10
Loop_str:
	beqz 	$t0, Exit_str		# branch to exit if counter is equal to zero
	divu 	$a0, $s2		# a0 / t2 
	mflo	$a0			# a0 = a0 / t2
	mfhi 	$s3        		# t3 = a0 % t2
	addi 	$s3, $s3, 48		# su dung ma ascii
End_str:
	sb 	$s3, 0($a1)		# luu tru hex digit vao ket qua
	subi 	$a1, $a1, 1		# tang dan bien dem dia chi  counter
	subi 	$t0, $t0, 1		# giam dan bien dem vong lap counter
j Loop_str

Exit_str:





	jr	$ra
#-------------------------------------

 
  

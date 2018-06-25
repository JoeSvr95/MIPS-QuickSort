particionar:
  sll $s0, $a2, 2 # dir * 4
  add $s0, $s0, $a0 # pega pos do vetor
  lw $s0, 0($s0)  # x == $s0
  subi $s1, $a1, 1  # i == $s1
  add $s2, $a1, $zero  # j == $s2
  for:
    slt $t1, $s2, $a2 # j < dir
    beq $t1, $zero, EXIT_FOR # se j nao for menor q dir
      sll $t1, $s2, 2 # j*4
      add $t1, $t1, $a0 # pega pos do vetor
      lw $t2, 0($t1) # t2 recebe vetor[j]
      slt $t2, $s0, $t2 # se x < t2
      bne $t2, $zero, EXIT_IF # se for menor sai
        addi $s1, $s1, 1 # i++
        # guarda a0, a1 e ra
        subi $sp, $sp, 12
        sw $a0, 0($sp)
        sw $a1, 4($sp)
        sw $ra, 8($sp)
        sll $t3, $s1, 2 #pega pos de vetor[i]
        add $t3, $t3, $a0 #pega pos de vetor[i]
        #la $a0, 0($t2)
        #la $a1, 0($t1)
        #Jal SWAP
        lw $t4, 0($t1)
        lw $t5, 0($t3)
        sw $t4, 0($t3)
        sw $t5, 0($t1)
        
        # restaura valores de a0, a1 e ra
        lw $a0, 0($sp)
        lw $a1, 4($sp)
        lw $ra, 8($sp)
        addi $sp, $sp, 12
    EXIT_IF:
    addi $s2, $s2, 1 #j++
    j FOR
  EXIT_FOR:
  # swap
  subi $sp, $sp, 12
  sw $a0, 0($sp)
  sw $a1, 4($sp)
  sw $ra, 8($sp)
  addi $t0, $s1, 1
  sll $t0, $t0, 2
  add $t0, $t0, $a0
  sll $t1, $a2, 2
  add $t1, $t1, $a0
  #la $a0, 0($t0)
  #la $a1, 0($t1)
  #Jal SWAP
  lw $t2, 0($t0)
  lw $t3, 0($t1)
  sw $t2, 0($t1)
  sw $t3, 0($t0)
  
  lw $a0, 0($sp)
  lw $a1, 4($sp)
  lw $ra, 8($sp)
  addi $sp, $sp, 12
  addi $v0, $s1, 1
  Jr $ra
  
  
  
##lo que yo tenia

	partition:
	
		add $sp, $sp, -4
		sw  $s0, 0($sp)
		addu $s4,$a0,$s4
		addiu $a1, $t2,-1 	#i = low -1 

		li 
		lw $t3, 0($t0)		#$t3 = arr[j]
		lw $t4, #high-1 	#$t4 = pivot =arr[high]
		ble $t3, $t4, L1
		addiu $a1,$a1,1 	#i++ 	
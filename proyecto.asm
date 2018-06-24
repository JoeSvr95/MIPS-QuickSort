.data
	numArray: .word 4, 3, 5, 2, 1, 3, 2, 3 # arr[] = {4, 3, 5, 2, 1, 3, 2, 3}
	size: .word 8
	indice: .word 0
	coma: .asciiz ", "
.text
	main:
		la $s0, numArray
		lw $s1, indice
		lw $s2, size
		
		# printArr( arr, n )
		jal printArr
		
		# Fin del programa
		li $v0, 10
		syscall
		
	swap:

	# SWAP (int *a, int *b])
       		add $sp,$sp,-4
       		sw $s0, 0($sp)
       
       		add $s0, $zero, $a1  	#t = 0 + a 
       		add $a1, $zero, $a2	#a = 0 + b
       		add $a2, $zero, $s0	#b = 0 + t
       
       		lw $s0, 0($sp)	 	#$s0 regresa a su valor anterior
       		add $sp, $sp, 4		#restaura el stack pointer
       		jr $ra			
       		
		
	printArr:
		# void printArr(int arr[], int n)
		addi $sp, $sp, -8
		# Guardando los valores de $s0 y $s1 en Stack para no modificar los valores originales
		sw $s1, 0($sp) # indice del array
		sw $s2, 4($sp) # Tamaño del array
		
		for:
			# for (int i = 0; i < n; ++i)
			slt $t0, $s1, $s2
			beq $t0, $zero, exit_for
			
			sll $t1, $s1, 2 # Multiplicando el valor de i * 4 para poder tomar los valores del arreglo
			lw $t2, numArray($t1) # $t1 = i * 4
			
			# printf("%d", arr[i])
			li $v0, 1
			add $a0, $zero, $t2
			syscall
			
			# print espacio entre numeros
			li $v0, 4
			la $a0, coma
			syscall
			
			# i++
			addi $s1, $s1, 1
			j for
		
		exit_for:
			lw $s1, 0($sp)
			lw $s2, 4($sp)
			addi $sp, $sp, 8
			
			jr $ra
			
	quickSortIterative:
		

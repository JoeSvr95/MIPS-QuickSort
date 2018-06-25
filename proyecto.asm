.data
	numArray: .word 4, 3, 5, 2, 1, 3, 2, 3 # arr[] = {4, 3, 5, 2, 1, 3, 2, 3}
	size: .word 8
	indice: .word 0
	stack: .word 0:size
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
       		
		
	printArr: # void printArr(int arr[], int n)
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
		
				
	quickSortIterative: # void quickSortIterative (int arr[], int l, int h)
		addi $sp, $sp, -16
		# Guardando los valores de $s0 y $s1 en Stack para no modificar los valores originales
		sw $s0, 0($sp) # Array
		sw $s1, 4($sp) # indice del array: l
		sw $s2, 8($sp) # Tamaño del array: h
		sw $ra, 12($sp) # Dirección para regresar al main
		sw $t0, stack
		
		sub $s3, $s2, $s1 # h - l
		addi $s3, $s3, 1 # h - l + 1
		
		subi $s4, $zero, 1 # top = -1
		addi $s4, $s4, 1 # top++
		sll $t1, $s4, 2 # Multiplicando top * 4 para guardar en el stack
		add $t2, $t1, $t0
		add $t3, $zero, 1
		sw $t3, 0($t2) # stack[too++] = 1
		
		addi $s4, $s4, 1 # top++
		sll $t1, $s4, 2 # Multiplicando por 4
		add $t2, $t1, $t0
		sw $s2, 0($t2)
		
		while:
			sge $s4, $zero, exit_while
			subi $s4, $s4, 1 # top-- 
			sll $t1, $s4, 2 # Multiplicando por 4
			add $t2, $t1, $t0
			lw $s2, 0($t2) # h = stack[ top-- ]
			
			subi $s4, $s4, 1 # top--
			sll $t1, $s4, 2 # Multiplicando por 4
			add $t2, $t1, $t0
			lw $s2, 0($t2)
			
			jal partition
			
			add $t4, $zero, $v1 # p = partition( arr, l, h)
			subi $t5, $t4, 1 # p - 1
			addi $t6, $t4, 1 # p + 1
			
			bgt $t5, $t3, else1 # if ( p -1 > 1)
			addi $s4, $s4, 1 # top++
			sll $t1, $s4, 2 # Multiplicando top * 4 para guardar en el stack
			add $t2, $t1, $t0
			sw $t3, 0($t2) # stack[++top] = 1
			
			addi $s4, $s4, 1 # top++
			sll $t1, $s4, 2 # Multiplicando por 4
			addi $t2, $t1, $t0
			sw $t5, 0($t2) # stack[++top] = p-1
			
			else1:
			
			blt $t6, $s2, else2 # if ( p + 1 < h )
			addi $s4, $s4, 1 # top++
			sll $t1, $s4, 2 # Multiplicando top * 4 para guardar en el stack
			add $t2, $t1, $t0
			sw $t6, 0($t2) # stack[++top] = p + 1
			
			addi $s4, $s4, 1 # top++
			sll $t1, $s4, 2 # Multiplicando por 4
			addi $t2, $t1, $t0
			sw $s2, 0($t2) # stack[++top] = h
			
			else2:
			
			j while
			
		exit_while:
			# Regresando a los valores anteriores
			lw $s0, 0($sp)
			lw $s1, 4($sp)
			lw $s2, 8($sp)
			lw $ra, 12($sp) 
			addi $sp, $sp, 8
			
			jr $ra
			
		
		
	partition:
		# La parte de alics la asimetrix <3
		

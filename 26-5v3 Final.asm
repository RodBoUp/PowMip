    .text
li  $a0, -5         # variable A
li  $a1, 3         # variable B
jal pot            # llama a la función potencia
li  $v0, 10        # código de salida del sistema
syscall

pot:
addi    $sp, $sp, -12   # decrementa el puntero de pila
sw  $s0, 0($sp)   # guarda valores para no mutar
sw  $s1, 4($sp)
sw  $s2, 8($sp)

move    $s0, $a0    # mueve x a s0
move    $s1, $a1    # mueve y a s1
li  $s2, 1          # inicializa el resultado en 1

# Comprueba si el exponente es 0, entonces establece el resultado a 1
beq $s1, $zero, end_loop

loop:           
mul $s2, $s2, $s0   # en cada iteración se realiza una multiplicación
addi    $s1, $s1, -1
bne $s1, $zero, loop    # cuando $a1 no es igual a 0 sigue en el bucle

end_loop:
### IMPRIMIR ###
la  $a0, prompt1
li  $v0, 4
syscall
move    $a0, $s0
li  $v0, 1
syscall
la  $a0, prompt2
li  $v0, 4
syscall
move    $a0, $a1
li  $v0, 1
syscall
### FIN IMPRIMIR ###

### IMPRIMIR ###
la  $a0, result
li  $v0, 4
syscall
move    $a0, $s2
li  $v0, 1
syscall
### FIN IMPRIMIR ###

move    $v0, $s2    # mueve el resultado a v0
lw  $s0, 0($sp)     # carga los valores para no mutar
lw  $s1, 4($sp)
lw  $s2, 8($sp)
addi    $sp, $sp, 12   # incrementa el puntero de pila
jr  $ra

.data
.align 2
prompt1:    .asciiz     "A: "
.align 2
prompt2:    .asciiz     "B: "
.align 2
result:     .asciiz     " Resultado de la potencia: "
; Professor: Ricardo Bohaczuk Venturelli
; Aluno: Alisson Pereira Ferreira

; O nome dos LOOPS, foram escolhidos para facilitar o entendimento do trabalho. [REGISTRADOR]
; SEGUNDO_05 = segundos(unidade) [B] e SEGUNDOS_04 = segundos(dezena) [C]
; MINUTO_03 = minutos(unidade) [D] e MINUTO_02 = minutos(dezena) [E]
; HORA_01 = horas(unidade) [H] e HORA_00 = horas(dezena) [L]

; Como todos os 06 registradores foram utitilzador para guardar as unidades anteriores 
; e eu não gostaria de usar as portas para guardar valores, resolvi utilzar o MVI para passar um 
; imediato para o acumulador, assim sem precisar usar algum registrador ou porta para armazenar 
; valores.

; Basicamente a conta é: 
; MVI leva 7 T-States, NOP leva 4 T-States, DCR leva 4 T-States, 
; JNZ leva 10 T-States caso pule e 7 T-States caso não pule.
; Então, o que temos: 
; Total: 7 + 142 * (4 + 10) - 3 + 4 + 4 = 2000 T-state
; Tempo total: 2000 · 0,5 µs = 1 ms.

.ORG 0000H
; Iniciamos o relogio em 00:00:00
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
OUT 01H
OUT 00H
MVI B, 01H
MVI C, 01H
MVI D, 01H
MVI E, 01H
MVI H, 01H
MVI L, 01H

ATRIBUI_ZERO:
MVI B, 01H

; Criamos um delay de exato 1ms
SEGUNDO_05:

MVI A, 8Eh ; 142D
DELAY:
DCR A 
JNZ DELAY
NOP
NOP

; A lógica utilizada é basicamente ir comparando o valor do registrador B com um certo valor pré-definido, como segundos vão
; de 0 a 9 neste loop, comparamos de 0 a 9. Caso ele for o valor comparado, ele irá para um loop em que será mostrado o valor na 
; porta 05H. Está lógica é utilizada em basicamente todo o trabalho, tendo apenas poucas mudanças. Como, por exemplo a dezena
; vai de 0 a 5, em vez de 0 a 9.

MOV A, B
CPI 01H
JZ UM_05  
CPI 02H
JZ DOIS_05  
CPI 03H
JZ TRES_05  
CPI 04H
JZ QUATRO_05  
CPI 05H
JZ CINCO_05  
CPI 06H
JZ SEIS_05  
CPI 07H
JZ SETE_05  
CPI 08H
JZ OITO_05  
CPI 09H
JZ NOVE_05 
JMP SEGUNDO_04 ; Se não for nenhum dos anteriores, vai para o SEGUNDO_04

UM_05:
MVI A, 44H
OUT 05H
INR B 
JMP SEGUNDO_05

DOIS_05:
MVI A, 3EH
OUT 05H
INR B 
JMP SEGUNDO_05

TRES_05:
MVI A, 6EH
OUT 05H
INR B 
JMP SEGUNDO_05

QUATRO_05:
MVI A, 4DH
OUT 05H
INR B 
JMP SEGUNDO_05

CINCO_05:
MVI A, 6BH
OUT 05H
INR B 
JMP SEGUNDO_05

SEIS_05:
MVI A, 7BH
OUT 05H
INR B 
JMP SEGUNDO_05

SETE_05:
MVI A, 46H
OUT 05H
INR B 
JMP SEGUNDO_05

OITO_05:
MVI A, 7FH
OUT 05H
INR B 
JMP SEGUNDO_05

NOVE_05:
MVI A, 4FH
OUT 05H
INR B 
JMP SEGUNDO_05

MVI B, 01H ; Coloca o valor 01H novamente para B

; Loop que atribui os valores ao segundo(dezena), segue o mesmo principio do anterior, só que como os segundos vão até 59, o loop vai até 5
; visto que, quando ele for 60, ele vai para o loop minutos(unidade) e recebe o valor de 0.
SEGUNDO_04:
MOV A, C
CPI 01H
JZ UM_04 ; 
CPI 02H
JZ DOIS_04 ; 
CPI 03H
JZ TRES_04 ; 
CPI 04H
JZ QUATRO_04 ; ; 
CPI 05H
JZ CINCO_04 ; 

JMP MINUTO_03

UM_04:
MVI A, 77H
OUT 05H
MVI A, 44H
OUT 04H
INR C 
JMP ATRIBUI_ZERO

DOIS_04:
MVI A, 77H
OUT 05H
MVI A, 3EH
OUT 04H
INR C 
JMP ATRIBUI_ZERO

TRES_04:
MVI A, 77H
OUT 05H
MVI A, 6EH
OUT 04H
INR C 
JMP ATRIBUI_ZERO

QUATRO_04:
MVI A, 77H
OUT 05H
MVI A, 4DH
OUT 04H
INR C 
JMP ATRIBUI_ZERO

CINCO_04:
MVI A, 77H
OUT 05H
MVI A, 6BH
OUT 04H
INR C 
JMP ATRIBUI_ZERO

; Este segue o mesmo principio do segundos(unidade), a unica diferença é que ele reseta os 
; registradores usados anteriores.
MINUTO_03:
MVI B, 01H
MVI C, 01H
MOV A, D
CPI 00H
JZ ZERO_03
CPI 01H
JZ UM_03  
CPI 02H
JZ DOIS_03  
CPI 03H
JZ TRES_03  
CPI 04H
JZ QUATRO_03  
CPI 05H
JZ CINCO_03  
CPI 06H
JZ SEIS_03  
CPI 07H
JZ SETE_03  
CPI 08H
JZ OITO_03  
CPI 09H
JZ NOVE_03 

JMP MINUTO_02 ; Se não for nenhum dos anteriores, vai para o MINUTO_02
ZERO_03:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
INR D 

JMP ATRIBUI_ZERO
UM_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 44H
OUT 03H
INR D 
JMP ATRIBUI_ZERO

DOIS_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 3EH
OUT 03H
INR D 
JMP ATRIBUI_ZERO

TRES_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 6EH
OUT 03H
INR D
JMP ATRIBUI_ZERO

QUATRO_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 4DH
OUT 03H
INR D
JMP ATRIBUI_ZERO

CINCO_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 6BH
OUT 03H
INR D
JMP ATRIBUI_ZERO

SEIS_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 7BH
OUT 03H
INR D
JMP ATRIBUI_ZERO

SETE_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 46H
OUT 03H
INR D
JMP ATRIBUI_ZERO

OITO_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 7FH
OUT 03H
INR D
JMP ATRIBUI_ZERO

NOVE_03:
MVI A, 77H
OUT 05H
OUT 04H
MVI A, 4FH
OUT 03H
INR D
JMP ATRIBUI_ZERO

JMP MINUTO_02 ; Se não for nenhum dos anteriores, vai para o MINUTO_02

; Este segue o mesmo principio do segundos(dezena),a unica diferença é que ele reseta os 
; registradores usados anteriores.
MINUTO_02:
MVI C, 00H
MVI D, 00H
MOV A, E
CPI 00H
JZ ZERO_02
CPI 01H
JZ UM_02 ; 
CPI 02H
JZ DOIS_02 ; 
CPI 03H
JZ TRES_02 ; 
CPI 04H
JZ QUATRO_02 ; ; 
CPI 05H
JZ CINCO_02 ; 
JMP HORA_01 ; Se não for nenhum dos anteriores, vai para o HORA_01

ZERO_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H

UM_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
MVI A, 44H
OUT 02H
INR E 
JMP ATRIBUI_ZERO

DOIS_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03h
MVI A, 3EH
OUT 02H
INR E 
JMP ATRIBUI_ZERO

TRES_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03h
MVI A, 6EH
OUT 02H
INR E 
JMP ATRIBUI_ZERO

QUATRO_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03h
MVI A, 4DH
OUT 02H
INR E 
JMP ATRIBUI_ZERO

CINCO_02:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03h
MVI A, 6BH
OUT 02H
INR E 
JMP ATRIBUI_ZERO

HORA_01:
MVI B, 01H
MVI C, 01H
MVI D, 01H
MVI E, 01H
MOV A, H
CPI 00H
JZ ZERO_01
CPI 01H
JZ UM_01  
CPI 02H
JZ DOIS_01  
CPI 03H
JZ TRES_01  
CPI 04H
JZ QUATRO_01  
CPI 05H
JZ CINCO_01  
CPI 06H
JZ SEIS_01  
CPI 07H
JZ SETE_01  
CPI 08H
JZ OITO_01  
CPI 09H
JZ NOVE_01 

JMP HORA_00 ; Se não for nenhum dos anteriores, vai para o HORA_0

; Este segue o mesmo principio do minutos(unidade), a unica diferenca e que quando tivermos o valor 3 no loop hora_00, o loop 
; da hora(dezena), e chegarmos no valor 3 na loop QUATRO_01, o loop ira finalizar, pois a maior hora que temos é 23:59:59 

ZERO_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
OUT 01H
INR H
JMP ATRIBUI_ZERO

UM_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 44H
OUT 01H
INR H
JMP ATRIBUI_ZERO

DOIS_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 3EH
OUT 01H
INR H
JMP ATRIBUI_ZERO

TRES_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 6EH
OUT 01H
INR H
JMP ATRIBUI_ZERO

QUATRO_01:
MOV A, L
CPI 03H
JZ END
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 4DH
OUT 01H
INR H
JMP ATRIBUI_ZERO

CINCO_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 6BH
OUT 01H
INR H
JMP ATRIBUI_ZERO

SEIS_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 7BH
OUT 01H
INR H
JMP ATRIBUI_ZERO

SETE_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 46H
OUT 01H
INR H
JMP ATRIBUI_ZERO

OITO_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 7FH
OUT 01H
INR H
JMP ATRIBUI_ZERO

NOVE_01:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
MVI A, 4FH
OUT 01H
INR H
JMP ATRIBUI_ZERO

; Este segue o mesmo principio do minutos(unidade), a unica diferenca e que so vai ate 2, pois a maior hora que temos é 23:59:59
HORA_00:
MVI B, 01H
MVI C, 01H
MVI D, 01H
MVI E, 01H
MVI H, 01H
MOV A, L
CPI 01H
JZ UM_00 ; 
CPI 02H
JZ DOIS_00 ;
JMP END ; Se não for nenhum dos anteriores, vai para o END

UM_00:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
OUT 01H
MVI A, 44H
OUT 00H
INR L
JMP ATRIBUI_ZERO

DOIS_00:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
OUT 01H
MVI A, 3EH
OUT 00H
INR L 
JMP ATRIBUI_ZERO

; LOOP que finaliza a execução do programa
END:
MVI A, 77H
OUT 05H
OUT 04H
OUT 03H
OUT 02H
OUT 01H
OUT 00H
HLT
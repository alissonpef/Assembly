; Professor: Ricardo Bohaczuk Venturelli
; Aluno: Alisson Ferreira

; O algoritmo analisa se o número é primo com base em uma verificação de paridade.
; Caso o número seja par, automaticamente não é primo. Se o número for impar, será verificado se ele é
; divisivel por 3, caso o resto da divisão seja 0, ele não é primo, logo, se o resto da divisão for diferente 
; de zero, ele será primo. Verificamos também se ele é divisivel por 05D, 07D, 11D e 13D pois algumas se não numeros como 25D e 49D
; mesmo não sendo primos, no final sairam como 01H na porta 00H.

; Algumas excessões: neste algoritmo não é possível verificar o 01H, O2H, 03H, 05H, 07H, 0BH e 0DH como número primo, logo tive que 
; criar uma verificação adicional para cada um desses casos.

; Lembrando que 00H, não é um número primo e nem um número não primo, logo ele é um erro.

.ORG 0000				; Inicia o programa no endereço de memoria 0000H
    LXI SP, 0000H			; Carrega o registrador SP com o valor 0000h

STANDBY: 
    JMP STANDBY      		; Salta para o loop STANDBY

.ORG 0024H				; Inicia o programa no endereço de memoria 0024H
TRAP: 
    IN 00h         		; Lê o valor na porta 00H
    MOV B, A       		; Move o acumulador A para B 
    MVI C, 02H     		; Move o valor 02H para o C

VERIFICA_01:
    IN 00H        		; Lê o valor na porta 00H
    CPI 01H       		; Compara com o valor 01H
    JZ NAO_PRIMO   		; Salta para o loop NAO_PRIMO se forem iguais

VERIFICA_02:
    IN 00H        		; Lê o valor na porta 00H
    CPI 02H       		; Compara com o valor 02H
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

VERIFICA_03:
    IN 00H        		; Lê o valor na porta 00H
    CPI 03H       		; Compara com o valor 03H
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

VERIFICA_05:
    IN 00H        		; Lê o valor na porta 00H
    CPI 05H       		; Compara com o valor 05H
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

VERIFICA_07:
    IN 00H        		; Lê o valor na porta 00H
    CPI 07H       		; Compara com o valor 07H
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

VERIFICA_11:
    IN 00H        		; Lê o valor na porta 00H
    CPI 0BH       		; Compara com o valor 0BH
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

VERIFICA_13:
    IN 00H        		; Lê o valor na porta 00H
    CPI 0DH       		; Compara com o valor 0DH
    JZ PRIMO   			; Salta para o loop PRIMO se forem iguais

LOOP_PRIMO:
    MOV A, B       		; Move B para o acumulador A
    CMP C          		; Compara se o acumulador A é igual ao C
    JC ATRIBUI_3        	; Salta para o loop ATRIBUI_3 se o resultado for menor
    JZ NAO_PRIMO 			; Salta para o loop NAO_PRIMO se forem iguais
    MOV D, A       		; Move o acumulador A para D
    MOV A, C       		; Move C para o acumulador A

DIVISAO:
    SUB D          		; Subtrai o D do acumulador A
    JNC RESTO_DIV 		; Salta para RESTO_DIV se não houver carry
    INR C          		; Incrementa o valor em C
    INR C          		; Incrementa novamente o valor em C
    JMP LOOP_PRIMO 		; Salta para LOOP_PRIMO
	
RESTO_DIV:
    MOV A, D       		; Move D para o acumulador A
    ORA A          		; Realiza um OR com o acumulador A
    JNZ NAO_PRIMO 		; Salta para NAO_PRIMO se o resultado não for zero
    INR C          		; Incrementa o valor em C
    INR C          		; Incrementa novamente o valor em C
    JMP LOOP_PRIMO 		; Salta para LOOP_PRIMO

LOOP_PRIMO_2:
    MOV A, B       		; Move B para o acumulador A
    CMP C          		; Compara se o acumulador A é igual ao C
    JC ATRIBUI_5 			; Salta para o loop ATRIBUI_5 se houver carry
    JZ NAO_PRIMO 			; Salta para o loop NAO_PRIMO se forem iguais
    MOV D, A       		; Move o acumulador A para D
    MOV A, C       		; Move C para o acumulador A

DIVISAO_2:
    SUB D          		; Subtrai o D do acumulador A
    JNC RESTO_DIV_2 		; Salta para RESTO_DIV_2 se não houver carry
    INR C          		; Incrementa o valor em C
    INR C          		; Incrementa novamente o valor em C
    INR C          		; Incrementa mais uma vez o valor em C
    JMP LOOP_PRIMO_2 		; Salta para LOOP_PRIMO_2
	
RESTO_DIV_2:
    MOV A, D       		; Move D para o acumulador A
    ORA A          		; Realiza um OR com o acumulador A
    JNZ NAO_PRIMO 		; Salta para NAO_PRIMO se o resultado não for zero
    INR C          		; Incrementa o valor em C
    INR C          		; Incrementa novamente o valor em C
    INR C          		; Incrementa mais uma vez o valor em C
    JMP LOOP_PRIMO_2 		; Salta para LOOP_PRIMO_2

ATRIBUI_3:
    MVI C, 03H 			; Move o valor 03H para o C
    JMP LOOP_PRIMO_2 		; Salta para LOOP_PRIMO_2

ATRIBUI_5:
	IN 00H			; Lê o valor na porta 00H
	JMP COMPARA_5		; Salta para COMPARA_5

COMPARA_5: 	               	
	MVI B, 05H      		; Move o valor 05h para  B
	CPI 05h         		; Compara com o valor 05H
	JZ NAO_PRIMO     		; Salta para NAO_PRIMO  se for igual
	JC ATRIBUI_7        	; Salta para ATRIBUI_7 se houver carry 
	SUB B           		; Subtrai B do acumulador A
	JMP COMPARA_5        	; Salta para COMPARA_5, até o valor for igual ou houver carry

ATRIBUI_7:
	IN 00H			; Lê o valor na porta 00H
	JMP COMPARA_7		; Salta para COMPARA_5

COMPARA_7: 	               	
	MVI B, 07H      		; Move o valor 05h para  B
	CPI 07h         		; Compara com o valor 05H
	JZ NAO_PRIMO     		; Salta para NAO_PRIMO  se for igual
	JC ATRIBUI_11        	; Salta para ATRIBUI_11 se houver carry 
	SUB B           		; Subtrai B do acumulador A
	JMP COMPARA_7        	; Salta para COMPARA_5, até o valor for igual ou houver carry

ATRIBUI_11:
	IN 00H			; Lê o valor na porta 00H
	JMP COMPARA_11		; Salta para COMPARA_5

COMPARA_11: 	               	
	MVI B, 0BH      		; Move o valor 05h para  B
	CPI 0Bh         		; Compara com o valor 05H
	JZ NAO_PRIMO     		; Salta para NAO_PRIMO  se for igual
	JC ATRIBUI_13       	; Salta para ATRIBUI_13 se houver carry 
	SUB B           		; Subtrai B do acumulador A
	JMP COMPARA_11        	; Salta para COMPARA_5, até o valor for igual ou houver carry

ATRIBUI_13:
	IN 00H			; Lê o valor na porta 00H
	JMP COMPARA_13		; Salta para COMPARA_5

COMPARA_13: 	               	
	MVI B, 0DH      		; Move o valor 05h para  B
	CPI 0Dh         		; Compara com o valor 05H
	JZ NAO_PRIMO     		; Salta para NAO_PRIMO  se for igual
	JC PRIMO        		; Salta para PRIMO se houver carry 
	SUB B           		; Subtrai B do acumulador A
	JMP COMPARA_13       	; Salta para COMPARA_5, até o valor for igual ou houver carry

PRIMO:
    MVI A, 01h 			; Move 01H para o acumulador A
    OUT 00h 			; Coloca o valor do acumulador A para a porta 00H
    JMP FIM 			; Salta para FIM

NAO_PRIMO:
    MVI A, 10h 			; Move 10H para o acumulador A
    OUT 00h 			; Coloca o valor do acumulador A para a porta 00H

FIM:
    POP D 				; Desempilha o D
    POP H 				; Desempilha o par HL
    POP PSW 			; Desempilha as flags e o acumulador
    EI 				; Habilita interrupções
    RET 				; Retorna da sub-rotina


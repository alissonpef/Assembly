; Professor: Ricardo Bohaczuk Venturelli
; Aluno: Alisson Ferreira

; Os valores de MVI B, 20 e MVI C, 10 Podem ser alterados para qualquer valor, desde que o mesmo seja > 0
; Caso algum registrador for igual a 0, o valor resultante sera o registrador diferente de 0
; Caso os dois forem iguais a 0, o valore sera 0

	.org 1000H     ; Inicia o programa no endereço de memoria 1000H
	LXI H, 2050H   ; Define o endereço de memória 2050H para o par HL
	MOV A, M       ; Move o par HL para o acumulador A
	MOV B, A       ; Move o acumulador A para o B
	LXI H, 2051H   ; Define o endereço de memória 2051H para o par HL
	MOV A, M       ; Move o par HL para o acumulador A
	MOV C, A       ; Move o acumulador A para o C
	CPI 00h        ; Compara o valor do acumulador A com 0
	JZ Resultado   ; Salta para o Loop Resultado se A = 0

Euclides:      	   ; Define o loop chamado Euclides, este por sua vez executa a formula de Euclides
	MOV A, B       ; Move B para o acumulador A
	CMP C          ; Compara se o acumulador A = C
	JC Troca       ; Salta para o Loop Troca se A < C
	JZ Resultado   ; Salta para o Loop Resultado se A = C
	JMP Subtracao  ; Salta para o Loop Subtracao se A > C

Troca:         	   ; Define o loop chamado Troca, este por sua vez troca os valores B com C
	MOV A, B       ; Move B para o acumulador A
	MOV B, C       ; Move C para B
	MOV C, A       ; Move o acumulador A para C
	JMP Euclides   ; Salta para o Loop Euclides

Subtracao:     	   ; Define o loop chamado Subtracao, este por sua vez faz a subtracao de B com C
	MOV A, B       ; Move B para o acumulador A
	SUB C          ; Subtrai C com o acumulador A
	JZ Resultado   ; Salta para Resultado se A = 0
	MOV B, A       ; Move o acumulador A para B
	JNZ Euclides   ; Salta para Euclides se A != 0

Resultado:       	   ; Define o loop chamado Resultado, este por sua vez carrega o valor no par HL 2052H e finaliza o programa
	MOV A, B       ; Move B para o acumulador A
	ORA C          ; Realiza um OR entre A e C
	LXI H, 2052H   ; Define o endereço de memória 2050H para o par HL
	MOV M, A       ; Move o acumulador A para o par HL
	HLT            ; Para o programa
	
	

	
	
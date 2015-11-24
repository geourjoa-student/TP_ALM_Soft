@ -------------------------------------
@ ALM TP2 : interclassement de tableau
@
@ Auteur : Geourjon Anthony
@ Date : 24/11/15
@ Avancement : en cours
@ -------------------------------------

.data

.set N1, 5 
.set N2, 4
.set N, N1+N2

	.align 

T1: 	.byte 12
	.byte 10
	.byte 8
	.byte 8
	.byte -7

	.align

T2:	.hword 15
	.hword 8
	.hword -1
	.hword -4

	.align
.bss

T: 	.skip N*4

	.align

.text

.global main

main:	stmfd sp!, {lr} 
	
	
	@ -- Interclassement --
	
	
	mov R1, #relaisT1	@R1 correpondra à l'adresse de T[1i1]
	mov R2, #relaisT2 	@R2 correpondra à l'adresse de T2[i2]
	mov R0, #relaisT 	@R0 correpondra à l'adresse de T[i]

	mov R3, #0		@R1 correpondra à i1
	mov R4, #0		@R2 correpondra à i2
	mov R5, #0	 	@R0 correpondra à i




	bal test1
tque1:	
	
tque2: 	cmp r4, #N2		@i2<N2
	bge ftque2
	
	ldrb r6, [r1]		@r6 -> valeur T1[i1]
	ldrh r7, [r2]		@r7 -> valeur T2[i2]
	cmp r7,r6 
	blt ftque2		@T[i1]>=T[i2]

boucle2:
	str r7, [r0]
	add r0, r0, #4		@ incrémentation de l'adresse
	add r2, r2, #2
	
	add r5, r5, #1		@ incrémentation de l'indice
	add r4, r4, #1

ftque2:

	str r6, [r0]
	add r0,r0,#4		@ idem que commentaire précedent
	add r1, r1, #1

	add r5,r5,#1
	add r3,r3,#1

test1:	cmp r1, #N1
	blt tque1








	bal test3

tque3:	str r4, [r0]
	add r0, r0, #4
	add r2, r2, #2

	add r5, r5, #1		
	add r4, r4, #1


test3:	cmp r2, #N2
	blt tq3







@ -- affichage --

	MOV r0, #RelaisT 

	bal test4
tque4:	
	bl EcrHexa32 		@ impression de la somme
	add r0, r0, #4
test4: 	cmp r0, #N
	bl tque4

d



	


fin :	ldmfd sp!, {pc}

relaisT1: .byte T1
relaisT2: .hword T2
relaisT: .word T

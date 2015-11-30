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
	.byte -15
	
	.align

T2:	.hword 15
	.hword 8
	.hword -1
	.hword -4
@	.hword -12

	.align

.bss

T: 	.skip N*4

	.align

.text

.global main

main:	stmfd sp!, {lr} 
	

	@ -- Interclassement --
	
	
	ldr R1, =T1		@R1 correpondra à l'adresse de T[i1]
	ldr R2, =T2 		@R2 correpondra à l'adresse de T2[i2]
	ldr R0, =T 		@R0 correpondra à l'adresse de T[i]

	mov R3, #0		@R1 correpondra à i1
	mov R4, #0		@R2 correpondra à i2
	mov R5, #0	 	@R0 correpondra à i


	bal test1
tque1:	
	
tque2: 	
	cmp r4, #N2		@tantque (i2 < N2)
	bgt ftque2
	
	ldrsb r6, [r1]		@r6 -> valeur T1[i1]		Ldrsb ou ldrsh : http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489c/Cihjffga.html
	ldrsh r7, [r2]		@r7 -> valeur T2[i2]

	cmp r7,r6		@et puis (T2[i2] >= T1[i2]) faire) 
	blt ftque2	

boucle2:
	str r7, [r0]
	add r0, r0, #4		@ incrémentation de l'adresse
	add r2, r2, #2
	
	add r5, r5, #1		@ incrémentation de l'indice
	add r4, r4, #1

	bal tque2

ftque2:

	str r6, [r0]
	add r0,r0,#4		@ idem que commentaire précedent
	add r1, r1, #1

	add r5,r5,#1
	add r3,r3,#1

test1:	cmp r3, #N1 		@ tantque (i1 < N1) faire)
	blt tque1


	bal test3

tque3:	
	ldrsh r7, [r2]
	str r7, [r0]
	add r0, r0, #4
	add r2, r2, #2

	add r5, r5, #1		
	add r4, r4, #1


test3:	cmp r4, #N2
	blt tque3



@ -- affichage --

	ldr r0, =T 
	mov r2, #0
	bal test4
tque4:	
	ldr r1, [r0]
	bl EcrRelatif32 		@ impression de la somme (relatif)
	bl EcrHexa32
	add r0, r0, #4
	add r2,r2,#1
test4: 	cmp r2, #N
	blt tque4





	


fin :	ldmfd sp!, {pc}


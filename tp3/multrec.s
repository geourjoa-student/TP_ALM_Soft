	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"multrec.c"
	.text
	.align	2
	.global	multiplication
	.type	multiplication, %function
multiplication:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}			@ Sauvegarde le conctexte de l'appelant
	add	fp, sp, #4			
	sub	sp, sp, #24			@ Allocation de mémoire dans la pile
	str	r0, [fp, #-16]			@ On enregistre les paramètres dans la pile
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r3, #1				@ On teste si la récursion est terminé
	bne	.L2
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-16]
	str	r2, [r3]
	b	.L1				@ Fin de la récursion et on va remonter dans la recursivité
.L2:
	ldr	r3, [fp, #-20]			@ Préparation des paramètres pour la récursion
	sub	r2, r3, #1
	sub	r3, fp, #8
	ldr	r0, [fp, #-16]
	mov	r1, r2
	mov	r2, r3
	bl	multiplication			@ Appel récursif
	ldr	r2, [fp, #-8]			@ On termine le calcul avec la valeur grâce à la valeur trouvée par la récursion
	ldr	r3, [fp, #-16]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3]
.L1:
	sub	sp, fp, #4
	@ sp needed
	ldmfd	sp!, {fp, lr}			@ On restaure le contexte de l'appelant
	bx	lr
	.size	multiplication, .-multiplication
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Donnez deux entiers positifs : \000"
	.align	2
.LC1:
	.ascii	"%d %d\000"
	.align	2
.LC2:
	.ascii	" %d * %d = %d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr} 		@ Sauvegarde du contexte de l'appelant dans la pile (ici inutile) 
	add	fp, sp, #4		
	sub	sp, sp, #16		@ Allocation de mots mémoire dans la pile. Ici le compilateur aloue 4 mots de mémoire alors que seulement 3 sont nécessaires. C'est donc pour cela que la pile contient des étages inutilisés.
	ldr	r0, .L5			@ On donne un pointeur vers la chaine à afficher
	bl	puts			@ On affiche
	sub	r2, fp, #8
	sub	r3, fp, #12
	ldr	r0, .L5+4		@ On charge le motif de scanf puis on charge les pointeurs de résultats dans r1 et r2
	mov	r1, r2
	mov	r2, r3
	bl	scanf			@ On lit l'entrée standart
	ldr	r1, [fp, #-8]		@ On charge dans les registres les résultats depuis les pointeurs
	ldr	r2, [fp, #-12]
	sub	r3, fp, #16
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	multiplication		@ On effectue la multiplication
	ldr	r1, [fp, #-8]		@ On charge les resultats et un pointeur de la chaine à afficher
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	ldr	r0, .L5+8		@ On affichae le résultat du programme
	bl	printf
	mov	r0, r3
	sub	sp, fp, #4		
	@ sp needed
	ldmfd	sp!, {fp, lr}		@ On restaure le contexte
	bx	lr
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (4.8.4-1+11-1) 4.8.4 20141219 (release)"

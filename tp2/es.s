@
@ fonctions d'entrees sorties
@ version 0 : aucune verification concernant les tailles des
@             representation n'est effectuee
@             on utilise uniquement les formats des fonctions de
@             la bibliotheque d'entrees/sorties C
@     il faudrait ameliorer la lecture et l'ecriture d'octets
@     qui pour l'instant se fait sur un demi-mot...
@ auteur : Fabienne Lagnier
@ date creation : 10 mai 2003
@ modifications :
@ --> 29/10/03 : sauvegarde r2 et r3
@

	.global EcrChaine
	.global EcrHexa32
	.global EcrRelatif32
	.global EcrRelatif16
	.global EcrRelatif8
	.global EcrNaturel32
	.global EcrNaturel16
	.global EcrNaturel8
	.global Lire32
	.global Lire16
	.global Lire8

	.text


@ EcrChaine :
@    ecriture de la chaine dont l'adresse est dans r1
EcrChaine:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, relais_fe_chaine
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrHexa32 :
@    ecriture d'un mot de 32 bits en hexadécimal
@    la valeur a afficher est dans r1
EcrHexa32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, relais_f_hexa_32
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrRelatif32 :
@    ecriture d'un entier relatif represente sur 32 bits
@    l'entier est dans r1
EcrRelatif32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, relais_fe_rel32
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrRelatif16 :
@    ecriture d'un entier relatif represente sur 16 bits
@    l'entier est dans les 16 bits de poids faibles de r1
EcrRelatif16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, relais_fe_rel16
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrRelatif8 :
@    ecriture d'un entier relatif represente sur 8 bits
@    l'entier est dans les 8 bits de poids faibles de r1
@    attention : les bits 15 a 8 de r1 sont eventuellement modifies
EcrRelatif8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   tst r1, #0x00000080 @ bit7 ?
	   andeq r1, r1, #0xffff00ff
		orrne r1, r1, #0x0000ff00
	   ldr r0, relais_fe_rel16
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNaturel32 :
@    ecriture d'un entier naturel represente sur 32 bits
@    l'entier est dans r1
EcrNaturel32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, relais_fe_nat32
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNaturel16 :
@    ecriture d'un entier naturel represente sur 16 bits
@    l'entier est dans les 16 bits de poids faibles de r1
EcrNaturel16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, relais_fe_nat16
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNaturel8 :
@    ecriture d'un entier naturel represente sur 8 bits
@    l'entier est dans les 8 bits de poids faibles de r1
@    attention : les bits 15 a 8 de r1 sont mis a 0
EcrNaturel8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
	   and r1, r1, #0xffff00ff
      ldr r0, relais_fe_nat16
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire32 :
@    lecture d'un entier represente sur 32 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, relais_fl_rel32
      bl scanf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire16 :
@    lecture d'un entier represente sur 16 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, relais_fl_rel16
      bl scanf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire8 :
@    lecture d'un entier represente sur 8 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
	   @ lecture dans la donnee DON sur 16 bits
      ldr r0, relais_fl_rel16
      ldr r1, relaisDON
      bl scanf
		@ recuperer le demi-mot lu 
		ldr r1, relaisDON
		ldrh r0, [r1]
		@ et le stocker ou on l'attend
		@ l'adresse etait dans r1 empile en debut de procedure
		@ d'ou on recupere r1 dans la pile
      ldr r1, [fp, #-16]
		strb r0, [r1]
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

relais_fe_chaine: .word fe_chaine
relais_f_hexa_32: .word f_hexa_32
relais_fe_rel32: .word fe_rel32
relais_fe_rel16: .word fe_rel16
relais_fe_nat32: .word fe_nat32
relais_fe_nat16: .word fe_nat16
relais_fl_rel32: .word fl_rel32
relais_fl_rel16: .word fl_rel16

relaisDON: .word DON  @ acces a la zone data

	.data

@ definition des formats de lecture ecriture
fe_chaine: .asciz "%s\n"
f_hexa_32: .asciz "%08x\n"
fe_rel32: .asciz  "%d\n"
fe_rel16: .asciz  "%hd\n"
fe_nat32: .asciz  "%u\n"
fe_nat16: .asciz  "%hu\n"
fl_rel32: .asciz  "%d"
fl_rel16: .asciz  "%hd"

@ pour la fonction Lire8
DON: .word 0

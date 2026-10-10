; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l5f69h:	equ 0x05f69

; ----------------------------------------------------------------------
; DATOS cabecera: cabecera del cartucho: "AB", INIT = 0x4090 y STATEMENT,
;   DEVICE y TEXT a cero; la lee la BIOS al arrancar; lo leen BIOS (16 bytes)
;   0x4000..0x4010  (16 bytes)
DATA_cabecera:
	defb 041h,042h,090h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ----------------------------------------------------------------------
; DATOS cabecera_game_master: la segunda cabecera de Konami: "CD", 0x07 0x51
;   (RC-751) y 15 bytes que lee el Game Master desde la otra ranura; el propio
;   cartucho la busca en el vecino (p03:BD06: Galious, Penguin Adventure y
;   Q*bert la llevan); lo leen p03:BD06 (19 bytes)
;   0x4010..0x4023  (19 bytes)
DATA_cabecera_game_master:
	defb 043h,044h,007h,051h,0b8h,0c0h,0e1h,004h,001h,0e2h,007h,000h,0e2h,0fah,0e1h,0f5h	; 4010  CD.Q............
	defb 0e1h,0c2h,0e1h	; 4020

; ======================================================================
; CODIGO 0x4023..0x4358  (821 bytes)
; ======================================================================


interrupcion:		; H.KEYI: cuenta el cuadro (0xF0F7), el sonido con los bancos 4-5-6 (p04:6934) y, si no esta ya en marcha (0xE1C5), el cuadro del juego
	call 0013eh		;4023   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP: asi se da por atendida la interrupcion
	di			;4026   ; sin interrupciones mientras se cambia de banco
	ld hl,(0f0f7h)		;4027   ; lee la cuenta de interrupciones (16 bits)
	inc hl			;402a   ; un cuadro mas
	ld (0f0f7h),hl		;402b   ; guarda la cuenta de interrupciones (16 bits)
	call cuenta_atras		;402e   ; p00:4C4B: lo primero de cada cuadro
	ld hl,0e1d4h		;4031   ; apunta a la marca de sonido en marcha
	ld a,(hl)			;4034
	and a			;4035
	ld (hl),001h		;4036   ; marca el sonido en marcha y mira si ya lo estaba
	jp nz,L_4075		;4038   ; si el sonido ya estaba en marcha, fuera
	ld a,004h		;403b   ; los bancos 4, 5 y 6 sin tocar sus copias: el sonido
	ld (07000h),a		;403d   ; el banco 4 en 0x6000
	inc a			;4040
	ld (09000h),a		;4041   ; el 5 en 0x8000
	inc a			;4044
	ld (0b000h),a		;4045   ; el 6 en 0xA000
	call 06934h		;4048   ; p04:6934: el sonido del cuadro
	xor a			;404b
	ld (0e1d4h),a		;404c   ; se acabo el sonido
	di			;404f
	ld a,(0f0f1h)		;4050   ; devuelve los bancos de antes, los de sus copias 0xF0F1-0xF0F3
	ld (07000h),a		;4053   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;4056   ; lee la copia del banco de 0x8000
	ld (09000h),a		;4059   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;405c   ; lee la copia del banco de 0xA000
	ld (0b000h),a		;405f   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0e1c5h		;4062   ; apunta a la marca de cuadro en marcha (si no es 0, la interrupcion no lanza otro)
	ld a,(hl)			;4065
	and a			;4066   ; si el cuadro de juego anterior no ha acabado, no se lanza otro
	jr nz,L_4075		;4067
	inc (hl)			;4069   ; marca el cuadro en marcha
	ei			;406a   ; con interrupciones: el sonido sigue sonando aunque el cuadro se alargue
	call lee_mandos		;406b   ; p00:5D2A: la pantalla del cuadro anterior a la VRAM
	call estado_del_juego		;406e   ; p00:5601: el estado del juego
	xor a			;4071
	ld (0e1c5h),a		;4072   ; cuadro acabado
L_4075:
	ei			;4075
	ret			;4076
L_4077:
	jp 00047h		;4077   ; BIOS WRTVDP - Writes data in the VDP-register | WRTVDP: el registro C del VDP con B
hl_mas_a:		; HL = HL + A
	add a,l			;407a   ; HL + A, con el acarreo al byte alto
	ld l,a			;407b
	ret nc			;407c
	inc h			;407d
	ret			;407e
de_mas_a:		; DE = DE + A
	add a,e			;407f   ; DE + A, con el acarreo al byte alto
	ld e,a			;4080
	ret nc			;4081
	inc d			;4082
	ret			;4083
despacha:		; salta a la palabra A de la tabla que va pegada detras del `call`
	pop hl			;4084   ; HL = la tabla, que va justo detras del `call`
despacha_hl:		; salta a la palabra A de la tabla HL
	add a,a			;4085   ; dos bytes por destino
	add a,l			;4086
	ld l,a			;4087
	jr nc,L_408B		;4088
	inc h			;408a
L_408B:
	ld a,(hl)			;408b
	inc hl			;408c
	ld h,(hl)			;408d
	ld l,a			;408e
	jp (hl)			;408f   ; y salta
init:		; el arranque: H.KEYI a p00:4023, el cartucho en 0x8000, bancos 0-1-2-3, RAM 0xE000-0xEFFF a cero y a esperar en `jr $`
	di			;4090   ; INIT: lo llama la BIOS al arrancar
	im 1		;4091
	ld a,0c3h		;4093   ; H.KEYI = jp p00:4023: el juego entero corre en la interrupcion
	ld (0fd9ah),a		;4095
	ld hl,interrupcion		;4098
	ld (0fd9bh),hl		;409b
	ld sp,0f0f0h		;409e   ; la pila, justo debajo de las copias de los bancos
	call slot_del_cartucho		;40a1   ; A = el slot del cartucho
	ld h,080h		;40a4   ; y lo pone tambien en la pagina 2 (0x8000-0xBFFF)
	call 00024h		;40a6   ; BIOS ENASLT - Switches to specified slot and page definitively
	xor a			;40a9   ; los bancos 0, 1, 2 y 3, con sus copias en 0xF0F0-0xF0F3
	ld hl,0f0f0h		;40aa   ; apunta a la copia del banco 0 (nadie la lee) y la cima de la pila
	ld (05000h),a		;40ad
	ld (hl),a			;40b0
	inc hl			;40b1
	inc a			;40b2
	ld (07000h),a		;40b3   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;40b6
	inc hl			;40b7
	inc a			;40b8
	ld (09000h),a		;40b9   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;40bc
	inc hl			;40bd
	inc a			;40be
	ld (hl),a			;40bf
	ld (0b000h),a		;40c0   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0e000h		;40c3   ; la RAM del juego, 0xE000-0xEFFF, a cero
	ld de,0e001h		;40c6
	ld bc,00fffh		;40c9   ; 4 KB
	ld (hl),000h		;40cc
	ldir		;40ce
	ld a,001h		;40d0   ; cuadro en marcha: la interrupcion no lo lanza todavia
	ld (0e1c5h),a		;40d2   ; guarda la marca de cuadro en marcha (si no es 0, la interrupcion no lanza otro)
	inc a			;40d5   ; 0xE1C6 = 2
	ld (0e1c6h),a		;40d6   ; guarda la fase de la siguiente demostracion (2-6)
	call empieza_todo		;40d9   ; p00:5CBD: el VDP y la pantalla
	call 0bcb1h		;40dc   ; p03:BCB1: lo que hay en la otra ranura, y el arranque del juego
	xor a			;40df   ; ya puede la interrupcion lanzar el cuadro
	ld (0e1c5h),a		;40e0   ; guarda la marca de cuadro en marcha (si no es 0, la interrupcion no lanza otro)
	call 0013eh		;40e3   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP para no perder la primera interrupcion
	ei			;40e6
L_40E7:
	jr L_40E7		;40e7   ; y aqui se queda: lo demas lo hace la interrupcion
slot_del_cartucho:		; A = el slot de la pagina 1 (el cartucho) en el formato de ENASLT
	call 00138h		;40e9   ; BIOS RSLREG - Reads the primary slot register | el slot primario de la pagina 1
	rrca			;40ec
	rrca			;40ed
	and 003h		;40ee
	ld c,a			;40f0
	ld b,000h		;40f1
	ld hl,0fcc1h		;40f3   ; EXPTBL: si ese slot esta expandido
	add hl,bc			;40f6
	ld a,(hl)			;40f7
	and 080h		;40f8   ; el bit 7 dice si esta expandido
	or c			;40fa
	ld c,a			;40fb
	inc hl			;40fc   ; SLTTBL del slot (EXPTBL + 4)
	inc hl			;40fd
	inc hl			;40fe
	inc hl			;40ff
	ld a,(hl)			;4100
	and 00ch		;4101   ; el subslot de la pagina 1 (bits 2-3)
	or c			;4103
	ret			;4104
sonido_salto:		; salta a p00:4AE4 (pide el sonido A)
	jp sonido		;4105   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
bancos_1_2_3:		; pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	push af			;4108   ; 1 en 0x6000, 2 en 0x8000, 3 en 0xA000
	ld a,001h		;4109
	jr bancos_desde_a		;410b
bancos_4_5_6:		; pone los bancos 4, 5 y 6 (y sus copias en 0xF0F1-0xF0F3)
	push af			;410d
	ld a,004h		;410e   ; 4 en 0x6000, 5 en 0x8000, 6 en 0xA000
	jr bancos_desde_a		;4110
bancos_7_8_9:		; pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	push af			;4112
	ld a,007h		;4113   ; 7 en 0x6000, 8 en 0x8000, 9 en 0xA000
	jr bancos_desde_a		;4115
bancos_13_14_15:		; pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	push af			;4117
	ld a,00dh		;4118   ; 13 en 0x6000, 14 en 0x8000, 15 en 0xA000
bancos_desde_a:		; pone A, A + 1 y A + 2 en 0x6000, 0x8000 y 0xA000 (y sus copias); conserva AF y HL
	di			;411a
	push hl			;411b
	ld hl,0f0f1h		;411c   ; las copias de los bancos
	ld (07000h),a		;411f   ; el banco de 0x6000 y su copia
	ld (hl),a			;4122
	inc a			;4123
	inc l			;4124
	ld (09000h),a		;4125   ; el siguiente en 0x8000 y su copia
	ld (hl),a			;4128
	inc a			;4129
	inc l			;412a
	ld (0b000h),a		;412b   ; el siguiente en 0xA000 y su copia
	ld (hl),a			;412e
	pop hl			;412f
	pop af			;4130
	ei			;4131
	ret			;4132
banco_10:		; pone el banco 10 en 0xA000 (y 0xF0F3)
	ld a,00ah		;4133
	jr banco_a_en_a000		;4135
banco_11:		; pone el banco 11 en 0xA000 (y 0xF0F3)
	ld a,00bh		;4137
	jr banco_a_en_a000		;4139
banco_12:		; pone el banco 12 en 0xA000 (y 0xF0F3)
	ld a,00ch		;413b
	jr banco_a_en_a000		;413d
banco_15:		; pone el banco 15 en 0xA000 (y 0xF0F3)
	ld a,00fh		;413f
	jp banco_a_en_a000		;4141   ; banco_a_en_a000: pone el banco A en 0xA000 (y 0xF0F3)
banco_9:		; pone el banco 9 en 0xA000 (y 0xF0F3)
	ld a,009h		;4144
	jp banco_a_en_a000		;4146   ; banco_a_en_a000: pone el banco A en 0xA000 (y 0xF0F3)
banco_6:		; pone el banco 6 en 0xA000 (y 0xF0F3)
	ld a,006h		;4149
	jp banco_a_en_a000		;414b   ; banco_a_en_a000: pone el banco A en 0xA000 (y 0xF0F3)
banco_a_en_a000:		; pone el banco A en 0xA000 (y 0xF0F3)
	di			;414e
	ld (0b000h),a		;414f   ; el banco A en 0xA000 y su copia
	ld (0f0f3h),a		;4152   ; guarda la copia del banco de 0xA000
	ei			;4155
	ret			;4156
bancos_2_3:		; pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,002h		;4157
	jr bancos_a_y_siguiente		;4159
bancos_14_15:		; pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,00eh		;415b
bancos_a_y_siguiente:		; pone A y A + 1 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	di			;415d
	ld (09000h),a		;415e   ; el banco A en 0x8000 y su copia
	ld (0f0f2h),a		;4161   ; guarda la copia del banco de 0x8000
	inc a			;4164
	ld (0b000h),a		;4165   ; y el siguiente en 0xA000
	ld (0f0f3h),a		;4168   ; guarda la copia del banco de 0xA000
	ei			;416b
	ret			;416c
cuadro_de_juego:		; un cuadro de partida: si se esta pintando el interior (0xE1DC) solo eso; si no, scroll, nave, armas, enemigos, jefe y marcador, banco a banco
	ld a,(0e1dch)		;416d   ; lee la marca de interior por pintar (fase 8)
	and a			;4170   ; se esta pintando el interior?
	jr z,L_417F		;4171
	call bancos_7_8_9		;4173   ; el interior se pinta con los bancos 7-8-9
	call aparece_el_interior		;4176   ; aparece_el_interior: la fase 8 se pinta en tres cuadros (0xE1DD): caracteres a cero, luego cada vez mas bits de sus dibujos (mascara 0xE1DF) y por ultimo enteros
	call bancos_1_2_3		;4179   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	jp 077f1h		;417c   ; p01:77F1, y no hay mas cuadro
L_417F:
	call fin_de_cuenta_atras		;417f   ; p00:54DC
	xor a			;4182
	ld (0e307h),a		;4183   ; guarda la marca de disparo en este cuadro (uno solo)
	ld (0e308h),a		;4186   ; guarda la marca del ruido de rotura en este cuadro
	ld (0e309h),a		;4189   ; guarda la marca del ruido de choque en este cuadro
	call 077b6h		;418c   ; p01:77B6
	call 07a2eh		;418f   ; p01:7A2E
	ld a,(0e1dah)		;4192   ; lee la marca del estado 8
	and a			;4195
	ret nz			;4196   ; si 0xE1DA no es cero, aqui se queda el cuadro
	call 07c90h		;4197   ; p01:7C90
	call 0bf3ah		;419a   ; p03:BF3A
	call bancos_13_14_15		;419d   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	call paso_de_scroll		;41a0   ; el scroll, con los bancos del mapa
	call bancos_1_2_3		;41a3   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call 074a2h		;41a6   ; p01:74A2: el final de la fase 8 (YOU CAPTURED)
	ld a,(0e3c1h)		;41a9   ; lee la marca de la nave ida
	or a			;41ac
	ret nz			;41ad   ; si esta en marcha, no hay mas cuadro
	call 0be97h		;41ae
	call 0a765h		;41b1
	call 07d4fh		;41b4   ; usa_el_medidor: con el otro boton recien pulsado y una casilla encendida que no este gastada, la usa (p01:7D8D por armas capturadas) y suena 6
	call 0aa53h		;41b7
	call 0aa9bh		;41ba
	call 0ab15h		;41bd
	call 0abe5h		;41c0
	call 0ab92h		;41c3
	call 08592h		;41c6   ; nucleo_con_el_scroll: el nucleo del interior se corre 8 pixeles con el scroll; al salir, desaparece
	call 08570h		;41c9   ; aparece_el_nucleo: en el interior, en la columna 0x7F: el nucleo (0xEA90) en Y 0x40, X 0xE0, con 24 golpes
	call 085a9h		;41cc   ; disparos_al_nucleo: cada disparo de la nave contra el nucleo del interior (p02:85C6)
	call 08653h		;41cf   ; nave_pasa_el_nucleo: al pasar la nave la X del nucleo, empieza el final del interior (0xE3C0 = 1), sin enemigos y suena 0xF1
	ld a,(0e3aah)		;41d2   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;41d5   ; con 0xE3AA puesto se salta este grupo
	jr nz,L_41E4		;41d6
	call 06385h		;41d8   ; mueve_enemigos: las 12 fichas de 0xE600: lo de su tipo (p01:63AE), el scroll (p01:6486) y su velocidad (p01:64BE)
	call 092c1h		;41db   ; mueve_balas: las 10 balas de 0xE900 (con E.SLOW, cuadro si cuadro no): suman su velocidad; fuera de la pantalla, libres
	call 06d47h		;41de   ; apariciones_de_enemigos: cada cuadro: torretas, la lista de la fase (p14:9A67), las oleadas y los de relleno de la zona (p14:99C7); nada en el final de la fase 8 ni con 0xE3D0
	call 07274h		;41e1   ; apariciones_de_bloques_scroll: si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
L_41E4:
	call 08526h		;41e4   ; capsula_con_el_scroll: la capsula especial del mapa se corre 8 pixeles con el scroll; al salir, desaparece
	call apariciones_del_scroll		;41e7   ; apariciones_del_scroll: si el scroll avanzo (0xE320), lo que trae la columna nueva (X = 0xF8)
	call 09034h		;41ea   ; recoge_capsula_especial: la nave coge la capsula especial del mapa (clase 3 o mas): suena 0x1F, 0x0030 puntos y 15 segundos de D.VARRIOR (3), R.DRILL (4), E.SLOW (5) o VECTOR (7)
	ld a,(0e201h)		;41ed   ; lee la fase (0-11)
	dec a			;41f0   ; la fase 1 tiene algo mas: p11:B193
	jr nz,L_41FC		;41f1
	call banco_11		;41f3   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b193h		;41f6
	call bancos_2_3		;41f9   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
L_41FC:
	call 06b85h		;41fc   ; mueve_piezas: sin jefe con partes, en las fases 3 y 9-11, las 16 piezas de 0xE580 (p01:6BA4)
	call 06acch		;41ff   ; apariciones_de_piezas_scroll: si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	call banco_11		;4202   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b4aah		;4205
	call 0b422h		;4208
	call bancos_2_3		;420b   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 0a04dh		;420e
	call 072d6h		;4211   ; suceso_e34b: el paso del suceso 0xE34B (4, p01:72DF): las dos piezas de 0xEA70, sus rocas, los puntos, 0xE3AA y p11:A2A2
	call 0781ch		;4214   ; final_de_fase_0: el paso 0xEA98 del final de la fase 0 (p01:7827)
	call 0927ah		;4217   ; disparos_al_nucleo_de_fase_0: con el final de la fase 0 en marcha, su nucleo (0xEA99) contra los disparos
	call 07930h		;421a   ; cuenta_objetos: 0xE3B2 = hasta donde hay fichas ocupadas en 0xE500 (8 de 16 bytes)
	call 07946h		;421d   ; mueve_objetos: sin jefe con partes, cada objeto de caracteres de 0xE500: lo de su clase, si se ve, y el scroll
	call 087a4h		;4220   ; apariciones_de_objetos_scroll: si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	call 08678h		;4223   ; mueve_explosiones: las 4 explosiones de 4x4 caracteres de 0xEA40 (8 bytes): cada 4 cuadros un paso, y el scroll
	call 06790h		;4226   ; cuadro_del_jefe: con un jefe (0xE340), un cuadro mas de pelea (0xE346, sin pasar de 0xFFFF) y lo de su tipo (p11, 5 tipos)
	call banco_11		;4229   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	ld a,(0e201h)		;422c   ; lee la fase (0-11)
	dec a			;422f   ; en la fase 1, p11:B2CE
	call z,0b2ceh		;4230
	call bancos_2_3		;4233   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 067b9h		;4236   ; partes_del_jefe: si p01:6878 no da Z, con el banco 9, p01:67CE con C = 1
	call 08be3h		;4239   ; disparos_a_piezas: sin jefe, en las fases 3 y 9-11, las piezas de 0xE580 contra los disparos
	call 08c86h		;423c   ; disparos_a_piezas_fase_5: sin jefe, en la fase 5, las dos piezas de 0xE580 y 0xE590 contra los disparos
	ld a,(0e3aah)		;423f   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;4242
	jr nz,L_425D		;4243
	call 090c6h		;4245   ; disparos_al_suceso: con el suceso de 0xE34B, sus dos piezas contra los disparos
	call 09167h		;4248   ; disparos_al_jefe: las partes que se pueden golpear del jefe (0xEA00, y 0xEA20 con el 5) contra los disparos
	call 088a2h		;424b   ; disparos_a_enemigos: cada enemigo que se puede tocar (IX+10 bit 1) contra los 9 disparos de la nave
	call 08a43h		;424e   ; disparos_a_objetos: sin jefe, cada objeto de caracteres de 0xE500 contra los 9 disparos de la nave
	call 08df9h		;4251   ; escudo_contra_enemigos: con escudo, el enemigo que lo toca cae y le quita un golpe; los que no caen (0x20, bloques, 0x22-0x24, 0x38-0x3C) se lo llevan entero
	call 08db4h		;4254   ; escudo_contra_balas: con escudo, las balas que llegan por delante se quedan en el y le quitan un golpe
	call 08e43h		;4257   ; nave_contra_enemigos: el enemigo que toca a la nave: los 0x29-0x2E se recogen (p02:8F67), los demas caen y la nave tambien
	call 08d5eh		;425a   ; nave_contra_balas: si una de las 10 balas de 0xE900 toca a la nave (12 x 8 pixeles), la bala se va y la nave cae
L_425D:
	call objetos_5fdf		;425d   ; objetos_5fdf: si p01:6878 da Z, con el banco 15, p00:5FDF
	call 08413h		;4260   ; nave_contra_el_mapa: si la nave toca el mapa cae (p02:8E7C); el R.DRILL rompe lo que se puede romper (p02:8481) y solo cae con lo demas
	call 092f6h		;4263   ; balas_contra_el_mapa: las balas (sin el bit 7 en el tipo) que tocan el mapa desaparecen
	call 081dah		;4266   ; mueve_disparos: los 9 disparos de la nave (0xE470, 16 bytes; IY): lo de su tipo (p02:81FB)
	ld a,(0e3aah)		;4269   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;426c
	call z,07a00h		;426d   ; enemigos_contra_el_mapa: los tipos 0x1D, 0x20 y 0x22 (sin IX+2F) se quitan al tocar el mapa (p02:9317)
	call 06cedh		;4270   ; pinta_piezas: sin jefe con partes, en las fases 3 y 9-11, con los bancos 14-15, cada pieza en la pantalla de RAM (p01:6D11)
	call 06c48h		;4273   ; caen_las_piezas: sin jefe con partes, en las fases 3 y 9-11, las 16 piezas de 0xE580 (p01:6C67)
	call banco_11		;4276   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b53ah		;4279
	call bancos_2_3		;427c   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 0853eh		;427f   ; pinta_capsula: la capsula especial: 2x2 caracteres desde el 0xE9 en la pantalla de RAM (sitio en 0xEA63)
	call 086b1h		;4282   ; guarda_fondo_explosiones: el fondo de 4x4 caracteres bajo cada explosion a 0xECC0 (16 bytes cada una) y su sitio
	call banco_11		;4285   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0bd47h		;4288
	call 0a0d6h		;428b
	call bancos_2_3		;428e   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call bancos_2_3		;4291   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 0872ah		;4294   ; pinta_explosiones: cada explosion: los 4x4 caracteres de su paso (p02:8762) en la pantalla de RAM
	call sprites_de_enemigos		;4297   ; sprites_de_enemigos: si no esta 0xE3AA, los enemigos de 0xE600 a sprites (0xE2A8) o a caracteres, con los bancos 7-8-9
	call sprites_de_balas		;429a   ; sprites_de_balas: los atributos de sprite de las 10 fichas de 0xE900 (Y, X, dibujo, color) a 0xE2D8; las libres con Y = 0xE0
	call banco_11		;429d   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a000h		;42a0
	call 0a088h		;42a3
	call 0a206h		;42a6
	call bancos_2_3		;42a9   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call banco_9		;42ac   ; el banco 9 en 0xA000 para p01:6A27
	call 06a27h		;42af   ; anima_el_fondo: sin jefe, un caracter animado de la fase (p09:B901): fichas de 10 bytes [caracter][tercios][8 bytes], una por cuadro (0xE3BB)
	call bancos_1_2_3		;42b2   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call estrellas_titilan		;42b5   ; estrellas_titilan: los dibujos de las estrellas (caracteres 0xFE y 0xFF de los tres tercios) segun 0xE202 y la mascara de p00:49E0
	call 077f1h		;42b8
	call banco_11		;42bb   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a16ah		;42be
	call 0bdcdh		;42c1
	call bancos_2_3		;42c4   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 086f1h		;42c7   ; repone_fondo_explosiones: devuelve el fondo de 0xECC0 bajo cada explosion
	call 06826h		;42ca   ; quita_partes_del_jefe: si hay jefe con partes, con el banco 9 las borra (C = 0) y vuelve a poner las estrellas
	call 08555h		;42cd   ; borra_capsula: borra los 2x2 caracteres de la capsula especial
	call objetos_5f84		;42d0   ; objetos_5f84: si p01:6878 da Z, con el banco 15, p00:5F84
	ld a,(0e1c3h)		;42d3   ; 1 de cada 8 cuadros: p00:5BBB
	and 007h		;42d6
	dec a			;42d8
	jp z,pinta_los_puntos		;42d9   ; pinta_los_puntos: el record (0xE1F4 en 0x3AF6) y los del jugador en turno (0x3AE9)
	ret			;42dc
sprites_de_la_nave_normal:		; con los bancos 7-8-9, p08:9FF4 y p08:A063 a 0x1800 y 0x1960
	call bancos_7_8_9		;42dd   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	ld hl,01800h		;42e0   ; los dibujos de sprite de la nave, a partir del sprite 0
	ld de,09ff4h		;42e3
	call descomprime_a_vram		;42e6   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	ld hl,01960h		;42e9   ; y los del sprite 44 (0x1960)
	ld de,0a063h		;42ec
	call descomprime_a_vram		;42ef   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	jp bancos_1_2_3		;42f2   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_r_drill:		; con los bancos 7-8-9, los dibujos del R.DRILL (p00:42FE)
	call bancos_7_8_9		;42f5   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_r_drill_sin_bancos		;42f8   ; sprites_r_drill_sin_bancos: p08:9D17 y p08:9D68 a 0x1800 y 0x1960: la nave R.DRILL
	jp bancos_1_2_3		;42fb   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_r_drill_sin_bancos:		; p08:9D17 y p08:9D68 a 0x1800 y 0x1960: la nave R.DRILL
	ld hl,01800h		;42fe
	ld de,09d17h		;4301
	call descomprime_a_vram		;4304   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	ld hl,01960h		;4307
	ld de,09d68h		;430a
	jp descomprime_a_vram		;430d   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
caracter_e9:		; con los bancos 7-8-9, el caracter 0xE9 en los tres tercios desde la ficha C de p08:9094
	call bancos_7_8_9		;4310   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call caracter_e9_sin_bancos		;4313   ; caracter_e9_sin_bancos: ficha C de p08:9094 (4 bytes: dibujos y colores) al caracter 0xE9 de los tres tercios
	jp bancos_1_2_3		;4316   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
caracter_e9_sin_bancos:		; ficha C de p08:9094 (4 bytes: dibujos y colores) al caracter 0xE9 de los tres tercios
	ld a,c			;4319   ; cuatro bytes por ficha
	add a,a			;431a
	add a,a			;431b
	ld hl,09094h		;431c
	call hl_mas_a		;431f   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;4322   ; DE = los dibujos
	inc hl			;4323
	ld d,(hl)			;4324
	push hl			;4325
	ld hl,02748h		;4326   ; al caracter 0xE9 de los tres tercios
	call descomprime_x3		;4329   ; descomprime_x3: descomprime DE a la VRAM HL en los tres tercios
	pop hl			;432c
	inc hl			;432d
	ld e,(hl)			;432e   ; DE = los colores
	inc hl			;432f
	ld d,(hl)			;4330
	ld hl,00748h		;4331   ; a los colores del caracter 0xE9
	jp descomprime_x3		;4334   ; descomprime_x3: descomprime DE a la VRAM HL en los tres tercios
caracteres_de_la_nave:		; pinta los caracteres de la nave: p00:4358 (con los bancos 7-8-9), o p11:BFBF si al lado esta Penguin Adventure (0xF0F5 bit 2)
	push ix		;4337
	ld a,(0f0f5h)		;4339   ; lee lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	bit 2,a		;433c   ; con Penguin Adventure, la lista de p11:BFBF
	jr z,L_4349		;433e
	call banco_11		;4340   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	ld ix,0bfbfh		;4343
	jr L_4350		;4347
L_4349:
	call bancos_7_8_9		;4349   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	ld ix,04358h		;434c   ; si no, la de p00:4358
L_4350:
	call pon_caracteres		;4350   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	pop ix		;4353
	jp bancos_1_2_3		;4355   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)

; ----------------------------------------------------------------------
; DATOS caracteres_4358: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p00:4350 (7 bytes)
;   0x4358..0x435f  (7 bytes)
DATA_caracteres_4358:
	defb 007h,03ah,092h,0c7h,05ch,092h	; 4358
	defb 000h	; 435e

; ======================================================================
; CODIGO 0x435f..0x44ea  (395 bytes)
; ======================================================================


sprites_de_la_nave:		; con los bancos 7-8-9, los dibujos de sprite de la nave (p00:4368)
	call bancos_7_8_9		;435f   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_de_la_nave_sin_bancos		;4362   ; sprites_de_la_nave_sin_bancos: dibujos de la nave a 0x1800 y 0x1960 (p08:936F, p08:942B), o el pinguino (p12:BF19) con Penguin Adventure al lado
	jp bancos_1_2_3		;4365   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_de_la_nave_sin_bancos:		; dibujos de la nave a 0x1800 y 0x1960 (p08:936F, p08:942B), o el pinguino (p12:BF19) con Penguin Adventure al lado
	ld a,(0f0f5h)		;4368   ; lee lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	bit 2,a		;436b   ; con Penguin Adventure al lado, el pinguino
	jr nz,L_4381		;436d
	ld hl,01800h		;436f   ; la nave, a partir del sprite 0
	ld de,0936fh		;4372
	call descomprime_a_vram		;4375   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	ld hl,01960h		;4378   ; y desde el sprite 44
	ld de,0942bh		;437b
	jp descomprime_a_vram		;437e   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
L_4381:
	call banco_12		;4381   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld hl,01800h		;4384   ; el pinguino a partir del sprite 0
	ld de,0bf19h		;4387
	call descomprime_a_vram		;438a   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	ld hl,019e0h		;438d   ; y desde el sprite 60 (0x19E0)
	ld de,0bf82h		;4390
	jp descomprime_a_vram		;4393   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
carga_graficos_de_fase:		; con los bancos 11 y 7-8-9: p11:B736 y luego caracteres y sprites de la fase (p00:43A5)
	call banco_11		;4396   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b736h		;4399   ; p11:B736
	call bancos_7_8_9		;439c   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call caracteres_y_sprites		;439f   ; caracteres_y_sprites: los caracteres de la fase (p00:44F7), los de la nave, sus sprites y los de la fase
	jp bancos_1_2_3		;43a2   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
caracteres_y_sprites:		; los caracteres de la fase (p00:44F7), los de la nave, sus sprites y los de la fase
	call caracteres_de_fase		;43a5   ; caracteres_de_fase: los caracteres de la fase 0xE201 (listas de p07:6000, p07:6018 y p07:6030); la 8 la deja para p00:46C4
	call caracteres_de_la_nave		;43a8   ; caracteres_de_la_nave: pinta los caracteres de la nave: p00:4358 (con los bancos 7-8-9), o p11:BFBF si al lado esta Penguin Adventure (0xF0F5 bit 2)
	call bancos_7_8_9		;43ab   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_de_armas		;43ae   ; sprites_de_armas: la nave, las opciones (p08:93C0), el R.DRILL si esta (0xE400 = 3), el escudo si 0xE432 = 5 y p08:94B8 a 0x1A20
	call sprites_volteados		;43b1   ; sprites_volteados: las copias de sprite de p00:44EA, los sprites de la fase (p00:44C7) y las copias de la fase (p08:9348)
caracteres_del_pinguino:		; con Penguin Adventure al lado (0xF0F5 bit 2), los caracteres de p11:BF63
	ld a,(0f0f5h)		;43b4   ; lee lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	bit 2,a		;43b7
	ret z			;43b9
	call banco_11		;43ba   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	ld ix,0bf63h		;43bd   ; los caracteres del pinguino
	jp pon_caracteres		;43c1   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
sprites_volteados:		; las copias de sprite de p00:44EA, los sprites de la fase (p00:44C7) y las copias de la fase (p08:9348)
	ld ix,044eah		;43c4   ; las copias de siempre
	call copias_de_sprite		;43c8   ; copias_de_sprite: lista IX de fichas [tipo][cuantos][origen][destino] (tipo 0 acaba): tipo 1 cabeza abajo, 2 espejo
	call sprites_de_la_fase		;43cb   ; sprites_de_la_fase: los dibujos de sprite de la fase 0xE201 (lista p08:92B3: [sprite][origen], 0 acaba)
	ld hl,09348h		;43ce   ; y las de la fase: la lista de p08:9348 que toca
	ld a,(0e201h)		;43d1   ; lee la fase (0-11)
	call palabra_a		;43d4   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	push de			;43d7
	pop ix		;43d8
copias_de_sprite:		; lista IX de fichas [tipo][cuantos][origen][destino] (tipo 0 acaba): tipo 1 cabeza abajo, 2 espejo
	ld a,(ix+000h)		;43da   ; el tipo: 0 acaba, 1 cabeza abajo, 2 espejo
	dec a			;43dd
	ret m			;43de
	push af			;43df
	call z,sprites_cabeza_abajo		;43e0   ; sprites_cabeza_abajo: copia IX+01 dibujos de sprite de IX+02 a IX+03 cabeza abajo
	pop af			;43e3
	call nz,sprites_espejo		;43e4   ; sprites_espejo: copia IX+01 dibujos de sprite de IX+02 a IX+03 de izquierda a derecha
	ld bc,00004h		;43e7
	add ix,bc		;43ea
	jr copias_de_sprite		;43ec
sprites_cabeza_abajo:		; copia IX+01 dibujos de sprite de IX+02 a IX+03 cabeza abajo
	ld a,(ix+001h)		;43ee   ; IX+01: cuantos sprites
	or a			;43f1
	ret z			;43f2
	ld (0f010h),a		;43f3   ; guarda variable de paso: la lista
	ld l,(ix+002h)		;43f6   ; IX+02: el sprite de origen, x 8 + 0x1800
	ld h,000h		;43f9
	add hl,hl			;43fb
	add hl,hl			;43fc
	add hl,hl			;43fd
	ld bc,01800h		;43fe
	add hl,bc			;4401
	ld (0f012h),hl		;4402   ; guarda la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	ld l,(ix+003h)		;4405   ; IX+03: el de destino
	ld h,000h		;4408
	add hl,hl			;440a
	add hl,hl			;440b
	add hl,hl			;440c
	add hl,bc			;440d
	ld (0f014h),hl		;440e   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
L_4411:
	ld hl,(0f012h)		;4411   ; lee los 32 bytes del sprite
	ld de,0e600h		;4414   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld bc,00020h		;4417
	call 00059h		;441a   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call da_la_vuelta_e600		;441d   ; les da la vuelta
	ld hl,(0f014h)		;4420   ; y los escribe en el de destino
	ld de,0e620h		;4423   ; apunta a el bufer de graficos, segunda mitad
	ld bc,00020h		;4426
	call copia_a_vram		;4429   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld bc,00020h		;442c   ; los dos al sprite siguiente
	ld hl,(0f012h)		;442f   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	add hl,bc			;4432
	ld (0f012h),hl		;4433   ; guarda la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,(0f014h)		;4436   ; lee la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	add hl,bc			;4439
	ld (0f014h),hl		;443a   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,0f010h		;443d   ; apunta a variable de paso: la lista
	dec (hl)			;4440   ; cuantos quedan
	jr nz,L_4411		;4441
	ret			;4443
da_la_vuelta_e600:		; copia 0xE600-0xE61F a 0xE620-0xE63F con las filas al reves (las dos mitades del sprite)
	ld hl,0e600h		;4444   ; la mitad izquierda, 16 filas al reves
	ld de,0e62fh		;4447
	ld b,010h		;444a
	call copia_al_reves		;444c   ; copia_al_reves: copia B bytes de HL hacia delante a DE hacia atras
	ld hl,0e610h		;444f   ; y la derecha
	ld de,0e63fh		;4452
	ld b,010h		;4455
copia_al_reves:		; copia B bytes de HL hacia delante a DE hacia atras
	ld a,(hl)			;4457   ; un byte hacia delante
	ld (de),a			;4458   ; al otro hacia atras
	inc hl			;4459
	dec de			;445a
	djnz copia_al_reves		;445b
	ret			;445d
sprites_espejo:		; copia IX+01 dibujos de sprite de IX+02 a IX+03 de izquierda a derecha
	ld a,(ix+001h)		;445e
	or a			;4461
	ret z			;4462
	ld l,(ix+003h)		;4463   ; el destino: IX+03 x 8 + 0x1810 (empieza por la mitad derecha)
	ld h,000h		;4466
	add hl,hl			;4468
	add hl,hl			;4469
	add hl,hl			;446a
	ld bc,01810h		;446b
	add hl,bc			;446e
	ex de,hl			;446f
	ld l,(ix+002h)		;4470   ; el origen: IX+02 x 8 + 0x1800
	ld h,000h		;4473
	add hl,hl			;4475
	add hl,hl			;4476
	add hl,hl			;4477
	ld bc,01800h		;4478
	add hl,bc			;447b
	ld c,(ix+001h)		;447c   ; IX+01 sprites
	jp espejo_de_sprites		;447f   ; espejo_de_sprites: copia C dibujos de sprite de 16x16 de la VRAM HL a la DE dados la vuelta de izquierda a derecha
sprites_escudo:		; con los bancos 7-8-9, p08:93EE a 0x18C0
	call bancos_7_8_9		;4482   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	ld de,093eeh		;4485   ; el escudo, desde el sprite 24
	call sprites_desde_el_24		;4488   ; sprites_desde_el_24: descomprime DE desde el sprite 24 (0x18C0)
	jp bancos_1_2_3		;448b   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_opcion:		; con los bancos 7-8-9, p08:93C0 a 0x18C0
	call bancos_7_8_9		;448e   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_opcion_sin_bancos		;4491   ; sprites_opcion_sin_bancos: p08:93C0 (las opciones) desde el sprite 24 (0x18C0)
	jp bancos_1_2_3		;4494   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_opcion_sin_bancos:		; p08:93C0 (las opciones) desde el sprite 24 (0x18C0)
	ld de,093c0h		;4497   ; las opciones, desde el sprite 24
sprites_desde_el_24:		; descomprime DE desde el sprite 24 (0x18C0)
	ld hl,018c0h		;449a
	jp descomprime_a_vram		;449d   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
sprites_de_armas:		; la nave, las opciones (p08:93C0), el R.DRILL si esta (0xE400 = 3), el escudo si 0xE432 = 5 y p08:94B8 a 0x1A20
	call sprites_de_la_nave_sin_bancos		;44a0   ; la nave
	call bancos_7_8_9		;44a3   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_opcion_sin_bancos		;44a6   ; sprites_opcion_sin_bancos: p08:93C0 (las opciones) desde el sprite 24 (0x18C0)
	ld a,(0e400h)		;44a9   ; lee la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	cp 003h		;44ac   ; con el R.DRILL, sus dibujos en lugar de la nave
	call z,sprites_r_drill_sin_bancos		;44ae   ; sprites_r_drill_sin_bancos: p08:9D17 y p08:9D68 a 0x1800 y 0x1960: la nave R.DRILL
	ld a,(0e432h)		;44b1   ; lee el arma elegida en el medidor
	cp 005h		;44b4   ; el arma 5 del medidor
	jr nz,L_44BE		;44b6
	ld de,093eeh		;44b8   ; cambia las opciones por el escudo
	call sprites_desde_el_24		;44bb   ; sprites_desde_el_24: descomprime DE desde el sprite 24 (0x18C0)
L_44BE:
	ld hl,01a20h		;44be   ; y desde el sprite 68, p08:94B8
	ld de,094b8h		;44c1
	jp descomprime_a_vram		;44c4   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
sprites_de_la_fase:		; los dibujos de sprite de la fase 0xE201 (lista p08:92B3: [sprite][origen], 0 acaba)
	ld a,(0e201h)		;44c7   ; lee la fase (0-11)
	ld hl,092b3h		;44ca   ; la lista de la fase
	call palabra_a		;44cd   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;44d0
L_44D1:
	ld a,(hl)			;44d1   ; [sprite][dibujos], el sprite 0 acaba
	or a			;44d2
	ret z			;44d3
	inc hl			;44d4
	ld e,(hl)			;44d5
	inc hl			;44d6
	ld d,(hl)			;44d7
	inc hl			;44d8
	push hl			;44d9
	ld l,a			;44da   ; el sprite x 8 + 0x1800
	ld h,000h		;44db
	add hl,hl			;44dd
	add hl,hl			;44de
	add hl,hl			;44df
	ld bc,01800h		;44e0
	add hl,bc			;44e3
	call descomprime_a_vram		;44e4   ; descomprime sus dibujos
	pop hl			;44e7
	jr L_44D1		;44e8

; ----------------------------------------------------------------------
; DATOS copias_44EA: lista de p00:43DA (fichas
;   [tipo][cuantos][origen][destino], tipo 0 acaba) que p00:43C4 pasa en IX;
;   lo leen p00:43C8 (13 bytes)
;   0x44ea..0x44f7  (13 bytes)
DATA_copias_44EA:
	defb 001h,003h,074h,080h	; 44ea
	defb 002h,003h,080h,08ch	; 44ee
	defb 001h,003h,08ch,098h	; 44f2
	defb 000h	; 44f6

; ======================================================================
; CODIGO 0x44f7..0x494a  (1107 bytes)
; ======================================================================


caracteres_de_fase:		; los caracteres de la fase 0xE201 (listas de p07:6000, p07:6018 y p07:6030); la 8 la deja para p00:46C4
	ld a,(0e201h)		;44f7   ; lee la fase (0-11)
	cp 008h		;44fa   ; la fase 8 (el interior) se pinta poco a poco
	jr nz,L_451E		;44fc
	ld ix,06048h		;44fe   ; los caracteres de siempre (p07:6048)
	call pon_caracteres		;4502   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	ld hl,00001h		;4505   ; 0xE1DC = 1 y 0xE1DD = 0: el interior, paso 0
	ld (0e1dch),hl		;4508   ; guarda la marca de interior por pintar (fase 8) y el byte siguiente (16 bits)
	ld hl,061ddh		;450b   ; las listas del interior en el banco 7
	ld (0e1e0h),hl		;450e   ; guarda la lista de caracteres del interior y el byte siguiente (16 bits)
	ld hl,06281h		;4511
	ld (0e1e2h),hl		;4514   ; guarda la lista de copias en espejo del interior y el byte siguiente (16 bits)
	ld hl,064a7h		;4517
	ld (0e1e4h),hl		;451a   ; guarda la lista de copias cabeza abajo del interior y el byte siguiente (16 bits)
	ret			;451d
L_451E:
	ld ix,06048h		;451e   ; los caracteres de siempre (p07:6048)
	call pon_caracteres		;4522   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	ld a,(0e201h)		;4525   ; los de la fase: p07:6000 + 2 x fase
	ld hl,06000h		;4528
	call palabra_a		;452b   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	push de			;452e
	pop ix		;452f
	call pon_caracteres		;4531   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;4534   ; las copias en espejo (p07:6018 + 2 x fase)
	ld (0f000h),a		;4535   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld hl,06018h		;4538
	call copias_de_la_fase		;453b   ; copias_de_la_fase: las copias de caracteres de la fase de la tabla HL (una lista por fase)
	ld hl,0f000h		;453e   ; y las de cabeza abajo (p07:6030 + 2 x fase)
	inc (hl)			;4541
	ld hl,06030h		;4542
copias_de_la_fase:		; las copias de caracteres de la fase de la tabla HL (una lista por fase)
	ld a,(0e201h)		;4545   ; lee la fase (0-11)
	call palabra_a		;4548   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	push de			;454b
	pop ix		;454c
copia_caracteres:		; lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,(ix+000h)		;454e   ; 0 acaba
	and a			;4551
	ret z			;4552
	ld a,(ix+002h)		;4553   ; los bits 7-6 del tercer byte: si no son cero, ese es el numero
	rlca			;4556
	rlca			;4557
	and 003h		;4558
	jr nz,L_456D		;455a
	ld l,(ix+003h)		;455c   ; si no, el cuarto byte lo es
	ld a,l			;455f
	ld (0f003h),a		;4560   ; guarda variable de paso: cuantos caracteres
	call copia_volteando		;4563   ; copia_volteando: lee L caracteres a 0xE600/0xE800, les da la vuelta (0xF000) y los escribe en su sitio
	ld de,00004h		;4566   ; ficha de 4 bytes
	add ix,de		;4569
	jr copia_caracteres		;456b
L_456D:
	ld l,a			;456d
	ld (0f003h),a		;456e   ; guarda variable de paso: cuantos caracteres
	call copia_volteando		;4571   ; copia_volteando: lee L caracteres a 0xE600/0xE800, les da la vuelta (0xF000) y los escribe en su sitio
	ld de,00003h		;4574   ; ficha de 3 bytes
	add ix,de		;4577
	jr copia_caracteres		;4579
copia_volteando:		; lee L caracteres a 0xE600/0xE800, les da la vuelta (0xF000) y los escribe en su sitio
	ld h,000h		;457b   ; los caracteres x 8 = los bytes
	add hl,hl			;457d
	add hl,hl			;457e
	add hl,hl			;457f
	ld (0f001h),hl		;4580   ; guarda variable de paso: cuantos bytes y el byte siguiente (16 bits)
	call lee_caracteres		;4583   ; lee el origen
	ld a,(0f000h)		;4586   ; el sentido: 0 espejo, si no cabeza abajo
	and a			;4589
	push af			;458a
	call z,espejo_de_caracteres		;458b   ; espejo_de_caracteres: da la vuelta de izquierda a derecha a los 0xF001 bytes de 0xE600
	pop af			;458e
	call nz,cabeza_abajo		;458f   ; cabeza_abajo: da la vuelta de arriba abajo a los caracteres de 0xE600 y 0xE800 (0xF003 de ellos)
	jp escribe_volteados		;4592   ; y lo escribe en el destino
pon_caracteres:		; pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	ld a,(ix+000h)		;4595   ; 0 acaba
	and a			;4598
	ret z			;4599
	rra			;459a   ; bit 0: el tercio de abajo (0x1000)
	ld de,01000h		;459b
	call c,pon_un_caracter		;459e   ; pon_un_caracter: un grupo de la ficha IX en el tercio DE: dibujos a 0x2000 + DE y colores a DE
	bit 1,(ix+000h)		;45a1   ; bit 1: el del medio (0x0800)
	ld de,00800h		;45a5
	call nz,pon_un_caracter		;45a8   ; pon_un_caracter: un grupo de la ficha IX en el tercio DE: dibujos a 0x2000 + DE y colores a DE
	bit 2,(ix+000h)		;45ab   ; bit 2: el de arriba (0x0000)
	ld de,00000h		;45af
	call nz,pon_un_caracter		;45b2   ; pon_un_caracter: un grupo de la ficha IX en el tercio DE: dibujos a 0x2000 + DE y colores a DE
	ld de,00006h		;45b5   ; ficha de 6 bytes
	add ix,de		;45b8
	jr pon_caracteres		;45ba
pon_un_caracter:		; un grupo de la ficha IX en el tercio DE: dibujos a 0x2000 + DE y colores a DE
	ld l,(ix+003h)		;45bc   ; IX+03: el caracter, x 8 + el tercio
	ld h,000h		;45bf
	add hl,hl			;45c1
	add hl,hl			;45c2
	add hl,hl			;45c3
	add hl,de			;45c4
	push hl			;45c5
	ld de,02000h		;45c6   ; los dibujos, en 0x2000
	add hl,de			;45c9
	ld e,(ix+001h)		;45ca   ; IX+01/IX+02: los dibujos comprimidos
	ld d,(ix+002h)		;45cd
	push ix		;45d0
	call descomprime_a_vram		;45d2   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	pop ix		;45d5
	pop hl			;45d7
	ld de,00000h		;45d8   ; los colores, en 0x0000
	add hl,de			;45db
	ld e,(ix+004h)		;45dc   ; IX+04/IX+05: los colores comprimidos
	ld d,(ix+005h)		;45df
	push ix		;45e2
	call descomprime_a_vram		;45e4   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	pop ix		;45e7
	ret			;45e9
cabeza_abajo:		; da la vuelta de arriba abajo a los caracteres de 0xE600 y 0xE800 (0xF003 de ellos)
	ld hl,0e600h		;45ea   ; los dibujos
	ld de,0e607h		;45ed
	call cabeza_abajo_de		;45f0   ; cabeza_abajo_de: da la vuelta de arriba abajo a 0xF003 caracteres de HL (DE = HL + 7)
	ld hl,0e800h		;45f3   ; y los colores
	ld de,0e807h		;45f6
cabeza_abajo_de:		; da la vuelta de arriba abajo a 0xF003 caracteres de HL (DE = HL + 7)
	exx			;45f9
	ld a,(0f003h)		;45fa   ; lee variable de paso: cuantos caracteres
	ld b,a			;45fd
L_45FE:
	exx			;45fe
	ld b,004h		;45ff   ; intercambia las filas 0-3 con las 7-4 de cada caracter
L_4601:
	ld c,(hl)			;4601
	ld a,(de)			;4602
	ld (hl),a			;4603
	ld a,c			;4604
	ld (de),a			;4605
	inc hl			;4606
	dec de			;4607
	djnz L_4601		;4608
	inc hl			;460a
	inc hl			;460b
	inc hl			;460c
	inc hl			;460d
	ld a,00ch		;460e   ; al caracter siguiente (12 + 4 = 16 bytes mas alla de DE)
	call de_mas_a		;4610   ; de_mas_a: DE = DE + A
	exx			;4613
	djnz L_45FE		;4614
	ret			;4616
espejo_de_caracteres:		; da la vuelta de izquierda a derecha a los 0xF001 bytes de 0xE600
	ld hl,0e600h		;4617   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld de,(0f001h)		;461a   ; lee variable de paso: cuantos bytes y el byte siguiente (16 bits)
L_461E:
	ld b,008h		;461e   ; los 8 bits de cada byte al reves
L_4620:
	rr (hl)		;4620   ; el bit de la derecha sale por el acarreo
	adc a,a			;4622   ; y entra por la derecha de A
	djnz L_4620		;4623
	ld (hl),a			;4625   ; el byte al reves
	inc hl			;4626
	dec de			;4627   ; cuantos quedan
	ld a,d			;4628
	or e			;4629
	jr nz,L_461E		;462a
	ret			;462c
escribe_volteados:		; escribe los caracteres de 0xE600/0xE800 en los tercios que marcan los bits 3-5 de IX+02
	bit 3,(ix+002h)		;462d   ; bit 3 de IX+02: al tercio de abajo
	ld de,01000h		;4631
	call nz,escribe_volteados_en		;4634   ; escribe_volteados_en: los 0xF001 bytes de 0xE600 a los dibujos y los de 0xE800 a los colores del caracter IX+01 del tercio DE
	bit 4,(ix+002h)		;4637   ; bit 4: al del medio
	ld de,00800h		;463b
	call nz,escribe_volteados_en		;463e   ; escribe_volteados_en: los 0xF001 bytes de 0xE600 a los dibujos y los de 0xE800 a los colores del caracter IX+01 del tercio DE
	bit 5,(ix+002h)		;4641   ; bit 5: al de arriba
	ld de,00000h		;4645
	ret z			;4648
escribe_volteados_en:		; los 0xF001 bytes de 0xE600 a los dibujos y los de 0xE800 a los colores del caracter IX+01 del tercio DE
	push ix		;4649   ; IX lo cambia copia_a_vram
	ld l,(ix+001h)		;464b   ; IX+01: el caracter de destino
	ld h,000h		;464e
	add hl,hl			;4650
	add hl,hl			;4651
	add hl,hl			;4652
	add hl,de			;4653   ; x 8 + el tercio
	push hl			;4654
	ld de,02000h		;4655   ; los dibujos
	add hl,de			;4658
	ld de,0e600h		;4659   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld bc,(0f001h)		;465c   ; lee variable de paso: cuantos bytes y el byte siguiente (16 bits)
	call copia_a_vram		;4660   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	pop hl			;4663
	ld de,00000h		;4664   ; y los colores
	add hl,de			;4667
	ld de,0e800h		;4668   ; desde 0xE800
	ld bc,(0f001h)		;466b   ; lee variable de paso: cuantos bytes y el byte siguiente (16 bits)
	call copia_a_vram		;466f   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	pop ix		;4672
	ret			;4674
lee_caracteres:		; lee los caracteres de origen de IX a 0xE600 (dibujos) y 0xE800 (colores) del tercio de IX+02
	ld bc,(0f001h)		;4675   ; lee variable de paso: cuantos bytes y el byte siguiente (16 bits)
	ld l,(ix+000h)		;4679   ; IX+00: el caracter de origen
	ld h,000h		;467c
	add hl,hl			;467e
	add hl,hl			;467f
	add hl,hl			;4680
	push hl			;4681
	ld de,02000h		;4682   ; en el tercio de arriba si el bit 2 de IX+02
	bit 2,(ix+002h)		;4685
	jr nz,L_4695		;4689
	ld d,028h		;468b   ; en el del medio si el bit 1
	bit 1,(ix+002h)		;468d
	jr nz,L_4695		;4691
	ld d,030h		;4693   ; si no, en el de abajo
L_4695:
	add hl,de			;4695
	ld de,0e600h		;4696   ; los dibujos a 0xE600
	push ix		;4699
	call 00059h		;469b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;469e
	pop hl			;46a0
	ld de,00000h		;46a1   ; los colores, del mismo tercio
	bit 2,(ix+002h)		;46a4
	jr nz,L_46B4		;46a8
	ld d,008h		;46aa
	bit 1,(ix+002h)		;46ac
	jr nz,L_46B4		;46b0
	ld d,010h		;46b2
L_46B4:
	add hl,de			;46b4
	ld de,0e800h		;46b5   ; a 0xE800
	ld bc,(0f001h)		;46b8   ; lee variable de paso: cuantos bytes y el byte siguiente (16 bits)
	push ix		;46bc
	call 00059h		;46be   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;46c1
	ret			;46c3
aparece_el_interior:		; la fase 8 se pinta en tres cuadros (0xE1DD): caracteres a cero, luego cada vez mas bits de sus dibujos (mascara 0xE1DF) y por ultimo enteros
	ld a,(0e1ddh)		;46c4   ; el paso: 0, 1 o 2
	dec a			;46c7
	jr z,L_46ED		;46c8
	dec a			;46ca
	jr z,L_470A		;46cb
	xor a			;46cd   ; paso 0: los dibujos a cero
	ld (0e1deh),a		;46ce   ; guarda 0: dibujos, 1: colores (pintado del interior)
	ld c,000h		;46d1
	call interior_con_mascara		;46d3   ; interior_con_mascara: las listas de caracteres de 0xE1E0 con la mascara C: dibujos (0xE1DE = 0) o colores (1)
	ld a,001h		;46d6   ; y los colores con la mascara 0xF0 (solo el color de la tinta)
	ld (0e1deh),a		;46d8   ; guarda 0: dibujos, 1: colores (pintado del interior)
	ld c,0f0h		;46db
	call interior_con_mascara		;46dd   ; interior_con_mascara: las listas de caracteres de 0xE1E0 con la mascara C: dibujos (0xE1DE = 0) o colores (1)
	call interior_copias		;46e0   ; interior_copias: las listas de copias de 0xE1E2 (espejo) y 0xE1E4 (cabeza abajo)
	ld a,001h		;46e3   ; la mascara de los dibujos empieza en 0x01
	ld (0e1dfh),a		;46e5   ; guarda la mascara de bits del pintado del interior
L_46E8:
	ld hl,0e1ddh		;46e8   ; al paso siguiente
	inc (hl)			;46eb
	ret			;46ec
L_46ED:
	xor a			;46ed   ; paso 1: los dibujos con la mascara
	ld (0e1deh),a		;46ee   ; guarda 0: dibujos, 1: colores (pintado del interior)
	ld a,(0e1dfh)		;46f1   ; lee la mascara de bits del pintado del interior
	ld c,a			;46f4
	call interior_con_mascara		;46f5   ; interior_con_mascara: las listas de caracteres de 0xE1E0 con la mascara C: dibujos (0xE1DE = 0) o colores (1)
	call interior_copias		;46f8   ; interior_copias: las listas de copias de 0xE1E2 (espejo) y 0xE1E4 (cabeza abajo)
	ld hl,0e1dfh		;46fb   ; apunta a la mascara de bits del pintado del interior
	ld a,(hl)			;46fe
	cp 0ffh		;46ff   ; mascara entera: al paso 2
	jr z,L_46E8		;4701
	rlca			;4703   ; si no, rota 3 bits y deja entrar uno mas
	rlca			;4704
	rlca			;4705
	or 001h		;4706
	ld (hl),a			;4708
	ret			;4709
L_470A:
	ld a,001h		;470a   ; paso 2: los colores enteros
	ld (0e1deh),a		;470c   ; guarda 0: dibujos, 1: colores (pintado del interior)
	ld c,0ffh		;470f
	call interior_con_mascara		;4711   ; interior_con_mascara: las listas de caracteres de 0xE1E0 con la mascara C: dibujos (0xE1DE = 0) o colores (1)
	call interior_copias		;4714   ; interior_copias: las listas de copias de 0xE1E2 (espejo) y 0xE1E4 (cabeza abajo)
	call borra_e600		;4717   ; vacia el bufer de 0xE600-0xE9FF
	call caracteres_del_pinguino		;471a   ; el pinguino, si esta al lado
	xor a			;471d   ; se acabo el interior
	ld (0e1dch),a		;471e   ; guarda la marca de interior por pintar (fase 8)
	ld a,(0e401h)		;4721   ; la nave: con escudo (2) si le quedan golpes, si no normal (1)
	or a			;4724
	ld a,001h		;4725
	jr z,L_472A		;4727
	inc a			;4729
L_472A:
	ld (0e400h),a		;472a   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ret			;472d
interior_con_mascara:		; las listas de caracteres de 0xE1E0 con la mascara C: dibujos (0xE1DE = 0) o colores (1)
	ld ix,(0e1e0h)		;472e   ; la lista de caracteres del interior
L_4732:
	ld a,(ix+000h)		;4732   ; como pon_caracteres: 0 acaba
	and a			;4735
	ret z			;4736
	rra			;4737
	ld de,01000h		;4738
	call c,interior_un_caracter		;473b   ; interior_un_caracter: un grupo de la ficha IX en el tercio DE, con la mascara C
	bit 1,(ix+000h)		;473e
	ld de,00800h		;4742
	call nz,interior_un_caracter		;4745   ; interior_un_caracter: un grupo de la ficha IX en el tercio DE, con la mascara C
	bit 2,(ix+000h)		;4748
	ld de,00000h		;474c
	call nz,interior_un_caracter		;474f   ; interior_un_caracter: un grupo de la ficha IX en el tercio DE, con la mascara C
	ld de,00006h		;4752
	add ix,de		;4755
	jr L_4732		;4757
interior_un_caracter:		; un grupo de la ficha IX en el tercio DE, con la mascara C
	ld l,(ix+003h)		;4759
	ld h,000h		;475c
	add hl,hl			;475e
	add hl,hl			;475f
	add hl,hl			;4760
	add hl,de			;4761
	ld a,(0e1deh)		;4762   ; 0: dibujos, 1: colores
	dec a			;4765
	jr z,L_477A		;4766
	ld de,02000h		;4768
	add hl,de			;476b
	ld e,(ix+001h)		;476c   ; los dibujos comprimidos
	ld d,(ix+002h)		;476f
	push ix		;4772
	call descomprime_con_mascara		;4774   ; descomprime_con_mascara: como descomprime_a_vram pero cada byte AND C, y C rota en los dibujos
	pop ix		;4777
	ret			;4779
L_477A:
	ld de,00000h		;477a
	add hl,de			;477d
	ld e,(ix+004h)		;477e   ; los colores comprimidos
	ld d,(ix+005h)		;4781
	push ix		;4784
	call descomprime_con_mascara		;4786   ; descomprime_con_mascara: como descomprime_a_vram pero cada byte AND C, y C rota en los dibujos
	pop ix		;4789
	ret			;478b
interior_copias:		; las listas de copias de 0xE1E2 (espejo) y 0xE1E4 (cabeza abajo)
	xor a			;478c   ; primero en espejo
	ld (0f000h),a		;478d   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,(0e1e2h)		;4790   ; lee la lista de copias en espejo del interior y el byte siguiente (16 bits)
	call copia_caracteres		;4794   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld hl,0f000h		;4797   ; luego cabeza abajo
	inc (hl)			;479a
	ld ix,(0e1e4h)		;479b   ; lee la lista de copias cabeza abajo del interior y el byte siguiente (16 bits)
	jp copia_caracteres		;479f   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
descomprime_con_mascara:		; como descomprime_a_vram pero cada byte AND C, y C rota en los dibujos
	call prepara_escritura_vram		;47a2   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
L_47A5:
	ld a,(de)			;47a5   ; 0 acaba
	and a			;47a6
	ret z			;47a7
	inc de			;47a8
	ld b,a			;47a9
	and 07fh		;47aa   ; bit 7: n bytes sueltos
	cp b			;47ac
	jr z,L_47C7		;47ad
	ld b,a			;47af
L_47B0:
	ld a,(de)			;47b0   ; cada uno con la mascara
	and c			;47b1
	inc de			;47b2
	exx			;47b3
	out (c),a		;47b4
	exx			;47b6
	ld a,(0e1deh)		;47b7   ; en los dibujos la mascara rota 3 bits por byte
	and a			;47ba
	jr nz,L_47C3		;47bb
	rrc c		;47bd
	rrc c		;47bf
	rrc c		;47c1
L_47C3:
	djnz L_47B0		;47c3
	jr L_47A5		;47c5
L_47C7:
	ld a,(de)			;47c7   ; si no, n veces el byte siguiente
	inc de			;47c8
L_47C9:
	and c			;47c9   ; el byte con la mascara
	exx			;47ca
	out (c),a		;47cb   ; a la VRAM
	exx			;47cd
	ex af,af'			;47ce
	ld a,(0e1deh)		;47cf   ; lee 0: dibujos, 1: colores (pintado del interior)
	and a			;47d2
	jr nz,L_47DB		;47d3   ; en los colores la mascara no rota
	rrc c		;47d5
	rrc c		;47d7
	rrc c		;47d9
L_47DB:
	ex af,af'			;47db
	djnz L_47C9		;47dc
	jr L_47A5		;47de
pinta_la_pantalla:		; las 32 columnas de la pantalla de una vez (0xE203 - 32 en adelante), con el cuadro entero de enemigos por cada una
	xor a			;47e0
	ld (0f004h),a		;47e1   ; 0xF004: la X de las columnas, de 8 en 8
	ld hl,(0e203h)		;47e4   ; la columna 32 atras
	ld de,00020h		;47e7
	sbc hl,de		;47ea
	ld (0e203h),hl		;47ec   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	ld hl,0ed00h		;47ef   ; la primera columna de la pantalla de RAM
	ld (0f000h),hl		;47f2   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld b,020h		;47f5   ; 32 columnas
L_47F7:
	push bc			;47f7
	call bancos_13_14_15		;47f8   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	call pinta_columna		;47fb   ; la columna, con los bancos del mapa
	call bancos_1_2_3		;47fe   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call 07261h		;4801   ; y un cuadro de lo que aparece con el scroll
	call 06560h		;4804   ; apariciones_de_torretas: lo que trae cada columna (p01:657C) hasta ponerse al dia (0xE358)
	call 08798h		;4807   ; apariciones_de_objetos: lo que trae cada columna (p02:87B4) hasta ponerse al dia (0xE359)
	call 06f42h		;480a   ; enemigos_de_la_lista: en las fases 0-8, lo que trae cada columna de la lista (p01:6F64) hasta ponerse al dia (0xE37C)
	call 06abch		;480d   ; apariciones_de_piezas: en las fases 3 y 9-11, lo que trae cada columna (p01:6AE0) hasta ponerse al dia (0xE369)
	call banco_11		;4810   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b109h		;4813
	call 0b410h		;4816
	call bancos_2_3		;4819   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call apariciones_de_capsula		;481c   ; apariciones_de_capsula: lo que trae la columna (p00:5130) hasta ponerse al dia (0xE37D)
	ld hl,(0f000h)		;481f   ; a la columna siguiente de la pantalla
	inc hl			;4822
	ld (0f000h),hl		;4823   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld hl,0f004h		;4826   ; 8 pixeles mas
	ld a,(hl)			;4829
	add a,008h		;482a
	ld (hl),a			;482c
	ld hl,(0e203h)		;482d   ; y del mapa
	inc hl			;4830
	ld (0e203h),hl		;4831   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	pop bc			;4834
	djnz L_47F7		;4835
	ld hl,(0e203h)		;4837   ; la ultima no cuenta: la pinta el scroll
	dec hl			;483a
	ld (0e203h),hl		;483b   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	ret			;483e
L_483F:
	ld a,001h		;483f
	ld (0e327h),a		;4841   ; guarda la marca de fin del scroll
	ret			;4844
paso_de_scroll:		; si toca (0xE3D0, 0xE202) corre la pantalla de 0xED00 una columna y pinta la nueva (0xE203); 0xE327 = 1 al llegar al final (0xE325)
	xor a			;4845
	ld (0e320h),a		;4846   ; guarda la marca de scroll hecho en este cuadro
	ld (0e327h),a		;4849   ; guarda la marca de fin del scroll
	ld de,(0e325h)		;484c   ; ya ha llegado al final?
	ld hl,(0e203h)		;4850   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;4853
	jr nc,L_483F		;4854
	ld a,(0e3d0h)		;4856   ; la velocidad del scroll
	dec a			;4859
	ret z			;485a   ; 1: parado
	dec a			;485b
	jr z,L_4867		;485c   ; 2: un paso cada cuadro
	ld de,0e202h		;485e   ; si no, cuando sale el bit 7 del ritmo
	ld a,(de)			;4861
	rlca			;4862
	ld (de),a			;4863
	and 001h		;4864
	ret z			;4866
L_4867:
	inc hl			;4867   ; una columna mas
	ld (0e203h),hl		;4868   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	ld a,001h		;486b   ; hay scroll en este cuadro
	ld (0e320h),a		;486d   ; guarda la marca de scroll hecho en este cuadro
	ld hl,0ed01h		;4870   ; corre a la izquierda las 22 filas de la pantalla de RAM
	ld de,0ed00h		;4873   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	ld b,016h		;4876
L_4878:
	push bc			;4878
	ld bc,0001fh		;4879
	ldir		;487c
	pop bc			;487e
	inc hl			;487f   ; salta la ultima columna de cada fila
	inc de			;4880
	djnz L_4878		;4881
	ld hl,0ed1fh		;4883   ; la columna nueva es la ultima (31)
	ld (0f000h),hl		;4886   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
pinta_columna:		; la columna 0xE203 del mapa de la fase (p13:7900) en 0xF000, metabloque a metabloque; fuera de 0xE321-0xE323, estrellas
	ld hl,(0e203h)		;4889   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	ld de,(0e323h)		;488c   ; pasada la ultima columna con mapa?
	rst 20h			;4890
	ccf			;4891
	jp c,columna_de_estrellas		;4892   ; columna_de_estrellas: una columna sin mapa: ceros y una estrella (0xFE/0xFF) en la fila de p00:49E8
	ld de,(0e321h)		;4895   ; o antes de la primera?
	and a			;4899
	sbc hl,de		;489a
	jp c,columna_de_estrellas		;489c   ; columna_de_estrellas: una columna sin mapa: ceros y una estrella (0xFE/0xFF) en la fila de p00:49E8
	push hl			;489f   ; la columna dentro del mapa
	ld hl,07900h		;48a0   ; el mapa de la fase en p13:7900
	ld a,(0e201h)		;48a3   ; lee la fase (0-11)
	call palabra_a		;48a6   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	pop hl			;48a9
	ld a,l			;48aa   ; cada 2 columnas, un metabloque: 3 bytes por pareja de columnas
	srl h		;48ab
	rra			;48ad
	and 0feh		;48ae
	ld l,a			;48b0
	ld c,l			;48b1
	ld b,h			;48b2
	add hl,hl			;48b3
	add hl,bc			;48b4
	add hl,de			;48b5
	ld (0f002h),hl		;48b6   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld hl,(0f000h)		;48b9   ; 6 metabloques de alto
	ld b,006h		;48bc
L_48BE:
	push bc			;48be
	push hl			;48bf
	ld a,(0e201h)		;48c0   ; los metabloques de la fase (p00:5557)
	ld hl,05557h		;48c3
	call palabra_a		;48c6   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,(0f002h)		;48c9   ; lee variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	call fase_sin_umbral		;48cc   ; fases 0 y 8: Z
	ld a,(hl)			;48cf   ; el metabloque
	inc hl			;48d0
	ld (0f002h),hl		;48d1   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	jr z,L_48E3		;48d4
	sub 004h		;48d6   ; en las demas, los 4 primeros son de p13:6000
	jr nc,L_48E3		;48d8
	add a,004h		;48da
	ld c,a			;48dc
	ld de,06000h		;48dd
	ld a,c			;48e0
	jr L_490A		;48e1
L_48E3:
	ld c,a			;48e3   ; cuantos de 16 bytes tiene la fase
	ld a,(0e201h)		;48e4   ; lee la fase (0-11)
	ld hl,0494ah		;48e7
	call hl_mas_a		;48ea   ; hl_mas_a: HL = HL + A
	ld a,c			;48ed
	cp (hl)			;48ee
	jr c,L_490A		;48ef
	sub (hl)			;48f1   ; los de 8 bytes van detras: se copian a 0xEAA8
	ld l,(hl)			;48f2
	ld h,000h		;48f3
	add hl,hl			;48f5
	call hl_mas_a		;48f6   ; hl_mas_a: HL = HL + A
	add hl,hl			;48f9
	add hl,hl			;48fa
	add hl,hl			;48fb
	add hl,de			;48fc
	ld de,0eaa8h		;48fd   ; apunta a el metabloque de 8 bytes que se esta pintando
	ld bc,00008h		;4900
	ldir		;4903
	ld de,0eaa8h		;4905   ; apunta a el metabloque de 8 bytes que se esta pintando
	jr L_4913		;4908
L_490A:
	ld l,a			;490a   ; los de 16 bytes: x 16
	ld h,000h		;490b
	add hl,hl			;490d
	add hl,hl			;490e
	add hl,hl			;490f
	add hl,hl			;4910
	add hl,de			;4911
	ex de,hl			;4912
L_4913:
	ld a,(0e203h)		;4913   ; la columna dentro del metabloque (0-3)
	and 003h		;4916
	add a,e			;4918
	ld e,a			;4919
	jr nc,L_491D		;491a
	inc d			;491c
L_491D:
	pop hl			;491d
	dec b			;491e   ; la ultima fila es de 2 caracteres, las demas de 4
	ld bc,00020h		;491f
	jr z,L_4932		;4922
	ld a,(de)			;4924   ; 4 caracteres hacia abajo, uno cada 4 bytes del metabloque
	ld (hl),a			;4925
	add hl,bc			;4926
	inc de			;4927
	inc de			;4928
	inc de			;4929
	inc de			;492a
	ld a,(de)			;492b
	ld (hl),a			;492c
	add hl,bc			;492d
	inc de			;492e
	inc de			;492f
	inc de			;4930
	inc de			;4931
L_4932:
	ld a,(de)			;4932   ; la ultima fila: 2 caracteres
	ld (hl),a			;4933
	add hl,bc			;4934
	inc de			;4935
	inc de			;4936
	inc de			;4937
	inc de			;4938
	ld a,(de)			;4939
	ld (hl),a			;493a
	add hl,bc			;493b
	pop bc			;493c   ; los metabloques de la columna
	dec b			;493d   ; al metabloque de abajo
	jp nz,L_48BE		;493e
	ret			;4941
fase_sin_umbral:		; Z si la fase 0xE201 es la 0 o la 8
	ld a,(0e201h)		;4942   ; lee la fase (0-11)
	and a			;4945
	ret z			;4946
	cp 008h		;4947
	ret			;4949

; ----------------------------------------------------------------------
; DATOS umbral_por_fase: 12 bytes, uno por fase: cuantos metabloques de 16
;   bytes hay antes de los de 8 (p00:48E7); lo leen p00:48EA (12 bytes)
;   0x494a..0x4956  (12 bytes)
DATA_umbral_por_fase:
	defb 035h,017h,02eh,012h,01dh,016h,03ch,059h,035h,012h,012h,012h	; 494a  5.....<Y5...

; ======================================================================
; CODIGO 0x4956..0x49e0  (138 bytes)
; ======================================================================


columna_de_estrellas:		; una columna sin mapa: ceros y una estrella (0xFE/0xFF) en la fila de p00:49E8
	ld a,(0e203h)		;4956   ; la fila de la estrella de esta columna
	and 01fh		;4959
	ld hl,049e8h		;495b
	call hl_mas_a		;495e   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;4961
	ld a,c			;4962   ; B = 22 filas
	ex af,af'			;4963
	ld b,016h		;4964
	ld de,00020h		;4966
	ld hl,(0f000h)		;4969   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
L_496C:
	xor a			;496c   ; cero, salvo en la fila de la estrella
	dec c			;496d
	jr nz,L_4975		;496e
	ex af,af'			;4970   ; 0xFE o 0xFF segun la fila
	and 001h		;4971
	add a,0feh		;4973
L_4975:
	ld (hl),a			;4975
	add hl,de			;4976
	djnz L_496C		;4977
	ret			;4979
estrellas_titilan:		; los dibujos de las estrellas (caracteres 0xFE y 0xFF de los tres tercios) segun 0xE202 y la mascara de p00:49E0
	ld a,(0e1c3h)		;497a   ; el par de mascaras que toca
	and 006h		;497d
	ld hl,049e0h		;497f
	ld e,a			;4982
	ld d,000h		;4983
	add hl,de			;4985
	ld c,(hl)			;4986
	inc hl			;4987
	ld b,(hl)			;4988
	ld hl,027f2h		;4989   ; la fila 2 del caracter 0xFE
	call estrella_en_tres_tercios		;498c   ; estrella_en_tres_tercios: el ritmo del scroll AND C en la VRAM HL de los tres tercios
	ld c,b			;498f   ; y la 3 del 0xFF
	ld hl,027fbh		;4990
estrella_en_tres_tercios:		; el ritmo del scroll AND C en la VRAM HL de los tres tercios
	ld a,(0e202h)		;4993   ; el ritmo del scroll con la mascara
	and c			;4996
	call 0004dh		;4997   ; BIOS WRTVRM - Writes data in VRAM | en los tres tercios
	ld de,00800h		;499a
	add hl,de			;499d
	call 0004dh		;499e   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;49a1
	jp 0004dh		;49a2   ; BIOS WRTVRM - Writes data in VRAM
cielo_de_estrellas:		; llena 0xED00 de estrellas: una por columna, en la fila de p00:49E8
	ld ix,049e8h		;49a5
	ld a,(0e203h)		;49a9   ; la fila de estrella de la primera columna
	sub 01fh		;49ac
	and 01fh		;49ae
	ld e,a			;49b0
	ld d,000h		;49b1
	add ix,de		;49b3
	sub 020h		;49b5
	neg		;49b7
	ld c,a			;49b9
	ld de,0ed00h		;49ba   ; de 0xED00 en adelante
	ld b,020h		;49bd   ; 32 columnas
L_49BF:
	push de			;49bf
	ld a,(ix+000h)		;49c0   ; la fila (1-22) x 32
	ld l,a			;49c3
	dec l			;49c4
	ld h,000h		;49c5
	add hl,hl			;49c7
	add hl,hl			;49c8
	add hl,hl			;49c9
	add hl,hl			;49ca
	add hl,hl			;49cb
	add hl,de			;49cc
	and 001h		;49cd   ; 0xFE o 0xFF
	add a,0feh		;49cf
	ld (hl),a			;49d1
	dec c			;49d2
	jr nz,L_49D9		;49d3   ; la tabla da la vuelta
	ld ix,049e8h		;49d5
L_49D9:
	pop de			;49d9
	inc de			;49da
	inc ix		;49db
	djnz L_49BF		;49dd
	ret			;49df

; ----------------------------------------------------------------------
; DATOS pares_49E0: 4 pares de bytes que p00:497A lee con (0xE1C3 & 6); lo
;   leen p00:4986 (8 bytes)
;   0x49e0..0x49e8  (8 bytes)
DATA_pares_49E0:
	defb 0ffh,000h	; 49e0
	defb 0ffh,0ffh	; 49e2
	defb 000h,0ffh	; 49e4
	defb 0ffh,0ffh	; 49e6

; ----------------------------------------------------------------------
; DATOS tabla_49E8: 32 bytes que p00:4956 lee con (0xE203 & 0x1F): la scroll
;   en curso; lo leen p00:495E (32 bytes)
;   0x49e8..0x4a08  (32 bytes)
DATA_tabla_49E8:
	defb 002h,00fh,005h,013h,00ah,001h,00dh,006h,011h,008h,00bh,002h,010h,007h,00dh,005h	; 49e8  ................
	defb 012h,00ch,002h,012h,009h,00eh,014h,011h,002h,005h,00dh,00ah,013h,006h,00fh,009h	; 49f8  ................

; ======================================================================
; CODIGO 0x4a08..0x4be8  (480 bytes)
; ======================================================================


borra_nombres_2c0:		; borra 704 bytes de la tabla de nombres (0x3800, 22 filas) tras p00:5AFA
	call sin_sprites		;4a08   ; sin_sprites: Y = 0xD0 en el primer sprite de la VRAM (0x3B00): no se pinta ninguno
	ld bc,002c0h		;4a0b   ; 22 filas
	jr L_4A16		;4a0e
borra_nombres:		; borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call sin_sprites		;4a10   ; sin_sprites: Y = 0xD0 en el primer sprite de la VRAM (0x3B00): no se pinta ninguno
	ld bc,00300h		;4a13
L_4A16:
	ld hl,03800h		;4a16   ; la tabla de nombres
	xor a			;4a19
	jp 00056h		;4a1a   ; BIOS FILVRM - Fills VRAM with value
prepara_escritura_vram:		; SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	ex af,af'			;4a1d
	call 00053h		;4a1e   ; BIOS SETWRT - Enables VDP to write
	exx			;4a21
	ld a,(00007h)		;4a22   ; el puerto de escritura del VDP, de la BIOS
	ld c,a			;4a25
	exx			;4a26
	ex af,af'			;4a27
	ret			;4a28
prepara_lectura_vram:		; SETRD en HL y C' = el puerto de lectura del VDP (0x0006 de la BIOS)
	call 00050h		;4a29   ; BIOS SETRD - Enables VDP to read
	exx			;4a2c
	ld a,(00006h)		;4a2d   ; el puerto de lectura del VDP, de la BIOS
	ld c,a			;4a30
	exx			;4a31
	ret			;4a32
copia_a_vram:		; copia BC bytes de DE a la VRAM HL (LDIRVM)
	ex de,hl			;4a33   ; LDIRVM quiere el origen en HL y el destino en DE
	jp 0005ch		;4a34   ; BIOS LDIRVM - Block transfers to VRAM from memory
copia_a_vram_x3:		; copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	exx			;4a37
	ld b,003h		;4a38
copia_a_vram_b_veces:		; copia BC' bytes de DE' a la VRAM HL B veces, 0x800 mas adelante cada vez
	exx			;4a3a
	push bc			;4a3b
	push de			;4a3c
	call copia_a_vram		;4a3d   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,00800h		;4a40   ; el tercio siguiente
	add hl,de			;4a43
	pop de			;4a44
	pop bc			;4a45
	exx			;4a46
	djnz copia_a_vram_b_veces		;4a47
	ret			;4a49
rellena_vram_x3:		; rellena BC bytes de la VRAM con A en los tres tercios (HL, + 0x800, + 0x1000)
	ld d,003h		;4a4a
rellena_vram_d_veces:		; rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
	push bc			;4a4c
	push de			;4a4d
	call 00056h		;4a4e   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;4a51   ; el tercio siguiente
	add hl,de			;4a54
	pop de			;4a55
	pop bc			;4a56
	dec d			;4a57
	jr nz,rellena_vram_d_veces		;4a58
	ret			;4a5a
descomprime_x3:		; descomprime DE a la VRAM HL en los tres tercios
	ld b,003h		;4a5b
L_4A5D:
	push bc			;4a5d
	push de			;4a5e
	call descomprime_a_vram		;4a5f   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	ld de,00800h		;4a62   ; el tercio siguiente
	add hl,de			;4a65
	pop de			;4a66
	pop bc			;4a67
	djnz L_4A5D		;4a68
	ret			;4a6a
escribe_texto:		; escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld c,0ffh		;4a6b
L_4A6D:
	ex de,hl			;4a6d   ; HL = la direccion de VRAM, de la lista
	ld e,(hl)			;4a6e
	inc hl			;4a6f
	ld d,(hl)			;4a70
	ex de,hl			;4a71
	inc de			;4a72
L_4A73:
	ld a,(de)			;4a73
	inc de			;4a74
	ld b,a			;4a75   ; 0xFF acaba
	inc b			;4a76
	ret z			;4a77
	inc b			;4a78   ; 0xFE: otra direccion
	jr z,L_4A6D		;4a79
	and c			;4a7b   ; el caracter (con C = 0, un cero)
	call 0004dh		;4a7c   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;4a7f
	jr L_4A73		;4a80
borra_texto:		; lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
	ld c,000h		;4a82
	jr L_4A6D		;4a84
descomprime_otra_direccion:		; la direccion de VRAM que va en DE y sigue descomprimiendo
	ex de,hl			;4a86   ; HL = la direccion nueva
	ld e,(hl)			;4a87
	inc hl			;4a88
	ld d,(hl)			;4a89
	ex de,hl			;4a8a
	inc de			;4a8b
descomprime_a_vram:		; descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	call prepara_escritura_vram		;4a8c   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
L_4A8F:
	ld a,(de)			;4a8f   ; 0 acaba
	and a			;4a90
	ret z			;4a91
	inc de			;4a92
	ld b,a			;4a93   ; bit 7 a cero: repeticion
	and 07fh		;4a94
	cp b			;4a96
	jr z,L_4AA7		;4a97
	and a			;4a99   ; 0x80: otra direccion
	jr z,descomprime_otra_direccion		;4a9a
	ld b,a			;4a9c   ; 0x80 + n: n bytes sueltos
L_4A9D:
	ld a,(de)			;4a9d   ; un byte suelto
	inc de			;4a9e
	exx			;4a9f
	out (c),a		;4aa0   ; a la VRAM
	exx			;4aa2
	djnz L_4A9D		;4aa3
	jr L_4A8F		;4aa5
L_4AA7:
	ld a,(de)			;4aa7   ; n veces el byte siguiente
	inc de			;4aa8
L_4AA9:
	exx			;4aa9   ; el mismo byte n veces
	out (c),a		;4aaa
	exx			;4aac
	djnz L_4AA9		;4aad
	jr L_4A8F		;4aaf
espejo_de_sprites:		; copia C dibujos de sprite de 16x16 de la VRAM HL a la DE dados la vuelta de izquierda a derecha
	call espejo_de_un_sprite		;4ab1   ; espejo_de_un_sprite: un dibujo de sprite de 16x16 de la VRAM HL a la DE, de izquierda a derecha
	ld a,020h		;4ab4   ; el sprite siguiente (32 bytes)
	call de_mas_a		;4ab6   ; de_mas_a: DE = DE + A
	dec c			;4ab9
	jr nz,espejo_de_sprites		;4aba
	ret			;4abc
espejo_de_un_sprite:		; un dibujo de sprite de 16x16 de la VRAM HL a la DE, de izquierda a derecha
	push de			;4abd
L_4ABE:
	ld b,010h		;4abe   ; 16 filas
L_4AC0:
	call 0004ah		;4ac0   ; BIOS RDVRM - Reads the content of VRAM
	call invierte_bits		;4ac3   ; cada fila al reves
	ex de,hl			;4ac6
	call 0004dh		;4ac7   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;4aca
	inc e			;4acb
	inc hl			;4acc
	djnz L_4AC0		;4acd
	ld a,e			;4acf   ; la mitad de destino cambia: de la derecha a la izquierda
	sub 020h		;4ad0
	ld e,a			;4ad2
	bit 4,e		;4ad3
	jr z,L_4ABE		;4ad5
	pop de			;4ad7
	ret			;4ad8
invierte_bits:		; A = los 8 bits de A al reves
	push bc			;4ad9
	ld c,a			;4ada
	ld b,008h		;4adb
L_4ADD:
	rr c		;4add   ; los 8 bits, uno a uno, al reves
	rla			;4adf
	djnz L_4ADD		;4ae0
	pop bc			;4ae2
	ret			;4ae3
sonido:		; pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	di			;4ae4   ; sin interrupciones mientras estan los bancos del sonido
	push hl			;4ae5
	push de			;4ae6
	push bc			;4ae7
	push ix		;4ae8
	push af			;4aea
	ld a,004h		;4aeb   ; los bancos 4, 5 y 6 sin tocar sus copias
	ld (07000h),a		;4aed   ; el banco 4 en 0x6000
	inc a			;4af0
	ld (09000h),a		;4af1   ; el 5 en 0x8000
	inc a			;4af4
	ld (0b000h),a		;4af5   ; el 6 en 0xA000
	pop af			;4af8
	push af			;4af9
	call 06480h		;4afa   ; p04:6480: pide el sonido A
	ld a,(0f0f1h)		;4afd   ; devuelve los bancos de sus copias
	ld (07000h),a		;4b00   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;4b03   ; lee la copia del banco de 0x8000
	ld (09000h),a		;4b06   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;4b09   ; lee la copia del banco de 0xA000
	ld (0b000h),a		;4b0c   ; el mapper: pone en 0xA000 el banco de A
	pop af			;4b0f
	pop ix		;4b10
	pop bc			;4b12
	pop de			;4b13
	pop hl			;4b14
	ei			;4b15
	ret			;4b16
L_4B17:
	call banco_11		;4b17   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b77fh		;4b1a   ; p11:B77F
	jp bancos_2_3		;4b1d   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
caracteres_de_jefe:		; con los bancos 13-14-15, los caracteres de los jefes 1-4 (p00:556F, copias p00:559A) y los sprites de p09:BF6D
	push ix		;4b20
	call bancos_13_14_15		;4b22   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	ld ix,0556fh		;4b25   ; los caracteres de los jefes 1-4
	call pon_caracteres		;4b29   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	ld a,001h		;4b2c   ; y sus copias cabeza abajo
	ld (0f000h),a		;4b2e   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0559ah		;4b31
	call copia_caracteres		;4b35   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	call sprites_bf6d		;4b38   ; y los sprites
	call bancos_1_2_3		;4b3b   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call banco_11		;4b3e   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	pop ix		;4b41
borra_e600:		; pone a cero 0xE600-0xE9FF
	ld hl,0e600h		;4b43   ; 0xE600-0xE9FF a cero
	ld de,0e601h		;4b46
	ld bc,003ffh		;4b49
	ld (hl),000h		;4b4c
	ldir		;4b4e
	ret			;4b50
sprites_bf6d:		; con los bancos 7-8-9, p09:BF6D a la VRAM 0x1E80
	call bancos_7_8_9		;4b51   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	ld hl,01e80h		;4b54
	ld de,0bf6dh		;4b57
	call descomprime_a_vram		;4b5a   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	jp bancos_1_2_3		;4b5d   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
palabra_a_de:		; DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ld l,a			;4b60   ; la palabra A de la tabla DE
	ld h,000h		;4b61
	add hl,hl			;4b63
	add hl,de			;4b64
	jr L_4B6C		;4b65
palabra_a:		; DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	add a,a			;4b67   ; dos bytes por palabra
	ld e,a			;4b68
	ld d,000h		;4b69
	add hl,de			;4b6b
L_4B6C:
	ld e,(hl)			;4b6c
	inc hl			;4b6d
	ld d,(hl)			;4b6e
	ret			;4b6f
queda_alguien:		; A distinto de 0 si queda ocupada alguna de las 12 fichas de 0xE600 (64 bytes) o de las 10 de 0xE900 (16 bytes)
	ld hl,0e600h		;4b70   ; 12 fichas de 64 bytes en 0xE600
	ld de,00040h		;4b73
	ld b,00ch		;4b76
L_4B78:
	ld a,(hl)			;4b78
	and a			;4b79
	ret nz			;4b7a
	add hl,de			;4b7b
	djnz L_4B78		;4b7c
	ld hl,0e900h		;4b7e   ; y 10 de 16 bytes en 0xE900
	ld de,00010h		;4b81
	ld b,00ah		;4b84
L_4B86:
	ld a,(hl)			;4b86
	and a			;4b87
	ret nz			;4b88
	add hl,de			;4b89
	djnz L_4B86		;4b8a
	xor a			;4b8c   ; ninguna ocupada
	ret			;4b8d
pon_el_jefe:		; copia el dibujo del jefe (p00:4BE8, IX+13 filas de IX+14) a la pantalla de RAM en IX+04/IX+06
	ld l,(ix+004h)		;4b8e   ; IX+04 y IX+06: la Y y la X del jefe
	ld h,(ix+006h)		;4b91
	call sitio_en_pantalla		;4b94   ; HL = su sitio en la pantalla de RAM
	ex de,hl			;4b97
	ld hl,04be8h		;4b98   ; el dibujo del jefe: filas de 15 alineadas a la derecha
	ld a,(ix+014h)		;4b9b
	sub 00fh		;4b9e
	neg		;4ba0
	call hl_mas_a		;4ba2   ; hl_mas_a: HL = HL + A
	exx			;4ba5
	ld b,(ix+013h)		;4ba6   ; IX+13 filas
L_4BA9:
	exx			;4ba9
	push hl			;4baa
	push de			;4bab
	ld c,(ix+014h)		;4bac   ; de IX+14 caracteres
	ld b,000h		;4baf
	ldir		;4bb1
	pop de			;4bb3
	ld a,020h		;4bb4   ; a la fila de abajo de la pantalla (32)
	add a,e			;4bb6
	ld e,a			;4bb7
	jr nc,L_4BBB		;4bb8
	inc d			;4bba
L_4BBB:
	pop hl			;4bbb
	ld a,00fh		;4bbc   ; y del dibujo (15)
	add a,l			;4bbe
	ld l,a			;4bbf
	jr nc,L_4BC3		;4bc0
	inc h			;4bc2
L_4BC3:
	exx			;4bc3
	djnz L_4BA9		;4bc4
	ret			;4bc6
quita_el_jefe:		; borra IX+13 filas de IX+14 caracteres de la pantalla de RAM en IX+04/IX+06
	ld l,(ix+004h)		;4bc7   ; IX+04 y IX+06: la Y y la X del jefe
	ld h,(ix+006h)		;4bca
	call sitio_en_pantalla		;4bcd   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld c,(ix+013h)		;4bd0   ; IX+13 filas
L_4BD3:
	push hl			;4bd3
	ld b,(ix+014h)		;4bd4   ; de IX+14 caracteres a cero
L_4BD7:
	ld (hl),000h		;4bd7   ; a cero
	inc hl			;4bd9
	djnz L_4BD7		;4bda
	pop hl			;4bdc
	ld a,020h		;4bdd   ; a la fila de abajo (32)
	add a,l			;4bdf
	ld l,a			;4be0
	jr nc,L_4BE4		;4be1
	inc h			;4be3
L_4BE4:
	dec c			;4be4
	jr nz,L_4BD3		;4be5
	ret			;4be7

; ----------------------------------------------------------------------
; DATOS bloque_4BE8: 4 filas de 15 caracteres que p00:4B8E copia a la tabla de
;   nombres de la RAM alineadas a la derecha (IX+14 de ancho, IX+13 filas); lo
;   leen p00:4BA2 (60 bytes)
;   0x4be8..0x4c24  (60 bytes)
DATA_bloque_4BE8:
	defb 0bch,0bch,0bch,0bch,0bch,0bch,0bch,0bch,0bch,0bch,0bch,0ach,0adh,0ach,0afh	; 4be8  ...............
	defb 0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh,0b0h,0b1h,0b2h,0b3h	; 4bf7  ...............
	defb 0beh,0beh,0beh,0beh,0beh,0beh,0beh,0beh,0beh,0beh,0beh,0b4h,0b5h,0b6h,0b7h	; 4c06  ...............
	defb 0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0b8h,0b9h,0bah,0bbh	; 4c15  ...............

; ======================================================================
; CODIGO 0x4c24..0x4cd6  (178 bytes)
; ======================================================================


azar:		; 0xE306 = 0xE306 + 3 x R: el azar del juego
	ld a,r		;4c24   ; un numero al azar: el registro R
	ld b,a			;4c26
	add a,a			;4c27
	add a,b			;4c28
	ld b,a			;4c29
	ld a,(0e306h)		;4c2a   ; sumado al azar de antes
	add a,b			;4c2d
	ld (0e306h),a		;4c2e   ; guarda el azar
	ret			;4c31
aparicion_de_fase:		; la ficha A (3 bytes [columna][dato]) de la lista HL de la fase: DE = su columna, C = el dato, y compara con la columna del scroll (Z llegada, C todavia no)
	push af			;4c32
	ld a,(0e201h)		;4c33   ; lee la fase (0-11)
	call palabra_a		;4c36   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	pop af			;4c39
	ld c,a			;4c3a   ; tres bytes por ficha
	add a,a			;4c3b
	add a,c			;4c3c
	call de_mas_a		;4c3d   ; de_mas_a: DE = DE + A
	ex de,hl			;4c40
	ld e,(hl)			;4c41   ; DE = la columna de la ficha
	inc hl			;4c42
	ld d,(hl)			;4c43
	inc hl			;4c44
	ld c,(hl)			;4c45   ; C = su dato
	ld hl,(0e203h)		;4c46   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;4c49   ; la compara con la del scroll
	ret			;4c4a
cuenta_atras:		; en los estados 2 y 5, la cuenta de la capsula especial (0xE439): un segundo cada 60 cuadros en 0xE43A (BCD); 0xE1D5 = 1 en cada segundo, 2 al acabar
	ld a,(0e1c0h)		;4c4b   ; solo en los estados 2 (demo) y 5 (juego)
	cp 002h		;4c4e
	jr z,L_4C55		;4c50
	cp 005h		;4c52
	ret nz			;4c54
L_4C55:
	ld a,(0e439h)		;4c55   ; sin capsula especial no hay cuenta atras
	or a			;4c58
	ret z			;4c59
	ld hl,0e1d5h		;4c5a   ; apunta a la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	ld a,(hl)			;4c5d
	or a			;4c5e
	ret nz			;4c5f   ; si aun no se ha atendido el segundo anterior, espera
	ld hl,0e43bh		;4c60   ; apunta a los cuadros del segundo (de 60 a 0)
	dec (hl)			;4c63   ; un cuadro menos del segundo
	ret nz			;4c64
	ld (hl),03ch		;4c65   ; 60 cuadros: un segundo
	dec l			;4c67   ; un segundo menos (BCD)
	ld a,(hl)			;4c68
	sub 001h		;4c69
	daa			;4c6b
	ld (hl),a			;4c6c
	ld a,001h		;4c6d   ; 1: pinta los segundos; 2: se acabo
	jr nz,L_4C72		;4c6f
	inc a			;4c71
L_4C72:
	ld (0e1d5h),a		;4c72   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	ret			;4c75
esconde_sprites:		; los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	ld hl,0e280h		;4c76   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	ld de,0e281h		;4c79
	ld (hl),0e0h		;4c7c   ; Y = 0xE0: el sprite fuera de la pantalla
	ld bc,0007fh		;4c7e
	ldir		;4c81
	ret			;4c83
caracteres_del_jefe_5:		; con los bancos 13-14-15, los caracteres del jefe 5 (p15:B3AF, copias p15:B3BC) y el banco 11
	call bancos_13_14_15		;4c84   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	ld ix,0b3afh		;4c87   ; los caracteres del jefe 5
	call pon_caracteres		;4c8b   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	ld a,001h		;4c8e   ; y sus copias cabeza abajo
	ld (0f000h),a		;4c90   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0b3bch		;4c93
	call copia_caracteres		;4c97   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	call bancos_1_2_3		;4c9a   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call banco_11		;4c9d   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	jp borra_e600		;4ca0   ; vacia el bufer
fila_de_caracteres:		; IX+14 caracteres IX+32 seguidos en la pantalla de RAM desde IX+11/IX+12
	ld a,(ix+014h)		;4ca3   ; IX+14: cuantos
	or a			;4ca6
	ret z			;4ca7
	ld b,a			;4ca8
	ld l,(ix+011h)		;4ca9   ; IX+11/IX+12: el sitio en la pantalla de RAM
	ld h,(ix+012h)		;4cac
	ld a,(ix+032h)		;4caf   ; IX+32: el caracter
L_4CB2:
	ld (hl),a			;4cb2
	inc l			;4cb3
	djnz L_4CB2		;4cb4
	ret			;4cb6
velocidad_en_direccion:		; para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
	push af			;4cb7
	ld hl,04cf6h		;4cb8   ; la componente de p00:4CF6
	call palabra_a		;4cbb   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,00000h		;4cbe
	push bc			;4cc1
L_4CC2:
	add hl,de			;4cc2   ; por B
	djnz L_4CC2		;4cc3
	pop bc			;4cc5
	pop af			;4cc6
	push hl			;4cc7
	ld hl,04cd6h		;4cc8   ; la de p00:4CD6
	call palabra_a		;4ccb   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,00000h		;4cce
L_4CD1:
	add hl,de			;4cd1   ; por B
	djnz L_4CD1		;4cd2
	pop de			;4cd4
	ret			;4cd5

; ----------------------------------------------------------------------
; DATOS tabla_4CD6: 16 palabras con signo (una por direccion) que p00:4CC8 lee
;   con L_4B67 y suma IX+?? veces; lo leen p00:4CCB (32 bytes)
;   0x4cd6..0x4cf6  (32 bytes)
DATA_tabla_4CD6:
	defw 00000h,0ff80h,0ff4bh,0ff23h,0ff00h,0ff23h,0ff4bh,0ff80h	; 4cd6
	defw 00000h,00080h,000b5h,000ddh,00100h,000ddh,000b5h,00080h	; 4ce6

; ----------------------------------------------------------------------
; DATOS tabla_4CF6: 16 palabras con signo (una por direccion) que p00:4CB8 lee
;   con L_4B67; lo leen p00:4CBB (32 bytes)
;   0x4cf6..0x4d16  (32 bytes)
DATA_tabla_4CF6:
	defw 00100h,000ddh,000b5h,00080h,00000h,0ff80h,0ff4bh,0ff23h	; 4cf6
	defw 0ff00h,0ff23h,0ff4bh,0ff80h,00000h,00080h,000b5h,000ddh	; 4d06

; ======================================================================
; CODIGO 0x4d16..0x4df3  (221 bytes)
; ======================================================================


crea_enemigo_ix:		; crea_enemigo conservando IX
	push ix		;4d16
	call crea_enemigo		;4d18   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	pop ix		;4d1b
	ret			;4d1d
crea_enemigo:		; busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	ld (0f019h),de		;4d1e   ; D = X, E = Y
	ld (0e350h),a		;4d22   ; guarda el tipo del enemigo que se crea
	ld a,b			;4d25
	ld (0e35fh),a		;4d26   ; guarda el dato B del enemigo que se crea
	xor a			;4d29
	ld (0e353h),a		;4d2a   ; guarda el tipo del ultimo enemigo creado
	ld a,c			;4d2d
	ld (0e351h),a		;4d2e   ; guarda el dato C del enemigo que se crea
	ld hl,0e600h		;4d31   ; 12 fichas de 64 bytes
	ld b,00ch		;4d34
	ld de,00040h		;4d36
	xor a			;4d39
L_4D3A:
	cp (hl)			;4d3a   ; la primera libre (tipo 0)
	jr z,L_4D42		;4d3b
	add hl,de			;4d3d
	djnz L_4D3A		;4d3e
	xor a			;4d40   ; ninguna libre: A = 0
	ret			;4d41
L_4D42:
	push hl			;4d42   ; 7 x tipo
	ld a,(0e350h)		;4d43   ; lee el tipo del enemigo que se crea
	ld l,a			;4d46
	ld h,000h		;4d47
	ld e,l			;4d49
	ld d,h			;4d4a
	add hl,hl			;4d4b
	add hl,hl			;4d4c
	add hl,hl			;4d4d
	or a			;4d4e
	sbc hl,de		;4d4f
	ld de,04f45h		;4d51   ; la ficha del tipo: p00:4F45 + 7 x tipo
	add hl,de			;4d54
	ex de,hl			;4d55
	pop hl			;4d56
	ld a,(de)			;4d57
	bit 6,a		;4d58   ; bit 6: de caracteres, no gasta sprites
	jr nz,L_4D6C		;4d5a
	and 03fh		;4d5c   ; los sprites que gasta
	ld b,a			;4d5e
	ld a,(0e355h)		;4d5f   ; lee los sprites ocupados por enemigos (maximo 12)
	add a,b			;4d62
	cp 00dh		;4d63   ; no caben mas de 12
	jr c,L_4D69		;4d65
	xor a			;4d67   ; no cabe: A = 0
	ret			;4d68
L_4D69:
	ld (0e355h),a		;4d69   ; los ocupa
L_4D6C:
	push de			;4d6c
	ld de,(0f019h)		;4d6d   ; DE = la posicion
	exx			;4d71
	ld hl,0e352h		;4d72   ; uno mas creado
	inc (hl)			;4d75
	exx			;4d76
	push hl			;4d77
	pop ix		;4d78
	ld a,(0e350h)		;4d7a   ; IX = la ficha
	ld (0e353h),a		;4d7d   ; guarda el tipo del ultimo enemigo creado
	ld (hl),a			;4d80   ; IX+00 = el tipo y IX+01-IX+03 = 0
	inc l			;4d81
	xor a			;4d82
	ld (hl),a			;4d83
	inc l			;4d84
	ld (hl),a			;4d85
	inc l			;4d86
	ld (hl),a			;4d87
	inc l			;4d88
	ld (hl),e			;4d89   ; IX+04 = Y
	inc l			;4d8a
	ld (hl),a			;4d8b
	inc l			;4d8c
	ld (hl),d			;4d8d   ; IX+06 = X
	ld de,00005h		;4d8e   ; a IX+0B
	add hl,de			;4d91
	pop de			;4d92
	ex de,hl			;4d93
	ldi		;4d94   ; IX+0B = el byte 0 de la ficha del tipo (sprites y banderas)
	ld a,(0e351h)		;4d96   ; lee el dato C del enemigo que se crea
	ld (de),a			;4d99   ; IX+0C = C
	inc e			;4d9a
	ldi		;4d9b   ; IX+0D-IX+0F = los bytes 1-3 de la ficha del tipo
	ldi		;4d9d
	ldi		;4d9f
	ld a,007h		;4da1   ; IX+10 = 7
	ld (de),a			;4da3
	ld a,005h		;4da4
	call de_mas_a		;4da6   ; de_mas_a: DE = DE + A
	call azar_por_nivel		;4da9   ; IX+15 = un azar por nivel
	ld (de),a			;4dac
	inc e			;4dad
	ld a,(0e350h)		;4dae   ; el tipo 0x26 no lleva IX+16
	cp 026h		;4db1
	jr z,L_4DCB		;4db3
	xor a			;4db5
	ld (de),a			;4db6
	ld a,(0e350h)		;4db7   ; los tipos 0x0B y 0x31 llevan IX+16 = 1 e IX+17 = 0xE396
	cp 00bh		;4dba
	jr z,L_4DC2		;4dbc
	cp 031h		;4dbe
	jr nz,L_4DCB		;4dc0
L_4DC2:
	ld a,001h		;4dc2   ; IX+16 = 1
	ld (de),a			;4dc4
	inc e			;4dc5
	ld a,(0e396h)		;4dc6   ; IX+17 = 0xE396
	ld (de),a			;4dc9
	dec e			;4dca
L_4DCB:
	inc e			;4dcb   ; IX+18 = 0
	inc e			;4dcc
	xor a			;4dcd
	ld (de),a			;4dce
	inc e			;4dcf
	ld a,(0e35fh)		;4dd0   ; IX+19 = B
	ld (de),a			;4dd3
	inc e			;4dd4
	xor a			;4dd5
	ld (de),a			;4dd6
	ld a,016h		;4dd7   ; a IX+30
	call de_mas_a		;4dd9   ; de_mas_a: DE = DE + A
	ldi		;4ddc   ; IX+30-IX+32 = los bytes 4-6 de la ficha del tipo
	ldi		;4dde
	ldi		;4de0
	ld a,(0e351h)		;4de2   ; con C, IX+31 = 8
	and a			;4de5
	jr z,L_4DEC		;4de6
	ld (ix+031h),008h		;4de8
L_4DEC:
	ld a,(0e350h)		;4dec   ; y lo propio de cada tipo (65, p00:4DF3)
	dec a			;4def
	call despacha		;4df0   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_4DF3: 65 destinos del despachador p00:4084 (call en p00:4DF0, el
;   indice en A): 65B1, 4E76, 9867, A2EE, 9D6D, 4E75, A54A, 99A0, 9B4C, 4E75,
;   A63C, 9A04, 9BA6, A340, 9BF7, B7BC, 9C8D, 4E75, 4E75, 9C50, 4E75, BBF6,
;   4E75, 4E75, A447, 4E75, A4E0, 4E75, B6E1, 4E75, B8FC, BA56, 4E75, BA47,
;   ABD2, AF20, 9F9D, 9629, 4E75, 4E75, 9694, 9694, 96AA, 96B6, 96B2, 96A2,
;   970C, A71B, BACB, 744F, 9629, 933D, 4E75, 9629, 4E75, 4E7F, 9720, 970D,
;   9809, 985F, 4E75, 4E75, 4E75, BEE6, BC10; lo leen p00:4DF0 (130 bytes)
;   0x4df3..0x4e75  (130 bytes)
DATA_tabla_4DF3:
	defw 065b1h,04e76h,09867h,0a2eeh,09d6dh,04e75h,0a54ah,099a0h	; 4df3
	defw 09b4ch,04e75h,0a63ch,09a04h,09ba6h,0a340h,09bf7h,0b7bch	; 4e03
	defw 09c8dh,04e75h,04e75h,09c50h,04e75h,0bbf6h,04e75h,04e75h	; 4e13
	defw 0a447h,04e75h,0a4e0h,04e75h,0b6e1h,04e75h,0b8fch,0ba56h	; 4e23
	defw 04e75h,0ba47h,0abd2h,0af20h,09f9dh,09629h,04e75h,04e75h	; 4e33
	defw 09694h,09694h,096aah,096b6h,096b2h,096a2h,0970ch,0a71bh	; 4e43
	defw 0bacbh,0744fh,09629h,0933dh,04e75h,09629h,04e75h,04e7fh	; 4e53
	defw 09720h,0970dh,09809h,0985fh,04e75h,04e75h,04e75h,0bee6h	; 4e63
	defw 0bc10h	; 4e73

; ======================================================================
; CODIGO 0x4e75..0x4ea4  (47 bytes)
; ======================================================================


L_4E75:
	ret			;4e75
tipo_banco_11_b8f4:		; con el banco 11, p11:B8F4, y vuelve a 2-3
	call banco_11		;4e76   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b8f4h		;4e79
	jp bancos_2_3		;4e7c   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_banco_11_a5f0:		; con el banco 11, p11:A5F0, y devuelve el banco de 0xA000
	ld a,(0f0f3h)		;4e7f   ; guarda el banco de 0xA000
	push af			;4e82
	call banco_11		;4e83   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a5f0h		;4e86
	pop af			;4e89   ; y lo devuelve
	di			;4e8a
	ld (0b000h),a		;4e8b   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4e8e   ; guarda la copia del banco de 0xA000
	ei			;4e91
	ret			;4e92
azar_por_nivel:		; A = p00:4EA4[0xE228] + un azar de 0 a 7 (R)
	push hl			;4e93
	ld a,(0e228h)		;4e94   ; el nivel
	ld hl,04ea4h		;4e97
	call hl_mas_a		;4e9a   ; hl_mas_a: HL = HL + A
	ld a,r		;4e9d   ; mas un azar de 0 a 7
	and 007h		;4e9f
	add a,(hl)			;4ea1
	pop hl			;4ea2
	ret			;4ea3

; ----------------------------------------------------------------------
; DATOS tabla_4EA4: 16 bytes que p00:4E94 lee con 0xE228 y a los que suma un
;   azar de 0 a 7 (ld a,r); lo leen p00:4E9A (16 bytes)
;   0x4ea4..0x4eb4  (16 bytes)
DATA_tabla_4EA4:
	defb 068h,060h,048h,040h,038h,030h,028h,024h,020h,01ch,01ah,018h,014h,010h,00eh,00ch	; 4ea4  h`H@80($ .......

; ======================================================================
; CODIGO 0x4eb4..0x4f4c  (152 bytes)
; ======================================================================


rumbo_a_la_nave:		; IX+07-IX+0A = la velocidad hacia la nave desde IX+04/IX+06 (p02:93F5)
	ld e,(ix+004h)		;4eb4   ; E = Y, D = X
	ld d,(ix+006h)		;4eb7
rumbo_desde_de:		; IX+07-IX+0A = la velocidad hacia la nave desde D/E (p02:93F5)
	call 093f5h		;4eba   ; rumbo_a: la velocidad hacia la nave con rapidez A
L_4EBD:
	ld de,(0f012h)		;4ebd   ; la componente Y de la velocidad
	call pon_vy		;4ec1   ; pon_vy: IX+07/IX+08 = DE
	ld de,(0f014h)		;4ec4   ; y la X
	jr pon_vx		;4ec8
rumbo_ix_93e9:		; IX+07-IX+0A con p02:93E9 desde IX+04/IX+06
	ld e,(ix+004h)		;4eca
	ld d,(ix+006h)		;4ecd
	call 093e9h		;4ed0   ; rumbo_sin_error: la velocidad hacia la nave desde D/E con rapidez A, sin el error de los niveles altos
	jr L_4EBD		;4ed3
rumbo_de_80:		; rumbo_de_a con A = 0x80
	ld a,080h		;4ed5
rumbo_de_a:		; IX+07-IX+0A desde IX+04/IX+06 con p02:9467 y p02:93FD (A en 0xF00F, HL en 0xF000-0xF001)
	ld e,(ix+004h)		;4ed7
	ld d,(ix+006h)		;4eda
	ld (0f00fh),a		;4edd   ; 0xF00F = A
	ld a,h			;4ee0   ; 0xF000-0xF001 = HL
	ld (0f000h),a		;4ee1   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,l			;4ee4
	ld (0f001h),a		;4ee5   ; guarda variable de paso: cuantos bytes
	call 09467h		;4ee8   ; angulo_a_f000: el angulo desde D/E hasta 0xF000 (Y), 0xF001 (X)
	ld d,001h		;4eeb
	call 093fdh		;4eed   ; rumbo_del_angulo_d: lo mismo con D = 1 para no poner error
	ld de,(0f014h)		;4ef0   ; lee la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	call pon_vx		;4ef4   ; pon_vx: IX+09/IX+0A = DE
	ld de,(0f012h)		;4ef7   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
pon_vy:		; IX+07/IX+08 = DE
	ld (ix+007h),e		;4efb   ; IX+07/IX+08: la velocidad Y
	ld (ix+008h),d		;4efe
	ret			;4f01
pon_vx:		; IX+09/IX+0A = DE
	ld (ix+009h),e		;4f02   ; IX+09/IX+0A: la velocidad X
	ld (ix+00ah),d		;4f05
	ret			;4f08
lee_vx:		; DE = IX+09/IX+0A
	ld e,(ix+009h)		;4f09
	ld d,(ix+00ah)		;4f0c
	ret			;4f0f
lee_vy:		; DE = IX+07/IX+08
	ld e,(ix+007h)		;4f10
	ld d,(ix+008h)		;4f13
	ret			;4f16
vx_cero_y_vy:		; IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	call vx_cero		;4f17   ; vx_cero: IX+09/IX+0A = 0
	jr pon_vy		;4f1a
vy_cero:		; IX+07/IX+08 = 0
	ld d,000h		;4f1c
	ld e,d			;4f1e
	jr pon_vy		;4f1f
vx_cero:		; IX+09/IX+0A = 0
	ld d,000h		;4f21
	ld e,d			;4f23
	jr pon_vx		;4f24
pon_vx_y_vy:		; IX+09/IX+0A = DE y IX+07/IX+08 = HL
	call pon_vx		;4f26   ; pon_vx: IX+09/IX+0A = DE
	ex de,hl			;4f29   ; y la Y = HL
	jr pon_vy		;4f2a
invierte_vx:		; IX+09/IX+0A = - IX+09/IX+0A
	ld e,(ix+009h)		;4f2c
	ld d,(ix+00ah)		;4f2f
	call menos_de		;4f32   ; cambiada de signo
	ld (ix+009h),e		;4f35
	ld (ix+00ah),d		;4f38
	ret			;4f3b
invierte_vy:		; IX+07/IX+08 = - IX+07/IX+08
	ld e,(ix+007h)		;4f3c
	ld d,(ix+008h)		;4f3f
	call menos_de		;4f42   ; cambiada de signo
	ld (ix+007h),e		;4f45
	ld (ix+008h),d		;4f48
	ret			;4f4b

; ----------------------------------------------------------------------
; DATOS fichas_de_tipo: 65 fichas de 7 bytes, una por tipo de enemigo (0xE350
;   o IX+00), del 1 al 65: p00:4D42 y p01:6514 las leen en 0x4F45 + 7 x tipo
;   (la del 0 caeria en el codigo de delante); lo leen p00:4D51 (455 bytes)
;   0x4f4c..0x5113  (455 bytes)
DATA_fichas_de_tipo:
	defb 0c0h,001h,010h,010h,0b0h,005h,000h	; 4f4c
	defb 081h,0ffh,010h,010h,0f8h,003h,000h	; 4f53
	defb 081h,001h,010h,010h,0dch,00ah,000h	; 4f5a
	defb 081h,001h,010h,010h,068h,003h,000h	; 4f61
	defb 081h,001h,010h,010h,074h,00ah,000h	; 4f68
	defb 081h,001h,010h,010h,058h,004h,000h	; 4f6f
	defb 081h,001h,010h,010h,0f0h,005h,000h	; 4f76
	defb 081h,003h,00dh,00dh,0c4h,008h,000h	; 4f7d
	defb 081h,001h,010h,010h,0a4h,007h,000h	; 4f84
	defb 081h,020h,010h,010h,0d4h,004h,000h	; 4f8b
	defb 0c0h,001h,010h,010h,000h,000h,021h	; 4f92
	defb 081h,001h,010h,010h,0c4h,003h,000h	; 4f99
	defb 081h,001h,010h,010h,0b4h,007h,000h	; 4fa0
	defb 081h,001h,010h,010h,0fch,00ah,000h	; 4fa7
	defb 081h,001h,010h,010h,0f8h,003h,000h	; 4fae
	defb 081h,001h,010h,010h,058h,00ah,000h	; 4fb5
	defb 081h,001h,010h,010h,0f0h,007h,000h	; 4fbc
	defb 081h,001h,010h,010h,0d4h,00bh,000h	; 4fc3
	defb 0c0h,00ah,018h,018h,000h,000h,004h	; 4fca
	defb 081h,001h,010h,010h,0e4h,004h,000h	; 4fd1
	defb 081h,001h,010h,010h,0e8h,003h,000h	; 4fd8
	defb 081h,001h,010h,010h,0dch,003h,000h	; 4fdf
	defb 0c0h,020h,000h,040h,000h,000h,02bh	; 4fe6
	defb 081h,002h,010h,010h,0e0h,005h,000h	; 4fed
	defb 081h,0ffh,010h,010h,0d4h,00eh,000h	; 4ff4
	defb 081h,001h,010h,010h,068h,00eh,000h	; 4ffb
	defb 040h,001h,010h,010h,000h,000h,003h	; 5002
	defb 081h,001h,010h,010h,0b0h,00fh,000h	; 5009
	defb 081h,001h,002h,002h,054h,00ah,000h	; 5010
	defb 081h,001h,010h,010h,0d0h,00ah,000h	; 5017
	defb 081h,001h,010h,010h,0e8h,008h,000h	; 501e
	defb 0c0h,0ffh,010h,020h,000h,000h,000h	; 5025
	defb 000h,000h,000h,000h,000h,000h,000h	; 502c
	defb 081h,001h,002h,002h,054h,00ah,000h	; 5033
	defb 0c0h,0ffh,008h,010h,000h,000h,000h	; 503a
	defb 0c0h,0ffh,020h,008h,000h,000h,000h	; 5041
	defb 081h,001h,010h,010h,0d0h,008h,000h	; 5048
	defb 081h,000h,010h,010h,044h,00fh,000h	; 504f
	defb 081h,001h,010h,010h,0e4h,006h,000h	; 5056
	defb 0c0h,030h,020h,020h,000h,000h,006h	; 505d
	defb 0c0h,001h,010h,010h,000h,000h,001h	; 5064
	defb 0c0h,001h,010h,010h,000h,000h,002h	; 506b
	defb 081h,001h,010h,010h,000h,002h,037h	; 5072
	defb 081h,001h,010h,010h,000h,008h,038h	; 5079
	defb 081h,001h,010h,010h,000h,008h,038h	; 5080
	defb 081h,001h,010h,010h,000h,000h,000h	; 5087
	defb 081h,001h,010h,010h,000h,000h,006h	; 508e
	defb 081h,003h,010h,010h,0d0h,009h,000h	; 5095
	defb 081h,001h,010h,010h,068h,009h,000h	; 509c
	defb 081h,001h,002h,002h,054h,003h,000h	; 50a3
	defb 081h,000h,000h,000h,044h,00fh,000h	; 50aa
	defb 081h,001h,010h,00ah,0ech,00fh,000h	; 50b1
	defb 081h,001h,010h,010h,0a4h,004h,000h	; 50b8
	defb 081h,000h,000h,000h,044h,00fh,000h	; 50bf
	defb 081h,001h,010h,010h,0e4h,005h,000h	; 50c6
	defb 084h,0ffh,008h,010h,0d0h,002h,000h	; 50cd
	defb 0c0h,0ffh,002h,008h,000h,000h,000h	; 50d4
	defb 0c0h,0ffh,008h,008h,000h,000h,000h	; 50db
	defb 0c0h,0ffh,002h,008h,000h,000h,000h	; 50e2
	defb 0c0h,0ffh,008h,008h,000h,000h,000h	; 50e9
	defb 081h,010h,010h,010h,0e8h,003h,000h	; 50f0
	defb 081h,001h,010h,010h,0e8h,008h,000h	; 50f7
	defb 081h,001h,010h,00ah,0ech,00fh,000h	; 50fe
	defb 081h,001h,010h,00ah,0c4h,00bh,000h	; 5105
	defb 0c0h,001h,008h,002h,000h,000h,01eh	; 510c

; ======================================================================
; CODIGO 0x5113..0x5265  (338 bytes)
; ======================================================================


apariciones_de_capsula:		; lo que trae la columna (p00:5130) hasta ponerse al dia (0xE37D)
	call aparicion_de_capsula		;5113   ; aparicion_de_capsula: con el banco 12, la siguiente ficha de p12:BB72 de la fase: si es su columna, pone la capsula C (p00:5157)
	jr z,apariciones_de_capsula		;5116   ; Z: puesta; sigue con la siguiente
	ret c			;5118   ; C: todavia no ha llegado su columna
	ld hl,0e37dh		;5119   ; ya pasada: a la siguiente
	inc (hl)			;511c
	jp apariciones_de_capsula		;511d   ; apariciones_de_capsula: lo que trae la columna (p00:5130) hasta ponerse al dia (0xE37D)
apariciones_del_scroll:		; si el scroll avanzo (0xE320), lo que trae la columna nueva (X = 0xF8)
	ld a,(0e320h)		;5120   ; lee la marca de scroll hecho en este cuadro
	and a			;5123
	ret z			;5124
	ld a,0f8h		;5125   ; lo nuevo aparece por el borde derecho
	ld (0f004h),a		;5127   ; guarda variable de paso
L_512A:
	call aparicion_de_capsula		;512a   ; aparicion_de_capsula: con el banco 12, la siguiente ficha de p12:BB72 de la fase: si es su columna, pone la capsula C (p00:5157)
	jr z,L_512A		;512d
	ret			;512f
aparicion_de_capsula:		; con el banco 12, la siguiente ficha de p12:BB72 de la fase: si es su columna, pone la capsula C (p00:5157)
	call banco_12		;5130   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld a,(0e37dh)		;5133   ; la siguiente ficha de la fase
	ld hl,0bb72h		;5136
	call aparicion_de_fase		;5139   ; aparicion_de_fase: la ficha A (3 bytes [columna][dato]) de la lista HL de la fase: DE = su columna, C = el dato, y compara con la columna del scroll (Z llegada, C todavia no)
	jp nz,bancos_2_3		;513c   ; no es su columna: fuera
	ld hl,0e37dh		;513f   ; la ficha gastada
	inc (hl)			;5142
	ld a,c			;5143   ; el nibble alto del dato: la Y
	and 0f0h		;5144
	ld e,a			;5146
	ld a,(0f004h)		;5147   ; la X
	ld d,a			;514a
	ld a,c			;514b   ; el nibble bajo: la clase de capsula
	and 00fh		;514c
	ld c,a			;514e
	call pon_capsula		;514f   ; pon_capsula: la capsula especial C del mapa en D (X), E (Y) (0xEA60-0xEA62), si no hay otra, ni cuenta atras, ni R.DRILL
	call bancos_2_3		;5152   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	xor a			;5155
	ret			;5156
pon_capsula:		; la capsula especial C del mapa en D (X), E (Y) (0xEA60-0xEA62), si no hay otra, ni cuenta atras, ni R.DRILL
	ld a,(0ea60h)		;5157   ; ya hay una capsula especial?
	or a			;515a
	ret nz			;515b
	ld a,(0e439h)		;515c   ; o una cuenta atras en marcha?
	or a			;515f
	ret nz			;5160
	ld a,(0e400h)		;5161   ; o la nave es el R.DRILL?
	cp 003h		;5164
	ret z			;5166
	ld a,c			;5167   ; la clase 1 no sale con 0xE36D puesto
	dec a			;5168
	jr nz,L_5170		;5169
	ld a,(0e36dh)		;516b   ; lee cuantos enemigos 0x2A hay
	or a			;516e
	ret nz			;516f
L_5170:
	ld hl,0ea60h		;5170   ; [clase][Y][X]
	ld (hl),c			;5173
	inc l			;5174
	ld (hl),e			;5175
	inc l			;5176
	ld (hl),d			;5177
	jp caracter_e9		;5178   ; y su caracter 0xE9
sprites_de_balas:		; los atributos de sprite de las 10 fichas de 0xE900 (Y, X, dibujo, color) a 0xE2D8; las libres con Y = 0xE0
	ld de,00010h		;517b
	exx			;517e
	ld ix,0e900h		;517f   ; las 10 fichas de 16 bytes
	ld de,0e2d8h		;5183   ; a sus sprites
	ld b,00ah		;5186
L_5188:
	ld a,(ix+000h)		;5188   ; libre: la esconde
	and a			;518b
	jr z,L_51A9		;518c
	ld a,(ix+004h)		;518e   ; Y, X, dibujo (IX+0B) y color (IX+0C)
	ld (de),a			;5191
	inc e			;5192
	ld a,(ix+006h)		;5193
	ld (de),a			;5196
	inc e			;5197
	ld a,(ix+00bh)		;5198
	ld (de),a			;519b
	inc e			;519c
	ld a,(ix+00ch)		;519d
	ld (de),a			;51a0
	inc e			;51a1
L_51A2:
	exx			;51a2
	add ix,de		;51a3
	exx			;51a5
	djnz L_5188		;51a6
	ret			;51a8
L_51A9:
	ld a,0e0h		;51a9   ; Y = 0xE0: fuera de la pantalla
	ld (de),a			;51ab
	inc e			;51ac
	inc e			;51ad
	inc e			;51ae
	inc e			;51af
	jp L_51A2		;51b0
sprites_de_enemigos:		; si no esta 0xE3AA, los enemigos de 0xE600 a sprites (0xE2A8) o a caracteres, con los bancos 7-8-9
	ld a,(0e3aah)		;51b3   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;51b6
	ret nz			;51b7
	call bancos_7_8_9		;51b8   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call sprites_de_enemigos_sin_bancos		;51bb   ; sprites_de_enemigos_sin_bancos: las 12 fichas de 0xE600: los tipos 0x24 (jefe), 0x29-0x2D y 0x39-0x3C de caracteres; los demas con IX+0B bit 6 de caracteres, o de 1 a 63 sprites
	jp bancos_1_2_3		;51be   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
sprites_de_enemigos_sin_bancos:		; las 12 fichas de 0xE600: los tipos 0x24 (jefe), 0x29-0x2D y 0x39-0x3C de caracteres; los demas con IX+0B bit 6 de caracteres, o de 1 a 63 sprites
	ld de,0e2a8h		;51c1   ; los 12 sprites de enemigos fuera de la pantalla
	ld b,00ch		;51c4
	ld a,0e0h		;51c6
L_51C8:
	ld (de),a			;51c8
	inc e			;51c9
	inc e			;51ca
	inc e			;51cb
	inc e			;51cc
	djnz L_51C8		;51cd
	ld ix,0e600h		;51cf   ; las 12 fichas de enemigos
	ld de,0e2a8h		;51d3   ; apunta a los sprites de los 12 enemigos
	ld b,00ch		;51d6
L_51D8:
	push bc			;51d8
	ld a,(ix+000h)		;51d9   ; libre
	or a			;51dc
	jr z,L_51FF		;51dd
	bit 7,(ix+00bh)		;51df   ; bit 7 de IX+0B: se ve
	jr z,L_51FF		;51e3
	cp 024h		;51e5   ; el tipo 0x24 es el jefe, de caracteres
	jp z,L_526A		;51e7
	sub 029h		;51ea   ; los tipos 0x29-0x2D, bloques de 2x2
	cp 005h		;51ec
	jr c,L_520A		;51ee
	sub 010h		;51f0   ; los 0x39-0x3C, una fila de caracteres (p00:4CA3)
	cp 004h		;51f2
	jr c,$+126		;51f4
	bit 6,(ix+00bh)		;51f6   ; bit 6 de IX+0B: de caracteres; si no, sprites (p00:527A)
	jr z,$+128		;51fa
	call nz,enemigo_de_caracteres		;51fc   ; enemigo_de_caracteres: el dibujo IX+32 (p08:9DA5) de IX+13 filas x IX+14 en la pantalla de RAM (IX+11/IX+12), cortado por el borde derecho
L_51FF:
	exx			;51ff
	ld de,00040h		;5200   ; la ficha siguiente
	add ix,de		;5203
	exx			;5205
	pop bc			;5206
	djnz L_51D8		;5207
	ret			;5209
L_520A:
	push de			;520a
	call enemigo_2x2		;520b   ; enemigo_2x2: los tipos 0x29-0x2D: un bloque de 2x2 caracteres (p00:5265) en la pantalla de RAM, si esta en pantalla (X < 0xF8)
	pop de			;520e
	jp L_51FF		;520f
enemigo_2x2:		; los tipos 0x29-0x2D: un bloque de 2x2 caracteres (p00:5265) en la pantalla de RAM, si esta en pantalla (X < 0xF8)
	ld c,a			;5212
	ld a,(ix+006h)		;5213   ; fuera de la pantalla por la derecha: nada
	cp 0f8h		;5216
	ret nc			;5218
	ld a,c			;5219   ; el primer caracter de su clase
	ld hl,05265h		;521a
	call byte_a		;521d   ; byte_a: A = el byte A de la tabla HL
	ld c,a			;5220
	ld l,(ix+011h)		;5221   ; IX+11/IX+12: el sitio en la pantalla de RAM
	ld h,(ix+012h)		;5224
bloque_2x2:		; 2x2 caracteres desde C en HL; en las fases 3, 9, 10 y 11 sin tapar los del mapa (0x1F-0x66)
	ld a,(0e201h)		;5227   ; en las fases 3, 9, 10 y 11, con cuidado
	cp 003h		;522a
	jr z,L_5242		;522c
	sub 009h		;522e
	cp 003h		;5230
	jr c,L_5242		;5232
	ld (hl),c			;5234   ; los cuatro caracteres seguidos: arriba y abajo
	inc l			;5235
	inc c			;5236
	ld (hl),c			;5237
	ld de,0001fh		;5238
	add hl,de			;523b
	inc c			;523c
	ld (hl),c			;523d
	inc l			;523e
	inc c			;523f
	ld (hl),c			;5240
	ret			;5241
L_5242:
	ld b,048h		;5242   ; 0x48 caracteres a partir de 0x1F son del mapa
	ld de,0001fh		;5244
	ld a,(hl)			;5247
	sub e			;5248
	cp b			;5249
	jr c,L_524D		;524a
	ld (hl),c			;524c   ; solo tapa lo que no es mapa
L_524D:
	inc c			;524d   ; el de la derecha
	inc l			;524e
	ld a,(hl)			;524f   ; lo que hay debajo
	sub e			;5250
	cp b			;5251
	jr c,L_5255		;5252
	ld (hl),c			;5254
L_5255:
	inc c			;5255   ; la fila de abajo
	add hl,de			;5256
	ld a,(hl)			;5257   ; lo que hay debajo
	sub e			;5258
	cp b			;5259
	jr c,L_525D		;525a
	ld (hl),c			;525c
L_525D:
	inc c			;525d   ; el de abajo a la derecha
	inc l			;525e
	ld a,(hl)			;525f   ; lo que hay debajo
	sub e			;5260
	cp b			;5261
	ret c			;5262
	ld (hl),c			;5263
	ret			;5264

; ----------------------------------------------------------------------
; DATOS tabla_5265: 5 bytes que p00:5219 lee con C (L_5CA6); lo leen p00:521D
;   (5 bytes)
;   0x5265..0x526a  (5 bytes)
DATA_tabla_5265:
	defb 0edh,0c7h,0a5h,0a1h,0a1h	; 5265

; ======================================================================
; CODIGO 0x526a..0x5462  (504 bytes)
; ======================================================================


L_526A:
	push de			;526a
	call pon_el_jefe		;526b   ; pon_el_jefe: copia el dibujo del jefe (p00:4BE8, IX+13 filas de IX+14) a la pantalla de RAM en IX+04/IX+06
	pop de			;526e
	jp L_51FF		;526f
L_5272:
	push de			;5272
	call fila_de_caracteres		;5273   ; fila_de_caracteres: IX+14 caracteres IX+32 seguidos en la pantalla de RAM desde IX+11/IX+12
	pop de			;5276
	jp L_51FF		;5277
L_527A:
	ld a,(ix+00bh)		;527a   ; IX+0B bits 0-5: cuantos sprites
	and 03fh		;527d
	ld b,a			;527f
	jp z,L_51FF		;5280
	ld a,(ix+004h)		;5283   ; el primero: IX+04 Y, IX+06 X, IX+30 dibujo, IX+31 color
	ld (de),a			;5286
	inc e			;5287
	ld a,(ix+006h)		;5288
	ld (de),a			;528b
	inc e			;528c
	ld a,(ix+030h)		;528d
	ld (de),a			;5290
	inc e			;5291
	ld a,(ix+031h)		;5292
	ld (de),a			;5295
	inc e			;5296
	dec b			;5297   ; los demas, de IX+34 en adelante
	jp z,L_51FF		;5298
	push ix		;529b
	pop hl			;529d
	ld a,034h		;529e
	add a,l			;52a0
	ld l,a			;52a1
	jr nc,L_52A5		;52a2
	inc h			;52a4
L_52A5:
	push bc			;52a5
	ld a,(hl)			;52a6   ; Y y X
	ld (de),a			;52a7
	inc l			;52a8
	inc e			;52a9
	ld a,(hl)			;52aa
	ld (de),a			;52ab
	inc l			;52ac
	inc e			;52ad
	ldi		;52ae   ; dibujo y color
	ldi		;52b0
	pop bc			;52b2
	djnz L_52A5		;52b3
	jp L_51FF		;52b5
enemigo_de_caracteres:		; el dibujo IX+32 (p08:9DA5) de IX+13 filas x IX+14 en la pantalla de RAM (IX+11/IX+12), cortado por el borde derecho
	ld a,(ix+004h)		;52b8   ; fuera por abajo: nada
	cp 0b8h		;52bb
	ret nc			;52bd
	ld a,(ix+006h)		;52be   ; o por la derecha
	cp 0f8h		;52c1
	ret nc			;52c3
	push de			;52c4
	ld de,09da5h		;52c5   ; el dibujo IX+32 de p08:9DA5
	ld a,(ix+032h)		;52c8
	call palabra_a_de		;52cb   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ex de,hl			;52ce
	ld e,(ix+011h)		;52cf   ; IX+11/IX+12: el sitio en la pantalla de RAM
	ld d,(ix+012h)		;52d2
	ld b,(ix+013h)		;52d5   ; IX+13 filas
	ld c,(ix+006h)		;52d8   ; los caracteres que caben hasta el borde derecho
	xor a			;52db
	sub c			;52dc
	jr nz,L_52E1		;52dd
	ld a,0f8h		;52df
L_52E1:
	rra			;52e1
	rra			;52e2
	rra			;52e3
	and 01fh		;52e4
	ld c,(ix+014h)		;52e6   ; IX+14 de ancho, o lo que quepa
	cp c			;52e9
	jr nc,L_52ED		;52ea
	ld c,a			;52ec
L_52ED:
	push bc			;52ed   ; una fila
	ld a,c			;52ee
	ld b,000h		;52ef
	ldir		;52f1   ; copia lo que cabe
	sub (ix+014h)		;52f3   ; salta lo que no cabe
	jr z,L_52FF		;52f6
	neg		;52f8
	add a,l			;52fa
	ld l,a			;52fb
	jr nc,L_52FF		;52fc
	inc h			;52fe
L_52FF:
	pop bc			;52ff
	ld a,020h		;5300   ; a la fila siguiente de la pantalla
	sub c			;5302
	add a,e			;5303
	ld e,a			;5304
	jr nc,L_5308		;5305
	inc d			;5307
L_5308:
	djnz L_52ED		;5308
	pop de			;530a
	ret			;530b
borra_bloque:		; borra C filas de B caracteres en la pantalla de RAM en H (X), L (Y), cortado por el borde
	call sitio_y_ancho		;530c   ; sitio_y_ancho: HL = el sitio de H (X), L (Y) en la pantalla de RAM y B recortado al borde derecho
	ld e,b			;530f
L_5310:
	ld a,h			;5310
	cp 0f0h		;5311   ; de la fila 0xF0 en adelante, fuera de la pantalla de RAM
	ret nc			;5313
	ld b,e			;5314
	xor a			;5315
	ld d,l			;5316   ; una fila de B ceros
L_5317:
	ld (hl),a			;5317
	inc l			;5318
	djnz L_5317		;5319
	ld l,d			;531b
	ld a,020h		;531c   ; la fila siguiente
	add a,l			;531e
	ld l,a			;531f
	jr nc,L_5323		;5320
	inc h			;5322
L_5323:
	dec c			;5323
	jr nz,L_5310		;5324
	ret			;5326
copia_bloque:		; copia DE en la pantalla de RAM en H (X), L (Y): C filas de B (de A de ancho en origen), cortado por el borde
	push bc			;5327
	call sitio_y_ancho		;5328   ; sitio_y_ancho: HL = el sitio de H (X), L (Y) en la pantalla de RAM y B recortado al borde derecho
	pop af			;532b
	sub b			;532c   ; lo que no cabe de cada fila, se salta en el origen
	exx			;532d
	ld c,a			;532e
	exx			;532f
	ld a,020h		;5330   ; 32 - B: el salto a la fila siguiente de la pantalla
	sub b			;5332
	exx			;5333
	ld d,a			;5334
	exx			;5335
	ld a,c			;5336
	ld c,b			;5337
	ld b,a			;5338
	ex de,hl			;5339
L_533A:
	ld a,d			;533a
	cp 0f0h		;533b   ; de 0xF000 en adelante, fuera
	ret nc			;533d
	push bc			;533e
	ld b,000h		;533f   ; una fila
	ldir		;5341
	pop bc			;5343
	exx			;5344
	ld a,c			;5345
	exx			;5346
	add a,l			;5347
	ld l,a			;5348
	jr nc,L_534C		;5349
	inc h			;534b
L_534C:
	exx			;534c   ; la fila siguiente del origen
	ld a,d			;534d
	exx			;534e
	add a,e			;534f   ; y de la pantalla
	ld e,a			;5350
	jr nc,L_5354		;5351
	inc d			;5353
L_5354:
	djnz L_533A		;5354
	ret			;5356
sitio_y_ancho:		; HL = el sitio de H (X), L (Y) en la pantalla de RAM y B recortado al borde derecho
	call sitio_en_pantalla		;5357   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld a,l			;535a   ; la columna
	and 01fh		;535b
	add a,b			;535d   ; cuanto se pasa del borde derecho
	sub 020h		;535e
	ret c			;5360
	neg		;5361
	add a,b			;5363   ; B = lo que cabe
	ld b,a			;5364
	ret			;5365
empieza_el_medidor:		; 0xE330-0xE33C a cero, p02:8060 y, con 0xE20B o 0xE20D, la casilla 1; y lo pinta
	ld hl,0e330h		;5366   ; el medidor a cero
	ld de,0e331h		;5369   ; apunta a cuantas casillas tiene el medidor
	ld bc,0000ch		;536c
	ld (hl),000h		;536f
	ldir		;5371
	call 08060h		;5373   ; p02:8060: las armas capturadas
	ld a,(0e20bh)		;5376   ; lee la marca de equipo guardado (Galious)
	or a			;5379
	jr nz,L_5382		;537a
	ld a,(0e20dh)		;537c   ; lee la casilla encendida al caer
	or a			;537f
	jr z,pinta_el_medidor		;5380
L_5382:
	ld a,001h		;5382   ; con 0xE20B o 0xE20D, la primera casilla encendida
	ld (0e330h),a		;5384   ; guarda la casilla iluminada del medidor
pinta_el_medidor:		; el recuadro del rotulo (caracteres 0x15-0x1C), las casillas del medidor y el rotulo
	ld hl,010a8h		;5387   ; los colores de los caracteres 0x15-0x1C: el recuadro del rotulo
	ld bc,00040h		;538a
	ld a,0a4h		;538d
	call 00056h		;538f   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03ad4h		;5392   ; en la fila 22, columna 20
	call prepara_escritura_vram		;5395   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	ld b,008h		;5398   ; los caracteres 0x15-0x1C
	ld a,015h		;539a
L_539C:
	exx			;539c
	out (c),a		;539d
	inc a			;539f
	exx			;53a0
	djnz L_539C		;53a1
casillas_del_medidor:		; las 9 casillas del medidor (0xE334) en la fila 22 y el rotulo de la casilla 0xE330
	ld hl,03ac1h		;53a3   ; en la fila 22, columna 1
	call prepara_escritura_vram		;53a6   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	ld hl,0e334h		;53a9   ; apunta a las 9 casillas del medidor
	ld bc,00901h		;53ac   ; 9 casillas, de la 1 en adelante
	ld a,(0e331h)		;53af   ; D: cuantas tiene el medidor
	dec a			;53b2
	ld d,a			;53b3
L_53B4:
	dec d			;53b4
	call casilla_del_medidor		;53b5   ; casilla_del_medidor: la casilla C: apagada, encendida, elegida o gastada (caracteres 0x0B-0x10, 0x1D-0x1E)
	inc hl			;53b8
	inc c			;53b9
	djnz L_53B4		;53ba
	ld a,(0e439h)		;53bc   ; con cuenta atras se queda el rotulo de la capsula
	or a			;53bf
	ret nz			;53c0
	ld a,(0e20bh)		;53c1   ; con 0xE20B, el rotulo 1
	or a			;53c4
	ld a,001h		;53c5
	jr nz,pon_rotulo		;53c7
	ld de,0e330h		;53c9   ; ninguna casilla encendida: sin rotulo
	ld a,(de)			;53cc
	ld b,a			;53cd
	or a			;53ce
	jr z,L_53F5		;53cf
	ld de,0e333h		;53d1   ; lo que hay en la casilla encendida
	add a,e			;53d4
	ld e,a			;53d5
	ld a,(de)			;53d6
	ld c,a			;53d7
	cp 0ffh		;53d8   ; 0xFF: el rotulo 21
	jr z,L_53F1		;53da
	ld a,(0e20fh)		;53dc   ; si no, de la tabla de las armas capturadas (p00:5462)
	ld hl,05462h		;53df
	call palabra_a		;53e2   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;53e5
	ld a,b			;53e6
	call palabra_a		;53e7   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;53ea
	ld b,000h		;53eb
	add hl,bc			;53ed
	ld a,(hl)			;53ee
	jr pon_rotulo		;53ef
L_53F1:
	ld a,015h		;53f1
	jr pon_rotulo		;53f3
L_53F5:
	xor a			;53f5
pon_rotulo:		; el rotulo A (1-25, p14:9BD3) en los caracteres 0x15-0x1C del tercio de abajo; del 21 en adelante en negativo
	ld hl,030a8h		;53f6   ; los dibujos de los caracteres 0x15-0x1C del tercio de abajo
pon_rotulo_en:		; el rotulo A en la VRAM HL
	ld (0f000h),hl		;53f9   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	push af			;53fc
	call bancos_14_15		;53fd   ; el banco 14 en 0x8000
	ld hl,(0f000h)		;5400   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	call prepara_escritura_vram		;5403   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;5406
	pop af			;5407
	ld b,a			;5408
	ld hl,09bd3h		;5409   ; los dibujos del rotulo (p14:9BD3)
	call palabra_a		;540c   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;540f
	ld a,b			;5410
	dec a			;5411
	ld e,0ffh		;5412   ; E = 0xFF: el borde de arriba y de abajo; del 21 en adelante, 0
	cp 014h		;5414
	jr c,L_5419		;5416
	inc e			;5418
L_5419:
	ld d,008h		;5419   ; 8 caracteres
L_541B:
	out (c),e		;541b   ; la fila de arriba
	nop			;541d
	ld b,006h		;541e   ; 6 filas del rotulo
L_5420:
	outi		;5420
	jp nz,L_5420		;5422
	nop			;5425
	out (c),e		;5426   ; la de abajo
	dec d			;5428
	jr nz,L_541B		;5429
	jp bancos_2_3		;542b   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
casilla_del_medidor:		; la casilla C: apagada, encendida, elegida o gastada (caracteres 0x0B-0x10, 0x1D-0x1E)
	ld a,d			;542e   ; fuera del medidor: en blanco
	or a			;542f
	jp m,L_5458		;5430
	ld a,(hl)			;5433   ; 0xFF: gastada
	inc a			;5434
	jr nz,L_5444		;5435
	ld a,(0e330h)		;5437   ; la elegida?
	cp c			;543a
	ld a,00fh		;543b   ; gastada: 0x0F, o 0x1D si es la elegida
	jr nz,L_544E		;543d
	ld a,01dh		;543f
	jp L_544E		;5441
L_5444:
	ld a,(0e330h)		;5444   ; normal: 0x0B, o 0x0D si es la elegida
	cp c			;5447
	ld a,00bh		;5448
	jr nz,L_544E		;544a
	ld a,00dh		;544c
L_544E:
	exx			;544e   ; los dos caracteres de la casilla
	out (c),a		;544f
	exx			;5451
	inc a			;5452
	exx			;5453
	out (c),a		;5454
	exx			;5456
	ret			;5457
L_5458:
	xor a			;5458   ; dos espacios
	exx			;5459
	out (c),a		;545a
	exx			;545c
	exx			;545d
	out (c),a		;545e
	exx			;5460
	ret			;5461

; ----------------------------------------------------------------------
; DATOS tablas_5462: 8 punteros, uno por cada cuenta de armas capturadas
;   (0xE20F), a tablas de punteros (indice B en p00:53E7) a tiras de bytes que
;   acaban en 0x54AE-0x54C6; las lee p00:53DC con L_4B67 dos veces; lo leen
;   p00:53E2 (101 bytes)
;   0x5462..0x54c7  (101 bytes)
DATA_tablas_5462:
	defb 070h,054h,07ch,054h,08ah,054h,08ah,054h,08ah,054h,08ah,054h,09ah,054h,09ah,054h	; 5462  pT|T.T.T.T.T.T.T
	defb 0aeh,054h,0b5h,054h,0b9h,054h,0c0h,054h,0c4h,054h,0c6h,054h,0aeh,054h,0b5h,054h	; 5472  .T.T.T.T.T.T.T.T
	defb 0b9h,054h,0bch,054h,0c0h,054h,0c4h,054h,0c6h,054h,0aeh,054h,0b5h,054h,0b9h,054h	; 5482  .T.T.T.T.T.T.T.T
	defb 0bch,054h,0beh,054h,0c0h,054h,0c4h,054h,0c6h,054h,0aeh,054h,0b5h,054h,0b8h,054h	; 5492  .T.T.T.T.T.T.T.T
	defb 0b9h,054h,0bch,054h,0beh,054h,0c0h,054h,0c4h,054h,0c6h,054h,002h,002h,002h,002h	; 54a2  .T.T.T.T.T.T....
	defb 002h,002h,002h,003h,004h,005h,006h,007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh	; 54b2  ................
	defb 010h,011h,012h,013h,014h	; 54c2

; ======================================================================
; CODIGO 0x54c7..0x554f  (136 bytes)
; ======================================================================


rotulo_y_recuadro:		; el rotulo B, el recuadro con 0xA0 y la cuenta atras
	ld a,b			;54c7
	call pon_rotulo		;54c8   ; pon_rotulo: el rotulo A (1-25, p14:9BD3) en los caracteres 0x15-0x1C del tercio de abajo; del 21 en adelante en negativo
	ld b,0a0h		;54cb   ; y el recuadro con el color 0xA0
	call color_del_recuadro		;54cd   ; color_del_recuadro: los colores de los caracteres 0x15-0x1C del tercio de abajo con B
	jr L_54E6		;54d0
color_del_recuadro:		; los colores de los caracteres 0x15-0x1C del tercio de abajo con B
	ld a,b			;54d2
	ld hl,010a8h		;54d3
	ld bc,00040h		;54d6
	jp 00056h		;54d9   ; BIOS FILVRM - Fills VRAM with value
fin_de_cuenta_atras:		; 0xE1D5 = 1: pinta los segundos (y pita por debajo de 4); 2: se acaba la capsula especial (0xE439)
	ld a,(0e1d5h)		;54dc   ; 1: un segundo menos
	dec a			;54df
	jr z,L_54E6		;54e0
	dec a			;54e2   ; 2: se acabo
	jr z,L_5500		;54e3
	ret			;54e5
L_54E6:
	ld de,0e43ah		;54e6   ; pinta los segundos que quedan en la fila 22, columna 26
	ld hl,03adah		;54e9
	ld b,001h		;54ec
	call pinta_bcd		;54ee   ; pinta_bcd: B bytes BCD de DE hacia atras en la VRAM HL, dos cifras por byte (caracter = cifra + 1)
	xor a			;54f1   ; atendido
	ld (0e1d5h),a		;54f2   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	ld a,(0e43ah)		;54f5   ; menos de 4 segundos: pita
	cp 004h		;54f8
	ret nc			;54fa
	ld a,021h		;54fb
	jp sonido		;54fd   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_5500:
	ld a,021h		;5500   ; se acabo: suena 0x21
	call sonido		;5502   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,(0e439h)		;5505   ; la capsula 3: p03:AA2F y p03:AAEC
	sub 003h		;5508
	jr nz,L_5514		;550a
	call 0aa2fh		;550c
	call 0aaech		;550f
	jr L_5534		;5512
L_5514:
	dec a			;5514   ; la capsula 4
	jr nz,L_5534		;5515
	ld hl,0e445h		;5517   ; con 0xE445, p01:7F98
	ld a,(hl)			;551a
	or a			;551b
	jr z,L_5525		;551c
	ld (hl),000h		;551e
	call 07f98h		;5520   ; pon_escudo: 0xE400 = 2 (con escudo) y 0xE401 = 10 golpes
	jr L_5531		;5523
L_5525:
	ld a,(0e401h)		;5525   ; si no, la nave vuelve a ser normal (o con escudo)
	or a			;5528
	ld a,001h		;5529
	jr z,L_552E		;552b
	inc a			;552d
L_552E:
	ld (0e400h),a		;552e   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
L_5531:
	call sprites_de_la_nave		;5531   ; y sus dibujos
L_5534:
	xor a			;5534   ; se acabo la capsula especial
	ld (0e439h),a		;5535   ; guarda la capsula especial en marcha (con cuenta atras)
	ld (0e1d5h),a		;5538   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	jp pinta_el_medidor		;553b   ; pinta_el_medidor: el recuadro del rotulo (caracteres 0x15-0x1C), las casillas del medidor y el rotulo
vacia_casilla_de_arma:		; pone a cero la casilla de 0xE3xx del arma capturada 0xE20F (p00:554F) y repinta el medidor
	ld a,(0e20fh)		;553e   ; lee las armas capturadas (0-7)
	ld hl,0554fh		;5541   ; la casilla de esa arma
	call hl_mas_a		;5544   ; hl_mas_a: HL = HL + A
	ld l,(hl)			;5547
	ld h,0e3h		;5548   ; 0xE3xx
	ld (hl),000h		;554a
	jp casillas_del_medidor		;554c   ; casillas_del_medidor: las 9 casillas del medidor (0xE334) en la fila 22 y el rotulo de la casilla 0xE330

; ----------------------------------------------------------------------
; DATOS tabla_554F: 8 bytes, uno por cada cuenta de armas capturadas (0xE20F):
;   la casilla 0xE3xx que p00:553E pone a cero; lo leen p00:5544 (8 bytes)
;   0x554f..0x5557  (8 bytes)
DATA_tabla_554F:
	defb 039h,03ah,03bh,03bh,03bh,03bh,03ch,03ch	; 554f  9:....<<

; ----------------------------------------------------------------------
; DATOS metabloques_por_fase: 12 punteros (uno por fase, 0xE201) a los
;   metabloques del banco 13; p00:48C3 los lee con L_4B67; lo leen p00:48C6
;   (24 bytes)
;   0x5557..0x556f  (24 bytes)
DATA_metabloques_por_fase:
	defw 07558h,06040h,06290h,065e0h,06768h,06980h	; 5557
	defw 06b78h,06f50h,07558h,065e0h,065e0h,065e0h	; 5563

; ----------------------------------------------------------------------
; DATOS caracteres_556F: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p00:4B29 (43
;   bytes)
;   0x556f..0x559a  (43 bytes)
DATA_caracteres_556F:
	defb 007h,0dbh,0a6h,01fh,0abh,0aah	; 556f
	defb 007h,049h,0a9h,070h,0c4h,0ach	; 5575
	defb 007h,063h,0aah,06dh,0a9h,0adh	; 557b
	defb 007h,07dh,0aah,0c0h,0c2h,0adh	; 5581
	defb 007h,0dah,0adh,0a0h,0afh,0aeh	; 5587
	defb 007h,06fh,0afh,0c7h,060h,0afh	; 558d
	defb 007h,097h,0aah,0c6h,0a1h,0aah	; 5593
	defb 000h	; 5599

; ----------------------------------------------------------------------
; DATOS copias_559A: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:4B35
;   (13 bytes)
;   0x559a..0x55a7  (13 bytes)
DATA_copias_559A:
	defb 01fh,046h,039h,010h,02fh,056h,039h,017h,070h,087h,039h,017h,000h	; 559a  .F9./V9.p.9..

; ----------------------------------------------------------------------
; DATOS caracteres_55A7: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p01:6165 (55
;   bytes)
;   0x55a7..0x55de  (55 bytes)
DATA_caracteres_55A7:
	defb 006h,07eh,0afh,040h,095h,0b1h	; 55a7
	defb 006h,098h,0afh,04eh,09ah,0b1h	; 55ad
	defb 006h,0ceh,0afh,05eh,0d2h,0b1h	; 55b3
	defb 006h,04dh,0b0h,072h,013h,0b2h	; 55b9
	defb 006h,09ch,0b0h,088h,03bh,0b2h	; 55bf
	defb 006h,0f9h,0b0h,09bh,083h,0b2h	; 55c5
	defb 006h,032h,0b1h,0a5h,0b9h,0b2h	; 55cb
	defb 006h,032h,0b1h,0bbh,019h,0b3h	; 55d1
	defb 006h,0f9h,0b0h,0d0h,079h,0b3h	; 55d7
	defb 000h	; 55dd

; ----------------------------------------------------------------------
; DATOS copias_55DE: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p01:6170
;   (35 bytes)
;   0x55de..0x5601  (35 bytes)
DATA_copias_55DE:
	defb 040h,04ah,034h,004h,04eh,056h,034h,008h,05eh,070h,074h,062h,071h,074h,072h,083h	; 55de  @J4.NV4.^ptbqtr.
	defb 034h,005h,088h,096h,034h,005h,09bh,0a3h,0b4h,0b5h,0b9h,074h,0cbh,0cfh,074h,0d0h	; 55ee  4...4......t..t.
	defb 0d8h,0b4h,000h	; 55fe

; ======================================================================
; CODIGO 0x5601..0x5615  (20 bytes)
; ======================================================================


estado_del_juego:		; cada cuadro: 0xE1C3 + 1 y el estado 0xE1C0 (11, p00:5615); en los tres primeros, luego los mandos del titulo (p00:5A3E)
	ld hl,0e1c3h		;5601   ; un cuadro mas
	inc (hl)			;5604
	ld hl,05a3eh		;5605   ; en los estados 0-2, al acabar, los mandos del titulo
	ld bc,(0e1c0h)		;5608   ; C = el estado, B = el paso
	ld a,c			;560c
	cp 003h		;560d
	jr nc,L_5612		;560f
	push hl			;5611
L_5612:
	call despacha		;5612   ; a la rutina del estado

; ----------------------------------------------------------------------
; DATOS tabla_5615: 11 destinos del despachador p00:4084 (call en p00:5612, el
;   indice en A): 562B, 567D, 5699, 5727, 578A, 57DB, 5817, 5842, 58CF, 58FD,
;   5955; lo leen p00:5612 (22 bytes)
;   0x5615..0x562b  (22 bytes)
DATA_tabla_5615:
	defw 0562bh,0567dh,05699h,05727h,0578ah,057dbh,05817h,05842h	; 5615
	defw 058cfh,058fdh,05955h	; 5625  -> estado_8_vuelve estado_9_pausa estado_10_final

; ======================================================================
; CODIGO 0x562b..0x5ad8  (1197 bytes)
; ======================================================================


estado_0_intro:		; la entrada (pasos 0-3 de 0xE1C1): p11:B6CD y p01:6237, p01:626B, p01:615B y p10:B64F, p10:B737
	djnz L_563A		;562b   ; paso 1: cada dos cuadros
	ld a,(0e1c3h)		;562d   ; lee la cuenta de cuadros
	rra			;5630
	ret nc			;5631
	call 0626bh		;5632   ; p01:626B hasta que de Z
	ret nz			;5635
	xor a			;5636
	jp siguiente_paso_con_espera		;5637   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_563A:
	djnz L_5651		;563a   ; paso 2: espera 0xE1C4
	ld hl,0e1c4h		;563c   ; apunta a la espera del paso, en cuadros
	dec (hl)			;563f
	ret nz			;5640
	call banco_10		;5641   ; con el banco 10, p01:615B y p10:B64F
	call 0615bh		;5644
	call 0b64fh		;5647
	call bancos_1_2_3		;564a   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	xor a			;564d
	jp siguiente_paso_con_espera		;564e   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_5651:
	djnz L_5668		;5651   ; paso 3: p10:B737 hasta que 0xE1D7 sea 0
	call banco_10		;5653   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0b737h		;5656
	call bancos_1_2_3		;5659   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld a,(0e1d7h)		;565c
	and a			;565f
	ret nz			;5660
	xor a			;5661   ; al estado 1 (el titulo)
	call siguiente_estado_con_espera		;5662   ; siguiente_estado_con_espera: 0xE1C4 = A y el estado siguiente, paso 0
	jp siguiente_paso		;5665   ; siguiente_paso: el paso siguiente del estado (0xE1C1 + 1)
L_5668:
	call registros_del_vdp		;5668   ; paso 0: el VDP, la pantalla en blanco, p11:B6CD y p01:6237
	call borra_nombres		;566b   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call banco_11		;566e   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b6cdh		;5671
	call bancos_2_3		;5674   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	call 06237h		;5677   ; logo_de_konami: descomprime p09:B79F, borra sus colores y pone los 21 x 6 caracteres del logo (0x40 en adelante) en la fila 8
	jp siguiente_paso		;567a   ; siguiente_paso: el paso siguiente del estado (0xE1C1 + 1)
estado_1_titulo:		; el titulo: p01:621E y luego p10:B77C cada cuadro durante 0xE1C4; despues el estado 2
	djnz L_5692		;567d   ; paso 1: p10:B77C mientras dure 0xE1C4
	call banco_10		;567f   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0b77ch		;5682
	call bancos_1_2_3		;5685   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld hl,0e1c4h		;5688   ; apunta a la espera del paso, en cuadros
	dec (hl)			;568b
	jp nz,061ech		;568c   ; p01:61EC
	jp siguiente_estado		;568f   ; y a la demostracion
L_5692:
	call 0621eh		;5692   ; paso 0: p01:621E
	xor a			;5695
	jp siguiente_paso_con_espera		;5696   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
estado_2_demo:		; la demostracion: p10:A643, p10:A000, p10:B64F, p10:B737, y una fase jugada sola (p00:5EF6, p00:5F2A); luego el estado 0
	djnz L_56AB		;5699   ; paso 1: p10:A000 hasta que 0xE1D7 sea 0
	call banco_10		;569b   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0a000h		;569e
	call bancos_1_2_3		;56a1   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld a,(0e1d7h)		;56a4
	and a			;56a7
	ret nz			;56a8
	jr siguiente_paso		;56a9
L_56AB:
	djnz L_56BC		;56ab   ; paso 2: p01:615B y p10:B64F
	call banco_10		;56ad   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0615bh		;56b0   ; pantalla_del_titulo: los caracteres del titulo (p00:55A7) y, fuera de Japon, los de NEMESIS (p12:AA83), p11:B6CD, sprites (p12:AA75) y p10:A24C
	call 0b64fh		;56b3
	call bancos_1_2_3		;56b6   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	jp siguiente_paso		;56b9   ; siguiente_paso: el paso siguiente del estado (0xE1C1 + 1)
L_56BC:
	djnz L_56D0		;56bc   ; paso 3: p10:B737 hasta que 0xE1D7 sea 0
	call banco_10		;56be   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0b737h		;56c1
	call bancos_1_2_3		;56c4   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld a,(0e1d7h)		;56c7
	and a			;56ca
	ret nz			;56cb
	xor a			;56cc
	jp siguiente_paso_con_espera		;56cd   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_56D0:
	djnz L_56E1		;56d0   ; paso 4: p10:B77C mientras dure 0xE1C4
	ld hl,0e1c4h		;56d2   ; apunta a la espera del paso, en cuadros
	dec (hl)			;56d5
	jr z,L_571D		;56d6
	call banco_10		;56d8   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0b77ch		;56db
	jp bancos_1_2_3		;56de   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
L_56E1:
	djnz L_56F6		;56e1   ; paso 5: silencio, pantalla en blanco, p01:6210, jugadores a cero y la demo
	ld a,043h		;56e3
	call sonido		;56e5   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call borra_nombres		;56e8   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 06210h		;56eb   ; borra_e490: 0xE490-0xE4A3 a cero
	call jugadores_a_cero		;56ee   ; jugadores_a_cero: 0xE200-0xE22D a cero y los valores de salida (p00:5AA3)
	call empieza_la_demo		;56f1   ; empieza_la_demo: la fase de la demostracion (0xE1C6: 2, 3, 4, 5, 6 y otra vez 2), sus mandos desde el primero, p01:60FD, p02:8196, nivel 0 y el marcador
	jr siguiente_paso		;56f4
L_56F6:
	djnz L_5711		;56f6   ; paso 6: la fase de la demostracion hasta que se pierde la nave o acaban sus mandos
	call cuadro_de_demo		;56f8   ; cuadro_de_demo: un cuadro de la demostracion: los mandos de p15:5F6D (pares [cuadros][mandos], 0xFF acaba) con el disparo puesto, y el cuadro de juego
	ld a,(0e1d3h)		;56fb   ; lee la marca de vida en marcha (0: la nave ha caido)
	or a			;56fe
	ret nz			;56ff
al_estado_0:		; suena 0x43 y vuelve al estado 0
	ld a,043h		;5700   ; silencio y al estado 0
	call sonido		;5702   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	xor a			;5705
al_estado_a:		; estado A, paso 0, 0xE1C4 = 32 cuadros
	ld (0e1c0h),a		;5706   ; guarda el estado del juego (0-10, p00:5615)
	ld a,020h		;5709
	ld (0e1c4h),a		;570b   ; guarda la espera del paso, en cuadros
	jp L_577C		;570e
L_5711:
	call borra_nombres		;5711   ; paso 0: pantalla en blanco y p10:A643
	call banco_10		;5714   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0a643h		;5717
	call bancos_1_2_3		;571a   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
L_571D:
	ld a,020h		;571d
siguiente_paso_con_espera:		; 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
	ld (0e1c4h),a		;571f   ; guarda la espera del paso, en cuadros
siguiente_paso:		; el paso siguiente del estado (0xE1C1 + 1)
	ld hl,0e1c1h		;5722   ; apunta a el paso del estado
	inc (hl)			;5725
	ret			;5726
estado_3_empieza:		; empieza la partida: suena 0x3E, parpadea 1PLAYER o 2PLAYERS, p10:BF9E, p10:BDFD y los jugadores a cero
	djnz L_5744		;5727   ; paso 1: parpadea el texto elegido cada 4 cuadros
	ld hl,0e1c4h		;5729   ; apunta a la espera del paso, en cuadros
	dec (hl)			;572c
	jr z,siguiente_paso		;572d
	ld a,(0e1c2h)		;572f   ; 1PLAYER, o 2PLAYERS con el bit 5
	bit 5,a		;5732
	ld de,0b25ah		;5734
	jr z,L_573C		;5737
	ld de,0b264h		;5739
L_573C:
	bit 2,(hl)		;573c
	jp z,escribe_texto		;573e   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp borra_texto		;5741   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
L_5744:
	djnz L_5754		;5744   ; paso 2: pantalla en blanco y p10:BF9E
	call borra_nombres		;5746   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call banco_10		;5749   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0bf9eh		;574c
	call bancos_1_2_3		;574f   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	jr siguiente_paso		;5752
L_5754:
	djnz L_5766		;5754   ; paso 3: p10:BDFD hasta que 0xE1D7 sea 0
	call banco_10		;5756   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0bdfdh		;5759
	call bancos_1_2_3		;575c   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld a,(0e1d7h)		;575f
	and a			;5762
	ret nz			;5763
	jr siguiente_paso		;5764
L_5766:
	djnz L_5781		;5766   ; paso 4: espera a que 0xE0A0 sea 0
	ld a,(0e0a0h)		;5768   ; lee la musica que suena
	or a			;576b
	ret nz			;576c
	call borra_nombres		;576d   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call jugadores_y_puntos_a_cero		;5770   ; los dos jugadores a cero
siguiente_estado:		; 0xE1C4 = 32 y el estado siguiente, paso 0
	ld a,020h		;5773
siguiente_estado_con_espera:		; 0xE1C4 = A y el estado siguiente, paso 0
	ld (0e1c4h),a		;5775   ; guarda la espera del paso, en cuadros
L_5778:
	ld hl,0e1c0h		;5778   ; al estado siguiente, paso 0
	inc (hl)			;577b
L_577C:
	xor a			;577c
L_577D:
	ld (0e1c1h),a		;577d   ; guarda el paso del estado
	ret			;5780
L_5781:
	ld a,03eh		;5781   ; paso 0: suena 0x3E y espera 80 cuadros
	call sonido		;5783   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,050h		;5786
	jr siguiente_paso_con_espera		;5788
estado_4_vida:		; una vida mas: le quita una (0xE200), PLAYER 1/2 y luego p01:60FD; 0xE1D3 = 1 y al estado 5
	djnz L_57A1		;578a   ; paso 1: espera 0xE1C4
	ld hl,0e1c4h		;578c   ; apunta a la espera del paso, en cuadros
	dec (hl)			;578f
	ret nz			;5790
	ld de,0b272h		;5791   ; borra PLAYER 1
	call borra_texto		;5794   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
	call 060fdh		;5797   ; p01:60FD
	ld a,001h		;579a   ; la nave en juego y al estado 5
	ld (0e1d3h),a		;579c   ; guarda la marca de vida en marcha (0: la nave ha caido)
	jr L_5778		;579f
L_57A1:
	call cortinilla		;57a1   ; paso 0: la cortinilla
	ret p			;57a4
	ld hl,0e200h		;57a5   ; una vida menos (BCD)
	ld a,(hl)			;57a8
	sub 001h		;57a9
	daa			;57ab
	ld (hl),a			;57ac
	call b736_y_b6f0		;57ad   ; b736_y_b6f0: con el banco 11, p11:B736 y p11:B6F0
	call caracteres_de_siempre		;57b0   ; caracteres_de_siempre: con los bancos 7-8-9, la lista de caracteres p07:6048
	call pinta_el_marcador		;57b3   ; pinta_el_marcador: los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
	call empieza_el_medidor		;57b6   ; empieza_el_medidor: 0xE330-0xE33C a cero, p02:8060 y, con 0xE20B o 0xE20D, la casilla 1; y lo pinta
	call b736_y_b6f0		;57b9   ; b736_y_b6f0: con el banco 11, p11:B736 y p11:B6F0
	ld a,(0e1c2h)		;57bc   ; con dos jugadores, el rotulo del jugador y 120 cuadros; si no, 16
	and 020h		;57bf
	ld a,010h		;57c1
	jp z,siguiente_paso_con_espera		;57c3   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
	call rotulo_de_jugador		;57c6   ; rotulo_de_jugador: con dos jugadores, PLAYER 1 o PLAYER 2 (0xE1C2 bit 7)
	ld a,078h		;57c9
	jp siguiente_paso_con_espera		;57cb   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
caracteres_de_siempre:		; con los bancos 7-8-9, la lista de caracteres p07:6048
	call bancos_7_8_9		;57ce   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	ld ix,06048h		;57d1
	call pon_caracteres		;57d5   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	jp bancos_1_2_3		;57d8   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
estado_5_juego:		; la partida: un cuadro de juego; F1 pausa (estado 9); sin nave al 6, con 0xE1DA al 8, con 0xE1E6 al 10
	call cuadro_de_juego		;57db   ; cuadro_de_juego: un cuadro de partida: si se esta pintando el interior (0xE1DC) solo eso; si no, scroll, nave, armas, enemigos, jefe y marcador, banco a banco
	ld a,(0e1e6h)		;57de   ; el final?
	and a			;57e1
	ld a,00ah		;57e2
	jp nz,al_estado_a		;57e4   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
	ld a,(0e1d3h)		;57e7   ; la nave ha caido: estado 6
	or a			;57ea
	jp z,siguiente_estado		;57eb   ; siguiente_estado: 0xE1C4 = 32 y el estado siguiente, paso 0
	ld a,(0e1dah)		;57ee   ; estado 8
	and a			;57f1
	ld a,008h		;57f2
	jp nz,al_estado_a		;57f4   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
	ld a,(0e400h)		;57f7   ; sin nave (0xE400 = 0) no hay pausa
	dec a			;57fa
	ret m			;57fb
	ld a,(0e3d0h)		;57fc   ; ni con el scroll parado por un jefe
	or a			;57ff
	ret nz			;5800
	ld a,(0e3c0h)		;5801   ; ni en el final de la fase 8
	or a			;5804
	ret nz			;5805
	call tecla_f1		;5806   ; F1: suena 0xF3, p11:BD67 y la pausa
	ret nc			;5809
	ld a,0f3h		;580a
	call sonido		;580c   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call 0bd67h		;580f
	ld a,009h		;5812
	jp al_estado_a		;5814   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
estado_6_muerte:		; con vidas, cambia de jugador si hay dos y vuelve al 4; sin ellas, suena 0x42 y al 7
	ld a,(0e200h)		;5817   ; sin vidas: fin de la partida
	or a			;581a
	jr z,L_583A		;581b
	ld a,(0e240h)		;581d   ; sin segundo jugador: otra vida
	or a			;5820
	jr z,L_5835		;5821
L_5823:
	ld hl,0e200h		;5823   ; cambia los 64 bytes de un jugador por los del otro
	ld de,0e240h		;5826   ; apunta a la copia de 0xE200-0xE23F del otro jugador
	ld b,040h		;5829
	call intercambia		;582b   ; intercambia: intercambia B bytes entre HL y DE
	ld hl,0e1c2h		;582e   ; y el jugador en turno
	ld a,(hl)			;5831
	xor 080h		;5832
	ld (hl),a			;5834
L_5835:
	ld a,004h		;5835   ; al estado 4: otra vida
	jp al_estado_a		;5837   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
L_583A:
	ld a,042h		;583a   ; suena 0x42 y al estado 7
	call sonido		;583c   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	jp siguiente_estado		;583f   ; siguiente_estado: 0xE1C4 = 32 y el estado siguiente, paso 0
estado_7_game_over:		; GAME OVER y CONTINUE F5: con F5 (0xE20C) puntos a cero y 3 vidas; luego el otro jugador o el estado 0
	djnz L_5896		;5842   ; paso 1: F1 suena 0xF3 y pasa al siguiente
	call tecla_f1		;5844   ; tecla_f1: C si se acaba de pulsar F1 (fila 6, bit 5) jugando (0xE1C2 bit 6); 0xE30A es la de antes
	jr nc,L_5851		;5847
	ld a,0f3h		;5849
	call sonido		;584b   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	jp siguiente_paso		;584e   ; siguiente_paso: el paso siguiente del estado (0xE1C1 + 1)
L_5851:
	call tecla_f5_continua		;5851   ; F5: continuar
	ld a,(0e078h)		;5854   ; espera a que acabe 0xE078
	or a			;5857
	ret nz			;5858
	ld a,(0e20ch)		;5859   ; continua?
	and a			;585c
	jr z,L_5880		;585d
	ld hl,0e1fah		;585f   ; a cero los puntos del jugador en turno
	ld a,(0e1c2h)		;5862   ; lee el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	and 080h		;5865
	jr z,L_586B		;5867
	ld l,0f5h		;5869
L_586B:
	xor a			;586b
	ld (hl),a			;586c
	inc l			;586d
	ld (hl),a			;586e
	inc l			;586f
	ld (hl),a			;5870
	inc l			;5871
	ld (hl),a			;5872
	inc l			;5873
	ld (hl),a			;5874
	ld (0e20bh),a		;5875   ; las casillas, a cero
	ld (0e20dh),a		;5878   ; guarda la casilla encendida al caer
	ld a,003h		;587b   ; y 3 vidas
	ld (0e200h),a		;587d   ; guarda las vidas (BCD)
L_5880:
	ld a,(0e240h)		;5880   ; si hay otro jugador, le toca
	or a			;5883
	jr nz,L_5823		;5884
	ld a,(0e20ch)		;5886   ; si continua, otra vida
	and a			;5889
	jr nz,L_5835		;588a
L_588C:
	ld hl,0e1c2h		;588c   ; se acabo la partida: ya no se juega
	ld a,(hl)			;588f
	and 0bfh		;5890
	ld (hl),a			;5892
	jp al_estado_0		;5893   ; al_estado_0: suena 0x43 y vuelve al estado 0
L_5896:
	djnz L_58A6		;5896   ; paso 2: F1 suena 0xF2 y vuelve al paso 1
	call tecla_f1		;5898   ; tecla_f1: C si se acaba de pulsar F1 (fila 6, bit 5) jugando (0xE1C2 bit 6); 0xE30A es la de antes
	ret nc			;589b
	ld a,0f2h		;589c
	call sonido		;589e   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,001h		;58a1
	jp L_577D		;58a3
L_58A6:
	call cortinilla		;58a6   ; paso 0: la cortinilla
	ret p			;58a9
	call b736_y_b6f0		;58aa   ; b736_y_b6f0: con el banco 11, p11:B736 y p11:B6F0
	ld de,0b288h		;58ad   ; GAME OVER y CONTINUE F5
	call escribe_texto		;58b0   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	call rotulo_de_jugador		;58b3   ; rotulo_de_jugador: con dos jugadores, PLAYER 1 o PLAYER 2 (0xE1C2 bit 7)
	call record_y_codigo		;58b6   ; el record y el codigo
	call pinta_el_marcador		;58b9   ; pinta_el_marcador: los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
	xor a			;58bc   ; sin continuar
	ld (0e20ch),a		;58bd   ; guarda la marca de continuar (F5)
	jp siguiente_paso_con_espera		;58c0   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
b736_y_b6f0:		; con el banco 11, p11:B736 y p11:B6F0
	call banco_11		;58c3   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b736h		;58c6
	call 0b6f0h		;58c9
	jp bancos_2_3		;58cc   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
estado_8_vuelve:		; 0xE1DA = 0, p01:7C1C, el marcador y el medidor; el R.DRILL vuelve a ser nave; al estado 5
	xor a			;58cf
	ld (0e1dah),a		;58d0   ; guarda la marca del estado 8
	call 07c1ch		;58d3   ; p01:7C1C
	call pinta_el_marcador		;58d6   ; pinta_el_marcador: los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
	call pinta_el_medidor		;58d9   ; pinta_el_medidor: el recuadro del rotulo (caracteres 0x15-0x1C), las casillas del medidor y el rotulo
	ld hl,0e400h		;58dc   ; si la nave es el R.DRILL
	ld a,(hl)			;58df
	cp 003h		;58e0
	jr nz,L_58F8		;58e2
	inc l			;58e4   ; vuelve a ser normal, o con escudo si le quedan golpes
	ld a,(hl)			;58e5
	or a			;58e6
	ld b,001h		;58e7
	jr z,L_58EC		;58e9
	inc b			;58eb
L_58EC:
	dec l			;58ec
	ld (hl),b			;58ed
	xor a			;58ee   ; sin capsula especial
	ld (0e439h),a		;58ef   ; guarda la capsula especial en marcha (con cuenta atras)
	ld (0e1d5h),a		;58f2   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	call sprites_de_la_nave		;58f5   ; sprites_de_la_nave: con los bancos 7-8-9, los dibujos de sprite de la nave (p00:4368)
L_58F8:
	ld a,005h		;58f8
	jp al_estado_a		;58fa   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
estado_9_pausa:		; la pausa: con F1 suena 0xF2 y vuelve al 5; mientras, p11:BD7C, la nave y p01:77B6
	call tecla_f1		;58fd   ; F1 otra vez: se acaba la pausa
	jr c,L_591E		;5900
	call 0bd7ch		;5902   ; p11:BD7C
	ld a,(0e400h)		;5905   ; sin nave, p01:77B6 y nada mas
	and a			;5908
	jp m,077b6h		;5909   ; sprites_a_vram: los 32 sprites de 0xE280 a la VRAM (0x3B00): sin nave en orden, si no rotando el orden cada cuadro (0xE304)
	call 0a78ch		;590c   ; p03:A78C y p03:AA53
	call 0aa53h		;590f
	call banco_11		;5912   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a000h		;5915   ; p11:A000
	call bancos_2_3		;5918   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	jp 077b6h		;591b
L_591E:
	ld a,0f2h		;591e   ; suena 0xF2 y vuelve al juego
	call sonido		;5920   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,005h		;5923
	jp al_estado_a		;5925   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
tecla_f1:		; C si se acaba de pulsar F1 (fila 6, bit 5) jugando (0xE1C2 bit 6); 0xE30A es la de antes
	ld a,(0e1c2h)		;5928   ; solo jugando
	and 040h		;592b
	ret z			;592d
	ld a,006h		;592e   ; la fila 6 del teclado: F1 es el bit 5
	call 00141h		;5930   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5933
	and 020h		;5934
	ld hl,0e30ah		;5936   ; la de antes
	ld c,(hl)			;5939
	ld (hl),a			;593a
	xor c			;593b   ; no ha cambiado: nada
	ret z			;593c
	bit 5,(hl)		;593d   ; se acaba de soltar: nada
	ret z			;593f
	scf			;5940   ; se acaba de pulsar: C
	ret			;5941
tecla_f5_continua:		; con F5 (fila 7, bit 1), 0xE20C = 1 y borra CONTINUE F5
	ld a,007h		;5942   ; la fila 7 del teclado: F5 es el bit 1
	call 00141h		;5944   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;5947
	ret nz			;5949
	ld a,001h		;594a   ; continua
	ld (0e20ch),a		;594c   ; guarda la marca de continuar (F5)
	ld de,0b295h		;594f   ; y borra CONTINUE F5
	jp borra_texto		;5952   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
estado_10_final:		; el final: espera, textos, F5 y espacio, p10:B993; luego el estado 8 o el 0
	djnz L_5961		;5955   ; paso 1: espera a que 0xE0A0 sea 0
	ld a,(0e0a0h)		;5957   ; lee la musica que suena
	or a			;595a
	ret nz			;595b
	ld a,030h		;595c
	jp siguiente_paso_con_espera		;595e   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_5961:
	djnz L_5981		;5961   ; paso 2: espera 0xE1C4, pantalla en blanco y el texto p03:B2AF
	ld hl,0e1c4h		;5963   ; apunta a la espera del paso, en cuadros
	dec (hl)			;5966
	ret nz			;5967
	call borra_nombres		;5968   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	ld de,0b2afh		;596b
	call escribe_texto		;596e   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	xor a			;5971
	ld (0e22dh),a		;5972   ; guarda la marca de F5 en el final
	ld (0e22eh),a		;5975   ; guarda la marca de espacio en el final
	ld hl,00000h		;5978   ; la cuenta de interrupciones a cero
	ld (0f0f7h),hl		;597b   ; guarda la cuenta de interrupciones (16 bits)
	jp siguiente_paso_con_espera		;597e   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_5981:
	djnz L_59CE		;5981   ; paso 3: con F5 el texto p03:B2CA, y luego espacio
	call tecla_f5		;5983   ; tecla_f5: 0xE22D = 1 si F5 (fila 7, bit 1) esta pulsada
	ld a,(0e22dh)		;5986   ; lee la marca de F5 en el final
	or a			;5989
	ld de,0b2cah		;598a
	call nz,escribe_texto		;598d   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld a,(0e22dh)		;5990   ; lee la marca de F5 en el final
	and a			;5993
	jr z,L_59B2		;5994
	call tecla_espacio		;5996   ; tecla_espacio: 0xE22E = 1 si el espacio (fila 8, bit 0) esta pulsado
	ld a,(0e22eh)		;5999   ; lee la marca de espacio en el final
	or a			;599c
	ret z			;599d
	ld de,0b2cah		;599e
	call borra_texto		;59a1   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
	ld a,078h		;59a4   ; 120 cuadros y el texto p03:B2EE
	ld (0e1c4h),a		;59a6   ; guarda la espera del paso, en cuadros
	ld de,0b2eeh		;59a9
	call escribe_texto		;59ac   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp siguiente_paso_con_espera		;59af   ; siguiente_paso_con_espera: 0xE1C4 = A y el paso siguiente (0xE1C1 + 1)
L_59B2:
	ld de,00258h		;59b2   ; sin F5, a los 600 cuadros (10 segundos)
	call cuadros_desde		;59b5   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	ret c			;59b8
	ld de,0b2bah		;59b9   ; cambia el texto y al paso 5
	call borra_texto		;59bc   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
	ld de,0b2dbh		;59bf
	call escribe_texto		;59c2   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	xor a			;59c5
	ld (0e1c4h),a		;59c6   ; guarda la espera del paso, en cuadros
	ld a,005h		;59c9
	jp L_577D		;59cb
L_59CE:
	djnz L_59ED		;59ce   ; paso 4: espera 0xE1C4
	ld hl,0e1c4h		;59d0   ; apunta a la espera del paso, en cuadros
	dec (hl)			;59d3
	ret nz			;59d4
	ld a,04ah		;59d5   ; la nave en Y 0x4A y X 0x50
	ld (0e404h),a		;59d7
	ld a,050h		;59da
	ld (0e406h),a		;59dc
	call 0aa2fh		;59df   ; p03:AA2F
	call esconde_sprites		;59e2   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call borra_nombres		;59e5   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	ld a,008h		;59e8   ; y al estado 8
	jp al_estado_a		;59ea   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
L_59ED:
	djnz L_5A05		;59ed   ; paso 5: espera, sin vidas y al otro jugador o al estado 0
	ld hl,0e1c4h		;59ef   ; apunta a la espera del paso, en cuadros
	dec (hl)			;59f2
	ret nz			;59f3
	call borra_nombres		;59f4   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	xor a			;59f7
	ld (0e200h),a		;59f8   ; guarda las vidas (BCD)
	ld a,(0e240h)		;59fb   ; lee la copia de 0xE200-0xE23F del otro jugador
	or a			;59fe
	jp nz,L_5823		;59ff
	jp L_588C		;5a02
L_5A05:
	call bancos_13_14_15		;5a05   ; paso 0: con los bancos 13-14-15 y 10, p10:B993
	call banco_10		;5a08   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call 0b993h		;5a0b
	call bancos_1_2_3		;5a0e   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld a,(0e1e6h)		;5a11   ; lee la marca del final (estado 10)
	or a			;5a14
	ret nz			;5a15
	ld a,(0e1d6h)		;5a16   ; lee la marca del final con textos
	or a			;5a19
	jp nz,L_571D		;5a1a   ; con 0xE1D6, al paso 1; si no, al estado 8
	ld a,008h		;5a1d
	jp al_estado_a		;5a1f   ; al_estado_a: estado A, paso 0, 0xE1C4 = 32 cuadros
tecla_f5:		; 0xE22D = 1 si F5 (fila 7, bit 1) esta pulsada
	ld a,007h		;5a22
	call 00141h		;5a24   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;5a27
	ret nz			;5a29
	ld a,001h		;5a2a
	ld (0e22dh),a		;5a2c   ; guarda la marca de F5 en el final
	ret			;5a2f
tecla_espacio:		; 0xE22E = 1 si el espacio (fila 8, bit 0) esta pulsado
	ld a,008h		;5a30
	call 00141h		;5a32   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 0,a		;5a35
	ret nz			;5a37
	ld a,001h		;5a38
	ld (0e22eh),a		;5a3a   ; guarda la marca de espacio en el final
	ret			;5a3d
mandos_del_titulo:		; en los estados 0-2: cualquier tecla lleva al titulo (estado 1); en el titulo, una direccion cambia 1 o 2 jugadores (0xE1D2) y un boton empieza (estado 3)
	call mandos_titulo		;5a3e   ; los mandos, y los recien pulsados en 0xE1D0
	ld hl,0e1d1h		;5a41   ; apunta a los mandos del titulo
	call guarda_mandos		;5a44   ; guarda_mandos: (HL) = A y (HL - 1) = los bits que se acaban de pulsar
	or a			;5a47
	ret z			;5a48   ; nada pulsado: fuera
	ld hl,0e1c4h		;5a49   ; apunta a la espera del paso, en cuadros
	ld (hl),000h		;5a4c   ; con algo pulsado, sin espera
	ld hl,0e1c0h		;5a4e   ; apunta a el estado del juego (0-10, p00:5615)
	ld de,0e1d2h		;5a51   ; apunta a la opcion del titulo (0: 1 jugador, 1: 2 jugadores)
	ld b,(hl)			;5a54   ; en el titulo (estado 1)?
	djnz L_5A70		;5a55
	and 030h		;5a57   ; un boton (bits 4-5): empieza
	jr z,L_5A7D		;5a59
	ld a,(de)			;5a5b   ; 0x40 un jugador, 0x60 dos
	or a			;5a5c
	ld a,040h		;5a5d
	jr z,L_5A63		;5a5f
	ld a,060h		;5a61
L_5A63:
	ld (0e1c2h),a		;5a63   ; guarda el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	ld (hl),003h		;5a66   ; al estado 3, paso 0
	inc hl			;5a68
	ld c,000h		;5a69
	ld (hl),c			;5a6b
	dec c			;5a6c
	jp 061f6h		;5a6d   ; p01:61F6
L_5A70:
	ld (hl),001h		;5a70   ; en la intro o la demo: al titulo
	inc hl			;5a72
	xor a			;5a73
	ld (hl),a			;5a74
	ld (0e1d7h),a		;5a75
	ld a,043h		;5a78   ; silencio
	jp sonido		;5a7a   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_5A7D:
	ld a,(de)			;5a7d   ; una direccion: cambia 1 o 2 jugadores
	xor 001h		;5a7e
	ld (de),a			;5a80
	ret			;5a81
rotulo_de_jugador:		; con dos jugadores, PLAYER 1 o PLAYER 2 (0xE1C2 bit 7)
	ld a,(0e1c2h)		;5a82   ; lee el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	bit 5,a		;5a85
	ret z			;5a87
	ld de,0b272h		;5a88   ; PLAYER 1, o PLAYER 2 con el bit 7
	and 080h		;5a8b
	jr z,L_5A92		;5a8d
	ld de,0b27dh		;5a8f
L_5A92:
	jp escribe_texto		;5a92   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
jugadores_a_cero:		; 0xE200-0xE22D a cero y los valores de salida (p00:5AA3)
	ld hl,0e200h		;5a95   ; apunta a las vidas (BCD)
	ld bc,00e20h		;5a98
	jr valores_de_salida		;5a9b
jugadores_y_puntos_a_cero:		; 0xE1F5-0xE220 a cero y los valores de salida (p00:5AA3)
	ld hl,0e1f5h		;5a9d   ; apunta a los puntos del jugador 2 (0xE1F5-0xE1F9, BCD)
	ld bc,00e2bh		;5aa0
valores_de_salida:		; borra BC bytes desde HL, 0xE200 = vidas y fase de p00:5AD8, la vida extra a 0x0010 y, con dos jugadores, copia al 2 (0xE240)
	ld e,l			;5aa3
	ld d,h			;5aa4
	inc de			;5aa5
	ld (hl),000h		;5aa6
	ldir		;5aa8
	xor a			;5aaa
	ld (0e1dah),a		;5aab   ; sin estado 8 ni interior
	ld (0e1dch),a		;5aae   ; guarda la marca de interior por pintar (fase 8)
	ld hl,05ad8h		;5ab1   ; las vidas y la fase de salida
	ld de,0e200h		;5ab4   ; apunta a las vidas (BCD)
	ld bc,00002h		;5ab7
	ldir		;5aba
	ld hl,00010h		;5abc   ; la primera vida extra a los 0x0010 (BCD) del byte de las centenas
	ld (0e207h),hl		;5abf   ; guarda los puntos de la siguiente vida extra (BCD, 3 bytes) y el byte siguiente (16 bits)
	xor a			;5ac2
	ld (0e209h),a		;5ac3   ; guarda la siguiente vida extra: el byte alto
	ld a,(0e1c2h)		;5ac6   ; con dos jugadores, el 2 sale igual
	and 020h		;5ac9
	ret z			;5acb
	ld hl,0e200h		;5acc   ; apunta a las vidas (BCD)
	ld de,0e240h		;5acf   ; apunta a la copia de 0xE200-0xE23F del otro jugador
	ld bc,00040h		;5ad2
	ldir		;5ad5
	ret			;5ad7

; ----------------------------------------------------------------------
; DATOS inicio_E200: 2 bytes que p00:5AB1 copia a 0xE200-0xE201 (la fase de
;   arranque); lo leen p00:5AB1 (2 bytes)
;   0x5ad8..0x5ada  (2 bytes)
DATA_inicio_E200:
	defb 003h,001h	; 5ad8

; ======================================================================
; CODIGO 0x5ada..0x5d1d  (579 bytes)
; ======================================================================


cortinilla:		; 0xE1C4 - 1: borra la columna 0xE1C4 XOR 31 de la tabla de nombres (22 filas, 24 en el estado 2) y esconde los sprites; signo: no ha acabado
	ld hl,0e1c4h		;5ada   ; apunta a la espera del paso, en cuadros
	dec (hl)			;5add
	ret m			;5ade   ; acabada: signo
	ld a,(hl)			;5adf
	ld h,038h		;5ae0   ; la columna 31 - 0xE1C4 de la tabla de nombres
	xor 01fh		;5ae2
	ld l,a			;5ae4
	ld b,016h		;5ae5   ; 22 filas, 24 en la demostracion
	ld a,(0e1c0h)		;5ae7   ; lee el estado del juego (0-10, p00:5615)
	cp 002h		;5aea
	jr nz,L_5AF0		;5aec
	ld b,018h		;5aee
L_5AF0:
	xor a			;5af0   ; a cero
	ld de,00020h		;5af1
L_5AF4:
	call 0004dh		;5af4   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;5af7
	djnz L_5AF4		;5af8
sin_sprites:		; Y = 0xD0 en el primer sprite de la VRAM (0x3B00): no se pinta ninguno
	ld hl,03b00h		;5afa   ; el primer sprite con Y = 0xD0: no se pinta ninguno
	ld a,0d0h		;5afd
	call 0004dh		;5aff   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;5b02
	ret			;5b03
suma_puntos:		; jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld a,(0e1c2h)		;5b04   ; bit 6 de 0xE1C2: solo jugando; bit 7: que jugador
	add a,a			;5b07
	ret p			;5b08
	ld hl,0e1fbh		;5b09   ; los puntos del 1, o los del 2
	jr nc,L_5B10		;5b0c
	ld l,0f6h		;5b0e
L_5B10:
	ld a,(hl)			;5b10   ; suma DE en BCD
	add a,e			;5b11
	daa			;5b12
	ld (hl),a			;5b13
	inc l			;5b14
	ld a,(hl)			;5b15
	adc a,d			;5b16
	daa			;5b17
	ld (hl),a			;5b18
	inc hl			;5b19   ; y el acarreo a los dos bytes de arriba
	ld a,(hl)			;5b1a
	adc a,000h		;5b1b
	daa			;5b1d
	ld (hl),a			;5b1e
	inc hl			;5b1f
	ld a,(hl)			;5b20
	adc a,000h		;5b21
	daa			;5b23
	ld (hl),a			;5b24
	jr nc,L_5B40		;5b25
	ld a,099h		;5b27   ; se pasa: 99999999
	ld (hl),a			;5b29
	dec l			;5b2a
	ld (hl),a			;5b2b
	dec l			;5b2c
	ld (hl),a			;5b2d
	dec l			;5b2e
	ld (hl),a			;5b2f
	ld a,(0f0f5h)		;5b30   ; y el record igual, si no esta esa ranura
	bit 1,a		;5b33
	ret nz			;5b35
	ld hl,09999h		;5b36
	ld (0e1f1h),hl		;5b39   ; guarda el record (BCD, 4 bytes) y el byte siguiente (16 bits)
	ld (0e1f3h),hl		;5b3c
	ret			;5b3f
L_5B40:
	ex de,hl			;5b40
	ld hl,0e209h		;5b41   ; ha pasado la siguiente vida extra?
	ld a,(de)			;5b44
	cp (hl)			;5b45
	jr c,L_5B68		;5b46
	dec e			;5b48
	dec l			;5b49
	ld a,(de)			;5b4a
	cp (hl)			;5b4b
	jr c,L_5B68		;5b4c
	dec e			;5b4e
	dec l			;5b4f
	ld a,(de)			;5b50
	cp (hl)			;5b51
	jr c,L_5B68		;5b52
	ld a,(hl)			;5b54   ; la siguiente, 0x10 mas (BCD)
	add a,010h		;5b55
	daa			;5b57
	ld (hl),a			;5b58
	inc l			;5b59
	ld a,(hl)			;5b5a
	adc a,000h		;5b5b
	daa			;5b5d
	ld (hl),a			;5b5e
	inc l			;5b5f
	ld a,(hl)			;5b60
	adc a,000h		;5b61
	daa			;5b63
	ld (hl),a			;5b64
	call vida_extra		;5b65   ; y una vida
L_5B68:
	ld a,(0f0f5h)		;5b68   ; con esa ranura no hay record
	bit 1,a		;5b6b
	ret nz			;5b6d
	ld a,(0e1c2h)		;5b6e   ; lee el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	add a,a			;5b71
	ld hl,0e1feh		;5b72   ; apunta a los puntos del jugador 1: el byte alto
	jr nc,L_5B79		;5b75
	ld l,0f9h		;5b77
L_5B79:
	ld b,004h		;5b79   ; compara los 4 bytes con el record, del alto al bajo
	ld de,0e1f4h		;5b7b   ; apunta a el record: el byte alto
	ld c,l			;5b7e
L_5B7F:
	ld a,(de)			;5b7f   ; byte a byte desde el alto
	sub (hl)			;5b80   ; el record menos los puntos
	jr c,L_5B89		;5b81   ; el record es menor: se copia
	ret nz			;5b83   ; el record es mayor: nada
	dec l			;5b84   ; iguales: el byte siguiente
	dec e			;5b85
	djnz L_5B7F		;5b86
	ret			;5b88
L_5B89:
	ld l,c			;5b89   ; los supera: al record
	ld bc,00004h		;5b8a
	ld e,0f4h		;5b8d
	lddr		;5b8f
	ret			;5b91
vida_extra:		; 0xE200 + 1 (BCD, sin pasar de 99), suena 0x0C y pinta las vidas
	ld hl,0e200h		;5b92   ; apunta a las vidas (BCD)
	ld a,(hl)			;5b95   ; una vida mas, sin pasar de 99
	add a,001h		;5b96
	daa			;5b98
	ret c			;5b99
	ld (hl),a			;5b9a
	ld a,00ch		;5b9b   ; suena 0x0C
	call sonido		;5b9d   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	jp pinta_las_vidas		;5ba0   ; pinta_las_vidas: las vidas (0xE200) en 0x3AE3, una o dos cifras
pinta_el_marcador:		; los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
	ld de,0b23dh		;5ba3   ; los textos fijos del marcador
	call escribe_texto		;5ba6   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld a,(0e1c2h)		;5ba9   ; lee el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	ld de,0b250h		;5bac   ; y el del jugador en turno
	add a,a			;5baf
	jr nc,L_5BB5		;5bb0
	ld de,0b255h		;5bb2
L_5BB5:
	call escribe_texto		;5bb5   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	call pinta_las_vidas		;5bb8   ; pinta_las_vidas: las vidas (0xE200) en 0x3AE3, una o dos cifras
pinta_los_puntos:		; el record (0xE1F4 en 0x3AF6) y los del jugador en turno (0x3AE9)
	ld de,0e1f4h		;5bbb   ; el record
	ld hl,03af6h		;5bbe
	call pinta_cifras		;5bc1   ; pinta_cifras: B bytes BCD de DE hacia atras en la VRAM HL, empezando por la cifra baja
	ld a,(0e1c2h)		;5bc4   ; los puntos del jugador en turno
	ld hl,03ae9h		;5bc7
	ld de,0e1feh		;5bca   ; apunta a los puntos del jugador 1: el byte alto
	add a,a			;5bcd
	jr nc,pinta_cifras		;5bce
	ld e,0f9h		;5bd0
pinta_cifras:		; B bytes BCD de DE hacia atras en la VRAM HL, empezando por la cifra baja
	ld b,005h		;5bd2   ; 5 bytes, 9 cifras: la primera es la baja del byte alto
	call prepara_escritura_vram		;5bd4   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;5bd7
	ld a,c			;5bd8
	exx			;5bd9
	ld c,a			;5bda
	jr L_5C08		;5bdb
pinta_las_vidas:		; las vidas (0xE200) en 0x3AE3, una o dos cifras
	ld hl,03ae3h		;5bdd
	ld de,0e200h		;5be0   ; apunta a las vidas (BCD)
	ld a,(de)			;5be3
	ld b,001h		;5be4
	and 0f0h		;5be6   ; con una cifra, un espacio delante
	jr nz,pinta_bcd		;5be8
	call prepara_escritura_vram		;5bea   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;5bed
	ld a,c			;5bee
	exx			;5bef
	ld c,a			;5bf0
	xor a			;5bf1
	out (c),a		;5bf2
	inc hl			;5bf4
	jr L_5C08		;5bf5
pinta_bcd:		; B bytes BCD de DE hacia atras en la VRAM HL, dos cifras por byte (caracter = cifra + 1)
	call prepara_escritura_vram		;5bf7   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;5bfa
	ld a,c			;5bfb
	exx			;5bfc
	ld c,a			;5bfd
L_5BFE:
	ld a,(de)			;5bfe   ; la cifra alta
	rra			;5bff
	rra			;5c00
	rra			;5c01
	rra			;5c02
	and 00fh		;5c03
	inc a			;5c05
	out (c),a		;5c06
L_5C08:
	ld a,(de)			;5c08   ; la baja (el caracter es la cifra + 1)
	and 00fh		;5c09
	inc a			;5c0b
	out (c),a		;5c0c
	dec de			;5c0e
	djnz L_5BFE		;5c0f
	ret			;5c11
record_y_codigo:		; sin nada en la otra ranura: HI SCORE, el record (0x3A2B) y un codigo de cuatro cifras (0x3A6E) de la suma de sus cifras, 0xE1C3 y p12:BBB9
	ld a,(0f0f5h)		;5c12   ; solo sin nada en la otra ranura
	or a			;5c15
	ret nz			;5c16
	ld de,0b2a4h		;5c17   ; HI SCORE
	call escribe_texto		;5c1a   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld de,0e1f4h		;5c1d   ; y el record
	ld hl,03a2bh		;5c20
	ld b,005h		;5c23
	call pinta_bcd		;5c25   ; pinta_bcd: B bytes BCD de DE hacia atras en la VRAM HL, dos cifras por byte (caracter = cifra + 1)
	call banco_12		;5c28   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld hl,0e1f1h		;5c2b   ; suma las 8 cifras del record (BCD)
	ld bc,00400h		;5c2e
L_5C31:
	ld a,(hl)			;5c31
	and 00fh		;5c32
	add a,c			;5c34
	daa			;5c35
	ld c,a			;5c36
	ld a,(hl)			;5c37
	rra			;5c38
	rra			;5c39
	rra			;5c3a
	rra			;5c3b
	and 00fh		;5c3c
	add a,c			;5c3e
	daa			;5c3f
	ld c,a			;5c40
	inc hl			;5c41
	djnz L_5C31		;5c42
	ld de,0f000h		;5c44   ; 0xF000 = la suma
	ld (de),a			;5c47
	ld a,(0e1c3h)		;5c48   ; 0xF001 = la cuenta de cuadros & 0x77
	and 077h		;5c4b
	inc e			;5c4d
	ld (de),a			;5c4e
	and 007h		;5c4f   ; de ahi la fila de 10 bytes de p12:BBB9
	add a,a			;5c51
	ld b,a			;5c52
	add a,a			;5c53
	add a,a			;5c54
	add a,b			;5c55
	ld hl,0bbb9h		;5c56
	call hl_mas_a		;5c59   ; hl_mas_a: HL = HL + A
	dec e			;5c5c
	ld a,(de)			;5c5d   ; cada nibble de la suma, un byte de la fila
	ld b,a			;5c5e
	and 00fh		;5c5f
	ld e,l			;5c61
	ld d,h			;5c62
	call hl_mas_a		;5c63   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;5c66
	ld a,b			;5c67
	rra			;5c68
	rra			;5c69
	rra			;5c6a
	rra			;5c6b
	and 00fh		;5c6c
	call de_mas_a		;5c6e   ; de_mas_a: DE = DE + A
	ld a,(de)			;5c71
	rla			;5c72
	rla			;5c73
	rla			;5c74
	rla			;5c75
	and 0f0h		;5c76
	or c			;5c78
	ld de,0f002h		;5c79   ; 0xF002 = el par de cifras
	ld (de),a			;5c7c
	ld hl,03a6eh		;5c7d   ; las dos cifras del codigo y la de cuadros
	ld b,002h		;5c80
	call pinta_bcd		;5c82   ; pinta_bcd: B bytes BCD de DE hacia atras en la VRAM HL, dos cifras por byte (caracter = cifra + 1)
	jp bancos_2_3		;5c85   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
intercambia:		; intercambia B bytes entre HL y DE
	ld c,(hl)			;5c88   ; el de HL
	ld a,(de)			;5c89
	ld (hl),a			;5c8a   ; pasa a HL el de DE
	ld a,c			;5c8b
	ld (de),a			;5c8c   ; y a DE el de HL
	inc hl			;5c8d
	inc de			;5c8e
	djnz intercambia		;5c8f
	ret			;5c91
sitio_en_pantalla:		; HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld a,l			;5c92   ; L = Y, H = X: HL = 0xED00 + (Y / 8) x 32 + X / 8
	rra			;5c93   ; L / 16, con los bits que salen a H
	rra			;5c94
	rra			;5c95
	rra			;5c96
	rr h		;5c97   ; H = X / 8 con los bits 3-5 de Y arriba
	rra			;5c99
	rr h		;5c9a
	rra			;5c9c
	rr h		;5c9d
	ld l,h			;5c9f   ; L = la columna y la fila dentro del tercio
	and 003h		;5ca0   ; H = 0xED + el tercio (Y / 64)
	add a,0edh		;5ca2
	ld h,a			;5ca4
	ret			;5ca5
byte_a:		; A = el byte A de la tabla HL
	add a,l			;5ca6
	ld l,a			;5ca7
	jr nc,L_5CAB		;5ca8
	inc h			;5caa
L_5CAB:
	ld a,(hl)			;5cab
	ret			;5cac
menos_de:		; DE = - DE
	ld a,e			;5cad   ; complemento a dos
	cpl			;5cae
	ld e,a			;5caf
	ld a,d			;5cb0
	cpl			;5cb1
	ld d,a			;5cb2
	inc de			;5cb3
	ret			;5cb4
menos_hl:		; HL = - HL
	ld a,l			;5cb5   ; complemento a dos
	cpl			;5cb6
	ld l,a			;5cb7
	ld a,h			;5cb8
	cpl			;5cb9
	ld h,a			;5cba
	inc hl			;5cbb
	ret			;5cbc
empieza_todo:		; 0xE1AE-0xE1B9, el sonido (p04:71AE), el mezclador del PSG (0xBF), silencio, la VRAM a cero y los registros del VDP
	ld a,0ffh		;5cbd   ; 0xE1AE y 0xE1AF = 0xFF
	ld hl,0e1aeh		;5cbf
	ld (hl),a			;5cc2
	inc hl			;5cc3
	ld (hl),a			;5cc4
	inc hl			;5cc5
	ld de,0e1b1h		;5cc6
	ld (hl),001h		;5cc9   ; 0xE1B0-0xE1B9 = 1
	ld bc,00009h		;5ccb
	ldir		;5cce
	ld a,004h		;5cd0   ; los bancos del sonido
	ld (07000h),a		;5cd2   ; el mapper: pone en 0x6000 el banco de A
	inc a			;5cd5
	ld (09000h),a		;5cd6   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5cd9
	ld (0b000h),a		;5cda   ; el mapper: pone en 0xA000 el banco de A
	call 071aeh		;5cdd   ; p04:71AE: el sonido, de cero
	ld a,(0f0f1h)		;5ce0   ; devuelve los bancos
	ld (07000h),a		;5ce3   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;5ce6   ; lee la copia del banco de 0x8000
	ld (09000h),a		;5ce9   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;5cec   ; lee la copia del banco de 0xA000
	ld (0b000h),a		;5cef   ; el mapper: pone en 0xA000 el banco de A
	ld a,0bfh		;5cf2   ; el mezclador del PSG: tonos de A, B y C, sin ruido
	ld (0e1a6h),a		;5cf4
	ld e,a			;5cf7
	ld a,007h		;5cf8
	call 00093h		;5cfa   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,043h		;5cfd   ; silencio
	call sonido		;5cff   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld hl,00000h		;5d02   ; los 16 KB de VRAM a cero
	ld bc,04000h		;5d05
	xor a			;5d08
	call 00056h		;5d09   ; BIOS FILVRM - Fills VRAM with value
registros_del_vdp:		; los 8 registros del VDP de p00:5D1D
	ld hl,05d1dh		;5d0c
	ld d,008h		;5d0f
	ld c,000h		;5d11   ; del registro 0 al 7
L_5D13:
	ld b,(hl)			;5d13
	call 00047h		;5d14   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;5d17
	inc c			;5d18
	dec d			;5d19
	jr nz,L_5D13		;5d1a
	ret			;5d1c

; ----------------------------------------------------------------------
; DATOS registros_vdp: los 8 registros del VDP que p00:5D0C escribe (WRTVDP):
;   SCREEN 2, nombres en 0x3800, colores en 0x0000, dibujos en 0x2000,
;   atributos de sprite en 0x3B00 y sus dibujos en 0x1800; lo leen p00:5D13 (8
;   bytes)
;   0x5d1d..0x5d25  (8 bytes)
DATA_registros_vdp:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e4h	; 5d1d  .....v..

; ======================================================================
; CODIGO 0x5d25..0x5f6d  (584 bytes)
; ======================================================================


color_de_fondo:		; el registro 7 del VDP (color de borde) con B
	ld c,007h		;5d25
	jp L_4077		;5d27
lee_mandos:		; 0xE1C9 = los mandos (p00:5D40) y 0xE1C8 = los recien pulsados
	call mandos		;5d2a   ; mandos: A = joystick 1 OR teclado: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 disparo (espacio), 5 el otro boton (M o N)
	ld hl,0e1c9h		;5d2d   ; apunta a los mandos: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 disparo, 5 el otro boton
guarda_mandos:		; (HL) = A y (HL - 1) = los bits que se acaban de pulsar
	ld c,(hl)			;5d30   ; C = lo de antes
	ld (hl),a			;5d31   ; guarda lo de ahora
	xor c			;5d32   ; lo que ha cambiado
	and (hl)			;5d33   ; y esta pulsado ahora
	dec hl			;5d34
	ld (hl),a			;5d35   ; en el byte de antes
	ret			;5d36
mandos_titulo:		; los mandos para p00:5A3E
	ld e,08fh		;5d37   ; el puerto: E = 0x8F
	call lee_joystick		;5d39   ; lee_joystick: A = el registro 14 del PSG (el puerto del joystick que elige E en el 15), invertido
	and 03fh		;5d3c   ; seis bits del joystick
	jr L_5D47		;5d3e
mandos:		; A = joystick 1 OR teclado: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 disparo (espacio), 5 el otro boton (M o N)
	ld e,08fh		;5d40
	call lee_joystick		;5d42   ; lee_joystick: A = el registro 14 del PSG (el puerto del joystick que elige E en el 15), invertido
	and 03fh		;5d45
L_5D47:
	push af			;5d47
	ld a,004h		;5d48   ; la fila 4 del teclado: M y N
	call 00141h		;5d4a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5d4d
	and 00ch		;5d4e
	ld e,a			;5d50
	jr z,L_5D55		;5d51
	ld e,020h		;5d53   ; M o N: el otro boton (bit 5)
L_5D55:
	ld a,008h		;5d55   ; la fila 8: espacio y cursores
	call 00141h		;5d57   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5d5a
	rrca			;5d5b
	rrca			;5d5c
	ld b,a			;5d5d
	and 004h		;5d5e   ; izquierda al bit 2
	or e			;5d60
	ld c,a			;5d61
	ld a,b			;5d62
	rrca			;5d63
	rrca			;5d64
	ld b,a			;5d65
	and 018h		;5d66   ; derecha al bit 3, espacio al 4
	or c			;5d68
	ld c,a			;5d69
	ld a,b			;5d6a
	rrca			;5d6b
	and 003h		;5d6c   ; arriba y abajo a los bits 0 y 1
	or c			;5d6e
	pop bc			;5d6f   ; junto con el joystick
	or b			;5d70
	ret			;5d71
lee_joystick:		; A = el registro 14 del PSG (el puerto del joystick que elige E en el 15), invertido
	ld a,00fh		;5d72   ; el registro 15 del PSG elige el puerto
	call 00093h		;5d74   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;5d77   ; el 14 lo lee
	di			;5d79
	call 00096h		;5d7a   ; BIOS RDPSG - Reads value from PSG-register
	ei			;5d7d
	cpl			;5d7e   ; a 1 lo pulsado
	ret			;5d7f
aa2f_con_bancos:		; con los bancos 1-2-3, p03:AA2F, y el banco 10
	call bancos_1_2_3		;5d80   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call 0aa2fh		;5d83
	jp banco_10		;5d86   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
cuadros_desde:		; C si la cuenta de interrupciones 0xF0F7 no llega a DE
	ld hl,(0f0f7h)		;5d89   ; lee la cuenta de interrupciones (16 bits)
	rst 20h			;5d8c   ; la compara con DE
	ret			;5d8d
caracteres_b3d0:		; p00:5DA0 y p01:69EF
	call caracteres_b3d0_sin_borrar		;5d8e   ; caracteres_b3d0_sin_borrar: con el banco 9, la lista p09:B3D0 con sus copias (p09:B3EA espejo, p09:B3FB cabeza abajo) y los sprites p12:A9BA
	jp 069efh		;5d91   ; borra_e600_y_banco_10: vacia 0xE600-0xE9FF, pone los bancos 1-2-3 y el 10 en 0xA000
caracteres_b3d0_y_borra:		; p00:5DA0 y p00:5D97
	call caracteres_b3d0_sin_borrar		;5d94   ; caracteres_b3d0_sin_borrar: con el banco 9, la lista p09:B3D0 con sus copias (p09:B3EA espejo, p09:B3FB cabeza abajo) y los sprites p12:A9BA
borra_e600_bancos:		; con los bancos 13-14-15 vacia 0xE600-0xE9FF y deja el banco 10
	call bancos_13_14_15		;5d97   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	call borra_e600		;5d9a   ; borra_e600: pone a cero 0xE600-0xE9FF
	jp banco_10		;5d9d   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
caracteres_b3d0_sin_borrar:		; con el banco 9, la lista p09:B3D0 con sus copias (p09:B3EA espejo, p09:B3FB cabeza abajo) y los sprites p12:A9BA
	call banco_9		;5da0   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld ix,0b3d0h		;5da3   ; los caracteres de p09:B3D0
	call pon_caracteres		;5da7   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;5daa   ; sus copias en espejo
	ld (0f000h),a		;5dab   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0b3eah		;5dae
	call copia_caracteres		;5db2   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,001h		;5db5   ; y cabeza abajo
	ld (0f000h),a		;5db7   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0b3fbh		;5dba
	call copia_caracteres		;5dbe   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	call banco_12		;5dc1   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld hl,01800h		;5dc4   ; los sprites de p12:A9BA
	ld de,0a9bah		;5dc7
	jp descomprime_a_vram		;5dca   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
caracteres_a000:		; copia caracteres de un tercio a los otros dos y la lista p12:A000 (copias p12:A00D)
	ld hl,02038h		;5dcd   ; 344 bytes de dibujos desde el caracter 7 del tercio de arriba
	ld de,0e500h		;5dd0   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00158h		;5dd3
	call 00059h		;5dd6   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02500h		;5dd9   ; al caracter 0xA0 de los tercios de arriba y del medio
	ld de,0e500h		;5ddc   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00158h		;5ddf
	exx			;5de2
	ld b,002h		;5de3
	call copia_a_vram_b_veces		;5de5   ; copia_a_vram_b_veces: copia BC' bytes de DE' a la VRAM HL B veces, 0x800 mas adelante cada vez
	ld a,0f0h		;5de8   ; con los colores 0xF0
	ld hl,00500h		;5dea
	ld bc,00158h		;5ded
	ld d,002h		;5df0
	call rellena_vram_d_veces		;5df2   ; rellena_vram_d_veces: rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
	call banco_12		;5df5   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld ix,0a000h		;5df8   ; la lista p12:A000
	call pon_caracteres		;5dfc   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;5dff
	ld (0f000h),a		;5e00   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a00dh		;5e03
	call copia_caracteres		;5e07   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	jr borra_e600_bancos		;5e0a
caracteres_5e5f:		; p00:5E64, p00:5E20 y p00:5D97
	call caracteres_b6cd_y_borra		;5e0c   ; caracteres_b6cd_y_borra: p00:5E64 y p00:5D97
	call caracteres_del_final		;5e0f   ; caracteres_del_final: p09:AFF8, p12:BC09 y p12:BEF1 a los tres tercios y colores 0xF0
L_5E12:
	jr borra_e600_bancos		;5e12
caracteres_5e59:		; p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call caracteres_b6cd_y_69f2		;5e14   ; caracteres_b6cd_y_69f2: p00:5E64 y p01:69F2
	call caracteres_del_final		;5e17   ; caracteres_del_final: p09:AFF8, p12:BC09 y p12:BEF1 a los tres tercios y colores 0xF0
	jp 069f2h		;5e1a   ; bancos_1_2_3_y_10: los bancos 1-2-3 y el 10 en 0xA000
caracteres_5e64_5e20:		; p00:5E64 y p00:5E20
	call caracteres_b6cd		;5e1d   ; caracteres_b6cd: con el banco 11, p11:B6CD y caracteres copiados de un sitio a otro de la VRAM
caracteres_del_final:		; p09:AFF8, p12:BC09 y p12:BEF1 a los tres tercios y colores 0xF0
	call banco_9		;5e20   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld de,0aff8h		;5e23   ; p09:AFF8 desde el caracter 0x26 de los tres tercios
	ld hl,02130h		;5e26
	ld bc,003d8h		;5e29
	call copia_a_vram_x3		;5e2c   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	call banco_12		;5e2f   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld de,0bc09h		;5e32   ; p12:BC09 desde el 0xA1
	ld hl,02508h		;5e35
	ld bc,002e8h		;5e38
	call copia_a_vram_x3		;5e3b   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld de,0bef1h		;5e3e   ; p12:BEF1 desde el 0x21
	ld hl,02108h		;5e41
	ld bc,00028h		;5e44
	call copia_a_vram_x3		;5e47   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld a,(0f000h)		;5e4a   ; 0xF000 tercios de colores 0xF0
	ld d,a			;5e4d
	ld a,0f0h		;5e4e
	ld hl,00008h		;5e50
	ld bc,007f0h		;5e53
	jp rellena_vram_x3		;5e56   ; rellena_vram_x3: rellena BC bytes de la VRAM con A en los tres tercios (HL, + 0x800, + 0x1000)
caracteres_b6cd_y_69f2:		; p00:5E64 y p01:69F2
	call caracteres_b6cd		;5e59   ; caracteres_b6cd: con el banco 11, p11:B6CD y caracteres copiados de un sitio a otro de la VRAM
	jp 069f2h		;5e5c
caracteres_b6cd_y_borra:		; p00:5E64 y p00:5D97
	call caracteres_b6cd		;5e5f   ; caracteres_b6cd: con el banco 11, p11:B6CD y caracteres copiados de un sitio a otro de la VRAM
L_5E62:
	jr L_5E12		;5e62
caracteres_b6cd:		; con el banco 11, p11:B6CD y caracteres copiados de un sitio a otro de la VRAM
	call banco_11		;5e64   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b6cdh		;5e67   ; p11:B6CD
	ld hl,030a0h		;5e6a   ; copia caracteres del tercio de abajo al de arriba
	ld de,0e500h		;5e6d   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00030h		;5e70
	call 00059h		;5e73   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02008h		;5e76
	ld de,0e500h		;5e79   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00030h		;5e7c
	call copia_a_vram_x3		;5e7f   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld hl,02108h		;5e82   ; y otros del tercio de arriba, mas abajo
	ld de,0e500h		;5e85   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,000d0h		;5e88
	call 00059h		;5e8b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02038h		;5e8e
	ld de,0e500h		;5e91   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,000d0h		;5e94
	jp copia_a_vram_x3		;5e97   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
caracteres_a214_y_borra:		; p00:5EA9, p00:5D97 y p10:A435
	call caracteres_a214_sin		;5e9a   ; caracteres_a214_sin: con el banco 9, la lista p09:A214 con sus copias y, fuera del MSX japones (0x002B), p09:A221
	call borra_e600_bancos		;5e9d   ; borra_e600_bancos: con los bancos 13-14-15 vacia 0xE600-0xE9FF y deja el banco 10
	jp 0a435h		;5ea0
caracteres_a214:		; p00:5EA9 y p01:69EF
	call caracteres_a214_sin		;5ea3   ; caracteres_a214_sin: con el banco 9, la lista p09:A214 con sus copias y, fuera del MSX japones (0x002B), p09:A221
L_5EA6:
	jp 069efh		;5ea6
caracteres_a214_sin:		; con el banco 9, la lista p09:A214 con sus copias y, fuera del MSX japones (0x002B), p09:A221
	call banco_9		;5ea9   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld ix,0a214h		;5eac   ; la lista p09:A214
	call pon_caracteres		;5eb0   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;5eb3   ; sus copias en espejo
	ld (0f000h),a		;5eb4   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a228h		;5eb7
	call copia_caracteres		;5ebb   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,001h		;5ebe   ; y cabeza abajo
	ld (0f000h),a		;5ec0   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a22fh		;5ec3
	call copia_caracteres		;5ec7   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,(0002bh)		;5eca   ; 0x002B de la BIOS: los bits 0-3 son el juego de caracteres (0 = japones)
	and 00fh		;5ecd
	ret z			;5ecf
	ld ix,0a221h		;5ed0   ; fuera de Japon, la lista p09:A221
	jp pon_caracteres		;5ed4   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
caracteres_a143:		; p00:5EE1 y p01:69EF
	call caracteres_a143_sin		;5ed7   ; caracteres_a143_sin: con el banco 9, la lista p09:A143 y sus copias p09:A15C
	jr L_5EA6		;5eda
caracteres_a143_y_borra:		; p00:5EE1 y p00:5D97
	call caracteres_a143_sin		;5edc   ; caracteres_a143_sin: con el banco 9, la lista p09:A143 y sus copias p09:A15C
	jr L_5E62		;5edf
caracteres_a143_sin:		; con el banco 9, la lista p09:A143 y sus copias p09:A15C
	call banco_9		;5ee1   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld ix,0a143h		;5ee4   ; la lista p09:A143
	call pon_caracteres		;5ee8   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;5eeb   ; y sus copias en espejo
	ld (0f000h),a		;5eec   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a15ch		;5eef
	jp copia_caracteres		;5ef3   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
empieza_la_demo:		; la fase de la demostracion (0xE1C6: 2, 3, 4, 5, 6 y otra vez 2), sus mandos desde el primero, p01:60FD, p02:8196, nivel 0 y el marcador
	xor a			;5ef6   ; sin mandos
	ld (0e1c9h),a		;5ef7   ; guarda los mandos: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 disparo, 5 el otro boton
	ld (0e1c7h),a		;5efa
	inc a			;5efd   ; con la nave en juego
	ld (0e1d3h),a		;5efe   ; guarda la marca de vida en marcha (0: la nave ha caido)
	ld hl,0e1c6h		;5f01   ; la fase de esta demostracion
	ld a,(hl)			;5f04
	ld (0e201h),a		;5f05   ; guarda la fase (0-11)
	inc a			;5f08   ; la siguiente: de la 2 a la 6
	cp 007h		;5f09
	jr c,L_5F0F		;5f0b
	ld a,002h		;5f0d
L_5F0F:
	ld (hl),a			;5f0f
	ld hl,00001h		;5f10   ; el primer mando, al cuadro siguiente
	ld (0e1cbh),hl		;5f13   ; guarda los cuadros que quedan del mando de la demo y el byte siguiente (16 bits)
	xor a			;5f16
	ld (0e1cdh),a		;5f17   ; guarda el paso de los mandos de la demo
	ld (0e20ah),a		;5f1a   ; guarda la vuelta (bit 0: las fases bajan)
	call 060fdh		;5f1d   ; p01:60FD
	call 08196h		;5f20   ; p02:8196
	xor a			;5f23
	ld (0e228h),a		;5f24   ; nivel 0
	jp pinta_el_marcador		;5f27   ; pinta_el_marcador: los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
cuadro_de_demo:		; un cuadro de la demostracion: los mandos de p15:5F6D (pares [cuadros][mandos], 0xFF acaba) con el disparo puesto, y el cuadro de juego
	ld a,(0e204h)		;5f2a   ; con 0xE204 puesto, se acaba
	and a			;5f2d
	jr z,L_5F35		;5f2e
L_5F30:
	xor a			;5f30
	ld (0e1d3h),a		;5f31   ; guarda la marca de vida en marcha (0: la nave ha caido)
	ret			;5f34
L_5F35:
	ld hl,0e1cbh		;5f35   ; un cuadro menos del mando
	dec (hl)			;5f38
	jr z,L_5F46		;5f39
L_5F3B:
	ld a,(0e1cch)		;5f3b   ; el mando, siempre disparando
	or 010h		;5f3e
	ld (0e1c9h),a		;5f40   ; guarda los mandos: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 disparo, 5 el otro boton
	jp cuadro_de_juego		;5f43   ; y un cuadro de juego
L_5F46:
	inc hl			;5f46   ; el siguiente par de la lista de la fase
	inc hl			;5f47
	ld c,(hl)			;5f48
	inc (hl)			;5f49
	call banco_15		;5f4a   ; en el banco 15
	ld a,(0e201h)		;5f4d   ; lee la fase (0-11)
	ld hl,l5f69h		;5f50
	call palabra_a		;5f53   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld l,c			;5f56
	ld h,000h		;5f57
	add hl,hl			;5f59
	add hl,de			;5f5a
	ld a,(hl)			;5f5b   ; [cuadros][mandos]
	ld c,a			;5f5c
	ld (0e1cbh),a		;5f5d   ; guarda los cuadros que quedan del mando de la demo
	inc hl			;5f60
	ld a,(hl)			;5f61
	ld (0e1cch),a		;5f62   ; guarda el mando de la demo
	call bancos_2_3		;5f65   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	inc c			;5f68   ; 0xFF: se acabo
L_5F69:
	jr z,L_5F30		;5f69
	jr L_5F3B		;5f6b

; ----------------------------------------------------------------------
; DATOS tabla_5F6D: 5 punteros (fases 2 a 6) al banco 15 que p00:5F4D lee en
;   0x5F69 + 2 x fase con L_4B67; las fases 0 y 1 caerian en el `jr` de
;   delante; lo leen p00:5F53 (10 bytes)
;   0x5f6d..0x5f77  (10 bytes)
DATA_tabla_5F6D:
	defw 0bdb2h,0be29h,0beaah,0bf0fh,0bf80h	; 5f6d

; ======================================================================
; CODIGO 0x5f77..0x6000  (137 bytes)
; ======================================================================


objetos_5f84:		; si p01:6878 da Z, con el banco 15, p00:5F84
	call 06878h		;5f77   ; p01:6878
	ret nz			;5f7a
	call banco_15		;5f7b   ; banco_15: pone el banco 15 en 0xA000 (y 0xF0F3)
	call objetos_de_caracteres_a		;5f7e   ; objetos_de_caracteres_a: las 0xE3B2 fichas de 16 bytes de 0xE500 de las clases 1-4, 5-6, 8-10, 14 y 16 (p00:5FB5)
	jp bancos_1_2_3		;5f81   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
objetos_de_caracteres_a:		; las 0xE3B2 fichas de 16 bytes de 0xE500 de las clases 1-4, 5-6, 8-10, 14 y 16 (p00:5FB5)
	ld a,(0e3b2h)		;5f84   ; 0xE3B2 fichas
	and a			;5f87
	ret z			;5f88
	ld b,a			;5f89
	ld ix,0e500h		;5f8a   ; apunta a las fichas de 16 bytes de los objetos de caracteres
L_5F8E:
	xor a			;5f8e   ; 0xF000 = 0
	ld (0f000h),a		;5f8f   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,(ix+000h)		;5f92   ; IX+00: la clase del objeto (0 libre)
	and a			;5f95
	jr z,L_5FAD		;5f96
	cp 007h		;5f98
	jr z,L_5FAD		;5f9a
	cp 00eh		;5f9c
	jr z,L_5FA8		;5f9e
	cp 010h		;5fa0
	jr z,L_5FA8		;5fa2
	cp 00bh		;5fa4
	jr nc,L_5FAD		;5fa6
L_5FA8:
	push bc			;5fa8
	call objeto_de_caracteres_a		;5fa9   ; objeto_de_caracteres_a: segun la clase (IX+00) y IX+06, a p00:5FFB
	pop bc			;5fac
L_5FAD:
	ld de,00010h		;5fad   ; 16 bytes por ficha
	add ix,de		;5fb0
	djnz L_5F8E		;5fb2
	ret			;5fb4
objeto_de_caracteres_a:		; segun la clase (IX+00) y IX+06, a p00:5FFB
	ld a,(ix+000h)		;5fb5   ; clases 5 y 6
	sub 005h		;5fb8
	cp 002h		;5fba
	jr c,objeto_de_caracteres		;5fbc
	ld a,(ix+006h)		;5fbe   ; IX+06 a cero: nada
	and a			;5fc1
	ret z			;5fc2
	ld a,(ix+000h)		;5fc3
	cp 007h		;5fc6
	ret z			;5fc8
	cp 005h		;5fc9
	jr nc,objeto_de_caracteres		;5fcb
	cp 002h		;5fcd
	jr z,objeto_de_caracteres		;5fcf
	ret			;5fd1
objetos_5fdf:		; si p01:6878 da Z, con el banco 15, p00:5FDF
	call 06878h		;5fd2
	ret nz			;5fd5
	call banco_15		;5fd6   ; banco_15: pone el banco 15 en 0xA000 (y 0xF0F3)
	call objetos_de_caracteres_b		;5fd9   ; objetos_de_caracteres_b: las 0xE3B2 fichas de 0xE500 con 0xF000 = 0xFF (p00:5FFB)
	jp bancos_1_2_3		;5fdc   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
objetos_de_caracteres_b:		; las 0xE3B2 fichas de 0xE500 con 0xF000 = 0xFF (p00:5FFB)
	ld a,(0e3b2h)		;5fdf   ; lee cuantas fichas de objetos de caracteres hay (0xE500)
	and a			;5fe2
	ret z			;5fe3
	ld b,a			;5fe4
	ld ix,0e500h		;5fe5   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld a,0ffh		;5fe9   ; 0xF000 = 0xFF
	ld (0f000h),a		;5feb   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
L_5FEE:
	push bc			;5fee   ; uno a uno
	call objeto_de_caracteres		;5fef   ; objeto_de_caracteres: un objeto de caracteres de 0xE500 (sigue en p01:6000)
	pop bc			;5ff2
	ld de,00010h		;5ff3   ; 16 bytes por ficha
	add ix,de		;5ff6
	djnz L_5FEE		;5ff8
	ret			;5ffa
objeto_de_caracteres:		; un objeto de caracteres de 0xE500 (sigue en p01:6000)
	ld a,(ix+000h)		;5ffb   ; la clase (0 libre)
	and a			;5ffe
	ret z			;5fff

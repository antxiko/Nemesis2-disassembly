; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x622d  (557 bytes)
; ======================================================================


objeto_de_caracteres_sigue:		; las clases 3 y 4 no se pintan, ni las 0x0B-0x0D, ni la 7 de X 0xC1 en adelante; las demas, su forma (p15:B661) en la pantalla de RAM
	cp 003h		;6000   ; las clases 3 y 4 no se pintan aqui
	ret z			;6002
	cp 004h		;6003
	ret z			;6005
	cp 00eh		;6006   ; de la 14 en adelante, se pintan
	jr nc,pinta_objeto		;6008
	cp 00bh		;600a   ; las 11-13 no
	ret nc			;600c
	cp 007h		;600d
	jr nz,pinta_objeto		;600f
	ld a,(ix+006h)		;6011   ; la 7, solo con X < 0xC1
	cp 0c1h		;6014
	ret nc			;6016
pinta_objeto:		; la forma IX+07 (p15:B661) de IX+09 x IX+0A en IX+04/IX+06: copiada con 0xF000 distinto de 0, borrada con 0
	ld a,(ix+007h)		;6017   ; la forma IX+07 en p15:B661
	ld hl,0b661h		;601a
	call 04b67h		;601d   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld b,(ix+009h)		;6020   ; B = ancho, C = filas
	ld c,(ix+00ah)		;6023
	ld l,(ix+004h)		;6026   ; L = Y, H = X
	ld h,(ix+006h)		;6029
	ld a,(0f000h)		;602c   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	and a			;602f   ; 0: borrarla
	jp z,L_6052		;6030
	ld a,(ix+006h)		;6033   ; cerca del borde derecho, con recorte
	cp 0c8h		;6036
	jp nc,05327h		;6038   ; copia_bloque: copia DE en la pantalla de RAM en H (X), L (Y): C filas de B (de A de ancho en origen), cortado por el borde
	call 05c92h		;603b   ; el sitio en la pantalla de RAM
	ex de,hl			;603e
	ld a,c			;603f
L_6040:
	push de			;6040   ; una fila de la forma
	ld c,(ix+009h)		;6041
	ld b,000h		;6044
	ldir		;6046
	pop de			;6048
	ld c,020h		;6049   ; la fila siguiente de la pantalla
	ex de,hl			;604b
	add hl,bc			;604c
	ex de,hl			;604d
	dec a			;604e
	jr nz,L_6040		;604f
	ret			;6051
L_6052:
	ld a,(ix+006h)		;6052   ; cerca del borde derecho, con recorte
	cp 0c8h		;6055
	jp nc,0530ch		;6057   ; borra_bloque: borra C filas de B caracteres en la pantalla de RAM en H (X), L (Y), cortado por el borde
	call 05c92h		;605a   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
L_605D:
	ld b,(ix+009h)		;605d   ; una fila de ceros
	push hl			;6060
	xor a			;6061
L_6062:
	ld (hl),a			;6062
	inc hl			;6063
	djnz L_6062		;6064
	pop hl			;6066
	ld a,020h		;6067   ; la fila siguiente
	call 0407ah		;6069   ; hl_mas_a: HL = HL + A
	dec c			;606c
	jr nz,L_605D		;606d
	ret			;606f
objeto_tocado:		; un objeto de caracteres tocado: suena 5 (0x14 la clase 15); la clase 9 pasa a IX+01 = 4 con el dibujo 0x1B o 0x1C
	ld c,005h		;6070   ; el sonido 5
	ld a,(ix+000h)		;6072
	cp 00fh		;6075   ; o el 0x14 la clase 15
	jr nz,L_607B		;6077
	ld c,014h		;6079
L_607B:
	ld a,(ix+008h)		;607b   ; con IX+08 = 1 no suena
	dec a			;607e
	ld a,c			;607f
	call nz,04ae4h		;6080   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,(ix+000h)		;6083   ; la clase 9
	cp 009h		;6086
	ret nz			;6088
	ld a,01bh		;6089   ; cambia de dibujo (0x1B, o 0x1C con IX+0B bit 0)
	ld (ix+001h),004h		;608b
	bit 0,(ix+00bh)		;608f
	jr z,L_6096		;6093
	inc a			;6095
L_6096:
	ld (ix+007h),a		;6096
	ld (ix+00dh),000h		;6099
	ret			;609d
objeto_destruido:		; con el banco 15, p01:60A7
	call 0413fh		;609e   ; banco_15: pone el banco 15 en 0xA000 (y 0xF0F3)
	call objeto_destruido_sin_banco		;60a1   ; objeto_destruido_sin_banco: las clases 14 y 16 quedan rotas (IX+0D = 0xFF), la 1 pasa a IX+01 = 8; las demas desaparecen
	jp 04157h		;60a4   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
objeto_destruido_sin_banco:		; las clases 14 y 16 quedan rotas (IX+0D = 0xFF), la 1 pasa a IX+01 = 8; las demas desaparecen
	ld a,(ix+000h)		;60a7   ; la clase 14
	cp 00eh		;60aa
	jr z,L_60C3		;60ac
	cp 010h		;60ae   ; la 16
	jr z,L_60BA		;60b0
	dec a			;60b2   ; la 1
	jr z,L_60CC		;60b3
	ld (ix+000h),000h		;60b5   ; las demas desaparecen
	ret			;60b9
L_60BA:
	ld (ix+00dh),0ffh		;60ba   ; rota
	ld (ix+001h),008h		;60be
	ret			;60c2
L_60C3:
	ld (ix+00dh),0ffh		;60c3
	ld (ix+001h),004h		;60c7
	ret			;60cb
L_60CC:
	ld (ix+001h),008h		;60cc
	ret			;60d0
vuelve_a_la_fase:		; los graficos, el marcador y la pantalla desde la columna 0; con 0xE1DB, la nave en Y 0x4A X 0x50 y p03:AA2F, p03:AAEC
	call 04396h		;60d1   ; carga_graficos_de_fase: con los bancos 11 y 7-8-9: p11:B736 y luego caracteres y sprites de la fase (p00:43A5)
	call 05ba3h		;60d4   ; pinta_el_marcador: los textos del marcador (p03:B23D y el del jugador), las vidas y los puntos
	ld hl,00000h		;60d7   ; desde la columna 0
	ld (0e203h),hl		;60da   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	call borra_la_fase		;60dd   ; borra_la_fase: 0xE22C, 0xE300, 0xEAA8-0xEAB7, 0xE340-0xE3FF y 0xE500-0xECFF a cero; luego p01:68E4
	call 047e0h		;60e0   ; pinta_la_pantalla: las 32 columnas de la pantalla de una vez (0xE203 - 32 en adelante), con el cuadro entero de enemigos por cada una
	ld a,(0e1dbh)		;60e3   ; con 0xE1DB, la nave en su sitio de salida
	or a			;60e6
	ret z			;60e7
	xor a			;60e8
	ld (0e1dbh),a		;60e9   ; guarda la marca de nave en su sitio al volver
	ld hl,04a00h		;60ec   ; Y 0x4A
	ld (0e403h),hl		;60ef
	ld h,050h		;60f2   ; X 0x50
	ld (0e405h),hl		;60f4
	call 0aa2fh		;60f7
	jp 0aaech		;60fa
empieza_la_fase:		; la fase de la vida (la mas alta en 0xE206; con 0xE22C la de p01:7C59; de la 8 en adelante, 0xE22A), sus graficos, 0xE300-0xEFFF a cero y la primera pantalla
	ld a,(0e201h)		;60fd   ; en las fases 0-7
	cp 008h		;6100
	jr nc,L_611C		;6102
	ld hl,0e206h		;6104   ; apunta la mas alta
	cp (hl)			;6107
	jr c,L_610B		;6108
	ld (hl),a			;610a
L_610B:
	ld hl,0e22ch		;610b   ; con 0xE22C se vuelve a otra fase
	ld a,(hl)			;610e
	ld (hl),000h		;610f
	and a			;6111
	jr z,L_6128		;6112
	ld a,(0e201h)		;6114   ; lee la fase (0-11)
	call fase_que_sigue_a		;6117   ; p01:7C59
	jr L_611F		;611a
L_611C:
	ld a,(0e22ah)		;611c   ; del interior se sale a la fase de 0xE22A
L_611F:
	ld (0e201h),a		;611f   ; guarda la fase (0-11)
	ld hl,00020h		;6122   ; desde la columna 32
	ld (0e203h),hl		;6125   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
L_6128:
	call 04396h		;6128   ; carga_graficos_de_fase: con los bancos 11 y 7-8-9: p11:B736 y luego caracteres y sprites de la fase (p00:43A5)
	call 04c76h		;612b   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	xor a			;612e
	ld (0e1d5h),a		;612f   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	ld hl,0e300h		;6132   ; 0xE300-0xEFFF a cero
	ld de,0e301h		;6135
	ld bc,00cffh		;6138
	ld (hl),a			;613b
	ldir		;613c
	call datos_de_la_fase		;613e   ; p01:68E4 y p01:68AA
	call nivel_de_la_fase		;6141   ; nivel_de_la_fase: el nivel (0xE228) = la fase mas alta / 2, como mucho 15
	ld a,(0e1c2h)		;6144   ; en la demo, nivel 0
	bit 6,a		;6147
	jr nz,L_614F		;6149
	xor a			;614b
	ld (0e228h),a		;614c   ; guarda el nivel de dificultad
L_614F:
	call nave_de_salida		;614f   ; p01:6888
	call 0aa2fh		;6152   ; p03:AA2F
	call 05366h		;6155   ; empieza_el_medidor: 0xE330-0xE33C a cero, p02:8060 y, con 0xE20B o 0xE20D, la casilla 1; y lo pinta
	jp 047e0h		;6158   ; pinta_la_pantalla: las 32 columnas de la pantalla de una vez (0xE203 - 32 en adelante), con el cuadro entero de enemigos por cada una
pantalla_del_titulo:		; los caracteres del titulo (p00:55A7) y, fuera de Japon, los de NEMESIS (p12:AA83), p11:B6CD, sprites (p12:AA75) y p10:A24C
	call 04a10h		;615b   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 0413fh		;615e   ; banco_15: pone el banco 15 en 0xA000 (y 0xF0F3)
	ld ix,055a7h		;6161   ; los caracteres del titulo
	call 04595h		;6165   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;6168   ; y sus copias
	ld (0f000h),a		;6169   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,055deh		;616c
	call 0454eh		;6170   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,(0002bh)		;6173   ; 0x002B: fuera de Japon, NEMESIS en lugar de GRADIUS
	and 00fh		;6176
	jr z,L_618F		;6178
	call 0413bh		;617a   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld ix,0aa83h		;617d   ; los caracteres de NEMESIS
	call 04595h		;6181   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;6184
	ld (0f000h),a		;6185   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0aa96h		;6188
	call 0454eh		;618c   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
L_618F:
	call 04137h		;618f   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b6cdh		;6192   ; p11:B6CD
	call 0413bh		;6195   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld hl,01800h		;6198   ; los sprites del titulo
	ld de,0aa75h		;619b
	call 04a8ch		;619e   ; descomprime_a_vram: descomprime DE a la VRAM HL: n < 0x80 repite el byte siguiente n veces, 0x80 + n copia n bytes, 0x80 cambia de direccion, 0 acaba
	call borra_e600_y_banco_10		;61a1   ; p01:69EF
	ld b,0e0h		;61a4   ; el borde del VDP con el color 0xE0
	call 05d25h		;61a6   ; color_de_fondo: el registro 7 del VDP (color de borde) con B
	ld hl,02800h		;61a9   ; en los tres tercios
	call colores_del_titulo		;61ac   ; colores_del_titulo: p10:A24C con p12:B8F5 en la VRAM HL
	ld hl,00000h		;61af
	call colores_del_titulo		;61b2   ; colores_del_titulo: p10:A24C con p12:B8F5 en la VRAM HL
	ld hl,00800h		;61b5
colores_del_titulo:		; p10:A24C con p12:B8F5 en la VRAM HL
	xor a			;61b8
	ld de,0b8f5h		;61b9
	ld b,001h		;61bc
	jp 0a24ch		;61be   ; p10:A24C
textos_del_titulo:		; KONAMI 1987, PLAY SELECT y 1PLAYER (estados 0-1), o KONAMI PRESENTS THE GRADIUS/NEMESIS SAGA CONTINUES...
	ld a,(0e1c0h)		;61c1   ; lee el estado del juego (0-10, p00:5615)
	cp 002h		;61c4   ; en los estados 0 y 1: KONAMI 1987, PLAY SELECT, 1PLAYER
	ld de,0b904h		;61c6
	jr c,L_61E7		;61c9
	ld de,0b936h		;61cb   ; si no: KONAMI PRESENTS THE
	call 04a6bh		;61ce   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld de,0b94fh		;61d1   ; GRADIUS, o NEMESIS fuera de Japon
	ld a,(0002bh)		;61d4
	and 00fh		;61d7
	jr z,L_61DE		;61d9
	ld de,0622dh		;61db
L_61DE:
	call 04a6bh		;61de   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld de,0b959h		;61e1   ; SAGA CONTINUES WITH THE ULTIMATE COSMIC ADVENTURE
L_61E4:
	jp 04a6bh		;61e4   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_61E7:
	call 04a6bh		;61e7   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jr L_61E4		;61ea
cursor_del_titulo:		; la flecha de la opcion (0xE1D2) parpadeando con el bit 3 de 0xE1C4
	ld hl,0e1c4h		;61ec   ; apunta a la espera del paso, en cuadros
	bit 3,(hl)		;61ef   ; parpadea cada 8 cuadros
	ld c,0ffh		;61f1
	jr nz,pon_cursor		;61f3
	inc c			;61f5
pon_cursor:		; la flecha (p03:B26F) delante de la opcion elegida (C = 0xFF) y la borra de la otra
	ld hl,03a2ah		;61f6   ; la flecha de 1PLAYER
	ld de,03a6ah		;61f9   ; y la de 2PLAYERS
	ld a,(0e1d2h)		;61fc   ; lee la opcion del titulo (0: 1 jugador, 1: 2 jugadores)
	or a			;61ff
	jr z,L_6203		;6200   ; si la opcion es 2 jugadores, al reves
	ex de,hl			;6202
L_6203:
	push de			;6203
	call flecha		;6204   ; pone una
	pop hl			;6207
	ld c,000h		;6208   ; y borra la otra
flecha:		; los dos caracteres de la flecha (p03:B26F) en HL con la mascara C
	ld de,0b26fh		;620a
	jp 04a73h		;620d
borra_e490:		; 0xE490-0xE4A3 a cero
	ld hl,0e490h		;6210   ; 20 bytes desde 0xE490
	ld de,0e491h		;6213
	ld bc,00013h		;6216
	xor a			;6219   ; a cero
	ld (hl),a			;621a
	ldir		;621b
	ret			;621d
titulo:		; con el banco 10: la pantalla del titulo, p10:B636 y sus textos
	call 04133h		;621e   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
	call pantalla_del_titulo		;6221   ; pantalla_del_titulo: los caracteres del titulo (p00:55A7) y, fuera de Japon, los de NEMESIS (p12:AA83), p11:B6CD, sprites (p12:AA75) y p10:A24C
	call 0b636h		;6224   ; p10:B636
	call textos_del_titulo		;6227   ; textos_del_titulo: KONAMI 1987, PLAY SELECT y 1PLAYER (estados 0-1), o KONAMI PRESENTS THE GRADIUS/NEMESIS SAGA CONTINUES...
	jp 04108h		;622a   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)

; ----------------------------------------------------------------------
; DATOS lista_622D: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p01:61DE (10 bytes)
;   0x622d..0x6237  (10 bytes)
DATA_lista_622D:
	defb 007h,03ah,02eh,025h,02dh,025h,033h,029h,033h,0ffh	; 622d  .:.%-%3)3.

; ======================================================================
; CODIGO 0x6237..0x63cd  (406 bytes)
; ======================================================================


logo_de_konami:		; descomprime p09:B79F, borra sus colores y pone los 21 x 6 caracteres del logo (0x40 en adelante) en la fila 8
	ld hl,00000h		;6237
	ld (0e1ceh),hl		;623a   ; desde la fila 0
	call 04144h		;623d   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld de,0b79fh		;6240   ; los dibujos del logo
	call 04a86h		;6243   ; descomprime_otra_direccion: la direccion de VRAM que va en DE y sigue descomprimiendo
	call 04157h		;6246   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld hl,00a00h		;6249   ; sus colores a cero: no se ve
	ld bc,003f0h		;624c
	xor a			;624f
	call 00056h		;6250   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;6253   ; 6 filas de 21 caracteres, de 0x40 en adelante, desde la fila 8 columna 7
	ld a,040h		;6256
	ld c,006h		;6258
	ld de,0000bh		;625a
L_625D:
	ld b,015h		;625d
L_625F:
	call 0004dh		;625f   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6262
	inc a			;6263
	djnz L_625F		;6264
	add hl,de			;6266   ; la fila siguiente (11 + 21 = 32)
	dec c			;6267
	jr nz,L_625D		;6268
	ret			;626a
logo_aparece:		; una fila de pixeles mas del logo en color 0xF0 (0xE1CE fila, 0xE1CF caracter); Z al acabar las 6
	ld bc,(0e1ceh)		;626b   ; C = la fila de pixeles, B = la de caracteres
	ld a,0ebh		;626f   ; el primer caracter de la fila: 0x40 + 21 x B
	inc b			;6271
L_6272:
	add a,015h		;6272
	djnz L_6272		;6274
	ld l,a			;6276   ; x 8 + 0x0A00: sus colores en el tercio del medio
	ld h,b			;6277
	add hl,hl			;6278
	add hl,hl			;6279
	add hl,hl			;627a
	ld de,00a00h		;627b
	add hl,de			;627e
	ld a,c			;627f   ; mas la fila de pixeles
	call 0407ah		;6280   ; hl_mas_a: HL = HL + A
	ld b,015h		;6283   ; 21 caracteres
	ld de,00008h		;6285
	ld a,0f0h		;6288   ; con el color 0xF0
L_628A:
	call 0004dh		;628a   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;628d
	djnz L_628A		;628e
	ld hl,0e1ceh		;6290   ; la fila de pixeles siguiente
	ld a,(hl)			;6293
	inc a			;6294
	and 007h		;6295
	ld (hl),a			;6297
	ret nz			;6298
	inc hl			;6299   ; a los 8, la fila de caracteres siguiente
	inc (hl)			;629a
	ld a,(hl)			;629b
	cp 006h		;629c   ; Z al acabar las 6
	ret			;629e
invierte_aceleracion:		; IX+20/IX+21 = - IX+20/IX+21
	ld e,(ix+020h)		;629f
	ld d,(ix+021h)		;62a2
	call 05cadh		;62a5   ; menos_de: DE = - DE
pon_aceleracion:		; IX+20/IX+21 = DE
	ld (ix+020h),e		;62a8
	ld (ix+021h),d		;62ab
	ret			;62ae
pon_aceleracion_b:		; IX+20/IX+21 = DE
	ld (ix+020h),e		;62af
	ld (ix+021h),d		;62b2
	ret			;62b5
pon_tope:		; IX+22/IX+23 = DE en valor absoluto
	ld a,d			;62b6   ; el tope, siempre positivo
	or a			;62b7
	call m,05cadh		;62b8   ; menos_de: DE = - DE
	ld (ix+022h),e		;62bb
	ld (ix+023h),d		;62be
	ret			;62c1
acelera_vy:		; IX+07/IX+08 + IX+20/IX+21
	ld a,(ix+007h)		;62c2   ; la velocidad Y mas la aceleracion
	add a,(ix+020h)		;62c5
	ld (ix+007h),a		;62c8
	ld a,(ix+008h)		;62cb
	adc a,(ix+021h)		;62ce
	ld (ix+008h),a		;62d1
	ret			;62d4
acelera_vx:		; IX+09/IX+0A + IX+20/IX+21
	ld a,(ix+009h)		;62d5   ; la velocidad X mas la aceleracion
	add a,(ix+020h)		;62d8
	ld (ix+009h),a		;62db
	ld a,(ix+00ah)		;62de
	adc a,(ix+021h)		;62e1
	ld (ix+00ah),a		;62e4
	ret			;62e7
vy_pasa_el_tope:		; compara el valor absoluto de IX+07/IX+08 con IX+22/IX+23 (C: lo pasa)
	ld e,(ix+007h)		;62e8   ; el valor absoluto de la velocidad Y
	ld d,(ix+008h)		;62eb
	ld a,d			;62ee
	or a			;62ef
	call m,05cadh		;62f0   ; menos_de: DE = - DE
	ld l,(ix+022h)		;62f3
	ld h,(ix+023h)		;62f6
	rst 20h			;62f9   ; contra el tope
	ret			;62fa
invierte_vx_b:		; IX+09/IX+0A = - IX+09/IX+0A
	ld e,(ix+009h)		;62fb
	ld d,(ix+00ah)		;62fe
	call 05cadh		;6301   ; menos_de: DE = - DE
	ld (ix+009h),e		;6304
	ld (ix+00ah),d		;6307
	ret			;630a
cada_32_cuadros:		; A = 0xE1C3 & 31 (Z una vez cada 32 cuadros)
	ld a,(0e1c3h)		;630b   ; lee la cuenta de cuadros
	and 01fh		;630e
	ret			;6310
hora_de_irse:		; cada 32 cuadros IX+25 - 1 (C al acabar); si no, C pasado el final del mapa (en la fase 7, en ciertos tramos)
	call cada_32_cuadros		;6311   ; una vez cada 32 cuadros
	jr nz,L_631D		;6314
	dec (ix+025h)		;6316   ; se acaba su tiempo: C
	jr nz,L_631D		;6319
	scf			;631b
	ret			;631c
L_631D:
	ld a,(0e201h)		;631d   ; la fase 7 es distinta
	cp 007h		;6320
	jr z,L_6333		;6322
	ld hl,(0e323h)		;6324   ; en las demas, pasada la columna final menos 16
	ld de,00010h		;6327
	or a			;632a
	sbc hl,de		;632b
	ld de,(0e203h)		;632d   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;6331
	ret			;6332
L_6333:
	ld a,(0e3beh)		;6333   ; en la fase 7, con 0xE3BE nunca
	or a			;6336
	ret nz			;6337
	ld de,(0e203h)		;6338   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	ld hl,000e0h		;633c   ; hasta la columna 0xE0, no
	or a			;633f
	sbc hl,de		;6340
	ret nc			;6342
	ld hl,001a0h		;6343   ; hasta la 0x1A0, si
	or a			;6346
	sbc hl,de		;6347
	ccf			;6349
	ret c			;634a
	ld hl,00210h		;634b   ; hasta la 0x210, no
	or a			;634e
	sbc hl,de		;634f
	ret nc			;6351
	ld hl,00240h		;6352   ; hasta la 0x240, si
	or a			;6355
	sbc hl,de		;6356
	ccf			;6358
	ret c			;6359
	ld hl,002e0h		;635a   ; y de la 0x2E0 en adelante
	or a			;635d
	sbc hl,de		;635e
	ret			;6360
anima:		; cada (0xE1C3 & B) = 0, IX+26 + 1 (de 0 a C - 1) y el dibujo IX+30 = IX+32 = HL[IX+26]
	ld a,(0e1c3h)		;6361   ; solo cuando (cuadros & B) = 0
	and b			;6364
	ret nz			;6365
	ld a,(ix+026h)		;6366   ; el paso siguiente de la animacion
	inc a			;6369
	cp c			;636a
	jr c,L_636E		;636b
	xor a			;636d   ; de 0 a C - 1
L_636E:
	ld (ix+026h),a		;636e
	call 05ca6h		;6371   ; el dibujo del paso
	ld (ix+030h),a		;6374
	ld (ix+032h),a		;6377
	ret			;637a
azar_rapido:		; A = R rotado XOR la cuenta de cuadros
	ld a,r		;637b
	rrca			;637d
	rrca			;637e
	rrca			;637f
	ld hl,0e1c3h		;6380   ; apunta a la cuenta de cuadros
	xor (hl)			;6383
	ret			;6384
mueve_enemigos:		; las 12 fichas de 0xE600: lo de su tipo (p01:63AE), el scroll (p01:6486) y su velocidad (p01:64BE)
	ld ix,0e600h		;6385   ; 12 fichas de 64 bytes
	ld b,00ch		;6389
L_638B:
	push bc			;638b
	ld a,(ix+000h)		;638c   ; libre
	and a			;638f
	jr z,L_63A5		;6390
	call lo_del_tipo		;6392   ; lo de su tipo
	ld a,(ix+000h)		;6395
	or a			;6398   ; se ha ido?
	jr z,L_63A5		;6399
	call enemigo_con_el_scroll		;639b   ; el scroll; C: se ha ido
	jr c,L_63A5		;639e
	call enemigo_se_mueve		;63a0   ; su velocidad
	jr nc,L_63A5		;63a3
L_63A5:
	ld bc,00040h		;63a5   ; la ficha siguiente
	add ix,bc		;63a8
	pop bc			;63aa
	djnz L_638B		;63ab
	ret			;63ad
lo_del_tipo:		; lo propio del tipo IX+00 (65, p01:63CD); con 0xE3D0 no se mueven (salvo el 0x26), con la capsula 5 solo cuadro si cuadro no
	ld a,(ix+000h)		;63ae   ; el tipo 0x26 se mueve siempre
	cp 026h		;63b1
	jr z,L_63C6		;63b3
	ld a,(0e3d0h)		;63b5   ; con 0xE3D0 los demas no
	or a			;63b8
	ret nz			;63b9
	ld a,(0e439h)		;63ba   ; con la capsula 5, cuadro si cuadro no
	cp 005h		;63bd
	jr nz,L_63C6		;63bf
	ld a,(0e1c3h)		;63c1   ; lee la cuenta de cuadros
	rra			;63c4
	ret c			;63c5
L_63C6:
	ld a,(ix+000h)		;63c6   ; por tipo (65)
	dec a			;63c9
	call 04084h		;63ca   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_63CD: 65 destinos del despachador p00:4084 (call en p01:63CA, el
;   indice en A): 6624, 647D, 988A, A2FA, 9D97, 644F, A593, 9A13, 9B59, 644F,
;   A662, 9AF9, 9BC5, A365, 9C0C, B7E7, 9CBF, 644F, 644F, 9C5B, 644F, BC0F,
;   644F, 644F, A495, 644F, A50B, 644F, B6FA, 644F, B91A, BA81, 644F, B6FA,
;   6474, 646B, 9FED, 9644, 644F, 644F, 644F, 644F, 644F, 96A1, 96A1, 644F,
;   96DE, 9FED, BAEC, 7461, 9644, 9359, 644F, 9632, 644F, 6462, 974E, 974E,
;   9811, 9811, 644F, 6450, 644F, 6450, 6459; lo leen p01:63CA (130 bytes)
;   0x63cd..0x644f  (130 bytes)
DATA_tabla_63CD:
	defw 06624h,0647dh,0988ah,0a2fah,09d97h,0644fh,0a593h,09a13h	; 63cd
	defw 09b59h,0644fh,0a662h,09af9h,09bc5h,0a365h,09c0ch,0b7e7h	; 63dd
	defw 09cbfh,0644fh,0644fh,09c5bh,0644fh,0bc0fh,0644fh,0644fh	; 63ed
	defw 0a495h,0644fh,0a50bh,0644fh,0b6fah,0644fh,0b91ah,0ba81h	; 63fd
	defw 0644fh,0b6fah,06474h,0646bh,09fedh,09644h,0644fh,0644fh	; 640d
	defw 0644fh,0644fh,0644fh,096a1h,096a1h,0644fh,096deh,09fedh	; 641d
	defw 0baech,07461h,09644h,09359h,0644fh,09632h,0644fh,06462h	; 642d
	defw 0974eh,0974eh,09811h,09811h,0644fh,06450h,0644fh,06450h	; 643d
	defw 06459h	; 644d  -> tipo_bc24

; ======================================================================
; CODIGO 0x644f..0x66c0  (625 bytes)
; ======================================================================


L_644F:
	ret			;644f
tipo_bf10:		; con el banco 11, p11:BF10
	call 04137h		;6450   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0bf10h		;6453
	jp 04157h		;6456   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_bc24:		; con el banco 11, p11:BC24
	call 04137h		;6459   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0bc24h		;645c
	jp 04157h		;645f   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_a644:		; con el banco 11, p11:A644
	call 04137h		;6462   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a644h		;6465
	jp 04157h		;6468   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_af36:		; con el banco 11, p11:AF36
	call 04137h		;646b   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0af36h		;646e
	jp 04157h		;6471   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_ac0c:		; con el banco 11, p11:AC0C
	call 04137h		;6474   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0ac0ch		;6477
	jp 04157h		;647a   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
tipo_b9a0:		; con el banco 11, p11:B9A0
	call 04137h		;647d   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b9a0h		;6480
	jp 04157h		;6483   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
enemigo_con_el_scroll:		; los que van con el mapa (IX+10 bit 3, o todos con 0xE3D0) se corren 8 pixeles con cada paso de scroll; al salir por la izquierda, fuera (C)
	ld a,(0e3d0h)		;6486   ; con 0xE3D0, todos con el scroll
	or a			;6489
	jr nz,L_6492		;648a
	ld a,(ix+010h)		;648c   ; si no, solo los de IX+10 bit 3
	and 008h		;648f
	ret z			;6491
L_6492:
	ld a,(0e320h)		;6492   ; solo si el scroll ha avanzado
	and a			;6495
	ret z			;6496
	ld a,(ix+006h)		;6497   ; 8 pixeles a la izquierda
	sub 008h		;649a
	ld (ix+006h),a		;649c
	ret nc			;649f   ; sigue en pantalla
	call suelta_e357		;64a0   ; ha salido: fuera
	call quita_enemigo		;64a3   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	scf			;64a6
	ret			;64a7
suelta_e357:		; los tipos 0x2C y 0x2D, y el 0x2F con IX+2A distinto de 1, ponen 0xE357 a cero al irse
	ld a,(ix+000h)		;64a8   ; los tipos 0x2C y 0x2D
	sub 02ch		;64ab
	cp 002h		;64ad
	jr c,L_64B9		;64af
	cp 003h		;64b1   ; y el 0x2F salvo con IX+2A = 1
	ret nz			;64b3
	ld a,(ix+02ah)		;64b4
	dec a			;64b7
	ret z			;64b8
L_64B9:
	xor a			;64b9
	ld (0e357h),a		;64ba   ; guarda la marca de los tipos 0x2C-0x2F
	ret			;64bd
enemigo_se_mueve:		; los que se mueven solos (IX+10 bit 2) suman su velocidad (con la capsula 5, cuadro si cuadro no); fuera de la pantalla, se quitan
	ld a,(0e439h)		;64be   ; con la capsula 5, cuadro si cuadro no
	cp 005h		;64c1
	jr nz,L_64CB		;64c3
	ld a,(0e1c3h)		;64c5   ; lee la cuenta de cuadros
	rra			;64c8
	jr c,L_64DA		;64c9
L_64CB:
	bit 2,(ix+010h)		;64cb   ; IX+10 bit 2: se mueve solo
	jr z,L_64DA		;64cf
	call suma_velocidad		;64d1   ; suma la velocidad; C: en pantalla
	ret c			;64d4
L_64D5:
	call quita_enemigo		;64d5   ; fuera de la pantalla: se quita
	or a			;64d8
	ret			;64d9
L_64DA:
	call en_pantalla		;64da   ; sin moverse, sigue en pantalla?
	ret c			;64dd
	jp L_64D5		;64de
suma_velocidad:		; IX+03/IX+04 (Y) + IX+07/IX+08 e IX+05/IX+06 (X) + IX+09/IX+0A; luego p01:64F3
	push ix		;64e1   ; HL = IX+03, DE = IX+07
	pop hl			;64e3
	inc l			;64e4
	inc l			;64e5
	inc l			;64e6
	ld d,h			;64e7
	ld e,l			;64e8
	inc e			;64e9
	inc e			;64ea
	inc e			;64eb
	inc e			;64ec
	call suma_16		;64ed   ; la Y: IX+03/IX+04 + IX+07/IX+08
	call suma_16		;64f0   ; la X: IX+05/IX+06 + IX+09/IX+0A
en_pantalla:		; C si IX+04 (Y) < 0xA8 (0xB0 el tipo 0x39) y IX+06 (X) < 0xF9
	ld a,(ix+000h)		;64f3
	ld c,0b0h		;64f6   ; el borde de abajo: 0xA8, o 0xB0 el tipo 0x39
	cp 039h		;64f8
	jr z,L_64FE		;64fa
	ld c,0a8h		;64fc
L_64FE:
	ld a,(ix+004h)		;64fe   ; Y por debajo del borde
	cp c			;6501
	ret nc			;6502
	ld a,(ix+006h)		;6503   ; X < 0xF9
	cp 0f9h		;6506
	ret			;6508
suma_16:		; (HL) + (DE) en 16 bits; los dos punteros avanzan 2
	ld a,(de)			;6509   ; el byte bajo
	add a,(hl)			;650a
	ld (hl),a			;650b
	inc l			;650c
	inc e			;650d
	ld a,(de)			;650e   ; el alto, con el acarreo
	adc a,(hl)			;650f
	ld (hl),a			;6510
	inc l			;6511
	inc e			;6512
	ret			;6513
quita_enemigo:		; quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld hl,0e352h		;6514   ; un enemigo menos
	dec (hl)			;6517
	ld l,(ix+000h)		;6518   ; su ficha de tipo: p00:4F45 + 7 x tipo
	ld h,000h		;651b
	ld e,l			;651d
	ld d,h			;651e
	add hl,hl			;651f
	add hl,hl			;6520
	add hl,hl			;6521
	or a			;6522
	sbc hl,de		;6523
	ld de,04f45h		;6525
	add hl,de			;6528
	ld a,(hl)			;6529
	bit 6,a		;652a   ; bit 6: de caracteres, sin sprites
	jr nz,L_6537		;652c
	and 03fh		;652e   ; devuelve sus sprites
	ld hl,0e355h		;6530   ; apunta a los sprites ocupados por enemigos (maximo 12)
	sub (hl)			;6533
	neg		;6534
	ld (hl),a			;6536
L_6537:
	ld a,(ix+000h)		;6537   ; el tipo 0x2A lleva cuenta aparte
	cp 02ah		;653a
	jr nz,L_6542		;653c
	ld hl,0e36dh		;653e   ; apunta a cuantos enemigos 0x2A hay
	dec (hl)			;6541
L_6542:
	ld (ix+000h),000h		;6542   ; la ficha, libre
	xor a			;6546
	ld (ix+00bh),a		;6547
	ld (ix+010h),a		;654a
	bit 0,(ix+016h)		;654d   ; IX+16 bit 0: de un grupo
	ret z			;6551
	ld a,(ix+017h)		;6552   ; el grupo IX+17 (p02:89A8)
	call 089a8h		;6555   ; busca_grupo: HL = el grupo A en 0xEA80 (4 de 3 bytes); C si no esta
	ret c			;6558
	inc l			;6559   ; uno menos en el grupo
	dec (hl)			;655a
	ret nz			;655b
	dec l			;655c   ; sin ninguno, el grupo libre
	ld (hl),000h		;655d
	ret			;655f
apariciones_de_torretas:		; lo que trae cada columna (p01:657C) hasta ponerse al dia (0xE358)
	call aparicion_de_tipo_1		;6560   ; aparicion_de_tipo_1: con los bancos 14-15, la siguiente ficha de p14:9554 de la fase: si es su columna, crea un tipo 1 en la fila del dato (bits 0-4), con C de los bits 6-7
	jr z,apariciones_de_torretas		;6563   ; Z: creado; a por el siguiente
	ret c			;6565   ; C: todavia no
	ld hl,0e358h		;6566   ; pasado: al siguiente
	inc (hl)			;6569
	jr apariciones_de_torretas		;656a
apariciones_del_scroll_1:		; si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	ld a,(0e320h)		;656c   ; lee la marca de scroll hecho en este cuadro
	and a			;656f
	ret z			;6570
	ld a,0f8h		;6571   ; por el borde derecho
	ld (0f004h),a		;6573   ; guarda variable de paso
L_6576:
	call aparicion_de_tipo_1		;6576   ; aparicion_de_tipo_1: con los bancos 14-15, la siguiente ficha de p14:9554 de la fase: si es su columna, crea un tipo 1 en la fila del dato (bits 0-4), con C de los bits 6-7
	jr z,L_6576		;6579
	ret			;657b
aparicion_de_tipo_1:		; con los bancos 14-15, la siguiente ficha de p14:9554 de la fase: si es su columna, crea un tipo 1 en la fila del dato (bits 0-4), con C de los bits 6-7
	call 0415bh		;657c   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e358h)		;657f   ; la siguiente de la fase en p14:9554
	ld hl,09554h		;6582
	call 04c32h		;6585   ; aparicion_de_fase: la ficha A (3 bytes [columna][dato]) de la lista HL de la fase: DE = su columna, C = el dato, y compara con la columna del scroll (Z llegada, C todavia no)
	push af			;6588
	call 04157h		;6589   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	pop af			;658c
	ret nz			;658d   ; no es su columna: fuera
	ld hl,0e358h		;658e   ; gastada
	inc (hl)			;6591
	ld b,c			;6592
	ld a,c			;6593   ; la fila: los bits 0-4 x 8
	and 01fh		;6594
	add a,a			;6596
	add a,a			;6597
	add a,a			;6598
	ld e,a			;6599
	ld a,(0f004h)		;659a   ; la X
	ld d,a			;659d
	xor a			;659e   ; C = 0, 1 (bit 6) o 2 (bits 6 y 7)
	bit 6,c		;659f
	jr z,L_65A9		;65a1
	inc a			;65a3
	bit 7,c		;65a4
	jr z,L_65A9		;65a6
	inc a			;65a8
L_65A9:
	ld c,a			;65a9
	ld a,001h		;65aa   ; y el tipo 1
	call 04d1eh		;65ac   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	xor a			;65af
	ret			;65b0
tipo_1_empieza:		; el tipo 1: 2 x 2, su espera de disparo, mira arriba o abajo y a un lado (IX+26, de IX+19) y su dibujo; en la fase 6 otro
	ld c,002h		;65b1   ; 2 x 2
	ld (ix+014h),c		;65b3
	ld (ix+013h),c		;65b6
	ld (ix+027h),000h		;65b9
	call espera_de_disparo		;65bd   ; la espera de disparo
	sra a		;65c0
	ld c,a			;65c2
	ld a,(0e358h)		;65c3   ; mas la aparicion & 3
	and 003h		;65c6
	add a,c			;65c8
	ld (ix+015h),a		;65c9
	ld c,(ix+019h)		;65cc   ; de IX+19: el lado al que mira (IX+26, de 0 a 3)
	xor a			;65cf
	bit 5,c		;65d0
	jr z,L_65D6		;65d2
	ld a,002h		;65d4
L_65D6:
	bit 6,c		;65d6
	jr nz,L_65DB		;65d8
	inc a			;65da
L_65DB:
	ld (ix+026h),a		;65db
	ld (ix+010h),00bh		;65de   ; IX+10 = 0x0B
	ld a,(0e201h)		;65e2   ; la fase 6 lo lleva distinto
	cp 006h		;65e5
	jp z,tipo_1_dibujo_fase_6		;65e7   ; tipo_1_dibujo_fase_6: el dibujo de p01:676C segun IX+26, abierto o no, y a que lado esta la nave
	ld c,000h		;65ea
	jr L_660A		;65ec
tipo_1_apunta:		; el angulo a la nave (p02:945B, 0xF018) en 5 pasos y el dibujo de p01:66D0 de la fase
	ld e,(ix+004h)		;65ee   ; desde su posicion
	ld d,(ix+006h)		;65f1
	call 0945bh		;65f4   ; p02:945B: el angulo a la nave en 0xF018
	ld a,(0f018h)		;65f7   ; lee el angulo calculado
	cp 080h		;65fa   ; a un lado, en valor absoluto
	jr c,L_6600		;65fc
	neg		;65fe
L_6600:
	ld bc,00505h		;6600   ; C = 5 - el angulo / 21: cinco dibujos
L_6603:
	sub 015h		;6603
	jr c,L_660A		;6605
	dec c			;6607
	djnz L_6603		;6608
L_660A:
	ld a,(ix+026h)		;660a   ; IX+26 x 12
	add a,a			;660d
	add a,a			;660e
	ld e,a			;660f
	add a,a			;6610
	add a,e			;6611
	ld hl,066d0h		;6612   ; + la fase en p01:66D0
	call 0407ah		;6615   ; hl_mas_a: HL = HL + A
	ld a,(0e201h)		;6618   ; lee la fase (0-11)
	call 0407ah		;661b   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;661e
	add a,c			;661f   ; mas el angulo: el dibujo
	ld (ix+032h),a		;6620
	ret			;6623
tipo_1:		; el tipo 1: cada 4 cuadros apunta a la nave y, si cae en su lado y no ha disparado nadie (0xE307), dispara (p02:938F)
	ld a,(0e201h)		;6624   ; la fase 6 tiene el suyo
	cp 006h		;6627
	jp z,tipo_1_fase_6		;6629   ; tipo_1_fase_6: el tipo 1 de la fase 6: se abre (IX+01) y dispara a los 4 cuadros si la nave esta en su lado
	dec (ix+015h)		;662c   ; la espera
	ld a,(ix+015h)		;662f
	and 003h		;6632   ; cada 4 cuadros
	ret nz			;6634
	call tipo_1_apunta		;6635   ; apunta
	ld a,(0f018h)		;6638   ; lee el angulo calculado
	bit 1,(ix+026h)		;663b   ; segun el lado al que mira
	jr nz,L_6648		;663f
	sub 010h		;6641   ; la nave no cae en su lado: nada
	cp 060h		;6643
	ret c			;6645
	jr L_664D		;6646
L_6648:
	sub 090h		;6648
	cp 060h		;664a
	ret c			;664c
L_664D:
	ld a,(ix+015h)		;664d   ; aun no toca disparar
	and a			;6650
	ret nz			;6651
	ld hl,0e307h		;6652   ; ya ha disparado alguien en este cuadro
	ld a,(hl)			;6655
	and a			;6656
	jr z,L_665E		;6657
	ld (ix+015h),001h		;6659   ; lo intenta en el siguiente
	ret			;665d
L_665E:
	ld e,(ix+004h)		;665e   ; dispara desde su posicion (p02:938F)
	ld d,(ix+006h)		;6661
	call 0938fh		;6664   ; dispara_bala: una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
espera_de_disparo:		; IX+15 = la espera entre disparos: p01:66C0[nivel], menos con escudo y en fases mas altas, minimo 12 (4 en las fases 0 y 7)
	ld hl,066c0h		;6667   ; la espera segun el nivel
	ld a,(0e206h)		;666a   ; si la fase mas alta es la 1, no pasa del nivel 2
	dec a			;666d
	ld a,(0e228h)		;666e   ; lee el nivel de dificultad
	jr nz,L_6679		;6671
	cp 002h		;6673
	jr c,L_6679		;6675
	ld a,002h		;6677
L_6679:
	call 0407ah		;6679   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;667c
	inc (ix+027h)		;667d   ; cada 4 disparos, el doble
	ld a,(ix+027h)		;6680
	and 003h		;6683
	jr nz,L_6689		;6685
	sla c		;6687
L_6689:
	ld a,(0e400h)		;6689   ; con escudo, 4 menos
	cp 002h		;668c
	ld a,c			;668e
	jr nz,L_6693		;668f
	sub 004h		;6691
L_6693:
	ld c,a			;6693
	ld a,(0e206h)		;6694   ; menos la fase mas alta / 4
	srl a		;6697
	srl a		;6699
	ld b,a			;669b
	ld a,c			;669c
	sub b			;669d
	jr nc,L_66A1		;669e
	xor a			;66a0
L_66A1:
	cp 00ch		;66a1   ; minimo 12
	jr nc,L_66A7		;66a3
	ld a,00ch		;66a5
L_66A7:
	ld c,a			;66a7
	ld a,(0e201h)		;66a8   ; en las fases 0 y 7, 8 menos (minimo 4)
	and a			;66ab
	jr z,L_66B2		;66ac
	cp 007h		;66ae
	jr nz,L_66BC		;66b0
L_66B2:
	ld a,c			;66b2
	sub 008h		;66b3
	cp 004h		;66b5
	jr nc,L_66BB		;66b7
	ld a,004h		;66b9
L_66BB:
	ld c,a			;66bb
L_66BC:
	ld (ix+015h),c		;66bc
	ret			;66bf

; ----------------------------------------------------------------------
; DATOS tabla_66C0: 16 bytes que p01:6667 lee con 0xE228 (con 0xE206 = 1, como
;   mucho el 2); lo leen p01:6679 (16 bytes)
;   0x66c0..0x66d0  (16 bytes)
DATA_tabla_66C0:
	defb 050h,040h,030h,028h,024h,022h,020h,01eh,01ch,01ah,018h,016h,014h,012h,010h,00ch	; 66c0  P@0($" .........

; ----------------------------------------------------------------------
; DATOS tabla_66D0: 4 filas de 12 bytes (IX+26 x 12 + fase) que p01:660A suma
;   a C para IX+32; lo leen p01:6615 (48 bytes)
;   0x66d0..0x6700  (48 bytes)
DATA_tabla_66D0:
	defb 041h,012h,000h,018h,018h,000h,064h,025h,018h,018h,018h,018h	; 66d0  A.....d%....
	defb 025h,000h,000h,051h,078h,000h,060h,03bh,078h,051h,051h,051h	; 66dc  %..Qx.`.xQQQ
	defb 003h,00ch,000h,06ch,06ch,000h,068h,02bh,06ch,06ch,06ch,06ch	; 66e8  ...ll.h+llll
	defb 031h,000h,000h,057h,04bh,000h,047h,031h,04bh,057h,057h,057h	; 66f4  1..WK.G1KWWW

; ======================================================================
; CODIGO 0x6700..0x676c  (108 bytes)
; ======================================================================


tipo_1_fase_6:		; el tipo 1 de la fase 6: se abre (IX+01) y dispara a los 4 cuadros si la nave esta en su lado
	ld hl,tipo_1_dibujo_fase_6		;6700   ; al acabar, el dibujo
	push hl			;6703
	ld a,(ix+001h)		;6704   ; IX+01: abierto (1) o cerrado
	dec a			;6707
	jr z,L_671A		;6708
	call nave_de_su_lado		;670a   ; la nave no esta de su lado: nada
	ret c			;670d
	dec (ix+015h)		;670e
	ret nz			;6711
	ld (ix+015h),008h		;6712   ; se abre en 8 cuadros
	inc (ix+001h)		;6716
	ret			;6719
L_671A:
	dec (ix+015h)		;671a   ; abierto: espera
	jr z,L_6732		;671d
	ld a,(ix+015h)		;671f
	cp 004h		;6722   ; a los 4 cuadros, dispara
	ret nz			;6724
	call nave_de_su_lado		;6725   ; nave_de_su_lado: C si la nave (0xE404) esta del lado al que mira (IX+26)
	ret c			;6728
	ld e,(ix+004h)		;6729
	ld d,(ix+006h)		;672c
	jp 0938fh		;672f   ; dispara_bala: una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
L_6732:
	call espera_de_disparo		;6732   ; y se cierra
	ld (ix+001h),000h		;6735
	ret			;6739
tipo_1_dibujo_fase_6:		; el dibujo de p01:676C segun IX+26, abierto o no, y a que lado esta la nave
	ld a,(ix+026h)		;673a   ; el dibujo segun el lado
	ld hl,0676ch		;673d
	call 0407ah		;6740   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;6743
	ld a,(ix+001h)		;6744   ; abierto: el siguiente
	and a			;6747
	jr z,L_674B		;6748
	inc c			;674a
L_674B:
	ld a,(0e406h)		;674b   ; y 2 mas si la nave esta a su derecha
	cp (ix+006h)		;674e
	ld a,c			;6751
	jr c,L_6756		;6752
	add a,002h		;6754
L_6756:
	ld (ix+032h),a		;6756
	ret			;6759
nave_de_su_lado:		; C si la nave (0xE404) esta del lado al que mira (IX+26)
	ld a,(0e404h)		;675a   ; la nave por encima o por debajo
	cp (ix+004h)		;675d
	ld a,(ix+026h)		;6760
	jr c,L_6768		;6763
	cp 002h		;6765
	ret			;6767
L_6768:
	cp 002h		;6768
	ccf			;676a
	ret			;676b

; ----------------------------------------------------------------------
; DATOS tabla_676C: 4 bytes que p01:673A lee con IX+26; lo leen p01:6740 (4
;   bytes)
;   0x676c..0x6770  (4 bytes)
DATA_tabla_676C:
	defb 064h,060h,068h,047h	; 676c

; ======================================================================
; CODIGO 0x6770..0x67af  (63 bytes)
; ======================================================================


dispara_al_acabar:		; IX+15 - 1 y, al llegar a 0, p01:6774
	dec (ix+015h)		;6770
	ret nz			;6773
dispara_si_puede:		; si nadie ha disparado este cuadro (0xE307), una bala a la nave (p02:938F) y la espera de nuevo al azar
	ld hl,0e307h		;6774   ; ya ha disparado alguien este cuadro
	ld a,(hl)			;6777
	and a			;6778
	jr z,L_6780		;6779
	ld (ix+015h),001h		;677b   ; lo intenta en el siguiente
	ret			;677f
L_6780:
	ld e,(ix+004h)		;6780
	ld d,(ix+006h)		;6783
	call 0938fh		;6786   ; una bala a la nave
	call 04e93h		;6789   ; la espera, al azar
	ld (ix+015h),a		;678c
	ret			;678f
cuadro_del_jefe:		; con un jefe (0xE340), un cuadro mas de pelea (0xE346, sin pasar de 0xFFFF) y lo de su tipo (p11, 5 tipos)
	ld a,(0e340h)		;6790   ; sin jefe, nada
	dec a			;6793
	ret m			;6794
	ld c,a			;6795
	ld hl,(0e346h)		;6796   ; un cuadro mas de pelea
	inc hl			;6799
	ld a,l			;679a
	or h			;679b
	jr nz,L_679F		;679c   ; sin pasar de 0xFFFF
	dec hl			;679e
L_679F:
	ld (0e346h),hl		;679f   ; guarda los cuadros de pelea con el jefe (16 bits) y el byte siguiente (16 bits)
	call 04137h		;67a2   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	ld a,c			;67a5
	call jefe_por_tipo		;67a6   ; por tipo de jefe
	jp 04157h		;67a9   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
jefe_por_tipo:		; la rutina del jefe A (5, p01:67AF, en el banco 11)
	call 04084h		;67ac   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_67AF: 5 destinos del despachador p00:4084 (call en p01:67AC, el
;   indice en A): A8B5, AC1D, AE29, AD29, AF72; lo leen p01:67AC (10 bytes)
;   0x67af..0x67b9  (10 bytes)
DATA_tabla_67AF:
	defw 0a8b5h,0ac1dh,0ae29h,0ad29h,0af72h	; 67af

; ======================================================================
; CODIGO 0x67b9..0x67c8  (15 bytes)
; ======================================================================


partes_del_jefe:		; si p01:6878 no da Z, con el banco 9, p01:67CE con C = 1
	call hay_jefe_con_partes		;67b9   ; hay_jefe_con_partes: NZ si hay jefe con partes: el 5 siempre, los demas si 0xEA00 no es cero
	ret z			;67bc
	call 04144h		;67bd   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld c,001h		;67c0
	call partes_del_jefe_c		;67c2   ; partes_del_jefe_c: las partes del jefe de 0xEA00 (y la segunda de 0xEA20 con el jefe 5)
	jp 04108h		;67c5   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)

; ----------------------------------------------------------------------
; DATOS tabla_67C8: 6 bytes que p01:67CE pasa a L_67EC (3 pares, destino
;   0xEA07); lo leen p01:67CE (6 bytes)
;   0x67c8..0x67ce  (6 bytes)
DATA_tabla_67C8:
	defb 006h,00dh,011h,026h,02dh,031h	; 67c8

; ======================================================================
; CODIGO 0x67ce..0x694a  (380 bytes)
; ======================================================================


partes_del_jefe_c:		; las partes del jefe de 0xEA00 (y la segunda de 0xEA20 con el jefe 5)
	ld hl,067c8h		;67ce
	ld de,0ea07h		;67d1
	ld a,(0ea00h)		;67d4   ; la primera parte (0xEA00)
	and a			;67d7
	call nz,tres_partes		;67d8   ; tres_partes: las 3 piezas del jefe: sitio de la tabla HL en la ficha DE, puestas (C = 1) o borradas
	ld a,(0e340h)		;67db   ; con el jefe 5, la segunda (0xEA20)
	cp 005h		;67de
	ret nz			;67e0
	ld a,(0ea20h)		;67e1   ; lee la segunda ficha del jefe (el 5)
	and a			;67e4
	ret z			;67e5
	ld hl,067cbh		;67e6
	ld de,0ea27h		;67e9
tres_partes:		; las 3 piezas del jefe: sitio de la tabla HL en la ficha DE, puestas (C = 1) o borradas
	ld b,003h		;67ec   ; tres piezas
L_67EE:
	push bc			;67ee
	ld a,(de)			;67ef   ; la pieza
	push de			;67f0
	ld e,(hl)			;67f1   ; su sitio en la ficha
	inc hl			;67f2
	ld d,000h		;67f3
	push hl			;67f5
	ld hl,0ea00h		;67f6   ; apunta a la ficha del jefe
	add hl,de			;67f9
	bit 0,c		;67fa   ; C = 1: ponerla; 0: borrarla
	jr z,L_6803		;67fc
	call pon_parte		;67fe   ; pon_parte: la pieza del jefe en la pantalla de RAM (copia_bloque), si existe y cabe
	jr L_6806		;6801
L_6803:
	call borra_parte		;6803   ; borra_parte: borra la pieza del jefe de la pantalla de RAM, si existe y cabe
L_6806:
	pop hl			;6806   ; la pieza siguiente
	pop de			;6807
	inc de			;6808
	pop bc			;6809
	djnz L_67EE		;680a
	ret			;680c
pon_parte:		; la pieza del jefe en la pantalla de RAM (copia_bloque), si existe y cabe
	and a			;680d   ; negativa: no hay pieza
	ret m			;680e
	call sitio_de_la_parte		;680f   ; sitio_de_la_parte: la pieza A de p09:BB01: C filas, B de ancho, DE los caracteres, y su sitio (p01:6841); C si no se pinta
	ret c			;6812
	jp 05327h		;6813   ; copia_bloque: copia DE en la pantalla de RAM en H (X), L (Y): C filas de B (de A de ancho en origen), cortado por el borde
sitio_de_la_parte:		; la pieza A de p09:BB01: C filas, B de ancho, DE los caracteres, y su sitio (p01:6841); C si no se pinta
	push hl			;6816
	ld de,0bb01h		;6817   ; la ficha de la pieza en p09:BB01
	call 04b60h		;681a   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ex de,hl			;681d
	ld c,(hl)			;681e   ; C = filas, B = ancho
	inc hl			;681f
	ld b,(hl)			;6820
	inc hl			;6821
	ex de,hl			;6822
	pop hl			;6823
	jr recorta_parte		;6824
quita_partes_del_jefe:		; si hay jefe con partes, con el banco 9 las borra (C = 0) y vuelve a poner las estrellas
	call hay_jefe_con_partes		;6826   ; sin jefe con partes, nada
	ret z			;6829
	call 04144h		;682a   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld c,000h		;682d   ; C = 0: borrar
	call partes_del_jefe_c		;682f   ; partes_del_jefe_c: las partes del jefe de 0xEA00 (y la segunda de 0xEA20 con el jefe 5)
	call 04108h		;6832   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	jp 049a5h		;6835   ; y las estrellas en su sitio
borra_parte:		; borra la pieza del jefe de la pantalla de RAM, si existe y cabe
	and a			;6838
	ret m			;6839
	call sitio_de_la_parte		;683a   ; sitio_de_la_parte: la pieza A de p09:BB01: C filas, B de ancho, DE los caracteres, y su sitio (p01:6841); C si no se pinta
	ret c			;683d
	jp 0530ch		;683e   ; borra_bloque: borra C filas de B caracteres en la pantalla de RAM en H (X), L (Y), cortado por el borde
recorta_parte:		; HL = el sitio de la pieza segun su ficha (C si no se ve); si asoma por la izquierda, recorta columnas
	ld a,(hl)			;6841   ; la X alta: fuera de la pantalla
	and a			;6842
	scf			;6843
	ret nz			;6844
	dec l			;6845   ; la X
	dec l			;6846
	ld a,(hl)			;6847
	dec l			;6848
	and a			;6849
	jr z,L_6871		;684a   ; dentro de la pantalla
	scf			;684c   ; demasiado a la derecha
	ret p			;684d
	ld a,(hl)			;684e   ; asoma por la izquierda: cuantas columnas faltan (negativo)
	rra			;684f
	rra			;6850
	rra			;6851
	or 0e0h		;6852
	ld (0f000h),a		;6854   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	add a,c			;6857   ; las filas que quedan
	ld c,a			;6858
	scf			;6859
	ret z			;685a
	ret m			;685b
	ld a,(0f000h)		;685c   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
L_685F:
	ex af,af'			;685f   ; salta en el origen las columnas que no se ven
	ld a,b			;6860
	add a,e			;6861
	ld e,a			;6862
	jr nc,L_6866		;6863
	inc d			;6865
L_6866:
	ex af,af'			;6866
	inc a			;6867
	jr nz,L_685F		;6868
	inc l			;686a   ; H = la Y, L = 0
	inc l			;686b
	ld h,(hl)			;686c
	ld l,000h		;686d
	xor a			;686f
	ret			;6870
L_6871:
	ld a,(hl)			;6871   ; L = X, H = Y
	inc l			;6872
	inc l			;6873
	ld h,(hl)			;6874
	ld l,a			;6875
	xor a			;6876
	ret			;6877
hay_jefe_con_partes:		; NZ si hay jefe con partes: el 5 siempre, los demas si 0xEA00 no es cero
	ld a,(0e340h)		;6878   ; sin jefe, Z
	and a			;687b
	ret z			;687c
	cp 005h		;687d   ; el 5 siempre tiene
	jr z,L_6886		;687f
	ld a,(0ea00h)		;6881   ; los demas, si su ficha esta en uso
	and a			;6884
	ret			;6885
L_6886:
	or a			;6886
	ret			;6887
nave_de_salida:		; 0xE400-0xE40E de p01:6962 y 0xE430-0xE438 de p01:6971; en la fase 8, X = 0x50
	ld hl,06962h		;6888   ; la nave
	ld de,0e400h		;688b   ; apunta a la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ld bc,0000fh		;688e
	ldir		;6891
	ld hl,06971h		;6893   ; y sus armas
	ld de,0e430h		;6896   ; apunta a el disparo normal
	ld bc,00009h		;6899
	ldir		;689c
	ld a,(0e201h)		;689e   ; lee la fase (0-11)
	cp 008h		;68a1
	ret nz			;68a3
	ld a,050h		;68a4   ; en el interior, X = 0x50
	ld (0e406h),a		;68a6
	ret			;68a9
nivel_de_la_fase:		; el nivel (0xE228) = la fase mas alta / 2, como mucho 15
	ld a,(0e206h)		;68aa   ; la fase mas alta / 2
	srl a		;68ad
	cp 00fh		;68af
	jr c,L_68B5		;68b1
	ld a,00fh		;68b3   ; como mucho 15
L_68B5:
	ld (0e228h),a		;68b5   ; guarda el nivel de dificultad
	ret			;68b8
borra_la_fase:		; 0xE22C, 0xE300, 0xEAA8-0xEAB7, 0xE340-0xE3FF y 0xE500-0xECFF a cero; luego p01:68E4
	xor a			;68b9
	ld (0e22ch),a		;68ba   ; guarda la marca de volver a la fase de p01:7C59
	ld (0e300h),a		;68bd   ; guarda la marca de 0xE300
	ld hl,0eaa8h		;68c0   ; 0xEAA8-0xEAB7
	ld de,0eaa9h		;68c3
	ld bc,0000fh		;68c6
	ld (hl),a			;68c9
	ldir		;68ca
	ld hl,0e340h		;68cc   ; 0xE340-0xE3FF
	ld de,0e341h		;68cf   ; apunta a el estado del jefe
	ld bc,000bfh		;68d2
	ld (hl),a			;68d5
	ldir		;68d6
	ld hl,0e500h		;68d8   ; 0xE500-0xECFF
	ld de,0e501h		;68db
	ld bc,007ffh		;68de
	ld (hl),a			;68e1
	ldir		;68e2
datos_de_la_fase:		; las cuentas de aparicion, 0xE305 (p01:697A), los limites del mapa (p01:6986), la columna de salida (p01:694A, 0x20 o 0x60 en la demo) y el ritmo del scroll
	xor a			;68e4   ; sin cuenta atras
	ld (0e1d5h),a		;68e5   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	ld (0e369h),a		;68e8   ; las apariciones de piezas desde la primera
	inc a			;68eb   ; las demas cuentas desde 1
	ld (0e35ch),a		;68ec
	ld (0e376h),a		;68ef
	ld (0e36eh),a		;68f2
	ld (0e365h),a		;68f5
	ld a,(0e201h)		;68f8   ; el dato de la fase
	ld hl,0697ah		;68fb
	call 05ca6h		;68fe   ; byte_a: A = el byte A de la tabla HL
	ld (0e305h),a		;6901   ; guarda dato de la fase de p01:697A
	xor a			;6904   ; sin fin de scroll
	ld (0e327h),a		;6905   ; guarda la marca de fin del scroll
	ld a,(0e201h)		;6908   ; 6 bytes por fase: los limites del mapa
	add a,a			;690b
	ld c,a			;690c
	add a,a			;690d
	add a,c			;690e
	ld hl,06986h		;690f
	call 0407ah		;6912   ; hl_mas_a: HL = HL + A
	ld de,0e321h		;6915   ; a 0xE321-0xE326
	ld bc,00006h		;6918
	ldir		;691b
	ld a,(0e201h)		;691d   ; el punto de control de la fase
	ld hl,0694ah		;6920
	call 04b67h		;6923   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,(0e203h)		;6926   ; si ya se habia pasado, se sale de alli
	rst 20h			;6929
	jr nc,L_6938		;692a
	ld de,00020h		;692c   ; si no, de la columna 32
	ld a,(0e1c2h)		;692f   ; lee el modo: bit 6 se juega, bit 5 dos jugadores, bit 7 juega el 2
	bit 6,a		;6932
	jr nz,L_6938		;6934
	ld e,060h		;6936   ; o de la 96 en la demo
L_6938:
	ld (0e203h),de		;6938   ; guarda la columna del scroll (16 bits) y el byte siguiente (16 bits)
	xor a			;693c
	ld (0e205h),a		;693d   ; guarda el paso del guion de la fase
	inc a			;6940   ; el ritmo del scroll
	ld (0e202h),a		;6941   ; guarda el ritmo del scroll (un bit que rota cada cuadro)
	ld a,040h		;6944
	ld (0e354h),a		;6946   ; guarda 0x40 al empezar la fase
	ret			;6949

; ----------------------------------------------------------------------
; DATOS tabla_694A: 12 palabras, una por fase, que p01:6920 lee con L_4B67; lo
;   leen p01:6923 (24 bytes)
;   0x694a..0x6962  (24 bytes)
DATA_tabla_694A:
	defw 00110h,00110h,00100h,00100h,00100h,000f4h	; 694a
	defw 000e8h,001dfh,00fffh,00fffh,00fffh,00fffh	; 6956

; ----------------------------------------------------------------------
; DATOS inicio_E400: 15 bytes que p01:6888 copia a 0xE400; lo leen p01:6888
;   (15 bytes)
;   0x6962..0x6971  (15 bytes)
DATA_inicio_E400:
	defb 001h,000h,000h,000h,04ah,000h,050h,000h,00fh,004h,008h,000h,000h,000h,000h	; 6962  ....J.P........

; ----------------------------------------------------------------------
; DATOS inicio_E430: 9 bytes que p01:6893 copia a 0xE430; lo leen p01:6893 (9
;   bytes)
;   0x6971..0x697a  (9 bytes)
DATA_inicio_E430:
	defb 002h,000h,000h,000h,000h,000h,000h,000h,000h	; 6971  .........

; ----------------------------------------------------------------------
; DATOS tabla_697A: 12 bytes, uno por fase, que p01:68F8 pone en 0xE305; lo
;   leen p01:68FE (12 bytes)
;   0x697a..0x6986  (12 bytes)
DATA_tabla_697A:
	defb 0c5h,0bdh,0b3h,0a1h,0aah,0a0h,090h,0c7h,09dh,0a1h,0a1h,0a1h	; 697a  ............

; ----------------------------------------------------------------------
; DATOS limites_por_fase: 12 fichas de 6 bytes, una por fase, que p01:6908
;   copia a 0xE321 (los limites del scroll que mira p00:4889); lo leen
;   p01:6912 (72 bytes)
;   0x6986..0x69ce  (72 bytes)
DATA_limites_por_fase:
	defb 000h,000h,0c0h,001h,0bfh,001h	; 6986
	defb 080h,000h,0c0h,001h,0dfh,001h	; 698c
	defb 080h,000h,0e0h,001h,0ffh,001h	; 6992
	defb 060h,000h,0e0h,001h,0ffh,001h	; 6998
	defb 080h,000h,000h,002h,0ffh,001h	; 699e
	defb 080h,000h,0a0h,001h,09fh,001h	; 69a4
	defb 060h,000h,0c0h,001h,0bfh,001h	; 69aa
	defb 060h,000h,0e0h,002h,0dfh,002h	; 69b0
	defb 000h,000h,0c0h,000h,09fh,000h	; 69b6
	defb 020h,000h,040h,001h,05fh,001h	; 69bc
	defb 020h,000h,040h,001h,05fh,001h	; 69c2
	defb 020h,000h,040h,001h,05fh,001h	; 69c8

; ======================================================================
; CODIGO 0x69ce..0x6b7c  (430 bytes)
; ======================================================================


caracteres_a16d:		; con el banco 9, la lista p09:A16D y sus copias (p09:A174 espejo, p09:A187 cabeza abajo); luego p01:69EF
	call 04144h		;69ce   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld ix,0a16dh		;69d1   ; la lista p09:A16D
	call 04595h		;69d5   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;69d8   ; sus copias en espejo
	ld (0f000h),a		;69d9   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a174h		;69dc
	call 0454eh		;69e0   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	ld a,001h		;69e3   ; y cabeza abajo
	ld (0f000h),a		;69e5   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a187h		;69e8
	call 0454eh		;69ec   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
borra_e600_y_banco_10:		; vacia 0xE600-0xE9FF, pone los bancos 1-2-3 y el 10 en 0xA000
	call 04b43h		;69ef   ; borra_e600: pone a cero 0xE600-0xE9FF
bancos_1_2_3_y_10:		; los bancos 1-2-3 y el 10 en 0xA000
	call 04108h		;69f2   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	jp 04133h		;69f5   ; banco_10: pone el banco 10 en 0xA000 (y 0xF0F3)
caracteres_a18b:		; con el banco 9, la lista p09:A18B y sus copias p09:A204; luego p01:69EF
	call 04144h		;69f8   ; banco_9: pone el banco 9 en 0xA000 (y 0xF0F3)
	ld ix,0a18bh		;69fb   ; la lista p09:A18B
	call 04595h		;69ff   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	xor a			;6a02   ; y sus copias en espejo
	ld (0f000h),a		;6a03   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld ix,0a204h		;6a06
	call 0454eh		;6a0a   ; copia_caracteres: lista de copias VRAM -> VRAM de IX (4 bytes, o 3 si el tercero lleva los bits altos; 0 acaba), dadas la vuelta segun 0xF000 (0 espejo, 1 cabeza abajo)
	jr borra_e600_y_banco_10		;6a0d
caracteres_b223:		; con el banco 12, la lista p12:B223; luego p01:69EF
	call 0413bh		;6a0f   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld ix,0b223h		;6a12
	call 04595h		;6a16   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	jr borra_e600_y_banco_10		;6a19
caracteres_ac44:		; con el banco 12, la lista p12:AC44; luego p01:69EF
	call 0413bh		;6a1b   ; banco_12: pone el banco 12 en 0xA000 (y 0xF0F3)
	ld ix,0ac44h		;6a1e
	call 04595h		;6a22   ; pon_caracteres: pinta la lista de caracteres IX: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba
	jr borra_e600_y_banco_10		;6a25
anima_el_fondo:		; sin jefe, un caracter animado de la fase (p09:B901): fichas de 10 bytes [caracter][tercios][8 bytes], una por cuadro (0xE3BB)
	ld a,(0e340h)		;6a27   ; con jefe no
	or a			;6a2a
	ret nz			;6a2b
	ld a,(0e3aah)		;6a2c   ; ni con 0xE3AA
	and a			;6a2f
	ret nz			;6a30
	ld a,(0e201h)		;6a31   ; lee la fase (0-11)
	ld b,a			;6a34
	cp 009h		;6a35   ; ni de la fase 9 en adelante
	ret nc			;6a37
	ld c,00fh		;6a38   ; la fase 4, cada 16 cuadros
	cp 004h		;6a3a
	jr z,L_6A45		;6a3c
	ld c,003h		;6a3e   ; las 1-7 cada cuadro; la 0 y la 8 cada 4
	dec a			;6a40
	cp 007h		;6a41
	jr c,L_6A4A		;6a43
L_6A45:
	ld a,(0e1c3h)		;6a45   ; lee la cuenta de cuadros
	and c			;6a48
	ret nz			;6a49
L_6A4A:
	ld a,(0e201h)		;6a4a   ; lee la fase (0-11)
	ld de,0b901h		;6a4d   ; la lista de la fase en p09:B901
	call 04b60h		;6a50   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ex de,hl			;6a53
	ld a,l			;6a54
	or h			;6a55
	ret z			;6a56   ; sin lista, nada
	ld a,(hl)			;6a57   ; [bit 7: dibujos o colores][cuantos pasos]
	ld (0f000h),a		;6a58   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	and 07fh		;6a5b
	ld c,a			;6a5d
	inc hl			;6a5e
	ld a,(0e3bbh)		;6a5f   ; el paso siguiente
	inc a			;6a62
	cp c			;6a63
	jr c,L_6A67		;6a64
	xor a			;6a66   ; vuelta al primero
L_6A67:
	ld (0e3bbh),a		;6a67   ; guarda el paso del caracter animado del fondo
	push hl			;6a6a
	ld l,a			;6a6b   ; 10 bytes por paso
	ld h,000h		;6a6c
	add hl,hl			;6a6e
	ld c,l			;6a6f
	ld b,h			;6a70
	add hl,hl			;6a71
	add hl,hl			;6a72
	add hl,bc			;6a73
	ld c,l			;6a74
	ld b,h			;6a75
	pop hl			;6a76
	add hl,bc			;6a77
	ld a,(hl)			;6a78   ; el caracter
	ex de,hl			;6a79
	inc de			;6a7a
	ld l,a			;6a7b
	ld a,(0f000h)		;6a7c   ; bit 7: colores (0x0000); si no, dibujos (0x2000)
	add a,a			;6a7f
	ld h,004h		;6a80
	jr nc,L_6A86		;6a82
	ld h,000h		;6a84
L_6A86:
	add hl,hl			;6a86   ; caracter x 8
	add hl,hl			;6a87
	add hl,hl			;6a88
	ld a,(00007h)		;6a89   ; el puerto del VDP
	ld c,a			;6a8c
	ld a,(de)			;6a8d   ; los tercios en los que va (bits 0-2)
	inc de			;6a8e
	exx			;6a8f
	ld b,003h		;6a90
	ld e,a			;6a92
L_6A93:
	rr e		;6a93   ; el siguiente tercio
	exx			;6a95
	jr nc,L_6AA7		;6a96
	call 00053h		;6a98   ; BIOS SETWRT - Enables VDP to write | los 8 bytes del paso
	push de			;6a9b
	push hl			;6a9c
	ex de,hl			;6a9d
	ld b,008h		;6a9e
L_6AA0:
	outi		;6aa0
	jp nz,L_6AA0		;6aa2
	pop hl			;6aa5
	pop de			;6aa6
L_6AA7:
	ld a,008h		;6aa7   ; al tercio siguiente (0x800)
	add a,h			;6aa9
	ld h,a			;6aaa
	exx			;6aab
	djnz L_6A93		;6aac
	ret			;6aae
fase_de_piezas:		; C en las fases 3, 9, 10 y 11
	ld a,(0e201h)		;6aaf   ; fase 3
	sub 003h		;6ab2
	cp 001h		;6ab4
	ret c			;6ab6
	sub 006h		;6ab7   ; o fases 9-11
	cp 003h		;6ab9
	ret			;6abb
apariciones_de_piezas:		; en las fases 3 y 9-11, lo que trae cada columna (p01:6AE0) hasta ponerse al dia (0xE369)
	call fase_de_piezas		;6abc   ; fase_de_piezas: C en las fases 3, 9, 10 y 11
	ret nc			;6abf
L_6AC0:
	call apariciones_de_piezas_columna		;6ac0   ; apariciones_de_piezas_columna: p01:6AE0 hasta que no quede ninguna en la columna
	jr z,L_6AC0		;6ac3   ; Z: creada; a por la siguiente
	ret c			;6ac5   ; C: todavia no
	ld hl,0e369h		;6ac6   ; pasada: la siguiente
	inc (hl)			;6ac9
	jr L_6AC0		;6aca
apariciones_de_piezas_scroll:		; si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	call fase_de_piezas		;6acc   ; fase_de_piezas: C en las fases 3, 9, 10 y 11
	ret nc			;6acf
	ld a,(0e320h)		;6ad0   ; lee la marca de scroll hecho en este cuadro
	and a			;6ad3
	ret z			;6ad4
	ld a,0f8h		;6ad5   ; por el borde derecho
	ld (0f004h),a		;6ad7   ; guarda variable de paso
apariciones_de_piezas_columna:		; p01:6AE0 hasta que no quede ninguna en la columna
	call aparicion_de_pieza		;6ada   ; aparicion_de_pieza: con los bancos 14-15, la siguiente ficha de 3 bytes de la fase (p15:A2AC o p01:6B7F): si es su columna, una pieza libre de 0xE580 con su clase, Y, X y rapidez
	jr z,apariciones_de_piezas_columna		;6add
	ret			;6adf
aparicion_de_pieza:		; con los bancos 14-15, la siguiente ficha de 3 bytes de la fase (p15:A2AC o p01:6B7F): si es su columna, una pieza libre de 0xE580 con su clase, Y, X y rapidez
	call 0415bh		;6ae0   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld hl,0a2ach		;6ae3   ; la fase 3: p15:A2AC
	ld a,(0e201h)		;6ae6   ; lee la fase (0-11)
	cp 003h		;6ae9
	jr z,L_6AF6		;6aeb
	sub 009h		;6aed   ; las 9-11: p01:6B7F
	ld hl,06b7fh		;6aef
	call 04b67h		;6af2   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;6af5
L_6AF6:
	ld a,(0e369h)		;6af6   ; 3 bytes por ficha
	ld c,a			;6af9
	add a,a			;6afa
	add a,c			;6afb
	call 0407ah		;6afc   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;6aff   ; la columna: un byte y el bit 0 del siguiente
	inc hl			;6b00
	ld a,(hl)			;6b01
	and 001h		;6b02
	ld d,a			;6b04
	inc hl			;6b05
	ld (0f005h),hl		;6b06   ; 0xF005 = el resto de la ficha
	ld hl,(0e203h)		;6b09   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;6b0c   ; no es su columna: fuera
	jp nz,04108h		;6b0d   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	ld hl,0e369h		;6b10   ; gastada
	inc (hl)			;6b13
	ld hl,0e580h		;6b14   ; 16 piezas de 8 bytes
	ld b,010h		;6b17
	ld de,00008h		;6b19
	xor a			;6b1c
L_6B1D:
	cp (hl)			;6b1d   ; la primera libre
	jr z,L_6B25		;6b1e
	add hl,de			;6b20
	djnz L_6B1D		;6b21
	xor a			;6b23   ; ninguna libre
	ret			;6b24
L_6B25:
	ex de,hl			;6b25
	ld hl,(0f005h)		;6b26   ; lee variable de paso: el puntero de la ficha y el byte siguiente (16 bits)
	push hl			;6b29
	ldi		;6b2a   ; [clase]
	xor a			;6b2c
	dec hl			;6b2d
	dec hl			;6b2e
	bit 1,(hl)		;6b2f   ; [0x80, o 0 con el bit 1]
	jr nz,L_6B35		;6b31
	ld a,080h		;6b33
L_6B35:
	ld (de),a			;6b35
	inc e			;6b36
	ld a,(hl)			;6b37   ; [Y]: los bits 3-7
	and 0f8h		;6b38
	ld (de),a			;6b3a
	inc e			;6b3b
	ld a,(0f004h)		;6b3c   ; [X]
	ld (de),a			;6b3f
	inc e			;6b40
	pop hl			;6b41
	ld a,(hl)			;6b42   ; dos bytes de p15:A561 por clase
	add a,a			;6b43
	ld hl,0a561h		;6b44
	call 0407ah		;6b47   ; hl_mas_a: HL = HL + A
	ldi		;6b4a
	ldi		;6b4c
	ex de,hl			;6b4e
	ld de,(0f005h)		;6b4f   ; lee variable de paso: el puntero de la ficha y el byte siguiente (16 bits)
	ld a,(de)			;6b53   ; la rapidez: 0x10 las clases 0-4
	sub 005h		;6b54
	jr c,L_6B75		;6b56
	cp 006h		;6b58   ; las demas, de p01:6B7C por clase (5-10 y 11-13)
	jr c,L_6B5E		;6b5a
	sub 006h		;6b5c
L_6B5E:
	push hl			;6b5e
	ld hl,06b7ch		;6b5f
	call 0407ah		;6b62   ; hl_mas_a: HL = HL + A
	ld b,(hl)			;6b65
	pop hl			;6b66
	ld a,(0e228h)		;6b67   ; 4 mas del nivel 6 en adelante
	cp 006h		;6b6a
	jr c,L_6B72		;6b6c
	ld a,b			;6b6e
	add a,004h		;6b6f
	ld b,a			;6b71
L_6B72:
	ld (hl),b			;6b72
	jr L_6B77		;6b73
L_6B75:
	ld (hl),010h		;6b75
L_6B77:
	inc l			;6b77
	ld (hl),004h		;6b78   ; y el ultimo byte, 4
	xor a			;6b7a
	ret			;6b7b

; ----------------------------------------------------------------------
; DATOS tabla_6B7C: 3 bytes que p01:6B5E lee con el indice de 0 a 2; lo leen
;   p01:6B62 (3 bytes)
;   0x6b7c..0x6b7f  (3 bytes)
DATA_tabla_6B7C:
	defb 004h,008h,00ch	; 6b7c

; ----------------------------------------------------------------------
; DATOS tabla_6B7F: 3 punteros (fases 9, 10 y 11) al banco 15 que p01:6AED lee
;   con fase - 9 (la 3 usa 0xA2AC); lo leen p01:6AF2 (6 bytes)
;   0x6b7f..0x6b85  (6 bytes)
DATA_tabla_6B7F:
	defw 0a362h,0a41eh,0a4cbh	; 6b7f

; ======================================================================
; CODIGO 0x6b85..0x6bef  (106 bytes)
; ======================================================================


mueve_piezas:		; sin jefe con partes, en las fases 3 y 9-11, las 16 piezas de 0xE580 (p01:6BA4)
	call hay_jefe_con_partes		;6b85   ; hay_jefe_con_partes: NZ si hay jefe con partes: el 5 siempre, los demas si 0xEA00 no es cero
	ret nz			;6b88
	call fase_de_piezas		;6b89   ; fase_de_piezas: C en las fases 3, 9, 10 y 11
	ret nc			;6b8c
	ld ix,0e580h		;6b8d   ; 16 piezas de 8 bytes
	ld b,010h		;6b91
L_6B93:
	push bc			;6b93
	ld a,(ix+000h)		;6b94
	or a			;6b97
	call nz,mueve_pieza		;6b98   ; mueve_pieza: si sigue en pantalla (p01:6C34): las clases 0-4 por paso (IX+01), las 5-10 y 11-13 cambian de clase al llegar al borde izquierdo
	ld bc,00008h		;6b9b   ; la siguiente
	add ix,bc		;6b9e
	pop bc			;6ba0
	djnz L_6B93		;6ba1
	ret			;6ba3
mueve_pieza:		; si sigue en pantalla (p01:6C34): las clases 0-4 por paso (IX+01), las 5-10 y 11-13 cambian de clase al llegar al borde izquierdo
	call pieza_con_el_scroll		;6ba4   ; fuera de la pantalla: se quita (C)
	ret c			;6ba7
	ld a,(0e439h)		;6ba8   ; con la capsula 5, cuadro si cuadro no
	cp 005h		;6bab
	jr nz,L_6BB4		;6bad
	ld a,(0e1c3h)		;6baf   ; lee la cuenta de cuadros
	rra			;6bb2
	ret nc			;6bb3
L_6BB4:
	ld a,(ix+000h)		;6bb4   ; las clases 0-4 van por pasos
	cp 005h		;6bb7
	jr c,L_6BE7		;6bb9
	cp 00bh		;6bbb   ; las 5-10
	jr nc,L_6BCD		;6bbd
	ld b,008h		;6bbf
	call pieza_al_borde		;6bc1   ; pieza_al_borde: por debajo de la clase B, al llegar a X < 4 pasa a la clase + 3 y suena 0x24
	ld a,(ix+001h)		;6bc4   ; en el paso 1
	and 07fh		;6bc7
	dec a			;6bc9
	jr z,$+62		;6bca
	ret			;6bcc
L_6BCD:
	ld b,00eh		;6bcd   ; las 11-13
pieza_al_borde:		; por debajo de la clase B, al llegar a X < 4 pasa a la clase + 3 y suena 0x24
	ld a,(ix+000h)		;6bcf
	cp b			;6bd2
	ret nc			;6bd3
	ld a,(ix+006h)		;6bd4   ; aun no ha llegado al borde izquierdo
	cp 004h		;6bd7
	ret nc			;6bd9
	ld a,(ix+000h)		;6bda   ; cambia de clase
	add a,003h		;6bdd
	ld (ix+000h),a		;6bdf
	ld a,024h		;6be2   ; y suena 0x24
	jp 04ae4h		;6be4   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_6BE7:
	ld a,(ix+001h)		;6be7   ; el paso IX+01
	and 07fh		;6bea
	call 04084h		;6bec   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_6BEF: 4 destinos del despachador p00:4084 (call en p01:6BEC, el
;   indice en A): 6BF7, 6C07, 6C08, 6C33; lo leen p01:6BEC (8 bytes)
;   0x6bef..0x6bf7  (8 bytes)
DATA_tabla_6BEF:
	defw 06bf7h,06c07h,06c08h,06c33h	; 6bef  -> L_6BF7 L_6C07 L_6C08 L_6C33

; ======================================================================
; CODIGO 0x6bf7..0x6c96  (159 bytes)
; ======================================================================


L_6BF7:
	ld a,(ix+005h)		;6bf7   ; el ancho x 8
	add a,a			;6bfa
	add a,a			;6bfb
	add a,a			;6bfc
	ld b,a			;6bfd
	xor a			;6bfe   ; lo que le queda para salir por la izquierda
	sub (ix+003h)		;6bff
	cp b			;6c02
	ret c			;6c03
	inc (ix+001h)		;6c04   ; al paso siguiente
L_6C07:
	ret			;6c07
L_6C08:
	dec (ix+007h)		;6c08   ; cada 4 cuadros
	ret nz			;6c0b
	ld (ix+007h),004h		;6c0c
	ld l,(ix+002h)		;6c10   ; su sitio en la pantalla de RAM
	ld h,(ix+003h)		;6c13
	call 05c92h		;6c16   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld b,(ix+005h)		;6c19   ; su ancho, recortado por la derecha
	ld a,l			;6c1c
	and 01fh		;6c1d
	sub 020h		;6c1f
	jr c,L_6C26		;6c21
	neg		;6c23
	ld b,a			;6c25
L_6C26:
	xor a			;6c26   ; borra su fila de arriba
L_6C27:
	ld (hl),a			;6c27
	inc l			;6c28
	djnz L_6C27		;6c29
	ld a,(ix+002h)		;6c2b   ; y baja 8 pixeles
	add a,008h		;6c2e
	ld (ix+002h),a		;6c30
L_6C33:
	ret			;6c33
pieza_con_el_scroll:		; con cada paso de scroll, X - 8; al salir por la izquierda, libre (C)
	ld a,(0e320h)		;6c34   ; lee la marca de scroll hecho en este cuadro
	and a			;6c37
	ret z			;6c38
	ld a,(ix+003h)		;6c39   ; 8 pixeles a la izquierda
	sub 008h		;6c3c
	ld (ix+003h),a		;6c3e
	ret nc			;6c41   ; sigue en pantalla
	ld (ix+000h),000h		;6c42   ; se ha ido
	scf			;6c46
	ret			;6c47
caen_las_piezas:		; sin jefe con partes, en las fases 3 y 9-11, las 16 piezas de 0xE580 (p01:6C67)
	call hay_jefe_con_partes		;6c48   ; hay_jefe_con_partes: NZ si hay jefe con partes: el 5 siempre, los demas si 0xEA00 no es cero
	ret nz			;6c4b
	call fase_de_piezas		;6c4c   ; fase_de_piezas: C en las fases 3, 9, 10 y 11
	ret nc			;6c4f
	ld ix,0e580h		;6c50   ; 16 piezas de 8 bytes
	ld b,010h		;6c54
L_6C56:
	push bc			;6c56
	ld a,(ix+000h)		;6c57
	or a			;6c5a
	call nz,cae_una_pieza		;6c5b   ; cae_una_pieza: las clases 5-10 caen mientras no tengan suelo debajo; las 0-4 por pasos (IX+01)
	ld bc,00008h		;6c5e   ; la siguiente
	add ix,bc		;6c61
	pop bc			;6c63
	djnz L_6C56		;6c64
	ret			;6c66
cae_una_pieza:		; las clases 5-10 caen mientras no tengan suelo debajo; las 0-4 por pasos (IX+01)
	ld a,(ix+000h)		;6c67   ; las clases 0-4 por pasos
	cp 005h		;6c6a
	jr c,L_6C8E		;6c6c
	cp 00bh		;6c6e   ; de la 11 en adelante no caen
	ret nc			;6c70
	ld a,(ix+001h)		;6c71   ; cayendo?
	and 07fh		;6c74
	jr z,L_6C80		;6c76
	call suelo_debajo		;6c78   ; hasta tocar suelo
	ret nc			;6c7b
	dec (ix+001h)		;6c7c   ; toca: quieta
	ret			;6c7f
L_6C80:
	ld a,(ix+003h)		;6c80   ; quieta: cerca del borde derecho no
	cp 0e1h		;6c83
	ret nc			;6c85
	call suelo_debajo		;6c86   ; si no tiene suelo, empieza a caer
	ret c			;6c89
	inc (ix+001h)		;6c8a
	ret			;6c8d
L_6C8E:
	ld a,(ix+001h)		;6c8e   ; el paso
	and 07fh		;6c91
	call 04084h		;6c93   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_6C96: 4 destinos del despachador p00:4084 (call en p01:6C93, el
;   indice en A): 6CAF, 6C9E, 6CB0, 6CAF; lo leen p01:6C93 (8 bytes)
;   0x6c96..0x6c9e  (8 bytes)
DATA_tabla_6C96:
	defw 06cafh,06c9eh,06cb0h,06cafh	; 6c96  -> L_6CAF L_6C9E L_6CB0 L_6CAF

; ======================================================================
; CODIGO 0x6c9e..0x6e07  (361 bytes)
; ======================================================================


L_6C9E:
	call suelo_debajo		;6c9e   ; con suelo debajo, nada
	ret c			;6ca1
	ld a,(ix+001h)		;6ca2   ; bit 7 del paso: sin mirar arriba
	rla			;6ca5
	jr c,L_6CAC		;6ca6
	call hueco_encima		;6ca8   ; hueco_encima: C si en la fila de encima de la pieza hay mapa (caracteres 1-0xA0)
	ret c			;6cab
L_6CAC:
	inc (ix+001h)		;6cac   ; al paso siguiente
L_6CAF:
	ret			;6caf
L_6CB0:
	call suelo_debajo		;6cb0   ; cae hasta tocar suelo
	ret nc			;6cb3
	ld a,01eh		;6cb4   ; y al tocarlo suena 0x1E
	call 04ae4h		;6cb6   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	dec (ix+001h)		;6cb9
	ret			;6cbc
hueco_encima:		; C si en la fila de encima de la pieza hay mapa (caracteres 1-0xA0)
	ld a,(ix+002h)		;6cbd   ; la fila de encima
	sub 008h		;6cc0
	ld l,a			;6cc2
	ld h,(ix+003h)		;6cc3
	ld b,(ix+005h)		;6cc6
	jr L_6CDD		;6cc9
suelo_debajo:		; C si en la fila de debajo de la pieza (Y + filas x 8) hay mapa (caracteres 1-0xA0)
	ld a,(ix+004h)		;6ccb   ; la fila de debajo: Y + filas x 8
	rla			;6cce
	rla			;6ccf
	rla			;6cd0
	and 0f8h		;6cd1
	add a,(ix+002h)		;6cd3
	ld l,a			;6cd6
	ld h,(ix+003h)		;6cd7
	ld b,(ix+005h)		;6cda
L_6CDD:
	call 05c92h		;6cdd   ; su sitio en la pantalla de RAM
	ld c,0a1h		;6ce0   ; de 0xA1 en adelante no es mapa
L_6CE2:
	ld a,(hl)			;6ce2   ; vacio: no cuenta
	or a			;6ce3
	jr z,L_6CE8		;6ce4
	cp c			;6ce6   ; mapa: C
	ret c			;6ce7
L_6CE8:
	inc l			;6ce8
	djnz L_6CE2		;6ce9
	xor a			;6ceb   ; nada debajo
	ret			;6cec
pinta_piezas:		; sin jefe con partes, en las fases 3 y 9-11, con los bancos 14-15, cada pieza en la pantalla de RAM (p01:6D11)
	call hay_jefe_con_partes		;6ced   ; hay_jefe_con_partes: NZ si hay jefe con partes: el 5 siempre, los demas si 0xEA00 no es cero
	ret nz			;6cf0
	call fase_de_piezas		;6cf1   ; fase_de_piezas: C en las fases 3, 9, 10 y 11
	ret nc			;6cf4
	call 0415bh		;6cf5   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld ix,0e580h		;6cf8   ; 16 piezas de 8 bytes
	ld b,010h		;6cfc
L_6CFE:
	push bc			;6cfe
	ld a,(ix+000h)		;6cff
	or a			;6d02
	call nz,pinta_pieza		;6d03   ; pinta_pieza: el dibujo de la clase (p15:A581) de IX+04 filas x IX+05 en IX+03 (X), IX+02 (Y)
	ld bc,00008h		;6d06   ; la siguiente
	add ix,bc		;6d09
	pop bc			;6d0b
	djnz L_6CFE		;6d0c
	jp 04157h		;6d0e   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
pinta_pieza:		; el dibujo de la clase (p15:A581) de IX+04 filas x IX+05 en IX+03 (X), IX+02 (Y)
	ld de,0a581h		;6d11   ; los caracteres de su clase
	call 04b60h		;6d14   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ld h,(ix+003h)		;6d17   ; H = X, L = Y
	ld l,(ix+002h)		;6d1a
	ld c,(ix+004h)		;6d1d   ; C = filas, B = ancho
	ld b,(ix+005h)		;6d20
	jp 05327h		;6d23   ; copia_bloque: copia DE en la pantalla de RAM en H (X), L (Y): C filas de B (de A de ancho en origen), cortado por el borde
pieza_rota:		; la pieza IX deja de estar: explosion (p02:8BA1), suena 0x13 y se borra de la pantalla de RAM
	ld (ix+000h),000h		;6d26   ; libre
	ld e,(ix+002h)		;6d2a   ; la explosion en su sitio
	ld d,(ix+003h)		;6d2d
	call 08ba1h		;6d30   ; crea_explosion: una explosion de 4x4 caracteres en D (X), E (Y), si esta en pantalla y hay hueco en 0xEA40
	ld a,013h		;6d33   ; suena 0x13
	call 04ae4h		;6d35   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld h,(ix+003h)		;6d38   ; y desaparece de la pantalla
	ld l,(ix+002h)		;6d3b
	ld c,(ix+004h)		;6d3e
	ld b,(ix+005h)		;6d41
	jp 0530ch		;6d44   ; borra_bloque: borra C filas de B caracteres en la pantalla de RAM en H (X), L (Y), cortado por el borde
apariciones_de_enemigos:		; cada cuadro: torretas, la lista de la fase (p14:9A67), las oleadas y los de relleno de la zona (p14:99C7); nada en el final de la fase 8 ni con 0xE3D0
	ld a,(0e3c0h)		;6d47   ; en el final de la fase 8 no sale nadie
	or a			;6d4a
	ret nz			;6d4b
	call apariciones_del_scroll_1		;6d4c   ; las torretas
	ld a,(0e3d0h)		;6d4f   ; con 0xE3D0, nada mas
	or a			;6d52
	ret nz			;6d53
	ld a,(0e201h)		;6d54   ; en las fases 9-11, sin espera
	cp 009h		;6d57
	jr c,L_6D60		;6d59
	xor a			;6d5b
	ld (0e354h),a		;6d5c   ; guarda 0x40 al empezar la fase
	ret			;6d5f
L_6D60:
	call enemigos_del_scroll		;6d60   ; la lista de la fase
	ld a,(0e3beh)		;6d63   ; con 0xE3BE, p01:701A
	or a			;6d66
	call nz,generador_2		;6d67   ; generador_2: crea el tipo 5 cada 0x70 - 4 x nivel cuadros, en las Y de p01:7055 (p01:705D en la fase 0), en tandas de 8
	call en_la_fase_1		;6d6a   ; lo de la fase 1
	ld a,(0e201h)		;6d6d   ; en la fase 7 con 0xE204 = 2, los de relleno
	cp 007h		;6d70
	jr nz,L_6D7C		;6d72
	ld a,(0e204h)		;6d74
	cp 002h		;6d77
	jp z,enemigos_de_relleno		;6d79   ; enemigos_de_relleno: con los bancos 14-15, el byte de p14:99C7 de la fase para estas 32 columnas: un generador por nibble (el bajo solo del nivel 10 en adelante)
L_6D7C:
	call espera_de_aparicion		;6d7c   ; con espera, nada mas
	ret nz			;6d7f
	call oleadas		;6d80   ; las oleadas
	ld a,(0e390h)		;6d83   ; con una oleada en marcha, nada mas
	and a			;6d86
	ret nz			;6d87
	ld a,(0e353h)		;6d88   ; sin enemigos creados, los de relleno
	and a			;6d8b
	jr z,enemigos_de_relleno		;6d8c
	ld hl,0e352h		;6d8e   ; si queda sitio para la oleada (11 - los que hay), tambien
	ld a,00bh		;6d91
	sub (hl)			;6d93
	ld hl,0e392h		;6d94   ; apunta a los enemigos que faltan de la oleada
	cp (hl)			;6d97
	ret c			;6d98
	jr enemigos_de_relleno		;6d99
en_la_fase_1:		; en la fase 1, con el banco 11, p11:B11A
	ld a,(0e201h)		;6d9b   ; solo en la fase 1
	dec a			;6d9e
	ret nz			;6d9f
	call 04137h		;6da0   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0b11ah		;6da3
	jp 04157h		;6da6   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
espera_de_aparicion:		; NZ mientras dure la espera 0xE354, haya jefe o 0xE204 sea 2 o mas
	ld hl,0e354h		;6da9   ; la espera de salida de la fase
	ld a,(hl)			;6dac
	and a			;6dad
	jr z,L_6DB4		;6dae
	dec (hl)			;6db0
L_6DB1:
	or 0ffh		;6db1
	ret			;6db3
L_6DB4:
	ld a,(0e340h)		;6db4   ; con jefe, no
	and a			;6db7
	ret nz			;6db8
	ld a,(0e204h)		;6db9   ; ni con 0xE204 a 2 o mas
	cp 002h		;6dbc
	jr nc,L_6DB1		;6dbe
	xor a			;6dc0
	ret			;6dc1
enemigos_de_relleno:		; con los bancos 14-15, el byte de p14:99C7 de la fase para estas 32 columnas: un generador por nibble (el bajo solo del nivel 10 en adelante)
	call 0415bh		;6dc2   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e201h)		;6dc5   ; la tabla de la fase en p14:99C7
	ld de,099c7h		;6dc8
	call 04b60h		;6dcb   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ld hl,(0e203h)		;6dce   ; la columna del scroll / 32
	ld a,l			;6dd1
	rr h		;6dd2
	rra			;6dd4
	rr h		;6dd5
	rra			;6dd7
	rra			;6dd8
	rra			;6dd9
	rra			;6dda
	and 01fh		;6ddb
	call 0407fh		;6ddd   ; de_mas_a: DE = DE + A
	ld a,(de)			;6de0   ; el byte de esta zona
	push af			;6de1
	rra			;6de2   ; el nibble alto: un generador
	rra			;6de3
	rra			;6de4
	rra			;6de5
	and 00fh		;6de6
	push af			;6de8
	call 04157h		;6de9   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	pop af			;6dec
	call generador		;6ded   ; generador: el generador A (1-11, p01:6E07); 0 ninguno
	pop bc			;6df0
	ld a,(0e228h)		;6df1   ; el bajo, solo del nivel 10 en adelante
	cp 00ah		;6df4
	jp c,04157h		;6df6   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,b			;6df9
	and 00fh		;6dfa
	call generador		;6dfc   ; generador: el generador A (1-11, p01:6E07); 0 ninguno
	jp 04157h		;6dff   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
generador:		; el generador A (1-11, p01:6E07); 0 ninguno
	dec a			;6e02   ; 0: ninguno
	ret m			;6e03
	call 04084h		;6e04   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_6E07: 11 destinos del despachador p00:4084 (call en p01:6E04, el
;   indice en A): 6FC4, 701A, 7216, 7151, 71EA, 71A2, 7106, 718A, 7065, 709F,
;   70CE; lo leen p01:6E04 (22 bytes)
;   0x6e07..0x6e1d  (22 bytes)
DATA_tabla_6E07:
	defw 06fc4h,0701ah,07216h,07151h,071eah,071a2h,07106h,0718ah	; 6e07
	defw 07065h,0709fh,070ceh	; 6e17  -> generador_9 generador_10 generador_11

; ======================================================================
; CODIGO 0x6e1d..0x6ec1  (164 bytes)
; ======================================================================


oleadas:		; en las fases 0-7: al llegar a su columna (p01:6EC1) empieza una oleada de 6 enemigos del tipo de la fase (p01:6EF2), uno cada 4 o 6 cuadros, en grupo (0xE396)
	ld a,(0e201h)		;6e1d   ; solo en las fases 0-7
	cp 008h		;6e20
	ret nc			;6e22
	ld hl,0e390h		;6e23   ; el paso de la oleada
	ld a,(hl)			;6e26
	and a			;6e27
	jr z,L_6E71		;6e28
	dec a			;6e2a
	jr z,L_6E69		;6e2b
	inc l			;6e2d   ; paso 2: la espera entre enemigos
	dec (hl)			;6e2e
	ret nz			;6e2f
	ld a,(0e393h)		;6e30   ; 4 cuadros el tipo 0x0B, 6 los demas
	ld b,004h		;6e33
	cp 00bh		;6e35
	jr z,L_6E3B		;6e37
	ld b,006h		;6e39
L_6E3B:
	ld (hl),b			;6e3b
	inc l			;6e3c   ; uno menos
	dec (hl)			;6e3d
	jr nz,L_6E44		;6e3e
	dec l			;6e40   ; el ultimo: se acaba la oleada
	dec l			;6e41
	ld (hl),000h		;6e42
L_6E44:
	ld hl,0e37eh		;6e44   ; el numero dentro de la oleada
	inc (hl)			;6e47
	ld b,(hl)			;6e48
	ld a,(0e395h)		;6e49   ; en Y 0xE395, X 0xF8
	ld e,a			;6e4c
	ld d,0f8h		;6e4d
	ld a,(0e393h)		;6e4f   ; lee el tipo de la oleada
	ld c,000h		;6e52
	call 04d1eh		;6e54   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	ld a,(0e353h)		;6e57   ; creado?
	and a			;6e5a
	ret nz			;6e5b
	ld hl,0e37eh		;6e5c   ; no habia sitio: se intenta luego (paso 1)
	dec (hl)			;6e5f
	ld hl,0e392h		;6e60   ; apunta a los enemigos que faltan de la oleada
	inc (hl)			;6e63
	dec l			;6e64
	dec l			;6e65
	ld (hl),001h		;6e66
	ret			;6e68
L_6E69:
	ld a,(0e352h)		;6e69   ; paso 1: espera a que haya menos de 7
	cp 007h		;6e6c
	ret nc			;6e6e
	inc (hl)			;6e6f
	ret			;6e70
L_6E71:
	ld a,(0e320h)		;6e71   ; paso 0: solo con scroll
	and a			;6e74
	ret z			;6e75
	ld hl,06ec1h		;6e76   ; la columna de la oleada de la fase
	ld a,(0e201h)		;6e79   ; lee la fase (0-11)
	call 0407ah		;6e7c   ; hl_mas_a: HL = HL + A
	ld d,000h		;6e7f
	ld e,(hl)			;6e81
	ld hl,(0e203h)		;6e82   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;6e85   ; aun no
	ret nc			;6e86
	ld a,l			;6e87   ; y en columna multiplo de 8
	and 007h		;6e88
	ret nz			;6e8a
	ld hl,00101h		;6e8b   ; paso 1
	ld (0e390h),hl		;6e8e   ; guarda el paso de la oleada (0 nada, 1 espera hueco, 2 saliendo) y el byte siguiente (16 bits)
	ld hl,0e396h		;6e91   ; un grupo nuevo (1-255)
	ld a,(hl)			;6e94
	inc a			;6e95
	jr nz,L_6E99		;6e96
	inc a			;6e98
L_6E99:
	ld (hl),a			;6e99
	ld a,(0e201h)		;6e9a   ; el tipo de la fase
	ld hl,06ef2h		;6e9d
	call 05ca6h		;6ea0   ; byte_a: A = el byte A de la tabla HL
	ld (0e393h),a		;6ea3   ; guarda el tipo de la oleada
	call altura_de_oleada		;6ea6   ; la altura
	ld (0e395h),a		;6ea9   ; guarda la Y de la oleada
	ld a,006h		;6eac   ; 6 enemigos
	ld (0e392h),a		;6eae   ; guarda los enemigos que faltan de la oleada
	ld a,0ffh		;6eb1
	ld (0e37eh),a		;6eb3   ; guarda el numero del enemigo dentro de la oleada
	xor a			;6eb6
	call 089a8h		;6eb7   ; sitio para el grupo (p02:89A8)
	jr nc,$+15		;6eba
	xor a			;6ebc   ; sin sitio, no hay oleada
	ld (0e390h),a		;6ebd   ; guarda el paso de la oleada (0 nada, 1 espera hueco, 2 saliendo)
	ret			;6ec0

; ----------------------------------------------------------------------
; DATOS tabla_6EC1: 8 bytes, uno por fase de la 0 a la 7, que p01:6E76 compara
;   con el scroll; lo leen p01:6E7C (8 bytes)
;   0x6ec1..0x6ec9  (8 bytes)
DATA_tabla_6EC1:
	defb 000h,080h,080h,060h,060h,080h,060h,048h	; 6ec1  ...``.`H

; ======================================================================
; CODIGO 0x6ec9..0x6ef2  (41 bytes)
; ======================================================================


apunta_grupo:		; el grupo: [0xE396][cuantos][cuantos]
	ld a,(0e396h)		;6ec9   ; lee el grupo de la ultima oleada (1-255)
	ld (hl),a			;6ecc
	inc l			;6ecd
	ld a,(0e392h)		;6ece   ; lee los enemigos que faltan de la oleada
	ld (hl),a			;6ed1
	inc l			;6ed2
	ld (hl),a			;6ed3
	ret			;6ed4
altura_de_oleada:		; la Y de la oleada: una vez arriba, otra abajo (0x30/0x70, el tipo 0x0B 0x1C/0x8C)
	ld hl,0e363h		;6ed5   ; una oleada mas
	inc (hl)			;6ed8
	ld a,(0e393h)		;6ed9   ; lee el tipo de la oleada
	cp 00bh		;6edc   ; el tipo 0x0B a otras alturas
	jr z,L_6EE9		;6ede
	ld a,(hl)			;6ee0   ; 0x30 o 0x70
	and 001h		;6ee1
	ld a,030h		;6ee3
	ret z			;6ee5
	xor 040h		;6ee6
	ret			;6ee8
L_6EE9:
	ld a,(hl)			;6ee9   ; 0x1C o 0x8C
	and 001h		;6eea
	ld a,01ch		;6eec
	ret z			;6eee
	ld a,08ch		;6eef
	ret			;6ef1

; ----------------------------------------------------------------------
; DATOS tabla_6EF2: 13 bytes, uno por fase, que p01:6E9A pone en 0xE393 (el 13
;   no lo pide ninguna); lo leen p01:6EA0 (13 bytes)
;   0x6ef2..0x6eff  (13 bytes)
DATA_tabla_6EF2:
	defb 00bh,00bh,00bh,031h,031h,031h,00bh,00bh,00bh,00bh,00bh,00bh,00bh	; 6ef2  ...111.......

; ======================================================================
; CODIGO 0x6eff..0x6f22  (35 bytes)
; ======================================================================


siguiente_de_6f22:		; C = el siguiente de p01:6F22 (la cuenta de HL, de 16 en 16)
	exx			;6eff
	ld hl,06f22h		;6f00
	exx			;6f03
	jp L_6F17		;6f04
siguiente_de_6f32:		; C = el siguiente de p01:6F32 (cuenta 0xE356)
	exx			;6f07
	ld hl,06f32h		;6f08
	exx			;6f0b
	jp siguiente_de_tabla		;6f0c   ; siguiente_de_tabla: C = la tabla HL' en (HL) & 15, y (HL) + 1
siguiente_de_6f22_e356:		; C = el siguiente de p01:6F22 (cuenta 0xE356)
	exx			;6f0f
	ld hl,06f22h		;6f10
	exx			;6f13
siguiente_de_tabla:		; C = la tabla HL' en (HL) & 15, y (HL) + 1
	ld hl,0e356h		;6f14   ; apunta a la cuenta de las tablas de p01:6F22/6F32
L_6F17:
	ld a,(hl)			;6f17   ; la cuenta, de 0 a 15
	and 00fh		;6f18
	inc (hl)			;6f1a
	exx			;6f1b
	call 05ca6h		;6f1c   ; byte_a: A = el byte A de la tabla HL
	exx			;6f1f
	ld c,a			;6f20
	ret			;6f21

; ----------------------------------------------------------------------
; DATOS tabla_6F22: 16 bytes que p01:6F17 lee con 0xE356 & 0x0F (desde
;   p01:6EFF y p01:6F0F); lo leen p01:6F1C (16 bytes)
;   0x6f22..0x6f32  (16 bytes)
DATA_tabla_6F22:
	defb 000h,000h,000h,001h,000h,000h,000h,001h,000h,000h,000h,002h,000h,000h,000h,001h	; 6f22  ................

; ----------------------------------------------------------------------
; DATOS tabla_6F32: 16 bytes que p01:6F17 lee con 0xE356 & 0x0F (desde
;   p01:6F07); lo leen p01:6F1C (16 bytes)
;   0x6f32..0x6f42  (16 bytes)
DATA_tabla_6F32:
	defb 000h,000h,001h,001h,000h,000h,001h,001h,000h,000h,001h,002h,000h,000h,001h,001h	; 6f32  ................

; ======================================================================
; CODIGO 0x6f42..0x7006  (196 bytes)
; ======================================================================


enemigos_de_la_lista:		; en las fases 0-8, lo que trae cada columna de la lista (p01:6F64) hasta ponerse al dia (0xE37C)
	ld a,(0e201h)		;6f42   ; en las fases 0-8
	cp 009h		;6f45
	ret nc			;6f47
L_6F48:
	call enemigo_de_la_lista		;6f48   ; enemigo_de_la_lista: con los bancos 14-15, la siguiente ficha de p14:9A67: [columna][B][tipo y C][Y]; si es su columna, crea el enemigo
	jr z,L_6F48		;6f4b   ; Z: creado; a por el siguiente
	ret c			;6f4d   ; C: todavia no
	ld hl,0e37ch		;6f4e   ; pasado: al siguiente
	inc (hl)			;6f51
	jr L_6F48		;6f52
enemigos_del_scroll:		; si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	ld a,(0e320h)		;6f54   ; lee la marca de scroll hecho en este cuadro
	and a			;6f57
	ret z			;6f58
	ld a,0f8h		;6f59   ; por el borde derecho
	ld (0f004h),a		;6f5b   ; guarda variable de paso
L_6F5E:
	call enemigo_de_la_lista		;6f5e   ; enemigo_de_la_lista: con los bancos 14-15, la siguiente ficha de p14:9A67: [columna][B][tipo y C][Y]; si es su columna, crea el enemigo
	jr z,L_6F5E		;6f61
	ret			;6f63
enemigo_de_la_lista:		; con los bancos 14-15, la siguiente ficha de p14:9A67: [columna][B][tipo y C][Y]; si es su columna, crea el enemigo
	call 0415bh		;6f64   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e37ch)		;6f67   ; la siguiente de la lista de la fase (p14:9A67)
	ld hl,09a67h		;6f6a
	call ficha_de_la_lista		;6f6d   ; ficha_de_la_lista: la ficha A (4 bytes) de la lista de la fase: DE su columna (10 bits), A, C y B los demas; compara con el scroll; C sin mas fichas (0xFFFF)
	jp nz,04157h		;6f70   ; no es su columna: fuera
	ld hl,0e37ch		;6f73   ; gastada
	inc (hl)			;6f76
	ld e,b			;6f77   ; E = Y
	srl a		;6f78   ; B = los bits 2-7 del segundo byte
	srl a		;6f7a
	ld b,a			;6f7c
	ld a,(0f004h)		;6f7d   ; D = X
	ld d,a			;6f80
	ld a,c			;6f81   ; el tipo: bits 0-5 del tercer byte
	ld l,a			;6f82
	and 03fh		;6f83
	cp c			;6f85
	ld c,000h		;6f86   ; C = 0, 1 (bit 6) o 2 (bit 7)
	jr z,L_6F90		;6f88
	inc c			;6f8a
	rl l		;6f8b
	jr nc,L_6F90		;6f8d
	inc c			;6f8f
L_6F90:
	push af			;6f90
	call 04157h		;6f91   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	pop af			;6f94
	call 04d1eh		;6f95   ; crea el enemigo
	xor a			;6f98
	ret			;6f99
ficha_de_la_lista:		; la ficha A (4 bytes) de la lista de la fase: DE su columna (10 bits), A, C y B los demas; compara con el scroll; C sin mas fichas (0xFFFF)
	push af			;6f9a
	ld a,(0e201h)		;6f9b   ; la lista de la fase
	call 04b67h		;6f9e   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	pop af			;6fa1
	add a,a			;6fa2   ; 4 bytes por ficha
	add a,a			;6fa3
	call 0407fh		;6fa4   ; de_mas_a: DE = DE + A
	ex de,hl			;6fa7
	ld e,(hl)			;6fa8
	inc hl			;6fa9
	ld a,(hl)			;6faa   ; 0xFFFF: no hay mas
	cp e			;6fab
	jr nz,L_6FB5		;6fac
	cp 0ffh		;6fae
	jr nz,L_6FB5		;6fb0
	or a			;6fb2   ; C y NZ
	scf			;6fb3
	ret			;6fb4
L_6FB5:
	and 003h		;6fb5   ; la columna: 8 bits y 2 mas
	ld d,a			;6fb7
	ld a,(hl)			;6fb8   ; A, C y B
	inc hl			;6fb9
	ld c,(hl)			;6fba
	inc hl			;6fbb
	ld b,(hl)			;6fbc
	ld hl,(0e203h)		;6fbd   ; la compara con el scroll
	and a			;6fc0
	sbc hl,de		;6fc1
	ret			;6fc3
generador_1:		; crea el tipo 4 en X 0xF0 cada 8 cuadros, en las Y de p01:7006, mientras dure la tanda (0xE373); luego otra tanda
	ld hl,0e373h		;6fc4   ; sin tanda, otra
	ld a,(hl)			;6fc7
	and a			;6fc8
	jr z,nueva_tanda		;6fc9
	inc l			;6fcb   ; cada 8 cuadros
	dec (hl)			;6fcc
	ret nz			;6fcd
	ld (hl),008h		;6fce
	dec l			;6fd0
	dec (hl)			;6fd1
	ld b,000h		;6fd2   ; en X 0xF0
	ld d,0f0h		;6fd4
	ld a,(hl)			;6fd6   ; una de las 4 alturas de p01:7006
	and 003h		;6fd7
	ld hl,07006h		;6fd9
	call 0407ah		;6fdc   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;6fdf
	ld c,000h		;6fe0
	ld a,004h		;6fe2   ; el tipo 4
	jp 04d1eh		;6fe4   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
nueva_tanda:		; la tanda segun el nivel (p01:700A) y su espera; 0xE3B3 + 1
	ld de,0700ah		;6fe7   ; la tanda, segun el nivel
	ld a,(0e228h)		;6fea   ; lee el nivel de dificultad
	call 0407fh		;6fed   ; de_mas_a: DE = DE + A
	ld a,(de)			;6ff0
	ld (hl),a			;6ff1
	inc l			;6ff2
	ld c,070h		;6ff3
	call espera_por_nivel		;6ff5   ; espera_por_nivel: (HL) = C - 2 x nivel
	ld hl,0e3b3h		;6ff8   ; apunta a cuantas tandas
	inc (hl)			;6ffb
	ret			;6ffc
espera_por_nivel:		; (HL) = C - 2 x nivel
	ld a,(0e228h)		;6ffd   ; menos 2 x nivel
	add a,a			;7000
	sub c			;7001
	neg		;7002
	ld (hl),a			;7004
	ret			;7005

; ----------------------------------------------------------------------
; DATOS tabla_7006: 4 bytes que p01:6FD6 lee con (HL) & 3; lo leen p01:6FDC (4
;   bytes)
;   0x7006..0x700a  (4 bytes)
DATA_tabla_7006:
	defb 020h,080h,040h,070h	; 7006

; ----------------------------------------------------------------------
; DATOS tabla_700A: 16 bytes que p01:6FE7 lee con 0xE228; lo leen p01:6FED (16
;   bytes)
;   0x700a..0x701a  (16 bytes)
DATA_tabla_700A:
	defb 004h,004h,004h,005h,005h,005h,005h,006h,006h,006h,006h,006h,007h,007h,007h,007h	; 700a  ................

; ======================================================================
; CODIGO 0x701a..0x7055  (59 bytes)
; ======================================================================


generador_2:		; crea el tipo 5 cada 0x70 - 4 x nivel cuadros, en las Y de p01:7055 (p01:705D en la fase 0), en tandas de 8
	ld hl,0e36fh		;701a   ; en tanda?
	ld a,(hl)			;701d
	and a			;701e
	jr z,L_704F		;701f
	inc l			;7021
	dec (hl)			;7022   ; la espera
	ret nz			;7023
	ld a,(0e228h)		;7024   ; 0x70 - 4 x nivel
	add a,a			;7027
	add a,a			;7028
	sub 070h		;7029
	neg		;702b
	ld (hl),a			;702d
	dec l			;702e
	dec (hl)			;702f   ; uno menos de la tanda
	ld a,(hl)			;7030
	and 007h		;7031
	ld b,a			;7033
	ld hl,07055h		;7034   ; la altura de la tabla (la de la fase 0 aparte)
	ld a,(0e201h)		;7037   ; lee la fase (0-11)
	or a			;703a
	jr nz,L_7040		;703b
	ld hl,0705dh		;703d
L_7040:
	ld a,b			;7040
	call 05ca6h		;7041   ; byte_a: A = el byte A de la tabla HL
	ld e,a			;7044
	ld d,000h		;7045
	call siguiente_de_6f22_e356		;7047   ; C de p01:6F22
	ld a,005h		;704a   ; el tipo 5
	jp 04d1eh		;704c   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
L_704F:
	ld (hl),008h		;704f   ; tanda de 8
	inc l			;7051
	ld (hl),001h		;7052
	ret			;7054

; ----------------------------------------------------------------------
; DATOS tabla_7055: dos tablas de 8 bytes (0x7055 y 0x705D) que p01:7040 lee
;   con B; lo leen p01:7041 (16 bytes)
;   0x7055..0x7065  (16 bytes)
DATA_tabla_7055:
	defb 008h,090h,008h,008h,090h,008h,090h,090h	; 7055  ........
	defb 050h,060h,050h,050h,060h,050h,060h,060h	; 705d  P`PP`P``

; ======================================================================
; CODIGO 0x7065..0x7097  (50 bytes)
; ======================================================================


generador_9:		; crea el tipo 0x19 en una Y al azar (0x10-0x8F), con la espera de p01:7097 (las largas, menos el nivel)
	ld hl,0e368h		;7065   ; la espera
	dec (hl)			;7068
	ret p			;7069
	ld hl,0e38eh		;706a   ; la siguiente de p01:7097
	inc (hl)			;706d
	ld a,(hl)			;706e
	and 007h		;706f
	ld hl,07097h		;7071
	call 05ca6h		;7074   ; byte_a: A = el byte A de la tabla HL
	ld hl,0e368h		;7077   ; apunta a la espera del generador 9
	ld (hl),a			;707a
	cp 018h		;707b   ; las largas, menos el nivel
	jr c,L_7086		;707d
	ld a,(0e228h)		;707f   ; lee el nivel de dificultad
	sub (hl)			;7082
	neg		;7083
	ld (hl),a			;7085
L_7086:
	ld a,r		;7086   ; Y al azar de 0x10 a 0x8F
	and 07fh		;7088
	add a,010h		;708a
	ld e,a			;708c
	ld d,0f8h		;708d   ; en el borde derecho
	ld bc,00000h		;708f
	ld a,019h		;7092   ; el tipo 0x19
	jp 04d1eh		;7094   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)

; ----------------------------------------------------------------------
; DATOS tabla_7097: 8 bytes que p01:706E lee con (HL) & 7; lo leen p01:7074 (8
;   bytes)
;   0x7097..0x709f  (8 bytes)
DATA_tabla_7097:
	defb 008h,003h,006h,030h,005h,004h,007h,006h	; 7097  ...0....

; ======================================================================
; CODIGO 0x709f..0x70c6  (39 bytes)
; ======================================================================


generador_10:		; crea el tipo 0x0C cada 20 - nivel / 2 cuadros en una Y al azar de p01:70C6
	ld hl,0e37fh		;709f   ; la espera
	dec (hl)			;70a2
	ret p			;70a3
	ld a,(0e228h)		;70a4   ; 20 - nivel / 2
	sra a		;70a7
	neg		;70a9
	add a,014h		;70ab
	ld (hl),a			;70ad
	call azar_rapido		;70ae   ; una de las 8 alturas de p01:70C6
	and 007h		;70b1
	ld hl,070c6h		;70b3
	call 05ca6h		;70b6   ; byte_a: A = el byte A de la tabla HL
	ld e,a			;70b9
	ld d,0f8h		;70ba
	call siguiente_de_6f32		;70bc   ; C de p01:6F32
	ld b,000h		;70bf
	ld a,00ch		;70c1   ; el tipo 0x0C
	jp 04d1eh		;70c3   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)

; ----------------------------------------------------------------------
; DATOS tabla_70C6: 8 bytes que p01:70B1 lee con A & 7; lo leen p01:70B6 (8
;   bytes)
;   0x70c6..0x70ce  (8 bytes)
DATA_tabla_70C6:
	defb 030h,038h,040h,048h,050h,058h,060h,070h	; 70c6  08@HPX`p

; ======================================================================
; CODIGO 0x70ce..0x7141  (115 bytes)
; ======================================================================


generador_11:		; crea el tipo 8 cada 0x50 cuadros (0x40 del nivel 6) en una Y de p01:70C6 lejos de la nave (24 pixeles o mas)
	ld hl,0e39dh		;70ce   ; apunta a la espera del generador 11
	dec (hl)			;70d1
	ret p			;70d2
	ld a,(0e228h)		;70d3   ; 0x50 cuadros, 0x40 del nivel 6
	cp 006h		;70d6
	ld a,040h		;70d8
	jr nc,L_70DE		;70da
	ld a,050h		;70dc
L_70DE:
	ld (hl),a			;70de
	call azar_rapido		;70df   ; azar_rapido: A = R rotado XOR la cuenta de cuadros
L_70E2:
	and 007h		;70e2   ; una de las 8 alturas de p01:70C6
	ld b,a			;70e4
	ld hl,070c6h		;70e5
	call 05ca6h		;70e8   ; byte_a: A = el byte A de la tabla HL
	ld e,a			;70eb
	ld a,(0e404h)		;70ec   ; lejos de la nave
	sub e			;70ef
	jr nc,L_70F4		;70f0
	neg		;70f2
L_70F4:
	cp 018h		;70f4
	jr nc,L_70FC		;70f6
	ld a,b			;70f8   ; demasiado cerca: la siguiente
	inc a			;70f9
	jr L_70E2		;70fa
L_70FC:
	ld d,0f8h		;70fc
	ld bc,00000h		;70fe
	ld a,008h		;7101   ; el tipo 8
	jp 04d1eh		;7103   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
generador_7:		; cada 0x60-0x9F cuadros, si la nave esta en medio, 8 enemigos 0x14 alrededor de ella (p01:713F)
	ld hl,0e364h		;7106   ; la espera
	ld a,(hl)			;7109
	dec (hl)			;710a
	and a			;710b
	ret nz			;710c
	ld a,(0e406h)		;710d   ; solo con la nave en medio de la pantalla
	sub 030h		;7110
	cp 090h		;7112
	ret nc			;7114
	ld a,(0e404h)		;7115
	cp 0a0h		;7118
	ret z			;711a
	ld a,r		;711b   ; la proxima, al azar
	and 03fh		;711d
	add a,060h		;711f
	ld (hl),a			;7121
	ld b,008h		;7122   ; 8 alrededor
L_7124:
	push bc			;7124
	ld a,b			;7125
	ld hl,0713fh		;7126   ; el desplazamiento de p01:713F
	call 04b67h		;7129   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(0e404h)		;712c   ; sumado a la nave
	add a,e			;712f
	ld e,a			;7130
	ld a,(0e406h)		;7131
	add a,d			;7134
	ld d,a			;7135
	ld c,000h		;7136
	ld a,014h		;7138   ; el tipo 0x14
	call 04d1eh		;713a   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	pop bc			;713d
	djnz L_7124		;713e
	ret			;7140

; ----------------------------------------------------------------------
; DATOS tabla_7141: 8 palabras que p01:7124 lee en 0x713F + 2 x B (B de 8 a
;   1); lo leen p01:7129 (16 bytes)
;   0x7141..0x7151  (16 bytes)
DATA_tabla_7141:
	defw 021dfh,02121h,0df21h,0dfdfh,000d0h,03000h,00030h,0d000h	; 7141

; ======================================================================
; CODIGO 0x7151..0x7240  (239 bytes)
; ======================================================================


generador_4:		; cada 0x40-0x5F cuadros, 6 enemigos 0x0D en columna desde Y 0x10, de 0x18 en 0x18 (uno de cada 4 con C = 1)
	ld hl,0e361h		;7151   ; la espera
	dec (hl)			;7154
	ret p			;7155
	ld a,r		;7156   ; la proxima, al azar
	and 01fh		;7158
	add a,040h		;715a
	ld (hl),a			;715c
	dec l			;715d   ; una tanda mas
	inc (hl)			;715e
	ld a,(hl)			;715f
	and 003h		;7160
	ld bc,00600h		;7162   ; 6, y una de cada 4 con C = 1
	jr nz,L_7168		;7165
	inc c			;7167
L_7168:
	ld de,0f810h		;7168   ; desde X 0xF8, Y 0x10
	ld a,(0e201h)		;716b   ; en la fase 7, una de cada 8 desde X 0
	cp 007h		;716e
	jr nz,L_717A		;7170
	ld a,(0e360h)		;7172   ; lee la cuenta del generador 4
	and 007h		;7175
	jr nz,L_717A		;7177
	ld d,a			;7179
L_717A:
	push bc			;717a
	push de			;717b
	ld a,00dh		;717c   ; el tipo 0x0D
	call 04d1eh		;717e   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	pop de			;7181
	ld a,e			;7182   ; 0x18 mas abajo
	add a,018h		;7183
	ld e,a			;7185
	pop bc			;7186
	djnz L_717A		;7187
	ret			;7189
generador_8:		; cada 0x50 cuadros, dos enemigos 0x16 en Y 0x30 y 0x70
	ld hl,0e378h		;718a   ; la espera
	dec (hl)			;718d
	ret p			;718e
	ld (hl),050h		;718f   ; 80 cuadros
	ld de,0f830h		;7191   ; uno en Y 0x30
	call crea_tipo_16		;7194   ; crea_tipo_16: crea el tipo 0x16 en D (X), E (Y)
	ld de,0f870h		;7197   ; y otro en Y 0x70
crea_tipo_16:		; crea el tipo 0x16 en D (X), E (Y)
	ld bc,00000h		;719a
	ld a,016h		;719d   ; el tipo 0x16
	jp 04d1eh		;719f   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
generador_6:		; crea el tipo 0x11 cada 10 cuadros (6 del nivel 6), arriba o abajo; cada 4 una espera mas larga
	ld hl,0e386h		;71a2   ; la espera
	dec (hl)			;71a5
	ret p			;71a6
	ld a,(0e228h)		;71a7   ; 10 cuadros, 6 del nivel 6
	cp 006h		;71aa
	ld a,00ah		;71ac
	jr c,L_71B2		;71ae
	ld a,006h		;71b0
L_71B2:
	ld (hl),a			;71b2
	inc hl			;71b3
	inc (hl)			;71b4   ; cada 4, una espera larga
	ld a,(hl)			;71b5
	and 003h		;71b6
	jr nz,L_71C0		;71b8
	dec hl			;71ba
	ld c,060h		;71bb
	jp espera_por_nivel		;71bd   ; espera_por_nivel: (HL) = C - 2 x nivel
L_71C0:
	and 001h		;71c0   ; arriba (0x10/0x30) o abajo (0x90/0x70)
	or a			;71c2
	ld de,01030h		;71c3
	jr z,L_71CB		;71c6
	ld de,09070h		;71c8
L_71CB:
	ld a,(0e201h)		;71cb   ; en la fase 5, la segunda
	cp 005h		;71ce
	jr nz,L_71D3		;71d0
	ld e,d			;71d2
L_71D3:
	ld d,0f8h		;71d3
	ld bc,00001h		;71d5   ; B = 0, C = 1
	ld a,(0e201h)		;71d8   ; lee la fase (0-11)
	cp 005h		;71db
	jr z,L_71E5		;71dd
	ld hl,0e38fh		;71df   ; en las demas, C de p01:6F22
	call siguiente_de_6f22		;71e2   ; siguiente_de_6f22: C = el siguiente de p01:6F22 (la cuenta de HL, de 16 en 16)
L_71E5:
	ld a,011h		;71e5   ; el tipo 0x11
	jp 04d1eh		;71e7   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
generador_5:		; con 0xE20A, el tipo 0x0F cada 16 cuadros en Y 0x20 o 0x90; cada 4 una espera mas larga
	ld a,(0e20ah)		;71ea   ; solo con 0xE20A
	or a			;71ed
	ret z			;71ee
	ld hl,0e379h		;71ef   ; la espera
	dec (hl)			;71f2
	ret p			;71f3
	ld (hl),010h		;71f4   ; 16 cuadros
	inc hl			;71f6
	inc (hl)			;71f7   ; cada 4, una espera larga
	ld a,(hl)			;71f8
	and 003h		;71f9
	jr nz,L_7203		;71fb
	dec hl			;71fd
	ld c,070h		;71fe
	jp espera_por_nivel		;7200   ; espera_por_nivel: (HL) = C - 2 x nivel
L_7203:
	and 001h		;7203   ; Y 0x20 o 0x90
	or a			;7205
	ld e,020h		;7206
	jr z,L_720C		;7208
	ld e,090h		;720a
L_720C:
	ld d,0f8h		;720c
	ld bc,00001h		;720e
	ld a,00fh		;7211   ; el tipo 0x0F
	jp 04d1eh		;7213   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
generador_3:		; crea el tipo 9 cada cuadro en las Y de p01:7240 mientras dure la tanda (0xE382); luego otra
	ld hl,0e382h		;7216   ; sin tanda, otra
	ld a,(hl)			;7219
	and a			;721a
	jp z,nueva_tanda		;721b   ; nueva_tanda: la tanda segun el nivel (p01:700A) y su espera; 0xE3B3 + 1
	inc l			;721e   ; cada cuadro
	dec (hl)			;721f
	ret nz			;7220
	ld (hl),001h		;7221
	ld a,(0e35bh)		;7223   ; la siguiente altura de p01:7240
	inc a			;7226
	and 007h		;7227
	ld (0e35bh),a		;7229   ; guarda la cuenta de alturas del generador 3
	ld hl,07240h		;722c
	call 05ca6h		;722f   ; byte_a: A = el byte A de la tabla HL
	ld hl,0e382h		;7232   ; uno menos de la tanda
	dec (hl)			;7235
	ld e,a			;7236
	ld d,0f8h		;7237
	ld c,000h		;7239
	ld a,009h		;723b   ; el tipo 9
	jp 04d1eh		;723d   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)

; ----------------------------------------------------------------------
; DATOS tabla_7240: 8 bytes que p01:7226 lee con 0xE35B; lo leen p01:722F (8
;   bytes)
;   0x7240..0x7248  (8 bytes)
DATA_tabla_7240:
	defb 010h,090h,050h,030h,080h,060h,028h,070h	; 7240  ..P0.`(p

; ======================================================================
; CODIGO 0x7248..0x72df  (151 bytes)
; ======================================================================


lista_de_bloques:		; HL = la lista de bloques de la fase (p15:A0B7 la 7, A0DB la 9, A14D la 10, A1E0 la 11); NZ en las demas
	ld a,(0e201h)		;7248   ; lee la fase (0-11)
	ld hl,0a0b7h		;724b   ; fase 7
	sub 007h		;724e
	ret z			;7250
	ld hl,0a0dbh		;7251   ; fase 9
	sub 002h		;7254
	ret z			;7256
	ld hl,0a14dh		;7257   ; fase 10
	dec a			;725a
	ret z			;725b
	ld hl,0a1e0h		;725c   ; fase 11
	dec a			;725f
	ret			;7260
apariciones_de_bloques:		; en las fases 7 y 9-11, lo que trae cada columna (p01:728B) hasta ponerse al dia (0xE3B1)
	call lista_de_bloques		;7261   ; lista_de_bloques: HL = la lista de bloques de la fase (p15:A0B7 la 7, A0DB la 9, A14D la 10, A1E0 la 11); NZ en las demas
	ret nz			;7264   ; sin lista, nada
	ld (0f010h),hl		;7265   ; guarda variable de paso: la lista y el byte siguiente (16 bits)
	call aparicion_de_bloque		;7268   ; aparicion_de_bloque: la siguiente ficha [C][columna][Y]: si es su columna, crea el tipo 0x29 + (C & 7) con el bit 3 de C, o el 0x2E
	jr z,apariciones_de_bloques		;726b   ; Z: creado; a por el siguiente
	ret c			;726d   ; C: todavia no
	ld hl,0e3b1h		;726e   ; pasado: al siguiente
	inc (hl)			;7271
	jr apariciones_de_bloques		;7272
apariciones_de_bloques_scroll:		; si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	call lista_de_bloques		;7274   ; lista_de_bloques: HL = la lista de bloques de la fase (p15:A0B7 la 7, A0DB la 9, A14D la 10, A1E0 la 11); NZ en las demas
	ret nz			;7277
	ld (0f010h),hl		;7278   ; guarda variable de paso: la lista y el byte siguiente (16 bits)
	ld a,(0e320h)		;727b   ; lee la marca de scroll hecho en este cuadro
	and a			;727e
	ret z			;727f
	ld a,0f8h		;7280   ; por el borde derecho
	ld (0f004h),a		;7282   ; guarda variable de paso
L_7285:
	call aparicion_de_bloque		;7285   ; aparicion_de_bloque: la siguiente ficha [C][columna][Y]: si es su columna, crea el tipo 0x29 + (C & 7) con el bit 3 de C, o el 0x2E
	jr z,L_7285		;7288
	ret			;728a
aparicion_de_bloque:		; la siguiente ficha [C][columna][Y]: si es su columna, crea el tipo 0x29 + (C & 7) con el bit 3 de C, o el 0x2E
	call ficha_de_bloque		;728b   ; ficha_de_bloque: con los bancos 14-15, la ficha 0xE3B1 de 3 bytes de la lista 0xF010: C, la columna (11 bits) y B; compara con el scroll
	ret nz			;728e   ; no es su columna
	ld hl,0e3b1h		;728f   ; gastada
	inc (hl)			;7292
	ld a,b			;7293   ; la Y: bits 3-7
	and 0f8h		;7294
	ld e,a			;7296
	ld a,(0f004h)		;7297   ; la X
	ld d,a			;729a
	bit 3,c		;729b   ; bit 3 de C: bloque 0x29-0x2D
	jp z,L_72AC		;729d
	ld a,c			;72a0
	and 007h		;72a1
	add a,029h		;72a3
	ld c,000h		;72a5
L_72A7:
	call 04d1eh		;72a7   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	xor a			;72aa
	ret			;72ab
L_72AC:
	inc c			;72ac   ; si no, el tipo 0x2E con C = 1
	ld a,02eh		;72ad
	jp L_72A7		;72af
ficha_de_bloque:		; con los bancos 14-15, la ficha 0xE3B1 de 3 bytes de la lista 0xF010: C, la columna (11 bits) y B; compara con el scroll
	call 0415bh		;72b2   ; bancos_14_15: pone los bancos 14 y 15 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e3b1h)		;72b5   ; 3 bytes por ficha
	ld b,a			;72b8
	add a,a			;72b9
	add a,b			;72ba
	ld l,a			;72bb
	ld h,000h		;72bc
	ld de,(0f010h)		;72be   ; lee variable de paso: la lista y el byte siguiente (16 bits)
	add hl,de			;72c2
	ld c,(hl)			;72c3   ; C
	inc hl			;72c4
	ld e,(hl)			;72c5   ; la columna: un byte y los bits 0-2 del siguiente
	inc hl			;72c6
	ld b,(hl)			;72c7
	ld a,b			;72c8
	and 007h		;72c9
	ld d,a			;72cb
	call 04157h		;72cc   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld hl,(0e203h)		;72cf   ; la compara con el scroll
	or a			;72d2
	sbc hl,de		;72d3
	ret			;72d5
suceso_e34b:		; el paso del suceso 0xE34B (4, p01:72DF): las dos piezas de 0xEA70, sus rocas, los puntos, 0xE3AA y p11:A2A2
	ld a,(0e34bh)		;72d6   ; sin suceso, nada
	or a			;72d9
	ret z			;72da
	dec a			;72db   ; por paso (4)
	call 04084h		;72dc   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_72DF: 4 destinos del despachador p00:4084 (call en p01:72DC, el
;   indice en A): 72E7, 731E, 7427, 7438; lo leen p01:72DC (8 bytes)
;   0x72df..0x72e7  (8 bytes)
DATA_tabla_72DF:
	defw 072e7h,0731eh,07427h,07438h	; 72df  -> suceso_empieza suceso_piezas suceso_espera suceso_final

; ======================================================================
; CODIGO 0x72e7..0x730e  (39 bytes)
; ======================================================================


suceso_empieza:		; las dos piezas de 0xEA70 y 0xEA78 (p01:730E) con su sitio en la pantalla de RAM
	ld a,002h		;72e7   ; dos piezas
	ld (0e34ch),a		;72e9   ; guarda las piezas del suceso que quedan
	ld hl,0730eh		;72ec   ; sus fichas de p01:730E
	ld de,0ea70h		;72ef   ; apunta a las dos piezas del suceso (8 bytes cada una)
	ld bc,00010h		;72f2
	ldir		;72f5
	ld hl,(0ea71h)		;72f7   ; el sitio de la primera
	call 05c92h		;72fa   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0ea76h),hl		;72fd
	ld hl,(0ea79h)		;7300   ; y el de la segunda
	call 05c92h		;7303   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0ea7eh),hl		;7306
suceso_siguiente:		; el paso siguiente del suceso (0xE34B + 1)
	ld hl,0e34bh		;7309   ; apunta a el paso del suceso (0 nada)
	inc (hl)			;730c
	ret			;730d

; ----------------------------------------------------------------------
; DATOS inicio_EA70: 16 bytes que p01:72EC copia a 0xEA70; lo leen p01:72EC
;   (16 bytes)
;   0x730e..0x731e  (16 bytes)
DATA_inicio_EA70:
	defb 001h,028h,0b8h,030h,000h,00ah,000h,000h,001h,070h,0b8h,030h,002h,00ah,000h,000h	; 730e  .(.0.....p.0....

; ======================================================================
; CODIGO 0x731e..0x73b8  (154 bytes)
; ======================================================================


suceso_piezas:		; mientras queden piezas (0xE34C), las anima y cada dos cuadros lanza un tipo 0x32 con velocidad al azar (p01:73B8); sin ellas, 0x0100 puntos
	ld a,(0e34ch)		;731e   ; sin piezas: puntos
	and a			;7321
	jp z,L_73AA		;7322
	ld hl,0ea70h		;7325   ; anima las dos
	call anima_pieza		;7328   ; anima_pieza: la pieza de 8 bytes HL: cuando acaba su espera cambia de dibujo (p01:7417, 2x2 caracteres) en su sitio
	ld hl,0ea78h		;732b
	call anima_pieza		;732e   ; anima_pieza: la pieza de 8 bytes HL: cuando acaba su espera cambia de dibujo (p01:7417, 2x2 caracteres) en su sitio
	ld a,(0e1c3h)		;7331   ; cada dos cuadros
	ld c,a			;7334
	rra			;7335
	ret c			;7336
	ld a,r		;7337   ; una X al azar entre 0x70 y 0x8F
	and 01fh		;7339
	add a,070h		;733b
	ld b,a			;733d
	ld a,(0e406h)		;733e   ; con la nave a la izquierda
	cp b			;7341
	jr nc,L_7375		;7342
	ld a,r		;7344   ; una velocidad X al azar (p01:73B8)
	and 01eh		;7346
	ld hl,073b8h		;7348
	call 0407ah		;734b   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;734e
	inc hl			;734f
	ld d,(hl)			;7350
	bit 1,c		;7351   ; al otro lado, uno de cada dos
	call nz,05cadh		;7353   ; menos_de: DE = - DE
	ld (0f012h),de		;7356   ; guarda la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,0f900h		;735a   ; velocidad Y 0xF900 (hacia arriba)
	ld (0f014h),hl		;735d   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,073d8h		;7360   ; desde una de las 4 piezas de p01:73D8
	ld a,r		;7363
	and 006h		;7365
	ld c,a			;7367
	ld b,000h		;7368
	add hl,bc			;736a
	ld e,(hl)			;736b
	inc hl			;736c
	ld d,(hl)			;736d
L_736E:
	ld a,032h		;736e   ; el tipo 0x32
	ld c,000h		;7370
	jp 04d1eh		;7372   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
L_7375:
	ld a,r		;7375   ; con la nave a la derecha
	and 01eh		;7377
	ld hl,073b8h		;7379
	call 0407ah		;737c   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;737f
	inc hl			;7380
	ld d,(hl)			;7381
	bit 1,c		;7382
	call nz,05cadh		;7384   ; menos_de: DE = - DE
	ld a,(0e404h)		;7387   ; desde arriba o desde abajo segun la altura de la nave
	cp 04dh		;738a
	ld hl,09747h		;738c
	jr c,L_7393		;738f
	ld l,05bh		;7391
L_7393:
	ex de,hl			;7393
	ld (0f014h),hl		;7394   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	ld a,(0e404h)		;7397   ; hacia abajo (0x0500) o hacia arriba (0xFB00)
	cp 04dh		;739a
	ld hl,00500h		;739c
	jr nc,L_73A4		;739f
	ld hl,0fb00h		;73a1
L_73A4:
	ld (0f012h),hl		;73a4   ; guarda la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	jp L_736E		;73a7
L_73AA:
	ld de,00100h		;73aa   ; las piezas destruidas: 0x0100 puntos (BCD)
	call 05b04h		;73ad   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld a,05ah		;73b0   ; y 90 cuadros de espera
	ld (0e349h),a		;73b2   ; guarda la espera del suceso
	jp suceso_siguiente		;73b5   ; suceso_siguiente: el paso siguiente del suceso (0xE34B + 1)

; ----------------------------------------------------------------------
; DATOS tabla_73B8: 16 palabras que p01:7344 y p01:7375 leen al azar (ld a,r &
;   0x1E); lo leen p01:734B (32 bytes)
;   0x73b8..0x73d8  (32 bytes)
DATA_tabla_73B8:
	defw 00100h,00280h,00200h,00500h,00340h,00400h,00380h,001a0h	; 73b8
	defw 00540h,00020h,00300h,00480h,00600h,005c0h,00160h,00080h	; 73c8

; ----------------------------------------------------------------------
; DATOS tabla_73D8: 4 palabras que p01:7360 lee al azar (ld a,r & 6); lo leen
;   p01:736A (8 bytes)
;   0x73d8..0x73e0  (8 bytes)
DATA_tabla_73D8:
	defw 08f4fh,08f55h,09747h,0975bh	; 73d8

; ======================================================================
; CODIGO 0x73e0..0x7417  (55 bytes)
; ======================================================================


anima_pieza:		; la pieza de 8 bytes HL: cuando acaba su espera cambia de dibujo (p01:7417, 2x2 caracteres) en su sitio
	ld a,(hl)			;73e0   ; sin pieza, nada
	or a			;73e1
	ret z			;73e2
	ld a,l			;73e3   ; su espera
	add a,005h		;73e4
	ld l,a			;73e6
	dec (hl)			;73e7
	ret nz			;73e8
	dec l			;73e9   ; la espera siguiente: 2, o 10 con el dibujo 0x10 o mas
	dec l			;73ea
	ld a,(hl)			;73eb
	cp 010h		;73ec
	ld a,002h		;73ee
	jr c,L_73F4		;73f0
	ld a,00ah		;73f2
L_73F4:
	inc l			;73f4
	inc l			;73f5
	ld (hl),a			;73f6
	dec l			;73f7
	ld a,(hl)			;73f8   ; cambia de dibujo
	xor 001h		;73f9
	ld (hl),a			;73fb
	inc l			;73fc
	inc l			;73fd
	ld e,(hl)			;73fe   ; su sitio en la pantalla de RAM
	inc l			;73ff
	ld d,(hl)			;7400
	ld hl,07417h		;7401   ; los 2x2 caracteres de p01:7417
	add a,a			;7404
	add a,a			;7405
	call 0407ah		;7406   ; hl_mas_a: HL = HL + A
	ldi		;7409   ; la fila de arriba
	ldi		;740b
	ld a,01eh		;740d
	call 0407fh		;740f   ; de_mas_a: DE = DE + A
	ldi		;7412   ; y la de abajo
	ldi		;7414
	ret			;7416

; ----------------------------------------------------------------------
; DATOS tabla_7417: 4 fichas de 4 bytes que p01:7401 copia con ldi; lo leen
;   p01:7406 (16 bytes)
;   0x7417..0x7427  (16 bytes)
DATA_tabla_7417:
	defb 054h,055h,056h,057h	; 7417
	defb 063h,064h,065h,066h	; 741b
	defb 056h,057h,054h,055h	; 741f
	defb 065h,066h,063h,064h	; 7423

; ======================================================================
; CODIGO 0x7427..0x74aa  (131 bytes)
; ======================================================================


suceso_espera:		; espera 0xE349 cuadros, p01:7918 y 0xE3AA = 1
	ld hl,0e349h		;7427   ; espera
	dec (hl)			;742a
	ret nz			;742b
	call borra_enemigos		;742c   ; p01:7918
	ld hl,00001h		;742f   ; 0xE3AA = 1, 0xE3AB = 0
	ld (0e3aah),hl		;7432   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo y el byte siguiente (16 bits)
	jp suceso_siguiente		;7435   ; suceso_siguiente: el paso siguiente del suceso (0xE34B + 1)
suceso_final:		; con el banco 11, p11:A2A2; con 0xE3AE, 0xE3AA = 0 y 0xE348 = 1
	call 04137h		;7438   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a2a2h		;743b   ; p11:A2A2
	call 04157h		;743e   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e3aeh)		;7441   ; hasta que acabe (0xE3AE)
	and a			;7444
	ret z			;7445
	xor a			;7446
	ld (0e3aah),a		;7447   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo
	inc a			;744a
	ld (0e348h),a		;744b   ; guarda la marca de fin del suceso
	ret			;744e
tipo_32_empieza:		; el tipo 0x32: IX+2F = 0, IX+02 = 4 y la velocidad de 0xF012 (X) y 0xF014 (Y)
	ld (ix+02fh),000h		;744f   ; IX+2F = 0
	ld (ix+002h),004h		;7453   ; IX+02 = 4
	ld de,(0f014h)		;7457   ; la velocidad que dejo el suceso
	ld hl,(0f012h)		;745b   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	jp 04f26h		;745e   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_32:		; el tipo 0x32: parpadea (color 3/9 cada 4 cuadros) y se quita al tocar mapa (por debajo de 0xE305) en su sitio o en la fila hacia la que va
	dec (ix+002h)		;7461   ; cada 4 cuadros
	jr nz,L_7478		;7464
	ld (ix+002h),004h		;7466
	ld a,(ix+031h)		;746a   ; cambia de color: 3 o 9
	cp 003h		;746d
	ld a,003h		;746f
	jr nz,L_7475		;7471
	ld a,009h		;7473
L_7475:
	ld (ix+031h),a		;7475
L_7478:
	ld a,(0e305h)		;7478   ; el primer caracter que no es mapa
	ld c,a			;747b
	ld l,(ix+004h)		;747c
	ld h,(ix+006h)		;747f
	call 05c92h		;7482   ; lo que hay en su sitio
	ld a,(hl)			;7485
	and a			;7486
	jr z,L_748D		;7487
	cp c			;7489   ; mapa: se quita
	jp c,quita_enemigo		;748a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_748D:
	bit 7,(ix+008h)		;748d   ; la fila de debajo si baja, la de arriba si sube
	ld de,00020h		;7491
	jr nz,L_7499		;7494
	ld de,0ffe0h		;7496
L_7499:
	add hl,de			;7499
	ld a,(hl)			;749a
	or a			;749b
	ret z			;749c
	cp c			;749d   ; mapa: se quita
	jp c,quita_enemigo		;749e   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ret			;74a1
final_de_fase_8:		; el final del interior, paso 0xE3C0 (13, p01:74AA): la nave al centro, YOU CAPTURED, el premio (0xE444), las armas y la salida
	ld a,(0e3c0h)		;74a2   ; sin final, nada
	dec a			;74a5
	ret m			;74a6
	call 04084h		;74a7   ; por paso (13)

; ----------------------------------------------------------------------
; DATOS tabla_74AA: 13 destinos del despachador p00:4084 (call en p01:74A7, el
;   indice en A): 74C4, 74E2, 750F, 7543, 7569, 7596, 75DE, 75EF, 7614, 761F,
;   7636, 763E, 7686; lo leen p01:74A7 (26 bytes)
;   0x74aa..0x74c4  (26 bytes)
DATA_tabla_74AA:
	defw 074c4h,074e2h,0750fh,07543h,07569h,07596h,075deh,075efh	; 74aa
	defw 07614h,0761fh,07636h,0763eh,07686h	; 74ba

; ======================================================================
; CODIGO 0x74c4..0x7565  (161 bytes)
; ======================================================================


final_1_al_centro:		; lleva la nave a Y 0x48, X 0x50; al acabar el scroll suena 0xF0 y 0x37
	call nave_al_centro		;74c4   ; la nave al centro
	ret nz			;74c7
	ld a,(0e327h)		;74c8   ; y el scroll acabado
	or a			;74cb
	ret z			;74cc
L_74CD:
	ld hl,00001h		;74cd   ; espera 1
	ld (0e3c3h),hl		;74d0   ; guarda la espera del paso del final y el byte siguiente (16 bits)
	ld a,0f0h		;74d3   ; suena 0xF0 y 0x37
	call 04ae4h		;74d5   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,037h		;74d8
	call 04ae4h		;74da   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
final_siguiente:		; el paso siguiente del final (0xE3C0 + 1)
	ld hl,0e3c0h		;74dd   ; apunta a el paso del final del interior (0 nada)
	inc (hl)			;74e0
	ret			;74e1
final_2_abre:		; cada 10 cuadros, 4 + 4 caracteres de p01:7738 en 0xEE2C/0xEE4C; al cuarto, 60 cuadros
	ld hl,0e3c3h		;74e2   ; cada 10 cuadros
	dec (hl)			;74e5
	ret z			;74e6
	ld (hl),00ah		;74e7
	inc l			;74e9
	ld a,(hl)			;74ea   ; el siguiente de p01:7738 (8 bytes)
	inc (hl)			;74eb
	add a,a			;74ec
	add a,a			;74ed
	add a,a			;74ee
	ld hl,07738h		;74ef
	call 0407ah		;74f2   ; hl_mas_a: HL = HL + A
	ld de,0ee2ch		;74f5   ; 4 caracteres en una fila
	ld bc,00004h		;74f8
	ldir		;74fb
	ld de,0ee4ch		;74fd   ; y 4 en la de abajo
	ld bc,00004h		;7500
	ldir		;7503
	ld a,(0e3c4h)		;7505   ; al cuarto, 60 cuadros y al paso siguiente
	cp 004h		;7508
	ret c			;750a
	ld a,03ch		;750b
	jr L_755F		;750d
final_3_parpadea:		; parpadean los 4 x 4 caracteres de p01:7758 en 0xEE10; al acabar, al paso 1 otra vez con 10 cuadros
	ld hl,0e3c3h		;750f   ; apunta a la espera del paso del final
	dec (hl)			;7512
	jr z,L_753A		;7513
	bit 1,(hl)		;7515   ; cada 2 cuadros cambia
	ld a,000h		;7517
	jr z,pon_4x4		;7519
	inc a			;751b
pon_4x4:		; los 4 x 4 caracteres A de p01:7758 en 0xEE10
	add a,a			;751c   ; 16 bytes por dibujo
	add a,a			;751d
	add a,a			;751e
	add a,a			;751f
	ld hl,07758h		;7520
	call 0407ah		;7523   ; hl_mas_a: HL = HL + A
	ld a,004h		;7526   ; 4 filas de 4 caracteres
	ld de,0ee10h		;7528
L_752B:
	ld bc,00004h		;752b
	ldir		;752e
	ex de,hl			;7530   ; la fila siguiente (28 + 4 = 32)
	ld bc,0001ch		;7531
	add hl,bc			;7534
	ex de,hl			;7535
	dec a			;7536
	jr nz,L_752B		;7537
	ret			;7539
L_753A:
	xor a			;753a   ; el primer dibujo
	call pon_4x4		;753b   ; pon_4x4: los 4 x 4 caracteres A de p01:7758 en 0xEE10
	ld hl,0000ah		;753e   ; y al paso 1 otra vez, 10 cuadros
	jr L_74CD		;7541
final_4_anima:		; cada 4 cuadros, los 4 x 4 de p01:7565; al cuarto, 30 cuadros
	ld hl,0e3c3h		;7543   ; cada 4 cuadros
	dec (hl)			;7546
	ret nz			;7547
	ld (hl),004h		;7548
	inc l			;754a
	ld c,(hl)			;754b   ; el siguiente de p01:7565
	inc (hl)			;754c
	ld b,000h		;754d
	ld hl,07565h		;754f
	add hl,bc			;7552
	ld a,(hl)			;7553
	call pon_4x4		;7554   ; pon_4x4: los 4 x 4 caracteres A de p01:7758 en 0xEE10
	ld a,(0e3c4h)		;7557   ; al cuarto, 30 cuadros y al paso siguiente
	cp 004h		;755a
	ret c			;755c
	ld a,01eh		;755d
L_755F:
	ld (0e3c3h),a		;755f   ; guarda la espera del paso del final
	jp final_siguiente		;7562   ; final_siguiente: el paso siguiente del final (0xE3C0 + 1)

; ----------------------------------------------------------------------
; DATOS tabla_7565: 4 bytes que p01:7543 lee con 0xE3C4; lo leen p01:7552 (4
;   bytes)
;   0x7565..0x7569  (4 bytes)
DATA_tabla_7565:
	defb 002h,003h,004h,001h	; 7565

; ======================================================================
; CODIGO 0x7569..0x7725  (444 bytes)
; ======================================================================


final_5_texto:		; borra 5 filas de 24 en 0xEEE4, p11:B77F y YOU CAPTURED (p01:7725) en 0xEF0A
	ld hl,0e3c3h		;7569   ; apunta a la espera del paso del final
	dec (hl)			;756c
	ret nz			;756d
	ld hl,0eee4h		;756e   ; 5 filas de 24 caracteres a cero
	ld a,005h		;7571
L_7573:
	ld d,h			;7573
	ld e,l			;7574
	inc de			;7575
	ld bc,00017h		;7576
	ld (hl),000h		;7579
	ldir		;757b
	ld bc,00009h		;757d
	add hl,bc			;7580
	dec a			;7581
	jr nz,L_7573		;7582
	call 04b17h		;7584   ; p11:B77F
	ld hl,07725h		;7587   ; YOU CAPTURED
	ld de,0ef0ah		;758a
	ld bc,0000ch		;758d
	ldir		;7590
	ld a,01eh		;7592   ; 30 cuadros y al paso siguiente
	jr $-53		;7594
final_6_premio:		; segun 0xE444: 1 una arma (paso 8), 2 dos (paso 9), si no NOTHING (p01:7731)
	ld hl,0e3c3h		;7596   ; apunta a la espera del paso del final
	dec (hl)			;7599
	ret nz			;759a
	ld a,(0e444h)		;759b   ; el premio
	dec a			;759e
	jr z,L_75B3		;759f
	dec a			;75a1
	jr z,L_75C5		;75a2
	ld hl,07731h		;75a4   ; ninguno: NOTHING
	ld de,0ef4ch		;75a7
	ld bc,00007h		;75aa
	ldir		;75ad
	ld a,01eh		;75af
	jr $-82		;75b1
L_75B3:
	ld a,08bh		;75b3   ; una arma: su rotulo y sus caracteres
	ld hl,03458h		;75b5
	ld de,0ef4ch		;75b8
	call arma_capturada		;75bb   ; arma_capturada: el rotulo del arma 0xE20F (p01:77A8) en la VRAM HL, sus 8 caracteres desde A en DE, la captura (p02:80BD) y suena 0x22
	call casilla_del_arma		;75be   ; casilla_del_arma: 0xE3C5 = la casilla del medidor del arma 0xE20F (p01:77AE) en la fila 22
	ld a,008h		;75c1   ; al paso 8
	jr L_75D5		;75c3
L_75C5:
	ld a,08bh		;75c5   ; dos armas: la primera
	ld hl,03458h		;75c7
	ld de,0ef47h		;75ca
	call arma_capturada		;75cd   ; arma_capturada: el rotulo del arma 0xE20F (p01:77A8) en la VRAM HL, sus 8 caracteres desde A en DE, la captura (p02:80BD) y suena 0x22
	call casilla_del_arma		;75d0   ; casilla_del_arma: 0xE3C5 = la casilla del medidor del arma 0xE20F (p01:77AE) en la fila 22
	ld a,009h		;75d3   ; al paso 9
L_75D5:
	call al_paso_del_final		;75d5   ; al_paso_del_final: 0xE3C0 = A
	ld a,03ch		;75d8   ; 60 cuadros
	ld (0e3c3h),a		;75da   ; guarda la espera del paso del final
	ret			;75dd
final_7_espera:		; espera y al paso 12 con 0xE3AA = 1
	ld hl,0e3c3h		;75de   ; apunta a la espera del paso del final
	dec (hl)			;75e1
	ret nz			;75e2
final_al_12:		; 0xE3AA = 1 y al paso 12
	ld hl,00001h		;75e3
	ld (0e3aah),hl		;75e6   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo y el byte siguiente (16 bits)
	ld a,00ch		;75e9   ; al paso 12
al_paso_del_final:		; 0xE3C0 = A
	ld (0e3c0h),a		;75eb   ; guarda el paso del final del interior (0 nada)
	ret			;75ee
final_parpadea_casilla:		; parpadea la casilla del medidor del arma (0xE3C5); al acabar, el medidor y al paso 12
	ld hl,0e3c3h		;75ef   ; apunta a la espera del paso del final
	dec (hl)			;75f2
	jr z,L_760F		;75f3
casilla_parpadea:		; la casilla de 0xE3C5 encendida o elegida segun el bit 2 de 0xE3C3
	ld hl,(0e3c5h)		;75f5   ; la casilla
	call 04a1dh		;75f8   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	ld a,(0e3c3h)		;75fb   ; lee la espera del paso del final
	bit 2,a		;75fe   ; 0x0B encendida, 0x0D elegida
	ld a,00bh		;7600
	jr z,L_7606		;7602
	ld a,00dh		;7604
L_7606:
	exx			;7606   ; el caracter de la izquierda
	out (c),a		;7607
	exx			;7609
	exx			;760a
	inc a			;760b   ; y el de la derecha
	out (c),a		;760c
	ret			;760e
L_760F:
	call 053a3h		;760f   ; el medidor como queda
	jr final_al_12		;7612
final_9_parpadea:		; parpadea la casilla y luego 30 cuadros mas
	ld hl,0e3c3h		;7614   ; apunta a la espera del paso del final
	dec (hl)			;7617
	jr nz,casilla_parpadea		;7618
	ld a,01eh		;761a   ; 30 cuadros y al paso siguiente
	jp L_755F		;761c
final_10_segunda:		; la segunda arma: su rotulo en 0x3498, sus caracteres 0x93 en 0xEF51; al paso 11
	ld hl,0e3c3h		;761f   ; apunta a la espera del paso del final
	dec (hl)			;7622
	ret nz			;7623
	ld a,093h		;7624   ; la segunda arma, mas abajo
	ld hl,03498h		;7626
	ld de,0ef51h		;7629
	call arma_capturada		;762c   ; arma_capturada: el rotulo del arma 0xE20F (p01:77A8) en la VRAM HL, sus 8 caracteres desde A en DE, la captura (p02:80BD) y suena 0x22
	call casilla_del_arma		;762f   ; casilla_del_arma: 0xE3C5 = la casilla del medidor del arma 0xE20F (p01:77AE) en la fila 22
	ld a,00bh		;7632   ; al paso 11
	jr L_75D5		;7634
final_11_parpadea:		; parpadea la casilla de la segunda arma; luego el medidor y al paso 12
	ld hl,0e3c3h		;7636   ; apunta a la espera del paso del final
	dec (hl)			;7639
	jr nz,casilla_parpadea		;763a
	jr L_760F		;763c
final_12_sale:		; con el banco 11, p11:A2A2 hasta 0xE3AE; entonces la nave se va
	call 04137h		;763e   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a2a2h		;7641   ; p11:A2A2
	call 04157h		;7644   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e3aeh)		;7647   ; hasta que acabe (0xE3AE)
	and a			;764a
	ret z			;764b
	xor a			;764c
	ld (0e3aah),a		;764d   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo
	call nave_se_va		;7650   ; la nave se va
	jp final_siguiente		;7653   ; final_siguiente: el paso siguiente del final (0xE3C0 + 1)
nave_se_va:		; 0xE3BF = 1, 0xE3C7 = 0 y suena 0x3C
	ld a,001h		;7656
	ld (0e3bfh),a		;7658   ; guarda la marca de la nave yendose
	ld hl,00000h		;765b
	ld (0e3c7h),hl		;765e   ; guarda la velocidad de la nave al irse (16 bits) y el byte siguiente (16 bits)
	ld a,03ch		;7661   ; suena 0x3C
	jp 04ae4h		;7663   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
nave_acelera:		; 0xE3C7 + 0x40; al llegar a X 0xF0, pantalla en blanco, sin sprites y 0xE3BF = 0
	ld hl,(0e3c7h)		;7666   ; cada vez mas deprisa
	ld de,00040h		;7669
	add hl,de			;766c
	ld (0e3c7h),hl		;766d   ; guarda la velocidad de la nave al irse (16 bits) y el byte siguiente (16 bits)
	ld a,008h		;7670   ; el dibujo 8
	ld (0e3c2h),a		;7672   ; guarda el dibujo de la nave en el final
	ld a,(0e406h)		;7675   ; hasta X 0xF0
	cp 0f0h		;7678
	ret c			;767a
	call 04a08h		;767b   ; se fue: pantalla en blanco y sin sprites
	call 04c76h		;767e   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	xor a			;7681
	ld (0e3bfh),a		;7682   ; guarda la marca de la nave yendose
	ret			;7685
nave_sale:		; p01:7666 y, al irse, 0xE3C1 = 1
	call nave_acelera		;7686   ; nave_acelera: 0xE3C7 + 0x40; al llegar a X 0xF0, pantalla en blanco, sin sprites y 0xE3BF = 0
	ret c			;7689
	ld a,001h		;768a   ; ya no esta
	ld (0e3c1h),a		;768c   ; guarda la marca de la nave ida
	ret			;768f
arma_capturada:		; el rotulo del arma 0xE20F (p01:77A8) en la VRAM HL, sus 8 caracteres desde A en DE, la captura (p02:80BD) y suena 0x22
	ld (0f004h),a		;7690   ; guarda variable de paso
	ld (0f000h),hl		;7693   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld (0f002h),de		;7696   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld a,(0e20fh)		;769a   ; el rotulo del arma capturada
	ld hl,077a8h		;769d
	call 05ca6h		;76a0   ; byte_a: A = el byte A de la tabla HL
	ld hl,(0f000h)		;76a3   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	call 053f9h		;76a6   ; pon_rotulo_en: el rotulo A en la VRAM HL
	ld hl,(0f000h)		;76a9   ; sus colores (0x2000 menos) con 0xA4
	ld bc,0e000h		;76ac   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	add hl,bc			;76af
	ld bc,00040h		;76b0
	ld a,0a4h		;76b3
	call 00056h		;76b5   ; BIOS FILVRM - Fills VRAM with value
	ld b,008h		;76b8   ; 8 caracteres seguidos en la pantalla de RAM
	ld a,(0f004h)		;76ba   ; lee variable de paso
	ld hl,(0f002h)		;76bd   ; lee variable de paso: el puntero del mapa y el byte siguiente (16 bits)
L_76C0:
	ld (hl),a			;76c0
	inc a			;76c1
	inc hl			;76c2
	djnz L_76C0		;76c3
	ld a,001h		;76c5   ; se queda con el arma (p02:80BD)
	call 080bdh		;76c7   ; captura_armas: captura A armas (0xE20F + A, como mucho 7), rehace el medidor y lo pinta
	ld a,022h		;76ca   ; suena 0x22
	jp 04ae4h		;76cc   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
casilla_del_arma:		; 0xE3C5 = la casilla del medidor del arma 0xE20F (p01:77AE) en la fila 22
	ld hl,077aeh		;76cf   ; la casilla del arma
	ld a,(0e20fh)		;76d2   ; lee las armas capturadas (0-7)
	call 05ca6h		;76d5   ; byte_a: A = el byte A de la tabla HL
	add a,a			;76d8   ; x 2 - 1
	sub 001h		;76d9
	ld hl,03ac0h		;76db   ; en la fila 22
	call 0407ah		;76de   ; hl_mas_a: HL = HL + A
	ld (0e3c5h),hl		;76e1   ; guarda la casilla que parpadea en el final (VRAM, 16 bits) y el byte siguiente (16 bits)
	ret			;76e4
nave_al_centro:		; un pixel hacia Y 0x48 y X 0x50, su dibujo (0xE3C2), p03:A82E y p03:A79A; Z al llegar
	ld hl,0e404h		;76e5   ; la Y de la nave
	ld a,(hl)			;76e8
	cp 048h		;76e9   ; hacia 0x48
	ld c,000h		;76eb
	jr z,L_76F9		;76ed
	ld bc,00102h		;76ef
	jr c,L_76F7		;76f2
	ld bc,0ff01h		;76f4
L_76F7:
	add a,b			;76f7
	ld (hl),a			;76f8
L_76F9:
	ld d,a			;76f9   ; la X
	inc l			;76fa
	inc l			;76fb
	ld a,(hl)			;76fc
	cp 050h		;76fd   ; hacia 0x50
	ld b,000h		;76ff
	jr z,L_770F		;7701
	ld e,001h		;7703
	ld b,008h		;7705
	jr c,L_770D		;7707
	ld e,0ffh		;7709
	ld b,004h		;770b
L_770D:
	add a,e			;770d
	ld (hl),a			;770e
L_770F:
	ld e,a			;770f
	push de			;7710
	push bc			;7711
	call 0a82eh		;7712   ; p03:A82E
	pop bc			;7715
	ld a,c			;7716   ; el dibujo segun hacia donde va
	or b			;7717
	ld bc,0e3c2h		;7718   ; apunta a el dibujo de la nave en el final
	ld (bc),a			;771b
	call 0a79ah		;771c   ; p03:A79A
	pop de			;771f
	ld hl,04850h		;7720   ; Z si ha llegado a Y 0x48, X 0x50
	rst 20h			;7723
	ret			;7724

; ----------------------------------------------------------------------
; DATOS inicio_EF0A: 12 bytes que p01:7587 copia a 0xEF0A; lo leen p01:7587
;   (12 bytes)
;   0x7725..0x7731  (12 bytes)
DATA_inicio_EF0A:
	defb 0bbh,0bch,0bdh,000h,0beh,0bfh,0c0h,0c1h,0bdh,0c2h,0c3h,0c4h	; 7725  ............

; ----------------------------------------------------------------------
; DATOS inicio_EF4C: 7 bytes que p01:75A4 copia a 0xEF4C; lo leen p01:75A4 (7
;   bytes)
;   0x7731..0x7738  (7 bytes)
DATA_inicio_EF4C:
	defb 0c5h,0bch,0c1h,0c6h,09bh,0c5h,09ch	; 7731

; ----------------------------------------------------------------------
; DATOS tabla_7738: 4 fichas de 8 bytes que p01:74EC copia a 0xEE2C y 0xEE4C;
;   lo leen p01:74F2 (32 bytes)
;   0x7738..0x7758  (32 bytes)
DATA_tabla_7738:
	defb 0b1h,000h,000h,000h,0b2h,000h,000h,000h	; 7738  ........
	defb 0b1h,0b3h,000h,000h,0b2h,0b4h,000h,000h	; 7740  ........
	defb 0b1h,0b3h,0b5h,000h,0b2h,0b4h,0b6h,000h	; 7748  ........
	defb 0b1h,0b3h,0b5h,0b7h,0b2h,0b4h,0b6h,0b8h	; 7750  ........

; ----------------------------------------------------------------------
; DATOS tabla_7758: 10 fichas de 8 bytes que p01:751D copia a 0xEE10; lo leen
;   p01:7523 (80 bytes)
;   0x7758..0x77a8  (80 bytes)
DATA_tabla_7758:
	defb 028h,09dh,09eh,038h,09fh,0a0h,0a1h,0a2h	; 7758  (..8....
	defb 0a3h,0a4h,0a5h,0a6h,048h,065h,065h,058h	; 7760  ....HeeX
	defb 028h,0a7h,0a8h,038h,0a9h,0aah,0abh,0ach	; 7768  (..8....
	defb 0adh,0aeh,0afh,0b0h,048h,0bah,0bah,058h	; 7770  ....H..X
	defb 028h,09dh,09eh,038h,09fh,0a0h,0a1h,0ach	; 7778  (..8....
	defb 0a3h,0a4h,0a5h,0b0h,048h,065h,065h,058h	; 7780  ....HeeX
	defb 028h,09dh,0a8h,038h,09fh,0a0h,0abh,0ach	; 7788  (..8....
	defb 0a3h,0a4h,0afh,0b0h,048h,065h,0bah,058h	; 7790  ....He.X
	defb 028h,0a7h,0a8h,038h,09fh,0aah,0abh,0ach	; 7798  (..8....
	defb 0a3h,0aeh,0afh,0b0h,048h,0bah,0bah,058h	; 77a0  ....H..X

; ----------------------------------------------------------------------
; DATOS tabla_77A8: 6 bytes que p01:769A lee con las armas capturadas
;   (0xE20F); lo leen p01:76A0 (6 bytes)
;   0x77a8..0x77ae  (6 bytes)
DATA_tabla_77A8:
	defb 00ah,00ch,005h,008h,010h,006h	; 77a8

; ----------------------------------------------------------------------
; DATOS tabla_77AE: 8 bytes, uno por cada cuenta de armas capturadas (0xE20F),
;   que p01:76CF lee; lo leen p01:76D5 (8 bytes)
;   0x77ae..0x77b6  (8 bytes)
DATA_tabla_77AE:
	defb 009h,004h,005h,002h,003h,006h,003h,004h	; 77ae  ........

; ======================================================================
; CODIGO 0x77b6..0x7825  (111 bytes)
; ======================================================================


sprites_a_vram:		; los 32 sprites de 0xE280 a la VRAM (0x3B00): sin nave en orden, si no rotando el orden cada cuadro (0xE304)
	ld hl,03b00h		;77b6   ; la tabla de atributos de sprite
	call 04a1dh		;77b9   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;77bc
	ld a,(0e400h)		;77bd   ; sin nave (0xFF), en orden
	inc a			;77c0
	jr z,L_77E6		;77c1
	ld hl,0e304h		;77c3   ; el primero de este cuadro: 7 sprites mas alla
	ld a,(hl)			;77c6
	add a,01ch		;77c7
	and 07ch		;77c9
	ld (hl),a			;77cb
	ld e,a			;77cc
	ld d,020h		;77cd   ; 32 sprites
L_77CF:
	ld a,e			;77cf
	ld hl,0e280h		;77d0   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	add a,l			;77d3
	ld l,a			;77d4
	ld b,004h		;77d5   ; 4 bytes por sprite
L_77D7:
	outi		;77d7
	jp nz,L_77D7		;77d9
	ld a,e			;77dc   ; el siguiente: 3 sprites mas alla
	add a,00ch		;77dd
	and 07ch		;77df
	ld e,a			;77e1
	dec d			;77e2
	jr nz,L_77CF		;77e3
	ret			;77e5
L_77E6:
	ld hl,0e280h		;77e6   ; los 32 en orden
	ld b,080h		;77e9
L_77EB:
	outi		;77eb
	jp nz,L_77EB		;77ed
	ret			;77f0
pantalla_a_vram:		; las 22 filas de la pantalla de RAM (0xED00) a la tabla de nombres, movidas un caracter si tiembla (0xE34E)
	ld hl,03800h		;77f1   ; la tabla de nombres
	call 04a1dh		;77f4   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;77f7
	ld hl,0ed00h		;77f8   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	ld a,(0e34eh)		;77fb   ; tiembla?
	or a			;77fe
	jr z,L_7808		;77ff
	ld de,00001h		;7801   ; un caracter a un lado o al otro
	call m,05cadh		;7804   ; menos_de: DE = - DE
	add hl,de			;7807
L_7808:
	ld b,000h		;7808   ; 256 + 256 + 192 bytes: 22 filas
L_780A:
	outi		;780a
	jp nz,L_780A		;780c
L_780F:
	outi		;780f
	jp nz,L_780F		;7811
	ld b,0c0h		;7814
L_7816:
	outi		;7816
	jp nz,L_7816		;7818
	ret			;781b
final_de_fase_0:		; el paso 0xEA98 del final de la fase 0 (p01:7827)
	ld hl,0ea98h		;781c   ; sin final de fase 0, nada
	ld a,(hl)			;781f
	dec a			;7820
	ret m			;7821
	call 04084h		;7822   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_7825: 5 destinos del despachador p00:4084 (call en p01:7822, el
;   indice en A): 782F, 7872, 78CD, 78E3, 790B; lo leen p01:7822 (10 bytes)
;   0x7825..0x782f  (10 bytes)
DATA_tabla_7825:
	defw 0782fh,07872h,078cdh,078e3h,0790bh	; 7825

; ======================================================================
; CODIGO 0x782f..0x786a  (59 bytes)
; ======================================================================


fase_0_empieza:		; el nucleo de la fase 0: 100 golpes (0xEA12), su sitio, los sprites p09:BF6D y sus caracteres
	ld hl,0ea98h		;782f   ; al paso siguiente
	inc (hl)			;7832
	inc l			;7833
	ld (hl),050h		;7834   ; [0x50][0xA0][1][0]
	inc l			;7836
	ld (hl),0a0h		;7837
	inc l			;7839
	ld (hl),001h		;783a
	inc l			;783c
	ld (hl),000h		;783d
	xor a			;783f
	ld (0e345h),a		;7840   ; guarda la marca de nucleo destruido
	ld (0e348h),a		;7843   ; guarda la marca de fin del suceso
	ld a,003h		;7846   ; 0xE34D = 3
	ld (0e34dh),a		;7848   ; guarda dato del jefe (1 al salir, 3 el nucleo)
	ld a,064h		;784b   ; 100 golpes
	ld (0ea12h),a		;784d   ; guarda los golpes que le quedan al nucleo de la fase 0
	call 04b51h		;7850   ; sus sprites
nucleo_entero:		; los 2 x 2 caracteres de p01:786A en 0xEE57 y 0xEE77
	ld hl,0786ah		;7853
pon_2x2_ee57:		; los 2 x 2 caracteres HL en 0xEE57 y 0xEE77
	ld de,0ee57h		;7856   ; la fila de arriba
	ldi		;7859
	ldi		;785b
	ld de,0ee77h		;785d   ; y la de abajo
	ldi		;7860
	ldi		;7862
	ret			;7864
nucleo_roto:		; los 2 x 2 caracteres de p01:786E
	ld hl,0786eh		;7865
	jr pon_2x2_ee57		;7868

; ----------------------------------------------------------------------
; DATOS tabla_786A: 8 bytes que p01:7853 copia de dos en dos a la tabla de
;   nombres de la RAM; lo leen p01:7853 (8 bytes)
;   0x786a..0x7872  (8 bytes)
DATA_tabla_786A:
	defb 096h,0a2h,0aeh,0bah,095h,0a1h,0adh,0b9h	; 786a  ........

; ======================================================================
; CODIGO 0x7872..0x79b3  (321 bytes)
; ======================================================================


fase_0_nucleo:		; dispara (p01:78AE) y parpadea por debajo de 32 golpes; destruido (0xE345): 0x0500 puntos, suena 0x39 y tiembla
	ld a,(0e345h)		;7872   ; destruido?
	or a			;7875
	jr nz,L_788B		;7876
	call nucleo_dispara		;7878   ; dispara
	ld a,(0ea12h)		;787b   ; con menos de 32 golpes, parpadea
	cp 020h		;787e
	jr nc,$-45		;7880
	ld a,(0e1c3h)		;7882   ; lee la cuenta de cuadros
	bit 2,a		;7885
	jr z,$-52		;7887
	jr $-36		;7889
L_788B:
	ld de,00500h		;788b   ; 0x0500 puntos (BCD)
	call 05b04h		;788e   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	call nucleo_roto		;7891   ; roto
	xor a			;7894
	ld (0e345h),a		;7895   ; guarda la marca de nucleo destruido
	ld a,078h		;7898   ; 120 cuadros de temblor
	ld (0ea9dh),a		;789a   ; guarda los cuadros de temblor
	ld a,039h		;789d   ; suena 0x39
	call 04ae4h		;789f   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,a			;78a2
	ld (0e300h),a		;78a3   ; guarda la marca de 0xE300
	call borra_enemigos		;78a6   ; p01:7918
L_78A9:
	ld hl,0ea98h		;78a9   ; apunta a el paso del final de la fase 0
	inc (hl)			;78ac
	ret			;78ad
nucleo_dispara:		; cada 18 cuadros (12 con menos de 32 golpes), una bala desde p09:9C38 o p09:9C63
	ld hl,0ea9bh		;78ae   ; la espera
	dec (hl)			;78b1
	ret nz			;78b2
	ld a,(0ea12h)		;78b3   ; 18 cuadros, 12 con menos de 32 golpes
	cp 020h		;78b6
	ld a,012h		;78b8
	jr nc,L_78BE		;78ba
	ld a,00ch		;78bc
L_78BE:
	ld (hl),a			;78be
	inc l			;78bf   ; uno de cada dos
	inc (hl)			;78c0
	bit 1,(hl)		;78c1
	ld de,09c38h		;78c3   ; desde p09:9C38 o p09:9C63
	jr z,L_78CA		;78c6
	ld e,063h		;78c8
L_78CA:
	jp 0938fh		;78ca   ; una bala a la nave
fase_0_tiembla:		; la pantalla tiembla 0xEA9D cuadros (0xE34E); luego 0xE3AA = 1
	ld hl,0ea9dh		;78cd   ; tiembla mientras dure
	dec (hl)			;78d0
	jr z,L_78DB		;78d1
	ld a,(hl)			;78d3   ; 0 o 1 cada dos cuadros
	rra			;78d4
	and 001h		;78d5
	ld (0e34eh),a		;78d7   ; guarda el temblor de la pantalla (0, 1 o -1)
	ret			;78da
L_78DB:
	ld hl,00001h		;78db   ; se acabo
	ld (0e3aah),hl		;78de   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo y el byte siguiente (16 bits)
	jr L_78A9		;78e1
fase_0_sale:		; tiembla al azar y p11:A2A2 hasta 0xE3AE
	ld a,(0e1c3h)		;78e3   ; un temblor al azar: -1, 0 o 1
	and 003h		;78e6
	dec a			;78e8
	cp 002h		;78e9
	jr nz,L_78EE		;78eb
	xor a			;78ed
L_78EE:
	ld (0e34eh),a		;78ee   ; guarda el temblor de la pantalla (0, 1 o -1)
	call 04137h		;78f1   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a2a2h		;78f4   ; p11:A2A2 hasta que acabe
	call 04157h		;78f7   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	ld a,(0e3aeh)		;78fa   ; lee la marca de fin de p11:A2A2
	and a			;78fd
	ret z			;78fe
	xor a			;78ff   ; sin temblor
	ld (0e3aah),a		;7900   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo
	ld (0e34eh),a		;7903   ; guarda el temblor de la pantalla (0, 1 o -1)
	call nave_se_va		;7906   ; la nave se va
	jr L_78A9		;7909
fase_0_nave_sale:		; la nave se va (p01:7666); al irse, 0xEA98 = 0 y 0xE348 = 1
	call nave_acelera		;790b   ; nave_acelera: 0xE3C7 + 0x40; al llegar a X 0xF0, pantalla en blanco, sin sprites y 0xE3BF = 0
	ret c			;790e
	xor a			;790f   ; se acabo el final de la fase 0
	ld (0ea98h),a		;7910   ; guarda el paso del final de la fase 0
	inc a			;7913
	ld (0e348h),a		;7914   ; guarda la marca de fin del suceso
	ret			;7917
borra_enemigos:		; 0xE600-0xE99F a cero y las cuentas de enemigos y sprites
	ld hl,0e600h		;7918   ; los 12 enemigos y las 10 fichas de 0xE900
	ld de,0e601h		;791b
	ld bc,0039fh		;791e
	ld (hl),000h		;7921
	ldir		;7923
	xor a			;7925   ; sin enemigos ni sprites ocupados
	ld (0e352h),a		;7926   ; guarda cuantos enemigos se han creado
	ld (0e355h),a		;7929   ; guarda los sprites ocupados por enemigos (maximo 12)
	ld (0e36dh),a		;792c   ; guarda cuantos enemigos 0x2A hay
	ret			;792f
cuenta_objetos:		; 0xE3B2 = hasta donde hay fichas ocupadas en 0xE500 (8 de 16 bytes)
	ld hl,0e570h		;7930   ; de la ultima ficha hacia atras
	ld de,0fff0h		;7933
	ld bc,00808h		;7936
L_7939:
	ld a,(hl)			;7939
	and a			;793a
	jr nz,L_7941		;793b
	dec c			;793d   ; libre: una menos
	add hl,de			;793e
	djnz L_7939		;793f
L_7941:
	ld a,c			;7941   ; cuantas hay
	ld (0e3b2h),a		;7942   ; guarda cuantas fichas de objetos de caracteres hay (0xE500)
	ret			;7945
mueve_objetos:		; sin jefe con partes, cada objeto de caracteres de 0xE500: lo de su clase, si se ve, y el scroll
	call hay_jefe_con_partes		;7946   ; con jefe con partes, nada
	ret nz			;7949
	ld ix,0e500h		;794a   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld a,(0e3b2h)		;794e   ; cuantas fichas
	and a			;7951
	ret z			;7952
	ld b,a			;7953
L_7954:
	push bc			;7954
	call mueve_objeto		;7955   ; mueve_objeto: lo de la clase (p01:79B3), IX+0D y 8 pixeles a la izquierda con cada paso de scroll; al salir, libre
	pop bc			;7958
	ld de,00010h		;7959   ; 16 bytes por ficha
	add ix,de		;795c
	djnz L_7954		;795e
	ret			;7960
mueve_objeto:		; lo de la clase (p01:79B3), IX+0D y 8 pixeles a la izquierda con cada paso de scroll; al salir, libre
	ld a,(ix+000h)		;7961   ; libre
	and a			;7964
	ret z			;7965
	call lo_de_la_clase		;7966   ; lo_de_la_clase: la rutina de la clase A (16, p01:79B3)
	call objeto_visible		;7969   ; objeto_visible: IX+0D = 0xFF cerca del borde derecho (X >= 0xE0); 0 si no (las clases 1 y 3 lo dejan)
	ld a,(0e320h)		;796c   ; solo con scroll
	and a			;796f
	ret z			;7970
	ld a,(ix+006h)		;7971   ; 8 pixeles a la izquierda
	sub 008h		;7974
	jr c,L_797C		;7976
	ld (ix+006h),a		;7978
	ret			;797b
L_797C:
	ld (ix+000h),000h		;797c   ; ha salido: libre
	ret			;7980
objeto_visible:		; IX+0D = 0xFF cerca del borde derecho (X >= 0xE0); 0 si no (las clases 1 y 3 lo dejan)
	ld a,(ix+000h)		;7981   ; estas clases no
	cp 002h		;7984
	ret z			;7986
	cp 004h		;7987
	ret z			;7989
	cp 006h		;798a
	ret z			;798c
	cp 007h		;798d
	ret z			;798f
	cp 00bh		;7990
	ret z			;7992
	cp 00eh		;7993
	ret z			;7995
	cp 010h		;7996
	ret z			;7998
	ld a,(ix+006h)		;7999   ; cerca del borde derecho: 0xFF
	cp 0e0h		;799c
	ld a,0ffh		;799e
	jr nc,L_79AB		;79a0
	ld a,(ix+000h)		;79a2   ; las clases 1 y 3 lo dejan como esta
	dec a			;79a5
	ret z			;79a6
	cp 002h		;79a7
	ret z			;79a9
	xor a			;79aa
L_79AB:
	ld (ix+00dh),a		;79ab
L_79AE:
	ret			;79ae
lo_de_la_clase:		; la rutina de la clase A (16, p01:79B3)
	dec a			;79af
	call 04084h		;79b0   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_79B3: 16 destinos del despachador p00:4084 (call en p01:79B0, el
;   indice en A): B483, 79AE, 79AE, B89F, B992, BBB6, A141, 7A2D, B3A7, B773,
;   79E5, 79EE, 79F7, 79D3, 79AE, 79DC; lo leen p01:79B0 (32 bytes)
;   0x79b3..0x79d3  (32 bytes)
DATA_tabla_79B3:
	defw 0b483h,079aeh,079aeh,0b89fh,0b992h,0bbb6h,0a141h,07a2dh	; 79b3
	defw 0b3a7h,0b773h,079e5h,079eeh,079f7h,079d3h,079aeh,079dch	; 79c3

; ======================================================================
; CODIGO 0x79d3..0x7a34  (97 bytes)
; ======================================================================


clase_be62:		; con el banco 11, p11:BE62
	call 04137h		;79d3   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0be62h		;79d6
	jp 04157h		;79d9   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_bb06:		; con el banco 11, p11:BB06
	call 04137h		;79dc   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0bb06h		;79df
	jp 04157h		;79e2   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a3c5:		; con el banco 11, p11:A3C5
	call 04137h		;79e5   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a3c5h		;79e8
	jp 04157h		;79eb   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a4e2:		; con el banco 11, p11:A4E2
	call 04137h		;79ee   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a4e2h		;79f1
	jp 04157h		;79f4   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a82e:		; con el banco 11, p11:A82E
	call 04137h		;79f7   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a82eh		;79fa
	jp 04157h		;79fd   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
enemigos_contra_el_mapa:		; los tipos 0x1D, 0x20 y 0x22 (sin IX+2F) se quitan al tocar el mapa (p02:9317)
	ld ix,0e600h		;7a00   ; 12 fichas de enemigo
	ld b,00ch		;7a04
L_7A06:
	ld a,(ix+02fh)		;7a06   ; con IX+2F no
	and a			;7a09
	jr nz,L_7A26		;7a0a
	ld a,(ix+000h)		;7a0c
	and a			;7a0f
	jr z,L_7A26		;7a10
	cp 01dh		;7a12   ; los tipos 0x1D, 0x20 y 0x22
	jr z,L_7A1E		;7a14
	cp 020h		;7a16
	jr z,L_7A1E		;7a18
	cp 022h		;7a1a
	jr nz,L_7A26		;7a1c
L_7A1E:
	call 09317h		;7a1e   ; toca el mapa (p02:9317)?
	jr nc,L_7A26		;7a21
	call quita_enemigo		;7a23   ; se quita
L_7A26:
	ld de,00040h		;7a26
	add ix,de		;7a29
	djnz L_7A06		;7a2b
L_7A2D:
	ret			;7a2d
guion_de_la_fase:		; lo de la fase (12, p01:7A34), paso 0xE205: al acabar el scroll el jefe, y al vencerlo el interior
	ld a,(0e201h)		;7a2e   ; por fase (12)
	call 04084h		;7a31   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_7A34: 12 destinos del despachador p00:4084 (call en p01:7A31, el
;   indice en A): 7A4C, 7A70, 7AA0, 7AB4, 7AE6, 7B2D, 7B67, 7B9A, 7BCF, 7C0C,
;   7BFD, 7C0C; lo leen p01:7A31 (24 bytes)
;   0x7a34..0x7a4c  (24 bytes)
DATA_tabla_7A34:
	defw 07a4ch,07a70h,07aa0h,07ab4h,07ae6h,07b2dh,07b67h,07b9ah	; 7a34
	defw 07bcfh,07c0ch,07bfdh,07c0ch	; 7a44  -> guion_fase_8 guion_fase_9_11 guion_fase_10 guion_fase_9_11

; ======================================================================
; CODIGO 0x7a4c..0x7ce6  (666 bytes)
; ======================================================================


guion_fase_0:		; al acabar el scroll, el nucleo (0xEA98 = 1); al irse la nave, el final del juego (0xE1E6, 0xE1D6)
	ld a,(0e205h)		;7a4c   ; paso 1?
	dec a			;7a4f
	jr z,L_7A5F		;7a50
	ld a,(0e327h)		;7a52   ; paso 0: al acabar el scroll
	and a			;7a55
	ret z			;7a56
	ld a,001h		;7a57   ; el nucleo
	ld (0ea98h),a		;7a59   ; guarda el paso del final de la fase 0
	jp guion_siguiente		;7a5c   ; guion_siguiente: el paso siguiente del guion de la fase (0xE205 + 1)
L_7A5F:
	ld a,(0e348h)		;7a5f   ; paso 1: cuando la nave se ha ido
	or a			;7a62
	ret z			;7a63
	xor a			;7a64
	ld (0e348h),a		;7a65   ; guarda la marca de fin del suceso
	inc a			;7a68   ; el final del juego, con textos
	ld (0e1e6h),a		;7a69   ; guarda la marca del final (estado 10)
	ld (0e1d6h),a		;7a6c   ; guarda la marca del final con textos
	ret			;7a6f
guion_fase_1:		; al acabar el scroll el jefe 1; vencido, al interior
	ld a,(0e205h)		;7a70   ; paso 1: esperando a que lo venzan
	dec a			;7a73
	jp z,jefe_vencido		;7a74   ; jefe_vencido: con el jefe vencido (0xE342), al interior
	ld a,(0e327h)		;7a77   ; paso 0: al acabar el scroll
	or a			;7a7a
	ret z			;7a7b
	call guion_siguiente		;7a7c   ; guion_siguiente: el paso siguiente del guion de la fase (0xE205 + 1)
	ld l,001h		;7a7f   ; el jefe 1
sale_el_jefe:		; el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	xor a			;7a81   ; jefe sin vencer
	ld (0e345h),a		;7a82   ; guarda la marca de nucleo destruido
	ld (0e342h),a		;7a85   ; guarda la marca de jefe vencido
	ld h,a			;7a88   ; 0xE340 = L, 0xE341 = 0
	ld (0e340h),hl		;7a89   ; guarda el tipo de jefe (1-5; 0 sin jefe) y el byte siguiente (16 bits)
	ld l,a			;7a8c   ; la pelea a cero
	ld (0e346h),hl		;7a8d   ; guarda los cuadros de pelea con el jefe (16 bits) y el byte siguiente (16 bits)
	ld a,001h		;7a90
	ld (0e34dh),a		;7a92   ; guarda dato del jefe (1 al salir, 3 el nucleo)
	ld a,008h		;7a95
	ld (0e343h),a		;7a97   ; guarda dato del jefe (8 al salir)
	ld a,070h		;7a9a
	ld (0e305h),a		;7a9c   ; guarda dato de la fase de p01:697A
	ret			;7a9f
guion_fase_2:		; al acabar el scroll el jefe 4; vencido, al interior
	ld a,(0e205h)		;7aa0   ; paso 1: esperando a que lo venzan
	dec a			;7aa3
	jp z,jefe_vencido		;7aa4   ; jefe_vencido: con el jefe vencido (0xE342), al interior
	ld a,(0e327h)		;7aa7   ; lee la marca de fin del scroll
	and a			;7aaa
	ret z			;7aab
	ld l,004h		;7aac   ; el jefe 4
	call sale_el_jefe		;7aae   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	jp guion_siguiente		;7ab1   ; guion_siguiente: el paso siguiente del guion de la fase (0xE205 + 1)
guion_fase_3:		; con 0xE3D0, al acabar el scroll la fase 9 (y despues la 4, o la 2 con 0xE20A impar); si no, el jefe 4 y al interior
	ld a,(0e3d0h)		;7ab4   ; con 0xE3D0, a otra fase
	and a			;7ab7
	jr z,L_7AD3		;7ab8
	ld a,(0e327h)		;7aba   ; lee la marca de fin del scroll
	and a			;7abd
	ret z			;7abe
	ld bc,00409h		;7abf   ; la 9, y luego la 4
a_la_subfase:		; 0xE22A = B (B - 2 con 0xE20A impar) y a la fase C
	ld a,(0e20ah)		;7ac2   ; con 0xE20A impar, dos menos
	bit 0,a		;7ac5
	jr z,L_7ACB		;7ac7
	dec b			;7ac9
	dec b			;7aca
L_7ACB:
	ld a,b			;7acb
	ld (0e22ah),a		;7acc   ; guarda la fase que sigue al interior
	ld a,c			;7acf
	jp a_la_fase		;7ad0   ; a_la_fase: fase A: silencio, guion y jefe a cero y la pantalla de la fase (p01:60D1)
L_7AD3:
	ld a,(0e205h)		;7ad3   ; lee el paso del guion de la fase
	dec a			;7ad6
	jp z,jefe_vencido		;7ad7   ; jefe_vencido: con el jefe vencido (0xE342), al interior
	ld a,(0e327h)		;7ada   ; lee la marca de fin del scroll
	and a			;7add
	ret z			;7ade
	ld l,004h		;7adf   ; el jefe 4
	call sale_el_jefe		;7ae1   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	jr guion_siguiente		;7ae4
guion_fase_4:		; al acabar el scroll 600 cuadros mas, el final se alarga a 0x220, el jefe 5, luego el 2 y al interior
	ld a,(0e205h)		;7ae6   ; el paso
	dec a			;7ae9
	jr z,L_7B03		;7aea
	dec a			;7aec
	jr z,L_7B15		;7aed
	dec a			;7aef
	jr z,L_7B21		;7af0
	dec a			;7af2
	jp z,jefe_vencido		;7af3   ; jefe_vencido: con el jefe vencido (0xE342), al interior
	ld a,(0e327h)		;7af6   ; lee la marca de fin del scroll
	and a			;7af9
	ret z			;7afa
	ld hl,00258h		;7afb   ; paso 0: al acabar el scroll, 600 cuadros
	ld (0e3a8h),hl		;7afe   ; guarda la espera de la fase 4 (16 bits) y el byte siguiente (16 bits)
	jr guion_siguiente		;7b01
L_7B03:
	ld hl,(0e3a8h)		;7b03   ; paso 1: los cuenta
	dec hl			;7b06
	ld (0e3a8h),hl		;7b07   ; guarda la espera de la fase 4 (16 bits) y el byte siguiente (16 bits)
	ld a,l			;7b0a
	or h			;7b0b
	ret nz			;7b0c
	ld hl,00220h		;7b0d   ; y el scroll sigue hasta la columna 0x220
	ld (0e325h),hl		;7b10   ; guarda la columna en la que acaba el scroll (16 bits) y el byte siguiente (16 bits)
	jr guion_siguiente		;7b13
L_7B15:
	ld a,(0e327h)		;7b15   ; paso 2: al acabar, el jefe 5
	and a			;7b18
	ret z			;7b19
	ld l,005h		;7b1a
	call sale_el_jefe		;7b1c   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	jr guion_siguiente		;7b1f
L_7B21:
	ld a,(0e342h)		;7b21   ; paso 3: vencido, el jefe 2
	and a			;7b24
	ret z			;7b25
	ld l,002h		;7b26
	call sale_el_jefe		;7b28   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	jr guion_siguiente		;7b2b
guion_fase_5:		; al acabar el scroll p03:A017; con 0xE348 el scroll sigue 32 columnas, el jefe 2 y al interior
	ld a,(0e205h)		;7b2d   ; lee el paso del guion de la fase
	dec a			;7b30
	jr z,L_7B48		;7b31
	dec a			;7b33
	jr z,L_7B58		;7b34
	dec a			;7b36
	jp z,jefe_vencido		;7b37   ; jefe_vencido: con el jefe vencido (0xE342), al interior
	ld a,(0e327h)		;7b3a   ; lee la marca de fin del scroll
	and a			;7b3d
	ret z			;7b3e
	xor a			;7b3f   ; paso 0: al acabar el scroll, p03:A017
	ld (0e348h),a		;7b40   ; guarda la marca de fin del suceso
	call 0a017h		;7b43
	jr guion_siguiente		;7b46
L_7B48:
	ld hl,0e348h		;7b48   ; paso 1: con 0xE348, 32 columnas mas
	ld a,(hl)			;7b4b
	or a			;7b4c
	ret z			;7b4d
	xor a			;7b4e
	ld (hl),a			;7b4f
	ld de,00020h		;7b50
	call alarga_el_scroll		;7b53   ; alarga_el_scroll: el final del scroll (0xE325) + DE
	jr guion_siguiente		;7b56
L_7B58:
	ld a,(0e327h)		;7b58   ; paso 2: al acabar, el jefe 2
	and a			;7b5b
	ret z			;7b5c
	ld l,002h		;7b5d
	call sale_el_jefe		;7b5f   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
guion_siguiente:		; el paso siguiente del guion de la fase (0xE205 + 1)
	ld hl,0e205h		;7b62   ; apunta a el paso del guion de la fase
	inc (hl)			;7b65
	ret			;7b66
guion_fase_6:		; con 0xE3D0, la fase 10 (y despues la 7, o la 5); si no, al acabar el scroll el suceso 0xE34B y al interior sin jefe
	ld a,(0e3d0h)		;7b67   ; con 0xE3D0, a otra fase
	and a			;7b6a
	jr z,L_7B78		;7b6b
	ld a,(0e327h)		;7b6d   ; lee la marca de fin del scroll
	and a			;7b70
	ret z			;7b71
	ld bc,0070ah		;7b72   ; la 10, y luego la 7
	jp a_la_subfase		;7b75   ; a_la_subfase: 0xE22A = B (B - 2 con 0xE20A impar) y a la fase C
L_7B78:
	ld a,(0e205h)		;7b78   ; lee el paso del guion de la fase
	dec a			;7b7b
	jr z,L_7B8D		;7b7c
	ld a,(0e327h)		;7b7e   ; lee la marca de fin del scroll
	and a			;7b81
	ret z			;7b82
	xor a			;7b83   ; paso 0: al acabar el scroll, el suceso
	ld (0e348h),a		;7b84   ; guarda la marca de fin del suceso
	inc a			;7b87
	ld (0e34bh),a		;7b88   ; guarda el paso del suceso (0 nada)
	jr guion_siguiente		;7b8b
L_7B8D:
	ld hl,0e348h		;7b8d   ; paso 1: acabado el suceso, al interior
	ld a,(hl)			;7b90
	or a			;7b91
	ret z			;7b92
	xor a			;7b93
	ld (hl),a			;7b94
	ld (0e34bh),a		;7b95   ; guarda el paso del suceso (0 nada)
	jr a_la_siguiente		;7b98
guion_fase_7:		; al acabar el scroll 0xE3BE = 1; con 0xE38D el scroll sigue 32 columnas, el jefe 3 y, vencido, el final (0xE1E6)
	ld a,(0e205h)		;7b9a   ; lee el paso del guion de la fase
	dec a			;7b9d
	jr z,L_7BB2		;7b9e
	dec a			;7ba0
	jr z,L_7BC3		;7ba1
	dec a			;7ba3
	jr z,final_del_juego		;7ba4
	ld a,(0e327h)		;7ba6   ; lee la marca de fin del scroll
	and a			;7ba9
	ret z			;7baa
	ld a,001h		;7bab   ; paso 0: al acabar el scroll, 0xE3BE = 1
	ld (0e3beh),a		;7bad   ; guarda la marca de la fase 7
	jr guion_siguiente		;7bb0
L_7BB2:
	ld a,(0e38dh)		;7bb2   ; paso 1: con 0xE38D, 32 columnas mas
	and a			;7bb5
	ret z			;7bb6
	xor a			;7bb7
	ld (0e3beh),a		;7bb8   ; guarda la marca de la fase 7
	ld de,00020h		;7bbb
	call alarga_el_scroll		;7bbe   ; alarga_el_scroll: el final del scroll (0xE325) + DE
	jr guion_siguiente		;7bc1
L_7BC3:
	ld a,(0e327h)		;7bc3   ; lee la marca de fin del scroll
	and a			;7bc6
	ret z			;7bc7
	ld l,003h		;7bc8   ; paso 2: al acabar, el jefe 3
	call sale_el_jefe		;7bca   ; sale_el_jefe: el jefe L: 0xE340 = L, la pelea a cero, 0xE34D = 1, 0xE343 = 8 y 0xE305 = 0x70
	jr guion_siguiente		;7bcd
guion_fase_8:		; al irse la nave del interior (0xE3C1), a la fase siguiente
	ld hl,0e3c1h		;7bcf   ; la nave se ha ido?
	ld a,(hl)			;7bd2
	or a			;7bd3
	ret z			;7bd4
	xor a			;7bd5   ; se acabo el final
	ld (hl),a			;7bd6
	dec l			;7bd7
	ld (hl),a			;7bd8
	jr a_la_siguiente		;7bd9
alarga_el_scroll:		; el final del scroll (0xE325) + DE
	ld hl,(0e325h)		;7bdb   ; lee la columna en la que acaba el scroll (16 bits) y el byte siguiente (16 bits)
	add hl,de			;7bde
	ld (0e325h),hl		;7bdf   ; guarda la columna en la que acaba el scroll (16 bits) y el byte siguiente (16 bits)
	ret			;7be2
jefe_vencido:		; con el jefe vencido (0xE342), al interior
	ld a,(0e342h)		;7be3   ; lee la marca de jefe vencido
	and a			;7be6
	ret z			;7be7
	jr a_la_siguiente		;7be8
final_del_juego:		; con el jefe vencido y la nave viva, 0xE1E6 = 1 y 0xE1D6 = 0
	ld a,(0e342h)		;7bea   ; lee la marca de jefe vencido
	and a			;7bed
	ret z			;7bee
	ld a,(0e400h)		;7bef   ; con la nave viva
	and a			;7bf2
	ret m			;7bf3
	xor a			;7bf4   ; el final del juego, sin textos
	ld (0e1d6h),a		;7bf5   ; guarda la marca del final con textos
	inc a			;7bf8
	ld (0e1e6h),a		;7bf9   ; guarda la marca del final (estado 10)
	ret			;7bfc
guion_fase_10:		; con 0xE3D0, al acabar el scroll la fase 11; si no, a la siguiente
	ld a,(0e3d0h)		;7bfd   ; lee la velocidad del scroll (1 parado, 2 cada cuadro, si no uno de cada dos)
	and a			;7c00
	jr z,guion_fase_9_11		;7c01
	ld a,(0e327h)		;7c03   ; lee la marca de fin del scroll
	and a			;7c06
	ret z			;7c07
	ld a,00bh		;7c08   ; la fase 11
	jr a_la_fase		;7c0a
guion_fase_9_11:		; al acabar el scroll, a la siguiente
	ld a,(0e327h)		;7c0c   ; lee la marca de fin del scroll
	and a			;7c0f
	ret z			;7c10
a_la_siguiente:		; con la nave viva, 0xE1DA = 1 (estado 8)
	ld a,(0e400h)		;7c11   ; sin nave, nada
	and a			;7c14
	ret m			;7c15
	ld a,001h		;7c16   ; al estado 8
	ld (0e1dah),a		;7c18   ; guarda la marca del estado 8
	ret			;7c1b
siguiente_fase:		; tras un jefe (0xE22B) el interior (fase 8) y apunta la que sigue; del interior o de 9-11 a 0xE22A; si no la siguiente; y el nivel sube
	ld a,(0e22bh)		;7c1c   ; tras vencer a un jefe?
	and a			;7c1f
	jr nz,L_7C2D		;7c20
	ld a,(0e201h)		;7c22   ; si no, segun la fase
	cp 008h		;7c25
	jr z,L_7C3F		;7c27
	jr nc,L_7C44		;7c29
	jr L_7C6E		;7c2b
L_7C2D:
	xor a			;7c2d   ; al interior
	ld (0e22bh),a		;7c2e   ; guarda la marca de jefe vencido: al interior
	inc a			;7c31
	ld (0e1dbh),a		;7c32   ; guarda la marca de nave en su sitio al volver
	call fase_que_sigue		;7c35   ; y despues, la que sigue
	ld (0e22ah),a		;7c38   ; guarda la fase que sigue al interior
	ld a,008h		;7c3b
	jr a_la_fase		;7c3d
L_7C3F:
	ld a,002h		;7c3f   ; del interior: 0xE1DB = 2
	ld (0e1dbh),a		;7c41   ; guarda la marca de nave en su sitio al volver
L_7C44:
	ld hl,0e206h		;7c44   ; la fase mas alta + 1 (sin pasar de 255)
	inc (hl)			;7c47
	jr nz,L_7C4B		;7c48
	dec (hl)			;7c4a
L_7C4B:
	ld de,00080h		;7c4b   ; el nivel sube 0x80
	call sube_el_nivel		;7c4e   ; sube_el_nivel: el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
	ld a,(0e22ah)		;7c51   ; a la apuntada
	jr a_la_fase		;7c54
fase_que_sigue:		; A = la fase que sigue a la 0xE201 (p01:7C59)
	ld a,(0e201h)		;7c56   ; lee la fase (0-11)
fase_que_sigue_a:		; A + 1 hasta la 7 (y luego la 6, 0xE20A + 1); con 0xE20A impar A - 1 hasta la 0 (y luego la 1)
	ld hl,0e20ah		;7c59   ; 0xE20A impar: bajando
	bit 0,(hl)		;7c5c
	jr z,L_7C66		;7c5e
	dec a			;7c60   ; A - 1 hasta la 0
	ret p			;7c61
	ld a,001h		;7c62   ; luego la 1, y subiendo
	inc (hl)			;7c64
	ret			;7c65
L_7C66:
	inc a			;7c66   ; A + 1 hasta la 7
	cp 008h		;7c67
	ret c			;7c69
	ld a,006h		;7c6a   ; luego la 6, y bajando
	inc (hl)			;7c6c
	ret			;7c6d
L_7C6E:
	ld hl,0e206h		;7c6e   ; la fase mas alta + 1
	inc (hl)			;7c71
	jr nz,L_7C75		;7c72
	dec (hl)			;7c74
L_7C75:
	ld de,00080h		;7c75   ; el nivel sube 0x80
	call sube_el_nivel		;7c78   ; sube_el_nivel: el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
	call fase_que_sigue		;7c7b   ; la siguiente
a_la_fase:		; fase A: silencio, guion y jefe a cero y la pantalla de la fase (p01:60D1)
	ld (0e201h),a		;7c7e   ; guarda la fase (0-11)
	ld a,043h		;7c81   ; silencio
	call 04ae4h		;7c83   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	xor a			;7c86   ; guion y jefe a cero
	ld (0e205h),a		;7c87   ; guarda el paso del guion de la fase
	ld (0e342h),a		;7c8a   ; guarda la marca de jefe vencido
	jp vuelve_a_la_fase		;7c8d   ; vuelve_a_la_fase: los graficos, el marcador y la pantalla desde la columna 0; con 0xE1DB, la nave en Y 0x4A X 0x50 y p03:AA2F, p03:AAEC
musica_de_la_zona:		; jugando sin jefe ni sucesos, la musica que toca por la columna del scroll (p01:7CE6 de la fase: [columna][sonido])
	ld a,(0e300h)		;7c90   ; con 0xE300 no
	and a			;7c93
	ret nz			;7c94
	ld a,(0e400h)		;7c95   ; ni sin nave
	and a			;7c98
	ret m			;7c99
	ld a,(0e3d0h)		;7c9a   ; ni con 0xE3D0, 0xE3AA, el final, 0xE34F o el bit 0 de 0xE190
	and a			;7c9d
	ret nz			;7c9e
	ld a,(0e3aah)		;7c9f   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;7ca2
	ret nz			;7ca3
	ld a,(0e3c0h)		;7ca4   ; lee el paso del final del interior (0 nada)
	or a			;7ca7
	ret nz			;7ca8
	ld a,(0e34fh)		;7ca9   ; lee la marca de jefe o suceso acabado
	or a			;7cac
	ret nz			;7cad
	ld a,(0e190h)		;7cae   ; lee el estado del sonido (bit 0)
	bit 0,a		;7cb1
	ret nz			;7cb3
	ld a,(0e201h)		;7cb4   ; la lista de la fase
	ld hl,07ce6h		;7cb7
	call 04b67h		;7cba   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld c,e			;7cbd
	ld b,d			;7cbe
	ld hl,(0e203h)		;7cbf   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
L_7CC2:
	ld a,(bc)			;7cc2   ; [columna][sonido]
	ld e,a			;7cc3
	inc bc			;7cc4
	ld a,(bc)			;7cc5
	ld d,a			;7cc6
	inc bc			;7cc7
	rst 20h			;7cc8   ; la compara con el scroll
	jr z,L_7CE1		;7cc9   ; justo en ella: suena 0xF1
	jr c,L_7CD0		;7ccb
	inc bc			;7ccd   ; pasada: la siguiente
	jr L_7CC2		;7cce
L_7CD0:
	ld a,(bc)			;7cd0   ; todavia no: la musica de la zona anterior
	ld hl,0e0a0h		;7cd1   ; apunta a la musica que suena
	cp (hl)			;7cd4   ; si ya suena, nada
	ret z			;7cd5
	cp 0ffh		;7cd6
	ret z			;7cd8
	call 04ae4h		;7cd9   ; la musica y 0xF0
	ld a,0f0h		;7cdc
	jp 04ae4h		;7cde   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_7CE1:
	ld a,0f1h		;7ce1
	jp 04ae4h		;7ce3   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS musica_por_fase: 12 punteros, uno por fase (0xE201): listas [posicion
;   del scroll][sonido] que p01:7CB4 lee con L_4B67; lo leen p01:7CBA (24
;   bytes)
;   0x7ce6..0x7cfe  (24 bytes)
DATA_musica_por_fase:
	defw 07cfeh,07d04h,07d0dh,07d16h,07d28h,07d1fh	; 7ce6
	defw 07d31h,07d3ah,07d43h,07d49h,07d49h,07d49h	; 7cf2

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7CFE: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba0; lo leen p01:7CBA (6 bytes)
;   0x7cfe..0x7d04  (6 bytes)
DATA_musica_por_fase_7CFE:
	defb 0b0h,001h,029h	; 7cfe
	defb 0ffh,0ffh,035h	; 7d01

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D04: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba1; lo leen p01:7CBA (9 bytes)
;   0x7d04..0x7d0d  (9 bytes)
DATA_musica_por_fase_7D04:
	defb 080h,000h,02bh	; 7d04
	defb 0a0h,001h,02ch	; 7d07
	defb 0ffh,0ffh,034h	; 7d0a

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D0D: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba2; lo leen p01:7CBA (9 bytes)
;   0x7d0d..0x7d16  (9 bytes)
DATA_musica_por_fase_7D0D:
	defb 084h,000h,02bh	; 7d0d
	defb 0deh,001h,02dh	; 7d10
	defb 0ffh,0ffh,034h	; 7d13

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D16: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba3; lo leen p01:7CBA (9 bytes)
;   0x7d16..0x7d1f  (9 bytes)
DATA_musica_por_fase_7D16:
	defb 060h,000h,02bh	; 7d16
	defb 0fah,001h,02eh	; 7d19
	defb 0ffh,0ffh,034h	; 7d1c

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D1F: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba5; lo leen p01:7CBA (9 bytes)
;   0x7d1f..0x7d28  (9 bytes)
DATA_musica_por_fase_7D1F:
	defb 085h,000h,02bh	; 7d1f
	defb 09ah,001h,030h	; 7d22
	defb 0ffh,0ffh,034h	; 7d25

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D28: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba4; lo leen p01:7CBA (9 bytes)
;   0x7d28..0x7d31  (9 bytes)
DATA_musica_por_fase_7D28:
	defb 085h,000h,02bh	; 7d28
	defb 0fah,001h,031h	; 7d2b
	defb 0ffh,0ffh,034h	; 7d2e

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D31: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba6; lo leen p01:7CBA (9 bytes)
;   0x7d31..0x7d3a  (9 bytes)
DATA_musica_por_fase_7D31:
	defb 060h,000h,02bh	; 7d31
	defb 0bah,001h,032h	; 7d34
	defb 0ffh,0ffh,034h	; 7d37

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D3A: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba7; lo leen p01:7CBA (9 bytes)
;   0x7d3a..0x7d43  (9 bytes)
DATA_musica_por_fase_7D3A:
	defb 060h,000h,02bh	; 7d3a
	defb 0dah,002h,033h	; 7d3d
	defb 0ffh,0ffh,034h	; 7d40

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D43: lista de p01:7CC2 de la fase : fichas [posicion
;   del scroll lo hi][sonido]; al pasar por la posicion suena el sonido
;   (p00:4AE4), y la 0xFFFF acaba8; lo leen p01:7CBA (6 bytes)
;   0x7d43..0x7d49  (6 bytes)
DATA_musica_por_fase_7D43:
	defb 090h,000h,035h	; 7d43
	defb 0ffh,0ffh,043h	; 7d46

; ----------------------------------------------------------------------
; DATOS musica_por_fase_7D49: lista de p01:7CC2 de las fases : fichas
;   [posicion del scroll lo hi][sonido]; al pasar por la posicion suena el
;   sonido (p00:4AE4), y la 0xFFFF acaba9, 10, 11; lo leen p01:7CBA (6 bytes)
;   0x7d49..0x7d4f  (6 bytes)
DATA_musica_por_fase_7D49:
	defb 04fh,001h,036h	; 7d49
	defb 0ffh,0ffh,02ah	; 7d4c

; ======================================================================
; CODIGO 0x7d4f..0x7d8d  (62 bytes)
; ======================================================================


usa_el_medidor:		; con el otro boton recien pulsado y una casilla encendida que no este gastada, la usa (p01:7D8D por armas capturadas) y suena 6
	ld a,(0e400h)		;7d4f   ; sin nave, nada
	dec a			;7d52
	ret m			;7d53
	ld a,(0e3c0h)		;7d54   ; ni en el final del interior
	or a			;7d57
	ret nz			;7d58
	ld a,(0e1c8h)		;7d59   ; el otro boton, recien pulsado
	and 020h		;7d5c
	ret z			;7d5e
	ld hl,0e330h		;7d5f   ; la casilla encendida
	ld a,(hl)			;7d62
	or a			;7d63
	ret z			;7d64
	ld (0e33dh),a		;7d65   ; la que se usa
	ld hl,0e333h		;7d68   ; gastada (0xFF): nada
	add a,l			;7d6b
	ld l,a			;7d6c
	ld a,(hl)			;7d6d
	or a			;7d6e
	ret m			;7d6f
	xor a			;7d70   ; se apaga
	ld (0e330h),a		;7d71   ; guarda la casilla iluminada del medidor
	ld hl,053a3h		;7d74   ; al acabar, el medidor
	push hl			;7d77
	ld hl,07d8dh		;7d78   ; la tabla de las armas capturadas
	ld a,(0e20fh)		;7d7b   ; lee las armas capturadas (0-7)
	call 04b67h		;7d7e   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;7d81
	ld a,(0e33dh)		;7d82   ; lee la casilla que se usa
	call 04085h		;7d85   ; la rutina de la casilla
	ld a,006h		;7d88   ; suena 6
	jp 04ae4h		;7d8a   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS saltos_por_capturas: 8 punteros, uno por cada cuenta de armas
;   capturadas (0xE20F), a las tablas de destinos de p01:7D85 (L_4085: HL =
;   tabla, A = 0xE33D); lo leen p01:7D7E (16 bytes)
;   0x7d8d..0x7d9d  (16 bytes)
DATA_saltos_por_capturas:
	defw 07d9bh,07da7h,07db5h,07db5h,07db5h,07db5h,07dc5h,07dc5h	; 7d8d

; ----------------------------------------------------------------------
; DATOS destinos_7D9B: las tablas de destinos de p01:7D85: 0x7D9B (6, su
;   primera palabra es la ultima de 0x7D8D), 0x7DA7 (7), 0x7DB5 (8) y 0x7DC5
;   (10); lo leen p01:7D85 (60 bytes)
;   0x7d9d..0x7dd9  (60 bytes)
DATA_destinos_7D9B:
	defw 07dd9h,07e32h,07e6bh,07f3fh,07f66h,07f87h,07dd9h,07e32h	; 7d9d
	defw 07e6bh,07ed9h,07f3fh,07f66h,07f87h,07dd9h,07e32h,07e6bh	; 7dad
	defw 07ed9h,07f0bh,07f3fh,07f66h,07f87h,07dd9h,07e32h,07e4fh	; 7dbd
	defw 07e6bh,07ed9h,07f0bh,07f3fh,07f66h,07f87h	; 7dcd

; ======================================================================
; CODIGO 0x7dd9..0x7fff  (550 bytes)
; ======================================================================


casilla_velocidad:		; con 0xE20B, recupera lo guardado en 0xE210 (medidor, armas, escudo, velocidad, opciones); si no, la velocidad + 1 (al llegar a 7, gastada)
	ld hl,0e20bh		;7dd9   ; con 0xE20B, lo guardado
	ld a,(hl)			;7ddc
	or a			;7ddd
	jr z,L_7E23		;7dde
	ld (hl),000h		;7de0
	ld hl,0e210h		;7de2   ; el medidor
	ld de,0e330h		;7de5   ; apunta a la casilla iluminada del medidor
	ld bc,0000dh		;7de8
	ldir		;7deb
	xor a			;7ded
	ld (0e330h),a		;7dee   ; guarda la casilla iluminada del medidor
	ld de,0e430h		;7df1   ; las armas
	ld bc,00007h		;7df4
	ldir		;7df7
	ld a,(hl)			;7df9   ; el escudo, si tenia
	or a			;7dfa
	jr z,L_7E05		;7dfb
	ld (0e401h),a		;7dfd   ; guarda los golpes que le quedan al escudo
	ld a,002h		;7e00
	ld (0e400h),a		;7e02   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
L_7E05:
	inc l			;7e05   ; la velocidad
	ld a,(hl)			;7e06
	ld (0e402h),a		;7e07   ; guarda la velocidad de la nave
	inc l			;7e0a   ; las opciones
	ld a,(hl)			;7e0b
	ld (0e40bh),a		;7e0c   ; guarda las opciones
	dec a			;7e0f
	ret m			;7e10
	jr z,L_7E20		;7e11
dos_opciones:		; 0xE40B = 2 opciones, con p03:AA43 para cada una
	ld a,001h		;7e13
	ld (0e40bh),a		;7e15   ; guarda las opciones
	call 0aa43h		;7e18
	ld a,002h		;7e1b
	ld (0e40bh),a		;7e1d   ; guarda las opciones
L_7E20:
	jp 0aa43h		;7e20
L_7E23:
	ld hl,0e334h		;7e23   ; la velocidad + 1
	inc (hl)			;7e26
	ld a,(hl)			;7e27
	cp 007h		;7e28   ; a la 7, gastada
	jr c,L_7E2E		;7e2a
	ld (hl),0ffh		;7e2c
L_7E2E:
	ld (0e402h),a		;7e2e   ; guarda la velocidad de la nave
	ret			;7e31
casilla_misil:		; el misil + 1 (hasta el tope de p02:804A; luego gastada) y el nivel sube
	xor a			;7e32   ; sin laser
	ld (0e435h),a		;7e33   ; guarda el laser
	call 0804ah		;7e36   ; C = el tope (p02:804A)
	ld hl,0e335h		;7e39   ; la casilla 2 + 1
	inc (hl)			;7e3c
	ld a,(hl)			;7e3d
	cp c			;7e3e   ; al tope, gastada
	jr c,L_7E43		;7e3f
	ld (hl),0ffh		;7e41
L_7E43:
	ld (0e433h),a		;7e43   ; el misil
	call suelta_por_capturas		;7e46   ; suelta_por_capturas: con 2-5 armas capturadas 0xE338 = 0, con 6 o mas 0xE339 = 0
	ld de,00080h		;7e49   ; el nivel sube 0x80
	jp sube_el_nivel		;7e4c   ; sube_el_nivel: el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
vuelve_al_disparo:		; 0xE430 = 1 y 0xE436 = 1, las demas armas a cero
	xor a			;7e4f   ; las armas a cero
	ld (0e431h),a		;7e50   ; guarda arma 0xE431
	ld (0e432h),a		;7e53   ; guarda el arma elegida en el medidor
	ld (0e434h),a		;7e56   ; guarda el disparo doble
	ld (0e435h),a		;7e59   ; guarda el laser
	inc a			;7e5c   ; el disparo normal
	ld (0e436h),a		;7e5d   ; guarda arma 0xE436
	ld (0e430h),a		;7e60   ; guarda el disparo normal
	ld a,0ffh		;7e63   ; la casilla 3 gastada
	ld (0e336h),a		;7e65   ; guarda la casilla 3 del medidor
	jp e33a_a_e337_a_cero		;7e68   ; e33a_a_e337_a_cero: 0xE33A, 0xE339, 0xE338 y 0xE337 a cero
casilla_varia:		; la casilla 0xE33D + 1: con 1 vuelve al disparo, con 2 el escudo (0xE432 = 5), si no 0xE432 = 6
	call 0804ah		;7e6b   ; el tope
	ld a,(0e33dh)		;7e6e   ; la casilla + 1
	ld hl,0e333h		;7e71   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7e74
	ld l,a			;7e75
	inc (hl)			;7e76
	ld a,(hl)			;7e77
	cp c			;7e78
	jr c,L_7E7D		;7e79
	ld (hl),0ffh		;7e7b
L_7E7D:
	dec a			;7e7d   ; 1: vuelve al disparo
	jr z,L_7EA5		;7e7e
	dec a			;7e80   ; 2: el escudo
	jr z,L_7E8A		;7e81
	call e33a_a_cero_con_7		;7e83   ; si no, 0xE432 = 6
	ld a,006h		;7e86
	jr L_7E95		;7e88
L_7E8A:
	call quita_tipo_03		;7e8a   ; quita_tipo_03: libera las fichas de 0xE470 con 3
	call 04482h		;7e8d   ; los dibujos del escudo
	call suelta_con_capturas		;7e90   ; suelta_con_capturas: con las armas capturadas (cruza a p02:8002): 4 o 5, p02:7FC2; 6 o mas, p01:7FFA
	ld a,005h		;7e93
L_7E95:
	ld (0e432h),a		;7e95   ; guarda el arma elegida en el medidor
	xor a			;7e98
	ld (0e430h),a		;7e99   ; guarda el disparo normal
	ld (0e431h),a		;7e9c   ; guarda arma 0xE431
	ld de,00080h		;7e9f   ; el nivel sube 0x80
	jp sube_el_nivel		;7ea2   ; sube_el_nivel: el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
L_7EA5:
	xor a			;7ea5
	ld (0e432h),a		;7ea6   ; guarda el arma elegida en el medidor
	ld (0e434h),a		;7ea9   ; guarda el disparo doble
	ld (0e435h),a		;7eac   ; guarda el laser
	ld (0e436h),a		;7eaf   ; guarda arma 0xE436
	inc a			;7eb2
	ld (0e430h),a		;7eb3   ; guarda el disparo normal
	ld (0e431h),a		;7eb6   ; guarda arma 0xE431
	call suelta_segun_capturas		;7eb9   ; lo que suelta y los dibujos de las opciones
	call quita_tipo_0e		;7ebc   ; quita_tipo_0e: libera las fichas de 0xE470 con 0x0E
	jp 0448eh		;7ebf   ; sprites_opcion: con los bancos 7-8-9, p08:93C0 a 0x18C0
quita_tipo_0e:		; libera las fichas de 0xE470 con 0x0E
	ld a,00eh		;7ec2
	jr quita_tipo_a		;7ec4
quita_tipo_03:		; libera las fichas de 0xE470 con 3
	ld a,003h		;7ec6
quita_tipo_a:		; libera las 9 fichas de 16 bytes de 0xE470 que tienen A
	ld hl,0e470h		;7ec8   ; 9 fichas de 16 bytes
	ld de,00010h		;7ecb
	ld b,009h		;7ece
L_7ED0:
	cp (hl)			;7ed0   ; si lleva A, libre
	jr nz,L_7ED5		;7ed1
	ld (hl),000h		;7ed3
L_7ED5:
	add hl,de			;7ed5
	djnz L_7ED0		;7ed6
	ret			;7ed8
casilla_doble:		; 0xE434 = la casilla + 1 (gastada al tope) y el nivel sube
	ld hl,0e430h		;7ed9   ; el disparo 2 vuelve a ser 1
	ld a,(hl)			;7edc
	cp 002h		;7edd
	jr nz,L_7EE3		;7edf
	ld (hl),001h		;7ee1
L_7EE3:
	xor a			;7ee3
	ld (0e431h),a		;7ee4   ; guarda arma 0xE431
	ld (0e435h),a		;7ee7   ; guarda el laser
	ld (0e436h),a		;7eea   ; guarda arma 0xE436
	call 0800bh		;7eed   ; p02:800B
	call 0804ah		;7ef0   ; tope_de_casilla: C = el tope de la casilla 0xE33D con estas armas capturadas (p02:8074, 9 por cuenta)
	ld a,(0e33dh)		;7ef3   ; la casilla + 1
	ld hl,0e333h		;7ef6   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7ef9
	ld l,a			;7efa
	inc (hl)			;7efb
	ld a,(hl)			;7efc
	ld (0e434h),a		;7efd   ; guarda el disparo doble
	cp c			;7f00   ; al tope, gastada
	jr c,L_7F05		;7f01
	ld (hl),0ffh		;7f03
L_7F05:
	ld de,00080h		;7f05
	jp sube_el_nivel		;7f08   ; sube_el_nivel: el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
casilla_laser:		; 0xE435 = la casilla + 1 (gastada al tope), p02:8028 y el nivel sube
	ld hl,0e430h		;7f0b   ; el disparo 2 vuelve a ser 1
	ld a,(hl)			;7f0e
	cp 002h		;7f0f
	jr nz,L_7F15		;7f11
	ld (hl),001h		;7f13
L_7F15:
	xor a			;7f15
	ld (0e433h),a		;7f16   ; guarda el misil
	ld (0e431h),a		;7f19   ; guarda arma 0xE431
	ld (0e434h),a		;7f1c   ; guarda el disparo doble
	ld (0e436h),a		;7f1f   ; guarda arma 0xE436
	call 0804ah		;7f22   ; la casilla + 1
	ld a,(0e33dh)		;7f25   ; lee la casilla que se usa
	ld hl,0e333h		;7f28   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7f2b
	ld l,a			;7f2c
	inc (hl)			;7f2d
	ld a,(hl)			;7f2e
	ld (0e435h),a		;7f2f   ; guarda el laser
	cp c			;7f32
	jr c,L_7F37		;7f33
	ld (hl),0ffh		;7f35
L_7F37:
	call 08028h		;7f37   ; p02:8028
	ld de,00080h		;7f3a
	jr sube_el_nivel		;7f3d
casilla_arma:		; 0xE432 = la casilla + 1 (gastada al tope), p02:8041 y el nivel sube poco
	xor a			;7f3f
	ld (0e430h),a		;7f40   ; guarda el disparo normal
	ld (0e431h),a		;7f43   ; guarda arma 0xE431
	ld (0e436h),a		;7f46   ; guarda arma 0xE436
	call 0804ah		;7f49   ; la casilla + 1
	ld a,(0e33dh)		;7f4c   ; lee la casilla que se usa
	ld hl,0e333h		;7f4f   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7f52
	ld l,a			;7f53
	inc (hl)			;7f54
	ld a,(hl)			;7f55
	ld (0e432h),a		;7f56   ; guarda el arma elegida en el medidor
	cp c			;7f59
	jr c,L_7F5E		;7f5a
	ld (hl),0ffh		;7f5c
L_7F5E:
	call 08041h		;7f5e   ; p02:8041
	ld de,00040h		;7f61   ; el nivel sube 0x40
	jr sube_el_nivel		;7f64
casilla_opcion:		; 0xE40B = las opciones (hasta 2; luego gastada) y p03:AA43
	ld a,(0e33dh)		;7f66   ; la casilla + 1
	ld hl,0e333h		;7f69   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7f6c
	ld l,a			;7f6d
	inc (hl)			;7f6e
	ld a,(hl)			;7f6f
	ld (0e40bh),a		;7f70   ; guarda las opciones
	cp 002h		;7f73   ; hasta 2; luego gastada
	jr c,L_7F79		;7f75
	ld (hl),0ffh		;7f77
L_7F79:
	call 0aa43h		;7f79   ; las opciones (p03:AA43)
	ld de,00080h		;7f7c
	jr sube_el_nivel		;7f7f
marca_e445:		; 0xE445 = 1
	ld a,001h		;7f81
	ld (0e445h),a		;7f83   ; guarda la marca de p01:7F98 al acabar la capsula
	ret			;7f86
casilla_escudo:		; la casilla gastada; con el R.DRILL solo 0xE445 = 1; si no, la nave con escudo de 10 golpes
	ld a,(0e33dh)		;7f87   ; gastada
	ld hl,0e333h		;7f8a   ; apunta a la tabla de rotulos de las casillas (desde 0xE334)
	add a,l			;7f8d
	ld l,a			;7f8e
	ld (hl),0ffh		;7f8f
	ld a,(0e400h)		;7f91   ; con el R.DRILL, solo la marca
	cp 003h		;7f94
	jr z,marca_e445		;7f96
pon_escudo:		; 0xE400 = 2 (con escudo) y 0xE401 = 10 golpes
	ld hl,00a02h		;7f98   ; 0xE400 = 2, 0xE401 = 10
	ld (0e400h),hl		;7f9b   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL) y el byte siguiente (16 bits)
	ld de,00100h		;7f9e
	ld de,00100h		;7fa1
sube_el_nivel:		; el nivel (0xE227-0xE228) + DE, como mucho 0x0FFF
	ld hl,(0e227h)		;7fa4   ; el nivel
	add hl,de			;7fa7
	ld a,h			;7fa8   ; como mucho 15
	cp 010h		;7fa9
	jr c,L_7FAF		;7fab
	ld h,00fh		;7fad
L_7FAF:
	ld (0e227h),hl		;7faf   ; guarda el nivel (16 bits: 0xE228 entero, 0xE227 fraccion) y el byte siguiente (16 bits)
	ret			;7fb2
suelta_por_capturas:		; con 2-5 armas capturadas 0xE338 = 0, con 6 o mas 0xE339 = 0
	ld a,(0e20fh)		;7fb3   ; 0 o 1: nada
	cp 002h		;7fb6
	ret c			;7fb8
	cp 006h		;7fb9
	jr c,L_7FC2		;7fbb
e339_a_cero:		; 0xE339 = 0
	xor a			;7fbd
	ld (0e339h),a		;7fbe   ; guarda la casilla 6 del medidor
	ret			;7fc1
L_7FC2:
	xor a			;7fc2
	ld (0e338h),a		;7fc3   ; guarda la casilla 5 del medidor
	ret			;7fc6
e33a_a_e337_a_cero:		; 0xE33A, 0xE339, 0xE338 y 0xE337 a cero
	xor a			;7fc7
	ld (0e33ah),a		;7fc8   ; guarda la casilla 7 del medidor
L_7FCB:
	xor a			;7fcb
	ld (0e339h),a		;7fcc   ; guarda la casilla 6 del medidor
L_7FCF:
	xor a			;7fcf
	ld (0e338h),a		;7fd0   ; guarda la casilla 5 del medidor
L_7FD3:
	xor a			;7fd3
	ld (0e337h),a		;7fd4   ; guarda la casilla 4 del medidor
	ret			;7fd7
suelta_segun_capturas:		; segun las armas capturadas, pone a cero 0xE337, 0xE338, 0xE339... (0 a 5) o 0xE336-0xE33A (6 o mas)
	ld a,(0e20fh)		;7fd8   ; sin armas capturadas: 0xE337
	or a			;7fdb
	jr z,L_7FD3		;7fdc
	cp 001h		;7fde   ; con una: 0xE338 y 0xE337
	jr z,L_7FCF		;7fe0
	cp 006h		;7fe2   ; de 2 a 5: tambien 0xE339
	jr c,L_7FCB		;7fe4
	xor a			;7fe6   ; 6 o 7: 0xE336-0xE33A
	ld (0e33ah),a		;7fe7   ; guarda la casilla 7 del medidor
	ld (0e339h),a		;7fea   ; guarda la casilla 6 del medidor
	ld (0e338h),a		;7fed   ; guarda la casilla 5 del medidor
	ld (0e336h),a		;7ff0   ; guarda la casilla 3 del medidor
	ret			;7ff3
e33a_a_cero_con_7:		; con 7 armas capturadas, 0xE33A = 0
	ld a,(0e20fh)		;7ff4   ; solo con 7
	cp 007h		;7ff7
	ret c			;7ff9
L_7FFA:
	xor a			;7ffa
	ld (0e33ah),a		;7ffb   ; guarda la casilla 7 del medidor
	ret			;7ffe

; ----------------------------------------------------------------------
; DATOS partida_7FFF: el primer byte (0x3A) de `ld a,(0xE20F)`, la instruccion
;   de p01:7FFF que acaba en el banco 2: su operando son 0x8000-0x8001 del
;   banco que haya en 0x8000 (el 2: p01:7E90 la llama con los bancos 1-2-3), y
;   sigue en p02:8002; lo leen p01:7E90 (1 bytes)
;   0x7fff..0x8000  (1 bytes)
suelta_con_capturas:		; con las armas capturadas (cruza a p02:8002): 4 o 5, p02:7FC2; 6 o mas, p01:7FFA
	defb 03ah	; 7fff

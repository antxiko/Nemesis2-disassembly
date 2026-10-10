; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 10 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa007  (7 bytes)
; ======================================================================


historia:		; la historia de la demostracion: el paso 0xE1D7 (31, p10:A007), cada uno espera su cuadro (0xF0F7) o pinta una escena con su texto (ingles fuera de Japon, 0x002B)
	ld a,(0e1d7h)		;a000   ; el paso
	dec a			;a003
	call 04084h		;a004   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A007: 31 destinos del despachador p00:4084 (call en p10:A004, el
;   indice en A): A045, A088, A0B9, A0C5, A0FA, A124, A16B, A177, A1A8, A1B4,
;   A1E8, A207, A2C5, A35D, A372, A386, A3C7, A3FF, A40B, A44C, A45A, A52E,
;   A54C, A57A, A598, A377, A5AE, A5EF, A627, A37C, A633; lo leen p10:A004 (62
;   bytes)
;   0xa007..0xa045  (62 bytes)
DATA_tabla_A007:
	defw 0a045h,0a088h,0a0b9h,0a0c5h,0a0fah,0a124h,0a16bh,0a177h	; a007
	defw 0a1a8h,0a1b4h,0a1e8h,0a207h,0a2c5h,0a35dh,0a372h,0a386h	; a017
	defw 0a3c7h,0a3ffh,0a40bh,0a44ch,0a45ah,0a52eh,0a54ch,0a57ah	; a027
	defw 0a598h,0a377h,0a5aeh,0a5efh,0a627h,0a37ch,0a633h	; a037

; ======================================================================
; CODIGO 0xa045..0xa352  (781 bytes)
; ======================================================================


historia_espera_1:		; hasta el cuadro 0x2DB el fundido; luego el paso siguiente
	ld de,002dbh		;a045   ; el cuadro 0x2DB
	call 05d89h		;a048   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp c,paso_de_fundido		;a04b   ; todavia no: el fundido
historia_fundido_y_paso:		; p10:A056 y el paso siguiente
	call funde_tres_tercios		;a04e   ; funde_tres_tercios: el fundido de tipo 3 de 0xFE caracteres desde 0x0008 en los tres tercios
historia_siguiente:		; el paso siguiente de la historia (0xE1D7 + 1)
	ld hl,0e1d7h		;a051   ; apunta a el paso de la historia o de la secuencia en marcha (0: ninguna)
	inc (hl)			;a054
	ret			;a055
funde_tres_tercios:		; el fundido de tipo 3 de 0xFE caracteres desde 0x0008 en los tres tercios
	ld hl,00008h		;a056   ; desde 0x0008
	ld c,003h		;a059   ; tres tercios
L_A05B:
	xor a			;a05b
	ld b,0feh		;a05c   ; 0xFE caracteres
L_A05E:
	jp empieza_fundido		;a05e   ; y empieza
funde_un_tercio:		; el fundido de 0xFE caracteres desde 0x1008, un tercio
	ld hl,01008h		;a061   ; desde 0x1008
	ld c,001h		;a064
	jr L_A05B		;a066
funde_a:		; el fundido de tipo 3 de 0xFE caracteres desde 0x0008, un tercio
	ld hl,00008h		;a068
	jr L_A080		;a06b
funde_d0:		; el fundido de tipo 3 de 0xD0 caracteres desde 0x0980, dos tercios
	ld c,002h		;a06d
	ld hl,00980h		;a06f   ; desde 0x0980, dos tercios
	ld b,0d0h		;a072   ; 0xD0 caracteres
	jr L_A084		;a074
funde_tres:		; el fundido de tipo 3 de 0xFE caracteres desde 0x0008, tres tercios
	ld c,003h		;a076
	ld hl,00008h		;a078
	jr L_A082		;a07b
funde_texto:		; el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld hl,01008h		;a07d
L_A080:
	ld c,001h		;a080
L_A082:
	ld b,0feh		;a082
L_A084:
	ld a,003h		;a084   ; tipo 3
	jr L_A05E		;a086
escena_1:		; la escena 1: la imagen p10:ACAB y DR.VENOM THE DIRECTOR GENERAL OF THE SPACE SCIENCE AGENCY ATTEMPTED A COUP D'ETAT
	call paso_de_fundido		;a088   ; el fundido
	ld a,(0e490h)		;a08b   ; hasta que acabe
	and a			;a08e
	ret nz			;a08f
L_A090:
	call 04a10h		;a090   ; pantalla en blanco
	call 05e14h		;a093   ; los caracteres de la historia
	call 069ceh		;a096   ; caracteres_a16d: con el banco 9, la lista p09:A16D y sus copias (p09:A174 espejo, p09:A187 cabeza abajo); luego p01:69EF
	ld de,03843h		;a099   ; la imagen p10:ACAB, 27 columnas, en 0x3843
	ld hl,0acabh		;a09c
	ld c,01bh		;a09f
	call pinta_imagen		;a0a1   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	call funde_texto		;a0a4   ; y el fundido del texto
	ld a,(0002bh)		;a0a7   ; Japon o no
	and 00fh		;a0aa
	ld de,0a933h		;a0ac   ; el texto japones
	jr z,L_A0B4		;a0af
	ld de,0b151h		;a0b1   ; o DR.VENOM THE DIRECTOR GENERAL...
L_A0B4:
	call 04a6bh		;a0b4   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jr historia_siguiente		;a0b7
historia_espera_2:		; hasta el cuadro 0x4BB
	ld de,004bbh		;a0b9   ; el cuadro 0x4BB
	call 05d89h		;a0bc   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a0bf   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	jp paso_de_fundido		;a0c2   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
escena_2:		; la escena 2: la imagen p10:ADBD y DR.VENOM FAILED IN A COUP D'ETAT... EXILED DR.VENOM TO PLANET SARD
	call paso_de_fundido		;a0c5   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a0c8   ; lee el fundido en marcha
	and a			;a0cb
	ret nz			;a0cc
	ld (0e496h),a		;a0cd   ; guarda el paso de la escena
	call 04a10h		;a0d0   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a0d3   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call 069f8h		;a0d6   ; caracteres_a18b: con el banco 9, la lista p09:A18B y sus copias p09:A204; luego p01:69EF
	ld de,03866h		;a0d9   ; la imagen p10:ADBD, 21 columnas, en 0x3866
	ld hl,0adbdh		;a0dc
	ld c,015h		;a0df
	call pinta_imagen		;a0e1   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	call funde_texto		;a0e4   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld a,(0002bh)		;a0e7
	and 00fh		;a0ea
	ld de,0a981h		;a0ec   ; el texto japones
	jr z,L_A0F4		;a0ef
	ld de,0b1aah		;a0f1   ; o DR.VENOM FAILED IN A COUP D'ETAT...
L_A0F4:
	call 04a6bh		;a0f4   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A0F7:
	jp historia_siguiente		;a0f7   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
historia_espera_3:		; hasta el cuadro 0x6D7, y cada 8 cuadros cambia un trozo de la imagen (p10:B0AB/B0B1)
	ld de,006d7h		;a0fa   ; el cuadro 0x6D7
	call 05d89h		;a0fd   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a100   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	call paso_de_fundido		;a103   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e1c3h)		;a106   ; cada 8 cuadros
	and 007h		;a109
	ret nz			;a10b
	ld a,(0e496h)		;a10c   ; alterna
	xor 001h		;a10f
	ld (0e496h),a		;a111   ; guarda el paso de la escena
	ld hl,0b0abh		;a114   ; uno de los dos trozos
	jr z,L_A11C		;a117
	ld hl,0b0b1h		;a119
L_A11C:
	ld c,004h		;a11c   ; 4 columnas en 0x38EC
	ld de,038ech		;a11e
	jp pinta_imagen		;a121   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
escena_3:		; la escena 3: tres imagenes y COSMIC YEAR ... DR.VENOM ESCAPED FROM PLANET SARD
	call paso_de_fundido		;a124   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a127   ; lee el fundido en marcha
	and a			;a12a
	ret nz			;a12b
	call 04a10h		;a12c   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a12f   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call 06a0fh		;a132   ; caracteres_b223: con el banco 12, la lista p12:B223; luego p01:69EF
	ld de,0382eh		;a135   ; tres imagenes
	ld hl,0ae67h		;a138
	ld c,00eh		;a13b
	call pinta_imagen		;a13d   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	ld de,03902h		;a140
	ld hl,0ae96h		;a143
	ld c,008h		;a146
	call pinta_imagen		;a148   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	ld de,0394ah		;a14b
	ld hl,0aea8h		;a14e
	ld c,006h		;a151
	call pinta_imagen		;a153   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	call funde_texto		;a156   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld a,(0002bh)		;a159
	and 00fh		;a15c
	ld de,0a9cdh		;a15e   ; el texto japones
	jr z,L_A166		;a161
	ld de,0b214h		;a163   ; o COSMIC YEAR ... DR.VENOM ESCAPED FROM PLANET SARD
L_A166:
	call 04a6bh		;a166   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A169:
	jr L_A0F7		;a169
historia_espera_4:		; hasta el cuadro 0x8B7
	ld de,008b7h		;a16b   ; el cuadro 0x8B7
	call 05d89h		;a16e   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp c,paso_de_fundido		;a171   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	jp historia_fundido_y_paso		;a174   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
escena_4:		; la escena 4: la imagen p10:AFE6 y HE WAS NOT FOUND, DESPITE THE SEARCH OF IMPERIAL ARMADA
	call paso_de_fundido		;a177   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a17a   ; lee el fundido en marcha
	and a			;a17d
	ret nz			;a17e
	call 04a10h		;a17f   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a182   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call 06a1bh		;a185   ; caracteres_ac44: con el banco 12, la lista p12:AC44; luego p01:69EF
	ld de,03801h		;a188   ; la imagen p10:AFE6, 31 columnas
	ld hl,0afe6h		;a18b
	ld c,01fh		;a18e
	call pinta_imagen		;a190   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	call funde_texto		;a193   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld a,(0002bh)		;a196
	and 00fh		;a199
	ld de,0aa0fh		;a19b   ; el texto japones
	jr z,L_A1A3		;a19e
	ld de,0b24eh		;a1a0   ; o HE WAS NOT FOUND, DESPITE THE SEARCH OF IMPERIAL ARMADA
L_A1A3:
	call 04a6bh		;a1a3   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jr L_A169		;a1a6
historia_espera_5:		; hasta el cuadro 0xA5B
	ld de,00a5bh		;a1a8   ; el cuadro 0xA5B
	call 05d89h		;a1ab   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a1ae   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	jp paso_de_fundido		;a1b1   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
escena_5:		; la escena 5: los caracteres de p10:AB29, la nave (p10:A432) y su texto (p10:AA50 / p10:B29E)
	call paso_de_fundido		;a1b4   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a1b7   ; lee el fundido en marcha
	and a			;a1ba
	ret nz			;a1bb
	call 04a10h		;a1bc   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a1bf   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	ld de,0ab29h		;a1c2   ; copias de caracteres
	call copias_en_dibujos		;a1c5   ; copias_en_dibujos: la lista DE en los dibujos (0x2800) de dos tercios, con colores 0xF0
	ld a,(0002bh)		;a1c8   ; fuera de Japon, mas
	and 00fh		;a1cb
	call nz,copia_tercio_abajo		;a1cd   ; copia_tercio_abajo: 0x128 bytes de dibujos del tercio de abajo (0x3008) a los otros dos (0x2B08)
	call la_nave_de_la_historia		;a1d0   ; la nave
	call funde_d0		;a1d3   ; funde_d0: el fundido de tipo 3 de 0xD0 caracteres desde 0x0980, dos tercios
	ld a,(0002bh)		;a1d6
	and 00fh		;a1d9
	ld de,0aa50h		;a1db   ; el texto japones
	jr z,L_A1E3		;a1de
	ld de,0b29eh		;a1e0   ; o el de p10:B29E
L_A1E3:
	call 04a6bh		;a1e3   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A1E6:
	jr L_A169		;a1e6
historia_espera_6:		; hasta el cuadro 0xBC3; parpadea la imagen p10:AFE3 cada 8 cuadros
	ld de,00bc3h		;a1e8   ; el cuadro 0xBC3
	call 05d89h		;a1eb   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a1ee   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	call paso_de_fundido		;a1f1   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e1c3h)		;a1f4   ; la mitad del tiempo, la nave
	bit 3,a		;a1f7
	jp nz,imagen_af6d		;a1f9   ; imagen_af6d: la imagen p10:AF6D (23 columnas) en 0x3885
	ld de,038ach		;a1fc   ; la otra, p10:AFE3
	ld hl,0afe3h		;a1ff
	ld c,009h		;a202
	jp pinta_imagen		;a204   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
escena_6:		; la escena 6: los caracteres de p10:AB02 y THE INVADER WAS DR.VENOM
	call paso_de_fundido		;a207   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a20a   ; lee el fundido en marcha
	and a			;a20d
	ret nz			;a20e
	call 04a10h		;a20f   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a212   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	ld a,(0002bh)		;a215   ; Japon o no
	and 00fh		;a218
	push af			;a21a
	call z,caracteres_ab02		;a21b   ; caracteres_ab02: la lista de copias de caracteres p10:AB02 en los dibujos de los dos primeros tercios
	pop af			;a21e
	call nz,copia_tercio_abajo		;a21f   ; copia_tercio_abajo: 0x128 bytes de dibujos del tercio de abajo (0x3008) a los otros dos (0x2B08)
	call 069f8h		;a222   ; caracteres_a18b: con el banco 9, la lista p09:A18B y sus copias p09:A204; luego p01:69EF
	ld a,001h		;a225   ; fundido de tipo 1
	ld hl,01008h		;a227
	ld b,05fh		;a22a
	ld c,a			;a22c
	call empieza_fundido		;a22d   ; empieza_fundido: un fundido de tipo A (0 borra, 1 y 3 aparece, 2 desaparece) de B caracteres desde HL en C tercios (0xE490-0xE4A0)
	ld a,(0002bh)		;a230
	and 00fh		;a233
	ld de,0aab4h		;a235   ; el texto japones
	jr z,L_A23D		;a238
	ld de,0b332h		;a23a   ; o THE INVADER WAS DR.VENOM
L_A23D:
	call 04a6bh		;a23d   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A240:
	jr L_A1E6		;a240
caracteres_ab02:		; la lista de copias de caracteres p10:AB02 en los dibujos de los dos primeros tercios
	ld de,0ab02h		;a242
copias_en_dibujos:		; la lista DE en los dibujos (0x2800) de dos tercios, con colores 0xF0
	ld hl,02800h		;a245   ; los dibujos
	ld a,001h		;a248
	ld b,002h		;a24a
copia_caracteres_lista:		; la lista DE de pares [origen][destino] de caracteres: copia los dibujos (y con A bit 0 pone sus colores a 0xF0) en B tercios desde HL
	ld (0e498h),a		;a24c   ; 1: con colores
	ld (0e49ah),hl		;a24f   ; la base
	ld a,b			;a252   ; los tercios
	ld (0e49dh),a		;a253   ; guarda cuantos tercios (copia de caracteres)
L_A256:
	ld a,(de)			;a256   ; 0 acaba
	or a			;a257
	ret z			;a258
	push de			;a259
	call caracter_a_vram		;a25a   ; el origen
	ld de,0e500h		;a25d   ; a 0xE500
	ld bc,00008h		;a260
	call 00059h		;a263   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop de			;a266
	inc de			;a267   ; el destino
	ld a,(de)			;a268
	push de			;a269
	push de			;a26a
	call caracter_a_vram		;a26b   ; caracter_a_vram: HL = la direccion del caracter A desde la base 0xE49A
	ld de,0e500h		;a26e   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00008h		;a271
	exx			;a274
	ld a,(0e49dh)		;a275   ; lee cuantos tercios (copia de caracteres)
	ld b,a			;a278
	call 04a3ah		;a279   ; copiado a los tercios
	pop de			;a27c
	ld a,(de)			;a27d
	call caracter_a_vram		;a27e   ; caracter_a_vram: HL = la direccion del caracter A desde la base 0xE49A
	ld a,(0e498h)		;a281   ; con colores?
	bit 0,a		;a284
	jr z,L_A29A		;a286
	xor a			;a288
	ld de,02000h		;a289   ; sus colores (0x2000 antes)
	sbc hl,de		;a28c
	ld bc,00008h		;a28e
	ld a,(0e49dh)		;a291   ; lee cuantos tercios (copia de caracteres)
	ld d,a			;a294
	ld a,0f0h		;a295   ; a 0xF0
	call 04a4ch		;a297   ; rellena_vram_d_veces: rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
L_A29A:
	pop de			;a29a
	inc de			;a29b   ; el par siguiente
	jr L_A256		;a29c
caracter_a_vram:		; HL = la direccion del caracter A desde la base 0xE49A
	ld h,000h		;a29e   ; x 8
	ld l,a			;a2a0
	add hl,hl			;a2a1
	add hl,hl			;a2a2
	add hl,hl			;a2a3
	ld de,(0e49ah)		;a2a4   ; + la base
	add hl,de			;a2a8
	ret			;a2a9
copia_tercio_abajo:		; 0x128 bytes de dibujos del tercio de abajo (0x3008) a los otros dos (0x2B08)
	ld hl,03008h		;a2aa   ; los dibujos del tercio de abajo
	ld de,0e500h		;a2ad   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld bc,00128h		;a2b0
	call 00059h		;a2b3   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,0e500h		;a2b6   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld hl,02b08h		;a2b9   ; a 0x2B08 y siguientes
	ld bc,00128h		;a2bc
	exx			;a2bf
	ld b,002h		;a2c0
	jp 04a3ah		;a2c2   ; copia_a_vram_b_veces: copia BC' bytes de DE' a la VRAM HL B veces, 0x800 mas adelante cada vez
escena_7:		; espera al cuadro 0xC77 y descomprime la imagen p10:AEBD a la pantalla de RAM
	call paso_de_fundido		;a2c5   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a2c8   ; lee el fundido en marcha
	and a			;a2cb
	ret nz			;a2cc
	ld de,00c77h		;a2cd   ; el cuadro 0xC77
	call 05d89h		;a2d0   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	ret c			;a2d3
	xor a			;a2d4   ; la fila 0
	ld (0e496h),a		;a2d5   ; guarda el paso de la escena
	ld hl,0ed00h		;a2d8   ; la imagen a la pantalla de RAM
	ld de,0aebdh		;a2db
	call descomprime_a_ram		;a2de   ; descomprime_a_ram: DE a la RAM HL: n < 0x80 n bytes, 0x80 + n un byte n veces, 0x80 n c una serie desde c, 0 acaba
	jp L_A240		;a2e1
pinta_imagen_paso:		; el trozo 0xE496 de la imagen grande (p10:A352) en la tabla de nombres
	call borra_512_nombres		;a2e4   ; borra las filas de arriba
	ld a,(0e496h)		;a2e7   ; lee el paso de la escena
	ld de,0a352h		;a2ea   ; la fila de la imagen (p10:A352)
	call 0407fh		;a2ed   ; de_mas_a: DE = DE + A
	ld a,(de)			;a2f0
	call sitio_del_trozo		;a2f1   ; sitio_del_trozo: HL = 0x3805 + (A + 2) x 32 en la VRAM y DE = 0xED00 + A x 23 en la pantalla de RAM
	ld b,002h		;a2f4   ; 2 filas
copia_23_filas:		; B filas de 23 caracteres de DE a la VRAM HL
	ld c,017h		;a2f6   ; de 23
copia_filas:		; B filas de C caracteres de la pantalla de RAM DE a la VRAM HL (los ceros no se pintan)
	ld a,c			;a2f8
	ld (0e497h),a		;a2f9   ; guarda el ancho de las filas que se copian
L_A2FC:
	ld a,(0e497h)		;a2fc   ; el ancho
	ld c,a			;a2ff
	xor a			;a300   ; sin fila de imagen (0xF000 = 0)
	ld (0f000h),a		;a301   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	push hl			;a304
	push de			;a305
	push bc			;a306
	call pinta_imagen_sigue		;a307   ; una fila
	pop bc			;a30a
	pop de			;a30b
	pop hl			;a30c
	ld a,c			;a30d   ; la siguiente de RAM
	call 0407fh		;a30e   ; de_mas_a: DE = DE + A
	ld a,020h		;a311   ; y de VRAM
	call 0407ah		;a313   ; hl_mas_a: HL = HL + A
	djnz L_A2FC		;a316
	ret			;a318
sitio_del_trozo:		; HL = 0x3805 + (A + 2) x 32 en la VRAM y DE = 0xED00 + A x 23 en la pantalla de RAM
	ld c,a			;a319
	add a,002h		;a31a   ; la fila A + 2
	call por_32		;a31c   ; por_32: HL = A x 32
	ld de,03800h		;a31f   ; en la tabla de nombres
	add hl,de			;a322
	ld de,00005h		;a323   ; columna 5
	add hl,de			;a326
	ex de,hl			;a327
	push de			;a328
	ld a,c			;a329   ; la fila A x 23
	call por_23		;a32a   ; por_23: HL = A x 23
	ld de,0ed00h		;a32d   ; de la pantalla de RAM
	add hl,de			;a330
	pop de			;a331
	ex de,hl			;a332
	ret			;a333
por_32:		; HL = A x 32
	ld h,000h		;a334
	ld l,a			;a336
	add hl,hl			;a337
L_A338:
	add hl,hl			;a338
	add hl,hl			;a339
	add hl,hl			;a33a
	add hl,hl			;a33b
	ret			;a33c
por_16:		; HL = A x 16
	ld h,000h		;a33d
	ld l,a			;a33f
	jr L_A338		;a340
por_23:		; HL = A x 23
	ld h,000h		;a342
	ld l,a			;a344
	ld c,l			;a345
	ld b,h			;a346
	add hl,hl			;a347
	add hl,hl			;a348
	add hl,hl			;a349
	ld e,l			;a34a   ; x 8
	ld d,h			;a34b
	add hl,hl			;a34c   ; x 16 + x 8 = x 24
	add hl,de			;a34d
	and a			;a34e
	sbc hl,bc		;a34f   ; - 1 = x 23
	ret			;a351

; ----------------------------------------------------------------------
; DATOS tabla_A352: 11 bytes que p10:A2E7 lee con el paso 0xE496; lo leen
;   p10:A2ED (11 bytes)
;   0xa352..0xa35d  (11 bytes)
DATA_tabla_A352:
	defb 00ah,009h,008h,007h,006h,005h,006h,007h,008h,009h,00ah	; a352  ...........

; ======================================================================
; CODIGO 0xa35d..0xa733  (982 bytes)
; ======================================================================


escena_7_aparece:		; cada 8 cuadros una fila mas de la imagen; a la sexta, el paso siguiente
	ld a,(0e1c3h)		;a35d   ; cada 8 cuadros
	and 007h		;a360
	ret nz			;a362
	ld a,(0e496h)		;a363   ; la fila siguiente
	inc a			;a366
	cp 006h		;a367   ; a la sexta, el paso siguiente
	jp z,historia_siguiente		;a369   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
	ld (0e496h),a		;a36c   ; guarda el paso de la escena
L_A36F:
	jp pinta_imagen_paso		;a36f   ; pinta_imagen_paso: el trozo 0xE496 de la imagen grande (p10:A352) en la tabla de nombres
historia_espera_8:		; hasta el cuadro 0xCEF
	ld de,00cefh		;a372
	jr historia_espera_hasta		;a375
historia_espera_9:		; hasta el cuadro 0x1C2B
	ld de,01c2bh		;a377
	jr historia_espera_hasta		;a37a
historia_espera_10:		; hasta el cuadro 0x1F37
	ld de,01f37h		;a37c
historia_espera_hasta:		; hasta el cuadro DE; luego el fundido y el paso siguiente
	call 05d89h		;a37f   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	ret c			;a382
	jp historia_fundido_y_paso		;a383   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
escena_7_sigue:		; cada 16 cuadros otra fila (hasta la 10)
	ld a,(0e1c3h)		;a386   ; cada 16 cuadros
	and 00fh		;a389
	ret nz			;a38b
	ld a,(0e496h)		;a38c   ; lee el paso de la escena
	inc a			;a38f
	cp 00bh		;a390   ; hasta la 10
	jr z,L_A399		;a392
	ld (0e496h),a		;a394   ; guarda el paso de la escena
	jr L_A36F		;a397
L_A399:
	ld a,009h		;a399   ; la 9
	ld (0e496h),a		;a39b   ; guarda el paso de la escena
	call historia_siguiente		;a39e   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
escena_7_trozo:		; la fila 0xE496: su fundido (p10:B0B7, B0CB) y sus caracteres
	ld a,(0e496h)		;a3a1   ; la fila
	ld de,0b0b7h		;a3a4   ; su VRAM (p10:B0B7)
	call 04b60h		;a3a7   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ex de,hl			;a3aa
	ld a,(0e496h)		;a3ab   ; lee el paso de la escena
	ld de,0b0cbh		;a3ae   ; sus caracteres (p10:B0CB)
	call 0407fh		;a3b1   ; de_mas_a: DE = DE + A
	ld a,(de)			;a3b4
	ld b,a			;a3b5
	ld a,002h		;a3b6   ; el fundido de tipo 2
	ld c,a			;a3b8
	call empieza_fundido		;a3b9   ; empieza_fundido: un fundido de tipo A (0 borra, 1 y 3 aparece, 2 desaparece) de B caracteres desde HL en C tercios (0xE490-0xE4A0)
	ld a,(0e496h)		;a3bc   ; la fila
	call sitio_del_trozo		;a3bf   ; sitio_del_trozo: HL = 0x3805 + (A + 2) x 32 en la VRAM y DE = 0xED00 + A x 23 en la pantalla de RAM
	ld b,001h		;a3c2   ; una fila
	jp copia_23_filas		;a3c4   ; copia_23_filas: B filas de 23 caracteres de DE a la VRAM HL
escena_7_se_va:		; cada 4 cuadros una fila menos; al acabar, DR.VENOM ATTEMPTED TO INVADE PLANET NEMESIS...
	ld a,(0e1c3h)		;a3c7   ; cada 4 cuadros
	and 003h		;a3ca
	ret nz			;a3cc
	call paso_de_fundido		;a3cd   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a3d0   ; lee el fundido en marcha
	and a			;a3d3
	ret nz			;a3d4
	ld a,(0e496h)		;a3d5   ; una fila menos
	dec a			;a3d8
	jp m,L_A3E1		;a3d9
	ld (0e496h),a		;a3dc   ; guarda el paso de la escena
	jr escena_7_trozo		;a3df
L_A3E1:
	ld a,001h		;a3e1   ; acabadas: el fundido
	ld hl,01300h		;a3e3
	ld b,09ch		;a3e6
	ld c,a			;a3e8
	call empieza_fundido		;a3e9   ; empieza_fundido: un fundido de tipo A (0 borra, 1 y 3 aparece, 2 desaparece) de B caracteres desde HL en C tercios (0xE490-0xE4A0)
	ld a,(0002bh)		;a3ec   ; el texto japones
	and 00fh		;a3ef
	ld de,0aad9h		;a3f1
	jr z,L_A3F9		;a3f4
	ld de,0b34eh		;a3f6   ; o DR.VENOM ATTEMPTED TO INVADE PLANET NEMESIS...
L_A3F9:
	call 04a6bh		;a3f9   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp historia_siguiente		;a3fc   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
historia_espera_11:		; hasta el cuadro 0xFBF
	ld de,00fbfh		;a3ff   ; el cuadro 0xFBF
	call 05d89h		;a402   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a405   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	jp paso_de_fundido		;a408   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
escena_8:		; la escena 8: la nave y COSMIC YEAR ... THE NEMESIS HIGHEST COUNCIL DECIDED TO DISPATCH METALION
	call paso_de_fundido		;a40b   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a40e   ; lee el fundido en marcha
	and a			;a411
	ret nz			;a412
	call 04a10h		;a413   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a416   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call la_nave_de_la_historia		;a419   ; la_nave_de_la_historia: los caracteres de la nave (p00:5EA3) y su imagen (p00:A435)
	call funde_texto		;a41c   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld a,(0002bh)		;a41f   ; el texto japones
	and 00fh		;a422
	ld de,0ab2eh		;a424
	jr z,L_A42C		;a427
	ld de,0b39fh		;a429   ; o COSMIC YEAR ... THE NEMESIS HIGHEST COUNCIL...
L_A42C:
	call 04a6bh		;a42c   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A42F:
	jp historia_siguiente		;a42f   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
la_nave_de_la_historia:		; los caracteres de la nave (p00:5EA3) y su imagen (p00:A435)
	call 05ea3h		;a432   ; caracteres_a214: p00:5EA9 y p01:69EF
imagen_de_la_nave:		; borra 8 dibujos desde 0x0170 en dos tercios y pinta la imagen p10:AF6D
	ld hl,00170h		;a435   ; desde 0x0170
	xor a			;a438
	ld bc,00008h		;a439
	ld d,002h		;a43c   ; dos tercios
	call 04a4ch		;a43e   ; rellena_vram_d_veces: rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
imagen_af6d:		; la imagen p10:AF6D (23 columnas) en 0x3885
	ld hl,0af6dh		;a441   ; la imagen
	ld de,03885h		;a444   ; en 0x3885
	ld c,017h		;a447   ; 23 columnas
	jp pinta_imagen		;a449   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
escena_8_espera:		; al acabar el fundido, 0xE496 = 0 y el paso siguiente
	call paso_de_fundido		;a44c   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a44f   ; lee el fundido en marcha
	and a			;a452
	ret nz			;a453
	xor a			;a454
	ld (0e496h),a		;a455   ; guarda el paso de la escena
	jr L_A42F		;a458
escena_9:		; hasta el cuadro 0x128F, cada 8 cuadros un paso mas (12) de las luces de la nave
	ld de,0128fh		;a45a   ; el cuadro 0x128F
	call 05d89h		;a45d   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,escena_9_texto		;a460   ; escena_9_texto: en Japon, borra la fila del texto y escribe p10:AB72
	ld a,(0e1c3h)		;a463   ; cada 8 cuadros
	and 007h		;a466
	ret nz			;a468
	call luces_de_la_nave		;a469   ; luces_de_la_nave: el caracter del paso (p10:A4DF) y las tres luces parpadeando
	cp 00ch		;a46c   ; hasta el 12
	ret z			;a46e
	inc a			;a46f
L_A470:
	ld (0e496h),a		;a470   ; guarda el paso de la escena
	ret			;a473
luces_de_la_nave:		; el caracter del paso (p10:A4DF) y las tres luces parpadeando
	call luz_del_paso		;a474   ; luz_del_paso: el caracter del paso 0xE496 (p10:B0E1: [caracter][columna][fila]) en la tabla de nombres
	call luz_1		;a477   ; luz_1: la luz de 0x3925: encendida (p10:B13B) o apagada (p10:B14E) segun 0xE1C3 bit 4
	ld a,(0e496h)		;a47a   ; lee el paso de la escena
	cp 003h		;a47d   ; del 3 en adelante, la luz 2
	push af			;a47f
	call nc,luz_2		;a480   ; luz_2: la luz de 0x398A: encendida (p10:B142) o apagada
	pop af			;a483
	ret			;a484
luces_siguen:		; cada 8 cuadros un paso mas (hasta 30) y las tres luces
	call luces_paso		;a485   ; luces_paso: cada 8 cuadros un paso mas de las luces (hasta 30)
tres_luces:		; las tres luces de la nave segun la cuenta de cuadros
	call luz_1		;a488   ; luz_1: la luz de 0x3925: encendida (p10:B13B) o apagada (p10:B14E) segun 0xE1C3 bit 4
	call luz_2		;a48b   ; luz_2: la luz de 0x398A: encendida (p10:B142) o apagada
	jr luz_3		;a48e
luces_paso:		; cada 8 cuadros un paso mas de las luces (hasta 30)
	ld a,(0e1c3h)		;a490   ; cada 8 cuadros
	and 007h		;a493
	ret nz			;a495
	call luz_del_paso		;a496   ; luz_del_paso: el caracter del paso 0xE496 (p10:B0E1: [caracter][columna][fila]) en la tabla de nombres
	ld a,(0e496h)		;a499   ; lee el paso de la escena
	inc a			;a49c
	cp 01eh		;a49d   ; hasta el 30
	ret z			;a49f
	jr L_A470		;a4a0
luz_1:		; la luz de 0x3925: encendida (p10:B13B) o apagada (p10:B14E) segun 0xE1C3 bit 4
	call cuadro_entre_16		;a4a2   ; cuadro_entre_16: A = la cuenta de cuadros con las cifras cambiadas
	ld de,03925h		;a4a5   ; en 0x3925
	bit 0,a		;a4a8
	jr z,L_A4D2		;a4aa
luz_1_encendida:		; la luz 1 encendida (p10:B13B) en DE
	ld hl,0b13bh		;a4ac   ; encendida
L_A4AF:
	ld c,005h		;a4af   ; 5 caracteres
	jp pinta_imagen		;a4b1   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
luz_2:		; la luz de 0x398A: encendida (p10:B142) o apagada
	call cuadro_entre_16		;a4b4   ; cuadro_entre_16: A = la cuenta de cuadros con las cifras cambiadas
	ld de,0398ah		;a4b7   ; en 0x398A
	bit 0,a		;a4ba
	jr z,L_A4D2		;a4bc
luz_2_encendida:		; la luz 2 encendida (p10:B142) en DE
	ld hl,0b142h		;a4be
	jr L_A4AF		;a4c1
luz_3:		; la luz de 0x38D8: encendida (p10:B148) o apagada
	call cuadro_entre_16		;a4c3   ; cuadro_entre_16: A = la cuenta de cuadros con las cifras cambiadas
	ld de,038d8h		;a4c6   ; en 0x38D8
	bit 0,a		;a4c9
	jr z,L_A4D2		;a4cb
L_A4CD:
	ld hl,0b148h		;a4cd
	jr L_A4AF		;a4d0
L_A4D2:
	ld hl,0b14eh		;a4d2   ; apagada
	jr L_A4AF		;a4d5
cuadro_entre_16:		; A = la cuenta de cuadros con las cifras cambiadas
	ld a,(0e1c3h)		;a4d7   ; cada 16 cuadros cambia
	rrca			;a4da
	rrca			;a4db
	rrca			;a4dc
	rrca			;a4dd
	ret			;a4de
luz_del_paso:		; el caracter del paso 0xE496 (p10:B0E1: [caracter][columna][fila]) en la tabla de nombres
	ld de,0b0e1h		;a4df
	ld a,(0e496h)		;a4e2   ; 3 bytes por paso
	ld c,a			;a4e5
	add a,a			;a4e6
	add a,c			;a4e7
	call 0407fh		;a4e8   ; de_mas_a: DE = DE + A
	ld a,(de)			;a4eb   ; el caracter
	ld b,a			;a4ec
	inc de			;a4ed
	ld a,(de)			;a4ee   ; la columna
	ld c,a			;a4ef
	inc de			;a4f0
	ld a,(de)			;a4f1   ; la fila x 32
	call por_32		;a4f2   ; por_32: HL = A x 32
	ld e,c			;a4f5
	ld d,000h		;a4f6
	add hl,de			;a4f8
	ld de,03800h		;a4f9   ; en la tabla de nombres
	add hl,de			;a4fc
	ld a,b			;a4fd
	ld bc,00001h		;a4fe
	jp 00056h		;a501   ; BIOS FILVRM - Fills VRAM with value | un caracter
luces_encendidas:		; las tres luces encendidas
	ld de,03925h		;a504   ; la luz 1
	call luz_1_encendida		;a507   ; luz_1_encendida: la luz 1 encendida (p10:B13B) en DE
	ld de,0398ah		;a50a   ; la 2
	call luz_2_encendida		;a50d   ; luz_2_encendida: la luz 2 encendida (p10:B142) en DE
	ld de,038d8h		;a510   ; la 3
	jr L_A4CD		;a513
escena_9_texto:		; en Japon, borra la fila del texto y escribe p10:AB72
	ld a,(0002bh)		;a515   ; solo en Japon
	and 00fh		;a518
	jp nz,historia_siguiente		;a51a   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
	ld de,0ab72h		;a51d   ; el texto de p10:AB72
L_A520:
	call borra_filas_16_23		;a520   ; borra_filas_16_23: borra 256 nombres desde 0x3A00 (las filas 16-23)
	push de			;a523
	call funde_texto		;a524   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	pop de			;a527
	call 04a6bh		;a528   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp historia_siguiente		;a52b   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
escena_10:		; hasta el cuadro 0x14AB las luces; luego encendidas y, en Japon, p10:ABD1
	ld de,014abh		;a52e   ; el cuadro 0x14AB
	call 05d89h		;a531   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jr nc,L_A53C		;a534
	call paso_de_fundido		;a536   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	jp luces_siguen		;a539   ; luces_siguen: cada 8 cuadros un paso mas (hasta 30) y las tres luces
L_A53C:
	call luces_encendidas		;a53c   ; las luces encendidas
	ld a,(0002bh)		;a53f
	and 00fh		;a542
	jp nz,historia_siguiente		;a544   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
	ld de,0abd1h		;a547   ; en Japon, p10:ABD1
	jr L_A520		;a54a
historia_espera_12:		; hasta el cuadro 0x17F3
	ld de,017f3h		;a54c   ; el cuadro 0x17F3
	call 05d89h		;a54f   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a552   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	jp paso_de_fundido		;a555   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
escena_piloto:		; pantalla en blanco, caracteres, los del piloto (p10:BFC1) y su imagen (p10:B586)
	call 04a10h		;a558   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a55b   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call caracteres_del_piloto		;a55e   ; los del piloto
imagen_del_piloto:		; la imagen p10:B586 (20 columnas) en 0x3906 y su fundido
	ld hl,0b586h		;a561   ; su imagen
	ld de,03906h		;a564   ; en 0x3906
	ld c,014h		;a567   ; 20 columnas
	call pinta_imagen		;a569   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	jp funde_texto		;a56c   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
escena_piloto_b:		; como p10:A558 con otros caracteres (p00:5E0C, p10:BFCA)
	call 04a10h		;a56f   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e0ch		;a572   ; caracteres_5e5f: p00:5E64, p00:5E20 y p00:5D97
	call caracteres_del_piloto_b		;a575   ; caracteres_del_piloto_b: p00:5D94 y sin sprites
	jr imagen_del_piloto		;a578
escena_11:		; la escena 11: el piloto y JAMES BURTON WAS CHOSEN TO FLY METALION
	call paso_de_fundido		;a57a   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a57d   ; lee el fundido en marcha
	and a			;a580
	ret nz			;a581
	call escena_piloto		;a582   ; escena_piloto: pantalla en blanco, caracteres, los del piloto (p10:BFC1) y su imagen (p10:B586)
	ld de,0ac19h		;a585   ; el texto japones
	ld a,(0002bh)		;a588
	and 00fh		;a58b
	jr z,L_A592		;a58d
	ld de,0b3f0h		;a58f   ; o JAMES BURTON WAS CHOSEN TO FLY METALION
L_A592:
	call 04a6bh		;a592   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp historia_siguiente		;a595   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
historia_espera_13:		; hasta el cuadro 0x1CA3
	ld de,01ca3h		;a598   ; el cuadro 0x1CA3
	call 05d89h		;a59b   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp nc,historia_fundido_y_paso		;a59e   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
	jp paso_de_fundido		;a5a1   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
borra_filas_16_23:		; borra 256 nombres desde 0x3A00 (las filas 16-23)
	ld bc,00100h		;a5a4
	ld hl,03a00h		;a5a7   ; las filas 16-23
	xor a			;a5aa
	jp 00056h		;a5ab   ; BIOS FILVRM - Fills VRAM with value
escena_12:		; la escena 12: la imagen p10:B06F en la pantalla de RAM y su aparicion por pasos
	call paso_de_fundido		;a5ae   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a5b1   ; lee el fundido en marcha
	and a			;a5b4
	ret nz			;a5b5
	call 04a10h		;a5b6   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a5b9   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call 05ed7h		;a5bc   ; caracteres_a143: p00:5EE1 y p01:69EF
	xor a			;a5bf
	ld (0e496h),a		;a5c0   ; guarda el paso de la escena
	call historia_siguiente		;a5c3   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
	ld hl,0ed00h		;a5c6   ; la imagen a la pantalla de RAM
	ld de,0b06fh		;a5c9
	call descomprime_a_ram		;a5cc   ; descomprime_a_ram: DE a la RAM HL: n < 0x80 n bytes, 0x80 + n un byte n veces, 0x80 n c una serie desde c, 0 acaba
escena_12_pasos:		; los datos de la aparicion (0xF000-0xF008: p10:B0D5, B0DB...) y p10:B685
	ld hl,0b0d5h		;a5cf
	ld (0f000h),hl		;a5d2   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld hl,00809h		;a5d5
	ld (0f002h),hl		;a5d8   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld hl,00201h		;a5db
	ld (0f004h),hl		;a5de   ; guarda variable de paso y el byte siguiente (16 bits)
	ld hl,0b0dbh		;a5e1
	ld (0f006h),hl		;a5e4
	ld a,008h		;a5e7
	ld (0f008h),a		;a5e9
	jp aparicion_por_pasos		;a5ec   ; aparicion_por_pasos: el paso 0xE496: dos fundidos (p10:A73B, p10:A717) y las dos filas que tocan, de la pantalla de RAM a la VRAM
escena_12_sigue:		; cada 4 cuadros un paso; al segundo, MR.JAMES BURTON SPECIAL CAPTAIN OF I.S.F. EX-VIC VIPER PILOT
	ld a,(0e1c3h)		;a5ef   ; cada 4 cuadros
	and 003h		;a5f2
	ret nz			;a5f4
	call paso_de_fundido		;a5f5   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	call paso_de_fundido_b		;a5f8   ; el segundo fundido
	ld a,(0e490h)		;a5fb   ; los dos fundidos acabados?
	ld hl,0e498h		;a5fe   ; apunta a el segundo fundido en marcha
	or (hl)			;a601
	ret nz			;a602
	ld a,(0e496h)		;a603   ; lee el paso de la escena
	inc a			;a606   ; 2 pasos
	cp 002h		;a607
	jr z,L_A611		;a609
	ld (0e496h),a		;a60b   ; guarda el paso de la escena
	jp escena_12_pasos		;a60e   ; escena_12_pasos: los datos de la aparicion (0xF000-0xF008: p10:B0D5, B0DB...) y p10:B685
L_A611:
	call funde_texto		;a611   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld a,(0002bh)		;a614
	and 00fh		;a617
	ld de,0ac70h		;a619   ; el texto japones
	jr z,L_A621		;a61c
	ld de,0b41dh		;a61e   ; o MR.JAMES BURTON SPECIAL CAPTAIN...
L_A621:
	call 04a6bh		;a621   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp historia_siguiente		;a624   ; historia_siguiente: el paso siguiente de la historia (0xE1D7 + 1)
historia_espera_14:		; hasta el cuadro 0x1FEB
	ld de,01febh		;a627   ; el cuadro 0x1FEB
	call 05d89h		;a62a   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp c,paso_de_fundido		;a62d   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	jp historia_fundido_y_paso		;a630   ; historia_fundido_y_paso: p10:A056 y el paso siguiente
historia_acaba:		; al acabar el fundido, pantalla en blanco y 0xE1D7 = 0
	call paso_de_fundido		;a633   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a636   ; lee el fundido en marcha
	and a			;a639
	ret nz			;a63a
	call 04a10h		;a63b   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	xor a			;a63e   ; se acabo la historia
	ld (0e1d7h),a		;a63f   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	ret			;a642
empieza_historia:		; suena 0x3F, la cuenta de cuadros a cero; en Japon un texto primero (paso 1), fuera la escena 1 (paso 2)
	ld a,03fh		;a643   ; la musica
	call 04ae4h		;a645   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld hl,00000h		;a648   ; desde el cuadro 0
	ld (0f0f7h),hl		;a64b   ; guarda la cuenta de interrupciones (16 bits)
	ld a,(0002bh)		;a64e   ; Japon?
	and 00fh		;a651
	jr nz,L_A669		;a653
	ld a,001h		;a655   ; en Japon, paso 1: un texto primero
	ld (0e1d7h),a		;a657   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	call 04a10h		;a65a   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e14h		;a65d   ; caracteres_5e59: p00:5E64, p01:69F2, p00:5E20 y p01:69F2
	call funde_tres		;a660   ; funde_tres: el fundido de tipo 3 de 0xFE caracteres desde 0x0008, tres tercios
	ld de,0a8b9h		;a663   ; p10:A8B9
	jp 04a6bh		;a666   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_A669:
	ld a,002h		;a669   ; fuera, la escena 1 directamente (paso 2)
	ld (0e1d7h),a		;a66b   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	jp L_A090		;a66e
borra_512_nombres:		; borra 512 nombres desde 0x3800
	ld hl,03800h		;a671   ; 16 filas
	ld bc,00200h		;a674
	xor a			;a677
	jp 00056h		;a678   ; BIOS FILVRM - Fills VRAM with value
pinta_imagen:		; la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	ld a,c			;a67b   ; C: las filas (0xF000)
	ld (0f000h),a		;a67c   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ex de,hl			;a67f   ; 0xF001: la VRAM de la fila
	ld (0f001h),hl		;a680   ; guarda variable de paso: cuantos bytes y el byte siguiente (16 bits)
L_A683:
	ld a,(de)			;a683   ; 0 acaba
	inc de			;a684
	ld b,a			;a685
	and a			;a686
	ret z			;a687
	jp p,L_A6A8		;a688   ; bit 7 a cero: n caracteres
	res 7,b		;a68b   ; 0x80 + n: n veces el mismo
	cp 080h		;a68d   ; 0x80: una serie
	jr z,L_A6D2		;a68f
pinta_imagen_sigue:		; los caracteres de la imagen hasta acabar la fila (0xF000 filas)
	ld a,(de)			;a691   ; el caracter
	and a			;a692
	inc de			;a693
	call nz,0004dh		;a694   ; BIOS WRTVRM - Writes data in VRAM | el 0 no se pinta
	inc hl			;a697
	dec c			;a698   ; fin de fila?
	call z,fila_siguiente_de_imagen		;a699   ; fila_siguiente_de_imagen: HL a la fila siguiente (0xF001 + 32); 0xF000 - 1
	ld a,(0f000h)		;a69c   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	and a			;a69f
	jr z,pinta_imagen_sigue		;a6a0
	inc a			;a6a2
	ret z			;a6a3
	djnz pinta_imagen_sigue		;a6a4
	jr L_A683		;a6a6
L_A6A8:
	ld a,(de)			;a6a8   ; n caracteres seguidos
	and a			;a6a9
	call nz,0004dh		;a6aa   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a6ad
	dec c			;a6ae
	call z,fila_siguiente_de_imagen		;a6af   ; fila_siguiente_de_imagen: HL a la fila siguiente (0xF001 + 32); 0xF000 - 1
	djnz L_A6A8		;a6b2
L_A6B4:
	inc de			;a6b4
	jr L_A683		;a6b5
fila_siguiente_de_imagen:		; HL a la fila siguiente (0xF001 + 32); 0xF000 - 1
	push af			;a6b7
	ld hl,(0f001h)		;a6b8   ; la fila siguiente
	ld a,020h		;a6bb
	call 0407ah		;a6bd   ; hl_mas_a: HL = HL + A
	ld (0f001h),hl		;a6c0   ; guarda variable de paso: cuantos bytes y el byte siguiente (16 bits)
	ld a,(0f000h)		;a6c3   ; sin filas: C = la cuenta
	and a			;a6c6
	jr z,L_A6CC		;a6c7
	ld c,a			;a6c9
	pop af			;a6ca
	ret			;a6cb
L_A6CC:
	pop af			;a6cc
	ld hl,0f000h		;a6cd   ; una fila menos
	dec (hl)			;a6d0
	ret			;a6d1
L_A6D2:
	ld a,(de)			;a6d2   ; cuantos
	ld b,a			;a6d3
	inc de			;a6d4
	ld a,(de)			;a6d5   ; desde cual
	exx			;a6d6
	ld d,a			;a6d7
	exx			;a6d8
L_A6D9:
	and a			;a6d9   ; el caracter
	call nz,0004dh		;a6da   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a6dd
	dec c			;a6de
	call z,fila_siguiente_de_imagen		;a6df   ; fila_siguiente_de_imagen: HL a la fila siguiente (0xF001 + 32); 0xF000 - 1
	exx			;a6e2
	ld a,d			;a6e3   ; el siguiente de la serie
	inc a			;a6e4
	ld d,a			;a6e5
	exx			;a6e6
	djnz L_A6D9		;a6e7
	jr L_A6B4		;a6e9
descomprime_a_ram:		; DE a la RAM HL: n < 0x80 n bytes, 0x80 + n un byte n veces, 0x80 n c una serie desde c, 0 acaba
	ld a,(de)			;a6eb   ; 0 acaba
	inc de			;a6ec
	and a			;a6ed
	ret z			;a6ee
	cp 080h		;a6ef   ; 0x80: serie
	jr z,L_A70A		;a6f1
	ld b,a			;a6f3   ; bit 7: repeticion
	and 07fh		;a6f4
	cp b			;a6f6
	jr z,L_A702		;a6f7
	ld b,a			;a6f9
L_A6FA:
	ld a,(de)			;a6fa   ; n bytes
	inc de			;a6fb
	ld (hl),a			;a6fc
	inc hl			;a6fd
	djnz L_A6FA		;a6fe
	jr descomprime_a_ram		;a700
L_A702:
	ld a,(de)			;a702   ; un byte n veces
	inc de			;a703
L_A704:
	ld (hl),a			;a704
	inc hl			;a705
	djnz L_A704		;a706
	jr descomprime_a_ram		;a708
L_A70A:
	ld a,(de)			;a70a   ; cuantos
	ld b,a			;a70b
	inc de			;a70c
	ld a,(de)			;a70d   ; desde cual
	inc de			;a70e
	ld c,a			;a70f
L_A710:
	ld (hl),c			;a710   ; la serie
	inc c			;a711
	inc hl			;a712
	djnz L_A710		;a713
	jr descomprime_a_ram		;a715
empieza_fundido:		; un fundido de tipo A (0 borra, 1 y 3 aparece, 2 desaparece) de B caracteres desde HL en C tercios (0xE490-0xE4A0)
	ld (0e495h),a		;a717   ; el tipo
	ld a,b			;a71a   ; cuantos caracteres
	ld (0e494h),a		;a71b   ; guarda cuantos caracteres funde
	ld a,c			;a71e   ; cuantos tercios
	ld (0e4a0h),a		;a71f   ; guarda cuantos tercios funde
	ld (0e492h),hl		;a722   ; desde donde
	xor a			;a725   ; la fila 0
	ld (0e491h),a		;a726   ; guarda la fila del fundido
	inc a			;a729   ; en marcha
	ld (0e490h),a		;a72a   ; guarda el fundido en marcha
	ld a,(0e495h)		;a72d   ; lo de su tipo al empezar
	call 04084h		;a730   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A733: 4 destinos del despachador p00:4084 (call en p10:A730, el
;   indice en A): A78E, A78F, A799, A78F; lo leen p10:A730 (8 bytes)
;   0xa733..0xa73b  (8 bytes)
DATA_tabla_A733:
	defw 0a78eh,0a78fh,0a799h,0a78fh	; a733  -> sin_nada guarda_y_borra guarda_borra_y_al_7 guarda_y_borra

; ======================================================================
; CODIGO 0xa73b..0xa7ad  (114 bytes)
; ======================================================================


empieza_fundido_b:		; el segundo fundido (0xE498): B caracteres desde HL, a 0xE800
	ld a,b			;a73b   ; cuantos
	ld (0e49ch),a		;a73c   ; guarda cuantos caracteres funde el segundo
	ld (0e49ah),hl		;a73f   ; desde donde
	xor a			;a742   ; la fila 0
	ld (0e499h),a		;a743   ; guarda la fila del segundo fundido
	inc a			;a746   ; en marcha
	ld (0e498h),a		;a747   ; guarda el segundo fundido en marcha
	jp guarda_y_borra_b		;a74a   ; guarda_y_borra_b: los del segundo, igual
fundido_borra:		; lee los caracteres y los borra
	call bytes_del_fundido		;a74d   ; cuantos bytes
	ld hl,(0e492h)		;a750   ; lee la VRAM del fundido y el byte siguiente (16 bits)
	ld a,(0e4a0h)		;a753   ; los tercios
	ld d,a			;a756
rellena_a_cero:		; rellena con 0 BC bytes de la VRAM HL en D tercios
	xor a			;a757
	jp 04a4ch		;a758   ; rellena_vram_d_veces: rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
fundido_b_borra:		; lee los del segundo fundido y los borra
	call bytes_del_fundido_b		;a75b   ; bytes_del_fundido_b: BC = los del segundo x 8
	ld hl,(0e49ah)		;a75e   ; lee la VRAM del segundo fundido y el byte siguiente (16 bits)
	ld d,002h		;a761   ; dos tercios
	jr rellena_a_cero		;a763
bytes_del_fundido:		; BC = los caracteres del fundido x 8
	ld a,(0e494h)		;a765   ; lee cuantos caracteres funde
L_A768:
	ld l,a			;a768
	ld h,000h		;a769
	add hl,hl			;a76b   ; x 8
	add hl,hl			;a76c
	add hl,hl			;a76d
	ld c,l			;a76e
	ld b,h			;a76f
	ret			;a770
bytes_del_fundido_b:		; BC = los del segundo x 8
	ld a,(0e49ch)		;a771   ; lee cuantos caracteres funde el segundo
	jr L_A768		;a774
guarda_caracteres:		; los caracteres del fundido a 0xE500
	call bytes_del_fundido		;a776   ; bytes_del_fundido: BC = los caracteres del fundido x 8
	ld hl,(0e492h)		;a779   ; lee la VRAM del fundido y el byte siguiente (16 bits)
	ld de,0e500h		;a77c   ; a 0xE500
	jp 00059h		;a77f   ; BIOS LDIRMV - Block transfers to memory from VRAM
guarda_caracteres_b:		; los del segundo a 0xE800
	call bytes_del_fundido_b		;a782   ; bytes_del_fundido_b: BC = los del segundo x 8
	ld hl,(0e49ah)		;a785   ; lee la VRAM del segundo fundido y el byte siguiente (16 bits)
	ld de,0e800h		;a788   ; a 0xE800
	jp 00059h		;a78b   ; BIOS LDIRMV - Block transfers to memory from VRAM
sin_nada:		; nada
	ret			;a78e
guarda_y_borra:		; los guarda y los borra
	call guarda_caracteres		;a78f   ; guarda_caracteres: los caracteres del fundido a 0xE500
	jr fundido_borra		;a792
guarda_y_borra_b:		; los del segundo, igual
	call guarda_caracteres_b		;a794   ; guarda_caracteres_b: los del segundo a 0xE800
	jr fundido_b_borra		;a797
guarda_borra_y_al_7:		; los guarda, los borra y empieza por la fila 7
	call guarda_y_borra		;a799   ; guarda_y_borra: los guarda y los borra
	ld a,007h		;a79c   ; desde la fila 7
	ld (0e491h),a		;a79e   ; guarda la fila del fundido
	ret			;a7a1
paso_de_fundido:		; un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;a7a2   ; sin fundido, nada
	and a			;a7a5
	ret z			;a7a6
	ld a,(0e495h)		;a7a7   ; por tipo
	call 04084h		;a7aa   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A7AD: 4 destinos del despachador p00:4084 (call en p10:A7AA, el
;   indice en A): A7B5, A7EA, A81D, A7EA; lo leen p10:A7AA (8 bytes)
;   0xa7ad..0xa7b5  (8 bytes)
DATA_tabla_A7AD:
	defw 0a7b5h,0a7eah,0a81dh,0a7eah	; a7ad  -> fundido_tipo_0 fundido_tipo_1 fundido_tipo_2 fundido_tipo_1

; ======================================================================
; CODIGO 0xa7b5..0xa8b9  (260 bytes)
; ======================================================================


fundido_tipo_0:		; borra la fila 0xE491 de cada caracter; a las 8, acabado
	ld hl,(0e492h)		;a7b5   ; lee la VRAM del fundido y el byte siguiente (16 bits)
	ld a,(0e494h)		;a7b8   ; lee cuantos caracteres funde
	ld b,a			;a7bb
L_A7BC:
	push hl			;a7bc
	push bc			;a7bd
	ld a,(0e491h)		;a7be   ; la fila
	and 007h		;a7c1
	call 0407ah		;a7c3   ; hl_mas_a: HL = HL + A
	ld bc,00001h		;a7c6
	ld a,(0e4a0h)		;a7c9   ; en los tercios
	ld d,a			;a7cc
	xor a			;a7cd   ; a cero
	call 04a4ch		;a7ce   ; rellena_vram_d_veces: rellena BC bytes de la VRAM HL con A, D veces, 0x800 mas adelante cada vez
	pop bc			;a7d1
	ld de,00008h		;a7d2   ; el caracter siguiente
	pop hl			;a7d5
	add hl,de			;a7d6
	djnz L_A7BC		;a7d7
	ld a,(0e491h)		;a7d9   ; la fila siguiente
	inc a			;a7dc
	cp 008h		;a7dd   ; 8 filas
	jr z,fundido_acabado		;a7df
	ld (0e491h),a		;a7e1   ; guarda la fila del fundido
	ret			;a7e4
fundido_acabado:		; 0xE490 = 0
	xor a			;a7e5
	ld (0e490h),a		;a7e6   ; acabado
	ret			;a7e9
fundido_tipo_1:		; escribe la fila 0xE491 de cada caracter (de 0xE500); a las 8, acabado
	ld hl,(0e492h)		;a7ea   ; lee la VRAM del fundido y el byte siguiente (16 bits)
	ld a,(0e494h)		;a7ed   ; lee cuantos caracteres funde
	ld b,a			;a7f0
	ld de,0e500h		;a7f1   ; desde 0xE500
L_A7F4:
	push bc			;a7f4
	push de			;a7f5
	push hl			;a7f6
	ld a,(0e491h)		;a7f7   ; la fila
	call fila_a		;a7fa   ; fila_a: HL y DE + (A & 7), BC = 1
	exx			;a7fd
	ld a,(0e4a0h)		;a7fe   ; en los tercios
	ld b,a			;a801
	call 04a3ah		;a802   ; copia_a_vram_b_veces: copia BC' bytes de DE' a la VRAM HL B veces, 0x800 mas adelante cada vez
	ld bc,00008h		;a805   ; el caracter siguiente
	pop hl			;a808
	add hl,bc			;a809
	pop de			;a80a
	ex de,hl			;a80b
	add hl,bc			;a80c
	ex de,hl			;a80d
	pop bc			;a80e
	djnz L_A7F4		;a80f
	ld a,(0e491h)		;a811   ; la fila siguiente
	inc a			;a814
	cp 008h		;a815
	jr z,fundido_acabado		;a817
	ld (0e491h),a		;a819   ; guarda la fila del fundido
	ret			;a81c
fundido_tipo_2:		; escribe la fila 0xE491 hacia atras; al llegar a 0, acabado
	ld hl,(0e492h)		;a81d   ; lee la VRAM del fundido y el byte siguiente (16 bits)
	ld a,(0e494h)		;a820   ; lee cuantos caracteres funde
	ld b,a			;a823
	ld de,0e500h		;a824   ; apunta a las fichas de 16 bytes de los objetos de caracteres
	ld a,(0e491h)		;a827   ; lee la fila del fundido
	call fila_de_caracteres		;a82a   ; una fila
	ld a,(0e491h)		;a82d   ; la anterior
	dec a			;a830
	jp m,fundido_acabado		;a831   ; fundido_acabado: 0xE490 = 0
	ld (0e491h),a		;a834   ; guarda la fila del fundido
	ret			;a837
fila_de_caracteres:		; la fila A de B caracteres de DE a la VRAM HL en dos tercios
	push af			;a838
	push bc			;a839
	push hl			;a83a
	push de			;a83b
	call fila_a		;a83c   ; la fila
	exx			;a83f
	ld b,002h		;a840   ; dos tercios
	call 04a3ah		;a842   ; copia_a_vram_b_veces: copia BC' bytes de DE' a la VRAM HL B veces, 0x800 mas adelante cada vez
	ld bc,00008h		;a845   ; el caracter siguiente
	pop hl			;a848
	add hl,bc			;a849
	ex de,hl			;a84a
	pop hl			;a84b
	add hl,bc			;a84c
	pop bc			;a84d
	pop af			;a84e
	djnz fila_de_caracteres		;a84f
	ld a,(0e491h)		;a851   ; lee la fila del fundido
	ret			;a854
fila_a:		; HL y DE + (A & 7), BC = 1
	and 007h		;a855   ; la fila (0-7)
	ld c,a			;a857
	call 0407ah		;a858   ; hl_mas_a: HL = HL + A
	ld a,c			;a85b
	call 0407fh		;a85c   ; de_mas_a: DE = DE + A
	ld bc,00001h		;a85f
	ret			;a862
paso_de_fundido_b:		; un paso del segundo fundido (0xE498), fila 0xE499
	ld a,(0e498h)		;a863   ; sin segundo fundido, nada
	and a			;a866
	ret z			;a867
	ld hl,(0e49ah)		;a868   ; lee la VRAM del segundo fundido y el byte siguiente (16 bits)
	ld a,(0e49ch)		;a86b   ; lee cuantos caracteres funde el segundo
	ld b,a			;a86e
	ld de,0e800h		;a86f   ; desde 0xE800
	ld a,(0e499h)		;a872   ; lee la fila del segundo fundido
	call fila_de_caracteres		;a875   ; la fila
	ld a,(0e499h)		;a878   ; la siguiente
	inc a			;a87b
	cp 008h		;a87c
	jr z,L_A884		;a87e
	ld (0e499h),a		;a880   ; guarda la fila del segundo fundido
	ret			;a883
L_A884:
	xor a			;a884   ; acabado
	ld (0e498h),a		;a885   ; guarda el segundo fundido en marcha
	ret			;a888
sprites_a_vram_b:		; los 32 sprites de 0xE280 a la VRAM 0x3B00
	ld bc,00080h		;a889   ; 128 bytes
	ld hl,0e280h		;a88c   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	ld de,03b00h		;a88f
	jp 0005ch		;a892   ; BIOS LDIRVM - Block transfers to VRAM from memory
borra_pantalla_ram:		; la pantalla de RAM (0xED00-0xEFFF) a cero y copia sus 2 primeras filas a 0xEFC0; luego a la VRAM
	ld hl,0ed00h		;a895   ; la pantalla de RAM a cero
	ld de,0ed01h		;a898
	ld bc,002ffh		;a89b
	xor a			;a89e
	ld (hl),a			;a89f
	ldir		;a8a0
	ld hl,0ed00h		;a8a2   ; sus dos primeras filas a 0xEFC0
	ld de,0efc0h		;a8a5
	ld bc,00040h		;a8a8
	ldir		;a8ab
pantalla_ram_a_vram:		; los 768 nombres de 0xED00 a la tabla de nombres
	ld bc,00300h		;a8ad   ; 768 nombres
	ld hl,03800h		;a8b0
	ld de,0ed00h		;a8b3   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	jp 04a33h		;a8b6   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)

; ----------------------------------------------------------------------
; DATOS lista_A8B9: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A666 (122 bytes)
;   0xa8b9..0xa933  (122 bytes)
DATA_lista_A8B9:
	defb 04fh,038h,03ah,03ch,0feh,06fh,038h,03bh,03dh,0feh,0c5h,038h,0a1h,0a2h,0a3h,0a4h	; a8b9  O8:<.o8.=..8....
	defb 0fbh,06dh,041h,0a5h,0a6h,0a7h,000h,0a8h,0a9h,0aah,0abh,0a6h,0ach,0adh,0abh,0aeh	; a8c9  .mA.............
	defb 0abh,0afh,038h,0feh,028h,039h,042h,0b0h,0a3h,0b1h,06dh,041h,0a4h,0fbh,0afh,0b2h	; a8d9  ..8.(9B...mA....
	defb 0abh,0b3h,0b4h,0a8h,0b5h,0b6h,0b4h,0feh,06ch,039h,0b7h,0aeh,0b8h,0fbh,043h,0a3h	; a8e9  ........l9....C.
	defb 0afh,038h,0feh,0aah,039h,0a3h,0b2h,0a3h,0b9h,0a2h,0fbh,06dh,041h,0a9h,0bbh,0bch	; a8f9  .8..9......mA...
	defb 0fbh,0feh,0e8h,039h,0bdh,0a2h,0aeh,0a3h,0afh,044h,045h,0a7h,0b7h,0b8h,0b6h,046h	; a909  ...9.....DE....F
	defb 0bfh,0b3h,0a8h,0a5h,038h,0feh,06dh,03ah,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h	; a919  ....8.m:`a......
	defb 047h,048h,04bh,04ch,000h,049h,04ah,0b5h,0b6h,0ffh	; a929  GHKL.IJ...

; ----------------------------------------------------------------------
; DATOS lista_A933: lista a la VRAM (p00:4A6B) que p10:A0B4 pinta en un MSX
;   japones (0x002B & 0x0F = 0); en los demas, la de 0xB151; lo leen p10:A0B4
;   (78 bytes)
;   0xa933..0xa981  (78 bytes)
DATA_lista_A933:
	defb 003h,03ah,04dh,04eh,04fh,000h,003h,003h,003h,001h,050h,000h,0eeh,0efh,0f0h,0f1h	; a933  .:MNO.....P.....
	defb 0f2h,0f3h,051h,052h,04dh,04eh,053h,054h,055h,056h,057h,0f4h,0f5h,0feh,04dh,03ah	; a943  ..QRMNSTUVW...M:
	defb 0f6h,0f7h,0aeh,06fh,058h,0c0h,0b5h,0b3h,0f8h,093h,0f0h,0f9h,093h,059h,044h,038h	; a953  ...oX........YD8
	defb 0feh,08dh,03ah,05ah,051h,0efh,093h,0ddh,0a4h,0fbh,0eeh,0efh,0f0h,0f1h,0f2h,0f3h	; a963  ..:ZQ...........
	defb 07fh,0a7h,085h,086h,0feh,0cdh,03ah,059h,087h,0aah,0bfh,0a2h,038h,0ffh	; a973  ......:Y....8.

; ----------------------------------------------------------------------
; DATOS listas_A981: 11 listas a la VRAM (p00:4A6B) seguidas, de 0xA981 a
;   0xACAB: la primera la pinta p10:A0EC en un MSX japones (0x002B & 0x0F = 0)
;   (en los demas, 0xB1AA), y p10:A1C5 pasa 0xAB29, de dentro de una de ellas,
;   a L_A245; lo leen p10:A0F4 (810 bytes)
;   0xa981..0xacab  (810 bytes)
DATA_listas_A981:
	defb 003h,03ah,04dh,04eh,04fh,000h,003h,003h,003h,001h,050h,000h,0f4h,0f5h,0f6h,0f7h	; a981  .:MNO.....P.....
	defb 088h,089h,0aeh,06fh,058h,0a4h,08ah,08bh,0aah,0ach,0fbh,0f8h,093h,0feh,04dh,03ah	; a991  ...oX.........M:
	defb 0f0h,0f9h,093h,0a4h,05eh,05fh,0a3h,0a2h,038h,0feh,08dh,03ah,05ah,051h,0efh,093h	; a9a1  ....^_..8..:ZQ..
	defb 0ddh,06eh,05ch,0a4h,0fbh,0f4h,0f5h,0f6h,0f7h,0aeh,06fh,058h,0a7h,0feh,0cdh,03ah	; a9b1  .n\.......oX...:
	defb 060h,061h,0dch,093h,0dbh,0c1h,062h,063h,0a3h,0a2h,038h,0ffh,023h,03ah,04dh,04eh	; a9c1  `a....bc..8.#:MN
	defb 04fh,000h,003h,003h,003h,002h,050h,000h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,051h,052h	; a9d1  O.....P.......QR
	defb 05ah,051h,0efh,093h,0ddh,06eh,05ch,05dh,065h,038h,0feh,08dh,03ah,0f4h,0f5h,0f6h	; a9e1  ZQ...n\]e8..:...
	defb 0f7h,0aeh,06fh,058h,0a4h,0fbh,060h,061h,0dch,093h,0dbh,0b2h,0aeh,06ah,0feh,0cdh	; a9f1  ..oX..`a.....j..
	defb 03ah,046h,06bh,06ch,038h,066h,067h,068h,069h,0b0h,0abh,0b3h,038h,0ffh,023h,03ah	; aa01  :Fkl8fghi...8.#:
	defb 04dh,04eh,04fh,000h,003h,003h,003h,002h,050h,000h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h	; aa11  MNO.....P.......
	defb 051h,052h,07fh,0a4h,0fbh,0deh,0dfh,0f8h,0e0h,0e1h,0e2h,0feh,06dh,03ah,093h,0c0h	; aa21  QR..........m:..
	defb 072h,0c2h,0e3h,0e1h,0e2h,093h,0f3h,0e4h,093h,0f3h,0e5h,0e6h,0e1h,0f9h,093h,0feh	; aa31  r...............
	defb 0adh,03ah,0e7h,0f9h,0e8h,0e9h,0eah,0a8h,076h,059h,0c0h,0bah,0beh,038h,0ffh,0c3h	; aa41  .:......vY...8..
	defb 039h,04dh,04eh,04fh,000h,080h,080h,080h,080h,050h,000h,060h,061h,0eeh,0efh,0f0h	; aa51  9MNO.....P.`a...
	defb 0f1h,0f2h,0f3h,0a8h,0ebh,0e9h,039h,0f3h,0e4h,093h,0f3h,0ech,0feh,00dh,03ah,0efh	; aa61  ......9.......:.
	defb 0eah,0edh,081h,060h,061h,0b2h,0aeh,0a8h,08dh,08eh,0bch,093h,08ch,0c0h,0b0h,0a5h	; aa71  ...`a...........
	defb 0feh,04dh,03ah,0c3h,0b3h,03eh,0dch,0e1h,0dah,0eah,0edh,039h,0cfh,0e1h,0edh,0e7h	; aa81  .M:..>.....9....
	defb 0d0h,08fh,090h,03fh,0feh,08dh,03ah,059h,044h,038h,091h,092h,0b2h,0c0h,0b5h,0b3h	; aa91  ...?..:YD8......
	defb 000h,0a3h,0c4h,0b6h,0c5h,0b8h,0c6h,0bdh,0feh,0cdh,03ah,0b3h,0a9h,0b0h,0bch,095h	; aaa1  ..........:.....
	defb 094h,038h,0ffh,003h,03ah,04dh,04eh,04fh,000h,003h,003h,003h,003h,050h,000h,043h	; aab1  .8..:MNO.....P.C
	defb 04ah,046h,04bh,048h,041h,044h,047h,040h,045h,043h,042h,052h,053h,054h,055h,04ch	; aac1  JFKHADG@ECBRSTUL
	defb 0feh,04dh,03ah,049h,051h,042h,038h,0ffh,08dh,03ah,0e0h,0f8h,0d1h,0e8h,0d0h,0eah	; aad1  .M:IQB8..:......
	defb 0a8h,099h,09dh,0b0h,0abh,0c7h,0a2h,0f4h,0f5h,0f6h,0f7h,0feh,0cdh,03ah,0a8h,072h	; aae1  .............:.r
	defb 0a8h,09bh,0afh,0a4h,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,0a5h,0c7h,0a2h,0fdh	; aaf1  ....`a..........
	defb 0ffh,083h,040h,092h,041h,0a2h,042h,0a3h,043h,0a4h,044h,098h,045h,0b6h,046h,0fbh	; ab01  ..@.A.B.C.D.E.F.
	defb 047h,0b8h,048h,0bdh,049h,0c4h,04ah,0c5h,04bh,0c6h,04ch,0c7h,051h,0f4h,052h,0f5h	; ab11  G.H.I.J.K.L.Q.R.
	defb 053h,0f6h,054h,0f7h,055h,038h,0fdh,000h,003h,080h,004h,081h,000h,024h,03ah,03eh	; ab21  S.T.U8.......$:>
	defb 0f4h,0f5h,0f6h,0f7h,0a4h,000h,05ah,051h,0efh,093h,0ddh,0c0h,0b5h,0c7h,0b1h,060h	; ab31  ......ZQ.......`
	defb 061h,0dch,093h,0dbh,0c1h,062h,063h,0feh,064h,03ah,0aah,0ach,0a2h,0a8h,0c8h,0fbh	; ab41  a....bc.d:......
	defb 0e0h,0f8h,0d1h,0e8h,0d0h,0eah,0a8h,0a2h,035h,0a6h,0a7h,0b2h,0b6h,0b1h,060h,061h	; ab51  ........5.....`a
	defb 0d7h,0eah,0c1h,0feh,0a4h,03ah,06ah,046h,06bh,06ch,0a3h,0b1h,0afh,0a2h,038h,03fh	; ab61  .....:jFkl....8?
	defb 0ffh,024h,03ah,03eh,060h,061h,0d7h,0eah,0c0h,02ah,093h,0f3h,0a7h,0b2h,0b9h,0c3h	; ab71  .$:>`a...*......
	defb 0a2h,0f4h,0f5h,0f6h,0f7h,0a4h,0fbh,072h,0b7h,033h,0b0h,0feh,064h,03ah,004h,0b7h	; ab81  .......r.3..d:..
	defb 0a8h,0f3h,0e4h,093h,0f3h,0ech,0efh,0eah,0edh,0a7h,000h,0a3h,0c4h,0b6h,0c5h,0b8h	; ab91  ................
	defb 0a3h,0a2h,038h,0feh,0a4h,03ah,0f4h,0f5h,0f6h,0f7h,0a8h,0a3h,0c4h,0b6h,0c5h,0b8h	; aba1  ..8..:..........
	defb 0a4h,0fbh,0afh,0b9h,000h,0b9h,0aah,0c0h,060h,061h,0eeh,0efh,0f0h,0f1h,0feh,0e4h	; abb1  ........`a......
	defb 03ah,0f2h,0f3h,0c0h,0cbh,0b5h,02eh,02dh,0b0h,0a3h,0b1h,0afh,0b3h,038h,03fh,0ffh	; abc1  :......-.....8?.
	defb 024h,03ah,03eh,0f4h,0f5h,0f6h,0f7h,0a8h,0a3h,0c4h,0b6h,0c5h,0b8h,0a7h,0b8h,0afh	; abd1  $:>.............
	defb 0b0h,031h,0b3h,0c0h,0a4h,0fbh,004h,0b7h,0a8h,0f3h,0feh,064h,03ah,0e4h,093h,0f3h	; abe1  .1.........d:...
	defb 0ech,0efh,0eah,0edh,0a7h,0b0h,0b6h,0b4h,030h,0a3h,0fbh,060h,061h,0d7h,0eah,0c0h	; abf1  ........0..`a...
	defb 0afh,0b3h,0f4h,0f5h,0f6h,0feh,0a4h,03ah,0f7h,0a7h,0a2h,0cbh,0aah,0abh,0a6h,0ach	; ac01  .......:........
	defb 0adh,0abh,0aeh,0abh,0afh,038h,03fh,0ffh,003h,03ah,04dh,04eh,04fh,000h,003h,003h	; ac11  .....8?..:MNO...
	defb 003h,003h,050h,000h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,051h,052h,07fh,0dch,0d2h,0dfh	; ac21  ..P.......QR....
	defb 0edh,0a4h,0fbh,0e7h,0f9h,0feh,04dh,03ah,0e8h,0e9h,0eah,046h,087h,0a7h,097h,09ah	; ac31  ......M:...F....
	defb 038h,0e2h,0e1h,0d3h,0dfh,0edh,0c0h,0a4h,09ch,0feh,08dh,03ah,0deh,0dfh,0f8h,0e0h	; ac41  8..........:....
	defb 0e1h,0e2h,093h,0a8h,0e2h,0e1h,0d3h,0dfh,0edh,039h,0d4h,0f5h,0e1h,0feh,0cdh,03ah	; ac51  .........9.....:
	defb 0f7h,0f3h,039h,0e0h,093h,0edh,0eah,0bch,096h,046h,0aah,0ach,0a2h,038h,0ffh,023h	; ac61  ..9......F...8.#
	defb 03ah,0d4h,0f5h,0e1h,0f7h,0f3h,039h,0e0h,093h,0edh,0eah,000h,000h,000h,003h,003h	; ac71  :.....9.........
	defb 001h,0fdh,050h,044h,0b9h,0ach,038h,0feh,070h,03ah,051h,052h,07fh,04dh,04eh,075h	; ac81  ..PD..8.p:QR.MNu
	defb 07fh,000h,077h,078h,079h,07ah,038h,0feh,0b0h,03ah,09ch,0deh,0dfh,0f8h,0e0h,0e1h	; ac91  ..wxyz8..:......
	defb 0e2h,093h,000h,0e2h,0e1h,0d3h,0dfh,0edh,038h,0ffh	; aca1  ........8.

; ----------------------------------------------------------------------
; DATOS rachas_f_ACAB: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A0A1 (274 bytes)
;   0xacab..0xadbd  (274 bytes)
DATA_rachas_f_ACAB:
	defb 005h,000h,081h,017h,015h,000h,087h,00fh,015h,025h,025h,027h,00ah,008h,00bh,025h	; acab  .........%%'...%
	defb 081h,010h,005h,025h,004h,000h,089h,019h,006h,000h,02ah,00bh,00ch,011h,008h,02dh	; acbb  ...%......*....-
	defb 006h,000h,084h,02ah,014h,01ah,004h,003h,000h,081h,026h,004h,000h,088h,026h,000h	; accb  ...*......&...&.
	defb 000h,028h,00ah,01ah,003h,004h,007h,000h,082h,016h,003h,005h,000h,08dh,026h,017h	; acdb  .(............&.
	defb 01bh,000h,000h,026h,005h,000h,01bh,02ch,002h,005h,006h,003h,000h,083h,01ch,024h	; aceb  ...&...,.......$
	defb 023h,003h,000h,081h,01bh,003h,000h,08ch,02ah,014h,00bh,01ah,000h,000h,026h,00eh	; acfb  #.......*.....&.
	defb 02eh,02bh,00ah,001h,003h,000h,084h,01dh,000h,000h,01eh,003h,000h,088h,02ah,01ah	; ad0b  .+............*.
	defb 004h,010h,000h,018h,016h,003h,003h,000h,087h,026h,000h,016h,029h,02ch,009h,010h	; ad1b  .........&..),..
	defb 003h,000h,08eh,01fh,000h,020h,021h,000h,000h,018h,000h,000h,018h,004h,000h,000h	; ad2b  ..... !.........
	defb 031h,003h,000h,088h,026h,000h,000h,02ah,00dh,013h,008h,02dh,005h,000h,081h,022h	; ad3b  1...&..*...-..."
	defb 006h,000h,084h,017h,000h,000h,031h,003h,000h,087h,026h,00eh,014h,030h,02ch,012h	; ad4b  ......1...&..0,.
	defb 007h,003h,000h,084h,01dh,000h,000h,01fh,005h,000h,085h,02ah,00ah,011h,008h,031h	; ad5b  ...........*...1
	defb 003h,000h,089h,026h,000h,029h,02fh,02bh,00ch,011h,008h,017h,008h,000h,087h,02ah	; ad6b  ...&.)/+.......*
	defb 008h,02bh,00dh,030h,00ch,031h,003h,000h,08bh,026h,01bh,02ah,00dh,013h,012h,00bh	; ad7b  .+.0.1...&.*....
	defb 013h,02bh,02dh,010h,004h,000h,089h,01bh,02ah,02ch,012h,013h,00bh,02bh,02ch,031h	; ad8b  .+-.....*,...+,1
	defb 003h,000h,098h,026h,014h,00ah,02bh,02bh,00dh,02ch,012h,00ch,012h,011h,02dh,000h	; ad9b  ...&..++.,....-.
	defb 000h,00eh,030h,013h,00ch,00ch,013h,02bh,012h,012h,031h,004h,000h,016h,032h,003h	; adab  ..0....+..1...2.
	defb 000h,000h	; adbb

; ----------------------------------------------------------------------
; DATOS rachas_f_ADBD: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A0E1 (170 bytes)
;   0xadbd..0xae67  (170 bytes)
DATA_rachas_f_ADBD:
	defb 006h,000h,085h,010h,01ch,014h,013h,012h,00fh,000h,087h,020h,022h,01dh,024h,025h	; adbd  ........... ".$%
	defb 026h,021h,00eh,000h,08bh,030h,031h,01dh,033h,034h,035h,036h,0f0h,0d8h,0fch,0fah	; adcd  &!...01.3456....
	defb 00ah,000h,08dh,040h,01ah,01bh,01fh,044h,045h,046h,000h,0d3h,097h,0beh,0d7h,0d6h	; addd  ...@...DEF......
	defb 008h,000h,08dh,09fh,02dh,019h,02eh,02fh,016h,050h,000h,09ah,098h,0bfh,09dh,099h	; aded  ....-../.P......
	defb 007h,000h,08eh,0f4h,09bh,063h,064h,061h,029h,062h,015h,000h,0b3h,0d9h,0bdh,096h	; adfd  .....cda)b......
	defb 09eh,007h,000h,08fh,09ch,000h,070h,074h,072h,073h,071h,000h,0f2h,0b4h,0dah,0dch	; ae0d  ......ptrsq.....
	defb 0deh,0b7h,03bh,006h,000h,08fh,0b9h,0bbh,000h,018h,017h,080h,083h,000h,0b2h,0b5h	; ae1d  ................
	defb 0f5h,0ddh,0b6h,04fh,039h,006h,000h,08fh,0b8h,0bch,0f6h,0a0h,0a2h,0a1h,000h,0fdh	; ae2d  ...O9...........
	defb 0f9h,0f1h,0dbh,0fbh,04dh,04ah,03ah,007h,000h,082h,0bah,0f3h,005h,000h,088h,0f7h	; ae3d  ....MJ:.........
	defb 0f8h,000h,03eh,03fh,04bh,04eh,0d4h,007h,000h,081h,03ch,003h,000h,08bh,0feh,0ffh	; ae4d  ..>?KN....<.....
	defb 000h,03dh,047h,049h,048h,04ch,0dfh,0b1h,0d5h,000h	; ae5d  .=GIHL....

; ----------------------------------------------------------------------
; DATOS rachas_f_AE67: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A13D (47 bytes)
;   0xae67..0xae96  (47 bytes)
DATA_rachas_f_AE67:
	defb 004h,000h,082h,001h,002h,00bh,000h,080h,004h,003h,00ah,000h,080h,004h,007h,00ah	; ae67  ................
	defb 000h,080h,005h,00bh,006h,000h,083h,011h,000h,000h,080h,007h,012h,004h,000h,080h	; ae77  ................
	defb 00dh,019h,081h,000h,080h,02ah,026h,003h,000h,080h,00ah,050h,081h,000h,000h	; ae87  .....*&....P...

; ----------------------------------------------------------------------
; DATOS rachas_f_AE96: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A148 (18 bytes)
;   0xae96..0xaea8  (18 bytes)
DATA_rachas_f_AE96:
	defb 080h,005h,05ah,003h,000h,080h,010h,05fh,080h,008h,071h,080h,008h,07ch,080h,008h	; ae96  ..Z...._..q..|..
	defb 088h,000h	; aea6

; ----------------------------------------------------------------------
; DATOS rachas_f_AEA8: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A153 (21 bytes)
;   0xaea8..0xaebd  (21 bytes)
DATA_rachas_f_AEA8:
	defb 082h,06fh,070h,004h,000h,080h,003h,079h,003h,000h,080h,004h,084h,002h,000h,080h	; aea8  .op....y........
	defb 005h,090h,081h,000h,000h	; aeb8

; ----------------------------------------------------------------------
; DATOS rachas_ram_AEBD: rachas a la RAM (p10:A6EB, el mismo formato que
;   p00:4A8C); lo leen p10:A2DE (176 bytes)
;   0xaebd..0xaf6d  (176 bytes)
DATA_rachas_ram_AEBD:
	defb 009h,000h,080h,003h,001h,013h,000h,085h,010h,011h,014h,013h,012h,011h,000h,081h	; aebd  ................
	defb 020h,080h,005h,022h,081h,021h,010h,000h,080h,007h,030h,010h,000h,080h,007h,040h	; aecd   ..".!....0....@
	defb 010h,000h,08ch,052h,056h,051h,054h,055h,053h,050h,059h,000h,000h,057h,058h,00ch	; aedd  ...RVQTUSPY..WX.
	defb 000h,08ch,063h,064h,061h,065h,062h,060h,06bh,06ah,067h,069h,068h,066h,006h,000h	; aeed  ..cdaeb`kjgihf..
	defb 092h,075h,076h,000h,000h,07bh,070h,074h,072h,073h,071h,000h,077h,07ah,07eh,078h	; aefd  .uv..{ptrsq.wz~x
	defb 079h,07ch,07dh,004h,000h,0d4h,084h,087h,08dh,090h,08eh,08fh,000h,081h,082h,080h	; af0d  y|}.............
	defb 083h,088h,08bh,08ah,089h,000h,091h,08ch,085h,086h,000h,000h,0abh,0ach,0a3h,0a4h	; af1d  ................
	defb 0a5h,0aah,0afh,000h,0a0h,0a2h,0a1h,000h,0a6h,0b0h,0a9h,0a7h,000h,000h,0adh,0aeh	; af2d  ................
	defb 0a8h,000h,0c0h,0c1h,0d0h,0c2h,000h,0c3h,0c7h,0cfh,0c4h,0cch,0ceh,0cdh,000h,0c6h	; af3d  ................
	defb 0cbh,0cah,0c5h,000h,000h,0c8h,0c9h,0d1h,0d2h,0e0h,0ebh,0eah,000h,000h,0e1h,0e3h	; af4d  ................
	defb 0e9h,0e4h,000h,0ech,000h,0e2h,0e6h,0e7h,0e8h,0e5h,003h,000h,080h,003h,0edh,000h	; af5d  ................

; ----------------------------------------------------------------------
; DATOS rachas_f_AF6D: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A449 (118 bytes)
;   0xaf6d..0xafe3  (118 bytes)
DATA_rachas_f_AF6D:
	defb 002h,000h,081h,01fh,011h,021h,081h,024h,004h,000h,081h,020h,006h,000h,081h,000h	; af6d  .....!.$... ....
	defb 003h,000h,088h,006h,000h,00dh,000h,000h,00fh,000h,025h,004h,000h,081h,020h,008h	; af7d  ..........%... .
	defb 000h,084h,00dh,000h,000h,013h,004h,000h,091h,026h,007h,008h,009h,000h,000h,020h	; af8d  .........&.....
	defb 000h,000h,02dh,000h,00dh,000h,000h,013h,000h,006h,007h,000h,081h,025h,004h,000h	; af9d  ..-..........%..
	defb 085h,020h,000h,01eh,023h,01dh,00dh,000h,089h,025h,000h,000h,001h,002h,003h,004h	; afad  . ..#....%......
	defb 005h,022h,00eh,000h,081h,025h,004h,000h,081h,020h,011h,000h,081h,025h,004h,000h	; afbd  ."...%... ...%..
	defb 083h,028h,029h,029h,004h,000h,081h,00eh,00ah,029h,081h,027h,007h,000h,084h,00ah	; afcd  .()).....).'....
	defb 00bh,00ch,005h,00eh,000h,000h	; afdd

; ----------------------------------------------------------------------
; DATOS rachas_f_AFE3: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A204 (3 bytes)
;   0xafe3..0xafe6  (3 bytes)
DATA_rachas_f_AFE3:
	defb 01bh,02eh,000h	; afe3

; ----------------------------------------------------------------------
; DATOS rachas_f_AFE6: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A190 (137 bytes)
;   0xafe6..0xb06f  (137 bytes)
DATA_rachas_f_AFE6:
	defb 081h,0b8h,01dh,0b7h,002h,0b6h,080h,003h,003h,00fh,000h,080h,003h,014h,082h,000h	; afe6  ................
	defb 071h,080h,006h,06ah,002h,0b6h,080h,003h,006h,002h,000h,080h,004h,064h,007h,000h	; aff6  q..j.........d..
	defb 080h,005h,017h,081h,070h,006h,072h,081h,000h,002h,0b6h,005h,000h,004h,069h,081h	; b006  ....p.r.......i.
	defb 068h,080h,00bh,01ch,008h,000h,002h,0b6h,008h,000h,080h,00eh,027h,007h,000h,002h	; b016  h...........'...
	defb 0b6h,007h,000h,080h,00fh,035h,007h,000h,002h,0b6h,00ah,000h,081h,07dh,003h,000h	; b026  .....5.......}..
	defb 081h,07fh,00eh,000h,002h,0b6h,080h,00ah,073h,005h,000h,081h,080h,080h,007h,082h	; b036  ........s.......
	defb 003h,000h,083h,009h,00ah,000h,002h,0b6h,009h,07eh,007h,000h,006h,081h,007h,000h	; b046  .........~......
	defb 081h,0b6h,01eh,0b7h,00ch,000h,080h,009h,00bh,034h,000h,080h,00bh,044h,02dh,000h	; b056  .........4...D-.
	defb 080h,00ch,04fh,081h,000h,080h,009h,05bh,000h	; b066  ..O....[.

; ----------------------------------------------------------------------
; DATOS rachas_f_B06F: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); se solapan 2 bloques: (rachas_ram_B06F B06F-B0AB); lo leen
;   p10:BC16, p10:A5CC (60 bytes)
;   0xb06f..0xb0ab  (60 bytes)
DATA_rachas_f_B06F:
	defb 083h,003h,001h,002h,080h,005h,004h,08bh,010h,00fh,00eh,00dh,00ch,00ah,009h,00bh	; b06f  ................
	defb 013h,011h,012h,080h,005h,014h,098h,020h,01fh,01eh,01dh,01ch,01ah,019h,01bh,026h	; b07f  ....... .......&
	defb 021h,022h,025h,023h,027h,024h,028h,030h,02ch,02fh,02bh,02dh,02ah,029h,02eh,080h	; b08f  !"%#'$(0,/+-*)..
	defb 008h,031h,088h,040h,03fh,03eh,03dh,03ch,03bh,03ah,039h,000h	; b09f  .1.@?>=<.:9.

; ----------------------------------------------------------------------
; DATOS rachas_f_B0AB: rachas a la VRAM por filas (p10:A67B) que p10:A10C
;   alterna cada 8 cuadros (0xB0AB y 0xB0B1); lo leen p10:A121 (6 bytes)
;   0xb0ab..0xb0b1  (6 bytes)
DATA_rachas_f_B0AB:
	defb 084h,02dh,019h,02eh,02fh,000h	; b0ab

; ----------------------------------------------------------------------
; DATOS rachas_f_B0B1: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:A121 (6 bytes)
;   0xb0b1..0xb0b7  (6 bytes)
DATA_rachas_f_B0B1:
	defb 084h,02ah,019h,02bh,02ch,000h	; b0b1

; ----------------------------------------------------------------------
; DATOS tabla_B0B7: 10 palabras (el paso 0xE496 de 0 a 9) que p10:A3A1 lee con
;   L_4B60; lo leen p10:A3A7 (20 bytes)
;   0xb0b7..0xb0cb  (20 bytes)
DATA_tabla_B0B7:
	defb 008h,000h,080h,000h,000h,001h,080h,001h,000h,002h,080h,002h,000h,003h,080h,003h	; b0b7  ................
	defb 000h,004h,000h,005h	; b0c7

; ----------------------------------------------------------------------
; DATOS tabla_B0CB: 10 bytes, uno por paso (0xE496), que p10:A3AB pasa en B a
;   L_A717; lo leen p10:A3B1 (10 bytes)
;   0xb0cb..0xb0d5  (10 bytes)
DATA_tabla_B0CB:
	defb 00fh,010h,010h,010h,010h,010h,010h,010h,020h,020h	; b0cb  ........

; ----------------------------------------------------------------------
; DATOS tabla_B0D5: fichas de 3 bytes por paso (0xE496 x 3):
;   [cuantos][puntero] que leen p10:B700 (0xB0DB, por 0xF000/0xF006) y
;   p10:A4E2 (0xB0E1); lo leen p10:B700 (124 bytes)
;   0xb0d5..0xb151  (124 bytes)
DATA_tabla_B0D5:
	defb 010h,008h,001h,010h,088h,001h,010h,088h,000h,010h,008h,000h,015h,00bh,009h,016h	; b0d5  ................
	defb 00ch,00ah,017h,00dh,00bh,018h,00fh,00ah,01ah,010h,00ah,01bh,010h,009h,019h,011h	; b0e5  ................
	defb 009h,018h,012h,008h,01ah,013h,008h,01bh,013h,007h,019h,014h,007h,018h,015h,006h	; b0f5  ................
	defb 014h,016h,006h,010h,016h,005h,011h,015h,005h,02bh,014h,005h,012h,014h,006h,02ch	; b105  .........+.....,
	defb 013h,006h,010h,012h,006h,02ah,012h,005h,011h,011h,006h,02ah,011h,007h,012h,010h	; b115  .....*.....*....
	defb 007h,02bh,010h,006h,02ch,00fh,007h,010h,00eh,007h,02eh,00eh,005h,011h,00dh,007h	; b125  .+..,...........
	defb 02bh,00ch,007h,012h,00ch,008h,085h,001h,002h,003h,004h,005h,000h,084h,00ah,00bh	; b135  +...............
	defb 00ch,005h,000h,084h,026h,007h,008h,009h,000h,005h,02eh,000h	; b145  ....&.......

; ----------------------------------------------------------------------
; DATOS lista_B151: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A0B4 (89 bytes)
;   0xb151..0xb1aa  (89 bytes)
DATA_lista_B151:
	defb 001h,03ah,00ah,018h,021h,01ch,00bh,014h,015h,013h,000h,01ah,00eh,00bh,000h,00ah	; b151  .:..!...........
	defb 00fh,018h,00bh,009h,01ah,015h,018h,000h,00dh,00bh,014h,00bh,018h,007h,012h,0feh	; b161  ................
	defb 042h,03ah,015h,00ch,000h,01ah,00eh,00bh,000h,019h,016h,007h,009h,00bh,000h,019h	; b171  B:..............
	defb 009h,00fh,00bh,014h,009h,00bh,000h,007h,00dh,00bh,014h,009h,01fh,0feh,084h,03ah	; b181  ...............:
	defb 007h,01ah,01ah,00bh,013h,016h,01ah,00bh,00ah,000h,007h,000h,009h,015h,01bh,016h	; b191  ................
	defb 000h,00ah,023h,00bh,01ah,007h,01ah,021h,0ffh	; b1a1  ..#....!.

; ----------------------------------------------------------------------
; DATOS lista_B1AA: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A0F4 (106 bytes)
;   0xb1aa..0xb214  (106 bytes)
DATA_lista_B1AA:
	defb 004h,03ah,00ah,018h,021h,01ch,00bh,014h,015h,013h,000h,00ch,007h,00fh,012h,00bh	; b1aa  .:..!...........
	defb 00ah,000h,00fh,014h,000h,007h,000h,009h,015h,01bh,016h,0feh,045h,03ah,00ah,023h	; b1ba  ............E:.#
	defb 00bh,01ah,007h,01ah,000h,007h,014h,00ah,000h,01dh,007h,019h,000h,009h,007h,016h	; b1ca  ................
	defb 01ah,01bh,018h,00bh,00ah,021h,0feh,082h,03ah,00bh,013h,016h,00bh,018h,015h,018h	; b1da  .....!..:.......
	defb 000h,012h,007h,018h,019h,000h,00bh,01eh,00fh,012h,00bh,00ah,000h,00ah,018h,021h	; b1ea  ...............!
	defb 01ch,00bh,014h,015h,013h,0feh,0c9h,03ah,01ah,015h,000h,016h,012h,007h,014h,00bh	; b1fa  .......:........
	defb 01ah,000h,019h,007h,018h,00ah,021h,000h,000h,0ffh	; b20a  ......!...

; ----------------------------------------------------------------------
; DATOS lista_B214: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A166 (58 bytes)
;   0xb214..0xb24e  (58 bytes)
DATA_lista_B214:
	defb 028h,03ah,009h,015h,019h,013h,00fh,009h,000h,01fh,00bh,007h,018h,000h,003h,003h	; b214  (:..............
	defb 003h,002h,0feh,068h,03ah,00ah,018h,021h,01ch,00bh,014h,015h,013h,000h,00bh,019h	; b224  ...h:..!........
	defb 009h,007h,016h,00bh,00ah,0feh,0a8h,03ah,00ch,018h,015h,013h,000h,016h,012h,007h	; b234  .......:........
	defb 014h,00bh,01ah,000h,019h,007h,018h,00ah,021h,0ffh	; b244  ........!.

; ----------------------------------------------------------------------
; DATOS lista_B24E: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A1A3 (80 bytes)
;   0xb24e..0xb29e  (80 bytes)
DATA_lista_B24E:
	defb 023h,03ah,00eh,00bh,000h,01dh,007h,019h,000h,014h,015h,01ah,000h,00ch,015h,01bh	; b24e  #:..............
	defb 014h,00ah,022h,000h,00ah,00bh,019h,016h,00fh,01ah,00bh,0feh,061h,03ah,01ah,00eh	; b25e  ..".........a:..
	defb 00bh,000h,019h,00bh,007h,018h,009h,00eh,000h,015h,00ch,000h,00fh,013h,016h,00bh	; b26e  ................
	defb 018h,00fh,007h,012h,000h,007h,018h,013h,007h,00ah,007h,021h,0feh,0a8h,03ah,009h	; b27e  ...........!..:.
	defb 015h,019h,013h,00fh,009h,000h,01fh,00bh,007h,018h,000h,003h,003h,003h,003h,0ffh	; b28e  ................

; ----------------------------------------------------------------------
; DATOS lista_B29E: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A1E3 (148 bytes)
;   0xb29e..0xb332  (148 bytes)
DATA_lista_B29E:
	defb 0c2h,039h,067h,072h,072h,000h,07ah,06eh,06bh,000h,069h,075h,073h,073h,07bh,074h	; b29e  .9grr.znk.iuss{t
	defb 06fh,069h,067h,07ah,06fh,075h,074h,079h,000h,07dh,06fh,07ah,06eh,0feh,001h,03ah	; b2ae  oigzouty.}ozn..:
	defb 064h,000h,076h,072h,067h,074h,06bh,07ah,079h,082h,000h,074h,06bh,073h,06bh,079h	; b2be  d.vrgtkzy..tksky
	defb 06fh,079h,083h,000h,074h,06bh,075h,085h,079h,078h,067h,069h,06bh,085h,0feh,042h	; b2ce  oy..tku.yxgik..B
	defb 03ah,076h,072h,067h,074h,07ah,082h,07dh,06bh,078h,06bh,000h,079h,07bh,06ah,06ah	; b2de  :vrgtz.}kxk.y{jj
	defb 06bh,074h,072h,07fh,000h,079h,07ah,075h,076h,076h,06bh,06ah,081h,0feh,082h,03ah	; b2ee  ktr..yzuvvkj...:
	defb 06fh,07ah,000h,068h,06bh,069h,067h,073h,06bh,000h,069h,072h,06bh,067h,078h,000h	; b2fe  oz.hkigsk.irkgx.
	defb 07ah,06eh,067h,07ah,000h,079h,075h,073h,06bh,075h,074h,06bh,0feh,0c6h,03ah,06fh	; b30e  zngz.yuskutk..:o
	defb 074h,07ch,067h,06ah,06bh,06ah,000h,07ah,06eh,06bh,000h,076h,072h,067h,074h,06bh	; b31e  t|gjkj.znk.vrgtk
	defb 07ah,079h,081h,0ffh	; b32e

; ----------------------------------------------------------------------
; DATOS lista_B332: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A23D (28 bytes)
;   0xb332..0xb34e  (28 bytes)
DATA_lista_B332:
	defb 004h,03ah,01ah,00eh,00bh,000h,00fh,014h,01ch,007h,00ah,00bh,018h,000h,01dh,007h	; b332  .:..............
	defb 019h,000h,00ah,018h,021h,01ch,00bh,014h,015h,013h,021h,0ffh	; b342  ....!.....!.

; ----------------------------------------------------------------------
; DATOS lista_B34E: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A3F9 (81 bytes)
;   0xb34e..0xb39f  (81 bytes)
DATA_lista_B34E:
	defb 042h,03ah,06ah,078h,081h,07ch,06bh,074h,075h,073h,000h,067h,07ah,07ah,06bh,073h	; b34e  B:jx.|ktus.gzzks
	defb 076h,07ah,06bh,06ah,000h,07ah,075h,000h,06fh,074h,07ch,067h,06ah,06bh,0feh,083h	; b35e  vzkj.zu.ot|gjk..
	defb 03ah,076h,072h,067h,074h,06bh,07ah,000h,074h,06bh,073h,06bh,079h,06fh,079h,082h	; b36e  :vrgtkz.tkskyoy.
	defb 069h,075h,074h,079h,076h,06fh,078h,06fh,074h,06dh,0feh,0c7h,03ah,07dh,06fh,07ah	; b37e  iutyvoxotm..:}oz
	defb 06eh,000h,07ah,06eh,06bh,000h,068h,067h,069h,07ah,06bh,078h,06fh,067h,074h,081h	; b38e  n.znk.hgizkxogt.
	defb 0ffh	; b39e

; ----------------------------------------------------------------------
; DATOS lista_B39F: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A42C (81 bytes)
;   0xb39f..0xb3f0  (81 bytes)
DATA_lista_B39F:
	defb 008h,03ah,009h,015h,019h,013h,00fh,009h,000h,01fh,00bh,007h,018h,000h,003h,003h	; b39f  .:..............
	defb 003h,003h,0feh,042h,03ah,01ah,00eh,00bh,000h,014h,00bh,013h,00bh,019h,00fh,019h	; b3af  ...B:...........
	defb 000h,00eh,00fh,00dh,00eh,00bh,019h,01ah,000h,009h,015h,01bh,014h,009h,00fh,012h	; b3bf  ................
	defb 0feh,082h,03ah,00ah,00bh,009h,00fh,00ah,00bh,00ah,000h,01ah,015h,000h,00ah,00fh	; b3cf  ..:.............
	defb 019h,016h,007h,01ah,009h,00eh,000h,013h,00bh,01ah,007h,012h,00fh,015h,014h,021h	; b3df  ...............!
	defb 0ffh	; b3ef

; ----------------------------------------------------------------------
; DATOS lista_B3F0: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A592 (45 bytes)
;   0xb3f0..0xb41d  (45 bytes)
DATA_lista_B3F0:
	defb 044h,03ah,010h,007h,013h,00bh,019h,000h,008h,01bh,018h,01ah,015h,014h,000h,01dh	; b3f0  D:..............
	defb 007h,019h,000h,009h,00eh,015h,019h,00bh,014h,0feh,088h,03ah,01ah,015h,000h,00ch	; b400  ...........:....
	defb 012h,01fh,000h,013h,00bh,01ah,007h,012h,00fh,015h,014h,021h,0ffh	; b410  ...........!.

; ----------------------------------------------------------------------
; DATOS lista_B41D: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:A621 (68 bytes)
;   0xb41d..0xb461  (68 bytes)
DATA_lista_B41D:
	defb 028h,03ah,013h,018h,021h,010h,007h,013h,00bh,019h,000h,008h,01bh,018h,01ah,015h	; b41d  (:..!...........
	defb 014h,0feh,064h,03ah,019h,016h,00bh,009h,00fh,007h,012h,000h,009h,007h,016h,01ah	; b42d  ..d:............
	defb 007h,00fh,014h,000h,015h,00ch,000h,00fh,021h,019h,021h,00ch,021h,0feh,0a6h,03ah	; b43d  ........!.!.!..:
	defb 00bh,01eh,025h,01ch,00fh,009h,000h,01ch,00fh,016h,00bh,018h,000h,016h,00fh,012h	; b44d  ..%.............
	defb 015h,01ah,021h,0ffh	; b45d

; ----------------------------------------------------------------------
; DATOS rachas_ED20: rachas a la RAM 0xED20 (p10:BFCF: 0 acaba; con el bit 7
;   repite el byte siguiente; sin el, copia n bytes); lo leen p10:BFD5 (293
;   bytes)
;   0xb461..0xb586  (293 bytes)
DATA_rachas_ED20:
	defb 001h,00ch,09eh,00bh,001h,01fh,087h,00ah,001h,00eh,090h,00ah,001h,021h,087h,00ah	; b461  .............!..
	defb 002h,00dh,032h,086h,000h,002h,00fh,010h,08ch,000h,002h,023h,022h,086h,000h,002h	; b471  ..2........#"...
	defb 034h,020h,082h,000h,002h,00dh,032h,085h,033h,002h,011h,012h,08ah,033h,002h,025h	; b481  4 ....2.3....3.%
	defb 024h,085h,033h,002h,034h,020h,084h,000h,004h,013h,014h,00ch,01fh,094h,033h,004h	; b491  $.3.4 ........3.
	defb 00ch,01fh,027h,026h,085h,000h,005h,015h,000h,016h,017h,032h,084h,000h,002h,018h	; b4a1  ..'&.......2....
	defb 019h,084h,000h,002h,02ch,02bh,084h,000h,005h,034h,02ah,029h,000h,028h,086h,000h	; b4b1  ....,+...4*).(..
	defb 003h,01ah,00ch,01bh,082h,000h,002h,01ch,01dh,084h,009h,004h,01eh,009h,009h,031h	; b4c1  ...............1
	defb 084h,009h,007h,030h,02fh,000h,000h,02eh,01fh,02dh,085h,000h,009h,04dh,03bh,000h	; b4d1  ...0/....-...M..
	defb 031h,000h,000h,04dh,03ch,03ah,08ah,000h,009h,04ah,04ch,04eh,000h,000h,041h,000h	; b4e1  1..M<:...JLN..A.
	defb 04bh,04eh,084h,000h,003h,030h,000h,04dh,083h,000h,002h,030h,032h,08ch,000h,002h	; b4f1  KN...0.M...02...
	defb 042h,040h,083h,000h,00ah,04eh,000h,040h,000h,000h,033h,034h,031h,000h,032h,083h	; b501  B@...N.@..341.2.
	defb 000h,082h,031h,08ch,000h,082h,041h,083h,000h,00eh,042h,000h,041h,044h,043h,000h	; b511  ..1...A...B.ADC.
	defb 04dh,000h,000h,031h,035h,036h,04dh,04dh,08eh,000h,012h,04eh,04eh,046h,045h,041h	; b521  M..156MM...NNFEA
	defb 000h,000h,04eh,000h,000h,032h,000h,04dh,000h,000h,037h,032h,032h,08eh,000h,012h	; b531  ..N..2.M..722...
	defb 042h,042h,047h,000h,000h,04eh,000h,042h,000h,000h,031h,000h,032h,000h,000h,000h	; b541  BBG..N.B..1.2...
	defb 031h,031h,08eh,000h,011h,041h,041h,000h,000h,000h,042h,000h,041h,000h,04dh,038h	; b551  11...AA...B.A.M8
	defb 000h,031h,000h,038h,04dh,04dh,090h,000h,010h,04eh,04eh,048h,000h,041h,000h,048h	; b561  .1.8MM...NNH.A.H
	defb 04eh,02dh,03dh,02dh,03dh,02eh,02fh,032h,032h,090h,000h,008h,042h,042h,03fh,03eh	; b571  N-=-=./22...BB?>
	defb 02dh,03dh,02dh,03dh,000h	; b581

; ----------------------------------------------------------------------
; DATOS rachas_f_B586: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); se solapan 2 bloques: (rachas_ram_B586 B586-B5EC); lo leen
;   p10:A569, p10:BFB8 (102 bytes)
;   0xb586..0xb5ec  (102 bytes)
DATA_rachas_f_B586:
	defb 007h,000h,086h,075h,074h,000h,000h,08fh,090h,00fh,000h,084h,076h,000h,000h,091h	; b586  ...ut.......v...
	defb 00eh,000h,088h,077h,078h,079h,07ah,095h,094h,093h,092h,00bh,000h,08ah,07bh,07ch	; b596  ...wxyz.......{|
	defb 07dh,07eh,07fh,09ah,099h,098h,097h,096h,005h,000h,094h,080h,081h,071h,082h,083h	; b5a6  }~...........q..
	defb 084h,085h,086h,087h,088h,0a3h,0a2h,0a1h,0a0h,09fh,09eh,09dh,071h,09ch,09bh,004h	; b5b6  ............q...
	defb 000h,081h,070h,003h,000h,084h,08bh,08ch,0a7h,0a6h,003h,000h,081h,070h,004h,000h	; b5c6  ..p..........p..
	defb 094h,089h,08ah,072h,073h,08eh,08dh,089h,08ah,072h,073h,08eh,08dh,0a5h,0a4h,072h	; b5d6  ...rs....rs....r
	defb 073h,08eh,08dh,0a5h,0a4h,000h	; b5e6

; ----------------------------------------------------------------------
; DATOS tabla_B5EC: dos listas de 4 fichas de 3 bytes [dy][dx][dibujo] que
;   p10:BF1E suma a las posiciones 0x7870 y 0x7890 y copia a 0xE280 y 0xE290;
;   lo leen p10:BF42 (24 bytes)
;   0xb5ec..0xb604  (24 bytes)
DATA_tabla_B5EC:
	defb 0e0h,0e0h,000h,0d8h,0f0h,004h,0f0h,0e0h,008h,0f0h,0f0h,00ch,0e0h,010h,018h,0d8h	; b5ec  ................
	defb 000h,01ch,0f0h,000h,024h,0f0h,010h,020h	; b5fc  ....$..

; ----------------------------------------------------------------------
; DATOS tabla_B604: dos listas de 2 fichas de 3 bytes (0xB604 y 0xB60A) que
;   p10:BEAC y p10:BEBC pasan a L_BF42; lo leen p10:BF42 (12 bytes)
;   0xb604..0xb610  (12 bytes)
DATA_tabla_B604:
	defb 0e0h,0e8h,010h,0f0h,0f0h,014h,0e0h,008h,028h,0f0h,000h,02ch	; b604  ........(..,

; ----------------------------------------------------------------------
; DATOS rachas_f_B610: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:BF05 (17 bytes)
;   0xb610..0xb621  (17 bytes)
DATA_rachas_f_B610:
	defb 089h,05dh,05ch,05bh,05ah,05fh,05eh,000h,000h,060h,008h,000h,083h,063h,062h,061h	; b610  .]\[Z_^..`...cba
	defb 000h	; b620

; ----------------------------------------------------------------------
; DATOS rachas_f_B621: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:BF11 (21 bytes)
;   0xb621..0xb636  (21 bytes)
DATA_rachas_f_B621:
	defb 088h,050h,051h,052h,053h,000h,000h,054h,055h,003h,000h,081h,056h,004h,000h,084h	; b621  .PQRS..TU...V...
	defb 057h,058h,059h,000h,000h	; b631

; ======================================================================
; CODIGO 0xb636..0xb7a1  (363 bytes)
; ======================================================================


logo_del_titulo:		; el logo (p10:B832 GRADIUS en Japon, p10:B7A1 NEMESIS fuera) en 0x3843, 26 columnas
	ld de,03843h		;b636   ; en 0x3843
	call imagen_del_logo		;b639   ; imagen_del_logo: HL = el logo: p10:B832 en Japon (0x002B), p10:B7A1 fuera
	ld c,01ah		;b63c   ; 26 columnas
	jp pinta_imagen		;b63e   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
imagen_del_logo:		; HL = el logo: p10:B832 en Japon (0x002B), p10:B7A1 fuera
	ld hl,0b832h		;b641
	ld a,(0002bh)		;b644   ; Japon?
	and 00fh		;b647
	jr z,L_B64E		;b649
	ld hl,0b7a1h		;b64b   ; fuera: NEMESIS
L_B64E:
	ret			;b64e
empieza_el_titulo:		; paso 1, sin sprites, el logo descomprimido en la pantalla de RAM y su aparicion por pasos
	ld a,001h		;b64f
	ld (0e1d7h),a		;b651   ; paso 1
	xor a			;b654   ; el paso 0 de la aparicion
	ld (0e496h),a		;b655   ; guarda el paso de la escena
	call 04c76h		;b658   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call sprites_a_vram_b		;b65b   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
	call imagen_del_logo		;b65e   ; imagen_del_logo: HL = el logo: p10:B832 en Japon (0x002B), p10:B7A1 fuera
	ex de,hl			;b661
	ld hl,0ed00h		;b662   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	call descomprime_a_ram		;b665   ; el logo a la pantalla de RAM
logo_por_pasos:		; los datos de la aparicion del logo (0xF000-0xF008: p10:B8E6, B8D7...)
	ld hl,0b8e6h		;b668   ; las fichas de la aparicion
	ld (0f000h),hl		;b66b   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld hl,00307h		;b66e
	ld (0f002h),hl		;b671   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld hl,00500h		;b674
	ld (0f004h),hl		;b677   ; guarda variable de paso y el byte siguiente (16 bits)
	ld hl,0b8d7h		;b67a
	ld (0f006h),hl		;b67d
	ld a,003h		;b680
	ld (0f008h),a		;b682
aparicion_por_pasos:		; el paso 0xE496: dos fundidos (p10:A73B, p10:A717) y las dos filas que tocan, de la pantalla de RAM a la VRAM
	ld hl,(0f000h)		;b685   ; la ficha del paso
	call paso_de_la_tabla		;b688   ; paso_de_la_tabla: B y HL de la ficha 0xE496 (3 bytes) de la tabla HL
	call empieza_fundido_b		;b68b   ; el segundo fundido
	ld a,(0e496h)		;b68e   ; la fila de arriba
	ld c,a			;b691
	ld hl,0f002h		;b692   ; apunta a variable de paso: el puntero del mapa
	add a,(hl)			;b695
	call por_32		;b696   ; por_32: HL = A x 32
	call vram_de_la_fila		;b699   ; vram_de_la_fila: DE = 0x3800 + HL + la columna 0xF008
	push de			;b69c
	call fila_x_ancho		;b69d   ; fila_x_ancho: HL = C x 26 (o x 16 con 0xF004)
	call ram_de_la_fila		;b6a0   ; ram_de_la_fila: DE = 0xED00 + la fila 0xF005 x ancho
	add hl,de			;b6a3
	pop de			;b6a4
	call copia_una_fila		;b6a5   ; copia_una_fila: una fila de 26 caracteres (16 con 0xF004) de DE a la VRAM HL
	ld hl,(0f006h)		;b6a8   ; la otra ficha
	call paso_de_la_tabla		;b6ab   ; paso_de_la_tabla: B y HL de la ficha 0xE496 (3 bytes) de la tabla HL
	ld a,002h		;b6ae
	ld c,a			;b6b0
	call empieza_fundido		;b6b1   ; el fundido de tipo 2
	ld a,(0e496h)		;b6b4   ; la fila de abajo
	ld c,a			;b6b7
	ld a,(0f005h)		;b6b8   ; lee variable de paso: el puntero de la ficha
	dec a			;b6bb
	sub c			;b6bc
	ld c,a			;b6bd
	ld hl,0f005h		;b6be   ; apunta a variable de paso: el puntero de la ficha
	ld a,(0f002h)		;b6c1   ; lee variable de paso: el puntero del mapa
	sub (hl)			;b6c4
	add a,c			;b6c5
	call por_32		;b6c6   ; por_32: HL = A x 32
	call vram_de_la_fila		;b6c9   ; vram_de_la_fila: DE = 0x3800 + HL + la columna 0xF008
	push de			;b6cc
	call fila_x_ancho		;b6cd   ; fila_x_ancho: HL = C x 26 (o x 16 con 0xF004)
	ld de,0ed00h		;b6d0   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	add hl,de			;b6d3
	pop de			;b6d4
copia_una_fila:		; una fila de 26 caracteres (16 con 0xF004) de DE a la VRAM HL
	ex de,hl			;b6d5
	ld b,001h		;b6d6   ; una fila
	ld c,01ah		;b6d8   ; 26 de ancho
	ld a,(0f004h)		;b6da   ; lee variable de paso
	and a			;b6dd
	jr z,L_B6E2		;b6de
	ld c,010h		;b6e0   ; o 16
L_B6E2:
	jp copia_filas		;b6e2   ; copia_filas: B filas de C caracteres de la pantalla de RAM DE a la VRAM HL (los ceros no se pintan)
fila_x_ancho:		; HL = C x 26 (o x 16 con 0xF004)
	ld a,(0f004h)		;b6e5   ; lee variable de paso
	and a			;b6e8
	ld a,c			;b6e9
	push af			;b6ea
	call z,por_26		;b6eb   ; por_26: HL = A x 26
	pop af			;b6ee
	call nz,por_16		;b6ef   ; por_16: HL = A x 16
	ret			;b6f2
vram_de_la_fila:		; DE = 0x3800 + HL + la columna 0xF008
	ld de,03800h		;b6f3
	add hl,de			;b6f6
	ld a,(0f008h)		;b6f7   ; la columna
	ld e,a			;b6fa
	ld d,000h		;b6fb
	add hl,de			;b6fd
	ex de,hl			;b6fe
	ret			;b6ff
paso_de_la_tabla:		; B y HL de la ficha 0xE496 (3 bytes) de la tabla HL
	ld a,(0e496h)		;b700   ; lee el paso de la escena
	ld c,a			;b703
	add a,a			;b704   ; 3 bytes por paso
	add a,c			;b705
	call 0407ah		;b706   ; hl_mas_a: HL = HL + A
	ld b,(hl)			;b709   ; B
	inc hl			;b70a
	ld e,(hl)			;b70b   ; HL
	inc hl			;b70c
	ld d,(hl)			;b70d
	ex de,hl			;b70e
	ret			;b70f
ram_de_la_fila:		; DE = 0xED00 + la fila 0xF005 x ancho
	push hl			;b710
	ld a,(0f004h)		;b711   ; lee variable de paso
	and a			;b714
	ld a,(0f005h)		;b715   ; lee variable de paso: el puntero de la ficha
	push af			;b718
	call z,por_26		;b719   ; por_26: HL = A x 26
	pop af			;b71c
	call nz,por_16		;b71d   ; por_16: HL = A x 16
	ld de,0ed00h		;b720   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	add hl,de			;b723
	ex de,hl			;b724
	pop hl			;b725
	ret			;b726
por_26:		; HL = A x 26
	ld h,000h		;b727
	ld l,a			;b729
	add hl,hl			;b72a   ; x 2
	ld c,l			;b72b
	ld b,h			;b72c
	add hl,hl			;b72d
	add hl,hl			;b72e   ; x 8
	push hl			;b72f
	add hl,bc			;b730   ; x 10
	ld c,l			;b731
	ld b,h			;b732
	pop hl			;b733
	add hl,hl			;b734
	add hl,bc			;b735   ; x 16 + x 10 = x 26
	ret			;b736
titulo_aparece:		; los fundidos del logo paso a paso (5); luego el de los textos y los textos del titulo; al acabar, 0xE1D7 = 0
	ld a,(0e1d7h)		;b737   ; sin secuencia, nada
	and a			;b73a
	ret z			;b73b
	dec a			;b73c
	jr nz,L_B76F		;b73d   ; paso 2
	call paso_de_fundido		;b73f   ; los fundidos
	call paso_de_fundido_b		;b742   ; paso_de_fundido_b: un paso del segundo fundido (0xE498), fila 0xE499
	ld a,(0e490h)		;b745   ; los dos acabados?
	ld hl,0e498h		;b748   ; apunta a el segundo fundido en marcha
	or (hl)			;b74b
	ret nz			;b74c
	ld a,(0e496h)		;b74d   ; lee el paso de la escena
	inc a			;b750   ; 5 pasos
	cp 005h		;b751
	jr z,L_B75B		;b753
	ld (0e496h),a		;b755   ; guarda el paso de la escena
	jp logo_por_pasos		;b758   ; logo_por_pasos: los datos de la aparicion del logo (0xF000-0xF008: p10:B8E6, B8D7...)
L_B75B:
	ld a,001h		;b75b   ; el fundido de los textos
	ld c,003h		;b75d
	ld b,02ch		;b75f
	ld hl,00080h		;b761
	call empieza_fundido		;b764   ; empieza_fundido: un fundido de tipo A (0 borra, 1 y 3 aparece, 2 desaparece) de B caracteres desde HL en C tercios (0xE490-0xE4A0)
	call 061c1h		;b767   ; los textos
	ld hl,0e1d7h		;b76a   ; paso 2
	inc (hl)			;b76d
	ret			;b76e
L_B76F:
	call paso_de_fundido		;b76f   ; hasta que acabe el fundido
	ld a,(0e490h)		;b772   ; lee el fundido en marcha
	and a			;b775
	ret nz			;b776
	xor a			;b777   ; acabado
	ld (0e1d7h),a		;b778   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	ret			;b77b
titulo_cada_cuadro:		; sin sprites, los dos sprites de p10:B8FC y, cada 4 cuadros, una de las dos imagenes del logo (brillo)
	call 04c76h		;b77c   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call sprites_a_vram_b		;b77f   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
	ld hl,0b8fch		;b782   ; dos sprites
	ld de,03b00h		;b785
	ld bc,00008h		;b788
	call 0005ch		;b78b   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,(0e1c3h)		;b78e   ; cada 4 cuadros
	bit 2,a		;b791
	jp z,logo_del_titulo		;b793   ; logo_del_titulo: el logo (p10:B832 GRADIUS en Japon, p10:B7A1 NEMESIS fuera) en 0x3843, 26 columnas
	ld de,038ech		;b796   ; la otra imagen
	ld hl,0b8b7h		;b799
	ld c,008h		;b79c
	jp pinta_imagen		;b79e   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan

; ----------------------------------------------------------------------
; DATOS rachas_f_B7A1: rachas a la VRAM por filas (p10:A67B) que p10:B641
;   elige: 0xB832 en un MSX japones (0x002B & 0x0F = 0), 0xB7A1 en los demas;
;   lo leen p10:B63E (145 bytes)
;   0xb7a1..0xb832  (145 bytes)
DATA_rachas_f_B7A1:
	defb 080h,004h,040h,006h,000h,080h,006h,044h,006h,000h,084h,04dh,04ch,04bh,04ah,080h	; b7a1  ..@....D...MLKJ.
	defb 004h,04eh,006h,052h,080h,003h,053h,083h,05dh,05ch,05bh,006h,05ah,084h,059h,058h	; b7b1  .N.R..S.]\[.Z.YX
	defb 057h,056h,081h,000h,080h,007h,05eh,081h,068h,080h,004h,065h,081h,065h,080h,003h	; b7c1  WV....^.h..e.e..
	defb 06ah,084h,069h,063h,063h,071h,080h,004h,06dh,003h,000h,080h,011h,072h,085h,087h	; b7d1  j.iccq..m....r..
	defb 086h,085h,084h,083h,005h,000h,080h,007h,088h,081h,091h,083h,08fh,090h,08eh,080h	; b7e1  ................
	defb 004h,092h,085h,09ah,099h,098h,097h,096h,008h,000h,081h,09bh,003h,09ch,081h,09dh	; b7f1  ................
	defb 003h,09eh,080h,004h,09fh,003h,0a4h,081h,0a3h,00eh,000h,081h,0a5h,003h,0a6h,080h	; b801  ................
	defb 004h,0a7h,012h,000h,083h,0abh,0adh,0ach,003h,0aeh,082h,0afh,0b0h,012h,000h,080h	; b811  ................
	defb 003h,0b1h,004h,0b5h,081h,0b4h,012h,000h,081h,0bah,006h,0b6h,081h,0b9h,009h,000h	; b821  ................
	defb 000h	; b831

; ----------------------------------------------------------------------
; DATOS rachas_f_B832: rachas a la VRAM por filas (p10:A67B) que p10:B641
;   elige: 0xB832 en un MSX japones (0x002B & 0x0F = 0), 0xB7A1 en los demas;
;   lo leen p10:B63E (133 bytes)
;   0xb832..0xb8b7  (133 bytes)
DATA_rachas_f_B832:
	defb 080h,004h,040h,006h,000h,080h,006h,044h,006h,000h,084h,04dh,04ch,04bh,04ah,080h	; b832  ..@....D...MLKJ.
	defb 004h,04eh,006h,052h,080h,003h,053h,083h,05dh,05ch,05bh,006h,05ah,085h,059h,058h	; b842  .N.R..S.]\[.Z.YX
	defb 057h,056h,000h,080h,007h,05eh,081h,063h,080h,008h,065h,084h,067h,063h,063h,071h	; b852  WV...^.c..e.gccq
	defb 080h,004h,06dh,003h,000h,080h,011h,072h,085h,087h,086h,085h,084h,083h,005h,000h	; b862  ..m....r........
	defb 080h,007h,088h,080h,008h,08eh,085h,09ah,099h,098h,097h,096h,008h,000h,081h,09bh	; b872  ................
	defb 003h,09ch,081h,09dh,003h,09eh,080h,004h,09fh,003h,0a4h,081h,0a3h,00eh,000h,081h	; b882  ................
	defb 0a5h,003h,0a6h,080h,004h,0a7h,012h,000h,083h,0abh,0adh,0ach,003h,0aeh,082h,0afh	; b892  ................
	defb 0b0h,012h,000h,080h,003h,0b1h,004h,0b5h,081h,0b4h,012h,000h,081h,0bah,006h,0b6h	; b8a2  ................
	defb 081h,0b9h,009h,000h,000h	; b8b2

; ----------------------------------------------------------------------
; DATOS rachas_f_B8B7: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:B79E (32 bytes)
;   0xb8b7..0xb8d7  (32 bytes)
DATA_rachas_f_B8B7:
	defb 081h,0d2h,003h,0d3h,080h,004h,0d4h,081h,0bbh,003h,0bch,080h,005h,0bdh,082h,0cdh	; b8b7  ................
	defb 0c2h,003h,0c4h,080h,005h,0c5h,004h,0ceh,082h,0cah,0cbh,006h,0cch,081h,0cfh,000h	; b8c7  ................

; ----------------------------------------------------------------------
; DATOS tabla_B8D7: fichas de 3 bytes por paso (0xE496 x 3),
;   [cuantos][puntero], que p10:B668 deja en 0xF006 (0xB8D7) y 0xF000 (0xB8E6)
;   para L_B700; lo leen p10:B700 (30 bytes)
;   0xb8d7..0xb8f5  (30 bytes)
DATA_tabla_B8D7:
	defb 013h,040h,004h,016h,090h,003h,014h,0f0h,002h,010h,070h,002h,00eh,000h,002h,00ah	; b8d7  .@........p.....
	defb 0d8h,004h,006h,028h,005h,006h,058h,005h,005h,088h,005h,008h,0b0h,005h	; b8e7  ...(..X.......

; ----------------------------------------------------------------------
; DATOS tabla_B8F5: la lista que p01:61B9 pasa a p10:A24C (DE = 0xB8F5): bytes
;   hasta un 0; lo leen p10:A256 (15 bytes)
;   0xb8f5..0xb904  (15 bytes)
DATA_tabla_B8F5:
	defb 0b5h,0bah,0b8h,0b5h,0b7h,0adh,000h,02fh,057h,000h,004h,02fh,091h,004h,004h	; b8f5  ......./W../...

; ----------------------------------------------------------------------
; DATOS lista_B904: lista a la VRAM (p00:4A6B) del titulo: KONAMI 1987, PLAY
;   SELECT y 1PLAYER; p01:61C1 la pinta con 0xE1C0 < 2, y detras la de 0xB92B;
;   lo leen p01:61E7 (39 bytes)
;   0xb904..0xb92b  (39 bytes)
DATA_lista_B904:
	defb 00ah,038h,01ah,02bh,02fh,02eh,021h,02dh,029h,000h,011h,019h,018h,017h,0feh,0cbh	; b904  .8.+/.!-).......
	defb 039h,030h,02ch,021h,039h,000h,033h,025h,02ch,025h,023h,034h,0feh,02dh,03ah,011h	; b914  90,!9.3%,%#4.-:.
	defb 030h,02ch,021h,039h,025h,032h,0ffh	; b924

; ----------------------------------------------------------------------
; DATOS lista_2players: lista a la VRAM con el texto 2PLAYERS en 0x3A6D: nadie
;   la apunta, la pinta p01:61E4 con el DE que deja la de 0xB904 al acabar
;   (p01:61E7 la pinta y salta a 61E4 sin cargar DE); lo leen p01:61E4 (11
;   bytes)
;   0xb92b..0xb936  (11 bytes)
DATA_lista_2players:
	defb 06dh,03ah,012h,030h,02ch,021h,039h,025h,032h,033h,0ffh	; b92b  m:.0,!9%23.

; ----------------------------------------------------------------------
; DATOS lista_B936: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p01:61CE (25 bytes)
;   0xb936..0xb94f  (25 bytes)
DATA_lista_B936:
	defb 008h,038h,02bh,02fh,02eh,021h,02dh,029h,000h,000h,030h,032h,025h,033h,025h,02eh	; b936  .8+/.!-)..02%3%.
	defb 034h,033h,0feh,003h,03ah,034h,028h,025h,0ffh	; b946  43..:4(%.

; ----------------------------------------------------------------------
; DATOS lista_B94F: lista a la VRAM (p00:4A6B) que p01:61DE pinta en un MSX
;   japones (0x002B & 0x0F = 0); en los demas, la de 0x622D; lo leen p01:61DE
;   (10 bytes)
;   0xb94f..0xb959  (10 bytes)
DATA_lista_B94F:
	defb 007h,03ah,027h,032h,021h,024h,029h,035h,033h,0ffh	; b94f  .:'2!$)53.

; ----------------------------------------------------------------------
; DATOS lista_B959: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p01:61E4 (58 bytes)
;   0xb959..0xb993  (58 bytes)
DATA_lista_B959:
	defb 00fh,03ah,033h,021h,027h,021h,000h,023h,02fh,02eh,034h,029h,02eh,035h,025h,033h	; b959  .:3!'!.#/.4).5%3
	defb 0feh,04eh,03ah,037h,029h,034h,028h,0feh,08ah,03ah,034h,028h,025h,000h,035h,02ch	; b969  .N:7)4(..:4(%.5,
	defb 034h,029h,02dh,021h,034h,025h,0feh,0c8h,03ah,023h,02fh,033h,02dh,029h,023h,000h	; b979  4)-!4%..:#/3-)#.
	defb 021h,024h,036h,025h,02eh,034h,035h,032h,025h,0ffh	; b989  !$6%.452%.

; ======================================================================
; CODIGO 0xb993..0xb99a  (7 bytes)
; ======================================================================


final:		; el final del juego, paso 0xE1E6 (14, p10:B99A): textos, la nave y los creditos
	ld a,(0e1e6h)		;b993   ; el paso del final
	dec a			;b996
	call 04084h		;b997   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B99A: 14 destinos del despachador p00:4084 (call en p10:B997, el
;   indice en A): BB7B, BA9C, B9B6, B9F0, BA05, BA3F, BB3C, BA70, BACD, BAF2,
;   BB35, BB3F, BB4B, BB6F; lo leen p10:B997 (28 bytes)
;   0xb99a..0xb9b6  (28 bytes)
DATA_tabla_B99A:
	defw 0bb7bh,0ba9ch,0b9b6h,0b9f0h,0ba05h,0ba3fh,0bb3ch,0ba70h	; b99a
	defw 0bacdh,0baf2h,0bb35h,0bb3fh,0bb4bh,0bb6fh	; b9aa

; ======================================================================
; CODIGO 0xb9b6..0xbc23  (621 bytes)
; ======================================================================


final_textos_1:		; cada 300 cuadros el texto siguiente de p14:9222; con el quinto, 60 cuadros y al paso siguiente
	call espera_del_final		;b9b6   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	ret nz			;b9b9
	ld hl,0012ch		;b9ba   ; 300 cuadros
	ld (0e49eh),hl		;b9bd   ; guarda la espera del paso del final (16 bits)
	ld hl,09222h		;b9c0   ; los textos de p14:9222
	call texto_siguiente		;b9c3   ; texto_siguiente: el texto 0xE496 de la lista HL; sin el (0), un cuadro y borra las filas de abajo
	ld hl,0003ch		;b9c6   ; con el quinto, 60 cuadros
	cp 005h		;b9c9
	jp z,final_siguiente		;b9cb   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
	ret			;b9ce
texto_siguiente:		; el texto 0xE496 de la lista HL; sin el (0), un cuadro y borra las filas de abajo
	ld a,(0e496h)		;b9cf   ; el texto del paso
	call 04b67h		;b9d2   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(de)			;b9d5
	and a			;b9d6   ; 0: no hay
	jp z,L_B9E5		;b9d7
	call 04a6bh		;b9da   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
L_B9DD:
	ld a,(0e496h)		;b9dd   ; el siguiente
	inc a			;b9e0
	ld (0e496h),a		;b9e1   ; guarda el paso de la escena
	ret			;b9e4
L_B9E5:
	ld hl,00001h		;b9e5   ; un cuadro
	ld (0e49eh),hl		;b9e8   ; guarda la espera del paso del final (16 bits)
	call borra_filas_16_23		;b9eb   ; borra_filas_16_23: borra 256 nombres desde 0x3A00 (las filas 16-23)
	jr L_B9DD		;b9ee
final_aviso:		; suena 0x28 y el aviso (p14:94C4) parpadeando
	call espera_del_final		;b9f0   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	ret nz			;b9f3
aviso_parpadea:		; suena 0x28, borra las filas de abajo y el aviso
	ld a,028h		;b9f4   ; suena 0x28
	call 04ae4h		;b9f6   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call borra_filas_16_23		;b9f9   ; borra_filas_16_23: borra 256 nombres desde 0x3A00 (las filas 16-23)
	ld de,094c4h		;b9fc   ; el aviso
	call 04a6bh		;b9ff   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp final_siguiente_texto		;ba02   ; final_siguiente_texto: 0xE496 = 0 y un cuadro de espera
final_textos_2:		; el aviso parpadea y cada 300 cuadros (120 el quinto) el texto siguiente de p14:9281; al septimo, la escena de p14:9317
	call aviso_cada_8		;ba05   ; aviso_cada_8: el aviso p14:94C4 cada 8 cuadros si, 8 no
	call espera_del_final		;ba08   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	ret nz			;ba0b
	ld hl,0012ch		;ba0c   ; 300 cuadros
	ld a,(0e496h)		;ba0f   ; lee el paso de la escena
	cp 005h		;ba12
	jr nz,L_BA19		;ba14   ; 120 con el quinto
	ld hl,00078h		;ba16
L_BA19:
	ld (0e49eh),hl		;ba19   ; guarda la espera del paso del final (16 bits)
	ld hl,09281h		;ba1c   ; los textos de p14:9281
	call texto_siguiente		;ba1f   ; texto_siguiente: el texto 0xE496 de la lista HL; sin el (0), un cuadro y borra las filas de abajo
	cp 007h		;ba22   ; al septimo
	ret nz			;ba24
	call 04a10h		;ba25   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 05e9ah		;ba28   ; la nave
	call funde_texto		;ba2b   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld de,09317h		;ba2e   ; p14:9317
	call 04a6bh		;ba31   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld a,00eh		;ba34   ; paso 14 de las luces
	ld (0e496h),a		;ba36   ; guarda el paso de la escena
	ld hl,006cch		;ba39   ; 1740 cuadros
	jp final_siguiente		;ba3c   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
final_luces:		; las luces de la nave; al acabar, el texto p14:9361
	call espera_del_final		;ba3f   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	jr z,L_BA5E		;ba42
	call paso_de_fundido		;ba44   ; el fundido
	call tres_luces		;ba47   ; las luces
	ld a,(0e1c3h)		;ba4a   ; cada 8 cuadros
	and 007h		;ba4d
	ret nz			;ba4f
	call luz_del_paso		;ba50   ; luz_del_paso: el caracter del paso 0xE496 (p10:B0E1: [caracter][columna][fila]) en la tabla de nombres
	ld a,(0e496h)		;ba53   ; hasta 30
	inc a			;ba56
	cp 01eh		;ba57
	ret z			;ba59
	ld (0e496h),a		;ba5a   ; guarda el paso de la escena
	ret			;ba5d
L_BA5E:
	call borra_filas_16_23		;ba5e   ; borra las filas de abajo
	call funde_texto		;ba61   ; funde_texto: el fundido de tipo 3 de 0xFE caracteres desde 0x1008 (el tercio del texto)
	ld de,09361h		;ba64   ; p14:9361
	call 04a6bh		;ba67   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld hl,00690h		;ba6a   ; 1680 cuadros
	jp final_siguiente		;ba6d   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
final_luces_encendidas:		; las luces encendidas y, al acabar el fundido, pantalla en blanco
	call paso_de_fundido		;ba70   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	call luces_encendidas		;ba73   ; luces_encendidas: las tres luces encendidas
	ld a,(0e490h)		;ba76   ; lee el fundido en marcha
	and a			;ba79
	ret nz			;ba7a
	jp L_BAB0		;ba7b
aviso_cada_8:		; el aviso p14:94C4 cada 8 cuadros si, 8 no
	ld de,094c4h		;ba7e
	ld hl,0e49eh		;ba81   ; cada 8 cuadros
	bit 3,(hl)		;ba84
	jp z,04a6bh		;ba86   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp 04a82h		;ba89   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
vuelve_ya:		; DR.VENOM IS FAST APPROACHING NEMESIS, RETURN IMMEDIATELY! (p14:94D1) parpadeando
	ld de,094d1h		;ba8c
	ld a,(0e1c3h)		;ba8f   ; 100 de cada 128 cuadros
	and 07fh		;ba92
	cp 064h		;ba94
	jp c,04a6bh		;ba96   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp 04a82h		;ba99   ; borra_texto: lo mismo que escribe_texto pero con ceros: borra los textos de la lista DE
final_vuelve:		; mientras suena la musica, los avisos; al acabar, al paso 8
	ld a,(0e0a0h)		;ba9c   ; mientras suene la musica
	and a			;ba9f
	jr z,L_BAAB		;baa0
	ld hl,0e49eh		;baa2   ; apunta a la espera del paso del final (16 bits)
	dec (hl)			;baa5
	call aviso_cada_8		;baa6   ; aviso_cada_8: el aviso p14:94C4 cada 8 cuadros si, 8 no
	jr vuelve_ya		;baa9
L_BAAB:
	ld a,008h		;baab   ; al paso 8
	ld (0e1e6h),a		;baad   ; guarda la marca del final (estado 10)
L_BAB0:
	call 04a10h		;bab0   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	jp final_siguiente		;bab3   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
naves_al_centro:		; la nave y sus dos opciones en Y 0x48, X 0x30
	ld a,048h		;bab6   ; Y 0x48
	ld (0e404h),a		;bab8   ; guarda la Y de la nave
	ld (0e414h),a		;babb   ; guarda la Y de la primera opcion
	ld (0e424h),a		;babe   ; guarda la Y de la segunda opcion
	ld a,030h		;bac1   ; X 0x30
	ld (0e406h),a		;bac3   ; guarda la X de la nave
	ld (0e416h),a		;bac6
	ld (0e426h),a		;bac9
	ret			;bacc
final_a_jugar:		; pantalla en blanco y p10:BAD0
	call 04a10h		;bacd   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
vuelve_a_jugar:		; las naves al centro, el rastro, 0xE500-0xEFFF a cero, sin sprites y 0xE1E6 = 0
	call naves_al_centro		;bad0   ; naves_al_centro: la nave y sus dos opciones en Y 0x48, X 0x30
	call 05d80h		;bad3   ; el rastro
	call borra_e500		;bad6   ; la RAM de enemigos
	call 04c76h		;bad9   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call sprites_a_vram_b		;badc   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
	xor a			;badf   ; sin final
	ld (0e1e6h),a		;bae0   ; guarda la marca del final (estado 10)
	ret			;bae3
borra_e500:		; 0xE500-0xEFFF a cero
	ld hl,0e500h		;bae4   ; 0xE500-0xEFFF
	ld de,0e501h		;bae7
	ld bc,00affh		;baea
	ld (hl),000h		;baed
	ldir		;baef
	ret			;baf1
final_textos_3:		; cada 480 cuadros el texto siguiente de p14:93B4 con su imagen; al septimo, 540 cuadros
	call espera_del_final		;baf2   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	ret nz			;baf5
	ld hl,001e0h		;baf6   ; 480 cuadros
	ld (0e49eh),hl		;baf9   ; guarda la espera del paso del final (16 bits)
	call imagen_del_texto		;bafc   ; la imagen
	ld hl,093b4h		;baff   ; los textos de p14:93B4
	call texto_siguiente		;bb02   ; texto_siguiente: el texto 0xE496 de la lista HL; sin el (0), un cuadro y borra las filas de abajo
	ld hl,0021ch		;bb05   ; al septimo, 540 cuadros
	cp 007h		;bb08
	jp z,final_siguiente		;bb0a   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
	ret			;bb0d
imagen_del_texto:		; con los textos 2 y 5 la imagen de p10:BBE0; con 4 y 6 la de p10:BC02
	ld a,(0e496h)		;bb0e   ; lee el paso de la escena
	exx			;bb11
	ld e,a			;bb12
	exx			;bb13
	cp 002h		;bb14   ; el 2: imagen 1
	jp z,imagen_del_final_1		;bb16   ; imagen_del_final_1: pantalla en blanco, caracteres (p12:A000) y la imagen p14:91A8 en 0x38A7
	call paso_en_e		;bb19   ; paso_en_e: A = el paso guardado en E'
	cp 004h		;bb1c   ; el 4: imagen 2
	jp z,imagen_del_final_2		;bb1e   ; imagen_del_final_2: pantalla en blanco, caracteres (p09:A143) y la imagen p10:B06F en 0x38E8
	call paso_en_e		;bb21   ; paso_en_e: A = el paso guardado en E'
	cp 005h		;bb24   ; el 5: imagen 1
	jp z,imagen_del_final_1		;bb26   ; imagen_del_final_1: pantalla en blanco, caracteres (p12:A000) y la imagen p14:91A8 en 0x38A7
	call paso_en_e		;bb29   ; paso_en_e: A = el paso guardado en E'
	cp 006h		;bb2c   ; el 6: imagen 2
	jp z,imagen_del_final_2		;bb2e   ; imagen_del_final_2: pantalla en blanco, caracteres (p09:A143) y la imagen p10:B06F en 0x38E8
paso_en_e:		; A = el paso guardado en E'
	exx			;bb31
	ld a,e			;bb32
	exx			;bb33
	ret			;bb34
final_creditos:		; al acabar la espera, la escena del piloto con su texto
	call espera_del_final		;bb35   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	ret nz			;bb38
	jp L_BBBD		;bb39
final_luces_b:		; las luces y luego el fundido
	call tres_luces		;bb3c   ; tres_luces: las tres luces de la nave segun la cuenta de cuadros
final_fundido:		; al acabar la espera, el fundido y al paso siguiente
	call espera_del_final		;bb3f   ; espera_del_final: 0xE49E - 1 (Z al acabar)
	jp nz,paso_de_fundido		;bb42   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	call funde_tres_tercios		;bb45   ; el fundido
	jp final_siguiente		;bb48   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
final_paz:		; pantalla en blanco y el texto final (p10:BC85 en Japon, p10:BD1A fuera: COSMIC YEAR... NEMESIS IS COMPLETELY RESTORED)
	call paso_de_fundido		;bb4b   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	ld a,(0e490h)		;bb4e   ; lee el fundido en marcha
	and a			;bb51
	ret nz			;bb52
	call 04a10h		;bb53   ; pantalla en blanco
	call 05e0ch		;bb56   ; caracteres_5e5f: p00:5E64, p00:5E20 y p00:5D97
	call funde_tres		;bb59   ; el fundido
	ld a,(0002bh)		;bb5c   ; Japon?
	and 00fh		;bb5f
	ld de,0bc85h		;bb61
	jr z,L_BB69		;bb64
	ld de,0bd1ah		;bb66   ; fuera: COSMIC YEAR ... NEMESIS IS COMPLETELY RESTORED
L_BB69:
	call 04a6bh		;bb69   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	jp final_siguiente		;bb6c   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
final_espera:		; hasta el cuadro 0x1518; luego a jugar otra vez
	ld de,01518h		;bb6f   ; el cuadro 0x1518
	call 05d89h		;bb72   ; cuadros_desde: C si la cuenta de interrupciones 0xF0F7 no llega a DE
	jp c,paso_de_fundido		;bb75   ; paso_de_fundido: un paso del fundido en marcha (0xE490): su tipo (p10:A7AD)
	jp vuelve_a_jugar		;bb78   ; a jugar
final_empieza:		; la cuenta de cuadros a cero; con 0xE1D6 el final de verdad (p10:BBAC); si no, suena 0x40 y el aviso
	ld hl,00000h		;bb7b   ; desde el cuadro 0
	ld (0f0f7h),hl		;bb7e   ; guarda la cuenta de interrupciones (16 bits)
	call 04a10h		;bb81   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	ld a,(0e1d6h)		;bb84   ; el final de verdad?
	or a			;bb87
	jr nz,final_de_verdad		;bb88
	ld a,040h		;bb8a   ; si no, suena 0x40
	call 04ae4h		;bb8c   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call imagen_del_final_1		;bb8f   ; la imagen
	ld a,(0002bh)		;bb92
	and 00fh		;bb95
	jp nz,aviso_parpadea		;bb97   ; fuera de Japon, el aviso
	call final_siguiente		;bb9a   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
final_siguiente_texto:		; 0xE496 = 0 y un cuadro de espera
	xor a			;bb9d   ; el primer texto
	ld (0e496h),a		;bb9e   ; guarda el paso de la escena
	ld hl,00001h		;bba1
final_siguiente:		; la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
	ld (0e49eh),hl		;bba4   ; la espera
	ld hl,0e1e6h		;bba7   ; el paso siguiente
	inc (hl)			;bbaa
	ret			;bbab
final_de_verdad:		; suena 0x41; fuera de Japon (paso 11) el piloto y OPERATIONS TO ERADICATE VENOM WERE ACHIEVED BY METALION...; en Japon (paso 9) la imagen
	ld a,041h		;bbac   ; suena 0x41
	call 04ae4h		;bbae   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,(0002bh)		;bbb1   ; Japon?
	and 00fh		;bbb4
	jr z,L_BBD6		;bbb6
	ld a,00bh		;bbb8   ; fuera: paso 11
	ld (0e1e6h),a		;bbba   ; guarda la marca del final (estado 10)
L_BBBD:
	call escena_piloto_b		;bbbd   ; el piloto
	ld a,(0002bh)		;bbc0
	and 00fh		;bbc3
	ld de,0950fh		;bbc5   ; el texto japones
	jr z,L_BBCD		;bbc8
	ld de,0bc23h		;bbca   ; o OPERATIONS TO ERADICATE VENOM WERE ACHIEVED BY METALION...
L_BBCD:
	call 04a6bh		;bbcd   ; escribe_texto: escribe a la VRAM la lista de textos de DE: [direccion][caracteres] con 0xFE = otra direccion y 0xFF = fin
	ld hl,00438h		;bbd0   ; 1080 cuadros
	jp final_siguiente		;bbd3   ; final_siguiente: la espera HL (0xE49E) y el paso siguiente (0xE1E6 + 1)
L_BBD6:
	ld a,009h		;bbd6   ; en Japon: paso 9
	ld (0e1e6h),a		;bbd8   ; guarda la marca del final (estado 10)
	call imagen_del_final_2		;bbdb   ; imagen_del_final_2: pantalla en blanco, caracteres (p09:A143) y la imagen p10:B06F en 0x38E8
	jr final_siguiente_texto		;bbde
imagen_del_final_1:		; pantalla en blanco, caracteres (p12:A000) y la imagen p14:91A8 en 0x38A7
	call 04a10h		;bbe0   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 04c76h		;bbe3   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call 05e0ch		;bbe6   ; los caracteres
	call 05dcdh		;bbe9   ; caracteres_a000: copia caracteres de un tercio a los otros dos y la lista p12:A000 (copias p12:A00D)
	ld a,080h		;bbec   ; colores 0x80
	ld hl,00d00h		;bbee
	ld bc,00158h		;bbf1
	call 00056h		;bbf4   ; BIOS FILVRM - Fills VRAM with value
	ld de,038a7h		;bbf7   ; la imagen en 0x38A7
	ld hl,091a8h		;bbfa
	ld c,012h		;bbfd
	jp pinta_imagen		;bbff   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
imagen_del_final_2:		; pantalla en blanco, caracteres (p09:A143) y la imagen p10:B06F en 0x38E8
	call 04a10h		;bc02   ; borra_nombres: borra la tabla de nombres entera (0x3800, 768 bytes) tras p00:5AFA
	call 04c76h		;bc05   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	call 05e0ch		;bc08   ; caracteres_5e5f: p00:5E64, p00:5E20 y p00:5D97
	call 05edch		;bc0b   ; caracteres_a143_y_borra: p00:5EE1 y p00:5D97
	ld de,038e8h		;bc0e   ; la imagen en 0x38E8
	ld hl,0b06fh		;bc11
	ld c,010h		;bc14
	jp pinta_imagen		;bc16   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
espera_del_final:		; 0xE49E - 1 (Z al acabar)
	ld hl,(0e49eh)		;bc19   ; la espera
	dec hl			;bc1c
	ld (0e49eh),hl		;bc1d   ; guarda la espera del paso del final (16 bits)
	ld a,l			;bc20
	or h			;bc21
	ret			;bc22

; ----------------------------------------------------------------------
; DATOS lista_BC23: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:BBCD (98 bytes)
;   0xbc23..0xbc85  (98 bytes)
DATA_lista_BC23:
	defb 004h,03ah,015h,016h,00bh,018h,007h,01ah,00fh,015h,014h,019h,000h,01ah,015h,000h	; bc23  .:..............
	defb 00bh,018h,007h,00ah,00fh,009h,007h,01ah,00bh,0feh,044h,03ah,01ch,00bh,014h,015h	; bc33  ..........D:....
	defb 013h,000h,01dh,00bh,018h,00bh,000h,007h,009h,00eh,00fh,00bh,01ch,00bh,00ah,000h	; bc43  ................
	defb 008h,01fh,0feh,084h,03ah,013h,00bh,01ah,007h,012h,00fh,015h,014h,022h,000h,016h	; bc53  ....:........"..
	defb 00bh,007h,009h,00bh,000h,018h,00bh,01ah,01bh,018h,014h,00bh,00ah,0feh,0c4h,03ah	; bc63  ...............:
	defb 01ah,015h,000h,014h,00bh,013h,00bh,019h,00fh,019h,000h,007h,00dh,007h,00fh,014h	; bc73  ................
	defb 021h,0ffh	; bc83

; ----------------------------------------------------------------------
; DATOS lista_BC85: lista a la VRAM (p00:4A6B) que p10:BB69 pinta en un MSX
;   japones (0x002B & 0x0F = 0); en los demas, la de 0xBD1A; lo leen p10:BB69
;   (149 bytes)
;   0xbc85..0xbd1a  (149 bytes)
DATA_lista_BC85:
	defb 023h,038h,04dh,04eh,04fh,000h,003h,003h,003h,004h,050h,000h,0d4h,0f5h,0e1h,0f7h	; bc85  #8MNO.....P.....
	defb 0f3h,039h,0e0h,093h,0edh,0eah,0a4h,0fbh,051h,052h,0dch,0d2h,0dfh,0feh,06dh,038h	; bc95  .9......QR....m8
	defb 0edh,0c0h,0cbh,0afh,0b1h,000h,09eh,064h,05ah,051h,039h,0efh,093h,0ddh,09eh,05ch	; bca5  .......dZQ9....\
	defb 0c0h,0feh,0adh,038h,074h,0cch,0aeh,0ach,0b3h,038h,0feh,007h,039h,003h,003h,003h	; bcb5  ...8t....8..9...
	defb 006h,050h,000h,004h,0b7h,0a8h,0ebh,0e9h,039h,0f3h,0e4h,093h,0f3h,0ech,0efh,0eah	; bcc5  .P......9.......
	defb 0edh,0a8h,0e8h,0d9h,0feh,04dh,039h,0e0h,0e8h,093h,081h,082h,038h,0a9h,0ach,0a7h	; bcd5  .....M9.....8...
	defb 0b4h,0c7h,0b1h,000h,060h,061h,0eeh,0efh,0feh,08dh,039h,0f0h,0f1h,0f2h,0f3h,0a4h	; bce5  ....`a....9.....
	defb 000h,081h,07bh,083h,084h,0a7h,0b0h,0ceh,0a2h,038h,0feh,06dh,03ah,060h,061h,0eeh	; bcf5  ..{......8.m:`a.
	defb 0efh,0f0h,0f1h,0f2h,0f3h,047h,048h,04bh,04ch,0feh,0b5h,03ah,0efh,093h,0ddh,09eh	; bd05  .....GHKL..:....
	defb 05ch,000h,000h,048h,0ffh	; bd15

; ----------------------------------------------------------------------
; DATOS lista_BD1A: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:BB69 (227 bytes)
;   0xbd1a..0xbdfd  (227 bytes)
DATA_lista_BD1A:
	defb 028h,038h,009h,015h,019h,013h,00fh,009h,000h,01fh,00bh,007h,018h,000h,003h,003h	; bd1a  (8..............
	defb 003h,004h,0feh,062h,038h,01ah,00eh,00bh,000h,00fh,013h,016h,00bh,018h,00fh,007h	; bd2a  ...b8...........
	defb 012h,000h,00eh,00fh,00dh,00eh,00bh,019h,01ah,000h,009h,015h,01bh,014h,009h,00fh	; bd3a  ................
	defb 012h,0feh,0a2h,038h,00ah,00bh,009h,00fh,00ah,00bh,00ah,000h,01ah,015h,000h,007h	; bd4a  ...8............
	defb 016h,016h,015h,00fh,014h,01ah,000h,013h,018h,021h,010h,007h,013h,00bh,019h,0feh	; bd5a  .........!......
	defb 0e3h,038h,008h,01bh,018h,01ah,015h,014h,000h,00ch,015h,018h,000h,00bh,013h,016h	; bd6a  .8..............
	defb 00bh,018h,015h,018h,000h,01ah,00eh,00bh,000h,09eh,01ah,00eh,021h,0feh,028h,039h	; bd7a  ............!.(9
	defb 018h,00bh,016h,007h,00fh,018h,000h,01dh,015h,018h,011h,019h,000h,00ch,015h,018h	; bd8a  ................
	defb 0feh,065h,039h,019h,00bh,01ch,00bh,014h,000h,016h,012h,007h,014h,00bh,01ah,019h	; bd9a  .e9.............
	defb 000h,00ch,00fh,014h,00fh,019h,00eh,00bh,00ah,021h,0feh,0a1h,039h,014h,00bh,013h	; bdaa  .........!..9...
	defb 00bh,019h,00fh,019h,000h,00fh,019h,000h,009h,015h,013h,016h,012h,00bh,01ah,00bh	; bdba  ................
	defb 012h,01fh,000h,018h,00bh,019h,01ah,015h,018h,00bh,00ah,021h,0feh,04bh,03ah,01dh	; bdca  ...........!.K:.
	defb 018h,00fh,01ah,01ah,00bh,014h,000h,008h,01fh,0feh,085h,03ah,000h,00bh,013h,016h	; bdda  ...........:....
	defb 00bh,018h,015h,018h,000h,012h,007h,018h,019h,000h,01ah,00eh,00bh,000h,09eh,01ah	; bdea  ................
	defb 00eh,000h,0ffh	; bdfa

; ======================================================================
; CODIGO 0xbdfd..0xbe04  (7 bytes)
; ======================================================================


escena_del_piloto:		; la escena del piloto al empezar la partida, paso 0xE1D7 (p10:BE04)
	ld a,(0e1d7h)		;bdfd   ; el paso
	dec a			;be00
	call 04084h		;be01   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_BE04: 5 destinos del despachador p00:4084 (call en p10:BE01, el
;   indice en A): BE0E, BE94, BED0, BF5E, BF78; lo leen p10:BE01 (10 bytes)
;   0xbe04..0xbe0e  (10 bytes)
DATA_tabla_BE04:
	defw 0be0eh,0be94h,0bed0h,0bf5eh,0bf78h	; be04

; ======================================================================
; CODIGO 0xbe0e..0xbff3  (485 bytes)
; ======================================================================


piloto_aparece:		; cada 8 cuadros una fila mas de la imagen (de abajo arriba); al acabar, 60 cuadros
	call ojos_parpadean		;be0e   ; los ojos
	ld a,(0e1c3h)		;be11   ; cada 8 cuadros
	and 007h		;be14
	ret nz			;be16
	call fondo_del_piloto		;be17   ; el fondo
	call pon_ojos		;be1a   ; pon_ojos: los caracteres de 0xE4A3 en 0x39C1 y 0x39C5, los de 0xE4A4 en 0x39DA y 0x39DE
	ld a,(0e496h)		;be1d   ; la fila de la imagen
	call fila_del_piloto		;be20   ; fila_del_piloto: la fila A de la imagen del piloto (0xE500) en la VRAM, 20 columnas
	ld a,(0e496h)		;be23   ; de abajo arriba
	dec a			;be26
	jp m,piloto_espera		;be27   ; piloto_espera: 0xE496 = 0xFF y 60 cuadros
	ld (0e496h),a		;be2a   ; guarda el paso de la escena
	ret			;be2d
fila_del_piloto:		; la fila A de la imagen del piloto (0xE500) en la VRAM, 20 columnas
	ld c,a			;be2e
	add a,009h		;be2f   ; + 9
	call por_32		;be31   ; por_32: HL = A x 32
	ld de,03800h		;be34
	add hl,de			;be37
	ld de,00006h		;be38   ; columna 6
	add hl,de			;be3b
	ld de,0e500h		;be3c   ; la imagen en 0xE500
	ld b,c			;be3f
	ld a,007h		;be40   ; 7 - la fila
	sub b			;be42
	ld b,a			;be43
	ld c,014h		;be44   ; 20 columnas
	jp copia_filas		;be46   ; copia_filas: B filas de C caracteres de la pantalla de RAM DE a la VRAM HL (los ceros no se pintan)
ojos_parpadean:		; cada 16 cuadros los dos caracteres de 0xE4A3 y 0xE4A4 cambian
	ld a,(0e1c3h)		;be49   ; cada 16 cuadros
	and 00fh		;be4c
	ret nz			;be4e
	ld de,0e4a3h		;be4f   ; apunta a el caracter de los ojos de arriba
	call alterna		;be52   ; alterna: (DE) XOR 1
	ld de,0e4a4h		;be55   ; apunta a el caracter de los ojos de abajo
	call alterna		;be58   ; alterna: (DE) XOR 1
pon_ojos:		; los caracteres de 0xE4A3 en 0x39C1 y 0x39C5, los de 0xE4A4 en 0x39DA y 0x39DE
	ld hl,039c1h		;be5b   ; los de arriba
	ld de,0e4a3h		;be5e   ; apunta a el caracter de los ojos de arriba
	call un_nombre		;be61   ; un_nombre: (DE) en la VRAM HL
	ld hl,039c5h		;be64
	ld de,0e4a3h		;be67   ; apunta a el caracter de los ojos de arriba
	call un_nombre		;be6a   ; un_nombre: (DE) en la VRAM HL
	ld hl,039dah		;be6d   ; los de abajo
	ld de,0e4a4h		;be70   ; apunta a el caracter de los ojos de abajo
	call un_nombre		;be73   ; un_nombre: (DE) en la VRAM HL
	ld hl,039deh		;be76
	ld de,0e4a4h		;be79   ; apunta a el caracter de los ojos de abajo
	jr un_nombre		;be7c
alterna:		; (DE) XOR 1
	ld a,(de)			;be7e
	xor 001h		;be7f   ; cambia
	ld (de),a			;be81
	ret			;be82
un_nombre:		; (DE) en la VRAM HL
	ld a,(de)			;be83
	ld bc,00001h		;be84   ; un nombre
	jp 00056h		;be87   ; BIOS FILVRM - Fills VRAM with value
piloto_espera:		; 0xE496 = 0xFF y 60 cuadros
	ld a,0ffh		;be8a   ; sin fila
	ld (0e496h),a		;be8c   ; guarda el paso de la escena
	ld a,03ch		;be8f   ; 60 cuadros
	jp piloto_siguiente		;be91   ; piloto_siguiente: la espera A y el paso siguiente
piloto_sprites:		; mientras dure la espera, los sprites de p10:B604/B60A cada dos cuadros
	ld hl,0e49eh		;be94   ; la espera
	dec (hl)			;be97
	jp z,piloto_siguiente		;be98   ; piloto_siguiente: la espera A y el paso siguiente
	call ojos_parpadean		;be9b   ; ojos_parpadean: cada 16 cuadros los dos caracteres de 0xE4A3 y 0xE4A4 cambian
	ld a,(0e1c3h)		;be9e   ; cada dos cuadros
	bit 1,a		;bea1
	jp nz,sin_sprites_en_vram		;bea3   ; sin_sprites_en_vram: esconde los sprites y a la VRAM
	ld bc,00207h		;bea6   ; 2 sprites, color 7
pon_dos_grupos:		; dos grupos de B sprites (de DE) en 0xE280 y 0xE288 con el color C, y a la VRAM
	ld hl,07870h		;bea9   ; en Y 0x78, X 0x70
	ld de,0b604h		;beac
	exx			;beaf
	ld hl,0e280h		;beb0   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	exx			;beb3
	push bc			;beb4
	call sprites_relativos		;beb5   ; sprites_relativos: B sprites de DE: Y + H, X + L, dibujo, color C, a HL'
	pop bc			;beb8
	ld hl,07890h		;beb9   ; en Y 0x78, X 0x90
	ld de,0b60ah		;bebc
	exx			;bebf
	ld hl,0e288h		;bec0
	exx			;bec3
	call sprites_relativos		;bec4   ; sprites_relativos: B sprites de DE: Y + H, X + L, dibujo, color C, a HL'
	jp sprites_a_vram_b		;bec7   ; a la VRAM
sin_sprites_en_vram:		; esconde los sprites y a la VRAM
	call 04c76h		;beca   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	jp sprites_a_vram_b		;becd   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
piloto_paso_3:		; cada 4 cuadros; la segunda vez, 8 sprites de color 10 y dos imagenes (p10:B610, p10:B621)
	call ojos_parpadean		;bed0   ; ojos_parpadean: cada 16 cuadros los dos caracteres de 0xE4A3 y 0xE4A4 cambian
	ld a,(0e1c3h)		;bed3   ; cada 4 cuadros
	and 003h		;bed6
	ret nz			;bed8
	ld a,(0e496h)		;bed9   ; una vez mas
	inc a			;bedc
	ld (0e496h),a		;bedd   ; guarda el paso de la escena
	and a			;bee0
	jr z,sin_sprites_en_vram		;bee1
	dec a			;bee3
	jr z,sprites_del_piloto		;bee4
	ld d,008h		;bee6   ; 8 sprites con color 10
	ld hl,03b03h		;bee8
L_BEEB:
	ld a,00ah		;beeb
	ld bc,00001h		;beed
	push hl			;bef0
	call 00056h		;bef1   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;bef4
	ld a,004h		;bef5
	add a,l			;bef7
	ld l,a			;bef8
	dec d			;bef9
	jr nz,L_BEEB		;befa
	ld de,0394ah		;befc   ; dos imagenes
	ld hl,0b610h		;beff
	ld bc,00504h		;bf02
	call pinta_imagen		;bf05   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	ld de,03952h		;bf08
	ld hl,0b621h		;bf0b
	ld bc,00504h		;bf0e
	call pinta_imagen		;bf11   ; pinta_imagen: la imagen DE (comprimida: n caracteres, 0x80 + n repetidos, 0x80 serie) en la VRAM HL, filas de C; los ceros no se pintan
	ld a,030h		;bf14   ; 48 cuadros
piloto_siguiente:		; la espera A y el paso siguiente
	ld (0e49eh),a		;bf16   ; la espera
	ld hl,0e1d7h		;bf19   ; el paso siguiente
	inc (hl)			;bf1c
	ret			;bf1d
sprites_del_piloto:		; dos grupos de 4 sprites (p10:B5EC, B5F8) con color 9
	ld bc,00409h		;bf1e   ; 4 sprites, color 9
	ld hl,07870h		;bf21
	ld de,0b5ech		;bf24
	exx			;bf27
	ld hl,0e280h		;bf28   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	exx			;bf2b
	push bc			;bf2c
	call sprites_relativos		;bf2d   ; sprites_relativos: B sprites de DE: Y + H, X + L, dibujo, color C, a HL'
	pop bc			;bf30
	ld hl,07890h		;bf31
	ld de,0b5f8h		;bf34
	exx			;bf37
	ld hl,0e290h		;bf38
	exx			;bf3b
	call sprites_relativos		;bf3c   ; sprites_relativos: B sprites de DE: Y + H, X + L, dibujo, color C, a HL'
	jp sprites_a_vram_b		;bf3f   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
sprites_relativos:		; B sprites de DE: Y + H, X + L, dibujo, color C, a HL'
	ld a,(de)			;bf42   ; Y + H
	inc de			;bf43
	add a,h			;bf44
	exx			;bf45
	ld (hl),a			;bf46
	inc hl			;bf47
	exx			;bf48
	ld a,(de)			;bf49   ; X + L
	inc de			;bf4a
	add a,l			;bf4b
	exx			;bf4c
	ld (hl),a			;bf4d
	inc hl			;bf4e
	exx			;bf4f
	ld a,(de)			;bf50   ; el dibujo
	inc de			;bf51
	exx			;bf52
	ld (hl),a			;bf53
	inc hl			;bf54
	exx			;bf55
	ld a,c			;bf56   ; el color
	exx			;bf57
	ld (hl),a			;bf58
	inc hl			;bf59
	exx			;bf5a
	djnz sprites_relativos		;bf5b
	ret			;bf5d
piloto_paso_4:		; al acabar la espera, la imagen entera, los ojos y los sprites; 15 cuadros
	call ojos_parpadean		;bf5e   ; ojos_parpadean: cada 16 cuadros los dos caracteres de 0xE4A3 y 0xE4A4 cambian
	ld hl,0e49eh		;bf61   ; la espera
	dec (hl)			;bf64
	ret nz			;bf65
	call fondo_del_piloto		;bf66   ; fondo_del_piloto: descomprime p10:B461 a la pantalla de RAM desde la fila 1 y la copia a la VRAM
	call pon_ojos		;bf69   ; pon_ojos: los caracteres de 0xE4A3 en 0x39C1 y 0x39C5, los de 0xE4A4 en 0x39DA y 0x39DE
	ld a,000h		;bf6c   ; la imagen entera
	call fila_del_piloto		;bf6e   ; fila_del_piloto: la fila A de la imagen del piloto (0xE500) en la VRAM, 20 columnas
	call sprites_del_piloto		;bf71   ; sprites_del_piloto: dos grupos de 4 sprites (p10:B5EC, B5F8) con color 9
	ld a,00fh		;bf74   ; 15 cuadros
	jr piloto_siguiente		;bf76
piloto_paso_5:		; parpadean los sprites; al acabar, pantalla en blanco y 0xE1D7 = 0
	ld hl,0e49eh		;bf78   ; la espera
	dec (hl)			;bf7b
	jp z,L_BF93		;bf7c
	call ojos_parpadean		;bf7f   ; ojos_parpadean: cada 16 cuadros los dos caracteres de 0xE4A3 y 0xE4A4 cambian
	ld a,(0e49eh)		;bf82   ; parpadean cada 8 cuadros
	bit 3,a		;bf85
	jp nz,sprites_del_piloto		;bf87   ; sprites_del_piloto: dos grupos de 4 sprites (p10:B5EC, B5F8) con color 9
	call 04c76h		;bf8a   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	ld bc,00206h		;bf8d
	jp pon_dos_grupos		;bf90   ; pon_dos_grupos: dos grupos de B sprites (de DE) en 0xE280 y 0xE288 con el color C, y a la VRAM
L_BF93:
	call 04a10h		;bf93   ; se acabo
	call borra_pantalla_ram		;bf96   ; borra_pantalla_ram: la pantalla de RAM (0xED00-0xEFFF) a cero y copia sus 2 primeras filas a 0xEFC0; luego a la VRAM
	xor a			;bf99
	ld (0e1d7h),a		;bf9a   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	ret			;bf9d
empieza_el_piloto:		; paso 1: caracteres, pantalla de RAM a cero, los ojos en 0x3848, el fondo y la imagen del piloto (p10:B586) a 0xE500
	ld a,001h		;bf9e   ; paso 1
	ld (0e1d7h),a		;bfa0   ; guarda el paso de la historia o de la secuencia en marcha (0: ninguna)
	call caracteres_del_piloto		;bfa3   ; caracteres_del_piloto: p00:5D8E y sin sprites
	call borra_pantalla_ram		;bfa6   ; borra_pantalla_ram: la pantalla de RAM (0xED00-0xEFFF) a cero y copia sus 2 primeras filas a 0xEFC0; luego a la VRAM
	ld hl,03848h		;bfa9   ; los ojos
	ld (0e4a3h),hl		;bfac   ; guarda el caracter de los ojos de arriba y el byte siguiente (16 bits)
	call fondo_del_piloto		;bfaf   ; fondo_del_piloto: descomprime p10:B461 a la pantalla de RAM desde la fila 1 y la copia a la VRAM
	ld hl,0e500h		;bfb2   ; la imagen del piloto a 0xE500
	ld de,0b586h		;bfb5
	call descomprime_a_ram		;bfb8   ; descomprime_a_ram: DE a la RAM HL: n < 0x80 n bytes, 0x80 + n un byte n veces, 0x80 n c una serie desde c, 0 acaba
	ld a,006h		;bfbb   ; desde la fila 6
	ld (0e496h),a		;bfbd   ; guarda el paso de la escena
	ret			;bfc0
caracteres_del_piloto:		; p00:5D8E y sin sprites
	call 05d8eh		;bfc1   ; caracteres_b3d0: p00:5DA0 y p01:69EF
L_BFC4:
	call 04c76h		;bfc4   ; esconde_sprites: los 32 sprites de 0xE280 con Y = 0xE0 (fuera de la pantalla)
	jp sprites_a_vram_b		;bfc7   ; sprites_a_vram_b: los 32 sprites de 0xE280 a la VRAM 0x3B00
caracteres_del_piloto_b:		; p00:5D94 y sin sprites
	call 05d94h		;bfca   ; caracteres_b3d0_y_borra: p00:5DA0 y p00:5D97
	jr L_BFC4		;bfcd
fondo_del_piloto:		; descomprime p10:B461 a la pantalla de RAM desde la fila 1 y la copia a la VRAM
	ld hl,0b461h		;bfcf   ; el fondo
	ld de,0ed20h		;bfd2   ; desde la fila 1
L_BFD5:
	ld a,(hl)			;bfd5
	inc hl			;bfd6
	and a			;bfd7   ; 0: a la VRAM
	jp z,pantalla_ram_a_vram		;bfd8   ; pantalla_ram_a_vram: los 768 nombres de 0xED00 a la tabla de nombres
	bit 7,a		;bfdb   ; bit 7: repeticion
	jr nz,L_BFE8		;bfdd
	ld b,a			;bfdf
L_BFE0:
	ld a,(hl)			;bfe0   ; n bytes
	ld (de),a			;bfe1
	inc hl			;bfe2
	inc de			;bfe3
	djnz L_BFE0		;bfe4
	jr L_BFD5		;bfe6
L_BFE8:
	and 07fh		;bfe8   ; un byte n veces
	ld b,a			;bfea
	ld a,(hl)			;bfeb
	inc hl			;bfec
L_BFED:
	ld (de),a			;bfed
	inc de			;bfee
	djnz L_BFED		;bfef
	jr L_BFD5		;bff1

; ----------------------------------------------------------------------
; DATOS tabla_BFF3: 13 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (13 bytes)
;   0xbff3..0xc000  (13 bytes)
DATA_tabla_BFF3:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff3  .............

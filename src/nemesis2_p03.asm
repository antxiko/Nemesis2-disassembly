; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS partida_A000: el desplazamiento (0x30) de `ld (ix+0x30),a`, la
;   instruccion que empieza en p02:9FFE; detras, p03:A001 es su `ret`; lo leen
;   p02:9FFE (1 bytes)
;   0xa000..0xa001  (1 bytes)
DATA_partida_A000:
	defb 030h	; a000

; ======================================================================
; CODIGO 0xa001..0xa013  (18 bytes)
; ======================================================================


L_A001:
	ret			;a001
color_de_p03_a013:		; IX+31 = el color de p03:A013 que toca (cada 4 cuadros, 4 colores)
	ld a,(0e1c3h)		;a002   ; cada 4 cuadros
	rra			;a005
	rra			;a006
	and 003h		;a007
	ld hl,0a013h		;a009   ; uno de 4 colores
	call 05ca6h		;a00c   ; byte_a: A = el byte A de la tabla HL
	ld (ix+031h),a		;a00f
	ret			;a012

; ----------------------------------------------------------------------
; DATOS tabla_A013: 4 bytes que p03:A002 lee con (0xE1C3 / 4) & 3 y pone en
;   IX+31; lo leen p03:A00C (4 bytes)
;   0xa013..0xa017  (4 bytes)
DATA_tabla_A013:
	defb 006h,008h,009h,008h	; a013

; ======================================================================
; CODIGO 0xa017..0xa0fc  (229 bytes)
; ======================================================================


suceso_de_fase_5:		; el suceso del final del scroll de la fase 5 (0xE388 = 1): 600 cuadros (900 con 0xE20A) de compuertas (clase 7) que salen y sueltan enemigos
	ld hl,01e01h		;a017   ; paso 1, espera 30
	ld (0e388h),hl		;a01a   ; guarda el paso del suceso de la fase 5 y el byte siguiente (16 bits)
	xor a			;a01d   ; sin compuertas
	ld (0e38ah),a		;a01e   ; guarda cuantas compuertas hay
	ld hl,0e3cah		;a021   ; los 6 huecos libres
	ld de,0e3cbh		;a024
	ld bc,00005h		;a027
	ld (hl),a			;a02a
	ldir		;a02b
	call 04c24h		;a02d   ; arriba o abajo al azar
	ld (0e38bh),a		;a030   ; guarda arriba o abajo (bit 0)
	ld a,0d2h		;a033   ; 210 cuadros
	ld (0e39fh),a		;a035   ; guarda la espera del paso del suceso
	ld a,01eh		;a038
	ld (0e389h),a		;a03a   ; guarda la espera entre compuertas
	ld hl,00258h		;a03d   ; 600 cuadros, 900 con 0xE20A
	ld a,(0e20ah)		;a040   ; lee la vuelta (bit 0: las fases bajan)
	or a			;a043
	jr z,L_A049		;a044
	ld hl,00384h		;a046
L_A049:
	ld (0e349h),hl		;a049   ; guarda la espera del suceso y el byte siguiente (16 bits)
	ret			;a04c
cuadro_suceso_fase_5:		; cuenta los cuadros del suceso (0xE349); al acabar, 0xE348 = 1; paso 1: salen compuertas; paso 2: espera
	ld a,(0e388h)		;a04d   ; sin suceso, nada
	or a			;a050
	ret z			;a051
	ld b,a			;a052
	ld hl,(0e349h)		;a053   ; un cuadro menos
	dec hl			;a056
	ld (0e349h),hl		;a057   ; guarda la espera del suceso y el byte siguiente (16 bits)
	ld a,l			;a05a
	or h			;a05b
	jr z,L_A066		;a05c   ; acabado
	dec b			;a05e   ; paso 1
	jr z,L_A06F		;a05f
	dec b			;a061   ; paso 2
	jp z,L_A108		;a062
	ret			;a065
L_A066:
	xor a			;a066   ; se acabo: el scroll sigue
	ld (0e388h),a		;a067   ; guarda el paso del suceso de la fase 5
	inc a			;a06a
	ld (0e348h),a		;a06b   ; guarda la marca de fin del suceso
	ret			;a06e
L_A06F:
	ld hl,0e39fh		;a06f   ; paso 1: la espera
	dec (hl)			;a072
	jr nz,L_A09D		;a073
	ld (hl),01eh		;a075   ; acabada: paso 2 y todas las compuertas a temblar
	ld a,002h		;a077
	ld (0e388h),a		;a079   ; guarda el paso del suceso de la fase 5
	ld ix,0e500h		;a07c   ; 8 fichas de objeto
	ld de,00010h		;a080
	ld bc,00805h		;a083
	ld hl,001ffh		;a086
L_A089:
	ld a,(ix+000h)		;a089   ; libre
	or a			;a08c
	jr z,L_A098		;a08d
	ld (ix+001h),c		;a08f   ; paso 5, sin caja (0xFF), IX+02 = 1
	ld (ix+00dh),l		;a092   ; sin caja
	ld (ix+002h),h		;a095   ; 1 cuadro
L_A098:
	add ix,de		;a098
	djnz L_A089		;a09a
	ret			;a09c
L_A09D:
	ld hl,0e389h		;a09d   ; la espera entre compuertas
	dec (hl)			;a0a0   ; la espera
	ret nz			;a0a1
	ld a,r		;a0a2   ; la siguiente, de 32 a 63 cuadros
	and 01fh		;a0a4
	add a,020h		;a0a6   ; 32-63 cuadros
	ld (hl),a			;a0a8
	ld a,(0e20ah)		;a0a9   ; como mucho 2 (3 con 0xE20A)
	ld b,002h		;a0ac   ; como mucho 2
	or a			;a0ae
	jr z,L_A0B2		;a0af
	inc b			;a0b1   ; 3 con la vuelta
L_A0B2:
	ld a,(0e38ah)		;a0b2   ; lee cuantas compuertas hay
	cp b			;a0b5
	jr c,L_A0BE		;a0b6
L_A0B8:
	ld a,001h		;a0b8   ; la proxima, en un cuadro
	ld (0e389h),a		;a0ba   ; guarda la espera entre compuertas
	ret			;a0bd
L_A0BE:
	call 04c24h		;a0be   ; un hueco al azar (0-2)
	and 003h		;a0c1   ; 0, 1 o 2
	cp 003h		;a0c3
	jr nz,L_A0C8		;a0c5
	xor a			;a0c7   ; el 3 vale 0
L_A0C8:
	ld b,a			;a0c8
	ld hl,0e3cah		;a0c9   ; arriba (0xE3CA) o abajo (0xE3CD)
	ld a,(0e38bh)		;a0cc   ; lee arriba o abajo (bit 0)
	bit 0,a		;a0cf
	jr z,L_A0D5		;a0d1
	ld l,0cdh		;a0d3
L_A0D5:
	ld a,b			;a0d5   ; el hueco
	add a,l			;a0d6
	ld l,a			;a0d7
	ld a,(hl)			;a0d8   ; ocupado
	or a			;a0d9   ; ocupado
	jr nz,L_A0B8		;a0da
	push hl			;a0dc
	ld a,(0e38bh)		;a0dd   ; el sitio del hueco
	bit 0,a		;a0e0
	ld a,b			;a0e2
	jr z,L_A0E7		;a0e3
	add a,003h		;a0e5   ; abajo: los 3 siguientes
L_A0E7:
	ld b,a			;a0e7
	ld hl,0a0fch		;a0e8   ; en p03:A0FC
	call 04b67h		;a0eb   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,007h		;a0ee   ; una compuerta (clase 7)
	call 087dch		;a0f0   ; crea_objeto: un objeto de caracteres de la clase A en la primera ficha libre de 0xE500 (8 de 16 bytes), en D (X), E (Y)
	pop hl			;a0f3
	ret nc			;a0f4   ; sin sitio
	ld (hl),001h		;a0f5   ; hueco ocupado
	ld hl,0e38ah		;a0f7   ; una mas
	inc (hl)			;a0fa
	ret			;a0fb

; ----------------------------------------------------------------------
; DATOS tabla_A0FC: 6 palabras que p03:A0DC lee con B (3 mas si el bit 0 de
;   0xE38B) con L_4B67; lo leen p03:A0EB (12 bytes)
;   0xa0fc..0xa108  (12 bytes)
DATA_tabla_A0FC:
	defw 0a008h,06008h,02008h,0a078h,06078h,02078h	; a0fc

; ======================================================================
; CODIGO 0xa108..0xa156  (78 bytes)
; ======================================================================


L_A108:
	ld hl,0e39fh		;a108   ; paso 2: espera 210 cuadros
	dec (hl)			;a10b
	ret nz			;a10c
	ld (hl),0d2h		;a10d
	ld hl,0e38bh		;a10f   ; la otra mitad
	inc (hl)			;a112
	ld a,001h		;a113   ; paso 1 otra vez
	ld (0e388h),a		;a115   ; guarda el paso del suceso de la fase 5
	ret			;a118
clase_7_empieza:		; la clase 7 (compuerta): 8 x 6 caracteres, 32 golpes, sin caja; la forma 0x1F arriba o 0x27 abajo; sin X, se quita
	ld a,(ix+006h)		;a119   ; sin X, se quita
	or a			;a11c
	jp z,compuerta_se_va		;a11d   ; compuerta_se_va: libera su hueco del suceso (0xE3CA) y la ficha
	ld (ix+009h),008h		;a120   ; 8 x 6 caracteres
	ld (ix+00ah),006h		;a124
	ld (ix+00dh),0ffh		;a128   ; sin caja
	ld (ix+008h),020h		;a12c   ; 32 golpes
	ld (ix+00eh),000h		;a130
	call compuerta_arriba		;a134   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld a,01fh		;a137   ; la forma: 0x1F arriba, 0x27 abajo
	jr c,L_A13D		;a139
	ld a,027h		;a13b
L_A13D:
	ld (ix+007h),a		;a13d
	ret			;a140
clase_7:		; la compuerta: lo de su paso (IX+01, p03:A156) y su caja segun la forma
	ld a,(ix+006h)		;a141   ; sin X, se quita
	or a			;a144   ; sin X
	jr nz,L_A14C		;a145
	ld (ix+000h),000h		;a147   ; se quita
	ret			;a14b
L_A14C:
	ld hl,0a22fh		;a14c   ; al acabar, su caja
	push hl			;a14f
	ld a,(ix+001h)		;a150   ; por paso
	call 04084h		;a153   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A156: 7 destinos del despachador p00:4084 (call en p03:A153, el
;   indice en A): A164, A170, A17E, A1AA, A1CA, A1F9, A210; lo leen p03:A153
;   (14 bytes)
;   0xa156..0xa164  (14 bytes)
DATA_tabla_A156:
	defw 0a164h,0a170h,0a17eh,0a1aah,0a1cah,0a1f9h,0a210h	; a156

; ======================================================================
; CODIGO 0xa164..0xa245  (225 bytes)
; ======================================================================


compuerta_espera:		; en pantalla (X < 0xC1), empieza a abrirse
	ld a,(ix+006h)		;a164   ; cerca del borde derecho, espera
	cp 0c1h		;a167
	ret nc			;a169
	ld (ix+002h),001h		;a16a   ; IX+02 = 1
	jr compuerta_siguiente		;a16e
compuerta_cerrada:		; cada 4 cuadros al paso siguiente; mientras, se mueve
	dec (ix+002h)		;a170   ; la espera
	jp nz,compuerta_vibra		;a173   ; compuerta_vibra: cada 8 cuadros la forma abre y cierra un paso
	ld (ix+002h),004h		;a176   ; 4 cuadros
compuerta_siguiente:		; el paso siguiente de la compuerta (IX+01 + 1)
	inc (ix+001h)		;a17a
	ret			;a17d
compuerta_se_abre:		; cada 4 cuadros la forma + 1 hasta abierta (0x23 o 0x2B); luego una espera y cuantos suelta al azar
	dec (ix+002h)		;a17e   ; la espera
	ret nz			;a181
	ld (ix+002h),004h		;a182
	call compuerta_arriba		;a186   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld b,023h		;a189   ; abierta: 0x23 arriba, 0x2B abajo
	jr c,L_A18F		;a18b
	ld b,02bh		;a18d
L_A18F:
	inc (ix+007h)		;a18f   ; un paso mas
	ld a,(ix+007h)		;a192   ; la forma
	cp b			;a195   ; hasta abierta
	ret c			;a196
	ld a,r		;a197   ; abierta: una espera de 48 a 79
	and 01fh		;a199
	add a,030h		;a19b
	ld (ix+002h),a		;a19d   ; 48-79 cuadros
	ld a,r		;a1a0   ; y cuantos suelta (1-16)
	and 00fh		;a1a2
	inc a			;a1a4
	ld (ix+00ch),a		;a1a5   ; 1-16 por soltar
	jr compuerta_siguiente		;a1a8
compuerta_abierta:		; abierta: suelta enemigos 0x25; al acabar la espera se cierra (o, sin suceso, se va)
	dec (ix+002h)		;a1aa   ; mientras dure
	jr z,L_A1B5		;a1ad
	call compuerta_anima		;a1af   ; anima y suelta
	jp compuerta_suelta		;a1b2   ; compuerta_suelta: al acabar IX+0C (mas rapido con pocos golpes), un 0x25 en su boca
L_A1B5:
	ld a,(0e388h)		;a1b5   ; sin suceso, a cerrarse
	or a			;a1b8
	jr nz,L_A1C1		;a1b9
	ld (ix+002h),004h		;a1bb   ; sin suceso: 4 cuadros y se cierra
	jr compuerta_siguiente		;a1bf
L_A1C1:
	ld (ix+002h),002h		;a1c1   ; con suceso, a temblar (paso 5)
	ld (ix+001h),005h		;a1c5
	ret			;a1c9
compuerta_se_cierra:		; cada 4 cuadros la forma - 1 hasta cerrada; luego espera 50 cuadros (30 con 0xE20A)
	dec (ix+002h)		;a1ca
	ret nz			;a1cd
	ld (ix+002h),004h		;a1ce   ; 4 cuadros
	call compuerta_arriba		;a1d2   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld b,020h		;a1d5   ; cerrada: 0x20 arriba, 0x28 abajo
	jr c,L_A1DB		;a1d7
	ld b,028h		;a1d9
L_A1DB:
	dec (ix+007h)		;a1db   ; un paso menos
	ld a,(ix+007h)		;a1de   ; la forma
	cp b			;a1e1   ; hasta cerrada
	ret nc			;a1e2
	ld (ix+001h),001h		;a1e3   ; cerrada: al paso 1
	ld (ix+00eh),000h		;a1e7   ; abriendo
	ld a,(0e20ah)		;a1eb   ; 50 cuadros, 30 con 0xE20A
	or a			;a1ee
	ld a,032h		;a1ef
	jr z,L_A1F5		;a1f1
	ld a,01eh		;a1f3
L_A1F5:
	ld (ix+002h),a		;a1f5
	ret			;a1f8
compuerta_tiembla:		; cada 2 cuadros la forma cambia un paso
	dec (ix+002h)		;a1f9
	ret nz			;a1fc
	ld (ix+002h),002h		;a1fd   ; cada 2 cuadros
	ld (ix+00eh),001h		;a201
	call compuerta_cierra_un_paso		;a205   ; compuerta_cierra_un_paso: la forma - 1 (hasta cerrada)
	bit 0,(ix+00eh)		;a208
	ret nz			;a20c
	jp compuerta_siguiente		;a20d   ; compuerta_siguiente: el paso siguiente de la compuerta (IX+01 + 1)
compuerta_se_va:		; libera su hueco del suceso (0xE3CA) y la ficha
	ld a,(0e388h)		;a210   ; con suceso, su hueco libre
	or a			;a213
	jr z,L_A224		;a214
	ld a,(ix+00bh)		;a216
	ld hl,0e3cah		;a219   ; apunta a los 6 huecos de compuerta (3 arriba, 3 abajo)
	add a,l			;a21c
	ld l,a			;a21d
	ld (hl),000h		;a21e
	ld hl,0e38ah		;a220   ; una menos
	dec (hl)			;a223
L_A224:
	ld (ix+000h),000h		;a224   ; libre
	ret			;a228
compuerta_arriba:		; C si esta arriba (Y < 0x40)
	ld a,(ix+004h)		;a229
	cp 040h		;a22c   ; Y < 0x40: arriba
	ret			;a22e
caja_de_compuerta:		; IX+0D = la caja de su forma (p03:A226); 0xFF cerca del borde derecho
	ld a,(ix+006h)		;a22f
	cp 0c1h		;a232   ; cerca del borde, sin caja
	ld a,0ffh		;a234
	jr nc,L_A241		;a236
	ld a,(ix+007h)		;a238   ; la caja de su forma
	ld hl,L_A224+2		;a23b
	call 05ca6h		;a23e   ; byte_a: A = el byte A de la tabla HL
L_A241:
	ld (ix+00dh),a		;a241
	ret			;a244

; ----------------------------------------------------------------------
; DATOS tabla_A245: 16 bytes que p03:A22F lee en 0xA226 + IX+07 (de 0x1F a
;   0x2E) con L_5CA6 y pone en IX+0D; lo leen p03:A23F (16 bytes)
;   0xa245..0xa255  (16 bytes)
DATA_tabla_A245:
	defb 00ah,00bh,00ch,00dh,009h,009h,009h,009h,00eh,00fh,010h,011h,009h,009h,009h,009h	; a245  ................

; ======================================================================
; CODIGO 0xa255..0xa43f  (490 bytes)
; ======================================================================


compuerta_vibra:		; cada 8 cuadros la forma abre y cierra un paso
	ld a,(0e1c3h)		;a255   ; cada 8 cuadros
	and 007h		;a258
	ret nz			;a25a
	bit 0,(ix+00eh)		;a25b   ; abriendo o cerrando?
	jr nz,compuerta_cierra_un_paso		;a25f
	call compuerta_arriba		;a261   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld b,021h		;a264   ; abre hasta 0x21 o 0x29
	jr c,L_A26A		;a266
	ld b,029h		;a268
L_A26A:
	inc (ix+007h)		;a26a
	ld a,(ix+007h)		;a26d   ; la forma
	cp b			;a270   ; hasta B
	ret c			;a271
	ld (ix+007h),b		;a272   ; abierta: ahora cierra
	ld (ix+00eh),001h		;a275   ; ahora cierra
	ret			;a279
compuerta_cierra_un_paso:		; la forma - 1 (hasta cerrada)
	call compuerta_arriba		;a27a   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld b,020h		;a27d   ; cierra hasta 0x20 o 0x28
	jr c,L_A283		;a27f
	ld b,028h		;a281
L_A283:
	dec (ix+007h)		;a283
	ld a,(ix+007h)		;a286   ; la forma
	cp b			;a289   ; hasta B
	ret nc			;a28a
	dec b			;a28b   ; cerrada: ahora abre
	ld (ix+007h),b		;a28c
	ld (ix+00eh),000h		;a28f   ; ahora abre
	ret			;a293
compuerta_anima:		; cada 4 cuadros la forma abierta cambia (dos dibujos)
	ld a,(0e1c3h)		;a294   ; cada 4 cuadros
	and 003h		;a297
	ret nz			;a299
	call compuerta_arriba		;a29a   ; compuerta_arriba: C si esta arriba (Y < 0x40)
	ld bc,02723h		;a29d   ; entre 0x23 y 0x26 (0x2B y 0x2E abajo)
	jr c,L_A2A5		;a2a0
	ld bc,02f2bh		;a2a2
L_A2A5:
	inc (ix+007h)		;a2a5   ; la forma siguiente
	ld a,(ix+007h)		;a2a8
	cp b			;a2ab   ; pasada la ultima
	ret c			;a2ac
	ld (ix+007h),c		;a2ad   ; vuelve a la primera
	ret			;a2b0
compuerta_suelta:		; al acabar IX+0C (mas rapido con pocos golpes), un 0x25 en su boca
	ld a,(0e354h)		;a2b1   ; en la espera de salida, no
	or a			;a2b4
	ret nz			;a2b5
	dec (ix+00ch)		;a2b6   ; la espera
	ret nz			;a2b9
	ld a,r		;a2ba   ; la siguiente: 1-8 cuadros
	and 007h		;a2bc
	inc a			;a2be
	ld c,a			;a2bf
	ld a,(ix+008h)		;a2c0   ; con menos de 24 golpes, el doble
	cp 018h		;a2c3
	jr nc,L_A2CF		;a2c5
	sla c		;a2c7
	cp 008h		;a2c9   ; con menos de 8, el doble otra vez
	jr nc,L_A2CF		;a2cb
	sla c		;a2cd
L_A2CF:
	ld (ix+00ch),c		;a2cf   ; la espera
	call compuerta_arriba		;a2d2   ; la boca: Y + 0x14 arriba, + 0x0C abajo
	ld e,014h		;a2d5
	jr c,L_A2DB		;a2d7
	ld e,00ch		;a2d9   ; abajo: + 0x0C
L_A2DB:
	ld a,(ix+004h)		;a2db
	add a,e			;a2de
	ld e,a			;a2df
	ld a,(ix+006h)		;a2e0   ; X + 0x18
	add a,018h		;a2e3
	ld d,a			;a2e5
	ld bc,00000h		;a2e6
	ld a,025h		;a2e9   ; un 0x25
	jp 04d16h		;a2eb   ; crea_enemigo_ix: crea_enemigo conservando IX
tipo_04_empieza:		; el tipo 4: hacia la izquierda (vx 0xFE80), sin velocidad Y
	ld de,00000h		;a2ee   ; vy = 0
	call 04efbh		;a2f1   ; pon_vy: IX+07/IX+08 = DE
	ld de,0fe80h		;a2f4   ; vx = 0xFE80
	jp 04f02h		;a2f7   ; pon_vx: IX+09/IX+0A = DE
tipo_04:		; el tipo 4: si la nave esta a su altura va hacia ella; si no, en diagonal hacia arriba o abajo; dispara
	call 06770h		;a2fa   ; dispara
	ld a,(0e404h)		;a2fd   ; la Y de la nave menos la suya
	sub (ix+004h)		;a300
	push af			;a303
	add a,003h		;a304
	cp 007h		;a306   ; a su altura (+-3)
	jr c,L_A321		;a308
	pop af			;a30a
	jr c,L_A317		;a30b
	ld a,070h		;a30d   ; por debajo: abajo en diagonal
	ld de,0fe80h		;a30f
	ld bc,00120h		;a312
	jr L_A335		;a315
L_A317:
	ld a,06ch		;a317   ; por encima: arriba en diagonal
	ld de,0fe80h		;a319   ; vx 0xFE80
	ld bc,0fee0h		;a31c   ; vy 0xFEE0: arriba
	jr L_A335		;a31f
L_A321:
	pop af			;a321
	ld a,(0e406h)		;a322   ; a su altura: hacia ella deprisa (0xFC80) o despacio (0xFE80)
	sub (ix+006h)		;a325   ; delante o detras
	ld de,0fc80h		;a328   ; hacia ella: deprisa
	jr c,L_A330		;a32b
	ld de,0fe80h		;a32d   ; o despacio
L_A330:
	ld bc,00000h		;a330
	ld a,068h		;a333
L_A335:
	ld (ix+030h),a		;a335   ; el dibujo
	call 04f02h		;a338   ; pon_vx: IX+09/IX+0A = DE
	ld d,b			;a33b
	ld e,c			;a33c
	jp 04efbh		;a33d   ; pon_vy: IX+07/IX+08 = DE
tipo_0e_empieza:		; el tipo 0x0E: con B sale de X 0 o 0x80; hacia la nave por pasos
	ld a,(ix+019h)		;a340   ; con B, la X de salida
	and a			;a343   ; sin B, nada
	jr z,L_A351		;a344
	cp 002h		;a346   ; 2: 0x80; si no, 0
	ld c,080h		;a348   ; 2: X 0x80
	jr z,L_A34E		;a34a
	ld c,000h		;a34c   ; 1: X 0
L_A34E:
	ld (ix+006h),c		;a34e
L_A351:
	call sin_ejes		;a351   ; sin_ejes: IX+2A = IX+2B = 0
	ld (ix+026h),000h		;a354   ; paso 0 del objetivo
	ld d,(ix+006h)		;a358   ; su X
	jr tipo_0e_rumbo		;a35b
sin_ejes:		; IX+2A = IX+2B = 0
	xor a			;a35d   ; sin sentido en ninguno de los ejes
	ld (ix+02ah),a		;a35e
	ld (ix+02bh),a		;a361
	ret			;a364
tipo_0e:		; el tipo 0x0E: va hacia la nave en vertical o en horizontal, por turnos (IX+25 cuadros cada uno)
	ld a,(ix+001h)		;a365   ; en marcha?
	and a			;a368
	jr z,L_A374		;a369   ; parado?
	dec (ix+025h)		;a36b   ; la espera del eje
	ret nz			;a36e
	dec (ix+001h)		;a36f   ; paso 0
	jr L_A37D		;a372
L_A374:
	dec (ix+025h)		;a374   ; la espera
	ret nz			;a377
	ld a,(ix+029h)		;a378   ; con IX+29, quieto
	and a			;a37b
	ret nz			;a37c
L_A37D:
	call tipo_0e_objetivo		;a37d   ; el objetivo y el rumbo
	call tipo_0e_rumbo		;a380   ; tipo_0e_rumbo: la velocidad hacia un punto cerca de la nave y hacia donde va en cada eje (IX+27, IX+28)
	jr L_A3B7		;a383
tipo_0e_rumbo:		; la velocidad hacia un punto cerca de la nave y hacia donde va en cada eje (IX+27, IX+28)
	ld a,(ix+001h)		;a385   ; paso 2: nada
	cp 002h		;a388
	ret z			;a38a
	ld e,(ix+004h)		;a38b
	ld a,040h		;a38e   ; rapidez 0x40
	call 04ebah		;a390   ; rumbo_desde_de: IX+07-IX+0A = la velocidad hacia la nave desde D/E (p02:93F5)
	xor a			;a393   ; baja (1) o sube (0)
	bit 7,(ix+008h)		;a394
	jr nz,L_A39B		;a398
	inc a			;a39a
L_A39B:
	ld c,(ix+027h)		;a39b   ; el sentido de antes, a IX+2A
	ld (ix+02ah),c		;a39e
	ld (ix+027h),a		;a3a1   ; el nuevo, a IX+27
	xor a			;a3a4   ; a la derecha (1) o a la izquierda (0)
	bit 7,(ix+00ah)		;a3a5   ; hacia la izquierda?
	jr nz,L_A3AC		;a3a9
	inc a			;a3ab
L_A3AC:
	ld c,(ix+028h)		;a3ac   ; el sentido de antes, a IX+2B
	ld (ix+02bh),c		;a3af
	ld (ix+028h),a		;a3b2   ; el nuevo, a IX+28
	jr tipo_0e_espera		;a3b5
L_A3B7:
	ld a,(ix+02ah)		;a3b7   ; ha cambiado de sentido en Y?
	ld c,(ix+027h)		;a3ba
	xor c			;a3bd
	jr nz,L_A3E5		;a3be
	ld a,(ix+02bh)		;a3c0   ; y en X?
	ld c,(ix+028h)		;a3c3
	xor c			;a3c6
	ret z			;a3c7
	inc (ix+001h)		;a3c8   ; en vertical hacia la nave
	call 04f17h		;a3cb   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	ld de,00180h		;a3ce
	ld b,001h		;a3d1
	ld a,(0e404h)		;a3d3   ; lee la Y de la nave
	cp (ix+004h)		;a3d6
	jr nc,L_A3DF		;a3d9
	dec b			;a3db
	call 05cadh		;a3dc   ; menos_de: DE = - DE
L_A3DF:
	ld (ix+027h),b		;a3df
	jp 04efbh		;a3e2   ; pon_vy: IX+07/IX+08 = DE
L_A3E5:
	inc (ix+001h)		;a3e5   ; en horizontal hacia la nave
	call 04f17h		;a3e8   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	ld de,00180h		;a3eb
	ld b,001h		;a3ee
	ld a,(0e406h)		;a3f0   ; lee la X de la nave
	cp (ix+006h)		;a3f3
	jr nc,L_A3FC		;a3f6
	dec b			;a3f8
	call 05cadh		;a3f9   ; menos_de: DE = - DE
L_A3FC:
	ld (ix+028h),b		;a3fc
	jp 04f02h		;a3ff   ; pon_vx: IX+09/IX+0A = DE
tipo_0e_espera:		; IX+25 = 8-11 al azar
	call 0637bh		;a402   ; 8-11 cuadros
	and 003h		;a405   ; 0-3
	ld c,008h		;a407   ; + 8
	add a,c			;a409
	ld (ix+025h),a		;a40a
	ret			;a40d
tipo_0e_objetivo:		; D = la X objetivo: la suya mas o menos la de p03:A43F (8 pasos)
	ld a,(ix+026h)		;a40e   ; el desplazamiento del paso (p03:A43F)
	ld hl,0a43fh		;a411
	call 0407ah		;a414   ; hl_mas_a: HL = HL + A
	ld l,(hl)			;a417
	ld a,(ix+026h)		;a418   ; el paso siguiente (8)
	inc a			;a41b   ; 8 pasos
	and 007h		;a41c
	ld (ix+026h),a		;a41e
	ld a,(ix+001h)		;a421   ; en marcha y la nave por encima
	and a			;a424
	jr z,L_A439		;a425
	ld a,(0e404h)		;a427   ; con la nave por encima, restado
	sub (ix+004h)		;a42a
	jr nc,L_A439		;a42d
	ld a,(ix+006h)		;a42f
	sub l			;a432
L_A433:
	jr nc,L_A437		;a433
	neg		;a435
L_A437:
	ld d,a			;a437
	ret			;a438
L_A439:
	ld a,(ix+006h)		;a439   ; si no, sumado
	add a,l			;a43c
	jr L_A433		;a43d

; ----------------------------------------------------------------------
; DATOS tabla_A43F: 8 bytes que p03:A40E lee con IX+26; lo leen p03:A414 (8
;   bytes)
;   0xa43f..0xa447  (8 bytes)
DATA_tabla_A43F:
	defb 010h,00ch,008h,006h,004h,002h,001h,000h	; a43f  ........

; ======================================================================
; CODIGO 0xa447..0xa485  (62 bytes)
; ======================================================================


tipo_19_empieza:		; el tipo 0x19: espera al azar, IX+10 = 0x17, y la velocidad hacia la nave (a veces) o recta, con la rapidez de p03:A48D + 2 x nivel
	ld a,r		;a447   ; 1-8 cuadros
	and 007h		;a449
	jr nz,L_A44F		;a44b   ; 0 vale 8
	ld a,008h		;a44d
L_A44F:
	ld (ix+025h),a		;a44f
	ld (ix+010h),017h		;a452   ; IX+10 = 0x17
	ld a,r		;a456   ; la rapidez de p03:A48D
	and 007h		;a458
	ld hl,0a48dh		;a45a
	call 0407ah		;a45d   ; hl_mas_a: HL = HL + A
	ld a,(0e228h)		;a460   ; + 2 x nivel
	add a,a			;a463
	add a,(hl)			;a464
	ld b,a			;a465
	ld h,(ix+004h)		;a466
	ld l,000h		;a469
	ld a,r		;a46b   ; una de cada 4, hacia la nave
	and 003h		;a46d
	jr nz,L_A481		;a46f
	ld a,(0e406h)		;a471   ; lee la X de la nave
	ld l,a			;a474
	ld a,(0e404h)		;a475   ; lee la Y de la nave
	ld c,a			;a478
	ld a,r		;a479   ; con un error de -32 a 31 en Y
	and 03fh		;a47b
	sub 020h		;a47d
	add a,c			;a47f
	ld h,a			;a480
L_A481:
	ld a,b			;a481
	jp 04ed7h		;a482   ; rumbo_de_a: IX+07-IX+0A desde IX+04/IX+06 con p02:9467 y p02:93FD (A en 0xF00F, HL en 0xF000-0xF001)

; ----------------------------------------------------------------------
; DATOS tabla_A485: 8 bytes delante de 0xA48D que no lee nadie a la vista (las
;   referencias a 0xA485 y 0xA488 son del banco 10); lo leen nadie (8 bytes)
;   0xa485..0xa48d  (8 bytes)
DATA_tabla_A485:
	defb 080h,080h,000h,040h,0c0h,030h,0d0h,060h	; a485  ...@.0.`

; ----------------------------------------------------------------------
; DATOS tabla_A48D: 8 bytes que p03:A456 lee al azar (ld a,r & 7) y a los que
;   suma 2 x 0xE228; lo leen p03:A45D (8 bytes)
;   0xa48d..0xa495  (8 bytes)
DATA_tabla_A48D:
	defb 0a0h,0c0h,0b0h,090h,080h,060h,0d0h,098h	; a48d  .....`..

; ======================================================================
; CODIGO 0xa495..0xa62c  (407 bytes)
; ======================================================================


tipo_19:		; el tipo 0x19: parpadea, se anima y se quita al tocar el mapa
	ld a,(ix+031h)		;a495   ; parpadea
	xor 001h		;a498
	ld (ix+031h),a		;a49a
	call tipo_19_dibujo		;a49d   ; su dibujo
	ld h,(ix+006h)		;a4a0
	ld l,(ix+004h)		;a4a3
	call 05c92h		;a4a6   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	call toca_mapa_o_diagonal		;a4a9   ; toca el mapa: se quita
	jp c,06514h		;a4ac   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ret			;a4af
toca_mapa_o_diagonal:		; C si hay mapa en HL o (sin estar en el borde derecho) en el de abajo a la derecha
	ld a,(0e305h)		;a4b0   ; lee dato de la fase de p01:697A
	ld c,a			;a4b3
	ld a,(hl)			;a4b4   ; vacio o fondo: mira el otro
	and a			;a4b5
	jr z,L_A4BA		;a4b6   ; vacio: mira el otro
	cp c			;a4b8   ; mapa: C
	ret c			;a4b9
L_A4BA:
	ld a,(ix+006h)		;a4ba   ; en el borde derecho, no
	cp 0f8h		;a4bd
	ret nc			;a4bf
	ld de,00021h		;a4c0   ; el de abajo a la derecha
	add hl,de			;a4c3
	ld a,(hl)			;a4c4   ; vacio: no
	and a			;a4c5
	ret z			;a4c6
	cp c			;a4c7   ; mapa: C
	ret			;a4c8
tipo_19_dibujo:		; cada 8 cuadros el dibujo siguiente (0xD4-0xDC)
	dec (ix+025h)		;a4c9   ; cada 8 cuadros
	ret nz			;a4cc
	ld (ix+025h),008h		;a4cd
	ld a,(ix+030h)		;a4d1   ; el siguiente, de 0xD4 a 0xDC
	add a,004h		;a4d4
	cp 0e0h		;a4d6   ; pasado 0xDC
	jr nz,L_A4DC		;a4d8
	ld a,0d4h		;a4da   ; vuelve a 0xD4
L_A4DC:
	ld (ix+030h),a		;a4dc
	ret			;a4df
tipo_1b_empieza:		; el tipo 0x1B: 2 x 2, el caracter 0x39 (0x3A sin B, desde X 8), 3 de caja, quieto
	ld (ix+013h),002h		;a4e0   ; 2 x 2
	ld (ix+014h),002h		;a4e4
	ld (ix+002h),004h		;a4e8   ; parpadeo de 4 cuadros, 10 veces
	ld (ix+025h),00ah		;a4ec
	ld (ix+015h),008h		;a4f0   ; espera de disparo
	ld b,039h		;a4f4   ; el caracter 0x39
	ld a,(ix+019h)		;a4f6
	and a			;a4f9
	jr nz,L_A501		;a4fa
	inc b			;a4fc   ; sin B, el 0x3A y desde la izquierda
	ld (ix+006h),008h		;a4fd
L_A501:
	ld (ix+032h),b		;a501
	ld (ix+00dh),003h		;a504   ; caja 3
	jp 04f17h		;a508   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
tipo_1b:		; el tipo 0x1B: parpadea 10 veces y luego sale (vx 0xFD00 o 0x0300) disparando
	ld a,(ix+001h)		;a50b   ; paso 0: parpadea
	and a			;a50e
	jr nz,L_A543		;a50f   ; en marcha?
	ld a,(ix+002h)		;a511   ; a los 2 cuadros
	cp 002h		;a514
	jr nz,L_A520		;a516
	ld a,(ix+00bh)		;a518   ; se ve o no
	xor 080h		;a51b   ; se ve o no
	ld (ix+00bh),a		;a51d
L_A520:
	dec (ix+002h)		;a520
	ret nz			;a523
	ld (ix+002h),004h		;a524   ; cada 4 cuadros
	dec (ix+025h)		;a528   ; 10 veces
	ret nz			;a52b
	inc (ix+001h)		;a52c   ; sale
	set 7,(ix+00bh)		;a52f
	call 04f17h		;a533   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	ld de,0fd00h		;a536   ; hacia la izquierda, o a la derecha sin B
	ld a,(ix+019h)		;a539
	and a			;a53c
	call z,05cadh		;a53d   ; menos_de: DE = - DE
	jp 04f02h		;a540   ; pon_vx: IX+09/IX+0A = DE
L_A543:
	dec (ix+015h)		;a543   ; dispara al acabar la espera
	ret nz			;a546
	jp dispara_desde_ix		;a547   ; dispara_desde_ix: una bala desde el enemigo IX (X + 8) hacia la nave
tipo_07_empieza:		; el tipo 7: en fila con el de delante (0xE35C, 0xE35D): el primero sube o baja (0xE35A); los demas siguen su rastro
	ld a,(0e35ch)		;a54a   ; el puesto en la fila
	ld (ix+027h),a		;a54d   ; su puesto
	and a			;a550
	jr nz,L_A572		;a551   ; no es el primero
	push ix		;a553   ; el primero: se apunta en la ficha de la fila
	pop de			;a555
	ld hl,(0e35dh)		;a556   ; lee el primero de la fila del tipo 7 y el byte siguiente (16 bits)
	inc l			;a559   ; a IX+03/IX+05 de la ficha de la fila
	inc l			;a55a
	inc l			;a55b
	ld (hl),e			;a55c
	inc l			;a55d
	inc l			;a55e
	ld (hl),d			;a55f
L_A560:
	call 04f21h		;a560   ; sin vx
	ld d,004h		;a563   ; sube o baja segun 0xE35A
	ld a,(0e35ah)		;a565   ; lee la altura de la fila del tipo 7
	rra			;a568
	call nc,05cadh		;a569   ; menos_de: DE = - DE
	call 04efbh		;a56c   ; pon_vy: IX+07/IX+08 = DE
	or 0ffh		;a56f   ; NZ
	ret			;a571
L_A572:
	ld hl,(0e35dh)		;a572   ; el de delante
	inc l			;a575   ; el de delante
	inc l			;a576
	inc l			;a577
	ld e,(hl)			;a578
	inc l			;a579
	inc l			;a57a
	ld d,(hl)			;a57b
	ex de,hl			;a57c
	ld a,005h		;a57d   ; su X
	add a,l			;a57f
	ld l,a			;a580
	ld a,(hl)			;a581
	ld (ix+005h),a		;a582   ; la X del de delante
	inc l			;a585
	ld a,(hl)			;a586
	ld (ix+006h),a		;a587
	inc l			;a58a   ; su rastro, en IX+25/IX+26
	ld (ix+025h),l		;a58b
	ld (ix+026h),h		;a58e
	jr L_A560		;a591
tipo_07:		; el tipo 7: el primero va recto hasta la altura de la nave y luego en zig-zag hacia ella; los demas copian el rastro del de delante
	call tipo_07_dibujo		;a593   ; cambia de dibujo
	ld a,(ix+001h)		;a596   ; en zig-zag?
	and a			;a599
	jr nz,L_A5E4		;a59a
	ld a,(ix+027h)		;a59c   ; los de detras, por el rastro
	and a			;a59f
	jr nz,L_A5EE		;a5a0
	ld a,(0e404h)		;a5a2   ; ha llegado a la altura de la nave?
	bit 7,(ix+008h)		;a5a5
	jr nz,L_A5B1		;a5a9
	cp (ix+004h)		;a5ab
	ret nc			;a5ae
	jr L_A5B5		;a5af
L_A5B1:
	cp (ix+004h)		;a5b1
	ret c			;a5b4
L_A5B5:
	ld de,0fd00h		;a5b5   ; hacia la nave en X
	ld a,(0e406h)		;a5b8   ; lee la X de la nave
	cp (ix+006h)		;a5bb
	call nc,05cadh		;a5be   ; menos_de: DE = - DE
	call 04f02h		;a5c1   ; pon_vx: IX+09/IX+0A = DE
L_A5C4:
	inc (ix+001h)		;a5c4   ; zig-zag
	call tipo_07_rapidez		;a5c7   ; tipo_07_rapidez: DE = la rapidez de p03:A62C segun el nivel / 2
	ld bc,0ff80h		;a5ca   ; la aceleracion Y, segun el puesto
	ld a,(ix+027h)		;a5cd
	and a			;a5d0
	jr z,L_A5D9		;a5d1
	call 05cadh		;a5d3   ; menos_de: DE = - DE
	ld bc,00080h		;a5d6
L_A5D9:
	call 04efbh		;a5d9   ; la velocidad Y, su tope y su aceleracion
	call 062b6h		;a5dc   ; pon_tope: IX+22/IX+23 = DE en valor absoluto
	ld d,b			;a5df
	ld e,c			;a5e0
	jp 062a8h		;a5e1   ; pon_aceleracion: IX+20/IX+21 = DE
L_A5E4:
	call 062c2h		;a5e4   ; zig-zag: acelera y al pasar el tope da la vuelta
	call 062e8h		;a5e7   ; vy_pasa_el_tope: compara el valor absoluto de IX+07/IX+08 con IX+22/IX+23 (C: lo pasa)
	jp z,0629fh		;a5ea   ; invierte_aceleracion: IX+20/IX+21 = - IX+20/IX+21
	ret			;a5ed
L_A5EE:
	ld l,(ix+025h)		;a5ee   ; el rastro del de delante
	ld h,(ix+026h)		;a5f1
	ld a,l			;a5f4
	ld c,l			;a5f5
	sub 007h		;a5f6   ; 7 bytes antes
	ld l,a			;a5f8
	ld a,(hl)			;a5f9
	and a			;a5fa
	jr z,L_A60D		;a5fb   ; ya no esta
	ld l,c			;a5fd
	inc hl			;a5fe   ; su vx
	inc hl			;a5ff
	ld a,(hl)			;a600
	inc hl			;a601
	ld c,(hl)			;a602
	or c			;a603   ; cero: aun no ha girado
	ret z			;a604
	ld d,(hl)			;a605
	dec hl			;a606
	ld e,(hl)			;a607
	call 04f02h		;a608   ; la copia
	jr L_A5C4		;a60b
L_A60D:
	ld (ix+027h),000h		;a60d   ; el de delante ya no esta: va por su cuenta
	ret			;a611
tipo_07_dibujo:		; cada 8 cuadros cambia de dibujo
	ld a,(0e1c3h)		;a612   ; cada 8 cuadros
	and 007h		;a615   ; cada 8 cuadros
	ret nz			;a617
	ld a,(ix+030h)		;a618   ; el otro dibujo
	xor 004h		;a61b
	ld (ix+030h),a		;a61d
	ret			;a620
tipo_07_rapidez:		; DE = la rapidez de p03:A62C segun el nivel / 2
	ld hl,0a62ch		;a621   ; segun el nivel / 2
	ld a,(0e228h)		;a624   ; lee el nivel de dificultad
	srl a		;a627
	jp 04b67h		;a629   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)

; ----------------------------------------------------------------------
; DATOS tabla_A62C: 8 palabras que p03:A621 lee con 0xE228 / 2 (L_4B67); lo
;   leen p03:A629 (16 bytes)
;   0xa62c..0xa63c  (16 bytes)
DATA_tabla_A62C:
	defw 00280h,00280h,00280h,00300h,00300h,00380h,00400h,00400h	; a62c

; ======================================================================
; CODIGO 0xa63c..0xa70d  (209 bytes)
; ======================================================================


tipo_0b_empieza:		; el tipo 0x0B: desde X 0x0C, arriba o abajo (IX+25), 2 x 2, hacia la derecha (vx 0x0400)
	call 04e93h		;a63c   ; azar por nivel
	ld a,00ch		;a63f   ; desde X 0x0C
	ld (ix+006h),a		;a641
	ld b,000h		;a644
	ld a,(ix+004h)		;a646   ; arriba (0) o abajo (1)
	cp 060h		;a649
	jr c,L_A64E		;a64b
	inc b			;a64d
L_A64E:
	ld (ix+025h),b		;a64e
	ld (ix+013h),002h		;a651   ; 2 x 2
	ld (ix+014h),002h		;a655
L_A659:
	call 04f17h		;a659   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	ld de,00400h		;a65c   ; vx 0x0400
	jp 04f02h		;a65f   ; pon_vx: IX+09/IX+0A = DE
tipo_0b:		; el tipo 0x0B: un recorrido en 4 tramos (derecha, izquierda, diagonal...) segun la X; con 0xE20A dispara
	ld a,(0e20ah)		;a662   ; con 0xE20A dispara
	and a			;a665
	call nz,tipo_0b_dispara		;a666   ; tipo_0b_dispara: al acabar IX+15, dispara (p03:BB44) y otra espera al azar
	call tipo_0b_dibujo		;a669   ; su dibujo
	ld a,(ix+001h)		;a66c   ; el tramo
	dec a			;a66f
	jr z,L_A69F		;a670
	dec a			;a672
	jr z,L_A6C2		;a673
	dec a			;a675   ; paso 3
	jr z,L_A6E7		;a676
	dec a			;a678   ; paso 4: nada
	ret z			;a679
	ld bc,0b0b2h		;a67a   ; tramo 0: a la derecha hasta X 0xB0 (0xB2 abajo)
	ld a,(ix+025h)		;a67d
	and a			;a680
	jr z,L_A684		;a681
	ld b,c			;a683
L_A684:
	ld a,(ix+006h)		;a684
	cp b			;a687
	ret c			;a688
	inc (ix+001h)		;a689
	ld de,00400h		;a68c   ; luego en diagonal hacia el centro y a la izquierda
	ld a,(ix+025h)		;a68f
	and a			;a692
	call nz,05cadh		;a693   ; menos_de: DE = - DE
	call 04efbh		;a696   ; pon_vy: IX+07/IX+08 = DE
	ld de,0fc00h		;a699
	jp 04f02h		;a69c   ; pon_vx: IX+09/IX+0A = DE
L_A69F:
	ld bc,08c90h		;a69f   ; tramo 1: hasta X 0x8C (0x90 abajo)
	ld a,(ix+025h)		;a6a2   ; abajo, otro limite
	and a			;a6a5
	jr z,L_A6A9		;a6a6
	ld b,c			;a6a8
L_A6A9:
	ld a,(ix+006h)		;a6a9
	cp b			;a6ac
	ret nc			;a6ad
	ld a,(ix+004h)		;a6ae   ; a la rejilla y a la izquierda
	and 0f8h		;a6b1
	ld (ix+004h),a		;a6b3
	inc (ix+001h)		;a6b6
	call 04f17h		;a6b9   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	ld de,0fc00h		;a6bc
	jp 04f02h		;a6bf   ; pon_vx: IX+09/IX+0A = DE
L_A6C2:
	ld bc,05458h		;a6c2   ; tramo 2: hasta X 0x54 (0x58 abajo)
	ld a,(ix+025h)		;a6c5   ; abajo, otro limite
	and a			;a6c8
	jr z,L_A6CC		;a6c9
	ld b,c			;a6cb
L_A6CC:
	ld a,(ix+006h)		;a6cc
	cp b			;a6cf
	ret nc			;a6d0
	inc (ix+001h)		;a6d1
	ld de,00400h		;a6d4   ; diagonal y a la derecha
	ld a,(ix+025h)		;a6d7
	and a			;a6da
	call nz,05cadh		;a6db   ; menos_de: DE = - DE
	call 04efbh		;a6de   ; pon_vy: IX+07/IX+08 = DE
	ld de,00400h		;a6e1
	jp 04f02h		;a6e4   ; pon_vx: IX+09/IX+0A = DE
L_A6E7:
	ld bc,07478h		;a6e7   ; tramo 3: hasta X 0x74 (0x78 abajo)
	ld a,(ix+025h)		;a6ea   ; abajo, otro limite
	and a			;a6ed
	jr z,L_A6F1		;a6ee
	ld b,c			;a6f0
L_A6F1:
	ld a,(ix+006h)		;a6f1   ; hasta el limite
	cp b			;a6f4
	ret c			;a6f5
	ld a,(ix+004h)		;a6f6   ; a la rejilla y otra vez a la derecha
	and 0f8h		;a6f9
	ld (ix+004h),a		;a6fb
	inc (ix+001h)		;a6fe   ; al paso siguiente
	jp L_A659		;a701
tipo_0b_dibujo:		; la animacion de p03:A70D
	ld bc,00304h		;a704   ; 3 pasos, cada 4 cuadros
	ld hl,0a70dh		;a707
	jp 06361h		;a70a   ; anima: cada (0xE1C3 & B) = 0, IX+26 + 1 (de 0 a C - 1) y el dibujo IX+30 = IX+32 = HL[IX+26]

; ----------------------------------------------------------------------
; DATOS tabla_A70D: 4 bytes que p03:A704 pasa a L_6361 (BC = 0x0304); lo leen
;   p03:A707 (4 bytes)
;   0xa70d..0xa711  (4 bytes)
DATA_tabla_A70D:
	defb 021h,022h,023h,024h	; a70d

; ======================================================================
; CODIGO 0xa711..0xa741  (48 bytes)
; ======================================================================


tipo_0b_dispara:		; al acabar IX+15, dispara (p03:BB44) y otra espera al azar
	dec (ix+015h)		;a711
	ret nz			;a714
	call 04e93h		;a715   ; otra espera
	jp dispara_desde_ix		;a718   ; dispara_desde_ix: una bala desde el enemigo IX (X + 8) hacia la nave
tipo_30_empieza:		; el tipo 0x30: velocidad y aceleracion de una de 4 fichas de p03:A741 al azar
	ld (ix+024h),001h		;a71b   ; un paso
	call 04c24h		;a71f   ; una de 4 fichas de 6 bytes
	and 006h		;a722
	ld b,a			;a724
	add a,a			;a725
	add a,b			;a726
	ld hl,0a741h		;a727
	call 0407ah		;a72a   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;a72d   ; vy
	inc hl			;a72e
	ld d,(hl)			;a72f
	inc hl			;a730
	call 04efbh		;a731   ; pon_vy: IX+07/IX+08 = DE
	ld e,(hl)			;a734   ; vx
	inc hl			;a735
	ld d,(hl)			;a736
	inc hl			;a737
	call 04f02h		;a738   ; pon_vx: IX+09/IX+0A = DE
	ld e,(hl)			;a73b   ; la aceleracion
	inc hl			;a73c
	ld d,(hl)			;a73d
	jp 062a8h		;a73e   ; pon_aceleracion: IX+20/IX+21 = DE

; ----------------------------------------------------------------------
; DATOS tabla_A741: 4 fichas de 6 bytes que p03:A71B elige con L_4C24 & 6; lo
;   leen p03:A72A (24 bytes)
;   0xa741..0xa759  (24 bytes)
DATA_tabla_A741:
	defb 000h,0fah,080h,0feh,080h,000h	; a741
	defb 000h,0f8h,000h,0feh,080h,000h	; a747
	defb 000h,0fah,000h,003h,080h,000h	; a74d
	defb 000h,0f8h,000h,0ffh,080h,000h	; a753

; ======================================================================
; CODIGO 0xa759..0xa879  (288 bytes)
; ======================================================================


nave_sale:		; la nave se va hacia la derecha con la velocidad 0xE3C7
	ld bc,(0e3c7h)		;a759   ; la velocidad de salida
	ld de,00000h		;a75d
	call mueve_la_nave		;a760   ; mueve_la_nave: Y (0xE403-0xE404) + DE y X (0xE405-0xE406) + BC
	jr dibujo_de_la_nave		;a763
cuadro_de_la_nave:		; la nave: los mandos, se mueve, sus limites y su dibujo; al caer, la explosion; entrando al jefe o saliendo del interior, sin mandos
	ld a,(0e3d0h)		;a765   ; con 0xE3D0, nada
	or a			;a768
	ret nz			;a769
	ld a,(0e400h)		;a76a   ; cayendo: la explosion
	or a			;a76d
	jp m,explosion_de_la_nave		;a76e   ; explosion_de_la_nave: cada 0xE44F cuadros el paso siguiente de la explosion (0xE44E); al cuarto, la vida se acaba
	ret z			;a771   ; sin nave, nada
	ld a,(0e22bh)		;a772   ; entrando en el jefe, sin mandos
	or a			;a775
	jr nz,dibujo_de_la_nave		;a776
	ld a,(0e3bfh)		;a778   ; saliendo del interior
	or a			;a77b
	jr nz,nave_sale		;a77c
	ld a,(0e3c0h)		;a77e   ; en el final del interior, nada
	or a			;a781
	ret nz			;a782
	call mandos_a_velocidad		;a783   ; los mandos
	call mueve_la_nave		;a786   ; se mueve
	call limites_de_la_nave		;a789   ; y sus limites
dibujo_de_la_nave:		; los dos sprites de la nave (0xE407-0xE40A) de su ficha (p03:A889, A895, A8AD o el pinguino)
	call ficha_de_la_nave		;a78c   ; la ficha de su forma
	ld a,(0e400h)		;a78f   ; el R.DRILL no mira los mandos
	cp 003h		;a792
	jp z,L_A7BE		;a794
	ld bc,0e1c9h		;a797   ; los mandos
dibujo_segun_mandos:		; la ficha de la nave segun arriba/abajo (0xE1C9 bits 0-1) y, con escudo, el parpadeo; con Penguin Adventure, el pinguino
	ld a,(0f0f5h)		;a79a   ; con Penguin Adventure, el pinguino
	bit 2,a		;a79d
	jr nz,dibujo_del_pinguino		;a79f
	ld a,(bc)			;a7a1   ; arriba y abajo
	and 003h		;a7a2
	cp 003h		;a7a4   ; los dos a la vez: recta
	jp nz,L_A7AA		;a7a6
	xor a			;a7a9
L_A7AA:
	add a,a			;a7aa   ; 4 bytes por dibujo
	add a,a			;a7ab
	ld c,a			;a7ac   ; C = 4 x direccion
	ld a,(0e400h)		;a7ad   ; con escudo, cada 4 cuadros los otros 3
	dec a			;a7b0
	jr z,L_A7BE		;a7b1
	ld a,(0e1c3h)		;a7b3   ; lee la cuenta de cuadros
	and 004h		;a7b6
	jr z,L_A7BE		;a7b8
	ld a,c			;a7ba   ; el otro juego de dibujos
	add a,00ch		;a7bb
	ld c,a			;a7bd
L_A7BE:
	ld b,000h		;a7be
	add hl,bc			;a7c0
pon_dibujo_de_nave:		; copia 4 bytes de la ficha HL a 0xE407; con un golpe de escudo, parpadea (color 6/9); intocable, color 3
	ld de,0e407h		;a7c1   ; los dos sprites de la nave
	ldi		;a7c4   ; dibujo y color del primero
	ldi		;a7c6
	ldi		;a7c8   ; dibujo y color del segundo
	ldi		;a7ca
	ld a,(0e400h)		;a7cc   ; con escudo de un golpe
	cp 002h		;a7cf
	jr nz,L_A7E7		;a7d1
	ld a,(0e401h)		;a7d3   ; lee los golpes que le quedan al escudo
	dec a			;a7d6
	jr nz,L_A7E7		;a7d7
	ld a,(0e1c3h)		;a7d9   ; parpadea: 6 o 9
	bit 1,a		;a7dc
	ld a,006h		;a7de   ; 6
	jr z,L_A7E4		;a7e0
	ld a,009h		;a7e2   ; o 9
L_A7E4:
	ld (0e40ah),a		;a7e4   ; guarda el color del segundo sprite de la nave
L_A7E7:
	ld a,(0e446h)		;a7e7   ; intocable?
	or a			;a7ea
	ret z			;a7eb
nave_intocable:		; el color del primer sprite, 3
	ld a,003h		;a7ec
	ld (0e408h),a		;a7ee   ; guarda el color del primer sprite de la nave
	ret			;a7f1
dibujo_r_drill:		; la primera ficha del R.DRILL (p03:A8AD)
	ld hl,0a8adh		;a7f2
	jp pon_dibujo_de_nave		;a7f5   ; pon_dibujo_de_nave: copia 4 bytes de la ficha HL a 0xE407; con un golpe de escudo, parpadea (color 6/9); intocable, color 3
dibujo_del_pinguino:		; el pinguino: su ficha y el color del segundo sprite (10 R.DRILL, 2/6/9 con escudo)
	ld de,0e407h		;a7f8   ; los dos sprites del pinguino
	ldi		;a7fb   ; dibujo y color del primero
	ldi		;a7fd
	ldi		;a7ff   ; dibujo y color del segundo
	ldi		;a801
	ld a,(0e446h)		;a803   ; lee la marca de nave intocable
	or a			;a806
	jr nz,nave_intocable		;a807
	ld a,(0e400h)		;a809   ; R.DRILL: 10
	ld b,00ah		;a80c
	cp 003h		;a80e   ; el R.DRILL
	jr z,L_A828		;a810
	cp 002h		;a812   ; con escudo
	ret nz			;a814
	ld a,(0e401h)		;a815   ; de mas de un golpe: 2
	dec a			;a818
	ld b,002h		;a819
	jr nz,L_A828		;a81b   ; mas de un golpe
	ld a,(0e1c3h)		;a81d   ; de uno: parpadea 6/9
	bit 1,a		;a820
	ld b,006h		;a822
	jr z,L_A828		;a824
	ld b,009h		;a826
L_A828:
	ld a,b			;a828
	ld (0e40ah),a		;a829   ; guarda el color del segundo sprite de la nave
	jr L_A7E7		;a82c
ficha_de_la_nave:		; HL (y C) = la ficha de la forma: normal p03:A889, escudo p03:A895, R.DRILL p03:A8AD (gira cada 3 cuadros), pinguino p03:A879/A881 por jugador
	ld a,(0e400h)		;a82e   ; la forma
	cp 003h		;a831
	jr z,L_A846		;a833
	ld b,a			;a835
	ld a,(0f0f5h)		;a836   ; con Penguin Adventure, el pinguino
	bit 2,a		;a839
	jr nz,L_A862		;a83b
	dec b			;a83d
	ld hl,0a889h		;a83e   ; 1: normal
	ret z			;a841
	ld hl,0a895h		;a842   ; 2: con escudo
	ret			;a845
L_A846:
	ld hl,0e440h		;a846   ; R.DRILL: cada 3 cuadros
	dec (hl)			;a849   ; la espera
	jr nz,L_A85E		;a84a
	ld (hl),003h		;a84c   ; 3 cuadros
	inc l			;a84e
	inc (hl)			;a84f   ; el paso siguiente del giro
	ld a,(hl)			;a850
	cp 006h		;a851
	jr c,L_A857		;a853   ; 6 pasos
	xor a			;a855   ; 6 pasos
	ld (hl),a			;a856
L_A857:
	ld hl,0a8adh		;a857   ; 4 bytes por paso
	add a,a			;a85a   ; 4 bytes por paso
	add a,a			;a85b
	ld c,a			;a85c
	ret			;a85d
L_A85E:
	inc l			;a85e
	ld a,(hl)			;a85f
	jr L_A857		;a860
L_A862:
	ld a,(0e1c2h)		;a862   ; el jugador 1 o el 2
	add a,a			;a865   ; el jugador 1
	ld hl,0a879h		;a866
	jr nc,L_A86E		;a869
	ld hl,0a881h		;a86b   ; o el 2
L_A86E:
	ld a,(0e1c3h)		;a86e   ; cada 8 cuadros, el otro dibujo
	bit 3,a		;a871
	ret z			;a873
	ld de,00004h		;a874   ; el otro dibujo
	add hl,de			;a877
	ret			;a878

; ----------------------------------------------------------------------
; DATOS fichas_E407: fichas de 4 bytes que p03:A7C1 copia a 0xE407: 0xA879 y
;   0xA881 (2 cada una, segun el bit 7 de 0xE1C2 y el 3 de 0xE1C3), 0xA889
;   (3), 0xA895 (6) y 0xA8AD (6, una por paso de 0xE441); lo leen p03:A7C1 (76
;   bytes)
;   0xa879..0xa8c5  (76 bytes)
DATA_fichas_E407:
	defb 000h,00fh,004h,004h	; a879
	defb 008h,00fh,00ch,004h	; a87d
	defb 000h,00fh,004h,00dh	; a881
	defb 008h,00fh,00ch,00dh	; a885
	defb 000h,00fh,004h,008h	; a889
	defb 010h,00fh,014h,005h	; a88d
	defb 008h,00fh,00ch,008h	; a891
	defb 000h,00fh,02ch,00fh	; a895
	defb 000h,00fh,02ch,00fh	; a899
	defb 008h,00fh,034h,00fh	; a89d
	defb 000h,00fh,030h,007h	; a8a1
	defb 000h,00fh,030h,007h	; a8a5
	defb 008h,00fh,038h,007h	; a8a9
	defb 000h,009h,004h,00fh	; a8ad
	defb 008h,009h,00ch,00fh	; a8b1
	defb 010h,009h,014h,00fh	; a8b5
	defb 02ch,00fh,030h,005h	; a8b9
	defb 00ch,005h,000h,000h	; a8bd
	defb 034h,00fh,038h,005h	; a8c1

; ======================================================================
; CODIGO 0xa8c5..0xa94e  (137 bytes)
; ======================================================================


limites_de_la_nave:		; X entre 8 y 0xD8; Y entre 0 y 0xA5 (de 3 a 0xA5 en las fases 1-3)
	ld hl,0e406h		;a8c5   ; la X
	ld a,(hl)			;a8c8
	cp 008h		;a8c9
	jr nc,L_A8CF		;a8cb
	ld a,008h		;a8cd   ; como poco 8
L_A8CF:
	cp 0d9h		;a8cf
	jr c,L_A8D5		;a8d1
	ld a,0d8h		;a8d3   ; como mucho 0xD8
L_A8D5:
	ld (hl),a			;a8d5   ; la X
	dec l			;a8d6   ; la Y
	dec l			;a8d7
	ld a,(hl)			;a8d8   ; mas 16
	add a,010h		;a8d9
	ld c,a			;a8db
	ld a,(0e201h)		;a8dc   ; en las fases 1-3, desde 0x13
	or a			;a8df
	jr z,L_A8F7		;a8e0
	cp 004h		;a8e2   ; fases 1-3
	jr nc,L_A8F7		;a8e4
	ld a,c			;a8e6   ; como poco 0x13
	cp 013h		;a8e7
	jr nc,L_A8ED		;a8e9
	ld a,013h		;a8eb
L_A8ED:
	cp 0b6h		;a8ed   ; hasta 0xB5
	jr c,L_A8F3		;a8ef
	ld a,0b5h		;a8f1
L_A8F3:
	sub 010h		;a8f3   ; menos 16
	ld (hl),a			;a8f5
	ret			;a8f6
L_A8F7:
	ld a,c			;a8f7   ; en las demas, desde 0x10
	cp 010h		;a8f8
	jp nc,L_A8FF		;a8fa
	ld a,010h		;a8fd   ; como poco 0x10
L_A8FF:
	jp L_A8ED		;a8ff
mandos_a_velocidad:		; DE (Y) y BC (X) = el paso de la direccion de los mandos (p03:A94E) x (velocidad 0xE402 + 3)
	ld a,(0e1c9h)		;a902   ; la direccion de los mandos
	and 00fh		;a905   ; los 4 bits de direccion
	add a,a			;a907   ; 4 bytes por direccion
	add a,a			;a908
	ld c,a			;a909
	ld b,000h		;a90a
	ld hl,0a94eh		;a90c   ; 4 bytes por direccion en p03:A94E
	add hl,bc			;a90f
	ld e,(hl)			;a910   ; el paso Y
	inc hl			;a911
	ld d,(hl)			;a912
	inc hl			;a913
	ld c,(hl)			;a914   ; el paso X
	inc hl			;a915
	ld b,(hl)			;a916
	ld (0f002h),bc		;a917   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld a,(0e402h)		;a91b   ; la velocidad + 3
	add a,003h		;a91e
	ld (0f000h),a		;a920   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld b,a			;a923   ; B = la velocidad + 3
	ld l,e			;a924   ; DE x B
	ld h,d			;a925
L_A926:
	add hl,de			;a926   ; DE = el paso Y x velocidad
	djnz L_A926		;a927
	ld (0f004h),hl		;a929   ; 0xF004 = el paso Y total
	ld hl,(0f002h)		;a92c   ; lee variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld e,l			;a92f   ; BC x B
	ld d,h			;a930
	ld a,(0f000h)		;a931   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld b,a			;a934
L_A935:
	add hl,de			;a935   ; BC = el paso X x velocidad
	djnz L_A935		;a936
	ld c,l			;a938
	ld b,h			;a939
	ld de,(0f004h)		;a93a   ; lee variable de paso y el byte siguiente (16 bits)
	ret			;a93e
mueve_la_nave:		; Y (0xE403-0xE404) + DE y X (0xE405-0xE406) + BC
	ld hl,(0e403h)		;a93f   ; la Y
	add hl,de			;a942
	ld (0e403h),hl		;a943   ; guarda la Y de la nave (16 bits) y el byte siguiente (16 bits)
	ld hl,(0e405h)		;a946   ; la X
	add hl,bc			;a949
	ld (0e405h),hl		;a94a   ; guarda la X de la nave (16 bits) y el byte siguiente (16 bits)
	ret			;a94d

; ----------------------------------------------------------------------
; DATOS tabla_A94E: 16 fichas de 4 bytes que p03:A902 lee con 0xE1C9 & 0x0F;
;   lo leen p03:A90C (64 bytes)
;   0xa94e..0xa98e  (64 bytes)
DATA_tabla_A94E:
	defb 000h,000h,000h,000h	; a94e
	defb 080h,0ffh,000h,000h	; a952
	defb 080h,000h,000h,000h	; a956
	defb 000h,000h,000h,000h	; a95a
	defb 000h,000h,080h,0ffh	; a95e
	defb 080h,0ffh,080h,0ffh	; a962
	defb 080h,000h,080h,0ffh	; a966
	defb 000h,000h,080h,0ffh	; a96a
	defb 000h,000h,080h,000h	; a96e
	defb 080h,0ffh,080h,000h	; a972
	defb 080h,000h,080h,000h	; a976
	defb 000h,000h,080h,000h	; a97a
	defb 000h,000h,000h,000h	; a97e
	defb 080h,0ffh,000h,000h	; a982
	defb 080h,000h,000h,000h	; a986
	defb 000h,000h,000h,000h	; a98a

; ======================================================================
; CODIGO 0xa98e..0xa9f4  (102 bytes)
; ======================================================================


vida_acabada:		; 0xE1D3 = 0: la nave ha caido del todo
	xor a			;a98e
	ld (0e1d3h),a		;a98f   ; guarda la marca de vida en marcha (0: la nave ha caido)
	ret			;a992
nave_explota:		; la nave cae: 0xE400 = 0xFF, sin opciones, la explosion desde el paso 0 y los dibujos de siempre
	ld hl,0e400h		;a993   ; ya cayendo, nada
	ld a,(hl)			;a996
	or a			;a997
	ret m			;a998
	xor a			;a999   ; el paso 0 de la explosion
	ld (0e44eh),a		;a99a   ; guarda el paso de la explosion de la nave
	dec a			;a99d   ; 0xE400 = 0xFF
	ld (hl),a			;a99e
	ld (0e410h),a		;a99f   ; sin opciones
	ld (0e420h),a		;a9a2   ; guarda la segunda opcion (16 bytes)
	xor a			;a9a5
	call paso_de_explosion		;a9a6   ; paso_de_explosion: el paso A (p03:A9F4): su espera y los 4 sprites alrededor de la nave (0xE418, 0xE41C, 0xE428, 0xE42C)
	jp 042ddh		;a9a9   ; los dibujos de siempre
explosion_de_la_nave:		; cada 0xE44F cuadros el paso siguiente de la explosion (0xE44E); al cuarto, la vida se acaba
	ld hl,0e44fh		;a9ac   ; la espera
	dec (hl)			;a9af
	ret nz			;a9b0
	dec l			;a9b1   ; el paso siguiente
	inc (hl)			;a9b2
	ld a,(hl)			;a9b3
	cp 004h		;a9b4   ; al cuarto se acaba
	jr nc,vida_acabada		;a9b6
paso_de_explosion:		; el paso A (p03:A9F4): su espera y los 4 sprites alrededor de la nave (0xE418, 0xE41C, 0xE428, 0xE42C)
	ld hl,0a9f4h		;a9b8   ; la ficha del paso
	call 04b67h		;a9bb   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;a9be
	ld a,(hl)			;a9bf   ; su espera
	ld (0e44fh),a		;a9c0   ; guarda la espera del paso de la explosion
	inc hl			;a9c3
	ld a,(0e404h)		;a9c4   ; alrededor de la nave
	ld c,a			;a9c7
	ld a,(0e406h)		;a9c8   ; lee la X de la nave
	ld b,a			;a9cb
	ld de,0e418h		;a9cc   ; 4 sprites
	call sprite_relativo		;a9cf   ; sprite_relativo: un sprite: Y y X sumadas a C y B, dibujo y color, de HL a DE
	ld de,0e41ch		;a9d2
	call sprite_relativo		;a9d5   ; sprite_relativo: un sprite: Y y X sumadas a C y B, dibujo y color, de HL a DE
	ld de,0e428h		;a9d8
	call sprite_relativo		;a9db   ; sprite_relativo: un sprite: Y y X sumadas a C y B, dibujo y color, de HL a DE
	ld de,0e42ch		;a9de
sprite_relativo:		; un sprite: Y y X sumadas a C y B, dibujo y color, de HL a DE
	ld a,(hl)			;a9e1   ; Y + C
	add a,c			;a9e2
	ld (de),a			;a9e3   ; la Y
	inc hl			;a9e4
	inc de			;a9e5
	ld a,(hl)			;a9e6   ; X + B
	add a,b			;a9e7
	ld (de),a			;a9e8   ; la X
	inc hl			;a9e9
	inc de			;a9ea
	ld a,(hl)			;a9eb   ; dibujo y color
	ld (de),a			;a9ec   ; el dibujo
	inc hl			;a9ed
	inc de			;a9ee
	ld a,(hl)			;a9ef
	ld (de),a			;a9f0   ; el color
	inc hl			;a9f1
	inc de			;a9f2
	ret			;a9f3

; ----------------------------------------------------------------------
; DATOS tabla_A9F4: 4 punteros (0xE44E de 0 a 3) que p03:A9B8 lee con L_4B67;
;   lo leen p03:A9BB (8 bytes)
;   0xa9f4..0xa9fc  (8 bytes)
DATA_tabla_A9F4:
	defw 0aa1eh,0a9fch,0aa0dh,0aa1eh	; a9f4  -> 0xaa1e DATA_fichas_A9FC 0xaa0d 0xaa1e

; ----------------------------------------------------------------------
; DATOS fichas_A9FC: 3 fichas de 17 bytes: la cuenta (a 0xE44F) y cuatro
;   grupos de 4 que p03:A9E1 suma a la posicion y copia a 0xE418, 0xE41C,
;   0xE428 y 0xE42C; lo leen p03:A9BF (51 bytes)
;   0xa9fc..0xaa2f  (51 bytes)
DATA_fichas_A9FC:
	defb 014h,000h,000h,010h,009h,000h,000h,014h,00fh,000h,0f8h,00ch,006h,000h,008h,03ch,006h	; a9fc  ...............<.
	defb 00ah,000h,000h,004h,009h,000h,000h,008h,00fh,000h,0f8h,000h,006h,000h,008h,038h,006h	; aa0d  ...............8.
	defb 00ah,000h,000h,034h,00fh,000h,000h,030h,009h,000h,000h,02ch,006h,000h,000h,02ch,006h	; aa1e  ...4...0...,...,.

; ======================================================================
; CODIGO 0xaa2f..0xaa93  (100 bytes)
; ======================================================================


rastro_a_la_nave:		; las 16 posiciones del rastro (0xE450) en la nave y 0xE40E = 0
	ld de,0e450h		;aa2f   ; 16 posiciones
	ld a,010h		;aa32
L_AA34:
	ld hl,0e404h		;aa34   ; Y y X de la nave
	ldi		;aa37   ; la Y
	inc l			;aa39
	ldi		;aa3a   ; la X
	dec a			;aa3c
	jr nz,L_AA34		;aa3d
	ld (0e40eh),a		;aa3f   ; el paso 0
	ret			;aa42
pon_opcion:		; enciende la opcion nueva (0xE410 la primera, 0xE420 la segunda) y la pone en el rastro
	ld a,(0e40bh)		;aa43   ; la opcion 1 o la 2
	dec a			;aa46
	ld hl,0e410h		;aa47   ; apunta a la primera opcion (16 bytes)
	jr z,L_AA4E		;aa4a
	ld l,020h		;aa4c
L_AA4E:
	ld (hl),001h		;aa4e   ; encendida
	jp opciones_al_rastro		;aa50   ; opciones_al_rastro: la primera opcion a 8 pasos del rastro y la segunda a 16
anima_opciones:		; cada 2 cuadros (4 con el pinguino) el dibujo siguiente de las opciones (p03:AA93)
	ld a,(0e400h)		;aa53   ; sin nave, nada
	dec a			;aa56
	ret m			;aa57
	ld a,(0e40bh)		;aa58   ; sin opciones, nada
	or a			;aa5b
	ret z			;aa5c
	ld a,(0f0f5h)		;aa5d   ; cada 2 cuadros, 4 con el pinguino
	bit 2,a		;aa60
	ld b,002h		;aa62
	jr z,L_AA68		;aa64
	ld b,004h		;aa66
L_AA68:
	ld hl,0e40ch		;aa68   ; apunta a la espera del dibujo de las opciones
	inc (hl)			;aa6b
	ld a,(hl)			;aa6c
	cp b			;aa6d
	ret c			;aa6e
	ld (hl),000h		;aa6f   ; el paso siguiente
	inc l			;aa71
	inc (hl)			;aa72
	ld a,(0e40bh)		;aa73   ; la segunda opcion
	dec a			;aa76
	jr z,L_AA7F		;aa77
	ld de,0e427h		;aa79
	call dibujo_de_opcion		;aa7c   ; dibujo_de_opcion: el dibujo de p03:AA93 que toca, a DE
L_AA7F:
	ld de,0e417h		;aa7f   ; la primera
dibujo_de_opcion:		; el dibujo de p03:AA93 que toca, a DE
	ld a,(0e40dh)		;aa82   ; 4 pasos
	and 003h		;aa85
	add a,a			;aa87
	ld hl,0aa93h		;aa88
	call 0407ah		;aa8b   ; hl_mas_a: HL = HL + A
	ldi		;aa8e
	ldi		;aa90
	ret			;aa92

; ----------------------------------------------------------------------
; DATOS tabla_AA93: 4 pares que p03:AA82 lee con 0xE40D & 3 y copia a DE; lo
;   leen p03:AA8B (8 bytes)
;   0xaa93..0xaa9b  (8 bytes)
DATA_tabla_AA93:
	defb 03ch,00ah	; aa93
	defb 03ch,009h	; aa95
	defb 040h,008h	; aa97
	defb 040h,006h	; aa99

; ======================================================================
; CODIGO 0xaa9b..0xab72  (215 bytes)
; ======================================================================


rastro_de_la_nave:		; si la nave se mueve, su posicion entra en el rastro (16, 0xE450) y las opciones la siguen 8 y 16 pasos atras
	ld a,(0e400h)		;aa9b   ; sin nave, nada
	dec a			;aa9e
	ret m			;aa9f
	ld a,(0e3d0h)		;aaa0   ; ni con 0xE3D0
	or a			;aaa3
	ret nz			;aaa4
	ld a,(0e22bh)		;aaa5   ; ni entrando al jefe
	or a			;aaa8
	ret nz			;aaa9
	ld a,(0e439h)		;aaaa   ; con la capsula 3, las opciones giran
	cp 003h		;aaad
	ret z			;aaaf
	ld hl,0e3c2h		;aab0   ; en el final, los mandos de la nave al centro
	ld a,(0e3c0h)		;aab3   ; lee el paso del final del interior (0 nada)
	or a			;aab6
	jr nz,L_AAC2		;aab7
	ld a,(0e3bfh)		;aab9   ; lee la marca de la nave yendose
	or a			;aabc
	jr nz,L_AAC2		;aabd
	ld hl,0e1c9h		;aabf   ; si no, los del jugador
L_AAC2:
	ld a,(hl)			;aac2   ; sin moverse, el rastro no avanza
	and 00fh		;aac3
	ret z			;aac5
	cp 003h		;aac6   ; arriba y abajo a la vez
	ret z			;aac8
	cp 00ch		;aac9   ; izquierda y derecha a la vez
	ret z			;aacb
	cp 00fh		;aacc
	ret z			;aace
	ld hl,0e450h		;aacf   ; el paso del rastro
	ld a,(0e40eh)		;aad2   ; lee el paso del rastro (0-15)
	add a,a			;aad5
	add a,l			;aad6
	ld l,a			;aad7
	ld a,(0e404h)		;aad8   ; la posicion de la nave
	ld (hl),a			;aadb
	ld a,(0e406h)		;aadc   ; lee la X de la nave
	inc l			;aadf
	ld (hl),a			;aae0
	ld hl,0e40eh		;aae1   ; el paso siguiente
	inc (hl)			;aae4
	ld a,(hl)			;aae5
	cp 010h		;aae6
	jr c,opciones_al_rastro		;aae8
	ld (hl),000h		;aaea   ; 16 pasos
opciones_al_rastro:		; la primera opcion a 8 pasos del rastro y la segunda a 16
	ld hl,0e40eh		;aaec   ; apunta a el paso del rastro (0-15)
	ld a,(0e40bh)		;aaef   ; sin opciones, nada
	dec a			;aaf2
	ret m			;aaf3
	jr z,L_AAFD		;aaf4
	ld bc,0e424h		;aaf6   ; la segunda, en el paso de ahora (16 atras)
	ld a,(hl)			;aaf9
	call opcion_en_el_rastro		;aafa   ; opcion_en_el_rastro: la Y y la X del paso A del rastro a la opcion BC
L_AAFD:
	ld bc,0e414h		;aafd   ; la primera, 8 pasos atras
	ld a,(hl)			;ab00
	sub 008h		;ab01   ; 8 pasos atras
	jr nc,opcion_en_el_rastro		;ab03
	add a,010h		;ab05   ; dando la vuelta
opcion_en_el_rastro:		; la Y y la X del paso A del rastro a la opcion BC
	add a,a			;ab07   ; 2 bytes por paso
	ld de,0e450h		;ab08   ; apunta a el rastro de la nave: 16 posiciones [Y][X]
	add a,e			;ab0b
	ld e,a			;ab0c
	ld a,(de)			;ab0d   ; la Y
	ld (bc),a			;ab0e
	inc e			;ab0f
	inc c			;ab10
	inc c			;ab11
	ld a,(de)			;ab12   ; la X
	ld (bc),a			;ab13
	ret			;ab14
opciones_giran:		; con la capsula 3, las opciones giran alrededor de la nave (16 posiciones de p03:AB72)
	ld a,(0e400h)		;ab15   ; sin nave, nada
	dec a			;ab18
	ret m			;ab19
	ld a,(0e439h)		;ab1a   ; solo con la capsula 3
	cp 003h		;ab1d
	ret nz			;ab1f
	ld a,(0e40bh)		;ab20   ; sin opciones, nada
	dec a			;ab23
	ret m			;ab24
	jr z,L_AB34		;ab25
	exx			;ab27   ; la segunda, en la posicion del cuadro
	ld hl,0e424h		;ab28   ; apunta a la Y de la segunda opcion
	exx			;ab2b
	ld a,(0e1c3h)		;ab2c   ; lee la cuenta de cuadros
	and 00fh		;ab2f
	call opcion_alrededor		;ab31   ; opcion_alrededor: la opcion HL' en la posicion A (p03:AB72) alrededor de la nave, sin salirse
L_AB34:
	exx			;ab34   ; la primera, en la opuesta
	ld hl,0e414h		;ab35   ; apunta a la Y de la primera opcion
	exx			;ab38
	ld a,(0e1c3h)		;ab39   ; lee la cuenta de cuadros
	and 00fh		;ab3c
	sub 008h		;ab3e
	jr nc,opcion_alrededor		;ab40
	add a,010h		;ab42
opcion_alrededor:		; la opcion HL' en la posicion A (p03:AB72) alrededor de la nave, sin salirse
	ld hl,0e404h		;ab44   ; la nave
	ld de,0ab72h		;ab47   ; 2 bytes por posicion
	add a,a			;ab4a
	call 0407fh		;ab4b   ; de_mas_a: DE = DE + A
	ld a,(de)			;ab4e   ; la Y de la nave + el desplazamiento
	add a,(hl)			;ab4f
	inc l			;ab50
	inc l			;ab51
	exx			;ab52
	ld (hl),a			;ab53
	inc l			;ab54
	inc l			;ab55
	exx			;ab56
	inc de			;ab57   ; el desplazamiento X
	ld a,(de)			;ab58
	or a			;ab59
	jp p,L_AB69		;ab5a
	neg		;ab5d   ; a la izquierda, sin bajar de 0
	ld d,a			;ab5f
	ld a,(hl)			;ab60
	sub d			;ab61
	jr nc,L_AB65		;ab62
	xor a			;ab64
L_AB65:
	exx			;ab65
	ld (hl),a			;ab66   ; la X de la opcion
	exx			;ab67
	ret			;ab68
L_AB69:
	ld a,(de)			;ab69   ; a la derecha, sin pasar de 0xF8
	add a,(hl)			;ab6a
	jr nc,L_AB65		;ab6b
	ld a,0f8h		;ab6d   ; como mucho 0xF8
	jp L_AB65		;ab6f

; ----------------------------------------------------------------------
; DATOS tabla_AB72: 16 pares (dx, dy) que p03:AB39 lee con 0xE1C3 & 0x0F, y
;   suma a 0xE404; lo leen p03:AB4B (32 bytes)
;   0xab72..0xab92  (32 bytes)
DATA_tabla_AB72:
	defb 0e0h,000h	; ab72
	defb 0e3h,00ch	; ab74
	defb 0eah,016h	; ab76
	defb 0f4h,01dh	; ab78
	defb 000h,020h	; ab7a
	defb 00ch,01dh	; ab7c
	defb 016h,016h	; ab7e
	defb 01dh,00ch	; ab80
	defb 020h,000h	; ab82
	defb 01dh,0f4h	; ab84
	defb 016h,0eah	; ab86
	defb 00ch,0e3h	; ab88
	defb 000h,0e0h	; ab8a
	defb 0f4h,0e3h	; ab8c
	defb 0eah,0eah	; ab8e
	defb 0e3h,0f4h	; ab90

; ======================================================================
; CODIGO 0xab92..0xabc2  (48 bytes)
; ======================================================================


mueve_disparos_de_la_nave:		; los 9 disparos de 0xE470: lo de su tipo (p03:ABC2); los 7, 8 y 10-13 ademas su largo en pixeles
	ld iy,0e470h		;ab92   ; 9 disparos
	ld b,009h		;ab96
L_AB98:
	push bc			;ab98
	call disparo_por_tipo_b		;ab99   ; disparo_por_tipo_b: la rutina del tipo IY+00
	ld bc,00010h		;ab9c
	add iy,bc		;ab9f
	pop bc			;aba1   ; el siguiente
	djnz L_AB98		;aba2
	ret			;aba4
disparo_por_tipo_b:		; la rutina del tipo IY+00
	ld a,(iy+000h)		;aba5   ; libre
	or a			;aba8
	ret z			;aba9
	ld b,a			;abaa
	sub 007h		;abab   ; los tipos 1-6, 9, 14 y 15
	jr c,L_ABBD		;abad   ; los 1-6
	sub 002h		;abaf
	jr z,L_ABBD		;abb1   ; el 9
	sub 005h		;abb3
	cp 002h		;abb5
	jr c,L_ABBD		;abb7   ; los 14 y 15
	ld hl,082feh		;abb9   ; los demas, al acabar su largo en pixeles
	push hl			;abbc
L_ABBD:
	ld a,b			;abbd   ; por tipo
	dec a			;abbe
	call 04084h		;abbf   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_ABC2: 15 destinos del despachador p00:4084 (call en p03:ABBF, el
;   indice en A): ACD4, ACE0, AD1F, B0FB, B0FB, B1AF, AE07, AE85, AF37, AEB7,
;   AECB, AEDB, AEFE, AFA7, B029; lo leen p03:ABBF (30 bytes)
;   0xabc2..0xabe0  (30 bytes)
DATA_tabla_ABC2:
	defw 0acd4h,0ace0h,0ad1fh,0b0fbh,0b0fbh,0b1afh,0ae07h,0ae85h	; abc2
	defw 0af37h,0aeb7h,0aecbh,0aedbh,0aefeh,0afa7h,0b029h	; abd2

; ======================================================================
; CODIGO 0xabe0..0xb1f0  (1552 bytes)
; ======================================================================


sin_autodisparo:		; 0xE437 = 0
	xor a			;abe0
	ld (0e437h),a		;abe1   ; guarda la cuenta del autodisparo (15 cuadros)
	ret			;abe4
dispara_la_nave:		; con el disparo recien pulsado, o cada 15 cuadros si se mantiene, disparan la nave y sus opciones (p03:AC30)
	ld a,(0e400h)		;abe5   ; sin nave, nada
	dec a			;abe8
	ret m			;abe9
	ld a,(0e3d0h)		;abea   ; ni con 0xE3D0, entrando al jefe o en el final
	or a			;abed
	ret nz			;abee
	ld a,(0e22bh)		;abef   ; lee la marca de jefe vencido: al interior
	or a			;abf2
	ret nz			;abf3
	ld a,(0e3c0h)		;abf4   ; lee el paso del final del interior (0 nada)
	or a			;abf7
	ret nz			;abf8
	ld a,(0e1c8h)		;abf9   ; recien pulsado: dispara
	and 010h		;abfc
	jr nz,L_AC0F		;abfe
	ld a,(0e1c9h)		;ac00   ; sin pulsar, nada
	and 010h		;ac03
	jr z,sin_autodisparo		;ac05
	ld hl,0e437h		;ac07   ; mantenido: cada 15 cuadros
	inc (hl)			;ac0a
	ld a,(hl)			;ac0b
	cp 00fh		;ac0c
	ret c			;ac0e
L_AC0F:
	call sin_autodisparo		;ac0f   ; sin_autodisparo: 0xE437 = 0
	ld ix,0e400h		;ac12   ; la nave y las dos opciones
	exx			;ac16
	ld de,00300h		;ac17   ; 3, con E' de 0x20 en 0x20
L_AC1A:
	exx			;ac1a
	ld a,(ix+000h)		;ac1b   ; solo las que estan
	or a			;ac1e
	call nz,dispara_uno		;ac1f   ; dispara_uno: la nave o la opcion IX dispara cada arma que tiene: con VECTOR (0xE439 = 7) a su manera; el misil, el doble y el laser siempre
	ld bc,00010h		;ac22
	add ix,bc		;ac25
	exx			;ac27
	ld a,e			;ac28   ; la ficha de la siguiente: 0x20 mas alla
	add a,020h		;ac29
	ld e,a			;ac2b
	dec d			;ac2c   ; 3
	jr nz,L_AC1A		;ac2d
	ret			;ac2f
dispara_uno:		; la nave o la opcion IX dispara cada arma que tiene: con VECTOR (0xE439 = 7) a su manera; el misil, el doble y el laser siempre
	ld a,(0e439h)		;ac30   ; VECTOR (capsula 7)?
	cp 007h		;ac33
	push af			;ac35
	call z,dispara_vector		;ac36   ; dispara_vector: con VECTOR (capsula 7), un tipo 9 en 0xE470, en la rejilla, dibujo 0xF2, 16 x 16; suena 0x1D
	pop af			;ac39
	jr z,L_AC58		;ac3a
	ld a,(0e430h)		;ac3c   ; el disparo normal
	or a			;ac3f
	call nz,dispara_normal		;ac40   ; dispara_normal: el disparo normal (0xE430): tipo 1 en 0xE470 o 0xE480
	ld a,(0e431h)		;ac43   ; 0xE431
	or a			;ac46
	call nz,dispara_e431		;ac47   ; dispara_e431: con 0xE438 a cero, un disparo tipo 3 en 0xE480 (24 x 7, en diagonal) y suena 2
	ld a,(0e432h)		;ac4a   ; 0xE432
	or a			;ac4d
	call nz,dispara_e432		;ac4e   ; dispara_e432: el arma 0xE432 en 0xE470: 1-2 tipo 7, 3 p03:AD85, 5 p03:AF77, 6 p03:B000
	ld a,(0e436h)		;ac51   ; 0xE436
	or a			;ac54
	call nz,dispara_e436		;ac55   ; dispara_e436: un disparo tipo 2 en la ficha 0xE480 (hacia arriba)
L_AC58:
	ld a,(0e433h)		;ac58   ; el misil
	or a			;ac5b
	call nz,dispara_misil		;ac5c   ; dispara_misil: el misil (0xE433) de quien dispara en su ficha de 0xE4D0, si esta libre: tipo 4 (5 con el 3), 8 x 2
	ld a,(0e434h)		;ac5f   ; el doble
	or a			;ac62
	call nz,dispara_arriba		;ac63   ; dispara_arriba: el disparo hacia arriba (0xE434): tipo 10 (o 12 con 2) en 0xE480, 2 x 16 x 8, y suena 0x0E
	ld a,(0e435h)		;ac66   ; el laser
	or a			;ac69
	call nz,dispara_abajo		;ac6a   ; dispara_abajo: el disparo hacia abajo (0xE435): tipo 11 (o 13 con 2) en 0xE480
	ret			;ac6d
dispara_e436:		; un disparo tipo 2 en la ficha 0xE480 (hacia arriba)
	ld hl,0e480h		;ac6e   ; en 0xE480, si esta libre
	call ficha_de_quien_dispara		;ac71   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;ac74
	ld (hl),002h		;ac75   ; tipo 2
	inc l			;ac77
	ld de,00800h		;ac78
	jr L_ACBB		;ac7b
dispara_normal:		; el disparo normal (0xE430): tipo 1 en 0xE470 o 0xE480
	dec a			;ac7d   ; 1: uno
	jr z,L_AC9A		;ac7e
	ld hl,0e470h		;ac80   ; 2: en 0xE470 o en 0xE480
	call ficha_de_quien_dispara		;ac83   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	jr z,L_ACB5		;ac86
	ld hl,0e480h		;ac88   ; apunta a la segunda ficha de disparo
	call ficha_de_quien_dispara		;ac8b   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	jr z,L_ACB5		;ac8e
	ret			;ac90
dispara_normal_1:		; un tipo 1 en 0xE470 si esta libre
	ld hl,0e470h		;ac91   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	call ficha_de_quien_dispara		;ac94   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;ac97
	jr L_ACB5		;ac98
L_AC9A:
	ld a,(0e431h)		;ac9a   ; con 0xE431, dos fichas
	or a			;ac9d
	jr z,dispara_normal_1		;ac9e
	ld hl,0e470h		;aca0   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	call ficha_de_quien_dispara		;aca3   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	jr nz,e438_a_1		;aca6
	push hl			;aca8
	ld bc,00010h		;aca9
	add hl,bc			;acac
	ld a,(hl)			;acad
	or a			;acae
	pop hl			;acaf
	jr nz,e438_a_1		;acb0
	call e438_a_0		;acb2   ; e438_a_0: 0xE438 = 0
L_ACB5:
	ld (hl),001h		;acb5   ; tipo 1
	inc l			;acb7
	ld de,00808h		;acb8
L_ACBB:
	call disparo_en_su_sitio		;acbb   ; su Y, en la rejilla de 8
	and 0f8h		;acbe
	ld (hl),a			;acc0
	ld d,0f6h		;acc1   ; su X
	call dibujo_por_y		;acc3   ; dibujo_por_y: (HL + 1) = D + (la Y de quien dispara / 2) & 3
	ld a,l			;acc6
	add a,006h		;acc7
	ld l,a			;acc9
	ld (hl),008h		;acca   ; 8 de largo, 2 de alto
	inc l			;accc
	ld (hl),002h		;accd
	ld a,001h		;accf   ; suena 1
	jp 04ae4h		;acd1   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
avanza_12:		; IY+05 + 12; al salir, se quita (p03:AE02)
	ld a,(iy+005h)		;acd4   ; 12 pixeles a la derecha
	add a,00ch		;acd7
	jp c,quita_disparo		;acd9   ; quita_disparo: el disparo IY desaparece
	ld (iy+005h),a		;acdc
	ret			;acdf
retrocede_12:		; IY+05 - 12; al salir, se quita (p03:AE02)
	ld a,(iy+005h)		;ace0   ; 12 pixeles a la izquierda
	sub 00ch		;ace3
	jp c,quita_disparo		;ace5   ; quita_disparo: el disparo IY desaparece
	ld (iy+005h),a		;ace8
	ret			;aceb
e438_a_1:		; 0xE438 = 1
	ld a,001h		;acec
	jr L_ACF2		;acee
e438_a_0:		; 0xE438 = 0
	ld a,000h		;acf0
L_ACF2:
	ld (0e438h),a		;acf2   ; guarda la marca de 0xE438
	ret			;acf5
dispara_e431:		; con 0xE438 a cero, un disparo tipo 3 en 0xE480 (24 x 7, en diagonal) y suena 2
	ld a,(0e438h)		;acf6   ; con 0xE438 no
	or a			;acf9
	ret nz			;acfa
	ld hl,0e480h		;acfb   ; en 0xE480
	call ficha_de_quien_dispara		;acfe   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;ad01
	ld (hl),003h		;ad02   ; tipo 3
	inc l			;ad04
	ld de,00808h		;ad05
	call disparo_en_su_sitio		;ad08   ; disparo_en_su_sitio: (HL + 2) = la Y de quien dispara + D y (HL + 4) = su X + E
	inc l			;ad0b   ; 24 x 7
	ld (hl),018h		;ad0c
	inc l			;ad0e
	ld (hl),007h		;ad0f
	ld a,l			;ad11
	add a,005h		;ad12
	ld l,a			;ad14
	ld (hl),008h		;ad15   ; 8 x 2
	inc l			;ad17
	ld (hl),002h		;ad18
	ld a,002h		;ad1a   ; suena 2
	jp 04ae4h		;ad1c   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
avanza_en_diagonal:		; IY+03 - 6 e IY+05 + 6; al salir, se quita
	ld a,(iy+003h)		;ad1f   ; 6 arriba
	sub 006h		;ad22
	jp c,quita_disparo		;ad24   ; quita_disparo: el disparo IY desaparece
	ld (iy+003h),a		;ad27
	ld a,(iy+005h)		;ad2a   ; 6 a la derecha
	add a,006h		;ad2d
	jp c,quita_disparo		;ad2f   ; quita_disparo: el disparo IY desaparece
	ld (iy+005h),a		;ad32
	ret			;ad35
dispara_e432:		; el arma 0xE432 en 0xE470: 1-2 tipo 7, 3 p03:AD85, 5 p03:AF77, 6 p03:B000
	ld hl,0e470h		;ad36   ; en 0xE470
	call ficha_de_quien_dispara		;ad39   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;ad3c
	ld a,(0e432h)		;ad3d   ; segun 0xE432
	sub 003h		;ad40
	jr c,L_AD50		;ad42
	jr z,dispara_tipo_8		;ad44
	dec a			;ad46
	dec a			;ad47
	jp z,dispara_tipo_14		;ad48   ; dispara_tipo_14: el arma 5 de 0xE432: un tipo 14 en 0xE470 a 16 pixeles de quien dispara, 12 x 12; suena 0x1B
	dec a			;ad4b
	jp z,dispara_tipo_15		;ad4c   ; dispara_tipo_15: el arma 6 de 0xE432: un tipo 15 en 0xE470 pegado a quien dispara; suena 0x1C
	ret			;ad4f
L_AD50:
	ld (hl),007h		;ad50   ; 1 o 2: tipo 7
	inc l			;ad52
	ld (hl),000h		;ad53
	ld de,00810h		;ad55
	call disparo_en_su_sitio		;ad58   ; disparo_en_su_sitio: (HL + 2) = la Y de quien dispara + D y (HL + 4) = su X + E
	and 0f8h		;ad5b
	ld (hl),a			;ad5d
	ld d,0fah		;ad5e   ; su X
	call dibujo_por_y		;ad60   ; dibujo_por_y: (HL + 1) = D + (la Y de quien dispara / 2) & 3
	inc l			;ad63
	inc l			;ad64
	push ix		;ad65   ; IX: quien dispara
	pop bc			;ad67
	ld (hl),c			;ad68
	inc l			;ad69
	ld (hl),b			;ad6a
	inc l			;ad6b
	ld (hl),000h		;ad6c
	inc l			;ad6e
	ld a,(0e432h)		;ad6f   ; 15 con 1, 28 con 2
	dec a			;ad72
	ld a,00fh		;ad73
	jr z,L_AD79		;ad75
	ld a,01ch		;ad77
L_AD79:
	ld (hl),a			;ad79
	inc l			;ad7a
	ld (hl),000h		;ad7b
	inc l			;ad7d
	ld (hl),002h		;ad7e
	ld a,003h		;ad80   ; suena 3
	jp 04ae4h		;ad82   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
dispara_tipo_8:		; el arma 3 de 0xE432: un tipo 8 delante de quien dispara, en la rejilla, dibujo 0xF1, y suena 0x1A
	ld (hl),008h		;ad85   ; tipo 8, paso 0
	inc l			;ad87
	ld (hl),000h		;ad88   ; paso 0
	ld a,(ix+004h)		;ad8a   ; la Y + 8 en la rejilla
	add a,008h		;ad8d   ; la Y + 8
	and 0f8h		;ad8f
	inc l			;ad91
	inc l			;ad92
	ld (hl),a			;ad93
	ld a,(ix+006h)		;ad94   ; la X + 16 en la rejilla
	add a,010h		;ad97   ; la X + 16
	and 0f8h		;ad99
	inc l			;ad9b
	inc l			;ad9c
	ld (hl),a			;ad9d
	inc l			;ad9e
	ld (hl),0f1h		;ad9f   ; dibujo 0xF1
	inc l			;ada1
	inc l			;ada2
	push ix		;ada3   ; quien dispara
	pop bc			;ada5
	ld (hl),c			;ada6   ; IY+08/IY+09: quien dispara
	inc l			;ada7
	ld (hl),b			;ada8
	inc l			;ada9
	ld (hl),000h		;adaa
	inc l			;adac
	ld (hl),01ch		;adad   ; 28 de largo
	inc l			;adaf
	ld (hl),000h		;adb0   ; IY+0C = 0
	inc l			;adb2
	ld (hl),008h		;adb3
	ld a,01ah		;adb5   ; suena 0x1A
	jp 04ae4h		;adb7   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
dispara_arriba:		; el disparo hacia arriba (0xE434): tipo 10 (o 12 con 2) en 0xE480, 2 x 16 x 8, y suena 0x0E
	ld hl,0e480h		;adba   ; en 0xE480
	call ficha_de_quien_dispara		;adbd   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;adc0
	ld a,(0e434h)		;adc1   ; 10, o 12 con 2
	dec a			;adc4
	ld a,00ah		;adc5
	jr z,pon_disparo_vertical		;adc7
	ld a,00ch		;adc9
pon_disparo_vertical:		; el disparo de tipo A en HL, en el sitio de quien dispara
	ld (hl),a			;adcb
	inc l			;adcc
	ld (hl),004h		;adcd   ; paso 4
	ld de,00800h		;adcf
	call disparo_en_su_sitio		;add2   ; la Y en la rejilla
	and 0f8h		;add5
	ld (hl),a			;add7
	ld d,0fah		;add8   ; la X
	call dibujo_por_y		;adda   ; dibujo_por_y: (HL + 1) = D + (la Y de quien dispara / 2) & 3
	ld a,l			;addd
	add a,004h		;adde
	ld l,a			;ade0
	ld (hl),002h		;ade1   ; 2 x 16 x 8
	inc l			;ade3
	inc l			;ade4
	ld (hl),010h		;ade5
	inc l			;ade7
	ld (hl),008h		;ade8
	ld a,00eh		;adea   ; suena 0x0E
	jp 04ae4h		;adec   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
dispara_abajo:		; el disparo hacia abajo (0xE435): tipo 11 (o 13 con 2) en 0xE480
	ld hl,0e480h		;adef   ; apunta a la segunda ficha de disparo
	call ficha_de_quien_dispara		;adf2   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;adf5
	ld a,(0e435h)		;adf6   ; 11, o 13 con 2
	dec a			;adf9
	ld a,00bh		;adfa
	jr z,pon_disparo_vertical		;adfc
	ld a,00dh		;adfe
	jr pon_disparo_vertical		;ae00
quita_disparo:		; el disparo IY desaparece
	ld (iy+000h),000h		;ae02
	ret			;ae06
disparo_tipo_7:		; el tipo 7: pegado a quien lo dispara, crece 4 pasos y luego avanza 32 pixeles por cuadro y se acorta
	push iy		;ae07
	pop hl			;ae09
	inc l			;ae0a
	ld a,(hl)			;ae0b   ; el paso
	dec a			;ae0c
	jr z,disparo_avanza		;ae0d
	jp p,disparo_se_acorta		;ae0f   ; disparo_se_acorta: 32 pixeles a la derecha y 4 caracteres menos de largo; sin largo, se quita
	ld c,(iy+008h)		;ae12   ; quien lo dispara
	ld b,(iy+009h)		;ae15
	push bc			;ae18
	pop ix		;ae19
	ld de,00810h		;ae1b   ; pegado a el
	call disparo_en_su_sitio		;ae1e   ; disparo_en_su_sitio: (HL + 2) = la Y de quien dispara + D y (HL + 4) = su X + E
	and 0f8h		;ae21
	cp 0f8h		;ae23   ; en el borde derecho, se quita
	jr nc,quita_disparo		;ae25
	ld (hl),a			;ae27
	ld d,0fah		;ae28
	call dibujo_por_y		;ae2a   ; dibujo_por_y: (HL + 1) = D + (la Y de quien dispara / 2) & 3
	ld a,004h		;ae2d   ; 4 pasos de crecer
L_AE2F:
	add a,l			;ae2f
	ld l,a			;ae30
	ld b,004h		;ae31
L_AE33:
	inc (hl)			;ae33   ; un caracter mas
	inc l			;ae34
	dec (hl)			;ae35   ; una vuelta menos del paso
	jr z,L_AE3D		;ae36
	dec l			;ae38
	djnz L_AE33		;ae39   ; 4 bytes
	jr recorta_por_la_izquierda		;ae3b
L_AE3D:
	inc (iy+001h)		;ae3d   ; crecido: al paso siguiente
recorta_por_la_izquierda:		; si el disparo empieza antes del borde izquierdo, su largo (IY+0A) se acorta
	ld a,(iy+00ah)		;ae40   ; el principio del disparo (X - largo x 8)
	add a,a			;ae43
	add a,a			;ae44
	add a,a			;ae45
	neg		;ae46
	sub (iy+005h)		;ae48
	ret nc			;ae4b   ; dentro: nada
	neg		;ae4c
	rra			;ae4e   ; lo que sale, en caracteres
	rra			;ae4f
	rra			;ae50
	and 01fh		;ae51
	sub (iy+00ah)		;ae53
	neg		;ae56
	ld (iy+00ah),a		;ae58   ; el largo que queda
	ret			;ae5b
disparo_avanza:		; 32 pixeles a la derecha y recortado; sin largo, se quita
	call avanza_32		;ae5c   ; avanza
	jr c,quita_disparo		;ae5f
	call recorta_por_la_izquierda		;ae61   ; recorta_por_la_izquierda: si el disparo empieza antes del borde izquierdo, su largo (IY+0A) se acorta
	ld a,(iy+00ah)		;ae64   ; sin largo, se quita
	or a			;ae67
	ret nz			;ae68
	jr quita_disparo		;ae69
disparo_se_acorta:		; 32 pixeles a la derecha y 4 caracteres menos de largo; sin largo, se quita
	call avanza_32		;ae6b   ; avanza_32: IY+05 + 32 (C al salirse)
	jr c,quita_disparo		;ae6e
	ld a,(iy+00ah)		;ae70   ; 4 menos de largo
	sub 005h		;ae73
	jr c,quita_disparo		;ae75
	inc a			;ae77
	ld (iy+00ah),a		;ae78
	ret			;ae7b
avanza_32:		; IY+05 + 32 (C al salirse)
	ld a,(iy+005h)		;ae7c   ; 32 pixeles
	add a,020h		;ae7f
	ld (iy+005h),a		;ae81
	ret			;ae84
disparo_tipo_8:		; el tipo 8: como el 7, desde la rejilla de quien lo dispara
	push iy		;ae85
	pop hl			;ae87
	inc l			;ae88
	ld a,(hl)			;ae89
	dec a			;ae8a
	jr z,disparo_avanza		;ae8b   ; paso 1: avanza
	jp p,disparo_se_acorta		;ae8d   ; disparo_se_acorta: 32 pixeles a la derecha y 4 caracteres menos de largo; sin largo, se quita
	ld c,(iy+008h)		;ae90   ; quien lo dispara
	ld b,(iy+009h)		;ae93
	push bc			;ae96
	pop ix		;ae97
	ld a,(ix+004h)		;ae99   ; la Y + 8 en la rejilla
	add a,008h		;ae9c
	and 0f8h		;ae9e
	inc l			;aea0
	inc l			;aea1
	ld (hl),a			;aea2
	ld a,(ix+006h)		;aea3   ; la X + 16 en la rejilla
	add a,010h		;aea6
	and 0f8h		;aea8
	cp 0f8h		;aeaa   ; en el borde derecho, se quita
	jp nc,quita_disparo		;aeac   ; quita_disparo: el disparo IY desaparece
	inc l			;aeaf
	inc l			;aeb0
	ld (hl),a			;aeb1
	ld a,005h		;aeb2   ; 5 pasos de crecer
	jp L_AE2F		;aeb4
disparo_sube:		; el disparo sube 6 pixeles; arriba del todo, se quita
	push iy		;aeb7
	pop hl			;aeb9
	inc l			;aeba
	inc l			;aebb
	inc l			;aebc
	ld a,(hl)			;aebd   ; la Y - 6
	sub 006h		;aebe
	jp c,quita_disparo		;aec0   ; quita_disparo: el disparo IY desaparece
pon_y_y_x:		; la Y A del disparo y su X la de quien dispara + 6
	ld (hl),a			;aec3
	inc l			;aec4   ; a IY+05
	inc l			;aec5
	ld d,0fah		;aec6   ; la X de quien dispara
	jp L_B236		;aec8
disparo_baja:		; el disparo baja 6 pixeles; abajo del todo (0xB0), se quita
	push iy		;aecb
	pop hl			;aecd
	inc l			;aece
	inc l			;aecf
	inc l			;aed0
	ld a,(hl)			;aed1   ; la Y + 6
	add a,006h		;aed2
	cp 0b0h		;aed4   ; abajo del todo
	jp nc,quita_disparo		;aed6   ; quita_disparo: el disparo IY desaparece
	jr pon_y_y_x		;aed9
disparo_tipo_12:		; el tipo 12: sube y cada 4 cuadros crece un caracter hacia la izquierda
	call disparo_sube		;aedb   ; disparo_sube: el disparo sube 6 pixeles; arriba del todo, se quita
crece_a_la_izquierda:		; cada 4 cuadros, 8 pixeles a la izquierda y un caracter mas de largo
	dec (iy+001h)		;aede   ; cada 4 cuadros
	ret nz			;aee1
	ld (iy+001h),004h		;aee2
	ld a,(iy+005h)		;aee6   ; en el borde izquierdo, solo crece
	or a			;aee9
	ld b,001h		;aeea
	jr z,L_AEF4		;aeec
	inc b			;aeee
	sub 008h		;aeef   ; 8 a la izquierda
	ld (iy+005h),a		;aef1
L_AEF4:
	ld a,(iy+00ah)		;aef4   ; 1 o 2 caracteres mas
	add a,b			;aef7
	ld (iy+00ah),a		;aef8
	jp recorta_por_la_izquierda		;aefb   ; recorta_por_la_izquierda: si el disparo empieza antes del borde izquierdo, su largo (IY+0A) se acorta
disparo_tipo_13:		; el tipo 13: baja y cada 4 cuadros crece un caracter hacia la izquierda
	call disparo_baja		;aefe   ; disparo_baja: el disparo baja 6 pixeles; abajo del todo (0xB0), se quita
	jp crece_a_la_izquierda		;af01   ; crece_a_la_izquierda: cada 4 cuadros, 8 pixeles a la izquierda y un caracter mas de largo
dispara_vector:		; con VECTOR (capsula 7), un tipo 9 en 0xE470, en la rejilla, dibujo 0xF2, 16 x 16; suena 0x1D
	ld hl,0e470h		;af04   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	call ficha_de_quien_dispara		;af07   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;af0a
	ld (hl),009h		;af0b   ; tipo 9, paso 4
	inc l			;af0d
	ld (hl),004h		;af0e
	ld a,(ix+004h)		;af10   ; la Y en la rejilla
	inc l			;af13
	inc l			;af14
	and 0f8h		;af15
	ld (hl),a			;af17
	ld a,(ix+006h)		;af18   ; la X + 16 en la rejilla
	add a,010h		;af1b
	inc l			;af1d
	inc l			;af1e
	and 0f8h		;af1f
	ld (hl),a			;af21
	inc l			;af22
	ld (hl),0f2h		;af23   ; dibujo 0xF2
	inc l			;af25
	inc l			;af26
	inc l			;af27
	inc l			;af28
	ld (hl),002h		;af29   ; 2 de largo
	inc l			;af2b
	inc l			;af2c
	ld (hl),010h		;af2d   ; 16 x 16
	inc l			;af2f
	ld (hl),010h		;af30
	ld a,01dh		;af32   ; suena 0x1D
	jp 04ae4h		;af34   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparo_tipo_9:		; el tipo 9: 8 pixeles a la derecha por cuadro; cada 4 cuadros sube 8 y crece un caracter, sin salirse por arriba
	ld a,(iy+005h)		;af37   ; 8 a la derecha
	add a,008h		;af3a
	jp c,quita_disparo		;af3c   ; quita_disparo: el disparo IY desaparece
	ld (iy+005h),a		;af3f
	dec (iy+001h)		;af42   ; cada 4 cuadros
	ret nz			;af45
	ld (iy+001h),004h		;af46
	ld a,(iy+003h)		;af4a   ; arriba del todo, solo crece
	or a			;af4d
	ld b,001h		;af4e
	jr z,L_AF58		;af50
	inc b			;af52
	sub 008h		;af53   ; 8 arriba
	ld (iy+003h),a		;af55
L_AF58:
	ld a,(iy+00ah)		;af58   ; 1 o 2 caracteres mas
	add a,b			;af5b
	ld (iy+00ah),a		;af5c   ; un caracter mas
	ld a,(iy+003h)		;af5f   ; sin salirse por arriba (23 caracteres)
	rra			;af62   ; la fila de arriba del disparo
	rra			;af63
	rra			;af64
	and 01fh		;af65
	add a,(iy+00ah)		;af67
	sub 017h		;af6a   ; sin pasar de la fila 23
	ret c			;af6c
	inc a			;af6d
	neg		;af6e
	add a,(iy+00ah)		;af70
	ld (iy+00ah),a		;af73   ; recortado
	ret			;af76
dispara_tipo_14:		; el arma 5 de 0xE432: un tipo 14 en 0xE470 a 16 pixeles de quien dispara, 12 x 12; suena 0x1B
	ld hl,0e470h		;af77   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	call ficha_de_quien_dispara		;af7a   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;af7d
	push hl			;af7e
	pop iy		;af7f
	ld (hl),00eh		;af81   ; tipo 14, paso 0
	inc l			;af83
	ld (hl),000h		;af84
	ld (iy+00ah),010h		;af86   ; a 16 pixeles
	call tipo_14_en_su_sitio		;af8a   ; tipo_14_en_su_sitio: la Y de quien dispara + 1 y su X + IY+0A (al salirse, vuelve)
	inc l			;af8d
	ld (hl),018h		;af8e   ; 24
	inc l			;af90
	inc l			;af91
	push ix		;af92   ; quien dispara
	pop bc			;af94
	ld (hl),c			;af95
	inc l			;af96
	ld (hl),b			;af97
	inc l			;af98
	ld (hl),010h		;af99   ; 16
	inc l			;af9b
	inc l			;af9c
	ld (hl),00ch		;af9d   ; 12 x 12
	inc l			;af9f
	ld (hl),00ch		;afa0
	ld a,01bh		;afa2   ; suena 0x1B
	jp 04ae4h		;afa4   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparo_tipo_14:		; el tipo 14: se aleja 6 pixeles por cuadro hasta 0x60 y vuelve hasta 16; va con quien lo disparo y parpadea (11/9)
	push iy		;afa7
	pop hl			;afa9
	inc l			;afaa
	bit 0,(hl)		;afab   ; volviendo?
	jr nz,L_AFF1		;afad
	ld a,(iy+00ah)		;afaf   ; se aleja 6
	add a,006h		;afb2
	ld (iy+00ah),a		;afb4
	cp 060h		;afb7   ; hasta 0x60: luego vuelve
	jr c,L_AFBD		;afb9
	ld (hl),001h		;afbb
L_AFBD:
	ld c,(iy+008h)		;afbd   ; quien lo disparo
	ld b,(iy+009h)		;afc0
	push bc			;afc3
	pop ix		;afc4
tipo_14_en_su_sitio:		; la Y de quien dispara + 1 y su X + IY+0A (al salirse, vuelve)
	ld a,(ix+004h)		;afc6   ; su Y + 1
	inc a			;afc9
	inc l			;afca
	inc l			;afcb
	ld (hl),a			;afcc   ; la Y
	inc l			;afcd
	inc l			;afce
	ld a,(ix+006h)		;afcf   ; su X + la distancia
	add a,(iy+00ah)		;afd2
	jr c,L_AFDB		;afd5
	cp 0f0h		;afd7   ; hasta 0xF0
	jr c,L_AFE1		;afd9
L_AFDB:
	ld (iy+001h),001h		;afdb   ; fuera: vuelve
	ld a,0f0h		;afdf
L_AFE1:
	ld (hl),a			;afe1   ; la X
	ld a,(0e1c3h)		;afe2   ; parpadea: 11 o 9
	bit 1,a		;afe5
	ld a,00bh		;afe7
	jr z,L_AFED		;afe9
	ld a,009h		;afeb
L_AFED:
	ld (iy+007h),a		;afed
	ret			;aff0
L_AFF1:
	ld a,(iy+00ah)		;aff1   ; vuelve 6
	sub 006h		;aff4
	ld (iy+00ah),a		;aff6
	cp 010h		;aff9   ; a 16, se quita
	jp c,quita_disparo		;affb   ; quita_disparo: el disparo IY desaparece
	jr L_AFBD		;affe
dispara_tipo_15:		; el arma 6 de 0xE432: un tipo 15 en 0xE470 pegado a quien dispara; suena 0x1C
	ld hl,0e470h		;b000   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	call ficha_de_quien_dispara		;b003   ; ficha_de_quien_dispara: HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ret nz			;b006
	push hl			;b007
	pop iy		;b008
	ld (hl),00fh		;b00a   ; tipo 15, paso 0
	inc l			;b00c
	ld (hl),000h		;b00d
	call tipo_15_sitio		;b00f   ; pegado a quien dispara
	push ix		;b012
	pop bc			;b014
	inc l			;b015   ; quien dispara
	inc l			;b016
	ld (hl),c			;b017
	inc l			;b018
	ld (hl),b			;b019
	inc l			;b01a
	xor a			;b01b   ; a cero
	ld (hl),a			;b01c
	inc l			;b01d
	ld (hl),a			;b01e
	inc l			;b01f
	ld (hl),a			;b020
	inc l			;b021
	ld (hl),008h		;b022   ; 8
	ld a,01ch		;b024   ; suena 0x1C
	jp 04ae4h		;b026   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparo_tipo_15:		; el tipo 15: crece 8 cuadros y luego mengua; con el boton otra vez (arma 6) vuelve a crecer
	push iy		;b029
	pop hl			;b02b
	inc l			;b02c
	bit 0,(hl)		;b02d   ; menguando?
	jr nz,L_B060		;b02f
	call tipo_15_en_su_sitio		;b031   ; en su sitio
	inc (iy+00bh)		;b034   ; crece
	ld a,(iy+00bh)		;b037
	cp 008h		;b03a   ; 8 pasos
	jr c,L_B042		;b03c
	ld (iy+001h),001h		;b03e
L_B042:
	ld a,(iy+005h)		;b042   ; recortado por la derecha
	rra			;b045   ; la columna
	rra			;b046
	rra			;b047
	and 01fh		;b048
	add a,(iy+00bh)		;b04a
	sub 021h		;b04d   ; sin pasar de la 33
	jr nc,L_B056		;b04f
	ld a,(iy+00bh)		;b051   ; todo cabe
	jr L_B05C		;b054
L_B056:
	inc a			;b056
	neg		;b057
	add a,(iy+00bh)		;b059
L_B05C:
	ld (iy+00ah),a		;b05c   ; IY+0A: el largo
	ret			;b05f
L_B060:
	call tipo_15_en_su_sitio		;b060   ; mengua
	dec (iy+00bh)		;b063
	jp z,quita_disparo		;b066   ; sin nada, se quita
	ld a,(0e432h)		;b069   ; el arma 6
	cp 006h		;b06c
	jr nz,L_B042		;b06e
	ld a,(0e3c0h)		;b070   ; lee el paso del final del interior (0 nada)
	or a			;b073
	jr nz,L_B042		;b074
	ld a,(0e1c8h)		;b076   ; con el boton otra vez
	and 010h		;b079
	jr z,L_B042		;b07b
	ld a,01ch		;b07d   ; suena 0x1C y vuelve a crecer
	call 04ae4h		;b07f   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld (iy+001h),000h		;b082
	jr L_B042		;b086
tipo_15_en_su_sitio:		; la Y (rejilla de 4) y la X (rejilla de 8) de quien dispara; en el borde, se quita
	ld c,(iy+008h)		;b088   ; quien lo dispara
	ld b,(iy+009h)		;b08b
	push bc			;b08e
	pop ix		;b08f
tipo_15_sitio:		; la Y (rejilla de 4) y la X (rejilla de 8) de IX en el disparo HL; al salirse, se quita
	inc l			;b091
	inc l			;b092
	ld a,(ix+004h)		;b093   ; la Y + 4 en la rejilla de 4
	add a,004h		;b096
	and 0fch		;b098
	ld (hl),a			;b09a
	ld b,a			;b09b
	inc l			;b09c
	inc l			;b09d
	ld a,(ix+006h)		;b09e   ; la X + 16 en la rejilla de 8
	add a,010h		;b0a1
	and 0f8h		;b0a3
	cp 0f8h		;b0a5   ; en el borde derecho, se quita
	jp z,quita_disparo		;b0a7   ; quita_disparo: el disparo IY desaparece
	ld (hl),a			;b0aa
	inc l			;b0ab
	xor a			;b0ac   ; la mitad de la rejilla de 8 (bit 2 de la Y)
	bit 2,b		;b0ad
	jr z,L_B0B2		;b0af
	inc a			;b0b1
L_B0B2:
	ld (hl),a			;b0b2
	ret			;b0b3
dispara_misil:		; el misil (0xE433) de quien dispara en su ficha de 0xE4D0, si esta libre: tipo 4 (5 con el 3), 8 x 2
	ld a,(ix+004h)		;b0b4   ; abajo del todo, no
	cp 0a5h		;b0b7
	ret nc			;b0b9
	ld a,(ix+006h)		;b0ba   ; ni en el borde derecho
	cp 0e8h		;b0bd
	ret nc			;b0bf
	ld hl,0e4d0h		;b0c0   ; la ficha de misil de quien dispara
	exx			;b0c3
	ld a,e			;b0c4
	exx			;b0c5
	sra a		;b0c6
	add a,l			;b0c8
	ld l,a			;b0c9
	ld a,(hl)			;b0ca   ; ocupada: nada
	or a			;b0cb
	ret nz			;b0cc
	ld a,(0e433h)		;b0cd   ; el misil
	ld de,00400h		;b0d0   ; 1: tipo 4, 0x20 x 0x0A
	ld bc,0200ah		;b0d3
	dec a			;b0d6
	jr z,L_B0E1		;b0d7
	inc e			;b0d9   ; 2: tipo 4 con paso 1
	dec a			;b0da
	jr z,L_B0E1		;b0db
	inc d			;b0dd   ; 3: tipo 5, 0x28 x 0x0F
	ld bc,0280fh		;b0de
L_B0E1:
	ld (hl),d			;b0e1   ; el tipo
	inc l			;b0e2
	ld (hl),e			;b0e3   ; el paso
	ld de,00808h		;b0e4   ; en su sitio
	call disparo_en_su_sitio		;b0e7   ; disparo_en_su_sitio: (HL + 2) = la Y de quien dispara + D y (HL + 4) = su X + E
	inc l			;b0ea
	ld (hl),b			;b0eb   ; alto y ancho
	inc l			;b0ec
	ld (hl),c			;b0ed
	inc l			;b0ee
	ld (hl),000h		;b0ef   ; IY+07 = 0
	ld a,l			;b0f1
	add a,004h		;b0f2
	ld l,a			;b0f4
	ld (hl),008h		;b0f5   ; 8 x 2
	inc l			;b0f7
	ld (hl),002h		;b0f8   ; IY+0D = 2
	ret			;b0fa
disparo_misil:		; los tipos 4 y 5 (el misil): cae hasta tocar el suelo y luego avanza pegado a el; al chocar de frente, se quita; en la fase 5 va recto
	push iy		;b0fb
	pop hl			;b0fd
	ld a,(0e201h)		;b0fe   ; en la fase 5, recto
	cp 005h		;b101
	jr z,L_B140		;b103
	ld h,(iy+005h)		;b105   ; debajo?
	ld l,(iy+003h)		;b108
	ld a,l			;b10b
	add a,008h		;b10c
	ld l,a			;b10e
	call misil_toca_mapa		;b10f   ; misil_toca_mapa: C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305)
	jr nc,L_B140		;b112   ; nada debajo: cae
	ld h,(iy+005h)		;b114   ; debajo a la derecha?
	ld l,(iy+003h)		;b117
	ld a,h			;b11a
	add a,008h		;b11b
	ld h,a			;b11d
	ld a,l			;b11e
	add a,008h		;b11f
	ld l,a			;b121
	call misil_toca_mapa		;b122   ; misil_toca_mapa: C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305)
	jr nc,L_B13A		;b125   ; nada: cae un poco
	ld h,(iy+005h)		;b127   ; delante?
	ld l,(iy+003h)		;b12a
	ld a,h			;b12d
	add a,008h		;b12e
	ld h,a			;b130
	call misil_toca_mapa		;b131   ; misil_toca_mapa: C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305)
	jp c,quita_disparo		;b134   ; de frente: se quita
	jp misil_avanza		;b137   ; por el suelo: avanza
L_B13A:
	call misil_cae		;b13a   ; misil_cae: el dibujo de caer (0x20, 0x28 el tipo 5) y baja 4 (6 con el paso 1); abajo del todo, se quita
	jp misil_avanza		;b13d   ; misil_avanza: el dibujo de avanzar (0x1C, 0x24 el tipo 5) y a la derecha 4 (6 con el paso 1)
L_B140:
	bit 0,(iy+001h)		;b140   ; recto o despacio (paso 1)
	ld de,00100h		;b144
	jr z,L_B14B		;b147
	ld e,080h		;b149
L_B14B:
	call avanza_de		;b14b   ; avanza_de: IY+04/IY+05 + DE; al salirse por la derecha, se quita
misil_cae:		; el dibujo de caer (0x20, 0x28 el tipo 5) y baja 4 (6 con el paso 1); abajo del todo, se quita
	ld a,(iy+000h)		;b14e
	cp 005h		;b151   ; 0x28 el tipo 5, 0x20 el 4
	ld a,028h		;b153   ; el 5
	jr z,L_B159		;b155
	ld a,020h		;b157   ; el 4
L_B159:
	ld (iy+006h),a		;b159   ; el dibujo
	bit 0,(iy+001h)		;b15c   ; 4, o 6 con el paso 1
	ld de,00400h		;b160   ; abajo 4
	jr z,L_B167		;b163
	ld d,006h		;b165   ; o 6
L_B167:
	ld a,(iy+002h)		;b167   ; la Y en 16 bits
	add a,e			;b16a
	ld (iy+002h),a		;b16b
	ld a,(iy+003h)		;b16e
	adc a,d			;b171
	cp 0a8h		;b172   ; abajo del todo, se quita
	jp nc,quita_disparo		;b174   ; quita_disparo: el disparo IY desaparece
	ld (iy+003h),a		;b177
	ret			;b17a
misil_avanza:		; el dibujo de avanzar (0x1C, 0x24 el tipo 5) y a la derecha 4 (6 con el paso 1)
	ld a,(iy+000h)		;b17b
	cp 005h		;b17e   ; 0x24 el tipo 5, 0x1C el 4
	ld a,024h		;b180   ; el 5
	jr z,L_B186		;b182
	ld a,01ch		;b184   ; el 4
L_B186:
	ld (iy+006h),a		;b186   ; el dibujo
	bit 0,(iy+001h)		;b189
	ld de,00400h		;b18d   ; adelante 4
	jr z,avanza_de		;b190
	ld d,006h		;b192   ; o 6
avanza_de:		; IY+04/IY+05 + DE; al salirse por la derecha, se quita
	ld a,(iy+004h)		;b194   ; la X en 16 bits
	add a,e			;b197
	ld (iy+004h),a		;b198
	ld a,(iy+005h)		;b19b
	adc a,d			;b19e
	jp c,quita_disparo		;b19f   ; al salirse, se quita
	ld (iy+005h),a		;b1a2
	ret			;b1a5
misil_toca_mapa:		; C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305)
	ld a,(0e305h)		;b1a6   ; C' = el primer caracter que no es mapa
	exx			;b1a9
	ld c,a			;b1aa
	exx			;b1ab
	jp 08388h		;b1ac   ; toca_mapa_hl: C si en H (X), L (Y) o en el caracter de la derecha hay mapa
disparo_tipo_6:		; el tipo 6 (el misil 3 al estallar): va con el scroll, se anima y cada 5 cuadros suelta un 0x36 alrededor (4 veces)
	ld a,(0e320h)		;b1af   ; con el scroll
	or a			;b1b2
	jr z,L_B1C0		;b1b3
	ld a,(iy+005h)		;b1b5
	sub 008h		;b1b8
	ld (iy+005h),a		;b1ba
	jp c,quita_disparo		;b1bd   ; quita_disparo: el disparo IY desaparece
L_B1C0:
	call tipo_6_dibujo		;b1c0   ; su dibujo
	dec (iy+009h)		;b1c3   ; cada 5 cuadros
	ret nz			;b1c6
	ld (iy+009h),005h		;b1c7
	ld a,(iy+008h)		;b1cb   ; 4 veces
	cp 004h		;b1ce
	jp nc,quita_disparo		;b1d0   ; quita_disparo: el disparo IY desaparece
	inc (iy+008h)		;b1d3
	and 003h		;b1d6   ; el desplazamiento de p03:B1F0
	add a,a			;b1d8
	ld hl,0b1f0h		;b1d9
	call 05ca6h		;b1dc   ; byte_a: A = el byte A de la tabla HL
	add a,(iy+003h)		;b1df
	ld e,a			;b1e2
	inc hl			;b1e3
	ld a,(hl)			;b1e4
	add a,(iy+005h)		;b1e5
	ld d,a			;b1e8
	ld c,000h		;b1e9   ; un 0x36
	ld a,036h		;b1eb
	jp 04d1eh		;b1ed   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)

; ----------------------------------------------------------------------
; DATOS tabla_B1F0: 4 pares (dx, dy) que p03:B1D3 lee con IY+08 & 3; lo leen
;   p03:B1DC (8 bytes)
;   0xb1f0..0xb1f8  (8 bytes)
DATA_tabla_B1F0:
	defb 0f8h,0f8h	; b1f0
	defb 008h,008h	; b1f2
	defb 008h,0f8h	; b1f4
	defb 0f8h,008h	; b1f6

; ======================================================================
; CODIGO 0xb1f8..0xb23d  (69 bytes)
; ======================================================================


tipo_6_dibujo:		; el dibujo siguiente de p02:9621 (4 pasos)
	ld a,(iy+00ah)		;b1f8   ; 4 pasos
	inc a			;b1fb
	cp 004h		;b1fc   ; 4 pasos
	jr c,L_B201		;b1fe
	xor a			;b200
L_B201:
	ld (iy+00ah),a		;b201
	ld hl,09621h		;b204   ; de p02:9621
	call 04b67h		;b207   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld (iy+006h),e		;b20a   ; el dibujo
	ret			;b20d
ficha_de_quien_dispara:		; HL + E' = la ficha de disparo de quien dispara (nave u opcion); A = su tipo (Z libre); NZ si quien dispara esta fuera de la pantalla
	ld a,(ix+004h)		;b20e   ; quien dispara, fuera por abajo o por la derecha: NZ
	cp 0a6h		;b211
	jr nc,L_B222		;b213
	ld a,(ix+006h)		;b215
	cp 0d9h		;b218
	jr nc,L_B222		;b21a
	exx			;b21c   ; su ficha (E')
	ld a,e			;b21d   ; E' = la ficha de quien dispara
	exx			;b21e
	add a,l			;b21f
	ld l,a			;b220
	ld a,(hl)			;b221   ; Z si esta libre
L_B222:
	or a			;b222
	ret			;b223
disparo_en_su_sitio:		; (HL + 2) = la Y de quien dispara + D y (HL + 4) = su X + E
	ld a,(ix+004h)		;b224   ; la Y
	add a,d			;b227
	inc l			;b228
	inc l			;b229
	ld (hl),a			;b22a   ; a la ficha
	ld a,(ix+006h)		;b22b   ; la X
	add a,e			;b22e
	inc l			;b22f
	inc l			;b230
	ld (hl),a			;b231   ; a la ficha
	ret			;b232
dibujo_por_y:		; (HL + 1) = D + (la Y de quien dispara / 2) & 3
	ld a,(ix+004h)		;b233   ; por la Y
L_B236:
	rra			;b236   ; (Y / 2) & 3
	and 003h		;b237
	add a,d			;b239   ; + D
	inc l			;b23a
	ld (hl),a			;b23b   ; a IY+01
	ret			;b23c

; ----------------------------------------------------------------------
; DATOS lista_B23D: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5BA6 (19 bytes)
;   0xb23d..0xb250  (19 bytes)
DATA_lista_B23D:
	defb 0f3h,03ah,013h,014h,0feh,0e1h,03ah,011h,0feh,0f0h,03ah,001h,001h,0feh,0fdh,03ah	; b23d  .:....:...:....:
	defb 001h,001h,0ffh	; b24d

; ----------------------------------------------------------------------
; DATOS lista_B250: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5BB5 (5 bytes)
;   0xb250..0xb255  (5 bytes)
DATA_lista_B250:
	defb 0e6h,03ah,002h,012h,0ffh	; b250

; ----------------------------------------------------------------------
; DATOS lista_B255: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5BB5 (5 bytes)
;   0xb255..0xb25a  (5 bytes)
DATA_lista_B255:
	defb 0e6h,03ah,003h,012h,0ffh	; b255

; ----------------------------------------------------------------------
; DATOS lista_B25A: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:573E (10 bytes)
;   0xb25a..0xb264  (10 bytes)
DATA_lista_B25A:
	defb 02dh,03ah,011h,030h,02ch,021h,039h,025h,032h,0ffh	; b25a  -:.0,!9%2.

; ----------------------------------------------------------------------
; DATOS lista_B264: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:573E, p00:5741 (11 bytes)
;   0xb264..0xb26f  (11 bytes)
DATA_lista_B264:
	defb 06dh,03ah,012h,030h,02ch,021h,039h,025h,032h,033h,0ffh	; b264  m:.0,!9%23.

; ----------------------------------------------------------------------
; DATOS lista_s_B26F: lista a la VRAM sin destino delante (p00:4A73; 0xFE otro
;   destino; 0xFF acaba); lo leen p01:620D (3 bytes)
;   0xb26f..0xb272  (3 bytes)
DATA_lista_s_B26F:
	defb 01bh,01ch,0ffh	; b26f

; ----------------------------------------------------------------------
; DATOS lista_B272: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5794 (11 bytes)
;   0xb272..0xb27d  (11 bytes)
DATA_lista_B272:
	defb 0cch,038h,030h,02ch,021h,039h,025h,032h,000h,011h,0ffh	; b272  .80,!9%2...

; ----------------------------------------------------------------------
; DATOS lista_B27D: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5A92 (11 bytes)
;   0xb27d..0xb288  (11 bytes)
DATA_lista_B27D:
	defb 0cch,038h,030h,02ch,021h,039h,025h,032h,000h,012h,0ffh	; b27d  .80,!9%2...

; ----------------------------------------------------------------------
; DATOS lista_B288: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); se solapan 2 bloques: (lista_B295 B295-B2A4); lo
;   leen p00:58B0, p00:5952 (28 bytes)
;   0xb288..0xb2a4  (28 bytes)
DATA_lista_B288:
	defb 00bh,039h,027h,021h,02dh,025h,000h,000h,02fh,036h,025h,032h,0feh,04ah,039h,023h	; b288  .9'!-%../6%2.J9#
	defb 02fh,02eh,034h,029h,02eh,035h,025h,000h,000h,026h,015h,0ffh	; b298  /.4).5%..&..

; ----------------------------------------------------------------------
; DATOS lista_B2A4: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:5C1A (11 bytes)
;   0xb2a4..0xb2af  (11 bytes)
DATA_lista_B2A4:
	defb 0cch,039h,028h,029h,000h,033h,023h,02fh,032h,025h,0ffh	; b2a4  .9().3#/2%.

; ----------------------------------------------------------------------
; DATOS lista_B2AF: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); se solapan 2 bloques: (lista_B2BA B2BA-B2CA); lo
;   leen p00:596E, p00:59BC (27 bytes)
;   0xb2af..0xb2ca  (27 bytes)
DATA_lista_B2AF:
	defb 06ch,039h,01ah,00eh,00bh,000h,000h,00bh,014h,00ah,0feh,02ah,03ah,093h,000h,00bh	; b2af  l9.........*:...
	defb 01eh,01ah,00bh,014h,00ah,000h,00ch,002h,000h,093h,0ffh	; b2bf  ...........

; ----------------------------------------------------------------------
; DATOS lista_B2CA: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:598D, p00:59A1 (17 bytes)
;   0xb2ca..0xb2db  (17 bytes)
DATA_lista_B2CA:
	defb 029h,03ah,016h,01bh,019h,00eh,000h,019h,016h,007h,009h,00bh,000h,011h,00bh,01fh	; b2ca  ):..............
	defb 0ffh	; b2da

; ----------------------------------------------------------------------
; DATOS lista_B2DB: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:59C2 (19 bytes)
;   0xb2db..0xb2ee  (19 bytes)
DATA_lista_B2DB:
	defb 028h,03ah,019h,00bh,00bh,000h,01fh,015h,01bh,000h,014h,00bh,01eh,01ah,021h,021h	; b2db  (:............!!
	defb 021h,021h,0ffh	; b2eb

; ----------------------------------------------------------------------
; DATOS lista_B2EE: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p00:59AC (15 bytes)
;   0xb2ee..0xb2fd  (15 bytes)
DATA_lista_B2EE:
	defb 06ah,039h,012h,00bh,01ah,023h,019h,000h,000h,019h,01ah,007h,018h,01ah,0ffh	; b2ee  j9...#.........

; ----------------------------------------------------------------------
; DATOS fichas_B2FD: 30 fichas de 4 bytes (IX+0D de 1 a 30: p02:8A87 lee
;   0xB2F9 + 4 x IX+0D, y la 0 caeria en el codigo de delante); lo leen
;   p02:8A93 (120 bytes)
;   0xb2fd..0xb375  (120 bytes)
DATA_fichas_B2FD:
	defb 010h,000h,018h,028h	; b2fd
	defb 008h,000h,018h,028h	; b301
	defb 000h,000h,018h,028h	; b305
	defb 008h,000h,018h,028h	; b309
	defb 010h,000h,018h,028h	; b30d
	defb 018h,000h,018h,028h	; b311
	defb 008h,000h,020h,020h	; b315
	defb 004h,000h,020h,020h	; b319
	defb 000h,000h,030h,040h	; b31d
	defb 000h,000h,010h,040h	; b321
	defb 000h,000h,018h,040h	; b325
	defb 000h,000h,020h,040h	; b329
	defb 000h,000h,028h,040h	; b32d
	defb 020h,000h,010h,040h	; b331
	defb 018h,000h,018h,040h	; b335
	defb 010h,000h,020h,040h	; b339
	defb 008h,000h,028h,040h	; b33d
	defb 010h,010h,00ch,010h	; b341
	defb 010h,010h,00ch,010h	; b345
	defb 010h,000h,00ch,010h	; b349
	defb 010h,000h,00ch,010h	; b34d
	defb 010h,030h,00ch,010h	; b351
	defb 010h,030h,00ch,010h	; b355
	defb 010h,010h,00ch,010h	; b359
	defb 010h,010h,00ch,010h	; b35d
	defb 010h,000h,00ch,010h	; b361
	defb 010h,000h,00ch,010h	; b365
	defb 010h,030h,00ch,010h	; b369
	defb 010h,030h,00ch,010h	; b36d
	defb 008h,000h,010h,010h	; b371

; ----------------------------------------------------------------------
; DATOS tabla_B375: 50 bytes que p02:8B78 lee con A (si es 0x35 o mas, A -
;   0x16); lo leen p02:8B84 (50 bytes)
;   0xb375..0xb3a7  (50 bytes)
DATA_tabla_B375:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,010h,010h	; b375  ..........
	defb 010h,010h,010h,010h,010h,010h,000h,000h,000h,000h	; b37f  ..........
	defb 000h,0f8h,000h,0f8h,000h,000h,000h,0f8h,000h,0f8h	; b389  ..........
	defb 000h,000h,000h,000h,0f8h,000h,0f8h,0f8h,0f8h,0f8h	; b393  ..........
	defb 0f8h,0f8h,0f8h,000h,000h,000h,000h,000h,000h,000h	; b39d  ..........

; ======================================================================
; CODIGO 0xb3a7..0xb3b6  (15 bytes)
; ======================================================================


clase_9:		; la clase 9: con X de 0x20 en adelante, lo de su paso (p03:B3B6) salvo el 5
	ld a,(ix+006h)		;b3a7   ; cerca del borde izquierdo, nada
	cp 020h		;b3aa
	ret c			;b3ac
	ld a,(ix+001h)		;b3ad   ; el paso 5, nada
	cp 005h		;b3b0
	ret z			;b3b2
	call 04084h		;b3b3   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B3B6: 5 destinos del despachador p00:4084 (call en p03:B3B3, el
;   indice en A): B3C0, B3C0, B3D0, B3EA, B407; lo leen p03:B3B3 (10 bytes)
;   0xb3b6..0xb3c0  (10 bytes)
DATA_tabla_B3B6:
	defw 0b3c0h,0b3c0h,0b3d0h,0b3eah,0b407h	; b3b6

; ======================================================================
; CODIGO 0xb3c0..0xb495  (213 bytes)
; ======================================================================


clase_9_abre:		; al acabar la espera, la forma + 1 y al paso siguiente con 8 cuadros
	dec (ix+002h)		;b3c0   ; la espera
	ret nz			;b3c3
	inc (ix+007h)		;b3c4   ; abre un paso
	ld a,008h		;b3c7
clase_9_siguiente:		; el paso siguiente con espera A
	inc (ix+001h)		;b3c9
	ld (ix+002h),a		;b3cc
	ret			;b3cf
clase_9_suelta:		; suelta los tipo 7 (p03:B407); sin quedar ninguno, se cierra
	call clase_9_suelta_uno		;b3d0   ; clase_9_suelta_uno: cada 8 cuadros (4 si es el primero) un tipo 7 en fila desde su boca, arriba o abajo segun IX+0B
	ld a,(ix+00ch)		;b3d3   ; quedan por soltar?
	and a			;b3d6
	ret nz			;b3d7
	dec (ix+007h)		;b3d8   ; se cierra un paso
	ld a,008h		;b3db
	jr clase_9_siguiente		;b3dd
clase_9_cierra:		; segun el paso, la forma - 1 o no, y al siguiente
	ld a,(ix+001h)		;b3df
	cp 002h		;b3e2   ; en el paso 2, cierra
	ld a,008h		;b3e4   ; 8 cuadros
	jr z,L_B402		;b3e6
	jr L_B405		;b3e8
clase_9_espera:		; al acabar la espera: IX+01 = 0xFF, 5 por soltar y la forma - 1 (y la espera 0x40 - 2 x nivel)
	dec (ix+002h)		;b3ea   ; la espera
	ret nz			;b3ed
	call marca_de_fila		;b3ee   ; marca_de_fila: IX+0F = 1: el siguiente tipo 7 empieza una fila
	ld (ix+001h),0ffh		;b3f1   ; sin paso
	ld (ix+00ch),005h		;b3f5   ; 5 por soltar
	ld b,040h		;b3f9   ; 0x40 - 2 x nivel
	ld a,(0e228h)		;b3fb   ; lee el nivel de dificultad
	add a,a			;b3fe
	neg		;b3ff
	add a,b			;b401
L_B402:
	dec (ix+007h)		;b402
L_B405:
	jr clase_9_siguiente		;b405
clase_9_suelta_uno:		; cada 8 cuadros (4 si es el primero) un tipo 7 en fila desde su boca, arriba o abajo segun IX+0B
	ld a,(ix+00bh)		;b407   ; arriba o abajo
	ld (0e35ah),a		;b40a   ; guarda la altura de la fila del tipo 7
	ld a,(ix+00ch)		;b40d   ; sin mas, cierra
	and a			;b410
	jr z,clase_9_cierra		;b411
	dec (ix+002h)		;b413   ; cada 8 cuadros
	ret nz			;b416
	ld (ix+002h),008h		;b417
	dec (ix+00ch)		;b41b   ; uno menos
	call fila_alterna		;b41e   ; la fila
	and a			;b421
	jr nz,L_B428		;b422
	ld (ix+002h),004h		;b424   ; el primero, 4
L_B428:
	ld a,(ix+004h)		;b428   ; la Y: 8 por encima o 16 por debajo
	ld c,0f8h		;b42b   ; la boca: 8 por encima
	bit 0,(ix+00bh)		;b42d
	jr z,L_B435		;b431
	ld c,010h		;b433   ; o 16 por debajo
L_B435:
	add a,c			;b435
	ld e,a			;b436
	ld a,(ix+006h)		;b437   ; la X + 8
	ld c,008h		;b43a
	add a,c			;b43c
	ld d,a			;b43d
	ld c,000h		;b43e
	ld a,007h		;b440   ; un tipo 7
	call 04d16h		;b442   ; crea_enemigo_ix: crea_enemigo conservando IX
	ret nz			;b445   ; sin sitio: la fila se corta
	jr marca_de_fila		;b446
clase_9_empieza:		; la clase 9: forma 0x15 + 3 x IX+0B, 6 x 3, 52 cuadros de espera y 5 por soltar
	call marca_de_fila		;b448   ; marca_de_fila: IX+0F = 1: el siguiente tipo 7 empieza una fila
	ld a,(ix+00bh)		;b44b   ; la forma: 0x15 + 3 x IX+0B
	ld c,a			;b44e
	add a,a			;b44f
	add a,c			;b450
	ld c,015h		;b451
	add a,c			;b453
	ld (ix+007h),a		;b454
	ld (ix+008h),006h		;b457   ; 6 x 3
	ld (ix+002h),034h		;b45b   ; 52 cuadros
	ld (ix+009h),006h		;b45f
	ld (ix+00ah),003h		;b463
	ld (ix+00ch),005h		;b467   ; 5 por soltar
	ret			;b46b
marca_de_fila:		; IX+0F = 1: el siguiente tipo 7 empieza una fila
	ld (ix+00fh),001h		;b46c
	ret			;b470
fila_alterna:		; IX+0F cambia y se pasa a 0xE35C; esta ficha en 0xE35D
	ld a,(ix+00fh)		;b471   ; alterna
	xor 001h		;b474
	ld (ix+00fh),a		;b476
	ld (0e35ch),a		;b479   ; guarda la cuenta de la fila del tipo 7
	push ix		;b47c   ; esta ficha
	pop hl			;b47e
	ld (0e35dh),hl		;b47f   ; guarda el primero de la fila del tipo 7 y el byte siguiente (16 bits)
	ret			;b482
clase_1:		; la clase 1: al llegar a X 0x20, p03:B5FF; lo de su paso (p03:B495)
	ld (ix+00fh),000h		;b483   ; IX+0F = 0
	ld a,(ix+006h)		;b487   ; al llegar a X 0x20
	cp 020h		;b48a
	call z,clase_1_borde		;b48c   ; clase_1_borde: al llegar al borde izquierdo con scroll, se cierra (pasos 10) o se queda sin caja
	ld a,(ix+001h)		;b48f   ; por paso
	call 04084h		;b492   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B495: 11 destinos del despachador p00:4084 (call en p03:B492, el
;   indice en A): B4B9, B4B9, B4AB, B50B, B57A, B514, B584, B51C, B5C5, B5DE,
;   B625; lo leen p03:B492 (22 bytes)
;   0xb495..0xb4ab  (22 bytes)
DATA_tabla_B495:
	defw 0b4b9h,0b4b9h,0b4abh,0b50bh,0b57ah,0b514h,0b584h,0b51ch	; b495
	defw 0b5c5h,0b5deh,0b625h	; b4a5  -> clase_1_rota clase_1_se_va clase_1_cierra

; ======================================================================
; CODIGO 0xb4ab..0xb4fb  (80 bytes)
; ======================================================================


clase_1_espera:		; al acabar la espera, 4 cuadros y la caja 2
	dec (ix+002h)		;b4ab
	ret nz			;b4ae
L_B4AF:
	ld (ix+002h),004h		;b4af   ; 4 cuadros
	ld (ix+00eh),002h		;b4b3   ; caja 2
	jr L_B4E7		;b4b7
clase_1_cajas:		; cada 8 cuadros; la caja segun la vuelta (0xE20A) y las opciones
	dec (ix+002h)		;b4b9
	ret nz			;b4bc
	ld (ix+002h),008h		;b4bd   ; 8 cuadros
L_B4C1:
	ld a,(0e20ah)		;b4c1   ; de la segunda vuelta en adelante, 6
	cp 002h		;b4c4
	ld b,006h		;b4c6
	jr nc,clase_1_pon_caja		;b4c8
	ld b,002h		;b4ca   ; si no, 2, o 1 con dos opciones
	ld a,(0e40bh)		;b4cc   ; lee las opciones
	cp 002h		;b4cf
	jr c,clase_1_pon_caja		;b4d1
	ld b,001h		;b4d3
	jr clase_1_pon_caja		;b4d5
clase_1_caja_por_opciones:		; la caja: 2 sin opciones, 1 con una, 0 con dos
	ld b,002h		;b4d7   ; 2 sin opciones
	ld a,(0e40bh)		;b4d9   ; lee las opciones
	and a			;b4dc
	jr z,clase_1_pon_caja		;b4dd
	dec b			;b4df   ; 1 con una, 0 con dos
	dec a			;b4e0
	jr z,clase_1_pon_caja		;b4e1
	dec b			;b4e3
clase_1_pon_caja:		; IX+0E = B, la forma + 1 y al paso siguiente
	ld (ix+00eh),b		;b4e4
L_B4E7:
	inc (ix+007h)		;b4e7   ; la forma siguiente
	inc (ix+001h)		;b4ea
caja_de_la_forma:		; IX+0D = la caja de la forma IX+07 (p03:B4FB)
	ld a,(ix+007h)		;b4ed   ; su caja
	ld hl,0b4fbh		;b4f0
	call 0407ah		;b4f3   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;b4f6
	ld (ix+00dh),a		;b4f7
	ret			;b4fa

; ----------------------------------------------------------------------
; DATOS tabla_B4FB: 16 bytes que p03:B4ED lee con IX+07 y pone en IX+0D (0xFF:
;   nada); lo leen p03:B4F3 (16 bytes)
;   0xb4fb..0xb50b  (16 bytes)
DATA_tabla_B4FB:
	defb 0ffh,0ffh,0ffh,001h,002h,003h,003h,0ffh,0ffh,0ffh,0ffh,004h,005h,006h,006h,0ffh	; b4fb  ................

; ======================================================================
; CODIGO 0xb50b..0xb6d1  (454 bytes)
; ======================================================================


clase_1_paso_con_2_opciones:		; sin dos opciones no suelta (IX+0F = 1); luego p03:B52D
	ld a,(0e40bh)		;b50b   ; con dos opciones
	cp 002h		;b50e
	jr nc,clase_1_dispara		;b510
	jr L_B529		;b512
clase_1_paso_sin_opciones:		; con opciones no suelta; luego p03:B52D
	ld a,(0e40bh)		;b514   ; sin opciones
	and a			;b517
	jr nz,clase_1_dispara		;b518
	jr L_B529		;b51a
clase_1_paso_con_opciones:		; sin opciones, o con escudo, no suelta; luego p03:B52D
	ld a,(0e40bh)		;b51c   ; con opciones
	and a			;b51f
	jr z,clase_1_dispara		;b520
	ld a,(0e400h)		;b522   ; y sin escudo
	cp 002h		;b525
	jr nc,clase_1_dispara		;b527
L_B529:
	ld (ix+00fh),001h		;b529   ; no suelta
clase_1_dispara:		; al acabar la espera, un 0x1D desde su boca (p03:B6D5) hacia la nave (si suelta) y la espera siguiente segun el paso, la vuelta, el escudo y el nivel
	dec (ix+002h)		;b52d   ; la espera
	ret nz			;b530
	ld a,(ix+003h)		;b531   ; su lado, a 0xE35D
	ld (0e35dh),a		;b534   ; guarda el primero de la fila del tipo 7
	call clase_1_cuenta		;b537   ; la cuenta
	cp 003h		;b53a   ; cada 3, otro ciclo
	jp z,clase_1_ciclo		;b53c   ; clase_1_ciclo: cada 3 disparos, otra forma y la espera de nuevo
	call boca_de_clase_1		;b53f   ; la boca
	bit 0,(ix+00fh)		;b542
	jr nz,clase_1_espera_siguiente		;b546
	ld a,01dh		;b548   ; un 0x1D
	ld c,000h		;b54a
	call 04d16h		;b54c   ; crea_enemigo_ix: crea_enemigo conservando IX
clase_1_espera_siguiente:		; un disparo mas (IX+0E) y la espera segun el paso, la vuelta, el escudo y el nivel
	inc (ix+00eh)		;b54f   ; un disparo mas
	ld b,001h		;b552   ; la espera: 1 en los primeros pasos
	ld a,(ix+001h)		;b554
	cp 006h		;b557
	jr c,L_B576		;b559
	ld b,004h		;b55b   ; 4 con la vuelta
	ld a,(0e20ah)		;b55d   ; lee la vuelta (bit 0: las fases bajan)
	and a			;b560
	jr nz,L_B576		;b561
	ld b,00fh		;b563   ; 15, o con escudo 12 - nivel / 2
	ld a,(0e400h)		;b565   ; lee la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	cp 002h		;b568
	jr nz,L_B576		;b56a
	ld a,(0e228h)		;b56c   ; lee el nivel de dificultad
	srl a		;b56f
	ld c,a			;b571
	ld a,00ch		;b572
	sub c			;b574
	ld b,a			;b575
L_B576:
	ld (ix+002h),b		;b576
	ret			;b579
clase_1_dispara_balas:		; como p03:B52D y ademas una bala especial (tipo 0x82, 12 cuadros sin chocar, color 10) hacia la nave
	ld a,(0e40bh)		;b57a   ; sin opciones, no suelta
	and a			;b57d
	jr nz,L_B584		;b57e
	ld (ix+00fh),001h		;b580
L_B584:
	dec (ix+002h)		;b584   ; la espera
	ret nz			;b587
	ld a,(ix+003h)		;b588
	ld (0e35dh),a		;b58b   ; guarda el primero de la fila del tipo 7
	call clase_1_cuenta		;b58e   ; clase_1_cuenta: IX+0C + 1 (de 0 a 3) y a 0xE35C
	ld a,(ix+00eh)		;b591   ; cada 3, otro ciclo
	cp 003h		;b594
	jp z,clase_1_ciclo_b		;b596   ; clase_1_ciclo_b: como p03:B630 para el paso 6
	call boca_de_clase_1		;b599   ; boca_de_clase_1: D/E = su posicion + el desplazamiento de la boca segun la caja (p03:B6D5)
	push de			;b59c
	call rumbo_cerca_de_la_nave		;b59d   ; el rumbo hacia la nave
	pop de			;b5a0
	call clase_1_espera_siguiente		;b5a1   ; el disparo
	bit 0,(ix+00fh)		;b5a4
	ret nz			;b5a8
	call 093b1h		;b5a9   ; y una bala
	push ix		;b5ac
	push hl			;b5ae
	pop ix		;b5af
	ld bc,0fff4h		;b5b1
	add ix,bc		;b5b4
	ld (ix+000h),082h		;b5b6   ; tipo 0x82: no choca
	ld (ix+002h),00ch		;b5ba   ; 12 cuadros
	ld (ix+00ch),00ah		;b5be   ; color 10
	pop ix		;b5c2
	ret			;b5c4
clase_1_rota:		; la forma 7 o 15 (segun IX+03), 13 cuadros y sin caja
	inc (ix+001h)		;b5c5   ; al paso siguiente
	ld a,007h		;b5c8   ; la forma rota: 7 o 15
	bit 0,(ix+003h)		;b5ca
	jr nz,L_B5D2		;b5ce
	ld a,00fh		;b5d0
L_B5D2:
	ld (ix+007h),a		;b5d2
	ld (ix+002h),00dh		;b5d5   ; 13 cuadros
	ld (ix+00dh),0ffh		;b5d9   ; sin caja
	ret			;b5dd
clase_1_se_va:		; al acabar la espera, libre; con IX+0B deja una capsula especial (la 5 con 1, la 3 si no)
	dec (ix+002h)		;b5de   ; la espera
	ret nz			;b5e1
L_B5E2:
	ld (ix+000h),000h		;b5e2   ; libre
	ld a,(ix+00bh)		;b5e6   ; sin IX+0B, nada
	or a			;b5e9
	ret z			;b5ea
	ld b,a			;b5eb
	ld a,(ix+004h)		;b5ec   ; Y + 16
	add a,010h		;b5ef
	ld e,a			;b5f1
	ld d,(ix+006h)		;b5f2
	ld c,005h		;b5f5   ; 1: la capsula 5; si no, la 3
	dec b			;b5f7
	jr z,L_B5FC		;b5f8
	ld c,003h		;b5fa
L_B5FC:
	jp 05157h		;b5fc   ; pon_capsula: la capsula especial C del mapa en D (X), E (Y) (0xEA60-0xEA62), si no hay otra, ni cuenta atras, ni R.DRILL
clase_1_borde:		; al llegar al borde izquierdo con scroll, se cierra (pasos 10) o se queda sin caja
	ld a,(0e320h)		;b5ff   ; solo con scroll
	and a			;b602
	ret z			;b603
	ld a,(ix+001h)		;b604   ; antes del paso 6, sin caja
	cp 006h		;b607
	jr c,L_B620		;b609
	cp 008h		;b60b
	ret nc			;b60d
	ld (ix+001h),00ah		;b60e   ; pasos 6-7: a cerrarse (paso 10), 6 veces
	ld (ix+00eh),006h		;b612
L_B616:
	ld (ix+002h),004h		;b616   ; 4 cuadros y la forma - 1
	dec (ix+007h)		;b61a
	jp caja_de_la_forma		;b61d   ; caja_de_la_forma: IX+0D = la caja de la forma IX+07 (p03:B4FB)
L_B620:
	ld (ix+00dh),0ffh		;b620
	ret			;b624
clase_1_cierra:		; cada 4 cuadros la forma - 1; al acabar, se va
	dec (ix+002h)		;b625   ; la espera
	ret nz			;b628
	dec (ix+00eh)		;b629   ; una vez menos
	jr z,L_B5E2		;b62c
	jr L_B616		;b62e
clase_1_ciclo:		; cada 3 disparos, otra forma y la espera de nuevo
	ld (ix+002h),004h		;b630   ; 4 cuadros
	ld a,(ix+001h)		;b634
	cp 007h		;b637   ; en el paso 7
	jp nz,L_B4AF		;b639
	dec (ix+001h)		;b63c   ; dos pasos atras
	dec (ix+001h)		;b63f
clase_1_espera_por_nivel:		; IX+02 = 16 - nivel / 2, la forma - 1 y la caja
	ld a,(0e228h)		;b642   ; 16 - nivel / 2
	srl a		;b645   ; nivel / 2
	neg		;b647
	add a,010h		;b649   ; 16 menos
	ld (ix+002h),a		;b64b
	dec (ix+007h)		;b64e   ; la forma - 1
	jp L_B4C1		;b651
clase_1_ciclo_b:		; como p03:B630 para el paso 6
	ld (ix+002h),004h		;b654   ; 4 cuadros
	bit 1,(ix+003h)		;b658
	ld a,(ix+001h)		;b65c   ; en el paso 6
	cp 006h		;b65f
	jp nz,L_B4AF		;b661
	jr clase_1_espera_por_nivel		;b664
clase_1_cuenta:		; IX+0C + 1 (de 0 a 3) y a 0xE35C
	ld a,(ix+00ch)		;b666   ; de 0 a 3
	inc a			;b669
	and 003h		;b66a
	ld (ix+00ch),a		;b66c
	ld (0e35ch),a		;b66f   ; guarda la cuenta de la fila del tipo 7
	ret			;b672
boca_de_clase_1:		; D/E = su posicion + el desplazamiento de la boca segun la caja (p03:B6D5)
	ld hl,0b6d5h		;b673   ; la boca segun la caja
	ld a,(ix+00dh)		;b676
	dec a			;b679
	add a,a			;b67a
	call 0407ah		;b67b   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;b67e
	inc hl			;b67f
	ld e,(ix+004h)		;b680   ; Y + el desplazamiento
	add a,e			;b683
	ld e,a			;b684
	ld a,(hl)			;b685
	ld d,(ix+006h)		;b686   ; X + el desplazamiento
	add a,d			;b689
	ld d,a			;b68a
	ret			;b68b
rumbo_cerca_de_la_nave:		; la velocidad (rapidez 0x60) hacia la nave mas o menos un desplazamiento (p03:B6D1)
	ld hl,0b6d1h		;b68c   ; el desplazamiento segun la cuenta
	ld a,(0e35ch)		;b68f   ; lee la cuenta de la fila del tipo 7
	call 0407ah		;b692   ; hl_mas_a: HL = HL + A
	ld l,(hl)			;b695
	ld a,(0e35dh)		;b696   ; los lados 0 y 3: por encima
	and a			;b699
	jr z,L_B6C8		;b69a
	cp 003h		;b69c
	jr z,L_B6C8		;b69e
	ld a,(0e404h)		;b6a0   ; los demas: por debajo de la nave
	add a,l			;b6a3
	ld h,a			;b6a4
	jr nc,L_B6AB		;b6a5
L_B6A7:
	ld a,(0e404h)		;b6a7   ; lee la Y de la nave
	ld h,a			;b6aa
L_B6AB:
	ld a,(0e406h)		;b6ab   ; lee la X de la nave
	ld l,a			;b6ae
	ld a,060h		;b6af   ; rapidez 0x60
	ld e,(ix+004h)		;b6b1
	ld d,(ix+006h)		;b6b4
	ld (0f00fh),a		;b6b7   ; guarda la rapidez del disparo
	ld a,h			;b6ba
	ld (0f000h),a		;b6bb   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,l			;b6be
	ld (0f001h),a		;b6bf   ; guarda variable de paso: cuantos bytes
	call 09467h		;b6c2   ; el angulo y la velocidad
	jp 093fbh		;b6c5   ; rumbo_del_angulo: la velocidad del angulo ya calculado (0xF017), con error del nivel 7 en adelante
L_B6C8:
	ld a,(0e404h)		;b6c8   ; lee la Y de la nave
	sub l			;b6cb   ; por encima de la nave
	ld h,a			;b6cc
	jr nc,L_B6AB		;b6cd
	jr L_B6A7		;b6cf

; ----------------------------------------------------------------------
; DATOS tabla_B6D1: 4 bytes que p03:B68C lee con 0xE35C; lo leen p03:B692 (4
;   bytes)
;   0xb6d1..0xb6d5  (4 bytes)
DATA_tabla_B6D1:
	defb 000h,010h,020h,010h	; b6d1

; ----------------------------------------------------------------------
; DATOS tabla_B6D5: 6 pares que p03:B673 lee con IX+0D - 1; lo leen p03:B67B
;   (12 bytes)
;   0xb6d5..0xb6e1  (12 bytes)
DATA_tabla_B6D5:
	defb 018h,008h	; b6d5
	defb 010h,008h	; b6d7
	defb 008h,008h	; b6d9
	defb 010h,010h	; b6db
	defb 018h,010h	; b6dd
	defb 020h,010h	; b6df

; ======================================================================
; CODIGO 0xb6e1..0xb98c  (683 bytes)
; ======================================================================


tipo_1d_empieza:		; el tipo 0x1D: sin tocar los disparos, hacia la nave, 12 cuadros sin chocar con el mapa
	res 1,(ix+010h)		;b6e1   ; no lo tocan los disparos
	call rumbo_cerca_de_la_nave		;b6e5   ; rumbo_cerca_de_la_nave: la velocidad (rapidez 0x60) hacia la nave mas o menos un desplazamiento (p03:B6D1)
pon_rumbo_y_espera:		; 12 cuadros con IX+2F = 1 y la velocidad de 0xF012/0xF014
	ld (ix+002h),00ch		;b6e8   ; 12 cuadros
	ld (ix+02fh),001h		;b6ec   ; sin chocar con el mapa
	ld de,(0f014h)		;b6f0   ; lee la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,(0f012h)		;b6f4   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	jp 04f26h		;b6f7   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_1d:		; los tipos 0x1D y 0x22: al acabar la espera, ya chocan con el mapa (IX+2F = 0)
	ld a,(ix+001h)		;b6fa   ; en el paso 0
	and a			;b6fd
	ret nz			;b6fe
	dec (ix+002h)		;b6ff   ; la espera
	ret nz			;b702
	ld (ix+02fh),000h		;b703   ; ya choca
	inc (ix+001h)		;b707
	ret			;b70a
bala_especial:		; la bala 0x82: al acabar IX+02, pasa a ser normal (choca con el mapa)
	bit 7,(ix+000h)		;b70b   ; el bit 7: aun no choca
	ret z			;b70f
	dec (ix+002h)		;b710   ; la espera
	ret nz			;b713
	res 7,(ix+000h)		;b714   ; ya choca
	ret			;b718
clase_1_empieza:		; la clase 1: la forma 0 (u 8 arriba), 7 golpes, 5 x 6, 48 cuadros y sin caja
	ld a,(ix+004h)		;b719   ; por debajo de Y 0x28: forma 0
	cp 028h		;b71c
	ld bc,00001h		;b71e
	jr nc,L_B726		;b721
	ld bc,00800h		;b723   ; arriba: forma 8
L_B726:
	ld (ix+007h),b		;b726
	ld (ix+003h),c		;b729
	ld b,007h		;b72c   ; 7 golpes
	ld a,(0e20ah)		;b72e   ; el `ld` no toca las banderas: este `jr z` mira el `cp 028h` de antes (10 golpes solo con Y = 0x28)
	jr z,L_B735		;b731
	ld b,00ah		;b733
L_B735:
	ld (ix+008h),b		;b735
	ld (ix+002h),030h		;b738   ; 48 cuadros
	ld (ix+009h),005h		;b73c   ; 5 x 6
	ld (ix+00ah),006h		;b740
	xor a			;b744   ; cuenta 0
	ld (ix+00ch),a		;b745
	dec a			;b748   ; sin caja
	ld (ix+00dh),a		;b749
	ret			;b74c
clase_10_empieza:		; la clase 10: la forma 0x1D en la fase 7 (0x38 en las demas, + 1 con IX+0B), 8 golpes, 4 x 3, 48 cuadros
	ld c,01dh		;b74d   ; en la fase 7, 0x1D
	ld a,(0e201h)		;b74f   ; lee la fase (0-11)
	cp 007h		;b752
	jr z,L_B758		;b754
	ld c,038h		;b756   ; en las demas, 0x38
L_B758:
	ld a,(ix+00bh)		;b758
	and a			;b75b
	jr z,L_B75F		;b75c
	inc c			;b75e   ; + 1 con IX+0B
L_B75F:
	ld (ix+007h),c		;b75f
	ld (ix+008h),008h		;b762   ; 8 golpes
	ld (ix+009h),004h		;b766   ; 4 x 3
	ld (ix+00ah),003h		;b76a
	ld (ix+002h),030h		;b76e   ; 48 cuadros
	ret			;b772
clase_10:		; la clase 10: al acabar la espera suelta 6 tipo 0x10 por su boca, uno cada 6 cuadros, y espera 96
	ld a,(ix+001h)		;b773   ; el paso
	dec a			;b776
	jr z,L_B789		;b777
	dec (ix+002h)		;b779   ; paso 0: la espera
	ret nz			;b77c
	inc (ix+001h)		;b77d   ; 6 a soltar, cada 6 cuadros
	ld (ix+002h),006h		;b780
	ld (ix+00ch),006h		;b784
	ret			;b788
L_B789:
	dec (ix+002h)		;b789   ; paso 1
	ret nz			;b78c
	ld (ix+002h),006h		;b78d
	ld a,(ix+004h)		;b791   ; la boca: arriba (-12) o abajo (+20)
	ld bc,000f4h		;b794
	bit 0,(ix+00bh)		;b797
	jr z,L_B7A0		;b79b
	ld bc,00114h		;b79d
L_B7A0:
	add a,c			;b7a0
	ld e,a			;b7a1
	ld a,(ix+006h)		;b7a2   ; X + 8
	add a,008h		;b7a5
	ld d,a			;b7a7
	ld a,010h		;b7a8   ; un 0x10
	ld c,000h		;b7aa
	call 04d16h		;b7ac   ; crea_enemigo_ix: crea_enemigo conservando IX
	dec (ix+00ch)		;b7af   ; uno menos
	ret nz			;b7b2
	ld (ix+002h),060h		;b7b3   ; 96 cuadros y otra vez
	ld (ix+001h),000h		;b7b7
	ret			;b7bb
tipo_10_empieza:		; el tipo 0x10: salta hacia arriba o abajo (IX+19), 16 cuadros, y su espera de disparo
	ld (ix+002h),010h		;b7bc   ; 16 cuadros
	ld a,(ix+006h)		;b7c0   ; la X de salida
	ld (ix+026h),a		;b7c3
	call 04e93h		;b7c6   ; la espera de disparo
	ld (ix+015h),a		;b7c9
	ld a,(ix+004h)		;b7cc
	bit 0,(ix+019h)		;b7cf   ; hacia abajo y a la derecha
	jr z,L_B7DE		;b7d3
	ld hl,00480h		;b7d5
	ld de,00300h		;b7d8
	jp 04f26h		;b7db   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
L_B7DE:
	ld hl,0fb80h		;b7de   ; o hacia arriba y a la izquierda
	ld de,0fd00h		;b7e1
	jp 04f26h		;b7e4   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_10:		; el tipo 0x10: se frena hacia el punto de salida, luego sale hacia la nave (0x70 + 2 x nivel) y dispara
	call tipo_10_dibujo		;b7e7   ; su dibujo
	call tipo_10_dispara		;b7ea   ; dispara
	ld a,(ix+001h)		;b7ed   ; el paso
	dec a			;b7f0
	jr z,L_B80D		;b7f1
	dec a			;b7f3
	ret z			;b7f4
	call con_el_scroll_1		;b7f5   ; paso 0: con el scroll y frena en X
	call frena_en_x		;b7f8   ; frena_en_x: la aceleracion X hacia IX+26 (4 x la distancia) y la suma
	dec (ix+002h)		;b7fb
	ret nz			;b7fe
	ld (ix+002h),05ah		;b7ff   ; 90 cuadros, desde su Y
	ld a,(ix+004h)		;b803
	ld (ix+025h),a		;b806
	inc (ix+001h)		;b809
	ret			;b80c
L_B80D:
	call con_el_scroll_1		;b80d   ; paso 1: frena en Y y en X
	call frena_en_y		;b810   ; frena_en_y: la aceleracion Y hacia IX+25 (4 x la distancia) y la suma
	dec (ix+002h)		;b813
	ret nz			;b816
	ld e,070h		;b817   ; rapidez 0x70 + 2 x nivel
	ld a,(0e228h)		;b819   ; lee el nivel de dificultad
	add a,a			;b81c
	add a,e			;b81d
	ld e,(ix+004h)		;b81e
	ld d,(ix+006h)		;b821
	call 093f5h		;b824   ; hacia la nave
	inc (ix+001h)		;b827
	ld hl,(0f012h)		;b82a   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	ld de,(0f014h)		;b82d   ; lee la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	jp 04f26h		;b831   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_10_dibujo:		; el dibujo: 0x58 + 4 x (cuadro & 3)
	ld a,(0e1c3h)		;b834   ; cada cuadro, uno de 4
	and 003h		;b837   ; uno de 4
	add a,a			;b839
	add a,a			;b83a
	add a,058h		;b83b   ; desde 0x58
	ld (ix+030h),a		;b83d
	ret			;b840
tipo_10_dispara:		; al acabar IX+15, dispara (p03:BB44) y otra espera al azar
	dec (ix+015h)		;b841   ; la espera
	ret nz			;b844
	call dispara_desde_ix		;b845   ; dispara_desde_ix: una bala desde el enemigo IX (X + 8) hacia la nave
	call 04e93h		;b848   ; azar_por_nivel: A = p00:4EA4[0xE228] + un azar de 0 a 7 (R)
	ld (ix+015h),a		;b84b
	ret			;b84e
frena_en_y:		; la aceleracion Y hacia IX+25 (4 x la distancia) y la suma
	ld h,000h		;b84f   ; en 16 bits con signo
	ld a,(ix+025h)		;b851   ; la Y objetivo menos la suya
	sub (ix+004h)		;b854
	jr nc,L_B85A		;b857
	dec h			;b859
L_B85A:
	ld l,a			;b85a
	add hl,hl			;b85b   ; x 4
	add hl,hl			;b85c
	ex de,hl			;b85d
	call 062a8h		;b85e   ; pon_aceleracion: IX+20/IX+21 = DE
	call 062c2h		;b861   ; acelera_vy: IX+07/IX+08 + IX+20/IX+21
frena_en_x:		; la aceleracion X hacia IX+26 (4 x la distancia) y la suma
	ld h,000h		;b864   ; en 16 bits con signo
	ld a,(ix+026h)		;b866   ; la X objetivo menos la suya
	sub (ix+006h)		;b869
	jr nc,L_B86F		;b86c
	dec h			;b86e
L_B86F:
	ld l,a			;b86f
	add hl,hl			;b870   ; x 4
	add hl,hl			;b871
	ex de,hl			;b872
	call 062afh		;b873   ; pon_aceleracion_b: IX+20/IX+21 = DE
	jp 062d5h		;b876   ; acelera_vx: IX+09/IX+0A + IX+20/IX+21
con_el_scroll_1:		; X - 1 y el punto IX+26 tambien
	dec (ix+006h)		;b879   ; X - 1
	ld a,(ix+026h)		;b87c   ; y el objetivo
	and a			;b87f
	ret z			;b880
	dec (ix+026h)		;b881
	ret			;b884
clase_4_empieza:		; la clase 4: 8 golpes, 3 x 1, sin caja y una espera al azar (0x20-0x2F)
	ld (ix+008h),008h		;b885   ; 8 golpes
	ld (ix+009h),003h		;b889   ; 3 x 1
	ld (ix+00ah),001h		;b88d
	ld (ix+00dh),0ffh		;b891   ; sin caja
	ld a,r		;b895   ; 32-47 cuadros
	and 00fh		;b897
	add a,020h		;b899
	ld (ix+002h),a		;b89b
	ret			;b89e
clase_4:		; la clase 4: al acabar la espera suelta un 0x1F (con IX+0B) por arriba o por abajo, y otra espera segun el nivel
	ld a,(ix+001h)		;b89f   ; el paso
	dec a			;b8a2
	jr z,L_B8D4		;b8a3
	dec a			;b8a5
	jr z,L_B8E0		;b8a6
	dec (ix+002h)		;b8a8   ; paso 0: la espera
	ret nz			;b8ab
	ld de,00808h		;b8ac   ; por debajo (+8) o por encima (-8)
	bit 0,(ix+00bh)		;b8af
	jr nz,L_B8B7		;b8b3
	ld e,0f8h		;b8b5
L_B8B7:
	ld a,(ix+004h)		;b8b7
	add a,e			;b8ba
	ld e,a			;b8bb
	ld a,(ix+006h)		;b8bc   ; X + 8
	add a,d			;b8bf
	ld d,a			;b8c0
	ld c,000h		;b8c1
	ld a,(ix+00bh)		;b8c3   ; con IX+0B
	ld b,a			;b8c6
	ld a,01fh		;b8c7   ; un 0x1F
	call 04d16h		;b8c9   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld (ix+002h),018h		;b8cc   ; 24 cuadros
	inc (ix+001h)		;b8d0
	ret			;b8d3
L_B8D4:
	dec (ix+002h)		;b8d4   ; paso 1: espera
	ret nz			;b8d7   ; la espera
	ld (ix+002h),004h		;b8d8
	inc (ix+001h)		;b8dc   ; al paso siguiente
	ret			;b8df
L_B8E0:
	dec (ix+002h)		;b8e0   ; paso 2: la siguiente espera, 24 - nivel / 2 + azar
	ret nz			;b8e3
	ld a,r		;b8e4   ; 0-7 al azar
	and 007h		;b8e6
	ld c,a			;b8e8
	ld a,(0e228h)		;b8e9   ; lee el nivel de dificultad
	rra			;b8ec   ; + 24 - (nivel / 2) & 7
	and 007h		;b8ed
	sub 018h		;b8ef
	neg		;b8f1
	add a,c			;b8f3
	ld (ix+002h),a		;b8f4
	ld (ix+001h),000h		;b8f7   ; al paso 0
	ret			;b8fb
tipo_1f_empieza:		; el tipo 0x1F: dibujo 0x80 (0x74 arriba), con el scroll, 24 cuadros quieto y animado
	ld c,080h		;b8fc   ; dibujo 0x80, o 0x74 arriba
	bit 0,(ix+019h)		;b8fe
	jr z,L_B906		;b902
	ld c,074h		;b904
L_B906:
	ld (ix+030h),c		;b906
	ld (ix+002h),000h		;b909   ; con el scroll
	set 3,(ix+010h)		;b90d
	ld (ix+025h),018h		;b911   ; 24 cuadros
	call 04f17h		;b915   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	jr L_B976		;b918
tipo_1f:		; el tipo 0x1F: se abre (dibujo + 4 a los 8 y a los 0 cuadros) y sale hacia arriba o abajo frenando
	call tipo_1f_color		;b91a   ; su color
	ld a,(ix+001h)		;b91d   ; el paso
	dec a			;b920
	jr z,tipo_1f_frena		;b921
	dec (ix+025h)		;b923   ; paso 0: la espera
	ld a,(ix+025h)		;b926
	cp 008h		;b929   ; a los 8, se abre un poco
	jr z,dibujo_mas_4		;b92b
	and a			;b92d
	ret nz			;b92e
	call dibujo_mas_4		;b92f   ; a los 0, del todo y sale
	inc (ix+001h)		;b932
tipo_1f_sale:		; sin scroll, velocidad Y 0x0400 o 0xFC00 y 30 cuadros
	res 3,(ix+010h)		;b935   ; ya sin el scroll
	bit 0,(ix+019h)		;b939
	jr z,L_B944		;b93d
	ld de,00400h		;b93f   ; hacia abajo
	jr L_B947		;b942
L_B944:
	ld de,0fc00h		;b944   ; o hacia arriba
L_B947:
	call 04efbh		;b947   ; pon_vy: IX+07/IX+08 = DE
	ld (ix+025h),01eh		;b94a   ; 30 cuadros
	ret			;b94e
dibujo_mas_4:		; IX+30 + 4
	ld a,(ix+030h)		;b94f
	add a,004h		;b952   ; el dibujo siguiente
	ld (ix+030h),a		;b954
	ret			;b957
tipo_1f_frena:		; 0x20 menos de velocidad Y por cuadro; al acabar, otra vez
	dec (ix+025h)		;b958   ; paso 1: frena
	jr z,tipo_1f_sale		;b95b
	ld de,00020h		;b95d
	bit 0,(ix+019h)		;b960
	call nz,05cadh		;b964   ; menos_de: DE = - DE
	ex de,hl			;b967
	call 04f10h		;b968   ; lee_vy: DE = IX+07/IX+08
	add hl,de			;b96b
	ex de,hl			;b96c
	jp 04efbh		;b96d   ; pon_vy: IX+07/IX+08 = DE
tipo_1f_color:		; cada 4 cuadros el color siguiente de p03:B98C (6)
	ld a,(0e1c3h)		;b970   ; cada 4 cuadros
	and 003h		;b973
	ret nz			;b975
L_B976:
	ld a,(ix+002h)		;b976   ; 6 colores
	inc a			;b979
	cp 006h		;b97a   ; 6 colores
	jr c,L_B97F		;b97c
	xor a			;b97e
L_B97F:
	ld (ix+002h),a		;b97f
	ld hl,0b98ch		;b982   ; de p03:B98C
	call 05ca6h		;b985   ; byte_a: A = el byte A de la tabla HL
	ld (ix+031h),a		;b988
	ret			;b98b

; ----------------------------------------------------------------------
; DATOS tabla_B98C: 6 bytes que p03:B976 lee con IX+02 (de 0 a 5) y pone en
;   IX+31; lo leen p03:B985 (6 bytes)
;   0xb98c..0xb992  (6 bytes)
DATA_tabla_B98C:
	defb 008h,009h,00ah,00fh,00ah,009h	; b98c

; ======================================================================
; CODIGO 0xb992..0xbb78  (486 bytes)
; ======================================================================


clase_5:		; la clase 5: suelta tipo 0x22 cada 4 cuadros (p03:B9E8) y sube y baja entre IX+0F y 0x58 abriendose y cerrandose
	ld a,(ix+006h)		;b992   ; lejos del borde izquierdo, suelta
	cp 028h		;b995
	call nc,clase_5_suelta		;b997   ; clase_5_suelta: cada IX+01 cuadros un 0x22 por su boca; cada 16, una pausa de 52
	dec (ix+002h)		;b99a   ; la espera
	jr z,L_B9AE		;b99d
	ld a,(ix+002h)		;b99f   ; a la mitad, abierta (0x11) y la caja
	cp (ix+00ch)		;b9a2
	ret nz			;b9a5
	ld (ix+007h),011h		;b9a6
	inc (ix+00dh)		;b9aa
	ret			;b9ad
L_B9AE:
	ld a,(ix+00ch)		;b9ae   ; el doble de espera
	add a,a			;b9b1
	ld (ix+002h),a		;b9b2
	dec (ix+00dh)		;b9b5
	bit 7,(ix+00eh)		;b9b8   ; subiendo o bajando
	jr nz,L_B9D6		;b9bc
	ld (ix+007h),012h		;b9be   ; baja: forma 0x12 y 8 pixeles
	ld a,(ix+004h)		;b9c2
	add a,008h		;b9c5
	ld (ix+004h),a		;b9c7
	cp 058h		;b9ca   ; hasta 0x58: da la vuelta
	ret nz			;b9cc
L_B9CD:
	ld a,(ix+00eh)		;b9cd
	neg		;b9d0   ; da la vuelta
	ld (ix+00eh),a		;b9d2
	ret			;b9d5
L_B9D6:
	ld (ix+007h),010h		;b9d6   ; sube: forma 0x10, hasta IX+0F
	ld a,(ix+004h)		;b9da
	sub 008h		;b9dd
	ld (ix+004h),a		;b9df
	cp (ix+00fh)		;b9e2   ; hasta su Y de arriba
	ret nz			;b9e5
	jr L_B9CD		;b9e6
clase_5_suelta:		; cada IX+01 cuadros un 0x22 por su boca; cada 16, una pausa de 52
	dec (ix+001h)		;b9e8   ; la espera
	ret nz			;b9eb
	dec (ix+003h)		;b9ec   ; cada 16
	ld a,004h		;b9ef
	jr nz,L_B9F9		;b9f1
	ld a,034h		;b9f3   ; una pausa de 52
	ld (ix+003h),010h		;b9f5
L_B9F9:
	ld (ix+001h),a		;b9f9
	call boca_de_clase_5		;b9fc   ; boca_de_clase_5: D/E = su posicion + 16 en Y y - 4 en X
	ld a,022h		;b9ff   ; un 0x22
	ld c,000h		;ba01
	jp 04d16h		;ba03   ; crea_enemigo_ix: crea_enemigo conservando IX
boca_de_clase_5:		; D/E = su posicion + 16 en Y y - 4 en X
	ld a,010h		;ba06   ; Y + 16
	add a,(ix+004h)		;ba08
	ld e,a			;ba0b
	ld a,0fch		;ba0c   ; X - 4
	add a,(ix+006h)		;ba0e
	ld d,a			;ba11
	ret			;ba12
clase_5_empieza:		; la clase 5: la forma 0x10, 40 golpes, 4 x 5, caja 7, el ritmo segun IX+0B
	ld a,(ix+00bh)		;ba13   ; el ritmo: 2 x IX+0B + 2
	add a,a			;ba16
	add a,002h		;ba17
	ld (ix+00ch),a		;ba19
	add a,a			;ba1c   ; la espera, el doble
	ld (ix+002h),a		;ba1d
	ld (ix+00eh),001h		;ba20   ; bajando
	ld (ix+007h),010h		;ba24   ; forma 0x10, 40 golpes
	ld (ix+008h),028h		;ba28
	ld (ix+001h),004h		;ba2c
	ld (ix+009h),004h		;ba30   ; 4 x 5
	ld (ix+00ah),005h		;ba34
	ld (ix+003h),010h		;ba38
	ld (ix+00dh),007h		;ba3c   ; caja 7
	ld a,(ix+004h)		;ba40   ; la Y de arriba
	ld (ix+00fh),a		;ba43
	ret			;ba46
tipo_22_empieza:		; el tipo 0x22: hacia la izquierda (vx 0xFC00), 12 cuadros sin chocar
	ld hl,00000h		;ba47   ; vy 0
	ld (0f012h),hl		;ba4a   ; guarda la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	ld hl,0fc00h		;ba4d   ; vx 0xFC00
	ld (0f014h),hl		;ba50   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	jp pon_rumbo_y_espera		;ba53   ; pon_rumbo_y_espera: 12 cuadros con IX+2F = 1 y la velocidad de 0xF012/0xF014
tipo_20_empieza:		; el tipo 0x20: 4 x 2 caracteres, IX+10 = 0x1B; sube o baja 8 pixeles cada 16 cuadros (8 con B)
	ld (ix+010h),01bh		;ba56   ; IX+10 = 0x1B
	ld (ix+014h),004h		;ba5a   ; 4 x 2
	ld (ix+013h),002h		;ba5e
	ld a,(ix+019h)		;ba62   ; cada 16 cuadros, 8 con B
	and a			;ba65
	ld a,010h		;ba66
	jr z,L_BA6C		;ba68
	ld a,008h		;ba6a
L_BA6C:
	ld (ix+028h),a		;ba6c
	ld (ix+02ah),a		;ba6f
	ld (ix+029h),008h		;ba72   ; baja 8
	ld a,(ix+004h)		;ba76   ; o sube 8 desde la mitad de abajo
	cp 068h		;ba79
	ret c			;ba7b
	ld (ix+029h),0f8h		;ba7c
	ret			;ba80
tipo_20:		; el tipo 0x20: espera hasta X < 0xD8 y luego sube o baja a saltos, rebotando en el mapa
	ld a,(ix+001h)		;ba81   ; paso 0
	dec a			;ba84
	jr z,L_BA91		;ba85
	ld a,(ix+006h)		;ba87   ; hasta X < 0xD8
	cp 0d8h		;ba8a
	ret nc			;ba8c
	inc (ix+001h)		;ba8d
	ret			;ba90
L_BA91:
	dec (ix+028h)		;ba91   ; paso 1: la espera
	ret nz			;ba94
	call tipo_20_rebota		;ba95   ; rebota en el mapa
	ld a,(ix+02ah)		;ba98
	ld (ix+028h),a		;ba9b
	ld a,(ix+004h)		;ba9e   ; sube o baja
	add a,(ix+029h)		;baa1
	ld (ix+004h),a		;baa4
	ret			;baa7
tipo_20_rebota:		; si delante (arriba o abajo) hay mapa, da la vuelta
	bit 7,(ix+029h)		;baa8   ; bajando
	jr nz,L_BAC4		;baac
	ld a,(ix+004h)		;baae   ; el de debajo
	add a,010h		;bab1
L_BAB3:
	ld l,a			;bab3
	ld h,(ix+006h)		;bab4
	call 083e8h		;bab7   ; mapa?
	ret nc			;baba
	ld a,(ix+029h)		;babb   ; da la vuelta
	neg		;babe
	ld (ix+029h),a		;bac0
	ret			;bac3
L_BAC4:
	ld a,(ix+004h)		;bac4   ; subiendo: el de encima
	sub 008h		;bac7
	jr L_BAB3		;bac9
tipo_31_empieza:		; el tipo 0x31: 16 cuadros, su Y, hacia la izquierda y abajo (o arriba desde la mitad)
	ld (ix+025h),010h		;bacb   ; 16 cuadros
	ld a,(ix+004h)		;bacf   ; su Y
	ld (ix+026h),a		;bad2
	cp 058h		;bad5   ; por encima de la mitad: hacia abajo
	ld hl,00400h		;bad7
	jr c,L_BAE6		;bada
	ld a,(ix+019h)		;badc   ; por debajo: otra direccion y hacia arriba
	add a,006h		;badf
	ld (ix+019h),a		;bae1
	ld h,004h		;bae4
L_BAE6:
	ld de,0fd60h		;bae6   ; vx 0xFD60
	jp 04f26h		;bae9   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_31:		; el tipo 0x31: oscila alrededor de su Y; en el borde izquierdo da la vuelta en una direccion de p03:BB84 y dispara (del nivel 9, mas)
	call tipo_31_dibujo		;baec   ; su dibujo
	ld a,(ix+001h)		;baef   ; el paso
	dec a			;baf2
	jr z,L_BB3D		;baf3
	dec a			;baf5
	ret z			;baf6
	ld a,(0e228h)		;baf7   ; del nivel 9, dispara mas
	cp 009h		;bafa
	call nc,tipo_31_dispara_mas		;bafc   ; tipo_31_dispara_mas: del nivel 9 en adelante, cada 9 cuadros
	ld (ix+001h),000h		;baff
	ld a,(ix+026h)		;bb03   ; oscila alrededor de su Y
	ld de,00070h		;bb06
	call 09c27h		;bb09   ; oscila_en_y: la velocidad Y + o - DE hacia la Y A
	ld a,(ix+006h)		;bb0c   ; hasta el borde izquierdo
	cp 020h		;bb0f
	ret nc			;bb11
	ld (ix+025h),008h		;bb12   ; 8 cuadros
	inc (ix+001h)		;bb16
	ld a,(0e228h)		;bb19   ; rapidez 4, 6 del nivel 6
	ld b,004h		;bb1c
	cp 006h		;bb1e
	jr c,L_BB24		;bb20
	ld b,006h		;bb22
L_BB24:
	ld a,(ix+019h)		;bb24   ; la direccion de p03:BB84
	ld hl,0bb84h		;bb27
	call 05ca6h		;bb2a   ; byte_a: A = el byte A de la tabla HL
	call 04cb7h		;bb2d   ; velocidad_en_direccion: para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
	jp 04f26h		;bb30   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_31_dispara_mas:		; del nivel 9 en adelante, cada 9 cuadros
	ld a,(ix+025h)		;bb33   ; cada 9 cuadros
	and a			;bb36
	jr nz,L_BB3D		;bb37
	ld (ix+025h),009h		;bb39
L_BB3D:
	dec (ix+025h)		;bb3d   ; la espera
	ret nz			;bb40
	inc (ix+001h)		;bb41
dispara_desde_ix:		; una bala desde el enemigo IX (X + 8) hacia la nave
	ld e,(ix+004h)		;bb44   ; desde el enemigo
	ld a,(ix+006h)		;bb47   ; X + 8
	add a,008h		;bb4a
	ld d,a			;bb4c
	jp 0938fh		;bb4d   ; dispara_bala: una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
tipo_31_dibujo:		; la animacion de su fase (p03:BB78, BB7C la 5, BB80 la 3) y el color cambia cada 4 cuadros
	ld hl,0bb78h		;bb50
	ld a,(0e201h)		;bb53   ; la fase 5
	cp 005h		;bb56
	jr z,L_BB63		;bb58
	cp 003h		;bb5a   ; la fase 3
	jr nz,L_BB66		;bb5c
	ld hl,0bb80h		;bb5e
	jr L_BB66		;bb61
L_BB63:
	ld hl,0bb7ch		;bb63
L_BB66:
	call 09b31h		;bb66   ; animacion_4: el dibujo de la tabla HL: un paso cada 4 cuadros (IX+24), 4 pasos
	ld a,(0e1c3h)		;bb69   ; cada 4 cuadros
	and 003h		;bb6c
	ret nz			;bb6e
	ld a,(ix+031h)		;bb6f   ; cambia de color
	xor 004h		;bb72
	ld (ix+031h),a		;bb74
	ret			;bb77

; ----------------------------------------------------------------------
; DATOS tablas_BB78: tres tablas de 4 bytes que p03:BB50 pasa a L_9B31:
;   0xBB78, 0xBB7C en la fase 5 y 0xBB80 en la 3; lo leen p03:BB66 (12 bytes)
;   0xbb78..0xbb84  (12 bytes)
DATA_tablas_BB78:
	defb 0b4h,0b8h,0bch,0c0h	; bb78
	defb 090h,094h,098h,09ch	; bb7c
	defb 07ch,080h,084h,088h	; bb80

; ----------------------------------------------------------------------
; DATOS tabla_BB84: 12 bytes que p03:BB24 lee con IX+19; lo leen p03:BB2A (12
;   bytes)
;   0xbb84..0xbb90  (12 bytes)
DATA_tabla_BB84:
	defb 000h,00fh,00eh,00dh,00eh,00fh,000h,001h,002h,003h,002h,001h	; bb84  ............

; ======================================================================
; CODIGO 0xbb90..0xbc5d  (205 bytes)
; ======================================================================


clase_6_empieza:		; la clase 6: la forma 0x13, 48 golpes, 4 x 4, sube y baja 1 (2 del nivel 6)
	ld (ix+007h),013h		;bb90   ; forma 0x13
	ld (ix+008h),030h		;bb94   ; 48 golpes
	ld (ix+009h),004h		;bb98   ; 4 x 4
	ld (ix+00ah),004h		;bb9c
	ld (ix+00dh),000h		;bba0   ; caja 0
	ld (ix+002h),001h		;bba4
	ld a,(0e228h)		;bba8   ; 1, o 2 del nivel 6
	cp 006h		;bbab
	ld a,001h		;bbad
	jr c,L_BBB2		;bbaf
	inc a			;bbb1
L_BBB2:
	ld (ix+00eh),a		;bbb2
	ret			;bbb5
clase_6:		; la clase 6: dispara y sube y baja entre Y 0x30 y 0x60
	call clase_6_dispara		;bbb6   ; dispara
	ld a,(ix+004h)		;bbb9   ; en 0x60 o 0x30 da la vuelta
	cp 060h		;bbbc
	jr z,L_BBC4		;bbbe
	cp 030h		;bbc0
	jr nz,L_BBCC		;bbc2
L_BBC4:
	ld a,(ix+00eh)		;bbc4
	neg		;bbc7
	ld (ix+00eh),a		;bbc9
L_BBCC:
	ld a,(ix+004h)		;bbcc   ; sube o baja
	add a,(ix+00eh)		;bbcf
	ld (ix+004h),a		;bbd2
	ret			;bbd5
clase_6_dispara:		; cada 18 cuadros (12 del nivel 6) una bala hacia la nave
	dec (ix+002h)		;bbd6   ; la espera
	ret nz			;bbd9
	ld e,(ix+004h)		;bbda   ; desde X - 8
	ld a,(ix+006h)		;bbdd
	sub 008h		;bbe0
	ld d,a			;bbe2
	ld (ix+002h),012h		;bbe3   ; 18 cuadros
	ld a,(0e228h)		;bbe7   ; lee el nivel de dificultad
	cp 006h		;bbea
	jp c,0938fh		;bbec   ; dispara_bala: una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
	ld (ix+002h),00ch		;bbef   ; 12 del nivel 6
	jp 0938fh		;bbf3   ; dispara_bala: una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
tipo_16_empieza:		; el tipo 0x16: hacia la izquierda (vx 0xFA00 y 40 cuadros; 0xFC00 y 24 por debajo del nivel 6)
	ld de,0fa00h		;bbf6   ; vx 0xFA00, 40 cuadros
	ld a,(0e228h)		;bbf9   ; lee el nivel de dificultad
	cp 006h		;bbfc
	ld a,028h		;bbfe
	jr nc,L_BC06		;bc00
	ld d,0fch		;bc02   ; por debajo del nivel 6: 0xFC00, 24
	ld a,018h		;bc04
L_BC06:
	ld (ix+027h),a		;bc06   ; la frenada
	call 04f02h		;bc09   ; pon_vx: IX+09/IX+0A = DE
	jp 04f1ch		;bc0c   ; vy_cero: IX+07/IX+08 = 0
tipo_16:		; el tipo 0x16: frena, se para, suelta 3 balas en abanico (p03:BC5D) y sale acelerando
	call tipo_16_dibujo		;bc0f   ; su dibujo
	ld a,(ix+001h)		;bc12   ; el paso
	dec a			;bc15
	jr z,L_BC2C		;bc16
	dec a			;bc18
	jr z,$+74		;bc19
	dec a			;bc1b
	jr z,$+105		;bc1c
	call tipo_16_frena		;bc1e   ; paso 0: frena hasta pararse
	rl h		;bc21
	ret c			;bc23
	ld (ix+025h),020h		;bc24   ; 32 cuadros
	inc (ix+001h)		;bc28
	ret			;bc2b
L_BC2C:
	call tipo_16_frena		;bc2c   ; paso 1: sigue frenando
	dec (ix+025h)		;bc2f
	ret nz			;bc32
	inc (ix+001h)		;bc33   ; parado: 3 balas
	ld (ix+025h),004h		;bc36
	call 04f21h		;bc3a   ; vx_cero: IX+09/IX+0A = 0
	ld hl,0bc5dh		;bc3d   ; en abanico
	ld b,003h		;bc40
L_BC42:
	push bc			;bc42
	xor a			;bc43   ; la velocidad Y de la tabla
	ld b,(hl)			;bc44
	ld c,a			;bc45
	inc hl			;bc46
	ld d,(hl)			;bc47   ; la X
	ld e,a			;bc48
	inc hl			;bc49
	push hl			;bc4a
	ex de,hl			;bc4b
	ld e,(ix+004h)		;bc4c   ; desde su sitio
	ld a,(ix+006h)		;bc4f   ; X + 8
	add a,008h		;bc52
	ld d,a			;bc54
	call 0937dh		;bc55   ; la bala con su velocidad
	pop hl			;bc58
	pop bc			;bc59
	djnz L_BC42		;bc5a   ; 3 balas
	ret			;bc5c

; ----------------------------------------------------------------------
; DATOS tabla_BC5D: 3 pares que p03:BC3D recorre; lo leen p03:BC44 (6 bytes)
;   0xbc5d..0xbc63  (6 bytes)
DATA_tabla_BC5D:
	defb 0feh,0feh	; bc5d
	defb 000h,0feh	; bc5f
	defb 002h,0feh	; bc61

; ======================================================================
; CODIGO 0xbc63..0xbd55  (242 bytes)
; ======================================================================


tipo_16_sale:		; al acabar la espera, vx 0xFC00 (0xFA00 del nivel 6)
	dec (ix+025h)		;bc63   ; la espera
	ret nz			;bc66
	inc (ix+001h)		;bc67   ; al paso siguiente
	ld (ix+025h),008h		;bc6a
	ld a,(0e228h)		;bc6e   ; vx 0xFC00, 0xFA00 del nivel 6
	cp 006h		;bc71
	ld de,0fc00h		;bc73
	jr c,L_BC7A		;bc76
	ld d,0fah		;bc78
L_BC7A:
	jp 04f02h		;bc7a   ; pon_vx: IX+09/IX+0A = DE
tipo_16_frena:		; la velocidad X + IX+27
	ld d,000h		;bc7d
	ld e,(ix+027h)		;bc7f
	jp 09d50h		;bc82   ; suma_a_vx: la velocidad X + DE
tipo_16_dispara:		; al acabar la espera, dispara (cada 16 cuadros, 8 del nivel 6)
	dec (ix+025h)		;bc85   ; la espera
	ret nz			;bc88
	ld a,(0e228h)		;bc89   ; 16 cuadros, 8 del nivel 6
	cp 006h		;bc8c
	ld (ix+025h),010h		;bc8e
	jp c,dispara_desde_ix		;bc92   ; dispara_desde_ix: una bala desde el enemigo IX (X + 8) hacia la nave
	ld (ix+025h),008h		;bc95
	jp dispara_desde_ix		;bc99   ; dispara_desde_ix: una bala desde el enemigo IX (X + 8) hacia la nave
tipo_16_dibujo:		; cada 4 cuadros el dibujo siguiente (0xDC-0xE4)
	ld a,(0e1c3h)		;bc9c   ; cada 4 cuadros
	and 003h		;bc9f
	ret nz			;bca1
	ld a,(ix+030h)		;bca2   ; de 0xDC a 0xE4
	add a,004h		;bca5
	cp 0e8h		;bca7
	jr nz,L_BCAD		;bca9
	ld a,0dch		;bcab
L_BCAD:
	ld (ix+030h),a		;bcad
	ret			;bcb0
busca_el_vecino:		; mira los 4 slots (y sus subslots) buscando otro cartucho conocido: 0xF0F5 (y 0xE229 = 1 con Q*bert)
	xor a			;bcb1   ; nada al lado
	ld (0f0f5h),a		;bcb2   ; guarda lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	ld (0e229h),a		;bcb5   ; guarda la marca de Q*bert al lado
	ld bc,00400h		;bcb8   ; 4 slots
	ld hl,0fcc1h		;bcbb   ; EXPTBL
L_BCBE:
	push bc			;bcbe
	push hl			;bcbf
	ld a,(hl)			;bcc0
	bit 7,a		;bcc1   ; expandido?
	jr nz,L_BCD4		;bcc3
	call que_cartucho_hay		;bcc5   ; no: el slot
L_BCC8:
	pop hl			;bcc8
	pop bc			;bcc9
	ld a,(0f0f5h)		;bcca   ; encontrado: fuera
	and a			;bccd   ; encontrado: fuera
	ret nz			;bcce
	inc hl			;bccf   ; el slot siguiente
	inc c			;bcd0
	djnz L_BCBE		;bcd1
	ret			;bcd3
L_BCD4:
	call busca_en_subslots		;bcd4   ; si: sus subslots
	jr L_BCC8		;bcd7
busca_en_subslots:		; los 4 subslots del slot C
	and 080h		;bcd9   ; el slot expandido
	or c			;bcdb
	ld c,a			;bcdc
	ld b,004h		;bcdd   ; 4 subslots
L_BCDF:
	push bc			;bcdf
	call que_cartucho_hay		;bce0   ; que_cartucho_hay: en el slot C: los 6 bytes de 0x7FFA (bit 1), o la cabecera de 0x4010 de Maze of Galious (bit 3), Penguin Adventure (bit 2) o Q*bert (bit 0)
	pop bc			;bce3
	ld a,(0f0f5h)		;bce4   ; lee lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	and a			;bce7   ; encontrado: fuera
	ret nz			;bce8
	ld a,c			;bce9
	add a,004h		;bcea   ; el subslot siguiente (bits 2-3)
	ld c,a			;bcec
	djnz L_BCDF		;bced
	ret			;bcef
que_cartucho_hay:		; en el slot C: los 6 bytes de 0x7FFA (bit 1), o la cabecera de 0x4010 de Maze of Galious (bit 3), Penguin Adventure (bit 2) o Q*bert (bit 0)
	ld de,0bd55h		;bcf0   ; los 6 bytes de 0x7FFA
	ld hl,07ffah		;bcf3
	ld b,006h		;bcf6
	call compara_en_slot		;bcf8   ; compara_en_slot: C si los B bytes de HL del slot C son los de DE (RDSLT)
	jr nc,L_BD03		;bcfb
	ld hl,0f0f5h		;bcfd   ; bit 1
	set 1,(hl)		;bd00
	ret			;bd02
L_BD03:
	ld de,0bd5bh		;bd03   ; "CD 07 49": Maze of Galious
	ld hl,04010h		;bd06
	ld b,004h		;bd09
	call compara_en_slot		;bd0b   ; compara_en_slot: C si los B bytes de HL del slot C son los de DE (RDSLT)
	jr nc,L_BD16		;bd0e
	ld hl,0f0f5h		;bd10   ; bit 3
	set 3,(hl)		;bd13
	ret			;bd15
L_BD16:
	ld de,0bd5fh		;bd16   ; "CD 07 43": Penguin Adventure
	ld hl,04010h		;bd19
	ld b,004h		;bd1c
	call compara_en_slot		;bd1e   ; compara_en_slot: C si los B bytes de HL del slot C son los de DE (RDSLT)
	jr nc,L_BD29		;bd21
	ld hl,0f0f5h		;bd23   ; bit 2
	set 2,(hl)		;bd26
	ret			;bd28
L_BD29:
	ld de,0bd63h		;bd29   ; Q*bert
	ld hl,04010h		;bd2c
	ld b,004h		;bd2f
	call compara_en_slot		;bd31   ; compara_en_slot: C si los B bytes de HL del slot C son los de DE (RDSLT)
	ret nc			;bd34
	ld hl,0f0f5h		;bd35   ; bit 0
	set 0,(hl)		;bd38
	ld a,001h		;bd3a
	ld (0e229h),a		;bd3c   ; guarda la marca de Q*bert al lado
	ret			;bd3f
compara_en_slot:		; C si los B bytes de HL del slot C son los de DE (RDSLT)
	push bc			;bd40
	push de			;bd41
	ld a,c			;bd42   ; RDSLT
	call 0000ch		;bd43   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;bd46
	pop bc			;bd47
	ex de,hl			;bd48   ; compara
	cp (hl)			;bd49
	ex de,hl			;bd4a
	jr nz,L_BD53		;bd4b
	inc hl			;bd4d
	inc de			;bd4e
	djnz compara_en_slot		;bd4f
	scf			;bd51   ; todos iguales: C
	ret			;bd52
L_BD53:
	and a			;bd53   ; distinto: NC
	ret			;bd54

; ----------------------------------------------------------------------
; DATOS firmas_del_vecino: lo que p03:BCF0 busca en la otra ranura (RDSLT): 00
;   30 31 13 35 AA en 0x7FFA (bit 1 de 0xF0F5), y en 0x4010 "CD 07 49"
;   (RC-749, Maze of Galious: bit 3), "CD 07 43" (RC-743, Penguin Adventure:
;   bit 2) y "CD 07 46" (RC-746, Q*bert: bit 0 y 0xE229 = 1); lo leen p03:BD40
;   (18 bytes)
;   0xbd55..0xbd67  (18 bytes)
DATA_firmas_del_vecino:
	defb 000h,030h,031h,013h,035h,0aah	; bd55
	defb 043h,044h,007h,049h,043h,044h	; bd5b
	defb 007h,043h,043h,044h,007h,046h	; bd61

; ======================================================================
; CODIGO 0xbd67..0xbdd2  (107 bytes)
; ======================================================================


borra_lo_tecleado:		; lo tecleado a cero (0xE3E0, 0xE3E8-0xE3EF)
	push hl			;bd67
	push bc			;bd68
	ld hl,00000h		;bd69   ; ninguna tecla
	ld (0e3e0h),hl		;bd6c   ; guarda cuantas teclas hay en el bufer y el byte siguiente (16 bits)
	ld hl,0e3e8h		;bd6f   ; el bufer a cero
	ld b,008h		;bd72
L_BD74:
	ld (hl),000h		;bd74   ; a cero
	inc hl			;bd76
	djnz L_BD74		;bd77
	pop bc			;bd79
	pop hl			;bd7a
	ret			;bd7b
teclea_en_pausa:		; en la pausa, con Q*bert al lado (0xF0F5 bit 0): cada tecla nueva al bufer 0xE3E8 (8); con RETURN busca la palabra clave (p03:BEAA)
	ld a,(0e400h)		;bd7c   ; sin nave, nada
	and a			;bd7f
	ret m			;bd80
	ld a,(0f0f5h)		;bd81   ; solo con Q*bert al lado
	bit 0,a		;bd84
	ret z			;bd86
	call tecla_pulsada		;bd87   ; la tecla
	and a			;bd8a
	ret z			;bd8b
	ld hl,0e3e1h		;bd8c   ; la misma de antes: nada
	cp (hl)			;bd8f
	ret z			;bd90
	ld (hl),a			;bd91
	ld c,a			;bd92
	cp 00dh		;bd93   ; RETURN
	jr z,L_BDA7		;bd95
	ld hl,0e3e0h		;bd97   ; como mucho 8
	ld a,(hl)			;bd9a
	cp 008h		;bd9b
	ret nc			;bd9d
	inc (hl)			;bd9e
	ld hl,0e3e8h		;bd9f   ; al bufer
	call 0407ah		;bda2   ; hl_mas_a: HL = HL + A
	ld (hl),c			;bda5
	ret			;bda6
L_BDA7:
	ld hl,borra_lo_tecleado		;bda7   ; al acabar, el bufer a cero
	push hl			;bdaa
	ld bc,00300h		;bdab   ; 3 palabras
L_BDAE:
	push bc			;bdae
	call compara_palabra		;bdaf   ; compara_palabra: C si lo tecleado no es la palabra C (LARS18TH, NEMESIS o METALION)
	pop bc			;bdb2
	jr nc,L_BDCE		;bdb3   ; encontrada
	inc c			;bdb5
	djnz L_BDAE		;bdb6
	ret			;bdb8
compara_palabra:		; C si lo tecleado no es la palabra C (LARS18TH, NEMESIS o METALION)
	ld hl,0beaah		;bdb9   ; la palabra C
	ld a,c			;bdbc
	call 04b67h		;bdbd   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,0e3e8h		;bdc0   ; apunta a el bufer de lo tecleado (8)
L_BDC3:
	ld a,(de)			;bdc3   ; hasta su RETURN
	cp 00dh		;bdc4   ; RETURN: igual
	ret z			;bdc6
	cp (hl)			;bdc7   ; compara
	inc de			;bdc8
	inc hl			;bdc9
	jr z,L_BDC3		;bdca
	scf			;bdcc   ; distinta: C
	ret			;bdcd
L_BDCE:
	ld a,c			;bdce   ; la de la palabra
	call 04084h		;bdcf   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_BDD2: 3 destinos del despachador p00:4084 (call en p03:BDCF, el
;   indice en A): BDD8, BE87, BE90; lo leen p03:BDCF (6 bytes)
;   0xbdd2..0xbdd8  (6 bytes)
DATA_tabla_BDD2:
	defw 0bdd8h,0be87h,0be90h	; bdd2  -> clave_lars18th clave_nemesis clave_metalion

; ======================================================================
; CODIGO 0xbdd8..0xbe07  (47 bytes)
; ======================================================================


clave_lars18th:		; LARS18TH: el medidor y las armas enteras segun las capturadas (p03:BE07), escudo, velocidad 2 y dos opciones
	ld a,(0e20fh)		;bdd8   ; 16 bytes por cuenta de capturadas
	add a,a			;bddb
	add a,a			;bddc
	add a,a			;bddd
	add a,a			;bdde
	ld hl,0be07h		;bddf
	call 0407ah		;bde2   ; hl_mas_a: HL = HL + A
	ld de,0e334h		;bde5   ; el medidor
	ld bc,00009h		;bde8
	ldir		;bdeb
	ld de,0e430h		;bded   ; las armas
	ld bc,00007h		;bdf0
	ldir		;bdf3
	call 08060h		;bdf5   ; las casillas
	call 081b5h		;bdf8   ; escudo, velocidad y opciones
	call 0448eh		;bdfb   ; los dibujos de las opciones
	ld a,(0e20fh)		;bdfe   ; con 4 capturadas, los del arma 5
	cp 004h		;be01
	ret nz			;be03
	jp 04482h		;be04   ; sprites_arma_5: con los bancos 7-8-9, los dibujos del arma 5 de 0xE432 (p08:93EE) desde el sprite 24, en lugar de las opciones

; ----------------------------------------------------------------------
; DATOS inicio_por_capturas: 8 filas de 16 bytes, una por cada cuenta de armas
;   capturadas (0xE20F): p03:BDD8 copia 9 a 0xE334 y 7 a 0xE430; lo leen
;   p03:BDE2 (128 bytes)
;   0xbe07..0xbe87  (128 bytes)
DATA_inicio_por_capturas:
	defb 002h,0ffh,000h,0ffh,0ffh,0ffh,000h,000h,000h,000h,000h,002h,002h,000h,000h,000h	; be07  ................
	defb 002h,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,002h,002h,002h,000h,000h	; be17  ................
	defb 002h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,002h,000h,000h,002h,000h	; be27  ................
	defb 002h,0ffh,000h,0ffh,000h,0ffh,0ffh,0ffh,000h,000h,000h,002h,003h,002h,000h,000h	; be37  ................
	defb 002h,0ffh,0ffh,000h,000h,000h,0ffh,0ffh,000h,000h,000h,005h,003h,000h,000h,000h	; be47  ................
	defb 002h,0ffh,000h,0ffh,000h,0ffh,0ffh,0ffh,000h,000h,000h,003h,003h,002h,000h,000h	; be57  ................
	defb 002h,0ffh,0ffh,000h,000h,000h,000h,0ffh,0ffh,001h,000h,000h,003h,000h,000h,001h	; be67  ................
	defb 002h,0ffh,000h,0ffh,0ffh,000h,000h,0ffh,000h,000h,000h,006h,003h,002h,000h,000h	; be77  ................

; ======================================================================
; CODIGO 0xbe87..0xbeaa  (35 bytes)
; ======================================================================


clave_nemesis:		; NEMESIS: pantalla en blanco y a la fase siguiente
	call 04a08h		;be87   ; pantalla en blanco
	call 04c76h		;be8a   ; sin sprites
	jp 07c11h		;be8d   ; a la fase siguiente
clave_metalion:		; METALION: la nave intocable 30 veces 32 cuadros (0xE446, 0xE447)
	ld hl,01e01h		;be90   ; 0xE446 = 1, 0xE447 = 30
	ld (0e446h),hl		;be93   ; guarda la marca de nave intocable y el byte siguiente (16 bits)
	ret			;be96
cuenta_intocable:		; cada 32 cuadros 0xE447 - 1; al acabar, 0xE446 = 0
	ld hl,0e446h		;be97   ; intocable?
	ld a,(hl)			;be9a
	or a			;be9b
	ret z			;be9c
	ld a,(0e1c3h)		;be9d   ; cada 32 cuadros
	and 01fh		;bea0
	ret nz			;bea2
	inc l			;bea3   ; uno menos
	dec (hl)			;bea4
	ret nz			;bea5
	dec l			;bea6
	ld (hl),000h		;bea7   ; se acabo
	ret			;bea9

; ----------------------------------------------------------------------
; DATOS palabras_clave: 3 punteros (C en p03:BDB9, con L_4B67) a las palabras
;   que se comparan con lo tecleado en 0xE3E8; lo leen p03:BDBD (6 bytes)
;   0xbeaa..0xbeb0  (6 bytes)
DATA_palabras_clave:
	defw 0beb0h,0beb9h,0bec1h	; beaa  -> DATA_textos_clave 0xbeb9 0xbec1

; ----------------------------------------------------------------------
; DATOS textos_clave: las tres palabras, acabadas en 0x0D: LARS18TH, NEMESIS y
;   METALION; lo leen p03:BDC3 (26 bytes)
;   0xbeb0..0xbeca  (26 bytes)
DATA_textos_clave:
	defb 04ch,041h,052h,053h,031h,038h,054h,048h,00dh	; beb0  LARS18TH.
	defb 04eh,045h,04dh,045h,053h,049h,053h,00dh,04dh	; beb9  NEMESIS.M
	defb 045h,054h,041h,04ch,049h,04fh,04eh,00dh	; bec2  ETALION.

; ======================================================================
; CODIGO 0xbeca..0xbef2  (40 bytes)
; ======================================================================


tecla_pulsada:		; A = el caracter de la primera tecla pulsada (p03:BEF2), o 0 sin ninguna
	ld b,008h		;beca   ; 8 filas
	ld e,000h		;becc
L_BECE:
	ld a,e			;bece
	call 00141h		;becf   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | la fila del teclado
	cpl			;bed2
	and a			;bed3
	jr nz,L_BEDE		;bed4   ; alguna pulsada
	inc e			;bed6
	djnz L_BECE		;bed7
	xor a			;bed9   ; ninguna
	ld (0e3e1h),a		;beda   ; guarda la ultima tecla
	ret			;bedd
L_BEDE:
	ld b,a			;bede   ; el caracter de la fila
	ld a,e			;bedf
	add a,a			;bee0
	add a,a			;bee1
	add a,a			;bee2
	ld hl,0bef2h		;bee3
	call 0407ah		;bee6   ; hl_mas_a: HL = HL + A
	ld a,b			;bee9
L_BEEA:
	rra			;beea   ; el primer bit pulsado
	jr c,L_BEF0		;beeb
	inc hl			;beed
	jr L_BEEA		;beee
L_BEF0:
	ld a,(hl)			;bef0
	ret			;bef1

; ----------------------------------------------------------------------
; DATOS teclado: 9 filas de 8: el caracter de cada tecla de la matriz del
;   teclado (p03:BEDE: 0xBEF2 + 8 x fila + bit), del 0 a la Z; lo leen
;   p03:BEE6 (72 bytes)
;   0xbef2..0xbf3a  (72 bytes)
DATA_teclado:
	defb 030h,031h,032h,033h,034h,035h,036h,037h	; bef2  01234567
	defb 038h,039h,02dh,05eh,009h,040h,05bh,03bh	; befa  89-^.@[.
	defb 03ah,05dh,02ch,02eh,02fh,05fh,041h,042h	; bf02  :],./_AB
	defb 043h,044h,045h,046h,047h,048h,049h,04ah	; bf0a  CDEFGHIJ
	defb 04bh,04ch,04dh,04eh,04fh,050h,051h,052h	; bf12  KLMNOPQR
	defb 053h,054h,055h,056h,057h,058h,059h,05ah	; bf1a  STUVWXYZ
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bf22  ........
	defb 000h,000h,000h,000h,000h,000h,000h,00dh	; bf2a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bf32  ........

; ======================================================================
; CODIGO 0xbf3a..0xbff6  (188 bytes)
; ======================================================================


fase_secreta:		; la entrada secreta de las fases 3, 6 y 10: al tocarla, el scroll se para 64 cuadros y luego corre cada cuadro (0xE3D0) hasta la fase 9, 10 u 11
	ld a,(0e400h)		;bf3a   ; sin nave, nada
	dec a			;bf3d
	ret m			;bf3e
	ld a,(0e3d0h)		;bf3f   ; entrando: espera
	and a			;bf42
	jr z,L_BF54		;bf43
	ld hl,0e3d5h		;bf45   ; apunta a la espera con el scroll parado
	dec (hl)			;bf48
	ret nz			;bf49
	ld a,002h		;bf4a   ; y luego el scroll corre cada cuadro
	ld (0e3d0h),a		;bf4c   ; guarda la fase secreta: 1 entrando (scroll parado), 2 yendo (scroll cada cuadro)
	ld a,03ch		;bf4f   ; suena 0x3C
	jp 04ae4h		;bf51   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_BF54:
	call aparece_la_entrada		;bf54   ; aparece?
	ld a,(0e3d1h)		;bf57   ; a la vista?
	and a			;bf5a
	ret z			;bf5b
	call nave_en_la_entrada		;bf5c   ; la toca y se mueve
	jp entrada_con_el_scroll		;bf5f   ; entrada_con_el_scroll: la entrada se corre 8 pixeles con el scroll; al salir, desaparece
aparece_la_entrada:		; en la columna de la fase (0x174 la 3, 0x164 la 6, 0xDF la 10) la entrada en Y 0x90, 0x88 o 0x30 y X 0xF0
	ld a,(0e320h)		;bf62   ; solo con scroll
	and a			;bf65
	ret z			;bf66
	ld a,(0e201h)		;bf67   ; lee la fase (0-11)
	ld hl,(0e203h)		;bf6a   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	cp 003h		;bf6d   ; la fase 3
	jr z,L_BF7A		;bf6f
	cp 006h		;bf71   ; la 6
	jr z,L_BF83		;bf73
	cp 00ah		;bf75   ; la 10
	jr z,L_BF8C		;bf77
	ret			;bf79
L_BF7A:
	ld de,00174h		;bf7a   ; en la columna 0x174, Y 0x90
	rst 20h			;bf7d
	ret nz			;bf7e   ; todavia no
	ld e,090h		;bf7f
	jr L_BF95		;bf81
L_BF83:
	ld de,00164h		;bf83   ; en la 0x164, Y 0x88
	rst 20h			;bf86
	ret nz			;bf87   ; todavia no
	ld e,088h		;bf88
	jr L_BF95		;bf8a
L_BF8C:
	ld de,000dfh		;bf8c   ; en la 0xDF, Y 0x30
	rst 20h			;bf8f
	ret nz			;bf90   ; todavia no
	ld e,030h		;bf91
	jr L_BF95		;bf93
L_BF95:
	ld hl,0e3d1h		;bf95   ; a la vista
	ld (hl),001h		;bf98
	inc l			;bf9a
	ld (hl),e			;bf9b
	inc l			;bf9c
	ld (hl),0f0h		;bf9d   ; X 0xF0
	ret			;bf9f
entrada_con_el_scroll:		; la entrada se corre 8 pixeles con el scroll; al salir, desaparece
	ld a,(0e320h)		;bfa0   ; lee la marca de scroll hecho en este cuadro
	and a			;bfa3
	ret z			;bfa4
	ld hl,0e3d3h		;bfa5   ; 8 pixeles a la izquierda
	ld a,(hl)			;bfa8
	sub 008h		;bfa9
	ld (hl),a			;bfab
	ret nc			;bfac
	dec l			;bfad   ; salio
	dec l			;bfae
	ld (hl),000h		;bfaf
	ret			;bfb1
nave_en_la_entrada:		; si la nave toca la entrada: el final del scroll (0x1FF, 0x1DF o 0x17F), scroll parado 64 cuadros, caen todos y silencio
	ld hl,0e3d2h		;bfb2   ; la Y de la nave, a +-8
	ld a,(0e404h)		;bfb5   ; lee la Y de la nave
	sub (hl)			;bfb8   ; la Y de la nave menos la de la entrada
	add a,008h		;bfb9
	cp 018h		;bfbb
	ret nc			;bfbd
	inc l			;bfbe
	ld a,(0e406h)		;bfbf   ; la X, 16 por delante
	sub (hl)			;bfc2   ; la X
	cp 010h		;bfc3
	ret nc			;bfc5
	ld a,(0e201h)		;bfc6   ; el nuevo final del scroll
	cp 003h		;bfc9   ; la fase 3: 0x1FF
	jr z,L_BFDB		;bfcb
	cp 006h		;bfcd   ; la 6: 0x1DF
	jr z,L_BFD6		;bfcf
	ld hl,0017fh		;bfd1   ; las demas: 0x17F
	jr L_BFDE		;bfd4
L_BFD6:
	ld hl,001dfh		;bfd6
	jr L_BFDE		;bfd9
L_BFDB:
	ld hl,001ffh		;bfdb
L_BFDE:
	ld (0e325h),hl		;bfde   ; guarda la columna en la que acaba el scroll (16 bits) y el byte siguiente (16 bits)
	ld a,040h		;bfe1   ; 64 cuadros parado
	ld (0e3d5h),a		;bfe3   ; guarda la espera con el scroll parado
	xor a			;bfe6   ; ya no se ve
	ld (0e3d1h),a		;bfe7   ; guarda la entrada secreta a la vista
	inc a			;bfea   ; entrando
	ld (0e3d0h),a		;bfeb   ; guarda la fase secreta: 1 entrando (scroll parado), 2 yendo (scroll cada cuadro)
	call 08fa2h		;bfee   ; caen todos
	ld a,043h		;bff1   ; silencio
	jp 04ae4h		;bff3   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS relleno_ff: 10 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (10 bytes)
;   0xbff6..0xc000  (10 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff6  ..........

; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 11 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa0f4  (244 bytes)
; ======================================================================


sprites_de_la_nave:		; la nave y sus opciones a la tabla de sprites (0xE280): sin nave ninguno; cayendo, la explosion; intocable parpadea al final; con escudo, el segundo sprite 8 pixeles delante
	ld de,0e280h		;a000   ; los sprites desde el primero
	ld a,(0e400h)		;a003   ; sin nave
	or a			;a006
	jr z,cuatro_escondidos		;a007
	jp m,explosion_a_sprites		;a009   ; cayendo
	ld hl,(0e446h)		;a00c   ; intocable acabandose?
	dec l			;a00f
	jr nz,L_A01E		;a010
	ld a,h			;a012
	cp 003h		;a013
	jr nc,L_A01E		;a015
	ld a,(0e1c3h)		;a017   ; parpadea
	bit 1,a		;a01a
	jr z,cuatro_escondidos		;a01c
L_A01E:
	ld hl,0e404h		;a01e   ; Y
	ldi		;a021
	inc l			;a023
	ldi		;a024   ; X
	ldi		;a026   ; dibujo y color
	ldi		;a028
	ld hl,0e404h		;a02a   ; apunta a la Y de la nave
	ld a,(0e400h)		;a02d   ; con escudo, el segundo sprite
	dec a			;a030
	jr z,L_A04B		;a031
	dec a			;a033
	jr nz,L_A04B		;a034
	ldi		;a036   ; Y
	inc l			;a038
	ld a,(0f0f5h)		;a039   ; con el pinguino, en el mismo sitio
	bit 2,a		;a03c
	ld b,008h		;a03e   ; si no, 8 pixeles delante
	jr z,L_A044		;a040
	ld b,000h		;a042
L_A044:
	ld a,(hl)			;a044   ; la X
	add a,b			;a045   ; + B
	ld (de),a			;a046
	inc e			;a047
	inc l			;a048
	jr L_A050		;a049
L_A04B:
	ldi		;a04b   ; el segundo sprite
	inc l			;a04d
	ldi		;a04e
L_A050:
	inc l			;a050
	inc l			;a051
	ldi		;a052   ; dibujo y color
	ldi		;a054
	ld hl,0e410h		;a056   ; la primera opcion
	call sprite_de_opcion		;a059   ; sprite_de_opcion: la opcion HL, si esta, a la tabla de sprites; si no, escondida
	ld hl,0e420h		;a05c   ; la segunda
sprite_de_opcion:		; la opcion HL, si esta, a la tabla de sprites; si no, escondida
	ld a,(hl)			;a05f   ; no esta
	or a			;a060
	jr z,esconde_un_sprite		;a061
	ld a,l			;a063   ; su Y
	add a,004h		;a064
	ld l,a			;a066
	ldi		;a067
	inc l			;a069
	ldi		;a06a   ; su X, dibujo y color
	ldi		;a06c
	ldi		;a06e
	ret			;a070
cuatro_escondidos:		; 4 sprites escondidos
	ld b,004h		;a071   ; 4 escondidos
L_A073:
	call esconde_un_sprite		;a073   ; esconde_un_sprite: Y = 0xE0 y el sprite siguiente
	djnz L_A073		;a076
	ret			;a078
explosion_a_sprites:		; los 4 sprites de la explosion de la nave (0xE418, 0xE428)
	ld hl,0e418h		;a079   ; dos de la explosion
	call copia_un_sprite_doble		;a07c   ; copia_un_sprite_doble: 8 bytes (dos sprites) de HL a DE
	ld hl,0e428h		;a07f   ; y otros dos
copia_un_sprite_doble:		; 8 bytes (dos sprites) de HL a DE
	ld bc,00008h		;a082
	ldir		;a085
	ret			;a087
sprites_de_disparos:		; los disparos de la nave que son sprites (tipos 3-5, 14 y el 6 en marcha) a 0xE290; los demas sprites, escondidos
	ld de,0e290h		;a088   ; desde el sprite 4
	ld hl,0e470h		;a08b   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	exx			;a08e
	ld bc,00906h		;a08f   ; 9 disparos, 6 sprites
L_A092:
	exx			;a092   ; cada disparo
	push hl			;a093
	call sprite_de_disparo		;a094   ; sprite_de_disparo: el disparo HL a la tabla de sprites si es de los que lo son (C' cuenta los que quedan)
	pop hl			;a097
	ld bc,00010h		;a098   ; 16 bytes por disparo
	add hl,bc			;a09b
	exx			;a09c
	djnz L_A092		;a09d
	ld a,c			;a09f   ; los que sobran
	exx			;a0a0
	or a			;a0a1   ; escondidos
	ret z			;a0a2   ; todos sprites: nada mas
	ld b,a			;a0a3
L_A0A4:
	call esconde_un_sprite		;a0a4   ; esconde_un_sprite: Y = 0xE0 y el sprite siguiente
	djnz L_A0A4		;a0a7
	ret			;a0a9
esconde_un_sprite:		; Y = 0xE0 y el sprite siguiente
	ld a,0e0h		;a0aa   ; Y = 0xE0
	ld (de),a			;a0ac   ; Y = 0xE0
	inc e			;a0ad   ; al sprite siguiente
	inc e			;a0ae
	inc e			;a0af
	inc e			;a0b0
	ret			;a0b1
sprite_de_disparo:		; el disparo HL a la tabla de sprites si es de los que lo son (C' cuenta los que quedan)
	ld a,(hl)			;a0b2   ; el tipo
	cp 00eh		;a0b3   ; el 14
	jr z,L_A0C0		;a0b5
	cp 006h		;a0b7   ; el 6, segun su paso
	jr z,L_A0D0		;a0b9
	sub 003h		;a0bb   ; los 3-5
	cp 003h		;a0bd
	ret nc			;a0bf
L_A0C0:
	inc l			;a0c0
L_A0C1:
	inc l			;a0c1
	inc l			;a0c2
	ldi		;a0c3   ; Y
	inc l			;a0c5
	ldi		;a0c6   ; X, dibujo y color
	ldi		;a0c8
	ldi		;a0ca
	exx			;a0cc
	dec c			;a0cd   ; uno menos
	exx			;a0ce
	ret			;a0cf
L_A0D0:
	inc l			;a0d0
	bit 0,(hl)		;a0d1   ; el 6 en el paso 0
	jr z,L_A0C1		;a0d3
	ret			;a0d5
guarda_fondo_disparos:		; el fondo bajo los 6 primeros disparos de caracteres, a 0xEC00
	ld ix,0e470h		;a0d6   ; 6 disparos
	ld de,0ec00h		;a0da   ; el fondo a 0xEC00
	ld b,006h		;a0dd
L_A0DF:
	push bc			;a0df
	call guarda_fondo_por_tipo		;a0e0   ; guarda_fondo_por_tipo: segun el tipo del disparo IX (p11:A0F4)
	ld bc,00010h		;a0e3   ; 16 bytes por disparo
	add ix,bc		;a0e6
	pop bc			;a0e8
	djnz L_A0DF		;a0e9
	ret			;a0eb
guarda_fondo_por_tipo:		; segun el tipo del disparo IX (p11:A0F4)
	ld a,(ix+000h)		;a0ec   ; libre
	dec a			;a0ef
	ret m			;a0f0
	call 04084h		;a0f1   ; por tipo

; ----------------------------------------------------------------------
; DATOS tabla_A0F4: 15 destinos del despachador p00:4084 (call en p11:A0F1, el
;   indice en A): A112, A112, A159, A159, A159, A159, A118, A118, A126, A118,
;   A118, A118, A118, A159, A138; lo leen p11:A0F1 (30 bytes)
;   0xa0f4..0xa112  (30 bytes)
DATA_tabla_A0F4:
	defw 0a112h,0a112h,0a159h,0a159h,0a159h,0a159h,0a118h,0a118h	; a0f4
	defw 0a126h,0a118h,0a118h,0a118h,0a118h,0a159h,0a138h	; a104

; ======================================================================
; CODIGO 0xa112..0xa188  (118 bytes)
; ======================================================================


guarda_un_caracter:		; el caracter bajo el disparo
	call sitio_del_disparo		;a112   ; sitio_del_disparo: IX+0E/IX+0F = el sitio del disparo (IX+03, IX+05) en la pantalla de RAM
	ldi		;a115   ; un byte
	ret			;a117
guarda_una_fila:		; la fila de IX+0A caracteres bajo el disparo
	call sitio_del_disparo		;a118   ; sitio_del_disparo: IX+0E/IX+0F = el sitio del disparo (IX+03, IX+05) en la pantalla de RAM
	ld a,(ix+00ah)		;a11b   ; IX+0A
	or a			;a11e
	ret z			;a11f
	ld c,a			;a120
	ld b,000h		;a121
	ldir		;a123   ; la fila
	ret			;a125
guarda_una_columna:		; la columna de IX+0A caracteres bajo el disparo
	call sitio_del_disparo		;a126   ; sitio_del_disparo: IX+0E/IX+0F = el sitio del disparo (IX+03, IX+05) en la pantalla de RAM
	ld a,(ix+00ah)		;a129
	or a			;a12c
	ret z			;a12d
L_A12E:
	ldi		;a12e   ; un caracter
	ld bc,0001fh		;a130   ; el de abajo
	add hl,bc			;a133
	dec a			;a134
	jr nz,L_A12E		;a135
	ret			;a137
guarda_dos_filas:		; una fila de IX+0A (y otra debajo con IX+06 bit 0)
	call sitio_del_disparo		;a138   ; sitio_del_disparo: IX+0E/IX+0F = el sitio del disparo (IX+03, IX+05) en la pantalla de RAM
	ld (0f000h),hl		;a13b   ; la primera fila
	ld a,(ix+00ah)		;a13e
	or a			;a141
	ret z			;a142
	ld c,a			;a143
	ld b,000h		;a144
	ldir		;a146
	bit 0,(ix+006h)		;a148   ; con el bit 0, otra
	ret z			;a14c
	ld hl,(0f000h)		;a14d   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld bc,00020h		;a150
	add hl,bc			;a153
	ld c,(ix+00ah)		;a154
	ldir		;a157
L_A159:
	ret			;a159
sitio_del_disparo:		; IX+0E/IX+0F = el sitio del disparo (IX+03, IX+05) en la pantalla de RAM
	ld l,(ix+003h)		;a15a   ; L = Y
	ld h,(ix+005h)		;a15d   ; H = X
	call 05c92h		;a160   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (ix+00eh),l		;a163   ; el sitio
	ld (ix+00fh),h		;a166
	ret			;a169
repone_fondo_disparos:		; devuelve el fondo de 0xEC00 bajo los 6 primeros disparos
	ld ix,0e470h		;a16a   ; 6 disparos
	ld de,0ec00h		;a16e   ; apunta a el fondo bajo los disparos de caracteres
	ld b,006h		;a171
L_A173:
	push bc			;a173
	call repone_fondo_por_tipo		;a174   ; repone_fondo_por_tipo: segun el tipo del disparo IX (p11:A188)
	ld bc,00010h		;a177   ; 16 bytes por disparo
	add ix,bc		;a17a
	pop bc			;a17c
	djnz L_A173		;a17d
	ret			;a17f
repone_fondo_por_tipo:		; segun el tipo del disparo IX (p11:A188)
	ld a,(ix+000h)		;a180   ; libre
	dec a			;a183
	ret m			;a184
	call 04084h		;a185   ; por tipo

; ----------------------------------------------------------------------
; DATOS tabla_A188: 15 destinos del despachador p00:4084 (call en p11:A185, el
;   indice en A): A1A6, A1A6, A159, A159, A159, A159, A1B1, A1B1, A1C4, A1B1,
;   A1B1, A1B1, A1B1, A159, A1DD; lo leen p11:A185 (30 bytes)
;   0xa188..0xa1a6  (30 bytes)
DATA_tabla_A188:
	defw 0a1a6h,0a1a6h,0a159h,0a159h,0a159h,0a159h,0a1b1h,0a1b1h	; a188
	defw 0a1c4h,0a1b1h,0a1b1h,0a1b1h,0a1b1h,0a159h,0a1ddh	; a198

; ======================================================================
; CODIGO 0xa1a6..0xa221  (123 bytes)
; ======================================================================


repone_un_caracter:		; el caracter del fondo
	ex de,hl			;a1a6
	ld e,(ix+00eh)		;a1a7   ; su sitio
	ld d,(ix+00fh)		;a1aa
	ldi		;a1ad   ; el byte
	ex de,hl			;a1af
	ret			;a1b0
repone_una_fila:		; la fila del fondo
	ld a,(ix+00ah)		;a1b1   ; el largo
	or a			;a1b4
	ret z			;a1b5
	ld c,a			;a1b6
	ld b,000h		;a1b7
	ex de,hl			;a1b9
	ld e,(ix+00eh)		;a1ba   ; su sitio
	ld d,(ix+00fh)		;a1bd
	ldir		;a1c0   ; la fila
	ex de,hl			;a1c2
	ret			;a1c3
repone_una_columna:		; la columna del fondo
	ld a,(ix+00ah)		;a1c4   ; el alto
	or a			;a1c7
	ret z			;a1c8   ; sin alto, nada
	ex de,hl			;a1c9
	ld e,(ix+00eh)		;a1ca   ; su sitio
	ld d,(ix+00fh)		;a1cd
L_A1D0:
	ldi		;a1d0   ; un caracter
	ex de,hl			;a1d2   ; la fila de abajo
	ld bc,0001fh		;a1d3   ; el de abajo
	add hl,bc			;a1d6
	ex de,hl			;a1d7
	dec a			;a1d8   ; una menos
	jr nz,L_A1D0		;a1d9
	ex de,hl			;a1db
	ret			;a1dc
repone_dos_filas:		; una o dos filas del fondo
	ld a,(ix+00ah)		;a1dd
	or a			;a1e0
	ret z			;a1e1   ; sin largo, nada
	ld c,a			;a1e2
	ld b,000h		;a1e3
	ld l,(ix+00eh)		;a1e5   ; su sitio
	ld h,(ix+00fh)		;a1e8
	ld (0f000h),hl		;a1eb   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ex de,hl			;a1ee
	ldir		;a1ef   ; la primera fila
	ex de,hl			;a1f1
	bit 0,(ix+006h)		;a1f2   ; con el bit 0, otra
	ret z			;a1f6
	ld hl,(0f000h)		;a1f7   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld bc,00020h		;a1fa   ; la de abajo
	add hl,bc			;a1fd
	ld c,(ix+00ah)		;a1fe
	ex de,hl			;a201
	ldir		;a202   ; otra fila
	ex de,hl			;a204
	ret			;a205
pinta_disparos:		; los 9 disparos de la nave que son caracteres, en la pantalla de RAM (p11:A221)
	ld ix,0e470h		;a206   ; 9 disparos
	ld b,009h		;a20a
L_A20C:
	push bc			;a20c
	call pinta_por_tipo		;a20d   ; pinta_por_tipo: segun el tipo del disparo IX
	ld bc,00010h		;a210   ; 16 bytes por disparo
	add ix,bc		;a213
	pop bc			;a215
	djnz L_A20C		;a216
	ret			;a218
pinta_por_tipo:		; segun el tipo del disparo IX
	ld a,(ix+000h)		;a219   ; libre
	dec a			;a21c
	ret m			;a21d
	call 04084h		;a21e   ; por tipo

; ----------------------------------------------------------------------
; DATOS tabla_A221: 15 destinos del despachador p00:4084 (call en p11:A21E, el
;   indice en A): A23F, A23F, A159, A159, A159, A159, A24A, A24A, A25E, A24A,
;   A24A, A24A, A24A, A159, A275; lo leen p11:A21E (30 bytes)
;   0xa221..0xa23f  (30 bytes)
DATA_tabla_A221:
	defw 0a23fh,0a23fh,0a159h,0a159h,0a159h,0a159h,0a24ah,0a24ah	; a221
	defw 0a25eh,0a24ah,0a24ah,0a24ah,0a24ah,0a159h,0a275h	; a231

; ======================================================================
; CODIGO 0xa23f..0xa44d  (526 bytes)
; ======================================================================


pinta_un_caracter:		; el caracter IX+06 en su sitio
	ld l,(ix+00eh)		;a23f   ; su sitio
	ld h,(ix+00fh)		;a242
	ld a,(ix+006h)		;a245   ; el caracter
	ld (hl),a			;a248
	ret			;a249
pinta_una_fila:		; IX+0A caracteres IX+06 en fila
	ld a,(ix+00ah)		;a24a   ; el largo
	or a			;a24d
	ret z			;a24e
	ld b,a			;a24f
	ld l,(ix+00eh)		;a250
	ld h,(ix+00fh)		;a253
	ld a,(ix+006h)		;a256   ; el caracter
L_A259:
	ld (hl),a			;a259   ; en fila
	inc l			;a25a
	djnz L_A259		;a25b
	ret			;a25d
pinta_una_columna:		; IX+0A caracteres IX+06 en columna
	ld a,(ix+00ah)		;a25e   ; el alto
	or a			;a261
	ret z			;a262
	ld b,a			;a263
	ld l,(ix+00eh)		;a264
	ld h,(ix+00fh)		;a267
	ld a,(ix+006h)		;a26a   ; el caracter
	ld de,00020h		;a26d
L_A270:
	ld (hl),a			;a270   ; en columna
	add hl,de			;a271
	djnz L_A270		;a272
	ret			;a274
pinta_dos_filas:		; IX+0A caracteres IX+06 - 13 y, con el bit 0, otra fila con el siguiente
	ld a,(ix+00ah)		;a275   ; el largo
	or a			;a278
	ret z			;a279
	ld b,a			;a27a
	ld l,(ix+00eh)		;a27b
	ld h,(ix+00fh)		;a27e
	ld a,(ix+006h)		;a281
	add a,0f3h		;a284   ; el caracter - 13
L_A286:
	ld (hl),a			;a286   ; la fila
	inc l			;a287
	djnz L_A286		;a288
	bit 0,(ix+006h)		;a28a   ; con el bit 0
	ret z			;a28e
	ld l,(ix+00eh)		;a28f
	ld h,(ix+00fh)		;a292
	ld bc,00020h		;a295   ; la fila de abajo
	add hl,bc			;a298
	ld b,(ix+00ah)		;a299
	inc a			;a29c   ; con el siguiente
L_A29D:
	ld (hl),a			;a29d   ; la segunda fila
	inc l			;a29e
	djnz L_A29D		;a29f
	ret			;a2a1
pantalla_se_deshace:		; la pantalla se deshace (paso 0xE3AB): los dibujos y luego los colores van perdiendo bits; despues todo a cero, 60 cuadros y 0xE3AE = 1
	ld hl,0e3abh		;a2a2   ; el paso
	ld a,(hl)			;a2a5
	dec a			;a2a6
	jr z,L_A2E7		;a2a7
	dec a			;a2a9
	jr z,L_A317		;a2aa
	dec a			;a2ac
	jp z,L_A349		;a2ad
	xor a			;a2b0   ; paso 0: sin acabar
	ld (0e3aeh),a		;a2b1   ; guarda la marca de fin de p11:A2A2
	inc l			;a2b4   ; caracter 0, mascara 0xF0
	ld (hl),a			;a2b5
	inc l			;a2b6
	ld (hl),0f0h		;a2b7
L_A2B9:
	ld a,(0e3ach)		;a2b9   ; el caracter
	or a			;a2bc
	jr nz,L_A2C1		;a2bd
	ld a,01fh		;a2bf   ; el 0 vale 0x1F
L_A2C1:
	ld de,01000h		;a2c1   ; los dibujos del tercio de abajo
	call deshace_caracteres		;a2c4   ; deshace_caracteres: lee los caracteres A del tercio DE (1, 7 o 64 de golpe), les aplica la mascara y los devuelve
	ld de,00800h		;a2c7   ; del medio
	call deshace_tercio		;a2ca   ; deshace_tercio: los caracteres 0xE3AC del tercio DE con la mascara 0xE3AD
	ld de,00000h		;a2cd   ; y de arriba
	call deshace_tercio		;a2d0   ; deshace_tercio: los caracteres 0xE3AC del tercio DE con la mascara 0xE3AD
	ld hl,0e3ach		;a2d3   ; los 64 siguientes
	ld a,(hl)			;a2d6
	add a,040h		;a2d7
	ld (hl),a			;a2d9
	jr nz,L_A2B9		;a2da   ; la vuelta entera
	dec l			;a2dc   ; al paso 1
	inc (hl)			;a2dd
	inc l			;a2de
	inc l			;a2df
	ld (hl),0feh		;a2e0   ; mascara 0xFE
	ld a,038h		;a2e2   ; suena 0x38
	jp 04ae4h		;a2e4   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A2E7:
	ld a,(0e3ach)		;a2e7   ; paso 1: los colores
	or a			;a2ea
	jr nz,L_A2EF		;a2eb
	ld a,01fh		;a2ed
L_A2EF:
	ld de,03000h		;a2ef   ; del tercio de abajo
	call deshace_caracteres		;a2f2   ; deshace_caracteres: lee los caracteres A del tercio DE (1, 7 o 64 de golpe), les aplica la mascara y los devuelve
	ld de,02800h		;a2f5   ; del medio
	call deshace_tercio		;a2f8   ; deshace_tercio: los caracteres 0xE3AC del tercio DE con la mascara 0xE3AD
	ld de,02000h		;a2fb   ; y de arriba
	call deshace_tercio		;a2fe   ; deshace_tercio: los caracteres 0xE3AC del tercio DE con la mascara 0xE3AD
	ld hl,0e3ach		;a301   ; los 64 siguientes
	ld a,(hl)			;a304
	add a,040h		;a305
	ld (hl),a			;a307
	ret nz			;a308
	inc l			;a309   ; la vuelta entera: la mascara pierde un bit
	ld a,(hl)			;a30a
	and a			;a30b
	jr z,L_A311		;a30c
	sla (hl)		;a30e
	ret			;a310
L_A311:
	ld a,002h		;a311   ; sin bits: al paso 2
	ld (0e3abh),a		;a313   ; guarda el paso de la pantalla que se deshace
	ret			;a316
L_A317:
	ld hl,0ed00h		;a317   ; paso 2: la pantalla de RAM a cero
	ld de,0ed01h		;a31a
	ld bc,002bfh		;a31d
	ld (hl),000h		;a320
	ldir		;a322
	ld hl,0e600h		;a324   ; los enemigos
	ld de,0e601h		;a327
	ld bc,002ffh		;a32a
	ld (hl),000h		;a32d
	ldir		;a32f
	ld hl,0e350h		;a331   ; y su cuenta
	ld de,0e351h		;a334   ; apunta a el dato C del enemigo que se crea
	ld bc,00006h		;a337
	ld (hl),000h		;a33a
	ldir		;a33c
	ld a,03ch		;a33e   ; 60 cuadros
	ld (0e349h),a		;a340   ; guarda la espera del suceso
	ld a,003h		;a343   ; al paso 3
	ld (0e3abh),a		;a345   ; guarda el paso de la pantalla que se deshace
	ret			;a348
L_A349:
	ld hl,0e349h		;a349   ; paso 3: la espera
	dec (hl)			;a34c
	ret nz			;a34d
	ld a,001h		;a34e   ; acabado
	ld (0e3aeh),a		;a350   ; guarda la marca de fin de p11:A2A2
	ret			;a353
deshace_tercio:		; los caracteres 0xE3AC del tercio DE con la mascara 0xE3AD
	ld a,(0e3ach)		;a354   ; lee el caracter que se deshace
deshace_caracteres:		; lee los caracteres A del tercio DE (1, 7 o 64 de golpe), les aplica la mascara y los devuelve
	ld bc,00108h		;a357   ; 33 caracteres con el 0x1F
	cp 01fh		;a35a
	jr z,L_A368		;a35c
	ld bc,00038h		;a35e   ; 7 de 0xC0 en adelante
	cp 0c0h		;a361
	jr nc,L_A368		;a363
	ld bc,00200h		;a365   ; si no, 64
L_A368:
	ld l,a			;a368   ; x 8 + el tercio
	ld h,000h		;a369
	add hl,hl			;a36b
	add hl,hl			;a36c
	add hl,hl			;a36d
	add hl,de			;a36e
	push hl			;a36f
	ld de,0e600h		;a370   ; a 0xE600
	push bc			;a373
	call 00059h		;a374   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop bc			;a377
	push bc			;a378
	ld hl,0e600h		;a379   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld a,(0e3adh)		;a37c   ; la mascara
	ld e,a			;a37f
	call aplica_mascara		;a380   ; aplica_mascara: BC bytes de HL AND E (en los dibujos la mascara rota 3 bits por byte)
	pop bc			;a383
	pop hl			;a384
	ld de,0e600h		;a385   ; y de vuelta
	jp 04a33h		;a388   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
aplica_mascara:		; BC bytes de HL AND E (en los dibujos la mascara rota 3 bits por byte)
	ld a,(0e3abh)		;a38b   ; en los dibujos rota
	and a			;a38e
	jr nz,L_A39B		;a38f
L_A391:
	ld a,(hl)			;a391   ; cada byte
	and e			;a392   ; con la mascara
	ld (hl),a			;a393
	inc hl			;a394
	dec bc			;a395   ; cuantos quedan
	ld a,b			;a396
	or c			;a397
	jr nz,L_A391		;a398
	ret			;a39a
L_A39B:
	ld a,(hl)			;a39b   ; cada byte
	and e			;a39c   ; con la mascara
	ld (hl),a			;a39d
	inc hl			;a39e
	rrc e		;a39f   ; la mascara rota 3 bits
	rrc e		;a3a1
	rrc e		;a3a3
	dec bc			;a3a5   ; cuantos quedan
	ld a,b			;a3a6
	or c			;a3a7
	jr nz,L_A39B		;a3a8
	ret			;a3aa
clase_11_empieza:		; la clase 11: sin caja, 11 pasos (14 con IX+0B bit 1)
	ld (ix+00dh),0ffh		;a3ab   ; sin caja
	ld (ix+002h),001h		;a3af   ; 1 cuadro
	ld (ix+00ch),000h		;a3b3   ; cuenta 0
	bit 1,(ix+00bh)		;a3b7   ; 11 pasos, o 14
	ld a,00bh		;a3bb
	jr z,L_A3C1		;a3bd
	ld a,00eh		;a3bf
L_A3C1:
	ld (ix+001h),a		;a3c1
	ret			;a3c4
clase_11:		; la clase 11: en pantalla, suena 0x11 cada 8 cuadros y cada 7 crece una fila de 4 caracteres arriba o abajo (p11:A48D, p11:A44D); al acabar sus pasos, libre
	ld a,(ix+006h)		;a3c5   ; cerca del borde derecho, nada
	cp 0c1h		;a3c8
	ret nc			;a3ca
	ld a,(0e1c3h)		;a3cb   ; cada 8 cuadros
	and 007h		;a3ce
	ld a,011h		;a3d0   ; suena 0x11
	call z,04ae4h		;a3d2   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	dec (ix+002h)		;a3d5   ; la espera
	ret nz			;a3d8
	ld (ix+002h),007h		;a3d9   ; 7 cuadros
	inc (ix+00ch)		;a3dd   ; una fila mas
	dec (ix+001h)		;a3e0   ; un paso menos
	jr nz,L_A3E9		;a3e3
	ld (ix+000h),000h		;a3e5   ; se acabo
L_A3E9:
	bit 0,(ix+00bh)		;a3e9   ; hacia arriba o abajo
	jr z,L_A40C		;a3ed
	ld b,008h		;a3ef   ; baja 8
	call clase_11_mueve		;a3f1   ; clase_11_mueve: la Y + B y la X con el scroll; DE = su sitio; C si se ha salido
	ret c			;a3f4
	ld hl,0a48dh		;a3f5   ; las filas de p11:A48D
	exx			;a3f8
	ld b,(ix+00ch)		;a3f9
L_A3FC:
	exx			;a3fc
	ld bc,00004h		;a3fd   ; 4 caracteres
	ldir		;a400   ; 4 caracteres
	ld bc,0ffdch		;a402   ; la fila de arriba
	ex de,hl			;a405   ; la fila de arriba (- 36 + 4)
	add hl,bc			;a406
	ex de,hl			;a407
	exx			;a408
	djnz L_A3FC		;a409   ; tantas filas como pasos
	ret			;a40b
L_A40C:
	ld b,0f8h		;a40c   ; sube 8
	call clase_11_mueve		;a40e   ; clase_11_mueve: la Y + B y la X con el scroll; DE = su sitio; C si se ha salido
	ret c			;a411
	ld hl,0a44dh		;a412   ; las filas de p11:A44D
	exx			;a415
	ld b,(ix+00ch)		;a416
L_A419:
	exx			;a419
	ld bc,00004h		;a41a
	ldir		;a41d   ; 4 caracteres
	ld a,01ch		;a41f   ; la fila de abajo
	add a,e			;a421   ; la fila de abajo (+ 28 + 4)
	ld e,a			;a422
	jr nc,L_A426		;a423
	inc d			;a425
L_A426:
	exx			;a426
	djnz L_A419		;a427
	ret			;a429
clase_11_mueve:		; la Y + B y la X con el scroll; DE = su sitio; C si se ha salido
	ld a,(ix+004h)		;a42a   ; la Y
	ld l,a			;a42d
	add a,b			;a42e   ; + B
	ld (ix+004h),a		;a42f
	ld h,(ix+006h)		;a432   ; la X
	ld a,(0e320h)		;a435   ; con scroll, 8 a la izquierda
	or a			;a438
	jr z,L_A441		;a439
	ld a,h			;a43b
	sub 008h		;a43c
	jr z,L_A447		;a43e   ; al borde: se va
	ld h,a			;a440
L_A441:
	call 05c92h		;a441   ; el sitio
	ex de,hl			;a444
	xor a			;a445
	ret			;a446
L_A447:
	ld (ix+000h),000h		;a447   ; libre
	scf			;a44b
	ret			;a44c

; ----------------------------------------------------------------------
; DATOS filas_A44D: 33 filas de 4 caracteres que p11:A412 copia (IX+0C filas)
;   a la tabla de nombres de la RAM; lo leen p11:A41D (132 bytes)
;   0xa44d..0xa4d1  (132 bytes)
DATA_filas_A44D:
	defb 0b4h,0b5h,088h,089h	; a44d
	defb 093h,097h,09ah,087h	; a451
	defb 0a6h,0a8h,0abh,0a7h	; a455
	defb 0b6h,0adh,0aeh,0b8h	; a459
	defb 0b8h,0abh,0ach,0aah	; a45d
	defb 0a7h,0a8h,0a9h,0aah	; a461
	defb 094h,095h,096h,0b4h	; a465
	defb 0b5h,09ah,093h,09ah	; a469
	defb 0b3h,099h,09ah,096h	; a46d
	defb 093h,094h,097h,0b4h	; a471
	defb 093h,085h,086h,0b5h	; a475
	defb 0b5h,095h,099h,09ah	; a479
	defb 0b6h,0adh,0aeh,096h	; a47d
	defb 094h,09ah,08ah,0b4h	; a481
	defb 097h,098h,099h,09ah	; a485
	defb 07dh,07ah,07bh,07ch	; a489
	defb 0b6h,0b8h,0a8h,0b7h	; a48d
	defb 0b6h,0a6h,09ah,0b7h	; a491
	defb 0b8h,0adh,0a6h,0aah	; a495
	defb 0b6h,0ach,0a9h,0b7h	; a499
	defb 0adh,0aeh,0a3h,0a7h	; a49d
	defb 0a7h,0a8h,0a9h,0aah	; a4a1
	defb 0b8h,0abh,0ach,0aah	; a4a5
	defb 0b6h,0adh,0aeh,0b8h	; a4a9
	defb 0a6h,0a8h,0abh,0a7h	; a4ad
	defb 093h,094h,097h,0b4h	; a4b1
	defb 0b3h,099h,09ah,096h	; a4b5
	defb 0b5h,09ah,093h,09ah	; a4b9
	defb 094h,095h,096h,0b4h	; a4bd
	defb 0b6h,0b8h,0a4h,0a5h	; a4c1
	defb 0a7h,0b6h,0a8h,0a9h	; a4c5
	defb 0a6h,0a4h,0ach,0adh	; a4c9
	defb 09ch,09dh,09eh,09fh	; a4cd

; ======================================================================
; CODIGO 0xa4d1..0xa566  (149 bytes)
; ======================================================================


clase_12_empieza:		; la clase 12: sin caja, 11 pasos, uno cada 6 cuadros
	ld (ix+00dh),0ffh		;a4d1   ; sin caja
	ld (ix+00ch),00bh		;a4d5   ; 11 pasos
	ld (ix+00eh),000h		;a4d9   ; desde la fila 0
	ld (ix+00fh),006h		;a4dd   ; 6 cuadros
	ret			;a4e1
clase_12:		; la clase 12: al pasar de X 0x80, cada 6 cuadros llena una fila por arriba y otra por abajo (p11:A566) con caracteres 0x67/0x69 al azar; al acabar, libre
	ld a,(ix+001h)		;a4e2   ; en marcha?
	dec a			;a4e5
	jr z,L_A4F2		;a4e6
	ld a,(ix+006h)		;a4e8   ; hasta X 0x80
	cp 080h		;a4eb
	ret nc			;a4ed
	inc (ix+001h)		;a4ee
	ret			;a4f1
L_A4F2:
	dec (ix+00fh)		;a4f2   ; la espera
	ret nz			;a4f5
	ld (ix+00fh),006h		;a4f6
	call clase_12_arriba		;a4fa   ; la de arriba
	call clase_12_abajo		;a4fd   ; y la de abajo
	inc (ix+00eh)		;a500   ; la fila siguiente
	dec (ix+00ch)		;a503   ; un paso menos
	ret nz			;a506
	ld (ix+000h),000h		;a507   ; libre
	ret			;a50b
clase_12_abajo:		; la fila 20 - IX+0E de la mascara de su forma
	ld a,014h		;a50c   ; 20 - la fila
	sub (ix+00eh)		;a50e
	call sitio_de_fila		;a511   ; sitio_de_fila: 0xF000 = el sitio de la fila A x 8 en su columna; HL = la tabla de su forma (p11:A566)
	ld a,015h		;a514   ; su mascara
	sub (ix+00eh)		;a516
	add a,a			;a519
	jr llena_fila		;a51a
clase_12_arriba:		; la fila IX+0E de la mascara de su forma
	ld a,(ix+00eh)		;a51c
	call sitio_de_fila		;a51f   ; sitio_de_fila: 0xF000 = el sitio de la fila A x 8 en su columna; HL = la tabla de su forma (p11:A566)
	ld a,(ix+00eh)		;a522
	add a,a			;a525
llena_fila:		; los bits de la palabra A de la tabla HL: cada bit a 1, un caracter 0x67 o 0x69 al azar en la pantalla de RAM (0xF000); suena 0x11 si pone alguno
	call 0407ah		;a526   ; la mascara de 16 bits
	ld e,(hl)			;a529
	inc hl			;a52a
	ld d,(hl)			;a52b
	ld hl,(0f000h)		;a52c   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ex de,hl			;a52f
	ld bc,01000h		;a530   ; 16 columnas
L_A533:
	add hl,hl			;a533   ; el bit siguiente
	jr nc,L_A544		;a534
	ld a,r		;a536   ; al azar
	xor l			;a538
	and 00fh		;a539
	ld a,067h		;a53b   ; 0x67 o 0x69
	jr z,L_A541		;a53d
	ld a,069h		;a53f
L_A541:
	ld (de),a			;a541
	ld c,001h		;a542   ; ha puesto alguno
L_A544:
	inc de			;a544   ; la columna siguiente
	djnz L_A533		;a545
	dec c			;a547
	ret nz			;a548
	ld a,011h		;a549   ; suena 0x11
	jp 04ae4h		;a54b   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
sitio_de_fila:		; 0xF000 = el sitio de la fila A x 8 en su columna; HL = la tabla de su forma (p11:A566)
	add a,a			;a54e   ; x 8: la Y
	add a,a			;a54f
	add a,a			;a550
	ld l,a			;a551
	ld h,(ix+006h)		;a552   ; su X
	call 05c92h		;a555   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0f000h),hl		;a558   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld a,(ix+00bh)		;a55b   ; la forma
	ld de,0a566h		;a55e
	call 04b60h		;a561   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ex de,hl			;a564
	ret			;a565

; ----------------------------------------------------------------------
; DATOS tabla_A566: 3 punteros (IX+0B) que p11:A55E lee con L_4B60; lo leen
;   p11:A561 (6 bytes)
;   0xa566..0xa56c  (6 bytes)
DATA_tabla_A566:
	defw 0a56ch,0a598h,0a5c4h	; a566  -> DATA_dibujos_A56C 0xa598 0xa5c4

; ----------------------------------------------------------------------
; DATOS dibujos_A56C: 3 bloques de 44 bytes (0xA56C, 0xA598 y 0xA5C4), los de
;   0xA566; lo leen p11:A564 (132 bytes)
;   0xa56c..0xa5f0  (132 bytes)
DATA_dibujos_A56C:
	defb 000h,000h,040h,000h,0f8h,07dh,0fch,0ffh,0feh,07fh,0f8h,07fh,0f0h,0ffh,0fch,07fh	; a56c  ..@..}..........
	defb 0feh,03fh,0fch,03fh,07ch,038h,01eh,078h,038h,078h,01ch,0f0h,03ch,078h,03ch,03eh	; a57c  .?.?|8.x8x..<x<>
	defb 0fch,07fh,0f8h,0ffh,0d0h,0ffh,000h,0e0h,000h,040h,000h,000h,000h,000h,000h,000h	; a58c  .........@......
	defb 000h,080h,000h,0e0h,0e0h,0ffh,0f4h,07fh,07ch,070h,03eh,038h,01ch,0f8h,03eh,0f8h	; a59c  ........|p>8..>.
	defb 07ch,07ch,0fch,0feh,0fch,07fh,0f8h,03fh,0fch,07fh,0fch,07fh,0f8h,07fh,0feh,0ffh	; a5ac  ||.....?........
	defb 000h,0f0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a5bc  ................
	defb 03ch,000h,0feh,001h,0fch,00fh,03eh,01fh,00eh,03eh,007h,07fh,00eh,07ch,09fh,0f1h	; a5cc  <.....>..>...|..
	defb 0bfh,0f9h,0beh,07eh,03fh,07fh,0cfh,01fh,0feh,003h,0fch,000h,000h,000h,000h,000h	; a5dc  ...~?...........
	defb 000h,000h,000h,000h	; a5ec

; ======================================================================
; CODIGO 0xa5f0..0xa634  (68 bytes)
; ======================================================================


tipo_38_empieza:		; el tipo 0x38: cuatro sprites (IX+34, IX+38, IX+3C) escondidos, 8 cuadros, con el scroll y el color que toca
	ld a,(ix+006h)		;a5f0   ; 32 pixeles atras
	sub 020h		;a5f3
	ld (ix+029h),a		;a5f5
	ld a,0e0h		;a5f8   ; los tres sprites escondidos
	ld (ix+034h),a		;a5fa
	ld (ix+038h),a		;a5fd
	ld (ix+03ch),a		;a600
	ld (ix+024h),008h		;a603   ; 8 cuadros
	xor a			;a607
	ld (0e39ah),a		;a608   ; guarda la cuenta de rumbos del tipo 0x38
	inc a			;a60b   ; IX+10 = 1, IX+25 = 1
	ld (ix+010h),a		;a60c
	ld (ix+025h),a		;a60f
	inc a			;a612
	ld (ix+02bh),a		;a613   ; IX+2B = IX+2C = 2
	ld (ix+02ch),a		;a616
tipo_38_color:		; el color siguiente (p11:A634) en los cuatro sprites
	inc (ix+02bh)		;a619   ; el color siguiente
	ld a,(ix+02bh)		;a61c
	and 00fh		;a61f
	ld hl,0a634h		;a621
	call 05ca6h		;a624   ; byte_a: A = el byte A de la tabla HL
	ld (ix+031h),a		;a627   ; en los cuatro sprites
	ld (ix+037h),a		;a62a
	ld (ix+03bh),a		;a62d
	ld (ix+03fh),a		;a630
	ret			;a633

; ----------------------------------------------------------------------
; DATOS tabla_A634: 16 bytes que p11:A619 lee con IX+2B & 0x0F y pone en
;   IX+31, +37, +3B y +3F; lo leen p11:A624 (16 bytes)
;   0xa634..0xa644  (16 bytes)
DATA_tabla_A634:
	defb 008h,00ah,005h,003h,002h,007h,005h,00fh,00dh,00bh,00dh,00bh,005h,009h,00ah,00dh	; a634  ................

; ======================================================================
; CODIGO 0xa644..0xa65b  (23 bytes)
; ======================================================================


tipo_38:		; el tipo 0x38: cambia de color y, cada 2 cuadros, lo de su paso (p11:A65B)
	call tipo_38_color		;a644   ; tipo_38_color: el color siguiente (p11:A634) en los cuatro sprites
	dec (ix+02ch)		;a647   ; cada 2 cuadros
	ret nz			;a64a
	ld (ix+02ch),002h		;a64b
	ld a,(ix+001h)		;a64f   ; en el paso 0, cada cuadro
	or a			;a652
	jr nz,L_A658		;a653
	dec (ix+02ch)		;a655
L_A658:
	call 04084h		;a658   ; por paso

; ----------------------------------------------------------------------
; DATOS tabla_A65B: 4 destinos del despachador p00:4084 (call en p11:A658, el
;   indice en A): A663, A69B, A6AA, A6C1; lo leen p11:A658 (8 bytes)
;   0xa65b..0xa663  (8 bytes)
DATA_tabla_A65B:
	defw 0a663h,0a69bh,0a6aah,0a6c1h	; a65b  -> tipo_38_abre tipo_38_suelta tipo_38_avanza tipo_38_se_va

; ======================================================================
; CODIGO 0xa663..0xa73a  (215 bytes)
; ======================================================================


tipo_38_abre:		; se anima (0xD0-0xE0) y, al acabar, 16 pixeles atras, su rumbo (p11:A6FA) y suena 0x17
	dec (ix+024h)		;a663   ; la espera
	jr z,L_A67C		;a666
	bit 0,(ix+024h)		;a668   ; cada 2 cuadros
	ret z			;a66c
	ld a,(ix+030h)		;a66d   ; el dibujo siguiente
	add a,004h		;a670
	cp 0e4h		;a672
	jr nz,L_A678		;a674
	ld a,0d0h		;a676   ; vuelta a 0xD0
L_A678:
	ld (ix+030h),a		;a678
	ret			;a67b
L_A67C:
	ld a,(ix+006h)		;a67c   ; 16 atras
	sub 010h		;a67f
	ld (ix+006h),a		;a681
	ld a,(ix+004h)		;a684   ; su Y
	ld (ix+02ah),a		;a687
	call tipo_38_rumbo		;a68a   ; el rumbo
	ld b,001h		;a68d
	call tipo_38_paso		;a68f   ; tipo_38_paso: A = el desplazamiento del dibujo A (p11:A75C con B = 1, p11:A761 si no)
	ld a,017h		;a692   ; suena 0x17
	call 04ae4h		;a694   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A697:
	inc (ix+001h)		;a697   ; al paso siguiente
	ret			;a69a
tipo_38_suelta:		; uno mas de sus sprites (hasta 4)
	call tipo_38_corre		;a69b   ; tipo_38_corre: el siguiente paso de su recorrido y la Y del sprite que toca
	ld a,(ix+025h)		;a69e   ; uno mas
	inc a			;a6a1
	cp 004h		;a6a2   ; hasta 4
	jr z,L_A697		;a6a4
	ld (ix+025h),a		;a6a6
	ret			;a6a9
tipo_38_avanza:		; mientras el ultimo no llegue (IX+3D >= 9) corre la fila de sprites
	ld a,(ix+03dh)		;a6aa   ; el ultimo sprite
	cp 009h		;a6ad
	jr c,L_A697		;a6af
	call corre_sprites		;a6b1   ; corre_sprites: el primero toma el sitio del segundo (IX+34-IX+37) y los demas avanzan uno
tipo_38_corre:		; el siguiente paso de su recorrido y la Y del sprite que toca
	call tipo_38_siguiente		;a6b4   ; tipo_38_siguiente: el siguiente byte de su recorrido al sprite que toca (p11:A788)
	push af			;a6b7
	call tipo_38_y		;a6b8   ; tipo_38_y: la Y del sprite que toca, sin pasar de 0xD0, y su X 16 pixeles a la izquierda
	pop af			;a6bb
	ld b,001h		;a6bc
	jp tipo_38_paso		;a6be   ; tipo_38_paso: A = el desplazamiento del dibujo A (p11:A75C con B = 1, p11:A761 si no)
tipo_38_se_va:		; corre la fila y suelta uno; sin ninguno, se quita
	call corre_sprites		;a6c1   ; corre_sprites: el primero toma el sitio del segundo (IX+34-IX+37) y los demas avanzan uno
	dec (ix+025h)		;a6c4   ; uno menos
	jp m,06514h		;a6c7   ; ninguno: se quita
	ld (ix+03ch),0e0h		;a6ca   ; el ultimo, escondido
	ret			;a6ce
corre_sprites:		; el primero toma el sitio del segundo (IX+34-IX+37) y los demas avanzan uno
	ld a,(ix+034h)		;a6cf   ; el segundo sprite
	ld (ix+004h),a		;a6d2   ; a la ficha
	ld a,(ix+035h)		;a6d5   ; X
	ld (ix+006h),a		;a6d8
	ld a,(ix+036h)		;a6db   ; dibujo
	ld (ix+030h),a		;a6de
	ld a,(ix+037h)		;a6e1   ; color
	ld (ix+031h),a		;a6e4
	push ix		;a6e7   ; los demas, un sitio adelante
	pop de			;a6e9
	ld a,034h		;a6ea
	call 0407fh		;a6ec   ; de_mas_a: DE = DE + A
	ld h,d			;a6ef
	ld a,e			;a6f0
	add a,004h		;a6f1
	ld l,a			;a6f3
	ld bc,00008h		;a6f4   ; 8 bytes: los otros dos sprites
	ldir		;a6f7
	ret			;a6f9
tipo_38_rumbo:		; tres de cada cuatro hacia la nave (segun su Y, p11:A73A); uno al azar; la ficha de p11:A7BF
	ld hl,0e39ah		;a6fa   ; una mas
	inc (hl)			;a6fd
	ld a,(hl)			;a6fe
	and 003h		;a6ff   ; una de cada cuatro, al azar
	jr z,L_A733		;a701
	ld bc,00500h		;a703   ; 5 tramos
	ld hl,0a73ah		;a706
	ld a,(0e404h)		;a709   ; la nave por encima o por debajo
	sub (ix+004h)		;a70c
	jr c,L_A716		;a70f
	ld de,00005h		;a711
	ld c,e			;a714
	add hl,de			;a715
L_A716:
	cp (hl)			;a716   ; el tramo de la distancia
	jr c,L_A71E		;a717   ; en este tramo
	inc c			;a719   ; el siguiente
	inc hl			;a71a
	djnz L_A716		;a71b
	dec c			;a71d
L_A71E:
	ld a,c			;a71e
L_A71F:
	add a,a			;a71f   ; 8 bytes por ficha
	add a,a			;a720
	add a,a			;a721
	ld hl,0a7bfh		;a722   ; en p11:A7BF
	call 05ca6h		;a725   ; byte_a: A = el byte A de la tabla HL
	inc hl			;a728
	ld (ix+026h),h		;a729   ; su recorrido
	ld (ix+027h),l		;a72c
	ld (ix+030h),a		;a72f   ; su dibujo
	ret			;a732
L_A733:
	call 0637bh		;a733   ; azar_rapido: A = R rotado XOR la cuenta de cuadros
	and 007h		;a736
	jr L_A71F		;a738

; ----------------------------------------------------------------------
; DATOS tabla_A73A: 10 bytes que p11:A703 recorre (B = 5) comparando con la
;   distancia en X; lo leen p11:A706 (10 bytes)
;   0xa73a..0xa744  (10 bytes)
DATA_tabla_A73A:
	defb 0dbh,0e7h,0ech,0f6h,0ffh,004h,008h,00dh,018h,028h	; a73a  .........(

; ======================================================================
; CODIGO 0xa744..0xa75c  (24 bytes)
; ======================================================================


tipo_38_paso:		; A = el desplazamiento del dibujo A (p11:A75C con B = 1, p11:A761 si no)
	sub 0d0h		;a744   ; el dibujo desde 0xD0, / 4
	rra			;a746
	rra			;a747
	and 03fh		;a748
	djnz L_A756		;a74a
	ld hl,0a75ch		;a74c   ; con B = 1, de p11:A75C
	call 05ca6h		;a74f   ; byte_a: A = el byte A de la tabla HL
	ld (ix+028h),a		;a752   ; a IX+28
	ret			;a755
L_A756:
	ld hl,0a761h		;a756   ; si no, de p11:A761
	jp 05ca6h		;a759   ; byte_a: A = el byte A de la tabla HL

; ----------------------------------------------------------------------
; DATOS tablas_A75C: dos tablas de 5 bytes (0xA75C y 0xA761) que p11:A74C y
;   p11:A756 leen con L_5CA6; lo leen p11:A74F (10 bytes)
;   0xa75c..0xa766  (10 bytes)
DATA_tablas_A75C:
	defb 001h,006h,00ah,00ah,00eh	; a75c
	defb 006h,007h,000h,00fh,004h	; a761

; ======================================================================
; CODIGO 0xa766..0xa788  (34 bytes)
; ======================================================================


tipo_38_siguiente:		; el siguiente byte de su recorrido al sprite que toca (p11:A788)
	ld a,(ix+025h)		;a766   ; el sprite que toca
	dec a			;a769
	ld hl,0a788h		;a76a
	call 05ca6h		;a76d   ; byte_a: A = el byte A de la tabla HL
	inc a			;a770
	inc a			;a771
	push ix		;a772
	pop de			;a774
	call 0407fh		;a775   ; de_mas_a: DE = DE + A
	ld h,(ix+026h)		;a778   ; su recorrido
	ld l,(ix+027h)		;a77b
	ld a,(hl)			;a77e
	ldi		;a77f   ; el byte siguiente
	ld (ix+026h),h		;a781
	ld (ix+027h),l		;a784
	ret			;a787

; ----------------------------------------------------------------------
; DATOS tabla_A788: 3 bytes que p11:A766 lee con IX+25 - 1; lo leen p11:A76D
;   (3 bytes)
;   0xa788..0xa78b  (3 bytes)
DATA_tabla_A788:
	defb 034h,038h,03ch	; a788

; ======================================================================
; CODIGO 0xa78b..0xa7bf  (52 bytes)
; ======================================================================


tipo_38_y:		; la Y del sprite que toca, sin pasar de 0xD0, y su X 16 pixeles a la izquierda
	ld b,000h		;a78b
	call tipo_38_paso		;a78d   ; tipo_38_paso: A = el desplazamiento del dibujo A (p11:A75C con B = 1, p11:A761 si no)
	ld b,a			;a790
	ld a,(ix+02ah)		;a791   ; la Y
	add a,(ix+028h)		;a794
	sub b			;a797
	cp 0d0h		;a798   ; sin pasar de 0xD0
	jr c,L_A79E		;a79a
	ld a,0e0h		;a79c   ; escondido
L_A79E:
	ld (ix+02ah),a		;a79e
	ld c,a			;a7a1
	push ix		;a7a2
	pop hl			;a7a4
	ld de,0a788h		;a7a5   ; el sprite que toca
	ld a,(ix+025h)		;a7a8
	dec a			;a7ab
	call 0407fh		;a7ac   ; de_mas_a: DE = DE + A
	ld a,(de)			;a7af
	call 0407ah		;a7b0   ; hl_mas_a: HL = HL + A
	ld (hl),c			;a7b3
	inc l			;a7b4
	ld a,(ix+029h)		;a7b5   ; su X
	ld (hl),a			;a7b8
	add a,0f0h		;a7b9   ; la siguiente, 16 a la izquierda
	ld (ix+029h),a		;a7bb
	ret			;a7be

; ----------------------------------------------------------------------
; DATOS filas_A7BF: filas de 8 bytes que p11:A71E lee con C x 8: la primera va
;   a IX+30 y la direccion del resto a IX+26/27; lo leen p11:A725 (82 bytes)
;   0xa7bf..0xa811  (82 bytes)
DATA_filas_A7BF:
	defb 0dch,0d0h,0dch,0d0h,0d0h,0dch,0d0h,0dch	; a7bf  ........
	defb 0dch,0d0h,0dch,0d4h,0d0h,0dch,0dch,0d0h	; a7c7  ........
	defb 0dch,0d4h,0dch,0d0h,0dch,0dch,0d0h,0d4h	; a7cf  ........
	defb 0d0h,0dch,0d0h,0d8h,0dch,0d4h,0d0h,0dch	; a7d7  ........
	defb 0d0h,0dch,0d8h,0dch,0e0h,0d0h,0d8h,0dch	; a7df  ........
	defb 0dch,0e0h,0d4h,0dch,0d0h,0d8h,0e0h,0d0h	; a7e7  ........
	defb 0d8h,0dch,0d0h,0e0h,0e0h,0d0h,0d8h,0dch	; a7ef  ........
	defb 0d0h,0d8h,0e0h,0d4h,0dch,0d8h,0e0h,0d0h	; a7f7  ........
	defb 0e0h,0d0h,0dch,0d8h,0e0h,0d8h,0e0h,0d8h	; a7ff  ........
	defb 0d8h,0e0h,0e0h,0d8h,0d4h,0d8h,0e0h,0d8h	; a807  ........
	defb 0d8h,0dch	; a80f

; ======================================================================
; CODIGO 0xa811..0xa82a  (25 bytes)
; ======================================================================


clase_13_empieza:		; la clase 13: sin caja, 1 cuadro, y la X a la que se abre de p11:A82A
	ld (ix+00dh),0ffh		;a811   ; sin caja
	ld (ix+002h),001h		;a815   ; 1 cuadro
	ld (ix+00ch),000h		;a819   ; paso 0
	ld a,(ix+00bh)		;a81d   ; la X de p11:A82A
	ld hl,0a82ah		;a820
	call 05ca6h		;a823   ; byte_a: A = el byte A de la tabla HL
	ld (ix+00bh),a		;a826
	ret			;a829

; ----------------------------------------------------------------------
; DATOS tabla_A82A: 4 bytes que p11:A81D lee con IX+0B; lo leen p11:A823 (4
;   bytes)
;   0xa82a..0xa82e  (4 bytes)
DATA_tabla_A82A:
	defb 071h,091h,0b1h,0d1h	; a82a

; ======================================================================
; CODIGO 0xa82e..0xa875  (71 bytes)
; ======================================================================


clase_13:		; la clase 13: al pasar su X, cada 24 cuadros el dibujo siguiente de 4 x 4 (p11:A865), 4 pasos, y suena 0x25
	ld a,(ix+006h)		;a82e   ; hasta su X
	cp (ix+00bh)		;a831
	ret nc			;a834
	dec (ix+002h)		;a835   ; la espera
	ret nz			;a838
	ld (ix+002h),018h		;a839   ; 24 cuadros
	inc (ix+00ch)		;a83d   ; el paso siguiente
	ld a,(ix+00ch)		;a840
	cp 004h		;a843   ; al cuarto, libre
	jr c,L_A84B		;a845
	ld (ix+000h),000h		;a847
L_A84B:
	add a,a			;a84b   ; 16 bytes por paso
	add a,a			;a84c
	add a,a			;a84d
	add a,a			;a84e
	ld de,0a865h		;a84f
	call 0407fh		;a852   ; de_mas_a: DE = DE + A
	ld l,(ix+004h)		;a855   ; su sitio
	ld h,(ix+006h)		;a858
	call 05c92h		;a85b   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;a85e
	exx			;a85f
	ld b,004h		;a860   ; 4 filas
L_A862:
	exx			;a862
	ld bc,00004h		;a863   ; de 4
	ldir		;a866
	ld a,01ch		;a868   ; la fila siguiente
	call 0407fh		;a86a   ; de_mas_a: DE = DE + A
	exx			;a86d
	djnz L_A862		;a86e
	ld a,025h		;a870   ; suena 0x25
	jp 04ae4h		;a872   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS piezas_A875: 4 piezas de 4 x 4 caracteres (IX+0C de 1 a 4: p11:A84B
;   lee 0xA865 + 16 x IX+0C, y la 0 caeria en el codigo de delante); lo leen
;   p11:A852 (64 bytes)
;   0xa875..0xa8b5  (64 bytes)
DATA_piezas_A875:
	defb 0c5h,0c5h,0c5h,0c5h	; a875
	defb 000h,000h,000h,000h	; a879
	defb 000h,000h,000h,000h	; a87d
	defb 0c6h,0c6h,0c6h,0c6h	; a881
	defb 0c4h,0c4h,0c4h,0c4h	; a885
	defb 000h,000h,000h,000h	; a889
	defb 000h,000h,000h,000h	; a88d
	defb 0c4h,0c4h,0c4h,0c4h	; a891
	defb 0c4h,0c4h,0c4h,0c4h	; a895
	defb 0c5h,0c5h,0c5h,0c5h	; a899
	defb 0c6h,0c6h,0c6h,0c6h	; a89d
	defb 0c4h,0c4h,0c4h,0c4h	; a8a1
	defb 0c4h,0c4h,0c4h,0c4h	; a8a5
	defb 0c4h,0c4h,0c4h,0c4h	; a8a9
	defb 0c4h,0c4h,0c4h,0c4h	; a8ad
	defb 0c4h,0c4h,0c4h,0c4h	; a8b1

; ======================================================================
; CODIGO 0xa8b5..0xa8bf  (10 bytes)
; ======================================================================


jefe_1:		; el jefe 1 (0xEA00): su paso 0xE341 (p11:A8C0)
	ld ix,0ea00h		;a8b5   ; apunta a la ficha del jefe
	ld a,(0e341h)		;a8b9   ; el paso
	call 04084h		;a8bc   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A8BF: 7 destinos del despachador p00:4084 (call en p11:A8BC, el
;   indice en A): A8CD, A90A, A928, A931, A95B, A98E, A99F; lo leen p11:A8BC
;   (14 bytes)
;   0xa8bf..0xa8cd  (14 bytes)
DATA_tabla_A8BF:
	defw 0a8cdh,0a90ah,0a928h,0a931h,0a95bh,0a98eh,0a99fh	; a8bf

; ======================================================================
; CODIGO 0xa8cd..0xa900  (51 bytes)
; ======================================================================


jefe_1_sale:		; sin enemigos y acabada la espera 0xE343: su ficha (p11:A900), 17 golpes y sus caracteres
	call espera_al_jefe		;a8cd   ; espera_al_jefe: NZ mientras queden enemigos o dure la espera 0xE343
	ret nz			;a8d0
	ld a,011h		;a8d1   ; 17 golpes
	ld hl,0a900h		;a8d3   ; su ficha
	call ficha_del_jefe		;a8d6   ; ficha_del_jefe: los 10 bytes de HL a 0xEA00, A golpes (0xEA12), 0xEA13 = 0xE0 y los caracteres de los jefes
	call caja_del_jefe_1		;a8d9   ; p11:AA20
jefe_siguiente:		; el paso siguiente del jefe (0xE341 + 1)
	ld hl,0e341h		;a8dc   ; apunta a el estado del jefe
	inc (hl)			;a8df
	ret			;a8e0
ficha_del_jefe:		; los 10 bytes de HL a 0xEA00, A golpes (0xEA12), 0xEA13 = 0xE0 y los caracteres de los jefes
	ld de,0ea00h		;a8e1   ; apunta a la ficha del jefe
	ld bc,0000ah		;a8e4   ; 10 bytes
	ldir		;a8e7
	ld (0ea12h),a		;a8e9   ; los golpes
	ld a,0e0h		;a8ec
	ld (0ea13h),a		;a8ee   ; guarda 0xE0 al salir el jefe
	jp 04b20h		;a8f1   ; caracteres_de_jefe: con los bancos 13-14-15, los caracteres de los jefes 1-4 (p00:556F, copias p00:559A) y los sprites de p09:BF6D
espera_al_jefe:		; NZ mientras queden enemigos o dure la espera 0xE343
	call 04b70h		;a8f4   ; quedan enemigos?
	ret nz			;a8f7
	ld hl,0e343h		;a8f8   ; la espera
	ld a,(hl)			;a8fb
	and a			;a8fc
	ret z			;a8fd
	dec (hl)			;a8fe   ; un cuadro menos
	ret			;a8ff

; ----------------------------------------------------------------------
; DATOS objeto_A900: 10 bytes que p11:A8D3 pasa a L_A8E1 (con A = 0x11); lo
;   leen p11:A8D6 (10 bytes)
;   0xa900..0xa90a  (10 bytes)
DATA_objeto_A900:
	defb 001h,000h,008h,0c0h,000h,090h,000h,010h,000h,014h	; a900  ..........

; ======================================================================
; CODIGO 0xa90a..0xaaf9  (495 bytes)
; ======================================================================


jefe_1_entra:		; el jefe 1 baja hasta Y 0x40 y luego al paso siguiente
	ld c,040h		;a90a   ; hasta Y 0x40
	call jefe_baja		;a90c   ; jefe_baja: cada 8 cuadros la Y del jefe (0xEA03) - 8; C al llegar a C
	call c,jefe_siguiente		;a90f   ; jefe_siguiente: el paso siguiente del jefe (0xE341 + 1)
	jp caja_del_jefe_1		;a912   ; caja_del_jefe_1: la caja del jefe 1 y su forma segun los golpes
jefe_baja:		; cada 8 cuadros la Y del jefe (0xEA03) - 8; C al llegar a C
	and a			;a915
	dec (ix+002h)		;a916   ; cada 8 cuadros
	ret nz			;a919
	ld (ix+002h),008h		;a91a
	ld a,(0ea03h)		;a91e   ; 8 mas arriba
	sub 008h		;a921
	ld (0ea03h),a		;a923   ; guarda la Y del jefe (16 bits)
	cp c			;a926
	ret			;a927
jefe_1_dispara:		; los 6 disparos del jefe (p11:AB7B)
	call jefe_dispara		;a928   ; jefe_dispara: 6 disparos 0x23 desde los puntos de p11:ABBA que esten en pantalla; suena 0x16
	ld (ix+002h),001h		;a92b   ; espera 1
	jr $-83		;a92f
jefe_1_pelea:		; el jefe 1 se mueve (p11:AA3B), su caja y su nucleo; vencido, p11:A93F
	call jefe_1_mueve		;a931   ; jefe_1_mueve: con la vuelta (0xE20A) dispara antes; el paso de su movimiento: quieto, se mueve, dispara
	call caja_del_jefe_1		;a934   ; caja_del_jefe_1: la caja del jefe 1 y su forma segun los golpes
	ld de,00020h		;a937   ; el nucleo, 32 por debajo y 16 a la derecha
	ld c,010h		;a93a
	call nucleo_del_jefe		;a93c   ; nucleo_del_jefe: IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
jefe_vencido_abre:		; vencido (0xE345): la forma rota (0x15) y 300 cuadros (1 en la fase 7) para entrar; al paso siguiente
	ld a,(0e345h)		;a93f   ; vencido?
	and a			;a942
	ret z			;a943
	ld a,015h		;a944   ; la forma rota
	ld (0ea09h),a		;a946   ; guarda la forma del jefe
	ld hl,0012ch		;a949   ; 300 cuadros
	ld a,(0e201h)		;a94c   ; lee la fase (0-11)
	cp 007h		;a94f
	jr nz,L_A956		;a951
	ld hl,00001h		;a953   ; en la fase 7, 1
L_A956:
	ld (0e343h),hl		;a956   ; guarda la espera del jefe (16 bits)
	jr $-125		;a959
jefe_espera_a_la_nave:		; mientras dura la espera, si la nave entra (0xE22B) desaparece y la pantalla se deshace; si no entra, el jefe estalla
	ld a,(0e201h)		;a95b   ; en la fase 7 no se entra
	cp 007h		;a95e
	call nz,092a4h		;a960   ; nave_entra_al_jefe: si la nave esta junto a la entrada del jefe (0xEA0E, 0xEA10), 0xE22B = 1: al interior
	ld a,(0e22bh)		;a963   ; ha entrado?
	and a			;a966
	jr nz,L_A979		;a967
	ld hl,(0e343h)		;a969   ; la espera
	dec hl			;a96c
	ld (0e343h),hl		;a96d   ; guarda la espera del jefe (16 bits)
	ld a,h			;a970
	or l			;a971
	ret nz			;a972
	call jefe_estalla		;a973   ; no ha entrado: estalla
	jp jefe_siguiente		;a976   ; jefe_siguiente: el paso siguiente del jefe (0xE341 + 1)
L_A979:
	ld a,01eh		;a979   ; 30 cuadros
	ld (0e343h),a		;a97b   ; guarda la espera del jefe (16 bits)
	ld hl,00001h		;a97e   ; sin enemigos ni su dibujo
	ld (0e3aah),hl		;a981   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo y el byte siguiente (16 bits)
	xor a			;a984   ; la nave ya no esta
	ld (0e400h),a		;a985   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ld hl,0e341h		;a988   ; dos pasos mas: se deshace
	inc (hl)			;a98b
	inc (hl)			;a98c
	ret			;a98d
jefe_estalla_espera:		; al acabar la espera, el jefe se acaba (p11:A993)
	ld hl,0e343h		;a98e   ; la espera
	dec (hl)			;a991
	ret nz			;a992
jefe_acabado:		; sin jefe (0xE340 = 0, 0xE34F = 0) y 0xE342 = 1: vencido
	xor a			;a993
	ld (0e340h),a		;a994   ; sin jefe
	ld (0e34fh),a		;a997   ; guarda la marca de jefe o suceso acabado
	inc a			;a99a   ; vencido
	ld (0e342h),a		;a99b   ; guarda la marca de jefe vencido
	ret			;a99e
jefe_se_deshace:		; la pantalla se deshace (p11:A2A2); al acabar, 0xE3AA = 0 y el jefe se acaba
	call pantalla_se_deshace		;a99f   ; pantalla_se_deshace: la pantalla se deshace (paso 0xE3AB): los dibujos y luego los colores van perdiendo bits; despues todo a cero, 60 cuadros y 0xE3AE = 1
	ld a,(0e3aeh)		;a9a2   ; hasta que acabe
	and a			;a9a5
	ret z			;a9a6
	xor a			;a9a7
	ld (0e3aah),a		;a9a8   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo
	jr jefe_acabado		;a9ab
nucleo_del_jefe:		; IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
	ld l,(ix+003h)		;a9ad   ; la Y + DE
	ld h,(ix+004h)		;a9b0
	add hl,de			;a9b3
	ld a,h			;a9b4   ; dentro de la pantalla
	and a			;a9b5
	jr nz,L_A9C3		;a9b6
	ld (ix+013h),l		;a9b8
	ld a,(ix+005h)		;a9bb   ; la X + C
	add a,c			;a9be
	ld (ix+014h),a		;a9bf
	ret			;a9c2
L_A9C3:
	ld (ix+013h),0e0h		;a9c3   ; fuera: Y 0xE0
	ret			;a9c7
jefe_estalla:		; la parte IX libre, 90 cuadros de espera, una explosion en su sitio y suena 9 (el 5) o 0x3B
	ld a,(ix+000h)		;a9c8   ; la parte
	ld b,a			;a9cb
	xor a			;a9cc
	ld (ix+000h),a		;a9cd   ; libre
	ld a,05ah		;a9d0   ; 90 cuadros
	ld (0e343h),a		;a9d2   ; guarda la espera del jefe (16 bits)
	ld l,(ix+00eh)		;a9d5   ; su sitio
	ld h,(ix+00fh)		;a9d8
	ld a,h			;a9db
	and a			;a9dc
	ret nz			;a9dd
	ld e,l			;a9de
	push bc			;a9df
	ld a,(ix+010h)		;a9e0
	ld d,a			;a9e3
	call 08ba1h		;a9e4   ; la explosion
	pop af			;a9e7
	cp 005h		;a9e8   ; el 5: suena 9; los demas, 0x3B
	ld a,009h		;a9ea
	jr z,L_A9F0		;a9ec
	ld a,03bh		;a9ee
L_A9F0:
	jp 04ae4h		;a9f0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
caja_del_jefe:		; la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld l,(ix+003h)		;a9f3   ; la Y + A
	ld h,(ix+004h)		;a9f6
	ld d,000h		;a9f9   ; + A
	ld e,a			;a9fb
	add hl,de			;a9fc
	ld (ix+00ah),l		;a9fd   ; IX+0A/IX+0B: la Y de la caja
	ld (ix+00bh),h		;aa00
	ld (ix+00eh),l		;aa03   ; IX+0E/IX+0F
	ld (ix+00fh),h		;aa06
	ld l,(ix+005h)		;aa09   ; la X + B
	ld h,(ix+006h)		;aa0c
	ld e,b			;aa0f
	add hl,de			;aa10   ; + B
	ld (ix+00ch),l		;aa11   ; IX+0C/IX+0D: la X de la caja
	ld (ix+00dh),h		;aa14
	ld e,c			;aa17   ; + C
	add hl,de			;aa18   ; + C
	ld (ix+010h),l		;aa19   ; IX+10/IX+11: el final de la caja
	ld (ix+011h),h		;aa1c
	ret			;aa1f
caja_del_jefe_1:		; la caja del jefe 1 y su forma segun los golpes
	ld a,020h		;aa20
	ld bc,01028h		;aa22   ; 32 abajo, 16 a la derecha, 40 de ancho
	call caja_del_jefe		;aa25   ; caja_del_jefe: la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld bc,00200h		;aa28   ; un paso de forma cada 2 golpes
forma_por_golpes:		; IX+08 = C + los golpes (IX+12) / B
	ld a,(ix+012h)		;aa2b
L_AA2E:
	sub b			;aa2e   ; cuantas veces cabe B
	jr c,L_AA37		;aa2f   ; cabe otra vez?
	jp m,L_AA37		;aa31
	inc c			;aa34   ; una mas
	jr L_AA2E		;aa35
L_AA37:
	ld (ix+008h),c		;aa37   ; la forma
	ret			;aa3a
jefe_1_mueve:		; con la vuelta (0xE20A) dispara antes; el paso de su movimiento: quieto, se mueve, dispara
	ld a,(0e20ah)		;aa3b   ; con la vuelta, mas disparos
	and a			;aa3e
	jr z,L_AA44		;aa3f
	call jefe_dispara_antes		;aa41   ; jefe_dispara_antes: al acabar IX+18, dispara y la espera de nuevo (0x38 - nivel)
L_AA44:
	ld a,(ix+001h)		;aa44   ; el paso
	dec a			;aa47
	jr z,jefe_1_anda		;aa48
	dec a			;aa4a
	jp z,jefe_espera_disparo		;aa4b   ; jefe_espera_disparo: al acabar IX+18, dispara (p11:AB7B) y vuelve al paso 0
	dec (ix+002h)		;aa4e   ; paso 0: la espera
	ret nz			;aa51
	call jefe_elige_rumbo		;aa52   ; elige direccion
	inc (ix+001h)		;aa55
	ret			;aa58
jefe_dispara_antes:		; al acabar IX+18, dispara y la espera de nuevo (0x38 - nivel)
	call jefe_espera_disparo		;aa59   ; jefe_espera_disparo: al acabar IX+18, dispara (p11:AB7B) y vuelve al paso 0
	ret nz			;aa5c
	ld a,(0e228h)		;aa5d   ; 0x38 - nivel
	neg		;aa60
	add a,038h		;aa62
	ld (ix+018h),a		;aa64
	ret			;aa67
jefe_espera_disparo:		; al acabar IX+18, dispara (p11:AB7B) y vuelve al paso 0
	dec (ix+018h)		;aa68
	ret nz			;aa6b
	call jefe_dispara		;aa6c   ; dispara
L_AA6F:
	ld (ix+002h),008h		;aa6f   ; 8 cuadros, paso 0
	xor a			;aa73
	ld (ix+001h),a		;aa74
	ret			;aa77
jefe_1_anda:		; se mueve (p11:AAFD); al acabar, al paso de disparar (4 cuadros)
	call jefe_anda		;aa78   ; se mueve
	ret nc			;aa7b
	ld a,(0e20ah)		;aa7c   ; con la vuelta, otra vez
	and a			;aa7f
	jr nz,L_AA6F		;aa80
	ld (ix+018h),004h		;aa82   ; 4 cuadros, al paso de disparar
	inc (ix+001h)		;aa86
	ret			;aa89
jefe_elige_rumbo:		; una direccion al azar (tres de cada cuatro segun la nave, si no hacia ella en X)
	ld a,r		;aa8a   ; una de cada cuatro
	and 00fh		;aa8c
	cp 00ch		;aa8e
	jr nc,jefe_rumbo_en_x		;aa90
jefe_rumbo_segun_nave:		; segun donde esta: hacia el centro en Y, o hacia la nave
	ld a,(ix+004h)		;aa92   ; lejos de arriba?
	and a			;aa95
	jr z,L_AAA0		;aa96
	ld a,002h		;aa98   ; sube o baja hacia el centro
	jp m,pon_rumbo_del_jefe		;aa9a   ; pon_rumbo_del_jefe: IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
	dec a			;aa9d
	jr pon_rumbo_del_jefe		;aa9e
L_AAA0:
	ld a,(0e406h)		;aaa0   ; con la nave a la derecha
	cp 080h		;aaa3
	jr c,L_AAB0		;aaa5
	ld a,(ix+005h)		;aaa7   ; y el jefe a la izquierda, a la derecha
	cp 060h		;aaaa
	ld a,004h		;aaac
	jr c,pon_rumbo_del_jefe		;aaae
L_AAB0:
	ld a,(0e340h)		;aab0   ; la altura de su boca (p11:AAF9)
	dec a			;aab3
	ld hl,0aaf9h		;aab4
	call 0407ah		;aab7   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;aaba
	ld a,(ix+003h)		;aabb
	add a,c			;aabe
	jr c,L_AAC9		;aabf
	ld hl,0e404h		;aac1   ; la nave por encima: sube
	cp (hl)			;aac4
	ld a,002h		;aac5
	jr c,pon_rumbo_del_jefe		;aac7
L_AAC9:
	ld a,001h		;aac9   ; si no, baja
pon_rumbo_del_jefe:		; IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
	ld (ix+015h),a		;aacb   ; la direccion
	ld (ix+002h),0ffh		;aace   ; la cuenta
	cp 003h		;aad2   ; 8-11 pasos, o 10-13 en horizontal
	ld c,008h		;aad4
	jr c,L_AADA		;aad6
	ld c,00ah		;aad8
L_AADA:
	ld a,r		;aada
	and 003h		;aadc   ; 0-3
	add a,c			;aade
	ld (ix+016h),a		;aadf   ; los pasos
	ld a,(0e228h)		;aae2   ; la rapidez: 0x40 + 2 x nivel
	add a,a			;aae5
	add a,040h		;aae6
	ld (ix+017h),a		;aae8   ; la rapidez
	ret			;aaeb
jefe_rumbo_en_x:		; hacia la nave en X (3 o 4)
	ld a,(0e406h)		;aaec   ; la nave a la izquierda: 3
	cp (ix+005h)		;aaef
	ld a,003h		;aaf2
	jr c,pon_rumbo_del_jefe		;aaf4
	inc a			;aaf6   ; a la derecha: 4
	jr pon_rumbo_del_jefe		;aaf7

; ----------------------------------------------------------------------
; DATOS tabla_AAF9: 4 bytes que p11:AAB0 lee con 0xE340 - 1; lo leen p11:AAB7
;   (4 bytes)
;   0xaaf9..0xaafd  (4 bytes)
DATA_tabla_AAF9:
	defb 028h,030h,040h,040h	; aaf9

; ======================================================================
; CODIGO 0xaafd..0xabba  (189 bytes)
; ======================================================================


jefe_anda:		; suma la rapidez; cada vez que pasa, 8 pixeles en su direccion (1 arriba, 2 abajo, 3 izquierda, 4 derecha) sin salirse; C al acabar
	ld a,(ix+017h)		;aafd   ; suma la rapidez
	add a,(ix+002h)		;ab00
	ld (ix+002h),a		;ab03
	ret nc			;ab06   ; sin pasar, nada
	dec (ix+016h)		;ab07   ; un paso menos
	jr z,jefe_acaba_rumbo		;ab0a
	ld (ix+002h),a		;ab0c
	ld a,(ix+015h)		;ab0f   ; la direccion
	and a			;ab12
	ret z			;ab13
	dec a			;ab14
	jr z,L_AB55		;ab15
	dec a			;ab17
	jr z,L_AB36		;ab18
	dec a			;ab1a
	jr z,L_AB2B		;ab1b
	ld a,(ix+005h)		;ab1d   ; 4: a la derecha, hasta 0xB0
	add a,008h		;ab20
	cp 0b0h		;ab22
	jr nc,jefe_acaba_rumbo		;ab24
L_AB26:
	ld (ix+005h),a		;ab26
	and a			;ab29
	ret			;ab2a
L_AB2B:
	ld a,(ix+005h)		;ab2b   ; 3: a la izquierda, desde 0x19
	sub 008h		;ab2e
	cp 019h		;ab30   ; hasta 0x19
	jr c,jefe_acaba_rumbo		;ab32
	jr L_AB26		;ab34
L_AB36:
	ld hl,(0ea03h)		;ab36   ; 2: baja
	ld de,00008h		;ab39
	add hl,de			;ab3c   ; + 8
	ld a,h			;ab3d
	and a			;ab3e
	jr nz,L_AB50		;ab3f   ; fuera: se queda
	ld de,00080h		;ab41   ; hasta 0x80 (0x68 el jefe 2)
	cp 002h		;ab44   ; el jefe 2, hasta 0x68
	jr nz,L_AB4A		;ab46
	ld e,068h		;ab48
L_AB4A:
	ld a,(0e340h)		;ab4a   ; lee el tipo de jefe (1-5; 0 sin jefe)
	rst 20h			;ab4d
	jr nc,jefe_da_la_vuelta		;ab4e
L_AB50:
	ld (0ea03h),hl		;ab50   ; guarda la Y del jefe (16 bits)
	and a			;ab53
	ret			;ab54
L_AB55:
	ld hl,(0ea03h)		;ab55   ; 1: sube
	ld de,0fff8h		;ab58
	add hl,de			;ab5b
	ld (0ea03h),hl		;ab5c   ; guarda la Y del jefe (16 bits)
	ld a,h			;ab5f
	and a			;ab60
	ret p			;ab61
	ld a,(0e340h)		;ab62   ; hasta 0xF0 (0xC0 el jefe 3)
	cp 003h		;ab65
	ld c,0f0h		;ab67
	jr nz,L_AB6D		;ab69
	ld c,0c0h		;ab6b
L_AB6D:
	ld a,l			;ab6d
	cp c			;ab6e
	ret nc			;ab6f
jefe_da_la_vuelta:		; invierte la direccion vertical (IX+15 XOR 3)
	ld a,(ix+015h)		;ab70   ; al llegar, da la vuelta
	xor 003h		;ab73
	ld (ix+015h),a		;ab75
	ret			;ab78
jefe_acaba_rumbo:		; C
	scf			;ab79
	ret			;ab7a
jefe_dispara:		; 6 disparos 0x23 desde los puntos de p11:ABBA que esten en pantalla; suena 0x16
	ld de,0abbah		;ab7b   ; 6 puntos de disparo
	ld b,006h		;ab7e
L_AB80:
	push bc			;ab80   ; el punto
	push de			;ab81
	ld l,(ix+003h)		;ab82   ; la Y del jefe
	ld h,(ix+004h)		;ab85
	ld a,(de)			;ab88   ; + la del punto
	ld c,a			;ab89
	inc de			;ab8a
	ld a,(de)			;ab8b   ; su Y
	ld b,a			;ab8c
	add hl,bc			;ab8d   ; sumada a la del jefe
	ld a,h			;ab8e   ; fuera de la pantalla, no
	and a			;ab8f
	jr nz,L_ABAD		;ab90
	ld a,l			;ab92
	cp 0b0h		;ab93   ; por debajo de 0xB0
	jr nc,L_ABAD		;ab95
	ex de,hl			;ab97
	ld a,(ix+005h)		;ab98   ; la X + la del punto
	inc hl			;ab9b
	add a,(hl)			;ab9c   ; la X del punto
	ld d,a			;ab9d
	cp 0e0h		;ab9e   ; por debajo de 0xE0
	jr nc,L_ABAD		;aba0
	inc hl			;aba2
	ld b,(hl)			;aba3   ; B
	and 07fh		;aba4
	ld c,000h		;aba6
	ld a,023h		;aba8   ; un 0x23
	call 04d16h		;abaa   ; crea_enemigo_ix: crea_enemigo conservando IX
L_ABAD:
	pop de			;abad
	pop bc			;abae
	inc de			;abaf   ; 4 bytes por punto
	inc de			;abb0
	inc de			;abb1
	inc de			;abb2
	djnz L_AB80		;abb3
	ld a,016h		;abb5   ; suena 0x16
	jp 04ae4h		;abb7   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS tabla_ABBA: 6 fichas de 4 bytes que p11:AB7B recorre; lo leen p11:AB80
;   (24 bytes)
;   0xabba..0xabd2  (24 bytes)
DATA_tabla_ABBA:
	defb 010h,000h,0f0h,000h	; abba
	defb 01ah,000h,0f8h,001h	; abbe
	defb 032h,000h,0f8h,002h	; abc2
	defb 03ch,000h,0f0h,003h	; abc6
	defb 008h,000h,030h,003h	; abca
	defb 048h,000h,030h,000h	; abce

; ======================================================================
; CODIGO 0xabd2..0xac27  (85 bytes)
; ======================================================================


tipo_23_empieza:		; el tipo 0x23: hacia la izquierda (la rapidez segun el nivel), 1 x 2, IX+10 = 5 y su dibujo
	call rapidez_23		;abd2   ; la rapidez
	call 05cb5h		;abd5   ; hacia la izquierda
	ld de,00000h		;abd8
	ex de,hl			;abdb
	call 04f26h		;abdc   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
	ld (ix+013h),001h		;abdf   ; 1 x 2
	ld (ix+014h),002h		;abe3
	ld (ix+010h),005h		;abe7   ; IX+10 = 5
	ld a,(ix+019h)		;abeb   ; su dibujo: 0x72 + B
	add a,072h		;abee
	ld (ix+032h),a		;abf0
	ret			;abf3
rapidez_23:		; HL = 0x700 + 32 x nivel; de 0x900 en adelante, 0x6FF
	ld a,(0e228h)		;abf4   ; 32 x nivel
	ld l,a			;abf7   ; el nivel
	ld h,000h		;abf8
	add hl,hl			;abfa   ; x 32
	add hl,hl			;abfb
	add hl,hl			;abfc
	add hl,hl			;abfd
	add hl,hl			;abfe
	ld de,00700h		;abff   ; + 0x700
	add hl,de			;ac02   ; + 0x700
	ld de,00900h		;ac03
	rst 20h			;ac06   ; como mucho 0x8FF
	ret c			;ac07
	ld hl,006ffh		;ac08   ; como mucho 0x6FF
	ret			;ac0b
tipo_23:		; el tipo 0x23: se quita al salir por la izquierda
	call 04f09h		;ac0c   ; la vx
	ld l,(ix+005h)		;ac0f   ; la X
	ld h,(ix+006h)		;ac12
	add hl,de			;ac15
	ld a,h			;ac16
	cp 0f0h		;ac17   ; al salir, se quita
	ret c			;ac19
	jp 06514h		;ac1a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
jefe_2:		; el jefe 2 (0xEA00): su paso 0xE341 (p11:AC27)
	ld ix,0ea00h		;ac1d   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ac21   ; el paso
	call 04084h		;ac24   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_AC27: 7 destinos del despachador p00:4084 (call en p11:AC24, el
;   indice en A): AC35, AC53, AC5E, AC77, A95B, A98E, A99F; lo leen p11:AC24
;   (14 bytes)
;   0xac27..0xac35  (14 bytes)
DATA_tabla_AC27:
	defw 0ac35h,0ac53h,0ac5eh,0ac77h,0a95bh,0a98eh,0a99fh	; ac27

; ======================================================================
; CODIGO 0xac35..0xac49  (20 bytes)
; ======================================================================


jefe_2_sale:		; sin enemigos y acabada la espera: su ficha (p11:AC49), 34 golpes y su caja
	call espera_al_jefe		;ac35   ; espera_al_jefe: NZ mientras queden enemigos o dure la espera 0xE343
	ret nz			;ac38
	ld hl,0ac49h		;ac39
	ld a,022h		;ac3c   ; 34 golpes
	call ficha_del_jefe		;ac3e   ; ficha_del_jefe: los 10 bytes de HL a 0xEA00, A golpes (0xEA12), 0xEA13 = 0xE0 y los caracteres de los jefes
	call caja_del_jefe_2		;ac41   ; caja_del_jefe_2: la caja del jefe 2 y su forma segun los golpes
jefe_2_siguiente:		; el paso siguiente
	ld hl,0e341h		;ac44   ; apunta a el estado del jefe
	inc (hl)			;ac47
	ret			;ac48

; ----------------------------------------------------------------------
; DATOS objeto_AC49: 10 bytes que p11:AC39 pasa a L_A8E1 (con A = 0x22); lo
;   leen p11:AC3E (10 bytes)
;   0xac49..0xac53  (10 bytes)
DATA_objeto_AC49:
	defb 002h,000h,008h,0c0h,000h,080h,000h,011h,009h,014h	; ac49  ..........

; ======================================================================
; CODIGO 0xac53..0xac9f  (76 bytes)
; ======================================================================


jefe_2_entra:		; baja hasta Y 0x40
	ld c,040h		;ac53
	call jefe_baja		;ac55   ; jefe_baja: cada 8 cuadros la Y del jefe (0xEA03) - 8; C al llegar a C
	call c,jefe_2_siguiente		;ac58   ; jefe_2_siguiente: el paso siguiente
	jp caja_del_jefe_2		;ac5b   ; caja_del_jefe_2: la caja del jefe 2 y su forma segun los golpes
jefe_2_empieza:		; su primer movimiento, esperas 64 y 32
	call jefe_2_suelta		;ac5e   ; jefe_2_suelta: dos tipo 0x38 desde el jefe, en su Y + 16 y + 64
	ld (ix+002h),001h		;ac61   ; 1 cuadro
	ld (ix+018h),040h		;ac65   ; 64
	ld (ix+01ah),020h		;ac69   ; 32
	ld (ix+01bh),000h		;ac6d
	ld (ix+001h),002h		;ac71   ; al paso 2
	jr $-49		;ac75
jefe_2_pelea:		; se mueve, su caja y su nucleo; vencido, p11:A93F
	call jefe_2_mueve		;ac77   ; jefe_2_mueve: lo de su paso (p11:AC9F)
	call caja_del_jefe_2		;ac7a   ; caja_del_jefe_2: la caja del jefe 2 y su forma segun los golpes
	ld de,00028h		;ac7d   ; el nucleo, 40 por debajo y 40 a la derecha
	ld c,028h		;ac80
	call nucleo_del_jefe		;ac82   ; nucleo_del_jefe: IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
	jp jefe_vencido_abre		;ac85   ; jefe_vencido_abre: vencido (0xE345): la forma rota (0x15) y 300 cuadros (1 en la fase 7) para entrar; al paso siguiente
caja_del_jefe_2:		; la caja del jefe 2 y su forma segun los golpes
	ld a,028h		;ac88
	ld bc,03020h		;ac8a   ; 40 abajo, 48 a la derecha, 32 de ancho
	call caja_del_jefe		;ac8d   ; caja_del_jefe: la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld bc,00509h		;ac90   ; un paso de forma cada 5 golpes, desde 9
	jp forma_por_golpes		;ac93   ; forma_por_golpes: IX+08 = C + los golpes (IX+12) / B
jefe_2_mueve:		; lo de su paso (p11:AC9F)
	call jefe_2_embiste		;ac96   ; jefe_2_embiste: cada IX+18 cuadros guarda el paso y embiste (pasos 2-4)
	ld a,(ix+001h)		;ac99   ; por paso
	call 04084h		;ac9c   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_AC9F: 5 destinos del despachador p00:4084 (call en p11:AC9C, el
;   indice en A): ACA9, ACAF, ACBB, ACC3, ACD0; lo leen p11:AC9C (10 bytes)
;   0xac9f..0xaca9  (10 bytes)
DATA_tabla_AC9F:
	defw 0aca9h,0acafh,0acbbh,0acc3h,0acd0h	; ac9f

; ======================================================================
; CODIGO 0xaca9..0xad33  (138 bytes)
; ======================================================================


jefe_2_elige:		; elige direccion y al paso siguiente
	inc (ix+001h)		;aca9
	jp jefe_rumbo_segun_nave		;acac   ; jefe_rumbo_segun_nave: segun donde esta: hacia el centro en Y, o hacia la nave
jefe_2_anda:		; se mueve; al acabar, vuelve atras
	call jefe_anda		;acaf   ; jefe_anda: suma la rapidez; cada vez que pasa, 8 pixeles en su direccion (1 arriba, 2 abajo, 3 izquierda, 4 derecha) sin salirse; C al acabar
	ret nc			;acb2
	dec (ix+001h)		;acb3   ; vuelve atras
	ld (ix+002h),004h		;acb6   ; 4 cuadros
	ret			;acba
jefe_2_espera:		; espera IX+1A
	dec (ix+01ah)		;acbb
	ret nz			;acbe
jefe_2_paso_siguiente:		; IX+01 + 1
	inc (ix+001h)		;acbf
	ret			;acc2
jefe_2_a_la_izquierda:		; 8 a la izquierda hasta X 8
	ld a,(ix+005h)		;acc3
	cp 008h		;acc6   ; hasta X 8
	jr z,jefe_2_paso_siguiente		;acc8   ; al llegar, el paso siguiente
	add a,0f8h		;acca   ; 8 a la izquierda
	ld (ix+005h),a		;accc
	ret			;accf
jefe_2_a_la_derecha:		; 8 a la derecha hasta X 0x80; luego al paso guardado
	ld a,(ix+005h)		;acd0
	cp 080h		;acd3   ; hasta X 0x80
	jr z,L_ACDD		;acd5
	add a,008h		;acd7   ; 8 a la derecha
	ld (ix+005h),a		;acd9
	ret			;acdc
L_ACDD:
	ld a,(ix+01bh)		;acdd   ; vuelve al paso guardado
	ld (ix+001h),a		;ace0
	ret			;ace3
jefe_2_embiste:		; cada IX+18 cuadros guarda el paso y embiste (pasos 2-4)
	ld a,(ix+001h)		;ace4
	cp 003h		;ace7   ; en los pasos 0-2
	ret nc			;ace9
	dec (ix+018h)		;acea   ; la espera
	ret nz			;aced
	ld a,(ix+001h)		;acee   ; guarda el paso
	ld (ix+01bh),a		;acf1
	ld (ix+001h),002h		;acf4   ; a embestir
	ld (ix+01ah),020h		;acf8
	ld a,r		;acfc   ; tres de cada cuatro
	and 003h		;acfe
	ld a,020h		;ad00   ; 32 cuadros
	jr z,L_AD0C		;ad02
	ld a,(0e228h)		;ad04   ; si no, 0x40 - 2 x nivel
	add a,a			;ad07
	sub 040h		;ad08
	neg		;ad0a
L_AD0C:
	ld (ix+018h),a		;ad0c
jefe_2_suelta:		; dos tipo 0x38 desde el jefe, en su Y + 16 y + 64
	ld bc,00210h		;ad0f   ; dos, a 16 y luego 64 por debajo
L_AD12:
	push bc			;ad12
	ld d,(ix+005h)		;ad13   ; su X
	ld a,(ix+003h)		;ad16
	add a,c			;ad19
	ld e,a			;ad1a
	ld bc,00000h		;ad1b
	ld a,038h		;ad1e   ; un 0x38
	call 04d16h		;ad20   ; crea_enemigo_ix: crea_enemigo conservando IX
	pop bc			;ad23
	ld c,040h		;ad24
	djnz L_AD12		;ad26
	ret			;ad28
jefe_4:		; el jefe 4 (0xEA00): su paso 0xE341 (p11:AD33)
	ld ix,0ea00h		;ad29   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ad2d   ; el paso
	call 04084h		;ad30   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_AD33: 7 destinos del despachador p00:4084 (call en p11:AD30, el
;   indice en A): AD41, AD5D, AD68, AD77, A95B, A98E, A99F; lo leen p11:AD30
;   (14 bytes)
;   0xad33..0xad41  (14 bytes)
DATA_tabla_AD33:
	defw 0ad41h,0ad5dh,0ad68h,0ad77h,0a95bh,0a98eh,0a99fh	; ad33

; ======================================================================
; CODIGO 0xad41..0xad53  (18 bytes)
; ======================================================================


jefe_4_sale:		; sin enemigos y acabada la espera: su ficha (p11:AD53), 26 golpes y su caja
	call espera_al_jefe		;ad41   ; espera_al_jefe: NZ mientras queden enemigos o dure la espera 0xE343
	ret nz			;ad44
	ld a,01ah		;ad45   ; 26 golpes
	ld hl,0ad53h		;ad47
	call ficha_del_jefe		;ad4a   ; ficha_del_jefe: los 10 bytes de HL a 0xEA00, A golpes (0xEA12), 0xEA13 = 0xE0 y los caracteres de los jefes
	call caja_del_jefe_4		;ad4d   ; caja_del_jefe_4: la caja del jefe 4 y su forma segun los golpes
	jp jefe_siguiente		;ad50   ; jefe_siguiente: el paso siguiente del jefe (0xE341 + 1)

; ----------------------------------------------------------------------
; DATOS objeto_AD53: 10 bytes que p11:AD47 pasa a L_A8E1 (con A = 0x1A); lo
;   leen p11:AD4A (10 bytes)
;   0xad53..0xad5d  (10 bytes)
DATA_objeto_AD53:
	defb 004h,000h,008h,0c0h,000h,0a0h,000h,013h,000h,014h	; ad53  ..........

; ======================================================================
; CODIGO 0xad5d..0xae21  (196 bytes)
; ======================================================================


jefe_4_entra:		; baja hasta Y 0x18
	ld c,018h		;ad5d   ; hasta Y 0x18
	call jefe_baja		;ad5f   ; jefe_baja: cada 8 cuadros la Y del jefe (0xEA03) - 8; C al llegar a C
	call c,jefe_siguiente		;ad62   ; jefe_siguiente: el paso siguiente del jefe (0xE341 + 1)
	jp caja_del_jefe_4		;ad65   ; caja_del_jefe_4: la caja del jefe 4 y su forma segun los golpes
jefe_4_empieza:		; 0xEA18 = 1 y esperas de 1
	ld hl,00001h		;ad68
	ld (0ea18h),hl		;ad6b   ; guarda dato del jefe 4 y el byte siguiente (16 bits)
	ld (ix+002h),l		;ad6e
	ld (ix+01ch),l		;ad71
	jp jefe_siguiente		;ad74   ; jefe_siguiente: el paso siguiente del jefe (0xE341 + 1)
jefe_4_pelea:		; se mueve y dispara, su caja y su nucleo; vencido, p11:A93F
	call jefe_4_mueve		;ad77   ; jefe_4_mueve: elige direccion y anda; en la pausa de disparos, al acabar IX+18 suelta 4 rayos (tipos 0x39/0x3A, p11:AE1F) y suena 0x19
	call caja_del_jefe_4		;ad7a   ; caja_del_jefe_4: la caja del jefe 4 y su forma segun los golpes
	ld de,00038h		;ad7d   ; el nucleo, 56 por debajo y 24 a la derecha
	ld c,018h		;ad80
	call nucleo_del_jefe		;ad82   ; nucleo_del_jefe: IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
	jp jefe_vencido_abre		;ad85   ; jefe_vencido_abre: vencido (0xE345): la forma rota (0x15) y 300 cuadros (1 en la fase 7) para entrar; al paso siguiente
caja_del_jefe_4:		; la caja del jefe 4 y su forma segun los golpes
	ld a,038h		;ad88
	ld bc,01820h		;ad8a   ; 56 abajo, 24 a la derecha, 32 de ancho
	call caja_del_jefe		;ad8d   ; caja_del_jefe: la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld bc,00300h		;ad90   ; un paso de forma cada 3 golpes
	jp forma_por_golpes		;ad93   ; forma_por_golpes: IX+08 = C + los golpes (IX+12) / B
jefe_4_mueve:		; elige direccion y anda; en la pausa de disparos, al acabar IX+18 suelta 4 rayos (tipos 0x39/0x3A, p11:AE1F) y suena 0x19
	ld a,(ix+001h)		;ad96   ; andando?
	dec a			;ad99
	jr z,L_ADA7		;ad9a
	dec (ix+002h)		;ad9c   ; la espera
	jr nz,L_ADB3		;ad9f
	inc (ix+001h)		;ada1   ; elige direccion
	jp jefe_rumbo_segun_nave		;ada4   ; jefe_rumbo_segun_nave: segun donde esta: hacia el centro en Y, o hacia la nave
L_ADA7:
	call jefe_anda		;ada7   ; anda
	jr nc,L_ADB3		;adaa
	ld hl,01000h		;adac   ; acabado: pausa
	ld (0ea01h),hl		;adaf
	ret			;adb2
L_ADB3:
	ld a,(ix+019h)		;adb3   ; disparando?
	or a			;adb6
	jr nz,L_ADCD		;adb7
	dec (ix+018h)		;adb9   ; la espera
	ret nz			;adbc
	ld hl,00618h		;adbd   ; 6 rayos cada 24 (12 cada 12 con la vuelta)
	ld a,(0e20ah)		;adc0   ; lee la vuelta (bit 0: las fases bajan)
	rra			;adc3
	jr nc,L_ADC9		;adc4
	ld hl,00c0ch		;adc6
L_ADC9:
	ld (0ea18h),hl		;adc9   ; guarda dato del jefe 4 y el byte siguiente (16 bits)
	ret			;adcc
L_ADCD:
	dec (ix+018h)		;adcd   ; la espera entre rayos
	ret nz			;add0
	ld a,(0e201h)		;add1   ; 24 en la fase 2, 12 en las demas
	cp 002h		;add4
	ld b,018h		;add6
	jr z,L_ADDC		;add8
	ld b,00ch		;adda
L_ADDC:
	ld (ix+018h),b		;addc
	dec (ix+019h)		;addf   ; uno menos; al ultimo, 60 cuadros
	jr nz,L_ADE8		;ade2
	ld (ix+018h),03ch		;ade4
L_ADE8:
	ld b,004h		;ade8   ; 4 a la vez
L_ADEA:
	push bc			;adea
	ld a,b			;adeb
	ld hl,0ae1fh		;adec   ; el punto de p11:AE1F
	call 04b67h		;adef   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(0ea03h)		;adf2   ; la Y del jefe + la del punto
	add a,e			;adf5
	cp 0b0h		;adf6   ; fuera, no
	jr nc,L_AE19		;adf8
	ld e,a			;adfa
	inc hl			;adfb
	ld a,(0ea05h)		;adfc   ; la X
	add a,d			;adff
	ld d,a			;ae00
	ld c,b			;ae01
	ld b,00ch		;ae02   ; 12 de largo en la fase 2, 6 en las demas
	ld a,(0e201h)		;ae04   ; lee la fase (0-11)
	cp 002h		;ae07
	jr z,L_AE0D		;ae09
	ld b,006h		;ae0b
L_AE0D:
	ld a,(0e20ah)		;ae0d   ; 0x39, o 0x3A con la vuelta
	rra			;ae10   ; con la vuelta
	ld a,039h		;ae11
	jr nc,L_AE16		;ae13
	inc a			;ae15
L_AE16:
	call 04d16h		;ae16   ; crea_enemigo_ix: crea_enemigo conservando IX
L_AE19:
	pop bc			;ae19
	djnz L_ADEA		;ae1a
	ld a,019h		;ae1c   ; suena 0x19
	jp 04ae4h		;ae1e   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS tabla_AE21: 4 palabras (B de 1 a 4: p11:ADEC lee 0xAE1F + 2 x B, y la
;   0 caeria en el codigo de delante); lo leen p11:ADEF (8 bytes)
;   0xae21..0xae29  (8 bytes)
DATA_tabla_AE21:
	defw 01810h,0182eh,01850h,0186eh	; ae21

; ======================================================================
; CODIGO 0xae29..0xae33  (10 bytes)
; ======================================================================


jefe_3:		; el jefe 3 (0xEA00): su paso 0xE341 (p11:AE33)
	ld ix,0ea00h		;ae29   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ae2d   ; el paso
	call 04084h		;ae30   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_AE33: 7 destinos del despachador p00:4084 (call en p11:AE30, el
;   indice en A): AE41, AE62, AE6D, AE77, A95B, A98E, A99F; lo leen p11:AE30
;   (14 bytes)
;   0xae33..0xae41  (14 bytes)
DATA_tabla_AE33:
	defw 0ae41h,0ae62h,0ae6dh,0ae77h,0a95bh,0a98eh,0a99fh	; ae33

; ======================================================================
; CODIGO 0xae41..0xae58  (23 bytes)
; ======================================================================


jefe_3_sale:		; sin enemigos: los caracteres de los jefes, su ficha (p11:AE58), 55 golpes y su caja
	call espera_al_jefe		;ae41   ; espera_al_jefe: NZ mientras queden enemigos o dure la espera 0xE343
	ret nz			;ae44
	call 04b20h		;ae45   ; caracteres_de_jefe: con los bancos 13-14-15, los caracteres de los jefes 1-4 (p00:556F, copias p00:559A) y los sprites de p09:BF6D
	ld hl,0ae58h		;ae48
	ld a,037h		;ae4b   ; 55 golpes
	call ficha_del_jefe		;ae4d   ; ficha_del_jefe: los 10 bytes de HL a 0xEA00, A golpes (0xEA12), 0xEA13 = 0xE0 y los caracteres de los jefes
	call caja_del_jefe_3		;ae50   ; caja_del_jefe_3: la caja del jefe 3 y su forma segun los golpes
jefe_3_siguiente:		; el paso siguiente
	ld hl,0e341h		;ae53   ; apunta a el estado del jefe
	inc (hl)			;ae56
	ret			;ae57

; ----------------------------------------------------------------------
; DATOS objeto_AE58: 10 bytes que p11:AE48 pasa a L_A8E1 (con A = 0x37); lo
;   leen p11:AE4D (10 bytes)
;   0xae58..0xae62  (10 bytes)
DATA_objeto_AE58:
	defb 003h,000h,008h,0c0h,000h,078h,000h,012h,009h,014h	; ae58  .....x....

; ======================================================================
; CODIGO 0xae62..0xaf78  (278 bytes)
; ======================================================================


jefe_3_entra:		; baja hasta Y 0x20
	ld c,020h		;ae62   ; hasta Y 0x20
	call jefe_baja		;ae64   ; jefe_baja: cada 8 cuadros la Y del jefe (0xEA03) - 8; C al llegar a C
	call c,jefe_3_siguiente		;ae67   ; jefe_3_siguiente: el paso siguiente
	jp caja_del_jefe_3		;ae6a   ; caja_del_jefe_3: la caja del jefe 3 y su forma segun los golpes
jefe_3_empieza:		; esperas de 1
	ld (ix+002h),001h		;ae6d
	ld (ix+018h),001h		;ae71
	jr $-34		;ae75
jefe_3_pelea:		; se mueve y dispara, su caja y su nucleo; vencido, p11:A93F
	call jefe_3_mueve		;ae77   ; jefe_3_mueve: dispara y elige direccion o anda
	call caja_del_jefe_3		;ae7a   ; caja_del_jefe_3: la caja del jefe 3 y su forma segun los golpes
	ld de,00038h		;ae7d   ; el nucleo, 56 por debajo y 24 a la derecha
	ld c,018h		;ae80
	call nucleo_del_jefe		;ae82   ; nucleo_del_jefe: IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
	jp jefe_vencido_abre		;ae85   ; jefe_vencido_abre: vencido (0xE345): la forma rota (0x15) y 300 cuadros (1 en la fase 7) para entrar; al paso siguiente
caja_del_jefe_3:		; la caja del jefe 3 y su forma segun los golpes
	ld a,038h		;ae88
	ld bc,01818h		;ae8a   ; 56 abajo, 24 a la derecha, 24 de ancho
	call caja_del_jefe		;ae8d   ; caja_del_jefe: la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld bc,00809h		;ae90   ; un paso de forma cada 8 golpes, desde 9
	jp forma_por_golpes		;ae93   ; forma_por_golpes: IX+08 = C + los golpes (IX+12) / B
jefe_3_mueve:		; dispara y elige direccion o anda
	call jefe_3_dispara		;ae96   ; jefe_3_dispara: cada 40 cuadros un tipo 0x24 desde su boca (Y + 0x30, X - 8) y suena 0x18
	ld a,(ix+001h)		;ae99   ; andando?
	dec a			;ae9c
	jr z,jefe_3_anda		;ae9d
	dec (ix+002h)		;ae9f   ; la espera
	ret nz			;aea2
	call jefe_3_rumbo		;aea3   ; jefe_3_rumbo: sube o baja hacia la altura de la nave (o hacia el centro)
	inc (ix+001h)		;aea6
	ret			;aea9
jefe_3_dispara:		; cada 40 cuadros un tipo 0x24 desde su boca (Y + 0x30, X - 8) y suena 0x18
	dec (ix+018h)		;aeaa   ; la espera de disparo
	ret nz			;aead
	ld (ix+018h),028h		;aeae   ; 40 cuadros
	ld hl,(0ea03h)		;aeb2   ; su boca: Y + 0x30
	ld de,00030h		;aeb5
	add hl,de			;aeb8
	ld a,h			;aeb9
	and a			;aeba
	ret nz			;aebb
	ld a,l			;aebc   ; fuera, no
	cp 0b0h		;aebd
	ret nc			;aebf
	ld e,a			;aec0
	ld a,(ix+005h)		;aec1   ; X - 8
	sub 008h		;aec4
	ld d,a			;aec6
	ld c,000h		;aec7
	ld a,024h		;aec9   ; un 0x24
	call 04d16h		;aecb   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,018h		;aece   ; suena 0x18
	jp 04ae4h		;aed0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
jefe_3_anda:		; anda; al acabar, 16 cuadros; si llega a su limite, da la vuelta
	call jefe_anda		;aed3   ; anda
	jr c,L_AEDF		;aed6
	call jefe_3_limite		;aed8   ; su limite
	jp c,jefe_da_la_vuelta		;aedb   ; jefe_da_la_vuelta: invierte la direccion vertical (IX+15 XOR 3)
	ret			;aede
L_AEDF:
	ld (ix+002h),010h		;aedf   ; acabado: 16 cuadros
	dec (ix+001h)		;aee3
	ret			;aee6
jefe_3_limite:		; C si ha llegado arriba (Y < 0x60) o abajo (Y >= 0xD8 de la parte alta) segun su direccion
	ld hl,(0ea03h)		;aee7   ; lee la Y del jefe (16 bits)
	bit 0,(ix+015h)		;aeea   ; bajando o subiendo
	jr nz,L_AEF8		;aeee
	ld a,h			;aef0   ; arriba: hasta 0x60
	and a			;aef1
	ret m			;aef2
	ld a,l			;aef3
	cp 060h		;aef4
	ccf			;aef6
	ret			;aef7
L_AEF8:
	ld a,h			;aef8   ; abajo
	and a			;aef9
	ret z			;aefa
	ld a,l			;aefb   ; por debajo de 0xD8
	cp 0d8h		;aefc
	ret			;aefe
jefe_3_rumbo:		; sube o baja hacia la altura de la nave (o hacia el centro)
	ld a,(ix+004h)		;aeff   ; lejos de arriba?
	and a			;af02
	jr z,L_AF0E		;af03
	ld a,002h		;af05
	jp m,pon_rumbo_del_jefe		;af07   ; pon_rumbo_del_jefe: IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
	dec a			;af0a
	jp pon_rumbo_del_jefe		;af0b   ; pon_rumbo_del_jefe: IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
L_AF0E:
	ld a,(ix+003h)		;af0e   ; su boca contra la nave
	add a,020h		;af11
	ld hl,0e404h		;af13   ; apunta a la Y de la nave
	cp (hl)			;af16
	ld a,002h		;af17
	jp c,pon_rumbo_del_jefe		;af19   ; pon_rumbo_del_jefe: IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
	dec a			;af1c
	jp pon_rumbo_del_jefe		;af1d   ; pon_rumbo_del_jefe: IX+15 = la direccion A, sus pasos (8-11 o 10-13) y la rapidez (0x40 + 2 x nivel)
tipo_24_empieza:		; el tipo 0x24: 4 x 1 caracteres, IX+10 = 1 y su dibujo (B)
	xor a			;af20
	ld (ix+013h),004h		;af21   ; 4 x 1
	ld (ix+014h),001h		;af25
	ld (ix+010h),001h		;af29   ; IX+10 = 1
	ld a,(ix+019h)		;af2d   ; su dibujo
	add a,000h		;af30
	ld (ix+032h),a		;af32
	ret			;af35
tipo_24:		; el tipo 0x24: crece 8 pixeles por cuadro hacia la izquierda a la altura del jefe; al llegar al borde espera 16 y se va; con el jefe vencido, se va
	ld a,(0e345h)		;af36   ; jefe vencido: se va
	and a			;af39
	jp nz,06514h		;af3a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld hl,(0ea03h)		;af3d   ; a la altura del jefe + 0x30
	ld de,00030h		;af40
	add hl,de			;af43
	ld (ix+004h),l		;af44
	ld a,(ix+001h)		;af47   ; el paso
	dec a			;af4a
	jr z,L_AF6B		;af4b
	ld a,(ix+00fh)		;af4d   ; 8 pixeles mas de ancho
	add a,008h		;af50
	ld (ix+00fh),a		;af52
	inc (ix+014h)		;af55   ; un caracter mas
	ld a,(ix+006h)		;af58   ; 8 a la izquierda
	sub 008h		;af5b
	and 0f8h		;af5d
	ld (ix+006h),a		;af5f
	ret nz			;af62
	ld (ix+002h),010h		;af63   ; al borde: 16 cuadros
	inc (ix+001h)		;af67
	ret			;af6a
L_AF6B:
	dec (ix+002h)		;af6b   ; la espera
	ret nz			;af6e
	jp 06514h		;af6f   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
jefe_5:		; el jefe 5: su paso 0xE341 (p11:AF78)
	ld a,(0e341h)		;af72   ; lee el estado del jefe
	call 04084h		;af75   ; el paso

; ----------------------------------------------------------------------
; DATOS tabla_AF78: 3 destinos del despachador p00:4084 (call en p11:AF75, el
;   indice en A): AF7E, AF94, AFAE; lo leen p11:AF75 (6 bytes)
;   0xaf78..0xaf7e  (6 bytes)
DATA_tabla_AF78:
	defw 0af7eh,0af94h,0afaeh	; af78  -> jefe_5_empieza jefe_5_pelea jefe_5_acaba

; ======================================================================
; CODIGO 0xaf7e..0xaffe  (128 bytes)
; ======================================================================


jefe_5_empieza:		; sin enemigos: sus caracteres, 10 piezas por salir (0xE3D6) y espera 1
	call 04b70h		;af7e   ; quedan enemigos?
	ret nz			;af81
	call 04c84h		;af82   ; caracteres_del_jefe_5: con los bancos 13-14-15, los caracteres del jefe 5 (p15:B3AF, copias p15:B3BC) y el banco 11
	ld a,00ah		;af85   ; 10 piezas
	ld (0e3d6h),a		;af87   ; guarda las piezas del jefe 5 por salir
	ld a,001h		;af8a   ; espera 1
	ld (0e343h),a		;af8c   ; guarda la espera del jefe (16 bits)
L_AF8F:
	ld hl,0e341h		;af8f   ; apunta a el estado del jefe
	inc (hl)			;af92
	ret			;af93
jefe_5_pelea:		; salen piezas (p11:AFBC) y se mueven (p11:B008); sin piezas por salir ni en pantalla, 30 cuadros y acabado
	call jefe_5_pieza_nueva		;af94   ; jefe_5_pieza_nueva: cada 144 cuadros, si hay hueco (0xEA00 o 0xEA20), una pieza nueva (p11:AFFE) arriba o abajo con 23 golpes
	call jefe_5_piezas		;af97   ; las dos piezas
	ld a,(0e3d6h)		;af9a   ; quedan por salir?
	and a			;af9d
	ret nz			;af9e
	ld a,(0ea00h)		;af9f   ; o en pantalla?
	ld hl,0ea20h		;afa2   ; apunta a la segunda ficha del jefe (el 5)
	or (hl)			;afa5
	ret nz			;afa6
	ld a,01eh		;afa7   ; 30 cuadros
	ld (0e343h),a		;afa9   ; guarda la espera del jefe (16 bits)
	jr L_AF8F		;afac
jefe_5_acaba:		; al acabar la espera, sin jefe y vencido (0xE342 = 1)
	ld hl,0e343h		;afae   ; apunta a la espera del jefe (16 bits)
	dec (hl)			;afb1
	ret nz			;afb2
	xor a			;afb3
	ld (0e340h),a		;afb4   ; sin jefe
	inc a			;afb7
	ld (0e342h),a		;afb8   ; vencido
	ret			;afbb
jefe_5_pieza_nueva:		; cada 144 cuadros, si hay hueco (0xEA00 o 0xEA20), una pieza nueva (p11:AFFE) arriba o abajo con 23 golpes
	ld hl,0e343h		;afbc   ; la espera
	dec (hl)			;afbf
	ret nz			;afc0
	ld (hl),090h		;afc1   ; 144 cuadros
	ld de,0ea00h		;afc3   ; apunta a la ficha del jefe
	ld a,(de)			;afc6   ; hueco en la primera?
	and a			;afc7
	jr z,L_AFCF		;afc8
	ld e,020h		;afca   ; o en la segunda?
	ld a,(de)			;afcc
	and a			;afcd
	ret nz			;afce
L_AFCF:
	ld hl,0e3d6h		;afcf   ; quedan por salir?
	ld a,(hl)			;afd2
	and a			;afd3
	ret z			;afd4
	dec (hl)			;afd5   ; una menos
	push de			;afd6
	pop ix		;afd7
	ld hl,0affeh		;afd9   ; su ficha
	ld bc,0000ah		;afdc
	ldir		;afdf
	ld a,(0e3d6h)		;afe1   ; arriba (0x20) o abajo (0x68)
	rra			;afe4
	ld a,020h		;afe5
	jr nc,L_AFEB		;afe7
	ld a,068h		;afe9
L_AFEB:
	ld (ix+003h),a		;afeb
	ld a,017h		;afee   ; 23 golpes
	ld (ix+012h),a		;aff0
	ld (ix+016h),00ah		;aff3   ; 10 pasos
	ld (ix+01fh),000h		;aff7
	jp caja_de_pieza		;affb   ; caja_de_pieza: la caja de la pieza y su forma segun los golpes

; ----------------------------------------------------------------------
; DATOS objeto_AFFE: 10 bytes que p11:AFD9 copia a IX (ldir); lo leen p11:AFDF
;   (10 bytes)
;   0xaffe..0xb008  (10 bytes)
DATA_objeto_AFFE:
	defb 005h,000h,004h,050h,000h,0f8h,000h,016h,017h,01eh	; affe  ...P......

; ======================================================================
; CODIGO 0xb008..0xb034  (44 bytes)
; ======================================================================


jefe_5_piezas:		; las dos piezas: se mueven, su nucleo, su caja y, rotas, sus puntos
	ld ix,0ea00h		;b008   ; la primera
	call jefe_5_pieza		;b00c   ; jefe_5_pieza: la pieza IX: lo de su paso, su nucleo y su caja; rota (IX+1F), puntos y estalla
	ld ix,0ea20h		;b00f   ; la segunda
jefe_5_pieza:		; la pieza IX: lo de su paso, su nucleo y su caja; rota (IX+1F), puntos y estalla
	ld a,(ix+000h)		;b013   ; libre
	and a			;b016
	ret z			;b017
	call jefe_5_paso		;b018   ; su paso
	ld de,00018h		;b01b   ; el nucleo
	ld c,000h		;b01e
	call nucleo_del_jefe		;b020   ; nucleo_del_jefe: IX+13/IX+14 = el nucleo: la Y + DE y la X + C (Y 0xE0 si se sale)
	call caja_de_pieza		;b023   ; la caja
	ld a,(ix+01fh)		;b026   ; rota?
	and a			;b029
	ret z			;b02a
	jp pieza_rota		;b02b   ; pieza_rota: 0x0030 puntos y estalla
jefe_5_paso:		; lo del paso IX+01 de la pieza (p11:B034)
	ld a,(ix+001h)		;b02e
	call 04084h		;b031   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B034: 3 destinos del despachador p00:4084 (call en p11:B031, el
;   indice en A): B03A, B088, B099; lo leen p11:B031 (6 bytes)
;   0xb034..0xb03a  (6 bytes)
DATA_tabla_B034:
	defw 0b03ah,0b088h,0b099h	; b034  -> pieza_avanza pieza_dispara pieza_sube_o_baja

; ======================================================================
; CODIGO 0xb03a..0xb080  (70 bytes)
; ======================================================================


pieza_avanza:		; cada IX+02 cuadros 8 a la izquierda; cada 10 pasos dispara; al llegar a X 0x10 elige subir o bajar
	dec (ix+002h)		;b03a   ; la espera
	ret nz			;b03d
	call espera_de_pieza		;b03e   ; la siguiente
	ld a,(ix+005h)		;b041   ; 8 a la izquierda
	sub 008h		;b044
	ld (ix+005h),a		;b046
	cp 010h		;b049   ; hasta X 0x10
	jr c,L_B059		;b04b
	dec (ix+016h)		;b04d   ; cada 10 pasos
	ret nz			;b050
	ld (ix+016h),00ah		;b051   ; dispara
	inc (ix+001h)		;b055
	ret			;b058
L_B059:
	ld c,001h		;b059   ; sube o baja hacia la nave
	ld a,(0e404h)		;b05b   ; lee la Y de la nave
	sub 018h		;b05e
	jr c,L_B068		;b060
	cp (ix+003h)		;b062
	jr c,L_B068		;b065
	dec c			;b067
L_B068:
	ld (ix+017h),c		;b068   ; al paso 2
	ld (ix+001h),002h		;b06b
	ret			;b06f
espera_de_pieza:		; IX+02 = p11:B080 segun el nivel / 2
	ld a,(0e228h)		;b070   ; nivel / 2
	srl a		;b073
	ld hl,0b080h		;b075
	call 0407ah		;b078   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;b07b
	ld (ix+002h),a		;b07c
	ret			;b07f

; ----------------------------------------------------------------------
; DATOS tabla_B080: 8 bytes que p11:B070 lee con 0xE228 / 2; lo leen p11:B078
;   (8 bytes)
;   0xb080..0xb088  (8 bytes)
DATA_tabla_B080:
	defb 005h,005h,004h,004h,003h,003h,002h,002h	; b080  ........

; ======================================================================
; CODIGO 0xb088..0xb0f9  (113 bytes)
; ======================================================================


pieza_dispara:		; al acabar IX+16, 4 disparos (p11:B0F9) y vuelve a avanzar
	dec (ix+016h)		;b088   ; la espera
	ret nz			;b08b
	call pieza_4_disparos		;b08c   ; 4 disparos
	ld (ix+016h),008h		;b08f
	ld (ix+001h),000h		;b093   ; a avanzar
	jr $-39		;b097
pieza_sube_o_baja:		; cada IX+02 cuadros 8 arriba o abajo; al salirse, libre
	dec (ix+002h)		;b099   ; la espera
	ret nz			;b09c
	call espera_de_pieza		;b09d   ; espera_de_pieza: IX+02 = p11:B080 segun el nivel / 2
	ld l,(ix+003h)		;b0a0   ; la Y
	ld h,(ix+004h)		;b0a3
	ld de,00008h		;b0a6
	bit 0,(ix+017h)		;b0a9   ; baja 8, o sube 8
	jr z,L_B0B2		;b0ad
	ld de,0fff8h		;b0af
L_B0B2:
	add hl,de			;b0b2   ; + 8 o - 8
	ld (ix+003h),l		;b0b3   ; la Y
	ld (ix+004h),h		;b0b6
	ld a,h			;b0b9   ; al salirse por arriba o por abajo
	and a			;b0ba
	ld a,l			;b0bb
	jr z,L_B0C8		;b0bc
	bit 0,(ix+017h)		;b0be   ; subiendo
	ret z			;b0c2
	cp 0c0h		;b0c3   ; por encima: hasta 0xC0
	jr c,L_B0D0		;b0c5
	ret			;b0c7
L_B0C8:
	bit 0,(ix+017h)		;b0c8   ; bajando
	ret nz			;b0cc
	cp 0c0h		;b0cd   ; hasta 0xC0
	ret c			;b0cf
L_B0D0:
	ld (ix+000h),000h		;b0d0   ; libre
	ret			;b0d4
pieza_rota:		; 0x0030 puntos y estalla
	ld a,(ix+000h)		;b0d5   ; libre ya?
	and a			;b0d8
	ret z			;b0d9
	ld de,00030h		;b0da   ; 0x0030 puntos
	call 05b04h		;b0dd   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	jp jefe_estalla		;b0e0   ; jefe_estalla: la parte IX libre, 90 cuadros de espera, una explosion en su sitio y suena 9 (el 5) o 0x3B
caja_de_pieza:		; la caja de la pieza y su forma segun los golpes
	ld a,018h		;b0e3
	ld bc,01018h		;b0e5   ; 24 abajo, 16 a la derecha, 24 de ancho
	call caja_del_jefe		;b0e8   ; caja_del_jefe: la caja de la parte IX: IX+0A/IX+0E = Y + A, IX+0C = X + B, IX+10 = X + B + C
	ld bc,00417h		;b0eb   ; un paso de forma cada 4 golpes, desde 0x17
	jp forma_por_golpes		;b0ee   ; forma_por_golpes: IX+08 = C + los golpes (IX+12) / B
pieza_4_disparos:		; 4 disparos 0x23 desde los puntos de p11:B0F9
	ld de,0b0f9h		;b0f1
	ld b,004h		;b0f4   ; 4 puntos
	jp L_AB80		;b0f6

; ----------------------------------------------------------------------
; DATOS tabla_B0F9: 4 fichas de 4 bytes que p11:B0F1 pasa a L_AB80; lo leen
;   p11:B0F6 (16 bytes)
;   0xb0f9..0xb109  (16 bytes)
DATA_tabla_B0F9:
	defb 008h,000h,0f8h,004h	; b0f9
	defb 012h,000h,0f0h,005h	; b0fd
	defb 02ah,000h,0f0h,004h	; b101
	defb 030h,000h,0f8h,005h	; b105

; ======================================================================
; CODIGO 0xb109..0xb179  (112 bytes)
; ======================================================================


giratorios_de_la_lista:		; en la fase 1, lo que trae cada columna (p11:B124) hasta ponerse al dia (0xE377)
	ld a,(0e201h)		;b109   ; solo en la fase 1
	dec a			;b10c
	ret nz			;b10d
L_B10E:
	call aparicion_de_giratorio		;b10e   ; aparicion_de_giratorio: la siguiente ficha de p11:B179 ([columna con 2 bits de modo][B]): si es su columna, un giratorio (p11:B14D)
	jr z,aparicion_de_giratorio		;b111   ; Z: puesto; el siguiente
	ret c			;b113   ; C: todavia no
	ld hl,0e377h		;b114   ; pasado: el siguiente
	inc (hl)			;b117
	jr L_B10E		;b118
giratorios_del_scroll:		; si el scroll avanzo, lo de la columna nueva (X = 0xF8)
	ld a,(0e320h)		;b11a   ; lee la marca de scroll hecho en este cuadro
	and a			;b11d
	ret z			;b11e
	ld a,0f8h		;b11f   ; por el borde derecho
	ld (0f004h),a		;b121   ; guarda variable de paso
aparicion_de_giratorio:		; la siguiente ficha de p11:B179 ([columna con 2 bits de modo][B]): si es su columna, un giratorio (p11:B14D)
	ld hl,0b179h		;b124   ; 3 bytes por ficha
	ld a,(0e377h)		;b127   ; lee la siguiente aparicion de giratorio (indice)
	ld c,a			;b12a
	add a,a			;b12b
	add a,c			;b12c
	call 0407ah		;b12d   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;b130   ; la columna
	inc hl			;b131
	ld d,(hl)			;b132
	inc hl			;b133
	ld b,(hl)			;b134   ; B
	ld a,d			;b135   ; los bits 6-7: el modo
	and 0c0h		;b136
	or 001h		;b138
	ld c,a			;b13a
	ld a,d			;b13b   ; la columna: 14 bits
	and 03fh		;b13c
	ld d,a			;b13e
	ld hl,(0e203h)		;b13f   ; la compara con el scroll
	rst 20h			;b142
	ret nz			;b143
	ld hl,0e377h		;b144   ; gastada
	inc (hl)			;b147
	call pon_giratorio		;b148   ; pon_giratorio: el primer hueco de 0xEA20 (4 de 8 bytes): [modo y paso 1][8][0][X][direccion B][0][16][5]
	xor a			;b14b
	ret			;b14c
pon_giratorio:		; el primer hueco de 0xEA20 (4 de 8 bytes): [modo y paso 1][8][0][X][direccion B][0][16][5]
	ld e,b			;b14d
	ld hl,0ea20h		;b14e   ; 4 huecos de 8 bytes
	ld b,004h		;b151
L_B153:
	ld a,(hl)			;b153   ; libre?
	and a			;b154   ; libre?
	jr z,L_B161		;b155
	ld a,008h		;b157   ; 8 bytes
	add a,l			;b159
	ld l,a			;b15a
	jr nc,L_B15E		;b15b
	inc h			;b15d
L_B15E:
	djnz L_B153		;b15e
	ret			;b160   ; ninguno
L_B161:
	ld (hl),c			;b161   ; el modo, paso 1
	inc l			;b162
	ld (hl),008h		;b163   ; 8 cuadros
	inc l			;b165
	ld (hl),000h		;b166
	inc l			;b168
	ld a,(0f004h)		;b169   ; la X
	ld (hl),a			;b16c
	inc l			;b16d
	ld (hl),e			;b16e   ; la direccion
	inc l			;b16f
	ld (hl),000h		;b170
	inc l			;b172
	ld (hl),010h		;b173   ; 16 cuadros
	inc l			;b175
	ld (hl),005h		;b176   ; 5
	ret			;b178

; ----------------------------------------------------------------------
; DATOS guion_B179: fichas de 3 bytes que p11:B124 lee con 0xE377 x 3, y FF FF
;   acaba; lo leen p11:B12D (26 bytes)
;   0xb179..0xb193  (26 bytes)
DATA_guion_B179:
	defb 0e8h,040h,000h	; b179
	defb 022h,041h,00ch	; b17c
	defb 02eh,041h,008h	; b17f
	defb 081h,001h,000h	; b182
	defb 093h,001h,003h	; b185
	defb 0a1h,081h,005h	; b188
	defb 0afh,001h,004h	; b18b
	defb 0b7h,001h,001h	; b18e
	defb 0ffh,0ffh	; b191

; ======================================================================
; CODIGO 0xb193..0xb2a8  (277 bytes)
; ======================================================================


mueve_giratorios:		; en la fase 1, los 4 giratorios de 0xEA20: el scroll, el giro, la animacion y el disparo
	ld ix,0ea20h		;b193   ; apunta a la segunda ficha del jefe (el 5)
	ld b,004h		;b197   ; 4 giratorios
L_B199:
	push bc			;b199
	ld a,(ix+000h)		;b19a   ; libre
	and a			;b19d
	call nz,mueve_giratorio		;b19e   ; mueve_giratorio: el giratorio IX: el scroll, el giro, la animacion y el disparo
	pop bc			;b1a1
	ld de,00008h		;b1a2   ; 8 bytes
	add ix,de		;b1a5
	djnz L_B199		;b1a7
	ret			;b1a9
mueve_giratorio:		; el giratorio IX: el scroll, el giro, la animacion y el disparo
	call giratorio_con_el_scroll		;b1aa   ; giratorio_con_el_scroll: 8 pixeles a la izquierda con el scroll; al llegar al borde, el paso siguiente (hasta 4) y libre
	call giratorio_gira		;b1ad   ; giratorio_gira: sin el bit 6, cada 8 cuadros la direccion (IX+04, 0-13) sube o baja segun el bit 7
	call giratorio_anima		;b1b0   ; giratorio_anima: cada 16 cuadros el paso siguiente (6) y su dibujo (p11:B35C)
	jp giratorio_dispara		;b1b3   ; giratorio_dispara: al acabar la espera (p11:B2A8 segun el nivel), si esta abierto y la nave cae por delante, un 0x34 desde su boca y suena 0x15
giratorio_con_el_scroll:		; 8 pixeles a la izquierda con el scroll; al llegar al borde, el paso siguiente (hasta 4) y libre
	ld a,(0e320h)		;b1b6   ; solo con scroll
	and a			;b1b9
	ret z			;b1ba
	ld a,(ix+003h)		;b1bb   ; 8 a la izquierda
	sub 008h		;b1be
	ld (ix+003h),a		;b1c0
	ret nc			;b1c3
	ld (ix+003h),000h		;b1c4   ; al borde
	inc (ix+000h)		;b1c8   ; el paso siguiente
	ld a,(ix+000h)		;b1cb
	and 03fh		;b1ce   ; hasta 4
	cp 005h		;b1d0
	ret c			;b1d2
	ld (ix+000h),000h		;b1d3   ; libre
	ret			;b1d7
giratorio_gira:		; sin el bit 6, cada 8 cuadros la direccion (IX+04, 0-13) sube o baja segun el bit 7
	bit 6,(ix+000h)		;b1d8   ; con el bit 6 no gira
	ret nz			;b1dc
	dec (ix+001h)		;b1dd   ; cada 8 cuadros
	ret nz			;b1e0
	ld (ix+001h),008h		;b1e1
	bit 7,(ix+000h)		;b1e5   ; hacia un lado
	jr z,L_B1F4		;b1e9
	dec (ix+004h)		;b1eb
	ret p			;b1ee
	ld (ix+004h),00dh		;b1ef   ; de 0 a 13
	ret			;b1f3
L_B1F4:
	inc (ix+004h)		;b1f4   ; o hacia el otro
	ld a,(ix+004h)		;b1f7   ; la direccion
	cp 00eh		;b1fa   ; de 0 a 13
	ret c			;b1fc
	ld (ix+004h),000h		;b1fd
	ret			;b201
giratorio_anima:		; cada 16 cuadros el paso siguiente (6) y su dibujo (p11:B35C)
	dec (ix+006h)		;b202   ; cada 16 cuadros
	ret nz			;b205
	ld (ix+006h),010h		;b206
	ld a,(ix+002h)		;b20a   ; el paso siguiente
	inc a			;b20d
	cp 006h		;b20e   ; 6 pasos
	jr c,L_B213		;b210
	xor a			;b212
L_B213:
	ld (ix+002h),a		;b213
	ld hl,0b35ch		;b216   ; su dibujo
	call 0407ah		;b219   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;b21c
	ld (ix+005h),a		;b21d
	ret			;b220
giratorio_dispara:		; al acabar la espera (p11:B2A8 segun el nivel), si esta abierto y la nave cae por delante, un 0x34 desde su boca y suena 0x15
	dec (ix+007h)		;b221   ; la espera
	ret nz			;b224
	ld a,(0e228h)		;b225   ; segun el nivel
	bit 6,(ix+000h)		;b228
	jr z,L_B230		;b22c
	add a,008h		;b22e
L_B230:
	cp 00fh		;b230   ; como mucho 15
	jr c,L_B236		;b232
	ld a,00fh		;b234
L_B236:
	ld hl,0b2a8h		;b236   ; en p11:B2A8
	call 05ca6h		;b239   ; byte_a: A = el byte A de la tabla HL
	ld (ix+007h),a		;b23c
	ld hl,0e406h		;b23f   ; la nave
	ld a,(ix+005h)		;b242   ; cerrado (0) o abierto (2)
	and a			;b245
	jr z,L_B262		;b246
	cp 002h		;b248
	ret nz			;b24a
	ld a,(ix+000h)		;b24b   ; su boca segun el paso
	and 03fh		;b24e
	dec a			;b250
	add a,a			;b251
	add a,a			;b252
	add a,a			;b253
	sub 018h		;b254
	neg		;b256
	ld c,a			;b258
	ld a,(ix+003h)		;b259
	add a,c			;b25c
	ret c			;b25d
	cp (hl)			;b25e   ; la nave delante?
	ret nc			;b25f
	jr L_B270		;b260
L_B262:
	ld a,(ix+000h)		;b262   ; en el paso 1
	and 03fh		;b265
	dec a			;b267
	ret nz			;b268
	ld a,(ix+003h)		;b269
	sub 008h		;b26c   ; 8 pixeles antes
	cp (hl)			;b26e
	ret c			;b26f
L_B270:
	ld d,a			;b270
	call boca_del_giratorio		;b271   ; la Y de la boca
	call nave_cerca		;b274   ; muy cerca, no
	ret c			;b277
	ld a,d			;b278   ; lejos (128 o mas), no
	sub (ix+003h)		;b279
	jr nc,L_B280		;b27c
	neg		;b27e
L_B280:
	cp 080h		;b280
	ret nc			;b282
	ld a,034h		;b283   ; un 0x34
	ld bc,00000h		;b285
	call 04d16h		;b288   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,015h		;b28b   ; suena 0x15
	jp 04ae4h		;b28d   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
nave_cerca:		; por debajo del nivel 5, C si la nave esta a menos de 32 pixeles de D/E (entonces no dispara)
	ld a,(0e228h)		;b290   ; del nivel 5, siempre
	cp 005h		;b293
	ret nc			;b295
	ld a,(0e406h)		;b296   ; la X de la nave a +-32
	sub d			;b299
	add a,020h		;b29a
	cp 040h		;b29c
	ret nc			;b29e
	ld a,(0e404h)		;b29f   ; la Y a +-32
	sub e			;b2a2
	add a,020h		;b2a3
	cp 040h		;b2a5
	ret			;b2a7

; ----------------------------------------------------------------------
; DATOS tabla_B2A8: 16 bytes que p11:B225 lee con 0xE228 (+8 con el bit 6 de
;   IX+00, y como mucho 15); lo leen p11:B239 (16 bytes)
;   0xb2a8..0xb2b8  (16 bytes)
DATA_tabla_B2A8:
	defb 018h,016h,014h,012h,010h,00eh,00ch,00bh,00ah,009h,008h,007h,006h,006h,005h,005h	; b2a8  ................

; ======================================================================
; CODIGO 0xb2b8..0xb35c  (164 bytes)
; ======================================================================


boca_del_giratorio:		; E = la Y de la boca segun la direccion (de 0x18 a 0x78)
	ld a,(ix+004h)		;b2b8   ; la direccion - 5
	sub 005h		;b2bb
	jr nc,L_B2C8		;b2bd
	neg		;b2bf
L_B2C1:
	add a,a			;b2c1   ; x 8 + 0x18
	add a,a			;b2c2   ; x 8
	add a,a			;b2c3
	add a,018h		;b2c4   ; + 0x18
	ld e,a			;b2c6
	ret			;b2c7
L_B2C8:
	neg		;b2c8   ; al otro lado
	add a,00eh		;b2ca
	jr L_B2C1		;b2cc
pinta_giratorios:		; en la fase 1, cada giratorio en la pantalla de RAM (p11:B2E5)
	ld ix,0ea20h		;b2ce   ; apunta a la segunda ficha del jefe (el 5)
	ld b,004h		;b2d2   ; 4 giratorios
L_B2D4:
	push bc			;b2d4
	ld a,(ix+000h)		;b2d5   ; libre
	and a			;b2d8
	call nz,pinta_giratorio		;b2d9   ; pinta_giratorio: 14 filas de su dibujo (p11:B362 por paso y direccion) desde la fila 1 en su X, recortado por la derecha
	pop bc			;b2dc
	ld de,00008h		;b2dd   ; 8 bytes cada uno
	add ix,de		;b2e0
	djnz L_B2D4		;b2e2
	ret			;b2e4
pinta_giratorio:		; 14 filas de su dibujo (p11:B362 por paso y direccion) desde la fila 1 en su X, recortado por la derecha
	ld a,(ix+005h)		;b2e5   ; el dibujo de su paso
	ld de,0b362h		;b2e8
	call 04b60h		;b2eb   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ld a,(ix+000h)		;b2ee   ; + el modo
	and 03fh		;b2f1
	dec a			;b2f3
	call 0407fh		;b2f4   ; de_mas_a: DE = DE + A
	ld (0f000h),de		;b2f7   ; 0xF000 = el principio
	ld a,(ix+004h)		;b2fb   ; + 4 x direccion
	add a,a			;b2fe
	add a,a			;b2ff
	call 0407fh		;b300   ; de_mas_a: DE = DE + A
	ld (0f002h),de		;b303   ; 0xF002 = la fila de la direccion
	ld h,(ix+003h)		;b307   ; su X, fila 1 (Y 0x20)
	ld l,020h		;b30a
	call 05c92h		;b30c   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0f004h),hl		;b30f   ; 0xF004 = el sitio
	ld a,(ix+000h)		;b312   ; el ancho: 5 - el modo
	and 03fh		;b315
	sub 005h		;b317
	neg		;b319
	ld b,a			;b31b
	ld a,(ix+003h)		;b31c   ; cerca del borde derecho, recortado
	cp 0e8h		;b31f
	jr c,L_B32B		;b321
	rra			;b323
	rra			;b324
	rra			;b325
	or 0e0h		;b326
	neg		;b328
	ld b,a			;b32a
L_B32B:
	ld a,(ix+004h)		;b32b
	ex af,af'			;b32e
	ld c,00eh		;b32f   ; 14 filas
	ld de,(0f002h)		;b331   ; lee variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld hl,(0f004h)		;b335   ; lee variable de paso y el byte siguiente (16 bits)
L_B338:
	push bc			;b338
	push de			;b339
	push hl			;b33a
L_B33B:
	ld a,(de)			;b33b   ; una fila
	ld (hl),a			;b33c
	inc l			;b33d
	inc de			;b33e
	djnz L_B33B		;b33f
	pop hl			;b341
	ld de,00020h		;b342   ; la fila siguiente
	add hl,de			;b345
	pop de			;b346
	inc de			;b347   ; 4 bytes por fila
	inc de			;b348
	inc de			;b349
	inc de			;b34a
	ex af,af'			;b34b
	inc a			;b34c   ; a los 14, vuelta al principio
	cp 00eh		;b34d
	jr c,L_B356		;b34f
	ld de,(0f000h)		;b351   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	xor a			;b355
L_B356:
	ex af,af'			;b356   ; la fila de la direccion
	pop bc			;b357
	dec c			;b358   ; una fila menos
	jr nz,L_B338		;b359
	ret			;b35b

; ----------------------------------------------------------------------
; DATOS tabla_B35C: 6 bytes que p11:B20A lee con IX+02 (de 0 a 5); lo leen
;   p11:B219 (6 bytes)
;   0xb35c..0xb362  (6 bytes)
DATA_tabla_B35C:
	defb 000h,000h,001h,002h,002h,001h	; b35c

; ----------------------------------------------------------------------
; DATOS tabla_B362: 3 punteros que p11:B2E8 lee con L_4B60; lo leen p11:B2EB
;   (6 bytes)
;   0xb362..0xb368  (6 bytes)
DATA_tabla_B362:
	defw 0b368h,0b3a0h,0b3d8h	; b362  -> DATA_bloques_B368 0xb3a0 0xb3d8

; ----------------------------------------------------------------------
; DATOS bloques_B368: 3 bloques de 56 bytes (0xB368, 0xB3A0 y 0xB3D8), los de
;   0xB362; lo leen p11:B2EE (168 bytes)
;   0xb368..0xb410  (168 bytes)
DATA_bloques_B368:
	defb 063h,062h,061h,060h,067h,066h,065h,064h	; b368  cba`gfed
	defb 06ah,080h,069h,068h,06eh,06dh,06ch,06bh	; b370  j.ihnmlk
	defb 071h,083h,070h,06fh,075h,074h,073h,072h	; b378  q.poutsr
	defb 079h,078h,077h,076h,052h,053h,07bh,07ah	; b380  yxwvRS{z
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b388  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b390  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b398  ........
	defb 038h,054h,07ch,03bh,055h,056h,07eh,07dh	; b3a0  8T|.UV~}
	defb 057h,058h,080h,07fh,040h,059h,081h,042h	; b3a8  WX..@Y.B
	defb 05ah,05bh,083h,082h,05ch,05dh,085h,084h	; b3b0  Z[..\]..
	defb 05eh,05fh,087h,086h,052h,053h,07bh,07ah	; b3b8  ^_..RS{z
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b3c0  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b3c8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b3d0  ........
	defb 038h,039h,03ah,03bh,03ch,03dh,03eh,03fh	; b3d8  89:.<=>?
	defb 040h,041h,058h,042h,043h,044h,045h,046h	; b3e0  @AXBCDEF
	defb 047h,048h,05bh,049h,04ah,04bh,04ch,04dh	; b3e8  GH[IJKLM
	defb 04eh,04fh,050h,051h,052h,053h,07bh,07ah	; b3f0  NOPQRS{z
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b3f8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b400  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b408  ........

; ======================================================================
; CODIGO 0xb410..0xb49e  (142 bytes)
; ======================================================================


piezas_de_fase_5:		; en la fase 5, lo que trae cada columna (p11:B432) hasta ponerse al dia (0xE36B)
	ld a,(0e201h)		;b410   ; solo en la fase 5
	cp 005h		;b413
	ret nz			;b415
	call aparicion_de_pieza_5		;b416   ; aparicion_de_pieza_5: en las columnas de p11:B49E, una pieza en 0xE580 o 0xE590 (si hay hueco) a una Y al azar (0x40-0x68)
	jr z,piezas_de_fase_5		;b419   ; Z: puesta; la siguiente
	ret c			;b41b   ; C: todavia no
	ld hl,0e36bh		;b41c   ; pasada: la siguiente
	inc (hl)			;b41f
	jr piezas_de_fase_5		;b420
piezas_de_fase_5_scroll:		; en la fase 5, si el scroll avanzo, lo de la columna nueva
	ld a,(0e201h)		;b422   ; lee la fase (0-11)
	cp 005h		;b425
	ret nz			;b427
	ld a,(0e320h)		;b428   ; lee la marca de scroll hecho en este cuadro
	or a			;b42b
	ret z			;b42c
	ld a,0f8h		;b42d   ; por el borde derecho
	ld (0f004h),a		;b42f   ; guarda variable de paso
aparicion_de_pieza_5:		; en las columnas de p11:B49E, una pieza en 0xE580 o 0xE590 (si hay hueco) a una Y al azar (0x40-0x68)
	ld hl,0b49eh		;b432   ; la columna de la siguiente
	ld a,(0e36bh)		;b435   ; lee la siguiente aparicion de pieza de la fase 5 (indice)
	call 04b67h		;b438   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,(0e203h)		;b43b   ; la compara con el scroll
	or a			;b43e
	sbc hl,de		;b43f
	ret nz			;b441
	ld hl,0e36bh		;b442   ; gastada
	inc (hl)			;b445
	xor a			;b446
	ld hl,0e580h		;b447   ; un hueco en 0xE580
	cp (hl)			;b44a
	jr z,L_B452		;b44b
	ld hl,0e590h		;b44d   ; o en 0xE590
	cp (hl)			;b450
	ret nz			;b451
L_B452:
	call 04c24h		;b452   ; una de 6 alturas
	and 007h		;b455   ; 0-7
	cp 006h		;b457
	jr c,L_B45D		;b459
	sub 006h		;b45b   ; 6 alturas
L_B45D:
	add a,a			;b45d
	add a,a			;b45e
	add a,a			;b45f
	add a,040h		;b460   ; 0x40 + 8 x azar
	ld c,a			;b462
	ld a,(0f004h)		;b463   ; cerca del borde derecho, menos ancha
	cp 0c9h		;b466
	ld de,00207h		;b468   ; 2 x 7
	jr c,L_B477		;b46b
	ld d,001h		;b46d   ; o 1 x lo que quepa
	neg		;b46f
	rra			;b471
	rra			;b472
	rra			;b473
	and 00fh		;b474
	ld e,a			;b476
L_B477:
	ld (hl),d			;b477   ; [modo][0][Y][X][ancho][ancho x 8][0][24][4]
	inc l			;b478
	ld (hl),000h		;b479   ; 0
	inc l			;b47b
	ld (hl),c			;b47c   ; la Y
	inc l			;b47d
	ld a,(0f004h)		;b47e   ; lee variable de paso
	ld (hl),a			;b481   ; la X
	inc l			;b482
	ld (hl),e			;b483   ; el ancho
	inc l			;b484
	ld a,e			;b485   ; en pixeles
	add a,a			;b486
	add a,a			;b487
	add a,a			;b488
	ld (hl),a			;b489
	inc l			;b48a
	ld (hl),000h		;b48b
	inc l			;b48d
	ld (hl),018h		;b48e   ; 24
	inc l			;b490
	ld (hl),004h		;b491   ; 4
	ld a,l			;b493
	add a,004h		;b494
	ld l,a			;b496
	ld (hl),000h		;b497   ; [0][3]
	inc l			;b499
	ld (hl),003h		;b49a   ; 3
	xor a			;b49c
	ret			;b49d

; ----------------------------------------------------------------------
; DATOS posiciones_B49E: 5 posiciones del scroll y 0xFFFF que p11:B432 lee con
;   0xE36B (L_4B67); lo leen p11:B438 (12 bytes)
;   0xb49e..0xb4aa  (12 bytes)
DATA_posiciones_B49E:
	defw 000d6h,0011ah,00138h,00164h,00172h,0ffffh	; b49e

; ======================================================================
; CODIGO 0xb4aa..0xb5d5  (299 bytes)
; ======================================================================


mueve_piezas_de_fase_5:		; en la fase 5, las dos piezas de 0xE580 y 0xE590
	ld a,(0e201h)		;b4aa   ; lee la fase (0-11)
	cp 005h		;b4ad
	ret nz			;b4af   ; solo en la fase 5
	ld ix,0e580h		;b4b0   ; la primera
	call mueve_pieza_5		;b4b4   ; mueve_pieza_5: el scroll, su animacion y, tocada, la vuelta a entera tras cada espera
	ld ix,0e590h		;b4b7   ; la segunda
mueve_pieza_5:		; el scroll, su animacion y, tocada, la vuelta a entera tras cada espera
	ld a,(ix+000h)		;b4bb   ; libre
	or a			;b4be
	ret z			;b4bf
	call pieza_5_con_el_scroll		;b4c0   ; el scroll; C: se ha ido
	ret c			;b4c3
	call anima_pieza_5		;b4c4   ; su dibujo
	ld a,(ix+001h)		;b4c7   ; tocada?
	or a			;b4ca
	ret z			;b4cb
	dec (ix+007h)		;b4cc   ; cada 24 cuadros
	ret nz			;b4cf
	ld (ix+007h),018h		;b4d0
	dec (ix+006h)		;b4d4   ; un paso de rotura menos
	ret p			;b4d7
	xor a			;b4d8   ; entera otra vez
	ld (ix+001h),a		;b4d9
	ld (ix+006h),a		;b4dc
	ret			;b4df
anima_pieza_5:		; cada 3 cuadros el dibujo siguiente (IX+0C, 3)
	dec (ix+00dh)		;b4e0   ; cada 3 cuadros
	ret nz			;b4e3
	ld (ix+00dh),003h		;b4e4
	inc (ix+00ch)		;b4e8   ; el dibujo siguiente
	ld a,(ix+00ch)		;b4eb
	cp 003h		;b4ee   ; 3 dibujos
	ret c			;b4f0
	ld (ix+00ch),000h		;b4f1
	ret			;b4f5
pieza_5_con_el_scroll:		; con el scroll, 8 a la izquierda: entra por la derecha creciendo (modo 1), entera (2) o sale por la izquierda menguando (3); libre al salir (C)
	ld a,(0e320h)		;b4f6   ; solo con scroll
	or a			;b4f9
	ret z			;b4fa
	ld a,(ix+003h)		;b4fb   ; 8 a la izquierda
	sub 008h		;b4fe
	jr c,L_B520		;b500
	ld (ix+003h),a		;b502
	cp 0d0h		;b505   ; entrando por la derecha
	jr nc,L_B516		;b507
	ld (ix+000h),002h		;b509   ; entera: modo 2, ancho 7
	ld (ix+004h),007h		;b50d
	ld a,038h		;b511
	jp L_B52F		;b513
L_B516:
	ld (ix+000h),001h		;b516   ; entrando: modo 1, un caracter mas
	inc (ix+004h)		;b51a
	jp ancho_de_pieza_5		;b51d   ; ancho_de_pieza_5: IX+05 = IX+04 x 8 (NZ)
L_B520:
	ld (ix+000h),003h		;b520   ; saliendo: modo 3, uno menos
	dec (ix+004h)		;b524
	jr z,L_B534		;b527   ; sin nada: libre
ancho_de_pieza_5:		; IX+05 = IX+04 x 8 (NZ)
	ld a,(ix+004h)		;b529
	add a,a			;b52c   ; x 8
	add a,a			;b52d
	add a,a			;b52e
L_B52F:
	ld (ix+005h),a		;b52f
	or a			;b532
	ret			;b533
L_B534:
	ld (ix+000h),000h		;b534
	scf			;b538
	ret			;b539
pinta_piezas_de_fase_5:		; en la fase 5, las dos piezas de 0xE580/0xE590 en la pantalla de RAM
	ld a,(0e201h)		;b53a   ; lee la fase (0-11)
	cp 005h		;b53d
	ret nz			;b53f
	ld ix,0e580h		;b540   ; la primera
	call pinta_pieza_5		;b544   ; pinta_pieza_5: su cabeza (p11:B5B8) y, tocada, su rotura (p11:B5D5 por paso): 4 filas de su ancho, recortadas segun entra o sale
	ld ix,0e590h		;b547   ; la segunda
pinta_pieza_5:		; su cabeza (p11:B5B8) y, tocada, su rotura (p11:B5D5 por paso): 4 filas de su ancho, recortadas segun entra o sale
	ld a,(ix+000h)		;b54b   ; libre
	or a			;b54e
	ret z			;b54f
	call cabeza_de_pieza_5		;b550   ; su cabeza
	ld a,(ix+001h)		;b553   ; tocada?
	or a			;b556
	ret z			;b557
	ld l,(ix+002h)		;b558
	ld h,(ix+003h)		;b55b   ; su sitio
	call 05c92h		;b55e   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	push hl			;b561
	ld a,(ix+006h)		;b562   ; la rotura del paso
	ld hl,0b5d5h		;b565
	call 04b67h		;b568   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;b56b
	pop de			;b56c
	ld a,004h		;b56d   ; 4 filas
pinta_filas_7:		; A filas de un dibujo de 7 de ancho en DE: enteras, o recortadas por la izquierda o por la derecha segun el modo
	ld (0f000h),a		;b56f   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,(ix+000h)		;b572   ; segun el modo
	sub 002h		;b575
	jr z,L_B5A5		;b577
	jp p,L_B599		;b579
L_B57C:
	ld c,(ix+004h)		;b57c   ; el ancho
	ld a,(0f000h)		;b57f   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld b,a			;b582
L_B583:
	push bc			;b583   ; una fila
	push hl			;b584
	push de			;b585
	ld b,000h		;b586
	ldir		;b588   ; la fila
	pop hl			;b58a
	ld bc,00020h		;b58b   ; la siguiente de la pantalla
	add hl,bc			;b58e   ; la siguiente
	ex de,hl			;b58f
	pop hl			;b590
	ld bc,00007h		;b591   ; y del dibujo (7)
	add hl,bc			;b594   ; 7 en el dibujo
	pop bc			;b595
	djnz L_B583		;b596
	ret			;b598
L_B599:
	ld a,007h		;b599   ; entrando: lo que no cabe a la izquierda
	sub (ix+004h)		;b59b   ; lo que no cabe
	ld c,a			;b59e
	ld b,000h		;b59f
	add hl,bc			;b5a1
	jp L_B57C		;b5a2
L_B5A5:
	ld a,(0f000h)		;b5a5   ; entera: filas de 7
	ld b,a			;b5a8
L_B5A9:
	push bc			;b5a9
	ld bc,00007h		;b5aa
	ldir		;b5ad
	ld a,019h		;b5af   ; la siguiente (25 + 7)
	call 0407fh		;b5b1   ; de_mas_a: DE = DE + A
	pop bc			;b5b4
	djnz L_B5A9		;b5b5
	ret			;b5b7
cabeza_de_pieza_5:		; el dibujo de su paso (p11:B66B, 7 x 12) desde la fila 5
	ld l,028h		;b5b8   ; desde la fila 5 (Y 0x28)
	ld h,(ix+003h)		;b5ba
	call 05c92h		;b5bd   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;b5c0
	ld hl,0b66bh		;b5c1   ; su paso
	ld a,(ix+00ch)		;b5c4
	ld c,a			;b5c7
	add a,a			;b5c8
	add a,a			;b5c9
	add a,a			;b5ca
	sub c			;b5cb   ; x 7
	ld c,a			;b5cc
	ld b,000h		;b5cd
	add hl,bc			;b5cf
	ld a,00ch		;b5d0   ; 12 filas
	jp pinta_filas_7		;b5d2   ; pinta_filas_7: A filas de un dibujo de 7 de ancho en DE: enteras, o recortadas por la izquierda o por la derecha segun el modo

; ----------------------------------------------------------------------
; DATOS tabla_B5D5: 5 punteros que p11:B562 lee con IX+06 (L_4B67); lo leen
;   p11:B568 (10 bytes)
;   0xb5d5..0xb5df  (10 bytes)
DATA_tabla_B5D5:
	defw 0b5dfh,0b5fbh,0b617h,0b633h,0b64fh	; b5d5

; ----------------------------------------------------------------------
; DATOS piezas_B5DF: 5 piezas de 4 filas de 7 caracteres (las de 0xB5D5) que
;   p11:B56F copia a la tabla de nombres; lo leen p11:B588 (140 bytes)
;   0xb5df..0xb66b  (140 bytes)
DATA_piezas_B5DF:
	defb 0a3h,059h,04dh,04fh,05eh,0a4h,000h	; b5df
	defb 0b0h,06fh,043h,04eh,05ah,0b6h,000h	; b5e6
	defb 0b3h,079h,048h,04ch,05bh,0b7h,000h	; b5ed
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b5f4
	defb 0a9h,05dh,054h,055h,05ah,0b6h,000h	; b5fb
	defb 0b1h,070h,071h,043h,05bh,0b7h,000h	; b602
	defb 0b4h,07ah,07bh,048h,05eh,0a4h,000h	; b609
	defb 0abh,05ch,04bh,04ch,05ah,0b6h,000h	; b610
	defb 0a6h,05ch,04bh,04ch,05bh,0a4h,000h	; b617
	defb 0b1h,070h,071h,072h,073h,0b2h,0b9h	; b61e
	defb 0a7h,07ah,07bh,07ch,07dh,0bah,0bbh	; b625
	defb 0a5h,05dh,054h,055h,05ah,077h,0b7h	; b62c
	defb 07fh,080h,081h,082h,083h,084h,085h	; b633
	defb 000h,0beh,0bfh,0c0h,0c1h,0a7h,000h	; b63a
	defb 000h,0c3h,0c4h,0c5h,0c6h,0c2h,000h	; b641
	defb 08ah,08bh,08ch,08dh,08eh,08fh,0c2h	; b648
	defb 0b1h,070h,071h,072h,073h,0b2h,0b9h	; b64f
	defb 000h,0b4h,000h,0bbh,0a7h,000h,000h	; b656
	defb 0bbh,000h,0a8h,0b9h,000h,0c1h,0c2h	; b65d
	defb 0b4h,07ah,07bh,07ch,07dh,0bah,0bbh	; b664

; ----------------------------------------------------------------------
; DATOS filas_B66B: 14 filas de 7 caracteres: p11:B5B8 copia 12 desde 0xB66B +
;   7 x IX+0C; lo leen p11:B5CF (98 bytes)
;   0xb66b..0xb6cd  (98 bytes)
DATA_filas_B66B:
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b66b
	defb 0a5h,05dh,054h,055h,05ah,0b6h,000h	; b672
	defb 0a6h,05ch,04bh,04ch,05bh,0b7h,000h	; b679
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b680
	defb 0a5h,05dh,054h,055h,05ah,0b6h,000h	; b687
	defb 0a6h,05ch,04bh,04ch,05bh,0b7h,000h	; b68e
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b695
	defb 0a5h,05dh,054h,055h,05ah,0b6h,000h	; b69c
	defb 0a6h,05ch,04bh,04ch,05bh,0b7h,000h	; b6a3
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b6aa
	defb 0a5h,05dh,054h,055h,05ah,0b6h,000h	; b6b1
	defb 0a6h,05ch,04bh,04ch,05bh,0b7h,000h	; b6b8
	defb 0a3h,059h,04dh,04eh,05eh,0a4h,000h	; b6bf
	defb 0a5h,05dh,054h,055h,05ah,0b6h,000h	; b6c6

; ======================================================================
; CODIGO 0xb6cd..0xb77b  (174 bytes)
; ======================================================================


fuente_tres_tercios:		; las letras y cifras (p11:B7B4 desde el caracter 0x10 y p11:B81C desde el 0x20) en los tres tercios, con colores 0xF0
	ld de,0b7b4h		;b6cd   ; las cifras
	ld hl,02080h		;b6d0
	ld bc,00068h		;b6d3
	call 04a37h		;b6d6   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld de,0b81ch		;b6d9   ; las letras
	ld hl,02100h		;b6dc
	ld bc,000d8h		;b6df
	call 04a37h		;b6e2   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld a,0f0h		;b6e5   ; colores 0xF0
	ld hl,00080h		;b6e7
	ld bc,00158h		;b6ea
	jp 04a4ah		;b6ed   ; rellena_vram_x3: rellena BC bytes de la VRAM con A en los tres tercios (HL, + 0x800, + 0x1000)
fuente_dos_tercios:		; las letras y cifras en los tercios de arriba y del medio
	ld de,0b7b4h		;b6f0   ; las cifras, tercio de arriba
	ld hl,02080h		;b6f3
	ld bc,00068h		;b6f6
	call 04a33h		;b6f9   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b81ch		;b6fc   ; las letras
	ld hl,02100h		;b6ff
	ld bc,000d8h		;b702
	call 04a33h		;b705   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld a,0f0h		;b708   ; colores
	ld hl,00080h		;b70a
	ld bc,00158h		;b70d
	call 00056h		;b710   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7b4h		;b713   ; tercio del medio
	ld hl,02880h		;b716
	ld bc,00068h		;b719
	call 04a33h		;b71c   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b81ch		;b71f   ; las letras
	ld hl,02900h		;b722
	ld bc,000d8h		;b725
	call 04a33h		;b728   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld a,0f0h		;b72b   ; colores
	ld hl,00880h		;b72d
	ld bc,00158h		;b730
	jp 00056h		;b733   ; BIOS FILVRM - Fills VRAM with value
fuente_del_marcador:		; colores 0xF0 y las cifras del tercio de abajo (p11:B7B4 desde el caracter 1) y las letras de p11:B77B desde el 0x12
	ld hl,01008h		;b736   ; colores de las cifras
	ld bc,00050h		;b739
	ld a,0f0h		;b73c
	call 00056h		;b73e   ; BIOS FILVRM - Fills VRAM with value
	ld hl,01090h		;b741   ; y de las letras
	ld bc,00018h		;b744
	ld a,0f0h		;b747
	call 00056h		;b749   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7b4h		;b74c   ; las cifras desde el caracter 1
	ld hl,03008h		;b74f
	ld bc,00050h		;b752
	call 04a33h		;b755   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b77bh		;b758   ; las letras de la lista
	ld hl,03090h		;b75b
letras_por_lista:		; en la VRAM HL, los dibujos de las letras de la lista DE (indices en p11:B81C, 0 acaba)
	push de			;b75e
	call 04a1dh		;b75f   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;b762
	pop hl			;b763
L_B764:
	ld a,(hl)			;b764   ; 0 acaba
	inc hl			;b765
	and a			;b766
	ret z			;b767
	add a,a			;b768   ; x 8
	add a,a			;b769
	add a,a			;b76a
	ld de,0b81ch		;b76b   ; en p11:B81C
	call 0407fh		;b76e   ; de_mas_a: DE = DE + A
	ld b,008h		;b771   ; 8 bytes
L_B773:
	ld a,(de)			;b773   ; un byte
	inc de			;b774
	out (c),a		;b775   ; a la VRAM
	djnz L_B773		;b777
	jr L_B764		;b779

; ----------------------------------------------------------------------
; DATOS texto_B77B: 3 letras y un 0 que p11:B758 escribe en la VRAM 0x3090; lo
;   leen p11:B75E (4 bytes)
;   0xb77b..0xb77f  (4 bytes)
DATA_texto_B77B:
	defb 010h,008h,009h,000h	; b77b

; ======================================================================
; CODIGO 0xb77f..0xb7a4  (37 bytes)
; ======================================================================


letras_de_you_captured:		; colores 0xF0 y las letras de p11:B7A4 en el caracter 0xBB y de p11:B7B1 en el 0x9B del tercio de abajo
	ld hl,015d8h		;b77f   ; colores
	ld bc,00060h		;b782
	ld a,0f0h		;b785
	call 00056h		;b787   ; BIOS FILVRM - Fills VRAM with value
	ld hl,014d8h		;b78a
	ld bc,00010h		;b78d
	call 00056h		;b790   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7a4h		;b793   ; la primera lista
	ld hl,035d8h		;b796
	call letras_por_lista		;b799   ; letras_por_lista: en la VRAM HL, los dibujos de las letras de la lista DE (indices en p11:B81C, 0 acaba)
	ld de,0b7b1h		;b79c   ; la segunda
	ld hl,034d8h		;b79f
	jr $-68		;b7a2

; ----------------------------------------------------------------------
; DATOS textos_B7A4: dos textos acabados en 0 (letras numeradas desde la A =
;   1) que p11:B793 y p11:B79C escriben en 0x35D8 y 0x34D8; lo leen p11:B75E
;   (16 bytes)
;   0xb7a4..0xb7b4  (16 bytes)
DATA_textos_B7A4:
	defb 019h,00fh,015h,003h,001h,010h,014h,012h,005h,004h,00eh,008h,000h,009h,007h,000h	; b7a4  ................

; ----------------------------------------------------------------------
; DATOS fuente_cifras: 13 caracteres de 8 bytes (las cifras y tres signos) que
;   p11:B6CD, B6F0, B713 y B74C copian a la VRAM; lo leen p11:B6D6 (104 bytes)
;   0xb7b4..0xb81c  (104 bytes)
DATA_fuente_cifras:
	defb 000h,01ch,022h,063h,063h,063h,022h,01ch	; b7b4  .."ccc".
	defb 000h,018h,038h,018h,018h,018h,018h,07eh	; b7bc  ..8....~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh	; b7c4  .>c..<p.
	defb 000h,03eh,063h,003h,00eh,003h,063h,03eh	; b7cc  .>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h	; b7d4  ...6ff..
	defb 000h,07fh,060h,07eh,063h,003h,063h,03eh	; b7dc  ..`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh	; b7e4  .>c`~cc>
	defb 000h,07fh,063h,006h,00ch,018h,018h,018h	; b7ec  ..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh	; b7f4  .>cc>cc>
	defb 000h,03eh,063h,063h,03fh,003h,063h,03eh	; b7fc  .>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch	; b804  <B....B<
	defb 0c0h,060h,078h,07eh,0bfh,0bfh,07fh,0f0h	; b80c  .`x~....
	defb 000h,000h,000h,000h,0e0h,0feh,080h,000h	; b814  ........

; ----------------------------------------------------------------------
; DATOS fuente_letras: 27 caracteres de 8 bytes (las letras) que p11:B6D9 y
;   los de al lado copian a la VRAM, y p11:B76B saca de uno en uno; lo leen
;   p11:B6E2 (216 bytes)
;   0xb81c..0xb8f4  (216 bytes)
DATA_fuente_letras:
	defb 000h,000h,000h,000h,07eh,000h,000h,000h	; b81c  ....~...
	defb 000h,01ch,036h,063h,063h,07fh,063h,063h	; b824  ..6cc.cc
	defb 000h,07eh,063h,063h,07eh,063h,063h,07eh	; b82c  .~cc~cc~
	defb 000h,03eh,063h,060h,060h,060h,063h,03eh	; b834  .>c```c>
	defb 000h,07ch,066h,063h,063h,063h,066h,07ch	; b83c  .|fcccf|
	defb 000h,07fh,060h,060h,07eh,060h,060h,07fh	; b844  ..``~``.
	defb 000h,07fh,060h,060h,07eh,060h,060h,060h	; b84c  ..``~```
	defb 000h,03eh,063h,060h,067h,063h,063h,03fh	; b854  .>c`gcc?
	defb 000h,063h,063h,063h,07fh,063h,063h,063h	; b85c  .ccc.ccc
	defb 000h,03ch,018h,018h,018h,018h,018h,03ch	; b864  .<.....<
	defb 000h,01fh,006h,006h,006h,006h,066h,03ch	; b86c  ......f<
	defb 000h,063h,066h,06ch,078h,07ch,06eh,067h	; b874  .cflx|ng
	defb 000h,060h,060h,060h,060h,060h,060h,07fh	; b87c  .``````.
	defb 000h,063h,077h,07fh,07fh,06bh,063h,063h	; b884  .cw..kcc
	defb 000h,063h,073h,07bh,07fh,06fh,067h,063h	; b88c  .cs{.ogc
	defb 000h,03eh,063h,063h,063h,063h,063h,03eh	; b894  .>ccccc>
	defb 000h,07eh,063h,063h,063h,07eh,060h,060h	; b89c  .~ccc~``
	defb 000h,03eh,063h,063h,063h,06fh,066h,03dh	; b8a4  .>cccof=
	defb 000h,07eh,063h,063h,062h,07ch,066h,063h	; b8ac  .~ccb|fc
	defb 000h,03eh,063h,060h,03eh,003h,063h,03eh	; b8b4  .>c`>.c>
	defb 000h,07eh,018h,018h,018h,018h,018h,018h	; b8bc  .~......
	defb 000h,063h,063h,063h,063h,063h,063h,03eh	; b8c4  .cccccc>
	defb 000h,063h,063h,063h,063h,036h,01ch,008h	; b8cc  .cccc6..
	defb 000h,063h,063h,06bh,06bh,07fh,077h,022h	; b8d4  .cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h	; b8dc  .cv<..7c
	defb 000h,066h,066h,07eh,03ch,018h,018h,018h	; b8e4  .ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh	; b8ec  .....8p.

; ======================================================================
; CODIGO 0xb8f4..0xb987  (147 bytes)
; ======================================================================


tipo_02_empieza:		; el tipo 2: sale de su compuerta del borde derecho (arriba o abajo) hacia el centro, con su cuenta (p11:B997)
	ld a,(0e201h)		;b8f4   ; lee la fase (0-11)
	cp 003h		;b8f7   ; en la fase 3, otro dibujo
	jr nz,L_B8FF		;b8f9
	ld (ix+030h),074h		;b8fb
L_B8FF:
	ld (ix+02bh),001h		;b8ff   ; IX+2B = 1, IX+2C = 7
	ld (ix+02ch),007h		;b903
	res 2,(ix+010h)		;b907   ; sin velocidad propia
	ld a,(ix+004h)		;b90b   ; su Y
	ld (ix+025h),a		;b90e
	ld (ix+028h),000h		;b911
	ld de,0ff00h		;b915   ; vx 0xFF00
	call 04f02h		;b918   ; pon_vx: IX+09/IX+0A = DE
	ld d,0fdh		;b91b   ; arriba: hacia abajo
	ld a,(ix+004h)		;b91d
	cp 060h		;b920
	jr nc,L_B932		;b922
	ld (ix+032h),001h		;b924   ; y otro dibujo
	ld a,(ix+030h)		;b928
	add a,004h		;b92b
	ld (ix+030h),a		;b92d
	ld d,003h		;b930   ; vy 0x0300
L_B932:
	call 04efbh		;b932   ; pon_vy: IX+07/IX+08 = DE
	ld a,(0e39ch)		;b935   ; la cuenta siguiente
	inc a			;b938
	and 007h		;b939
	ld (0e39ch),a		;b93b   ; guarda la cuenta de los tipo 2
	ld hl,0b997h		;b93e   ; su espera (p11:B997)
	call 05ca6h		;b941   ; byte_a: A = el byte A de la tabla HL
	ld (ix+02dh),a		;b944
compuerta_del_tipo_2:		; los 2 x 2 caracteres de su compuerta (p11:B987/B98B, + 8 en la fase 3) en el borde derecho, abierta o cerrada
	ld b,010h		;b947   ; por debajo (+16) o por encima (-16)
	ld a,(ix+004h)		;b949
	cp 058h		;b94c   ; arriba o abajo
	jr nc,L_B952		;b94e
	ld b,0f0h		;b950
L_B952:
	add a,b			;b952
	ld l,a			;b953
	ld h,0f8h		;b954   ; X 0xF8
	call 05c92h		;b956   ; el sitio en el borde derecho
	ld de,0b987h		;b959   ; la compuerta de arriba o la de abajo
	ld a,(ix+032h)		;b95c
	dec a			;b95f
	jr z,L_B965		;b960
	ld de,0b98bh		;b962   ; la de abajo
L_B965:
	ld a,(0e201h)		;b965   ; en la fase 3, otra
	cp 003h		;b968
	jr nz,L_B971		;b96a
	ld a,008h		;b96c
	call 0407fh		;b96e   ; de_mas_a: DE = DE + A
L_B971:
	ld a,(ix+028h)		;b971   ; abierta?
	and a			;b974
	jr z,L_B979		;b975   ; cerrada
	inc de			;b977   ; abierta
	inc de			;b978
L_B979:
	ex de,hl			;b979
	ldi		;b97a   ; dos caracteres
	ld a,01fh		;b97c
	call 0407fh		;b97e   ; de_mas_a: DE = DE + A
	ldi		;b981   ; y dos debajo
	inc (ix+028h)		;b983   ; cambia
	ret			;b986

; ----------------------------------------------------------------------
; DATOS tablas_B987: tablas de 4 bytes (0xB987 y 0xB98B segun IX+32) que
;   p11:B959 lee; lo leen p11:B965 (16 bytes)
;   0xb987..0xb997  (16 bytes)
DATA_tablas_B987:
	defb 036h,034h,037h,035h	; b987
	defb 034h,036h,035h,037h	; b98b
	defb 05eh,05ch,05fh,05dh	; b98f
	defb 05ch,05eh,05dh,05fh	; b993

; ----------------------------------------------------------------------
; DATOS tabla_B997: 9 bytes que p11:B941 lee con L_5CA6; lo leen p11:B941 (9
;   bytes)
;   0xb997..0xb9a0  (9 bytes)
DATA_tabla_B997:
	defb 0a0h,0e0h,080h,070h,060h,050h,090h,0c0h,020h	; b997  ...p`P..

; ======================================================================
; CODIGO 0xb9a0..0xb9b8  (24 bytes)
; ======================================================================


tipo_02:		; el tipo 2: su compuerta y lo de su paso (p11:B9B8)
	ld a,(ix+028h)		;b9a0   ; abierta del todo?
	cp 002h		;b9a3
	jr z,L_B9AF		;b9a5
	ld a,(ix+006h)		;b9a7   ; en el borde derecho, la compuerta
	cp 0f0h		;b9aa
	call z,compuerta_del_tipo_2		;b9ac   ; compuerta_del_tipo_2: los 2 x 2 caracteres de su compuerta (p11:B987/B98B, + 8 en la fase 3) en el borde derecho, abierta o cerrada
L_B9AF:
	call tipo_02_espera_8		;b9af   ; su dibujo
	ld a,(ix+001h)		;b9b2   ; por paso
	call 04084h		;b9b5   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B9B8: 6 destinos del despachador p00:4084 (call en p11:B9B5, el
;   indice en A): B9DC, B9EA, B9FA, BA0E, BA54, BA64; lo leen p11:B9B5 (12
;   bytes)
;   0xb9b8..0xb9c4  (12 bytes)
DATA_tabla_B9B8:
	defw 0b9dch,0b9eah,0b9fah,0ba0eh,0ba54h,0ba64h	; b9b8

; ======================================================================
; CODIGO 0xb9c4..0xbabb  (247 bytes)
; ======================================================================


tipo_02_espera_8:		; IX+2C - 1; a cero, 8 otra vez
	dec (ix+02ch)		;b9c4
	ret nz			;b9c7
	ld (ix+02ch),008h		;b9c8   ; 8
	ret			;b9cc
tipo_02_avanza:		; cada 8 cuadros, 8 pixeles a la izquierda
	ld a,(ix+02ch)		;b9cd   ; cada 8 cuadros
	cp 008h		;b9d0
	ret nz			;b9d2
	ld a,(ix+006h)		;b9d3   ; 8 a la izquierda
	sub 008h		;b9d6
	ld (ix+006h),a		;b9d8
	ret			;b9db
tipo_02_hasta_su_x:		; avanza hasta la X de IX+2D
	call tipo_02_avanza		;b9dc   ; tipo_02_avanza: cada 8 cuadros, 8 pixeles a la izquierda
	ld a,(ix+006h)		;b9df   ; hasta su X
	cp (ix+02dh)		;b9e2
	ret nc			;b9e5
	inc (ix+001h)		;b9e6
	ret			;b9e9
tipo_02_sale:		; se puede tocar (caja 1), 10 cuadros y se mueve solo
	inc (ix+001h)		;b9ea
	ld (ix+00dh),001h		;b9ed   ; caja 1
	ld (ix+002h),00ah		;b9f1   ; 10 cuadros
	set 2,(ix+010h)		;b9f5   ; se mueve solo
	ret			;b9f9
tipo_02_dispara:		; parpadea, a los 4 cuadros se para y suelta 6 balas en abanico (p11:BABB); al pasar el centro, vuelve
	call tipo_02_parpadea		;b9fa   ; parpadea
	call tipo_02_abanico		;b9fd   ; el abanico
	ld a,(ix+004h)		;ba00   ; al pasar el centro
	add a,070h		;ba03
	cp 080h		;ba05
	ret nc			;ba07
	inc (ix+001h)		;ba08   ; vuelve
	jp 04f3ch		;ba0b   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
tipo_02_vuelve:		; parpadea y vuelve a su altura (IX+25): entonces se cierra en su compuerta
	call tipo_02_parpadea		;ba0e   ; tipo_02_parpadea: cada 2 cuadros cambia de dibujo (4, o 12 en la fase 3)
	bit 7,(ix+008h)		;ba11   ; subiendo o bajando
	ld a,(ix+004h)		;ba15
	jr nz,L_BA4D		;ba18
	cp (ix+025h)		;ba1a   ; ha vuelto?
	ret c			;ba1d
L_BA1E:
	ld a,(ix+025h)		;ba1e   ; en su sitio
	ld (ix+004h),a		;ba21
	res 2,(ix+010h)		;ba24   ; quieto
	dec (ix+006h)		;ba28
	inc (ix+001h)		;ba2b
	ld b,0f8h		;ba2e   ; su dibujo
	ld a,(0e201h)		;ba30   ; lee la fase (0-11)
	cp 003h		;ba33
	jr nz,L_BA39		;ba35
	ld b,074h		;ba37
L_BA39:
	ld (ix+00dh),0ffh		;ba39   ; sin caja
	ld a,(ix+004h)		;ba3d
	cp 060h		;ba40
	ld a,b			;ba42   ; el dibujo
	jr nc,L_BA47		;ba43
	add a,004h		;ba45   ; arriba, + 4
L_BA47:
	ld (ix+030h),a		;ba47
	jp 04f3ch		;ba4a   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
L_BA4D:
	inc a			;ba4d
	cp (ix+025h)		;ba4e   ; ya ha subido?
	jr c,L_BA1E		;ba51
	ret			;ba53
tipo_02_con_el_scroll:		; con el scroll, al paso siguiente con 8 cuadros
	dec (ix+006h)		;ba54
	ld a,(0e320h)		;ba57   ; con scroll
	or a			;ba5a
	ret z			;ba5b
	inc (ix+001h)		;ba5c
	ld (ix+002h),008h		;ba5f   ; 8 cuadros
	ret			;ba63
tipo_02_espera:		; avanza y, al acabar la espera, al paso 0
	call tipo_02_avanza		;ba64   ; tipo_02_avanza: cada 8 cuadros, 8 pixeles a la izquierda
	dec (ix+002h)		;ba67   ; la espera
	ret nz			;ba6a
	ld (ix+001h),000h		;ba6b   ; al paso 0
	ret			;ba6f
tipo_02_abanico:		; a los 4 cuadros se para (guarda su vy); a cero, recupera la vy y 6 balas en abanico
	ld a,(ix+002h)		;ba70   ; la cuenta
	and a			;ba73   ; sin cuenta, nada
	ret z			;ba74
	dec a			;ba75
	ld (ix+002h),a		;ba76
	jr z,L_BA8D		;ba79
	cp 004h		;ba7b   ; a los 4, se para
	ret nz			;ba7d
	ld d,(ix+007h)		;ba7e   ; guarda la vy
	ld e,(ix+008h)		;ba81
	ld (ix+029h),d		;ba84
	ld (ix+02ah),e		;ba87
	jp 04f1ch		;ba8a   ; vy_cero: IX+07/IX+08 = 0
L_BA8D:
	ld e,(ix+029h)		;ba8d   ; a cero, su vy otra vez
	ld d,(ix+02ah)		;ba90
	call 04efbh		;ba93   ; pon_vy: IX+07/IX+08 = DE
	ld hl,0babbh		;ba96   ; 6 direcciones
	ld b,006h		;ba99
L_BA9B:
	push bc			;ba9b
	push hl			;ba9c
	ld a,b			;ba9d
	dec a			;ba9e
	call 05ca6h		;ba9f   ; de p11:BABB
	ld b,002h		;baa2   ; rapidez 2
	call 04cb7h		;baa4   ; velocidad_en_direccion: para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
	ex de,hl			;baa7
	ld b,d			;baa8
	ld c,e			;baa9
	ld e,(ix+004h)		;baaa   ; desde su sitio
	ld a,(ix+006h)		;baad
	add a,008h		;bab0
	ld d,a			;bab2
	call 0937dh		;bab3   ; una bala
	pop hl			;bab6
	pop bc			;bab7
	djnz L_BA9B		;bab8
	ret			;baba

; ----------------------------------------------------------------------
; DATOS tabla_BABB: 6 bytes que p11:BA96 recorre (B = 6); lo leen p11:BA9B (6
;   bytes)
;   0xbabb..0xbac1  (6 bytes)
DATA_tabla_BABB:
	defb 000h,002h,006h,008h,00ah,00eh	; babb

; ======================================================================
; CODIGO 0xbac1..0xbb0c  (75 bytes)
; ======================================================================


tipo_02_parpadea:		; cada 2 cuadros cambia de dibujo (4, o 12 en la fase 3)
	dec (ix+02bh)		;bac1   ; cada 2 cuadros
	ret nz			;bac4
	ld (ix+02bh),002h		;bac5
	ld b,004h		;bac9   ; 4, o 12 en la fase 3
	ld a,(0e201h)		;bacb   ; lee la fase (0-11)
	cp 003h		;bace
	jr nz,L_BAD4		;bad0
	ld b,00ch		;bad2
L_BAD4:
	ld a,(ix+030h)		;bad4   ; cambia de dibujo
	xor b			;bad7
	ld (ix+030h),a		;bad8
	ret			;badb
clase_16_empieza:		; la clase 16: la forma 0x3A (+ 7 con IX+0B bit 0), 6 golpes, 4 x 3, 48 cuadros y sin caja
	bit 0,(ix+00bh)		;badc
	ld a,03ah		;bae0
	call forma_por_lado		;bae2   ; forma_por_lado: IX+07 = A (+ 7 con IX+0B bit 0)
	ld (ix+008h),006h		;bae5   ; 6 golpes
	ld (ix+009h),004h		;bae9   ; 4 x 3
	ld (ix+00ah),003h		;baed
	ld (ix+002h),030h		;baf1   ; 48 cuadros
	ld (ix+00dh),0ffh		;baf5   ; sin caja
	ret			;baf9
forma_por_lado:		; IX+07 = A (+ 7 con IX+0B bit 0)
	bit 0,(ix+00bh)		;bafa
	jr z,L_BB02		;bafe
	add a,007h		;bb00   ; el otro lado
L_BB02:
	ld (ix+007h),a		;bb02
	ret			;bb05
clase_16:		; la clase 16: lo de su paso (p11:BB0C)
	ld a,(ix+001h)		;bb06
	call 04084h		;bb09   ; por paso

; ----------------------------------------------------------------------
; DATOS tabla_BB0C: 9 destinos del despachador p00:4084 (call en p11:BB09, el
;   indice en A): BB1E, BB49, BB60, BB81, BB8C, BB95, BBCC, BBDC, BBF8; lo
;   leen p11:BB09 (18 bytes)
;   0xbb0c..0xbb1e  (18 bytes)
DATA_tabla_BB0C:
	defw 0bb1eh,0bb49h,0bb60h,0bb81h,0bb8ch,0bb95h,0bbcch,0bbdch	; bb0c
	defw 0bbf8h	; bb1c  -> clase_16_rota

; ======================================================================
; CODIGO 0xbb1e..0xbe68  (842 bytes)
; ======================================================================


clase_16_espera:		; con la nave a menos de 32 pixeles en X: con caja y a abrirse
	dec (ix+002h)		;bb1e   ; la espera
	ret nz			;bb21
	inc (ix+002h)		;bb22
	ld a,(0e406h)		;bb25   ; la nave a +-32 en X?
	sub (ix+006h)		;bb28
	add a,020h		;bb2b
	cp 040h		;bb2d
	ret nc			;bb2f
	ld (ix+00dh),000h		;bb30   ; con caja
	ld (ix+002h),001h		;bb34
	ld (ix+00ch),003h		;bb38   ; 3 pasos
	inc (ix+001h)		;bb3c
	ld a,(0e203h)		;bb3f   ; segun la columna
	rra			;bb42
	and 001h		;bb43
	ld (ix+00fh),a		;bb45
	ret			;bb48
clase_16_abre:		; cada cuadro la forma + 1 (3 veces); luego 6 cuadros
	dec (ix+002h)		;bb49
	ret nz			;bb4c
	ld (ix+002h),001h		;bb4d   ; 1 cuadro
	inc (ix+007h)		;bb51   ; la forma siguiente
	dec (ix+00ch)		;bb54   ; 3 veces
	ret nz			;bb57
	ld (ix+002h),006h		;bb58   ; 6 cuadros
	inc (ix+001h)		;bb5c
	ret			;bb5f
clase_16_tiembla:		; alterna dos formas; al acabar, la 0x3E y 2 pasos
	call forma_alterna		;bb60   ; forma_alterna: la forma 0x3D o 0x3E segun el cuadro
	dec (ix+002h)		;bb63   ; la espera
	ret nz			;bb66
	ld a,03eh		;bb67   ; la forma 0x3E
	call forma_por_lado		;bb69   ; forma_por_lado: IX+07 = A (+ 7 con IX+0B bit 0)
	ld (ix+00ch),002h		;bb6c   ; 2 pasos
	inc (ix+001h)		;bb70
	ret			;bb73
forma_alterna:		; la forma 0x3D o 0x3E segun el cuadro
	bit 0,(ix+002h)		;bb74   ; cada cuadro
	ld a,03dh		;bb78
	jr z,L_BB7E		;bb7a
	ld a,03eh		;bb7c
L_BB7E:
	jp forma_por_lado		;bb7e   ; forma_por_lado: IX+07 = A (+ 7 con IX+0B bit 0)
clase_16_forma_mas:		; la forma + 1, IX+0C veces
	inc (ix+007h)		;bb81   ; la forma siguiente
	dec (ix+00ch)		;bb84   ; IX+0C veces
	ret nz			;bb87
	inc (ix+001h)		;bb88
	ret			;bb8b
clase_16_forma_3d:		; la forma 0x3D
	ld a,03dh		;bb8c
	call forma_por_lado		;bb8e   ; forma_por_lado: IX+07 = A (+ 7 con IX+0B bit 0)
	inc (ix+001h)		;bb91
	ret			;bb94
clase_16_suelta:		; un 0x41 por su boca y 6 cuadros
	call boca_de_clase_16		;bb95   ; boca_de_clase_16: un tipo 0x41 por arriba (-8) o por abajo (+24), 16 (8 con scroll) a la derecha; suena 0x26
	ld (ix+002h),006h		;bb98
	inc (ix+001h)		;bb9c
	ret			;bb9f
boca_de_clase_16:		; un tipo 0x41 por arriba (-8) o por abajo (+24), 16 (8 con scroll) a la derecha; suena 0x26
	bit 0,(ix+00bh)		;bba0   ; por arriba
	ld bc,000f8h		;bba4
	jr z,L_BBAC		;bba7
	ld bc,00118h		;bba9   ; o por abajo
L_BBAC:
	ld a,(ix+004h)		;bbac
	add a,c			;bbaf   ; la Y de la boca
	ld e,a			;bbb0
	ld a,(0e320h)		;bbb1   ; con scroll, 8 mas cerca
	and a			;bbb4
	ld c,010h		;bbb5   ; 16
	jr z,L_BBBB		;bbb7
	ld c,008h		;bbb9   ; o 8 con scroll
L_BBBB:
	ld a,(ix+006h)		;bbbb
	add a,c			;bbbe
	ld d,a			;bbbf
	ld c,000h		;bbc0
	ld a,041h		;bbc2   ; un 0x41
	call 04d16h		;bbc4   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,026h		;bbc7   ; suena 0x26
	jp 04ae4h		;bbc9   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
clase_16_cierra_espera:		; al acabar la espera, 3 pasos de cerrar
	dec (ix+002h)		;bbcc   ; la espera
	ret nz			;bbcf
	ld (ix+002h),001h		;bbd0
	ld (ix+00ch),003h		;bbd4   ; 3 pasos
	inc (ix+001h)		;bbd8
	ret			;bbdb
clase_16_cierra:		; cada cuadro la forma - 1; cerrada, sin caja y 32 cuadros
	dec (ix+002h)		;bbdc   ; la espera
	ret nz			;bbdf
	ld (ix+002h),001h		;bbe0
	dec (ix+007h)		;bbe4   ; la forma - 1
	dec (ix+00ch)		;bbe7
	ret nz			;bbea
	ld (ix+00dh),0ffh		;bbeb   ; sin caja
	ld (ix+002h),020h		;bbef   ; 32 cuadros
	ld (ix+001h),000h		;bbf3
	ret			;bbf7
clase_16_rota:		; sin IX+0B, sin caja y la forma 0x33 + IX+0F; con el, libre
	ld a,(ix+00bh)		;bbf8   ; con IX+0B, libre
	and a			;bbfb
	jr nz,L_BC0B		;bbfc
	ld (ix+00dh),0ffh		;bbfe
	ld a,(ix+00fh)		;bc02   ; la forma rota
	add a,033h		;bc05
	ld (ix+007h),a		;bc07
	ret			;bc0a
L_BC0B:
	ld (ix+000h),000h		;bc0b
	ret			;bc0f
tipo_41_empieza:		; el tipo 0x41: 1 x 1, IX+10 = 9, 10 cuadros
	xor a			;bc10
	ld (ix+02fh),a		;bc11   ; choca con el mapa
	inc a			;bc14
	ld (ix+013h),a		;bc15   ; 1 x 1
	ld (ix+014h),a		;bc18
	ld (ix+010h),009h		;bc1b   ; IX+10 = 9
	ld (ix+002h),00ah		;bc1f   ; 10 cuadros
	ret			;bc23
tipo_41:		; el tipo 0x41: una columna que crece 4 caracteres por cuadro hacia arriba o abajo hasta tocar el mapa y luego mengua
	ld a,(ix+001h)		;bc24   ; menguando?
	dec a			;bc27
	jr z,L_BC5C		;bc28
	bit 0,(ix+019h)		;bc2a   ; hacia arriba o abajo
	jr nz,L_BC3E		;bc2e
	bit 0,(ix+02fh)		;bc30   ; ya cortada, no crece
	jr nz,L_BC54		;bc34
	ld a,(ix+004h)		;bc36   ; sube 32
	sub 020h		;bc39
	ld (ix+004h),a		;bc3b
L_BC3E:
	ld a,(ix+013h)		;bc3e   ; 4 caracteres mas
	add a,004h		;bc41
	ld (ix+013h),a		;bc43
	ld a,(ix+00eh)		;bc46   ; 32 pixeles mas de alto
	add a,020h		;bc49
	ld (ix+00eh),a		;bc4b
	call columna_recorta		;bc4e   ; recortada
	call tipo_41_toca		;bc51   ; toca el mapa?
L_BC54:
	dec (ix+002h)		;bc54   ; la espera
	ret nz			;bc57
	inc (ix+001h)		;bc58
	ret			;bc5b
L_BC5C:
	bit 0,(ix+02fh)		;bc5c   ; cortada?
	jr nz,L_BC8F		;bc60
	bit 0,(ix+019h)		;bc62   ; sube o baja 32
	ld c,0e0h		;bc66
	jr z,L_BC6C		;bc68
	ld c,020h		;bc6a
L_BC6C:
	ld a,(ix+004h)		;bc6c
	add a,c			;bc6f
	ld (ix+004h),a		;bc70
	call columna_recorta		;bc73   ; columna_recorta: recorta la columna si se sale por arriba o por abajo de la pantalla
tipo_41_toca:		; C si la columna toca el mapa (entonces se quita)
	ld l,(ix+004h)		;bc76   ; su sitio
	ld h,(ix+006h)		;bc79
	bit 0,(ix+019h)		;bc7c   ; hacia abajo
	jr z,L_BCB3		;bc80
	call 05c92h		;bc82   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld de,00020h		;bc85   ; de fila en fila
	call columna_toca_mapa		;bc88   ; columna_toca_mapa: recorre las IX+13 filas de la columna en HL (de DE en DE): al tocar mapa, la corta ahi (IX+2F = 1)
	ret nc			;bc8b
	jp 06514h		;bc8c   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_BC8F:
	ld a,(ix+013h)		;bc8f   ; mengua 4
	sub 004h		;bc92
	ld (ix+013h),a		;bc94
	jp c,06514h		;bc97   ; sin nada, se quita
	dec a			;bc9a
	jp m,06514h		;bc9b   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	inc a			;bc9e
	add a,a			;bc9f   ; su alto
	add a,a			;bca0
	add a,a			;bca1
	ld (ix+00eh),a		;bca2
	bit 0,(ix+019h)		;bca5   ; hacia abajo, el principio baja
	ret z			;bca9
	ld a,(ix+004h)		;bcaa
	add a,020h		;bcad
	ld (ix+004h),a		;bcaf
	ret			;bcb2
L_BCB3:
	ld a,(ix+013h)		;bcb3   ; hacia arriba, desde su fondo
	dec a			;bcb6
	add a,a			;bcb7
	add a,a			;bcb8
	add a,a			;bcb9
	add a,l			;bcba
	ld l,a			;bcbb
	ld (0f000h),a		;bcbc   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	call 05c92h		;bcbf   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld de,0ffe0h		;bcc2   ; de fila en fila hacia arriba
	call columna_toca_mapa		;bcc5   ; columna_toca_mapa: recorre las IX+13 filas de la columna en HL (de DE en DE): al tocar mapa, la corta ahi (IX+2F = 1)
	ret nc			;bcc8
	jp 06514h		;bcc9   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
columna_toca_mapa:		; recorre las IX+13 filas de la columna en HL (de DE en DE): al tocar mapa, la corta ahi (IX+2F = 1)
	ld a,(0e305h)		;bccc   ; el primer caracter que no es mapa
	ld c,a			;bccf
	ld b,(ix+013h)		;bcd0   ; sus filas
	exx			;bcd3
	ld c,000h		;bcd4
	exx			;bcd6
L_BCD7:
	ld a,(hl)			;bcd7   ; vacio: sigue
	and a			;bcd8
	jr z,L_BCDE		;bcd9
	cp c			;bcdb   ; mapa: corta
	jr c,L_BCE6		;bcdc
L_BCDE:
	exx			;bcde   ; una fila mas
	inc c			;bcdf
	exx			;bce0
	add hl,de			;bce1
	djnz L_BCD7		;bce2
	and a			;bce4   ; sin mapa
	ret			;bce5
L_BCE6:
	ld (ix+02fh),001h		;bce6   ; cortada
	exx			;bcea
	ld (ix+013h),c		;bceb   ; su alto hasta el mapa
	ld a,c			;bcee   ; el alto
	dec a			;bcef
	scf			;bcf0   ; sin nada: C
	ret m			;bcf1
	ld a,c			;bcf2
	add a,a			;bcf3
	add a,a			;bcf4
	add a,a			;bcf5
	ld c,a			;bcf6   ; en pixeles
	ld (ix+00eh),a		;bcf7   ; en pixeles
	ld a,(ix+019h)		;bcfa
	and a			;bcfd
	ret nz			;bcfe
	ld a,(0f000h)		;bcff   ; hacia arriba, su principio
	sub c			;bd02   ; hacia arriba, sube
	ld (ix+004h),a		;bd03
	and a			;bd06
	ret			;bd07
columna_recorta:		; recorta la columna si se sale por arriba o por abajo de la pantalla
	ld (0f000h),a		;bd08   ; 0xF000
	ld a,(ix+004h)		;bd0b
	bit 0,(ix+019h)		;bd0e   ; hacia abajo
	jr z,L_BD23		;bd12
	ld a,(ix+013h)		;bd14   ; el final
	add a,a			;bd17
	add a,a			;bd18
	add a,a			;bd19
	add a,(ix+004h)		;bd1a
	sub 0c0h		;bd1d   ; pasado 0xC0?
	ret c			;bd1f
	ret z			;bd20
	jr L_BD2C		;bd21
L_BD23:
	cp 0e0h		;bd23   ; hacia arriba: se sale por arriba?
	ret c			;bd25
	neg		;bd26
	ld (ix+004h),000h		;bd28   ; desde 0
L_BD2C:
	ld c,a			;bd2c   ; lo que se sale
	ld a,(ix+00eh)		;bd2d
	sub c			;bd30
	ld (ix+00eh),a		;bd31
	ld a,c			;bd34   ; en caracteres
	rra			;bd35
	rra			;bd36
	rra			;bd37
	and 01fh		;bd38
	ld b,a			;bd3a
	ld a,(ix+013h)		;bd3b   ; menos alto
	sub b			;bd3e
	ld (ix+013h),a		;bd3f
	dec a			;bd42
	jp m,06514h		;bd43   ; sin nada, se quita
	ret			;bd46
guarda_fondo_de_enemigos:		; sin 0xE3AA, el fondo bajo cada enemigo de caracteres (no el 0x24) a 0xEB00
	ld a,(0e3aah)		;bd47   ; con 0xE3AA, nada
	or a			;bd4a
	ret nz			;bd4b
	ld de,0eb00h		;bd4c   ; el fondo a 0xEB00
	ld ix,0e600h		;bd4f   ; 12 enemigos
	ld b,00ch		;bd53
L_BD55:
	push bc			;bd55
	call guarda_fondo_de_uno		;bd56   ; guarda_fondo_de_uno: el fondo de IX+13 filas x IX+14 bajo el enemigo IX (una fila los 0x39-0x3C), con su sitio en IX+11
	exx			;bd59
	ld de,00040h		;bd5a   ; 64 bytes
	add ix,de		;bd5d
	exx			;bd5f
	pop bc			;bd60
	djnz L_BD55		;bd61
	ret			;bd63
guarda_fondo_de_uno:		; el fondo de IX+13 filas x IX+14 bajo el enemigo IX (una fila los 0x39-0x3C), con su sitio en IX+11
	bit 6,(ix+00bh)		;bd64   ; de caracteres?
	ret z			;bd68
	ld a,(ix+000h)		;bd69
	and a			;bd6c
	ret z			;bd6d
	cp 024h		;bd6e   ; el 0x24 no
	ret z			;bd70
	sub 039h		;bd71   ; los 0x39-0x3C: una fila
	cp 004h		;bd73
	jr c,L_BDB3		;bd75
	ld a,(ix+006h)		;bd77   ; en el borde derecho, no
	cp 0f8h		;bd7a
	ret nc			;bd7c
	ld h,a			;bd7d
	ld l,(ix+004h)		;bd7e
	call 05c92h		;bd81   ; su sitio
	ld (ix+011h),l		;bd84
	ld (ix+012h),h		;bd87
	ld b,(ix+013h)		;bd8a   ; sus filas
	ld c,(ix+006h)		;bd8d   ; lo que cabe hasta el borde
	xor a			;bd90
	sub c			;bd91
	jr nz,L_BD96		;bd92
	ld a,0f8h		;bd94
L_BD96:
	rra			;bd96   ; / 8
	rra			;bd97
	rra			;bd98
	and 01fh		;bd99
	ld c,(ix+014h)		;bd9b   ; su ancho, o lo que quepa
	cp c			;bd9e
	jr nc,L_BDA2		;bd9f   ; cabe entero?
	ld c,a			;bda1
L_BDA2:
	push bc			;bda2   ; una fila
	ld b,000h		;bda3
	ldir		;bda5   ; la fila
	pop bc			;bda7
	ld a,020h		;bda8   ; la siguiente
	sub c			;bdaa
	add a,l			;bdab   ; la siguiente
	ld l,a			;bdac
	jr nc,L_BDB0		;bdad
	inc h			;bdaf
L_BDB0:
	djnz L_BDA2		;bdb0
	ret			;bdb2
L_BDB3:
	ld a,(ix+014h)		;bdb3   ; su largo
	or a			;bdb6
	ret z			;bdb7
	ld c,a			;bdb8
	ld l,(ix+004h)		;bdb9
	ld h,(ix+006h)		;bdbc
	call 05c92h		;bdbf   ; su sitio
	ld (ix+011h),l		;bdc2
	ld (ix+012h),h		;bdc5
	ld b,000h		;bdc8   ; la fila
	ldir		;bdca
	ret			;bdcc
repone_fondo_de_enemigos:		; sin 0xE3AA, devuelve el fondo de 0xEB00 bajo cada enemigo de caracteres; el 0x24 se borra (p00:4BC7)
	ld a,(0e3aah)		;bdcd   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;bdd0
	ret nz			;bdd1
	ld hl,0eb00h		;bdd2   ; desde 0xEB00
	ld ix,0e600h		;bdd5   ; 12 enemigos
	ld b,00ch		;bdd9
L_BDDB:
	push bc			;bddb
	bit 6,(ix+00bh)		;bddc   ; de caracteres?
	jr z,L_BE27		;bde0
	ld a,(ix+000h)		;bde2   ; libre
	and a			;bde5
	jr z,L_BE27		;bde6
	cp 024h		;bde8   ; el 0x24 se borra
	jr z,L_BE30		;bdea
	sub 039h		;bdec   ; los 0x39-0x3C: una fila
	cp 004h		;bdee
	jr c,L_BE37		;bdf0
	ld a,(ix+006h)		;bdf2   ; en el borde derecho, no
	cp 0f8h		;bdf5
	jr nc,L_BE27		;bdf7
	ld e,(ix+011h)		;bdf9   ; su sitio
	ld d,(ix+012h)		;bdfc   ; su sitio
	ld b,(ix+013h)		;bdff   ; sus filas
	ld c,(ix+006h)		;be02   ; su X
	xor a			;be05
	sub c			;be06
	jr nz,L_BE0B		;be07
	ld a,0f8h		;be09
L_BE0B:
	rra			;be0b   ; / 8: lo que cabe
	rra			;be0c
	rra			;be0d
	and 01fh		;be0e
	ld c,(ix+014h)		;be10   ; su ancho
	cp c			;be13   ; cabe entero?
	jr nc,L_BE17		;be14
	ld c,a			;be16   ; recortado
L_BE17:
	push bc			;be17   ; una fila
	ld b,000h		;be18
	ldir		;be1a   ; la fila
	pop bc			;be1c
	ld a,020h		;be1d   ; la siguiente
	sub c			;be1f
	add a,e			;be20   ; la siguiente
	ld e,a			;be21
	jr nc,L_BE25		;be22
	inc d			;be24
L_BE25:
	djnz L_BE17		;be25
L_BE27:
	pop bc			;be27
	ld de,00040h		;be28   ; el siguiente
	add ix,de		;be2b   ; 64 bytes
	djnz L_BDDB		;be2d
	ret			;be2f
L_BE30:
	push hl			;be30
	call 04bc7h		;be31   ; quita_el_jefe: borra IX+13 filas de IX+14 caracteres de la pantalla de RAM en IX+04/IX+06
	pop hl			;be34
	jr L_BE27		;be35
L_BE37:
	ld a,(ix+014h)		;be37   ; su largo
	or a			;be3a
	ret z			;be3b
	ld c,a			;be3c
	ld b,000h		;be3d
	ld e,(ix+011h)		;be3f
	ld d,(ix+012h)		;be42
	ldir		;be45   ; la fila
	jr L_BE27		;be47
clase_14_empieza:		; la clase 14: la forma 0x2F, 4 golpes, 2 x 2, 48 cuadros y sin caja
	ld (ix+007h),02fh		;be49   ; la forma 0x2F
	ld (ix+008h),004h		;be4d   ; 4 golpes
	ld (ix+009h),002h		;be51   ; 2 x 2
	ld (ix+00ah),002h		;be55
	ld (ix+002h),030h		;be59   ; 48 cuadros
	ld (ix+00dh),0ffh		;be5d   ; sin caja
	ret			;be61
clase_14:		; la clase 14: lo de su paso (p11:BE68)
	ld a,(ix+001h)		;be62
	call 04084h		;be65   ; por paso

; ----------------------------------------------------------------------
; DATOS tabla_BE68: 5 destinos del despachador p00:4084 (call en p11:BE65, el
;   indice en A): BE72, BE86, BEA1, BED0, BEE1; lo leen p11:BE65 (10 bytes)
;   0xbe68..0xbe72  (10 bytes)
DATA_tabla_BE68:
	defw 0be72h,0be86h,0bea1h,0bed0h,0bee1h	; be68

; ======================================================================
; CODIGO 0xbe72..0xbf0b  (153 bytes)
; ======================================================================


clase_14_espera:		; al acabar la espera, a abrirse (2 pasos) con caja 30
	dec (ix+002h)		;be72   ; la espera
	ret nz			;be75
	inc (ix+001h)		;be76
	ld (ix+002h),001h		;be79
	ld (ix+00ch),002h		;be7d   ; 2 pasos
	ld (ix+00dh),01eh		;be81   ; caja 30
	ret			;be85
clase_14_abre:		; cada 3 cuadros la forma + 1; abierta, 5 por soltar
	dec (ix+002h)		;be86   ; cada 3 cuadros
	ret nz			;be89
	ld (ix+002h),003h		;be8a
	inc (ix+007h)		;be8e   ; la forma siguiente
	dec (ix+00ch)		;be91
	ret nz			;be94
	ld (ix+002h),001h		;be95   ; 5 por soltar
	ld (ix+00ch),005h		;be99
	inc (ix+001h)		;be9d
	ret			;bea0
clase_14_suelta:		; cada 8 cuadros un 0x40 por su boca (suena 0x15); al acabar, 64 cuadros
	dec (ix+002h)		;bea1   ; cada 8 cuadros
	ret nz			;bea4
	ld (ix+002h),008h		;bea5
	ld a,(ix+004h)		;bea9   ; su boca: Y - 12, X - 4
	add a,0f4h		;beac
	ld e,a			;beae
	ld a,(ix+006h)		;beaf
	sub 004h		;beb2
	ld d,a			;beb4
	ld a,040h		;beb5   ; un 0x40
	ld b,(ix+00ch)		;beb7
	ld c,000h		;beba
	call 04d16h		;bebc   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,015h		;bebf   ; suena 0x15
	call 04ae4h		;bec1   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	dec (ix+00ch)		;bec4   ; uno menos
	ret nz			;bec7
	ld (ix+002h),040h		;bec8   ; 64 cuadros
	inc (ix+001h)		;becc
	ret			;becf
clase_14_otra_vez:		; al acabar la espera, 5 por soltar otra vez
	dec (ix+002h)		;bed0
	ret nz			;bed3
	ld (ix+002h),001h		;bed4   ; 1 cuadro
	ld (ix+00ch),005h		;bed8   ; 5 por soltar
	ld (ix+001h),002h		;bedc   ; al paso 2
	ret			;bee0
clase_14_rota:		; la forma 0x32
	ld (ix+007h),032h		;bee1
	ret			;bee5
tipo_40_empieza:		; el tipo 0x40: su espera (p11:BF0B por B), su espera de disparo y hacia arriba (vy 0xFD00)
	ld a,(ix+019h)		;bee6   ; su espera de p11:BF0B
	dec a			;bee9
	ld hl,0bf0bh		;beea
	call 0407ah		;beed   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;bef0
	ld (ix+002h),a		;bef1
	call 04e93h		;bef4   ; la espera de disparo
	ld (ix+015h),a		;bef7
	ld (ix+024h),004h		;befa   ; animacion
	ld (ix+025h),000h		;befe
	ld de,00000h		;bf02   ; hacia arriba
	ld hl,0fd00h		;bf05
	jp 04f26h		;bf08   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL

; ----------------------------------------------------------------------
; DATOS tabla_BF0B: 5 bytes que p11:BEE6 lee con IX+19 - 1; lo leen p11:BEED
;   (5 bytes)
;   0xbf0b..0xbf10  (5 bytes)
DATA_tabla_BF0B:
	defb 00ch,010h,014h,018h,01ch	; bf0b

; ======================================================================
; CODIGO 0xbf10..0xbf63  (83 bytes)
; ======================================================================


tipo_40:		; el tipo 0x40: se anima y dispara; sube hasta Y 8 (o acaba su espera) y luego va hacia la nave en X y se acerca a su altura
	call tipo_40_dibujo		;bf10   ; su dibujo
	call 06770h		;bf13   ; dispara
	ld a,(ix+001h)		;bf16   ; paso 1: a la altura de la nave
	dec a			;bf19
	jp z,09b62h		;bf1a   ; hacia_la_y_de_la_nave: la velocidad Y + o - 0x16 hacia la Y de la nave
	ld a,(ix+004h)		;bf1d   ; arriba del todo: a por la nave
	cp 008h		;bf20
	jr c,L_BF31		;bf22
	ld a,(0e327h)		;bf24   ; con el scroll
	and a			;bf27
	jr nz,L_BF2D		;bf28
	dec (ix+006h)		;bf2a
L_BF2D:
	dec (ix+002h)		;bf2d   ; la espera
	ret nz			;bf30
L_BF31:
	ld de,00280h		;bf31   ; vx 0x0280 hacia la nave
	ld a,(0e406h)		;bf34   ; lee la X de la nave
	sub (ix+006h)		;bf37
	call c,05cadh		;bf3a   ; menos_de: DE = - DE
	ld hl,00000h		;bf3d
	call 04f26h		;bf40   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
	inc (ix+001h)		;bf43   ; al paso 1
	ret			;bf46
tipo_40_dibujo:		; cada 4 cuadros uno de 3 dibujos (0xC4, 0xC8, 0xCC)
	dec (ix+024h)		;bf47   ; cada 4 cuadros
	ret nz			;bf4a
	ld (ix+024h),004h		;bf4b
	ld a,(ix+025h)		;bf4f   ; el dibujo siguiente
	inc a			;bf52
	cp 003h		;bf53
	jr c,L_BF58		;bf55
	xor a			;bf57
L_BF58:
	ld (ix+025h),a		;bf58
	add a,a			;bf5b   ; 0xC4 + 4 x paso
	add a,a			;bf5c   ; x 4
	add a,0c4h		;bf5d
	ld (ix+030h),a		;bf5f
	ret			;bf62

; ----------------------------------------------------------------------
; DATOS caracteres_BF63: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p00:43C1 (13
;   bytes)
;   0xbf63..0xbf70  (13 bytes)
DATA_caracteres_BF63:
	defb 007h,070h,0bfh,0edh,0a8h,0bfh	; bf63
	defb 007h,091h,0bfh,0f6h,0bch,0bfh	; bf69
	defb 000h	; bf6f

; ----------------------------------------------------------------------
; DATOS dibujos_BF70: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 237, ficha 0 de la lista 0xBF63 (p00:4595); lo leen p00:43C1 (33
;   bytes)
;   0xbf70..0xbf91  (33 bytes)
DATA_dibujos_BF70:
	defb 003h,000h,09dh,006h,00fh,007h,00fh,006h,000h,000h,018h,070h,0fch,038h,0ceh,0f4h	; bf70  ...........p.8..
	defb 019h,03fh,07fh,0ffh,0fch,003h,03fh,000h,07ah,0b8h,08dh,0b7h,09ah,06bh,0b9h,000h	; bf80  .?....?.z....k..
	defb 000h	; bf90

; ----------------------------------------------------------------------
; DATOS dibujos_BF91: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 246, ficha 1 de la lista 0xBF63 (p00:4595); lo leen p00:43C1 (23
;   bytes)
;   0xbf91..0xbfa8  (23 bytes)
DATA_dibujos_BF91:
	defb 083h,0a5h,0e7h,042h,007h,000h,083h,0a5h,0e7h,042h,006h,000h,083h,0a5h,0e7h,042h	; bf91  ...B.....B.....B
	defb 007h,000h,083h,0a5h,0e7h,042h,000h	; bfa1

; ----------------------------------------------------------------------
; DATOS colores_BFA8: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 237, ficha 0 de la lista 0xBF63 (p00:4595); lo leen p00:43C1 (20
;   bytes)
;   0xbfa8..0xbfbc  (20 bytes)
DATA_colores_BFA8:
	defb 007h,0f0h,081h,0e0h,006h,090h,004h,080h,002h,060h,086h,076h,070h,040h,040h,080h	; bfa8  .........`.vp@@.
	defb 080h,006h,060h,000h	; bfb8

; ----------------------------------------------------------------------
; DATOS colores_BFBC: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 246, ficha 1 de la lista 0xBF63 (p00:4595); lo leen p00:43C1 (3
;   bytes)
;   0xbfbc..0xbfbf  (3 bytes)
DATA_colores_BFBC:
	defb 020h,080h,000h	; bfbc

; ----------------------------------------------------------------------
; DATOS caracteres_BFBF: lista de caracteres (p00:4595) que p00:4343 pasa con
;   el banco 11 puesto (si el bit 2 de 0xF0F5); lo leen p00:4350 (7 bytes)
;   0xbfbf..0xbfc6  (7 bytes)
DATA_caracteres_BFBF:
	defb 007h,0c6h,0bfh,0c7h,0e8h,0bfh	; bfbf
	defb 000h	; bfc5

; ----------------------------------------------------------------------
; DATOS dibujos_BFC6: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 199, ficha 0 de la lista 0xBFBF (p00:4595); lo leen p00:4350 (34
;   bytes)
;   0xbfc6..0xbfe8  (34 bytes)
DATA_dibujos_BFC6:
	defb 002h,000h,086h,006h,0cbh,06bh,02fh,066h,0c0h,003h,000h,095h,001h,003h,054h,0ffh	; bfc6  .....k/f......T.
	defb 0bdh,03bh,039h,03ch,01eh,01fh,007h,000h,000h,0d9h,0d8h,010h,030h,0e0h,0c0h,000h	; bfd6  ..9<........0...
	defb 000h,000h	; bfe6

; ----------------------------------------------------------------------
; DATOS colores_BFE8: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 199, ficha 0 de la lista 0xBFBF (p00:4595); lo leen p00:4350 (23
;   bytes)
;   0xbfe8..0xbfff  (23 bytes)
DATA_colores_BFE8:
	defb 007h,0a0h,081h,0a4h,005h,0f0h,087h,0f4h,044h,050h,050h,070h,0f0h,0f0h,004h,0e0h	; bfe8  ........DPPp....
	defb 081h,070h,003h,0f0h,004h,0e0h,000h	; bff8

; ----------------------------------------------------------------------
; DATOS relleno_ff: un 0xFF al final del banco: relleno; lo leen nadie (1
;   bytes)
;   0xbfff..0xc000  (1 bytes)
DATA_relleno_ff:
	defb 0ffh	; bfff

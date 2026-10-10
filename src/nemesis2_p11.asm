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


L_A000:
	ld de,0e280h		;a000   ; apunta a los atributos de los 32 sprites (Y, X, dibujo, color)
	ld a,(0e400h)		;a003   ; lee la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	or a			;a006
	jr z,L_A071		;a007
	jp m,L_A079		;a009
	ld hl,(0e446h)		;a00c   ; lee la marca de nave intocable y el byte siguiente (16 bits)
	dec l			;a00f
	jr nz,L_A01E		;a010
	ld a,h			;a012
	cp 003h		;a013
	jr nc,L_A01E		;a015
	ld a,(0e1c3h)		;a017   ; lee la cuenta de cuadros
	bit 1,a		;a01a
	jr z,L_A071		;a01c
L_A01E:
	ld hl,0e404h		;a01e
	ldi		;a021
	inc l			;a023
	ldi		;a024
	ldi		;a026
	ldi		;a028
	ld hl,0e404h		;a02a
	ld a,(0e400h)		;a02d   ; lee la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	dec a			;a030
	jr z,L_A04B		;a031
	dec a			;a033
	jr nz,L_A04B		;a034
	ldi		;a036
	inc l			;a038
	ld a,(0f0f5h)		;a039   ; lee lo que hay en la otra ranura (bit 3 Galious, 2 Penguin Adventure, 1 los 6 bytes de 0x7FFA, 0 Q*bert)
	bit 2,a		;a03c
	ld b,008h		;a03e
	jr z,L_A044		;a040
	ld b,000h		;a042
L_A044:
	ld a,(hl)			;a044
	add a,b			;a045
	ld (de),a			;a046
	inc e			;a047
	inc l			;a048
	jr L_A050		;a049
L_A04B:
	ldi		;a04b
	inc l			;a04d
	ldi		;a04e
L_A050:
	inc l			;a050
	inc l			;a051
	ldi		;a052
	ldi		;a054
	ld hl,0e410h		;a056
	call L_A05F		;a059
	ld hl,0e420h		;a05c
L_A05F:
	ld a,(hl)			;a05f
	or a			;a060
	jr z,L_A0AA		;a061
	ld a,l			;a063
	add a,004h		;a064
	ld l,a			;a066
	ldi		;a067
	inc l			;a069
	ldi		;a06a
	ldi		;a06c
	ldi		;a06e
	ret			;a070
L_A071:
	ld b,004h		;a071
L_A073:
	call L_A0AA		;a073
	djnz L_A073		;a076
	ret			;a078
L_A079:
	ld hl,0e418h		;a079
	call L_A082		;a07c
	ld hl,0e428h		;a07f
L_A082:
	ld bc,00008h		;a082
	ldir		;a085
	ret			;a087
L_A088:
	ld de,0e290h		;a088
	ld hl,0e470h		;a08b   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	exx			;a08e
	ld bc,00906h		;a08f
L_A092:
	exx			;a092
	push hl			;a093
	call L_A0B2		;a094
	pop hl			;a097
	ld bc,00010h		;a098
	add hl,bc			;a09b
	exx			;a09c
	djnz L_A092		;a09d
	ld a,c			;a09f
	exx			;a0a0
	or a			;a0a1
	ret z			;a0a2
	ld b,a			;a0a3
L_A0A4:
	call L_A0AA		;a0a4
	djnz L_A0A4		;a0a7
	ret			;a0a9
L_A0AA:
	ld a,0e0h		;a0aa
	ld (de),a			;a0ac
	inc e			;a0ad
	inc e			;a0ae
	inc e			;a0af
	inc e			;a0b0
	ret			;a0b1
L_A0B2:
	ld a,(hl)			;a0b2
	cp 00eh		;a0b3
	jr z,L_A0C0		;a0b5
	cp 006h		;a0b7
	jr z,L_A0D0		;a0b9
	sub 003h		;a0bb
	cp 003h		;a0bd
	ret nc			;a0bf
L_A0C0:
	inc l			;a0c0
L_A0C1:
	inc l			;a0c1
	inc l			;a0c2
	ldi		;a0c3
	inc l			;a0c5
	ldi		;a0c6
	ldi		;a0c8
	ldi		;a0ca
	exx			;a0cc
	dec c			;a0cd
	exx			;a0ce
	ret			;a0cf
L_A0D0:
	inc l			;a0d0
	bit 0,(hl)		;a0d1
	jr z,L_A0C1		;a0d3
	ret			;a0d5
L_A0D6:
	ld ix,0e470h		;a0d6   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	ld de,0ec00h		;a0da
	ld b,006h		;a0dd
L_A0DF:
	push bc			;a0df
	call L_A0EC		;a0e0
	ld bc,00010h		;a0e3
	add ix,bc		;a0e6
	pop bc			;a0e8
	djnz L_A0DF		;a0e9
	ret			;a0eb
L_A0EC:
	ld a,(ix+000h)		;a0ec
	dec a			;a0ef
	ret m			;a0f0
	call 04084h		;a0f1   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

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


L_A112:
	call L_A15A		;a112
	ldi		;a115
	ret			;a117
L_A118:
	call L_A15A		;a118
	ld a,(ix+00ah)		;a11b
	or a			;a11e
	ret z			;a11f
	ld c,a			;a120
	ld b,000h		;a121
	ldir		;a123
	ret			;a125
L_A126:
	call L_A15A		;a126
	ld a,(ix+00ah)		;a129
	or a			;a12c
	ret z			;a12d
L_A12E:
	ldi		;a12e
	ld bc,0001fh		;a130
	add hl,bc			;a133
	dec a			;a134
	jr nz,L_A12E		;a135
	ret			;a137
L_A138:
	call L_A15A		;a138
	ld (0f000h),hl		;a13b   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld a,(ix+00ah)		;a13e
	or a			;a141
	ret z			;a142
	ld c,a			;a143
	ld b,000h		;a144
	ldir		;a146
	bit 0,(ix+006h)		;a148
	ret z			;a14c
	ld hl,(0f000h)		;a14d   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld bc,00020h		;a150
	add hl,bc			;a153
	ld c,(ix+00ah)		;a154
	ldir		;a157
L_A159:
	ret			;a159
L_A15A:
	ld l,(ix+003h)		;a15a
	ld h,(ix+005h)		;a15d
	call 05c92h		;a160   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (ix+00eh),l		;a163
	ld (ix+00fh),h		;a166
	ret			;a169
L_A16A:
	ld ix,0e470h		;a16a   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	ld de,0ec00h		;a16e
	ld b,006h		;a171
L_A173:
	push bc			;a173
	call L_A180		;a174
	ld bc,00010h		;a177
	add ix,bc		;a17a
	pop bc			;a17c
	djnz L_A173		;a17d
	ret			;a17f
L_A180:
	ld a,(ix+000h)		;a180
	dec a			;a183
	ret m			;a184
	call 04084h		;a185   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

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


L_A1A6:
	ex de,hl			;a1a6
	ld e,(ix+00eh)		;a1a7
	ld d,(ix+00fh)		;a1aa
	ldi		;a1ad
	ex de,hl			;a1af
	ret			;a1b0
L_A1B1:
	ld a,(ix+00ah)		;a1b1
	or a			;a1b4
	ret z			;a1b5
	ld c,a			;a1b6
	ld b,000h		;a1b7
	ex de,hl			;a1b9
	ld e,(ix+00eh)		;a1ba
	ld d,(ix+00fh)		;a1bd
	ldir		;a1c0
	ex de,hl			;a1c2
	ret			;a1c3
L_A1C4:
	ld a,(ix+00ah)		;a1c4
	or a			;a1c7
	ret z			;a1c8
	ex de,hl			;a1c9
	ld e,(ix+00eh)		;a1ca
	ld d,(ix+00fh)		;a1cd
L_A1D0:
	ldi		;a1d0
	ex de,hl			;a1d2
	ld bc,0001fh		;a1d3
	add hl,bc			;a1d6
	ex de,hl			;a1d7
	dec a			;a1d8
	jr nz,L_A1D0		;a1d9
	ex de,hl			;a1db
	ret			;a1dc
L_A1DD:
	ld a,(ix+00ah)		;a1dd
	or a			;a1e0
	ret z			;a1e1
	ld c,a			;a1e2
	ld b,000h		;a1e3
	ld l,(ix+00eh)		;a1e5
	ld h,(ix+00fh)		;a1e8
	ld (0f000h),hl		;a1eb   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ex de,hl			;a1ee
	ldir		;a1ef
	ex de,hl			;a1f1
	bit 0,(ix+006h)		;a1f2
	ret z			;a1f6
	ld hl,(0f000h)		;a1f7   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld bc,00020h		;a1fa
	add hl,bc			;a1fd
	ld c,(ix+00ah)		;a1fe
	ex de,hl			;a201
	ldir		;a202
	ex de,hl			;a204
	ret			;a205
L_A206:
	ld ix,0e470h		;a206   ; apunta a los 9 disparos de la nave (16 bytes: tipo, Y, X, largo...)
	ld b,009h		;a20a
L_A20C:
	push bc			;a20c
	call L_A219		;a20d
	ld bc,00010h		;a210
	add ix,bc		;a213
	pop bc			;a215
	djnz L_A20C		;a216
	ret			;a218
L_A219:
	ld a,(ix+000h)		;a219
	dec a			;a21c
	ret m			;a21d
	call 04084h		;a21e   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

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


L_A23F:
	ld l,(ix+00eh)		;a23f
	ld h,(ix+00fh)		;a242
	ld a,(ix+006h)		;a245
	ld (hl),a			;a248
	ret			;a249
L_A24A:
	ld a,(ix+00ah)		;a24a
	or a			;a24d
	ret z			;a24e
	ld b,a			;a24f
	ld l,(ix+00eh)		;a250
	ld h,(ix+00fh)		;a253
	ld a,(ix+006h)		;a256
L_A259:
	ld (hl),a			;a259
	inc l			;a25a
	djnz L_A259		;a25b
	ret			;a25d
L_A25E:
	ld a,(ix+00ah)		;a25e
	or a			;a261
	ret z			;a262
	ld b,a			;a263
	ld l,(ix+00eh)		;a264
	ld h,(ix+00fh)		;a267
	ld a,(ix+006h)		;a26a
	ld de,00020h		;a26d
L_A270:
	ld (hl),a			;a270
	add hl,de			;a271
	djnz L_A270		;a272
	ret			;a274
L_A275:
	ld a,(ix+00ah)		;a275
	or a			;a278
	ret z			;a279
	ld b,a			;a27a
	ld l,(ix+00eh)		;a27b
	ld h,(ix+00fh)		;a27e
	ld a,(ix+006h)		;a281
	add a,0f3h		;a284
L_A286:
	ld (hl),a			;a286
	inc l			;a287
	djnz L_A286		;a288
	bit 0,(ix+006h)		;a28a
	ret z			;a28e
	ld l,(ix+00eh)		;a28f
	ld h,(ix+00fh)		;a292
	ld bc,00020h		;a295
	add hl,bc			;a298
	ld b,(ix+00ah)		;a299
	inc a			;a29c
L_A29D:
	ld (hl),a			;a29d
	inc l			;a29e
	djnz L_A29D		;a29f
	ret			;a2a1
L_A2A2:
	ld hl,0e3abh		;a2a2
	ld a,(hl)			;a2a5
	dec a			;a2a6
	jr z,L_A2E7		;a2a7
	dec a			;a2a9
	jr z,L_A317		;a2aa
	dec a			;a2ac
	jp z,L_A349		;a2ad
	xor a			;a2b0
	ld (0e3aeh),a		;a2b1   ; guarda la marca de fin de p11:A2A2
	inc l			;a2b4
	ld (hl),a			;a2b5
	inc l			;a2b6
	ld (hl),0f0h		;a2b7
L_A2B9:
	ld a,(0e3ach)		;a2b9
	or a			;a2bc
	jr nz,L_A2C1		;a2bd
	ld a,01fh		;a2bf
L_A2C1:
	ld de,01000h		;a2c1
	call L_A357		;a2c4
	ld de,00800h		;a2c7
	call L_A354		;a2ca
	ld de,00000h		;a2cd
	call L_A354		;a2d0
	ld hl,0e3ach		;a2d3
	ld a,(hl)			;a2d6
	add a,040h		;a2d7
	ld (hl),a			;a2d9
	jr nz,L_A2B9		;a2da
	dec l			;a2dc
	inc (hl)			;a2dd
	inc l			;a2de
	inc l			;a2df
	ld (hl),0feh		;a2e0
	ld a,038h		;a2e2
	jp 04ae4h		;a2e4   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A2E7:
	ld a,(0e3ach)		;a2e7
	or a			;a2ea
	jr nz,L_A2EF		;a2eb
	ld a,01fh		;a2ed
L_A2EF:
	ld de,03000h		;a2ef
	call L_A357		;a2f2
	ld de,02800h		;a2f5
	call L_A354		;a2f8
	ld de,02000h		;a2fb
	call L_A354		;a2fe
	ld hl,0e3ach		;a301
	ld a,(hl)			;a304
	add a,040h		;a305
	ld (hl),a			;a307
	ret nz			;a308
	inc l			;a309
	ld a,(hl)			;a30a
	and a			;a30b
	jr z,L_A311		;a30c
	sla (hl)		;a30e
	ret			;a310
L_A311:
	ld a,002h		;a311
	ld (0e3abh),a		;a313
	ret			;a316
L_A317:
	ld hl,0ed00h		;a317   ; apunta a la pantalla en RAM: la tabla de nombres de 22 filas de 32
	ld de,0ed01h		;a31a
	ld bc,002bfh		;a31d
	ld (hl),000h		;a320
	ldir		;a322
	ld hl,0e600h		;a324   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld de,0e601h		;a327
	ld bc,002ffh		;a32a
	ld (hl),000h		;a32d
	ldir		;a32f
	ld hl,0e350h		;a331   ; apunta a el tipo del enemigo que se crea
	ld de,0e351h		;a334   ; apunta a el dato C del enemigo que se crea
	ld bc,00006h		;a337
	ld (hl),000h		;a33a
	ldir		;a33c
	ld a,03ch		;a33e
	ld (0e349h),a		;a340   ; guarda la espera del suceso
	ld a,003h		;a343
	ld (0e3abh),a		;a345
	ret			;a348
L_A349:
	ld hl,0e349h		;a349   ; apunta a la espera del suceso
	dec (hl)			;a34c
	ret nz			;a34d
	ld a,001h		;a34e
	ld (0e3aeh),a		;a350   ; guarda la marca de fin de p11:A2A2
	ret			;a353
L_A354:
	ld a,(0e3ach)		;a354
L_A357:
	ld bc,00108h		;a357
	cp 01fh		;a35a
	jr z,L_A368		;a35c
	ld bc,00038h		;a35e
	cp 0c0h		;a361
	jr nc,L_A368		;a363
	ld bc,00200h		;a365
L_A368:
	ld l,a			;a368
	ld h,000h		;a369
	add hl,hl			;a36b
	add hl,hl			;a36c
	add hl,hl			;a36d
	add hl,de			;a36e
	push hl			;a36f
	ld de,0e600h		;a370   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	push bc			;a373
	call 00059h		;a374   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop bc			;a377
	push bc			;a378
	ld hl,0e600h		;a379   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld a,(0e3adh)		;a37c
	ld e,a			;a37f
	call L_A38B		;a380
	pop bc			;a383
	pop hl			;a384
	ld de,0e600h		;a385   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	jp 04a33h		;a388   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
L_A38B:
	ld a,(0e3abh)		;a38b
	and a			;a38e
	jr nz,L_A39B		;a38f
L_A391:
	ld a,(hl)			;a391
	and e			;a392
	ld (hl),a			;a393
	inc hl			;a394
	dec bc			;a395
	ld a,b			;a396
	or c			;a397
	jr nz,L_A391		;a398
	ret			;a39a
L_A39B:
	ld a,(hl)			;a39b
	and e			;a39c
	ld (hl),a			;a39d
	inc hl			;a39e
	rrc e		;a39f
	rrc e		;a3a1
	rrc e		;a3a3
	dec bc			;a3a5
	ld a,b			;a3a6
	or c			;a3a7
	jr nz,L_A39B		;a3a8
	ret			;a3aa
L_A3AB:
	ld (ix+00dh),0ffh		;a3ab
	ld (ix+002h),001h		;a3af
	ld (ix+00ch),000h		;a3b3
	bit 1,(ix+00bh)		;a3b7
	ld a,00bh		;a3bb
	jr z,L_A3C1		;a3bd
	ld a,00eh		;a3bf
L_A3C1:
	ld (ix+001h),a		;a3c1
	ret			;a3c4
L_A3C5:
	ld a,(ix+006h)		;a3c5
	cp 0c1h		;a3c8
	ret nc			;a3ca
	ld a,(0e1c3h)		;a3cb   ; lee la cuenta de cuadros
	and 007h		;a3ce
	ld a,011h		;a3d0
	call z,04ae4h		;a3d2   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	dec (ix+002h)		;a3d5
	ret nz			;a3d8
	ld (ix+002h),007h		;a3d9
	inc (ix+00ch)		;a3dd
	dec (ix+001h)		;a3e0
	jr nz,L_A3E9		;a3e3
	ld (ix+000h),000h		;a3e5
L_A3E9:
	bit 0,(ix+00bh)		;a3e9
	jr z,L_A40C		;a3ed
	ld b,008h		;a3ef
	call L_A42A		;a3f1
	ret c			;a3f4
	ld hl,0a48dh		;a3f5
	exx			;a3f8
	ld b,(ix+00ch)		;a3f9
L_A3FC:
	exx			;a3fc
	ld bc,00004h		;a3fd
	ldir		;a400
	ld bc,0ffdch		;a402
	ex de,hl			;a405
	add hl,bc			;a406
	ex de,hl			;a407
	exx			;a408
	djnz L_A3FC		;a409
	ret			;a40b
L_A40C:
	ld b,0f8h		;a40c
	call L_A42A		;a40e
	ret c			;a411
	ld hl,0a44dh		;a412
	exx			;a415
	ld b,(ix+00ch)		;a416
L_A419:
	exx			;a419
	ld bc,00004h		;a41a
	ldir		;a41d
	ld a,01ch		;a41f
	add a,e			;a421
	ld e,a			;a422
	jr nc,L_A426		;a423
	inc d			;a425
L_A426:
	exx			;a426
	djnz L_A419		;a427
	ret			;a429
L_A42A:
	ld a,(ix+004h)		;a42a
	ld l,a			;a42d
	add a,b			;a42e
	ld (ix+004h),a		;a42f
	ld h,(ix+006h)		;a432
	ld a,(0e320h)		;a435   ; lee la marca de scroll hecho en este cuadro
	or a			;a438
	jr z,L_A441		;a439
	ld a,h			;a43b
	sub 008h		;a43c
	jr z,L_A447		;a43e
	ld h,a			;a440
L_A441:
	call 05c92h		;a441   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;a444
	xor a			;a445
	ret			;a446
L_A447:
	ld (ix+000h),000h		;a447
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


L_A4D1:
	ld (ix+00dh),0ffh		;a4d1
	ld (ix+00ch),00bh		;a4d5
	ld (ix+00eh),000h		;a4d9
	ld (ix+00fh),006h		;a4dd
	ret			;a4e1
L_A4E2:
	ld a,(ix+001h)		;a4e2
	dec a			;a4e5
	jr z,L_A4F2		;a4e6
	ld a,(ix+006h)		;a4e8
	cp 080h		;a4eb
	ret nc			;a4ed
	inc (ix+001h)		;a4ee
	ret			;a4f1
L_A4F2:
	dec (ix+00fh)		;a4f2
	ret nz			;a4f5
	ld (ix+00fh),006h		;a4f6
	call L_A51C		;a4fa
	call L_A50C		;a4fd
	inc (ix+00eh)		;a500
	dec (ix+00ch)		;a503
	ret nz			;a506
	ld (ix+000h),000h		;a507
	ret			;a50b
L_A50C:
	ld a,014h		;a50c
	sub (ix+00eh)		;a50e
	call L_A54E		;a511
	ld a,015h		;a514
	sub (ix+00eh)		;a516
	add a,a			;a519
	jr L_A526		;a51a
L_A51C:
	ld a,(ix+00eh)		;a51c
	call L_A54E		;a51f
	ld a,(ix+00eh)		;a522
	add a,a			;a525
L_A526:
	call 0407ah		;a526   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;a529
	inc hl			;a52a
	ld d,(hl)			;a52b
	ld hl,(0f000h)		;a52c   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ex de,hl			;a52f
	ld bc,01000h		;a530
L_A533:
	add hl,hl			;a533
	jr nc,L_A544		;a534
	ld a,r		;a536
	xor l			;a538
	and 00fh		;a539
	ld a,067h		;a53b
	jr z,L_A541		;a53d
	ld a,069h		;a53f
L_A541:
	ld (de),a			;a541
	ld c,001h		;a542
L_A544:
	inc de			;a544
	djnz L_A533		;a545
	dec c			;a547
	ret nz			;a548
	ld a,011h		;a549
	jp 04ae4h		;a54b   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A54E:
	add a,a			;a54e
	add a,a			;a54f
	add a,a			;a550
	ld l,a			;a551
	ld h,(ix+006h)		;a552
	call 05c92h		;a555   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0f000h),hl		;a558   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld a,(ix+00bh)		;a55b
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


L_A5F0:
	ld a,(ix+006h)		;a5f0
	sub 020h		;a5f3
	ld (ix+029h),a		;a5f5
	ld a,0e0h		;a5f8
	ld (ix+034h),a		;a5fa
	ld (ix+038h),a		;a5fd
	ld (ix+03ch),a		;a600
	ld (ix+024h),008h		;a603
	xor a			;a607
	ld (0e39ah),a		;a608
	inc a			;a60b
	ld (ix+010h),a		;a60c
	ld (ix+025h),a		;a60f
	inc a			;a612
	ld (ix+02bh),a		;a613
	ld (ix+02ch),a		;a616
L_A619:
	inc (ix+02bh)		;a619
	ld a,(ix+02bh)		;a61c
	and 00fh		;a61f
	ld hl,0a634h		;a621
	call 05ca6h		;a624   ; byte_a: A = el byte A de la tabla HL
	ld (ix+031h),a		;a627
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


L_A644:
	call L_A619		;a644
	dec (ix+02ch)		;a647
	ret nz			;a64a
	ld (ix+02ch),002h		;a64b
	ld a,(ix+001h)		;a64f
	or a			;a652
	jr nz,L_A658		;a653
	dec (ix+02ch)		;a655
L_A658:
	call 04084h		;a658   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_A65B: 4 destinos del despachador p00:4084 (call en p11:A658, el
;   indice en A): A663, A69B, A6AA, A6C1; lo leen p11:A658 (8 bytes)
;   0xa65b..0xa663  (8 bytes)
DATA_tabla_A65B:
	defw 0a663h,0a69bh,0a6aah,0a6c1h	; a65b  -> L_A663 L_A69B L_A6AA L_A6C1

; ======================================================================
; CODIGO 0xa663..0xa73a  (215 bytes)
; ======================================================================


L_A663:
	dec (ix+024h)		;a663
	jr z,L_A67C		;a666
	bit 0,(ix+024h)		;a668
	ret z			;a66c
	ld a,(ix+030h)		;a66d
	add a,004h		;a670
	cp 0e4h		;a672
	jr nz,L_A678		;a674
	ld a,0d0h		;a676
L_A678:
	ld (ix+030h),a		;a678
	ret			;a67b
L_A67C:
	ld a,(ix+006h)		;a67c
	sub 010h		;a67f
	ld (ix+006h),a		;a681
	ld a,(ix+004h)		;a684
	ld (ix+02ah),a		;a687
	call L_A6FA		;a68a
	ld b,001h		;a68d
	call L_A744		;a68f
	ld a,017h		;a692
	call 04ae4h		;a694   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A697:
	inc (ix+001h)		;a697
	ret			;a69a
L_A69B:
	call L_A6B4		;a69b
	ld a,(ix+025h)		;a69e
	inc a			;a6a1
	cp 004h		;a6a2
	jr z,L_A697		;a6a4
	ld (ix+025h),a		;a6a6
	ret			;a6a9
L_A6AA:
	ld a,(ix+03dh)		;a6aa
	cp 009h		;a6ad
	jr c,L_A697		;a6af
	call L_A6CF		;a6b1
L_A6B4:
	call L_A766		;a6b4
	push af			;a6b7
	call L_A78B		;a6b8
	pop af			;a6bb
	ld b,001h		;a6bc
	jp L_A744		;a6be
L_A6C1:
	call L_A6CF		;a6c1
	dec (ix+025h)		;a6c4
	jp m,06514h		;a6c7   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld (ix+03ch),0e0h		;a6ca
	ret			;a6ce
L_A6CF:
	ld a,(ix+034h)		;a6cf
	ld (ix+004h),a		;a6d2
	ld a,(ix+035h)		;a6d5
	ld (ix+006h),a		;a6d8
	ld a,(ix+036h)		;a6db
	ld (ix+030h),a		;a6de
	ld a,(ix+037h)		;a6e1
	ld (ix+031h),a		;a6e4
	push ix		;a6e7
	pop de			;a6e9
	ld a,034h		;a6ea
	call 0407fh		;a6ec   ; de_mas_a: DE = DE + A
	ld h,d			;a6ef
	ld a,e			;a6f0
	add a,004h		;a6f1
	ld l,a			;a6f3
	ld bc,00008h		;a6f4
	ldir		;a6f7
	ret			;a6f9
L_A6FA:
	ld hl,0e39ah		;a6fa
	inc (hl)			;a6fd
	ld a,(hl)			;a6fe
	and 003h		;a6ff
	jr z,L_A733		;a701
	ld bc,00500h		;a703
	ld hl,0a73ah		;a706
	ld a,(0e404h)		;a709
	sub (ix+004h)		;a70c
	jr c,L_A716		;a70f
	ld de,00005h		;a711
	ld c,e			;a714
	add hl,de			;a715
L_A716:
	cp (hl)			;a716
	jr c,L_A71E		;a717
	inc c			;a719
	inc hl			;a71a
	djnz L_A716		;a71b
	dec c			;a71d
L_A71E:
	ld a,c			;a71e
L_A71F:
	add a,a			;a71f
	add a,a			;a720
	add a,a			;a721
	ld hl,0a7bfh		;a722
	call 05ca6h		;a725   ; byte_a: A = el byte A de la tabla HL
	inc hl			;a728
	ld (ix+026h),h		;a729
	ld (ix+027h),l		;a72c
	ld (ix+030h),a		;a72f
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


L_A744:
	sub 0d0h		;a744
	rra			;a746
	rra			;a747
	and 03fh		;a748
	djnz L_A756		;a74a
	ld hl,0a75ch		;a74c
	call 05ca6h		;a74f   ; byte_a: A = el byte A de la tabla HL
	ld (ix+028h),a		;a752
	ret			;a755
L_A756:
	ld hl,0a761h		;a756
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


L_A766:
	ld a,(ix+025h)		;a766
	dec a			;a769
	ld hl,0a788h		;a76a
	call 05ca6h		;a76d   ; byte_a: A = el byte A de la tabla HL
	inc a			;a770
	inc a			;a771
	push ix		;a772
	pop de			;a774
	call 0407fh		;a775   ; de_mas_a: DE = DE + A
	ld h,(ix+026h)		;a778
	ld l,(ix+027h)		;a77b
	ld a,(hl)			;a77e
	ldi		;a77f
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


L_A78B:
	ld b,000h		;a78b
	call L_A744		;a78d
	ld b,a			;a790
	ld a,(ix+02ah)		;a791
	add a,(ix+028h)		;a794
	sub b			;a797
	cp 0d0h		;a798
	jr c,L_A79E		;a79a
	ld a,0e0h		;a79c
L_A79E:
	ld (ix+02ah),a		;a79e
	ld c,a			;a7a1
	push ix		;a7a2
	pop hl			;a7a4
	ld de,0a788h		;a7a5
	ld a,(ix+025h)		;a7a8
	dec a			;a7ab
	call 0407fh		;a7ac   ; de_mas_a: DE = DE + A
	ld a,(de)			;a7af
	call 0407ah		;a7b0   ; hl_mas_a: HL = HL + A
	ld (hl),c			;a7b3
	inc l			;a7b4
	ld a,(ix+029h)		;a7b5
	ld (hl),a			;a7b8
	add a,0f0h		;a7b9
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


L_A811:
	ld (ix+00dh),0ffh		;a811
	ld (ix+002h),001h		;a815
	ld (ix+00ch),000h		;a819
	ld a,(ix+00bh)		;a81d
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


L_A82E:
	ld a,(ix+006h)		;a82e
	cp (ix+00bh)		;a831
	ret nc			;a834
	dec (ix+002h)		;a835
	ret nz			;a838
	ld (ix+002h),018h		;a839
	inc (ix+00ch)		;a83d
	ld a,(ix+00ch)		;a840
	cp 004h		;a843
	jr c,L_A84B		;a845
	ld (ix+000h),000h		;a847
L_A84B:
	add a,a			;a84b
	add a,a			;a84c
	add a,a			;a84d
	add a,a			;a84e
	ld de,0a865h		;a84f
	call 0407fh		;a852   ; de_mas_a: DE = DE + A
	ld l,(ix+004h)		;a855
	ld h,(ix+006h)		;a858
	call 05c92h		;a85b   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;a85e
	exx			;a85f
	ld b,004h		;a860
L_A862:
	exx			;a862
	ld bc,00004h		;a863
	ldir		;a866
	ld a,01ch		;a868
	call 0407fh		;a86a   ; de_mas_a: DE = DE + A
	exx			;a86d
	djnz L_A862		;a86e
	ld a,025h		;a870
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


L_A8B5:
	ld ix,0ea00h		;a8b5   ; apunta a la ficha del jefe
	ld a,(0e341h)		;a8b9   ; lee el estado del jefe
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


L_A8CD:
	call L_A8F4		;a8cd
	ret nz			;a8d0
	ld a,011h		;a8d1
	ld hl,0a900h		;a8d3
	call L_A8E1		;a8d6
	call L_AA20		;a8d9
L_A8DC:
	ld hl,0e341h		;a8dc   ; apunta a el estado del jefe
	inc (hl)			;a8df
	ret			;a8e0
L_A8E1:
	ld de,0ea00h		;a8e1   ; apunta a la ficha del jefe
	ld bc,0000ah		;a8e4
	ldir		;a8e7
	ld (0ea12h),a		;a8e9   ; guarda los golpes que le quedan al nucleo de la fase 0
	ld a,0e0h		;a8ec
	ld (0ea13h),a		;a8ee
	jp 04b20h		;a8f1   ; caracteres_de_jefe: con los bancos 13-14-15, los caracteres de los jefes 1-4 (p00:556F, copias p00:559A) y los sprites de p09:BF6D
L_A8F4:
	call 04b70h		;a8f4   ; queda_alguien: A distinto de 0 si queda ocupada alguna de las 12 fichas de 0xE600 (64 bytes) o de las 10 de 0xE900 (16 bytes)
	ret nz			;a8f7
	ld hl,0e343h		;a8f8   ; apunta a dato del jefe (8 al salir)
	ld a,(hl)			;a8fb
	and a			;a8fc
	ret z			;a8fd
	dec (hl)			;a8fe
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


L_A90A:
	ld c,040h		;a90a
	call L_A915		;a90c
	call c,L_A8DC		;a90f
	jp L_AA20		;a912
L_A915:
	and a			;a915
	dec (ix+002h)		;a916
	ret nz			;a919
	ld (ix+002h),008h		;a91a
	ld a,(0ea03h)		;a91e
	sub 008h		;a921
	ld (0ea03h),a		;a923
	cp c			;a926
	ret			;a927
L_A928:
	call L_AB7B		;a928
	ld (ix+002h),001h		;a92b
	jr $-83		;a92f
L_A931:
	call L_AA3B		;a931
	call L_AA20		;a934
	ld de,00020h		;a937
	ld c,010h		;a93a
	call L_A9AD		;a93c
L_A93F:
	ld a,(0e345h)		;a93f   ; lee la marca de nucleo destruido
	and a			;a942
	ret z			;a943
	ld a,015h		;a944
	ld (0ea09h),a		;a946
	ld hl,0012ch		;a949
	ld a,(0e201h)		;a94c   ; lee la fase (0-11)
	cp 007h		;a94f
	jr nz,L_A956		;a951
	ld hl,00001h		;a953
L_A956:
	ld (0e343h),hl		;a956   ; guarda dato del jefe (8 al salir) y el byte siguiente (16 bits)
	jr $-125		;a959
L_A95B:
	ld a,(0e201h)		;a95b   ; lee la fase (0-11)
	cp 007h		;a95e
	call nz,092a4h		;a960   ; nave_entra_al_jefe: si la nave esta junto a la entrada del jefe (0xEA0E, 0xEA10), 0xE22B = 1: al interior
	ld a,(0e22bh)		;a963   ; lee la marca de jefe vencido: al interior
	and a			;a966
	jr nz,L_A979		;a967
	ld hl,(0e343h)		;a969   ; lee dato del jefe (8 al salir) y el byte siguiente (16 bits)
	dec hl			;a96c
	ld (0e343h),hl		;a96d   ; guarda dato del jefe (8 al salir) y el byte siguiente (16 bits)
	ld a,h			;a970
	or l			;a971
	ret nz			;a972
	call L_A9C8		;a973
	jp L_A8DC		;a976
L_A979:
	ld a,01eh		;a979
	ld (0e343h),a		;a97b   ; guarda dato del jefe (8 al salir)
	ld hl,00001h		;a97e
	ld (0e3aah),hl		;a981   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo y el byte siguiente (16 bits)
	xor a			;a984
	ld (0e400h),a		;a985   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ld hl,0e341h		;a988   ; apunta a el estado del jefe
	inc (hl)			;a98b
	inc (hl)			;a98c
	ret			;a98d
L_A98E:
	ld hl,0e343h		;a98e   ; apunta a dato del jefe (8 al salir)
	dec (hl)			;a991
	ret nz			;a992
L_A993:
	xor a			;a993
	ld (0e340h),a		;a994   ; guarda el tipo de jefe (1-5; 0 sin jefe)
	ld (0e34fh),a		;a997   ; guarda la marca de jefe o suceso acabado
	inc a			;a99a
	ld (0e342h),a		;a99b   ; guarda la marca de jefe vencido
	ret			;a99e
L_A99F:
	call L_A2A2		;a99f
	ld a,(0e3aeh)		;a9a2   ; lee la marca de fin de p11:A2A2
	and a			;a9a5
	ret z			;a9a6
	xor a			;a9a7
	ld (0e3aah),a		;a9a8   ; guarda la marca de 0xE3AA: sin enemigos ni su dibujo
	jr L_A993		;a9ab
L_A9AD:
	ld l,(ix+003h)		;a9ad
	ld h,(ix+004h)		;a9b0
	add hl,de			;a9b3
	ld a,h			;a9b4
	and a			;a9b5
	jr nz,L_A9C3		;a9b6
	ld (ix+013h),l		;a9b8
	ld a,(ix+005h)		;a9bb
	add a,c			;a9be
	ld (ix+014h),a		;a9bf
	ret			;a9c2
L_A9C3:
	ld (ix+013h),0e0h		;a9c3
	ret			;a9c7
L_A9C8:
	ld a,(ix+000h)		;a9c8
	ld b,a			;a9cb
	xor a			;a9cc
	ld (ix+000h),a		;a9cd
	ld a,05ah		;a9d0
	ld (0e343h),a		;a9d2   ; guarda dato del jefe (8 al salir)
	ld l,(ix+00eh)		;a9d5
	ld h,(ix+00fh)		;a9d8
	ld a,h			;a9db
	and a			;a9dc
	ret nz			;a9dd
	ld e,l			;a9de
	push bc			;a9df
	ld a,(ix+010h)		;a9e0
	ld d,a			;a9e3
	call 08ba1h		;a9e4   ; crea_explosion: una explosion de 4x4 caracteres en D (X), E (Y), si esta en pantalla y hay hueco en 0xEA40
	pop af			;a9e7
	cp 005h		;a9e8
	ld a,009h		;a9ea
	jr z,L_A9F0		;a9ec
	ld a,03bh		;a9ee
L_A9F0:
	jp 04ae4h		;a9f0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_A9F3:
	ld l,(ix+003h)		;a9f3
	ld h,(ix+004h)		;a9f6
	ld d,000h		;a9f9
	ld e,a			;a9fb
	add hl,de			;a9fc
	ld (ix+00ah),l		;a9fd
	ld (ix+00bh),h		;aa00
	ld (ix+00eh),l		;aa03
	ld (ix+00fh),h		;aa06
	ld l,(ix+005h)		;aa09
	ld h,(ix+006h)		;aa0c
	ld e,b			;aa0f
	add hl,de			;aa10
	ld (ix+00ch),l		;aa11
	ld (ix+00dh),h		;aa14
	ld e,c			;aa17
	add hl,de			;aa18
	ld (ix+010h),l		;aa19
	ld (ix+011h),h		;aa1c
	ret			;aa1f
L_AA20:
	ld a,020h		;aa20
	ld bc,01028h		;aa22
	call L_A9F3		;aa25
	ld bc,00200h		;aa28
L_AA2B:
	ld a,(ix+012h)		;aa2b
L_AA2E:
	sub b			;aa2e
	jr c,L_AA37		;aa2f
	jp m,L_AA37		;aa31
	inc c			;aa34
	jr L_AA2E		;aa35
L_AA37:
	ld (ix+008h),c		;aa37
	ret			;aa3a
L_AA3B:
	ld a,(0e20ah)		;aa3b   ; lee la vuelta (bit 0: las fases bajan)
	and a			;aa3e
	jr z,L_AA44		;aa3f
	call L_AA59		;aa41
L_AA44:
	ld a,(ix+001h)		;aa44
	dec a			;aa47
	jr z,L_AA78		;aa48
	dec a			;aa4a
	jp z,L_AA68		;aa4b
	dec (ix+002h)		;aa4e
	ret nz			;aa51
	call L_AA8A		;aa52
	inc (ix+001h)		;aa55
	ret			;aa58
L_AA59:
	call L_AA68		;aa59
	ret nz			;aa5c
	ld a,(0e228h)		;aa5d   ; lee el nivel de dificultad
	neg		;aa60
	add a,038h		;aa62
	ld (ix+018h),a		;aa64
	ret			;aa67
L_AA68:
	dec (ix+018h)		;aa68
	ret nz			;aa6b
	call L_AB7B		;aa6c
L_AA6F:
	ld (ix+002h),008h		;aa6f
	xor a			;aa73
	ld (ix+001h),a		;aa74
	ret			;aa77
L_AA78:
	call L_AAFD		;aa78
	ret nc			;aa7b
	ld a,(0e20ah)		;aa7c   ; lee la vuelta (bit 0: las fases bajan)
	and a			;aa7f
	jr nz,L_AA6F		;aa80
	ld (ix+018h),004h		;aa82
	inc (ix+001h)		;aa86
	ret			;aa89
L_AA8A:
	ld a,r		;aa8a
	and 00fh		;aa8c
	cp 00ch		;aa8e
	jr nc,L_AAEC		;aa90
L_AA92:
	ld a,(ix+004h)		;aa92
	and a			;aa95
	jr z,L_AAA0		;aa96
	ld a,002h		;aa98
	jp m,L_AACB		;aa9a
	dec a			;aa9d
	jr L_AACB		;aa9e
L_AAA0:
	ld a,(0e406h)		;aaa0
	cp 080h		;aaa3
	jr c,L_AAB0		;aaa5
	ld a,(ix+005h)		;aaa7
	cp 060h		;aaaa
	ld a,004h		;aaac
	jr c,L_AACB		;aaae
L_AAB0:
	ld a,(0e340h)		;aab0   ; lee el tipo de jefe (1-5; 0 sin jefe)
	dec a			;aab3
	ld hl,0aaf9h		;aab4
	call 0407ah		;aab7   ; hl_mas_a: HL = HL + A
	ld c,(hl)			;aaba
	ld a,(ix+003h)		;aabb
	add a,c			;aabe
	jr c,L_AAC9		;aabf
	ld hl,0e404h		;aac1
	cp (hl)			;aac4
	ld a,002h		;aac5
	jr c,L_AACB		;aac7
L_AAC9:
	ld a,001h		;aac9
L_AACB:
	ld (ix+015h),a		;aacb
	ld (ix+002h),0ffh		;aace
	cp 003h		;aad2
	ld c,008h		;aad4
	jr c,L_AADA		;aad6
	ld c,00ah		;aad8
L_AADA:
	ld a,r		;aada
	and 003h		;aadc
	add a,c			;aade
	ld (ix+016h),a		;aadf
	ld a,(0e228h)		;aae2   ; lee el nivel de dificultad
	add a,a			;aae5
	add a,040h		;aae6
	ld (ix+017h),a		;aae8
	ret			;aaeb
L_AAEC:
	ld a,(0e406h)		;aaec
	cp (ix+005h)		;aaef
	ld a,003h		;aaf2
	jr c,L_AACB		;aaf4
	inc a			;aaf6
	jr L_AACB		;aaf7

; ----------------------------------------------------------------------
; DATOS tabla_AAF9: 4 bytes que p11:AAB0 lee con 0xE340 - 1; lo leen p11:AAB7
;   (4 bytes)
;   0xaaf9..0xaafd  (4 bytes)
DATA_tabla_AAF9:
	defb 028h,030h,040h,040h	; aaf9

; ======================================================================
; CODIGO 0xaafd..0xabba  (189 bytes)
; ======================================================================


L_AAFD:
	ld a,(ix+017h)		;aafd
	add a,(ix+002h)		;ab00
	ld (ix+002h),a		;ab03
	ret nc			;ab06
	dec (ix+016h)		;ab07
	jr z,L_AB79		;ab0a
	ld (ix+002h),a		;ab0c
	ld a,(ix+015h)		;ab0f
	and a			;ab12
	ret z			;ab13
	dec a			;ab14
	jr z,L_AB55		;ab15
	dec a			;ab17
	jr z,L_AB36		;ab18
	dec a			;ab1a
	jr z,L_AB2B		;ab1b
	ld a,(ix+005h)		;ab1d
	add a,008h		;ab20
	cp 0b0h		;ab22
	jr nc,L_AB79		;ab24
L_AB26:
	ld (ix+005h),a		;ab26
	and a			;ab29
	ret			;ab2a
L_AB2B:
	ld a,(ix+005h)		;ab2b
	sub 008h		;ab2e
	cp 019h		;ab30
	jr c,L_AB79		;ab32
	jr L_AB26		;ab34
L_AB36:
	ld hl,(0ea03h)		;ab36
	ld de,00008h		;ab39
	add hl,de			;ab3c
	ld a,h			;ab3d
	and a			;ab3e
	jr nz,L_AB50		;ab3f
	ld de,00080h		;ab41
	cp 002h		;ab44
	jr nz,L_AB4A		;ab46
	ld e,068h		;ab48
L_AB4A:
	ld a,(0e340h)		;ab4a   ; lee el tipo de jefe (1-5; 0 sin jefe)
	rst 20h			;ab4d
	jr nc,L_AB70		;ab4e
L_AB50:
	ld (0ea03h),hl		;ab50
	and a			;ab53
	ret			;ab54
L_AB55:
	ld hl,(0ea03h)		;ab55
	ld de,0fff8h		;ab58
	add hl,de			;ab5b
	ld (0ea03h),hl		;ab5c
	ld a,h			;ab5f
	and a			;ab60
	ret p			;ab61
	ld a,(0e340h)		;ab62   ; lee el tipo de jefe (1-5; 0 sin jefe)
	cp 003h		;ab65
	ld c,0f0h		;ab67
	jr nz,L_AB6D		;ab69
	ld c,0c0h		;ab6b
L_AB6D:
	ld a,l			;ab6d
	cp c			;ab6e
	ret nc			;ab6f
L_AB70:
	ld a,(ix+015h)		;ab70
	xor 003h		;ab73
	ld (ix+015h),a		;ab75
	ret			;ab78
L_AB79:
	scf			;ab79
	ret			;ab7a
L_AB7B:
	ld de,0abbah		;ab7b
	ld b,006h		;ab7e
L_AB80:
	push bc			;ab80
	push de			;ab81
	ld l,(ix+003h)		;ab82
	ld h,(ix+004h)		;ab85
	ld a,(de)			;ab88
	ld c,a			;ab89
	inc de			;ab8a
	ld a,(de)			;ab8b
	ld b,a			;ab8c
	add hl,bc			;ab8d
	ld a,h			;ab8e
	and a			;ab8f
	jr nz,L_ABAD		;ab90
	ld a,l			;ab92
	cp 0b0h		;ab93
	jr nc,L_ABAD		;ab95
	ex de,hl			;ab97
	ld a,(ix+005h)		;ab98
	inc hl			;ab9b
	add a,(hl)			;ab9c
	ld d,a			;ab9d
	cp 0e0h		;ab9e
	jr nc,L_ABAD		;aba0
	inc hl			;aba2
	ld b,(hl)			;aba3
	and 07fh		;aba4
	ld c,000h		;aba6
	ld a,023h		;aba8
	call 04d16h		;abaa   ; crea_enemigo_ix: crea_enemigo conservando IX
L_ABAD:
	pop de			;abad
	pop bc			;abae
	inc de			;abaf
	inc de			;abb0
	inc de			;abb1
	inc de			;abb2
	djnz L_AB80		;abb3
	ld a,016h		;abb5
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


L_ABD2:
	call L_ABF4		;abd2
	call 05cb5h		;abd5   ; menos_hl: HL = - HL
	ld de,00000h		;abd8
	ex de,hl			;abdb
	call 04f26h		;abdc   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
	ld (ix+013h),001h		;abdf
	ld (ix+014h),002h		;abe3
	ld (ix+010h),005h		;abe7
	ld a,(ix+019h)		;abeb
	add a,072h		;abee
	ld (ix+032h),a		;abf0
	ret			;abf3
L_ABF4:
	ld a,(0e228h)		;abf4   ; lee el nivel de dificultad
	ld l,a			;abf7
	ld h,000h		;abf8
	add hl,hl			;abfa
	add hl,hl			;abfb
	add hl,hl			;abfc
	add hl,hl			;abfd
	add hl,hl			;abfe
	ld de,00700h		;abff
	add hl,de			;ac02
	ld de,00900h		;ac03
	rst 20h			;ac06
	ret c			;ac07
	ld hl,006ffh		;ac08
	ret			;ac0b
L_AC0C:
	call 04f09h		;ac0c   ; lee_vx: DE = IX+09/IX+0A
	ld l,(ix+005h)		;ac0f
	ld h,(ix+006h)		;ac12
	add hl,de			;ac15
	ld a,h			;ac16
	cp 0f0h		;ac17
	ret c			;ac19
	jp 06514h		;ac1a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_AC1D:
	ld ix,0ea00h		;ac1d   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ac21   ; lee el estado del jefe
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


L_AC35:
	call L_A8F4		;ac35
	ret nz			;ac38
	ld hl,0ac49h		;ac39
	ld a,022h		;ac3c
	call L_A8E1		;ac3e
	call L_AC88		;ac41
L_AC44:
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


L_AC53:
	ld c,040h		;ac53
	call L_A915		;ac55
	call c,L_AC44		;ac58
	jp L_AC88		;ac5b
L_AC5E:
	call L_AD0F		;ac5e
	ld (ix+002h),001h		;ac61
	ld (ix+018h),040h		;ac65
	ld (ix+01ah),020h		;ac69
	ld (ix+01bh),000h		;ac6d
	ld (ix+001h),002h		;ac71
	jr $-49		;ac75
L_AC77:
	call L_AC96		;ac77
	call L_AC88		;ac7a
	ld de,00028h		;ac7d
	ld c,028h		;ac80
	call L_A9AD		;ac82
	jp L_A93F		;ac85
L_AC88:
	ld a,028h		;ac88
	ld bc,03020h		;ac8a
	call L_A9F3		;ac8d
	ld bc,00509h		;ac90
	jp L_AA2B		;ac93
L_AC96:
	call L_ACE4		;ac96
	ld a,(ix+001h)		;ac99
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


L_ACA9:
	inc (ix+001h)		;aca9
	jp L_AA92		;acac
L_ACAF:
	call L_AAFD		;acaf
	ret nc			;acb2
	dec (ix+001h)		;acb3
	ld (ix+002h),004h		;acb6
	ret			;acba
L_ACBB:
	dec (ix+01ah)		;acbb
	ret nz			;acbe
L_ACBF:
	inc (ix+001h)		;acbf
	ret			;acc2
L_ACC3:
	ld a,(ix+005h)		;acc3
	cp 008h		;acc6
	jr z,L_ACBF		;acc8
	add a,0f8h		;acca
	ld (ix+005h),a		;accc
	ret			;accf
L_ACD0:
	ld a,(ix+005h)		;acd0
	cp 080h		;acd3
	jr z,L_ACDD		;acd5
	add a,008h		;acd7
	ld (ix+005h),a		;acd9
	ret			;acdc
L_ACDD:
	ld a,(ix+01bh)		;acdd
	ld (ix+001h),a		;ace0
	ret			;ace3
L_ACE4:
	ld a,(ix+001h)		;ace4
	cp 003h		;ace7
	ret nc			;ace9
	dec (ix+018h)		;acea
	ret nz			;aced
	ld a,(ix+001h)		;acee
	ld (ix+01bh),a		;acf1
	ld (ix+001h),002h		;acf4
	ld (ix+01ah),020h		;acf8
	ld a,r		;acfc
	and 003h		;acfe
	ld a,020h		;ad00
	jr z,L_AD0C		;ad02
	ld a,(0e228h)		;ad04   ; lee el nivel de dificultad
	add a,a			;ad07
	sub 040h		;ad08
	neg		;ad0a
L_AD0C:
	ld (ix+018h),a		;ad0c
L_AD0F:
	ld bc,00210h		;ad0f
L_AD12:
	push bc			;ad12
	ld d,(ix+005h)		;ad13
	ld a,(ix+003h)		;ad16
	add a,c			;ad19
	ld e,a			;ad1a
	ld bc,00000h		;ad1b
	ld a,038h		;ad1e
	call 04d16h		;ad20   ; crea_enemigo_ix: crea_enemigo conservando IX
	pop bc			;ad23
	ld c,040h		;ad24
	djnz L_AD12		;ad26
	ret			;ad28
L_AD29:
	ld ix,0ea00h		;ad29   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ad2d   ; lee el estado del jefe
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


L_AD41:
	call L_A8F4		;ad41
	ret nz			;ad44
	ld a,01ah		;ad45
	ld hl,0ad53h		;ad47
	call L_A8E1		;ad4a
	call L_AD88		;ad4d
	jp L_A8DC		;ad50

; ----------------------------------------------------------------------
; DATOS objeto_AD53: 10 bytes que p11:AD47 pasa a L_A8E1 (con A = 0x1A); lo
;   leen p11:AD4A (10 bytes)
;   0xad53..0xad5d  (10 bytes)
DATA_objeto_AD53:
	defb 004h,000h,008h,0c0h,000h,0a0h,000h,013h,000h,014h	; ad53  ..........

; ======================================================================
; CODIGO 0xad5d..0xae21  (196 bytes)
; ======================================================================


L_AD5D:
	ld c,018h		;ad5d
	call L_A915		;ad5f
	call c,L_A8DC		;ad62
	jp L_AD88		;ad65
L_AD68:
	ld hl,00001h		;ad68
	ld (0ea18h),hl		;ad6b
	ld (ix+002h),l		;ad6e
	ld (ix+01ch),l		;ad71
	jp L_A8DC		;ad74
L_AD77:
	call L_AD96		;ad77
	call L_AD88		;ad7a
	ld de,00038h		;ad7d
	ld c,018h		;ad80
	call L_A9AD		;ad82
	jp L_A93F		;ad85
L_AD88:
	ld a,038h		;ad88
	ld bc,01820h		;ad8a
	call L_A9F3		;ad8d
	ld bc,00300h		;ad90
	jp L_AA2B		;ad93
L_AD96:
	ld a,(ix+001h)		;ad96
	dec a			;ad99
	jr z,L_ADA7		;ad9a
	dec (ix+002h)		;ad9c
	jr nz,L_ADB3		;ad9f
	inc (ix+001h)		;ada1
	jp L_AA92		;ada4
L_ADA7:
	call L_AAFD		;ada7
	jr nc,L_ADB3		;adaa
	ld hl,01000h		;adac
	ld (0ea01h),hl		;adaf
	ret			;adb2
L_ADB3:
	ld a,(ix+019h)		;adb3
	or a			;adb6
	jr nz,L_ADCD		;adb7
	dec (ix+018h)		;adb9
	ret nz			;adbc
	ld hl,00618h		;adbd
	ld a,(0e20ah)		;adc0   ; lee la vuelta (bit 0: las fases bajan)
	rra			;adc3
	jr nc,L_ADC9		;adc4
	ld hl,00c0ch		;adc6
L_ADC9:
	ld (0ea18h),hl		;adc9
	ret			;adcc
L_ADCD:
	dec (ix+018h)		;adcd
	ret nz			;add0
	ld a,(0e201h)		;add1   ; lee la fase (0-11)
	cp 002h		;add4
	ld b,018h		;add6
	jr z,L_ADDC		;add8
	ld b,00ch		;adda
L_ADDC:
	ld (ix+018h),b		;addc
	dec (ix+019h)		;addf
	jr nz,L_ADE8		;ade2
	ld (ix+018h),03ch		;ade4
L_ADE8:
	ld b,004h		;ade8
L_ADEA:
	push bc			;adea
	ld a,b			;adeb
	ld hl,0ae1fh		;adec
	call 04b67h		;adef   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(0ea03h)		;adf2
	add a,e			;adf5
	cp 0b0h		;adf6
	jr nc,L_AE19		;adf8
	ld e,a			;adfa
	inc hl			;adfb
	ld a,(0ea05h)		;adfc
	add a,d			;adff
	ld d,a			;ae00
	ld c,b			;ae01
	ld b,00ch		;ae02
	ld a,(0e201h)		;ae04   ; lee la fase (0-11)
	cp 002h		;ae07
	jr z,L_AE0D		;ae09
	ld b,006h		;ae0b
L_AE0D:
	ld a,(0e20ah)		;ae0d   ; lee la vuelta (bit 0: las fases bajan)
	rra			;ae10
	ld a,039h		;ae11
	jr nc,L_AE16		;ae13
	inc a			;ae15
L_AE16:
	call 04d16h		;ae16   ; crea_enemigo_ix: crea_enemigo conservando IX
L_AE19:
	pop bc			;ae19
	djnz L_ADEA		;ae1a
	ld a,019h		;ae1c
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


L_AE29:
	ld ix,0ea00h		;ae29   ; apunta a la ficha del jefe
	ld a,(0e341h)		;ae2d   ; lee el estado del jefe
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


L_AE41:
	call L_A8F4		;ae41
	ret nz			;ae44
	call 04b20h		;ae45   ; caracteres_de_jefe: con los bancos 13-14-15, los caracteres de los jefes 1-4 (p00:556F, copias p00:559A) y los sprites de p09:BF6D
	ld hl,0ae58h		;ae48
	ld a,037h		;ae4b
	call L_A8E1		;ae4d
	call L_AE88		;ae50
L_AE53:
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


L_AE62:
	ld c,020h		;ae62
	call L_A915		;ae64
	call c,L_AE53		;ae67
	jp L_AE88		;ae6a
L_AE6D:
	ld (ix+002h),001h		;ae6d
	ld (ix+018h),001h		;ae71
	jr $-34		;ae75
L_AE77:
	call L_AE96		;ae77
	call L_AE88		;ae7a
	ld de,00038h		;ae7d
	ld c,018h		;ae80
	call L_A9AD		;ae82
	jp L_A93F		;ae85
L_AE88:
	ld a,038h		;ae88
	ld bc,01818h		;ae8a
	call L_A9F3		;ae8d
	ld bc,00809h		;ae90
	jp L_AA2B		;ae93
L_AE96:
	call L_AEAA		;ae96
	ld a,(ix+001h)		;ae99
	dec a			;ae9c
	jr z,L_AED3		;ae9d
	dec (ix+002h)		;ae9f
	ret nz			;aea2
	call L_AEFF		;aea3
	inc (ix+001h)		;aea6
	ret			;aea9
L_AEAA:
	dec (ix+018h)		;aeaa
	ret nz			;aead
	ld (ix+018h),028h		;aeae
	ld hl,(0ea03h)		;aeb2
	ld de,00030h		;aeb5
	add hl,de			;aeb8
	ld a,h			;aeb9
	and a			;aeba
	ret nz			;aebb
	ld a,l			;aebc
	cp 0b0h		;aebd
	ret nc			;aebf
	ld e,a			;aec0
	ld a,(ix+005h)		;aec1
	sub 008h		;aec4
	ld d,a			;aec6
	ld c,000h		;aec7
	ld a,024h		;aec9
	call 04d16h		;aecb   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,018h		;aece
	jp 04ae4h		;aed0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_AED3:
	call L_AAFD		;aed3
	jr c,L_AEDF		;aed6
	call L_AEE7		;aed8
	jp c,L_AB70		;aedb
	ret			;aede
L_AEDF:
	ld (ix+002h),010h		;aedf
	dec (ix+001h)		;aee3
	ret			;aee6
L_AEE7:
	ld hl,(0ea03h)		;aee7
	bit 0,(ix+015h)		;aeea
	jr nz,L_AEF8		;aeee
	ld a,h			;aef0
	and a			;aef1
	ret m			;aef2
	ld a,l			;aef3
	cp 060h		;aef4
	ccf			;aef6
	ret			;aef7
L_AEF8:
	ld a,h			;aef8
	and a			;aef9
	ret z			;aefa
	ld a,l			;aefb
	cp 0d8h		;aefc
	ret			;aefe
L_AEFF:
	ld a,(ix+004h)		;aeff
	and a			;af02
	jr z,L_AF0E		;af03
	ld a,002h		;af05
	jp m,L_AACB		;af07
	dec a			;af0a
	jp L_AACB		;af0b
L_AF0E:
	ld a,(ix+003h)		;af0e
	add a,020h		;af11
	ld hl,0e404h		;af13
	cp (hl)			;af16
	ld a,002h		;af17
	jp c,L_AACB		;af19
	dec a			;af1c
	jp L_AACB		;af1d
L_AF20:
	xor a			;af20
	ld (ix+013h),004h		;af21
	ld (ix+014h),001h		;af25
	ld (ix+010h),001h		;af29
	ld a,(ix+019h)		;af2d
	add a,000h		;af30
	ld (ix+032h),a		;af32
	ret			;af35
L_AF36:
	ld a,(0e345h)		;af36   ; lee la marca de nucleo destruido
	and a			;af39
	jp nz,06514h		;af3a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld hl,(0ea03h)		;af3d
	ld de,00030h		;af40
	add hl,de			;af43
	ld (ix+004h),l		;af44
	ld a,(ix+001h)		;af47
	dec a			;af4a
	jr z,L_AF6B		;af4b
	ld a,(ix+00fh)		;af4d
	add a,008h		;af50
	ld (ix+00fh),a		;af52
	inc (ix+014h)		;af55
	ld a,(ix+006h)		;af58
	sub 008h		;af5b
	and 0f8h		;af5d
	ld (ix+006h),a		;af5f
	ret nz			;af62
	ld (ix+002h),010h		;af63
	inc (ix+001h)		;af67
	ret			;af6a
L_AF6B:
	dec (ix+002h)		;af6b
	ret nz			;af6e
	jp 06514h		;af6f   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_AF72:
	ld a,(0e341h)		;af72   ; lee el estado del jefe
	call 04084h		;af75   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_AF78: 3 destinos del despachador p00:4084 (call en p11:AF75, el
;   indice en A): AF7E, AF94, AFAE; lo leen p11:AF75 (6 bytes)
;   0xaf78..0xaf7e  (6 bytes)
DATA_tabla_AF78:
	defw 0af7eh,0af94h,0afaeh	; af78  -> L_AF7E L_AF94 L_AFAE

; ======================================================================
; CODIGO 0xaf7e..0xaffe  (128 bytes)
; ======================================================================


L_AF7E:
	call 04b70h		;af7e   ; queda_alguien: A distinto de 0 si queda ocupada alguna de las 12 fichas de 0xE600 (64 bytes) o de las 10 de 0xE900 (16 bytes)
	ret nz			;af81
	call 04c84h		;af82   ; caracteres_del_jefe_5: con los bancos 13-14-15, los caracteres del jefe 5 (p15:B3AF, copias p15:B3BC) y el banco 11
	ld a,00ah		;af85
	ld (0e3d6h),a		;af87
	ld a,001h		;af8a
	ld (0e343h),a		;af8c   ; guarda dato del jefe (8 al salir)
L_AF8F:
	ld hl,0e341h		;af8f   ; apunta a el estado del jefe
	inc (hl)			;af92
	ret			;af93
L_AF94:
	call L_AFBC		;af94
	call L_B008		;af97
	ld a,(0e3d6h)		;af9a
	and a			;af9d
	ret nz			;af9e
	ld a,(0ea00h)		;af9f   ; lee la ficha del jefe
	ld hl,0ea20h		;afa2   ; apunta a la segunda ficha del jefe (el 5)
	or (hl)			;afa5
	ret nz			;afa6
	ld a,01eh		;afa7
	ld (0e343h),a		;afa9   ; guarda dato del jefe (8 al salir)
	jr L_AF8F		;afac
L_AFAE:
	ld hl,0e343h		;afae   ; apunta a dato del jefe (8 al salir)
	dec (hl)			;afb1
	ret nz			;afb2
	xor a			;afb3
	ld (0e340h),a		;afb4   ; guarda el tipo de jefe (1-5; 0 sin jefe)
	inc a			;afb7
	ld (0e342h),a		;afb8   ; guarda la marca de jefe vencido
	ret			;afbb
L_AFBC:
	ld hl,0e343h		;afbc   ; apunta a dato del jefe (8 al salir)
	dec (hl)			;afbf
	ret nz			;afc0
	ld (hl),090h		;afc1
	ld de,0ea00h		;afc3   ; apunta a la ficha del jefe
	ld a,(de)			;afc6
	and a			;afc7
	jr z,L_AFCF		;afc8
	ld e,020h		;afca
	ld a,(de)			;afcc
	and a			;afcd
	ret nz			;afce
L_AFCF:
	ld hl,0e3d6h		;afcf
	ld a,(hl)			;afd2
	and a			;afd3
	ret z			;afd4
	dec (hl)			;afd5
	push de			;afd6
	pop ix		;afd7
	ld hl,0affeh		;afd9
	ld bc,0000ah		;afdc
	ldir		;afdf
	ld a,(0e3d6h)		;afe1
	rra			;afe4
	ld a,020h		;afe5
	jr nc,L_AFEB		;afe7
	ld a,068h		;afe9
L_AFEB:
	ld (ix+003h),a		;afeb
	ld a,017h		;afee
	ld (ix+012h),a		;aff0
	ld (ix+016h),00ah		;aff3
	ld (ix+01fh),000h		;aff7
	jp L_B0E3		;affb

; ----------------------------------------------------------------------
; DATOS objeto_AFFE: 10 bytes que p11:AFD9 copia a IX (ldir); lo leen p11:AFDF
;   (10 bytes)
;   0xaffe..0xb008  (10 bytes)
DATA_objeto_AFFE:
	defb 005h,000h,004h,050h,000h,0f8h,000h,016h,017h,01eh	; affe  ...P......

; ======================================================================
; CODIGO 0xb008..0xb034  (44 bytes)
; ======================================================================


L_B008:
	ld ix,0ea00h		;b008   ; apunta a la ficha del jefe
	call L_B013		;b00c
	ld ix,0ea20h		;b00f   ; apunta a la segunda ficha del jefe (el 5)
L_B013:
	ld a,(ix+000h)		;b013
	and a			;b016
	ret z			;b017
	call L_B02E		;b018
	ld de,00018h		;b01b
	ld c,000h		;b01e
	call L_A9AD		;b020
	call L_B0E3		;b023
	ld a,(ix+01fh)		;b026
	and a			;b029
	ret z			;b02a
	jp L_B0D5		;b02b
L_B02E:
	ld a,(ix+001h)		;b02e
	call 04084h		;b031   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_B034: 3 destinos del despachador p00:4084 (call en p11:B031, el
;   indice en A): B03A, B088, B099; lo leen p11:B031 (6 bytes)
;   0xb034..0xb03a  (6 bytes)
DATA_tabla_B034:
	defw 0b03ah,0b088h,0b099h	; b034  -> L_B03A L_B088 L_B099

; ======================================================================
; CODIGO 0xb03a..0xb080  (70 bytes)
; ======================================================================


L_B03A:
	dec (ix+002h)		;b03a
	ret nz			;b03d
	call L_B070		;b03e
	ld a,(ix+005h)		;b041
	sub 008h		;b044
	ld (ix+005h),a		;b046
	cp 010h		;b049
	jr c,L_B059		;b04b
	dec (ix+016h)		;b04d
	ret nz			;b050
	ld (ix+016h),00ah		;b051
	inc (ix+001h)		;b055
	ret			;b058
L_B059:
	ld c,001h		;b059
	ld a,(0e404h)		;b05b
	sub 018h		;b05e
	jr c,L_B068		;b060
	cp (ix+003h)		;b062
	jr c,L_B068		;b065
	dec c			;b067
L_B068:
	ld (ix+017h),c		;b068
	ld (ix+001h),002h		;b06b
	ret			;b06f
L_B070:
	ld a,(0e228h)		;b070   ; lee el nivel de dificultad
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


L_B088:
	dec (ix+016h)		;b088
	ret nz			;b08b
	call L_B0F1		;b08c
	ld (ix+016h),008h		;b08f
	ld (ix+001h),000h		;b093
	jr $-39		;b097
L_B099:
	dec (ix+002h)		;b099
	ret nz			;b09c
	call L_B070		;b09d
	ld l,(ix+003h)		;b0a0
	ld h,(ix+004h)		;b0a3
	ld de,00008h		;b0a6
	bit 0,(ix+017h)		;b0a9
	jr z,L_B0B2		;b0ad
	ld de,0fff8h		;b0af
L_B0B2:
	add hl,de			;b0b2
	ld (ix+003h),l		;b0b3
	ld (ix+004h),h		;b0b6
	ld a,h			;b0b9
	and a			;b0ba
	ld a,l			;b0bb
	jr z,L_B0C8		;b0bc
	bit 0,(ix+017h)		;b0be
	ret z			;b0c2
	cp 0c0h		;b0c3
	jr c,L_B0D0		;b0c5
	ret			;b0c7
L_B0C8:
	bit 0,(ix+017h)		;b0c8
	ret nz			;b0cc
	cp 0c0h		;b0cd
	ret c			;b0cf
L_B0D0:
	ld (ix+000h),000h		;b0d0
	ret			;b0d4
L_B0D5:
	ld a,(ix+000h)		;b0d5
	and a			;b0d8
	ret z			;b0d9
	ld de,00030h		;b0da
	call 05b04h		;b0dd   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	jp L_A9C8		;b0e0
L_B0E3:
	ld a,018h		;b0e3
	ld bc,01018h		;b0e5
	call L_A9F3		;b0e8
	ld bc,00417h		;b0eb
	jp L_AA2B		;b0ee
L_B0F1:
	ld de,0b0f9h		;b0f1
	ld b,004h		;b0f4
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


L_B109:
	ld a,(0e201h)		;b109   ; lee la fase (0-11)
	dec a			;b10c
	ret nz			;b10d
L_B10E:
	call L_B124		;b10e
	jr z,L_B124		;b111
	ret c			;b113
	ld hl,0e377h		;b114
	inc (hl)			;b117
	jr L_B10E		;b118
L_B11A:
	ld a,(0e320h)		;b11a   ; lee la marca de scroll hecho en este cuadro
	and a			;b11d
	ret z			;b11e
	ld a,0f8h		;b11f
	ld (0f004h),a		;b121   ; guarda variable de paso
L_B124:
	ld hl,0b179h		;b124
	ld a,(0e377h)		;b127
	ld c,a			;b12a
	add a,a			;b12b
	add a,c			;b12c
	call 0407ah		;b12d   ; hl_mas_a: HL = HL + A
	ld e,(hl)			;b130
	inc hl			;b131
	ld d,(hl)			;b132
	inc hl			;b133
	ld b,(hl)			;b134
	ld a,d			;b135
	and 0c0h		;b136
	or 001h		;b138
	ld c,a			;b13a
	ld a,d			;b13b
	and 03fh		;b13c
	ld d,a			;b13e
	ld hl,(0e203h)		;b13f   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	rst 20h			;b142
	ret nz			;b143
	ld hl,0e377h		;b144
	inc (hl)			;b147
	call L_B14D		;b148
	xor a			;b14b
	ret			;b14c
L_B14D:
	ld e,b			;b14d
	ld hl,0ea20h		;b14e   ; apunta a la segunda ficha del jefe (el 5)
	ld b,004h		;b151
L_B153:
	ld a,(hl)			;b153
	and a			;b154
	jr z,L_B161		;b155
	ld a,008h		;b157
	add a,l			;b159
	ld l,a			;b15a
	jr nc,L_B15E		;b15b
	inc h			;b15d
L_B15E:
	djnz L_B153		;b15e
	ret			;b160
L_B161:
	ld (hl),c			;b161
	inc l			;b162
	ld (hl),008h		;b163
	inc l			;b165
	ld (hl),000h		;b166
	inc l			;b168
	ld a,(0f004h)		;b169   ; lee variable de paso
	ld (hl),a			;b16c
	inc l			;b16d
	ld (hl),e			;b16e
	inc l			;b16f
	ld (hl),000h		;b170
	inc l			;b172
	ld (hl),010h		;b173
	inc l			;b175
	ld (hl),005h		;b176
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


L_B193:
	ld ix,0ea20h		;b193   ; apunta a la segunda ficha del jefe (el 5)
	ld b,004h		;b197
L_B199:
	push bc			;b199
	ld a,(ix+000h)		;b19a
	and a			;b19d
	call nz,L_B1AA		;b19e
	pop bc			;b1a1
	ld de,00008h		;b1a2
	add ix,de		;b1a5
	djnz L_B199		;b1a7
	ret			;b1a9
L_B1AA:
	call L_B1B6		;b1aa
	call L_B1D8		;b1ad
	call L_B202		;b1b0
	jp L_B221		;b1b3
L_B1B6:
	ld a,(0e320h)		;b1b6   ; lee la marca de scroll hecho en este cuadro
	and a			;b1b9
	ret z			;b1ba
	ld a,(ix+003h)		;b1bb
	sub 008h		;b1be
	ld (ix+003h),a		;b1c0
	ret nc			;b1c3
	ld (ix+003h),000h		;b1c4
	inc (ix+000h)		;b1c8
	ld a,(ix+000h)		;b1cb
	and 03fh		;b1ce
	cp 005h		;b1d0
	ret c			;b1d2
	ld (ix+000h),000h		;b1d3
	ret			;b1d7
L_B1D8:
	bit 6,(ix+000h)		;b1d8
	ret nz			;b1dc
	dec (ix+001h)		;b1dd
	ret nz			;b1e0
	ld (ix+001h),008h		;b1e1
	bit 7,(ix+000h)		;b1e5
	jr z,L_B1F4		;b1e9
	dec (ix+004h)		;b1eb
	ret p			;b1ee
	ld (ix+004h),00dh		;b1ef
	ret			;b1f3
L_B1F4:
	inc (ix+004h)		;b1f4
	ld a,(ix+004h)		;b1f7
	cp 00eh		;b1fa
	ret c			;b1fc
	ld (ix+004h),000h		;b1fd
	ret			;b201
L_B202:
	dec (ix+006h)		;b202
	ret nz			;b205
	ld (ix+006h),010h		;b206
	ld a,(ix+002h)		;b20a
	inc a			;b20d
	cp 006h		;b20e
	jr c,L_B213		;b210
	xor a			;b212
L_B213:
	ld (ix+002h),a		;b213
	ld hl,0b35ch		;b216
	call 0407ah		;b219   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;b21c
	ld (ix+005h),a		;b21d
	ret			;b220
L_B221:
	dec (ix+007h)		;b221
	ret nz			;b224
	ld a,(0e228h)		;b225   ; lee el nivel de dificultad
	bit 6,(ix+000h)		;b228
	jr z,L_B230		;b22c
	add a,008h		;b22e
L_B230:
	cp 00fh		;b230
	jr c,L_B236		;b232
	ld a,00fh		;b234
L_B236:
	ld hl,0b2a8h		;b236
	call 05ca6h		;b239   ; byte_a: A = el byte A de la tabla HL
	ld (ix+007h),a		;b23c
	ld hl,0e406h		;b23f
	ld a,(ix+005h)		;b242
	and a			;b245
	jr z,L_B262		;b246
	cp 002h		;b248
	ret nz			;b24a
	ld a,(ix+000h)		;b24b
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
	cp (hl)			;b25e
	ret nc			;b25f
	jr L_B270		;b260
L_B262:
	ld a,(ix+000h)		;b262
	and 03fh		;b265
	dec a			;b267
	ret nz			;b268
	ld a,(ix+003h)		;b269
	sub 008h		;b26c
	cp (hl)			;b26e
	ret c			;b26f
L_B270:
	ld d,a			;b270
	call L_B2B8		;b271
	call L_B290		;b274
	ret c			;b277
	ld a,d			;b278
	sub (ix+003h)		;b279
	jr nc,L_B280		;b27c
	neg		;b27e
L_B280:
	cp 080h		;b280
	ret nc			;b282
	ld a,034h		;b283
	ld bc,00000h		;b285
	call 04d16h		;b288   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,015h		;b28b
	jp 04ae4h		;b28d   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_B290:
	ld a,(0e228h)		;b290   ; lee el nivel de dificultad
	cp 005h		;b293
	ret nc			;b295
	ld a,(0e406h)		;b296
	sub d			;b299
	add a,020h		;b29a
	cp 040h		;b29c
	ret nc			;b29e
	ld a,(0e404h)		;b29f
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


L_B2B8:
	ld a,(ix+004h)		;b2b8
	sub 005h		;b2bb
	jr nc,L_B2C8		;b2bd
	neg		;b2bf
L_B2C1:
	add a,a			;b2c1
	add a,a			;b2c2
	add a,a			;b2c3
	add a,018h		;b2c4
	ld e,a			;b2c6
	ret			;b2c7
L_B2C8:
	neg		;b2c8
	add a,00eh		;b2ca
	jr L_B2C1		;b2cc
L_B2CE:
	ld ix,0ea20h		;b2ce   ; apunta a la segunda ficha del jefe (el 5)
	ld b,004h		;b2d2
L_B2D4:
	push bc			;b2d4
	ld a,(ix+000h)		;b2d5
	and a			;b2d8
	call nz,L_B2E5		;b2d9
	pop bc			;b2dc
	ld de,00008h		;b2dd
	add ix,de		;b2e0
	djnz L_B2D4		;b2e2
	ret			;b2e4
L_B2E5:
	ld a,(ix+005h)		;b2e5
	ld de,0b362h		;b2e8
	call 04b60h		;b2eb   ; palabra_a_de: DE = la palabra A de la tabla DE (HL apunta a su byte alto)
	ld a,(ix+000h)		;b2ee
	and 03fh		;b2f1
	dec a			;b2f3
	call 0407fh		;b2f4   ; de_mas_a: DE = DE + A
	ld (0f000h),de		;b2f7   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld a,(ix+004h)		;b2fb
	add a,a			;b2fe
	add a,a			;b2ff
	call 0407fh		;b300   ; de_mas_a: DE = DE + A
	ld (0f002h),de		;b303   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld h,(ix+003h)		;b307
	ld l,020h		;b30a
	call 05c92h		;b30c   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0f004h),hl		;b30f   ; guarda variable de paso y el byte siguiente (16 bits)
	ld a,(ix+000h)		;b312
	and 03fh		;b315
	sub 005h		;b317
	neg		;b319
	ld b,a			;b31b
	ld a,(ix+003h)		;b31c
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
	ld c,00eh		;b32f
	ld de,(0f002h)		;b331   ; lee variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld hl,(0f004h)		;b335   ; lee variable de paso y el byte siguiente (16 bits)
L_B338:
	push bc			;b338
	push de			;b339
	push hl			;b33a
L_B33B:
	ld a,(de)			;b33b
	ld (hl),a			;b33c
	inc l			;b33d
	inc de			;b33e
	djnz L_B33B		;b33f
	pop hl			;b341
	ld de,00020h		;b342
	add hl,de			;b345
	pop de			;b346
	inc de			;b347
	inc de			;b348
	inc de			;b349
	inc de			;b34a
	ex af,af'			;b34b
	inc a			;b34c
	cp 00eh		;b34d
	jr c,L_B356		;b34f
	ld de,(0f000h)		;b351   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	xor a			;b355
L_B356:
	ex af,af'			;b356
	pop bc			;b357
	dec c			;b358
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


L_B410:
	ld a,(0e201h)		;b410   ; lee la fase (0-11)
	cp 005h		;b413
	ret nz			;b415
	call L_B432		;b416
	jr z,L_B410		;b419
	ret c			;b41b
	ld hl,0e36bh		;b41c
	inc (hl)			;b41f
	jr L_B410		;b420
L_B422:
	ld a,(0e201h)		;b422   ; lee la fase (0-11)
	cp 005h		;b425
	ret nz			;b427
	ld a,(0e320h)		;b428   ; lee la marca de scroll hecho en este cuadro
	or a			;b42b
	ret z			;b42c
	ld a,0f8h		;b42d
	ld (0f004h),a		;b42f   ; guarda variable de paso
L_B432:
	ld hl,0b49eh		;b432
	ld a,(0e36bh)		;b435
	call 04b67h		;b438   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld hl,(0e203h)		;b43b   ; lee la columna del scroll (16 bits) y el byte siguiente (16 bits)
	or a			;b43e
	sbc hl,de		;b43f
	ret nz			;b441
	ld hl,0e36bh		;b442
	inc (hl)			;b445
	xor a			;b446
	ld hl,0e580h		;b447   ; apunta a las 16 piezas de 8 bytes de las fases 3 y 9-11
	cp (hl)			;b44a
	jr z,L_B452		;b44b
	ld hl,0e590h		;b44d   ; apunta a la segunda pieza de la fase 5
	cp (hl)			;b450
	ret nz			;b451
L_B452:
	call 04c24h		;b452   ; azar: 0xE306 = 0xE306 + 3 x R: el azar del juego
	and 007h		;b455
	cp 006h		;b457
	jr c,L_B45D		;b459
	sub 006h		;b45b
L_B45D:
	add a,a			;b45d
	add a,a			;b45e
	add a,a			;b45f
	add a,040h		;b460
	ld c,a			;b462
	ld a,(0f004h)		;b463   ; lee variable de paso
	cp 0c9h		;b466
	ld de,00207h		;b468
	jr c,L_B477		;b46b
	ld d,001h		;b46d
	neg		;b46f
	rra			;b471
	rra			;b472
	rra			;b473
	and 00fh		;b474
	ld e,a			;b476
L_B477:
	ld (hl),d			;b477
	inc l			;b478
	ld (hl),000h		;b479
	inc l			;b47b
	ld (hl),c			;b47c
	inc l			;b47d
	ld a,(0f004h)		;b47e   ; lee variable de paso
	ld (hl),a			;b481
	inc l			;b482
	ld (hl),e			;b483
	inc l			;b484
	ld a,e			;b485
	add a,a			;b486
	add a,a			;b487
	add a,a			;b488
	ld (hl),a			;b489
	inc l			;b48a
	ld (hl),000h		;b48b
	inc l			;b48d
	ld (hl),018h		;b48e
	inc l			;b490
	ld (hl),004h		;b491
	ld a,l			;b493
	add a,004h		;b494
	ld l,a			;b496
	ld (hl),000h		;b497
	inc l			;b499
	ld (hl),003h		;b49a
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


L_B4AA:
	ld a,(0e201h)		;b4aa   ; lee la fase (0-11)
	cp 005h		;b4ad
	ret nz			;b4af
	ld ix,0e580h		;b4b0   ; apunta a las 16 piezas de 8 bytes de las fases 3 y 9-11
	call L_B4BB		;b4b4
	ld ix,0e590h		;b4b7   ; apunta a la segunda pieza de la fase 5
L_B4BB:
	ld a,(ix+000h)		;b4bb
	or a			;b4be
	ret z			;b4bf
	call L_B4F6		;b4c0
	ret c			;b4c3
	call L_B4E0		;b4c4
	ld a,(ix+001h)		;b4c7
	or a			;b4ca
	ret z			;b4cb
	dec (ix+007h)		;b4cc
	ret nz			;b4cf
	ld (ix+007h),018h		;b4d0
	dec (ix+006h)		;b4d4
	ret p			;b4d7
	xor a			;b4d8
	ld (ix+001h),a		;b4d9
	ld (ix+006h),a		;b4dc
	ret			;b4df
L_B4E0:
	dec (ix+00dh)		;b4e0
	ret nz			;b4e3
	ld (ix+00dh),003h		;b4e4
	inc (ix+00ch)		;b4e8
	ld a,(ix+00ch)		;b4eb
	cp 003h		;b4ee
	ret c			;b4f0
	ld (ix+00ch),000h		;b4f1
	ret			;b4f5
L_B4F6:
	ld a,(0e320h)		;b4f6   ; lee la marca de scroll hecho en este cuadro
	or a			;b4f9
	ret z			;b4fa
	ld a,(ix+003h)		;b4fb
	sub 008h		;b4fe
	jr c,L_B520		;b500
	ld (ix+003h),a		;b502
	cp 0d0h		;b505
	jr nc,L_B516		;b507
	ld (ix+000h),002h		;b509
	ld (ix+004h),007h		;b50d
	ld a,038h		;b511
	jp L_B52F		;b513
L_B516:
	ld (ix+000h),001h		;b516
	inc (ix+004h)		;b51a
	jp L_B529		;b51d
L_B520:
	ld (ix+000h),003h		;b520
	dec (ix+004h)		;b524
	jr z,L_B534		;b527
L_B529:
	ld a,(ix+004h)		;b529
	add a,a			;b52c
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
L_B53A:
	ld a,(0e201h)		;b53a   ; lee la fase (0-11)
	cp 005h		;b53d
	ret nz			;b53f
	ld ix,0e580h		;b540   ; apunta a las 16 piezas de 8 bytes de las fases 3 y 9-11
	call L_B54B		;b544
	ld ix,0e590h		;b547   ; apunta a la segunda pieza de la fase 5
L_B54B:
	ld a,(ix+000h)		;b54b
	or a			;b54e
	ret z			;b54f
	call L_B5B8		;b550
	ld a,(ix+001h)		;b553
	or a			;b556
	ret z			;b557
	ld l,(ix+002h)		;b558
	ld h,(ix+003h)		;b55b
	call 05c92h		;b55e   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	push hl			;b561
	ld a,(ix+006h)		;b562
	ld hl,0b5d5h		;b565
	call 04b67h		;b568   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;b56b
	pop de			;b56c
	ld a,004h		;b56d
L_B56F:
	ld (0f000h),a		;b56f   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,(ix+000h)		;b572
	sub 002h		;b575
	jr z,L_B5A5		;b577
	jp p,L_B599		;b579
L_B57C:
	ld c,(ix+004h)		;b57c
	ld a,(0f000h)		;b57f   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld b,a			;b582
L_B583:
	push bc			;b583
	push hl			;b584
	push de			;b585
	ld b,000h		;b586
	ldir		;b588
	pop hl			;b58a
	ld bc,00020h		;b58b
	add hl,bc			;b58e
	ex de,hl			;b58f
	pop hl			;b590
	ld bc,00007h		;b591
	add hl,bc			;b594
	pop bc			;b595
	djnz L_B583		;b596
	ret			;b598
L_B599:
	ld a,007h		;b599
	sub (ix+004h)		;b59b
	ld c,a			;b59e
	ld b,000h		;b59f
	add hl,bc			;b5a1
	jp L_B57C		;b5a2
L_B5A5:
	ld a,(0f000h)		;b5a5   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld b,a			;b5a8
L_B5A9:
	push bc			;b5a9
	ld bc,00007h		;b5aa
	ldir		;b5ad
	ld a,019h		;b5af
	call 0407fh		;b5b1   ; de_mas_a: DE = DE + A
	pop bc			;b5b4
	djnz L_B5A9		;b5b5
	ret			;b5b7
L_B5B8:
	ld l,028h		;b5b8
	ld h,(ix+003h)		;b5ba
	call 05c92h		;b5bd   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;b5c0
	ld hl,0b66bh		;b5c1
	ld a,(ix+00ch)		;b5c4
	ld c,a			;b5c7
	add a,a			;b5c8
	add a,a			;b5c9
	add a,a			;b5ca
	sub c			;b5cb
	ld c,a			;b5cc
	ld b,000h		;b5cd
	add hl,bc			;b5cf
	ld a,00ch		;b5d0
	jp L_B56F		;b5d2

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


L_B6CD:
	ld de,0b7b4h		;b6cd
	ld hl,02080h		;b6d0
	ld bc,00068h		;b6d3
	call 04a37h		;b6d6   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld de,0b81ch		;b6d9
	ld hl,02100h		;b6dc
	ld bc,000d8h		;b6df
	call 04a37h		;b6e2   ; copia_a_vram_x3: copia a la VRAM en los tres tercios (HL, + 0x800, + 0x1000)
	ld a,0f0h		;b6e5
	ld hl,00080h		;b6e7
	ld bc,00158h		;b6ea
	jp 04a4ah		;b6ed   ; rellena_vram_x3: rellena BC bytes de la VRAM con A en los tres tercios (HL, + 0x800, + 0x1000)
L_B6F0:
	ld de,0b7b4h		;b6f0
	ld hl,02080h		;b6f3
	ld bc,00068h		;b6f6
	call 04a33h		;b6f9   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b81ch		;b6fc
	ld hl,02100h		;b6ff
	ld bc,000d8h		;b702
	call 04a33h		;b705   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld a,0f0h		;b708
	ld hl,00080h		;b70a
	ld bc,00158h		;b70d
	call 00056h		;b710   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7b4h		;b713
	ld hl,02880h		;b716
	ld bc,00068h		;b719
	call 04a33h		;b71c   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b81ch		;b71f
	ld hl,02900h		;b722
	ld bc,000d8h		;b725
	call 04a33h		;b728   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld a,0f0h		;b72b
	ld hl,00880h		;b72d
	ld bc,00158h		;b730
	jp 00056h		;b733   ; BIOS FILVRM - Fills VRAM with value
L_B736:
	ld hl,01008h		;b736
	ld bc,00050h		;b739
	ld a,0f0h		;b73c
	call 00056h		;b73e   ; BIOS FILVRM - Fills VRAM with value
	ld hl,01090h		;b741
	ld bc,00018h		;b744
	ld a,0f0h		;b747
	call 00056h		;b749   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7b4h		;b74c
	ld hl,03008h		;b74f
	ld bc,00050h		;b752
	call 04a33h		;b755   ; copia_a_vram: copia BC bytes de DE a la VRAM HL (LDIRVM)
	ld de,0b77bh		;b758
	ld hl,03090h		;b75b
L_B75E:
	push de			;b75e
	call 04a1dh		;b75f   ; prepara_escritura_vram: SETWRT en HL y C' = el puerto de datos del VDP (0x0007 de la BIOS); conserva AF
	exx			;b762
	pop hl			;b763
L_B764:
	ld a,(hl)			;b764
	inc hl			;b765
	and a			;b766
	ret z			;b767
	add a,a			;b768
	add a,a			;b769
	add a,a			;b76a
	ld de,0b81ch		;b76b
	call 0407fh		;b76e   ; de_mas_a: DE = DE + A
	ld b,008h		;b771
L_B773:
	ld a,(de)			;b773
	inc de			;b774
	out (c),a		;b775
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


L_B77F:
	ld hl,015d8h		;b77f
	ld bc,00060h		;b782
	ld a,0f0h		;b785
	call 00056h		;b787   ; BIOS FILVRM - Fills VRAM with value
	ld hl,014d8h		;b78a
	ld bc,00010h		;b78d
	call 00056h		;b790   ; BIOS FILVRM - Fills VRAM with value
	ld de,0b7a4h		;b793
	ld hl,035d8h		;b796
	call L_B75E		;b799
	ld de,0b7b1h		;b79c
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


L_B8F4:
	ld a,(0e201h)		;b8f4   ; lee la fase (0-11)
	cp 003h		;b8f7
	jr nz,L_B8FF		;b8f9
	ld (ix+030h),074h		;b8fb
L_B8FF:
	ld (ix+02bh),001h		;b8ff
	ld (ix+02ch),007h		;b903
	res 2,(ix+010h)		;b907
	ld a,(ix+004h)		;b90b
	ld (ix+025h),a		;b90e
	ld (ix+028h),000h		;b911
	ld de,0ff00h		;b915
	call 04f02h		;b918   ; pon_vx: IX+09/IX+0A = DE
	ld d,0fdh		;b91b
	ld a,(ix+004h)		;b91d
	cp 060h		;b920
	jr nc,L_B932		;b922
	ld (ix+032h),001h		;b924
	ld a,(ix+030h)		;b928
	add a,004h		;b92b
	ld (ix+030h),a		;b92d
	ld d,003h		;b930
L_B932:
	call 04efbh		;b932   ; pon_vy: IX+07/IX+08 = DE
	ld a,(0e39ch)		;b935
	inc a			;b938
	and 007h		;b939
	ld (0e39ch),a		;b93b
	ld hl,0b997h		;b93e
	call 05ca6h		;b941   ; byte_a: A = el byte A de la tabla HL
	ld (ix+02dh),a		;b944
L_B947:
	ld b,010h		;b947
	ld a,(ix+004h)		;b949
	cp 058h		;b94c
	jr nc,L_B952		;b94e
	ld b,0f0h		;b950
L_B952:
	add a,b			;b952
	ld l,a			;b953
	ld h,0f8h		;b954
	call 05c92h		;b956   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld de,0b987h		;b959
	ld a,(ix+032h)		;b95c
	dec a			;b95f
	jr z,L_B965		;b960
	ld de,0b98bh		;b962
L_B965:
	ld a,(0e201h)		;b965   ; lee la fase (0-11)
	cp 003h		;b968
	jr nz,L_B971		;b96a
	ld a,008h		;b96c
	call 0407fh		;b96e   ; de_mas_a: DE = DE + A
L_B971:
	ld a,(ix+028h)		;b971
	and a			;b974
	jr z,L_B979		;b975
	inc de			;b977
	inc de			;b978
L_B979:
	ex de,hl			;b979
	ldi		;b97a
	ld a,01fh		;b97c
	call 0407fh		;b97e   ; de_mas_a: DE = DE + A
	ldi		;b981
	inc (ix+028h)		;b983
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


L_B9A0:
	ld a,(ix+028h)		;b9a0
	cp 002h		;b9a3
	jr z,L_B9AF		;b9a5
	ld a,(ix+006h)		;b9a7
	cp 0f0h		;b9aa
	call z,L_B947		;b9ac
L_B9AF:
	call L_B9C4		;b9af
	ld a,(ix+001h)		;b9b2
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


L_B9C4:
	dec (ix+02ch)		;b9c4
	ret nz			;b9c7
	ld (ix+02ch),008h		;b9c8
	ret			;b9cc
L_B9CD:
	ld a,(ix+02ch)		;b9cd
	cp 008h		;b9d0
	ret nz			;b9d2
	ld a,(ix+006h)		;b9d3
	sub 008h		;b9d6
	ld (ix+006h),a		;b9d8
	ret			;b9db
L_B9DC:
	call L_B9CD		;b9dc
	ld a,(ix+006h)		;b9df
	cp (ix+02dh)		;b9e2
	ret nc			;b9e5
	inc (ix+001h)		;b9e6
	ret			;b9e9
L_B9EA:
	inc (ix+001h)		;b9ea
	ld (ix+00dh),001h		;b9ed
	ld (ix+002h),00ah		;b9f1
	set 2,(ix+010h)		;b9f5
	ret			;b9f9
L_B9FA:
	call L_BAC1		;b9fa
	call L_BA70		;b9fd
	ld a,(ix+004h)		;ba00
	add a,070h		;ba03
	cp 080h		;ba05
	ret nc			;ba07
	inc (ix+001h)		;ba08
	jp 04f3ch		;ba0b   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
L_BA0E:
	call L_BAC1		;ba0e
	bit 7,(ix+008h)		;ba11
	ld a,(ix+004h)		;ba15
	jr nz,L_BA4D		;ba18
	cp (ix+025h)		;ba1a
	ret c			;ba1d
L_BA1E:
	ld a,(ix+025h)		;ba1e
	ld (ix+004h),a		;ba21
	res 2,(ix+010h)		;ba24
	dec (ix+006h)		;ba28
	inc (ix+001h)		;ba2b
	ld b,0f8h		;ba2e
	ld a,(0e201h)		;ba30   ; lee la fase (0-11)
	cp 003h		;ba33
	jr nz,L_BA39		;ba35
	ld b,074h		;ba37
L_BA39:
	ld (ix+00dh),0ffh		;ba39
	ld a,(ix+004h)		;ba3d
	cp 060h		;ba40
	ld a,b			;ba42
	jr nc,L_BA47		;ba43
	add a,004h		;ba45
L_BA47:
	ld (ix+030h),a		;ba47
	jp 04f3ch		;ba4a   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
L_BA4D:
	inc a			;ba4d
	cp (ix+025h)		;ba4e
	jr c,L_BA1E		;ba51
	ret			;ba53
L_BA54:
	dec (ix+006h)		;ba54
	ld a,(0e320h)		;ba57   ; lee la marca de scroll hecho en este cuadro
	or a			;ba5a
	ret z			;ba5b
	inc (ix+001h)		;ba5c
	ld (ix+002h),008h		;ba5f
	ret			;ba63
L_BA64:
	call L_B9CD		;ba64
	dec (ix+002h)		;ba67
	ret nz			;ba6a
	ld (ix+001h),000h		;ba6b
	ret			;ba6f
L_BA70:
	ld a,(ix+002h)		;ba70
	and a			;ba73
	ret z			;ba74
	dec a			;ba75
	ld (ix+002h),a		;ba76
	jr z,L_BA8D		;ba79
	cp 004h		;ba7b
	ret nz			;ba7d
	ld d,(ix+007h)		;ba7e
	ld e,(ix+008h)		;ba81
	ld (ix+029h),d		;ba84
	ld (ix+02ah),e		;ba87
	jp 04f1ch		;ba8a   ; vy_cero: IX+07/IX+08 = 0
L_BA8D:
	ld e,(ix+029h)		;ba8d
	ld d,(ix+02ah)		;ba90
	call 04efbh		;ba93   ; pon_vy: IX+07/IX+08 = DE
	ld hl,0babbh		;ba96
	ld b,006h		;ba99
L_BA9B:
	push bc			;ba9b
	push hl			;ba9c
	ld a,b			;ba9d
	dec a			;ba9e
	call 05ca6h		;ba9f   ; byte_a: A = el byte A de la tabla HL
	ld b,002h		;baa2
	call 04cb7h		;baa4   ; velocidad_en_direccion: para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
	ex de,hl			;baa7
	ld b,d			;baa8
	ld c,e			;baa9
	ld e,(ix+004h)		;baaa
	ld a,(ix+006h)		;baad
	add a,008h		;bab0
	ld d,a			;bab2
	call 0937dh		;bab3   ; dispara_bala_con: una bala desde D/E + 8 con la velocidad BC (Y) y HL (X), si no esta 0xF00E
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


L_BAC1:
	dec (ix+02bh)		;bac1
	ret nz			;bac4
	ld (ix+02bh),002h		;bac5
	ld b,004h		;bac9
	ld a,(0e201h)		;bacb   ; lee la fase (0-11)
	cp 003h		;bace
	jr nz,L_BAD4		;bad0
	ld b,00ch		;bad2
L_BAD4:
	ld a,(ix+030h)		;bad4
	xor b			;bad7
	ld (ix+030h),a		;bad8
	ret			;badb
L_BADC:
	bit 0,(ix+00bh)		;badc
	ld a,03ah		;bae0
	call L_BAFA		;bae2
	ld (ix+008h),006h		;bae5
	ld (ix+009h),004h		;bae9
	ld (ix+00ah),003h		;baed
	ld (ix+002h),030h		;baf1
	ld (ix+00dh),0ffh		;baf5
	ret			;baf9
L_BAFA:
	bit 0,(ix+00bh)		;bafa
	jr z,L_BB02		;bafe
	add a,007h		;bb00
L_BB02:
	ld (ix+007h),a		;bb02
	ret			;bb05
L_BB06:
	ld a,(ix+001h)		;bb06
	call 04084h		;bb09   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_BB0C: 9 destinos del despachador p00:4084 (call en p11:BB09, el
;   indice en A): BB1E, BB49, BB60, BB81, BB8C, BB95, BBCC, BBDC, BBF8; lo
;   leen p11:BB09 (18 bytes)
;   0xbb0c..0xbb1e  (18 bytes)
DATA_tabla_BB0C:
	defw 0bb1eh,0bb49h,0bb60h,0bb81h,0bb8ch,0bb95h,0bbcch,0bbdch	; bb0c
	defw 0bbf8h	; bb1c  -> L_BBF8

; ======================================================================
; CODIGO 0xbb1e..0xbe68  (842 bytes)
; ======================================================================


L_BB1E:
	dec (ix+002h)		;bb1e
	ret nz			;bb21
	inc (ix+002h)		;bb22
	ld a,(0e406h)		;bb25
	sub (ix+006h)		;bb28
	add a,020h		;bb2b
	cp 040h		;bb2d
	ret nc			;bb2f
	ld (ix+00dh),000h		;bb30
	ld (ix+002h),001h		;bb34
	ld (ix+00ch),003h		;bb38
	inc (ix+001h)		;bb3c
	ld a,(0e203h)		;bb3f   ; lee la columna del scroll (16 bits)
	rra			;bb42
	and 001h		;bb43
	ld (ix+00fh),a		;bb45
	ret			;bb48
L_BB49:
	dec (ix+002h)		;bb49
	ret nz			;bb4c
	ld (ix+002h),001h		;bb4d
	inc (ix+007h)		;bb51
	dec (ix+00ch)		;bb54
	ret nz			;bb57
	ld (ix+002h),006h		;bb58
	inc (ix+001h)		;bb5c
	ret			;bb5f
L_BB60:
	call L_BB74		;bb60
	dec (ix+002h)		;bb63
	ret nz			;bb66
	ld a,03eh		;bb67
	call L_BAFA		;bb69
	ld (ix+00ch),002h		;bb6c
	inc (ix+001h)		;bb70
	ret			;bb73
L_BB74:
	bit 0,(ix+002h)		;bb74
	ld a,03dh		;bb78
	jr z,L_BB7E		;bb7a
	ld a,03eh		;bb7c
L_BB7E:
	jp L_BAFA		;bb7e
L_BB81:
	inc (ix+007h)		;bb81
	dec (ix+00ch)		;bb84
	ret nz			;bb87
	inc (ix+001h)		;bb88
	ret			;bb8b
L_BB8C:
	ld a,03dh		;bb8c
	call L_BAFA		;bb8e
	inc (ix+001h)		;bb91
	ret			;bb94
L_BB95:
	call L_BBA0		;bb95
	ld (ix+002h),006h		;bb98
	inc (ix+001h)		;bb9c
	ret			;bb9f
L_BBA0:
	bit 0,(ix+00bh)		;bba0
	ld bc,000f8h		;bba4
	jr z,L_BBAC		;bba7
	ld bc,00118h		;bba9
L_BBAC:
	ld a,(ix+004h)		;bbac
	add a,c			;bbaf
	ld e,a			;bbb0
	ld a,(0e320h)		;bbb1   ; lee la marca de scroll hecho en este cuadro
	and a			;bbb4
	ld c,010h		;bbb5
	jr z,L_BBBB		;bbb7
	ld c,008h		;bbb9
L_BBBB:
	ld a,(ix+006h)		;bbbb
	add a,c			;bbbe
	ld d,a			;bbbf
	ld c,000h		;bbc0
	ld a,041h		;bbc2
	call 04d16h		;bbc4   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,026h		;bbc7
	jp 04ae4h		;bbc9   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_BBCC:
	dec (ix+002h)		;bbcc
	ret nz			;bbcf
	ld (ix+002h),001h		;bbd0
	ld (ix+00ch),003h		;bbd4
	inc (ix+001h)		;bbd8
	ret			;bbdb
L_BBDC:
	dec (ix+002h)		;bbdc
	ret nz			;bbdf
	ld (ix+002h),001h		;bbe0
	dec (ix+007h)		;bbe4
	dec (ix+00ch)		;bbe7
	ret nz			;bbea
	ld (ix+00dh),0ffh		;bbeb
	ld (ix+002h),020h		;bbef
	ld (ix+001h),000h		;bbf3
	ret			;bbf7
L_BBF8:
	ld a,(ix+00bh)		;bbf8
	and a			;bbfb
	jr nz,L_BC0B		;bbfc
	ld (ix+00dh),0ffh		;bbfe
	ld a,(ix+00fh)		;bc02
	add a,033h		;bc05
	ld (ix+007h),a		;bc07
	ret			;bc0a
L_BC0B:
	ld (ix+000h),000h		;bc0b
	ret			;bc0f
L_BC10:
	xor a			;bc10
	ld (ix+02fh),a		;bc11
	inc a			;bc14
	ld (ix+013h),a		;bc15
	ld (ix+014h),a		;bc18
	ld (ix+010h),009h		;bc1b
	ld (ix+002h),00ah		;bc1f
	ret			;bc23
L_BC24:
	ld a,(ix+001h)		;bc24
	dec a			;bc27
	jr z,L_BC5C		;bc28
	bit 0,(ix+019h)		;bc2a
	jr nz,L_BC3E		;bc2e
	bit 0,(ix+02fh)		;bc30
	jr nz,L_BC54		;bc34
	ld a,(ix+004h)		;bc36
	sub 020h		;bc39
	ld (ix+004h),a		;bc3b
L_BC3E:
	ld a,(ix+013h)		;bc3e
	add a,004h		;bc41
	ld (ix+013h),a		;bc43
	ld a,(ix+00eh)		;bc46
	add a,020h		;bc49
	ld (ix+00eh),a		;bc4b
	call L_BD08		;bc4e
	call L_BC76		;bc51
L_BC54:
	dec (ix+002h)		;bc54
	ret nz			;bc57
	inc (ix+001h)		;bc58
	ret			;bc5b
L_BC5C:
	bit 0,(ix+02fh)		;bc5c
	jr nz,L_BC8F		;bc60
	bit 0,(ix+019h)		;bc62
	ld c,0e0h		;bc66
	jr z,L_BC6C		;bc68
	ld c,020h		;bc6a
L_BC6C:
	ld a,(ix+004h)		;bc6c
	add a,c			;bc6f
	ld (ix+004h),a		;bc70
	call L_BD08		;bc73
L_BC76:
	ld l,(ix+004h)		;bc76
	ld h,(ix+006h)		;bc79
	bit 0,(ix+019h)		;bc7c
	jr z,L_BCB3		;bc80
	call 05c92h		;bc82   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld de,00020h		;bc85
	call L_BCCC		;bc88
	ret nc			;bc8b
	jp 06514h		;bc8c   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_BC8F:
	ld a,(ix+013h)		;bc8f
	sub 004h		;bc92
	ld (ix+013h),a		;bc94
	jp c,06514h		;bc97   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	dec a			;bc9a
	jp m,06514h		;bc9b   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	inc a			;bc9e
	add a,a			;bc9f
	add a,a			;bca0
	add a,a			;bca1
	ld (ix+00eh),a		;bca2
	bit 0,(ix+019h)		;bca5
	ret z			;bca9
	ld a,(ix+004h)		;bcaa
	add a,020h		;bcad
	ld (ix+004h),a		;bcaf
	ret			;bcb2
L_BCB3:
	ld a,(ix+013h)		;bcb3
	dec a			;bcb6
	add a,a			;bcb7
	add a,a			;bcb8
	add a,a			;bcb9
	add a,l			;bcba
	ld l,a			;bcbb
	ld (0f000h),a		;bcbc   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	call 05c92h		;bcbf   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld de,0ffe0h		;bcc2
	call L_BCCC		;bcc5
	ret nc			;bcc8
	jp 06514h		;bcc9   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
L_BCCC:
	ld a,(0e305h)		;bccc   ; lee dato de la fase de p01:697A
	ld c,a			;bccf
	ld b,(ix+013h)		;bcd0
	exx			;bcd3
	ld c,000h		;bcd4
	exx			;bcd6
L_BCD7:
	ld a,(hl)			;bcd7
	and a			;bcd8
	jr z,L_BCDE		;bcd9
	cp c			;bcdb
	jr c,L_BCE6		;bcdc
L_BCDE:
	exx			;bcde
	inc c			;bcdf
	exx			;bce0
	add hl,de			;bce1
	djnz L_BCD7		;bce2
	and a			;bce4
	ret			;bce5
L_BCE6:
	ld (ix+02fh),001h		;bce6
	exx			;bcea
	ld (ix+013h),c		;bceb
	ld a,c			;bcee
	dec a			;bcef
	scf			;bcf0
	ret m			;bcf1
	ld a,c			;bcf2
	add a,a			;bcf3
	add a,a			;bcf4
	add a,a			;bcf5
	ld c,a			;bcf6
	ld (ix+00eh),a		;bcf7
	ld a,(ix+019h)		;bcfa
	and a			;bcfd
	ret nz			;bcfe
	ld a,(0f000h)		;bcff   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	sub c			;bd02
	ld (ix+004h),a		;bd03
	and a			;bd06
	ret			;bd07
L_BD08:
	ld (0f000h),a		;bd08   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,(ix+004h)		;bd0b
	bit 0,(ix+019h)		;bd0e
	jr z,L_BD23		;bd12
	ld a,(ix+013h)		;bd14
	add a,a			;bd17
	add a,a			;bd18
	add a,a			;bd19
	add a,(ix+004h)		;bd1a
	sub 0c0h		;bd1d
	ret c			;bd1f
	ret z			;bd20
	jr L_BD2C		;bd21
L_BD23:
	cp 0e0h		;bd23
	ret c			;bd25
	neg		;bd26
	ld (ix+004h),000h		;bd28
L_BD2C:
	ld c,a			;bd2c
	ld a,(ix+00eh)		;bd2d
	sub c			;bd30
	ld (ix+00eh),a		;bd31
	ld a,c			;bd34
	rra			;bd35
	rra			;bd36
	rra			;bd37
	and 01fh		;bd38
	ld b,a			;bd3a
	ld a,(ix+013h)		;bd3b
	sub b			;bd3e
	ld (ix+013h),a		;bd3f
	dec a			;bd42
	jp m,06514h		;bd43   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ret			;bd46
L_BD47:
	ld a,(0e3aah)		;bd47   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;bd4a
	ret nz			;bd4b
	ld de,0eb00h		;bd4c
	ld ix,0e600h		;bd4f   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld b,00ch		;bd53
L_BD55:
	push bc			;bd55
	call L_BD64		;bd56
	exx			;bd59
	ld de,00040h		;bd5a
	add ix,de		;bd5d
	exx			;bd5f
	pop bc			;bd60
	djnz L_BD55		;bd61
	ret			;bd63
L_BD64:
	bit 6,(ix+00bh)		;bd64
	ret z			;bd68
	ld a,(ix+000h)		;bd69
	and a			;bd6c
	ret z			;bd6d
	cp 024h		;bd6e
	ret z			;bd70
	sub 039h		;bd71
	cp 004h		;bd73
	jr c,L_BDB3		;bd75
	ld a,(ix+006h)		;bd77
	cp 0f8h		;bd7a
	ret nc			;bd7c
	ld h,a			;bd7d
	ld l,(ix+004h)		;bd7e
	call 05c92h		;bd81   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (ix+011h),l		;bd84
	ld (ix+012h),h		;bd87
	ld b,(ix+013h)		;bd8a
	ld c,(ix+006h)		;bd8d
	xor a			;bd90
	sub c			;bd91
	jr nz,L_BD96		;bd92
	ld a,0f8h		;bd94
L_BD96:
	rra			;bd96
	rra			;bd97
	rra			;bd98
	and 01fh		;bd99
	ld c,(ix+014h)		;bd9b
	cp c			;bd9e
	jr nc,L_BDA2		;bd9f
	ld c,a			;bda1
L_BDA2:
	push bc			;bda2
	ld b,000h		;bda3
	ldir		;bda5
	pop bc			;bda7
	ld a,020h		;bda8
	sub c			;bdaa
	add a,l			;bdab
	ld l,a			;bdac
	jr nc,L_BDB0		;bdad
	inc h			;bdaf
L_BDB0:
	djnz L_BDA2		;bdb0
	ret			;bdb2
L_BDB3:
	ld a,(ix+014h)		;bdb3
	or a			;bdb6
	ret z			;bdb7
	ld c,a			;bdb8
	ld l,(ix+004h)		;bdb9
	ld h,(ix+006h)		;bdbc
	call 05c92h		;bdbf   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (ix+011h),l		;bdc2
	ld (ix+012h),h		;bdc5
	ld b,000h		;bdc8
	ldir		;bdca
	ret			;bdcc
L_BDCD:
	ld a,(0e3aah)		;bdcd   ; lee la marca de 0xE3AA: sin enemigos ni su dibujo
	or a			;bdd0
	ret nz			;bdd1
	ld hl,0eb00h		;bdd2
	ld ix,0e600h		;bdd5   ; apunta a las fichas de 64 bytes (0xE600-0xE8FF), y tambien el bufer de graficos al cargar
	ld b,00ch		;bdd9
L_BDDB:
	push bc			;bddb
	bit 6,(ix+00bh)		;bddc
	jr z,L_BE27		;bde0
	ld a,(ix+000h)		;bde2
	and a			;bde5
	jr z,L_BE27		;bde6
	cp 024h		;bde8
	jr z,L_BE30		;bdea
	sub 039h		;bdec
	cp 004h		;bdee
	jr c,L_BE37		;bdf0
	ld a,(ix+006h)		;bdf2
	cp 0f8h		;bdf5
	jr nc,L_BE27		;bdf7
	ld e,(ix+011h)		;bdf9
	ld d,(ix+012h)		;bdfc
	ld b,(ix+013h)		;bdff
	ld c,(ix+006h)		;be02
	xor a			;be05
	sub c			;be06
	jr nz,L_BE0B		;be07
	ld a,0f8h		;be09
L_BE0B:
	rra			;be0b
	rra			;be0c
	rra			;be0d
	and 01fh		;be0e
	ld c,(ix+014h)		;be10
	cp c			;be13
	jr nc,L_BE17		;be14
	ld c,a			;be16
L_BE17:
	push bc			;be17
	ld b,000h		;be18
	ldir		;be1a
	pop bc			;be1c
	ld a,020h		;be1d
	sub c			;be1f
	add a,e			;be20
	ld e,a			;be21
	jr nc,L_BE25		;be22
	inc d			;be24
L_BE25:
	djnz L_BE17		;be25
L_BE27:
	pop bc			;be27
	ld de,00040h		;be28
	add ix,de		;be2b
	djnz L_BDDB		;be2d
	ret			;be2f
L_BE30:
	push hl			;be30
	call 04bc7h		;be31   ; quita_el_jefe: borra IX+13 filas de IX+14 caracteres de la pantalla de RAM en IX+04/IX+06
	pop hl			;be34
	jr L_BE27		;be35
L_BE37:
	ld a,(ix+014h)		;be37
	or a			;be3a
	ret z			;be3b
	ld c,a			;be3c
	ld b,000h		;be3d
	ld e,(ix+011h)		;be3f
	ld d,(ix+012h)		;be42
	ldir		;be45
	jr L_BE27		;be47
L_BE49:
	ld (ix+007h),02fh		;be49
	ld (ix+008h),004h		;be4d
	ld (ix+009h),002h		;be51
	ld (ix+00ah),002h		;be55
	ld (ix+002h),030h		;be59
	ld (ix+00dh),0ffh		;be5d
	ret			;be61
L_BE62:
	ld a,(ix+001h)		;be62
	call 04084h		;be65   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_BE68: 5 destinos del despachador p00:4084 (call en p11:BE65, el
;   indice en A): BE72, BE86, BEA1, BED0, BEE1; lo leen p11:BE65 (10 bytes)
;   0xbe68..0xbe72  (10 bytes)
DATA_tabla_BE68:
	defw 0be72h,0be86h,0bea1h,0bed0h,0bee1h	; be68

; ======================================================================
; CODIGO 0xbe72..0xbf0b  (153 bytes)
; ======================================================================


L_BE72:
	dec (ix+002h)		;be72
	ret nz			;be75
	inc (ix+001h)		;be76
	ld (ix+002h),001h		;be79
	ld (ix+00ch),002h		;be7d
	ld (ix+00dh),01eh		;be81
	ret			;be85
L_BE86:
	dec (ix+002h)		;be86
	ret nz			;be89
	ld (ix+002h),003h		;be8a
	inc (ix+007h)		;be8e
	dec (ix+00ch)		;be91
	ret nz			;be94
	ld (ix+002h),001h		;be95
	ld (ix+00ch),005h		;be99
	inc (ix+001h)		;be9d
	ret			;bea0
L_BEA1:
	dec (ix+002h)		;bea1
	ret nz			;bea4
	ld (ix+002h),008h		;bea5
	ld a,(ix+004h)		;bea9
	add a,0f4h		;beac
	ld e,a			;beae
	ld a,(ix+006h)		;beaf
	sub 004h		;beb2
	ld d,a			;beb4
	ld a,040h		;beb5
	ld b,(ix+00ch)		;beb7
	ld c,000h		;beba
	call 04d16h		;bebc   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,015h		;bebf
	call 04ae4h		;bec1   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	dec (ix+00ch)		;bec4
	ret nz			;bec7
	ld (ix+002h),040h		;bec8
	inc (ix+001h)		;becc
	ret			;becf
L_BED0:
	dec (ix+002h)		;bed0
	ret nz			;bed3
	ld (ix+002h),001h		;bed4
	ld (ix+00ch),005h		;bed8
	ld (ix+001h),002h		;bedc
	ret			;bee0
L_BEE1:
	ld (ix+007h),032h		;bee1
	ret			;bee5
L_BEE6:
	ld a,(ix+019h)		;bee6
	dec a			;bee9
	ld hl,0bf0bh		;beea
	call 0407ah		;beed   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;bef0
	ld (ix+002h),a		;bef1
	call 04e93h		;bef4   ; azar_por_nivel: A = p00:4EA4[0xE228] + un azar de 0 a 7 (R)
	ld (ix+015h),a		;bef7
	ld (ix+024h),004h		;befa
	ld (ix+025h),000h		;befe
	ld de,00000h		;bf02
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


L_BF10:
	call L_BF47		;bf10
	call 06770h		;bf13   ; dispara_al_acabar: IX+15 - 1 y, al llegar a 0, p01:6774
	ld a,(ix+001h)		;bf16
	dec a			;bf19
	jp z,09b62h		;bf1a   ; hacia_la_y_de_la_nave: la velocidad Y + o - 0x16 hacia la Y de la nave
	ld a,(ix+004h)		;bf1d
	cp 008h		;bf20
	jr c,L_BF31		;bf22
	ld a,(0e327h)		;bf24   ; lee la marca de fin del scroll
	and a			;bf27
	jr nz,L_BF2D		;bf28
	dec (ix+006h)		;bf2a
L_BF2D:
	dec (ix+002h)		;bf2d
	ret nz			;bf30
L_BF31:
	ld de,00280h		;bf31
	ld a,(0e406h)		;bf34
	sub (ix+006h)		;bf37
	call c,05cadh		;bf3a   ; menos_de: DE = - DE
	ld hl,00000h		;bf3d
	call 04f26h		;bf40   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
	inc (ix+001h)		;bf43
	ret			;bf46
L_BF47:
	dec (ix+024h)		;bf47
	ret nz			;bf4a
	ld (ix+024h),004h		;bf4b
	ld a,(ix+025h)		;bf4f
	inc a			;bf52
	cp 003h		;bf53
	jr c,L_BF58		;bf55
	xor a			;bf57
L_BF58:
	ld (ix+025h),a		;bf58
	add a,a			;bf5b
	add a,a			;bf5c
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

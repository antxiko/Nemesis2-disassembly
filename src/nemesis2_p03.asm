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
L_A002:
	ld a,(0e1c3h)		;a002
	rra			;a005
	rra			;a006
	and 003h		;a007
	ld hl,0a013h		;a009
	call 05ca6h		;a00c
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


L_A017:
	ld hl,01e01h		;a017
	ld (0e388h),hl		;a01a
	xor a			;a01d
	ld (0e38ah),a		;a01e
	ld hl,0e3cah		;a021
	ld de,0e3cbh		;a024
	ld bc,00005h		;a027
	ld (hl),a			;a02a
	ldir		;a02b
	call 04c24h		;a02d
	ld (0e38bh),a		;a030
	ld a,0d2h		;a033
	ld (0e39fh),a		;a035
	ld a,01eh		;a038
	ld (0e389h),a		;a03a
	ld hl,00258h		;a03d
	ld a,(0e20ah)		;a040
	or a			;a043
	jr z,L_A049		;a044
	ld hl,00384h		;a046
L_A049:
	ld (0e349h),hl		;a049
	ret			;a04c
L_A04D:
	ld a,(0e388h)		;a04d
	or a			;a050
	ret z			;a051
	ld b,a			;a052
	ld hl,(0e349h)		;a053
	dec hl			;a056
	ld (0e349h),hl		;a057
	ld a,l			;a05a
	or h			;a05b
	jr z,L_A066		;a05c
	dec b			;a05e
	jr z,L_A06F		;a05f
	dec b			;a061
	jp z,L_A108		;a062
	ret			;a065
L_A066:
	xor a			;a066
	ld (0e388h),a		;a067
	inc a			;a06a
	ld (0e348h),a		;a06b
	ret			;a06e
L_A06F:
	ld hl,0e39fh		;a06f
	dec (hl)			;a072
	jr nz,L_A09D		;a073
	ld (hl),01eh		;a075
	ld a,002h		;a077
	ld (0e388h),a		;a079
	ld ix,0e500h		;a07c
	ld de,00010h		;a080
	ld bc,00805h		;a083
	ld hl,001ffh		;a086
L_A089:
	ld a,(ix+000h)		;a089
	or a			;a08c
	jr z,L_A098		;a08d
	ld (ix+001h),c		;a08f
	ld (ix+00dh),l		;a092
	ld (ix+002h),h		;a095
L_A098:
	add ix,de		;a098
	djnz L_A089		;a09a
	ret			;a09c
L_A09D:
	ld hl,0e389h		;a09d
	dec (hl)			;a0a0
	ret nz			;a0a1
	ld a,r		;a0a2
	and 01fh		;a0a4
	add a,020h		;a0a6
	ld (hl),a			;a0a8
	ld a,(0e20ah)		;a0a9
	ld b,002h		;a0ac
	or a			;a0ae
	jr z,L_A0B2		;a0af
	inc b			;a0b1
L_A0B2:
	ld a,(0e38ah)		;a0b2
	cp b			;a0b5
	jr c,L_A0BE		;a0b6
L_A0B8:
	ld a,001h		;a0b8
	ld (0e389h),a		;a0ba
	ret			;a0bd
L_A0BE:
	call 04c24h		;a0be
	and 003h		;a0c1
	cp 003h		;a0c3
	jr nz,L_A0C8		;a0c5
	xor a			;a0c7
L_A0C8:
	ld b,a			;a0c8
	ld hl,0e3cah		;a0c9
	ld a,(0e38bh)		;a0cc
	bit 0,a		;a0cf
	jr z,L_A0D5		;a0d1
	ld l,0cdh		;a0d3
L_A0D5:
	ld a,b			;a0d5
	add a,l			;a0d6
	ld l,a			;a0d7
	ld a,(hl)			;a0d8
	or a			;a0d9
	jr nz,L_A0B8		;a0da
	push hl			;a0dc
	ld a,(0e38bh)		;a0dd
	bit 0,a		;a0e0
	ld a,b			;a0e2
	jr z,L_A0E7		;a0e3
	add a,003h		;a0e5
L_A0E7:
	ld b,a			;a0e7
	ld hl,0a0fch		;a0e8
	call 04b67h		;a0eb
	ld a,007h		;a0ee
	call 087dch		;a0f0
	pop hl			;a0f3
	ret nc			;a0f4
	ld (hl),001h		;a0f5
	ld hl,0e38ah		;a0f7
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
	ld hl,0e39fh		;a108
	dec (hl)			;a10b
	ret nz			;a10c
	ld (hl),0d2h		;a10d
	ld hl,0e38bh		;a10f
	inc (hl)			;a112
	ld a,001h		;a113
	ld (0e388h),a		;a115
	ret			;a118
L_A119:
	ld a,(ix+006h)		;a119
	or a			;a11c
	jp z,L_A210		;a11d
	ld (ix+009h),008h		;a120
	ld (ix+00ah),006h		;a124
	ld (ix+00dh),0ffh		;a128
	ld (ix+008h),020h		;a12c
	ld (ix+00eh),000h		;a130
	call L_A229		;a134
	ld a,01fh		;a137
	jr c,L_A13D		;a139
	ld a,027h		;a13b
L_A13D:
	ld (ix+007h),a		;a13d
	ret			;a140
L_A141:
	ld a,(ix+006h)		;a141
	or a			;a144
	jr nz,L_A14C		;a145
	ld (ix+000h),000h		;a147
	ret			;a14b
L_A14C:
	ld hl,0a22fh		;a14c
	push hl			;a14f
	ld a,(ix+001h)		;a150
	call 04084h		;a153

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


L_A164:
	ld a,(ix+006h)		;a164
	cp 0c1h		;a167
	ret nc			;a169
	ld (ix+002h),001h		;a16a
	jr L_A17A		;a16e
L_A170:
	dec (ix+002h)		;a170
	jp nz,L_A255		;a173
	ld (ix+002h),004h		;a176
L_A17A:
	inc (ix+001h)		;a17a
	ret			;a17d
L_A17E:
	dec (ix+002h)		;a17e
	ret nz			;a181
	ld (ix+002h),004h		;a182
	call L_A229		;a186
	ld b,023h		;a189
	jr c,L_A18F		;a18b
	ld b,02bh		;a18d
L_A18F:
	inc (ix+007h)		;a18f
	ld a,(ix+007h)		;a192
	cp b			;a195
	ret c			;a196
	ld a,r		;a197
	and 01fh		;a199
	add a,030h		;a19b
	ld (ix+002h),a		;a19d
	ld a,r		;a1a0
	and 00fh		;a1a2
	inc a			;a1a4
	ld (ix+00ch),a		;a1a5
	jr L_A17A		;a1a8
L_A1AA:
	dec (ix+002h)		;a1aa
	jr z,L_A1B5		;a1ad
	call L_A294		;a1af
	jp L_A2B1		;a1b2
L_A1B5:
	ld a,(0e388h)		;a1b5
	or a			;a1b8
	jr nz,L_A1C1		;a1b9
	ld (ix+002h),004h		;a1bb
	jr L_A17A		;a1bf
L_A1C1:
	ld (ix+002h),002h		;a1c1
	ld (ix+001h),005h		;a1c5
	ret			;a1c9
L_A1CA:
	dec (ix+002h)		;a1ca
	ret nz			;a1cd
	ld (ix+002h),004h		;a1ce
	call L_A229		;a1d2
	ld b,020h		;a1d5
	jr c,L_A1DB		;a1d7
	ld b,028h		;a1d9
L_A1DB:
	dec (ix+007h)		;a1db
	ld a,(ix+007h)		;a1de
	cp b			;a1e1
	ret nc			;a1e2
	ld (ix+001h),001h		;a1e3
	ld (ix+00eh),000h		;a1e7
	ld a,(0e20ah)		;a1eb
	or a			;a1ee
	ld a,032h		;a1ef
	jr z,L_A1F5		;a1f1
	ld a,01eh		;a1f3
L_A1F5:
	ld (ix+002h),a		;a1f5
	ret			;a1f8
L_A1F9:
	dec (ix+002h)		;a1f9
	ret nz			;a1fc
	ld (ix+002h),002h		;a1fd
	ld (ix+00eh),001h		;a201
	call L_A27A		;a205
	bit 0,(ix+00eh)		;a208
	ret nz			;a20c
	jp L_A17A		;a20d
L_A210:
	ld a,(0e388h)		;a210
	or a			;a213
	jr z,L_A224		;a214
	ld a,(ix+00bh)		;a216
	ld hl,0e3cah		;a219
	add a,l			;a21c
	ld l,a			;a21d
	ld (hl),000h		;a21e
	ld hl,0e38ah		;a220
	dec (hl)			;a223
L_A224:
	ld (ix+000h),000h		;a224
	ret			;a228
L_A229:
	ld a,(ix+004h)		;a229
	cp 040h		;a22c
	ret			;a22e
L_A22F:
	ld a,(ix+006h)		;a22f
	cp 0c1h		;a232
	ld a,0ffh		;a234
	jr nc,L_A241		;a236
	ld a,(ix+007h)		;a238
	ld hl,L_A224+2		;a23b
	call 05ca6h		;a23e
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


L_A255:
	ld a,(0e1c3h)		;a255
	and 007h		;a258
	ret nz			;a25a
	bit 0,(ix+00eh)		;a25b
	jr nz,L_A27A		;a25f
	call L_A229		;a261
	ld b,021h		;a264
	jr c,L_A26A		;a266
	ld b,029h		;a268
L_A26A:
	inc (ix+007h)		;a26a
	ld a,(ix+007h)		;a26d
	cp b			;a270
	ret c			;a271
	ld (ix+007h),b		;a272
	ld (ix+00eh),001h		;a275
	ret			;a279
L_A27A:
	call L_A229		;a27a
	ld b,020h		;a27d
	jr c,L_A283		;a27f
	ld b,028h		;a281
L_A283:
	dec (ix+007h)		;a283
	ld a,(ix+007h)		;a286
	cp b			;a289
	ret nc			;a28a
	dec b			;a28b
	ld (ix+007h),b		;a28c
	ld (ix+00eh),000h		;a28f
	ret			;a293
L_A294:
	ld a,(0e1c3h)		;a294
	and 003h		;a297
	ret nz			;a299
	call L_A229		;a29a
	ld bc,02723h		;a29d
	jr c,L_A2A5		;a2a0
	ld bc,02f2bh		;a2a2
L_A2A5:
	inc (ix+007h)		;a2a5
	ld a,(ix+007h)		;a2a8
	cp b			;a2ab
	ret c			;a2ac
	ld (ix+007h),c		;a2ad
	ret			;a2b0
L_A2B1:
	ld a,(0e354h)		;a2b1
	or a			;a2b4
	ret nz			;a2b5
	dec (ix+00ch)		;a2b6
	ret nz			;a2b9
	ld a,r		;a2ba
	and 007h		;a2bc
	inc a			;a2be
	ld c,a			;a2bf
	ld a,(ix+008h)		;a2c0
	cp 018h		;a2c3
	jr nc,L_A2CF		;a2c5
	sla c		;a2c7
	cp 008h		;a2c9
	jr nc,L_A2CF		;a2cb
	sla c		;a2cd
L_A2CF:
	ld (ix+00ch),c		;a2cf
	call L_A229		;a2d2
	ld e,014h		;a2d5
	jr c,L_A2DB		;a2d7
	ld e,00ch		;a2d9
L_A2DB:
	ld a,(ix+004h)		;a2db
	add a,e			;a2de
	ld e,a			;a2df
	ld a,(ix+006h)		;a2e0
	add a,018h		;a2e3
	ld d,a			;a2e5
	ld bc,00000h		;a2e6
	ld a,025h		;a2e9
	jp 04d16h		;a2eb
L_A2EE:
	ld de,00000h		;a2ee
	call 04efbh		;a2f1
	ld de,0fe80h		;a2f4
	jp 04f02h		;a2f7
L_A2FA:
	call 06770h		;a2fa
	ld a,(0e404h)		;a2fd
	sub (ix+004h)		;a300
	push af			;a303
	add a,003h		;a304
	cp 007h		;a306
	jr c,L_A321		;a308
	pop af			;a30a
	jr c,L_A317		;a30b
	ld a,070h		;a30d
	ld de,0fe80h		;a30f
	ld bc,00120h		;a312
	jr L_A335		;a315
L_A317:
	ld a,06ch		;a317
	ld de,0fe80h		;a319
	ld bc,0fee0h		;a31c
	jr L_A335		;a31f
L_A321:
	pop af			;a321
	ld a,(0e406h)		;a322
	sub (ix+006h)		;a325
	ld de,0fc80h		;a328
	jr c,L_A330		;a32b
	ld de,0fe80h		;a32d
L_A330:
	ld bc,00000h		;a330
	ld a,068h		;a333
L_A335:
	ld (ix+030h),a		;a335
	call 04f02h		;a338
	ld d,b			;a33b
	ld e,c			;a33c
	jp 04efbh		;a33d
L_A340:
	ld a,(ix+019h)		;a340
	and a			;a343
	jr z,L_A351		;a344
	cp 002h		;a346
	ld c,080h		;a348
	jr z,L_A34E		;a34a
	ld c,000h		;a34c
L_A34E:
	ld (ix+006h),c		;a34e
L_A351:
	call L_A35D		;a351
	ld (ix+026h),000h		;a354
	ld d,(ix+006h)		;a358
	jr L_A385		;a35b
L_A35D:
	xor a			;a35d
	ld (ix+02ah),a		;a35e
	ld (ix+02bh),a		;a361
	ret			;a364
L_A365:
	ld a,(ix+001h)		;a365
	and a			;a368
	jr z,L_A374		;a369
	dec (ix+025h)		;a36b
	ret nz			;a36e
	dec (ix+001h)		;a36f
	jr L_A37D		;a372
L_A374:
	dec (ix+025h)		;a374
	ret nz			;a377
	ld a,(ix+029h)		;a378
	and a			;a37b
	ret nz			;a37c
L_A37D:
	call L_A40E		;a37d
	call L_A385		;a380
	jr L_A3B7		;a383
L_A385:
	ld a,(ix+001h)		;a385
	cp 002h		;a388
	ret z			;a38a
	ld e,(ix+004h)		;a38b
	ld a,040h		;a38e
	call 04ebah		;a390
	xor a			;a393
	bit 7,(ix+008h)		;a394
	jr nz,L_A39B		;a398
	inc a			;a39a
L_A39B:
	ld c,(ix+027h)		;a39b
	ld (ix+02ah),c		;a39e
	ld (ix+027h),a		;a3a1
	xor a			;a3a4
	bit 7,(ix+00ah)		;a3a5
	jr nz,L_A3AC		;a3a9
	inc a			;a3ab
L_A3AC:
	ld c,(ix+028h)		;a3ac
	ld (ix+02bh),c		;a3af
	ld (ix+028h),a		;a3b2
	jr L_A402		;a3b5
L_A3B7:
	ld a,(ix+02ah)		;a3b7
	ld c,(ix+027h)		;a3ba
	xor c			;a3bd
	jr nz,L_A3E5		;a3be
	ld a,(ix+02bh)		;a3c0
	ld c,(ix+028h)		;a3c3
	xor c			;a3c6
	ret z			;a3c7
	inc (ix+001h)		;a3c8
	call 04f17h		;a3cb
	ld de,00180h		;a3ce
	ld b,001h		;a3d1
	ld a,(0e404h)		;a3d3
	cp (ix+004h)		;a3d6
	jr nc,L_A3DF		;a3d9
	dec b			;a3db
	call 05cadh		;a3dc
L_A3DF:
	ld (ix+027h),b		;a3df
	jp 04efbh		;a3e2
L_A3E5:
	inc (ix+001h)		;a3e5
	call 04f17h		;a3e8
	ld de,00180h		;a3eb
	ld b,001h		;a3ee
	ld a,(0e406h)		;a3f0
	cp (ix+006h)		;a3f3
	jr nc,L_A3FC		;a3f6
	dec b			;a3f8
	call 05cadh		;a3f9
L_A3FC:
	ld (ix+028h),b		;a3fc
	jp 04f02h		;a3ff
L_A402:
	call 0637bh		;a402
	and 003h		;a405
	ld c,008h		;a407
	add a,c			;a409
	ld (ix+025h),a		;a40a
	ret			;a40d
L_A40E:
	ld a,(ix+026h)		;a40e
	ld hl,0a43fh		;a411
	call 0407ah		;a414
	ld l,(hl)			;a417
	ld a,(ix+026h)		;a418
	inc a			;a41b
	and 007h		;a41c
	ld (ix+026h),a		;a41e
	ld a,(ix+001h)		;a421
	and a			;a424
	jr z,L_A439		;a425
	ld a,(0e404h)		;a427
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
	ld a,(ix+006h)		;a439
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


L_A447:
	ld a,r		;a447
	and 007h		;a449
	jr nz,L_A44F		;a44b
	ld a,008h		;a44d
L_A44F:
	ld (ix+025h),a		;a44f
	ld (ix+010h),017h		;a452
	ld a,r		;a456
	and 007h		;a458
	ld hl,0a48dh		;a45a
	call 0407ah		;a45d
	ld a,(0e228h)		;a460
	add a,a			;a463
	add a,(hl)			;a464
	ld b,a			;a465
	ld h,(ix+004h)		;a466
	ld l,000h		;a469
	ld a,r		;a46b
	and 003h		;a46d
	jr nz,L_A481		;a46f
	ld a,(0e406h)		;a471
	ld l,a			;a474
	ld a,(0e404h)		;a475
	ld c,a			;a478
	ld a,r		;a479
	and 03fh		;a47b
	sub 020h		;a47d
	add a,c			;a47f
	ld h,a			;a480
L_A481:
	ld a,b			;a481
	jp 04ed7h		;a482

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


L_A495:
	ld a,(ix+031h)		;a495
	xor 001h		;a498
	ld (ix+031h),a		;a49a
	call L_A4C9		;a49d
	ld h,(ix+006h)		;a4a0
	ld l,(ix+004h)		;a4a3
	call 05c92h		;a4a6
	call L_A4B0		;a4a9
	jp c,06514h		;a4ac
	ret			;a4af
L_A4B0:
	ld a,(0e305h)		;a4b0
	ld c,a			;a4b3
	ld a,(hl)			;a4b4
	and a			;a4b5
	jr z,L_A4BA		;a4b6
	cp c			;a4b8
	ret c			;a4b9
L_A4BA:
	ld a,(ix+006h)		;a4ba
	cp 0f8h		;a4bd
	ret nc			;a4bf
	ld de,00021h		;a4c0
	add hl,de			;a4c3
	ld a,(hl)			;a4c4
	and a			;a4c5
	ret z			;a4c6
	cp c			;a4c7
	ret			;a4c8
L_A4C9:
	dec (ix+025h)		;a4c9
	ret nz			;a4cc
	ld (ix+025h),008h		;a4cd
	ld a,(ix+030h)		;a4d1
	add a,004h		;a4d4
	cp 0e0h		;a4d6
	jr nz,L_A4DC		;a4d8
	ld a,0d4h		;a4da
L_A4DC:
	ld (ix+030h),a		;a4dc
	ret			;a4df
L_A4E0:
	ld (ix+013h),002h		;a4e0
	ld (ix+014h),002h		;a4e4
	ld (ix+002h),004h		;a4e8
	ld (ix+025h),00ah		;a4ec
	ld (ix+015h),008h		;a4f0
	ld b,039h		;a4f4
	ld a,(ix+019h)		;a4f6
	and a			;a4f9
	jr nz,L_A501		;a4fa
	inc b			;a4fc
	ld (ix+006h),008h		;a4fd
L_A501:
	ld (ix+032h),b		;a501
	ld (ix+00dh),003h		;a504
	jp 04f17h		;a508
L_A50B:
	ld a,(ix+001h)		;a50b
	and a			;a50e
	jr nz,L_A543		;a50f
	ld a,(ix+002h)		;a511
	cp 002h		;a514
	jr nz,L_A520		;a516
	ld a,(ix+00bh)		;a518
	xor 080h		;a51b
	ld (ix+00bh),a		;a51d
L_A520:
	dec (ix+002h)		;a520
	ret nz			;a523
	ld (ix+002h),004h		;a524
	dec (ix+025h)		;a528
	ret nz			;a52b
	inc (ix+001h)		;a52c
	set 7,(ix+00bh)		;a52f
	call 04f17h		;a533
	ld de,0fd00h		;a536
	ld a,(ix+019h)		;a539
	and a			;a53c
	call z,05cadh		;a53d
	jp 04f02h		;a540
L_A543:
	dec (ix+015h)		;a543
	ret nz			;a546
	jp L_BB44		;a547
L_A54A:
	ld a,(0e35ch)		;a54a
	ld (ix+027h),a		;a54d
	and a			;a550
	jr nz,L_A572		;a551
	push ix		;a553
	pop de			;a555
	ld hl,(0e35dh)		;a556
	inc l			;a559
	inc l			;a55a
	inc l			;a55b
	ld (hl),e			;a55c
	inc l			;a55d
	inc l			;a55e
	ld (hl),d			;a55f
L_A560:
	call 04f21h		;a560
	ld d,004h		;a563
	ld a,(0e35ah)		;a565
	rra			;a568
	call nc,05cadh		;a569
	call 04efbh		;a56c
	or 0ffh		;a56f
	ret			;a571
L_A572:
	ld hl,(0e35dh)		;a572
	inc l			;a575
	inc l			;a576
	inc l			;a577
	ld e,(hl)			;a578
	inc l			;a579
	inc l			;a57a
	ld d,(hl)			;a57b
	ex de,hl			;a57c
	ld a,005h		;a57d
	add a,l			;a57f
	ld l,a			;a580
	ld a,(hl)			;a581
	ld (ix+005h),a		;a582
	inc l			;a585
	ld a,(hl)			;a586
	ld (ix+006h),a		;a587
	inc l			;a58a
	ld (ix+025h),l		;a58b
	ld (ix+026h),h		;a58e
	jr L_A560		;a591
L_A593:
	call L_A612		;a593
	ld a,(ix+001h)		;a596
	and a			;a599
	jr nz,L_A5E4		;a59a
	ld a,(ix+027h)		;a59c
	and a			;a59f
	jr nz,L_A5EE		;a5a0
	ld a,(0e404h)		;a5a2
	bit 7,(ix+008h)		;a5a5
	jr nz,L_A5B1		;a5a9
	cp (ix+004h)		;a5ab
	ret nc			;a5ae
	jr L_A5B5		;a5af
L_A5B1:
	cp (ix+004h)		;a5b1
	ret c			;a5b4
L_A5B5:
	ld de,0fd00h		;a5b5
	ld a,(0e406h)		;a5b8
	cp (ix+006h)		;a5bb
	call nc,05cadh		;a5be
	call 04f02h		;a5c1
L_A5C4:
	inc (ix+001h)		;a5c4
	call L_A621		;a5c7
	ld bc,0ff80h		;a5ca
	ld a,(ix+027h)		;a5cd
	and a			;a5d0
	jr z,L_A5D9		;a5d1
	call 05cadh		;a5d3
	ld bc,00080h		;a5d6
L_A5D9:
	call 04efbh		;a5d9
	call 062b6h		;a5dc
	ld d,b			;a5df
	ld e,c			;a5e0
	jp 062a8h		;a5e1
L_A5E4:
	call 062c2h		;a5e4
	call 062e8h		;a5e7
	jp z,0629fh		;a5ea
	ret			;a5ed
L_A5EE:
	ld l,(ix+025h)		;a5ee
	ld h,(ix+026h)		;a5f1
	ld a,l			;a5f4
	ld c,l			;a5f5
	sub 007h		;a5f6
	ld l,a			;a5f8
	ld a,(hl)			;a5f9
	and a			;a5fa
	jr z,L_A60D		;a5fb
	ld l,c			;a5fd
	inc hl			;a5fe
	inc hl			;a5ff
	ld a,(hl)			;a600
	inc hl			;a601
	ld c,(hl)			;a602
	or c			;a603
	ret z			;a604
	ld d,(hl)			;a605
	dec hl			;a606
	ld e,(hl)			;a607
	call 04f02h		;a608
	jr L_A5C4		;a60b
L_A60D:
	ld (ix+027h),000h		;a60d
	ret			;a611
L_A612:
	ld a,(0e1c3h)		;a612
	and 007h		;a615
	ret nz			;a617
	ld a,(ix+030h)		;a618
	xor 004h		;a61b
	ld (ix+030h),a		;a61d
	ret			;a620
L_A621:
	ld hl,0a62ch		;a621
	ld a,(0e228h)		;a624
	srl a		;a627
	jp 04b67h		;a629

; ----------------------------------------------------------------------
; DATOS tabla_A62C: 8 palabras que p03:A621 lee con 0xE228 / 2 (L_4B67); lo
;   leen p03:A629 (16 bytes)
;   0xa62c..0xa63c  (16 bytes)
DATA_tabla_A62C:
	defw 00280h,00280h,00280h,00300h,00300h,00380h,00400h,00400h	; a62c

; ======================================================================
; CODIGO 0xa63c..0xa70d  (209 bytes)
; ======================================================================


L_A63C:
	call 04e93h		;a63c
	ld a,00ch		;a63f
	ld (ix+006h),a		;a641
	ld b,000h		;a644
	ld a,(ix+004h)		;a646
	cp 060h		;a649
	jr c,L_A64E		;a64b
	inc b			;a64d
L_A64E:
	ld (ix+025h),b		;a64e
	ld (ix+013h),002h		;a651
	ld (ix+014h),002h		;a655
L_A659:
	call 04f17h		;a659
	ld de,00400h		;a65c
	jp 04f02h		;a65f
L_A662:
	ld a,(0e20ah)		;a662
	and a			;a665
	call nz,L_A711		;a666
	call L_A704		;a669
	ld a,(ix+001h)		;a66c
	dec a			;a66f
	jr z,L_A69F		;a670
	dec a			;a672
	jr z,L_A6C2		;a673
	dec a			;a675
	jr z,L_A6E7		;a676
	dec a			;a678
	ret z			;a679
	ld bc,0b0b2h		;a67a
	ld a,(ix+025h)		;a67d
	and a			;a680
	jr z,L_A684		;a681
	ld b,c			;a683
L_A684:
	ld a,(ix+006h)		;a684
	cp b			;a687
	ret c			;a688
	inc (ix+001h)		;a689
	ld de,00400h		;a68c
	ld a,(ix+025h)		;a68f
	and a			;a692
	call nz,05cadh		;a693
	call 04efbh		;a696
	ld de,0fc00h		;a699
	jp 04f02h		;a69c
L_A69F:
	ld bc,08c90h		;a69f
	ld a,(ix+025h)		;a6a2
	and a			;a6a5
	jr z,L_A6A9		;a6a6
	ld b,c			;a6a8
L_A6A9:
	ld a,(ix+006h)		;a6a9
	cp b			;a6ac
	ret nc			;a6ad
	ld a,(ix+004h)		;a6ae
	and 0f8h		;a6b1
	ld (ix+004h),a		;a6b3
	inc (ix+001h)		;a6b6
	call 04f17h		;a6b9
	ld de,0fc00h		;a6bc
	jp 04f02h		;a6bf
L_A6C2:
	ld bc,05458h		;a6c2
	ld a,(ix+025h)		;a6c5
	and a			;a6c8
	jr z,L_A6CC		;a6c9
	ld b,c			;a6cb
L_A6CC:
	ld a,(ix+006h)		;a6cc
	cp b			;a6cf
	ret nc			;a6d0
	inc (ix+001h)		;a6d1
	ld de,00400h		;a6d4
	ld a,(ix+025h)		;a6d7
	and a			;a6da
	call nz,05cadh		;a6db
	call 04efbh		;a6de
	ld de,00400h		;a6e1
	jp 04f02h		;a6e4
L_A6E7:
	ld bc,07478h		;a6e7
	ld a,(ix+025h)		;a6ea
	and a			;a6ed
	jr z,L_A6F1		;a6ee
	ld b,c			;a6f0
L_A6F1:
	ld a,(ix+006h)		;a6f1
	cp b			;a6f4
	ret c			;a6f5
	ld a,(ix+004h)		;a6f6
	and 0f8h		;a6f9
	ld (ix+004h),a		;a6fb
	inc (ix+001h)		;a6fe
	jp L_A659		;a701
L_A704:
	ld bc,00304h		;a704
	ld hl,0a70dh		;a707
	jp 06361h		;a70a

; ----------------------------------------------------------------------
; DATOS tabla_A70D: 4 bytes que p03:A704 pasa a L_6361 (BC = 0x0304); lo leen
;   p03:A707 (4 bytes)
;   0xa70d..0xa711  (4 bytes)
DATA_tabla_A70D:
	defb 021h,022h,023h,024h	; a70d

; ======================================================================
; CODIGO 0xa711..0xa741  (48 bytes)
; ======================================================================


L_A711:
	dec (ix+015h)		;a711
	ret nz			;a714
	call 04e93h		;a715
	jp L_BB44		;a718
L_A71B:
	ld (ix+024h),001h		;a71b
	call 04c24h		;a71f
	and 006h		;a722
	ld b,a			;a724
	add a,a			;a725
	add a,b			;a726
	ld hl,0a741h		;a727
	call 0407ah		;a72a
	ld e,(hl)			;a72d
	inc hl			;a72e
	ld d,(hl)			;a72f
	inc hl			;a730
	call 04efbh		;a731
	ld e,(hl)			;a734
	inc hl			;a735
	ld d,(hl)			;a736
	inc hl			;a737
	call 04f02h		;a738
	ld e,(hl)			;a73b
	inc hl			;a73c
	ld d,(hl)			;a73d
	jp 062a8h		;a73e

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


L_A759:
	ld bc,(0e3c7h)		;a759
	ld de,00000h		;a75d
	call L_A93F		;a760
	jr L_A78C		;a763
L_A765:
	ld a,(0e3d0h)		;a765
	or a			;a768
	ret nz			;a769
	ld a,(0e400h)		;a76a
	or a			;a76d
	jp m,L_A9AC		;a76e
	ret z			;a771
	ld a,(0e22bh)		;a772
	or a			;a775
	jr nz,L_A78C		;a776
	ld a,(0e3bfh)		;a778
	or a			;a77b
	jr nz,L_A759		;a77c
	ld a,(0e3c0h)		;a77e
	or a			;a781
	ret nz			;a782
	call L_A902		;a783
	call L_A93F		;a786
	call L_A8C5		;a789
L_A78C:
	call L_A82E		;a78c
	ld a,(0e400h)		;a78f
	cp 003h		;a792
	jp z,L_A7BE		;a794
	ld bc,0e1c9h		;a797
L_A79A:
	ld a,(0f0f5h)		;a79a
	bit 2,a		;a79d
	jr nz,L_A7F8		;a79f
	ld a,(bc)			;a7a1
	and 003h		;a7a2
	cp 003h		;a7a4
	jp nz,L_A7AA		;a7a6
	xor a			;a7a9
L_A7AA:
	add a,a			;a7aa
	add a,a			;a7ab
	ld c,a			;a7ac
	ld a,(0e400h)		;a7ad
	dec a			;a7b0
	jr z,L_A7BE		;a7b1
	ld a,(0e1c3h)		;a7b3
	and 004h		;a7b6
	jr z,L_A7BE		;a7b8
	ld a,c			;a7ba
	add a,00ch		;a7bb
	ld c,a			;a7bd
L_A7BE:
	ld b,000h		;a7be
	add hl,bc			;a7c0
L_A7C1:
	ld de,0e407h		;a7c1
	ldi		;a7c4
	ldi		;a7c6
	ldi		;a7c8
	ldi		;a7ca
	ld a,(0e400h)		;a7cc
	cp 002h		;a7cf
	jr nz,L_A7E7		;a7d1
	ld a,(0e401h)		;a7d3
	dec a			;a7d6
	jr nz,L_A7E7		;a7d7
	ld a,(0e1c3h)		;a7d9
	bit 1,a		;a7dc
	ld a,006h		;a7de
	jr z,L_A7E4		;a7e0
	ld a,009h		;a7e2
L_A7E4:
	ld (0e40ah),a		;a7e4
L_A7E7:
	ld a,(0e446h)		;a7e7
	or a			;a7ea
	ret z			;a7eb
L_A7EC:
	ld a,003h		;a7ec
	ld (0e408h),a		;a7ee
	ret			;a7f1
L_A7F2:
	ld hl,0a8adh		;a7f2
	jp L_A7C1		;a7f5
L_A7F8:
	ld de,0e407h		;a7f8
	ldi		;a7fb
	ldi		;a7fd
	ldi		;a7ff
	ldi		;a801
	ld a,(0e446h)		;a803
	or a			;a806
	jr nz,L_A7EC		;a807
	ld a,(0e400h)		;a809
	ld b,00ah		;a80c
	cp 003h		;a80e
	jr z,L_A828		;a810
	cp 002h		;a812
	ret nz			;a814
	ld a,(0e401h)		;a815
	dec a			;a818
	ld b,002h		;a819
	jr nz,L_A828		;a81b
	ld a,(0e1c3h)		;a81d
	bit 1,a		;a820
	ld b,006h		;a822
	jr z,L_A828		;a824
	ld b,009h		;a826
L_A828:
	ld a,b			;a828
	ld (0e40ah),a		;a829
	jr L_A7E7		;a82c
L_A82E:
	ld a,(0e400h)		;a82e
	cp 003h		;a831
	jr z,L_A846		;a833
	ld b,a			;a835
	ld a,(0f0f5h)		;a836
	bit 2,a		;a839
	jr nz,L_A862		;a83b
	dec b			;a83d
	ld hl,0a889h		;a83e
	ret z			;a841
	ld hl,0a895h		;a842
	ret			;a845
L_A846:
	ld hl,0e440h		;a846
	dec (hl)			;a849
	jr nz,L_A85E		;a84a
	ld (hl),003h		;a84c
	inc l			;a84e
	inc (hl)			;a84f
	ld a,(hl)			;a850
	cp 006h		;a851
	jr c,L_A857		;a853
	xor a			;a855
	ld (hl),a			;a856
L_A857:
	ld hl,0a8adh		;a857
	add a,a			;a85a
	add a,a			;a85b
	ld c,a			;a85c
	ret			;a85d
L_A85E:
	inc l			;a85e
	ld a,(hl)			;a85f
	jr L_A857		;a860
L_A862:
	ld a,(0e1c2h)		;a862
	add a,a			;a865
	ld hl,0a879h		;a866
	jr nc,L_A86E		;a869
	ld hl,0a881h		;a86b
L_A86E:
	ld a,(0e1c3h)		;a86e
	bit 3,a		;a871
	ret z			;a873
	ld de,00004h		;a874
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


L_A8C5:
	ld hl,0e406h		;a8c5
	ld a,(hl)			;a8c8
	cp 008h		;a8c9
	jr nc,L_A8CF		;a8cb
	ld a,008h		;a8cd
L_A8CF:
	cp 0d9h		;a8cf
	jr c,L_A8D5		;a8d1
	ld a,0d8h		;a8d3
L_A8D5:
	ld (hl),a			;a8d5
	dec l			;a8d6
	dec l			;a8d7
	ld a,(hl)			;a8d8
	add a,010h		;a8d9
	ld c,a			;a8db
	ld a,(0e201h)		;a8dc
	or a			;a8df
	jr z,L_A8F7		;a8e0
	cp 004h		;a8e2
	jr nc,L_A8F7		;a8e4
	ld a,c			;a8e6
	cp 013h		;a8e7
	jr nc,L_A8ED		;a8e9
	ld a,013h		;a8eb
L_A8ED:
	cp 0b6h		;a8ed
	jr c,L_A8F3		;a8ef
	ld a,0b5h		;a8f1
L_A8F3:
	sub 010h		;a8f3
	ld (hl),a			;a8f5
	ret			;a8f6
L_A8F7:
	ld a,c			;a8f7
	cp 010h		;a8f8
	jp nc,L_A8FF		;a8fa
	ld a,010h		;a8fd
L_A8FF:
	jp L_A8ED		;a8ff
L_A902:
	ld a,(0e1c9h)		;a902
	and 00fh		;a905
	add a,a			;a907
	add a,a			;a908
	ld c,a			;a909
	ld b,000h		;a90a
	ld hl,0a94eh		;a90c
	add hl,bc			;a90f
	ld e,(hl)			;a910
	inc hl			;a911
	ld d,(hl)			;a912
	inc hl			;a913
	ld c,(hl)			;a914
	inc hl			;a915
	ld b,(hl)			;a916
	ld (0f002h),bc		;a917
	ld a,(0e402h)		;a91b
	add a,003h		;a91e
	ld (0f000h),a		;a920
	ld b,a			;a923
	ld l,e			;a924
	ld h,d			;a925
L_A926:
	add hl,de			;a926
	djnz L_A926		;a927
	ld (0f004h),hl		;a929
	ld hl,(0f002h)		;a92c
	ld e,l			;a92f
	ld d,h			;a930
	ld a,(0f000h)		;a931
	ld b,a			;a934
L_A935:
	add hl,de			;a935
	djnz L_A935		;a936
	ld c,l			;a938
	ld b,h			;a939
	ld de,(0f004h)		;a93a
	ret			;a93e
L_A93F:
	ld hl,(0e403h)		;a93f
	add hl,de			;a942
	ld (0e403h),hl		;a943
	ld hl,(0e405h)		;a946
	add hl,bc			;a949
	ld (0e405h),hl		;a94a
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


L_A98E:
	xor a			;a98e
	ld (0e1d3h),a		;a98f
	ret			;a992
L_A993:
	ld hl,0e400h		;a993
	ld a,(hl)			;a996
	or a			;a997
	ret m			;a998
	xor a			;a999
	ld (0e44eh),a		;a99a
	dec a			;a99d
	ld (hl),a			;a99e
	ld (0e410h),a		;a99f
	ld (0e420h),a		;a9a2
	xor a			;a9a5
	call L_A9B8		;a9a6
	jp 042ddh		;a9a9
L_A9AC:
	ld hl,0e44fh		;a9ac
	dec (hl)			;a9af
	ret nz			;a9b0
	dec l			;a9b1
	inc (hl)			;a9b2
	ld a,(hl)			;a9b3
	cp 004h		;a9b4
	jr nc,L_A98E		;a9b6
L_A9B8:
	ld hl,0a9f4h		;a9b8
	call 04b67h		;a9bb
	ex de,hl			;a9be
	ld a,(hl)			;a9bf
	ld (0e44fh),a		;a9c0
	inc hl			;a9c3
	ld a,(0e404h)		;a9c4
	ld c,a			;a9c7
	ld a,(0e406h)		;a9c8
	ld b,a			;a9cb
	ld de,0e418h		;a9cc
	call L_A9E1		;a9cf
	ld de,0e41ch		;a9d2
	call L_A9E1		;a9d5
	ld de,0e428h		;a9d8
	call L_A9E1		;a9db
	ld de,0e42ch		;a9de
L_A9E1:
	ld a,(hl)			;a9e1
	add a,c			;a9e2
	ld (de),a			;a9e3
	inc hl			;a9e4
	inc de			;a9e5
	ld a,(hl)			;a9e6
	add a,b			;a9e7
	ld (de),a			;a9e8
	inc hl			;a9e9
	inc de			;a9ea
	ld a,(hl)			;a9eb
	ld (de),a			;a9ec
	inc hl			;a9ed
	inc de			;a9ee
	ld a,(hl)			;a9ef
	ld (de),a			;a9f0
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


L_AA2F:
	ld de,0e450h		;aa2f
	ld a,010h		;aa32
L_AA34:
	ld hl,0e404h		;aa34
	ldi		;aa37
	inc l			;aa39
	ldi		;aa3a
	dec a			;aa3c
	jr nz,L_AA34		;aa3d
	ld (0e40eh),a		;aa3f
	ret			;aa42
L_AA43:
	ld a,(0e40bh)		;aa43
	dec a			;aa46
	ld hl,0e410h		;aa47
	jr z,L_AA4E		;aa4a
	ld l,020h		;aa4c
L_AA4E:
	ld (hl),001h		;aa4e
	jp L_AAEC		;aa50
L_AA53:
	ld a,(0e400h)		;aa53
	dec a			;aa56
	ret m			;aa57
	ld a,(0e40bh)		;aa58
	or a			;aa5b
	ret z			;aa5c
	ld a,(0f0f5h)		;aa5d
	bit 2,a		;aa60
	ld b,002h		;aa62
	jr z,L_AA68		;aa64
	ld b,004h		;aa66
L_AA68:
	ld hl,0e40ch		;aa68
	inc (hl)			;aa6b
	ld a,(hl)			;aa6c
	cp b			;aa6d
	ret c			;aa6e
	ld (hl),000h		;aa6f
	inc l			;aa71
	inc (hl)			;aa72
	ld a,(0e40bh)		;aa73
	dec a			;aa76
	jr z,L_AA7F		;aa77
	ld de,0e427h		;aa79
	call L_AA82		;aa7c
L_AA7F:
	ld de,0e417h		;aa7f
L_AA82:
	ld a,(0e40dh)		;aa82
	and 003h		;aa85
	add a,a			;aa87
	ld hl,0aa93h		;aa88
	call 0407ah		;aa8b
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


L_AA9B:
	ld a,(0e400h)		;aa9b
	dec a			;aa9e
	ret m			;aa9f
	ld a,(0e3d0h)		;aaa0
	or a			;aaa3
	ret nz			;aaa4
	ld a,(0e22bh)		;aaa5
	or a			;aaa8
	ret nz			;aaa9
	ld a,(0e439h)		;aaaa
	cp 003h		;aaad
	ret z			;aaaf
	ld hl,0e3c2h		;aab0
	ld a,(0e3c0h)		;aab3
	or a			;aab6
	jr nz,L_AAC2		;aab7
	ld a,(0e3bfh)		;aab9
	or a			;aabc
	jr nz,L_AAC2		;aabd
	ld hl,0e1c9h		;aabf
L_AAC2:
	ld a,(hl)			;aac2
	and 00fh		;aac3
	ret z			;aac5
	cp 003h		;aac6
	ret z			;aac8
	cp 00ch		;aac9
	ret z			;aacb
	cp 00fh		;aacc
	ret z			;aace
	ld hl,0e450h		;aacf
	ld a,(0e40eh)		;aad2
	add a,a			;aad5
	add a,l			;aad6
	ld l,a			;aad7
	ld a,(0e404h)		;aad8
	ld (hl),a			;aadb
	ld a,(0e406h)		;aadc
	inc l			;aadf
	ld (hl),a			;aae0
	ld hl,0e40eh		;aae1
	inc (hl)			;aae4
	ld a,(hl)			;aae5
	cp 010h		;aae6
	jr c,L_AAEC		;aae8
	ld (hl),000h		;aaea
L_AAEC:
	ld hl,0e40eh		;aaec
	ld a,(0e40bh)		;aaef
	dec a			;aaf2
	ret m			;aaf3
	jr z,L_AAFD		;aaf4
	ld bc,0e424h		;aaf6
	ld a,(hl)			;aaf9
	call L_AB07		;aafa
L_AAFD:
	ld bc,0e414h		;aafd
	ld a,(hl)			;ab00
	sub 008h		;ab01
	jr nc,L_AB07		;ab03
	add a,010h		;ab05
L_AB07:
	add a,a			;ab07
	ld de,0e450h		;ab08
	add a,e			;ab0b
	ld e,a			;ab0c
	ld a,(de)			;ab0d
	ld (bc),a			;ab0e
	inc e			;ab0f
	inc c			;ab10
	inc c			;ab11
	ld a,(de)			;ab12
	ld (bc),a			;ab13
	ret			;ab14
L_AB15:
	ld a,(0e400h)		;ab15
	dec a			;ab18
	ret m			;ab19
	ld a,(0e439h)		;ab1a
	cp 003h		;ab1d
	ret nz			;ab1f
	ld a,(0e40bh)		;ab20
	dec a			;ab23
	ret m			;ab24
	jr z,L_AB34		;ab25
	exx			;ab27
	ld hl,0e424h		;ab28
	exx			;ab2b
	ld a,(0e1c3h)		;ab2c
	and 00fh		;ab2f
	call L_AB44		;ab31
L_AB34:
	exx			;ab34
	ld hl,0e414h		;ab35
	exx			;ab38
	ld a,(0e1c3h)		;ab39
	and 00fh		;ab3c
	sub 008h		;ab3e
	jr nc,L_AB44		;ab40
	add a,010h		;ab42
L_AB44:
	ld hl,0e404h		;ab44
	ld de,0ab72h		;ab47
	add a,a			;ab4a
	call 0407fh		;ab4b
	ld a,(de)			;ab4e
	add a,(hl)			;ab4f
	inc l			;ab50
	inc l			;ab51
	exx			;ab52
	ld (hl),a			;ab53
	inc l			;ab54
	inc l			;ab55
	exx			;ab56
	inc de			;ab57
	ld a,(de)			;ab58
	or a			;ab59
	jp p,L_AB69		;ab5a
	neg		;ab5d
	ld d,a			;ab5f
	ld a,(hl)			;ab60
	sub d			;ab61
	jr nc,L_AB65		;ab62
	xor a			;ab64
L_AB65:
	exx			;ab65
	ld (hl),a			;ab66
	exx			;ab67
	ret			;ab68
L_AB69:
	ld a,(de)			;ab69
	add a,(hl)			;ab6a
	jr nc,L_AB65		;ab6b
	ld a,0f8h		;ab6d
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


L_AB92:
	ld iy,0e470h		;ab92
	ld b,009h		;ab96
L_AB98:
	push bc			;ab98
	call L_ABA5		;ab99
	ld bc,00010h		;ab9c
	add iy,bc		;ab9f
	pop bc			;aba1
	djnz L_AB98		;aba2
	ret			;aba4
L_ABA5:
	ld a,(iy+000h)		;aba5
	or a			;aba8
	ret z			;aba9
	ld b,a			;abaa
	sub 007h		;abab
	jr c,L_ABBD		;abad
	sub 002h		;abaf
	jr z,L_ABBD		;abb1
	sub 005h		;abb3
	cp 002h		;abb5
	jr c,L_ABBD		;abb7
	ld hl,082feh		;abb9
	push hl			;abbc
L_ABBD:
	ld a,b			;abbd
	dec a			;abbe
	call 04084h		;abbf

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


L_ABE0:
	xor a			;abe0
	ld (0e437h),a		;abe1
	ret			;abe4
L_ABE5:
	ld a,(0e400h)		;abe5
	dec a			;abe8
	ret m			;abe9
	ld a,(0e3d0h)		;abea
	or a			;abed
	ret nz			;abee
	ld a,(0e22bh)		;abef
	or a			;abf2
	ret nz			;abf3
	ld a,(0e3c0h)		;abf4
	or a			;abf7
	ret nz			;abf8
	ld a,(0e1c8h)		;abf9
	and 010h		;abfc
	jr nz,L_AC0F		;abfe
	ld a,(0e1c9h)		;ac00
	and 010h		;ac03
	jr z,L_ABE0		;ac05
	ld hl,0e437h		;ac07
	inc (hl)			;ac0a
	ld a,(hl)			;ac0b
	cp 00fh		;ac0c
	ret c			;ac0e
L_AC0F:
	call L_ABE0		;ac0f
	ld ix,0e400h		;ac12
	exx			;ac16
	ld de,00300h		;ac17
L_AC1A:
	exx			;ac1a
	ld a,(ix+000h)		;ac1b
	or a			;ac1e
	call nz,L_AC30		;ac1f
	ld bc,00010h		;ac22
	add ix,bc		;ac25
	exx			;ac27
	ld a,e			;ac28
	add a,020h		;ac29
	ld e,a			;ac2b
	dec d			;ac2c
	jr nz,L_AC1A		;ac2d
	ret			;ac2f
L_AC30:
	ld a,(0e439h)		;ac30
	cp 007h		;ac33
	push af			;ac35
	call z,L_AF04		;ac36
	pop af			;ac39
	jr z,L_AC58		;ac3a
	ld a,(0e430h)		;ac3c
	or a			;ac3f
	call nz,L_AC7D		;ac40
	ld a,(0e431h)		;ac43
	or a			;ac46
	call nz,L_ACF6		;ac47
	ld a,(0e432h)		;ac4a
	or a			;ac4d
	call nz,L_AD36		;ac4e
	ld a,(0e436h)		;ac51
	or a			;ac54
	call nz,L_AC6E		;ac55
L_AC58:
	ld a,(0e433h)		;ac58
	or a			;ac5b
	call nz,L_B0B4		;ac5c
	ld a,(0e434h)		;ac5f
	or a			;ac62
	call nz,L_ADBA		;ac63
	ld a,(0e435h)		;ac66
	or a			;ac69
	call nz,L_ADEF		;ac6a
	ret			;ac6d
L_AC6E:
	ld hl,0e480h		;ac6e
	call L_B20E		;ac71
	ret nz			;ac74
	ld (hl),002h		;ac75
	inc l			;ac77
	ld de,00800h		;ac78
	jr L_ACBB		;ac7b
L_AC7D:
	dec a			;ac7d
	jr z,L_AC9A		;ac7e
	ld hl,0e470h		;ac80
	call L_B20E		;ac83
	jr z,L_ACB5		;ac86
	ld hl,0e480h		;ac88
	call L_B20E		;ac8b
	jr z,L_ACB5		;ac8e
	ret			;ac90
L_AC91:
	ld hl,0e470h		;ac91
	call L_B20E		;ac94
	ret nz			;ac97
	jr L_ACB5		;ac98
L_AC9A:
	ld a,(0e431h)		;ac9a
	or a			;ac9d
	jr z,L_AC91		;ac9e
	ld hl,0e470h		;aca0
	call L_B20E		;aca3
	jr nz,L_ACEC		;aca6
	push hl			;aca8
	ld bc,00010h		;aca9
	add hl,bc			;acac
	ld a,(hl)			;acad
	or a			;acae
	pop hl			;acaf
	jr nz,L_ACEC		;acb0
	call L_ACF0		;acb2
L_ACB5:
	ld (hl),001h		;acb5
	inc l			;acb7
	ld de,00808h		;acb8
L_ACBB:
	call L_B224		;acbb
	and 0f8h		;acbe
	ld (hl),a			;acc0
	ld d,0f6h		;acc1
	call L_B233		;acc3
	ld a,l			;acc6
	add a,006h		;acc7
	ld l,a			;acc9
	ld (hl),008h		;acca
	inc l			;accc
	ld (hl),002h		;accd
	ld a,001h		;accf
	jp 04ae4h		;acd1
L_ACD4:
	ld a,(iy+005h)		;acd4
	add a,00ch		;acd7
	jp c,L_AE02		;acd9
	ld (iy+005h),a		;acdc
	ret			;acdf
L_ACE0:
	ld a,(iy+005h)		;ace0
	sub 00ch		;ace3
	jp c,L_AE02		;ace5
	ld (iy+005h),a		;ace8
	ret			;aceb
L_ACEC:
	ld a,001h		;acec
	jr L_ACF2		;acee
L_ACF0:
	ld a,000h		;acf0
L_ACF2:
	ld (0e438h),a		;acf2
	ret			;acf5
L_ACF6:
	ld a,(0e438h)		;acf6
	or a			;acf9
	ret nz			;acfa
	ld hl,0e480h		;acfb
	call L_B20E		;acfe
	ret nz			;ad01
	ld (hl),003h		;ad02
	inc l			;ad04
	ld de,00808h		;ad05
	call L_B224		;ad08
	inc l			;ad0b
	ld (hl),018h		;ad0c
	inc l			;ad0e
	ld (hl),007h		;ad0f
	ld a,l			;ad11
	add a,005h		;ad12
	ld l,a			;ad14
	ld (hl),008h		;ad15
	inc l			;ad17
	ld (hl),002h		;ad18
	ld a,002h		;ad1a
	jp 04ae4h		;ad1c
L_AD1F:
	ld a,(iy+003h)		;ad1f
	sub 006h		;ad22
	jp c,L_AE02		;ad24
	ld (iy+003h),a		;ad27
	ld a,(iy+005h)		;ad2a
	add a,006h		;ad2d
	jp c,L_AE02		;ad2f
	ld (iy+005h),a		;ad32
	ret			;ad35
L_AD36:
	ld hl,0e470h		;ad36
	call L_B20E		;ad39
	ret nz			;ad3c
	ld a,(0e432h)		;ad3d
	sub 003h		;ad40
	jr c,L_AD50		;ad42
	jr z,L_AD85		;ad44
	dec a			;ad46
	dec a			;ad47
	jp z,L_AF77		;ad48
	dec a			;ad4b
	jp z,L_B000		;ad4c
	ret			;ad4f
L_AD50:
	ld (hl),007h		;ad50
	inc l			;ad52
	ld (hl),000h		;ad53
	ld de,00810h		;ad55
	call L_B224		;ad58
	and 0f8h		;ad5b
	ld (hl),a			;ad5d
	ld d,0fah		;ad5e
	call L_B233		;ad60
	inc l			;ad63
	inc l			;ad64
	push ix		;ad65
	pop bc			;ad67
	ld (hl),c			;ad68
	inc l			;ad69
	ld (hl),b			;ad6a
	inc l			;ad6b
	ld (hl),000h		;ad6c
	inc l			;ad6e
	ld a,(0e432h)		;ad6f
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
	ld a,003h		;ad80
	jp 04ae4h		;ad82
L_AD85:
	ld (hl),008h		;ad85
	inc l			;ad87
	ld (hl),000h		;ad88
	ld a,(ix+004h)		;ad8a
	add a,008h		;ad8d
	and 0f8h		;ad8f
	inc l			;ad91
	inc l			;ad92
	ld (hl),a			;ad93
	ld a,(ix+006h)		;ad94
	add a,010h		;ad97
	and 0f8h		;ad99
	inc l			;ad9b
	inc l			;ad9c
	ld (hl),a			;ad9d
	inc l			;ad9e
	ld (hl),0f1h		;ad9f
	inc l			;ada1
	inc l			;ada2
	push ix		;ada3
	pop bc			;ada5
	ld (hl),c			;ada6
	inc l			;ada7
	ld (hl),b			;ada8
	inc l			;ada9
	ld (hl),000h		;adaa
	inc l			;adac
	ld (hl),01ch		;adad
	inc l			;adaf
	ld (hl),000h		;adb0
	inc l			;adb2
	ld (hl),008h		;adb3
	ld a,01ah		;adb5
	jp 04ae4h		;adb7
L_ADBA:
	ld hl,0e480h		;adba
	call L_B20E		;adbd
	ret nz			;adc0
	ld a,(0e434h)		;adc1
	dec a			;adc4
	ld a,00ah		;adc5
	jr z,L_ADCB		;adc7
	ld a,00ch		;adc9
L_ADCB:
	ld (hl),a			;adcb
	inc l			;adcc
	ld (hl),004h		;adcd
	ld de,00800h		;adcf
	call L_B224		;add2
	and 0f8h		;add5
	ld (hl),a			;add7
	ld d,0fah		;add8
	call L_B233		;adda
	ld a,l			;addd
	add a,004h		;adde
	ld l,a			;ade0
	ld (hl),002h		;ade1
	inc l			;ade3
	inc l			;ade4
	ld (hl),010h		;ade5
	inc l			;ade7
	ld (hl),008h		;ade8
	ld a,00eh		;adea
	jp 04ae4h		;adec
L_ADEF:
	ld hl,0e480h		;adef
	call L_B20E		;adf2
	ret nz			;adf5
	ld a,(0e435h)		;adf6
	dec a			;adf9
	ld a,00bh		;adfa
	jr z,L_ADCB		;adfc
	ld a,00dh		;adfe
	jr L_ADCB		;ae00
L_AE02:
	ld (iy+000h),000h		;ae02
	ret			;ae06
L_AE07:
	push iy		;ae07
	pop hl			;ae09
	inc l			;ae0a
	ld a,(hl)			;ae0b
	dec a			;ae0c
	jr z,L_AE5C		;ae0d
	jp p,L_AE6B		;ae0f
	ld c,(iy+008h)		;ae12
	ld b,(iy+009h)		;ae15
	push bc			;ae18
	pop ix		;ae19
	ld de,00810h		;ae1b
	call L_B224		;ae1e
	and 0f8h		;ae21
	cp 0f8h		;ae23
	jr nc,L_AE02		;ae25
	ld (hl),a			;ae27
	ld d,0fah		;ae28
	call L_B233		;ae2a
	ld a,004h		;ae2d
L_AE2F:
	add a,l			;ae2f
	ld l,a			;ae30
	ld b,004h		;ae31
L_AE33:
	inc (hl)			;ae33
	inc l			;ae34
	dec (hl)			;ae35
	jr z,L_AE3D		;ae36
	dec l			;ae38
	djnz L_AE33		;ae39
	jr L_AE40		;ae3b
L_AE3D:
	inc (iy+001h)		;ae3d
L_AE40:
	ld a,(iy+00ah)		;ae40
	add a,a			;ae43
	add a,a			;ae44
	add a,a			;ae45
	neg		;ae46
	sub (iy+005h)		;ae48
	ret nc			;ae4b
	neg		;ae4c
	rra			;ae4e
	rra			;ae4f
	rra			;ae50
	and 01fh		;ae51
	sub (iy+00ah)		;ae53
	neg		;ae56
	ld (iy+00ah),a		;ae58
	ret			;ae5b
L_AE5C:
	call L_AE7C		;ae5c
	jr c,L_AE02		;ae5f
	call L_AE40		;ae61
	ld a,(iy+00ah)		;ae64
	or a			;ae67
	ret nz			;ae68
	jr L_AE02		;ae69
L_AE6B:
	call L_AE7C		;ae6b
	jr c,L_AE02		;ae6e
	ld a,(iy+00ah)		;ae70
	sub 005h		;ae73
	jr c,L_AE02		;ae75
	inc a			;ae77
	ld (iy+00ah),a		;ae78
	ret			;ae7b
L_AE7C:
	ld a,(iy+005h)		;ae7c
	add a,020h		;ae7f
	ld (iy+005h),a		;ae81
	ret			;ae84
L_AE85:
	push iy		;ae85
	pop hl			;ae87
	inc l			;ae88
	ld a,(hl)			;ae89
	dec a			;ae8a
	jr z,L_AE5C		;ae8b
	jp p,L_AE6B		;ae8d
	ld c,(iy+008h)		;ae90
	ld b,(iy+009h)		;ae93
	push bc			;ae96
	pop ix		;ae97
	ld a,(ix+004h)		;ae99
	add a,008h		;ae9c
	and 0f8h		;ae9e
	inc l			;aea0
	inc l			;aea1
	ld (hl),a			;aea2
	ld a,(ix+006h)		;aea3
	add a,010h		;aea6
	and 0f8h		;aea8
	cp 0f8h		;aeaa
	jp nc,L_AE02		;aeac
	inc l			;aeaf
	inc l			;aeb0
	ld (hl),a			;aeb1
	ld a,005h		;aeb2
	jp L_AE2F		;aeb4
L_AEB7:
	push iy		;aeb7
	pop hl			;aeb9
	inc l			;aeba
	inc l			;aebb
	inc l			;aebc
	ld a,(hl)			;aebd
	sub 006h		;aebe
	jp c,L_AE02		;aec0
L_AEC3:
	ld (hl),a			;aec3
	inc l			;aec4
	inc l			;aec5
	ld d,0fah		;aec6
	jp L_B236		;aec8
L_AECB:
	push iy		;aecb
	pop hl			;aecd
	inc l			;aece
	inc l			;aecf
	inc l			;aed0
	ld a,(hl)			;aed1
	add a,006h		;aed2
	cp 0b0h		;aed4
	jp nc,L_AE02		;aed6
	jr L_AEC3		;aed9
L_AEDB:
	call L_AEB7		;aedb
L_AEDE:
	dec (iy+001h)		;aede
	ret nz			;aee1
	ld (iy+001h),004h		;aee2
	ld a,(iy+005h)		;aee6
	or a			;aee9
	ld b,001h		;aeea
	jr z,L_AEF4		;aeec
	inc b			;aeee
	sub 008h		;aeef
	ld (iy+005h),a		;aef1
L_AEF4:
	ld a,(iy+00ah)		;aef4
	add a,b			;aef7
	ld (iy+00ah),a		;aef8
	jp L_AE40		;aefb
L_AEFE:
	call L_AECB		;aefe
	jp L_AEDE		;af01
L_AF04:
	ld hl,0e470h		;af04
	call L_B20E		;af07
	ret nz			;af0a
	ld (hl),009h		;af0b
	inc l			;af0d
	ld (hl),004h		;af0e
	ld a,(ix+004h)		;af10
	inc l			;af13
	inc l			;af14
	and 0f8h		;af15
	ld (hl),a			;af17
	ld a,(ix+006h)		;af18
	add a,010h		;af1b
	inc l			;af1d
	inc l			;af1e
	and 0f8h		;af1f
	ld (hl),a			;af21
	inc l			;af22
	ld (hl),0f2h		;af23
	inc l			;af25
	inc l			;af26
	inc l			;af27
	inc l			;af28
	ld (hl),002h		;af29
	inc l			;af2b
	inc l			;af2c
	ld (hl),010h		;af2d
	inc l			;af2f
	ld (hl),010h		;af30
	ld a,01dh		;af32
	jp 04ae4h		;af34
L_AF37:
	ld a,(iy+005h)		;af37
	add a,008h		;af3a
	jp c,L_AE02		;af3c
	ld (iy+005h),a		;af3f
	dec (iy+001h)		;af42
	ret nz			;af45
	ld (iy+001h),004h		;af46
	ld a,(iy+003h)		;af4a
	or a			;af4d
	ld b,001h		;af4e
	jr z,L_AF58		;af50
	inc b			;af52
	sub 008h		;af53
	ld (iy+003h),a		;af55
L_AF58:
	ld a,(iy+00ah)		;af58
	add a,b			;af5b
	ld (iy+00ah),a		;af5c
	ld a,(iy+003h)		;af5f
	rra			;af62
	rra			;af63
	rra			;af64
	and 01fh		;af65
	add a,(iy+00ah)		;af67
	sub 017h		;af6a
	ret c			;af6c
	inc a			;af6d
	neg		;af6e
	add a,(iy+00ah)		;af70
	ld (iy+00ah),a		;af73
	ret			;af76
L_AF77:
	ld hl,0e470h		;af77
	call L_B20E		;af7a
	ret nz			;af7d
	push hl			;af7e
	pop iy		;af7f
	ld (hl),00eh		;af81
	inc l			;af83
	ld (hl),000h		;af84
	ld (iy+00ah),010h		;af86
	call L_AFC6		;af8a
	inc l			;af8d
	ld (hl),018h		;af8e
	inc l			;af90
	inc l			;af91
	push ix		;af92
	pop bc			;af94
	ld (hl),c			;af95
	inc l			;af96
	ld (hl),b			;af97
	inc l			;af98
	ld (hl),010h		;af99
	inc l			;af9b
	inc l			;af9c
	ld (hl),00ch		;af9d
	inc l			;af9f
	ld (hl),00ch		;afa0
	ld a,01bh		;afa2
	jp 04ae4h		;afa4
L_AFA7:
	push iy		;afa7
	pop hl			;afa9
	inc l			;afaa
	bit 0,(hl)		;afab
	jr nz,L_AFF1		;afad
	ld a,(iy+00ah)		;afaf
	add a,006h		;afb2
	ld (iy+00ah),a		;afb4
	cp 060h		;afb7
	jr c,L_AFBD		;afb9
	ld (hl),001h		;afbb
L_AFBD:
	ld c,(iy+008h)		;afbd
	ld b,(iy+009h)		;afc0
	push bc			;afc3
	pop ix		;afc4
L_AFC6:
	ld a,(ix+004h)		;afc6
	inc a			;afc9
	inc l			;afca
	inc l			;afcb
	ld (hl),a			;afcc
	inc l			;afcd
	inc l			;afce
	ld a,(ix+006h)		;afcf
	add a,(iy+00ah)		;afd2
	jr c,L_AFDB		;afd5
	cp 0f0h		;afd7
	jr c,L_AFE1		;afd9
L_AFDB:
	ld (iy+001h),001h		;afdb
	ld a,0f0h		;afdf
L_AFE1:
	ld (hl),a			;afe1
	ld a,(0e1c3h)		;afe2
	bit 1,a		;afe5
	ld a,00bh		;afe7
	jr z,L_AFED		;afe9
	ld a,009h		;afeb
L_AFED:
	ld (iy+007h),a		;afed
	ret			;aff0
L_AFF1:
	ld a,(iy+00ah)		;aff1
	sub 006h		;aff4
	ld (iy+00ah),a		;aff6
	cp 010h		;aff9
	jp c,L_AE02		;affb
	jr L_AFBD		;affe
L_B000:
	ld hl,0e470h		;b000
	call L_B20E		;b003
	ret nz			;b006
	push hl			;b007
	pop iy		;b008
	ld (hl),00fh		;b00a
	inc l			;b00c
	ld (hl),000h		;b00d
	call L_B091		;b00f
	push ix		;b012
	pop bc			;b014
	inc l			;b015
	inc l			;b016
	ld (hl),c			;b017
	inc l			;b018
	ld (hl),b			;b019
	inc l			;b01a
	xor a			;b01b
	ld (hl),a			;b01c
	inc l			;b01d
	ld (hl),a			;b01e
	inc l			;b01f
	ld (hl),a			;b020
	inc l			;b021
	ld (hl),008h		;b022
	ld a,01ch		;b024
	jp 04ae4h		;b026
L_B029:
	push iy		;b029
	pop hl			;b02b
	inc l			;b02c
	bit 0,(hl)		;b02d
	jr nz,L_B060		;b02f
	call L_B088		;b031
	inc (iy+00bh)		;b034
	ld a,(iy+00bh)		;b037
	cp 008h		;b03a
	jr c,L_B042		;b03c
	ld (iy+001h),001h		;b03e
L_B042:
	ld a,(iy+005h)		;b042
	rra			;b045
	rra			;b046
	rra			;b047
	and 01fh		;b048
	add a,(iy+00bh)		;b04a
	sub 021h		;b04d
	jr nc,L_B056		;b04f
	ld a,(iy+00bh)		;b051
	jr L_B05C		;b054
L_B056:
	inc a			;b056
	neg		;b057
	add a,(iy+00bh)		;b059
L_B05C:
	ld (iy+00ah),a		;b05c
	ret			;b05f
L_B060:
	call L_B088		;b060
	dec (iy+00bh)		;b063
	jp z,L_AE02		;b066
	ld a,(0e432h)		;b069
	cp 006h		;b06c
	jr nz,L_B042		;b06e
	ld a,(0e3c0h)		;b070
	or a			;b073
	jr nz,L_B042		;b074
	ld a,(0e1c8h)		;b076
	and 010h		;b079
	jr z,L_B042		;b07b
	ld a,01ch		;b07d
	call 04ae4h		;b07f
	ld (iy+001h),000h		;b082
	jr L_B042		;b086
L_B088:
	ld c,(iy+008h)		;b088
	ld b,(iy+009h)		;b08b
	push bc			;b08e
	pop ix		;b08f
L_B091:
	inc l			;b091
	inc l			;b092
	ld a,(ix+004h)		;b093
	add a,004h		;b096
	and 0fch		;b098
	ld (hl),a			;b09a
	ld b,a			;b09b
	inc l			;b09c
	inc l			;b09d
	ld a,(ix+006h)		;b09e
	add a,010h		;b0a1
	and 0f8h		;b0a3
	cp 0f8h		;b0a5
	jp z,L_AE02		;b0a7
	ld (hl),a			;b0aa
	inc l			;b0ab
	xor a			;b0ac
	bit 2,b		;b0ad
	jr z,L_B0B2		;b0af
	inc a			;b0b1
L_B0B2:
	ld (hl),a			;b0b2
	ret			;b0b3
L_B0B4:
	ld a,(ix+004h)		;b0b4
	cp 0a5h		;b0b7
	ret nc			;b0b9
	ld a,(ix+006h)		;b0ba
	cp 0e8h		;b0bd
	ret nc			;b0bf
	ld hl,0e4d0h		;b0c0
	exx			;b0c3
	ld a,e			;b0c4
	exx			;b0c5
	sra a		;b0c6
	add a,l			;b0c8
	ld l,a			;b0c9
	ld a,(hl)			;b0ca
	or a			;b0cb
	ret nz			;b0cc
	ld a,(0e433h)		;b0cd
	ld de,00400h		;b0d0
	ld bc,0200ah		;b0d3
	dec a			;b0d6
	jr z,L_B0E1		;b0d7
	inc e			;b0d9
	dec a			;b0da
	jr z,L_B0E1		;b0db
	inc d			;b0dd
	ld bc,0280fh		;b0de
L_B0E1:
	ld (hl),d			;b0e1
	inc l			;b0e2
	ld (hl),e			;b0e3
	ld de,00808h		;b0e4
	call L_B224		;b0e7
	inc l			;b0ea
	ld (hl),b			;b0eb
	inc l			;b0ec
	ld (hl),c			;b0ed
	inc l			;b0ee
	ld (hl),000h		;b0ef
	ld a,l			;b0f1
	add a,004h		;b0f2
	ld l,a			;b0f4
	ld (hl),008h		;b0f5
	inc l			;b0f7
	ld (hl),002h		;b0f8
	ret			;b0fa
L_B0FB:
	push iy		;b0fb
	pop hl			;b0fd
	ld a,(0e201h)		;b0fe
	cp 005h		;b101
	jr z,L_B140		;b103
	ld h,(iy+005h)		;b105
	ld l,(iy+003h)		;b108
	ld a,l			;b10b
	add a,008h		;b10c
	ld l,a			;b10e
	call L_B1A6		;b10f
	jr nc,L_B140		;b112
	ld h,(iy+005h)		;b114
	ld l,(iy+003h)		;b117
	ld a,h			;b11a
	add a,008h		;b11b
	ld h,a			;b11d
	ld a,l			;b11e
	add a,008h		;b11f
	ld l,a			;b121
	call L_B1A6		;b122
	jr nc,L_B13A		;b125
	ld h,(iy+005h)		;b127
	ld l,(iy+003h)		;b12a
	ld a,h			;b12d
	add a,008h		;b12e
	ld h,a			;b130
	call L_B1A6		;b131
	jp c,L_AE02		;b134
	jp L_B17B		;b137
L_B13A:
	call L_B14E		;b13a
	jp L_B17B		;b13d
L_B140:
	bit 0,(iy+001h)		;b140
	ld de,00100h		;b144
	jr z,L_B14B		;b147
	ld e,080h		;b149
L_B14B:
	call L_B194		;b14b
L_B14E:
	ld a,(iy+000h)		;b14e
	cp 005h		;b151
	ld a,028h		;b153
	jr z,L_B159		;b155
	ld a,020h		;b157
L_B159:
	ld (iy+006h),a		;b159
	bit 0,(iy+001h)		;b15c
	ld de,00400h		;b160
	jr z,L_B167		;b163
	ld d,006h		;b165
L_B167:
	ld a,(iy+002h)		;b167
	add a,e			;b16a
	ld (iy+002h),a		;b16b
	ld a,(iy+003h)		;b16e
	adc a,d			;b171
	cp 0a8h		;b172
	jp nc,L_AE02		;b174
	ld (iy+003h),a		;b177
	ret			;b17a
L_B17B:
	ld a,(iy+000h)		;b17b
	cp 005h		;b17e
	ld a,024h		;b180
	jr z,L_B186		;b182
	ld a,01ch		;b184
L_B186:
	ld (iy+006h),a		;b186
	bit 0,(iy+001h)		;b189
	ld de,00400h		;b18d
	jr z,L_B194		;b190
	ld d,006h		;b192
L_B194:
	ld a,(iy+004h)		;b194
	add a,e			;b197
	ld (iy+004h),a		;b198
	ld a,(iy+005h)		;b19b
	adc a,d			;b19e
	jp c,L_AE02		;b19f
	ld (iy+005h),a		;b1a2
	ret			;b1a5
L_B1A6:
	ld a,(0e305h)		;b1a6
	exx			;b1a9
	ld c,a			;b1aa
	exx			;b1ab
	jp 08388h		;b1ac
L_B1AF:
	ld a,(0e320h)		;b1af
	or a			;b1b2
	jr z,L_B1C0		;b1b3
	ld a,(iy+005h)		;b1b5
	sub 008h		;b1b8
	ld (iy+005h),a		;b1ba
	jp c,L_AE02		;b1bd
L_B1C0:
	call L_B1F8		;b1c0
	dec (iy+009h)		;b1c3
	ret nz			;b1c6
	ld (iy+009h),005h		;b1c7
	ld a,(iy+008h)		;b1cb
	cp 004h		;b1ce
	jp nc,L_AE02		;b1d0
	inc (iy+008h)		;b1d3
	and 003h		;b1d6
	add a,a			;b1d8
	ld hl,0b1f0h		;b1d9
	call 05ca6h		;b1dc
	add a,(iy+003h)		;b1df
	ld e,a			;b1e2
	inc hl			;b1e3
	ld a,(hl)			;b1e4
	add a,(iy+005h)		;b1e5
	ld d,a			;b1e8
	ld c,000h		;b1e9
	ld a,036h		;b1eb
	jp 04d1eh		;b1ed

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


L_B1F8:
	ld a,(iy+00ah)		;b1f8
	inc a			;b1fb
	cp 004h		;b1fc
	jr c,L_B201		;b1fe
	xor a			;b200
L_B201:
	ld (iy+00ah),a		;b201
	ld hl,09621h		;b204
	call 04b67h		;b207
	ld (iy+006h),e		;b20a
	ret			;b20d
L_B20E:
	ld a,(ix+004h)		;b20e
	cp 0a6h		;b211
	jr nc,L_B222		;b213
	ld a,(ix+006h)		;b215
	cp 0d9h		;b218
	jr nc,L_B222		;b21a
	exx			;b21c
	ld a,e			;b21d
	exx			;b21e
	add a,l			;b21f
	ld l,a			;b220
	ld a,(hl)			;b221
L_B222:
	or a			;b222
	ret			;b223
L_B224:
	ld a,(ix+004h)		;b224
	add a,d			;b227
	inc l			;b228
	inc l			;b229
	ld (hl),a			;b22a
	ld a,(ix+006h)		;b22b
	add a,e			;b22e
	inc l			;b22f
	inc l			;b230
	ld (hl),a			;b231
	ret			;b232
L_B233:
	ld a,(ix+004h)		;b233
L_B236:
	rra			;b236
	and 003h		;b237
	add a,d			;b239
	inc l			;b23a
	ld (hl),a			;b23b
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


L_B3A7:
	ld a,(ix+006h)		;b3a7
	cp 020h		;b3aa
	ret c			;b3ac
	ld a,(ix+001h)		;b3ad
	cp 005h		;b3b0
	ret z			;b3b2
	call 04084h		;b3b3

; ----------------------------------------------------------------------
; DATOS tabla_B3B6: 5 destinos del despachador p00:4084 (call en p03:B3B3, el
;   indice en A): B3C0, B3C0, B3D0, B3EA, B407; lo leen p03:B3B3 (10 bytes)
;   0xb3b6..0xb3c0  (10 bytes)
DATA_tabla_B3B6:
	defw 0b3c0h,0b3c0h,0b3d0h,0b3eah,0b407h	; b3b6

; ======================================================================
; CODIGO 0xb3c0..0xb495  (213 bytes)
; ======================================================================


L_B3C0:
	dec (ix+002h)		;b3c0
	ret nz			;b3c3
	inc (ix+007h)		;b3c4
	ld a,008h		;b3c7
L_B3C9:
	inc (ix+001h)		;b3c9
	ld (ix+002h),a		;b3cc
	ret			;b3cf
L_B3D0:
	call L_B407		;b3d0
	ld a,(ix+00ch)		;b3d3
	and a			;b3d6
	ret nz			;b3d7
	dec (ix+007h)		;b3d8
	ld a,008h		;b3db
	jr L_B3C9		;b3dd
L_B3DF:
	ld a,(ix+001h)		;b3df
	cp 002h		;b3e2
	ld a,008h		;b3e4
	jr z,L_B402		;b3e6
	jr L_B405		;b3e8
L_B3EA:
	dec (ix+002h)		;b3ea
	ret nz			;b3ed
	call L_B46C		;b3ee
	ld (ix+001h),0ffh		;b3f1
	ld (ix+00ch),005h		;b3f5
	ld b,040h		;b3f9
	ld a,(0e228h)		;b3fb
	add a,a			;b3fe
	neg		;b3ff
	add a,b			;b401
L_B402:
	dec (ix+007h)		;b402
L_B405:
	jr L_B3C9		;b405
L_B407:
	ld a,(ix+00bh)		;b407
	ld (0e35ah),a		;b40a
	ld a,(ix+00ch)		;b40d
	and a			;b410
	jr z,L_B3DF		;b411
	dec (ix+002h)		;b413
	ret nz			;b416
	ld (ix+002h),008h		;b417
	dec (ix+00ch)		;b41b
	call L_B471		;b41e
	and a			;b421
	jr nz,L_B428		;b422
	ld (ix+002h),004h		;b424
L_B428:
	ld a,(ix+004h)		;b428
	ld c,0f8h		;b42b
	bit 0,(ix+00bh)		;b42d
	jr z,L_B435		;b431
	ld c,010h		;b433
L_B435:
	add a,c			;b435
	ld e,a			;b436
	ld a,(ix+006h)		;b437
	ld c,008h		;b43a
	add a,c			;b43c
	ld d,a			;b43d
	ld c,000h		;b43e
	ld a,007h		;b440
	call 04d16h		;b442
	ret nz			;b445
	jr L_B46C		;b446
L_B448:
	call L_B46C		;b448
	ld a,(ix+00bh)		;b44b
	ld c,a			;b44e
	add a,a			;b44f
	add a,c			;b450
	ld c,015h		;b451
	add a,c			;b453
	ld (ix+007h),a		;b454
	ld (ix+008h),006h		;b457
	ld (ix+002h),034h		;b45b
	ld (ix+009h),006h		;b45f
	ld (ix+00ah),003h		;b463
	ld (ix+00ch),005h		;b467
	ret			;b46b
L_B46C:
	ld (ix+00fh),001h		;b46c
	ret			;b470
L_B471:
	ld a,(ix+00fh)		;b471
	xor 001h		;b474
	ld (ix+00fh),a		;b476
	ld (0e35ch),a		;b479
	push ix		;b47c
	pop hl			;b47e
	ld (0e35dh),hl		;b47f
	ret			;b482
L_B483:
	ld (ix+00fh),000h		;b483
	ld a,(ix+006h)		;b487
	cp 020h		;b48a
	call z,L_B5FF		;b48c
	ld a,(ix+001h)		;b48f
	call 04084h		;b492

; ----------------------------------------------------------------------
; DATOS tabla_B495: 11 destinos del despachador p00:4084 (call en p03:B492, el
;   indice en A): B4B9, B4B9, B4AB, B50B, B57A, B514, B584, B51C, B5C5, B5DE,
;   B625; lo leen p03:B492 (22 bytes)
;   0xb495..0xb4ab  (22 bytes)
DATA_tabla_B495:
	defw 0b4b9h,0b4b9h,0b4abh,0b50bh,0b57ah,0b514h,0b584h,0b51ch	; b495
	defw 0b5c5h,0b5deh,0b625h	; b4a5  -> L_B5C5 L_B5DE L_B625

; ======================================================================
; CODIGO 0xb4ab..0xb4fb  (80 bytes)
; ======================================================================


L_B4AB:
	dec (ix+002h)		;b4ab
	ret nz			;b4ae
L_B4AF:
	ld (ix+002h),004h		;b4af
	ld (ix+00eh),002h		;b4b3
	jr L_B4E7		;b4b7
L_B4B9:
	dec (ix+002h)		;b4b9
	ret nz			;b4bc
	ld (ix+002h),008h		;b4bd
L_B4C1:
	ld a,(0e20ah)		;b4c1
	cp 002h		;b4c4
	ld b,006h		;b4c6
	jr nc,L_B4E4		;b4c8
	ld b,002h		;b4ca
	ld a,(0e40bh)		;b4cc
	cp 002h		;b4cf
	jr c,L_B4E4		;b4d1
	ld b,001h		;b4d3
	jr L_B4E4		;b4d5
L_B4D7:
	ld b,002h		;b4d7
	ld a,(0e40bh)		;b4d9
	and a			;b4dc
	jr z,L_B4E4		;b4dd
	dec b			;b4df
	dec a			;b4e0
	jr z,L_B4E4		;b4e1
	dec b			;b4e3
L_B4E4:
	ld (ix+00eh),b		;b4e4
L_B4E7:
	inc (ix+007h)		;b4e7
	inc (ix+001h)		;b4ea
L_B4ED:
	ld a,(ix+007h)		;b4ed
	ld hl,0b4fbh		;b4f0
	call 0407ah		;b4f3
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


L_B50B:
	ld a,(0e40bh)		;b50b
	cp 002h		;b50e
	jr nc,L_B52D		;b510
	jr L_B529		;b512
L_B514:
	ld a,(0e40bh)		;b514
	and a			;b517
	jr nz,L_B52D		;b518
	jr L_B529		;b51a
L_B51C:
	ld a,(0e40bh)		;b51c
	and a			;b51f
	jr z,L_B52D		;b520
	ld a,(0e400h)		;b522
	cp 002h		;b525
	jr nc,L_B52D		;b527
L_B529:
	ld (ix+00fh),001h		;b529
L_B52D:
	dec (ix+002h)		;b52d
	ret nz			;b530
	ld a,(ix+003h)		;b531
	ld (0e35dh),a		;b534
	call L_B666		;b537
	cp 003h		;b53a
	jp z,L_B630		;b53c
	call L_B673		;b53f
	bit 0,(ix+00fh)		;b542
	jr nz,L_B54F		;b546
	ld a,01dh		;b548
	ld c,000h		;b54a
	call 04d16h		;b54c
L_B54F:
	inc (ix+00eh)		;b54f
	ld b,001h		;b552
	ld a,(ix+001h)		;b554
	cp 006h		;b557
	jr c,L_B576		;b559
	ld b,004h		;b55b
	ld a,(0e20ah)		;b55d
	and a			;b560
	jr nz,L_B576		;b561
	ld b,00fh		;b563
	ld a,(0e400h)		;b565
	cp 002h		;b568
	jr nz,L_B576		;b56a
	ld a,(0e228h)		;b56c
	srl a		;b56f
	ld c,a			;b571
	ld a,00ch		;b572
	sub c			;b574
	ld b,a			;b575
L_B576:
	ld (ix+002h),b		;b576
	ret			;b579
L_B57A:
	ld a,(0e40bh)		;b57a
	and a			;b57d
	jr nz,L_B584		;b57e
	ld (ix+00fh),001h		;b580
L_B584:
	dec (ix+002h)		;b584
	ret nz			;b587
	ld a,(ix+003h)		;b588
	ld (0e35dh),a		;b58b
	call L_B666		;b58e
	ld a,(ix+00eh)		;b591
	cp 003h		;b594
	jp z,L_B654		;b596
	call L_B673		;b599
	push de			;b59c
	call L_B68C		;b59d
	pop de			;b5a0
	call L_B54F		;b5a1
	bit 0,(ix+00fh)		;b5a4
	ret nz			;b5a8
	call 093b1h		;b5a9
	push ix		;b5ac
	push hl			;b5ae
	pop ix		;b5af
	ld bc,0fff4h		;b5b1
	add ix,bc		;b5b4
	ld (ix+000h),082h		;b5b6
	ld (ix+002h),00ch		;b5ba
	ld (ix+00ch),00ah		;b5be
	pop ix		;b5c2
	ret			;b5c4
L_B5C5:
	inc (ix+001h)		;b5c5
	ld a,007h		;b5c8
	bit 0,(ix+003h)		;b5ca
	jr nz,L_B5D2		;b5ce
	ld a,00fh		;b5d0
L_B5D2:
	ld (ix+007h),a		;b5d2
	ld (ix+002h),00dh		;b5d5
	ld (ix+00dh),0ffh		;b5d9
	ret			;b5dd
L_B5DE:
	dec (ix+002h)		;b5de
	ret nz			;b5e1
L_B5E2:
	ld (ix+000h),000h		;b5e2
	ld a,(ix+00bh)		;b5e6
	or a			;b5e9
	ret z			;b5ea
	ld b,a			;b5eb
	ld a,(ix+004h)		;b5ec
	add a,010h		;b5ef
	ld e,a			;b5f1
	ld d,(ix+006h)		;b5f2
	ld c,005h		;b5f5
	dec b			;b5f7
	jr z,L_B5FC		;b5f8
	ld c,003h		;b5fa
L_B5FC:
	jp 05157h		;b5fc
L_B5FF:
	ld a,(0e320h)		;b5ff
	and a			;b602
	ret z			;b603
	ld a,(ix+001h)		;b604
	cp 006h		;b607
	jr c,L_B620		;b609
	cp 008h		;b60b
	ret nc			;b60d
	ld (ix+001h),00ah		;b60e
	ld (ix+00eh),006h		;b612
L_B616:
	ld (ix+002h),004h		;b616
	dec (ix+007h)		;b61a
	jp L_B4ED		;b61d
L_B620:
	ld (ix+00dh),0ffh		;b620
	ret			;b624
L_B625:
	dec (ix+002h)		;b625
	ret nz			;b628
	dec (ix+00eh)		;b629
	jr z,L_B5E2		;b62c
	jr L_B616		;b62e
L_B630:
	ld (ix+002h),004h		;b630
	ld a,(ix+001h)		;b634
	cp 007h		;b637
	jp nz,L_B4AF		;b639
	dec (ix+001h)		;b63c
	dec (ix+001h)		;b63f
L_B642:
	ld a,(0e228h)		;b642
	srl a		;b645
	neg		;b647
	add a,010h		;b649
	ld (ix+002h),a		;b64b
	dec (ix+007h)		;b64e
	jp L_B4C1		;b651
L_B654:
	ld (ix+002h),004h		;b654
	bit 1,(ix+003h)		;b658
	ld a,(ix+001h)		;b65c
	cp 006h		;b65f
	jp nz,L_B4AF		;b661
	jr L_B642		;b664
L_B666:
	ld a,(ix+00ch)		;b666
	inc a			;b669
	and 003h		;b66a
	ld (ix+00ch),a		;b66c
	ld (0e35ch),a		;b66f
	ret			;b672
L_B673:
	ld hl,0b6d5h		;b673
	ld a,(ix+00dh)		;b676
	dec a			;b679
	add a,a			;b67a
	call 0407ah		;b67b
	ld a,(hl)			;b67e
	inc hl			;b67f
	ld e,(ix+004h)		;b680
	add a,e			;b683
	ld e,a			;b684
	ld a,(hl)			;b685
	ld d,(ix+006h)		;b686
	add a,d			;b689
	ld d,a			;b68a
	ret			;b68b
L_B68C:
	ld hl,0b6d1h		;b68c
	ld a,(0e35ch)		;b68f
	call 0407ah		;b692
	ld l,(hl)			;b695
	ld a,(0e35dh)		;b696
	and a			;b699
	jr z,L_B6C8		;b69a
	cp 003h		;b69c
	jr z,L_B6C8		;b69e
	ld a,(0e404h)		;b6a0
	add a,l			;b6a3
	ld h,a			;b6a4
	jr nc,L_B6AB		;b6a5
L_B6A7:
	ld a,(0e404h)		;b6a7
	ld h,a			;b6aa
L_B6AB:
	ld a,(0e406h)		;b6ab
	ld l,a			;b6ae
	ld a,060h		;b6af
	ld e,(ix+004h)		;b6b1
	ld d,(ix+006h)		;b6b4
	ld (0f00fh),a		;b6b7
	ld a,h			;b6ba
	ld (0f000h),a		;b6bb
	ld a,l			;b6be
	ld (0f001h),a		;b6bf
	call 09467h		;b6c2
	jp 093fbh		;b6c5
L_B6C8:
	ld a,(0e404h)		;b6c8
	sub l			;b6cb
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


L_B6E1:
	res 1,(ix+010h)		;b6e1
	call L_B68C		;b6e5
L_B6E8:
	ld (ix+002h),00ch		;b6e8
	ld (ix+02fh),001h		;b6ec
	ld de,(0f014h)		;b6f0
	ld hl,(0f012h)		;b6f4
	jp 04f26h		;b6f7
L_B6FA:
	ld a,(ix+001h)		;b6fa
	and a			;b6fd
	ret nz			;b6fe
	dec (ix+002h)		;b6ff
	ret nz			;b702
	ld (ix+02fh),000h		;b703
	inc (ix+001h)		;b707
	ret			;b70a
L_B70B:
	bit 7,(ix+000h)		;b70b
	ret z			;b70f
	dec (ix+002h)		;b710
	ret nz			;b713
	res 7,(ix+000h)		;b714
	ret			;b718
L_B719:
	ld a,(ix+004h)		;b719
	cp 028h		;b71c
	ld bc,00001h		;b71e
	jr nc,L_B726		;b721
	ld bc,00800h		;b723
L_B726:
	ld (ix+007h),b		;b726
	ld (ix+003h),c		;b729
	ld b,007h		;b72c
	ld a,(0e20ah)		;b72e
	jr z,L_B735		;b731
	ld b,00ah		;b733
L_B735:
	ld (ix+008h),b		;b735
	ld (ix+002h),030h		;b738
	ld (ix+009h),005h		;b73c
	ld (ix+00ah),006h		;b740
	xor a			;b744
	ld (ix+00ch),a		;b745
	dec a			;b748
	ld (ix+00dh),a		;b749
	ret			;b74c
L_B74D:
	ld c,01dh		;b74d
	ld a,(0e201h)		;b74f
	cp 007h		;b752
	jr z,L_B758		;b754
	ld c,038h		;b756
L_B758:
	ld a,(ix+00bh)		;b758
	and a			;b75b
	jr z,L_B75F		;b75c
	inc c			;b75e
L_B75F:
	ld (ix+007h),c		;b75f
	ld (ix+008h),008h		;b762
	ld (ix+009h),004h		;b766
	ld (ix+00ah),003h		;b76a
	ld (ix+002h),030h		;b76e
	ret			;b772
L_B773:
	ld a,(ix+001h)		;b773
	dec a			;b776
	jr z,L_B789		;b777
	dec (ix+002h)		;b779
	ret nz			;b77c
	inc (ix+001h)		;b77d
	ld (ix+002h),006h		;b780
	ld (ix+00ch),006h		;b784
	ret			;b788
L_B789:
	dec (ix+002h)		;b789
	ret nz			;b78c
	ld (ix+002h),006h		;b78d
	ld a,(ix+004h)		;b791
	ld bc,000f4h		;b794
	bit 0,(ix+00bh)		;b797
	jr z,L_B7A0		;b79b
	ld bc,00114h		;b79d
L_B7A0:
	add a,c			;b7a0
	ld e,a			;b7a1
	ld a,(ix+006h)		;b7a2
	add a,008h		;b7a5
	ld d,a			;b7a7
	ld a,010h		;b7a8
	ld c,000h		;b7aa
	call 04d16h		;b7ac
	dec (ix+00ch)		;b7af
	ret nz			;b7b2
	ld (ix+002h),060h		;b7b3
	ld (ix+001h),000h		;b7b7
	ret			;b7bb
L_B7BC:
	ld (ix+002h),010h		;b7bc
	ld a,(ix+006h)		;b7c0
	ld (ix+026h),a		;b7c3
	call 04e93h		;b7c6
	ld (ix+015h),a		;b7c9
	ld a,(ix+004h)		;b7cc
	bit 0,(ix+019h)		;b7cf
	jr z,L_B7DE		;b7d3
	ld hl,00480h		;b7d5
	ld de,00300h		;b7d8
	jp 04f26h		;b7db
L_B7DE:
	ld hl,0fb80h		;b7de
	ld de,0fd00h		;b7e1
	jp 04f26h		;b7e4
L_B7E7:
	call L_B834		;b7e7
	call L_B841		;b7ea
	ld a,(ix+001h)		;b7ed
	dec a			;b7f0
	jr z,L_B80D		;b7f1
	dec a			;b7f3
	ret z			;b7f4
	call L_B879		;b7f5
	call L_B864		;b7f8
	dec (ix+002h)		;b7fb
	ret nz			;b7fe
	ld (ix+002h),05ah		;b7ff
	ld a,(ix+004h)		;b803
	ld (ix+025h),a		;b806
	inc (ix+001h)		;b809
	ret			;b80c
L_B80D:
	call L_B879		;b80d
	call L_B84F		;b810
	dec (ix+002h)		;b813
	ret nz			;b816
	ld e,070h		;b817
	ld a,(0e228h)		;b819
	add a,a			;b81c
	add a,e			;b81d
	ld e,(ix+004h)		;b81e
	ld d,(ix+006h)		;b821
	call 093f5h		;b824
	inc (ix+001h)		;b827
	ld hl,(0f012h)		;b82a
	ld de,(0f014h)		;b82d
	jp 04f26h		;b831
L_B834:
	ld a,(0e1c3h)		;b834
	and 003h		;b837
	add a,a			;b839
	add a,a			;b83a
	add a,058h		;b83b
	ld (ix+030h),a		;b83d
	ret			;b840
L_B841:
	dec (ix+015h)		;b841
	ret nz			;b844
	call L_BB44		;b845
	call 04e93h		;b848
	ld (ix+015h),a		;b84b
	ret			;b84e
L_B84F:
	ld h,000h		;b84f
	ld a,(ix+025h)		;b851
	sub (ix+004h)		;b854
	jr nc,L_B85A		;b857
	dec h			;b859
L_B85A:
	ld l,a			;b85a
	add hl,hl			;b85b
	add hl,hl			;b85c
	ex de,hl			;b85d
	call 062a8h		;b85e
	call 062c2h		;b861
L_B864:
	ld h,000h		;b864
	ld a,(ix+026h)		;b866
	sub (ix+006h)		;b869
	jr nc,L_B86F		;b86c
	dec h			;b86e
L_B86F:
	ld l,a			;b86f
	add hl,hl			;b870
	add hl,hl			;b871
	ex de,hl			;b872
	call 062afh		;b873
	jp 062d5h		;b876
L_B879:
	dec (ix+006h)		;b879
	ld a,(ix+026h)		;b87c
	and a			;b87f
	ret z			;b880
	dec (ix+026h)		;b881
	ret			;b884
L_B885:
	ld (ix+008h),008h		;b885
	ld (ix+009h),003h		;b889
	ld (ix+00ah),001h		;b88d
	ld (ix+00dh),0ffh		;b891
	ld a,r		;b895
	and 00fh		;b897
	add a,020h		;b899
	ld (ix+002h),a		;b89b
	ret			;b89e
L_B89F:
	ld a,(ix+001h)		;b89f
	dec a			;b8a2
	jr z,L_B8D4		;b8a3
	dec a			;b8a5
	jr z,L_B8E0		;b8a6
	dec (ix+002h)		;b8a8
	ret nz			;b8ab
	ld de,00808h		;b8ac
	bit 0,(ix+00bh)		;b8af
	jr nz,L_B8B7		;b8b3
	ld e,0f8h		;b8b5
L_B8B7:
	ld a,(ix+004h)		;b8b7
	add a,e			;b8ba
	ld e,a			;b8bb
	ld a,(ix+006h)		;b8bc
	add a,d			;b8bf
	ld d,a			;b8c0
	ld c,000h		;b8c1
	ld a,(ix+00bh)		;b8c3
	ld b,a			;b8c6
	ld a,01fh		;b8c7
	call 04d16h		;b8c9
	ld (ix+002h),018h		;b8cc
	inc (ix+001h)		;b8d0
	ret			;b8d3
L_B8D4:
	dec (ix+002h)		;b8d4
	ret nz			;b8d7
	ld (ix+002h),004h		;b8d8
	inc (ix+001h)		;b8dc
	ret			;b8df
L_B8E0:
	dec (ix+002h)		;b8e0
	ret nz			;b8e3
	ld a,r		;b8e4
	and 007h		;b8e6
	ld c,a			;b8e8
	ld a,(0e228h)		;b8e9
	rra			;b8ec
	and 007h		;b8ed
	sub 018h		;b8ef
	neg		;b8f1
	add a,c			;b8f3
	ld (ix+002h),a		;b8f4
	ld (ix+001h),000h		;b8f7
	ret			;b8fb
L_B8FC:
	ld c,080h		;b8fc
	bit 0,(ix+019h)		;b8fe
	jr z,L_B906		;b902
	ld c,074h		;b904
L_B906:
	ld (ix+030h),c		;b906
	ld (ix+002h),000h		;b909
	set 3,(ix+010h)		;b90d
	ld (ix+025h),018h		;b911
	call 04f17h		;b915
	jr L_B976		;b918
L_B91A:
	call L_B970		;b91a
	ld a,(ix+001h)		;b91d
	dec a			;b920
	jr z,L_B958		;b921
	dec (ix+025h)		;b923
	ld a,(ix+025h)		;b926
	cp 008h		;b929
	jr z,L_B94F		;b92b
	and a			;b92d
	ret nz			;b92e
	call L_B94F		;b92f
	inc (ix+001h)		;b932
L_B935:
	res 3,(ix+010h)		;b935
	bit 0,(ix+019h)		;b939
	jr z,L_B944		;b93d
	ld de,00400h		;b93f
	jr L_B947		;b942
L_B944:
	ld de,0fc00h		;b944
L_B947:
	call 04efbh		;b947
	ld (ix+025h),01eh		;b94a
	ret			;b94e
L_B94F:
	ld a,(ix+030h)		;b94f
	add a,004h		;b952
	ld (ix+030h),a		;b954
	ret			;b957
L_B958:
	dec (ix+025h)		;b958
	jr z,L_B935		;b95b
	ld de,00020h		;b95d
	bit 0,(ix+019h)		;b960
	call nz,05cadh		;b964
	ex de,hl			;b967
	call 04f10h		;b968
	add hl,de			;b96b
	ex de,hl			;b96c
	jp 04efbh		;b96d
L_B970:
	ld a,(0e1c3h)		;b970
	and 003h		;b973
	ret nz			;b975
L_B976:
	ld a,(ix+002h)		;b976
	inc a			;b979
	cp 006h		;b97a
	jr c,L_B97F		;b97c
	xor a			;b97e
L_B97F:
	ld (ix+002h),a		;b97f
	ld hl,0b98ch		;b982
	call 05ca6h		;b985
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


L_B992:
	ld a,(ix+006h)		;b992
	cp 028h		;b995
	call nc,L_B9E8		;b997
	dec (ix+002h)		;b99a
	jr z,L_B9AE		;b99d
	ld a,(ix+002h)		;b99f
	cp (ix+00ch)		;b9a2
	ret nz			;b9a5
	ld (ix+007h),011h		;b9a6
	inc (ix+00dh)		;b9aa
	ret			;b9ad
L_B9AE:
	ld a,(ix+00ch)		;b9ae
	add a,a			;b9b1
	ld (ix+002h),a		;b9b2
	dec (ix+00dh)		;b9b5
	bit 7,(ix+00eh)		;b9b8
	jr nz,L_B9D6		;b9bc
	ld (ix+007h),012h		;b9be
	ld a,(ix+004h)		;b9c2
	add a,008h		;b9c5
	ld (ix+004h),a		;b9c7
	cp 058h		;b9ca
	ret nz			;b9cc
L_B9CD:
	ld a,(ix+00eh)		;b9cd
	neg		;b9d0
	ld (ix+00eh),a		;b9d2
	ret			;b9d5
L_B9D6:
	ld (ix+007h),010h		;b9d6
	ld a,(ix+004h)		;b9da
	sub 008h		;b9dd
	ld (ix+004h),a		;b9df
	cp (ix+00fh)		;b9e2
	ret nz			;b9e5
	jr L_B9CD		;b9e6
L_B9E8:
	dec (ix+001h)		;b9e8
	ret nz			;b9eb
	dec (ix+003h)		;b9ec
	ld a,004h		;b9ef
	jr nz,L_B9F9		;b9f1
	ld a,034h		;b9f3
	ld (ix+003h),010h		;b9f5
L_B9F9:
	ld (ix+001h),a		;b9f9
	call L_BA06		;b9fc
	ld a,022h		;b9ff
	ld c,000h		;ba01
	jp 04d16h		;ba03
L_BA06:
	ld a,010h		;ba06
	add a,(ix+004h)		;ba08
	ld e,a			;ba0b
	ld a,0fch		;ba0c
	add a,(ix+006h)		;ba0e
	ld d,a			;ba11
	ret			;ba12
L_BA13:
	ld a,(ix+00bh)		;ba13
	add a,a			;ba16
	add a,002h		;ba17
	ld (ix+00ch),a		;ba19
	add a,a			;ba1c
	ld (ix+002h),a		;ba1d
	ld (ix+00eh),001h		;ba20
	ld (ix+007h),010h		;ba24
	ld (ix+008h),028h		;ba28
	ld (ix+001h),004h		;ba2c
	ld (ix+009h),004h		;ba30
	ld (ix+00ah),005h		;ba34
	ld (ix+003h),010h		;ba38
	ld (ix+00dh),007h		;ba3c
	ld a,(ix+004h)		;ba40
	ld (ix+00fh),a		;ba43
	ret			;ba46
L_BA47:
	ld hl,00000h		;ba47
	ld (0f012h),hl		;ba4a
	ld hl,0fc00h		;ba4d
	ld (0f014h),hl		;ba50
	jp L_B6E8		;ba53
L_BA56:
	ld (ix+010h),01bh		;ba56
	ld (ix+014h),004h		;ba5a
	ld (ix+013h),002h		;ba5e
	ld a,(ix+019h)		;ba62
	and a			;ba65
	ld a,010h		;ba66
	jr z,L_BA6C		;ba68
	ld a,008h		;ba6a
L_BA6C:
	ld (ix+028h),a		;ba6c
	ld (ix+02ah),a		;ba6f
	ld (ix+029h),008h		;ba72
	ld a,(ix+004h)		;ba76
	cp 068h		;ba79
	ret c			;ba7b
	ld (ix+029h),0f8h		;ba7c
	ret			;ba80
L_BA81:
	ld a,(ix+001h)		;ba81
	dec a			;ba84
	jr z,L_BA91		;ba85
	ld a,(ix+006h)		;ba87
	cp 0d8h		;ba8a
	ret nc			;ba8c
	inc (ix+001h)		;ba8d
	ret			;ba90
L_BA91:
	dec (ix+028h)		;ba91
	ret nz			;ba94
	call L_BAA8		;ba95
	ld a,(ix+02ah)		;ba98
	ld (ix+028h),a		;ba9b
	ld a,(ix+004h)		;ba9e
	add a,(ix+029h)		;baa1
	ld (ix+004h),a		;baa4
	ret			;baa7
L_BAA8:
	bit 7,(ix+029h)		;baa8
	jr nz,L_BAC4		;baac
	ld a,(ix+004h)		;baae
	add a,010h		;bab1
L_BAB3:
	ld l,a			;bab3
	ld h,(ix+006h)		;bab4
	call 083e8h		;bab7
	ret nc			;baba
	ld a,(ix+029h)		;babb
	neg		;babe
	ld (ix+029h),a		;bac0
	ret			;bac3
L_BAC4:
	ld a,(ix+004h)		;bac4
	sub 008h		;bac7
	jr L_BAB3		;bac9
L_BACB:
	ld (ix+025h),010h		;bacb
	ld a,(ix+004h)		;bacf
	ld (ix+026h),a		;bad2
	cp 058h		;bad5
	ld hl,00400h		;bad7
	jr c,L_BAE6		;bada
	ld a,(ix+019h)		;badc
	add a,006h		;badf
	ld (ix+019h),a		;bae1
	ld h,004h		;bae4
L_BAE6:
	ld de,0fd60h		;bae6
	jp 04f26h		;bae9
L_BAEC:
	call L_BB50		;baec
	ld a,(ix+001h)		;baef
	dec a			;baf2
	jr z,L_BB3D		;baf3
	dec a			;baf5
	ret z			;baf6
	ld a,(0e228h)		;baf7
	cp 009h		;bafa
	call nc,L_BB33		;bafc
	ld (ix+001h),000h		;baff
	ld a,(ix+026h)		;bb03
	ld de,00070h		;bb06
	call 09c27h		;bb09
	ld a,(ix+006h)		;bb0c
	cp 020h		;bb0f
	ret nc			;bb11
	ld (ix+025h),008h		;bb12
	inc (ix+001h)		;bb16
	ld a,(0e228h)		;bb19
	ld b,004h		;bb1c
	cp 006h		;bb1e
	jr c,L_BB24		;bb20
	ld b,006h		;bb22
L_BB24:
	ld a,(ix+019h)		;bb24
	ld hl,0bb84h		;bb27
	call 05ca6h		;bb2a
	call 04cb7h		;bb2d
	jp 04f26h		;bb30
L_BB33:
	ld a,(ix+025h)		;bb33
	and a			;bb36
	jr nz,L_BB3D		;bb37
	ld (ix+025h),009h		;bb39
L_BB3D:
	dec (ix+025h)		;bb3d
	ret nz			;bb40
	inc (ix+001h)		;bb41
L_BB44:
	ld e,(ix+004h)		;bb44
	ld a,(ix+006h)		;bb47
	add a,008h		;bb4a
	ld d,a			;bb4c
	jp 0938fh		;bb4d
L_BB50:
	ld hl,0bb78h		;bb50
	ld a,(0e201h)		;bb53
	cp 005h		;bb56
	jr z,L_BB63		;bb58
	cp 003h		;bb5a
	jr nz,L_BB66		;bb5c
	ld hl,0bb80h		;bb5e
	jr L_BB66		;bb61
L_BB63:
	ld hl,0bb7ch		;bb63
L_BB66:
	call 09b31h		;bb66
	ld a,(0e1c3h)		;bb69
	and 003h		;bb6c
	ret nz			;bb6e
	ld a,(ix+031h)		;bb6f
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


L_BB90:
	ld (ix+007h),013h		;bb90
	ld (ix+008h),030h		;bb94
	ld (ix+009h),004h		;bb98
	ld (ix+00ah),004h		;bb9c
	ld (ix+00dh),000h		;bba0
	ld (ix+002h),001h		;bba4
	ld a,(0e228h)		;bba8
	cp 006h		;bbab
	ld a,001h		;bbad
	jr c,L_BBB2		;bbaf
	inc a			;bbb1
L_BBB2:
	ld (ix+00eh),a		;bbb2
	ret			;bbb5
L_BBB6:
	call L_BBD6		;bbb6
	ld a,(ix+004h)		;bbb9
	cp 060h		;bbbc
	jr z,L_BBC4		;bbbe
	cp 030h		;bbc0
	jr nz,L_BBCC		;bbc2
L_BBC4:
	ld a,(ix+00eh)		;bbc4
	neg		;bbc7
	ld (ix+00eh),a		;bbc9
L_BBCC:
	ld a,(ix+004h)		;bbcc
	add a,(ix+00eh)		;bbcf
	ld (ix+004h),a		;bbd2
	ret			;bbd5
L_BBD6:
	dec (ix+002h)		;bbd6
	ret nz			;bbd9
	ld e,(ix+004h)		;bbda
	ld a,(ix+006h)		;bbdd
	sub 008h		;bbe0
	ld d,a			;bbe2
	ld (ix+002h),012h		;bbe3
	ld a,(0e228h)		;bbe7
	cp 006h		;bbea
	jp c,0938fh		;bbec
	ld (ix+002h),00ch		;bbef
	jp 0938fh		;bbf3
L_BBF6:
	ld de,0fa00h		;bbf6
	ld a,(0e228h)		;bbf9
	cp 006h		;bbfc
	ld a,028h		;bbfe
	jr nc,L_BC06		;bc00
	ld d,0fch		;bc02
	ld a,018h		;bc04
L_BC06:
	ld (ix+027h),a		;bc06
	call 04f02h		;bc09
	jp 04f1ch		;bc0c
L_BC0F:
	call L_BC9C		;bc0f
	ld a,(ix+001h)		;bc12
	dec a			;bc15
	jr z,L_BC2C		;bc16
	dec a			;bc18
	jr z,$+74		;bc19
	dec a			;bc1b
	jr z,$+105		;bc1c
	call L_BC7D		;bc1e
	rl h		;bc21
	ret c			;bc23
	ld (ix+025h),020h		;bc24
	inc (ix+001h)		;bc28
	ret			;bc2b
L_BC2C:
	call L_BC7D		;bc2c
	dec (ix+025h)		;bc2f
	ret nz			;bc32
	inc (ix+001h)		;bc33
	ld (ix+025h),004h		;bc36
	call 04f21h		;bc3a
	ld hl,0bc5dh		;bc3d
	ld b,003h		;bc40
L_BC42:
	push bc			;bc42
	xor a			;bc43
	ld b,(hl)			;bc44
	ld c,a			;bc45
	inc hl			;bc46
	ld d,(hl)			;bc47
	ld e,a			;bc48
	inc hl			;bc49
	push hl			;bc4a
	ex de,hl			;bc4b
	ld e,(ix+004h)		;bc4c
	ld a,(ix+006h)		;bc4f
	add a,008h		;bc52
	ld d,a			;bc54
	call 0937dh		;bc55
	pop hl			;bc58
	pop bc			;bc59
	djnz L_BC42		;bc5a
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


L_BC63:
	dec (ix+025h)		;bc63
	ret nz			;bc66
	inc (ix+001h)		;bc67
	ld (ix+025h),008h		;bc6a
	ld a,(0e228h)		;bc6e
	cp 006h		;bc71
	ld de,0fc00h		;bc73
	jr c,L_BC7A		;bc76
	ld d,0fah		;bc78
L_BC7A:
	jp 04f02h		;bc7a
L_BC7D:
	ld d,000h		;bc7d
	ld e,(ix+027h)		;bc7f
	jp 09d50h		;bc82
L_BC85:
	dec (ix+025h)		;bc85
	ret nz			;bc88
	ld a,(0e228h)		;bc89
	cp 006h		;bc8c
	ld (ix+025h),010h		;bc8e
	jp c,L_BB44		;bc92
	ld (ix+025h),008h		;bc95
	jp L_BB44		;bc99
L_BC9C:
	ld a,(0e1c3h)		;bc9c
	and 003h		;bc9f
	ret nz			;bca1
	ld a,(ix+030h)		;bca2
	add a,004h		;bca5
	cp 0e8h		;bca7
	jr nz,L_BCAD		;bca9
	ld a,0dch		;bcab
L_BCAD:
	ld (ix+030h),a		;bcad
	ret			;bcb0
L_BCB1:
	xor a			;bcb1
	ld (0f0f5h),a		;bcb2
	ld (0e229h),a		;bcb5
	ld bc,00400h		;bcb8
	ld hl,0fcc1h		;bcbb
L_BCBE:
	push bc			;bcbe
	push hl			;bcbf
	ld a,(hl)			;bcc0
	bit 7,a		;bcc1
	jr nz,L_BCD4		;bcc3
	call L_BCF0		;bcc5
L_BCC8:
	pop hl			;bcc8
	pop bc			;bcc9
	ld a,(0f0f5h)		;bcca
	and a			;bccd
	ret nz			;bcce
	inc hl			;bccf
	inc c			;bcd0
	djnz L_BCBE		;bcd1
	ret			;bcd3
L_BCD4:
	call L_BCD9		;bcd4
	jr L_BCC8		;bcd7
L_BCD9:
	and 080h		;bcd9
	or c			;bcdb
	ld c,a			;bcdc
	ld b,004h		;bcdd
L_BCDF:
	push bc			;bcdf
	call L_BCF0		;bce0
	pop bc			;bce3
	ld a,(0f0f5h)		;bce4
	and a			;bce7
	ret nz			;bce8
	ld a,c			;bce9
	add a,004h		;bcea
	ld c,a			;bcec
	djnz L_BCDF		;bced
	ret			;bcef
L_BCF0:
	ld de,0bd55h		;bcf0
	ld hl,07ffah		;bcf3
	ld b,006h		;bcf6
	call L_BD40		;bcf8
	jr nc,L_BD03		;bcfb
	ld hl,0f0f5h		;bcfd
	set 1,(hl)		;bd00
	ret			;bd02
L_BD03:
	ld de,0bd5bh		;bd03
	ld hl,04010h		;bd06
	ld b,004h		;bd09
	call L_BD40		;bd0b
	jr nc,L_BD16		;bd0e
	ld hl,0f0f5h		;bd10
	set 3,(hl)		;bd13
	ret			;bd15
L_BD16:
	ld de,0bd5fh		;bd16
	ld hl,04010h		;bd19
	ld b,004h		;bd1c
	call L_BD40		;bd1e
	jr nc,L_BD29		;bd21
	ld hl,0f0f5h		;bd23
	set 2,(hl)		;bd26
	ret			;bd28
L_BD29:
	ld de,0bd63h		;bd29
	ld hl,04010h		;bd2c
	ld b,004h		;bd2f
	call L_BD40		;bd31
	ret nc			;bd34
	ld hl,0f0f5h		;bd35
	set 0,(hl)		;bd38
	ld a,001h		;bd3a
	ld (0e229h),a		;bd3c
	ret			;bd3f
L_BD40:
	push bc			;bd40
	push de			;bd41
	ld a,c			;bd42
	call 0000ch		;bd43   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;bd46
	pop bc			;bd47
	ex de,hl			;bd48
	cp (hl)			;bd49
	ex de,hl			;bd4a
	jr nz,L_BD53		;bd4b
	inc hl			;bd4d
	inc de			;bd4e
	djnz L_BD40		;bd4f
	scf			;bd51
	ret			;bd52
L_BD53:
	and a			;bd53
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


L_BD67:
	push hl			;bd67
	push bc			;bd68
	ld hl,00000h		;bd69
	ld (0e3e0h),hl		;bd6c
	ld hl,0e3e8h		;bd6f
	ld b,008h		;bd72
L_BD74:
	ld (hl),000h		;bd74
	inc hl			;bd76
	djnz L_BD74		;bd77
	pop bc			;bd79
	pop hl			;bd7a
	ret			;bd7b
L_BD7C:
	ld a,(0e400h)		;bd7c
	and a			;bd7f
	ret m			;bd80
	ld a,(0f0f5h)		;bd81
	bit 0,a		;bd84
	ret z			;bd86
	call L_BECA		;bd87
	and a			;bd8a
	ret z			;bd8b
	ld hl,0e3e1h		;bd8c
	cp (hl)			;bd8f
	ret z			;bd90
	ld (hl),a			;bd91
	ld c,a			;bd92
	cp 00dh		;bd93
	jr z,L_BDA7		;bd95
	ld hl,0e3e0h		;bd97
	ld a,(hl)			;bd9a
	cp 008h		;bd9b
	ret nc			;bd9d
	inc (hl)			;bd9e
	ld hl,0e3e8h		;bd9f
	call 0407ah		;bda2
	ld (hl),c			;bda5
	ret			;bda6
L_BDA7:
	ld hl,L_BD67		;bda7
	push hl			;bdaa
	ld bc,00300h		;bdab
L_BDAE:
	push bc			;bdae
	call L_BDB9		;bdaf
	pop bc			;bdb2
	jr nc,L_BDCE		;bdb3
	inc c			;bdb5
	djnz L_BDAE		;bdb6
	ret			;bdb8
L_BDB9:
	ld hl,0beaah		;bdb9
	ld a,c			;bdbc
	call 04b67h		;bdbd
	ld hl,0e3e8h		;bdc0
L_BDC3:
	ld a,(de)			;bdc3
	cp 00dh		;bdc4
	ret z			;bdc6
	cp (hl)			;bdc7
	inc de			;bdc8
	inc hl			;bdc9
	jr z,L_BDC3		;bdca
	scf			;bdcc
	ret			;bdcd
L_BDCE:
	ld a,c			;bdce
	call 04084h		;bdcf

; ----------------------------------------------------------------------
; DATOS tabla_BDD2: 3 destinos del despachador p00:4084 (call en p03:BDCF, el
;   indice en A): BDD8, BE87, BE90; lo leen p03:BDCF (6 bytes)
;   0xbdd2..0xbdd8  (6 bytes)
DATA_tabla_BDD2:
	defw 0bdd8h,0be87h,0be90h	; bdd2  -> L_BDD8 L_BE87 L_BE90

; ======================================================================
; CODIGO 0xbdd8..0xbe07  (47 bytes)
; ======================================================================


L_BDD8:
	ld a,(0e20fh)		;bdd8
	add a,a			;bddb
	add a,a			;bddc
	add a,a			;bddd
	add a,a			;bdde
	ld hl,0be07h		;bddf
	call 0407ah		;bde2
	ld de,0e334h		;bde5
	ld bc,00009h		;bde8
	ldir		;bdeb
	ld de,0e430h		;bded
	ld bc,00007h		;bdf0
	ldir		;bdf3
	call 08060h		;bdf5
	call 081b5h		;bdf8
	call 0448eh		;bdfb
	ld a,(0e20fh)		;bdfe
	cp 004h		;be01
	ret nz			;be03
	jp 04482h		;be04

; ----------------------------------------------------------------------
; DATOS inicio_por_vuelta: 8 filas de 16 bytes, una por vuelta (0xE20F):
;   p03:BDD8 copia 9 a 0xE334 y 7 a 0xE430; lo leen p03:BDE2 (128 bytes)
;   0xbe07..0xbe87  (128 bytes)
DATA_inicio_por_vuelta:
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


L_BE87:
	call 04a08h		;be87
	call 04c76h		;be8a
	jp 07c11h		;be8d
L_BE90:
	ld hl,01e01h		;be90
	ld (0e446h),hl		;be93
	ret			;be96
L_BE97:
	ld hl,0e446h		;be97
	ld a,(hl)			;be9a
	or a			;be9b
	ret z			;be9c
	ld a,(0e1c3h)		;be9d
	and 01fh		;bea0
	ret nz			;bea2
	inc l			;bea3
	dec (hl)			;bea4
	ret nz			;bea5
	dec l			;bea6
	ld (hl),000h		;bea7
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


L_BECA:
	ld b,008h		;beca
	ld e,000h		;becc
L_BECE:
	ld a,e			;bece
	call 00141h		;becf   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;bed2
	and a			;bed3
	jr nz,L_BEDE		;bed4
	inc e			;bed6
	djnz L_BECE		;bed7
	xor a			;bed9
	ld (0e3e1h),a		;beda
	ret			;bedd
L_BEDE:
	ld b,a			;bede
	ld a,e			;bedf
	add a,a			;bee0
	add a,a			;bee1
	add a,a			;bee2
	ld hl,0bef2h		;bee3
	call 0407ah		;bee6
	ld a,b			;bee9
L_BEEA:
	rra			;beea
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


L_BF3A:
	ld a,(0e400h)		;bf3a
	dec a			;bf3d
	ret m			;bf3e
	ld a,(0e3d0h)		;bf3f
	and a			;bf42
	jr z,L_BF54		;bf43
	ld hl,0e3d5h		;bf45
	dec (hl)			;bf48
	ret nz			;bf49
	ld a,002h		;bf4a
	ld (0e3d0h),a		;bf4c
	ld a,03ch		;bf4f
	jp 04ae4h		;bf51
L_BF54:
	call L_BF62		;bf54
	ld a,(0e3d1h)		;bf57
	and a			;bf5a
	ret z			;bf5b
	call L_BFB2		;bf5c
	jp L_BFA0		;bf5f
L_BF62:
	ld a,(0e320h)		;bf62
	and a			;bf65
	ret z			;bf66
	ld a,(0e201h)		;bf67
	ld hl,(0e203h)		;bf6a
	cp 003h		;bf6d
	jr z,L_BF7A		;bf6f
	cp 006h		;bf71
	jr z,L_BF83		;bf73
	cp 00ah		;bf75
	jr z,L_BF8C		;bf77
	ret			;bf79
L_BF7A:
	ld de,00174h		;bf7a
	rst 20h			;bf7d
	ret nz			;bf7e
	ld e,090h		;bf7f
	jr L_BF95		;bf81
L_BF83:
	ld de,00164h		;bf83
	rst 20h			;bf86
	ret nz			;bf87
	ld e,088h		;bf88
	jr L_BF95		;bf8a
L_BF8C:
	ld de,000dfh		;bf8c
	rst 20h			;bf8f
	ret nz			;bf90
	ld e,030h		;bf91
	jr L_BF95		;bf93
L_BF95:
	ld hl,0e3d1h		;bf95
	ld (hl),001h		;bf98
	inc l			;bf9a
	ld (hl),e			;bf9b
	inc l			;bf9c
	ld (hl),0f0h		;bf9d
	ret			;bf9f
L_BFA0:
	ld a,(0e320h)		;bfa0
	and a			;bfa3
	ret z			;bfa4
	ld hl,0e3d3h		;bfa5
	ld a,(hl)			;bfa8
	sub 008h		;bfa9
	ld (hl),a			;bfab
	ret nc			;bfac
	dec l			;bfad
	dec l			;bfae
	ld (hl),000h		;bfaf
	ret			;bfb1
L_BFB2:
	ld hl,0e3d2h		;bfb2
	ld a,(0e404h)		;bfb5
	sub (hl)			;bfb8
	add a,008h		;bfb9
	cp 018h		;bfbb
	ret nc			;bfbd
	inc l			;bfbe
	ld a,(0e406h)		;bfbf
	sub (hl)			;bfc2
	cp 010h		;bfc3
	ret nc			;bfc5
	ld a,(0e201h)		;bfc6
	cp 003h		;bfc9
	jr z,L_BFDB		;bfcb
	cp 006h		;bfcd
	jr z,L_BFD6		;bfcf
	ld hl,0017fh		;bfd1
	jr L_BFDE		;bfd4
L_BFD6:
	ld hl,001dfh		;bfd6
	jr L_BFDE		;bfd9
L_BFDB:
	ld hl,001ffh		;bfdb
L_BFDE:
	ld (0e325h),hl		;bfde
	ld a,040h		;bfe1
	ld (0e3d5h),a		;bfe3
	xor a			;bfe6
	ld (0e3d1h),a		;bfe7
	inc a			;bfea
	ld (0e3d0h),a		;bfeb
	call 08fa2h		;bfee
	ld a,043h		;bff1
	jp 04ae4h		;bff3

; ----------------------------------------------------------------------
; DATOS relleno_ff: 10 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (10 bytes)
;   0xbff6..0xc000  (10 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff6  ..........

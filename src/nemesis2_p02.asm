; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l97b8h:	equ 0x097b8

; ----------------------------------------------------------------------
; DATOS partida_8000: el operando (0xE20F) de `ld a,(nn)`, la instruccion que
;   empieza en p01:7FFF; el codigo sigue en 0x8002; lo leen p01:7FFF (2 bytes)
;   0x8000..0x8002  (2 bytes)
DATA_partida_8000:
	defb 00fh,0e2h	; 8000

; ======================================================================
; CODIGO 0x8002..0x806d  (107 bytes)
; ======================================================================


L_8002:
	cp 004h		;8002
	ret c			;8004
	cp 006h		;8005
	jr c,$-74		;8007
	jr $-15		;8009
L_800B:
	ld a,(0e20fh)		;800b
	cp 001h		;800e
	jr z,L_801D		;8010
	cp 006h		;8012
	jr c,L_8022		;8014
	call 07fbdh		;8016
L_8019:
	xor a			;8019
	ld (0e337h),a		;801a
L_801D:
	xor a			;801d
	ld (0e336h),a		;801e
	ret			;8021
L_8022:
	xor a			;8022
	ld (0e338h),a		;8023
	jr L_801D		;8026
L_8028:
	ld a,(0e20fh)		;8028
	cp 002h		;802b
	ret c			;802d
	cp 006h		;802e
	jr c,L_8036		;8030
	xor a			;8032
	ld (0e338h),a		;8033
L_8036:
	xor a			;8036
	ld (0e337h),a		;8037
	ld (0e336h),a		;803a
	ld (0e335h),a		;803d
	ret			;8040
L_8041:
	ld a,(0e20fh)		;8041
	cp 006h		;8044
	jr c,L_801D		;8046
	jr L_8019		;8048
L_804A:
	ld a,(0e20fh)		;804a
	ld c,a			;804d
	add a,a			;804e
	add a,a			;804f
	add a,a			;8050
	add a,c			;8051
	ld c,a			;8052
	ld a,(0e33dh)		;8053
	add a,c			;8056
	ld c,a			;8057
	ld b,000h		;8058
	ld hl,08074h		;805a
	add hl,bc			;805d
	ld c,(hl)			;805e
	ret			;805f
L_8060:
	ld hl,0806dh		;8060
	ld a,(0e20fh)		;8063
	call 05ca6h		;8066
	ld (0e331h),a		;8069
	ret			;806c

; ----------------------------------------------------------------------
; DATOS tabla_806D: 8 bytes, uno por vuelta (0xE20F), que p02:8060 pone en
;   0xE331; el octavo es el primero de 0x8074; lo leen p02:8066 (7 bytes)
;   0x806d..0x8074  (7 bytes)
DATA_tabla_806D:
	defb 007h,008h,009h,009h,009h,009h,00ah	; 806d

; ----------------------------------------------------------------------
; DATOS tabla_8074: 8 filas de 9 bytes, una por vuelta: p02:804A lee 0x8074 +
;   9 x 0xE20F + 0xE33D; lo leen p02:805D (72 bytes)
;   0x8074..0x80bc  (72 bytes)
DATA_tabla_8074:
	defb 00ah,007h,002h,001h,002h,002h,001h,000h,000h	; 8074  .........
	defb 000h,007h,002h,001h,002h,002h,002h,001h,000h	; 807d  .........
	defb 000h,007h,002h,001h,002h,002h,002h,001h,001h	; 8086  .........
	defb 000h,007h,003h,001h,002h,002h,002h,001h,001h	; 808f  .........
	defb 000h,007h,003h,002h,002h,002h,002h,001h,001h	; 8098  .........
	defb 000h,007h,003h,002h,002h,002h,003h,002h,001h	; 80a1  .........
	defb 000h,007h,003h,001h,002h,002h,002h,003h,002h	; 80aa  .........
	defb 001h,007h,003h,001h,003h,002h,002h,003h,002h	; 80b3  .........

; ----------------------------------------------------------------------
; DATOS tabla_8074_cola: el byte de detras de las 8 filas de 0x8074: la
;   casilla 9 de la fila 7, si 0xE33D llegara a 9; lo leen p02:805D (1 bytes)
;   0x80bc..0x80bd  (1 bytes)
DATA_tabla_8074_cola:
	defb 001h	; 80bc

; ======================================================================
; CODIGO 0x80bd..0x8148  (139 bytes)
; ======================================================================


L_80BD:
	call L_80C6		;80bd
	call L_8060		;80c0
	jp 05387h		;80c3
L_80C6:
	ld b,a			;80c6
L_80C7:
	ld hl,0e20fh		;80c7
	ld a,(hl)			;80ca
	inc a			;80cb
	cp 008h		;80cc
	ret nc			;80ce
	ld (hl),a			;80cf
	push bc			;80d0
	call L_80D8		;80d1
	pop bc			;80d4
	djnz L_80C7		;80d5
	ret			;80d7
L_80D8:
	ld hl,0f010h		;80d8
	ld de,0f011h		;80db
	ld bc,00008h		;80de
	ld (hl),000h		;80e1
	ldir		;80e3
	ld a,(0e20fh)		;80e5
	ld hl,08146h		;80e8
	call 04b67h		;80eb
	ex de,hl			;80ee
L_80EF:
	ld a,(hl)			;80ef
	or a			;80f0
	jr z,L_8107		;80f1
	inc hl			;80f3
	ld c,(hl)			;80f4
	inc hl			;80f5
	push hl			;80f6
	ld hl,0e333h		;80f7
	add a,l			;80fa
	ld l,a			;80fb
	ld de,0f00fh		;80fc
	ld a,c			;80ff
	add a,e			;8100
	ld e,a			;8101
	ldi		;8102
	pop hl			;8104
	jr L_80EF		;8105
L_8107:
	ld hl,0f010h		;8107
	ld de,0e334h		;810a
	ld bc,00009h		;810d
	ldir		;8110
	ld a,(0e20fh)		;8112
	cp 003h		;8115
	jr z,L_813F		;8117
	cp 004h		;8119
	jr z,L_8136		;811b
	cp 005h		;811d
	jr z,L_812D		;811f
	cp 007h		;8121
	ret nz			;8123
	ld hl,0e337h		;8124
	ld a,(hl)			;8127
	inc a			;8128
	ret nz			;8129
	ld (hl),002h		;812a
	ret			;812c
L_812D:
	ld hl,0e339h		;812d
	ld a,(hl)			;8130
	inc a			;8131
	ret nz			;8132
	ld (hl),002h		;8133
	ret			;8135
L_8136:
	ld hl,0e336h		;8136
	ld a,(hl)			;8139
	inc a			;813a
	ret nz			;813b
	ld (hl),001h		;813c
	ret			;813e
L_813F:
	ld hl,0e335h		;813f
	ld a,(hl)			;8142
	inc a			;8143
	ret nz			;8144
	ld (hl),002h		;8145
	ret			;8147

; ----------------------------------------------------------------------
; DATOS listas_por_vuelta: 7 punteros (vueltas 1 a 7: p02:80E5 lee 0x8146 + 2
;   x 0xE20F con L_4B67, y la 0 caeria en el `ret` de delante) a listas
;   [casilla][valor]; lo leen p02:80EB (14 bytes)
;   0x8148..0x8156  (14 bytes)
DATA_listas_por_vuelta:
	defw 08156h,08163h,08174h,08174h,08174h,08185h,08172h	; 8148

; ----------------------------------------------------------------------
; DATOS listas_8156: las listas de p02:80EF: pares [casilla de 0xE333][valor]
;   hasta un 0 (0x8156, 0x8163, 0x8172, 0x8174 y 0x8185, que comparten
;   finales); lo leen p02:80EF (64 bytes)
;   0x8156..0x8196  (64 bytes)
DATA_listas_8156:
	defb 006h,007h,005h,006h,004h,005h,003h,003h,002h,002h,001h,001h,000h,007h,008h,006h	; 8156  ................
	defb 007h,005h,006h,004h,004h,003h,003h,002h,002h,001h,001h,000h,009h,009h,008h,008h	; 8166  ................
	defb 007h,007h,006h,006h,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h,000h,008h	; 8176  ................
	defb 009h,007h,008h,006h,007h,005h,006h,004h,005h,003h,004h,002h,002h,001h,001h,000h	; 8186  ................

; ======================================================================
; CODIGO 0x8196..0x81ca  (52 bytes)
; ======================================================================


L_8196:
	ld a,007h		;8196
	ld (0e20fh),a		;8198
	ld a,00ah		;819b
	ld (0e331h),a		;819d
	ld hl,081cah		;81a0
	ld de,0e334h		;81a3
	ld bc,00009h		;81a6
	ldir		;81a9
	ld de,0e430h		;81ab
	ld bc,00007h		;81ae
	ldir		;81b1
	ld c,07fh		;81b3
L_81B5:
	ld hl,0e400h		;81b5
	ld (hl),002h		;81b8
	inc l			;81ba
	ld (hl),c			;81bb
	inc l			;81bc
	ld (hl),002h		;81bd
	ld a,002h		;81bf
	ld (0e40bh),a		;81c1
	call 07e13h		;81c4
	jp 053a3h		;81c7

; ----------------------------------------------------------------------
; DATOS inicio_E334: 9 bytes que p02:81A0 copia a 0xE334 y 7 a 0xE430; lo leen
;   p02:81A0 (16 bytes)
;   0x81ca..0x81da  (16 bytes)
DATA_inicio_E334:
	defb 002h,0ffh,000h,000h,0ffh,000h,002h,0ffh,0ffh,000h,000h,002h,003h,002h,000h,000h	; 81ca  ................

; ======================================================================
; CODIGO 0x81da..0x81fb  (33 bytes)
; ======================================================================


L_81DA:
	exx			;81da
	ld a,(0e305h)		;81db
	ld c,a			;81de
	exx			;81df
	ld iy,0e470h		;81e0
	ld b,009h		;81e4
L_81E6:
	push bc			;81e6
	call L_81F3		;81e7
	ld bc,00010h		;81ea
	add iy,bc		;81ed
	pop bc			;81ef
	djnz L_81E6		;81f0
L_81F2:
	ret			;81f2
L_81F3:
	ld a,(iy+000h)		;81f3
	dec a			;81f6
	ret m			;81f7
	call 04084h		;81f8

; ----------------------------------------------------------------------
; DATOS tabla_81FB: 15 destinos del despachador p00:4084 (call en p02:81F8, el
;   indice en A): 8219, 8227, 8219, 824A, 824A, 81F2, 827C, 827C, 8308, 82D8,
;   82D8, 82D8, 82D8, 8366, 827C; lo leen p02:81F8 (30 bytes)
;   0x81fb..0x8219  (30 bytes)
DATA_tabla_81FB:
	defw 08219h,08227h,08219h,0824ah,0824ah,081f2h,0827ch,0827ch	; 81fb
	defw 08308h,082d8h,082d8h,082d8h,082d8h,08366h,0827ch	; 820b

; ======================================================================
; CODIGO 0x8219..0x84ca  (689 bytes)
; ======================================================================


L_8219:
	ld a,(iy+005h)		;8219
	sub 008h		;821c
	ld h,a			;821e
	call L_822A		;821f
	ld a,(iy+000h)		;8222
	or a			;8225
	ret z			;8226
L_8227:
	ld h,(iy+005h)		;8227
L_822A:
	ld l,(iy+003h)		;822a
	call L_8388		;822d
	ret nc			;8230
	ld (iy+000h),000h		;8231
	ld a,(0e340h)		;8235
	or a			;8238
	jp z,L_8481		;8239
L_823C:
	ld a,(0e309h)		;823c
	or a			;823f
	ret nz			;8240
	inc a			;8241
	ld (0e309h),a		;8242
	ld a,005h		;8245
	jp 04ae4h		;8247
L_824A:
	ld h,(iy+005h)		;824a
	ld l,(iy+003h)		;824d
	call L_8388		;8250
	jr nc,L_826B		;8253
	ld (iy+000h),000h		;8255
	ld a,(0e340h)		;8259
	or a			;825c
	jp nz,L_823C		;825d
	ld a,(0e201h)		;8260
	cp 005h		;8263
	ret nz			;8265
	ld a,012h		;8266
	jp 04ae4h		;8268
L_826B:
	ld a,(0e340h)		;826b
	or a			;826e
	ret nz			;826f
	ld h,(iy+005h)		;8270
	ld a,(iy+003h)		;8273
	add a,008h		;8276
	ld l,a			;8278
	jp L_8388		;8279
L_827C:
	ld h,(iy+005h)		;827c
	ld l,(iy+003h)		;827f
	call 05c92h		;8282
	ex de,hl			;8285
	ld a,(iy+00ah)		;8286
	or a			;8289
	ret z			;828a
	ld b,a			;828b
L_828C:
	call L_82BC		;828c
	jr nc,L_829C		;828f
	ld a,(0e340h)		;8291
	or a			;8294
	jr nz,L_82A0		;8295
	call L_8481		;8297
	jr nc,L_82A0		;829a
L_829C:
	inc de			;829c
	djnz L_828C		;829d
	ret			;829f
L_82A0:
	ld a,(iy+00ah)		;82a0
	inc b			;82a3
	sub b			;82a4
	jp c,0ae02h		;82a5
	jp z,0ae02h		;82a8
	ld (iy+00ah),a		;82ab
	ld a,(iy+000h)		;82ae
	cp 00fh		;82b1
	ld a,001h		;82b3
	jr z,L_82B8		;82b5
	inc a			;82b7
L_82B8:
	ld (iy+001h),a		;82b8
	ret			;82bb
L_82BC:
	ld a,(0e201h)		;82bc
	or a			;82bf
	jr z,L_82CF		;82c0
	sub 007h		;82c2
	cp 002h		;82c4
	jr c,L_82CF		;82c6
	ld a,(de)			;82c8
	and a			;82c9
	ret z			;82ca
	exx			;82cb
	cp c			;82cc
	exx			;82cd
	ret			;82ce
L_82CF:
	ld a,(de)			;82cf
	cp 009h		;82d0
	ccf			;82d2
	ret nc			;82d3
	exx			;82d4
	cp c			;82d5
	exx			;82d6
	ret			;82d7
L_82D8:
	ld h,(iy+005h)		;82d8
	ld l,(iy+003h)		;82db
	call 05c92h		;82de
	ex de,hl			;82e1
	ld a,(iy+00ah)		;82e2
	or a			;82e5
	ret z			;82e6
	ld b,a			;82e7
L_82E8:
	call L_82BC		;82e8
	jr nc,L_82FA		;82eb
	ld a,(0e340h)		;82ed
	or a			;82f0
	jp nz,0ae02h		;82f1
	call L_8481		;82f4
	jp nc,0ae02h		;82f7
L_82FA:
	inc de			;82fa
	djnz L_82E8		;82fb
	ret			;82fd
L_82FE:
	ld a,(iy+00ah)		;82fe
	add a,a			;8301
	add a,a			;8302
	add a,a			;8303
	ld (iy+00ch),a		;8304
	ret			;8307
L_8308:
	ld h,(iy+005h)		;8308
	ld l,(iy+003h)		;830b
	call 05c92h		;830e
	ld (0f000h),hl		;8311
	ex de,hl			;8314
	ld a,(iy+00ah)		;8315
	or a			;8318
	jr z,L_835C		;8319
	ld b,a			;831b
L_831C:
	call L_82BC		;831c
	jr nc,L_832E		;831f
	ld a,(0e340h)		;8321
	or a			;8324
	jp nz,0ae02h		;8325
	call L_8481		;8328
	jp nc,0ae02h		;832b
L_832E:
	ld a,020h		;832e
	call 0407fh		;8330
	djnz L_831C		;8333
	ld a,(0e320h)		;8335
	or a			;8338
	jr z,L_835C		;8339
	ld de,(0f000h)		;833b
	dec de			;833f
	ld b,(iy+00ah)		;8340
L_8343:
	call L_82BC		;8343
	jr nc,L_8355		;8346
	ld a,(0e340h)		;8348
	or a			;834b
	jp nz,0ae02h		;834c
	call L_8481		;834f
	jp nc,0ae02h		;8352
L_8355:
	ld a,020h		;8355
	call 0407fh		;8357
	djnz L_8343		;835a
L_835C:
	ld a,(iy+00ah)		;835c
	add a,a			;835f
	add a,a			;8360
	add a,a			;8361
	ld (iy+00dh),a		;8362
	ret			;8365
L_8366:
	ld h,(iy+005h)		;8366
	ld l,(iy+003h)		;8369
	call 05c92h		;836c
	ex de,hl			;836f
	ld b,002h		;8370
L_8372:
	call L_82BC		;8372
	jr nc,L_8384		;8375
	ld a,(0e340h)		;8377
	or a			;837a
	jp nz,0ae02h		;837b
	call L_8481		;837e
	jp nc,0ae02h		;8381
L_8384:
	inc de			;8384
	djnz L_8372		;8385
	ret			;8387
L_8388:
	call 05c92h		;8388
	ex de,hl			;838b
	call L_8395		;838c
	ret c			;838f
	inc de			;8390
	ld a,e			;8391
	and 01fh		;8392
	ret z			;8394
L_8395:
	ld a,(0e201h)		;8395
	or a			;8398
	jr z,L_83A8		;8399
	sub 007h		;839b
	cp 002h		;839d
	jr c,L_83A8		;839f
	ld a,(de)			;83a1
	and a			;83a2
	ret z			;83a3
	exx			;83a4
	cp c			;83a5
	exx			;83a6
	ret			;83a7
L_83A8:
	ld a,(de)			;83a8
	cp 009h		;83a9
	ccf			;83ab
	ret nc			;83ac
	exx			;83ad
	cp c			;83ae
	exx			;83af
	ret			;83b0
L_83B1:
	ld a,(ix+004h)		;83b1
	sub 008h		;83b4
	ld l,a			;83b6
L_83B7:
	ld h,(ix+006h)		;83b7
	call 05c92h		;83ba
	ld a,(0e305h)		;83bd
	ld c,a			;83c0
	ld b,006h		;83c1
L_83C3:
	ld a,(hl)			;83c3
	inc l			;83c4
	and a			;83c5
	ret z			;83c6
	cp c			;83c7
	ret c			;83c8
	djnz L_83C3		;83c9
	xor a			;83cb
	ret			;83cc
L_83CD:
	ld a,(ix+004h)		;83cd
	add a,030h		;83d0
	cp 0a0h		;83d2
	ccf			;83d4
	ret c			;83d5
	ld l,a			;83d6
	jr L_83B7		;83d7
L_83D9:
	call 05c92h		;83d9
	ld c,08ah		;83dc
	ld a,(0e201h)		;83de
	dec a			;83e1
	jr z,L_83F2		;83e2
	ld c,067h		;83e4
	jr L_83F2		;83e6
L_83E8:
	call 05c92h		;83e8
	ld (0e3bch),hl		;83eb
L_83EE:
	ld a,(0e305h)		;83ee
	ld c,a			;83f1
L_83F2:
	call L_83FB		;83f2
	ret c			;83f5
	inc hl			;83f6
	ld a,l			;83f7
	and 01fh		;83f8
	ret z			;83fa
L_83FB:
	ld a,(0e201h)		;83fb
	or a			;83fe
	jr z,L_840C		;83ff
	sub 007h		;8401
	cp 002h		;8403
	jr c,L_840C		;8405
	ld a,(hl)			;8407
	and a			;8408
	ret z			;8409
	cp c			;840a
	ret			;840b
L_840C:
	ld a,(hl)			;840c
	cp 009h		;840d
	ccf			;840f
	ret nc			;8410
	cp c			;8411
	ret			;8412
L_8413:
	ld a,(0e400h)		;8413
	dec a			;8416
	ret m			;8417
	ld a,(0e3d0h)		;8418
	or a			;841b
	ret nz			;841c
	exx			;841d
	ld a,(0e305h)		;841e
	ld c,a			;8421
	exx			;8422
	call L_844A		;8423
	ret nc			;8426
	ld a,(0e400h)		;8427
	cp 003h		;842a
	jp nz,L_8E7C		;842c
	call L_8481		;842f
	jp nc,L_8E7C		;8432
	ld a,(0e404h)		;8435
	add a,008h		;8438
	ld l,a			;843a
	ld a,(0e406h)		;843b
	ld h,a			;843e
	call 05c92h		;843f
	ex de,hl			;8442
	call L_8481		;8443
	inc de			;8446
	jp L_8481		;8447
L_844A:
	ld a,(0e404h)		;844a
	add a,008h		;844d
	ld l,a			;844f
	ld a,(0e406h)		;8450
	ld h,a			;8453
	and 007h		;8454
	cp 004h		;8456
	push af			;8458
	call 05c92h		;8459
	ex de,hl			;845c
	pop af			;845d
	jr nc,L_8464		;845e
	call L_8465		;8460
	ret c			;8463
L_8464:
	inc de			;8464
L_8465:
	ld a,(0e201h)		;8465
	or a			;8468
	jr z,L_8478		;8469
	sub 007h		;846b
	cp 002h		;846d
	jr c,L_8478		;846f
	ld a,(de)			;8471
	or a			;8472
	ret z			;8473
	exx			;8474
	cp c			;8475
	exx			;8476
	ret			;8477
L_8478:
	ld a,(de)			;8478
	cp 009h		;8479
	ccf			;847b
	ret nc			;847c
	exx			;847d
	cp c			;847e
	exx			;847f
	ret			;8480
L_8481:
	ld hl,0af04h		;8481
	ld a,(0e201h)		;8484
	sub 002h		;8487
	jr z,L_849F		;8489
	ld h,067h		;848b
	sub 004h		;848d
	jr z,L_849F		;848f
	dec a			;8491
	jr z,L_84AA		;8492
	ld hl,0a001h		;8494
	sub 002h		;8497
	cp 003h		;8499
	jr c,L_849F		;849b
	xor a			;849d
	ret			;849e
L_849F:
	ld a,(de)			;849f
	sub h			;84a0
	cp l			;84a1
	ret nc			;84a2
	xor a			;84a3
	ld (de),a			;84a4
	call L_84BC		;84a5
	scf			;84a8
	ret			;84a9
L_84AA:
	ld a,(de)			;84aa
	sub 01fh		;84ab
	cp 05ch		;84ad
	ret nc			;84af
	ld hl,084cah		;84b0
	call 05ca6h		;84b3
	ld (de),a			;84b6
	call L_84BC		;84b7
	scf			;84ba
	ret			;84bb
L_84BC:
	ld a,(0e308h)		;84bc
	or a			;84bf
	ret nz			;84c0
	inc a			;84c1
	ld (0e308h),a		;84c2
	ld a,004h		;84c5
	jp 04ae4h		;84c7

; ----------------------------------------------------------------------
; DATOS tabla_84CA: 92 bytes que p02:84AA lee con (DE) - 0x1F < 0x5C (L_5CA6);
;   lo leen p02:84B3 (92 bytes)
;   0x84ca..0x8526  (92 bytes)
DATA_tabla_84CA:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0a2h,0a2h,0a3h,0a3h,0a3h,0a4h	; 84ca  ................
	defb 0a5h,0a5h,0a5h,0a6h,0a6h,0a7h,0a7h,0a8h,0a9h,0aah,0aah,0abh,0abh,0abh,0abh,0ach	; 84da  ................
	defb 0ach,0ach,0adh,0adh,0aeh,0aeh,0afh,0b0h,0b0h,0b0h,0b1h,0b1h,0b1h,0b1h,0b2h,0b2h	; 84ea  ................
	defb 0b2h,0b2h,0b3h,0b3h,0b3h,0b3h,0b4h,0b5h,0b6h,0b6h,0b7h,0b7h,0b8h,0b8h,0b8h,0b8h	; 84fa  ................
	defb 0b9h,0bah,0bah,0bbh,0bbh,0bbh,0bbh,0bch,0bch,0bdh,0bdh,0beh,0beh,0bfh,0bfh,0bfh	; 850a  ................
	defb 0c0h,0c1h,0c1h,0c2h,0c2h,0c2h,0c4h,0c4h,0c5h,0c6h,0a1h,0c3h	; 851a  ............

; ======================================================================
; CODIGO 0x8526..0x8762  (572 bytes)
; ======================================================================


L_8526:
	ld a,(0ea60h)		;8526
	or a			;8529
	ret z			;852a
	ld a,(0e320h)		;852b
	or a			;852e
	ret z			;852f
	ld a,(0ea62h)		;8530
	sub 008h		;8533
	ld (0ea62h),a		;8535
	ret nc			;8538
	xor a			;8539
	ld (0ea60h),a		;853a
	ret			;853d
L_853E:
	ld a,(0ea60h)		;853e
	or a			;8541
	ret z			;8542
	ld hl,(0ea61h)		;8543
	ld a,h			;8546
	cp 0f8h		;8547
	ret nc			;8549
	call 05c92h		;854a
	ld (0ea63h),hl		;854d
	ld c,0e9h		;8550
	jp 05227h		;8552
L_8555:
	ld a,(0ea60h)		;8555
	or a			;8558
	ret z			;8559
	ld hl,(0ea61h)		;855a
	ld a,h			;855d
	cp 0f8h		;855e
	ret nc			;8560
	ld hl,(0ea63h)		;8561
	xor a			;8564
	ld (hl),a			;8565
	inc l			;8566
	ld (hl),a			;8567
	ld bc,0001fh		;8568
	add hl,bc			;856b
	ld (hl),a			;856c
	inc l			;856d
	ld (hl),a			;856e
	ret			;856f
L_8570:
	ld a,(0e201h)		;8570
	cp 008h		;8573
	ret nz			;8575
	ld a,(0e320h)		;8576
	or a			;8579
	ret z			;857a
	ld hl,(0e203h)		;857b
	ld de,0007fh		;857e
	rst 20h			;8581
	ret nz			;8582
	ld hl,0ea90h		;8583
	ld (hl),001h		;8586
	inc l			;8588
	ld (hl),040h		;8589
	inc l			;858b
	ld (hl),0e0h		;858c
	inc l			;858e
	ld (hl),018h		;858f
	ret			;8591
L_8592:
	ld hl,0ea90h		;8592
	ld a,(hl)			;8595
	or a			;8596
	ret z			;8597
	ld a,(0e320h)		;8598
	or a			;859b
	ret z			;859c
	inc l			;859d
	inc l			;859e
	ld a,(hl)			;859f
	sub 008h		;85a0
	ld (hl),a			;85a2
	ret nc			;85a3
	xor a			;85a4
	ld (0ea90h),a		;85a5
	ret			;85a8
L_85A9:
	ld a,(0ea90h)		;85a9
	dec a			;85ac
	ret nz			;85ad
	ld iy,0e470h		;85ae
	ld b,009h		;85b2
L_85B4:
	push bc			;85b4
	ld a,(iy+000h)		;85b5
	or a			;85b8
	call nz,L_85C6		;85b9
	pop bc			;85bc
	ret c			;85bd
	ld de,00010h		;85be
	add iy,de		;85c1
	djnz L_85B4		;85c3
	ret			;85c5
L_85C6:
	cp 006h		;85c6
	ret z			;85c8
	ld hl,0ea91h		;85c9
	ld a,(hl)			;85cc
	sub (iy+003h)		;85cd
	jp nc,L_85DB		;85d0
	neg		;85d3
	cp 020h		;85d5
	jp c,L_85DF		;85d7
	ret			;85da
L_85DB:
	cp (iy+00dh)		;85db
	ret nc			;85de
L_85DF:
	inc l			;85df
	ld a,(hl)			;85e0
	sub (iy+005h)		;85e1
	jp nc,L_85EF		;85e4
	neg		;85e7
	cp 020h		;85e9
	jp c,L_85F3		;85eb
	ret			;85ee
L_85EF:
	cp (iy+00ch)		;85ef
	ret nc			;85f2
L_85F3:
	call L_85F8		;85f3
	scf			;85f6
	ret			;85f7
L_85F8:
	ld a,(iy+000h)		;85f8
	cp 005h		;85fb
	jr nz,L_8605		;85fd
	call L_8A0C		;85ff
	jp L_8609		;8602
L_8605:
	ld (iy+000h),000h		;8605
L_8609:
	ld hl,0ea93h		;8609
	dec (hl)			;860c
	jp m,L_8626		;860d
	ld e,(iy+003h)		;8610
	ld a,r		;8613
	and 00fh		;8615
	dec l			;8617
	add a,(hl)			;8618
	ld d,a			;8619
	ld a,033h		;861a
	ld c,000h		;861c
	call 04d1eh		;861e
	ld a,005h		;8621
	jp 04ae4h		;8623
L_8626:
	ld a,002h		;8626
	ld (0ea90h),a		;8628
	ld hl,(0ea91h)		;862b
	call 05c92h		;862e
	xor a			;8631
	ld de,0001ch		;8632
	ld c,004h		;8635
L_8637:
	ld b,004h		;8637
L_8639:
	ld (hl),a			;8639
	inc l			;863a
	djnz L_8639		;863b
	add hl,de			;863d
	dec c			;863e
	jr nz,L_8637		;863f
	ld de,(0ea91h)		;8641
	call L_8BA1		;8645
	ld a,009h		;8648
	call 04ae4h		;864a
	ld de,00050h		;864d
	jp 05b04h		;8650
L_8653:
	ld a,(0ea90h)		;8653
	or a			;8656
	ret z			;8657
	ld a,(0e400h)		;8658
	dec a			;865b
	ret m			;865c
	ld a,(0e3c0h)		;865d
	or a			;8660
	ret nz			;8661
	ld a,(0ea92h)		;8662
	ld b,a			;8665
	ld a,(0e406h)		;8666
	cp b			;8669
	ret c			;866a
	ld a,001h		;866b
	ld (0e3c0h),a		;866d
	call 07918h		;8670
	ld a,0f1h		;8673
	jp 04ae4h		;8675
L_8678:
	ld ix,0ea40h		;8678
	ld de,00008h		;867c
	ld b,004h		;867f
L_8681:
	ld a,(ix+000h)		;8681
	and a			;8684
	call nz,L_868D		;8685
	add ix,de		;8688
	djnz L_8681		;868a
	ret			;868c
L_868D:
	call L_86A0		;868d
	ld a,(0e320h)		;8690
	and a			;8693
	ret z			;8694
	ld a,(ix+003h)		;8695
	sub 008h		;8698
	jr c,L_86AC		;869a
	ld (ix+003h),a		;869c
	ret			;869f
L_86A0:
	dec (ix+001h)		;86a0
	ret nz			;86a3
	ld (ix+001h),004h		;86a4
	dec (ix+006h)		;86a8
	ret p			;86ab
L_86AC:
	ld (ix+000h),000h		;86ac
	ret			;86b0
L_86B1:
	ld ix,0ea40h		;86b1
	ld iy,0ecc0h		;86b5
	ld b,004h		;86b9
L_86BB:
	push bc			;86bb
	call L_86CC		;86bc
	ld bc,00008h		;86bf
	add ix,bc		;86c2
	ld c,010h		;86c4
	add iy,bc		;86c6
	pop bc			;86c8
	djnz L_86BB		;86c9
	ret			;86cb
L_86CC:
	ld a,(ix+000h)		;86cc
	or a			;86cf
	ret z			;86d0
	ld l,(ix+002h)		;86d1
	ld h,(ix+003h)		;86d4
	call 05c92h		;86d7
	ld (ix+004h),l		;86da
	ld (ix+005h),h		;86dd
	push iy		;86e0
	pop de			;86e2
	ld a,004h		;86e3
L_86E5:
	ld bc,00004h		;86e5
	ldir		;86e8
	ld c,01ch		;86ea
	add hl,bc			;86ec
	dec a			;86ed
	jr nz,L_86E5		;86ee
	ret			;86f0
L_86F1:
	ld ix,0ea40h		;86f1
	ld iy,0ecc0h		;86f5
	ld b,004h		;86f9
L_86FB:
	push bc			;86fb
	call L_870C		;86fc
	ld bc,00008h		;86ff
	add ix,bc		;8702
	ld c,010h		;8704
	add iy,bc		;8706
	pop bc			;8708
	djnz L_86FB		;8709
	ret			;870b
L_870C:
	ld a,(ix+000h)		;870c
	or a			;870f
	ret z			;8710
	ld e,(ix+004h)		;8711
	ld d,(ix+005h)		;8714
	push iy		;8717
	pop hl			;8719
	ld a,004h		;871a
L_871C:
	ld bc,00004h		;871c
	ldir		;871f
	ld c,01ch		;8721
	ex de,hl			;8723
	add hl,bc			;8724
	ex de,hl			;8725
	dec a			;8726
	jr nz,L_871C		;8727
	ret			;8729
L_872A:
	ld ix,0ea40h		;872a
	ld b,004h		;872e
L_8730:
	push bc			;8730
	call L_873D		;8731
	ld bc,00008h		;8734
	add ix,bc		;8737
	pop bc			;8739
	djnz L_8730		;873a
	ret			;873c
L_873D:
	ld a,(ix+000h)		;873d
	and a			;8740
	ret z			;8741
	ld a,(ix+006h)		;8742
	ld hl,08762h		;8745
	call 04b67h		;8748
	ex de,hl			;874b
	ld e,(ix+004h)		;874c
	ld d,(ix+005h)		;874f
	ld a,004h		;8752
L_8754:
	ld bc,00004h		;8754
	ldir		;8757
	ld c,01ch		;8759
	ex de,hl			;875b
	add hl,bc			;875c
	ex de,hl			;875d
	dec a			;875e
	jr nz,L_8754		;875f
	ret			;8761

; ----------------------------------------------------------------------
; DATOS tabla_8762: 3 punteros que p02:873D lee con IX+06 (L_4B67); lo leen
;   p02:8748 (6 bytes)
;   0x8762..0x8768  (6 bytes)
DATA_tabla_8762:
	defw 08768h,08778h,08788h	; 8762  -> DATA_filas_8768 0x8778 0x8788

; ----------------------------------------------------------------------
; DATOS filas_8768: 3 filas de 16 bytes (las de 0x8762), que p02:874B recorre;
;   lo leen p02:874B (48 bytes)
;   0x8768..0x8798  (48 bytes)
DATA_filas_8768:
	defb 000h,000h,000h,000h,000h,0e5h,0e6h,000h,000h,0e7h,0e8h,000h,000h,000h,000h,000h	; 8768  ................
	defb 000h,000h,0dbh,0dch,000h,0ddh,0deh,0dfh,000h,0e0h,0e1h,0e2h,000h,0e3h,0e4h,000h	; 8778  ................
	defb 0cbh,0cch,0cdh,0ceh,0cfh,0d0h,0d1h,0d2h,0d3h,0d4h,0d5h,0d6h,0d7h,0d8h,0d9h,0dah	; 8788  ................

; ======================================================================
; CODIGO 0x8798..0x882c  (148 bytes)
; ======================================================================


L_8798:
	call L_87B4		;8798
	jr z,L_8798		;879b
	ret c			;879d
	ld hl,0e359h		;879e
	inc (hl)			;87a1
	jr L_8798		;87a2
L_87A4:
	ld a,(0e320h)		;87a4
	and a			;87a7
	ret z			;87a8
	ld a,0f8h		;87a9
	ld (0f004h),a		;87ab
L_87AE:
	call L_87B4		;87ae
	jr z,L_87AE		;87b1
	ret			;87b3
L_87B4:
	call L_8879		;87b4
	ret nz			;87b7
	ld hl,0e359h		;87b8
	inc (hl)			;87bb
	call L_87C1		;87bc
	xor a			;87bf
	ret			;87c0
L_87C1:
	bit 7,c		;87c1
	jr z,L_87CA		;87c3
	ld a,(0e20ah)		;87c5
	or a			;87c8
	ret z			;87c9
L_87CA:
	ld a,b			;87ca
	and 0f8h		;87cb
	ld e,a			;87cd
	ld a,(0f004h)		;87ce
	ld d,a			;87d1
	ld a,c			;87d2
	rlca			;87d3
	rlca			;87d4
	rlca			;87d5
	and 003h		;87d6
	ld b,a			;87d8
	ld a,c			;87d9
	and 01fh		;87da
L_87DC:
	ld (0f010h),a		;87dc
	ld a,b			;87df
	ld (0f011h),a		;87e0
	ld (0f012h),de		;87e3
	ld hl,0e500h		;87e7
	ld de,00010h		;87ea
	xor a			;87ed
	ld b,008h		;87ee
L_87F0:
	cp (hl)			;87f0
	jr z,L_87F8		;87f1
	add hl,de			;87f3
	djnz L_87F0		;87f4
	xor a			;87f6
	ret			;87f7
L_87F8:
	push hl			;87f8
	pop ix		;87f9
	ld a,(0f010h)		;87fb
	ld (hl),a			;87fe
	push af			;87ff
	inc l			;8800
	ld (hl),000h		;8801
	ld de,(0f012h)		;8803
	inc l			;8807
	ld a,d			;8808
	cp 0f8h		;8809
	ld a,000h		;880b
	jr z,L_8810		;880d
	dec a			;880f
L_8810:
	ld (hl),a			;8810
	inc l			;8811
	xor a			;8812
	ld (hl),a			;8813
	inc l			;8814
	ld (hl),e			;8815
	inc l			;8816
	ld (hl),a			;8817
	inc l			;8818
	ld (hl),d			;8819
	ld a,l			;881a
	add a,005h		;881b
	ld l,a			;881d
	ld a,(0f011h)		;881e
	ld (hl),a			;8821
	pop af			;8822
	call L_8828		;8823
	scf			;8826
L_8827:
	ret			;8827
L_8828:
	dec a			;8828
	call 04084h		;8829

; ----------------------------------------------------------------------
; DATOS tabla_882C: 16 destinos del despachador p00:4084 (call en p02:8829, el
;   indice en A): B719, 8827, 8827, B885, BA13, BB90, A119, 8827, B448, B74D,
;   885E, 8867, 8870, 884C, 8827, 8855; lo leen p02:8829 (32 bytes)
;   0x882c..0x884c  (32 bytes)
DATA_tabla_882C:
	defw 0b719h,08827h,08827h,0b885h,0ba13h,0bb90h,0a119h,08827h	; 882c
	defw 0b448h,0b74dh,0885eh,08867h,08870h,0884ch,08827h,08855h	; 883c

; ======================================================================
; CODIGO 0x884c..0x8f71  (1829 bytes)
; ======================================================================


L_884C:
	call 04137h		;884c
	call 0be49h		;884f
	jp 04157h		;8852
L_8855:
	call 04137h		;8855
	call 0badch		;8858
	jp 04157h		;885b
L_885E:
	call 04137h		;885e
	call 0a3abh		;8861
	jp 04157h		;8864
L_8867:
	call 04137h		;8867
	call 0a4d1h		;886a
	jp 04157h		;886d
L_8870:
	call 04137h		;8870
	call 0a811h		;8873
	jp 04157h		;8876
L_8879:
	call 0413bh		;8879
	ld a,(0e201h)		;887c
	ld hl,0ba12h		;887f
	call 04b67h		;8882
	ld a,(0e359h)		;8885
	ld b,a			;8888
	add a,a			;8889
	add a,b			;888a
	call 0407fh		;888b
	ex de,hl			;888e
	ld e,(hl)			;888f
	inc hl			;8890
	ld a,(hl)			;8891
	ld b,a			;8892
	and 007h		;8893
	ld d,a			;8895
	inc hl			;8896
	ld c,(hl)			;8897
	ld hl,(0e203h)		;8898
	rst 20h			;889b
	push af			;889c
	call 04157h		;889d
	pop af			;88a0
	ret			;88a1
L_88A2:
	ld ix,0e600h		;88a2
	ld b,00ch		;88a6
L_88A8:
	push bc			;88a8
	bit 1,(ix+010h)		;88a9
	jr z,L_88C5		;88ad
	ld iy,0e470h		;88af
	ld de,00010h		;88b3
	ld b,009h		;88b6
L_88B8:
	ld a,(iy+000h)		;88b8
	or a			;88bb
	call nz,L_88CE		;88bc
	jr c,L_88C5		;88bf
	add iy,de		;88c1
	djnz L_88B8		;88c3
L_88C5:
	ld de,00040h		;88c5
	add ix,de		;88c8
	pop bc			;88ca
	djnz L_88A8		;88cb
	ret			;88cd
L_88CE:
	ld a,(ix+004h)		;88ce
	sub (iy+003h)		;88d1
	jp nc,L_88E1		;88d4
	neg		;88d7
	dec a			;88d9
	cp (ix+00eh)		;88da
	jp c,L_88E5		;88dd
	ret			;88e0
L_88E1:
	cp (iy+00dh)		;88e1
	ret nc			;88e4
L_88E5:
	ld a,(ix+006h)		;88e5
	sub (iy+005h)		;88e8
	jp nc,L_88F7		;88eb
	neg		;88ee
	cp (ix+00fh)		;88f0
	jp c,L_88FB		;88f3
	ret			;88f6
L_88F7:
	cp (iy+00ch)		;88f7
	ret nc			;88fa
L_88FB:
	call L_8900		;88fb
	scf			;88fe
	ret			;88ff
L_8900:
	ld a,(iy+000h)		;8900
	cp 006h		;8903
	jr nc,L_8915		;8905
	cp 005h		;8907
	jr nz,L_8911		;8909
	call L_8A0C		;890b
	jp L_8915		;890e
L_8911:
	ld (iy+000h),000h		;8911
L_8915:
	ld a,(ix+000h)		;8915
	cp 00fh		;8918
	jp z,L_89B6		;891a
	bit 4,(ix+010h)		;891d
	jp nz,L_89FB		;8921
	dec (ix+00dh)		;8924
	ret nz			;8927
L_8928:
	ld a,(ix+000h)		;8928
	cp 02eh		;892b
	jp z,L_89E8		;892d
	cp 032h		;8930
	jr z,L_893A		;8932
	ld de,00001h		;8934
	call 05b04h		;8937
L_893A:
	ld a,(ix+000h)		;893a
	ld b,012h		;893d
	cp 030h		;893f
	jr z,L_8957		;8941
	cp 025h		;8943
	jr z,L_8957		;8945
	ld b,008h		;8947
	cp 001h		;8949
	jr z,L_8957		;894b
	cp 003h		;894d
	jr z,L_8957		;894f
	cp 005h		;8951
	jr z,L_8957		;8953
	ld b,007h		;8955
L_8957:
	ld a,b			;8957
	call 04ae4h		;8958
	call L_8988		;895b
	ld a,(ix+000h)		;895e
	push af			;8961
	push bc			;8962
	call 06514h		;8963
	pop bc			;8966
	pop af			;8967
	sub 01dh		;8968
	ret z			;896a
	sub 005h		;896b
	cp 003h		;896d
	ret c			;896f
	sub 016h		;8970
	cp 003h		;8972
	ret c			;8974
	sub 009h		;8975
	ret z			;8977
	ld a,026h		;8978
	ld e,(ix+004h)		;897a
	ld d,(ix+006h)		;897d
	jp 04d16h		;8980
L_8983:
	ld a,009h		;8983
	jp 04ae4h		;8985
L_8988:
	ld c,(ix+00ch)		;8988
	ld a,(ix+016h)		;898b
	and a			;898e
	ret z			;898f
	ld c,000h		;8990
	ld a,(ix+017h)		;8992
	call L_89A8		;8995
	ret c			;8998
	ld a,(hl)			;8999
	inc l			;899a
	inc l			;899b
	dec (hl)			;899c
	ret nz			;899d
	dec l			;899e
	dec l			;899f
	ld (hl),000h		;89a0
	inc c			;89a2
	and 007h		;89a3
	ret nz			;89a5
	inc c			;89a6
	ret			;89a7
L_89A8:
	ld hl,0ea80h		;89a8
	ld b,004h		;89ab
L_89AD:
	cp (hl)			;89ad
	ret z			;89ae
	inc l			;89af
	inc l			;89b0
	inc l			;89b1
	djnz L_89AD		;89b2
	scf			;89b4
	ret			;89b5
L_89B6:
	call L_8928		;89b6
	ld a,(iy+000h)		;89b9
	ld (iy+000h),000h		;89bc
	sub 007h		;89c0
	cp 002h		;89c2
	ret nc			;89c4
	ld b,a			;89c5
	ld a,(ix+006h)		;89c6
	cp 010h		;89c9
	ret c			;89cb
	ld d,a			;89cc
	ld a,b			;89cd
	or a			;89ce
	jr nz,L_89D6		;89cf
	ld e,(iy+003h)		;89d1
	jr L_89D9		;89d4
L_89D6:
	ld e,(ix+004h)		;89d6
L_89D9:
	ld c,000h		;89d9
	ld a,03bh		;89db
	add a,b			;89dd
	ld b,00ch		;89de
	call 04d16h		;89e0
	ld a,020h		;89e3
	jp 04ae4h		;89e5
L_89E8:
	ld a,(ix+00ch)		;89e8
	push af			;89eb
	call 06514h		;89ec
	pop af			;89ef
	add a,028h		;89f0
	ld e,(ix+004h)		;89f2
	ld d,(ix+006h)		;89f5
	jp 04d16h		;89f8
L_89FB:
	ld (iy+000h),000h		;89fb
	ld a,(ix+000h)		;89ff
	cp 019h		;8a02
	jp nz,L_823C		;8a04
	ld a,014h		;8a07
	jp 04ae4h		;8a09
L_8A0C:
	ld a,(0e201h)		;8a0c
	cp 005h		;8a0f
	jr nz,L_8A18		;8a11
	ld (iy+000h),000h		;8a13
	ret			;8a17
L_8A18:
	push iy		;8a18
	pop hl			;8a1a
	ld (hl),006h		;8a1b
	inc l			;8a1d
	ld (hl),000h		;8a1e
	ld a,l			;8a20
	add a,004h		;8a21
	ld l,a			;8a23
	ld a,(hl)			;8a24
	cp 0f8h		;8a25
	jr c,L_8A2C		;8a27
	ld a,0f7h		;8a29
	ld (hl),a			;8a2b
L_8A2C:
	inc l			;8a2c
	ld (hl),044h		;8a2d
	inc l			;8a2f
	ld (hl),00fh		;8a30
	inc l			;8a32
	ld (hl),000h		;8a33
	inc l			;8a35
	ld (hl),001h		;8a36
	inc l			;8a38
	ld (hl),000h		;8a39
	inc l			;8a3b
	inc l			;8a3c
	ld (hl),018h		;8a3d
	inc l			;8a3f
	ld (hl),018h		;8a40
	ret			;8a42
L_8A43:
	ld a,(0e340h)		;8a43
	or a			;8a46
	ret nz			;8a47
	ld a,(0e3b2h)		;8a48
	and a			;8a4b
	ret z			;8a4c
	ld b,a			;8a4d
	ld ix,0e500h		;8a4e
L_8A52:
	push bc			;8a52
	ld a,(ix+000h)		;8a53
	and a			;8a56
	jr z,L_8A6F		;8a57
	ld iy,0e470h		;8a59
	ld de,00010h		;8a5d
	ld b,009h		;8a60
L_8A62:
	ld a,(iy+000h)		;8a62
	or a			;8a65
	call nz,L_8A78		;8a66
	jr c,L_8A6F		;8a69
	add iy,de		;8a6b
	djnz L_8A62		;8a6d
L_8A6F:
	ld de,00010h		;8a6f
	add ix,de		;8a72
	pop bc			;8a74
	djnz L_8A52		;8a75
	ret			;8a77
L_8A78:
	sub 004h		;8a78
	cp 003h		;8a7a
	jr nc,L_8A87		;8a7c
	ld a,(ix+000h)		;8a7e
	sub 007h		;8a81
	cp 001h		;8a83
	ccf			;8a85
	ret nc			;8a86
L_8A87:
	ld a,(ix+00dh)		;8a87
	or a			;8a8a
	ret m			;8a8b
	jr z,L_8ACF		;8a8c
	add a,a			;8a8e
	add a,a			;8a8f
	ld hl,0b2f9h		;8a90
	call 0407ah		;8a93
	ld (0f000h),hl		;8a96
	ld a,(ix+004h)		;8a99
	add a,(hl)			;8a9c
	sub (iy+003h)		;8a9d
	jp nc,L_8AAD		;8aa0
	neg		;8aa3
	dec a			;8aa5
	inc hl			;8aa6
	inc hl			;8aa7
	cp (hl)			;8aa8
	jp c,L_8AB1		;8aa9
	ret			;8aac
L_8AAD:
	cp (iy+00dh)		;8aad
	ret nc			;8ab0
L_8AB1:
	ld hl,(0f000h)		;8ab1
	inc hl			;8ab4
	ld a,(ix+006h)		;8ab5
	add a,(hl)			;8ab8
	sub (iy+005h)		;8ab9
	jp nc,L_8AC8		;8abc
	neg		;8abf
	inc hl			;8ac1
	inc hl			;8ac2
	cp (hl)			;8ac3
	jp c,L_8B0A		;8ac4
	ret			;8ac7
L_8AC8:
	cp (iy+00ch)		;8ac8
	jp c,L_8B0A		;8acb
	ret			;8ace
L_8ACF:
	ld a,(ix+004h)		;8acf
	sub (iy+003h)		;8ad2
	jp nc,L_8AE9		;8ad5
	neg		;8ad8
	dec a			;8ada
	ld c,(ix+00ah)		;8adb
	sla c		;8ade
	sla c		;8ae0
	sla c		;8ae2
	cp c			;8ae4
	jp c,L_8AED		;8ae5
	ret			;8ae8
L_8AE9:
	cp (iy+00dh)		;8ae9
	ret nc			;8aec
L_8AED:
	ld a,(ix+006h)		;8aed
	sub (iy+005h)		;8af0
	jp nc,L_8B06		;8af3
	neg		;8af6
	ld c,(ix+009h)		;8af8
	sla c		;8afb
	sla c		;8afd
	sla c		;8aff
	cp c			;8b01
	jp c,L_8B0A		;8b02
	ret			;8b05
L_8B06:
	cp (iy+00ch)		;8b06
	ret nc			;8b09
L_8B0A:
	call L_8B0F		;8b0a
	scf			;8b0d
	ret			;8b0e
L_8B0F:
	ld a,(iy+000h)		;8b0f
	cp 006h		;8b12
	jr nc,L_8B24		;8b14
	cp 005h		;8b16
	jr nz,L_8B20		;8b18
	call L_8A0C		;8b1a
	jp L_8B24		;8b1d
L_8B20:
	ld (iy+000h),000h		;8b20
L_8B24:
	call 06070h		;8b24
	dec (ix+008h)		;8b27
	ret nz			;8b2a
	ld a,(ix+000h)		;8b2b
	cp 007h		;8b2e
	jp z,L_8BCC		;8b30
	cp 006h		;8b33
	jr z,L_8B3B		;8b35
	cp 00fh		;8b37
	jr nz,L_8B45		;8b39
L_8B3B:
	ld a,001h		;8b3b
	ld (0e38dh),a		;8b3d
	ld de,00050h		;8b40
	jr L_8B48		;8b43
L_8B45:
	ld de,00010h		;8b45
L_8B48:
	call 05b04h		;8b48
	ld c,03bh		;8b4b
	ld a,(ix+000h)		;8b4d
	cp 00fh		;8b50
	jr z,L_8B5E		;8b52
	ld c,009h		;8b54
	sub 005h		;8b56
	cp 002h		;8b58
	jr c,L_8B5E		;8b5a
	ld c,013h		;8b5c
L_8B5E:
	ld a,c			;8b5e
	call 04ae4h		;8b5f
	call 0609eh		;8b62
	ld e,(ix+004h)		;8b65
	ld d,(ix+006h)		;8b68
	ld hl,0f8f8h		;8b6b
	ld a,(ix+000h)		;8b6e
	cp 00eh		;8b71
	jr z,L_8B8C		;8b73
	ld a,(ix+007h)		;8b75
	push de			;8b78
	cp 035h		;8b79
	jr c,L_8B81		;8b7b
	sub 035h		;8b7d
	add a,01fh		;8b7f
L_8B81:
	ld hl,0b375h		;8b81
	call 0407ah		;8b84
	ld d,000h		;8b87
	ld e,(hl)			;8b89
	ex de,hl			;8b8a
	pop de			;8b8b
L_8B8C:
	ld a,l			;8b8c
	add a,e			;8b8d
	ld e,a			;8b8e
	ld c,d			;8b8f
	ld a,h			;8b90
	add a,d			;8b91
	ld d,a			;8b92
	cp 0e0h		;8b93
	jr c,L_8BA1		;8b95
	bit 7,c		;8b97
	ld d,0e0h		;8b99
	jr nz,L_8BA1		;8b9b
	ld d,000h		;8b9d
	jr L_8BA1		;8b9f
L_8BA1:
	ld a,d			;8ba1
	cp 0e8h		;8ba2
	ret nc			;8ba4
	ld a,e			;8ba5
	cp 0a8h		;8ba6
	ret nc			;8ba8
	ld hl,0ea40h		;8ba9
	ld b,004h		;8bac
L_8BAE:
	ld a,(hl)			;8bae
	and a			;8baf
	jr z,L_8BBA		;8bb0
	ld a,008h		;8bb2
	add a,l			;8bb4
	ld l,a			;8bb5
	djnz L_8BAE		;8bb6
	xor a			;8bb8
	ret			;8bb9
L_8BBA:
	ld a,005h		;8bba
	sub b			;8bbc
	ld (hl),a			;8bbd
	inc l			;8bbe
	ld (hl),004h		;8bbf
	inc l			;8bc1
	ld (hl),e			;8bc2
	inc l			;8bc3
	ld (hl),d			;8bc4
	inc l			;8bc5
	inc l			;8bc6
	inc l			;8bc7
	ld (hl),002h		;8bc8
	scf			;8bca
	ret			;8bcb
L_8BCC:
	ld (ix+001h),005h		;8bcc
	ld (ix+00dh),0ffh		;8bd0
	ld (ix+002h),001h		;8bd4
	ld de,00010h		;8bd8
	call 05b04h		;8bdb
	ld a,013h		;8bde
	jp 04ae4h		;8be0
L_8BE3:
	ld a,(0e340h)		;8be3
	or a			;8be6
	ret nz			;8be7
	ld a,(0e201h)		;8be8
	cp 003h		;8beb
	jr z,L_8BF4		;8bed
	sub 009h		;8bef
	cp 003h		;8bf1
	ret nc			;8bf3
L_8BF4:
	ld ix,0e580h		;8bf4
	ld b,010h		;8bf8
L_8BFA:
	push bc			;8bfa
	ld a,(ix+000h)		;8bfb
	cp 005h		;8bfe
	jr c,L_8C20		;8c00
	ld iy,0e470h		;8c02
	ld de,00010h		;8c06
	ld b,009h		;8c09
L_8C0B:
	ld a,(iy+000h)		;8c0b
	or a			;8c0e
	jr z,L_8C1C		;8c0f
	sub 004h		;8c11
	cp 003h		;8c13
	jr c,L_8C1C		;8c15
	call L_8C29		;8c17
	jr c,L_8C20		;8c1a
L_8C1C:
	add iy,de		;8c1c
	djnz L_8C0B		;8c1e
L_8C20:
	ld bc,00008h		;8c20
	add ix,bc		;8c23
	pop bc			;8c25
	djnz L_8BFA		;8c26
	ret			;8c28
L_8C29:
	ld a,(ix+003h)		;8c29
	cp 0e8h		;8c2c
	ret nc			;8c2e
	sub (iy+005h)		;8c2f
	jp nc,L_8C45		;8c32
	neg		;8c35
	ld c,(ix+005h)		;8c37
	sla c		;8c3a
	sla c		;8c3c
	sla c		;8c3e
	cp c			;8c40
	jp c,L_8C49		;8c41
	ret			;8c44
L_8C45:
	cp (iy+00ch)		;8c45
	ret nc			;8c48
L_8C49:
	ld a,(ix+002h)		;8c49
	sub (iy+003h)		;8c4c
	jp nc,L_8C63		;8c4f
	neg		;8c52
	dec a			;8c54
	ld c,(ix+004h)		;8c55
	sla c		;8c58
	sla c		;8c5a
	sla c		;8c5c
	cp c			;8c5e
	jp c,L_8C67		;8c5f
	ret			;8c62
L_8C63:
	cp (iy+00dh)		;8c63
	ret nc			;8c66
L_8C67:
	call L_8C6C		;8c67
	scf			;8c6a
	ret			;8c6b
L_8C6C:
	ld a,(iy+000h)		;8c6c
	cp 006h		;8c6f
	jr nc,L_8C77		;8c71
	ld (iy+000h),000h		;8c73
L_8C77:
	dec (ix+006h)		;8c77
	jp nz,L_823C		;8c7a
	call 06d26h		;8c7d
	ld de,00010h		;8c80
	jp 05b04h		;8c83
L_8C86:
	ld a,(0e340h)		;8c86
	or a			;8c89
	ret nz			;8c8a
	ld a,(0e201h)		;8c8b
	cp 005h		;8c8e
	ret nz			;8c90
	ld ix,0e580h		;8c91
	call L_8C9C		;8c95
	ld ix,0e590h		;8c98
L_8C9C:
	ld a,(ix+000h)		;8c9c
	or a			;8c9f
	ret z			;8ca0
	ld iy,0e470h		;8ca1
	ld de,00010h		;8ca5
	ld b,009h		;8ca8
L_8CAA:
	ld a,(iy+000h)		;8caa
	or a			;8cad
	jr z,L_8CBA		;8cae
	sub 004h		;8cb0
	cp 003h		;8cb2
	jr c,L_8CBA		;8cb4
	call L_8CBF		;8cb6
	ret c			;8cb9
L_8CBA:
	add iy,de		;8cba
	djnz L_8CAA		;8cbc
	ret			;8cbe
L_8CBF:
	ld a,(ix+003h)		;8cbf
	sub (iy+005h)		;8cc2
	jp nc,L_8CD1		;8cc5
	neg		;8cc8
	cp (ix+005h)		;8cca
	jp c,L_8CD5		;8ccd
	ret			;8cd0
L_8CD1:
	cp (iy+00ch)		;8cd1
	ret nc			;8cd4
L_8CD5:
	ld a,(ix+002h)		;8cd5
	sub (iy+003h)		;8cd8
	jp nc,L_8CE7		;8cdb
	neg		;8cde
	dec a			;8ce0
	cp 020h		;8ce1
	jp c,L_8CEB		;8ce3
	ret			;8ce6
L_8CE7:
	cp (iy+00dh)		;8ce7
	ret nc			;8cea
L_8CEB:
	call L_8D07		;8ceb
	call L_8CF6		;8cee
	call L_8D39		;8cf1
	scf			;8cf4
	ret			;8cf5
L_8CF6:
	ld a,(ix+006h)		;8cf6
	cp 004h		;8cf9
	ret nc			;8cfb
	ld a,(iy+000h)		;8cfc
	cp 00fh		;8cff
	ret z			;8d01
	ld (iy+000h),000h		;8d02
	ret			;8d06
L_8D07:
	ld (ix+007h),018h		;8d07
	dec (ix+008h)		;8d0b
	jp nz,L_8D2E		;8d0e
	ld (ix+008h),004h		;8d11
	ld a,(ix+001h)		;8d15
	ld (ix+001h),001h		;8d18
	or a			;8d1c
	jr z,L_8D29		;8d1d
	ld a,(ix+006h)		;8d1f
	cp 004h		;8d22
	ret nc			;8d24
	inc (ix+006h)		;8d25
	ret			;8d28
L_8D29:
	ld (ix+006h),000h		;8d29
	ret			;8d2d
L_8D2E:
	ld a,(ix+006h)		;8d2e
	cp 004h		;8d31
	ret nc			;8d33
	ld a,012h		;8d34
	jp 04ae4h		;8d36
L_8D39:
	ld a,(ix+006h)		;8d39
	cp 004h		;8d3c
	ret nc			;8d3e
	call 04c24h		;8d3f
	and 00fh		;8d42
	ret nz			;8d44
	ld a,(ix+003h)		;8d45
	sub 010h		;8d48
	cp 0e0h		;8d4a
	ret nc			;8d4c
	add a,010h		;8d4d
	ld d,a			;8d4f
	ld a,(ix+002h)		;8d50
	add a,008h		;8d53
	ld e,a			;8d55
	ld bc,00000h		;8d56
	ld a,030h		;8d59
	jp 04d16h		;8d5b
L_8D5E:
	ld a,(0e400h)		;8d5e
	dec a			;8d61
	ret m			;8d62
	ld a,(0e3d0h)		;8d63
	or a			;8d66
	ret nz			;8d67
	ld ix,0e900h		;8d68
	ld l,00ah		;8d6c
	ld bc,00202h		;8d6e
	call L_8D7C		;8d71
	ret nc			;8d74
	ld (ix+000h),000h		;8d75
	jp L_8E71		;8d79
L_8D7C:
	ld a,(0e404h)		;8d7c
	add a,004h		;8d7f
	ld e,a			;8d81
	ld a,(0e406h)		;8d82
	inc a			;8d85
	ld d,a			;8d86
	exx			;8d87
	ld de,00010h		;8d88
	ld bc,00c08h		;8d8b
	exx			;8d8e
L_8D8F:
	ld a,(ix+000h)		;8d8f
	or a			;8d92
	jr z,L_8DAB		;8d93
	ld a,(ix+004h)		;8d95
	sub e			;8d98
	exx			;8d99
	cp c			;8d9a
	exx			;8d9b
	jr c,L_8DA1		;8d9c
	add a,c			;8d9e
	jr nc,L_8DAB		;8d9f
L_8DA1:
	ld a,(ix+006h)		;8da1
	sub d			;8da4
	exx			;8da5
	cp b			;8da6
	exx			;8da7
	ret c			;8da8
	add a,b			;8da9
	ret c			;8daa
L_8DAB:
	exx			;8dab
	add ix,de		;8dac
	exx			;8dae
	dec l			;8daf
	jr nz,L_8D8F		;8db0
	xor a			;8db2
	ret			;8db3
L_8DB4:
	ld a,(0e400h)		;8db4
	cp 002h		;8db7
	ret nz			;8db9
	ld a,(0e3d0h)		;8dba
	or a			;8dbd
	ret nz			;8dbe
	ld a,(0e404h)		;8dbf
	ld l,a			;8dc2
	ld a,(0e406h)		;8dc3
	add a,00ch		;8dc6
	ld h,a			;8dc8
	ld ix,0e900h		;8dc9
	ld de,00010h		;8dcd
	ld b,00ah		;8dd0
L_8DD2:
	ld a,(ix+000h)		;8dd2
	and a			;8dd5
	jp z,L_8DED		;8dd6
	ld a,l			;8dd9
	sub (ix+004h)		;8dda
	add a,010h		;8ddd
	cp 013h		;8ddf
	jr nc,L_8DED		;8de1
	ld a,h			;8de3
	sub (ix+006h)		;8de4
	add a,00ch		;8de7
	cp 00bh		;8de9
	jr c,L_8DF2		;8deb
L_8DED:
	add ix,de		;8ded
	djnz L_8DD2		;8def
	ret			;8df1
L_8DF2:
	ld (ix+000h),000h		;8df2
	jp L_8E33		;8df6
L_8DF9:
	ld a,(0e400h)		;8df9
	cp 002h		;8dfc
	ret nz			;8dfe
	ld a,(0e3d0h)		;8dff
	or a			;8e02
	ret nz			;8e03
	ld a,(0e404h)		;8e04
	ld e,a			;8e07
	ld a,(0e406h)		;8e08
	add a,00ch		;8e0b
	ld d,a			;8e0d
	ld hl,00c10h		;8e0e
	call L_8EE2		;8e11
	ret nc			;8e14
	ld a,(ix+000h)		;8e15
	ld b,a			;8e18
	cp 020h		;8e19
	jr z,L_8E38		;8e1b
	sub 029h		;8e1d
	cp 006h		;8e1f
	ret c			;8e21
	push bc			;8e22
	call L_8928		;8e23
	pop af			;8e26
	sub 022h		;8e27
	cp 003h		;8e29
	jr c,L_8E38		;8e2b
	sub 016h		;8e2d
	cp 005h		;8e2f
	jr c,L_8E38		;8e31
L_8E33:
	ld hl,0e401h		;8e33
	dec (hl)			;8e36
	ret nz			;8e37
L_8E38:
	xor a			;8e38
	ld (0e401h),a		;8e39
	inc a			;8e3c
	ld (0e400h),a		;8e3d
	jp 0553eh		;8e40
L_8E43:
	ld a,(0e400h)		;8e43
	inc a			;8e46
	ret z			;8e47
	ld a,(0e3d0h)		;8e48
	or a			;8e4b
	ret nz			;8e4c
	ld a,(0e404h)		;8e4d
	add a,004h		;8e50
	ld e,a			;8e52
	ld a,(0e406h)		;8e53
	add a,002h		;8e56
	ld d,a			;8e58
	ld hl,00806h		;8e59
	call L_8EE2		;8e5c
	ret nc			;8e5f
	ld a,(ix+000h)		;8e60
	cp 020h		;8e63
	jr z,L_8E71		;8e65
	sub 029h		;8e67
	cp 006h		;8e69
	jp c,L_8F67		;8e6b
	call L_8928		;8e6e
L_8E71:
	ld a,(0e1c2h)		;8e71
	bit 6,a		;8e74
	ret z			;8e76
	ld a,(0e446h)		;8e77
	or a			;8e7a
	ret nz			;8e7b
L_8E7C:
	ld a,(0e3c0h)		;8e7c
	or a			;8e7f
	ret nz			;8e80
	xor a			;8e81
	ld (0e20bh),a		;8e82
	ld a,(0f0f5h)		;8e85
	bit 3,a		;8e88
	jr nz,L_8E94		;8e8a
	ld a,(0e330h)		;8e8c
	ld (0e20dh),a		;8e8f
	jr L_8ECE		;8e92
L_8E94:
	ld hl,0e334h		;8e94
	ld b,009h		;8e97
	xor a			;8e99
L_8E9A:
	cp (hl)			;8e9a
	jr nz,L_8EA8		;8e9b
	inc hl			;8e9d
	djnz L_8E9A		;8e9e
	ld a,(0e330h)		;8ea0
	ld (0e20dh),a		;8ea3
	jr L_8ECE		;8ea6
L_8EA8:
	ld a,001h		;8ea8
	ld (0e20bh),a		;8eaa
	ld de,0e210h		;8ead
	ld hl,0e330h		;8eb0
	ld bc,0000dh		;8eb3
	ldir		;8eb6
	ld hl,0e430h		;8eb8
	ld bc,00007h		;8ebb
	ldir		;8ebe
	ld a,(0e401h)		;8ec0
	ld (de),a			;8ec3
	inc e			;8ec4
	ld a,(0e402h)		;8ec5
	ld (de),a			;8ec8
	inc e			;8ec9
	ld a,(0e40bh)		;8eca
	ld (de),a			;8ecd
L_8ECE:
	ld a,03dh		;8ece
	call 04ae4h		;8ed0
	ld a,0f0h		;8ed3
	call 04ae4h		;8ed5
	xor a			;8ed8
	ld (0e439h),a		;8ed9
	ld (0e1d5h),a		;8edc
	jp 0a993h		;8edf
L_8EE2:
	ld ix,0e600h		;8ee2
	ld b,00ch		;8ee6
	exx			;8ee8
	ld de,00040h		;8ee9
	exx			;8eec
L_8EED:
	bit 0,(ix+010h)		;8eed
	jr z,L_8F19		;8ef1
	ld a,(ix+004h)		;8ef3
	sub e			;8ef6
	jp nc,L_8F05		;8ef7
	neg		;8efa
	cp (ix+00eh)		;8efc
	jp c,L_8F08		;8eff
	jp L_8F19		;8f02
L_8F05:
	cp l			;8f05
	jr nc,L_8F19		;8f06
L_8F08:
	ld a,(ix+006h)		;8f08
	sub d			;8f0b
	jp nc,L_8F17		;8f0c
	neg		;8f0f
	cp (ix+00fh)		;8f11
	jr nc,L_8F19		;8f14
	ret			;8f16
L_8F17:
	cp h			;8f17
	ret c			;8f18
L_8F19:
	ld a,(ix+000h)		;8f19
	cp 038h		;8f1c
	jr nz,L_8F24		;8f1e
	call L_8F2C		;8f20
	ret c			;8f23
L_8F24:
	exx			;8f24
	add ix,de		;8f25
	exx			;8f27
	djnz L_8EED		;8f28
	xor a			;8f2a
	ret			;8f2b
L_8F2C:
	push bc			;8f2c
	push ix		;8f2d
	pop bc			;8f2f
	ld a,034h		;8f30
	add a,c			;8f32
	ld c,a			;8f33
	exx			;8f34
	ld c,003h		;8f35
	exx			;8f37
L_8F38:
	ld a,(bc)			;8f38
	inc c			;8f39
	inc c			;8f3a
	sub e			;8f3b
	jp nc,L_8F48		;8f3c
	neg		;8f3f
	cp 008h		;8f41
	jp c,L_8F4B		;8f43
	jr L_8F5D		;8f46
L_8F48:
	cp l			;8f48
	jr nc,L_8F5D		;8f49
L_8F4B:
	dec c			;8f4b
	ld a,(bc)			;8f4c
	inc c			;8f4d
	sub d			;8f4e
	jp nc,L_8F5A		;8f4f
	neg		;8f52
	cp 010h		;8f54
	jr nc,L_8F5D		;8f56
L_8F58:
	pop bc			;8f58
	ret			;8f59
L_8F5A:
	cp h			;8f5a
	jr c,L_8F58		;8f5b
L_8F5D:
	inc c			;8f5d
	inc c			;8f5e
	exx			;8f5f
	dec c			;8f60
	exx			;8f61
	jr nz,L_8F38		;8f62
	pop bc			;8f64
	xor a			;8f65
	ret			;8f66
L_8F67:
	push af			;8f67
	cp 002h		;8f68
	call c,06514h		;8f6a
	pop af			;8f6d
	call 04084h		;8f6e

; ----------------------------------------------------------------------
; DATOS tabla_8F71: 6 destinos del despachador p00:4084 (call en p02:8F6E, el
;   indice en A): 8F7D, 8F9C, 8FE6, 8FD1, 8FD1, 89E8; lo leen p02:8F6E (12
;   bytes)
;   0x8f71..0x8f7d  (12 bytes)
DATA_tabla_8F71:
	defw 08f7dh,08f9ch,08fe6h,08fd1h,08fd1h,089e8h	; 8f71

; ======================================================================
; CODIGO 0x8f7d..0x9026  (169 bytes)
; ======================================================================


L_8F7D:
	xor a			;8f7d
	ld (0e20bh),a		;8f7e
	ld hl,0e330h		;8f81
	ld a,(hl)			;8f84
	inc a			;8f85
	inc l			;8f86
	cp (hl)			;8f87
	jr c,L_8F8C		;8f88
	ld a,001h		;8f8a
L_8F8C:
	dec l			;8f8c
	ld (hl),a			;8f8d
	ld de,00005h		;8f8e
	call 05b04h		;8f91
	ld a,00ah		;8f94
	call 04ae4h		;8f96
	jp 053a3h		;8f99
L_8F9C:
	ld de,00005h		;8f9c
	call 05b04h		;8f9f
L_8FA2:
	ld ix,0e8c0h		;8fa2
	ld b,00ch		;8fa6
L_8FA8:
	push bc			;8fa8
	ld a,(ix+000h)		;8fa9
	or a			;8fac
	jr z,L_8FC4		;8fad
	cp 01dh		;8faf
	jr z,L_8FC4		;8fb1
	cp 020h		;8fb3
	jr z,L_8FC4		;8fb5
	cp 026h		;8fb7
	jr z,L_8FC4		;8fb9
	sub 029h		;8fbb
	cp 006h		;8fbd
	jr c,L_8FC4		;8fbf
	call L_8928		;8fc1
L_8FC4:
	ld bc,0ffc0h		;8fc4
	add ix,bc		;8fc7
	pop bc			;8fc9
	djnz L_8FA8		;8fca
	ld a,00bh		;8fcc
	jp 04ae4h		;8fce
L_8FD1:
	call L_8FF0		;8fd1
	call L_900D		;8fd4
	ld a,(0e357h)		;8fd7
	add a,a			;8fda
	add a,a			;8fdb
	add a,094h		;8fdc
	ld (ix+030h),a		;8fde
	ld a,023h		;8fe1
	jp 04ae4h		;8fe3
L_8FE6:
	call L_8FF0		;8fe6
	ld (ix+030h),094h		;8fe9
	jp 05b92h		;8fed
L_8FF0:
	ld a,(ix+000h)		;8ff0
	ld (ix+028h),a		;8ff3
	ld (ix+000h),02fh		;8ff6
	ld a,(ix+004h)		;8ffa
	ld (ix+029h),a		;8ffd
	ld (ix+00bh),081h		;9000
	ld (ix+010h),008h		;9004
	ld (ix+002h),00ah		;9008
	ret			;900c
L_900D:
	call L_9019		;900d
	ld hl,L_9024		;9010
	call 04b67h		;9013
	jp 05b04h		;9016
L_9019:
	ld hl,0e357h		;9019
	ld a,(hl)			;901c
	inc a			;901d
	cp 008h		;901e
	jr c,L_9024		;9020
	ld a,007h		;9022
L_9024:
	ld (hl),a			;9024
	ret			;9025

; ----------------------------------------------------------------------
; DATOS tabla_9026: 7 palabras (0xE357 de 1 a 7; p02:900D lee 0x9024 + 2 x A
;   con L_4B67, y la 0 caeria en el `ld (hl),a / ret` de delante); lo leen
;   p02:9013 (14 bytes)
;   0x9026..0x9034  (14 bytes)
DATA_tabla_9026:
	defw 00001h,00002h,00005h,00010h,00020h,00050h,00100h	; 9026

; ======================================================================
; CODIGO 0x9034..0x94d9  (1189 bytes)
; ======================================================================


L_9034:
	ld a,(0e340h)		;9034
	or a			;9037
	ret nz			;9038
	ld a,(0ea60h)		;9039
	sub 002h		;903c
	ret c			;903e
	ld a,(0e400h)		;903f
	dec a			;9042
	ret m			;9043
	ld a,(0e404h)		;9044
	add a,004h		;9047
	ld e,a			;9049
	ld a,(0e406h)		;904a
	inc a			;904d
	ld d,a			;904e
	ld a,(0ea61h)		;904f
	sub e			;9052
	cp 008h		;9053
	jr c,L_905A		;9055
	add a,00fh		;9057
	ret nc			;9059
L_905A:
	ld a,(0ea62h)		;905a
	sub d			;905d
	cp 00bh		;905e
	jr c,L_9065		;9060
	add a,00fh		;9062
	ret nc			;9064
L_9065:
	ld a,01fh		;9065
	call 04ae4h		;9067
	ld de,00030h		;906a
	call 05b04h		;906d
	ld hl,0ea60h		;9070
	ld a,(hl)			;9073
	ld (hl),000h		;9074
	sub 003h		;9076
	jr z,L_908A		;9078
	dec a			;907a
	jr z,L_90A1		;907b
	dec a			;907d
	jr z,L_90BF		;907e
	sub 002h		;9080
	ret nz			;9082
	ld hl,01507h		;9083
	ld b,017h		;9086
	jr L_9094		;9088
L_908A:
	ld a,00fh		;908a
	call 04ae4h		;908c
	ld hl,01503h		;908f
	ld b,019h		;9092
L_9094:
	di			;9094
	ld (0e439h),hl		;9095
	ld a,03ch		;9098
	ld (0e43bh),a		;909a
	ei			;909d
	jp 054c7h		;909e
L_90A1:
	ld a,003h		;90a1
	ld (0e400h),a		;90a3
	ld hl,00001h		;90a6
	ld (0e440h),hl		;90a9
	ld hl,01504h		;90ac
	ld b,016h		;90af
	call L_9094		;90b1
	call 0a7f2h		;90b4
	call 042f5h		;90b7
	ld a,010h		;90ba
	jp 04ae4h		;90bc
L_90BF:
	ld hl,01505h		;90bf
	ld b,018h		;90c2
	jr L_9094		;90c4
L_90C6:
	ld a,(0e34bh)		;90c6
	or a			;90c9
	ret z			;90ca
	ld hl,0ea70h		;90cb
	call L_90D4		;90ce
	ld hl,0ea78h		;90d1
L_90D4:
	ld a,(hl)			;90d4
	or a			;90d5
	ret z			;90d6
	ld iy,0e470h		;90d7
	ld de,00010h		;90db
	ld bc,00910h		;90de
L_90E1:
	ld a,(iy+000h)		;90e1
	or a			;90e4
	jr z,L_90ED		;90e5
	push hl			;90e7
	call L_90F2		;90e8
	pop hl			;90eb
	ret c			;90ec
L_90ED:
	add iy,de		;90ed
	djnz L_90E1		;90ef
	ret			;90f1
L_90F2:
	inc l			;90f2
	ld a,(hl)			;90f3
	sub (iy+003h)		;90f4
	jp nc,L_9101		;90f7
	neg		;90fa
	cp c			;90fc
	jp c,L_9105		;90fd
	ret			;9100
L_9101:
	cp (iy+00dh)		;9101
	ret nc			;9104
L_9105:
	inc l			;9105
	ld a,(hl)			;9106
	sub (iy+005h)		;9107
	jp nc,L_9114		;910a
	neg		;910d
	cp c			;910f
	jp c,L_9118		;9110
	ret			;9113
L_9114:
	cp (iy+00ch)		;9114
	ret nc			;9117
L_9118:
	call L_9121		;9118
	ld (iy+000h),000h		;911b
	scf			;911f
	ret			;9120
L_9121:
	inc l			;9121
	dec (hl)			;9122
	jr z,L_9142		;9123
	ld a,(hl)			;9125
	and 003h		;9126
	ret nz			;9128
	dec l			;9129
	ld a,r		;912a
	and 00fh		;912c
	sub 007h		;912e
	add a,(hl)			;9130
	ld d,a			;9131
	ld a,r		;9132
	and 00fh		;9134
	sub 007h		;9136
	dec l			;9138
	add a,(hl)			;9139
	ld e,a			;913a
	ld a,033h		;913b
	ld c,000h		;913d
	jp 04d1eh		;913f
L_9142:
	dec l			;9142
	ld a,(hl)			;9143
	sub 008h		;9144
	ld d,a			;9146
	dec l			;9147
	ld a,(hl)			;9148
	sub 008h		;9149
	ld e,a			;914b
	dec l			;914c
	ld (hl),000h		;914d
	call L_8BA1		;914f
	ld hl,0e34ch		;9152
	dec (hl)			;9155
	jr z,L_915D		;9156
	ld a,009h		;9158
	jp 04ae4h		;915a
L_915D:
	ld a,001h		;915d
	ld (0e34fh),a		;915f
	ld a,03bh		;9162
	jp 04ae4h		;9164
L_9167:
	ld a,(0e340h)		;9167
	cp 005h		;916a
	jr nz,L_917B		;916c
	ld ix,0ea00h		;916e
	call L_9188		;9172
	ld ix,0ea20h		;9175
	jr L_9188		;9179
L_917B:
	call 06878h		;917b
	ret z			;917e
	ld a,(0e345h)		;917f
	and a			;9182
	ret nz			;9183
	ld ix,0ea00h		;9184
L_9188:
	ld a,(ix+000h)		;9188
	and a			;918b
	ret z			;918c
	ld iy,0e470h		;918d
	ld b,009h		;9191
L_9193:
	push bc			;9193
	ld a,(iy+000h)		;9194
	or a			;9197
	call nz,L_91A4		;9198
	ld de,00010h		;919b
	add iy,de		;919e
	pop bc			;91a0
	djnz L_9193		;91a1
	ret			;91a3
L_91A4:
	ld l,(ix+013h)		;91a4
	ld h,(ix+014h)		;91a7
	ld (0e3d7h),hl		;91aa
	ld hl,0e3d7h		;91ad
	ld bc,01010h		;91b0
L_91B3:
	cp 006h		;91b3
	ret z			;91b5
	ld a,(0e345h)		;91b6
	and a			;91b9
	ret nz			;91ba
	ld a,(hl)			;91bb
	inc a			;91bc
	sub (iy+003h)		;91bd
	jp nc,L_91CA		;91c0
	neg		;91c3
	cp c			;91c5
	jp c,L_91CE		;91c6
	ret			;91c9
L_91CA:
	cp (iy+00dh)		;91ca
	ret nc			;91cd
L_91CE:
	inc l			;91ce
	ld a,(hl)			;91cf
	sub (iy+005h)		;91d0
	jp nc,L_91DD		;91d3
	neg		;91d6
	cp b			;91d8
	jp c,L_91E1		;91d9
	ret			;91dc
L_91DD:
	cp (iy+00ch)		;91dd
	ret nc			;91e0
L_91E1:
	ld a,(iy+000h)		;91e1
	cp 005h		;91e4
	jr nz,L_91EE		;91e6
	call L_8A0C		;91e8
	jp L_91F2		;91eb
L_91EE:
	ld (iy+000h),000h		;91ee
L_91F2:
	dec (ix+012h)		;91f2
	jp m,L_9218		;91f5
	ld a,(0e34dh)		;91f8
	cp 003h		;91fb
	jr z,L_926F		;91fd
	ld a,027h		;91ff
	call 04ae4h		;9201
	ld e,(ix+013h)		;9204
	ld a,(ix+014h)		;9207
	add a,010h		;920a
	jr nc,L_9210		;920c
	ld a,0f0h		;920e
L_9210:
	ld d,a			;9210
	ld a,026h		;9211
	ld c,000h		;9213
	jp 04d16h		;9215
L_9218:
	ld a,(0e340h)		;9218
	cp 005h		;921b
	jr nz,L_9224		;921d
	ld (ix+01fh),001h		;921f
	ret			;9223
L_9224:
	ld a,001h		;9224
	ld (0e345h),a		;9226
	ld a,(0e34dh)		;9229
	cp 003h		;922c
	ret z			;922e
	ld a,001h		;922f
	ld (0e22ch),a		;9231
	ld hl,(0e346h)		;9234
	ld de,0012ch		;9237
	rst 20h			;923a
	ld b,002h		;923b
	jr c,L_924A		;923d
	ld de,00384h		;923f
	rst 20h			;9242
	ld b,001h		;9243
	jr c,L_924A		;9245
	xor a			;9247
	jr L_925C		;9248
L_924A:
	ld hl,0e20fh		;924a
	ld a,(hl)			;924d
	cp 007h		;924e
	ld c,000h		;9250
	jr nc,L_925B		;9252
	cp 006h		;9254
	ld c,b			;9256
	jr c,L_925B		;9257
	ld c,001h		;9259
L_925B:
	ld a,c			;925b
L_925C:
	ld (0e444h),a		;925c
	ld a,03ah		;925f
	call 04ae4h		;9261
	ld a,001h		;9264
	ld (0e34fh),a		;9266
	ld de,00100h		;9269
	jp 05b04h		;926c
L_926F:
	ld de,(0ea99h)		;926f
	ld c,000h		;9273
	ld a,038h		;9275
	jp 04d1eh		;9277
L_927A:
	ld hl,0ea98h		;927a
	ld a,(hl)			;927d
	or a			;927e
	ret z			;927f
	ld iy,0e470h		;9280
	ld b,009h		;9284
L_9286:
	push bc			;9286
	ld a,(iy+000h)		;9287
	or a			;928a
	call nz,L_9297		;928b
	ld de,00010h		;928e
	add iy,de		;9291
	pop bc			;9293
	djnz L_9286		;9294
	ret			;9296
L_9297:
	ld ix,0ea00h		;9297
	ld hl,0ea99h		;929b
	ld bc,01010h		;929e
	jp L_91B3		;92a1
L_92A4:
	ld hl,0ea0eh		;92a4
	ld a,(0e404h)		;92a7
	sub (hl)			;92aa
	add a,010h		;92ab
	cp 020h		;92ad
	ret nc			;92af
	inc l			;92b0
	inc l			;92b1
	ld a,(0e406h)		;92b2
	sub (hl)			;92b5
	add a,018h		;92b6
	cp 028h		;92b8
	ret nc			;92ba
	ld a,001h		;92bb
	ld (0e22bh),a		;92bd
	ret			;92c0
L_92C1:
	ld a,(0e439h)		;92c1
	cp 005h		;92c4
	jr nz,L_92CD		;92c6
	ld a,(0e1c3h)		;92c8
	rra			;92cb
	ret c			;92cc
L_92CD:
	ld ix,0e900h		;92cd
	ld b,00ah		;92d1
L_92D3:
	ld a,(ix+000h)		;92d3
	and a			;92d6
	jr z,L_92EE		;92d7
	cp 082h		;92d9
	call z,0b70bh		;92db
	call 064e1h		;92de
	jr nc,L_92EA		;92e1
	ld a,(ix+006h)		;92e3
	cp 0f0h		;92e6
	jr c,L_92EE		;92e8
L_92EA:
	ld (ix+000h),000h		;92ea
L_92EE:
	ld de,00010h		;92ee
	add ix,de		;92f1
	djnz L_92D3		;92f3
	ret			;92f5
L_92F6:
	ld ix,0e900h		;92f6
	ld b,00ah		;92fa
L_92FC:
	ld a,(ix+000h)		;92fc
	and a			;92ff
	jr z,L_930F		;9300
	bit 7,a		;9302
	jr nz,L_930F		;9304
	call L_9317		;9306
	jr nc,L_930F		;9309
	ld (ix+000h),000h		;930b
L_930F:
	ld de,00010h		;930f
	add ix,de		;9312
	djnz L_92FC		;9314
	ret			;9316
L_9317:
	ld l,(ix+004h)		;9317
	ld h,(ix+006h)		;931a
	call 05c92h		;931d
	ld a,(0e201h)		;9320
	or a			;9323
	jr z,L_9335		;9324
	sub 007h		;9326
	cp 002h		;9328
	jr c,L_9335		;932a
L_932C:
	ld a,(hl)			;932c
	and a			;932d
	ret z			;932e
L_932F:
	ld a,(0e305h)		;932f
	cp (hl)			;9332
	ccf			;9333
	ret			;9334
L_9335:
	ld a,(hl)			;9335
	cp 009h		;9336
	ccf			;9338
	ret nc			;9339
	jp L_932F		;933a
L_933D:
	ld a,050h		;933d
	ld (0f00fh),a		;933f
	ld e,(ix+004h)		;9342
	ld d,(ix+006h)		;9345
	call L_93F8		;9348
	ld de,(0f012h)		;934b
	call 04efbh		;934f
	ld de,(0f014h)		;9352
	jp 04f02h		;9356
L_9359:
	call L_9360		;9359
	ret nc			;935c
	jp 06514h		;935d
L_9360:
	ld l,(ix+004h)		;9360
	ld a,(ix+006h)		;9363
	bit 7,(ix+00ah)		;9366
	jr nz,L_936E		;936a
	add a,008h		;936c
L_936E:
	ld h,a			;936e
	call 05c92h		;936f
	call L_932C		;9372
	ret c			;9375
	ld de,00020h		;9376
	add hl,de			;9379
	jp L_932C		;937a
L_937D:
	ld (0f012h),bc		;937d
	ld (0f014h),hl		;9381
	ld a,e			;9384
	add a,008h		;9385
	ld e,a			;9387
	ld a,(0f00eh)		;9388
	and a			;938b
	ret nz			;938c
	jr L_93B1		;938d
L_938F:
	ld a,e			;938f
	add a,008h		;9390
	ld e,a			;9392
	ld a,(0e228h)		;9393
	add a,a			;9396
	add a,050h		;9397
	cp 060h		;9399
	jr c,L_939F		;939b
	ld a,060h		;939d
L_939F:
	ld (0f00fh),a		;939f
	push de			;93a2
	call L_93F8		;93a3
	pop de			;93a6
	ld a,(0f00eh)		;93a7
	and a			;93aa
	ret nz			;93ab
	ld a,(0e354h)		;93ac
	and a			;93af
	ret nz			;93b0
L_93B1:
	ld hl,0e900h		;93b1
	ld b,00ah		;93b4
L_93B6:
	ld a,(hl)			;93b6
	and a			;93b7
	jr z,L_93C1		;93b8
	ld a,010h		;93ba
	add a,l			;93bc
	ld l,a			;93bd
	djnz L_93B6		;93be
	ret			;93c0
L_93C1:
	ld a,001h		;93c1
	ld (0e307h),a		;93c3
	ld (hl),a			;93c6
	inc l			;93c7
	inc l			;93c8
	inc l			;93c9
	xor a			;93ca
	ld (hl),a			;93cb
	inc l			;93cc
	ld (hl),e			;93cd
	inc l			;93ce
	ld (hl),a			;93cf
	inc l			;93d0
	ld (hl),d			;93d1
	inc l			;93d2
	ld de,(0f012h)		;93d3
	ld (hl),e			;93d7
	inc l			;93d8
	ld (hl),d			;93d9
	ld de,(0f014h)		;93da
	inc l			;93de
	ld (hl),e			;93df
	inc l			;93e0
	ld (hl),d			;93e1
	inc l			;93e2
	ld (hl),054h		;93e3
	inc l			;93e5
	ld (hl),009h		;93e6
	ret			;93e8
L_93E9:
	ld (0f00fh),a		;93e9
	call L_945B		;93ec
	ld d,001h		;93ef
	jr L_93FD		;93f1
L_93F3:
	ld a,080h		;93f3
L_93F5:
	ld (0f00fh),a		;93f5
L_93F8:
	call L_945B		;93f8
L_93FB:
	ld d,000h		;93fb
L_93FD:
	ld a,(0f017h)		;93fd
	ld e,a			;9400
	ld a,(0e228h)		;9401
	cp 007h		;9404
	jr c,L_9425		;9406
	dec d			;9408
	jr z,L_9425		;9409
	ld a,r		;940b
	ld b,a			;940d
	and 00fh		;940e
	bit 6,b		;9410
	jr z,L_941D		;9412
	ld b,a			;9414
	ld a,c			;9415
	sub b			;9416
	jr nc,L_941A		;9417
	xor a			;9419
L_941A:
	ld e,a			;941a
	jr L_9425		;941b
L_941D:
	add a,e			;941d
	cp 03fh		;941e
	jr c,L_9424		;9420
	ld a,03fh		;9422
L_9424:
	ld e,a			;9424
L_9425:
	ld d,000h		;9425
	ld a,e			;9427
	sub 03fh		;9428
	neg		;942a
	ld hl,095d9h		;942c
	push hl			;942f
	add hl,de			;9430
	ld c,(hl)			;9431
	pop hl			;9432
	ld e,a			;9433
	add hl,de			;9434
	ld a,(hl)			;9435
	ld (0f016h),a		;9436
	ld e,c			;9439
	call L_94BB		;943a
	ld a,(0f010h)		;943d
	and a			;9440
	call nz,05cadh		;9441
	ld (0f012h),de		;9444
	ld a,(0f016h)		;9448
	ld e,a			;944b
	call L_94BB		;944c
	ld a,(0f011h)		;944f
	and a			;9452
	call nz,05cadh		;9453
	ld (0f014h),de		;9456
	ret			;945a
L_945B:
	ld a,(0e404h)		;945b
	ld (0f000h),a		;945e
	ld a,(0e406h)		;9461
	ld (0f001h),a		;9464
L_9467:
	ld hl,0f010h		;9467
	ld (hl),000h		;946a
	ld a,(0f000h)		;946c
	sub e			;946f
	jr nc,L_9475		;9470
	neg		;9472
	inc (hl)			;9474
L_9475:
	inc hl			;9475
	ld (hl),000h		;9476
	and 0f0h		;9478
	ld e,a			;947a
	ld a,(0f001h)		;947b
	sub d			;947e
	jr nc,L_9484		;947f
	neg		;9481
	inc (hl)			;9483
L_9484:
	ld d,a			;9484
	ld hl,0f00eh		;9485
	ld (hl),000h		;9488
	add a,e			;948a
	jr c,L_9492		;948b
	cp 030h		;948d
	jr nc,L_9492		;948f
	inc (hl)			;9491
L_9492:
	ld a,d			;9492
	rra			;9493
	rra			;9494
	rra			;9495
	rra			;9496
	and 00fh		;9497
	add a,e			;9499
	ld hl,094d9h		;949a
	call 0407ah		;949d
	ld a,(hl)			;94a0
	ld (0f017h),a		;94a1
	ld c,a			;94a4
	ld hl,(0f010h)		;94a5
	ld a,h			;94a8
	ld b,000h		;94a9
	and a			;94ab
	jr z,L_94B0		;94ac
	ld b,080h		;94ae
L_94B0:
	cp l			;94b0
	ld a,c			;94b1
	jr z,L_94B6		;94b2
	neg		;94b4
L_94B6:
	add a,b			;94b6
	ld (0f018h),a		;94b7
	ret			;94ba
L_94BB:
	ld a,(0f00fh)		;94bb
	ld h,a			;94be
	call L_94CD		;94bf
	xor a			;94c2
	add hl,hl			;94c3
	adc a,a			;94c4
	add hl,hl			;94c5
	adc a,a			;94c6
	add hl,hl			;94c7
	adc a,a			;94c8
	ld l,h			;94c9
	ld h,a			;94ca
	ex de,hl			;94cb
	ret			;94cc
L_94CD:
	ld b,008h		;94cd
	ld l,000h		;94cf
	ld d,l			;94d1
L_94D2:
	add hl,hl			;94d2
	jr nc,L_94D6		;94d3
	add hl,de			;94d5
L_94D6:
	djnz L_94D2		;94d6
	ret			;94d8

; ----------------------------------------------------------------------
; DATOS arcotangente: 16 x 16 bytes: el angulo (0x00-0x3F) para cada par
;   |dx|/16, |dy|/16 que p02:9492 calcula (0x94D9 + 16 x fila + columna); lo
;   leen p02:949D (256 bytes)
;   0x94d9..0x95d9  (256 bytes)
DATA_arcotangente:
	defb 020h,00dh,008h,006h,004h,004h,003h,003h,002h,002h,002h,002h,001h,001h,001h,001h	; 94d9   ...............
	defb 033h,020h,016h,010h,00dh,00bh,009h,008h,007h,006h,006h,005h,005h,004h,004h,004h	; 94e9  3 ..............
	defb 038h,02ah,020h,019h,015h,011h,00fh,00dh,00ch,00ah,009h,009h,008h,007h,007h,006h	; 94f9  8* .............
	defb 03ah,02fh,027h,020h,01bh,017h,014h,012h,010h,00eh,00dh,00ch,00bh,00ah,00ah,009h	; 9509  :/' ............
	defb 03bh,033h,02bh,025h,020h,01ch,019h,016h,014h,012h,010h,00fh,00eh,00dh,00ch,00bh	; 9519  .3+% ...........
	defb 03ch,035h,02eh,029h,024h,020h,01ch,01ah,017h,015h,014h,012h,011h,010h,00fh,00eh	; 9529  <5.)$ ..........
	defb 03dh,037h,031h,02ch,027h,023h,020h,01dh,01ah,018h,016h,015h,013h,012h,011h,010h	; 9539  =71,'# .........
	defb 03dh,038h,033h,02eh,02ah,026h,023h,020h,01dh,01bh,019h,017h,016h,015h,013h,012h	; 9549  =83.*&# ........
	defb 03dh,039h,034h,030h,02ch,028h,025h,022h,020h,01eh,01ch,01ah,018h,017h,015h,014h	; 9559  =940,(%" .......
	defb 03eh,039h,035h,031h,02eh,02ah,027h,025h,022h,020h,01eh,01ch,01ah,019h,017h,016h	; 9569  >951.*'%" ......
	defb 03eh,03ah,036h,033h,02fh,02ch,029h,027h,024h,022h,020h,01eh,01ch,01bh,019h,018h	; 9579  >:63/,)'$" .....
	defb 03eh,03bh,037h,034h,031h,02eh,02bh,028h,026h,024h,022h,020h,01eh,01dh,01bh,01ah	; 9589  >.741.+(&$" ....
	defb 03eh,03bh,038h,035h,032h,02fh,02ch,02ah,028h,025h,023h,022h,020h,01eh,01dh,01ch	; 9599  >.852/,*(%#" ...
	defb 03eh,03bh,038h,036h,033h,030h,02eh,02bh,029h,027h,025h,023h,021h,020h,01eh,01dh	; 95a9  >.8630.+)'%#! ..
	defb 03eh,03ch,039h,036h,034h,031h,02fh,02ch,02ah,028h,026h,025h,023h,021h,020h,01eh	; 95b9  ><9641/,*(&%#! .
	defb 03fh,03ch,039h,037h,034h,032h,030h,02dh,02bh,029h,028h,026h,024h,023h,021h,020h	; 95c9  ?<97420-+)(&$#!

; ----------------------------------------------------------------------
; DATOS seno: 64 bytes que suben de 0x00 a 0xFF: p02:9425 lee 0x95D9 + (0x3F -
;   E) y 0x95D9 + E; lo leen p02:942C (64 bytes)
;   0x95d9..0x9619  (64 bytes)
DATA_seno:
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; 95d9  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; 95e9  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; 95f9  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 9609  ................

; ----------------------------------------------------------------------
; DATOS tabla_9619: 4 pares que p02:9644 lee con (IX+02 / 2) & 6 y pone en
;   IX+30 e IX+31; lo leen p02:9654 (8 bytes)
;   0x9619..0x9621  (8 bytes)
DATA_tabla_9619:
	defb 044h,00fh	; 9619
	defb 048h,009h	; 961b
	defb 04ch,006h	; 961d
	defb 050h,00dh	; 961f

; ----------------------------------------------------------------------
; DATOS tabla_9621: 4 palabras que p02:963F y p03:B204 leen con L_4B67; lo
;   leen p02:963F (8 bytes)
;   0x9621..0x9629  (8 bytes)
DATA_tabla_9621:
	defw 00f44h,00f48h,00f44h,00f48h	; 9621

; ======================================================================
; CODIGO 0x9629..0x97b9  (400 bytes)
; ======================================================================


L_9629:
	ld (ix+002h),000h		;9629
	ld (ix+010h),008h		;962d
	ret			;9631
L_9632:
	ld a,(ix+002h)		;9632
	inc a			;9635
	cp 004h		;9636
	jp nc,06514h		;9638
	ld (ix+002h),a		;963b
	add a,a			;963e
	ld hl,09621h		;963f
	jr L_9654		;9642
L_9644:
	ld a,(ix+002h)		;9644
	cp 010h		;9647
	jr nc,L_9660		;9649
	inc (ix+002h)		;964b
	rra			;964e
	and 006h		;964f
	ld hl,09619h		;9651
L_9654:
	call 05ca6h		;9654
	ld (ix+030h),a		;9657
	inc hl			;965a
	ld a,(hl)			;965b
	ld (ix+031h),a		;965c
	ret			;965f
L_9660:
	xor a			;9660
	ld (ix+016h),a		;9661
	ld a,(ix+00ch)		;9664
	dec a			;9667
	jp m,06514h		;9668
	ld bc,02901h		;966b
	jr z,L_9672		;966e
	inc b			;9670
	inc c			;9671
L_9672:
	ld (ix+000h),b		;9672
	ld (ix+032h),c		;9675
	ld hl,0e355h		;9678
	dec (hl)			;967b
	ld (ix+00bh),0c0h		;967c
	call L_9694		;9680
	ld a,(ix+004h)		;9683
	and 0f8h		;9686
	ld (ix+004h),a		;9688
	ld a,(ix+006h)		;968b
	and 0f8h		;968e
	ld (ix+006h),a		;9690
	ret			;9693
L_9694:
	ld a,009h		;9694
L_9696:
	ld (ix+010h),a		;9696
	ld a,002h		;9699
	ld (ix+013h),a		;969b
	ld (ix+014h),a		;969e
L_96A1:
	ret			;96a1
L_96A2:
	ld (ix+00bh),000h		;96a2
	ld a,00bh		;96a6
	jr L_9696		;96a8
L_96AA:
	ld (ix+00bh),0c0h		;96aa
	ld c,037h		;96ae
	jr L_96C1		;96b0
L_96B2:
	ld b,008h		;96b2
	jr L_96B8		;96b4
L_96B6:
	ld b,001h		;96b6
L_96B8:
	ld (ix+02ah),b		;96b8
	ld (ix+00bh),0c0h		;96bb
	ld c,038h		;96bf
L_96C1:
	ld (ix+032h),c		;96c1
	ld a,009h		;96c4
	call L_9696		;96c6
	ld l,(ix+004h)		;96c9
	ld h,(ix+006h)		;96cc
	call 05c92h		;96cf
	xor a			;96d2
	ld (hl),a			;96d3
	inc hl			;96d4
	ld (hl),a			;96d5
	ld bc,0001fh		;96d6
	add hl,bc			;96d9
	ld (hl),a			;96da
	inc hl			;96db
	ld (hl),a			;96dc
	ret			;96dd
L_96DE:
	ld a,(ix+004h)		;96de
	or a			;96e1
	jp z,L_96E8		;96e2
	dec (ix+004h)		;96e5
L_96E8:
	dec (ix+002h)		;96e8
	ret nz			;96eb
	ld a,(ix+028h)		;96ec
	cp 02bh		;96ef
	jp z,06514h		;96f1
	dec (ix+02ah)		;96f4
	jp z,06514h		;96f7
	ld (ix+000h),02dh		;96fa
	ld (ix+00bh),0c0h		;96fe
	set 0,(ix+010h)		;9702
	ld a,(ix+029h)		;9706
	ld (ix+004h),a		;9709
L_970C:
	ret			;970c
L_970D:
	ld a,0c6h		;970d
	call L_9714		;970f
	jr L_9725		;9712
L_9714:
	ld (ix+032h),a		;9714
	ld a,(ix+004h)		;9717
	and 0f8h		;971a
	ld (ix+004h),a		;971c
	ret			;971f
L_9720:
	ld c,0c7h		;9720
	call L_9743		;9722
L_9725:
	ld a,(ix+00ch)		;9725
	ld (ix+002h),a		;9728
L_972B:
	ld (ix+00ch),000h		;972b
	ld a,001h		;972f
	ld (ix+010h),a		;9731
	ld (ix+013h),a		;9734
	ld (ix+014h),a		;9737
	ld a,(ix+006h)		;973a
	and 0f8h		;973d
	ld (ix+006h),a		;973f
	ret			;9742
L_9743:
	ld a,(ix+004h)		;9743
	rra			;9746
	and 003h		;9747
	add a,c			;9749
	ld (ix+032h),a		;974a
	ret			;974d
L_974E:
	ld a,(ix+001h)		;974e
	dec a			;9751
	jr z,$+107		;9752
	dec a			;9754
	jr z,$+125		;9755
	jp p,L_97DA		;9757
	ld a,(ix+006h)		;975a
	sub 008h		;975d
	ld (ix+006h),a		;975f
	jr z,$+107		;9762
	ld a,(0e340h)		;9764
	or a			;9767
	jr z,L_978E		;9768
	ld hl,l97b8h		;976a
	ld a,(ix+002h)		;976d
	call 05ca6h		;9770
	ld a,(0ea03h)		;9773
	add a,(hl)			;9776
	ld (ix+004h),a		;9777
	cp 0b0h		;977a
	jp nc,06514h		;977c
	ld a,(ix+000h)		;977f
	cp 039h		;9782
	jr z,L_978E		;9784
	ld a,(ix+004h)		;9786
	and 0f8h		;9789
	ld (ix+004h),a		;978b
L_978E:
	call L_97F3		;978e
	jr c,L_97AC		;9791
	inc (ix+014h)		;9793
	ld a,(ix+014h)		;9796
	cp (ix+019h)		;9799
	jr c,L_97A2		;979c
	ld (ix+001h),001h		;979e
L_97A2:
	ld a,(ix+014h)		;97a2
	add a,a			;97a5
	add a,a			;97a6
	add a,a			;97a7
	ld (ix+00fh),a		;97a8
	ret			;97ab
L_97AC:
	ld a,(ix+006h)		;97ac
	add a,008h		;97af
	ld (ix+006h),a		;97b1
	ld (ix+001h),003h		;97b4
L_97B8:
	ret			;97b8

; ----------------------------------------------------------------------
; DATOS tabla_97B9: 4 bytes (IX+02 de 1 a 4: p02:976A lee 0x97B8 + IX+02 con
;   L_5CA6, y la 0 caeria en el codigo de delante); lo leen p02:9770 (4 bytes)
;   0x97b9..0x97bd  (4 bytes)
DATA_tabla_97B9:
	defb 010h,02eh,050h,06eh	; 97b9

; ======================================================================
; CODIGO 0x97bd..0x9998  (475 bytes)
; ======================================================================


L_97BD:
	ld a,(ix+006h)		;97bd
	sub 008h		;97c0
	ld (ix+006h),a		;97c2
	jr z,L_97CD		;97c5
	call L_97F3		;97c7
	jr c,$-30		;97ca
	ret			;97cc
L_97CD:
	ld (ix+001h),002h		;97cd
	ret			;97d1
L_97D2:
	dec (ix+014h)		;97d2
	jr nz,$-51		;97d5
	jp 06514h		;97d7
L_97DA:
	dec (ix+014h)		;97da
	jp z,06514h		;97dd
	call L_97A2		;97e0
	ld a,(0e320h)		;97e3
	or a			;97e6
	ret z			;97e7
	ld a,(ix+006h)		;97e8
	sub 008h		;97eb
	ld (ix+006h),a		;97ed
	ret nz			;97f0
	jr L_97CD		;97f1
L_97F3:
	ld a,(0e340h)		;97f3
	or a			;97f6
	ret nz			;97f7
	ld l,(ix+004h)		;97f8
	ld h,(ix+006h)		;97fb
	call 05c92h		;97fe
	ld a,(hl)			;9801
	or a			;9802
	ret z			;9803
	ld hl,0e305h		;9804
	cp (hl)			;9807
	ret			;9808
L_9809:
	ld c,0fah		;9809
	call L_9743		;980b
	jp L_972B		;980e
L_9811:
	ld a,(ix+001h)		;9811
	dec a			;9814
	jr z,L_9841		;9815
	dec a			;9817
	jr z,L_9852		;9818
	jp p,L_9840		;981a
	ld b,004h		;981d
L_981F:
	ld a,(ix+006h)		;981f
	sub 008h		;9822
	ld (ix+006h),a		;9824
	jp z,L_983C		;9827
	inc (ix+014h)		;982a
	dec (ix+019h)		;982d
	jr z,L_9837		;9830
	djnz L_981F		;9832
	jp L_97A2		;9834
L_9837:
	ld (ix+001h),001h		;9837
	ret			;983b
L_983C:
	ld (ix+001h),002h		;983c
L_9840:
	ret			;9840
L_9841:
	ld b,004h		;9841
L_9843:
	ld a,(ix+006h)		;9843
	sub 008h		;9846
	ld (ix+006h),a		;9848
	jr z,L_983C		;984b
	djnz L_9843		;984d
	jp L_97A2		;984f
L_9852:
	ld b,004h		;9852
L_9854:
	dec (ix+014h)		;9854
	jp z,06514h		;9857
	djnz L_9854		;985a
	jp L_97A2		;985c
L_985F:
	ld a,0f1h		;985f
	call L_9714		;9861
	jp L_972B		;9864
L_9867:
	ld (ix+024h),006h		;9867
	ld (ix+027h),000h		;986b
	res 2,(ix+010h)		;986f
	call 04f1ch		;9873
	ld de,0fe80h		;9876
	call 04f02h		;9879
	ld (ix+015h),008h		;987c
	ld a,(ix+019h)		;9880
	and a			;9883
	ret z			;9884
	ld (ix+030h),0b4h		;9885
	ret			;9889
L_988A:
	call L_9989		;988a
	ld a,(ix+001h)		;988d
	dec a			;9890
	jr z,L_98CC		;9891
	dec a			;9893
	jr z,L_9904		;9894
	dec a			;9896
	jp z,L_9918		;9897
	ld bc,00408h		;989a
L_989D:
	push bc			;989d
	ld a,(ix+006h)		;989e
	sub c			;98a1
	ld h,a			;98a2
	ld a,(ix+004h)		;98a3
	bit 0,(ix+019h)		;98a6
	jr nz,L_98AE		;98aa
	add a,008h		;98ac
L_98AE:
	ld l,a			;98ae
	call L_83D9		;98af
	pop bc			;98b2
	jr c,L_98C3		;98b3
	ld a,c			;98b5
	add a,008h		;98b6
	ld c,a			;98b8
	djnz L_989D		;98b9
	set 2,(ix+010h)		;98bb
	inc (ix+001h)		;98bf
	ret			;98c2
L_98C3:
	ld (ix+001h),003h		;98c3
	set 3,(ix+010h)		;98c7
	ret			;98cb
L_98CC:
	call L_995D		;98cc
	call c,04f2ch		;98cf
	call L_9929		;98d2
	jr c,L_98F7		;98d5
	inc (ix+001h)		;98d7
	ld d,(ix+00ah)		;98da
	ld e,(ix+009h)		;98dd
	ld (ix+026h),d		;98e0
	ld (ix+025h),e		;98e3
	ld hl,0fc00h		;98e6
	ld a,(ix+019h)		;98e9
	and a			;98ec
	jr nz,L_98F1		;98ed
	ld h,004h		;98ef
L_98F1:
	ld de,00100h		;98f1
	call 04f26h		;98f4
L_98F7:
	dec (ix+015h)		;98f7
	ret nz			;98fa
	call L_9EB0		;98fb
	ld (ix+015h),a		;98fe
	jp 0bb44h		;9901
L_9904:
	call L_9929		;9904
	ret nc			;9907
	ld e,(ix+026h)		;9908
	ld d,(ix+025h)		;990b
	call 04f02h		;990e
	ld (ix+001h),001h		;9911
	jp 04f1ch		;9915
L_9918:
	ld a,(ix+006h)		;9918
	cp 0c0h		;991b
	ret nz			;991d
	ld (ix+001h),001h		;991e
	ld (ix+010h),007h		;9922
	jp 04f2ch		;9926
L_9929:
	bit 0,(ix+019h)		;9929
	ld a,010h		;992d
	jr z,L_9933		;992f
	ld a,0ffh		;9931
L_9933:
	ld h,(ix+006h)		;9933
	add a,(ix+004h)		;9936
	ld l,a			;9939
	push hl			;993a
	call L_83D9		;993b
	pop hl			;993e
	jr c,L_9956		;993f
	ld a,(ix+004h)		;9941
	add a,068h		;9944
	cp 071h		;9946
	jr nc,L_9956		;9948
L_994A:
	ld de,00180h		;994a
	call 04f02h		;994d
	scf			;9950
	ret			;9951
L_9952:
	cp 018h		;9952
	jr nc,L_994A		;9954
L_9956:
	ld a,h			;9956
	add a,008h		;9957
	ld h,a			;9959
	jp L_83D9		;995a
L_995D:
	bit 0,(ix+019h)		;995d
	ld a,(ix+004h)		;9961
	jr nz,L_9968		;9964
	add a,008h		;9966
L_9968:
	ld l,a			;9968
	ld a,(ix+006h)		;9969
	bit 7,(ix+00ah)		;996c
	jr z,L_997B		;9970
	cp 008h		;9972
	ccf			;9974
	ret nc			;9975
	dec a			;9976
	ld h,a			;9977
	jp L_83D9		;9978
L_997B:
	add a,008h		;997b
	ld h,a			;997d
	call L_83D9		;997e
	ret c			;9981
	ld a,(ix+006h)		;9982
	cp 0f0h		;9985
	ccf			;9987
	ret			;9988
L_9989:
	bit 0,(ix+019h)		;9989
	ld hl,09998h		;998d
	jr z,L_9995		;9990
	ld hl,0999ch		;9992
L_9995:
	jp L_9B31		;9995

; ----------------------------------------------------------------------
; DATOS tabla_9998: dos tablas de 4 bytes (0x9998 y 0x999C) que p02:9989 pasa
;   a L_9B31 segun el bit 0 de IX+19; lo leen p02:9995 (8 bytes)
;   0x9998..0x99a0  (8 bytes)
DATA_tabla_9998:
	defb 0dch,0e0h,0e8h,0e4h	; 9998
	defb 0b4h,0b8h,0c0h,0bch	; 999c

; ======================================================================
; CODIGO 0x99a0..0x9aaa  (266 bytes)
; ======================================================================


L_99A0:
	ld (ix+002h),022h		;99a0
	ld a,(ix+019h)		;99a4
	and a			;99a7
	jr nz,L_99C5		;99a8
	ld (ix+02ah),006h		;99aa
	ld a,r		;99ae
	and 001h		;99b0
	jr z,L_99BC		;99b2
	ld (ix+02ah),00eh		;99b4
	ld (ix+006h),004h		;99b8
L_99BC:
	ld a,(ix+02ah)		;99bc
	inc a			;99bf
	inc a			;99c0
	and 00fh		;99c1
	jr L_99EB		;99c3
L_99C5:
	ld (ix+030h),0c4h		;99c5
	inc (ix+001h)		;99c9
	ld a,(ix+019h)		;99cc
	bit 7,a		;99cf
	jr z,L_99D4		;99d1
	xor a			;99d3
L_99D4:
	ld (ix+026h),018h		;99d4
	jr L_99EF		;99d8
L_99DA:
	call 0637bh		;99da
	and 003h		;99dd
	add a,(ix+02ah)		;99df
	and 00fh		;99e2
	jr L_99EB		;99e4
L_99E6:
	call 0637bh		;99e6
	and 00fh		;99e9
L_99EB:
	ld (ix+026h),010h		;99eb
L_99EF:
	ld (ix+025h),a		;99ef
	ld c,a			;99f2
	ld a,(0e228h)		;99f3
	ld b,001h		;99f6
	cp 006h		;99f8
	jr c,L_99FD		;99fa
	inc b			;99fc
L_99FD:
	ld a,c			;99fd
	call 04cb7h		;99fe
	jp 04f26h		;9a01
L_9A04:
	ld (ix+027h),020h		;9a04
	ld (ix+024h),004h		;9a08
	ld (ix+028h),000h		;9a0c
	jp 04f17h		;9a10
L_9A13:
	ld a,(ix+031h)		;9a13
	xor 005h		;9a16
	ld (ix+031h),a		;9a18
	call L_9AAE		;9a1b
	call L_9AC3		;9a1e
	ld a,(ix+001h)		;9a21
	dec a			;9a24
	jr z,L_9A74		;9a25
	dec a			;9a27
	jr z,L_9A8A		;9a28
	dec (ix+002h)		;9a2a
	jr nz,L_9A6D		;9a2d
	ld c,000h		;9a2f
	ld d,(ix+006h)		;9a31
	ld e,(ix+004h)		;9a34
	ld a,(ix+025h)		;9a37
	add a,002h		;9a3a
	and 00fh		;9a3c
	jr nz,L_9A42		;9a3e
	ld a,080h		;9a40
L_9A42:
	ld b,a			;9a42
	ld a,008h		;9a43
	push de			;9a45
	push bc			;9a46
	call 04d16h		;9a47
	pop bc			;9a4a
	pop de			;9a4b
	ld a,b			;9a4c
	sub 004h		;9a4d
	and 00fh		;9a4f
	jr nz,L_9A55		;9a51
	ld a,080h		;9a53
L_9A55:
	ld b,a			;9a55
	ld a,008h		;9a56
	ld c,000h		;9a58
	call 04d16h		;9a5a
	ld (ix+030h),0c4h		;9a5d
	inc (ix+001h)		;9a61
	ld (ix+019h),0ffh		;9a64
	ld (ix+026h),010h		;9a68
	ret			;9a6c
L_9A6D:
	dec (ix+026h)		;9a6d
	ret nz			;9a70
	jp L_99DA		;9a71
L_9A74:
	ld a,(ix+019h)		;9a74
	or a			;9a77
	jr z,L_9A6D		;9a78
	dec (ix+026h)		;9a7a
	ret nz			;9a7d
	res 2,(ix+010h)		;9a7e
	inc (ix+001h)		;9a82
	ld (ix+026h),008h		;9a85
	ret			;9a89
L_9A8A:
	dec (ix+026h)		;9a8a
	ret nz			;9a8d
	dec (ix+001h)		;9a8e
	set 2,(ix+010h)		;9a91
	ld (ix+026h),028h		;9a95
	ld a,(0e228h)		;9a99
	srl a		;9a9c
	srl a		;9a9e
	ld hl,09aaah		;9aa0
	call 0407ah		;9aa3
	ld a,(hl)			;9aa6
	jp 04ecah		;9aa7

; ----------------------------------------------------------------------
; DATOS tabla_9AAA: 4 bytes que p02:9A99 lee con 0xE228 / 4; lo leen p02:9AA3
;   (4 bytes)
;   0x9aaa..0x9aae  (4 bytes)
DATA_tabla_9AAA:
	defb 020h,030h,040h,050h	; 9aaa

; ======================================================================
; CODIGO 0x9aae..0x9b48  (154 bytes)
; ======================================================================


L_9AAE:
	bit 7,(ix+008h)		;9aae
	ld a,(ix+004h)		;9ab2
	jr z,L_9ABD		;9ab5
	cp 008h		;9ab7
	jp c,04f3ch		;9ab9
	ret			;9abc
L_9ABD:
	cp 0a0h		;9abd
	jp nc,04f3ch		;9abf
	ret			;9ac2
L_9AC3:
	ld a,(ix+001h)		;9ac3
	or a			;9ac6
	jr nz,L_9AE4		;9ac7
	ld b,0b4h		;9ac9
	ld a,(ix+002h)		;9acb
	cp 014h		;9ace
	jr nc,L_9AE0		;9ad0
	ld b,0b8h		;9ad2
	cp 00fh		;9ad4
	jr nc,L_9AE0		;9ad6
	ld b,0bch		;9ad8
	cp 004h		;9ada
	jr nc,L_9AE0		;9adc
	ld b,0c0h		;9ade
L_9AE0:
	ld (ix+030h),b		;9ae0
	ret			;9ae3
L_9AE4:
	ld a,(0e1c3h)		;9ae4
	and 003h		;9ae7
	ret nz			;9ae9
	ld a,(ix+030h)		;9aea
	add a,004h		;9aed
	cp 0dch		;9aef
	jr nz,L_9AF5		;9af1
	ld a,0c4h		;9af3
L_9AF5:
	ld (ix+030h),a		;9af5
	ret			;9af8
L_9AF9:
	dec (ix+006h)		;9af9
	call L_9B2E		;9afc
	ld a,(ix+001h)		;9aff
	dec a			;9b02
	jr z,L_9B14		;9b03
	dec a			;9b05
	jr z,L_9B1F		;9b06
	dec (ix+027h)		;9b08
	ret nz			;9b0b
	ld (ix+026h),001h		;9b0c
	inc (ix+001h)		;9b10
	ret			;9b13
L_9B14:
	dec (ix+026h)		;9b14
	ret nz			;9b17
	call L_99E6		;9b18
	inc (ix+001h)		;9b1b
	ret			;9b1e
L_9B1F:
	dec (ix+026h)		;9b1f
	ret nz			;9b22
	ld (ix+026h),008h		;9b23
	call 04f17h		;9b27
	dec (ix+001h)		;9b2a
	ret			;9b2d
L_9B2E:
	ld hl,09b48h		;9b2e
L_9B31:
	ld c,000h		;9b31
L_9B33:
	dec (ix+024h)		;9b33
	ld a,(ix+024h)		;9b36
	rra			;9b39
	rra			;9b3a
	dec c			;9b3b
	jr nz,L_9B3F		;9b3c
	rra			;9b3e
L_9B3F:
	and 003h		;9b3f
	call 05ca6h		;9b41
	ld (ix+030h),a		;9b44
	ret			;9b47

; ----------------------------------------------------------------------
; DATOS tabla_9B48: 4 bytes que p02:9B2E pasa a L_9B31; lo leen p02:9B2E (4
;   bytes)
;   0x9b48..0x9b4c  (4 bytes)
DATA_tabla_9B48:
	defb 0c4h,0c8h,0cch,0c8h	; 9b48

; ======================================================================
; CODIGO 0x9b4c..0x9b98  (76 bytes)
; ======================================================================


L_9B4C:
	ld (ix+02bh),008h		;9b4c
	ld de,0fd00h		;9b50
	call 04f02h		;9b53
	jp 04f1ch		;9b56
L_9B59:
	call L_9B85		;9b59
	call 06770h		;9b5c
	call L_9B77		;9b5f
L_9B62:
	ld a,(0e404h)		;9b62
	ld de,00016h		;9b65
	cp (ix+004h)		;9b68
	call c,05cadh		;9b6b
	ex de,hl			;9b6e
	call 04f10h		;9b6f
	add hl,de			;9b72
	ex de,hl			;9b73
	jp 04efbh		;9b74
L_9B77:
	ld a,(0e406h)		;9b77
	cp (ix+006h)		;9b7a
	ret c			;9b7d
	dec (ix+02bh)		;9b7e
	ret nz			;9b81
	jp 0bb44h		;9b82
L_9B85:
	ld hl,09b98h		;9b85
	ld a,(0e201h)		;9b88
	cp 004h		;9b8b
	jr nz,L_9B92		;9b8d
	ld hl,09b9fh		;9b8f
L_9B92:
	ld bc,00307h		;9b92
	jp 06361h		;9b95

; ----------------------------------------------------------------------
; DATOS tabla_9B98: dos tablas de 7 bytes (0x9B98, y 0x9B9F en la fase 4) que
;   p02:9B85 pasa a L_6361; lo leen p02:9B92 (14 bytes)
;   0x9b98..0x9ba6  (14 bytes)
DATA_tabla_9B98:
	defb 0a4h,0a8h,0ach,0b0h,0ach,0a8h,0a4h	; 9b98
	defb 074h,078h,07ch,080h,07ch,078h,074h	; 9b9f

; ======================================================================
; CODIGO 0x9ba6..0x9bc1  (27 bytes)
; ======================================================================


L_9BA6:
	ld a,(0e201h)		;9ba6
	cp 004h		;9ba9
	jr nz,L_9BB1		;9bab
	ld (ix+030h),084h		;9bad
L_9BB1:
	ld a,(0e228h)		;9bb1
	srl a		;9bb4
	srl a		;9bb6
	ld hl,09bc1h		;9bb8
	call 05ca6h		;9bbb
	jp 04ecah		;9bbe

; ----------------------------------------------------------------------
; DATOS tabla_9BC1: 4 bytes que p02:9BB1 lee con 0xE228 / 4; lo leen p02:9BBB
;   (4 bytes)
;   0x9bc1..0x9bc5  (4 bytes)
DATA_tabla_9BC1:
	defb 070h,090h,0a0h,0c0h	; 9bc1

; ======================================================================
; CODIGO 0x9bc5..0x9beb  (38 bytes)
; ======================================================================


L_9BC5:
	ld a,(0e1c3h)		;9bc5
	and 003h		;9bc8
	ret nz			;9bca
	ld hl,09bebh		;9bcb
	ld a,(0e201h)		;9bce
	cp 004h		;9bd1
	jr nz,L_9BD8		;9bd3
	ld hl,09bf1h		;9bd5
L_9BD8:
	ld a,(ix+025h)		;9bd8
	inc a			;9bdb
	cp 006h		;9bdc
	jr c,L_9BE1		;9bde
	xor a			;9be0
L_9BE1:
	ld (ix+025h),a		;9be1
	call 05ca6h		;9be4
	ld (ix+030h),a		;9be7
	ret			;9bea

; ----------------------------------------------------------------------
; DATOS tabla_9BEB: dos tablas de 6 bytes (0x9BEB, y 0x9BF1 en la fase 4) que
;   p02:9BCB lee con IX+25; lo leen p02:9BD8 (12 bytes)
;   0x9beb..0x9bf7  (12 bytes)
DATA_tabla_9BEB:
	defb 0b4h,0b8h,0bch,0c0h,0bch,0b8h	; 9beb
	defb 084h,088h,08ch,090h,08ch,088h	; 9bf1

; ======================================================================
; CODIGO 0x9bf7..0x9c3c  (69 bytes)
; ======================================================================


L_9BF7:
	ld de,0fe80h		;9bf7
	call 04f02h		;9bfa
	ld de,00800h		;9bfd
	ld a,(ix+004h)		;9c00
	cp 060h		;9c03
	jr c,L_9C09		;9c05
	ld d,0f8h		;9c07
L_9C09:
	jp 04efbh		;9c09
L_9C0C:
	call L_9C40		;9c0c
	call L_9C36		;9c0f
	ld a,(ix+001h)		;9c12
	dec a			;9c15
	jr z,L_9C22		;9c16
	ld a,048h		;9c18
	cp (ix+004h)		;9c1a
	ret nz			;9c1d
	inc (ix+001h)		;9c1e
	ret			;9c21
L_9C22:
	ld de,00080h		;9c22
	ld a,048h		;9c25
L_9C27:
	cp (ix+004h)		;9c27
	call c,05cadh		;9c2a
	ex de,hl			;9c2d
	call 04f10h		;9c2e
	add hl,de			;9c31
	ex de,hl			;9c32
	jp 04efbh		;9c33
L_9C36:
	ld hl,09c3ch		;9c36
	jp L_9B31		;9c39

; ----------------------------------------------------------------------
; DATOS tabla_9C3C: 4 bytes que p02:9C36 pasa a L_9B31; lo leen p02:9C36 (4
;   bytes)
;   0x9c3c..0x9c40  (4 bytes)
DATA_tabla_9C3C:
	defb 0f4h,0f8h,0f4h,0f8h	; 9c3c

; ======================================================================
; CODIGO 0x9c40..0x9c87  (71 bytes)
; ======================================================================


L_9C40:
	ld a,(0e228h)		;9c40
	cp 006h		;9c43
	ret c			;9c45
	dec (ix+015h)		;9c46
	ret nz			;9c49
	call 04e93h		;9c4a
	jp 0bb44h		;9c4d
L_9C50:
	ld (ix+025h),020h		;9c50
	ld (ix+010h),002h		;9c54
	jp L_9BB1		;9c58
L_9C5B:
	ld a,(ix+001h)		;9c5b
	and a			;9c5e
	ret nz			;9c5f
	dec (ix+025h)		;9c60
	jr nz,L_9C71		;9c63
	inc (ix+001h)		;9c65
	ld (ix+031h),005h		;9c68
	ld (ix+010h),007h		;9c6c
	ret			;9c70
L_9C71:
	ld hl,09c87h		;9c71
	ld a,(ix+027h)		;9c74
	inc a			;9c77
	cp 006h		;9c78
	jr c,L_9C7D		;9c7a
	xor a			;9c7c
L_9C7D:
	ld (ix+027h),a		;9c7d
	call 05ca6h		;9c80
	ld (ix+031h),a		;9c83
	ret			;9c86

; ----------------------------------------------------------------------
; DATOS tabla_9C87: 6 bytes que p02:9C71 lee con IX+27 (de 0 a 5); lo leen
;   p02:9C80 (6 bytes)
;   0x9c87..0x9c8d  (6 bytes)
DATA_tabla_9C87:
	defb 004h,005h,007h,00fh,007h,005h	; 9c87

; ======================================================================
; CODIGO 0x9c8d..0x9cbb  (46 bytes)
; ======================================================================


L_9C8D:
	ld (ix+024h),008h		;9c8d
	ld (ix+02bh),000h		;9c91
	ld a,(0e228h)		;9c95
	cp 006h		;9c98
	ld de,0fa00h		;9c9a
	jr nc,L_9CA1		;9c9d
	ld d,0fch		;9c9f
L_9CA1:
	ld (ix+02ah),d		;9ca1
	call 04f02h		;9ca4
	call 04f1ch		;9ca7
L_9CAA:
	ld a,(0e228h)		;9caa
	srl a		;9cad
	srl a		;9caf
	ld hl,09cbbh		;9cb1
	call 05ca6h		;9cb4
	ld (ix+02ch),a		;9cb7
	ret			;9cba

; ----------------------------------------------------------------------
; DATOS tabla_9CBB: 4 bytes que p02:9CAA lee con 0xE228 / 4; lo leen p02:9CB4
;   (4 bytes)
;   0x9cbb..0x9cbf  (4 bytes)
DATA_tabla_9CBB:
	defb 028h,020h,018h,010h	; 9cbb

; ======================================================================
; CODIGO 0x9cbf..0x9d63  (164 bytes)
; ======================================================================


L_9CBF:
	ld a,(ix+006h)		;9cbf
	cp 008h		;9cc2
	jp c,06514h		;9cc4
	call L_9D59		;9cc7
	ld hl,09d63h		;9cca
	ld a,(0e201h)		;9ccd
	cp 005h		;9cd0
	jr nz,L_9CD7		;9cd2
	ld hl,09d67h		;9cd4
L_9CD7:
	ld c,001h		;9cd7
	call L_9B33		;9cd9
	ld a,(ix+001h)		;9cdc
	dec a			;9cdf
	jr z,L_9D16		;9ce0
	dec a			;9ce2
	jr z,L_9D4D		;9ce3
	ld hl,09d6bh		;9ce5
	ld a,(ix+02bh)		;9ce8
	ld c,a			;9ceb
	call 05ca6h		;9cec
	cp (ix+006h)		;9cef
	ret c			;9cf2
	inc c			;9cf3
	ld (ix+02bh),c		;9cf4
	inc (ix+001h)		;9cf7
	ld a,(ix+004h)		;9cfa
	cp 058h		;9cfd
	ld a,001h		;9cff
	jr c,L_9D05		;9d01
	ld a,0ffh		;9d03
L_9D05:
	ld (ix+028h),a		;9d05
	ld (ix+002h),002h		;9d08
	ld a,008h		;9d0c
	ld b,004h		;9d0e
	ld (ix+027h),a		;9d10
	jp 04cb7h		;9d13
L_9D16:
	dec (ix+002h)		;9d16
	ret nz			;9d19
	ld (ix+002h),002h		;9d1a
	ld a,(ix+027h)		;9d1e
	add a,(ix+028h)		;9d21
	and 00fh		;9d24
	cp 008h		;9d26
	jr z,L_9D35		;9d28
	ld (ix+027h),a		;9d2a
	ld b,004h		;9d2d
	call 04cb7h		;9d2f
	jp 04f26h		;9d32
L_9D35:
	call 04f1ch		;9d35
	ld d,(ix+02ah)		;9d38
	ld e,000h		;9d3b
	call 04f02h		;9d3d
	ld (ix+001h),e		;9d40
	ld a,(ix+02bh)		;9d43
	dec a			;9d46
	ret z			;9d47
	ld (ix+001h),002h		;9d48
	ret			;9d4c
L_9D4D:
	ld de,0ffc8h		;9d4d
L_9D50:
	ex de,hl			;9d50
	call 04f09h		;9d51
	add hl,de			;9d54
	ex de,hl			;9d55
	jp 04f02h		;9d56
L_9D59:
	dec (ix+02ch)		;9d59
	ret nz			;9d5c
	call L_9CAA		;9d5d
	jp 0bb44h		;9d60

; ----------------------------------------------------------------------
; DATOS tablas_9D63: dos tablas de 4 bytes (0x9D63, y 0x9D67 en la fase 5) que
;   p02:9CCA lee, y 2 bytes en 0x9D6B que lee p02:9CE5; lo leen p02:9CCA (10
;   bytes)
;   0x9d63..0x9d6d  (10 bytes)
DATA_tablas_9D63:
	defb 0ech,0f0h,0f4h,0f0h	; 9d63
	defb 0a4h,0a8h,0ach,0a8h	; 9d67
	defb 090h,068h	; 9d6b

; ======================================================================
; CODIGO 0x9d6d..0x9f18  (427 bytes)
; ======================================================================


L_9D6D:
	ld a,(ix+004h)		;9d6d
	cp 060h		;9d70
	ld bc,00098h		;9d72
	jr c,L_9D7A		;9d75
	ld bc,0018ch		;9d77
L_9D7A:
	ld (ix+027h),b		;9d7a
	ld (ix+030h),c		;9d7d
	ld (ix+025h),00ah		;9d80
	call 04f1ch		;9d84
	ld de,00200h		;9d87
	call 04f02h		;9d8a
L_9D8D:
	ld a,r		;9d8d
	and 01fh		;9d8f
	add a,02dh		;9d91
	ld (ix+002h),a		;9d93
	ret			;9d96
L_9D97:
	call L_9F46		;9d97
	jp c,L_893A		;9d9a
	call L_9F75		;9d9d
	jp c,06514h		;9da0
	ld a,(ix+001h)		;9da3
	dec a			;9da6
	jr z,L_9DE1		;9da7
	jp p,L_9E12		;9da9
	call 06311h		;9dac
	jr c,L_9DD3		;9daf
	dec (ix+002h)		;9db1
	jr z,L_9DBC		;9db4
	call L_9E1B		;9db6
	jp L_9EFC		;9db9
L_9DBC:
	inc (ix+001h)		;9dbc
	ld (ix+002h),05ah		;9dbf
	call L_9F20		;9dc3
	call L_9E17		;9dc6
	call L_9EB0		;9dc9
	ld (ix+010h),00bh		;9dcc
	jp 04f21h		;9dd0
L_9DD3:
	ld (ix+010h),007h		;9dd3
	ld (ix+001h),002h		;9dd7
	ld de,0fe00h		;9ddb
	jp 04f02h		;9dde
L_9DE1:
	call 06311h		;9de1
	jr c,L_9DD3		;9de4
	dec (ix+002h)		;9de6
	jr z,L_9DF6		;9de9
	call L_9EBC		;9deb
	ld a,(0e201h)		;9dee
	or a			;9df1
	ret nz			;9df2
	jp L_9E1B		;9df3
L_9DF6:
	ld a,(0e406h)		;9df6
	cp (ix+006h)		;9df9
	ld de,00200h		;9dfc
	jr nc,L_9E04		;9dff
	ld de,0fe00h		;9e01
L_9E04:
	call 04f02h		;9e04
L_9E07:
	ld (ix+010h),007h		;9e07
	ld (ix+001h),000h		;9e0b
	jp L_9D8D		;9e0f
L_9E12:
	call L_9EFC		;9e12
	jr L_9E1B		;9e15
L_9E17:
	ld a,001h		;9e17
	jr L_9E1C		;9e19
L_9E1B:
	xor a			;9e1b
L_9E1C:
	ld (0e366h),a		;9e1c
	ld a,(ix+004h)		;9e1f
	ld (ix+028h),a		;9e22
	bit 0,(ix+027h)		;9e25
	jr z,L_9E74		;9e29
L_9E2B:
	ld h,(ix+006h)		;9e2b
	ld a,(ix+004h)		;9e2e
	add a,010h		;9e31
	ld l,a			;9e33
	call L_83E8		;9e34
	jr nc,L_9E62		;9e37
L_9E39:
	ld hl,(0e3bch)		;9e39
	ld bc,0ffe0h		;9e3c
	add hl,bc			;9e3f
	ld (0e3bch),hl		;9e40
	call L_83EE		;9e43
	ret nc			;9e46
	ld a,(ix+004h)		;9e47
	sub 008h		;9e4a
	ld (ix+004h),a		;9e4c
	cp 010h		;9e4f
	jr nc,L_9E39		;9e51
L_9E53:
	call 062fbh		;9e53
	ld (ix+025h),005h		;9e56
	ld a,(ix+028h)		;9e5a
	ld (ix+004h),a		;9e5d
	jr L_9E07		;9e60
L_9E62:
	ld a,(ix+004h)		;9e62
	cp 098h		;9e65
	ret nc			;9e67
	add a,008h		;9e68
	ld (ix+004h),a		;9e6a
	ld a,(0e366h)		;9e6d
	or a			;9e70
	jr nz,L_9E2B		;9e71
	ret			;9e73
L_9E74:
	ld h,(ix+006h)		;9e74
	ld l,(ix+004h)		;9e77
	call L_83E8		;9e7a
	jr nc,L_9E8D		;9e7d
	ld a,(ix+004h)		;9e7f
	add a,008h		;9e82
	ld (ix+004h),a		;9e84
	cp 080h		;9e87
	jr c,L_9E74		;9e89
	jr L_9E53		;9e8b
L_9E8D:
	ld hl,(0e3bch)		;9e8d
	ld bc,0ffe0h		;9e90
	add hl,bc			;9e93
	ld (0e3bch),hl		;9e94
	call L_83EE		;9e97
	ret c			;9e9a
	ld a,(ix+004h)		;9e9b
	cp 009h		;9e9e
	ret c			;9ea0
	ld a,(ix+004h)		;9ea1
	sub 008h		;9ea4
	ld (ix+004h),a		;9ea6
	ld a,(0e366h)		;9ea9
	or a			;9eac
	jr nz,L_9E8D		;9ead
	ret			;9eaf
L_9EB0:
	ld a,(0e228h)		;9eb0
	add a,a			;9eb3
	sub 03ch		;9eb4
	neg		;9eb6
	ld (ix+015h),a		;9eb8
	ret			;9ebb
L_9EBC:
	dec (ix+015h)		;9ebc
	ret nz			;9ebf
	call L_9EB0		;9ec0
	call L_9F20		;9ec3
	bit 0,(ix+027h)		;9ec6
	jr z,L_9ED5		;9eca
	ld a,(0e404h)		;9ecc
	cp (ix+004h)		;9ecf
	ret nc			;9ed2
	jr L_9EDC		;9ed3
L_9ED5:
	ld a,(0e404h)		;9ed5
	cp (ix+004h)		;9ed8
	ret c			;9edb
L_9EDC:
	ld e,(ix+004h)		;9edc
	ld d,(ix+006h)		;9edf
	call L_945B		;9ee2
	ld a,(0f018h)		;9ee5
	cp 080h		;9ee8
	jr c,L_9EEE		;9eea
	neg		;9eec
L_9EEE:
	cp 040h		;9eee
	jr c,L_9EF4		;9ef0
	sub 040h		;9ef2
L_9EF4:
	sub 008h		;9ef4
	cp 030h		;9ef6
	ret nc			;9ef8
	jp 06774h		;9ef9
L_9EFC:
	ld a,(ix+00ah)		;9efc
	or a			;9eff
	ld hl,09f18h		;9f00
	jp p,L_9F08		;9f03
	inc hl			;9f06
	inc hl			;9f07
L_9F08:
	bit 0,(ix+027h)		;9f08
	jr z,L_9F12		;9f0c
	ld bc,00004h		;9f0e
	add hl,bc			;9f11
L_9F12:
	ld bc,00302h		;9f12
	jp 06361h		;9f15

; ----------------------------------------------------------------------
; DATOS tabla_9F18: 4 pares que p02:9EFC lee (0x9F18 o 0x9F1A segun IX+0A, y
;   el bit 0 de IX+27); lo leen p02:9F00 (8 bytes)
;   0x9f18..0x9f20  (8 bytes)
DATA_tabla_9F18:
	defb 098h,09ch	; 9f18
	defb 074h,078h	; 9f1a
	defb 08ch,090h	; 9f1c
	defb 080h,084h	; 9f1e

; ======================================================================
; CODIGO 0x9f20..0x9fcd  (173 bytes)
; ======================================================================


L_9F20:
	bit 0,(ix+027h)		;9f20
	jr z,L_9F36		;9f24
	ld b,094h		;9f26
	ld a,(0e406h)		;9f28
	cp (ix+006h)		;9f2b
	jr nc,L_9F32		;9f2e
	ld b,088h		;9f30
L_9F32:
	ld (ix+030h),b		;9f32
	ret			;9f35
L_9F36:
	ld b,0a0h		;9f36
	ld a,(0e406h)		;9f38
	cp (ix+006h)		;9f3b
	jr nc,L_9F42		;9f3e
	ld b,07ch		;9f40
L_9F42:
	ld (ix+030h),b		;9f42
	ret			;9f45
L_9F46:
	ld a,(0e201h)		;9f46
	or a			;9f49
	ret nz			;9f4a
	ld l,(ix+004h)		;9f4b
	ld h,(ix+006h)		;9f4e
	call 05c92h		;9f51
	ld (0f000h),hl		;9f54
	ld (0f002h),hl		;9f57
	ld de,002c3h		;9f5a
	ld bc,00020h		;9f5d
	call L_9F6C		;9f60
	ret c			;9f63
	ld hl,(0f000h)		;9f64
	ld a,l			;9f67
	and 01fh		;9f68
	ret z			;9f6a
	inc hl			;9f6b
L_9F6C:
	ld a,(hl)			;9f6c
	sub e			;9f6d
	cp d			;9f6e
	ret nc			;9f6f
	add hl,bc			;9f70
	ld a,(hl)			;9f71
	sub e			;9f72
	cp d			;9f73
	ret			;9f74
L_9F75:
	ld a,(0e201h)		;9f75
	or a			;9f78
	ret nz			;9f79
	ld a,(0e320h)		;9f7a
	or a			;9f7d
	ret nz			;9f7e
	ld a,(0e305h)		;9f7f
	ld c,a			;9f82
	ld hl,(0f002h)		;9f83
	call L_9F98		;9f86
	ret nc			;9f89
	inc hl			;9f8a
	call L_9F98		;9f8b
	ret nc			;9f8e
	ld de,0001fh		;9f8f
	add hl,de			;9f92
	call L_9F98		;9f93
	ret nc			;9f96
	inc hl			;9f97
L_9F98:
	ld a,(hl)			;9f98
	or a			;9f99
	ret z			;9f9a
	cp c			;9f9b
	ret			;9f9c
L_9F9D:
	ld a,r		;9f9d
	and 007h		;9f9f
	add a,a			;9fa1
	ld hl,09fcdh		;9fa2
	call 04b67h		;9fa5
	ld a,(ix+004h)		;9fa8
	or a			;9fab
	call m,05cadh		;9fac
	call 04efbh		;9faf
	inc hl			;9fb2
	ld e,(hl)			;9fb3
	inc hl			;9fb4
	ld d,(hl)			;9fb5
	ld a,r		;9fb6
	and 001h		;9fb8
	call nz,05cadh		;9fba
	call 04f02h		;9fbd
	ld de,00088h		;9fc0
	ld a,(ix+004h)		;9fc3
	or a			;9fc6
	call p,05cadh		;9fc7
	jp 062a8h		;9fca

; ----------------------------------------------------------------------
; DATOS tabla_9FCD: 8 fichas de 4 bytes que p02:9F9D elige al azar (ld a,r &
;   7) con L_4B67; lo leen p02:9FA5 (32 bytes)
;   0x9fcd..0x9fed  (32 bytes)
DATA_tabla_9FCD:
	defb 000h,00bh,080h,001h	; 9fcd
	defb 080h,00ah,000h,002h	; 9fd1
	defb 080h,00bh,000h,004h	; 9fd5
	defb 000h,00ah,090h,001h	; 9fd9
	defb 080h,00ah,0b0h,001h	; 9fdd
	defb 040h,00bh,000h,003h	; 9fe1
	defb 070h,00ah,080h,002h	; 9fe5
	defb 060h,00ah,040h,002h	; 9fe9

; ======================================================================
; CODIGO 0x9fed..0x9ffe  (17 bytes)
; ======================================================================


L_9FED:
	call 062c2h		;9fed
	call 0a002h		;9ff0
	ld a,(0e1c3h)		;9ff3
	and 003h		;9ff6
	ret nz			;9ff8
	ld a,(ix+030h)		;9ff9
	xor 004h		;9ffc

; ----------------------------------------------------------------------
; DATOS partida_9FFE: `ld (ix+d),a` (DD 77), que acaba en el banco 3: el
;   desplazamiento (0x30) es el primer byte de p03:A000, y el codigo sigue en
;   p03:A001; lo leen p02:9FFE (2 bytes)
;   0x9ffe..0xa000  (2 bytes)
DATA_partida_9FFE:
	defb 0ddh,077h	; 9ffe

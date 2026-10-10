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


L_A000:
	ld a,(0e1d7h)		;a000
	dec a			;a003
	call 04084h		;a004

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


L_A045:
	ld de,002dbh		;a045
	call 05d89h		;a048
	jp c,L_A7A2		;a04b
L_A04E:
	call L_A056		;a04e
L_A051:
	ld hl,0e1d7h		;a051
	inc (hl)			;a054
	ret			;a055
L_A056:
	ld hl,00008h		;a056
	ld c,003h		;a059
L_A05B:
	xor a			;a05b
	ld b,0feh		;a05c
L_A05E:
	jp L_A717		;a05e
L_A061:
	ld hl,01008h		;a061
	ld c,001h		;a064
	jr L_A05B		;a066
L_A068:
	ld hl,00008h		;a068
	jr L_A080		;a06b
L_A06D:
	ld c,002h		;a06d
	ld hl,00980h		;a06f
	ld b,0d0h		;a072
	jr L_A084		;a074
L_A076:
	ld c,003h		;a076
	ld hl,00008h		;a078
	jr L_A082		;a07b
L_A07D:
	ld hl,01008h		;a07d
L_A080:
	ld c,001h		;a080
L_A082:
	ld b,0feh		;a082
L_A084:
	ld a,003h		;a084
	jr L_A05E		;a086
L_A088:
	call L_A7A2		;a088
	ld a,(0e490h)		;a08b
	and a			;a08e
	ret nz			;a08f
L_A090:
	call 04a10h		;a090
	call 05e14h		;a093
	call 069ceh		;a096
	ld de,03843h		;a099
	ld hl,0acabh		;a09c
	ld c,01bh		;a09f
	call L_A67B		;a0a1
	call L_A07D		;a0a4
	ld a,(0002bh)		;a0a7
	and 00fh		;a0aa
	ld de,0a933h		;a0ac
	jr z,L_A0B4		;a0af
	ld de,0b151h		;a0b1
L_A0B4:
	call 04a6bh		;a0b4
	jr L_A051		;a0b7
L_A0B9:
	ld de,004bbh		;a0b9
	call 05d89h		;a0bc
	jp nc,L_A04E		;a0bf
	jp L_A7A2		;a0c2
L_A0C5:
	call L_A7A2		;a0c5
	ld a,(0e490h)		;a0c8
	and a			;a0cb
	ret nz			;a0cc
	ld (0e496h),a		;a0cd
	call 04a10h		;a0d0
	call 05e14h		;a0d3
	call 069f8h		;a0d6
	ld de,03866h		;a0d9
	ld hl,0adbdh		;a0dc
	ld c,015h		;a0df
	call L_A67B		;a0e1
	call L_A07D		;a0e4
	ld a,(0002bh)		;a0e7
	and 00fh		;a0ea
	ld de,0a981h		;a0ec
	jr z,L_A0F4		;a0ef
	ld de,0b1aah		;a0f1
L_A0F4:
	call 04a6bh		;a0f4
L_A0F7:
	jp L_A051		;a0f7
L_A0FA:
	ld de,006d7h		;a0fa
	call 05d89h		;a0fd
	jp nc,L_A04E		;a100
	call L_A7A2		;a103
	ld a,(0e1c3h)		;a106
	and 007h		;a109
	ret nz			;a10b
	ld a,(0e496h)		;a10c
	xor 001h		;a10f
	ld (0e496h),a		;a111
	ld hl,0b0abh		;a114
	jr z,L_A11C		;a117
	ld hl,0b0b1h		;a119
L_A11C:
	ld c,004h		;a11c
	ld de,038ech		;a11e
	jp L_A67B		;a121
L_A124:
	call L_A7A2		;a124
	ld a,(0e490h)		;a127
	and a			;a12a
	ret nz			;a12b
	call 04a10h		;a12c
	call 05e14h		;a12f
	call 06a0fh		;a132
	ld de,0382eh		;a135
	ld hl,0ae67h		;a138
	ld c,00eh		;a13b
	call L_A67B		;a13d
	ld de,03902h		;a140
	ld hl,0ae96h		;a143
	ld c,008h		;a146
	call L_A67B		;a148
	ld de,0394ah		;a14b
	ld hl,0aea8h		;a14e
	ld c,006h		;a151
	call L_A67B		;a153
	call L_A07D		;a156
	ld a,(0002bh)		;a159
	and 00fh		;a15c
	ld de,0a9cdh		;a15e
	jr z,L_A166		;a161
	ld de,0b214h		;a163
L_A166:
	call 04a6bh		;a166
L_A169:
	jr L_A0F7		;a169
L_A16B:
	ld de,008b7h		;a16b
	call 05d89h		;a16e
	jp c,L_A7A2		;a171
	jp L_A04E		;a174
L_A177:
	call L_A7A2		;a177
	ld a,(0e490h)		;a17a
	and a			;a17d
	ret nz			;a17e
	call 04a10h		;a17f
	call 05e14h		;a182
	call 06a1bh		;a185
	ld de,03801h		;a188
	ld hl,0afe6h		;a18b
	ld c,01fh		;a18e
	call L_A67B		;a190
	call L_A07D		;a193
	ld a,(0002bh)		;a196
	and 00fh		;a199
	ld de,0aa0fh		;a19b
	jr z,L_A1A3		;a19e
	ld de,0b24eh		;a1a0
L_A1A3:
	call 04a6bh		;a1a3
	jr L_A169		;a1a6
L_A1A8:
	ld de,00a5bh		;a1a8
	call 05d89h		;a1ab
	jp nc,L_A04E		;a1ae
	jp L_A7A2		;a1b1
L_A1B4:
	call L_A7A2		;a1b4
	ld a,(0e490h)		;a1b7
	and a			;a1ba
	ret nz			;a1bb
	call 04a10h		;a1bc
	call 05e14h		;a1bf
	ld de,0ab29h		;a1c2
	call L_A245		;a1c5
	ld a,(0002bh)		;a1c8
	and 00fh		;a1cb
	call nz,L_A2AA		;a1cd
	call L_A432		;a1d0
	call L_A06D		;a1d3
	ld a,(0002bh)		;a1d6
	and 00fh		;a1d9
	ld de,0aa50h		;a1db
	jr z,L_A1E3		;a1de
	ld de,0b29eh		;a1e0
L_A1E3:
	call 04a6bh		;a1e3
L_A1E6:
	jr L_A169		;a1e6
L_A1E8:
	ld de,00bc3h		;a1e8
	call 05d89h		;a1eb
	jp nc,L_A04E		;a1ee
	call L_A7A2		;a1f1
	ld a,(0e1c3h)		;a1f4
	bit 3,a		;a1f7
	jp nz,L_A441		;a1f9
	ld de,038ach		;a1fc
	ld hl,0afe3h		;a1ff
	ld c,009h		;a202
	jp L_A67B		;a204
L_A207:
	call L_A7A2		;a207
	ld a,(0e490h)		;a20a
	and a			;a20d
	ret nz			;a20e
	call 04a10h		;a20f
	call 05e14h		;a212
	ld a,(0002bh)		;a215
	and 00fh		;a218
	push af			;a21a
	call z,L_A242		;a21b
	pop af			;a21e
	call nz,L_A2AA		;a21f
	call 069f8h		;a222
	ld a,001h		;a225
	ld hl,01008h		;a227
	ld b,05fh		;a22a
	ld c,a			;a22c
	call L_A717		;a22d
	ld a,(0002bh)		;a230
	and 00fh		;a233
	ld de,0aab4h		;a235
	jr z,L_A23D		;a238
	ld de,0b332h		;a23a
L_A23D:
	call 04a6bh		;a23d
L_A240:
	jr L_A1E6		;a240
L_A242:
	ld de,0ab02h		;a242
L_A245:
	ld hl,02800h		;a245
	ld a,001h		;a248
	ld b,002h		;a24a
L_A24C:
	ld (0e498h),a		;a24c
	ld (0e49ah),hl		;a24f
	ld a,b			;a252
	ld (0e49dh),a		;a253
L_A256:
	ld a,(de)			;a256
	or a			;a257
	ret z			;a258
	push de			;a259
	call L_A29E		;a25a
	ld de,0e500h		;a25d
	ld bc,00008h		;a260
	call 00059h		;a263   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop de			;a266
	inc de			;a267
	ld a,(de)			;a268
	push de			;a269
	push de			;a26a
	call L_A29E		;a26b
	ld de,0e500h		;a26e
	ld bc,00008h		;a271
	exx			;a274
	ld a,(0e49dh)		;a275
	ld b,a			;a278
	call 04a3ah		;a279
	pop de			;a27c
	ld a,(de)			;a27d
	call L_A29E		;a27e
	ld a,(0e498h)		;a281
	bit 0,a		;a284
	jr z,L_A29A		;a286
	xor a			;a288
	ld de,02000h		;a289
	sbc hl,de		;a28c
	ld bc,00008h		;a28e
	ld a,(0e49dh)		;a291
	ld d,a			;a294
	ld a,0f0h		;a295
	call 04a4ch		;a297
L_A29A:
	pop de			;a29a
	inc de			;a29b
	jr L_A256		;a29c
L_A29E:
	ld h,000h		;a29e
	ld l,a			;a2a0
	add hl,hl			;a2a1
	add hl,hl			;a2a2
	add hl,hl			;a2a3
	ld de,(0e49ah)		;a2a4
	add hl,de			;a2a8
	ret			;a2a9
L_A2AA:
	ld hl,03008h		;a2aa
	ld de,0e500h		;a2ad
	ld bc,00128h		;a2b0
	call 00059h		;a2b3   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,0e500h		;a2b6
	ld hl,02b08h		;a2b9
	ld bc,00128h		;a2bc
	exx			;a2bf
	ld b,002h		;a2c0
	jp 04a3ah		;a2c2
L_A2C5:
	call L_A7A2		;a2c5
	ld a,(0e490h)		;a2c8
	and a			;a2cb
	ret nz			;a2cc
	ld de,00c77h		;a2cd
	call 05d89h		;a2d0
	ret c			;a2d3
	xor a			;a2d4
	ld (0e496h),a		;a2d5
	ld hl,0ed00h		;a2d8
	ld de,0aebdh		;a2db
	call L_A6EB		;a2de
	jp L_A240		;a2e1
L_A2E4:
	call L_A671		;a2e4
	ld a,(0e496h)		;a2e7
	ld de,0a352h		;a2ea
	call 0407fh		;a2ed
	ld a,(de)			;a2f0
	call L_A319		;a2f1
	ld b,002h		;a2f4
L_A2F6:
	ld c,017h		;a2f6
L_A2F8:
	ld a,c			;a2f8
	ld (0e497h),a		;a2f9
L_A2FC:
	ld a,(0e497h)		;a2fc
	ld c,a			;a2ff
	xor a			;a300
	ld (0f000h),a		;a301
	push hl			;a304
	push de			;a305
	push bc			;a306
	call L_A691		;a307
	pop bc			;a30a
	pop de			;a30b
	pop hl			;a30c
	ld a,c			;a30d
	call 0407fh		;a30e
	ld a,020h		;a311
	call 0407ah		;a313
	djnz L_A2FC		;a316
	ret			;a318
L_A319:
	ld c,a			;a319
	add a,002h		;a31a
	call L_A334		;a31c
	ld de,03800h		;a31f
	add hl,de			;a322
	ld de,00005h		;a323
	add hl,de			;a326
	ex de,hl			;a327
	push de			;a328
	ld a,c			;a329
	call L_A342		;a32a
	ld de,0ed00h		;a32d
	add hl,de			;a330
	pop de			;a331
	ex de,hl			;a332
	ret			;a333
L_A334:
	ld h,000h		;a334
	ld l,a			;a336
	add hl,hl			;a337
L_A338:
	add hl,hl			;a338
	add hl,hl			;a339
	add hl,hl			;a33a
	add hl,hl			;a33b
	ret			;a33c
L_A33D:
	ld h,000h		;a33d
	ld l,a			;a33f
	jr L_A338		;a340
L_A342:
	ld h,000h		;a342
	ld l,a			;a344
	ld c,l			;a345
	ld b,h			;a346
	add hl,hl			;a347
	add hl,hl			;a348
	add hl,hl			;a349
	ld e,l			;a34a
	ld d,h			;a34b
	add hl,hl			;a34c
	add hl,de			;a34d
	and a			;a34e
	sbc hl,bc		;a34f
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


L_A35D:
	ld a,(0e1c3h)		;a35d
	and 007h		;a360
	ret nz			;a362
	ld a,(0e496h)		;a363
	inc a			;a366
	cp 006h		;a367
	jp z,L_A051		;a369
	ld (0e496h),a		;a36c
L_A36F:
	jp L_A2E4		;a36f
L_A372:
	ld de,00cefh		;a372
	jr L_A37F		;a375
L_A377:
	ld de,01c2bh		;a377
	jr L_A37F		;a37a
L_A37C:
	ld de,01f37h		;a37c
L_A37F:
	call 05d89h		;a37f
	ret c			;a382
	jp L_A04E		;a383
L_A386:
	ld a,(0e1c3h)		;a386
	and 00fh		;a389
	ret nz			;a38b
	ld a,(0e496h)		;a38c
	inc a			;a38f
	cp 00bh		;a390
	jr z,L_A399		;a392
	ld (0e496h),a		;a394
	jr L_A36F		;a397
L_A399:
	ld a,009h		;a399
	ld (0e496h),a		;a39b
	call L_A051		;a39e
L_A3A1:
	ld a,(0e496h)		;a3a1
	ld de,0b0b7h		;a3a4
	call 04b60h		;a3a7
	ex de,hl			;a3aa
	ld a,(0e496h)		;a3ab
	ld de,0b0cbh		;a3ae
	call 0407fh		;a3b1
	ld a,(de)			;a3b4
	ld b,a			;a3b5
	ld a,002h		;a3b6
	ld c,a			;a3b8
	call L_A717		;a3b9
	ld a,(0e496h)		;a3bc
	call L_A319		;a3bf
	ld b,001h		;a3c2
	jp L_A2F6		;a3c4
L_A3C7:
	ld a,(0e1c3h)		;a3c7
	and 003h		;a3ca
	ret nz			;a3cc
	call L_A7A2		;a3cd
	ld a,(0e490h)		;a3d0
	and a			;a3d3
	ret nz			;a3d4
	ld a,(0e496h)		;a3d5
	dec a			;a3d8
	jp m,L_A3E1		;a3d9
	ld (0e496h),a		;a3dc
	jr L_A3A1		;a3df
L_A3E1:
	ld a,001h		;a3e1
	ld hl,01300h		;a3e3
	ld b,09ch		;a3e6
	ld c,a			;a3e8
	call L_A717		;a3e9
	ld a,(0002bh)		;a3ec
	and 00fh		;a3ef
	ld de,0aad9h		;a3f1
	jr z,L_A3F9		;a3f4
	ld de,0b34eh		;a3f6
L_A3F9:
	call 04a6bh		;a3f9
	jp L_A051		;a3fc
L_A3FF:
	ld de,00fbfh		;a3ff
	call 05d89h		;a402
	jp nc,L_A04E		;a405
	jp L_A7A2		;a408
L_A40B:
	call L_A7A2		;a40b
	ld a,(0e490h)		;a40e
	and a			;a411
	ret nz			;a412
	call 04a10h		;a413
	call 05e14h		;a416
	call L_A432		;a419
	call L_A07D		;a41c
	ld a,(0002bh)		;a41f
	and 00fh		;a422
	ld de,0ab2eh		;a424
	jr z,L_A42C		;a427
	ld de,0b39fh		;a429
L_A42C:
	call 04a6bh		;a42c
L_A42F:
	jp L_A051		;a42f
L_A432:
	call 05ea3h		;a432
L_A435:
	ld hl,00170h		;a435
	xor a			;a438
	ld bc,00008h		;a439
	ld d,002h		;a43c
	call 04a4ch		;a43e
L_A441:
	ld hl,0af6dh		;a441
	ld de,03885h		;a444
	ld c,017h		;a447
	jp L_A67B		;a449
L_A44C:
	call L_A7A2		;a44c
	ld a,(0e490h)		;a44f
	and a			;a452
	ret nz			;a453
	xor a			;a454
	ld (0e496h),a		;a455
	jr L_A42F		;a458
L_A45A:
	ld de,0128fh		;a45a
	call 05d89h		;a45d
	jp nc,L_A515		;a460
	ld a,(0e1c3h)		;a463
	and 007h		;a466
	ret nz			;a468
	call L_A474		;a469
	cp 00ch		;a46c
	ret z			;a46e
	inc a			;a46f
L_A470:
	ld (0e496h),a		;a470
	ret			;a473
L_A474:
	call L_A4DF		;a474
	call L_A4A2		;a477
	ld a,(0e496h)		;a47a
	cp 003h		;a47d
	push af			;a47f
	call nc,L_A4B4		;a480
	pop af			;a483
	ret			;a484
L_A485:
	call L_A490		;a485
L_A488:
	call L_A4A2		;a488
	call L_A4B4		;a48b
	jr L_A4C3		;a48e
L_A490:
	ld a,(0e1c3h)		;a490
	and 007h		;a493
	ret nz			;a495
	call L_A4DF		;a496
	ld a,(0e496h)		;a499
	inc a			;a49c
	cp 01eh		;a49d
	ret z			;a49f
	jr L_A470		;a4a0
L_A4A2:
	call L_A4D7		;a4a2
	ld de,03925h		;a4a5
	bit 0,a		;a4a8
	jr z,L_A4D2		;a4aa
L_A4AC:
	ld hl,0b13bh		;a4ac
L_A4AF:
	ld c,005h		;a4af
	jp L_A67B		;a4b1
L_A4B4:
	call L_A4D7		;a4b4
	ld de,0398ah		;a4b7
	bit 0,a		;a4ba
	jr z,L_A4D2		;a4bc
L_A4BE:
	ld hl,0b142h		;a4be
	jr L_A4AF		;a4c1
L_A4C3:
	call L_A4D7		;a4c3
	ld de,038d8h		;a4c6
	bit 0,a		;a4c9
	jr z,L_A4D2		;a4cb
L_A4CD:
	ld hl,0b148h		;a4cd
	jr L_A4AF		;a4d0
L_A4D2:
	ld hl,0b14eh		;a4d2
	jr L_A4AF		;a4d5
L_A4D7:
	ld a,(0e1c3h)		;a4d7
	rrca			;a4da
	rrca			;a4db
	rrca			;a4dc
	rrca			;a4dd
	ret			;a4de
L_A4DF:
	ld de,0b0e1h		;a4df
	ld a,(0e496h)		;a4e2
	ld c,a			;a4e5
	add a,a			;a4e6
	add a,c			;a4e7
	call 0407fh		;a4e8
	ld a,(de)			;a4eb
	ld b,a			;a4ec
	inc de			;a4ed
	ld a,(de)			;a4ee
	ld c,a			;a4ef
	inc de			;a4f0
	ld a,(de)			;a4f1
	call L_A334		;a4f2
	ld e,c			;a4f5
	ld d,000h		;a4f6
	add hl,de			;a4f8
	ld de,03800h		;a4f9
	add hl,de			;a4fc
	ld a,b			;a4fd
	ld bc,00001h		;a4fe
	jp 00056h		;a501   ; BIOS FILVRM - Fills VRAM with value
L_A504:
	ld de,03925h		;a504
	call L_A4AC		;a507
	ld de,0398ah		;a50a
	call L_A4BE		;a50d
	ld de,038d8h		;a510
	jr L_A4CD		;a513
L_A515:
	ld a,(0002bh)		;a515
	and 00fh		;a518
	jp nz,L_A051		;a51a
	ld de,0ab72h		;a51d
L_A520:
	call L_A5A4		;a520
	push de			;a523
	call L_A07D		;a524
	pop de			;a527
	call 04a6bh		;a528
	jp L_A051		;a52b
L_A52E:
	ld de,014abh		;a52e
	call 05d89h		;a531
	jr nc,L_A53C		;a534
	call L_A7A2		;a536
	jp L_A485		;a539
L_A53C:
	call L_A504		;a53c
	ld a,(0002bh)		;a53f
	and 00fh		;a542
	jp nz,L_A051		;a544
	ld de,0abd1h		;a547
	jr L_A520		;a54a
L_A54C:
	ld de,017f3h		;a54c
	call 05d89h		;a54f
	jp nc,L_A04E		;a552
	jp L_A7A2		;a555
L_A558:
	call 04a10h		;a558
	call 05e14h		;a55b
	call L_BFC1		;a55e
L_A561:
	ld hl,0b586h		;a561
	ld de,03906h		;a564
	ld c,014h		;a567
	call L_A67B		;a569
	jp L_A07D		;a56c
L_A56F:
	call 04a10h		;a56f
	call 05e0ch		;a572
	call L_BFCA		;a575
	jr L_A561		;a578
L_A57A:
	call L_A7A2		;a57a
	ld a,(0e490h)		;a57d
	and a			;a580
	ret nz			;a581
	call L_A558		;a582
	ld de,0ac19h		;a585
	ld a,(0002bh)		;a588
	and 00fh		;a58b
	jr z,L_A592		;a58d
	ld de,0b3f0h		;a58f
L_A592:
	call 04a6bh		;a592
	jp L_A051		;a595
L_A598:
	ld de,01ca3h		;a598
	call 05d89h		;a59b
	jp nc,L_A04E		;a59e
	jp L_A7A2		;a5a1
L_A5A4:
	ld bc,00100h		;a5a4
	ld hl,03a00h		;a5a7
	xor a			;a5aa
	jp 00056h		;a5ab   ; BIOS FILVRM - Fills VRAM with value
L_A5AE:
	call L_A7A2		;a5ae
	ld a,(0e490h)		;a5b1
	and a			;a5b4
	ret nz			;a5b5
	call 04a10h		;a5b6
	call 05e14h		;a5b9
	call 05ed7h		;a5bc
	xor a			;a5bf
	ld (0e496h),a		;a5c0
	call L_A051		;a5c3
	ld hl,0ed00h		;a5c6
	ld de,0b06fh		;a5c9
	call L_A6EB		;a5cc
L_A5CF:
	ld hl,0b0d5h		;a5cf
	ld (0f000h),hl		;a5d2
	ld hl,00809h		;a5d5
	ld (0f002h),hl		;a5d8
	ld hl,00201h		;a5db
	ld (0f004h),hl		;a5de
	ld hl,0b0dbh		;a5e1
	ld (0f006h),hl		;a5e4
	ld a,008h		;a5e7
	ld (0f008h),a		;a5e9
	jp L_B685		;a5ec
L_A5EF:
	ld a,(0e1c3h)		;a5ef
	and 003h		;a5f2
	ret nz			;a5f4
	call L_A7A2		;a5f5
	call L_A863		;a5f8
	ld a,(0e490h)		;a5fb
	ld hl,0e498h		;a5fe
	or (hl)			;a601
	ret nz			;a602
	ld a,(0e496h)		;a603
	inc a			;a606
	cp 002h		;a607
	jr z,L_A611		;a609
	ld (0e496h),a		;a60b
	jp L_A5CF		;a60e
L_A611:
	call L_A07D		;a611
	ld a,(0002bh)		;a614
	and 00fh		;a617
	ld de,0ac70h		;a619
	jr z,L_A621		;a61c
	ld de,0b41dh		;a61e
L_A621:
	call 04a6bh		;a621
	jp L_A051		;a624
L_A627:
	ld de,01febh		;a627
	call 05d89h		;a62a
	jp c,L_A7A2		;a62d
	jp L_A04E		;a630
L_A633:
	call L_A7A2		;a633
	ld a,(0e490h)		;a636
	and a			;a639
	ret nz			;a63a
	call 04a10h		;a63b
	xor a			;a63e
	ld (0e1d7h),a		;a63f
	ret			;a642
L_A643:
	ld a,03fh		;a643
	call 04ae4h		;a645
	ld hl,00000h		;a648
	ld (0f0f7h),hl		;a64b
	ld a,(0002bh)		;a64e
	and 00fh		;a651
	jr nz,L_A669		;a653
	ld a,001h		;a655
	ld (0e1d7h),a		;a657
	call 04a10h		;a65a
	call 05e14h		;a65d
	call L_A076		;a660
	ld de,0a8b9h		;a663
	jp 04a6bh		;a666
L_A669:
	ld a,002h		;a669
	ld (0e1d7h),a		;a66b
	jp L_A090		;a66e
L_A671:
	ld hl,03800h		;a671
	ld bc,00200h		;a674
	xor a			;a677
	jp 00056h		;a678   ; BIOS FILVRM - Fills VRAM with value
L_A67B:
	ld a,c			;a67b
	ld (0f000h),a		;a67c
	ex de,hl			;a67f
	ld (0f001h),hl		;a680
L_A683:
	ld a,(de)			;a683
	inc de			;a684
	ld b,a			;a685
	and a			;a686
	ret z			;a687
	jp p,L_A6A8		;a688
	res 7,b		;a68b
	cp 080h		;a68d
	jr z,L_A6D2		;a68f
L_A691:
	ld a,(de)			;a691
	and a			;a692
	inc de			;a693
	call nz,0004dh		;a694   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a697
	dec c			;a698
	call z,L_A6B7		;a699
	ld a,(0f000h)		;a69c
	and a			;a69f
	jr z,L_A691		;a6a0
	inc a			;a6a2
	ret z			;a6a3
	djnz L_A691		;a6a4
	jr L_A683		;a6a6
L_A6A8:
	ld a,(de)			;a6a8
	and a			;a6a9
	call nz,0004dh		;a6aa   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a6ad
	dec c			;a6ae
	call z,L_A6B7		;a6af
	djnz L_A6A8		;a6b2
L_A6B4:
	inc de			;a6b4
	jr L_A683		;a6b5
L_A6B7:
	push af			;a6b7
	ld hl,(0f001h)		;a6b8
	ld a,020h		;a6bb
	call 0407ah		;a6bd
	ld (0f001h),hl		;a6c0
	ld a,(0f000h)		;a6c3
	and a			;a6c6
	jr z,L_A6CC		;a6c7
	ld c,a			;a6c9
	pop af			;a6ca
	ret			;a6cb
L_A6CC:
	pop af			;a6cc
	ld hl,0f000h		;a6cd
	dec (hl)			;a6d0
	ret			;a6d1
L_A6D2:
	ld a,(de)			;a6d2
	ld b,a			;a6d3
	inc de			;a6d4
	ld a,(de)			;a6d5
	exx			;a6d6
	ld d,a			;a6d7
	exx			;a6d8
L_A6D9:
	and a			;a6d9
	call nz,0004dh		;a6da   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a6dd
	dec c			;a6de
	call z,L_A6B7		;a6df
	exx			;a6e2
	ld a,d			;a6e3
	inc a			;a6e4
	ld d,a			;a6e5
	exx			;a6e6
	djnz L_A6D9		;a6e7
	jr L_A6B4		;a6e9
L_A6EB:
	ld a,(de)			;a6eb
	inc de			;a6ec
	and a			;a6ed
	ret z			;a6ee
	cp 080h		;a6ef
	jr z,L_A70A		;a6f1
	ld b,a			;a6f3
	and 07fh		;a6f4
	cp b			;a6f6
	jr z,L_A702		;a6f7
	ld b,a			;a6f9
L_A6FA:
	ld a,(de)			;a6fa
	inc de			;a6fb
	ld (hl),a			;a6fc
	inc hl			;a6fd
	djnz L_A6FA		;a6fe
	jr L_A6EB		;a700
L_A702:
	ld a,(de)			;a702
	inc de			;a703
L_A704:
	ld (hl),a			;a704
	inc hl			;a705
	djnz L_A704		;a706
	jr L_A6EB		;a708
L_A70A:
	ld a,(de)			;a70a
	ld b,a			;a70b
	inc de			;a70c
	ld a,(de)			;a70d
	inc de			;a70e
	ld c,a			;a70f
L_A710:
	ld (hl),c			;a710
	inc c			;a711
	inc hl			;a712
	djnz L_A710		;a713
	jr L_A6EB		;a715
L_A717:
	ld (0e495h),a		;a717
	ld a,b			;a71a
	ld (0e494h),a		;a71b
	ld a,c			;a71e
	ld (0e4a0h),a		;a71f
	ld (0e492h),hl		;a722
	xor a			;a725
	ld (0e491h),a		;a726
	inc a			;a729
	ld (0e490h),a		;a72a
	ld a,(0e495h)		;a72d
	call 04084h		;a730

; ----------------------------------------------------------------------
; DATOS tabla_A733: 4 destinos del despachador p00:4084 (call en p10:A730, el
;   indice en A): A78E, A78F, A799, A78F; lo leen p10:A730 (8 bytes)
;   0xa733..0xa73b  (8 bytes)
DATA_tabla_A733:
	defw 0a78eh,0a78fh,0a799h,0a78fh	; a733  -> L_A78E L_A78F L_A799 L_A78F

; ======================================================================
; CODIGO 0xa73b..0xa7ad  (114 bytes)
; ======================================================================


L_A73B:
	ld a,b			;a73b
	ld (0e49ch),a		;a73c
	ld (0e49ah),hl		;a73f
	xor a			;a742
	ld (0e499h),a		;a743
	inc a			;a746
	ld (0e498h),a		;a747
	jp L_A794		;a74a
L_A74D:
	call L_A765		;a74d
	ld hl,(0e492h)		;a750
	ld a,(0e4a0h)		;a753
	ld d,a			;a756
L_A757:
	xor a			;a757
	jp 04a4ch		;a758
L_A75B:
	call L_A771		;a75b
	ld hl,(0e49ah)		;a75e
	ld d,002h		;a761
	jr L_A757		;a763
L_A765:
	ld a,(0e494h)		;a765
L_A768:
	ld l,a			;a768
	ld h,000h		;a769
	add hl,hl			;a76b
	add hl,hl			;a76c
	add hl,hl			;a76d
	ld c,l			;a76e
	ld b,h			;a76f
	ret			;a770
L_A771:
	ld a,(0e49ch)		;a771
	jr L_A768		;a774
L_A776:
	call L_A765		;a776
	ld hl,(0e492h)		;a779
	ld de,0e500h		;a77c
	jp 00059h		;a77f   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_A782:
	call L_A771		;a782
	ld hl,(0e49ah)		;a785
	ld de,0e800h		;a788
	jp 00059h		;a78b   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_A78E:
	ret			;a78e
L_A78F:
	call L_A776		;a78f
	jr L_A74D		;a792
L_A794:
	call L_A782		;a794
	jr L_A75B		;a797
L_A799:
	call L_A78F		;a799
	ld a,007h		;a79c
	ld (0e491h),a		;a79e
	ret			;a7a1
L_A7A2:
	ld a,(0e490h)		;a7a2
	and a			;a7a5
	ret z			;a7a6
	ld a,(0e495h)		;a7a7
	call 04084h		;a7aa

; ----------------------------------------------------------------------
; DATOS tabla_A7AD: 4 destinos del despachador p00:4084 (call en p10:A7AA, el
;   indice en A): A7B5, A7EA, A81D, A7EA; lo leen p10:A7AA (8 bytes)
;   0xa7ad..0xa7b5  (8 bytes)
DATA_tabla_A7AD:
	defw 0a7b5h,0a7eah,0a81dh,0a7eah	; a7ad  -> L_A7B5 L_A7EA L_A81D L_A7EA

; ======================================================================
; CODIGO 0xa7b5..0xa8b9  (260 bytes)
; ======================================================================


L_A7B5:
	ld hl,(0e492h)		;a7b5
	ld a,(0e494h)		;a7b8
	ld b,a			;a7bb
L_A7BC:
	push hl			;a7bc
	push bc			;a7bd
	ld a,(0e491h)		;a7be
	and 007h		;a7c1
	call 0407ah		;a7c3
	ld bc,00001h		;a7c6
	ld a,(0e4a0h)		;a7c9
	ld d,a			;a7cc
	xor a			;a7cd
	call 04a4ch		;a7ce
	pop bc			;a7d1
	ld de,00008h		;a7d2
	pop hl			;a7d5
	add hl,de			;a7d6
	djnz L_A7BC		;a7d7
	ld a,(0e491h)		;a7d9
	inc a			;a7dc
	cp 008h		;a7dd
	jr z,L_A7E5		;a7df
	ld (0e491h),a		;a7e1
	ret			;a7e4
L_A7E5:
	xor a			;a7e5
	ld (0e490h),a		;a7e6
	ret			;a7e9
L_A7EA:
	ld hl,(0e492h)		;a7ea
	ld a,(0e494h)		;a7ed
	ld b,a			;a7f0
	ld de,0e500h		;a7f1
L_A7F4:
	push bc			;a7f4
	push de			;a7f5
	push hl			;a7f6
	ld a,(0e491h)		;a7f7
	call L_A855		;a7fa
	exx			;a7fd
	ld a,(0e4a0h)		;a7fe
	ld b,a			;a801
	call 04a3ah		;a802
	ld bc,00008h		;a805
	pop hl			;a808
	add hl,bc			;a809
	pop de			;a80a
	ex de,hl			;a80b
	add hl,bc			;a80c
	ex de,hl			;a80d
	pop bc			;a80e
	djnz L_A7F4		;a80f
	ld a,(0e491h)		;a811
	inc a			;a814
	cp 008h		;a815
	jr z,L_A7E5		;a817
	ld (0e491h),a		;a819
	ret			;a81c
L_A81D:
	ld hl,(0e492h)		;a81d
	ld a,(0e494h)		;a820
	ld b,a			;a823
	ld de,0e500h		;a824
	ld a,(0e491h)		;a827
	call L_A838		;a82a
	ld a,(0e491h)		;a82d
	dec a			;a830
	jp m,L_A7E5		;a831
	ld (0e491h),a		;a834
	ret			;a837
L_A838:
	push af			;a838
	push bc			;a839
	push hl			;a83a
	push de			;a83b
	call L_A855		;a83c
	exx			;a83f
	ld b,002h		;a840
	call 04a3ah		;a842
	ld bc,00008h		;a845
	pop hl			;a848
	add hl,bc			;a849
	ex de,hl			;a84a
	pop hl			;a84b
	add hl,bc			;a84c
	pop bc			;a84d
	pop af			;a84e
	djnz L_A838		;a84f
	ld a,(0e491h)		;a851
	ret			;a854
L_A855:
	and 007h		;a855
	ld c,a			;a857
	call 0407ah		;a858
	ld a,c			;a85b
	call 0407fh		;a85c
	ld bc,00001h		;a85f
	ret			;a862
L_A863:
	ld a,(0e498h)		;a863
	and a			;a866
	ret z			;a867
	ld hl,(0e49ah)		;a868
	ld a,(0e49ch)		;a86b
	ld b,a			;a86e
	ld de,0e800h		;a86f
	ld a,(0e499h)		;a872
	call L_A838		;a875
	ld a,(0e499h)		;a878
	inc a			;a87b
	cp 008h		;a87c
	jr z,L_A884		;a87e
	ld (0e499h),a		;a880
	ret			;a883
L_A884:
	xor a			;a884
	ld (0e498h),a		;a885
	ret			;a888
L_A889:
	ld bc,00080h		;a889
	ld hl,0e280h		;a88c
	ld de,03b00h		;a88f
	jp 0005ch		;a892   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_A895:
	ld hl,0ed00h		;a895
	ld de,0ed01h		;a898
	ld bc,002ffh		;a89b
	xor a			;a89e
	ld (hl),a			;a89f
	ldir		;a8a0
	ld hl,0ed00h		;a8a2
	ld de,0efc0h		;a8a5
	ld bc,00040h		;a8a8
	ldir		;a8ab
L_A8AD:
	ld bc,00300h		;a8ad
	ld hl,03800h		;a8b0
	ld de,0ed00h		;a8b3
	jp 04a33h		;a8b6

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


L_B636:
	ld de,03843h		;b636
	call L_B641		;b639
	ld c,01ah		;b63c
	jp L_A67B		;b63e
L_B641:
	ld hl,0b832h		;b641
	ld a,(0002bh)		;b644
	and 00fh		;b647
	jr z,L_B64E		;b649
	ld hl,0b7a1h		;b64b
L_B64E:
	ret			;b64e
L_B64F:
	ld a,001h		;b64f
	ld (0e1d7h),a		;b651
	xor a			;b654
	ld (0e496h),a		;b655
	call 04c76h		;b658
	call L_A889		;b65b
	call L_B641		;b65e
	ex de,hl			;b661
	ld hl,0ed00h		;b662
	call L_A6EB		;b665
L_B668:
	ld hl,0b8e6h		;b668
	ld (0f000h),hl		;b66b
	ld hl,00307h		;b66e
	ld (0f002h),hl		;b671
	ld hl,00500h		;b674
	ld (0f004h),hl		;b677
	ld hl,0b8d7h		;b67a
	ld (0f006h),hl		;b67d
	ld a,003h		;b680
	ld (0f008h),a		;b682
L_B685:
	ld hl,(0f000h)		;b685
	call L_B700		;b688
	call L_A73B		;b68b
	ld a,(0e496h)		;b68e
	ld c,a			;b691
	ld hl,0f002h		;b692
	add a,(hl)			;b695
	call L_A334		;b696
	call L_B6F3		;b699
	push de			;b69c
	call L_B6E5		;b69d
	call L_B710		;b6a0
	add hl,de			;b6a3
	pop de			;b6a4
	call L_B6D5		;b6a5
	ld hl,(0f006h)		;b6a8
	call L_B700		;b6ab
	ld a,002h		;b6ae
	ld c,a			;b6b0
	call L_A717		;b6b1
	ld a,(0e496h)		;b6b4
	ld c,a			;b6b7
	ld a,(0f005h)		;b6b8
	dec a			;b6bb
	sub c			;b6bc
	ld c,a			;b6bd
	ld hl,0f005h		;b6be
	ld a,(0f002h)		;b6c1
	sub (hl)			;b6c4
	add a,c			;b6c5
	call L_A334		;b6c6
	call L_B6F3		;b6c9
	push de			;b6cc
	call L_B6E5		;b6cd
	ld de,0ed00h		;b6d0
	add hl,de			;b6d3
	pop de			;b6d4
L_B6D5:
	ex de,hl			;b6d5
	ld b,001h		;b6d6
	ld c,01ah		;b6d8
	ld a,(0f004h)		;b6da
	and a			;b6dd
	jr z,L_B6E2		;b6de
	ld c,010h		;b6e0
L_B6E2:
	jp L_A2F8		;b6e2
L_B6E5:
	ld a,(0f004h)		;b6e5
	and a			;b6e8
	ld a,c			;b6e9
	push af			;b6ea
	call z,L_B727		;b6eb
	pop af			;b6ee
	call nz,L_A33D		;b6ef
	ret			;b6f2
L_B6F3:
	ld de,03800h		;b6f3
	add hl,de			;b6f6
	ld a,(0f008h)		;b6f7
	ld e,a			;b6fa
	ld d,000h		;b6fb
	add hl,de			;b6fd
	ex de,hl			;b6fe
	ret			;b6ff
L_B700:
	ld a,(0e496h)		;b700
	ld c,a			;b703
	add a,a			;b704
	add a,c			;b705
	call 0407ah		;b706
	ld b,(hl)			;b709
	inc hl			;b70a
	ld e,(hl)			;b70b
	inc hl			;b70c
	ld d,(hl)			;b70d
	ex de,hl			;b70e
	ret			;b70f
L_B710:
	push hl			;b710
	ld a,(0f004h)		;b711
	and a			;b714
	ld a,(0f005h)		;b715
	push af			;b718
	call z,L_B727		;b719
	pop af			;b71c
	call nz,L_A33D		;b71d
	ld de,0ed00h		;b720
	add hl,de			;b723
	ex de,hl			;b724
	pop hl			;b725
	ret			;b726
L_B727:
	ld h,000h		;b727
	ld l,a			;b729
	add hl,hl			;b72a
	ld c,l			;b72b
	ld b,h			;b72c
	add hl,hl			;b72d
	add hl,hl			;b72e
	push hl			;b72f
	add hl,bc			;b730
	ld c,l			;b731
	ld b,h			;b732
	pop hl			;b733
	add hl,hl			;b734
	add hl,bc			;b735
	ret			;b736
L_B737:
	ld a,(0e1d7h)		;b737
	and a			;b73a
	ret z			;b73b
	dec a			;b73c
	jr nz,L_B76F		;b73d
	call L_A7A2		;b73f
	call L_A863		;b742
	ld a,(0e490h)		;b745
	ld hl,0e498h		;b748
	or (hl)			;b74b
	ret nz			;b74c
	ld a,(0e496h)		;b74d
	inc a			;b750
	cp 005h		;b751
	jr z,L_B75B		;b753
	ld (0e496h),a		;b755
	jp L_B668		;b758
L_B75B:
	ld a,001h		;b75b
	ld c,003h		;b75d
	ld b,02ch		;b75f
	ld hl,00080h		;b761
	call L_A717		;b764
	call 061c1h		;b767
	ld hl,0e1d7h		;b76a
	inc (hl)			;b76d
	ret			;b76e
L_B76F:
	call L_A7A2		;b76f
	ld a,(0e490h)		;b772
	and a			;b775
	ret nz			;b776
	xor a			;b777
	ld (0e1d7h),a		;b778
	ret			;b77b
L_B77C:
	call 04c76h		;b77c
	call L_A889		;b77f
	ld hl,0b8fch		;b782
	ld de,03b00h		;b785
	ld bc,00008h		;b788
	call 0005ch		;b78b   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,(0e1c3h)		;b78e
	bit 2,a		;b791
	jp z,L_B636		;b793
	ld de,038ech		;b796
	ld hl,0b8b7h		;b799
	ld c,008h		;b79c
	jp L_A67B		;b79e

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


L_B993:
	ld a,(0e1e6h)		;b993
	dec a			;b996
	call 04084h		;b997

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


L_B9B6:
	call L_BC19		;b9b6
	ret nz			;b9b9
	ld hl,0012ch		;b9ba
	ld (0e49eh),hl		;b9bd
	ld hl,09222h		;b9c0
	call L_B9CF		;b9c3
	ld hl,0003ch		;b9c6
	cp 005h		;b9c9
	jp z,L_BBA4		;b9cb
	ret			;b9ce
L_B9CF:
	ld a,(0e496h)		;b9cf
	call 04b67h		;b9d2
	ld a,(de)			;b9d5
	and a			;b9d6
	jp z,L_B9E5		;b9d7
	call 04a6bh		;b9da
L_B9DD:
	ld a,(0e496h)		;b9dd
	inc a			;b9e0
	ld (0e496h),a		;b9e1
	ret			;b9e4
L_B9E5:
	ld hl,00001h		;b9e5
	ld (0e49eh),hl		;b9e8
	call L_A5A4		;b9eb
	jr L_B9DD		;b9ee
L_B9F0:
	call L_BC19		;b9f0
	ret nz			;b9f3
L_B9F4:
	ld a,028h		;b9f4
	call 04ae4h		;b9f6
	call L_A5A4		;b9f9
	ld de,094c4h		;b9fc
	call 04a6bh		;b9ff
	jp L_BB9D		;ba02
L_BA05:
	call L_BA7E		;ba05
	call L_BC19		;ba08
	ret nz			;ba0b
	ld hl,0012ch		;ba0c
	ld a,(0e496h)		;ba0f
	cp 005h		;ba12
	jr nz,L_BA19		;ba14
	ld hl,00078h		;ba16
L_BA19:
	ld (0e49eh),hl		;ba19
	ld hl,09281h		;ba1c
	call L_B9CF		;ba1f
	cp 007h		;ba22
	ret nz			;ba24
	call 04a10h		;ba25
	call 05e9ah		;ba28
	call L_A07D		;ba2b
	ld de,09317h		;ba2e
	call 04a6bh		;ba31
	ld a,00eh		;ba34
	ld (0e496h),a		;ba36
	ld hl,006cch		;ba39
	jp L_BBA4		;ba3c
L_BA3F:
	call L_BC19		;ba3f
	jr z,L_BA5E		;ba42
	call L_A7A2		;ba44
	call L_A488		;ba47
	ld a,(0e1c3h)		;ba4a
	and 007h		;ba4d
	ret nz			;ba4f
	call L_A4DF		;ba50
	ld a,(0e496h)		;ba53
	inc a			;ba56
	cp 01eh		;ba57
	ret z			;ba59
	ld (0e496h),a		;ba5a
	ret			;ba5d
L_BA5E:
	call L_A5A4		;ba5e
	call L_A07D		;ba61
	ld de,09361h		;ba64
	call 04a6bh		;ba67
	ld hl,00690h		;ba6a
	jp L_BBA4		;ba6d
L_BA70:
	call L_A7A2		;ba70
	call L_A504		;ba73
	ld a,(0e490h)		;ba76
	and a			;ba79
	ret nz			;ba7a
	jp L_BAB0		;ba7b
L_BA7E:
	ld de,094c4h		;ba7e
	ld hl,0e49eh		;ba81
	bit 3,(hl)		;ba84
	jp z,04a6bh		;ba86
	jp 04a82h		;ba89
L_BA8C:
	ld de,094d1h		;ba8c
	ld a,(0e1c3h)		;ba8f
	and 07fh		;ba92
	cp 064h		;ba94
	jp c,04a6bh		;ba96
	jp 04a82h		;ba99
L_BA9C:
	ld a,(0e0a0h)		;ba9c
	and a			;ba9f
	jr z,L_BAAB		;baa0
	ld hl,0e49eh		;baa2
	dec (hl)			;baa5
	call L_BA7E		;baa6
	jr L_BA8C		;baa9
L_BAAB:
	ld a,008h		;baab
	ld (0e1e6h),a		;baad
L_BAB0:
	call 04a10h		;bab0
	jp L_BBA4		;bab3
L_BAB6:
	ld a,048h		;bab6
	ld (0e404h),a		;bab8
	ld (0e414h),a		;babb
	ld (0e424h),a		;babe
	ld a,030h		;bac1
	ld (0e406h),a		;bac3
	ld (0e416h),a		;bac6
	ld (0e426h),a		;bac9
	ret			;bacc
L_BACD:
	call 04a10h		;bacd
L_BAD0:
	call L_BAB6		;bad0
	call 05d80h		;bad3
	call L_BAE4		;bad6
	call 04c76h		;bad9
	call L_A889		;badc
	xor a			;badf
	ld (0e1e6h),a		;bae0
	ret			;bae3
L_BAE4:
	ld hl,0e500h		;bae4
	ld de,0e501h		;bae7
	ld bc,00affh		;baea
	ld (hl),000h		;baed
	ldir		;baef
	ret			;baf1
L_BAF2:
	call L_BC19		;baf2
	ret nz			;baf5
	ld hl,001e0h		;baf6
	ld (0e49eh),hl		;baf9
	call L_BB0E		;bafc
	ld hl,093b4h		;baff
	call L_B9CF		;bb02
	ld hl,0021ch		;bb05
	cp 007h		;bb08
	jp z,L_BBA4		;bb0a
	ret			;bb0d
L_BB0E:
	ld a,(0e496h)		;bb0e
	exx			;bb11
	ld e,a			;bb12
	exx			;bb13
	cp 002h		;bb14
	jp z,L_BBE0		;bb16
	call L_BB31		;bb19
	cp 004h		;bb1c
	jp z,L_BC02		;bb1e
	call L_BB31		;bb21
	cp 005h		;bb24
	jp z,L_BBE0		;bb26
	call L_BB31		;bb29
	cp 006h		;bb2c
	jp z,L_BC02		;bb2e
L_BB31:
	exx			;bb31
	ld a,e			;bb32
	exx			;bb33
	ret			;bb34
L_BB35:
	call L_BC19		;bb35
	ret nz			;bb38
	jp L_BBBD		;bb39
L_BB3C:
	call L_A488		;bb3c
L_BB3F:
	call L_BC19		;bb3f
	jp nz,L_A7A2		;bb42
	call L_A056		;bb45
	jp L_BBA4		;bb48
L_BB4B:
	call L_A7A2		;bb4b
	ld a,(0e490h)		;bb4e
	and a			;bb51
	ret nz			;bb52
	call 04a10h		;bb53
	call 05e0ch		;bb56
	call L_A076		;bb59
	ld a,(0002bh)		;bb5c
	and 00fh		;bb5f
	ld de,0bc85h		;bb61
	jr z,L_BB69		;bb64
	ld de,0bd1ah		;bb66
L_BB69:
	call 04a6bh		;bb69
	jp L_BBA4		;bb6c
L_BB6F:
	ld de,01518h		;bb6f
	call 05d89h		;bb72
	jp c,L_A7A2		;bb75
	jp L_BAD0		;bb78
L_BB7B:
	ld hl,00000h		;bb7b
	ld (0f0f7h),hl		;bb7e
	call 04a10h		;bb81
	ld a,(0e1d6h)		;bb84
	or a			;bb87
	jr nz,L_BBAC		;bb88
	ld a,040h		;bb8a
	call 04ae4h		;bb8c
	call L_BBE0		;bb8f
	ld a,(0002bh)		;bb92
	and 00fh		;bb95
	jp nz,L_B9F4		;bb97
	call L_BBA4		;bb9a
L_BB9D:
	xor a			;bb9d
	ld (0e496h),a		;bb9e
	ld hl,00001h		;bba1
L_BBA4:
	ld (0e49eh),hl		;bba4
	ld hl,0e1e6h		;bba7
	inc (hl)			;bbaa
	ret			;bbab
L_BBAC:
	ld a,041h		;bbac
	call 04ae4h		;bbae
	ld a,(0002bh)		;bbb1
	and 00fh		;bbb4
	jr z,L_BBD6		;bbb6
	ld a,00bh		;bbb8
	ld (0e1e6h),a		;bbba
L_BBBD:
	call L_A56F		;bbbd
	ld a,(0002bh)		;bbc0
	and 00fh		;bbc3
	ld de,0950fh		;bbc5
	jr z,L_BBCD		;bbc8
	ld de,0bc23h		;bbca
L_BBCD:
	call 04a6bh		;bbcd
	ld hl,00438h		;bbd0
	jp L_BBA4		;bbd3
L_BBD6:
	ld a,009h		;bbd6
	ld (0e1e6h),a		;bbd8
	call L_BC02		;bbdb
	jr L_BB9D		;bbde
L_BBE0:
	call 04a10h		;bbe0
	call 04c76h		;bbe3
	call 05e0ch		;bbe6
	call 05dcdh		;bbe9
	ld a,080h		;bbec
	ld hl,00d00h		;bbee
	ld bc,00158h		;bbf1
	call 00056h		;bbf4   ; BIOS FILVRM - Fills VRAM with value
	ld de,038a7h		;bbf7
	ld hl,091a8h		;bbfa
	ld c,012h		;bbfd
	jp L_A67B		;bbff
L_BC02:
	call 04a10h		;bc02
	call 04c76h		;bc05
	call 05e0ch		;bc08
	call 05edch		;bc0b
	ld de,038e8h		;bc0e
	ld hl,0b06fh		;bc11
	ld c,010h		;bc14
	jp L_A67B		;bc16
L_BC19:
	ld hl,(0e49eh)		;bc19
	dec hl			;bc1c
	ld (0e49eh),hl		;bc1d
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


L_BDFD:
	ld a,(0e1d7h)		;bdfd
	dec a			;be00
	call 04084h		;be01

; ----------------------------------------------------------------------
; DATOS tabla_BE04: 5 destinos del despachador p00:4084 (call en p10:BE01, el
;   indice en A): BE0E, BE94, BED0, BF5E, BF78; lo leen p10:BE01 (10 bytes)
;   0xbe04..0xbe0e  (10 bytes)
DATA_tabla_BE04:
	defw 0be0eh,0be94h,0bed0h,0bf5eh,0bf78h	; be04

; ======================================================================
; CODIGO 0xbe0e..0xbff3  (485 bytes)
; ======================================================================


L_BE0E:
	call L_BE49		;be0e
	ld a,(0e1c3h)		;be11
	and 007h		;be14
	ret nz			;be16
	call L_BFCF		;be17
	call L_BE5B		;be1a
	ld a,(0e496h)		;be1d
	call L_BE2E		;be20
	ld a,(0e496h)		;be23
	dec a			;be26
	jp m,L_BE8A		;be27
	ld (0e496h),a		;be2a
	ret			;be2d
L_BE2E:
	ld c,a			;be2e
	add a,009h		;be2f
	call L_A334		;be31
	ld de,03800h		;be34
	add hl,de			;be37
	ld de,00006h		;be38
	add hl,de			;be3b
	ld de,0e500h		;be3c
	ld b,c			;be3f
	ld a,007h		;be40
	sub b			;be42
	ld b,a			;be43
	ld c,014h		;be44
	jp L_A2F8		;be46
L_BE49:
	ld a,(0e1c3h)		;be49
	and 00fh		;be4c
	ret nz			;be4e
	ld de,0e4a3h		;be4f
	call L_BE7E		;be52
	ld de,0e4a4h		;be55
	call L_BE7E		;be58
L_BE5B:
	ld hl,039c1h		;be5b
	ld de,0e4a3h		;be5e
	call L_BE83		;be61
	ld hl,039c5h		;be64
	ld de,0e4a3h		;be67
	call L_BE83		;be6a
	ld hl,039dah		;be6d
	ld de,0e4a4h		;be70
	call L_BE83		;be73
	ld hl,039deh		;be76
	ld de,0e4a4h		;be79
	jr L_BE83		;be7c
L_BE7E:
	ld a,(de)			;be7e
	xor 001h		;be7f
	ld (de),a			;be81
	ret			;be82
L_BE83:
	ld a,(de)			;be83
	ld bc,00001h		;be84
	jp 00056h		;be87   ; BIOS FILVRM - Fills VRAM with value
L_BE8A:
	ld a,0ffh		;be8a
	ld (0e496h),a		;be8c
	ld a,03ch		;be8f
	jp L_BF16		;be91
L_BE94:
	ld hl,0e49eh		;be94
	dec (hl)			;be97
	jp z,L_BF16		;be98
	call L_BE49		;be9b
	ld a,(0e1c3h)		;be9e
	bit 1,a		;bea1
	jp nz,L_BECA		;bea3
	ld bc,00207h		;bea6
L_BEA9:
	ld hl,07870h		;bea9
	ld de,0b604h		;beac
	exx			;beaf
	ld hl,0e280h		;beb0
	exx			;beb3
	push bc			;beb4
	call L_BF42		;beb5
	pop bc			;beb8
	ld hl,07890h		;beb9
	ld de,0b60ah		;bebc
	exx			;bebf
	ld hl,0e288h		;bec0
	exx			;bec3
	call L_BF42		;bec4
	jp L_A889		;bec7
L_BECA:
	call 04c76h		;beca
	jp L_A889		;becd
L_BED0:
	call L_BE49		;bed0
	ld a,(0e1c3h)		;bed3
	and 003h		;bed6
	ret nz			;bed8
	ld a,(0e496h)		;bed9
	inc a			;bedc
	ld (0e496h),a		;bedd
	and a			;bee0
	jr z,L_BECA		;bee1
	dec a			;bee3
	jr z,L_BF1E		;bee4
	ld d,008h		;bee6
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
	ld de,0394ah		;befc
	ld hl,0b610h		;beff
	ld bc,00504h		;bf02
	call L_A67B		;bf05
	ld de,03952h		;bf08
	ld hl,0b621h		;bf0b
	ld bc,00504h		;bf0e
	call L_A67B		;bf11
	ld a,030h		;bf14
L_BF16:
	ld (0e49eh),a		;bf16
	ld hl,0e1d7h		;bf19
	inc (hl)			;bf1c
	ret			;bf1d
L_BF1E:
	ld bc,00409h		;bf1e
	ld hl,07870h		;bf21
	ld de,0b5ech		;bf24
	exx			;bf27
	ld hl,0e280h		;bf28
	exx			;bf2b
	push bc			;bf2c
	call L_BF42		;bf2d
	pop bc			;bf30
	ld hl,07890h		;bf31
	ld de,0b5f8h		;bf34
	exx			;bf37
	ld hl,0e290h		;bf38
	exx			;bf3b
	call L_BF42		;bf3c
	jp L_A889		;bf3f
L_BF42:
	ld a,(de)			;bf42
	inc de			;bf43
	add a,h			;bf44
	exx			;bf45
	ld (hl),a			;bf46
	inc hl			;bf47
	exx			;bf48
	ld a,(de)			;bf49
	inc de			;bf4a
	add a,l			;bf4b
	exx			;bf4c
	ld (hl),a			;bf4d
	inc hl			;bf4e
	exx			;bf4f
	ld a,(de)			;bf50
	inc de			;bf51
	exx			;bf52
	ld (hl),a			;bf53
	inc hl			;bf54
	exx			;bf55
	ld a,c			;bf56
	exx			;bf57
	ld (hl),a			;bf58
	inc hl			;bf59
	exx			;bf5a
	djnz L_BF42		;bf5b
	ret			;bf5d
L_BF5E:
	call L_BE49		;bf5e
	ld hl,0e49eh		;bf61
	dec (hl)			;bf64
	ret nz			;bf65
	call L_BFCF		;bf66
	call L_BE5B		;bf69
	ld a,000h		;bf6c
	call L_BE2E		;bf6e
	call L_BF1E		;bf71
	ld a,00fh		;bf74
	jr L_BF16		;bf76
L_BF78:
	ld hl,0e49eh		;bf78
	dec (hl)			;bf7b
	jp z,L_BF93		;bf7c
	call L_BE49		;bf7f
	ld a,(0e49eh)		;bf82
	bit 3,a		;bf85
	jp nz,L_BF1E		;bf87
	call 04c76h		;bf8a
	ld bc,00206h		;bf8d
	jp L_BEA9		;bf90
L_BF93:
	call 04a10h		;bf93
	call L_A895		;bf96
	xor a			;bf99
	ld (0e1d7h),a		;bf9a
	ret			;bf9d
L_BF9E:
	ld a,001h		;bf9e
	ld (0e1d7h),a		;bfa0
	call L_BFC1		;bfa3
	call L_A895		;bfa6
	ld hl,03848h		;bfa9
	ld (0e4a3h),hl		;bfac
	call L_BFCF		;bfaf
	ld hl,0e500h		;bfb2
	ld de,0b586h		;bfb5
	call L_A6EB		;bfb8
	ld a,006h		;bfbb
	ld (0e496h),a		;bfbd
	ret			;bfc0
L_BFC1:
	call 05d8eh		;bfc1
L_BFC4:
	call 04c76h		;bfc4
	jp L_A889		;bfc7
L_BFCA:
	call 05d94h		;bfca
	jr L_BFC4		;bfcd
L_BFCF:
	ld hl,0b461h		;bfcf
	ld de,0ed20h		;bfd2
L_BFD5:
	ld a,(hl)			;bfd5
	inc hl			;bfd6
	and a			;bfd7
	jp z,L_A8AD		;bfd8
	bit 7,a		;bfdb
	jr nz,L_BFE8		;bfdd
	ld b,a			;bfdf
L_BFE0:
	ld a,(hl)			;bfe0
	ld (de),a			;bfe1
	inc hl			;bfe2
	inc de			;bfe3
	djnz L_BFE0		;bfe4
	jr L_BFD5		;bfe6
L_BFE8:
	and 07fh		;bfe8
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

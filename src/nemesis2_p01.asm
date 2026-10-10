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


L_6000:
	cp 003h		;6000
	ret z			;6002
	cp 004h		;6003
	ret z			;6005
	cp 00eh		;6006
	jr nc,L_6017		;6008
	cp 00bh		;600a
	ret nc			;600c
	cp 007h		;600d
	jr nz,L_6017		;600f
	ld a,(ix+006h)		;6011
	cp 0c1h		;6014
	ret nc			;6016
L_6017:
	ld a,(ix+007h)		;6017
	ld hl,0b661h		;601a
	call 04b67h		;601d
	ld b,(ix+009h)		;6020
	ld c,(ix+00ah)		;6023
	ld l,(ix+004h)		;6026
	ld h,(ix+006h)		;6029
	ld a,(0f000h)		;602c
	and a			;602f
	jp z,L_6052		;6030
	ld a,(ix+006h)		;6033
	cp 0c8h		;6036
	jp nc,05327h		;6038
	call 05c92h		;603b
	ex de,hl			;603e
	ld a,c			;603f
L_6040:
	push de			;6040
	ld c,(ix+009h)		;6041
	ld b,000h		;6044
	ldir		;6046
	pop de			;6048
	ld c,020h		;6049
	ex de,hl			;604b
	add hl,bc			;604c
	ex de,hl			;604d
	dec a			;604e
	jr nz,L_6040		;604f
	ret			;6051
L_6052:
	ld a,(ix+006h)		;6052
	cp 0c8h		;6055
	jp nc,0530ch		;6057
	call 05c92h		;605a
L_605D:
	ld b,(ix+009h)		;605d
	push hl			;6060
	xor a			;6061
L_6062:
	ld (hl),a			;6062
	inc hl			;6063
	djnz L_6062		;6064
	pop hl			;6066
	ld a,020h		;6067
	call 0407ah		;6069
	dec c			;606c
	jr nz,L_605D		;606d
	ret			;606f
L_6070:
	ld c,005h		;6070
	ld a,(ix+000h)		;6072
	cp 00fh		;6075
	jr nz,L_607B		;6077
	ld c,014h		;6079
L_607B:
	ld a,(ix+008h)		;607b
	dec a			;607e
	ld a,c			;607f
	call nz,04ae4h		;6080
	ld a,(ix+000h)		;6083
	cp 009h		;6086
	ret nz			;6088
	ld a,01bh		;6089
	ld (ix+001h),004h		;608b
	bit 0,(ix+00bh)		;608f
	jr z,L_6096		;6093
	inc a			;6095
L_6096:
	ld (ix+007h),a		;6096
	ld (ix+00dh),000h		;6099
	ret			;609d
L_609E:
	call 0413fh		;609e
	call L_60A7		;60a1
	jp 04157h		;60a4
L_60A7:
	ld a,(ix+000h)		;60a7
	cp 00eh		;60aa
	jr z,L_60C3		;60ac
	cp 010h		;60ae
	jr z,L_60BA		;60b0
	dec a			;60b2
	jr z,L_60CC		;60b3
	ld (ix+000h),000h		;60b5
	ret			;60b9
L_60BA:
	ld (ix+00dh),0ffh		;60ba
	ld (ix+001h),008h		;60be
	ret			;60c2
L_60C3:
	ld (ix+00dh),0ffh		;60c3
	ld (ix+001h),004h		;60c7
	ret			;60cb
L_60CC:
	ld (ix+001h),008h		;60cc
	ret			;60d0
L_60D1:
	call 04396h		;60d1
	call 05ba3h		;60d4
	ld hl,00000h		;60d7
	ld (0e203h),hl		;60da
	call L_68B9		;60dd
	call 047e0h		;60e0
	ld a,(0e1dbh)		;60e3
	or a			;60e6
	ret z			;60e7
	xor a			;60e8
	ld (0e1dbh),a		;60e9
	ld hl,04a00h		;60ec
	ld (0e403h),hl		;60ef
	ld h,050h		;60f2
	ld (0e405h),hl		;60f4
	call 0aa2fh		;60f7
	jp 0aaech		;60fa
L_60FD:
	ld a,(0e201h)		;60fd
	cp 008h		;6100
	jr nc,L_611C		;6102
	ld hl,0e206h		;6104
	cp (hl)			;6107
	jr c,L_610B		;6108
	ld (hl),a			;610a
L_610B:
	ld hl,0e22ch		;610b
	ld a,(hl)			;610e
	ld (hl),000h		;610f
	and a			;6111
	jr z,L_6128		;6112
	ld a,(0e201h)		;6114
	call L_7C59		;6117
	jr L_611F		;611a
L_611C:
	ld a,(0e22ah)		;611c
L_611F:
	ld (0e201h),a		;611f
	ld hl,00020h		;6122
	ld (0e203h),hl		;6125
L_6128:
	call 04396h		;6128
	call 04c76h		;612b
	xor a			;612e
	ld (0e1d5h),a		;612f
	ld hl,0e300h		;6132
	ld de,0e301h		;6135
	ld bc,00cffh		;6138
	ld (hl),a			;613b
	ldir		;613c
	call L_68E4		;613e
	call L_68AA		;6141
	ld a,(0e1c2h)		;6144
	bit 6,a		;6147
	jr nz,L_614F		;6149
	xor a			;614b
	ld (0e228h),a		;614c
L_614F:
	call L_6888		;614f
	call 0aa2fh		;6152
	call 05366h		;6155
	jp 047e0h		;6158
L_615B:
	call 04a10h		;615b
	call 0413fh		;615e
	ld ix,055a7h		;6161
	call 04595h		;6165
	xor a			;6168
	ld (0f000h),a		;6169
	ld ix,055deh		;616c
	call 0454eh		;6170
	ld a,(0002bh)		;6173
	and 00fh		;6176
	jr z,L_618F		;6178
	call 0413bh		;617a
	ld ix,0aa83h		;617d
	call 04595h		;6181
	xor a			;6184
	ld (0f000h),a		;6185
	ld ix,0aa96h		;6188
	call 0454eh		;618c
L_618F:
	call 04137h		;618f
	call 0b6cdh		;6192
	call 0413bh		;6195
	ld hl,01800h		;6198
	ld de,0aa75h		;619b
	call 04a8ch		;619e
	call L_69EF		;61a1
	ld b,0e0h		;61a4
	call 05d25h		;61a6
	ld hl,02800h		;61a9
	call L_61B8		;61ac
	ld hl,00000h		;61af
	call L_61B8		;61b2
	ld hl,00800h		;61b5
L_61B8:
	xor a			;61b8
	ld de,0b8f5h		;61b9
	ld b,001h		;61bc
	jp 0a24ch		;61be
L_61C1:
	ld a,(0e1c0h)		;61c1
	cp 002h		;61c4
	ld de,0b904h		;61c6
	jr c,L_61E7		;61c9
	ld de,0b936h		;61cb
	call 04a6bh		;61ce
	ld de,0b94fh		;61d1
	ld a,(0002bh)		;61d4
	and 00fh		;61d7
	jr z,L_61DE		;61d9
	ld de,0622dh		;61db
L_61DE:
	call 04a6bh		;61de
	ld de,0b959h		;61e1
L_61E4:
	jp 04a6bh		;61e4
L_61E7:
	call 04a6bh		;61e7
	jr L_61E4		;61ea
L_61EC:
	ld hl,0e1c4h		;61ec
	bit 3,(hl)		;61ef
	ld c,0ffh		;61f1
	jr nz,L_61F6		;61f3
	inc c			;61f5
L_61F6:
	ld hl,03a2ah		;61f6
	ld de,03a6ah		;61f9
	ld a,(0e1d2h)		;61fc
	or a			;61ff
	jr z,L_6203		;6200
	ex de,hl			;6202
L_6203:
	push de			;6203
	call L_620A		;6204
	pop hl			;6207
	ld c,000h		;6208
L_620A:
	ld de,0b26fh		;620a
	jp 04a73h		;620d
L_6210:
	ld hl,0e490h		;6210
	ld de,0e491h		;6213
	ld bc,00013h		;6216
	xor a			;6219
	ld (hl),a			;621a
	ldir		;621b
	ret			;621d
L_621E:
	call 04133h		;621e
	call L_615B		;6221
	call 0b636h		;6224
	call L_61C1		;6227
	jp 04108h		;622a

; ----------------------------------------------------------------------
; DATOS lista_622D: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p01:61DE (10 bytes)
;   0x622d..0x6237  (10 bytes)
DATA_lista_622D:
	defb 007h,03ah,02eh,025h,02dh,025h,033h,029h,033h,0ffh	; 622d  .:.%-%3)3.

; ======================================================================
; CODIGO 0x6237..0x63cd  (406 bytes)
; ======================================================================


L_6237:
	ld hl,00000h		;6237
	ld (0e1ceh),hl		;623a
	call 04144h		;623d
	ld de,0b79fh		;6240
	call 04a86h		;6243
	call 04157h		;6246
	ld hl,00a00h		;6249
	ld bc,003f0h		;624c
	xor a			;624f
	call 00056h		;6250   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;6253
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
	add hl,de			;6266
	dec c			;6267
	jr nz,L_625D		;6268
	ret			;626a
L_626B:
	ld bc,(0e1ceh)		;626b
	ld a,0ebh		;626f
	inc b			;6271
L_6272:
	add a,015h		;6272
	djnz L_6272		;6274
	ld l,a			;6276
	ld h,b			;6277
	add hl,hl			;6278
	add hl,hl			;6279
	add hl,hl			;627a
	ld de,00a00h		;627b
	add hl,de			;627e
	ld a,c			;627f
	call 0407ah		;6280
	ld b,015h		;6283
	ld de,00008h		;6285
	ld a,0f0h		;6288
L_628A:
	call 0004dh		;628a   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;628d
	djnz L_628A		;628e
	ld hl,0e1ceh		;6290
	ld a,(hl)			;6293
	inc a			;6294
	and 007h		;6295
	ld (hl),a			;6297
	ret nz			;6298
	inc hl			;6299
	inc (hl)			;629a
	ld a,(hl)			;629b
	cp 006h		;629c
	ret			;629e
L_629F:
	ld e,(ix+020h)		;629f
	ld d,(ix+021h)		;62a2
	call 05cadh		;62a5
L_62A8:
	ld (ix+020h),e		;62a8
	ld (ix+021h),d		;62ab
	ret			;62ae
L_62AF:
	ld (ix+020h),e		;62af
	ld (ix+021h),d		;62b2
	ret			;62b5
L_62B6:
	ld a,d			;62b6
	or a			;62b7
	call m,05cadh		;62b8
	ld (ix+022h),e		;62bb
	ld (ix+023h),d		;62be
	ret			;62c1
L_62C2:
	ld a,(ix+007h)		;62c2
	add a,(ix+020h)		;62c5
	ld (ix+007h),a		;62c8
	ld a,(ix+008h)		;62cb
	adc a,(ix+021h)		;62ce
	ld (ix+008h),a		;62d1
	ret			;62d4
L_62D5:
	ld a,(ix+009h)		;62d5
	add a,(ix+020h)		;62d8
	ld (ix+009h),a		;62db
	ld a,(ix+00ah)		;62de
	adc a,(ix+021h)		;62e1
	ld (ix+00ah),a		;62e4
	ret			;62e7
L_62E8:
	ld e,(ix+007h)		;62e8
	ld d,(ix+008h)		;62eb
	ld a,d			;62ee
	or a			;62ef
	call m,05cadh		;62f0
	ld l,(ix+022h)		;62f3
	ld h,(ix+023h)		;62f6
	rst 20h			;62f9
	ret			;62fa
L_62FB:
	ld e,(ix+009h)		;62fb
	ld d,(ix+00ah)		;62fe
	call 05cadh		;6301
	ld (ix+009h),e		;6304
	ld (ix+00ah),d		;6307
	ret			;630a
L_630B:
	ld a,(0e1c3h)		;630b
	and 01fh		;630e
	ret			;6310
L_6311:
	call L_630B		;6311
	jr nz,L_631D		;6314
	dec (ix+025h)		;6316
	jr nz,L_631D		;6319
	scf			;631b
	ret			;631c
L_631D:
	ld a,(0e201h)		;631d
	cp 007h		;6320
	jr z,L_6333		;6322
	ld hl,(0e323h)		;6324
	ld de,00010h		;6327
	or a			;632a
	sbc hl,de		;632b
	ld de,(0e203h)		;632d
	rst 20h			;6331
	ret			;6332
L_6333:
	ld a,(0e3beh)		;6333
	or a			;6336
	ret nz			;6337
	ld de,(0e203h)		;6338
	ld hl,000e0h		;633c
	or a			;633f
	sbc hl,de		;6340
	ret nc			;6342
	ld hl,001a0h		;6343
	or a			;6346
	sbc hl,de		;6347
	ccf			;6349
	ret c			;634a
	ld hl,00210h		;634b
	or a			;634e
	sbc hl,de		;634f
	ret nc			;6351
	ld hl,00240h		;6352
	or a			;6355
	sbc hl,de		;6356
	ccf			;6358
	ret c			;6359
	ld hl,002e0h		;635a
	or a			;635d
	sbc hl,de		;635e
	ret			;6360
L_6361:
	ld a,(0e1c3h)		;6361
	and b			;6364
	ret nz			;6365
	ld a,(ix+026h)		;6366
	inc a			;6369
	cp c			;636a
	jr c,L_636E		;636b
	xor a			;636d
L_636E:
	ld (ix+026h),a		;636e
	call 05ca6h		;6371
	ld (ix+030h),a		;6374
	ld (ix+032h),a		;6377
	ret			;637a
L_637B:
	ld a,r		;637b
	rrca			;637d
	rrca			;637e
	rrca			;637f
	ld hl,0e1c3h		;6380
	xor (hl)			;6383
	ret			;6384
L_6385:
	ld ix,0e600h		;6385
	ld b,00ch		;6389
L_638B:
	push bc			;638b
	ld a,(ix+000h)		;638c
	and a			;638f
	jr z,L_63A5		;6390
	call L_63AE		;6392
	ld a,(ix+000h)		;6395
	or a			;6398
	jr z,L_63A5		;6399
	call L_6486		;639b
	jr c,L_63A5		;639e
	call L_64BE		;63a0
	jr nc,L_63A5		;63a3
L_63A5:
	ld bc,00040h		;63a5
	add ix,bc		;63a8
	pop bc			;63aa
	djnz L_638B		;63ab
	ret			;63ad
L_63AE:
	ld a,(ix+000h)		;63ae
	cp 026h		;63b1
	jr z,L_63C6		;63b3
	ld a,(0e3d0h)		;63b5
	or a			;63b8
	ret nz			;63b9
	ld a,(0e439h)		;63ba
	cp 005h		;63bd
	jr nz,L_63C6		;63bf
	ld a,(0e1c3h)		;63c1
	rra			;63c4
	ret c			;63c5
L_63C6:
	ld a,(ix+000h)		;63c6
	dec a			;63c9
	call 04084h		;63ca

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
	defw 06459h	; 644d  -> L_6459

; ======================================================================
; CODIGO 0x644f..0x66c0  (625 bytes)
; ======================================================================


L_644F:
	ret			;644f
L_6450:
	call 04137h		;6450
	call 0bf10h		;6453
	jp 04157h		;6456
L_6459:
	call 04137h		;6459
	call 0bc24h		;645c
	jp 04157h		;645f
L_6462:
	call 04137h		;6462
	call 0a644h		;6465
	jp 04157h		;6468
L_646B:
	call 04137h		;646b
	call 0af36h		;646e
	jp 04157h		;6471
L_6474:
	call 04137h		;6474
	call 0ac0ch		;6477
	jp 04157h		;647a
L_647D:
	call 04137h		;647d
	call 0b9a0h		;6480
	jp 04157h		;6483
L_6486:
	ld a,(0e3d0h)		;6486
	or a			;6489
	jr nz,L_6492		;648a
	ld a,(ix+010h)		;648c
	and 008h		;648f
	ret z			;6491
L_6492:
	ld a,(0e320h)		;6492
	and a			;6495
	ret z			;6496
	ld a,(ix+006h)		;6497
	sub 008h		;649a
	ld (ix+006h),a		;649c
	ret nc			;649f
	call L_64A8		;64a0
	call L_6514		;64a3
	scf			;64a6
	ret			;64a7
L_64A8:
	ld a,(ix+000h)		;64a8
	sub 02ch		;64ab
	cp 002h		;64ad
	jr c,L_64B9		;64af
	cp 003h		;64b1
	ret nz			;64b3
	ld a,(ix+02ah)		;64b4
	dec a			;64b7
	ret z			;64b8
L_64B9:
	xor a			;64b9
	ld (0e357h),a		;64ba
	ret			;64bd
L_64BE:
	ld a,(0e439h)		;64be
	cp 005h		;64c1
	jr nz,L_64CB		;64c3
	ld a,(0e1c3h)		;64c5
	rra			;64c8
	jr c,L_64DA		;64c9
L_64CB:
	bit 2,(ix+010h)		;64cb
	jr z,L_64DA		;64cf
	call L_64E1		;64d1
	ret c			;64d4
L_64D5:
	call L_6514		;64d5
	or a			;64d8
	ret			;64d9
L_64DA:
	call L_64F3		;64da
	ret c			;64dd
	jp L_64D5		;64de
L_64E1:
	push ix		;64e1
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
	call L_6509		;64ed
	call L_6509		;64f0
L_64F3:
	ld a,(ix+000h)		;64f3
	ld c,0b0h		;64f6
	cp 039h		;64f8
	jr z,L_64FE		;64fa
	ld c,0a8h		;64fc
L_64FE:
	ld a,(ix+004h)		;64fe
	cp c			;6501
	ret nc			;6502
	ld a,(ix+006h)		;6503
	cp 0f9h		;6506
	ret			;6508
L_6509:
	ld a,(de)			;6509
	add a,(hl)			;650a
	ld (hl),a			;650b
	inc l			;650c
	inc e			;650d
	ld a,(de)			;650e
	adc a,(hl)			;650f
	ld (hl),a			;6510
	inc l			;6511
	inc e			;6512
	ret			;6513
L_6514:
	ld hl,0e352h		;6514
	dec (hl)			;6517
	ld l,(ix+000h)		;6518
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
	bit 6,a		;652a
	jr nz,L_6537		;652c
	and 03fh		;652e
	ld hl,0e355h		;6530
	sub (hl)			;6533
	neg		;6534
	ld (hl),a			;6536
L_6537:
	ld a,(ix+000h)		;6537
	cp 02ah		;653a
	jr nz,L_6542		;653c
	ld hl,0e36dh		;653e
	dec (hl)			;6541
L_6542:
	ld (ix+000h),000h		;6542
	xor a			;6546
	ld (ix+00bh),a		;6547
	ld (ix+010h),a		;654a
	bit 0,(ix+016h)		;654d
	ret z			;6551
	ld a,(ix+017h)		;6552
	call 089a8h		;6555
	ret c			;6558
	inc l			;6559
	dec (hl)			;655a
	ret nz			;655b
	dec l			;655c
	ld (hl),000h		;655d
	ret			;655f
L_6560:
	call L_657C		;6560
	jr z,L_6560		;6563
	ret c			;6565
	ld hl,0e358h		;6566
	inc (hl)			;6569
	jr L_6560		;656a
L_656C:
	ld a,(0e320h)		;656c
	and a			;656f
	ret z			;6570
	ld a,0f8h		;6571
	ld (0f004h),a		;6573
L_6576:
	call L_657C		;6576
	jr z,L_6576		;6579
	ret			;657b
L_657C:
	call 0415bh		;657c
	ld a,(0e358h)		;657f
	ld hl,09554h		;6582
	call 04c32h		;6585
	push af			;6588
	call 04157h		;6589
	pop af			;658c
	ret nz			;658d
	ld hl,0e358h		;658e
	inc (hl)			;6591
	ld b,c			;6592
	ld a,c			;6593
	and 01fh		;6594
	add a,a			;6596
	add a,a			;6597
	add a,a			;6598
	ld e,a			;6599
	ld a,(0f004h)		;659a
	ld d,a			;659d
	xor a			;659e
	bit 6,c		;659f
	jr z,L_65A9		;65a1
	inc a			;65a3
	bit 7,c		;65a4
	jr z,L_65A9		;65a6
	inc a			;65a8
L_65A9:
	ld c,a			;65a9
	ld a,001h		;65aa
	call 04d1eh		;65ac
	xor a			;65af
	ret			;65b0
L_65B1:
	ld c,002h		;65b1
	ld (ix+014h),c		;65b3
	ld (ix+013h),c		;65b6
	ld (ix+027h),000h		;65b9
	call L_6667		;65bd
	sra a		;65c0
	ld c,a			;65c2
	ld a,(0e358h)		;65c3
	and 003h		;65c6
	add a,c			;65c8
	ld (ix+015h),a		;65c9
	ld c,(ix+019h)		;65cc
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
	ld (ix+010h),00bh		;65de
	ld a,(0e201h)		;65e2
	cp 006h		;65e5
	jp z,L_673A		;65e7
	ld c,000h		;65ea
	jr L_660A		;65ec
L_65EE:
	ld e,(ix+004h)		;65ee
	ld d,(ix+006h)		;65f1
	call 0945bh		;65f4
	ld a,(0f018h)		;65f7
	cp 080h		;65fa
	jr c,L_6600		;65fc
	neg		;65fe
L_6600:
	ld bc,00505h		;6600
L_6603:
	sub 015h		;6603
	jr c,L_660A		;6605
	dec c			;6607
	djnz L_6603		;6608
L_660A:
	ld a,(ix+026h)		;660a
	add a,a			;660d
	add a,a			;660e
	ld e,a			;660f
	add a,a			;6610
	add a,e			;6611
	ld hl,066d0h		;6612
	call 0407ah		;6615
	ld a,(0e201h)		;6618
	call 0407ah		;661b
	ld a,(hl)			;661e
	add a,c			;661f
	ld (ix+032h),a		;6620
	ret			;6623
L_6624:
	ld a,(0e201h)		;6624
	cp 006h		;6627
	jp z,L_6700		;6629
	dec (ix+015h)		;662c
	ld a,(ix+015h)		;662f
	and 003h		;6632
	ret nz			;6634
	call L_65EE		;6635
	ld a,(0f018h)		;6638
	bit 1,(ix+026h)		;663b
	jr nz,L_6648		;663f
	sub 010h		;6641
	cp 060h		;6643
	ret c			;6645
	jr L_664D		;6646
L_6648:
	sub 090h		;6648
	cp 060h		;664a
	ret c			;664c
L_664D:
	ld a,(ix+015h)		;664d
	and a			;6650
	ret nz			;6651
	ld hl,0e307h		;6652
	ld a,(hl)			;6655
	and a			;6656
	jr z,L_665E		;6657
	ld (ix+015h),001h		;6659
	ret			;665d
L_665E:
	ld e,(ix+004h)		;665e
	ld d,(ix+006h)		;6661
	call 0938fh		;6664
L_6667:
	ld hl,066c0h		;6667
	ld a,(0e206h)		;666a
	dec a			;666d
	ld a,(0e228h)		;666e
	jr nz,L_6679		;6671
	cp 002h		;6673
	jr c,L_6679		;6675
	ld a,002h		;6677
L_6679:
	call 0407ah		;6679
	ld c,(hl)			;667c
	inc (ix+027h)		;667d
	ld a,(ix+027h)		;6680
	and 003h		;6683
	jr nz,L_6689		;6685
	sla c		;6687
L_6689:
	ld a,(0e400h)		;6689
	cp 002h		;668c
	ld a,c			;668e
	jr nz,L_6693		;668f
	sub 004h		;6691
L_6693:
	ld c,a			;6693
	ld a,(0e206h)		;6694
	srl a		;6697
	srl a		;6699
	ld b,a			;669b
	ld a,c			;669c
	sub b			;669d
	jr nc,L_66A1		;669e
	xor a			;66a0
L_66A1:
	cp 00ch		;66a1
	jr nc,L_66A7		;66a3
	ld a,00ch		;66a5
L_66A7:
	ld c,a			;66a7
	ld a,(0e201h)		;66a8
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


L_6700:
	ld hl,L_673A		;6700
	push hl			;6703
	ld a,(ix+001h)		;6704
	dec a			;6707
	jr z,L_671A		;6708
	call L_675A		;670a
	ret c			;670d
	dec (ix+015h)		;670e
	ret nz			;6711
	ld (ix+015h),008h		;6712
	inc (ix+001h)		;6716
	ret			;6719
L_671A:
	dec (ix+015h)		;671a
	jr z,L_6732		;671d
	ld a,(ix+015h)		;671f
	cp 004h		;6722
	ret nz			;6724
	call L_675A		;6725
	ret c			;6728
	ld e,(ix+004h)		;6729
	ld d,(ix+006h)		;672c
	jp 0938fh		;672f
L_6732:
	call L_6667		;6732
	ld (ix+001h),000h		;6735
	ret			;6739
L_673A:
	ld a,(ix+026h)		;673a
	ld hl,0676ch		;673d
	call 0407ah		;6740
	ld c,(hl)			;6743
	ld a,(ix+001h)		;6744
	and a			;6747
	jr z,L_674B		;6748
	inc c			;674a
L_674B:
	ld a,(0e406h)		;674b
	cp (ix+006h)		;674e
	ld a,c			;6751
	jr c,L_6756		;6752
	add a,002h		;6754
L_6756:
	ld (ix+032h),a		;6756
	ret			;6759
L_675A:
	ld a,(0e404h)		;675a
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


L_6770:
	dec (ix+015h)		;6770
	ret nz			;6773
L_6774:
	ld hl,0e307h		;6774
	ld a,(hl)			;6777
	and a			;6778
	jr z,L_6780		;6779
	ld (ix+015h),001h		;677b
	ret			;677f
L_6780:
	ld e,(ix+004h)		;6780
	ld d,(ix+006h)		;6783
	call 0938fh		;6786
	call 04e93h		;6789
	ld (ix+015h),a		;678c
	ret			;678f
L_6790:
	ld a,(0e340h)		;6790
	dec a			;6793
	ret m			;6794
	ld c,a			;6795
	ld hl,(0e346h)		;6796
	inc hl			;6799
	ld a,l			;679a
	or h			;679b
	jr nz,L_679F		;679c
	dec hl			;679e
L_679F:
	ld (0e346h),hl		;679f
	call 04137h		;67a2
	ld a,c			;67a5
	call L_67AC		;67a6
	jp 04157h		;67a9
L_67AC:
	call 04084h		;67ac

; ----------------------------------------------------------------------
; DATOS tabla_67AF: 5 destinos del despachador p00:4084 (call en p01:67AC, el
;   indice en A): A8B5, AC1D, AE29, AD29, AF72; lo leen p01:67AC (10 bytes)
;   0x67af..0x67b9  (10 bytes)
DATA_tabla_67AF:
	defw 0a8b5h,0ac1dh,0ae29h,0ad29h,0af72h	; 67af

; ======================================================================
; CODIGO 0x67b9..0x67c8  (15 bytes)
; ======================================================================


L_67B9:
	call L_6878		;67b9
	ret z			;67bc
	call 04144h		;67bd
	ld c,001h		;67c0
	call L_67CE		;67c2
	jp 04108h		;67c5

; ----------------------------------------------------------------------
; DATOS tabla_67C8: 6 bytes que p01:67CE pasa a L_67EC (3 pares, destino
;   0xEA07); lo leen p01:67CE (6 bytes)
;   0x67c8..0x67ce  (6 bytes)
DATA_tabla_67C8:
	defb 006h,00dh,011h,026h,02dh,031h	; 67c8

; ======================================================================
; CODIGO 0x67ce..0x694a  (380 bytes)
; ======================================================================


L_67CE:
	ld hl,067c8h		;67ce
	ld de,0ea07h		;67d1
	ld a,(0ea00h)		;67d4
	and a			;67d7
	call nz,L_67EC		;67d8
	ld a,(0e340h)		;67db
	cp 005h		;67de
	ret nz			;67e0
	ld a,(0ea20h)		;67e1
	and a			;67e4
	ret z			;67e5
	ld hl,067cbh		;67e6
	ld de,0ea27h		;67e9
L_67EC:
	ld b,003h		;67ec
L_67EE:
	push bc			;67ee
	ld a,(de)			;67ef
	push de			;67f0
	ld e,(hl)			;67f1
	inc hl			;67f2
	ld d,000h		;67f3
	push hl			;67f5
	ld hl,0ea00h		;67f6
	add hl,de			;67f9
	bit 0,c		;67fa
	jr z,L_6803		;67fc
	call L_680D		;67fe
	jr L_6806		;6801
L_6803:
	call L_6838		;6803
L_6806:
	pop hl			;6806
	pop de			;6807
	inc de			;6808
	pop bc			;6809
	djnz L_67EE		;680a
	ret			;680c
L_680D:
	and a			;680d
	ret m			;680e
	call L_6816		;680f
	ret c			;6812
	jp 05327h		;6813
L_6816:
	push hl			;6816
	ld de,0bb01h		;6817
	call 04b60h		;681a
	ex de,hl			;681d
	ld c,(hl)			;681e
	inc hl			;681f
	ld b,(hl)			;6820
	inc hl			;6821
	ex de,hl			;6822
	pop hl			;6823
	jr L_6841		;6824
L_6826:
	call L_6878		;6826
	ret z			;6829
	call 04144h		;682a
	ld c,000h		;682d
	call L_67CE		;682f
	call 04108h		;6832
	jp 049a5h		;6835
L_6838:
	and a			;6838
	ret m			;6839
	call L_6816		;683a
	ret c			;683d
	jp 0530ch		;683e
L_6841:
	ld a,(hl)			;6841
	and a			;6842
	scf			;6843
	ret nz			;6844
	dec l			;6845
	dec l			;6846
	ld a,(hl)			;6847
	dec l			;6848
	and a			;6849
	jr z,L_6871		;684a
	scf			;684c
	ret p			;684d
	ld a,(hl)			;684e
	rra			;684f
	rra			;6850
	rra			;6851
	or 0e0h		;6852
	ld (0f000h),a		;6854
	add a,c			;6857
	ld c,a			;6858
	scf			;6859
	ret z			;685a
	ret m			;685b
	ld a,(0f000h)		;685c
L_685F:
	ex af,af'			;685f
	ld a,b			;6860
	add a,e			;6861
	ld e,a			;6862
	jr nc,L_6866		;6863
	inc d			;6865
L_6866:
	ex af,af'			;6866
	inc a			;6867
	jr nz,L_685F		;6868
	inc l			;686a
	inc l			;686b
	ld h,(hl)			;686c
	ld l,000h		;686d
	xor a			;686f
	ret			;6870
L_6871:
	ld a,(hl)			;6871
	inc l			;6872
	inc l			;6873
	ld h,(hl)			;6874
	ld l,a			;6875
	xor a			;6876
	ret			;6877
L_6878:
	ld a,(0e340h)		;6878
	and a			;687b
	ret z			;687c
	cp 005h		;687d
	jr z,L_6886		;687f
	ld a,(0ea00h)		;6881
	and a			;6884
	ret			;6885
L_6886:
	or a			;6886
	ret			;6887
L_6888:
	ld hl,06962h		;6888
	ld de,0e400h		;688b
	ld bc,0000fh		;688e
	ldir		;6891
	ld hl,06971h		;6893
	ld de,0e430h		;6896
	ld bc,00009h		;6899
	ldir		;689c
	ld a,(0e201h)		;689e
	cp 008h		;68a1
	ret nz			;68a3
	ld a,050h		;68a4
	ld (0e406h),a		;68a6
	ret			;68a9
L_68AA:
	ld a,(0e206h)		;68aa
	srl a		;68ad
	cp 00fh		;68af
	jr c,L_68B5		;68b1
	ld a,00fh		;68b3
L_68B5:
	ld (0e228h),a		;68b5
	ret			;68b8
L_68B9:
	xor a			;68b9
	ld (0e22ch),a		;68ba
	ld (0e300h),a		;68bd
	ld hl,0eaa8h		;68c0
	ld de,0eaa9h		;68c3
	ld bc,0000fh		;68c6
	ld (hl),a			;68c9
	ldir		;68ca
	ld hl,0e340h		;68cc
	ld de,0e341h		;68cf
	ld bc,000bfh		;68d2
	ld (hl),a			;68d5
	ldir		;68d6
	ld hl,0e500h		;68d8
	ld de,0e501h		;68db
	ld bc,007ffh		;68de
	ld (hl),a			;68e1
	ldir		;68e2
L_68E4:
	xor a			;68e4
	ld (0e1d5h),a		;68e5
	ld (0e369h),a		;68e8
	inc a			;68eb
	ld (0e35ch),a		;68ec
	ld (0e376h),a		;68ef
	ld (0e36eh),a		;68f2
	ld (0e365h),a		;68f5
	ld a,(0e201h)		;68f8
	ld hl,0697ah		;68fb
	call 05ca6h		;68fe
	ld (0e305h),a		;6901
	xor a			;6904
	ld (0e327h),a		;6905
	ld a,(0e201h)		;6908
	add a,a			;690b
	ld c,a			;690c
	add a,a			;690d
	add a,c			;690e
	ld hl,06986h		;690f
	call 0407ah		;6912
	ld de,0e321h		;6915
	ld bc,00006h		;6918
	ldir		;691b
	ld a,(0e201h)		;691d
	ld hl,0694ah		;6920
	call 04b67h		;6923
	ld hl,(0e203h)		;6926
	rst 20h			;6929
	jr nc,L_6938		;692a
	ld de,00020h		;692c
	ld a,(0e1c2h)		;692f
	bit 6,a		;6932
	jr nz,L_6938		;6934
	ld e,060h		;6936
L_6938:
	ld (0e203h),de		;6938
	xor a			;693c
	ld (0e205h),a		;693d
	inc a			;6940
	ld (0e202h),a		;6941
	ld a,040h		;6944
	ld (0e354h),a		;6946
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


L_69CE:
	call 04144h		;69ce
	ld ix,0a16dh		;69d1
	call 04595h		;69d5
	xor a			;69d8
	ld (0f000h),a		;69d9
	ld ix,0a174h		;69dc
	call 0454eh		;69e0
	ld a,001h		;69e3
	ld (0f000h),a		;69e5
	ld ix,0a187h		;69e8
	call 0454eh		;69ec
L_69EF:
	call 04b43h		;69ef
L_69F2:
	call 04108h		;69f2
	jp 04133h		;69f5
L_69F8:
	call 04144h		;69f8
	ld ix,0a18bh		;69fb
	call 04595h		;69ff
	xor a			;6a02
	ld (0f000h),a		;6a03
	ld ix,0a204h		;6a06
	call 0454eh		;6a0a
	jr L_69EF		;6a0d
L_6A0F:
	call 0413bh		;6a0f
	ld ix,0b223h		;6a12
	call 04595h		;6a16
	jr L_69EF		;6a19
L_6A1B:
	call 0413bh		;6a1b
	ld ix,0ac44h		;6a1e
	call 04595h		;6a22
	jr L_69EF		;6a25
L_6A27:
	ld a,(0e340h)		;6a27
	or a			;6a2a
	ret nz			;6a2b
	ld a,(0e3aah)		;6a2c
	and a			;6a2f
	ret nz			;6a30
	ld a,(0e201h)		;6a31
	ld b,a			;6a34
	cp 009h		;6a35
	ret nc			;6a37
	ld c,00fh		;6a38
	cp 004h		;6a3a
	jr z,L_6A45		;6a3c
	ld c,003h		;6a3e
	dec a			;6a40
	cp 007h		;6a41
	jr c,L_6A4A		;6a43
L_6A45:
	ld a,(0e1c3h)		;6a45
	and c			;6a48
	ret nz			;6a49
L_6A4A:
	ld a,(0e201h)		;6a4a
	ld de,0b901h		;6a4d
	call 04b60h		;6a50
	ex de,hl			;6a53
	ld a,l			;6a54
	or h			;6a55
	ret z			;6a56
	ld a,(hl)			;6a57
	ld (0f000h),a		;6a58
	and 07fh		;6a5b
	ld c,a			;6a5d
	inc hl			;6a5e
	ld a,(0e3bbh)		;6a5f
	inc a			;6a62
	cp c			;6a63
	jr c,L_6A67		;6a64
	xor a			;6a66
L_6A67:
	ld (0e3bbh),a		;6a67
	push hl			;6a6a
	ld l,a			;6a6b
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
	ld a,(hl)			;6a78
	ex de,hl			;6a79
	inc de			;6a7a
	ld l,a			;6a7b
	ld a,(0f000h)		;6a7c
	add a,a			;6a7f
	ld h,004h		;6a80
	jr nc,L_6A86		;6a82
	ld h,000h		;6a84
L_6A86:
	add hl,hl			;6a86
	add hl,hl			;6a87
	add hl,hl			;6a88
	ld a,(00007h)		;6a89
	ld c,a			;6a8c
	ld a,(de)			;6a8d
	inc de			;6a8e
	exx			;6a8f
	ld b,003h		;6a90
	ld e,a			;6a92
L_6A93:
	rr e		;6a93
	exx			;6a95
	jr nc,L_6AA7		;6a96
	call 00053h		;6a98   ; BIOS SETWRT - Enables VDP to write
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
	ld a,008h		;6aa7
	add a,h			;6aa9
	ld h,a			;6aaa
	exx			;6aab
	djnz L_6A93		;6aac
	ret			;6aae
L_6AAF:
	ld a,(0e201h)		;6aaf
	sub 003h		;6ab2
	cp 001h		;6ab4
	ret c			;6ab6
	sub 006h		;6ab7
	cp 003h		;6ab9
	ret			;6abb
L_6ABC:
	call L_6AAF		;6abc
	ret nc			;6abf
L_6AC0:
	call L_6ADA		;6ac0
	jr z,L_6AC0		;6ac3
	ret c			;6ac5
	ld hl,0e369h		;6ac6
	inc (hl)			;6ac9
	jr L_6AC0		;6aca
L_6ACC:
	call L_6AAF		;6acc
	ret nc			;6acf
	ld a,(0e320h)		;6ad0
	and a			;6ad3
	ret z			;6ad4
	ld a,0f8h		;6ad5
	ld (0f004h),a		;6ad7
L_6ADA:
	call L_6AE0		;6ada
	jr z,L_6ADA		;6add
	ret			;6adf
L_6AE0:
	call 0415bh		;6ae0
	ld hl,0a2ach		;6ae3
	ld a,(0e201h)		;6ae6
	cp 003h		;6ae9
	jr z,L_6AF6		;6aeb
	sub 009h		;6aed
	ld hl,06b7fh		;6aef
	call 04b67h		;6af2
	ex de,hl			;6af5
L_6AF6:
	ld a,(0e369h)		;6af6
	ld c,a			;6af9
	add a,a			;6afa
	add a,c			;6afb
	call 0407ah		;6afc
	ld e,(hl)			;6aff
	inc hl			;6b00
	ld a,(hl)			;6b01
	and 001h		;6b02
	ld d,a			;6b04
	inc hl			;6b05
	ld (0f005h),hl		;6b06
	ld hl,(0e203h)		;6b09
	rst 20h			;6b0c
	jp nz,04108h		;6b0d
	ld hl,0e369h		;6b10
	inc (hl)			;6b13
	ld hl,0e580h		;6b14
	ld b,010h		;6b17
	ld de,00008h		;6b19
	xor a			;6b1c
L_6B1D:
	cp (hl)			;6b1d
	jr z,L_6B25		;6b1e
	add hl,de			;6b20
	djnz L_6B1D		;6b21
	xor a			;6b23
	ret			;6b24
L_6B25:
	ex de,hl			;6b25
	ld hl,(0f005h)		;6b26
	push hl			;6b29
	ldi		;6b2a
	xor a			;6b2c
	dec hl			;6b2d
	dec hl			;6b2e
	bit 1,(hl)		;6b2f
	jr nz,L_6B35		;6b31
	ld a,080h		;6b33
L_6B35:
	ld (de),a			;6b35
	inc e			;6b36
	ld a,(hl)			;6b37
	and 0f8h		;6b38
	ld (de),a			;6b3a
	inc e			;6b3b
	ld a,(0f004h)		;6b3c
	ld (de),a			;6b3f
	inc e			;6b40
	pop hl			;6b41
	ld a,(hl)			;6b42
	add a,a			;6b43
	ld hl,0a561h		;6b44
	call 0407ah		;6b47
	ldi		;6b4a
	ldi		;6b4c
	ex de,hl			;6b4e
	ld de,(0f005h)		;6b4f
	ld a,(de)			;6b53
	sub 005h		;6b54
	jr c,L_6B75		;6b56
	cp 006h		;6b58
	jr c,L_6B5E		;6b5a
	sub 006h		;6b5c
L_6B5E:
	push hl			;6b5e
	ld hl,06b7ch		;6b5f
	call 0407ah		;6b62
	ld b,(hl)			;6b65
	pop hl			;6b66
	ld a,(0e228h)		;6b67
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
	ld (hl),004h		;6b78
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


L_6B85:
	call L_6878		;6b85
	ret nz			;6b88
	call L_6AAF		;6b89
	ret nc			;6b8c
	ld ix,0e580h		;6b8d
	ld b,010h		;6b91
L_6B93:
	push bc			;6b93
	ld a,(ix+000h)		;6b94
	or a			;6b97
	call nz,L_6BA4		;6b98
	ld bc,00008h		;6b9b
	add ix,bc		;6b9e
	pop bc			;6ba0
	djnz L_6B93		;6ba1
	ret			;6ba3
L_6BA4:
	call L_6C34		;6ba4
	ret c			;6ba7
	ld a,(0e439h)		;6ba8
	cp 005h		;6bab
	jr nz,L_6BB4		;6bad
	ld a,(0e1c3h)		;6baf
	rra			;6bb2
	ret nc			;6bb3
L_6BB4:
	ld a,(ix+000h)		;6bb4
	cp 005h		;6bb7
	jr c,L_6BE7		;6bb9
	cp 00bh		;6bbb
	jr nc,L_6BCD		;6bbd
	ld b,008h		;6bbf
	call L_6BCF		;6bc1
	ld a,(ix+001h)		;6bc4
	and 07fh		;6bc7
	dec a			;6bc9
	jr z,$+62		;6bca
	ret			;6bcc
L_6BCD:
	ld b,00eh		;6bcd
L_6BCF:
	ld a,(ix+000h)		;6bcf
	cp b			;6bd2
	ret nc			;6bd3
	ld a,(ix+006h)		;6bd4
	cp 004h		;6bd7
	ret nc			;6bd9
	ld a,(ix+000h)		;6bda
	add a,003h		;6bdd
	ld (ix+000h),a		;6bdf
	ld a,024h		;6be2
	jp 04ae4h		;6be4
L_6BE7:
	ld a,(ix+001h)		;6be7
	and 07fh		;6bea
	call 04084h		;6bec

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
	ld a,(ix+005h)		;6bf7
	add a,a			;6bfa
	add a,a			;6bfb
	add a,a			;6bfc
	ld b,a			;6bfd
	xor a			;6bfe
	sub (ix+003h)		;6bff
	cp b			;6c02
	ret c			;6c03
	inc (ix+001h)		;6c04
L_6C07:
	ret			;6c07
L_6C08:
	dec (ix+007h)		;6c08
	ret nz			;6c0b
	ld (ix+007h),004h		;6c0c
	ld l,(ix+002h)		;6c10
	ld h,(ix+003h)		;6c13
	call 05c92h		;6c16
	ld b,(ix+005h)		;6c19
	ld a,l			;6c1c
	and 01fh		;6c1d
	sub 020h		;6c1f
	jr c,L_6C26		;6c21
	neg		;6c23
	ld b,a			;6c25
L_6C26:
	xor a			;6c26
L_6C27:
	ld (hl),a			;6c27
	inc l			;6c28
	djnz L_6C27		;6c29
	ld a,(ix+002h)		;6c2b
	add a,008h		;6c2e
	ld (ix+002h),a		;6c30
L_6C33:
	ret			;6c33
L_6C34:
	ld a,(0e320h)		;6c34
	and a			;6c37
	ret z			;6c38
	ld a,(ix+003h)		;6c39
	sub 008h		;6c3c
	ld (ix+003h),a		;6c3e
	ret nc			;6c41
	ld (ix+000h),000h		;6c42
	scf			;6c46
	ret			;6c47
L_6C48:
	call L_6878		;6c48
	ret nz			;6c4b
	call L_6AAF		;6c4c
	ret nc			;6c4f
	ld ix,0e580h		;6c50
	ld b,010h		;6c54
L_6C56:
	push bc			;6c56
	ld a,(ix+000h)		;6c57
	or a			;6c5a
	call nz,L_6C67		;6c5b
	ld bc,00008h		;6c5e
	add ix,bc		;6c61
	pop bc			;6c63
	djnz L_6C56		;6c64
	ret			;6c66
L_6C67:
	ld a,(ix+000h)		;6c67
	cp 005h		;6c6a
	jr c,L_6C8E		;6c6c
	cp 00bh		;6c6e
	ret nc			;6c70
	ld a,(ix+001h)		;6c71
	and 07fh		;6c74
	jr z,L_6C80		;6c76
	call L_6CCB		;6c78
	ret nc			;6c7b
	dec (ix+001h)		;6c7c
	ret			;6c7f
L_6C80:
	ld a,(ix+003h)		;6c80
	cp 0e1h		;6c83
	ret nc			;6c85
	call L_6CCB		;6c86
	ret c			;6c89
	inc (ix+001h)		;6c8a
	ret			;6c8d
L_6C8E:
	ld a,(ix+001h)		;6c8e
	and 07fh		;6c91
	call 04084h		;6c93

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
	call L_6CCB		;6c9e
	ret c			;6ca1
	ld a,(ix+001h)		;6ca2
	rla			;6ca5
	jr c,L_6CAC		;6ca6
	call L_6CBD		;6ca8
	ret c			;6cab
L_6CAC:
	inc (ix+001h)		;6cac
L_6CAF:
	ret			;6caf
L_6CB0:
	call L_6CCB		;6cb0
	ret nc			;6cb3
	ld a,01eh		;6cb4
	call 04ae4h		;6cb6
	dec (ix+001h)		;6cb9
	ret			;6cbc
L_6CBD:
	ld a,(ix+002h)		;6cbd
	sub 008h		;6cc0
	ld l,a			;6cc2
	ld h,(ix+003h)		;6cc3
	ld b,(ix+005h)		;6cc6
	jr L_6CDD		;6cc9
L_6CCB:
	ld a,(ix+004h)		;6ccb
	rla			;6cce
	rla			;6ccf
	rla			;6cd0
	and 0f8h		;6cd1
	add a,(ix+002h)		;6cd3
	ld l,a			;6cd6
	ld h,(ix+003h)		;6cd7
	ld b,(ix+005h)		;6cda
L_6CDD:
	call 05c92h		;6cdd
	ld c,0a1h		;6ce0
L_6CE2:
	ld a,(hl)			;6ce2
	or a			;6ce3
	jr z,L_6CE8		;6ce4
	cp c			;6ce6
	ret c			;6ce7
L_6CE8:
	inc l			;6ce8
	djnz L_6CE2		;6ce9
	xor a			;6ceb
	ret			;6cec
L_6CED:
	call L_6878		;6ced
	ret nz			;6cf0
	call L_6AAF		;6cf1
	ret nc			;6cf4
	call 0415bh		;6cf5
	ld ix,0e580h		;6cf8
	ld b,010h		;6cfc
L_6CFE:
	push bc			;6cfe
	ld a,(ix+000h)		;6cff
	or a			;6d02
	call nz,L_6D11		;6d03
	ld bc,00008h		;6d06
	add ix,bc		;6d09
	pop bc			;6d0b
	djnz L_6CFE		;6d0c
	jp 04157h		;6d0e
L_6D11:
	ld de,0a581h		;6d11
	call 04b60h		;6d14
	ld h,(ix+003h)		;6d17
	ld l,(ix+002h)		;6d1a
	ld c,(ix+004h)		;6d1d
	ld b,(ix+005h)		;6d20
	jp 05327h		;6d23
L_6D26:
	ld (ix+000h),000h		;6d26
	ld e,(ix+002h)		;6d2a
	ld d,(ix+003h)		;6d2d
	call 08ba1h		;6d30
	ld a,013h		;6d33
	call 04ae4h		;6d35
	ld h,(ix+003h)		;6d38
	ld l,(ix+002h)		;6d3b
	ld c,(ix+004h)		;6d3e
	ld b,(ix+005h)		;6d41
	jp 0530ch		;6d44
L_6D47:
	ld a,(0e3c0h)		;6d47
	or a			;6d4a
	ret nz			;6d4b
	call L_656C		;6d4c
	ld a,(0e3d0h)		;6d4f
	or a			;6d52
	ret nz			;6d53
	ld a,(0e201h)		;6d54
	cp 009h		;6d57
	jr c,L_6D60		;6d59
	xor a			;6d5b
	ld (0e354h),a		;6d5c
	ret			;6d5f
L_6D60:
	call L_6F54		;6d60
	ld a,(0e3beh)		;6d63
	or a			;6d66
	call nz,L_701A		;6d67
	call L_6D9B		;6d6a
	ld a,(0e201h)		;6d6d
	cp 007h		;6d70
	jr nz,L_6D7C		;6d72
	ld a,(0e204h)		;6d74
	cp 002h		;6d77
	jp z,L_6DC2		;6d79
L_6D7C:
	call L_6DA9		;6d7c
	ret nz			;6d7f
	call L_6E1D		;6d80
	ld a,(0e390h)		;6d83
	and a			;6d86
	ret nz			;6d87
	ld a,(0e353h)		;6d88
	and a			;6d8b
	jr z,L_6DC2		;6d8c
	ld hl,0e352h		;6d8e
	ld a,00bh		;6d91
	sub (hl)			;6d93
	ld hl,0e392h		;6d94
	cp (hl)			;6d97
	ret c			;6d98
	jr L_6DC2		;6d99
L_6D9B:
	ld a,(0e201h)		;6d9b
	dec a			;6d9e
	ret nz			;6d9f
	call 04137h		;6da0
	call 0b11ah		;6da3
	jp 04157h		;6da6
L_6DA9:
	ld hl,0e354h		;6da9
	ld a,(hl)			;6dac
	and a			;6dad
	jr z,L_6DB4		;6dae
	dec (hl)			;6db0
L_6DB1:
	or 0ffh		;6db1
	ret			;6db3
L_6DB4:
	ld a,(0e340h)		;6db4
	and a			;6db7
	ret nz			;6db8
	ld a,(0e204h)		;6db9
	cp 002h		;6dbc
	jr nc,L_6DB1		;6dbe
	xor a			;6dc0
	ret			;6dc1
L_6DC2:
	call 0415bh		;6dc2
	ld a,(0e201h)		;6dc5
	ld de,099c7h		;6dc8
	call 04b60h		;6dcb
	ld hl,(0e203h)		;6dce
	ld a,l			;6dd1
	rr h		;6dd2
	rra			;6dd4
	rr h		;6dd5
	rra			;6dd7
	rra			;6dd8
	rra			;6dd9
	rra			;6dda
	and 01fh		;6ddb
	call 0407fh		;6ddd
	ld a,(de)			;6de0
	push af			;6de1
	rra			;6de2
	rra			;6de3
	rra			;6de4
	rra			;6de5
	and 00fh		;6de6
	push af			;6de8
	call 04157h		;6de9
	pop af			;6dec
	call L_6E02		;6ded
	pop bc			;6df0
	ld a,(0e228h)		;6df1
	cp 00ah		;6df4
	jp c,04157h		;6df6
	ld a,b			;6df9
	and 00fh		;6dfa
	call L_6E02		;6dfc
	jp 04157h		;6dff
L_6E02:
	dec a			;6e02
	ret m			;6e03
	call 04084h		;6e04

; ----------------------------------------------------------------------
; DATOS tabla_6E07: 11 destinos del despachador p00:4084 (call en p01:6E04, el
;   indice en A): 6FC4, 701A, 7216, 7151, 71EA, 71A2, 7106, 718A, 7065, 709F,
;   70CE; lo leen p01:6E04 (22 bytes)
;   0x6e07..0x6e1d  (22 bytes)
DATA_tabla_6E07:
	defw 06fc4h,0701ah,07216h,07151h,071eah,071a2h,07106h,0718ah	; 6e07
	defw 07065h,0709fh,070ceh	; 6e17  -> L_7065 L_709F L_70CE

; ======================================================================
; CODIGO 0x6e1d..0x6ec1  (164 bytes)
; ======================================================================


L_6E1D:
	ld a,(0e201h)		;6e1d
	cp 008h		;6e20
	ret nc			;6e22
	ld hl,0e390h		;6e23
	ld a,(hl)			;6e26
	and a			;6e27
	jr z,L_6E71		;6e28
	dec a			;6e2a
	jr z,L_6E69		;6e2b
	inc l			;6e2d
	dec (hl)			;6e2e
	ret nz			;6e2f
	ld a,(0e393h)		;6e30
	ld b,004h		;6e33
	cp 00bh		;6e35
	jr z,L_6E3B		;6e37
	ld b,006h		;6e39
L_6E3B:
	ld (hl),b			;6e3b
	inc l			;6e3c
	dec (hl)			;6e3d
	jr nz,L_6E44		;6e3e
	dec l			;6e40
	dec l			;6e41
	ld (hl),000h		;6e42
L_6E44:
	ld hl,0e37eh		;6e44
	inc (hl)			;6e47
	ld b,(hl)			;6e48
	ld a,(0e395h)		;6e49
	ld e,a			;6e4c
	ld d,0f8h		;6e4d
	ld a,(0e393h)		;6e4f
	ld c,000h		;6e52
	call 04d1eh		;6e54
	ld a,(0e353h)		;6e57
	and a			;6e5a
	ret nz			;6e5b
	ld hl,0e37eh		;6e5c
	dec (hl)			;6e5f
	ld hl,0e392h		;6e60
	inc (hl)			;6e63
	dec l			;6e64
	dec l			;6e65
	ld (hl),001h		;6e66
	ret			;6e68
L_6E69:
	ld a,(0e352h)		;6e69
	cp 007h		;6e6c
	ret nc			;6e6e
	inc (hl)			;6e6f
	ret			;6e70
L_6E71:
	ld a,(0e320h)		;6e71
	and a			;6e74
	ret z			;6e75
	ld hl,06ec1h		;6e76
	ld a,(0e201h)		;6e79
	call 0407ah		;6e7c
	ld d,000h		;6e7f
	ld e,(hl)			;6e81
	ld hl,(0e203h)		;6e82
	rst 20h			;6e85
	ret nc			;6e86
	ld a,l			;6e87
	and 007h		;6e88
	ret nz			;6e8a
	ld hl,00101h		;6e8b
	ld (0e390h),hl		;6e8e
	ld hl,0e396h		;6e91
	ld a,(hl)			;6e94
	inc a			;6e95
	jr nz,L_6E99		;6e96
	inc a			;6e98
L_6E99:
	ld (hl),a			;6e99
	ld a,(0e201h)		;6e9a
	ld hl,06ef2h		;6e9d
	call 05ca6h		;6ea0
	ld (0e393h),a		;6ea3
	call L_6ED5		;6ea6
	ld (0e395h),a		;6ea9
	ld a,006h		;6eac
	ld (0e392h),a		;6eae
	ld a,0ffh		;6eb1
	ld (0e37eh),a		;6eb3
	xor a			;6eb6
	call 089a8h		;6eb7
	jr nc,$+15		;6eba
	xor a			;6ebc
	ld (0e390h),a		;6ebd
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


L_6EC9:
	ld a,(0e396h)		;6ec9
	ld (hl),a			;6ecc
	inc l			;6ecd
	ld a,(0e392h)		;6ece
	ld (hl),a			;6ed1
	inc l			;6ed2
	ld (hl),a			;6ed3
	ret			;6ed4
L_6ED5:
	ld hl,0e363h		;6ed5
	inc (hl)			;6ed8
	ld a,(0e393h)		;6ed9
	cp 00bh		;6edc
	jr z,L_6EE9		;6ede
	ld a,(hl)			;6ee0
	and 001h		;6ee1
	ld a,030h		;6ee3
	ret z			;6ee5
	xor 040h		;6ee6
	ret			;6ee8
L_6EE9:
	ld a,(hl)			;6ee9
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


L_6EFF:
	exx			;6eff
	ld hl,06f22h		;6f00
	exx			;6f03
	jp L_6F17		;6f04
L_6F07:
	exx			;6f07
	ld hl,06f32h		;6f08
	exx			;6f0b
	jp L_6F14		;6f0c
L_6F0F:
	exx			;6f0f
	ld hl,06f22h		;6f10
	exx			;6f13
L_6F14:
	ld hl,0e356h		;6f14
L_6F17:
	ld a,(hl)			;6f17
	and 00fh		;6f18
	inc (hl)			;6f1a
	exx			;6f1b
	call 05ca6h		;6f1c
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


L_6F42:
	ld a,(0e201h)		;6f42
	cp 009h		;6f45
	ret nc			;6f47
L_6F48:
	call L_6F64		;6f48
	jr z,L_6F48		;6f4b
	ret c			;6f4d
	ld hl,0e37ch		;6f4e
	inc (hl)			;6f51
	jr L_6F48		;6f52
L_6F54:
	ld a,(0e320h)		;6f54
	and a			;6f57
	ret z			;6f58
	ld a,0f8h		;6f59
	ld (0f004h),a		;6f5b
L_6F5E:
	call L_6F64		;6f5e
	jr z,L_6F5E		;6f61
	ret			;6f63
L_6F64:
	call 0415bh		;6f64
	ld a,(0e37ch)		;6f67
	ld hl,09a67h		;6f6a
	call L_6F9A		;6f6d
	jp nz,04157h		;6f70
	ld hl,0e37ch		;6f73
	inc (hl)			;6f76
	ld e,b			;6f77
	srl a		;6f78
	srl a		;6f7a
	ld b,a			;6f7c
	ld a,(0f004h)		;6f7d
	ld d,a			;6f80
	ld a,c			;6f81
	ld l,a			;6f82
	and 03fh		;6f83
	cp c			;6f85
	ld c,000h		;6f86
	jr z,L_6F90		;6f88
	inc c			;6f8a
	rl l		;6f8b
	jr nc,L_6F90		;6f8d
	inc c			;6f8f
L_6F90:
	push af			;6f90
	call 04157h		;6f91
	pop af			;6f94
	call 04d1eh		;6f95
	xor a			;6f98
	ret			;6f99
L_6F9A:
	push af			;6f9a
	ld a,(0e201h)		;6f9b
	call 04b67h		;6f9e
	pop af			;6fa1
	add a,a			;6fa2
	add a,a			;6fa3
	call 0407fh		;6fa4
	ex de,hl			;6fa7
	ld e,(hl)			;6fa8
	inc hl			;6fa9
	ld a,(hl)			;6faa
	cp e			;6fab
	jr nz,L_6FB5		;6fac
	cp 0ffh		;6fae
	jr nz,L_6FB5		;6fb0
	or a			;6fb2
	scf			;6fb3
	ret			;6fb4
L_6FB5:
	and 003h		;6fb5
	ld d,a			;6fb7
	ld a,(hl)			;6fb8
	inc hl			;6fb9
	ld c,(hl)			;6fba
	inc hl			;6fbb
	ld b,(hl)			;6fbc
	ld hl,(0e203h)		;6fbd
	and a			;6fc0
	sbc hl,de		;6fc1
	ret			;6fc3
L_6FC4:
	ld hl,0e373h		;6fc4
	ld a,(hl)			;6fc7
	and a			;6fc8
	jr z,L_6FE7		;6fc9
	inc l			;6fcb
	dec (hl)			;6fcc
	ret nz			;6fcd
	ld (hl),008h		;6fce
	dec l			;6fd0
	dec (hl)			;6fd1
	ld b,000h		;6fd2
	ld d,0f0h		;6fd4
	ld a,(hl)			;6fd6
	and 003h		;6fd7
	ld hl,07006h		;6fd9
	call 0407ah		;6fdc
	ld e,(hl)			;6fdf
	ld c,000h		;6fe0
	ld a,004h		;6fe2
	jp 04d1eh		;6fe4
L_6FE7:
	ld de,0700ah		;6fe7
	ld a,(0e228h)		;6fea
	call 0407fh		;6fed
	ld a,(de)			;6ff0
	ld (hl),a			;6ff1
	inc l			;6ff2
	ld c,070h		;6ff3
	call L_6FFD		;6ff5
	ld hl,0e3b3h		;6ff8
	inc (hl)			;6ffb
	ret			;6ffc
L_6FFD:
	ld a,(0e228h)		;6ffd
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


L_701A:
	ld hl,0e36fh		;701a
	ld a,(hl)			;701d
	and a			;701e
	jr z,L_704F		;701f
	inc l			;7021
	dec (hl)			;7022
	ret nz			;7023
	ld a,(0e228h)		;7024
	add a,a			;7027
	add a,a			;7028
	sub 070h		;7029
	neg		;702b
	ld (hl),a			;702d
	dec l			;702e
	dec (hl)			;702f
	ld a,(hl)			;7030
	and 007h		;7031
	ld b,a			;7033
	ld hl,07055h		;7034
	ld a,(0e201h)		;7037
	or a			;703a
	jr nz,L_7040		;703b
	ld hl,0705dh		;703d
L_7040:
	ld a,b			;7040
	call 05ca6h		;7041
	ld e,a			;7044
	ld d,000h		;7045
	call L_6F0F		;7047
	ld a,005h		;704a
	jp 04d1eh		;704c
L_704F:
	ld (hl),008h		;704f
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


L_7065:
	ld hl,0e368h		;7065
	dec (hl)			;7068
	ret p			;7069
	ld hl,0e38eh		;706a
	inc (hl)			;706d
	ld a,(hl)			;706e
	and 007h		;706f
	ld hl,07097h		;7071
	call 05ca6h		;7074
	ld hl,0e368h		;7077
	ld (hl),a			;707a
	cp 018h		;707b
	jr c,L_7086		;707d
	ld a,(0e228h)		;707f
	sub (hl)			;7082
	neg		;7083
	ld (hl),a			;7085
L_7086:
	ld a,r		;7086
	and 07fh		;7088
	add a,010h		;708a
	ld e,a			;708c
	ld d,0f8h		;708d
	ld bc,00000h		;708f
	ld a,019h		;7092
	jp 04d1eh		;7094

; ----------------------------------------------------------------------
; DATOS tabla_7097: 8 bytes que p01:706E lee con (HL) & 7; lo leen p01:7074 (8
;   bytes)
;   0x7097..0x709f  (8 bytes)
DATA_tabla_7097:
	defb 008h,003h,006h,030h,005h,004h,007h,006h	; 7097  ...0....

; ======================================================================
; CODIGO 0x709f..0x70c6  (39 bytes)
; ======================================================================


L_709F:
	ld hl,0e37fh		;709f
	dec (hl)			;70a2
	ret p			;70a3
	ld a,(0e228h)		;70a4
	sra a		;70a7
	neg		;70a9
	add a,014h		;70ab
	ld (hl),a			;70ad
	call L_637B		;70ae
	and 007h		;70b1
	ld hl,070c6h		;70b3
	call 05ca6h		;70b6
	ld e,a			;70b9
	ld d,0f8h		;70ba
	call L_6F07		;70bc
	ld b,000h		;70bf
	ld a,00ch		;70c1
	jp 04d1eh		;70c3

; ----------------------------------------------------------------------
; DATOS tabla_70C6: 8 bytes que p01:70B1 lee con A & 7; lo leen p01:70B6 (8
;   bytes)
;   0x70c6..0x70ce  (8 bytes)
DATA_tabla_70C6:
	defb 030h,038h,040h,048h,050h,058h,060h,070h	; 70c6  08@HPX`p

; ======================================================================
; CODIGO 0x70ce..0x7141  (115 bytes)
; ======================================================================


L_70CE:
	ld hl,0e39dh		;70ce
	dec (hl)			;70d1
	ret p			;70d2
	ld a,(0e228h)		;70d3
	cp 006h		;70d6
	ld a,040h		;70d8
	jr nc,L_70DE		;70da
	ld a,050h		;70dc
L_70DE:
	ld (hl),a			;70de
	call L_637B		;70df
L_70E2:
	and 007h		;70e2
	ld b,a			;70e4
	ld hl,070c6h		;70e5
	call 05ca6h		;70e8
	ld e,a			;70eb
	ld a,(0e404h)		;70ec
	sub e			;70ef
	jr nc,L_70F4		;70f0
	neg		;70f2
L_70F4:
	cp 018h		;70f4
	jr nc,L_70FC		;70f6
	ld a,b			;70f8
	inc a			;70f9
	jr L_70E2		;70fa
L_70FC:
	ld d,0f8h		;70fc
	ld bc,00000h		;70fe
	ld a,008h		;7101
	jp 04d1eh		;7103
L_7106:
	ld hl,0e364h		;7106
	ld a,(hl)			;7109
	dec (hl)			;710a
	and a			;710b
	ret nz			;710c
	ld a,(0e406h)		;710d
	sub 030h		;7110
	cp 090h		;7112
	ret nc			;7114
	ld a,(0e404h)		;7115
	cp 0a0h		;7118
	ret z			;711a
	ld a,r		;711b
	and 03fh		;711d
	add a,060h		;711f
	ld (hl),a			;7121
	ld b,008h		;7122
L_7124:
	push bc			;7124
	ld a,b			;7125
	ld hl,0713fh		;7126
	call 04b67h		;7129
	ld a,(0e404h)		;712c
	add a,e			;712f
	ld e,a			;7130
	ld a,(0e406h)		;7131
	add a,d			;7134
	ld d,a			;7135
	ld c,000h		;7136
	ld a,014h		;7138
	call 04d1eh		;713a
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


L_7151:
	ld hl,0e361h		;7151
	dec (hl)			;7154
	ret p			;7155
	ld a,r		;7156
	and 01fh		;7158
	add a,040h		;715a
	ld (hl),a			;715c
	dec l			;715d
	inc (hl)			;715e
	ld a,(hl)			;715f
	and 003h		;7160
	ld bc,00600h		;7162
	jr nz,L_7168		;7165
	inc c			;7167
L_7168:
	ld de,0f810h		;7168
	ld a,(0e201h)		;716b
	cp 007h		;716e
	jr nz,L_717A		;7170
	ld a,(0e360h)		;7172
	and 007h		;7175
	jr nz,L_717A		;7177
	ld d,a			;7179
L_717A:
	push bc			;717a
	push de			;717b
	ld a,00dh		;717c
	call 04d1eh		;717e
	pop de			;7181
	ld a,e			;7182
	add a,018h		;7183
	ld e,a			;7185
	pop bc			;7186
	djnz L_717A		;7187
	ret			;7189
L_718A:
	ld hl,0e378h		;718a
	dec (hl)			;718d
	ret p			;718e
	ld (hl),050h		;718f
	ld de,0f830h		;7191
	call L_719A		;7194
	ld de,0f870h		;7197
L_719A:
	ld bc,00000h		;719a
	ld a,016h		;719d
	jp 04d1eh		;719f
L_71A2:
	ld hl,0e386h		;71a2
	dec (hl)			;71a5
	ret p			;71a6
	ld a,(0e228h)		;71a7
	cp 006h		;71aa
	ld a,00ah		;71ac
	jr c,L_71B2		;71ae
	ld a,006h		;71b0
L_71B2:
	ld (hl),a			;71b2
	inc hl			;71b3
	inc (hl)			;71b4
	ld a,(hl)			;71b5
	and 003h		;71b6
	jr nz,L_71C0		;71b8
	dec hl			;71ba
	ld c,060h		;71bb
	jp L_6FFD		;71bd
L_71C0:
	and 001h		;71c0
	or a			;71c2
	ld de,01030h		;71c3
	jr z,L_71CB		;71c6
	ld de,09070h		;71c8
L_71CB:
	ld a,(0e201h)		;71cb
	cp 005h		;71ce
	jr nz,L_71D3		;71d0
	ld e,d			;71d2
L_71D3:
	ld d,0f8h		;71d3
	ld bc,00001h		;71d5
	ld a,(0e201h)		;71d8
	cp 005h		;71db
	jr z,L_71E5		;71dd
	ld hl,0e38fh		;71df
	call L_6EFF		;71e2
L_71E5:
	ld a,011h		;71e5
	jp 04d1eh		;71e7
L_71EA:
	ld a,(0e20ah)		;71ea
	or a			;71ed
	ret z			;71ee
	ld hl,0e379h		;71ef
	dec (hl)			;71f2
	ret p			;71f3
	ld (hl),010h		;71f4
	inc hl			;71f6
	inc (hl)			;71f7
	ld a,(hl)			;71f8
	and 003h		;71f9
	jr nz,L_7203		;71fb
	dec hl			;71fd
	ld c,070h		;71fe
	jp L_6FFD		;7200
L_7203:
	and 001h		;7203
	or a			;7205
	ld e,020h		;7206
	jr z,L_720C		;7208
	ld e,090h		;720a
L_720C:
	ld d,0f8h		;720c
	ld bc,00001h		;720e
	ld a,00fh		;7211
	jp 04d1eh		;7213
L_7216:
	ld hl,0e382h		;7216
	ld a,(hl)			;7219
	and a			;721a
	jp z,L_6FE7		;721b
	inc l			;721e
	dec (hl)			;721f
	ret nz			;7220
	ld (hl),001h		;7221
	ld a,(0e35bh)		;7223
	inc a			;7226
	and 007h		;7227
	ld (0e35bh),a		;7229
	ld hl,07240h		;722c
	call 05ca6h		;722f
	ld hl,0e382h		;7232
	dec (hl)			;7235
	ld e,a			;7236
	ld d,0f8h		;7237
	ld c,000h		;7239
	ld a,009h		;723b
	jp 04d1eh		;723d

; ----------------------------------------------------------------------
; DATOS tabla_7240: 8 bytes que p01:7226 lee con 0xE35B; lo leen p01:722F (8
;   bytes)
;   0x7240..0x7248  (8 bytes)
DATA_tabla_7240:
	defb 010h,090h,050h,030h,080h,060h,028h,070h	; 7240  ..P0.`(p

; ======================================================================
; CODIGO 0x7248..0x72df  (151 bytes)
; ======================================================================


L_7248:
	ld a,(0e201h)		;7248
	ld hl,0a0b7h		;724b
	sub 007h		;724e
	ret z			;7250
	ld hl,0a0dbh		;7251
	sub 002h		;7254
	ret z			;7256
	ld hl,0a14dh		;7257
	dec a			;725a
	ret z			;725b
	ld hl,0a1e0h		;725c
	dec a			;725f
	ret			;7260
L_7261:
	call L_7248		;7261
	ret nz			;7264
	ld (0f010h),hl		;7265
	call L_728B		;7268
	jr z,L_7261		;726b
	ret c			;726d
	ld hl,0e3b1h		;726e
	inc (hl)			;7271
	jr L_7261		;7272
L_7274:
	call L_7248		;7274
	ret nz			;7277
	ld (0f010h),hl		;7278
	ld a,(0e320h)		;727b
	and a			;727e
	ret z			;727f
	ld a,0f8h		;7280
	ld (0f004h),a		;7282
L_7285:
	call L_728B		;7285
	jr z,L_7285		;7288
	ret			;728a
L_728B:
	call L_72B2		;728b
	ret nz			;728e
	ld hl,0e3b1h		;728f
	inc (hl)			;7292
	ld a,b			;7293
	and 0f8h		;7294
	ld e,a			;7296
	ld a,(0f004h)		;7297
	ld d,a			;729a
	bit 3,c		;729b
	jp z,L_72AC		;729d
	ld a,c			;72a0
	and 007h		;72a1
	add a,029h		;72a3
	ld c,000h		;72a5
L_72A7:
	call 04d1eh		;72a7
	xor a			;72aa
	ret			;72ab
L_72AC:
	inc c			;72ac
	ld a,02eh		;72ad
	jp L_72A7		;72af
L_72B2:
	call 0415bh		;72b2
	ld a,(0e3b1h)		;72b5
	ld b,a			;72b8
	add a,a			;72b9
	add a,b			;72ba
	ld l,a			;72bb
	ld h,000h		;72bc
	ld de,(0f010h)		;72be
	add hl,de			;72c2
	ld c,(hl)			;72c3
	inc hl			;72c4
	ld e,(hl)			;72c5
	inc hl			;72c6
	ld b,(hl)			;72c7
	ld a,b			;72c8
	and 007h		;72c9
	ld d,a			;72cb
	call 04157h		;72cc
	ld hl,(0e203h)		;72cf
	or a			;72d2
	sbc hl,de		;72d3
	ret			;72d5
L_72D6:
	ld a,(0e34bh)		;72d6
	or a			;72d9
	ret z			;72da
	dec a			;72db
	call 04084h		;72dc

; ----------------------------------------------------------------------
; DATOS tabla_72DF: 4 destinos del despachador p00:4084 (call en p01:72DC, el
;   indice en A): 72E7, 731E, 7427, 7438; lo leen p01:72DC (8 bytes)
;   0x72df..0x72e7  (8 bytes)
DATA_tabla_72DF:
	defw 072e7h,0731eh,07427h,07438h	; 72df  -> L_72E7 L_731E L_7427 L_7438

; ======================================================================
; CODIGO 0x72e7..0x730e  (39 bytes)
; ======================================================================


L_72E7:
	ld a,002h		;72e7
	ld (0e34ch),a		;72e9
	ld hl,0730eh		;72ec
	ld de,0ea70h		;72ef
	ld bc,00010h		;72f2
	ldir		;72f5
	ld hl,(0ea71h)		;72f7
	call 05c92h		;72fa
	ld (0ea76h),hl		;72fd
	ld hl,(0ea79h)		;7300
	call 05c92h		;7303
	ld (0ea7eh),hl		;7306
L_7309:
	ld hl,0e34bh		;7309
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


L_731E:
	ld a,(0e34ch)		;731e
	and a			;7321
	jp z,L_73AA		;7322
	ld hl,0ea70h		;7325
	call L_73E0		;7328
	ld hl,0ea78h		;732b
	call L_73E0		;732e
	ld a,(0e1c3h)		;7331
	ld c,a			;7334
	rra			;7335
	ret c			;7336
	ld a,r		;7337
	and 01fh		;7339
	add a,070h		;733b
	ld b,a			;733d
	ld a,(0e406h)		;733e
	cp b			;7341
	jr nc,L_7375		;7342
	ld a,r		;7344
	and 01eh		;7346
	ld hl,073b8h		;7348
	call 0407ah		;734b
	ld e,(hl)			;734e
	inc hl			;734f
	ld d,(hl)			;7350
	bit 1,c		;7351
	call nz,05cadh		;7353
	ld (0f012h),de		;7356
	ld hl,0f900h		;735a
	ld (0f014h),hl		;735d
	ld hl,073d8h		;7360
	ld a,r		;7363
	and 006h		;7365
	ld c,a			;7367
	ld b,000h		;7368
	add hl,bc			;736a
	ld e,(hl)			;736b
	inc hl			;736c
	ld d,(hl)			;736d
L_736E:
	ld a,032h		;736e
	ld c,000h		;7370
	jp 04d1eh		;7372
L_7375:
	ld a,r		;7375
	and 01eh		;7377
	ld hl,073b8h		;7379
	call 0407ah		;737c
	ld e,(hl)			;737f
	inc hl			;7380
	ld d,(hl)			;7381
	bit 1,c		;7382
	call nz,05cadh		;7384
	ld a,(0e404h)		;7387
	cp 04dh		;738a
	ld hl,09747h		;738c
	jr c,L_7393		;738f
	ld l,05bh		;7391
L_7393:
	ex de,hl			;7393
	ld (0f014h),hl		;7394
	ld a,(0e404h)		;7397
	cp 04dh		;739a
	ld hl,00500h		;739c
	jr nc,L_73A4		;739f
	ld hl,0fb00h		;73a1
L_73A4:
	ld (0f012h),hl		;73a4
	jp L_736E		;73a7
L_73AA:
	ld de,00100h		;73aa
	call 05b04h		;73ad
	ld a,05ah		;73b0
	ld (0e349h),a		;73b2
	jp L_7309		;73b5

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


L_73E0:
	ld a,(hl)			;73e0
	or a			;73e1
	ret z			;73e2
	ld a,l			;73e3
	add a,005h		;73e4
	ld l,a			;73e6
	dec (hl)			;73e7
	ret nz			;73e8
	dec l			;73e9
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
	ld a,(hl)			;73f8
	xor 001h		;73f9
	ld (hl),a			;73fb
	inc l			;73fc
	inc l			;73fd
	ld e,(hl)			;73fe
	inc l			;73ff
	ld d,(hl)			;7400
	ld hl,07417h		;7401
	add a,a			;7404
	add a,a			;7405
	call 0407ah		;7406
	ldi		;7409
	ldi		;740b
	ld a,01eh		;740d
	call 0407fh		;740f
	ldi		;7412
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


L_7427:
	ld hl,0e349h		;7427
	dec (hl)			;742a
	ret nz			;742b
	call L_7918		;742c
	ld hl,00001h		;742f
	ld (0e3aah),hl		;7432
	jp L_7309		;7435
L_7438:
	call 04137h		;7438
	call 0a2a2h		;743b
	call 04157h		;743e
	ld a,(0e3aeh)		;7441
	and a			;7444
	ret z			;7445
	xor a			;7446
	ld (0e3aah),a		;7447
	inc a			;744a
	ld (0e348h),a		;744b
	ret			;744e
L_744F:
	ld (ix+02fh),000h		;744f
	ld (ix+002h),004h		;7453
	ld de,(0f014h)		;7457
	ld hl,(0f012h)		;745b
	jp 04f26h		;745e
L_7461:
	dec (ix+002h)		;7461
	jr nz,L_7478		;7464
	ld (ix+002h),004h		;7466
	ld a,(ix+031h)		;746a
	cp 003h		;746d
	ld a,003h		;746f
	jr nz,L_7475		;7471
	ld a,009h		;7473
L_7475:
	ld (ix+031h),a		;7475
L_7478:
	ld a,(0e305h)		;7478
	ld c,a			;747b
	ld l,(ix+004h)		;747c
	ld h,(ix+006h)		;747f
	call 05c92h		;7482
	ld a,(hl)			;7485
	and a			;7486
	jr z,L_748D		;7487
	cp c			;7489
	jp c,L_6514		;748a
L_748D:
	bit 7,(ix+008h)		;748d
	ld de,00020h		;7491
	jr nz,L_7499		;7494
	ld de,0ffe0h		;7496
L_7499:
	add hl,de			;7499
	ld a,(hl)			;749a
	or a			;749b
	ret z			;749c
	cp c			;749d
	jp c,L_6514		;749e
	ret			;74a1
L_74A2:
	ld a,(0e3c0h)		;74a2
	dec a			;74a5
	ret m			;74a6
	call 04084h		;74a7

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


L_74C4:
	call L_76E5		;74c4
	ret nz			;74c7
	ld a,(0e327h)		;74c8
	or a			;74cb
	ret z			;74cc
L_74CD:
	ld hl,00001h		;74cd
	ld (0e3c3h),hl		;74d0
	ld a,0f0h		;74d3
	call 04ae4h		;74d5
	ld a,037h		;74d8
	call 04ae4h		;74da
L_74DD:
	ld hl,0e3c0h		;74dd
	inc (hl)			;74e0
	ret			;74e1
L_74E2:
	ld hl,0e3c3h		;74e2
	dec (hl)			;74e5
	ret z			;74e6
	ld (hl),00ah		;74e7
	inc l			;74e9
	ld a,(hl)			;74ea
	inc (hl)			;74eb
	add a,a			;74ec
	add a,a			;74ed
	add a,a			;74ee
	ld hl,07738h		;74ef
	call 0407ah		;74f2
	ld de,0ee2ch		;74f5
	ld bc,00004h		;74f8
	ldir		;74fb
	ld de,0ee4ch		;74fd
	ld bc,00004h		;7500
	ldir		;7503
	ld a,(0e3c4h)		;7505
	cp 004h		;7508
	ret c			;750a
	ld a,03ch		;750b
	jr L_755F		;750d
L_750F:
	ld hl,0e3c3h		;750f
	dec (hl)			;7512
	jr z,L_753A		;7513
	bit 1,(hl)		;7515
	ld a,000h		;7517
	jr z,L_751C		;7519
	inc a			;751b
L_751C:
	add a,a			;751c
	add a,a			;751d
	add a,a			;751e
	add a,a			;751f
	ld hl,07758h		;7520
	call 0407ah		;7523
	ld a,004h		;7526
	ld de,0ee10h		;7528
L_752B:
	ld bc,00004h		;752b
	ldir		;752e
	ex de,hl			;7530
	ld bc,0001ch		;7531
	add hl,bc			;7534
	ex de,hl			;7535
	dec a			;7536
	jr nz,L_752B		;7537
	ret			;7539
L_753A:
	xor a			;753a
	call L_751C		;753b
	ld hl,0000ah		;753e
	jr L_74CD		;7541
L_7543:
	ld hl,0e3c3h		;7543
	dec (hl)			;7546
	ret nz			;7547
	ld (hl),004h		;7548
	inc l			;754a
	ld c,(hl)			;754b
	inc (hl)			;754c
	ld b,000h		;754d
	ld hl,07565h		;754f
	add hl,bc			;7552
	ld a,(hl)			;7553
	call L_751C		;7554
	ld a,(0e3c4h)		;7557
	cp 004h		;755a
	ret c			;755c
	ld a,01eh		;755d
L_755F:
	ld (0e3c3h),a		;755f
	jp L_74DD		;7562

; ----------------------------------------------------------------------
; DATOS tabla_7565: 4 bytes que p01:7543 lee con 0xE3C4; lo leen p01:7552 (4
;   bytes)
;   0x7565..0x7569  (4 bytes)
DATA_tabla_7565:
	defb 002h,003h,004h,001h	; 7565

; ======================================================================
; CODIGO 0x7569..0x7725  (444 bytes)
; ======================================================================


L_7569:
	ld hl,0e3c3h		;7569
	dec (hl)			;756c
	ret nz			;756d
	ld hl,0eee4h		;756e
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
	call 04b17h		;7584
	ld hl,07725h		;7587
	ld de,0ef0ah		;758a
	ld bc,0000ch		;758d
	ldir		;7590
	ld a,01eh		;7592
	jr $-53		;7594
L_7596:
	ld hl,0e3c3h		;7596
	dec (hl)			;7599
	ret nz			;759a
	ld a,(0e444h)		;759b
	dec a			;759e
	jr z,L_75B3		;759f
	dec a			;75a1
	jr z,L_75C5		;75a2
	ld hl,07731h		;75a4
	ld de,0ef4ch		;75a7
	ld bc,00007h		;75aa
	ldir		;75ad
	ld a,01eh		;75af
	jr $-82		;75b1
L_75B3:
	ld a,08bh		;75b3
	ld hl,03458h		;75b5
	ld de,0ef4ch		;75b8
	call L_7690		;75bb
	call L_76CF		;75be
	ld a,008h		;75c1
	jr L_75D5		;75c3
L_75C5:
	ld a,08bh		;75c5
	ld hl,03458h		;75c7
	ld de,0ef47h		;75ca
	call L_7690		;75cd
	call L_76CF		;75d0
	ld a,009h		;75d3
L_75D5:
	call L_75EB		;75d5
	ld a,03ch		;75d8
	ld (0e3c3h),a		;75da
	ret			;75dd
L_75DE:
	ld hl,0e3c3h		;75de
	dec (hl)			;75e1
	ret nz			;75e2
L_75E3:
	ld hl,00001h		;75e3
	ld (0e3aah),hl		;75e6
	ld a,00ch		;75e9
L_75EB:
	ld (0e3c0h),a		;75eb
	ret			;75ee
L_75EF:
	ld hl,0e3c3h		;75ef
	dec (hl)			;75f2
	jr z,L_760F		;75f3
L_75F5:
	ld hl,(0e3c5h)		;75f5
	call 04a1dh		;75f8
	ld a,(0e3c3h)		;75fb
	bit 2,a		;75fe
	ld a,00bh		;7600
	jr z,L_7606		;7602
	ld a,00dh		;7604
L_7606:
	exx			;7606
	out (c),a		;7607
	exx			;7609
	exx			;760a
	inc a			;760b
	out (c),a		;760c
	ret			;760e
L_760F:
	call 053a3h		;760f
	jr L_75E3		;7612
L_7614:
	ld hl,0e3c3h		;7614
	dec (hl)			;7617
	jr nz,L_75F5		;7618
	ld a,01eh		;761a
	jp L_755F		;761c
L_761F:
	ld hl,0e3c3h		;761f
	dec (hl)			;7622
	ret nz			;7623
	ld a,093h		;7624
	ld hl,03498h		;7626
	ld de,0ef51h		;7629
	call L_7690		;762c
	call L_76CF		;762f
	ld a,00bh		;7632
	jr L_75D5		;7634
L_7636:
	ld hl,0e3c3h		;7636
	dec (hl)			;7639
	jr nz,L_75F5		;763a
	jr L_760F		;763c
L_763E:
	call 04137h		;763e
	call 0a2a2h		;7641
	call 04157h		;7644
	ld a,(0e3aeh)		;7647
	and a			;764a
	ret z			;764b
	xor a			;764c
	ld (0e3aah),a		;764d
	call L_7656		;7650
	jp L_74DD		;7653
L_7656:
	ld a,001h		;7656
	ld (0e3bfh),a		;7658
	ld hl,00000h		;765b
	ld (0e3c7h),hl		;765e
	ld a,03ch		;7661
	jp 04ae4h		;7663
L_7666:
	ld hl,(0e3c7h)		;7666
	ld de,00040h		;7669
	add hl,de			;766c
	ld (0e3c7h),hl		;766d
	ld a,008h		;7670
	ld (0e3c2h),a		;7672
	ld a,(0e406h)		;7675
	cp 0f0h		;7678
	ret c			;767a
	call 04a08h		;767b
	call 04c76h		;767e
	xor a			;7681
	ld (0e3bfh),a		;7682
	ret			;7685
L_7686:
	call L_7666		;7686
	ret c			;7689
	ld a,001h		;768a
	ld (0e3c1h),a		;768c
	ret			;768f
L_7690:
	ld (0f004h),a		;7690
	ld (0f000h),hl		;7693
	ld (0f002h),de		;7696
	ld a,(0e20fh)		;769a
	ld hl,077a8h		;769d
	call 05ca6h		;76a0
	ld hl,(0f000h)		;76a3
	call 053f9h		;76a6
	ld hl,(0f000h)		;76a9
	ld bc,0e000h		;76ac
	add hl,bc			;76af
	ld bc,00040h		;76b0
	ld a,0a4h		;76b3
	call 00056h		;76b5   ; BIOS FILVRM - Fills VRAM with value
	ld b,008h		;76b8
	ld a,(0f004h)		;76ba
	ld hl,(0f002h)		;76bd
L_76C0:
	ld (hl),a			;76c0
	inc a			;76c1
	inc hl			;76c2
	djnz L_76C0		;76c3
	ld a,001h		;76c5
	call 080bdh		;76c7
	ld a,022h		;76ca
	jp 04ae4h		;76cc
L_76CF:
	ld hl,077aeh		;76cf
	ld a,(0e20fh)		;76d2
	call 05ca6h		;76d5
	add a,a			;76d8
	sub 001h		;76d9
	ld hl,03ac0h		;76db
	call 0407ah		;76de
	ld (0e3c5h),hl		;76e1
	ret			;76e4
L_76E5:
	ld hl,0e404h		;76e5
	ld a,(hl)			;76e8
	cp 048h		;76e9
	ld c,000h		;76eb
	jr z,L_76F9		;76ed
	ld bc,00102h		;76ef
	jr c,L_76F7		;76f2
	ld bc,0ff01h		;76f4
L_76F7:
	add a,b			;76f7
	ld (hl),a			;76f8
L_76F9:
	ld d,a			;76f9
	inc l			;76fa
	inc l			;76fb
	ld a,(hl)			;76fc
	cp 050h		;76fd
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
	call 0a82eh		;7712
	pop bc			;7715
	ld a,c			;7716
	or b			;7717
	ld bc,0e3c2h		;7718
	ld (bc),a			;771b
	call 0a79ah		;771c
	pop de			;771f
	ld hl,04850h		;7720
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


L_77B6:
	ld hl,03b00h		;77b6
	call 04a1dh		;77b9
	exx			;77bc
	ld a,(0e400h)		;77bd
	inc a			;77c0
	jr z,L_77E6		;77c1
	ld hl,0e304h		;77c3
	ld a,(hl)			;77c6
	add a,01ch		;77c7
	and 07ch		;77c9
	ld (hl),a			;77cb
	ld e,a			;77cc
	ld d,020h		;77cd
L_77CF:
	ld a,e			;77cf
	ld hl,0e280h		;77d0
	add a,l			;77d3
	ld l,a			;77d4
	ld b,004h		;77d5
L_77D7:
	outi		;77d7
	jp nz,L_77D7		;77d9
	ld a,e			;77dc
	add a,00ch		;77dd
	and 07ch		;77df
	ld e,a			;77e1
	dec d			;77e2
	jr nz,L_77CF		;77e3
	ret			;77e5
L_77E6:
	ld hl,0e280h		;77e6
	ld b,080h		;77e9
L_77EB:
	outi		;77eb
	jp nz,L_77EB		;77ed
	ret			;77f0
L_77F1:
	ld hl,03800h		;77f1
	call 04a1dh		;77f4
	exx			;77f7
	ld hl,0ed00h		;77f8
	ld a,(0e34eh)		;77fb
	or a			;77fe
	jr z,L_7808		;77ff
	ld de,00001h		;7801
	call m,05cadh		;7804
	add hl,de			;7807
L_7808:
	ld b,000h		;7808
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
L_781C:
	ld hl,0ea98h		;781c
	ld a,(hl)			;781f
	dec a			;7820
	ret m			;7821
	call 04084h		;7822

; ----------------------------------------------------------------------
; DATOS tabla_7825: 5 destinos del despachador p00:4084 (call en p01:7822, el
;   indice en A): 782F, 7872, 78CD, 78E3, 790B; lo leen p01:7822 (10 bytes)
;   0x7825..0x782f  (10 bytes)
DATA_tabla_7825:
	defw 0782fh,07872h,078cdh,078e3h,0790bh	; 7825

; ======================================================================
; CODIGO 0x782f..0x786a  (59 bytes)
; ======================================================================


L_782F:
	ld hl,0ea98h		;782f
	inc (hl)			;7832
	inc l			;7833
	ld (hl),050h		;7834
	inc l			;7836
	ld (hl),0a0h		;7837
	inc l			;7839
	ld (hl),001h		;783a
	inc l			;783c
	ld (hl),000h		;783d
	xor a			;783f
	ld (0e345h),a		;7840
	ld (0e348h),a		;7843
	ld a,003h		;7846
	ld (0e34dh),a		;7848
	ld a,064h		;784b
	ld (0ea12h),a		;784d
	call 04b51h		;7850
L_7853:
	ld hl,0786ah		;7853
L_7856:
	ld de,0ee57h		;7856
	ldi		;7859
	ldi		;785b
	ld de,0ee77h		;785d
	ldi		;7860
	ldi		;7862
	ret			;7864
L_7865:
	ld hl,0786eh		;7865
	jr L_7856		;7868

; ----------------------------------------------------------------------
; DATOS tabla_786A: 8 bytes que p01:7853 copia de dos en dos a la tabla de
;   nombres de la RAM; lo leen p01:7853 (8 bytes)
;   0x786a..0x7872  (8 bytes)
DATA_tabla_786A:
	defb 096h,0a2h,0aeh,0bah,095h,0a1h,0adh,0b9h	; 786a  ........

; ======================================================================
; CODIGO 0x7872..0x79b3  (321 bytes)
; ======================================================================


L_7872:
	ld a,(0e345h)		;7872
	or a			;7875
	jr nz,L_788B		;7876
	call L_78AE		;7878
	ld a,(0ea12h)		;787b
	cp 020h		;787e
	jr nc,$-45		;7880
	ld a,(0e1c3h)		;7882
	bit 2,a		;7885
	jr z,$-52		;7887
	jr $-36		;7889
L_788B:
	ld de,00500h		;788b
	call 05b04h		;788e
	call L_7865		;7891
	xor a			;7894
	ld (0e345h),a		;7895
	ld a,078h		;7898
	ld (0ea9dh),a		;789a
	ld a,039h		;789d
	call 04ae4h		;789f
	ld a,a			;78a2
	ld (0e300h),a		;78a3
	call L_7918		;78a6
L_78A9:
	ld hl,0ea98h		;78a9
	inc (hl)			;78ac
	ret			;78ad
L_78AE:
	ld hl,0ea9bh		;78ae
	dec (hl)			;78b1
	ret nz			;78b2
	ld a,(0ea12h)		;78b3
	cp 020h		;78b6
	ld a,012h		;78b8
	jr nc,L_78BE		;78ba
	ld a,00ch		;78bc
L_78BE:
	ld (hl),a			;78be
	inc l			;78bf
	inc (hl)			;78c0
	bit 1,(hl)		;78c1
	ld de,09c38h		;78c3
	jr z,L_78CA		;78c6
	ld e,063h		;78c8
L_78CA:
	jp 0938fh		;78ca
L_78CD:
	ld hl,0ea9dh		;78cd
	dec (hl)			;78d0
	jr z,L_78DB		;78d1
	ld a,(hl)			;78d3
	rra			;78d4
	and 001h		;78d5
	ld (0e34eh),a		;78d7
	ret			;78da
L_78DB:
	ld hl,00001h		;78db
	ld (0e3aah),hl		;78de
	jr L_78A9		;78e1
L_78E3:
	ld a,(0e1c3h)		;78e3
	and 003h		;78e6
	dec a			;78e8
	cp 002h		;78e9
	jr nz,L_78EE		;78eb
	xor a			;78ed
L_78EE:
	ld (0e34eh),a		;78ee
	call 04137h		;78f1
	call 0a2a2h		;78f4
	call 04157h		;78f7
	ld a,(0e3aeh)		;78fa
	and a			;78fd
	ret z			;78fe
	xor a			;78ff
	ld (0e3aah),a		;7900
	ld (0e34eh),a		;7903
	call L_7656		;7906
	jr L_78A9		;7909
L_790B:
	call L_7666		;790b
	ret c			;790e
	xor a			;790f
	ld (0ea98h),a		;7910
	inc a			;7913
	ld (0e348h),a		;7914
	ret			;7917
L_7918:
	ld hl,0e600h		;7918
	ld de,0e601h		;791b
	ld bc,0039fh		;791e
	ld (hl),000h		;7921
	ldir		;7923
	xor a			;7925
	ld (0e352h),a		;7926
	ld (0e355h),a		;7929
	ld (0e36dh),a		;792c
	ret			;792f
L_7930:
	ld hl,0e570h		;7930
	ld de,0fff0h		;7933
	ld bc,00808h		;7936
L_7939:
	ld a,(hl)			;7939
	and a			;793a
	jr nz,L_7941		;793b
	dec c			;793d
	add hl,de			;793e
	djnz L_7939		;793f
L_7941:
	ld a,c			;7941
	ld (0e3b2h),a		;7942
	ret			;7945
L_7946:
	call L_6878		;7946
	ret nz			;7949
	ld ix,0e500h		;794a
	ld a,(0e3b2h)		;794e
	and a			;7951
	ret z			;7952
	ld b,a			;7953
L_7954:
	push bc			;7954
	call L_7961		;7955
	pop bc			;7958
	ld de,00010h		;7959
	add ix,de		;795c
	djnz L_7954		;795e
	ret			;7960
L_7961:
	ld a,(ix+000h)		;7961
	and a			;7964
	ret z			;7965
	call L_79AF		;7966
	call L_7981		;7969
	ld a,(0e320h)		;796c
	and a			;796f
	ret z			;7970
	ld a,(ix+006h)		;7971
	sub 008h		;7974
	jr c,L_797C		;7976
	ld (ix+006h),a		;7978
	ret			;797b
L_797C:
	ld (ix+000h),000h		;797c
	ret			;7980
L_7981:
	ld a,(ix+000h)		;7981
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
	ld a,(ix+006h)		;7999
	cp 0e0h		;799c
	ld a,0ffh		;799e
	jr nc,L_79AB		;79a0
	ld a,(ix+000h)		;79a2
	dec a			;79a5
	ret z			;79a6
	cp 002h		;79a7
	ret z			;79a9
	xor a			;79aa
L_79AB:
	ld (ix+00dh),a		;79ab
L_79AE:
	ret			;79ae
L_79AF:
	dec a			;79af
	call 04084h		;79b0

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


L_79D3:
	call 04137h		;79d3
	call 0be62h		;79d6
	jp 04157h		;79d9
L_79DC:
	call 04137h		;79dc
	call 0bb06h		;79df
	jp 04157h		;79e2
L_79E5:
	call 04137h		;79e5
	call 0a3c5h		;79e8
	jp 04157h		;79eb
L_79EE:
	call 04137h		;79ee
	call 0a4e2h		;79f1
	jp 04157h		;79f4
L_79F7:
	call 04137h		;79f7
	call 0a82eh		;79fa
	jp 04157h		;79fd
L_7A00:
	ld ix,0e600h		;7a00
	ld b,00ch		;7a04
L_7A06:
	ld a,(ix+02fh)		;7a06
	and a			;7a09
	jr nz,L_7A26		;7a0a
	ld a,(ix+000h)		;7a0c
	and a			;7a0f
	jr z,L_7A26		;7a10
	cp 01dh		;7a12
	jr z,L_7A1E		;7a14
	cp 020h		;7a16
	jr z,L_7A1E		;7a18
	cp 022h		;7a1a
	jr nz,L_7A26		;7a1c
L_7A1E:
	call 09317h		;7a1e
	jr nc,L_7A26		;7a21
	call L_6514		;7a23
L_7A26:
	ld de,00040h		;7a26
	add ix,de		;7a29
	djnz L_7A06		;7a2b
L_7A2D:
	ret			;7a2d
L_7A2E:
	ld a,(0e201h)		;7a2e
	call 04084h		;7a31

; ----------------------------------------------------------------------
; DATOS tabla_7A34: 12 destinos del despachador p00:4084 (call en p01:7A31, el
;   indice en A): 7A4C, 7A70, 7AA0, 7AB4, 7AE6, 7B2D, 7B67, 7B9A, 7BCF, 7C0C,
;   7BFD, 7C0C; lo leen p01:7A31 (24 bytes)
;   0x7a34..0x7a4c  (24 bytes)
DATA_tabla_7A34:
	defw 07a4ch,07a70h,07aa0h,07ab4h,07ae6h,07b2dh,07b67h,07b9ah	; 7a34
	defw 07bcfh,07c0ch,07bfdh,07c0ch	; 7a44  -> L_7BCF L_7C0C L_7BFD L_7C0C

; ======================================================================
; CODIGO 0x7a4c..0x7ce6  (666 bytes)
; ======================================================================


L_7A4C:
	ld a,(0e205h)		;7a4c
	dec a			;7a4f
	jr z,L_7A5F		;7a50
	ld a,(0e327h)		;7a52
	and a			;7a55
	ret z			;7a56
	ld a,001h		;7a57
	ld (0ea98h),a		;7a59
	jp L_7B62		;7a5c
L_7A5F:
	ld a,(0e348h)		;7a5f
	or a			;7a62
	ret z			;7a63
	xor a			;7a64
	ld (0e348h),a		;7a65
	inc a			;7a68
	ld (0e1e6h),a		;7a69
	ld (0e1d6h),a		;7a6c
	ret			;7a6f
L_7A70:
	ld a,(0e205h)		;7a70
	dec a			;7a73
	jp z,L_7BE3		;7a74
	ld a,(0e327h)		;7a77
	or a			;7a7a
	ret z			;7a7b
	call L_7B62		;7a7c
	ld l,001h		;7a7f
L_7A81:
	xor a			;7a81
	ld (0e345h),a		;7a82
	ld (0e342h),a		;7a85
	ld h,a			;7a88
	ld (0e340h),hl		;7a89
	ld l,a			;7a8c
	ld (0e346h),hl		;7a8d
	ld a,001h		;7a90
	ld (0e34dh),a		;7a92
	ld a,008h		;7a95
	ld (0e343h),a		;7a97
	ld a,070h		;7a9a
	ld (0e305h),a		;7a9c
	ret			;7a9f
L_7AA0:
	ld a,(0e205h)		;7aa0
	dec a			;7aa3
	jp z,L_7BE3		;7aa4
	ld a,(0e327h)		;7aa7
	and a			;7aaa
	ret z			;7aab
	ld l,004h		;7aac
	call L_7A81		;7aae
	jp L_7B62		;7ab1
L_7AB4:
	ld a,(0e3d0h)		;7ab4
	and a			;7ab7
	jr z,L_7AD3		;7ab8
	ld a,(0e327h)		;7aba
	and a			;7abd
	ret z			;7abe
	ld bc,00409h		;7abf
L_7AC2:
	ld a,(0e20ah)		;7ac2
	bit 0,a		;7ac5
	jr z,L_7ACB		;7ac7
	dec b			;7ac9
	dec b			;7aca
L_7ACB:
	ld a,b			;7acb
	ld (0e22ah),a		;7acc
	ld a,c			;7acf
	jp L_7C7E		;7ad0
L_7AD3:
	ld a,(0e205h)		;7ad3
	dec a			;7ad6
	jp z,L_7BE3		;7ad7
	ld a,(0e327h)		;7ada
	and a			;7add
	ret z			;7ade
	ld l,004h		;7adf
	call L_7A81		;7ae1
	jr L_7B62		;7ae4
L_7AE6:
	ld a,(0e205h)		;7ae6
	dec a			;7ae9
	jr z,L_7B03		;7aea
	dec a			;7aec
	jr z,L_7B15		;7aed
	dec a			;7aef
	jr z,L_7B21		;7af0
	dec a			;7af2
	jp z,L_7BE3		;7af3
	ld a,(0e327h)		;7af6
	and a			;7af9
	ret z			;7afa
	ld hl,00258h		;7afb
	ld (0e3a8h),hl		;7afe
	jr L_7B62		;7b01
L_7B03:
	ld hl,(0e3a8h)		;7b03
	dec hl			;7b06
	ld (0e3a8h),hl		;7b07
	ld a,l			;7b0a
	or h			;7b0b
	ret nz			;7b0c
	ld hl,00220h		;7b0d
	ld (0e325h),hl		;7b10
	jr L_7B62		;7b13
L_7B15:
	ld a,(0e327h)		;7b15
	and a			;7b18
	ret z			;7b19
	ld l,005h		;7b1a
	call L_7A81		;7b1c
	jr L_7B62		;7b1f
L_7B21:
	ld a,(0e342h)		;7b21
	and a			;7b24
	ret z			;7b25
	ld l,002h		;7b26
	call L_7A81		;7b28
	jr L_7B62		;7b2b
L_7B2D:
	ld a,(0e205h)		;7b2d
	dec a			;7b30
	jr z,L_7B48		;7b31
	dec a			;7b33
	jr z,L_7B58		;7b34
	dec a			;7b36
	jp z,L_7BE3		;7b37
	ld a,(0e327h)		;7b3a
	and a			;7b3d
	ret z			;7b3e
	xor a			;7b3f
	ld (0e348h),a		;7b40
	call 0a017h		;7b43
	jr L_7B62		;7b46
L_7B48:
	ld hl,0e348h		;7b48
	ld a,(hl)			;7b4b
	or a			;7b4c
	ret z			;7b4d
	xor a			;7b4e
	ld (hl),a			;7b4f
	ld de,00020h		;7b50
	call L_7BDB		;7b53
	jr L_7B62		;7b56
L_7B58:
	ld a,(0e327h)		;7b58
	and a			;7b5b
	ret z			;7b5c
	ld l,002h		;7b5d
	call L_7A81		;7b5f
L_7B62:
	ld hl,0e205h		;7b62
	inc (hl)			;7b65
	ret			;7b66
L_7B67:
	ld a,(0e3d0h)		;7b67
	and a			;7b6a
	jr z,L_7B78		;7b6b
	ld a,(0e327h)		;7b6d
	and a			;7b70
	ret z			;7b71
	ld bc,0070ah		;7b72
	jp L_7AC2		;7b75
L_7B78:
	ld a,(0e205h)		;7b78
	dec a			;7b7b
	jr z,L_7B8D		;7b7c
	ld a,(0e327h)		;7b7e
	and a			;7b81
	ret z			;7b82
	xor a			;7b83
	ld (0e348h),a		;7b84
	inc a			;7b87
	ld (0e34bh),a		;7b88
	jr L_7B62		;7b8b
L_7B8D:
	ld hl,0e348h		;7b8d
	ld a,(hl)			;7b90
	or a			;7b91
	ret z			;7b92
	xor a			;7b93
	ld (hl),a			;7b94
	ld (0e34bh),a		;7b95
	jr L_7C11		;7b98
L_7B9A:
	ld a,(0e205h)		;7b9a
	dec a			;7b9d
	jr z,L_7BB2		;7b9e
	dec a			;7ba0
	jr z,L_7BC3		;7ba1
	dec a			;7ba3
	jr z,L_7BEA		;7ba4
	ld a,(0e327h)		;7ba6
	and a			;7ba9
	ret z			;7baa
	ld a,001h		;7bab
	ld (0e3beh),a		;7bad
	jr L_7B62		;7bb0
L_7BB2:
	ld a,(0e38dh)		;7bb2
	and a			;7bb5
	ret z			;7bb6
	xor a			;7bb7
	ld (0e3beh),a		;7bb8
	ld de,00020h		;7bbb
	call L_7BDB		;7bbe
	jr L_7B62		;7bc1
L_7BC3:
	ld a,(0e327h)		;7bc3
	and a			;7bc6
	ret z			;7bc7
	ld l,003h		;7bc8
	call L_7A81		;7bca
	jr L_7B62		;7bcd
L_7BCF:
	ld hl,0e3c1h		;7bcf
	ld a,(hl)			;7bd2
	or a			;7bd3
	ret z			;7bd4
	xor a			;7bd5
	ld (hl),a			;7bd6
	dec l			;7bd7
	ld (hl),a			;7bd8
	jr L_7C11		;7bd9
L_7BDB:
	ld hl,(0e325h)		;7bdb
	add hl,de			;7bde
	ld (0e325h),hl		;7bdf
	ret			;7be2
L_7BE3:
	ld a,(0e342h)		;7be3
	and a			;7be6
	ret z			;7be7
	jr L_7C11		;7be8
L_7BEA:
	ld a,(0e342h)		;7bea
	and a			;7bed
	ret z			;7bee
	ld a,(0e400h)		;7bef
	and a			;7bf2
	ret m			;7bf3
	xor a			;7bf4
	ld (0e1d6h),a		;7bf5
	inc a			;7bf8
	ld (0e1e6h),a		;7bf9
	ret			;7bfc
L_7BFD:
	ld a,(0e3d0h)		;7bfd
	and a			;7c00
	jr z,L_7C0C		;7c01
	ld a,(0e327h)		;7c03
	and a			;7c06
	ret z			;7c07
	ld a,00bh		;7c08
	jr L_7C7E		;7c0a
L_7C0C:
	ld a,(0e327h)		;7c0c
	and a			;7c0f
	ret z			;7c10
L_7C11:
	ld a,(0e400h)		;7c11
	and a			;7c14
	ret m			;7c15
	ld a,001h		;7c16
	ld (0e1dah),a		;7c18
	ret			;7c1b
L_7C1C:
	ld a,(0e22bh)		;7c1c
	and a			;7c1f
	jr nz,L_7C2D		;7c20
	ld a,(0e201h)		;7c22
	cp 008h		;7c25
	jr z,L_7C3F		;7c27
	jr nc,L_7C44		;7c29
	jr L_7C6E		;7c2b
L_7C2D:
	xor a			;7c2d
	ld (0e22bh),a		;7c2e
	inc a			;7c31
	ld (0e1dbh),a		;7c32
	call L_7C56		;7c35
	ld (0e22ah),a		;7c38
	ld a,008h		;7c3b
	jr L_7C7E		;7c3d
L_7C3F:
	ld a,002h		;7c3f
	ld (0e1dbh),a		;7c41
L_7C44:
	ld hl,0e206h		;7c44
	inc (hl)			;7c47
	jr nz,L_7C4B		;7c48
	dec (hl)			;7c4a
L_7C4B:
	ld de,00080h		;7c4b
	call L_7FA4		;7c4e
	ld a,(0e22ah)		;7c51
	jr L_7C7E		;7c54
L_7C56:
	ld a,(0e201h)		;7c56
L_7C59:
	ld hl,0e20ah		;7c59
	bit 0,(hl)		;7c5c
	jr z,L_7C66		;7c5e
	dec a			;7c60
	ret p			;7c61
	ld a,001h		;7c62
	inc (hl)			;7c64
	ret			;7c65
L_7C66:
	inc a			;7c66
	cp 008h		;7c67
	ret c			;7c69
	ld a,006h		;7c6a
	inc (hl)			;7c6c
	ret			;7c6d
L_7C6E:
	ld hl,0e206h		;7c6e
	inc (hl)			;7c71
	jr nz,L_7C75		;7c72
	dec (hl)			;7c74
L_7C75:
	ld de,00080h		;7c75
	call L_7FA4		;7c78
	call L_7C56		;7c7b
L_7C7E:
	ld (0e201h),a		;7c7e
	ld a,043h		;7c81
	call 04ae4h		;7c83
	xor a			;7c86
	ld (0e205h),a		;7c87
	ld (0e342h),a		;7c8a
	jp L_60D1		;7c8d
L_7C90:
	ld a,(0e300h)		;7c90
	and a			;7c93
	ret nz			;7c94
	ld a,(0e400h)		;7c95
	and a			;7c98
	ret m			;7c99
	ld a,(0e3d0h)		;7c9a
	and a			;7c9d
	ret nz			;7c9e
	ld a,(0e3aah)		;7c9f
	or a			;7ca2
	ret nz			;7ca3
	ld a,(0e3c0h)		;7ca4
	or a			;7ca7
	ret nz			;7ca8
	ld a,(0e34fh)		;7ca9
	or a			;7cac
	ret nz			;7cad
	ld a,(0e190h)		;7cae
	bit 0,a		;7cb1
	ret nz			;7cb3
	ld a,(0e201h)		;7cb4
	ld hl,07ce6h		;7cb7
	call 04b67h		;7cba
	ld c,e			;7cbd
	ld b,d			;7cbe
	ld hl,(0e203h)		;7cbf
L_7CC2:
	ld a,(bc)			;7cc2
	ld e,a			;7cc3
	inc bc			;7cc4
	ld a,(bc)			;7cc5
	ld d,a			;7cc6
	inc bc			;7cc7
	rst 20h			;7cc8
	jr z,L_7CE1		;7cc9
	jr c,L_7CD0		;7ccb
	inc bc			;7ccd
	jr L_7CC2		;7cce
L_7CD0:
	ld a,(bc)			;7cd0
	ld hl,0e0a0h		;7cd1
	cp (hl)			;7cd4
	ret z			;7cd5
	cp 0ffh		;7cd6
	ret z			;7cd8
	call 04ae4h		;7cd9
	ld a,0f0h		;7cdc
	jp 04ae4h		;7cde
L_7CE1:
	ld a,0f1h		;7ce1
	jp 04ae4h		;7ce3

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


L_7D4F:
	ld a,(0e400h)		;7d4f
	dec a			;7d52
	ret m			;7d53
	ld a,(0e3c0h)		;7d54
	or a			;7d57
	ret nz			;7d58
	ld a,(0e1c8h)		;7d59
	and 020h		;7d5c
	ret z			;7d5e
	ld hl,0e330h		;7d5f
	ld a,(hl)			;7d62
	or a			;7d63
	ret z			;7d64
	ld (0e33dh),a		;7d65
	ld hl,0e333h		;7d68
	add a,l			;7d6b
	ld l,a			;7d6c
	ld a,(hl)			;7d6d
	or a			;7d6e
	ret m			;7d6f
	xor a			;7d70
	ld (0e330h),a		;7d71
	ld hl,053a3h		;7d74
	push hl			;7d77
	ld hl,07d8dh		;7d78
	ld a,(0e20fh)		;7d7b
	call 04b67h		;7d7e
	ex de,hl			;7d81
	ld a,(0e33dh)		;7d82
	call 04085h		;7d85
	ld a,006h		;7d88
	jp 04ae4h		;7d8a

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


L_7DD9:
	ld hl,0e20bh		;7dd9
	ld a,(hl)			;7ddc
	or a			;7ddd
	jr z,L_7E23		;7dde
	ld (hl),000h		;7de0
	ld hl,0e210h		;7de2
	ld de,0e330h		;7de5
	ld bc,0000dh		;7de8
	ldir		;7deb
	xor a			;7ded
	ld (0e330h),a		;7dee
	ld de,0e430h		;7df1
	ld bc,00007h		;7df4
	ldir		;7df7
	ld a,(hl)			;7df9
	or a			;7dfa
	jr z,L_7E05		;7dfb
	ld (0e401h),a		;7dfd
	ld a,002h		;7e00
	ld (0e400h),a		;7e02
L_7E05:
	inc l			;7e05
	ld a,(hl)			;7e06
	ld (0e402h),a		;7e07
	inc l			;7e0a
	ld a,(hl)			;7e0b
	ld (0e40bh),a		;7e0c
	dec a			;7e0f
	ret m			;7e10
	jr z,L_7E20		;7e11
L_7E13:
	ld a,001h		;7e13
	ld (0e40bh),a		;7e15
	call 0aa43h		;7e18
	ld a,002h		;7e1b
	ld (0e40bh),a		;7e1d
L_7E20:
	jp 0aa43h		;7e20
L_7E23:
	ld hl,0e334h		;7e23
	inc (hl)			;7e26
	ld a,(hl)			;7e27
	cp 007h		;7e28
	jr c,L_7E2E		;7e2a
	ld (hl),0ffh		;7e2c
L_7E2E:
	ld (0e402h),a		;7e2e
	ret			;7e31
L_7E32:
	xor a			;7e32
	ld (0e435h),a		;7e33
	call 0804ah		;7e36
	ld hl,0e335h		;7e39
	inc (hl)			;7e3c
	ld a,(hl)			;7e3d
	cp c			;7e3e
	jr c,L_7E43		;7e3f
	ld (hl),0ffh		;7e41
L_7E43:
	ld (0e433h),a		;7e43
	call L_7FB3		;7e46
	ld de,00080h		;7e49
	jp L_7FA4		;7e4c
L_7E4F:
	xor a			;7e4f
	ld (0e431h),a		;7e50
	ld (0e432h),a		;7e53
	ld (0e434h),a		;7e56
	ld (0e435h),a		;7e59
	inc a			;7e5c
	ld (0e436h),a		;7e5d
	ld (0e430h),a		;7e60
	ld a,0ffh		;7e63
	ld (0e336h),a		;7e65
	jp L_7FC7		;7e68
L_7E6B:
	call 0804ah		;7e6b
	ld a,(0e33dh)		;7e6e
	ld hl,0e333h		;7e71
	add a,l			;7e74
	ld l,a			;7e75
	inc (hl)			;7e76
	ld a,(hl)			;7e77
	cp c			;7e78
	jr c,L_7E7D		;7e79
	ld (hl),0ffh		;7e7b
L_7E7D:
	dec a			;7e7d
	jr z,L_7EA5		;7e7e
	dec a			;7e80
	jr z,L_7E8A		;7e81
	call L_7FF4		;7e83
	ld a,006h		;7e86
	jr L_7E95		;7e88
L_7E8A:
	call L_7EC6		;7e8a
	call 04482h		;7e8d
	call L_7FFF		;7e90
	ld a,005h		;7e93
L_7E95:
	ld (0e432h),a		;7e95
	xor a			;7e98
	ld (0e430h),a		;7e99
	ld (0e431h),a		;7e9c
	ld de,00080h		;7e9f
	jp L_7FA4		;7ea2
L_7EA5:
	xor a			;7ea5
	ld (0e432h),a		;7ea6
	ld (0e434h),a		;7ea9
	ld (0e435h),a		;7eac
	ld (0e436h),a		;7eaf
	inc a			;7eb2
	ld (0e430h),a		;7eb3
	ld (0e431h),a		;7eb6
	call L_7FD8		;7eb9
	call L_7EC2		;7ebc
	jp 0448eh		;7ebf
L_7EC2:
	ld a,00eh		;7ec2
	jr L_7EC8		;7ec4
L_7EC6:
	ld a,003h		;7ec6
L_7EC8:
	ld hl,0e470h		;7ec8
	ld de,00010h		;7ecb
	ld b,009h		;7ece
L_7ED0:
	cp (hl)			;7ed0
	jr nz,L_7ED5		;7ed1
	ld (hl),000h		;7ed3
L_7ED5:
	add hl,de			;7ed5
	djnz L_7ED0		;7ed6
	ret			;7ed8
L_7ED9:
	ld hl,0e430h		;7ed9
	ld a,(hl)			;7edc
	cp 002h		;7edd
	jr nz,L_7EE3		;7edf
	ld (hl),001h		;7ee1
L_7EE3:
	xor a			;7ee3
	ld (0e431h),a		;7ee4
	ld (0e435h),a		;7ee7
	ld (0e436h),a		;7eea
	call 0800bh		;7eed
	call 0804ah		;7ef0
	ld a,(0e33dh)		;7ef3
	ld hl,0e333h		;7ef6
	add a,l			;7ef9
	ld l,a			;7efa
	inc (hl)			;7efb
	ld a,(hl)			;7efc
	ld (0e434h),a		;7efd
	cp c			;7f00
	jr c,L_7F05		;7f01
	ld (hl),0ffh		;7f03
L_7F05:
	ld de,00080h		;7f05
	jp L_7FA4		;7f08
L_7F0B:
	ld hl,0e430h		;7f0b
	ld a,(hl)			;7f0e
	cp 002h		;7f0f
	jr nz,L_7F15		;7f11
	ld (hl),001h		;7f13
L_7F15:
	xor a			;7f15
	ld (0e433h),a		;7f16
	ld (0e431h),a		;7f19
	ld (0e434h),a		;7f1c
	ld (0e436h),a		;7f1f
	call 0804ah		;7f22
	ld a,(0e33dh)		;7f25
	ld hl,0e333h		;7f28
	add a,l			;7f2b
	ld l,a			;7f2c
	inc (hl)			;7f2d
	ld a,(hl)			;7f2e
	ld (0e435h),a		;7f2f
	cp c			;7f32
	jr c,L_7F37		;7f33
	ld (hl),0ffh		;7f35
L_7F37:
	call 08028h		;7f37
	ld de,00080h		;7f3a
	jr L_7FA4		;7f3d
L_7F3F:
	xor a			;7f3f
	ld (0e430h),a		;7f40
	ld (0e431h),a		;7f43
	ld (0e436h),a		;7f46
	call 0804ah		;7f49
	ld a,(0e33dh)		;7f4c
	ld hl,0e333h		;7f4f
	add a,l			;7f52
	ld l,a			;7f53
	inc (hl)			;7f54
	ld a,(hl)			;7f55
	ld (0e432h),a		;7f56
	cp c			;7f59
	jr c,L_7F5E		;7f5a
	ld (hl),0ffh		;7f5c
L_7F5E:
	call 08041h		;7f5e
	ld de,00040h		;7f61
	jr L_7FA4		;7f64
L_7F66:
	ld a,(0e33dh)		;7f66
	ld hl,0e333h		;7f69
	add a,l			;7f6c
	ld l,a			;7f6d
	inc (hl)			;7f6e
	ld a,(hl)			;7f6f
	ld (0e40bh),a		;7f70
	cp 002h		;7f73
	jr c,L_7F79		;7f75
	ld (hl),0ffh		;7f77
L_7F79:
	call 0aa43h		;7f79
	ld de,00080h		;7f7c
	jr L_7FA4		;7f7f
L_7F81:
	ld a,001h		;7f81
	ld (0e445h),a		;7f83
	ret			;7f86
L_7F87:
	ld a,(0e33dh)		;7f87
	ld hl,0e333h		;7f8a
	add a,l			;7f8d
	ld l,a			;7f8e
	ld (hl),0ffh		;7f8f
	ld a,(0e400h)		;7f91
	cp 003h		;7f94
	jr z,L_7F81		;7f96
L_7F98:
	ld hl,00a02h		;7f98
	ld (0e400h),hl		;7f9b
	ld de,00100h		;7f9e
	ld de,00100h		;7fa1
L_7FA4:
	ld hl,(0e227h)		;7fa4
	add hl,de			;7fa7
	ld a,h			;7fa8
	cp 010h		;7fa9
	jr c,L_7FAF		;7fab
	ld h,00fh		;7fad
L_7FAF:
	ld (0e227h),hl		;7faf
	ret			;7fb2
L_7FB3:
	ld a,(0e20fh)		;7fb3
	cp 002h		;7fb6
	ret c			;7fb8
	cp 006h		;7fb9
	jr c,L_7FC2		;7fbb
L_7FBD:
	xor a			;7fbd
	ld (0e339h),a		;7fbe
	ret			;7fc1
L_7FC2:
	xor a			;7fc2
	ld (0e338h),a		;7fc3
	ret			;7fc6
L_7FC7:
	xor a			;7fc7
	ld (0e33ah),a		;7fc8
L_7FCB:
	xor a			;7fcb
	ld (0e339h),a		;7fcc
L_7FCF:
	xor a			;7fcf
	ld (0e338h),a		;7fd0
L_7FD3:
	xor a			;7fd3
	ld (0e337h),a		;7fd4
	ret			;7fd7
L_7FD8:
	ld a,(0e20fh)		;7fd8
	or a			;7fdb
	jr z,L_7FD3		;7fdc
	cp 001h		;7fde
	jr z,L_7FCF		;7fe0
	cp 006h		;7fe2
	jr c,L_7FCB		;7fe4
	xor a			;7fe6
	ld (0e33ah),a		;7fe7
	ld (0e339h),a		;7fea
	ld (0e338h),a		;7fed
	ld (0e336h),a		;7ff0
	ret			;7ff3
L_7FF4:
	ld a,(0e20fh)		;7ff4
	cp 007h		;7ff7
	ret c			;7ff9
L_7FFA:
	xor a			;7ffa
	ld (0e33ah),a		;7ffb
	ret			;7ffe

; ----------------------------------------------------------------------
; DATOS partida_7FFF: el primer byte (0x3A) de `ld a,(0xE20F)`, la instruccion
;   de p01:7FFF que acaba en el banco 2: su operando son 0x8000-0x8001 del
;   banco que haya en 0x8000 (el 2: p01:7E90 la llama con los bancos 1-2-3), y
;   sigue en p02:8002; lo leen p01:7E90 (1 bytes)
;   0x7fff..0x8000  (1 bytes)
L_7FFF:
	defb 03ah	; 7fff

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


L_4023:
	call 0013eh		;4023   ; BIOS RDVDP - Reads VDP status register
	di			;4026
	ld hl,(0f0f7h)		;4027
	inc hl			;402a
	ld (0f0f7h),hl		;402b
	call L_4C4B		;402e
	ld hl,0e1d4h		;4031
	ld a,(hl)			;4034
	and a			;4035
	ld (hl),001h		;4036
	jp nz,L_4075		;4038
	ld a,004h		;403b
	ld (07000h),a		;403d
	inc a			;4040
	ld (09000h),a		;4041
	inc a			;4044
	ld (0b000h),a		;4045
	call 06934h		;4048
	xor a			;404b
	ld (0e1d4h),a		;404c
	di			;404f
	ld a,(0f0f1h)		;4050
	ld (07000h),a		;4053
	ld a,(0f0f2h)		;4056
	ld (09000h),a		;4059
	ld a,(0f0f3h)		;405c
	ld (0b000h),a		;405f
	ld hl,0e1c5h		;4062
	ld a,(hl)			;4065
	and a			;4066
	jr nz,L_4075		;4067
	inc (hl)			;4069
	ei			;406a
	call L_5D2A		;406b
	call L_5601		;406e
	xor a			;4071
	ld (0e1c5h),a		;4072
L_4075:
	ei			;4075
	ret			;4076
L_4077:
	jp 00047h		;4077   ; BIOS WRTVDP - Writes data in the VDP-register
L_407A:
	add a,l			;407a
	ld l,a			;407b
	ret nc			;407c
	inc h			;407d
	ret			;407e
L_407F:
	add a,e			;407f
	ld e,a			;4080
	ret nc			;4081
	inc d			;4082
	ret			;4083
L_4084:
	pop hl			;4084
L_4085:
	add a,a			;4085
	add a,l			;4086
	ld l,a			;4087
	jr nc,L_408B		;4088
	inc h			;408a
L_408B:
	ld a,(hl)			;408b
	inc hl			;408c
	ld h,(hl)			;408d
	ld l,a			;408e
	jp (hl)			;408f
L_4090:
	di			;4090
	im 1		;4091
	ld a,0c3h		;4093
	ld (0fd9ah),a		;4095
	ld hl,L_4023		;4098
	ld (0fd9bh),hl		;409b
	ld sp,0f0f0h		;409e
	call L_40E9		;40a1
	ld h,080h		;40a4
	call 00024h		;40a6   ; BIOS ENASLT - Switches to specified slot and page definitively
	xor a			;40a9
	ld hl,0f0f0h		;40aa
	ld (05000h),a		;40ad
	ld (hl),a			;40b0
	inc hl			;40b1
	inc a			;40b2
	ld (07000h),a		;40b3
	ld (hl),a			;40b6
	inc hl			;40b7
	inc a			;40b8
	ld (09000h),a		;40b9
	ld (hl),a			;40bc
	inc hl			;40bd
	inc a			;40be
	ld (hl),a			;40bf
	ld (0b000h),a		;40c0
	ld hl,0e000h		;40c3
	ld de,0e001h		;40c6
	ld bc,00fffh		;40c9
	ld (hl),000h		;40cc
	ldir		;40ce
	ld a,001h		;40d0
	ld (0e1c5h),a		;40d2
	inc a			;40d5
	ld (0e1c6h),a		;40d6
	call L_5CBD		;40d9
	call 0bcb1h		;40dc
	xor a			;40df
	ld (0e1c5h),a		;40e0
	call 0013eh		;40e3   ; BIOS RDVDP - Reads VDP status register
	ei			;40e6
L_40E7:
	jr L_40E7		;40e7
L_40E9:
	call 00138h		;40e9   ; BIOS RSLREG - Reads the primary slot register
	rrca			;40ec
	rrca			;40ed
	and 003h		;40ee
	ld c,a			;40f0
	ld b,000h		;40f1
	ld hl,0fcc1h		;40f3
	add hl,bc			;40f6
	ld a,(hl)			;40f7
	and 080h		;40f8
	or c			;40fa
	ld c,a			;40fb
	inc hl			;40fc
	inc hl			;40fd
	inc hl			;40fe
	inc hl			;40ff
	ld a,(hl)			;4100
	and 00ch		;4101
	or c			;4103
	ret			;4104
L_4105:
	jp L_4AE4		;4105
L_4108:
	push af			;4108
	ld a,001h		;4109
	jr L_411A		;410b
L_410D:
	push af			;410d
	ld a,004h		;410e
	jr L_411A		;4110
L_4112:
	push af			;4112
	ld a,007h		;4113
	jr L_411A		;4115
L_4117:
	push af			;4117
	ld a,00dh		;4118
L_411A:
	di			;411a
	push hl			;411b
	ld hl,0f0f1h		;411c
	ld (07000h),a		;411f
	ld (hl),a			;4122
	inc a			;4123
	inc l			;4124
	ld (09000h),a		;4125
	ld (hl),a			;4128
	inc a			;4129
	inc l			;412a
	ld (0b000h),a		;412b
	ld (hl),a			;412e
	pop hl			;412f
	pop af			;4130
	ei			;4131
	ret			;4132
L_4133:
	ld a,00ah		;4133
	jr L_414E		;4135
L_4137:
	ld a,00bh		;4137
	jr L_414E		;4139
L_413B:
	ld a,00ch		;413b
	jr L_414E		;413d
L_413F:
	ld a,00fh		;413f
	jp L_414E		;4141
L_4144:
	ld a,009h		;4144
	jp L_414E		;4146
L_4149:
	ld a,006h		;4149
	jp L_414E		;414b
L_414E:
	di			;414e
	ld (0b000h),a		;414f
	ld (0f0f3h),a		;4152
	ei			;4155
	ret			;4156
L_4157:
	ld a,002h		;4157
	jr L_415D		;4159
L_415B:
	ld a,00eh		;415b
L_415D:
	di			;415d
	ld (09000h),a		;415e
	ld (0f0f2h),a		;4161
	inc a			;4164
	ld (0b000h),a		;4165
	ld (0f0f3h),a		;4168
	ei			;416b
	ret			;416c
L_416D:
	ld a,(0e1dch)		;416d
	and a			;4170
	jr z,L_417F		;4171
	call L_4112		;4173
	call L_46C4		;4176
	call L_4108		;4179
	jp 077f1h		;417c
L_417F:
	call L_54DC		;417f
	xor a			;4182
	ld (0e307h),a		;4183
	ld (0e308h),a		;4186
	ld (0e309h),a		;4189
	call 077b6h		;418c
	call 07a2eh		;418f
	ld a,(0e1dah)		;4192
	and a			;4195
	ret nz			;4196
	call 07c90h		;4197
	call 0bf3ah		;419a
	call L_4117		;419d
	call L_4845		;41a0
	call L_4108		;41a3
	call 074a2h		;41a6
	ld a,(0e3c1h)		;41a9
	or a			;41ac
	ret nz			;41ad
	call 0be97h		;41ae
	call 0a765h		;41b1
	call 07d4fh		;41b4
	call 0aa53h		;41b7
	call 0aa9bh		;41ba
	call 0ab15h		;41bd
	call 0abe5h		;41c0
	call 0ab92h		;41c3
	call 08592h		;41c6
	call 08570h		;41c9
	call 085a9h		;41cc
	call 08653h		;41cf
	ld a,(0e3aah)		;41d2
	or a			;41d5
	jr nz,L_41E4		;41d6
	call 06385h		;41d8
	call 092c1h		;41db
	call 06d47h		;41de
	call 07274h		;41e1
L_41E4:
	call 08526h		;41e4
	call L_5120		;41e7
	call 09034h		;41ea
	ld a,(0e201h)		;41ed
	dec a			;41f0
	jr nz,L_41FC		;41f1
	call L_4137		;41f3
	call 0b193h		;41f6
	call L_4157		;41f9
L_41FC:
	call 06b85h		;41fc
	call 06acch		;41ff
	call L_4137		;4202
	call 0b4aah		;4205
	call 0b422h		;4208
	call L_4157		;420b
	call 0a04dh		;420e
	call 072d6h		;4211
	call 0781ch		;4214
	call 0927ah		;4217
	call 07930h		;421a
	call 07946h		;421d
	call 087a4h		;4220
	call 08678h		;4223
	call 06790h		;4226
	call L_4137		;4229
	ld a,(0e201h)		;422c
	dec a			;422f
	call z,0b2ceh		;4230
	call L_4157		;4233
	call 067b9h		;4236
	call 08be3h		;4239
	call 08c86h		;423c
	ld a,(0e3aah)		;423f
	or a			;4242
	jr nz,L_425D		;4243
	call 090c6h		;4245
	call 09167h		;4248
	call 088a2h		;424b
	call 08a43h		;424e
	call 08df9h		;4251
	call 08db4h		;4254
	call 08e43h		;4257
	call 08d5eh		;425a
L_425D:
	call L_5FD2		;425d
	call 08413h		;4260
	call 092f6h		;4263
	call 081dah		;4266
	ld a,(0e3aah)		;4269
	or a			;426c
	call z,07a00h		;426d
	call 06cedh		;4270
	call 06c48h		;4273
	call L_4137		;4276
	call 0b53ah		;4279
	call L_4157		;427c
	call 0853eh		;427f
	call 086b1h		;4282
	call L_4137		;4285
	call 0bd47h		;4288
	call 0a0d6h		;428b
	call L_4157		;428e
	call L_4157		;4291
	call 0872ah		;4294
	call L_51B3		;4297
	call L_517B		;429a
	call L_4137		;429d
	call 0a000h		;42a0
	call 0a088h		;42a3
	call 0a206h		;42a6
	call L_4157		;42a9
	call L_4144		;42ac
	call 06a27h		;42af
	call L_4108		;42b2
	call L_497A		;42b5
	call 077f1h		;42b8
	call L_4137		;42bb
	call 0a16ah		;42be
	call 0bdcdh		;42c1
	call L_4157		;42c4
	call 086f1h		;42c7
	call 06826h		;42ca
	call 08555h		;42cd
	call L_5F77		;42d0
	ld a,(0e1c3h)		;42d3
	and 007h		;42d6
	dec a			;42d8
	jp z,L_5BBB		;42d9
	ret			;42dc
L_42DD:
	call L_4112		;42dd
	ld hl,01800h		;42e0
	ld de,09ff4h		;42e3
	call L_4A8C		;42e6
	ld hl,01960h		;42e9
	ld de,0a063h		;42ec
	call L_4A8C		;42ef
	jp L_4108		;42f2
L_42F5:
	call L_4112		;42f5
	call L_42FE		;42f8
	jp L_4108		;42fb
L_42FE:
	ld hl,01800h		;42fe
	ld de,09d17h		;4301
	call L_4A8C		;4304
	ld hl,01960h		;4307
	ld de,09d68h		;430a
	jp L_4A8C		;430d
L_4310:
	call L_4112		;4310
	call L_4319		;4313
	jp L_4108		;4316
L_4319:
	ld a,c			;4319
	add a,a			;431a
	add a,a			;431b
	ld hl,09094h		;431c
	call L_407A		;431f
	ld e,(hl)			;4322
	inc hl			;4323
	ld d,(hl)			;4324
	push hl			;4325
	ld hl,02748h		;4326
	call L_4A5B		;4329
	pop hl			;432c
	inc hl			;432d
	ld e,(hl)			;432e
	inc hl			;432f
	ld d,(hl)			;4330
	ld hl,00748h		;4331
	jp L_4A5B		;4334
L_4337:
	push ix		;4337
	ld a,(0f0f5h)		;4339
	bit 2,a		;433c
	jr z,L_4349		;433e
	call L_4137		;4340
	ld ix,0bfbfh		;4343
	jr L_4350		;4347
L_4349:
	call L_4112		;4349
	ld ix,04358h		;434c
L_4350:
	call L_4595		;4350
	pop ix		;4353
	jp L_4108		;4355

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


L_435F:
	call L_4112		;435f
	call L_4368		;4362
	jp L_4108		;4365
L_4368:
	ld a,(0f0f5h)		;4368
	bit 2,a		;436b
	jr nz,L_4381		;436d
	ld hl,01800h		;436f
	ld de,0936fh		;4372
	call L_4A8C		;4375
	ld hl,01960h		;4378
	ld de,0942bh		;437b
	jp L_4A8C		;437e
L_4381:
	call L_413B		;4381
	ld hl,01800h		;4384
	ld de,0bf19h		;4387
	call L_4A8C		;438a
	ld hl,019e0h		;438d
	ld de,0bf82h		;4390
	jp L_4A8C		;4393
L_4396:
	call L_4137		;4396
	call 0b736h		;4399
	call L_4112		;439c
	call L_43A5		;439f
	jp L_4108		;43a2
L_43A5:
	call L_44F7		;43a5
	call L_4337		;43a8
	call L_4112		;43ab
	call L_44A0		;43ae
	call L_43C4		;43b1
L_43B4:
	ld a,(0f0f5h)		;43b4
	bit 2,a		;43b7
	ret z			;43b9
	call L_4137		;43ba
	ld ix,0bf63h		;43bd
	jp L_4595		;43c1
L_43C4:
	ld ix,044eah		;43c4
	call L_43DA		;43c8
	call L_44C7		;43cb
	ld hl,09348h		;43ce
	ld a,(0e201h)		;43d1
	call L_4B67		;43d4
	push de			;43d7
	pop ix		;43d8
L_43DA:
	ld a,(ix+000h)		;43da
	dec a			;43dd
	ret m			;43de
	push af			;43df
	call z,L_43EE		;43e0
	pop af			;43e3
	call nz,L_445E		;43e4
	ld bc,00004h		;43e7
	add ix,bc		;43ea
	jr L_43DA		;43ec
L_43EE:
	ld a,(ix+001h)		;43ee
	or a			;43f1
	ret z			;43f2
	ld (0f010h),a		;43f3
	ld l,(ix+002h)		;43f6
	ld h,000h		;43f9
	add hl,hl			;43fb
	add hl,hl			;43fc
	add hl,hl			;43fd
	ld bc,01800h		;43fe
	add hl,bc			;4401
	ld (0f012h),hl		;4402
	ld l,(ix+003h)		;4405
	ld h,000h		;4408
	add hl,hl			;440a
	add hl,hl			;440b
	add hl,hl			;440c
	add hl,bc			;440d
	ld (0f014h),hl		;440e
L_4411:
	ld hl,(0f012h)		;4411
	ld de,0e600h		;4414
	ld bc,00020h		;4417
	call 00059h		;441a   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call L_4444		;441d
	ld hl,(0f014h)		;4420
	ld de,0e620h		;4423
	ld bc,00020h		;4426
	call L_4A33		;4429
	ld bc,00020h		;442c
	ld hl,(0f012h)		;442f
	add hl,bc			;4432
	ld (0f012h),hl		;4433
	ld hl,(0f014h)		;4436
	add hl,bc			;4439
	ld (0f014h),hl		;443a
	ld hl,0f010h		;443d
	dec (hl)			;4440
	jr nz,L_4411		;4441
	ret			;4443
L_4444:
	ld hl,0e600h		;4444
	ld de,0e62fh		;4447
	ld b,010h		;444a
	call L_4457		;444c
	ld hl,0e610h		;444f
	ld de,0e63fh		;4452
	ld b,010h		;4455
L_4457:
	ld a,(hl)			;4457
	ld (de),a			;4458
	inc hl			;4459
	dec de			;445a
	djnz L_4457		;445b
	ret			;445d
L_445E:
	ld a,(ix+001h)		;445e
	or a			;4461
	ret z			;4462
	ld l,(ix+003h)		;4463
	ld h,000h		;4466
	add hl,hl			;4468
	add hl,hl			;4469
	add hl,hl			;446a
	ld bc,01810h		;446b
	add hl,bc			;446e
	ex de,hl			;446f
	ld l,(ix+002h)		;4470
	ld h,000h		;4473
	add hl,hl			;4475
	add hl,hl			;4476
	add hl,hl			;4477
	ld bc,01800h		;4478
	add hl,bc			;447b
	ld c,(ix+001h)		;447c
	jp L_4AB1		;447f
L_4482:
	call L_4112		;4482
	ld de,093eeh		;4485
	call L_449A		;4488
	jp L_4108		;448b
L_448E:
	call L_4112		;448e
	call L_4497		;4491
	jp L_4108		;4494
L_4497:
	ld de,093c0h		;4497
L_449A:
	ld hl,018c0h		;449a
	jp L_4A8C		;449d
L_44A0:
	call L_4368		;44a0
	call L_4112		;44a3
	call L_4497		;44a6
	ld a,(0e400h)		;44a9
	cp 003h		;44ac
	call z,L_42FE		;44ae
	ld a,(0e432h)		;44b1
	cp 005h		;44b4
	jr nz,L_44BE		;44b6
	ld de,093eeh		;44b8
	call L_449A		;44bb
L_44BE:
	ld hl,01a20h		;44be
	ld de,094b8h		;44c1
	jp L_4A8C		;44c4
L_44C7:
	ld a,(0e201h)		;44c7
	ld hl,092b3h		;44ca
	call L_4B67		;44cd
	ex de,hl			;44d0
L_44D1:
	ld a,(hl)			;44d1
	or a			;44d2
	ret z			;44d3
	inc hl			;44d4
	ld e,(hl)			;44d5
	inc hl			;44d6
	ld d,(hl)			;44d7
	inc hl			;44d8
	push hl			;44d9
	ld l,a			;44da
	ld h,000h		;44db
	add hl,hl			;44dd
	add hl,hl			;44de
	add hl,hl			;44df
	ld bc,01800h		;44e0
	add hl,bc			;44e3
	call L_4A8C		;44e4
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


L_44F7:
	ld a,(0e201h)		;44f7
	cp 008h		;44fa
	jr nz,L_451E		;44fc
	ld ix,06048h		;44fe
	call L_4595		;4502
	ld hl,00001h		;4505
	ld (0e1dch),hl		;4508
	ld hl,061ddh		;450b
	ld (0e1e0h),hl		;450e
	ld hl,06281h		;4511
	ld (0e1e2h),hl		;4514
	ld hl,064a7h		;4517
	ld (0e1e4h),hl		;451a
	ret			;451d
L_451E:
	ld ix,06048h		;451e
	call L_4595		;4522
	ld a,(0e201h)		;4525
	ld hl,06000h		;4528
	call L_4B67		;452b
	push de			;452e
	pop ix		;452f
	call L_4595		;4531
	xor a			;4534
	ld (0f000h),a		;4535
	ld hl,06018h		;4538
	call L_4545		;453b
	ld hl,0f000h		;453e
	inc (hl)			;4541
	ld hl,06030h		;4542
L_4545:
	ld a,(0e201h)		;4545
	call L_4B67		;4548
	push de			;454b
	pop ix		;454c
L_454E:
	ld a,(ix+000h)		;454e
	and a			;4551
	ret z			;4552
	ld a,(ix+002h)		;4553
	rlca			;4556
	rlca			;4557
	and 003h		;4558
	jr nz,L_456D		;455a
	ld l,(ix+003h)		;455c
	ld a,l			;455f
	ld (0f003h),a		;4560
	call L_457B		;4563
	ld de,00004h		;4566
	add ix,de		;4569
	jr L_454E		;456b
L_456D:
	ld l,a			;456d
	ld (0f003h),a		;456e
	call L_457B		;4571
	ld de,00003h		;4574
	add ix,de		;4577
	jr L_454E		;4579
L_457B:
	ld h,000h		;457b
	add hl,hl			;457d
	add hl,hl			;457e
	add hl,hl			;457f
	ld (0f001h),hl		;4580
	call L_4675		;4583
	ld a,(0f000h)		;4586
	and a			;4589
	push af			;458a
	call z,L_4617		;458b
	pop af			;458e
	call nz,L_45EA		;458f
	jp L_462D		;4592
L_4595:
	ld a,(ix+000h)		;4595
	and a			;4598
	ret z			;4599
	rra			;459a
	ld de,01000h		;459b
	call c,L_45BC		;459e
	bit 1,(ix+000h)		;45a1
	ld de,00800h		;45a5
	call nz,L_45BC		;45a8
	bit 2,(ix+000h)		;45ab
	ld de,00000h		;45af
	call nz,L_45BC		;45b2
	ld de,00006h		;45b5
	add ix,de		;45b8
	jr L_4595		;45ba
L_45BC:
	ld l,(ix+003h)		;45bc
	ld h,000h		;45bf
	add hl,hl			;45c1
	add hl,hl			;45c2
	add hl,hl			;45c3
	add hl,de			;45c4
	push hl			;45c5
	ld de,02000h		;45c6
	add hl,de			;45c9
	ld e,(ix+001h)		;45ca
	ld d,(ix+002h)		;45cd
	push ix		;45d0
	call L_4A8C		;45d2
	pop ix		;45d5
	pop hl			;45d7
	ld de,00000h		;45d8
	add hl,de			;45db
	ld e,(ix+004h)		;45dc
	ld d,(ix+005h)		;45df
	push ix		;45e2
	call L_4A8C		;45e4
	pop ix		;45e7
	ret			;45e9
L_45EA:
	ld hl,0e600h		;45ea
	ld de,0e607h		;45ed
	call L_45F9		;45f0
	ld hl,0e800h		;45f3
	ld de,0e807h		;45f6
L_45F9:
	exx			;45f9
	ld a,(0f003h)		;45fa
	ld b,a			;45fd
L_45FE:
	exx			;45fe
	ld b,004h		;45ff
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
	ld a,00ch		;460e
	call L_407F		;4610
	exx			;4613
	djnz L_45FE		;4614
	ret			;4616
L_4617:
	ld hl,0e600h		;4617
	ld de,(0f001h)		;461a
L_461E:
	ld b,008h		;461e
L_4620:
	rr (hl)		;4620
	adc a,a			;4622
	djnz L_4620		;4623
	ld (hl),a			;4625
	inc hl			;4626
	dec de			;4627
	ld a,d			;4628
	or e			;4629
	jr nz,L_461E		;462a
	ret			;462c
L_462D:
	bit 3,(ix+002h)		;462d
	ld de,01000h		;4631
	call nz,L_4649		;4634
	bit 4,(ix+002h)		;4637
	ld de,00800h		;463b
	call nz,L_4649		;463e
	bit 5,(ix+002h)		;4641
	ld de,00000h		;4645
	ret z			;4648
L_4649:
	push ix		;4649
	ld l,(ix+001h)		;464b
	ld h,000h		;464e
	add hl,hl			;4650
	add hl,hl			;4651
	add hl,hl			;4652
	add hl,de			;4653
	push hl			;4654
	ld de,02000h		;4655
	add hl,de			;4658
	ld de,0e600h		;4659
	ld bc,(0f001h)		;465c
	call L_4A33		;4660
	pop hl			;4663
	ld de,00000h		;4664
	add hl,de			;4667
	ld de,0e800h		;4668
	ld bc,(0f001h)		;466b
	call L_4A33		;466f
	pop ix		;4672
	ret			;4674
L_4675:
	ld bc,(0f001h)		;4675
	ld l,(ix+000h)		;4679
	ld h,000h		;467c
	add hl,hl			;467e
	add hl,hl			;467f
	add hl,hl			;4680
	push hl			;4681
	ld de,02000h		;4682
	bit 2,(ix+002h)		;4685
	jr nz,L_4695		;4689
	ld d,028h		;468b
	bit 1,(ix+002h)		;468d
	jr nz,L_4695		;4691
	ld d,030h		;4693
L_4695:
	add hl,de			;4695
	ld de,0e600h		;4696
	push ix		;4699
	call 00059h		;469b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;469e
	pop hl			;46a0
	ld de,00000h		;46a1
	bit 2,(ix+002h)		;46a4
	jr nz,L_46B4		;46a8
	ld d,008h		;46aa
	bit 1,(ix+002h)		;46ac
	jr nz,L_46B4		;46b0
	ld d,010h		;46b2
L_46B4:
	add hl,de			;46b4
	ld de,0e800h		;46b5
	ld bc,(0f001h)		;46b8
	push ix		;46bc
	call 00059h		;46be   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;46c1
	ret			;46c3
L_46C4:
	ld a,(0e1ddh)		;46c4
	dec a			;46c7
	jr z,L_46ED		;46c8
	dec a			;46ca
	jr z,L_470A		;46cb
	xor a			;46cd
	ld (0e1deh),a		;46ce
	ld c,000h		;46d1
	call L_472E		;46d3
	ld a,001h		;46d6
	ld (0e1deh),a		;46d8
	ld c,0f0h		;46db
	call L_472E		;46dd
	call L_478C		;46e0
	ld a,001h		;46e3
	ld (0e1dfh),a		;46e5
L_46E8:
	ld hl,0e1ddh		;46e8
	inc (hl)			;46eb
	ret			;46ec
L_46ED:
	xor a			;46ed
	ld (0e1deh),a		;46ee
	ld a,(0e1dfh)		;46f1
	ld c,a			;46f4
	call L_472E		;46f5
	call L_478C		;46f8
	ld hl,0e1dfh		;46fb
	ld a,(hl)			;46fe
	cp 0ffh		;46ff
	jr z,L_46E8		;4701
	rlca			;4703
	rlca			;4704
	rlca			;4705
	or 001h		;4706
	ld (hl),a			;4708
	ret			;4709
L_470A:
	ld a,001h		;470a
	ld (0e1deh),a		;470c
	ld c,0ffh		;470f
	call L_472E		;4711
	call L_478C		;4714
	call L_4B43		;4717
	call L_43B4		;471a
	xor a			;471d
	ld (0e1dch),a		;471e
	ld a,(0e401h)		;4721
	or a			;4724
	ld a,001h		;4725
	jr z,L_472A		;4727
	inc a			;4729
L_472A:
	ld (0e400h),a		;472a
	ret			;472d
L_472E:
	ld ix,(0e1e0h)		;472e
L_4732:
	ld a,(ix+000h)		;4732
	and a			;4735
	ret z			;4736
	rra			;4737
	ld de,01000h		;4738
	call c,L_4759		;473b
	bit 1,(ix+000h)		;473e
	ld de,00800h		;4742
	call nz,L_4759		;4745
	bit 2,(ix+000h)		;4748
	ld de,00000h		;474c
	call nz,L_4759		;474f
	ld de,00006h		;4752
	add ix,de		;4755
	jr L_4732		;4757
L_4759:
	ld l,(ix+003h)		;4759
	ld h,000h		;475c
	add hl,hl			;475e
	add hl,hl			;475f
	add hl,hl			;4760
	add hl,de			;4761
	ld a,(0e1deh)		;4762
	dec a			;4765
	jr z,L_477A		;4766
	ld de,02000h		;4768
	add hl,de			;476b
	ld e,(ix+001h)		;476c
	ld d,(ix+002h)		;476f
	push ix		;4772
	call L_47A2		;4774
	pop ix		;4777
	ret			;4779
L_477A:
	ld de,00000h		;477a
	add hl,de			;477d
	ld e,(ix+004h)		;477e
	ld d,(ix+005h)		;4781
	push ix		;4784
	call L_47A2		;4786
	pop ix		;4789
	ret			;478b
L_478C:
	xor a			;478c
	ld (0f000h),a		;478d
	ld ix,(0e1e2h)		;4790
	call L_454E		;4794
	ld hl,0f000h		;4797
	inc (hl)			;479a
	ld ix,(0e1e4h)		;479b
	jp L_454E		;479f
L_47A2:
	call L_4A1D		;47a2
L_47A5:
	ld a,(de)			;47a5
	and a			;47a6
	ret z			;47a7
	inc de			;47a8
	ld b,a			;47a9
	and 07fh		;47aa
	cp b			;47ac
	jr z,L_47C7		;47ad
	ld b,a			;47af
L_47B0:
	ld a,(de)			;47b0
	and c			;47b1
	inc de			;47b2
	exx			;47b3
	out (c),a		;47b4
	exx			;47b6
	ld a,(0e1deh)		;47b7
	and a			;47ba
	jr nz,L_47C3		;47bb
	rrc c		;47bd
	rrc c		;47bf
	rrc c		;47c1
L_47C3:
	djnz L_47B0		;47c3
	jr L_47A5		;47c5
L_47C7:
	ld a,(de)			;47c7
	inc de			;47c8
L_47C9:
	and c			;47c9
	exx			;47ca
	out (c),a		;47cb
	exx			;47cd
	ex af,af'			;47ce
	ld a,(0e1deh)		;47cf
	and a			;47d2
	jr nz,L_47DB		;47d3
	rrc c		;47d5
	rrc c		;47d7
	rrc c		;47d9
L_47DB:
	ex af,af'			;47db
	djnz L_47C9		;47dc
	jr L_47A5		;47de
L_47E0:
	xor a			;47e0
	ld (0f004h),a		;47e1
	ld hl,(0e203h)		;47e4
	ld de,00020h		;47e7
	sbc hl,de		;47ea
	ld (0e203h),hl		;47ec
	ld hl,0ed00h		;47ef
	ld (0f000h),hl		;47f2
	ld b,020h		;47f5
L_47F7:
	push bc			;47f7
	call L_4117		;47f8
	call L_4889		;47fb
	call L_4108		;47fe
	call 07261h		;4801
	call 06560h		;4804
	call 08798h		;4807
	call 06f42h		;480a
	call 06abch		;480d
	call L_4137		;4810
	call 0b109h		;4813
	call 0b410h		;4816
	call L_4157		;4819
	call L_5113		;481c
	ld hl,(0f000h)		;481f
	inc hl			;4822
	ld (0f000h),hl		;4823
	ld hl,0f004h		;4826
	ld a,(hl)			;4829
	add a,008h		;482a
	ld (hl),a			;482c
	ld hl,(0e203h)		;482d
	inc hl			;4830
	ld (0e203h),hl		;4831
	pop bc			;4834
	djnz L_47F7		;4835
	ld hl,(0e203h)		;4837
	dec hl			;483a
	ld (0e203h),hl		;483b
	ret			;483e
L_483F:
	ld a,001h		;483f
	ld (0e327h),a		;4841
	ret			;4844
L_4845:
	xor a			;4845
	ld (0e320h),a		;4846
	ld (0e327h),a		;4849
	ld de,(0e325h)		;484c
	ld hl,(0e203h)		;4850
	rst 20h			;4853
	jr nc,L_483F		;4854
	ld a,(0e3d0h)		;4856
	dec a			;4859
	ret z			;485a
	dec a			;485b
	jr z,L_4867		;485c
	ld de,0e202h		;485e
	ld a,(de)			;4861
	rlca			;4862
	ld (de),a			;4863
	and 001h		;4864
	ret z			;4866
L_4867:
	inc hl			;4867
	ld (0e203h),hl		;4868
	ld a,001h		;486b
	ld (0e320h),a		;486d
	ld hl,0ed01h		;4870
	ld de,0ed00h		;4873
	ld b,016h		;4876
L_4878:
	push bc			;4878
	ld bc,0001fh		;4879
	ldir		;487c
	pop bc			;487e
	inc hl			;487f
	inc de			;4880
	djnz L_4878		;4881
	ld hl,0ed1fh		;4883
	ld (0f000h),hl		;4886
L_4889:
	ld hl,(0e203h)		;4889
	ld de,(0e323h)		;488c
	rst 20h			;4890
	ccf			;4891
	jp c,L_4956		;4892
	ld de,(0e321h)		;4895
	and a			;4899
	sbc hl,de		;489a
	jp c,L_4956		;489c
	push hl			;489f
	ld hl,07900h		;48a0
	ld a,(0e201h)		;48a3
	call L_4B67		;48a6
	pop hl			;48a9
	ld a,l			;48aa
	srl h		;48ab
	rra			;48ad
	and 0feh		;48ae
	ld l,a			;48b0
	ld c,l			;48b1
	ld b,h			;48b2
	add hl,hl			;48b3
	add hl,bc			;48b4
	add hl,de			;48b5
	ld (0f002h),hl		;48b6
	ld hl,(0f000h)		;48b9
	ld b,006h		;48bc
L_48BE:
	push bc			;48be
	push hl			;48bf
	ld a,(0e201h)		;48c0
	ld hl,05557h		;48c3
	call L_4B67		;48c6
	ld hl,(0f002h)		;48c9
	call L_4942		;48cc
	ld a,(hl)			;48cf
	inc hl			;48d0
	ld (0f002h),hl		;48d1
	jr z,L_48E3		;48d4
	sub 004h		;48d6
	jr nc,L_48E3		;48d8
	add a,004h		;48da
	ld c,a			;48dc
	ld de,06000h		;48dd
	ld a,c			;48e0
	jr L_490A		;48e1
L_48E3:
	ld c,a			;48e3
	ld a,(0e201h)		;48e4
	ld hl,0494ah		;48e7
	call L_407A		;48ea
	ld a,c			;48ed
	cp (hl)			;48ee
	jr c,L_490A		;48ef
	sub (hl)			;48f1
	ld l,(hl)			;48f2
	ld h,000h		;48f3
	add hl,hl			;48f5
	call L_407A		;48f6
	add hl,hl			;48f9
	add hl,hl			;48fa
	add hl,hl			;48fb
	add hl,de			;48fc
	ld de,0eaa8h		;48fd
	ld bc,00008h		;4900
	ldir		;4903
	ld de,0eaa8h		;4905
	jr L_4913		;4908
L_490A:
	ld l,a			;490a
	ld h,000h		;490b
	add hl,hl			;490d
	add hl,hl			;490e
	add hl,hl			;490f
	add hl,hl			;4910
	add hl,de			;4911
	ex de,hl			;4912
L_4913:
	ld a,(0e203h)		;4913
	and 003h		;4916
	add a,e			;4918
	ld e,a			;4919
	jr nc,L_491D		;491a
	inc d			;491c
L_491D:
	pop hl			;491d
	dec b			;491e
	ld bc,00020h		;491f
	jr z,L_4932		;4922
	ld a,(de)			;4924
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
	ld a,(de)			;4932
	ld (hl),a			;4933
	add hl,bc			;4934
	inc de			;4935
	inc de			;4936
	inc de			;4937
	inc de			;4938
	ld a,(de)			;4939
	ld (hl),a			;493a
	add hl,bc			;493b
	pop bc			;493c
	dec b			;493d
	jp nz,L_48BE		;493e
	ret			;4941
L_4942:
	ld a,(0e201h)		;4942
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


L_4956:
	ld a,(0e203h)		;4956
	and 01fh		;4959
	ld hl,049e8h		;495b
	call L_407A		;495e
	ld c,(hl)			;4961
	ld a,c			;4962
	ex af,af'			;4963
	ld b,016h		;4964
	ld de,00020h		;4966
	ld hl,(0f000h)		;4969
L_496C:
	xor a			;496c
	dec c			;496d
	jr nz,L_4975		;496e
	ex af,af'			;4970
	and 001h		;4971
	add a,0feh		;4973
L_4975:
	ld (hl),a			;4975
	add hl,de			;4976
	djnz L_496C		;4977
	ret			;4979
L_497A:
	ld a,(0e1c3h)		;497a
	and 006h		;497d
	ld hl,049e0h		;497f
	ld e,a			;4982
	ld d,000h		;4983
	add hl,de			;4985
	ld c,(hl)			;4986
	inc hl			;4987
	ld b,(hl)			;4988
	ld hl,027f2h		;4989
	call L_4993		;498c
	ld c,b			;498f
	ld hl,027fbh		;4990
L_4993:
	ld a,(0e202h)		;4993
	and c			;4996
	call 0004dh		;4997   ; BIOS WRTVRM - Writes data in VRAM
	ld de,00800h		;499a
	add hl,de			;499d
	call 0004dh		;499e   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;49a1
	jp 0004dh		;49a2   ; BIOS WRTVRM - Writes data in VRAM
L_49A5:
	ld ix,049e8h		;49a5
	ld a,(0e203h)		;49a9
	sub 01fh		;49ac
	and 01fh		;49ae
	ld e,a			;49b0
	ld d,000h		;49b1
	add ix,de		;49b3
	sub 020h		;49b5
	neg		;49b7
	ld c,a			;49b9
	ld de,0ed00h		;49ba
	ld b,020h		;49bd
L_49BF:
	push de			;49bf
	ld a,(ix+000h)		;49c0
	ld l,a			;49c3
	dec l			;49c4
	ld h,000h		;49c5
	add hl,hl			;49c7
	add hl,hl			;49c8
	add hl,hl			;49c9
	add hl,hl			;49ca
	add hl,hl			;49cb
	add hl,de			;49cc
	and 001h		;49cd
	add a,0feh		;49cf
	ld (hl),a			;49d1
	dec c			;49d2
	jr nz,L_49D9		;49d3
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


L_4A08:
	call L_5AFA		;4a08
	ld bc,002c0h		;4a0b
	jr L_4A16		;4a0e
L_4A10:
	call L_5AFA		;4a10
	ld bc,00300h		;4a13
L_4A16:
	ld hl,03800h		;4a16
	xor a			;4a19
	jp 00056h		;4a1a   ; BIOS FILVRM - Fills VRAM with value
L_4A1D:
	ex af,af'			;4a1d
	call 00053h		;4a1e   ; BIOS SETWRT - Enables VDP to write
	exx			;4a21
	ld a,(00007h)		;4a22
	ld c,a			;4a25
	exx			;4a26
	ex af,af'			;4a27
	ret			;4a28
L_4A29:
	call 00050h		;4a29   ; BIOS SETRD - Enables VDP to read
	exx			;4a2c
	ld a,(00006h)		;4a2d
	ld c,a			;4a30
	exx			;4a31
	ret			;4a32
L_4A33:
	ex de,hl			;4a33
	jp 0005ch		;4a34   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_4A37:
	exx			;4a37
	ld b,003h		;4a38
L_4A3A:
	exx			;4a3a
	push bc			;4a3b
	push de			;4a3c
	call L_4A33		;4a3d
	ld de,00800h		;4a40
	add hl,de			;4a43
	pop de			;4a44
	pop bc			;4a45
	exx			;4a46
	djnz L_4A3A		;4a47
	ret			;4a49
L_4A4A:
	ld d,003h		;4a4a
L_4A4C:
	push bc			;4a4c
	push de			;4a4d
	call 00056h		;4a4e   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;4a51
	add hl,de			;4a54
	pop de			;4a55
	pop bc			;4a56
	dec d			;4a57
	jr nz,L_4A4C		;4a58
	ret			;4a5a
L_4A5B:
	ld b,003h		;4a5b
L_4A5D:
	push bc			;4a5d
	push de			;4a5e
	call L_4A8C		;4a5f
	ld de,00800h		;4a62
	add hl,de			;4a65
	pop de			;4a66
	pop bc			;4a67
	djnz L_4A5D		;4a68
	ret			;4a6a
L_4A6B:
	ld c,0ffh		;4a6b
L_4A6D:
	ex de,hl			;4a6d
	ld e,(hl)			;4a6e
	inc hl			;4a6f
	ld d,(hl)			;4a70
	ex de,hl			;4a71
	inc de			;4a72
L_4A73:
	ld a,(de)			;4a73
	inc de			;4a74
	ld b,a			;4a75
	inc b			;4a76
	ret z			;4a77
	inc b			;4a78
	jr z,L_4A6D		;4a79
	and c			;4a7b
	call 0004dh		;4a7c   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;4a7f
	jr L_4A73		;4a80
L_4A82:
	ld c,000h		;4a82
	jr L_4A6D		;4a84
L_4A86:
	ex de,hl			;4a86
	ld e,(hl)			;4a87
	inc hl			;4a88
	ld d,(hl)			;4a89
	ex de,hl			;4a8a
	inc de			;4a8b
L_4A8C:
	call L_4A1D		;4a8c
L_4A8F:
	ld a,(de)			;4a8f
	and a			;4a90
	ret z			;4a91
	inc de			;4a92
	ld b,a			;4a93
	and 07fh		;4a94
	cp b			;4a96
	jr z,L_4AA7		;4a97
	and a			;4a99
	jr z,L_4A86		;4a9a
	ld b,a			;4a9c
L_4A9D:
	ld a,(de)			;4a9d
	inc de			;4a9e
	exx			;4a9f
	out (c),a		;4aa0
	exx			;4aa2
	djnz L_4A9D		;4aa3
	jr L_4A8F		;4aa5
L_4AA7:
	ld a,(de)			;4aa7
	inc de			;4aa8
L_4AA9:
	exx			;4aa9
	out (c),a		;4aaa
	exx			;4aac
	djnz L_4AA9		;4aad
	jr L_4A8F		;4aaf
L_4AB1:
	call L_4ABD		;4ab1
	ld a,020h		;4ab4
	call L_407F		;4ab6
	dec c			;4ab9
	jr nz,L_4AB1		;4aba
	ret			;4abc
L_4ABD:
	push de			;4abd
L_4ABE:
	ld b,010h		;4abe
L_4AC0:
	call 0004ah		;4ac0   ; BIOS RDVRM - Reads the content of VRAM
	call L_4AD9		;4ac3
	ex de,hl			;4ac6
	call 0004dh		;4ac7   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;4aca
	inc e			;4acb
	inc hl			;4acc
	djnz L_4AC0		;4acd
	ld a,e			;4acf
	sub 020h		;4ad0
	ld e,a			;4ad2
	bit 4,e		;4ad3
	jr z,L_4ABE		;4ad5
	pop de			;4ad7
	ret			;4ad8
L_4AD9:
	push bc			;4ad9
	ld c,a			;4ada
	ld b,008h		;4adb
L_4ADD:
	rr c		;4add
	rla			;4adf
	djnz L_4ADD		;4ae0
	pop bc			;4ae2
	ret			;4ae3
L_4AE4:
	di			;4ae4
	push hl			;4ae5
	push de			;4ae6
	push bc			;4ae7
	push ix		;4ae8
	push af			;4aea
	ld a,004h		;4aeb
	ld (07000h),a		;4aed
	inc a			;4af0
	ld (09000h),a		;4af1
	inc a			;4af4
	ld (0b000h),a		;4af5
	pop af			;4af8
	push af			;4af9
	call 06480h		;4afa
	ld a,(0f0f1h)		;4afd
	ld (07000h),a		;4b00
	ld a,(0f0f2h)		;4b03
	ld (09000h),a		;4b06
	ld a,(0f0f3h)		;4b09
	ld (0b000h),a		;4b0c
	pop af			;4b0f
	pop ix		;4b10
	pop bc			;4b12
	pop de			;4b13
	pop hl			;4b14
	ei			;4b15
	ret			;4b16
L_4B17:
	call L_4137		;4b17
	call 0b77fh		;4b1a
	jp L_4157		;4b1d
L_4B20:
	push ix		;4b20
	call L_4117		;4b22
	ld ix,0556fh		;4b25
	call L_4595		;4b29
	ld a,001h		;4b2c
	ld (0f000h),a		;4b2e
	ld ix,0559ah		;4b31
	call L_454E		;4b35
	call L_4B51		;4b38
	call L_4108		;4b3b
	call L_4137		;4b3e
	pop ix		;4b41
L_4B43:
	ld hl,0e600h		;4b43
	ld de,0e601h		;4b46
	ld bc,003ffh		;4b49
	ld (hl),000h		;4b4c
	ldir		;4b4e
	ret			;4b50
L_4B51:
	call L_4112		;4b51
	ld hl,01e80h		;4b54
	ld de,0bf6dh		;4b57
	call L_4A8C		;4b5a
	jp L_4108		;4b5d
L_4B60:
	ld l,a			;4b60
	ld h,000h		;4b61
	add hl,hl			;4b63
	add hl,de			;4b64
	jr L_4B6C		;4b65
L_4B67:
	add a,a			;4b67
	ld e,a			;4b68
	ld d,000h		;4b69
	add hl,de			;4b6b
L_4B6C:
	ld e,(hl)			;4b6c
	inc hl			;4b6d
	ld d,(hl)			;4b6e
	ret			;4b6f
L_4B70:
	ld hl,0e600h		;4b70
	ld de,00040h		;4b73
	ld b,00ch		;4b76
L_4B78:
	ld a,(hl)			;4b78
	and a			;4b79
	ret nz			;4b7a
	add hl,de			;4b7b
	djnz L_4B78		;4b7c
	ld hl,0e900h		;4b7e
	ld de,00010h		;4b81
	ld b,00ah		;4b84
L_4B86:
	ld a,(hl)			;4b86
	and a			;4b87
	ret nz			;4b88
	add hl,de			;4b89
	djnz L_4B86		;4b8a
	xor a			;4b8c
	ret			;4b8d
L_4B8E:
	ld l,(ix+004h)		;4b8e
	ld h,(ix+006h)		;4b91
	call L_5C92		;4b94
	ex de,hl			;4b97
	ld hl,04be8h		;4b98
	ld a,(ix+014h)		;4b9b
	sub 00fh		;4b9e
	neg		;4ba0
	call L_407A		;4ba2
	exx			;4ba5
	ld b,(ix+013h)		;4ba6
L_4BA9:
	exx			;4ba9
	push hl			;4baa
	push de			;4bab
	ld c,(ix+014h)		;4bac
	ld b,000h		;4baf
	ldir		;4bb1
	pop de			;4bb3
	ld a,020h		;4bb4
	add a,e			;4bb6
	ld e,a			;4bb7
	jr nc,L_4BBB		;4bb8
	inc d			;4bba
L_4BBB:
	pop hl			;4bbb
	ld a,00fh		;4bbc
	add a,l			;4bbe
	ld l,a			;4bbf
	jr nc,L_4BC3		;4bc0
	inc h			;4bc2
L_4BC3:
	exx			;4bc3
	djnz L_4BA9		;4bc4
	ret			;4bc6
L_4BC7:
	ld l,(ix+004h)		;4bc7
	ld h,(ix+006h)		;4bca
	call L_5C92		;4bcd
	ld c,(ix+013h)		;4bd0
L_4BD3:
	push hl			;4bd3
	ld b,(ix+014h)		;4bd4
L_4BD7:
	ld (hl),000h		;4bd7
	inc hl			;4bd9
	djnz L_4BD7		;4bda
	pop hl			;4bdc
	ld a,020h		;4bdd
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


L_4C24:
	ld a,r		;4c24
	ld b,a			;4c26
	add a,a			;4c27
	add a,b			;4c28
	ld b,a			;4c29
	ld a,(0e306h)		;4c2a
	add a,b			;4c2d
	ld (0e306h),a		;4c2e
	ret			;4c31
L_4C32:
	push af			;4c32
	ld a,(0e201h)		;4c33
	call L_4B67		;4c36
	pop af			;4c39
	ld c,a			;4c3a
	add a,a			;4c3b
	add a,c			;4c3c
	call L_407F		;4c3d
	ex de,hl			;4c40
	ld e,(hl)			;4c41
	inc hl			;4c42
	ld d,(hl)			;4c43
	inc hl			;4c44
	ld c,(hl)			;4c45
	ld hl,(0e203h)		;4c46
	rst 20h			;4c49
	ret			;4c4a
L_4C4B:
	ld a,(0e1c0h)		;4c4b
	cp 002h		;4c4e
	jr z,L_4C55		;4c50
	cp 005h		;4c52
	ret nz			;4c54
L_4C55:
	ld a,(0e439h)		;4c55
	or a			;4c58
	ret z			;4c59
	ld hl,0e1d5h		;4c5a
	ld a,(hl)			;4c5d
	or a			;4c5e
	ret nz			;4c5f
	ld hl,0e43bh		;4c60
	dec (hl)			;4c63
	ret nz			;4c64
	ld (hl),03ch		;4c65
	dec l			;4c67
	ld a,(hl)			;4c68
	sub 001h		;4c69
	daa			;4c6b
	ld (hl),a			;4c6c
	ld a,001h		;4c6d
	jr nz,L_4C72		;4c6f
	inc a			;4c71
L_4C72:
	ld (0e1d5h),a		;4c72
	ret			;4c75
L_4C76:
	ld hl,0e280h		;4c76
	ld de,0e281h		;4c79
	ld (hl),0e0h		;4c7c
	ld bc,0007fh		;4c7e
	ldir		;4c81
	ret			;4c83
L_4C84:
	call L_4117		;4c84
	ld ix,0b3afh		;4c87
	call L_4595		;4c8b
	ld a,001h		;4c8e
	ld (0f000h),a		;4c90
	ld ix,0b3bch		;4c93
	call L_454E		;4c97
	call L_4108		;4c9a
	call L_4137		;4c9d
	jp L_4B43		;4ca0
L_4CA3:
	ld a,(ix+014h)		;4ca3
	or a			;4ca6
	ret z			;4ca7
	ld b,a			;4ca8
	ld l,(ix+011h)		;4ca9
	ld h,(ix+012h)		;4cac
	ld a,(ix+032h)		;4caf
L_4CB2:
	ld (hl),a			;4cb2
	inc l			;4cb3
	djnz L_4CB2		;4cb4
	ret			;4cb6
L_4CB7:
	push af			;4cb7
	ld hl,04cf6h		;4cb8
	call L_4B67		;4cbb
	ld hl,00000h		;4cbe
	push bc			;4cc1
L_4CC2:
	add hl,de			;4cc2
	djnz L_4CC2		;4cc3
	pop bc			;4cc5
	pop af			;4cc6
	push hl			;4cc7
	ld hl,04cd6h		;4cc8
	call L_4B67		;4ccb
	ld hl,00000h		;4cce
L_4CD1:
	add hl,de			;4cd1
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


L_4D16:
	push ix		;4d16
	call L_4D1E		;4d18
	pop ix		;4d1b
	ret			;4d1d
L_4D1E:
	ld (0f019h),de		;4d1e
	ld (0e350h),a		;4d22
	ld a,b			;4d25
	ld (0e35fh),a		;4d26
	xor a			;4d29
	ld (0e353h),a		;4d2a
	ld a,c			;4d2d
	ld (0e351h),a		;4d2e
	ld hl,0e600h		;4d31
	ld b,00ch		;4d34
	ld de,00040h		;4d36
	xor a			;4d39
L_4D3A:
	cp (hl)			;4d3a
	jr z,L_4D42		;4d3b
	add hl,de			;4d3d
	djnz L_4D3A		;4d3e
	xor a			;4d40
	ret			;4d41
L_4D42:
	push hl			;4d42
	ld a,(0e350h)		;4d43
	ld l,a			;4d46
	ld h,000h		;4d47
	ld e,l			;4d49
	ld d,h			;4d4a
	add hl,hl			;4d4b
	add hl,hl			;4d4c
	add hl,hl			;4d4d
	or a			;4d4e
	sbc hl,de		;4d4f
	ld de,04f45h		;4d51
	add hl,de			;4d54
	ex de,hl			;4d55
	pop hl			;4d56
	ld a,(de)			;4d57
	bit 6,a		;4d58
	jr nz,L_4D6C		;4d5a
	and 03fh		;4d5c
	ld b,a			;4d5e
	ld a,(0e355h)		;4d5f
	add a,b			;4d62
	cp 00dh		;4d63
	jr c,L_4D69		;4d65
	xor a			;4d67
	ret			;4d68
L_4D69:
	ld (0e355h),a		;4d69
L_4D6C:
	push de			;4d6c
	ld de,(0f019h)		;4d6d
	exx			;4d71
	ld hl,0e352h		;4d72
	inc (hl)			;4d75
	exx			;4d76
	push hl			;4d77
	pop ix		;4d78
	ld a,(0e350h)		;4d7a
	ld (0e353h),a		;4d7d
	ld (hl),a			;4d80
	inc l			;4d81
	xor a			;4d82
	ld (hl),a			;4d83
	inc l			;4d84
	ld (hl),a			;4d85
	inc l			;4d86
	ld (hl),a			;4d87
	inc l			;4d88
	ld (hl),e			;4d89
	inc l			;4d8a
	ld (hl),a			;4d8b
	inc l			;4d8c
	ld (hl),d			;4d8d
	ld de,00005h		;4d8e
	add hl,de			;4d91
	pop de			;4d92
	ex de,hl			;4d93
	ldi		;4d94
	ld a,(0e351h)		;4d96
	ld (de),a			;4d99
	inc e			;4d9a
	ldi		;4d9b
	ldi		;4d9d
	ldi		;4d9f
	ld a,007h		;4da1
	ld (de),a			;4da3
	ld a,005h		;4da4
	call L_407F		;4da6
	call L_4E93		;4da9
	ld (de),a			;4dac
	inc e			;4dad
	ld a,(0e350h)		;4dae
	cp 026h		;4db1
	jr z,L_4DCB		;4db3
	xor a			;4db5
	ld (de),a			;4db6
	ld a,(0e350h)		;4db7
	cp 00bh		;4dba
	jr z,L_4DC2		;4dbc
	cp 031h		;4dbe
	jr nz,L_4DCB		;4dc0
L_4DC2:
	ld a,001h		;4dc2
	ld (de),a			;4dc4
	inc e			;4dc5
	ld a,(0e396h)		;4dc6
	ld (de),a			;4dc9
	dec e			;4dca
L_4DCB:
	inc e			;4dcb
	inc e			;4dcc
	xor a			;4dcd
	ld (de),a			;4dce
	inc e			;4dcf
	ld a,(0e35fh)		;4dd0
	ld (de),a			;4dd3
	inc e			;4dd4
	xor a			;4dd5
	ld (de),a			;4dd6
	ld a,016h		;4dd7
	call L_407F		;4dd9
	ldi		;4ddc
	ldi		;4dde
	ldi		;4de0
	ld a,(0e351h)		;4de2
	and a			;4de5
	jr z,L_4DEC		;4de6
	ld (ix+031h),008h		;4de8
L_4DEC:
	ld a,(0e350h)		;4dec
	dec a			;4def
	call L_4084		;4df0

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
L_4E76:
	call L_4137		;4e76
	call 0b8f4h		;4e79
	jp L_4157		;4e7c
L_4E7F:
	ld a,(0f0f3h)		;4e7f
	push af			;4e82
	call L_4137		;4e83
	call 0a5f0h		;4e86
	pop af			;4e89
	di			;4e8a
	ld (0b000h),a		;4e8b
	ld (0f0f3h),a		;4e8e
	ei			;4e91
	ret			;4e92
L_4E93:
	push hl			;4e93
	ld a,(0e228h)		;4e94
	ld hl,04ea4h		;4e97
	call L_407A		;4e9a
	ld a,r		;4e9d
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


L_4EB4:
	ld e,(ix+004h)		;4eb4
	ld d,(ix+006h)		;4eb7
L_4EBA:
	call 093f5h		;4eba
L_4EBD:
	ld de,(0f012h)		;4ebd
	call L_4EFB		;4ec1
	ld de,(0f014h)		;4ec4
	jr L_4F02		;4ec8
L_4ECA:
	ld e,(ix+004h)		;4eca
	ld d,(ix+006h)		;4ecd
	call 093e9h		;4ed0
	jr L_4EBD		;4ed3
L_4ED5:
	ld a,080h		;4ed5
L_4ED7:
	ld e,(ix+004h)		;4ed7
	ld d,(ix+006h)		;4eda
	ld (0f00fh),a		;4edd
	ld a,h			;4ee0
	ld (0f000h),a		;4ee1
	ld a,l			;4ee4
	ld (0f001h),a		;4ee5
	call 09467h		;4ee8
	ld d,001h		;4eeb
	call 093fdh		;4eed
	ld de,(0f014h)		;4ef0
	call L_4F02		;4ef4
	ld de,(0f012h)		;4ef7
L_4EFB:
	ld (ix+007h),e		;4efb
	ld (ix+008h),d		;4efe
	ret			;4f01
L_4F02:
	ld (ix+009h),e		;4f02
	ld (ix+00ah),d		;4f05
	ret			;4f08
L_4F09:
	ld e,(ix+009h)		;4f09
	ld d,(ix+00ah)		;4f0c
	ret			;4f0f
L_4F10:
	ld e,(ix+007h)		;4f10
	ld d,(ix+008h)		;4f13
	ret			;4f16
L_4F17:
	call L_4F21		;4f17
	jr L_4EFB		;4f1a
L_4F1C:
	ld d,000h		;4f1c
	ld e,d			;4f1e
	jr L_4EFB		;4f1f
L_4F21:
	ld d,000h		;4f21
	ld e,d			;4f23
	jr L_4F02		;4f24
L_4F26:
	call L_4F02		;4f26
	ex de,hl			;4f29
	jr L_4EFB		;4f2a
L_4F2C:
	ld e,(ix+009h)		;4f2c
	ld d,(ix+00ah)		;4f2f
	call L_5CAD		;4f32
	ld (ix+009h),e		;4f35
	ld (ix+00ah),d		;4f38
	ret			;4f3b
L_4F3C:
	ld e,(ix+007h)		;4f3c
	ld d,(ix+008h)		;4f3f
	call L_5CAD		;4f42
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


L_5113:
	call L_5130		;5113
	jr z,L_5113		;5116
	ret c			;5118
	ld hl,0e37dh		;5119
	inc (hl)			;511c
	jp L_5113		;511d
L_5120:
	ld a,(0e320h)		;5120
	and a			;5123
	ret z			;5124
	ld a,0f8h		;5125
	ld (0f004h),a		;5127
L_512A:
	call L_5130		;512a
	jr z,L_512A		;512d
	ret			;512f
L_5130:
	call L_413B		;5130
	ld a,(0e37dh)		;5133
	ld hl,0bb72h		;5136
	call L_4C32		;5139
	jp nz,L_4157		;513c
	ld hl,0e37dh		;513f
	inc (hl)			;5142
	ld a,c			;5143
	and 0f0h		;5144
	ld e,a			;5146
	ld a,(0f004h)		;5147
	ld d,a			;514a
	ld a,c			;514b
	and 00fh		;514c
	ld c,a			;514e
	call L_5157		;514f
	call L_4157		;5152
	xor a			;5155
	ret			;5156
L_5157:
	ld a,(0ea60h)		;5157
	or a			;515a
	ret nz			;515b
	ld a,(0e439h)		;515c
	or a			;515f
	ret nz			;5160
	ld a,(0e400h)		;5161
	cp 003h		;5164
	ret z			;5166
	ld a,c			;5167
	dec a			;5168
	jr nz,L_5170		;5169
	ld a,(0e36dh)		;516b
	or a			;516e
	ret nz			;516f
L_5170:
	ld hl,0ea60h		;5170
	ld (hl),c			;5173
	inc l			;5174
	ld (hl),e			;5175
	inc l			;5176
	ld (hl),d			;5177
	jp L_4310		;5178
L_517B:
	ld de,00010h		;517b
	exx			;517e
	ld ix,0e900h		;517f
	ld de,0e2d8h		;5183
	ld b,00ah		;5186
L_5188:
	ld a,(ix+000h)		;5188
	and a			;518b
	jr z,L_51A9		;518c
	ld a,(ix+004h)		;518e
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
	ld a,0e0h		;51a9
	ld (de),a			;51ab
	inc e			;51ac
	inc e			;51ad
	inc e			;51ae
	inc e			;51af
	jp L_51A2		;51b0
L_51B3:
	ld a,(0e3aah)		;51b3
	or a			;51b6
	ret nz			;51b7
	call L_4112		;51b8
	call L_51C1		;51bb
	jp L_4108		;51be
L_51C1:
	ld de,0e2a8h		;51c1
	ld b,00ch		;51c4
	ld a,0e0h		;51c6
L_51C8:
	ld (de),a			;51c8
	inc e			;51c9
	inc e			;51ca
	inc e			;51cb
	inc e			;51cc
	djnz L_51C8		;51cd
	ld ix,0e600h		;51cf
	ld de,0e2a8h		;51d3
	ld b,00ch		;51d6
L_51D8:
	push bc			;51d8
	ld a,(ix+000h)		;51d9
	or a			;51dc
	jr z,L_51FF		;51dd
	bit 7,(ix+00bh)		;51df
	jr z,L_51FF		;51e3
	cp 024h		;51e5
	jp z,L_526A		;51e7
	sub 029h		;51ea
	cp 005h		;51ec
	jr c,L_520A		;51ee
	sub 010h		;51f0
	cp 004h		;51f2
	jr c,$+126		;51f4
	bit 6,(ix+00bh)		;51f6
	jr z,$+128		;51fa
	call nz,L_52B8		;51fc
L_51FF:
	exx			;51ff
	ld de,00040h		;5200
	add ix,de		;5203
	exx			;5205
	pop bc			;5206
	djnz L_51D8		;5207
	ret			;5209
L_520A:
	push de			;520a
	call L_5212		;520b
	pop de			;520e
	jp L_51FF		;520f
L_5212:
	ld c,a			;5212
	ld a,(ix+006h)		;5213
	cp 0f8h		;5216
	ret nc			;5218
	ld a,c			;5219
	ld hl,05265h		;521a
	call L_5CA6		;521d
	ld c,a			;5220
	ld l,(ix+011h)		;5221
	ld h,(ix+012h)		;5224
L_5227:
	ld a,(0e201h)		;5227
	cp 003h		;522a
	jr z,L_5242		;522c
	sub 009h		;522e
	cp 003h		;5230
	jr c,L_5242		;5232
	ld (hl),c			;5234
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
	ld b,048h		;5242
	ld de,0001fh		;5244
	ld a,(hl)			;5247
	sub e			;5248
	cp b			;5249
	jr c,L_524D		;524a
	ld (hl),c			;524c
L_524D:
	inc c			;524d
	inc l			;524e
	ld a,(hl)			;524f
	sub e			;5250
	cp b			;5251
	jr c,L_5255		;5252
	ld (hl),c			;5254
L_5255:
	inc c			;5255
	add hl,de			;5256
	ld a,(hl)			;5257
	sub e			;5258
	cp b			;5259
	jr c,L_525D		;525a
	ld (hl),c			;525c
L_525D:
	inc c			;525d
	inc l			;525e
	ld a,(hl)			;525f
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
	call L_4B8E		;526b
	pop de			;526e
	jp L_51FF		;526f
L_5272:
	push de			;5272
	call L_4CA3		;5273
	pop de			;5276
	jp L_51FF		;5277
L_527A:
	ld a,(ix+00bh)		;527a
	and 03fh		;527d
	ld b,a			;527f
	jp z,L_51FF		;5280
	ld a,(ix+004h)		;5283
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
	dec b			;5297
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
	ld a,(hl)			;52a6
	ld (de),a			;52a7
	inc l			;52a8
	inc e			;52a9
	ld a,(hl)			;52aa
	ld (de),a			;52ab
	inc l			;52ac
	inc e			;52ad
	ldi		;52ae
	ldi		;52b0
	pop bc			;52b2
	djnz L_52A5		;52b3
	jp L_51FF		;52b5
L_52B8:
	ld a,(ix+004h)		;52b8
	cp 0b8h		;52bb
	ret nc			;52bd
	ld a,(ix+006h)		;52be
	cp 0f8h		;52c1
	ret nc			;52c3
	push de			;52c4
	ld de,09da5h		;52c5
	ld a,(ix+032h)		;52c8
	call L_4B60		;52cb
	ex de,hl			;52ce
	ld e,(ix+011h)		;52cf
	ld d,(ix+012h)		;52d2
	ld b,(ix+013h)		;52d5
	ld c,(ix+006h)		;52d8
	xor a			;52db
	sub c			;52dc
	jr nz,L_52E1		;52dd
	ld a,0f8h		;52df
L_52E1:
	rra			;52e1
	rra			;52e2
	rra			;52e3
	and 01fh		;52e4
	ld c,(ix+014h)		;52e6
	cp c			;52e9
	jr nc,L_52ED		;52ea
	ld c,a			;52ec
L_52ED:
	push bc			;52ed
	ld a,c			;52ee
	ld b,000h		;52ef
	ldir		;52f1
	sub (ix+014h)		;52f3
	jr z,L_52FF		;52f6
	neg		;52f8
	add a,l			;52fa
	ld l,a			;52fb
	jr nc,L_52FF		;52fc
	inc h			;52fe
L_52FF:
	pop bc			;52ff
	ld a,020h		;5300
	sub c			;5302
	add a,e			;5303
	ld e,a			;5304
	jr nc,L_5308		;5305
	inc d			;5307
L_5308:
	djnz L_52ED		;5308
	pop de			;530a
	ret			;530b
L_530C:
	call L_5357		;530c
	ld e,b			;530f
L_5310:
	ld a,h			;5310
	cp 0f0h		;5311
	ret nc			;5313
	ld b,e			;5314
	xor a			;5315
	ld d,l			;5316
L_5317:
	ld (hl),a			;5317
	inc l			;5318
	djnz L_5317		;5319
	ld l,d			;531b
	ld a,020h		;531c
	add a,l			;531e
	ld l,a			;531f
	jr nc,L_5323		;5320
	inc h			;5322
L_5323:
	dec c			;5323
	jr nz,L_5310		;5324
	ret			;5326
L_5327:
	push bc			;5327
	call L_5357		;5328
	pop af			;532b
	sub b			;532c
	exx			;532d
	ld c,a			;532e
	exx			;532f
	ld a,020h		;5330
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
	cp 0f0h		;533b
	ret nc			;533d
	push bc			;533e
	ld b,000h		;533f
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
	exx			;534c
	ld a,d			;534d
	exx			;534e
	add a,e			;534f
	ld e,a			;5350
	jr nc,L_5354		;5351
	inc d			;5353
L_5354:
	djnz L_533A		;5354
	ret			;5356
L_5357:
	call L_5C92		;5357
	ld a,l			;535a
	and 01fh		;535b
	add a,b			;535d
	sub 020h		;535e
	ret c			;5360
	neg		;5361
	add a,b			;5363
	ld b,a			;5364
	ret			;5365
L_5366:
	ld hl,0e330h		;5366
	ld de,0e331h		;5369
	ld bc,0000ch		;536c
	ld (hl),000h		;536f
	ldir		;5371
	call 08060h		;5373
	ld a,(0e20bh)		;5376
	or a			;5379
	jr nz,L_5382		;537a
	ld a,(0e20dh)		;537c
	or a			;537f
	jr z,L_5387		;5380
L_5382:
	ld a,001h		;5382
	ld (0e330h),a		;5384
L_5387:
	ld hl,010a8h		;5387
	ld bc,00040h		;538a
	ld a,0a4h		;538d
	call 00056h		;538f   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03ad4h		;5392
	call L_4A1D		;5395
	ld b,008h		;5398
	ld a,015h		;539a
L_539C:
	exx			;539c
	out (c),a		;539d
	inc a			;539f
	exx			;53a0
	djnz L_539C		;53a1
L_53A3:
	ld hl,03ac1h		;53a3
	call L_4A1D		;53a6
	ld hl,0e334h		;53a9
	ld bc,00901h		;53ac
	ld a,(0e331h)		;53af
	dec a			;53b2
	ld d,a			;53b3
L_53B4:
	dec d			;53b4
	call L_542E		;53b5
	inc hl			;53b8
	inc c			;53b9
	djnz L_53B4		;53ba
	ld a,(0e439h)		;53bc
	or a			;53bf
	ret nz			;53c0
	ld a,(0e20bh)		;53c1
	or a			;53c4
	ld a,001h		;53c5
	jr nz,L_53F6		;53c7
	ld de,0e330h		;53c9
	ld a,(de)			;53cc
	ld b,a			;53cd
	or a			;53ce
	jr z,L_53F5		;53cf
	ld de,0e333h		;53d1
	add a,e			;53d4
	ld e,a			;53d5
	ld a,(de)			;53d6
	ld c,a			;53d7
	cp 0ffh		;53d8
	jr z,L_53F1		;53da
	ld a,(0e20fh)		;53dc
	ld hl,05462h		;53df
	call L_4B67		;53e2
	ex de,hl			;53e5
	ld a,b			;53e6
	call L_4B67		;53e7
	ex de,hl			;53ea
	ld b,000h		;53eb
	add hl,bc			;53ed
	ld a,(hl)			;53ee
	jr L_53F6		;53ef
L_53F1:
	ld a,015h		;53f1
	jr L_53F6		;53f3
L_53F5:
	xor a			;53f5
L_53F6:
	ld hl,030a8h		;53f6
L_53F9:
	ld (0f000h),hl		;53f9
	push af			;53fc
	call L_415B		;53fd
	ld hl,(0f000h)		;5400
	call L_4A1D		;5403
	exx			;5406
	pop af			;5407
	ld b,a			;5408
	ld hl,09bd3h		;5409
	call L_4B67		;540c
	ex de,hl			;540f
	ld a,b			;5410
	dec a			;5411
	ld e,0ffh		;5412
	cp 014h		;5414
	jr c,L_5419		;5416
	inc e			;5418
L_5419:
	ld d,008h		;5419
L_541B:
	out (c),e		;541b
	nop			;541d
	ld b,006h		;541e
L_5420:
	outi		;5420
	jp nz,L_5420		;5422
	nop			;5425
	out (c),e		;5426
	dec d			;5428
	jr nz,L_541B		;5429
	jp L_4157		;542b
L_542E:
	ld a,d			;542e
	or a			;542f
	jp m,L_5458		;5430
	ld a,(hl)			;5433
	inc a			;5434
	jr nz,L_5444		;5435
	ld a,(0e330h)		;5437
	cp c			;543a
	ld a,00fh		;543b
	jr nz,L_544E		;543d
	ld a,01dh		;543f
	jp L_544E		;5441
L_5444:
	ld a,(0e330h)		;5444
	cp c			;5447
	ld a,00bh		;5448
	jr nz,L_544E		;544a
	ld a,00dh		;544c
L_544E:
	exx			;544e
	out (c),a		;544f
	exx			;5451
	inc a			;5452
	exx			;5453
	out (c),a		;5454
	exx			;5456
	ret			;5457
L_5458:
	xor a			;5458
	exx			;5459
	out (c),a		;545a
	exx			;545c
	exx			;545d
	out (c),a		;545e
	exx			;5460
	ret			;5461

; ----------------------------------------------------------------------
; DATOS tablas_5462: 8 punteros, uno por vuelta (0xE20F), a tablas de punteros
;   (indice B en p00:53E7) a tiras de bytes que acaban en 0x54AE-0x54C6; las
;   lee p00:53DC con L_4B67 dos veces; lo leen p00:53E2 (101 bytes)
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


L_54C7:
	ld a,b			;54c7
	call L_53F6		;54c8
	ld b,0a0h		;54cb
	call L_54D2		;54cd
	jr L_54E6		;54d0
L_54D2:
	ld a,b			;54d2
	ld hl,010a8h		;54d3
	ld bc,00040h		;54d6
	jp 00056h		;54d9   ; BIOS FILVRM - Fills VRAM with value
L_54DC:
	ld a,(0e1d5h)		;54dc
	dec a			;54df
	jr z,L_54E6		;54e0
	dec a			;54e2
	jr z,L_5500		;54e3
	ret			;54e5
L_54E6:
	ld de,0e43ah		;54e6
	ld hl,03adah		;54e9
	ld b,001h		;54ec
	call L_5BF7		;54ee
	xor a			;54f1
	ld (0e1d5h),a		;54f2
	ld a,(0e43ah)		;54f5
	cp 004h		;54f8
	ret nc			;54fa
	ld a,021h		;54fb
	jp L_4AE4		;54fd
L_5500:
	ld a,021h		;5500
	call L_4AE4		;5502
	ld a,(0e439h)		;5505
	sub 003h		;5508
	jr nz,L_5514		;550a
	call 0aa2fh		;550c
	call 0aaech		;550f
	jr L_5534		;5512
L_5514:
	dec a			;5514
	jr nz,L_5534		;5515
	ld hl,0e445h		;5517
	ld a,(hl)			;551a
	or a			;551b
	jr z,L_5525		;551c
	ld (hl),000h		;551e
	call 07f98h		;5520
	jr L_5531		;5523
L_5525:
	ld a,(0e401h)		;5525
	or a			;5528
	ld a,001h		;5529
	jr z,L_552E		;552b
	inc a			;552d
L_552E:
	ld (0e400h),a		;552e
L_5531:
	call L_435F		;5531
L_5534:
	xor a			;5534
	ld (0e439h),a		;5535
	ld (0e1d5h),a		;5538
	jp L_5387		;553b
L_553E:
	ld a,(0e20fh)		;553e
	ld hl,0554fh		;5541
	call L_407A		;5544
	ld l,(hl)			;5547
	ld h,0e3h		;5548
	ld (hl),000h		;554a
	jp L_53A3		;554c

; ----------------------------------------------------------------------
; DATOS tabla_554F: 8 bytes, uno por vuelta (0xE20F): la casilla 0xE3xx que
;   p00:553E pone a cero; lo leen p00:5544 (8 bytes)
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


L_5601:
	ld hl,0e1c3h		;5601
	inc (hl)			;5604
	ld hl,05a3eh		;5605
	ld bc,(0e1c0h)		;5608
	ld a,c			;560c
	cp 003h		;560d
	jr nc,L_5612		;560f
	push hl			;5611
L_5612:
	call L_4084		;5612

; ----------------------------------------------------------------------
; DATOS tabla_5615: 11 destinos del despachador p00:4084 (call en p00:5612, el
;   indice en A): 562B, 567D, 5699, 5727, 578A, 57DB, 5817, 5842, 58CF, 58FD,
;   5955; lo leen p00:5612 (22 bytes)
;   0x5615..0x562b  (22 bytes)
DATA_tabla_5615:
	defw 0562bh,0567dh,05699h,05727h,0578ah,057dbh,05817h,05842h	; 5615
	defw 058cfh,058fdh,05955h	; 5625  -> L_58CF L_58FD L_5955

; ======================================================================
; CODIGO 0x562b..0x5ad8  (1197 bytes)
; ======================================================================


L_562B:
	djnz L_563A		;562b
	ld a,(0e1c3h)		;562d
	rra			;5630
	ret nc			;5631
	call 0626bh		;5632
	ret nz			;5635
	xor a			;5636
	jp L_571F		;5637
L_563A:
	djnz L_5651		;563a
	ld hl,0e1c4h		;563c
	dec (hl)			;563f
	ret nz			;5640
	call L_4133		;5641
	call 0615bh		;5644
	call 0b64fh		;5647
	call L_4108		;564a
	xor a			;564d
	jp L_571F		;564e
L_5651:
	djnz L_5668		;5651
	call L_4133		;5653
	call 0b737h		;5656
	call L_4108		;5659
	ld a,(0e1d7h)		;565c
	and a			;565f
	ret nz			;5660
	xor a			;5661
	call L_5775		;5662
	jp L_5722		;5665
L_5668:
	call L_5D0C		;5668
	call L_4A10		;566b
	call L_4137		;566e
	call 0b6cdh		;5671
	call L_4157		;5674
	call 06237h		;5677
	jp L_5722		;567a
L_567D:
	djnz L_5692		;567d
	call L_4133		;567f
	call 0b77ch		;5682
	call L_4108		;5685
	ld hl,0e1c4h		;5688
	dec (hl)			;568b
	jp nz,061ech		;568c
	jp L_5773		;568f
L_5692:
	call 0621eh		;5692
	xor a			;5695
	jp L_571F		;5696
L_5699:
	djnz L_56AB		;5699
	call L_4133		;569b
	call 0a000h		;569e
	call L_4108		;56a1
	ld a,(0e1d7h)		;56a4
	and a			;56a7
	ret nz			;56a8
	jr L_5722		;56a9
L_56AB:
	djnz L_56BC		;56ab
	call L_4133		;56ad
	call 0615bh		;56b0
	call 0b64fh		;56b3
	call L_4108		;56b6
	jp L_5722		;56b9
L_56BC:
	djnz L_56D0		;56bc
	call L_4133		;56be
	call 0b737h		;56c1
	call L_4108		;56c4
	ld a,(0e1d7h)		;56c7
	and a			;56ca
	ret nz			;56cb
	xor a			;56cc
	jp L_571F		;56cd
L_56D0:
	djnz L_56E1		;56d0
	ld hl,0e1c4h		;56d2
	dec (hl)			;56d5
	jr z,L_571D		;56d6
	call L_4133		;56d8
	call 0b77ch		;56db
	jp L_4108		;56de
L_56E1:
	djnz L_56F6		;56e1
	ld a,043h		;56e3
	call L_4AE4		;56e5
	call L_4A10		;56e8
	call 06210h		;56eb
	call L_5A95		;56ee
	call L_5EF6		;56f1
	jr L_5722		;56f4
L_56F6:
	djnz L_5711		;56f6
	call L_5F2A		;56f8
	ld a,(0e1d3h)		;56fb
	or a			;56fe
	ret nz			;56ff
L_5700:
	ld a,043h		;5700
	call L_4AE4		;5702
	xor a			;5705
L_5706:
	ld (0e1c0h),a		;5706
	ld a,020h		;5709
	ld (0e1c4h),a		;570b
	jp L_577C		;570e
L_5711:
	call L_4A10		;5711
	call L_4133		;5714
	call 0a643h		;5717
	call L_4108		;571a
L_571D:
	ld a,020h		;571d
L_571F:
	ld (0e1c4h),a		;571f
L_5722:
	ld hl,0e1c1h		;5722
	inc (hl)			;5725
	ret			;5726
L_5727:
	djnz L_5744		;5727
	ld hl,0e1c4h		;5729
	dec (hl)			;572c
	jr z,L_5722		;572d
	ld a,(0e1c2h)		;572f
	bit 5,a		;5732
	ld de,0b25ah		;5734
	jr z,L_573C		;5737
	ld de,0b264h		;5739
L_573C:
	bit 2,(hl)		;573c
	jp z,L_4A6B		;573e
	jp L_4A82		;5741
L_5744:
	djnz L_5754		;5744
	call L_4A10		;5746
	call L_4133		;5749
	call 0bf9eh		;574c
	call L_4108		;574f
	jr L_5722		;5752
L_5754:
	djnz L_5766		;5754
	call L_4133		;5756
	call 0bdfdh		;5759
	call L_4108		;575c
	ld a,(0e1d7h)		;575f
	and a			;5762
	ret nz			;5763
	jr L_5722		;5764
L_5766:
	djnz L_5781		;5766
	ld a,(0e0a0h)		;5768
	or a			;576b
	ret nz			;576c
	call L_4A10		;576d
	call L_5A9D		;5770
L_5773:
	ld a,020h		;5773
L_5775:
	ld (0e1c4h),a		;5775
L_5778:
	ld hl,0e1c0h		;5778
	inc (hl)			;577b
L_577C:
	xor a			;577c
L_577D:
	ld (0e1c1h),a		;577d
	ret			;5780
L_5781:
	ld a,03eh		;5781
	call L_4AE4		;5783
	ld a,050h		;5786
	jr L_571F		;5788
L_578A:
	djnz L_57A1		;578a
	ld hl,0e1c4h		;578c
	dec (hl)			;578f
	ret nz			;5790
	ld de,0b272h		;5791
	call L_4A82		;5794
	call 060fdh		;5797
	ld a,001h		;579a
	ld (0e1d3h),a		;579c
	jr L_5778		;579f
L_57A1:
	call L_5ADA		;57a1
	ret p			;57a4
	ld hl,0e200h		;57a5
	ld a,(hl)			;57a8
	sub 001h		;57a9
	daa			;57ab
	ld (hl),a			;57ac
	call L_58C3		;57ad
	call L_57CE		;57b0
	call L_5BA3		;57b3
	call L_5366		;57b6
	call L_58C3		;57b9
	ld a,(0e1c2h)		;57bc
	and 020h		;57bf
	ld a,010h		;57c1
	jp z,L_571F		;57c3
	call L_5A82		;57c6
	ld a,078h		;57c9
	jp L_571F		;57cb
L_57CE:
	call L_4112		;57ce
	ld ix,06048h		;57d1
	call L_4595		;57d5
	jp L_4108		;57d8
L_57DB:
	call L_416D		;57db
	ld a,(0e1e6h)		;57de
	and a			;57e1
	ld a,00ah		;57e2
	jp nz,L_5706		;57e4
	ld a,(0e1d3h)		;57e7
	or a			;57ea
	jp z,L_5773		;57eb
	ld a,(0e1dah)		;57ee
	and a			;57f1
	ld a,008h		;57f2
	jp nz,L_5706		;57f4
	ld a,(0e400h)		;57f7
	dec a			;57fa
	ret m			;57fb
	ld a,(0e3d0h)		;57fc
	or a			;57ff
	ret nz			;5800
	ld a,(0e3c0h)		;5801
	or a			;5804
	ret nz			;5805
	call L_5928		;5806
	ret nc			;5809
	ld a,0f3h		;580a
	call L_4AE4		;580c
	call 0bd67h		;580f
	ld a,009h		;5812
	jp L_5706		;5814
L_5817:
	ld a,(0e200h)		;5817
	or a			;581a
	jr z,L_583A		;581b
	ld a,(0e240h)		;581d
	or a			;5820
	jr z,L_5835		;5821
L_5823:
	ld hl,0e200h		;5823
	ld de,0e240h		;5826
	ld b,040h		;5829
	call L_5C88		;582b
	ld hl,0e1c2h		;582e
	ld a,(hl)			;5831
	xor 080h		;5832
	ld (hl),a			;5834
L_5835:
	ld a,004h		;5835
	jp L_5706		;5837
L_583A:
	ld a,042h		;583a
	call L_4AE4		;583c
	jp L_5773		;583f
L_5842:
	djnz L_5896		;5842
	call L_5928		;5844
	jr nc,L_5851		;5847
	ld a,0f3h		;5849
	call L_4AE4		;584b
	jp L_5722		;584e
L_5851:
	call L_5942		;5851
	ld a,(0e078h)		;5854
	or a			;5857
	ret nz			;5858
	ld a,(0e20ch)		;5859
	and a			;585c
	jr z,L_5880		;585d
	ld hl,0e1fah		;585f
	ld a,(0e1c2h)		;5862
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
	ld (0e20bh),a		;5875
	ld (0e20dh),a		;5878
	ld a,003h		;587b
	ld (0e200h),a		;587d
L_5880:
	ld a,(0e240h)		;5880
	or a			;5883
	jr nz,L_5823		;5884
	ld a,(0e20ch)		;5886
	and a			;5889
	jr nz,L_5835		;588a
L_588C:
	ld hl,0e1c2h		;588c
	ld a,(hl)			;588f
	and 0bfh		;5890
	ld (hl),a			;5892
	jp L_5700		;5893
L_5896:
	djnz L_58A6		;5896
	call L_5928		;5898
	ret nc			;589b
	ld a,0f2h		;589c
	call L_4AE4		;589e
	ld a,001h		;58a1
	jp L_577D		;58a3
L_58A6:
	call L_5ADA		;58a6
	ret p			;58a9
	call L_58C3		;58aa
	ld de,0b288h		;58ad
	call L_4A6B		;58b0
	call L_5A82		;58b3
	call L_5C12		;58b6
	call L_5BA3		;58b9
	xor a			;58bc
	ld (0e20ch),a		;58bd
	jp L_571F		;58c0
L_58C3:
	call L_4137		;58c3
	call 0b736h		;58c6
	call 0b6f0h		;58c9
	jp L_4157		;58cc
L_58CF:
	xor a			;58cf
	ld (0e1dah),a		;58d0
	call 07c1ch		;58d3
	call L_5BA3		;58d6
	call L_5387		;58d9
	ld hl,0e400h		;58dc
	ld a,(hl)			;58df
	cp 003h		;58e0
	jr nz,L_58F8		;58e2
	inc l			;58e4
	ld a,(hl)			;58e5
	or a			;58e6
	ld b,001h		;58e7
	jr z,L_58EC		;58e9
	inc b			;58eb
L_58EC:
	dec l			;58ec
	ld (hl),b			;58ed
	xor a			;58ee
	ld (0e439h),a		;58ef
	ld (0e1d5h),a		;58f2
	call L_435F		;58f5
L_58F8:
	ld a,005h		;58f8
	jp L_5706		;58fa
L_58FD:
	call L_5928		;58fd
	jr c,L_591E		;5900
	call 0bd7ch		;5902
	ld a,(0e400h)		;5905
	and a			;5908
	jp m,077b6h		;5909
	call 0a78ch		;590c
	call 0aa53h		;590f
	call L_4137		;5912
	call 0a000h		;5915
	call L_4157		;5918
	jp 077b6h		;591b
L_591E:
	ld a,0f2h		;591e
	call L_4AE4		;5920
	ld a,005h		;5923
	jp L_5706		;5925
L_5928:
	ld a,(0e1c2h)		;5928
	and 040h		;592b
	ret z			;592d
	ld a,006h		;592e
	call 00141h		;5930   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5933
	and 020h		;5934
	ld hl,0e30ah		;5936
	ld c,(hl)			;5939
	ld (hl),a			;593a
	xor c			;593b
	ret z			;593c
	bit 5,(hl)		;593d
	ret z			;593f
	scf			;5940
	ret			;5941
L_5942:
	ld a,007h		;5942
	call 00141h		;5944   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;5947
	ret nz			;5949
	ld a,001h		;594a
	ld (0e20ch),a		;594c
	ld de,0b295h		;594f
	jp L_4A82		;5952
L_5955:
	djnz L_5961		;5955
	ld a,(0e0a0h)		;5957
	or a			;595a
	ret nz			;595b
	ld a,030h		;595c
	jp L_571F		;595e
L_5961:
	djnz L_5981		;5961
	ld hl,0e1c4h		;5963
	dec (hl)			;5966
	ret nz			;5967
	call L_4A10		;5968
	ld de,0b2afh		;596b
	call L_4A6B		;596e
	xor a			;5971
	ld (0e22dh),a		;5972
	ld (0e22eh),a		;5975
	ld hl,00000h		;5978
	ld (0f0f7h),hl		;597b
	jp L_571F		;597e
L_5981:
	djnz L_59CE		;5981
	call L_5A22		;5983
	ld a,(0e22dh)		;5986
	or a			;5989
	ld de,0b2cah		;598a
	call nz,L_4A6B		;598d
	ld a,(0e22dh)		;5990
	and a			;5993
	jr z,L_59B2		;5994
	call L_5A30		;5996
	ld a,(0e22eh)		;5999
	or a			;599c
	ret z			;599d
	ld de,0b2cah		;599e
	call L_4A82		;59a1
	ld a,078h		;59a4
	ld (0e1c4h),a		;59a6
	ld de,0b2eeh		;59a9
	call L_4A6B		;59ac
	jp L_571F		;59af
L_59B2:
	ld de,00258h		;59b2
	call L_5D89		;59b5
	ret c			;59b8
	ld de,0b2bah		;59b9
	call L_4A82		;59bc
	ld de,0b2dbh		;59bf
	call L_4A6B		;59c2
	xor a			;59c5
	ld (0e1c4h),a		;59c6
	ld a,005h		;59c9
	jp L_577D		;59cb
L_59CE:
	djnz L_59ED		;59ce
	ld hl,0e1c4h		;59d0
	dec (hl)			;59d3
	ret nz			;59d4
	ld a,04ah		;59d5
	ld (0e404h),a		;59d7
	ld a,050h		;59da
	ld (0e406h),a		;59dc
	call 0aa2fh		;59df
	call L_4C76		;59e2
	call L_4A10		;59e5
	ld a,008h		;59e8
	jp L_5706		;59ea
L_59ED:
	djnz L_5A05		;59ed
	ld hl,0e1c4h		;59ef
	dec (hl)			;59f2
	ret nz			;59f3
	call L_4A10		;59f4
	xor a			;59f7
	ld (0e200h),a		;59f8
	ld a,(0e240h)		;59fb
	or a			;59fe
	jp nz,L_5823		;59ff
	jp L_588C		;5a02
L_5A05:
	call L_4117		;5a05
	call L_4133		;5a08
	call 0b993h		;5a0b
	call L_4108		;5a0e
	ld a,(0e1e6h)		;5a11
	or a			;5a14
	ret nz			;5a15
	ld a,(0e1d6h)		;5a16
	or a			;5a19
	jp nz,L_571D		;5a1a
	ld a,008h		;5a1d
	jp L_5706		;5a1f
L_5A22:
	ld a,007h		;5a22
	call 00141h		;5a24   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;5a27
	ret nz			;5a29
	ld a,001h		;5a2a
	ld (0e22dh),a		;5a2c
	ret			;5a2f
L_5A30:
	ld a,008h		;5a30
	call 00141h		;5a32   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 0,a		;5a35
	ret nz			;5a37
	ld a,001h		;5a38
	ld (0e22eh),a		;5a3a
	ret			;5a3d
L_5A3E:
	call L_5D37		;5a3e
	ld hl,0e1d1h		;5a41
	call L_5D30		;5a44
	or a			;5a47
	ret z			;5a48
	ld hl,0e1c4h		;5a49
	ld (hl),000h		;5a4c
	ld hl,0e1c0h		;5a4e
	ld de,0e1d2h		;5a51
	ld b,(hl)			;5a54
	djnz L_5A70		;5a55
	and 030h		;5a57
	jr z,L_5A7D		;5a59
	ld a,(de)			;5a5b
	or a			;5a5c
	ld a,040h		;5a5d
	jr z,L_5A63		;5a5f
	ld a,060h		;5a61
L_5A63:
	ld (0e1c2h),a		;5a63
	ld (hl),003h		;5a66
	inc hl			;5a68
	ld c,000h		;5a69
	ld (hl),c			;5a6b
	dec c			;5a6c
	jp 061f6h		;5a6d
L_5A70:
	ld (hl),001h		;5a70
	inc hl			;5a72
	xor a			;5a73
	ld (hl),a			;5a74
	ld (0e1d7h),a		;5a75
	ld a,043h		;5a78
	jp L_4AE4		;5a7a
L_5A7D:
	ld a,(de)			;5a7d
	xor 001h		;5a7e
	ld (de),a			;5a80
	ret			;5a81
L_5A82:
	ld a,(0e1c2h)		;5a82
	bit 5,a		;5a85
	ret z			;5a87
	ld de,0b272h		;5a88
	and 080h		;5a8b
	jr z,L_5A92		;5a8d
	ld de,0b27dh		;5a8f
L_5A92:
	jp L_4A6B		;5a92
L_5A95:
	ld hl,0e200h		;5a95
	ld bc,00e20h		;5a98
	jr L_5AA3		;5a9b
L_5A9D:
	ld hl,0e1f5h		;5a9d
	ld bc,00e2bh		;5aa0
L_5AA3:
	ld e,l			;5aa3
	ld d,h			;5aa4
	inc de			;5aa5
	ld (hl),000h		;5aa6
	ldir		;5aa8
	xor a			;5aaa
	ld (0e1dah),a		;5aab
	ld (0e1dch),a		;5aae
	ld hl,05ad8h		;5ab1
	ld de,0e200h		;5ab4
	ld bc,00002h		;5ab7
	ldir		;5aba
	ld hl,00010h		;5abc
	ld (0e207h),hl		;5abf
	xor a			;5ac2
	ld (0e209h),a		;5ac3
	ld a,(0e1c2h)		;5ac6
	and 020h		;5ac9
	ret z			;5acb
	ld hl,0e200h		;5acc
	ld de,0e240h		;5acf
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


L_5ADA:
	ld hl,0e1c4h		;5ada
	dec (hl)			;5add
	ret m			;5ade
	ld a,(hl)			;5adf
	ld h,038h		;5ae0
	xor 01fh		;5ae2
	ld l,a			;5ae4
	ld b,016h		;5ae5
	ld a,(0e1c0h)		;5ae7
	cp 002h		;5aea
	jr nz,L_5AF0		;5aec
	ld b,018h		;5aee
L_5AF0:
	xor a			;5af0
	ld de,00020h		;5af1
L_5AF4:
	call 0004dh		;5af4   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;5af7
	djnz L_5AF4		;5af8
L_5AFA:
	ld hl,03b00h		;5afa
	ld a,0d0h		;5afd
	call 0004dh		;5aff   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;5b02
	ret			;5b03
L_5B04:
	ld a,(0e1c2h)		;5b04
	add a,a			;5b07
	ret p			;5b08
	ld hl,0e1fbh		;5b09
	jr nc,L_5B10		;5b0c
	ld l,0f6h		;5b0e
L_5B10:
	ld a,(hl)			;5b10
	add a,e			;5b11
	daa			;5b12
	ld (hl),a			;5b13
	inc l			;5b14
	ld a,(hl)			;5b15
	adc a,d			;5b16
	daa			;5b17
	ld (hl),a			;5b18
	inc hl			;5b19
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
	ld a,099h		;5b27
	ld (hl),a			;5b29
	dec l			;5b2a
	ld (hl),a			;5b2b
	dec l			;5b2c
	ld (hl),a			;5b2d
	dec l			;5b2e
	ld (hl),a			;5b2f
	ld a,(0f0f5h)		;5b30
	bit 1,a		;5b33
	ret nz			;5b35
	ld hl,09999h		;5b36
	ld (0e1f1h),hl		;5b39
	ld (0e1f3h),hl		;5b3c
	ret			;5b3f
L_5B40:
	ex de,hl			;5b40
	ld hl,0e209h		;5b41
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
	ld a,(hl)			;5b54
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
	call L_5B92		;5b65
L_5B68:
	ld a,(0f0f5h)		;5b68
	bit 1,a		;5b6b
	ret nz			;5b6d
	ld a,(0e1c2h)		;5b6e
	add a,a			;5b71
	ld hl,0e1feh		;5b72
	jr nc,L_5B79		;5b75
	ld l,0f9h		;5b77
L_5B79:
	ld b,004h		;5b79
	ld de,0e1f4h		;5b7b
	ld c,l			;5b7e
L_5B7F:
	ld a,(de)			;5b7f
	sub (hl)			;5b80
	jr c,L_5B89		;5b81
	ret nz			;5b83
	dec l			;5b84
	dec e			;5b85
	djnz L_5B7F		;5b86
	ret			;5b88
L_5B89:
	ld l,c			;5b89
	ld bc,00004h		;5b8a
	ld e,0f4h		;5b8d
	lddr		;5b8f
	ret			;5b91
L_5B92:
	ld hl,0e200h		;5b92
	ld a,(hl)			;5b95
	add a,001h		;5b96
	daa			;5b98
	ret c			;5b99
	ld (hl),a			;5b9a
	ld a,00ch		;5b9b
	call L_4AE4		;5b9d
	jp L_5BDD		;5ba0
L_5BA3:
	ld de,0b23dh		;5ba3
	call L_4A6B		;5ba6
	ld a,(0e1c2h)		;5ba9
	ld de,0b250h		;5bac
	add a,a			;5baf
	jr nc,L_5BB5		;5bb0
	ld de,0b255h		;5bb2
L_5BB5:
	call L_4A6B		;5bb5
	call L_5BDD		;5bb8
L_5BBB:
	ld de,0e1f4h		;5bbb
	ld hl,03af6h		;5bbe
	call L_5BD2		;5bc1
	ld a,(0e1c2h)		;5bc4
	ld hl,03ae9h		;5bc7
	ld de,0e1feh		;5bca
	add a,a			;5bcd
	jr nc,L_5BD2		;5bce
	ld e,0f9h		;5bd0
L_5BD2:
	ld b,005h		;5bd2
	call L_4A1D		;5bd4
	exx			;5bd7
	ld a,c			;5bd8
	exx			;5bd9
	ld c,a			;5bda
	jr L_5C08		;5bdb
L_5BDD:
	ld hl,03ae3h		;5bdd
	ld de,0e200h		;5be0
	ld a,(de)			;5be3
	ld b,001h		;5be4
	and 0f0h		;5be6
	jr nz,L_5BF7		;5be8
	call L_4A1D		;5bea
	exx			;5bed
	ld a,c			;5bee
	exx			;5bef
	ld c,a			;5bf0
	xor a			;5bf1
	out (c),a		;5bf2
	inc hl			;5bf4
	jr L_5C08		;5bf5
L_5BF7:
	call L_4A1D		;5bf7
	exx			;5bfa
	ld a,c			;5bfb
	exx			;5bfc
	ld c,a			;5bfd
L_5BFE:
	ld a,(de)			;5bfe
	rra			;5bff
	rra			;5c00
	rra			;5c01
	rra			;5c02
	and 00fh		;5c03
	inc a			;5c05
	out (c),a		;5c06
L_5C08:
	ld a,(de)			;5c08
	and 00fh		;5c09
	inc a			;5c0b
	out (c),a		;5c0c
	dec de			;5c0e
	djnz L_5BFE		;5c0f
	ret			;5c11
L_5C12:
	ld a,(0f0f5h)		;5c12
	or a			;5c15
	ret nz			;5c16
	ld de,0b2a4h		;5c17
	call L_4A6B		;5c1a
	ld de,0e1f4h		;5c1d
	ld hl,03a2bh		;5c20
	ld b,005h		;5c23
	call L_5BF7		;5c25
	call L_413B		;5c28
	ld hl,0e1f1h		;5c2b
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
	ld de,0f000h		;5c44
	ld (de),a			;5c47
	ld a,(0e1c3h)		;5c48
	and 077h		;5c4b
	inc e			;5c4d
	ld (de),a			;5c4e
	and 007h		;5c4f
	add a,a			;5c51
	ld b,a			;5c52
	add a,a			;5c53
	add a,a			;5c54
	add a,b			;5c55
	ld hl,0bbb9h		;5c56
	call L_407A		;5c59
	dec e			;5c5c
	ld a,(de)			;5c5d
	ld b,a			;5c5e
	and 00fh		;5c5f
	ld e,l			;5c61
	ld d,h			;5c62
	call L_407A		;5c63
	ld c,(hl)			;5c66
	ld a,b			;5c67
	rra			;5c68
	rra			;5c69
	rra			;5c6a
	rra			;5c6b
	and 00fh		;5c6c
	call L_407F		;5c6e
	ld a,(de)			;5c71
	rla			;5c72
	rla			;5c73
	rla			;5c74
	rla			;5c75
	and 0f0h		;5c76
	or c			;5c78
	ld de,0f002h		;5c79
	ld (de),a			;5c7c
	ld hl,03a6eh		;5c7d
	ld b,002h		;5c80
	call L_5BF7		;5c82
	jp L_4157		;5c85
L_5C88:
	ld c,(hl)			;5c88
	ld a,(de)			;5c89
	ld (hl),a			;5c8a
	ld a,c			;5c8b
	ld (de),a			;5c8c
	inc hl			;5c8d
	inc de			;5c8e
	djnz L_5C88		;5c8f
	ret			;5c91
L_5C92:
	ld a,l			;5c92
	rra			;5c93
	rra			;5c94
	rra			;5c95
	rra			;5c96
	rr h		;5c97
	rra			;5c99
	rr h		;5c9a
	rra			;5c9c
	rr h		;5c9d
	ld l,h			;5c9f
	and 003h		;5ca0
	add a,0edh		;5ca2
	ld h,a			;5ca4
	ret			;5ca5
L_5CA6:
	add a,l			;5ca6
	ld l,a			;5ca7
	jr nc,L_5CAB		;5ca8
	inc h			;5caa
L_5CAB:
	ld a,(hl)			;5cab
	ret			;5cac
L_5CAD:
	ld a,e			;5cad
	cpl			;5cae
	ld e,a			;5caf
	ld a,d			;5cb0
	cpl			;5cb1
	ld d,a			;5cb2
	inc de			;5cb3
	ret			;5cb4
L_5CB5:
	ld a,l			;5cb5
	cpl			;5cb6
	ld l,a			;5cb7
	ld a,h			;5cb8
	cpl			;5cb9
	ld h,a			;5cba
	inc hl			;5cbb
	ret			;5cbc
L_5CBD:
	ld a,0ffh		;5cbd
	ld hl,0e1aeh		;5cbf
	ld (hl),a			;5cc2
	inc hl			;5cc3
	ld (hl),a			;5cc4
	inc hl			;5cc5
	ld de,0e1b1h		;5cc6
	ld (hl),001h		;5cc9
	ld bc,00009h		;5ccb
	ldir		;5cce
	ld a,004h		;5cd0
	ld (07000h),a		;5cd2
	inc a			;5cd5
	ld (09000h),a		;5cd6
	inc a			;5cd9
	ld (0b000h),a		;5cda
	call 071aeh		;5cdd
	ld a,(0f0f1h)		;5ce0
	ld (07000h),a		;5ce3
	ld a,(0f0f2h)		;5ce6
	ld (09000h),a		;5ce9
	ld a,(0f0f3h)		;5cec
	ld (0b000h),a		;5cef
	ld a,0bfh		;5cf2
	ld (0e1a6h),a		;5cf4
	ld e,a			;5cf7
	ld a,007h		;5cf8
	call 00093h		;5cfa   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,043h		;5cfd
	call L_4AE4		;5cff
	ld hl,00000h		;5d02
	ld bc,04000h		;5d05
	xor a			;5d08
	call 00056h		;5d09   ; BIOS FILVRM - Fills VRAM with value
L_5D0C:
	ld hl,05d1dh		;5d0c
	ld d,008h		;5d0f
	ld c,000h		;5d11
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


L_5D25:
	ld c,007h		;5d25
	jp L_4077		;5d27
L_5D2A:
	call L_5D40		;5d2a
	ld hl,0e1c9h		;5d2d
L_5D30:
	ld c,(hl)			;5d30
	ld (hl),a			;5d31
	xor c			;5d32
	and (hl)			;5d33
	dec hl			;5d34
	ld (hl),a			;5d35
	ret			;5d36
L_5D37:
	ld e,08fh		;5d37
	call L_5D72		;5d39
	and 03fh		;5d3c
	jr L_5D47		;5d3e
L_5D40:
	ld e,08fh		;5d40
	call L_5D72		;5d42
	and 03fh		;5d45
L_5D47:
	push af			;5d47
	ld a,004h		;5d48
	call 00141h		;5d4a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5d4d
	and 00ch		;5d4e
	ld e,a			;5d50
	jr z,L_5D55		;5d51
	ld e,020h		;5d53
L_5D55:
	ld a,008h		;5d55
	call 00141h		;5d57   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5d5a
	rrca			;5d5b
	rrca			;5d5c
	ld b,a			;5d5d
	and 004h		;5d5e
	or e			;5d60
	ld c,a			;5d61
	ld a,b			;5d62
	rrca			;5d63
	rrca			;5d64
	ld b,a			;5d65
	and 018h		;5d66
	or c			;5d68
	ld c,a			;5d69
	ld a,b			;5d6a
	rrca			;5d6b
	and 003h		;5d6c
	or c			;5d6e
	pop bc			;5d6f
	or b			;5d70
	ret			;5d71
L_5D72:
	ld a,00fh		;5d72
	call 00093h		;5d74   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;5d77
	di			;5d79
	call 00096h		;5d7a   ; BIOS RDPSG - Reads value from PSG-register
	ei			;5d7d
	cpl			;5d7e
	ret			;5d7f
L_5D80:
	call L_4108		;5d80
	call 0aa2fh		;5d83
	jp L_4133		;5d86
L_5D89:
	ld hl,(0f0f7h)		;5d89
	rst 20h			;5d8c
	ret			;5d8d
L_5D8E:
	call L_5DA0		;5d8e
	jp 069efh		;5d91
L_5D94:
	call L_5DA0		;5d94
L_5D97:
	call L_4117		;5d97
	call L_4B43		;5d9a
	jp L_4133		;5d9d
L_5DA0:
	call L_4144		;5da0
	ld ix,0b3d0h		;5da3
	call L_4595		;5da7
	xor a			;5daa
	ld (0f000h),a		;5dab
	ld ix,0b3eah		;5dae
	call L_454E		;5db2
	ld a,001h		;5db5
	ld (0f000h),a		;5db7
	ld ix,0b3fbh		;5dba
	call L_454E		;5dbe
	call L_413B		;5dc1
	ld hl,01800h		;5dc4
	ld de,0a9bah		;5dc7
	jp L_4A8C		;5dca
L_5DCD:
	ld hl,02038h		;5dcd
	ld de,0e500h		;5dd0
	ld bc,00158h		;5dd3
	call 00059h		;5dd6   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02500h		;5dd9
	ld de,0e500h		;5ddc
	ld bc,00158h		;5ddf
	exx			;5de2
	ld b,002h		;5de3
	call L_4A3A		;5de5
	ld a,0f0h		;5de8
	ld hl,00500h		;5dea
	ld bc,00158h		;5ded
	ld d,002h		;5df0
	call L_4A4C		;5df2
	call L_413B		;5df5
	ld ix,0a000h		;5df8
	call L_4595		;5dfc
	xor a			;5dff
	ld (0f000h),a		;5e00
	ld ix,0a00dh		;5e03
	call L_454E		;5e07
	jr L_5D97		;5e0a
L_5E0C:
	call L_5E5F		;5e0c
	call L_5E20		;5e0f
L_5E12:
	jr L_5D97		;5e12
L_5E14:
	call L_5E59		;5e14
	call L_5E20		;5e17
	jp 069f2h		;5e1a
L_5E1D:
	call L_5E64		;5e1d
L_5E20:
	call L_4144		;5e20
	ld de,0aff8h		;5e23
	ld hl,02130h		;5e26
	ld bc,003d8h		;5e29
	call L_4A37		;5e2c
	call L_413B		;5e2f
	ld de,0bc09h		;5e32
	ld hl,02508h		;5e35
	ld bc,002e8h		;5e38
	call L_4A37		;5e3b
	ld de,0bef1h		;5e3e
	ld hl,02108h		;5e41
	ld bc,00028h		;5e44
	call L_4A37		;5e47
	ld a,(0f000h)		;5e4a
	ld d,a			;5e4d
	ld a,0f0h		;5e4e
	ld hl,00008h		;5e50
	ld bc,007f0h		;5e53
	jp L_4A4A		;5e56
L_5E59:
	call L_5E64		;5e59
	jp 069f2h		;5e5c
L_5E5F:
	call L_5E64		;5e5f
L_5E62:
	jr L_5E12		;5e62
L_5E64:
	call L_4137		;5e64
	call 0b6cdh		;5e67
	ld hl,030a0h		;5e6a
	ld de,0e500h		;5e6d
	ld bc,00030h		;5e70
	call 00059h		;5e73   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02008h		;5e76
	ld de,0e500h		;5e79
	ld bc,00030h		;5e7c
	call L_4A37		;5e7f
	ld hl,02108h		;5e82
	ld de,0e500h		;5e85
	ld bc,000d0h		;5e88
	call 00059h		;5e8b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,02038h		;5e8e
	ld de,0e500h		;5e91
	ld bc,000d0h		;5e94
	jp L_4A37		;5e97
L_5E9A:
	call L_5EA9		;5e9a
	call L_5D97		;5e9d
	jp 0a435h		;5ea0
L_5EA3:
	call L_5EA9		;5ea3
L_5EA6:
	jp 069efh		;5ea6
L_5EA9:
	call L_4144		;5ea9
	ld ix,0a214h		;5eac
	call L_4595		;5eb0
	xor a			;5eb3
	ld (0f000h),a		;5eb4
	ld ix,0a228h		;5eb7
	call L_454E		;5ebb
	ld a,001h		;5ebe
	ld (0f000h),a		;5ec0
	ld ix,0a22fh		;5ec3
	call L_454E		;5ec7
	ld a,(0002bh)		;5eca
	and 00fh		;5ecd
	ret z			;5ecf
	ld ix,0a221h		;5ed0
	jp L_4595		;5ed4
L_5ED7:
	call L_5EE1		;5ed7
	jr L_5EA6		;5eda
L_5EDC:
	call L_5EE1		;5edc
	jr L_5E62		;5edf
L_5EE1:
	call L_4144		;5ee1
	ld ix,0a143h		;5ee4
	call L_4595		;5ee8
	xor a			;5eeb
	ld (0f000h),a		;5eec
	ld ix,0a15ch		;5eef
	jp L_454E		;5ef3
L_5EF6:
	xor a			;5ef6
	ld (0e1c9h),a		;5ef7
	ld (0e1c7h),a		;5efa
	inc a			;5efd
	ld (0e1d3h),a		;5efe
	ld hl,0e1c6h		;5f01
	ld a,(hl)			;5f04
	ld (0e201h),a		;5f05
	inc a			;5f08
	cp 007h		;5f09
	jr c,L_5F0F		;5f0b
	ld a,002h		;5f0d
L_5F0F:
	ld (hl),a			;5f0f
	ld hl,00001h		;5f10
	ld (0e1cbh),hl		;5f13
	xor a			;5f16
	ld (0e1cdh),a		;5f17
	ld (0e20ah),a		;5f1a
	call 060fdh		;5f1d
	call 08196h		;5f20
	xor a			;5f23
	ld (0e228h),a		;5f24
	jp L_5BA3		;5f27
L_5F2A:
	ld a,(0e204h)		;5f2a
	and a			;5f2d
	jr z,L_5F35		;5f2e
L_5F30:
	xor a			;5f30
	ld (0e1d3h),a		;5f31
	ret			;5f34
L_5F35:
	ld hl,0e1cbh		;5f35
	dec (hl)			;5f38
	jr z,L_5F46		;5f39
L_5F3B:
	ld a,(0e1cch)		;5f3b
	or 010h		;5f3e
	ld (0e1c9h),a		;5f40
	jp L_416D		;5f43
L_5F46:
	inc hl			;5f46
	inc hl			;5f47
	ld c,(hl)			;5f48
	inc (hl)			;5f49
	call L_413F		;5f4a
	ld a,(0e201h)		;5f4d
	ld hl,l5f69h		;5f50
	call L_4B67		;5f53
	ld l,c			;5f56
	ld h,000h		;5f57
	add hl,hl			;5f59
	add hl,de			;5f5a
	ld a,(hl)			;5f5b
	ld c,a			;5f5c
	ld (0e1cbh),a		;5f5d
	inc hl			;5f60
	ld a,(hl)			;5f61
	ld (0e1cch),a		;5f62
	call L_4157		;5f65
	inc c			;5f68
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


L_5F77:
	call 06878h		;5f77
	ret nz			;5f7a
	call L_413F		;5f7b
	call L_5F84		;5f7e
	jp L_4108		;5f81
L_5F84:
	ld a,(0e3b2h)		;5f84
	and a			;5f87
	ret z			;5f88
	ld b,a			;5f89
	ld ix,0e500h		;5f8a
L_5F8E:
	xor a			;5f8e
	ld (0f000h),a		;5f8f
	ld a,(ix+000h)		;5f92
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
	call L_5FB5		;5fa9
	pop bc			;5fac
L_5FAD:
	ld de,00010h		;5fad
	add ix,de		;5fb0
	djnz L_5F8E		;5fb2
	ret			;5fb4
L_5FB5:
	ld a,(ix+000h)		;5fb5
	sub 005h		;5fb8
	cp 002h		;5fba
	jr c,L_5FFB		;5fbc
	ld a,(ix+006h)		;5fbe
	and a			;5fc1
	ret z			;5fc2
	ld a,(ix+000h)		;5fc3
	cp 007h		;5fc6
	ret z			;5fc8
	cp 005h		;5fc9
	jr nc,L_5FFB		;5fcb
	cp 002h		;5fcd
	jr z,L_5FFB		;5fcf
	ret			;5fd1
L_5FD2:
	call 06878h		;5fd2
	ret nz			;5fd5
	call L_413F		;5fd6
	call L_5FDF		;5fd9
	jp L_4108		;5fdc
L_5FDF:
	ld a,(0e3b2h)		;5fdf
	and a			;5fe2
	ret z			;5fe3
	ld b,a			;5fe4
	ld ix,0e500h		;5fe5
	ld a,0ffh		;5fe9
	ld (0f000h),a		;5feb
L_5FEE:
	push bc			;5fee
	call L_5FFB		;5fef
	pop bc			;5ff2
	ld de,00010h		;5ff3
	add ix,de		;5ff6
	djnz L_5FEE		;5ff8
	ret			;5ffa
L_5FFB:
	ld a,(ix+000h)		;5ffb
	and a			;5ffe
	ret z			;5fff

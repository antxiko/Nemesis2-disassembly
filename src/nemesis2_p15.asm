; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS cifras_grandes_dibujos_cola: dibujos de 48 bytes (8 filas de 6) que
;   p00:541B saca al VDP fila a fila, con un byte de borde a cada lado (0xFF,
;   o 0x00 desde el 0x14) (sigue del banco 14); lo leen p00:5420 (183 bytes)
;   0xa000..0xa0b7  (183 bytes)
DATA_cifras_grandes_dibujos_cola:
	defb 050h,058h,04ah,0e7h,0b4h,097h	; a000
	defb 095h,095h,0f4h,0a8h,0a8h,0a8h	; a006
	defb 028h,0a8h,0aeh,087h,080h,080h	; a00c
	defb 080h,080h,0e7h,0e6h,026h,020h	; a012
	defb 020h,026h,0e6h,000h,000h,000h	; a018
	defb 000h,000h,000h,000h,000h,000h	; a01e
	defb 000h,000h,000h,07eh,040h,040h	; a024
	defb 040h,040h,07eh,04bh,04ah,04bh	; a02a
	defb 04ah,05ah,073h,0bbh,021h,0a1h	; a030
	defb 021h,021h,0b9h,0bdh,025h,025h	; a036
	defb 025h,025h,03dh,0e7h,020h,0e0h	; a03c
	defb 040h,060h,027h,0e6h,026h,020h	; a042
	defb 020h,026h,0e6h,000h,000h,000h	; a048
	defb 000h,000h,000h,000h,000h,000h	; a04e
	defb 000h,000h,000h,07eh,040h,040h	; a054
	defb 040h,040h,07eh,078h,040h,078h	; a05a
	defb 040h,040h,07ah,0f4h,084h,0f4h	; a060
	defb 014h,014h,0f7h,07ah,04ah,04ah	; a066
	defb 04ah,04ah,07bh,0a7h,0a0h,0a0h	; a06c
	defb 0a0h,0a0h,0e7h,0e6h,026h,020h	; a072
	defb 020h,026h,0e6h,000h,000h,000h	; a078
	defb 000h,000h,000h,000h,000h,000h	; a07e
	defb 000h,000h,000h,01eh,012h,012h	; a084
	defb 012h,012h,01eh,025h,025h,025h	; a08a
	defb 025h,02dh,0b9h,0efh,029h,0efh	; a090
	defb 02ah,02bh,029h,07ah,04ah,07ah	; a096
	defb 052h,05ah,04ah,0f7h,094h,097h	; a09c
	defb 095h,095h,0f4h,086h,086h,080h	; a0a2
	defb 000h,086h,086h,000h,000h,000h	; a0a8
	defb 000h,000h,000h,000h,000h,000h	; a0ae
	defb 000h,000h,000h	; a0b4

; ----------------------------------------------------------------------
; DATOS guion_fase_7: la lista de la fase 7 que p01:7248 da a p01:72B2 (0xE3B1
;   x 3): fichas [dato][posicion lo][posicion hi (3 bits) e Y], hasta FF FF
;   FF; lo leen p01:72C3 (36 bytes)
;   0xa0b7..0xa0db  (36 bytes)
DATA_guion_fase_7:
	defb 000h,058h,081h	; a0b7
	defb 000h,05ch,091h	; a0ba
	defb 000h,05eh,091h	; a0bd
	defb 000h,068h,081h	; a0c0
	defb 000h,06ah,081h	; a0c3
	defb 000h,082h,081h	; a0c6
	defb 000h,090h,091h	; a0c9
	defb 000h,098h,091h	; a0cc
	defb 000h,09ah,091h	; a0cf
	defb 000h,0a8h,081h	; a0d2
	defb 000h,0aah,081h	; a0d5
	defb 0ffh,0ffh,0ffh	; a0d8

; ----------------------------------------------------------------------
; DATOS guion_fase_9: la lista de la fase 9 que p01:7248 da a p01:72B2 (0xE3B1
;   x 3): fichas [dato][posicion lo][posicion hi (3 bits) e Y], hasta FF FF
;   FF; lo leen p01:72C3 (114 bytes)
;   0xa0db..0xa14d  (114 bytes)
DATA_guion_fase_9:
	defb 00bh,03ch,090h	; a0db
	defb 00bh,03eh,090h	; a0de
	defb 003h,04ch,090h	; a0e1
	defb 003h,050h,090h	; a0e4
	defb 003h,052h,090h	; a0e7
	defb 003h,054h,090h	; a0ea
	defb 00bh,08ch,010h	; a0ed
	defb 00bh,08eh,010h	; a0f0
	defb 00bh,090h,010h	; a0f3
	defb 003h,094h,030h	; a0f6
	defb 003h,096h,030h	; a0f9
	defb 003h,096h,040h	; a0fc
	defb 003h,098h,040h	; a0ff
	defb 003h,098h,050h	; a102
	defb 003h,09ah,050h	; a105
	defb 003h,0cch,070h	; a108
	defb 003h,0ceh,070h	; a10b
	defb 003h,0d0h,070h	; a10e
	defb 003h,0d0h,090h	; a111
	defb 003h,0d2h,070h	; a114
	defb 003h,0d4h,090h	; a117
	defb 003h,0d6h,090h	; a11a
	defb 003h,0d8h,090h	; a11d
	defb 003h,0dah,090h	; a120
	defb 003h,012h,071h	; a123
	defb 003h,014h,071h	; a126
	defb 003h,016h,071h	; a129
	defb 003h,018h,091h	; a12c
	defb 003h,01ah,091h	; a12f
	defb 003h,01ch,091h	; a132
	defb 003h,01eh,091h	; a135
	defb 003h,020h,091h	; a138
	defb 003h,022h,091h	; a13b
	defb 003h,024h,091h	; a13e
	defb 003h,026h,091h	; a141
	defb 003h,028h,091h	; a144
	defb 003h,02ah,091h	; a147
	defb 0ffh,0ffh,0ffh	; a14a

; ----------------------------------------------------------------------
; DATOS guion_fase_10: la lista de la fase 10 que p01:7248 da a p01:72B2
;   (0xE3B1 x 3): fichas [dato][posicion lo][posicion hi (3 bits) e Y], hasta
;   FF FF FF; lo leen p01:72C3 (147 bytes)
;   0xa14d..0xa1e0  (147 bytes)
DATA_guion_fase_10:
	defb 00bh,034h,060h	; a14d
	defb 00bh,034h,070h	; a150
	defb 00bh,036h,060h	; a153
	defb 00bh,036h,070h	; a156
	defb 003h,048h,070h	; a159
	defb 003h,04ah,070h	; a15c
	defb 003h,04ch,080h	; a15f
	defb 003h,04eh,080h	; a162
	defb 00bh,05ch,030h	; a165
	defb 00bh,05eh,030h	; a168
	defb 003h,06ah,068h	; a16b
	defb 003h,06ah,088h	; a16e
	defb 003h,06ch,078h	; a171
	defb 003h,06ch,090h	; a174
	defb 003h,06dh,058h	; a177
	defb 003h,06eh,090h	; a17a
	defb 003h,070h,058h	; a17d
	defb 003h,070h,080h	; a180
	defb 003h,072h,090h	; a183
	defb 003h,08ch,070h	; a186
	defb 003h,08eh,070h	; a189
	defb 003h,094h,070h	; a18c
	defb 00bh,0a8h,070h	; a18f
	defb 00bh,0a8h,080h	; a192
	defb 00bh,0aah,070h	; a195
	defb 00bh,0aah,080h	; a198
	defb 002h,0b8h,070h	; a19b
	defb 003h,0d8h,070h	; a19e
	defb 003h,0dah,070h	; a1a1
	defb 003h,0dah,090h	; a1a4
	defb 003h,0dch,090h	; a1a7
	defb 003h,0dch,070h	; a1aa
	defb 003h,0deh,070h	; a1ad
	defb 00bh,0eah,068h	; a1b0
	defb 003h,0ech,028h	; a1b3
	defb 00bh,0ech,068h	; a1b6
	defb 00ch,0eeh,068h	; a1b9
	defb 00ch,0f0h,068h	; a1bc
	defb 00bh,0f2h,068h	; a1bf
	defb 00bh,0f4h,068h	; a1c2
	defb 002h,024h,041h	; a1c5
	defb 00bh,037h,031h	; a1c8
	defb 00bh,039h,011h	; a1cb
	defb 00bh,039h,021h	; a1ce
	defb 00bh,039h,031h	; a1d1
	defb 00bh,039h,071h	; a1d4
	defb 00bh,03bh,031h	; a1d7
	defb 00ch,03bh,071h	; a1da
	defb 0ffh,0ffh,0ffh	; a1dd

; ----------------------------------------------------------------------
; DATOS guion_fase_11: la lista de la fase 11 que p01:7248 da a p01:72B2
;   (0xE3B1 x 3): fichas [dato][posicion lo][posicion hi (3 bits) e Y], hasta
;   FF FF FF; lo leen p01:72C3 (204 bytes)
;   0xa1e0..0xa2ac  (204 bytes)
DATA_guion_fase_11:
	defb 00bh,038h,020h	; a1e0
	defb 00bh,03ah,020h	; a1e3
	defb 00bh,054h,050h	; a1e6
	defb 00bh,056h,050h	; a1e9
	defb 00bh,05ah,060h	; a1ec
	defb 00bh,05ch,070h	; a1ef
	defb 00bh,05eh,070h	; a1f2
	defb 00bh,064h,060h	; a1f5
	defb 00bh,068h,050h	; a1f8
	defb 00bh,06ah,040h	; a1fb
	defb 00bh,06eh,040h	; a1fe
	defb 00bh,070h,060h	; a201
	defb 00bh,072h,030h	; a204
	defb 00bh,072h,060h	; a207
	defb 00bh,076h,030h	; a20a
	defb 00bh,078h,060h	; a20d
	defb 00bh,07ch,020h	; a210
	defb 00bh,07eh,020h	; a213
	defb 00bh,07eh,070h	; a216
	defb 00bh,084h,060h	; a219
	defb 00bh,086h,020h	; a21c
	defb 00bh,088h,070h	; a21f
	defb 00bh,08ah,060h	; a222
	defb 00bh,090h,060h	; a225
	defb 00bh,092h,060h	; a228
	defb 00bh,094h,038h	; a22b
	defb 00bh,094h,060h	; a22e
	defb 00bh,098h,088h	; a231
	defb 00bh,09ah,050h	; a234
	defb 00bh,09ch,018h	; a237
	defb 00bh,09ch,050h	; a23a
	defb 00bh,0a2h,050h	; a23d
	defb 00bh,0afh,030h	; a240
	defb 00bh,0b4h,048h	; a243
	defb 00bh,0b6h,058h	; a246
	defb 00bh,0b7h,038h	; a249
	defb 00bh,0bbh,040h	; a24c
	defb 00bh,0beh,010h	; a24f
	defb 00bh,0c4h,050h	; a252
	defb 00bh,0c6h,050h	; a255
	defb 00bh,0cah,038h	; a258
	defb 00bh,0ceh,028h	; a25b
	defb 00bh,0d0h,050h	; a25e
	defb 00bh,0d2h,090h	; a261
	defb 00bh,0dch,060h	; a264
	defb 00bh,0dch,090h	; a267
	defb 00bh,0deh,060h	; a26a
	defb 00bh,0f6h,048h	; a26d
	defb 00bh,0f8h,078h	; a270
	defb 00bh,0fah,048h	; a273
	defb 00bh,0fah,078h	; a276
	defb 00bh,004h,049h	; a279
	defb 00bh,004h,091h	; a27c
	defb 00bh,006h,049h	; a27f
	defb 00bh,015h,019h	; a282
	defb 003h,018h,061h	; a285
	defb 003h,018h,071h	; a288
	defb 003h,01eh,011h	; a28b
	defb 003h,01eh,021h	; a28e
	defb 003h,02ch,021h	; a291
	defb 003h,02ch,021h	; a294
	defb 003h,02eh,021h	; a297
	defb 003h,02eh,031h	; a29a
	defb 003h,030h,021h	; a29d
	defb 003h,030h,031h	; a2a0
	defb 003h,032h,021h	; a2a3
	defb 003h,032h,031h	; a2a6
	defb 0ffh,0ffh,0ffh	; a2a9

; ----------------------------------------------------------------------
; DATOS objetos_fase_3: la lista de la fase 3 de p01:6AE0 (0xA2AC en la 3, la
;   tabla 0x6B7F en las 9-11; 0xE369 x 3): fichas [posicion lo][bit alto de la
;   posicion e Y][tipo], hasta FF FF; lo leen p01:6AFC (182 bytes)
;   0xa2ac..0xa362  (182 bytes)
DATA_objetos_fase_3:
	defb 08ch,068h,003h	; a2ac
	defb 090h,080h,005h	; a2af
	defb 090h,010h,001h	; a2b2
	defb 092h,028h,007h	; a2b5
	defb 096h,050h,001h	; a2b8
	defb 0afh,088h,001h	; a2bb
	defb 0b3h,070h,001h	; a2be
	defb 0bch,088h,001h	; a2c1
	defb 0beh,058h,003h	; a2c4
	defb 0c0h,020h,001h	; a2c7
	defb 0c2h,038h,005h	; a2ca
	defb 0c4h,070h,006h	; a2cd
	defb 0d4h,020h,001h	; a2d0
	defb 0d7h,068h,001h	; a2d3
	defb 0d8h,038h,001h	; a2d6
	defb 0d8h,080h,005h	; a2d9
	defb 0dah,050h,001h	; a2dc
	defb 0ech,088h,001h	; a2df
	defb 0eeh,030h,001h	; a2e2
	defb 0f2h,048h,004h	; a2e5
	defb 0f3h,018h,001h	; a2e8
	defb 0f8h,060h,007h	; a2eb
	defb 0fch,060h,007h	; a2ee
	defb 003h,031h,001h	; a2f1
	defb 051h,043h,001h	; a2f4
	defb 054h,011h,00ch	; a2f7
	defb 054h,089h,002h	; a2fa
	defb 058h,071h,001h	; a2fd
	defb 05ah,029h,003h	; a300
	defb 05ch,041h,006h	; a303
	defb 060h,011h,001h	; a306
	defb 06dh,029h,001h	; a309
	defb 070h,041h,005h	; a30c
	defb 070h,061h,005h	; a30f
	defb 070h,081h,005h	; a312
	defb 076h,021h,001h	; a315
	defb 076h,089h,001h	; a318
	defb 078h,039h,006h	; a31b
	defb 078h,069h,005h	; a31e
	defb 094h,089h,001h	; a321
	defb 0a4h,019h,001h	; a324
	defb 0a4h,071h,001h	; a327
	defb 0a8h,031h,001h	; a32a
	defb 0a8h,089h,001h	; a32d
	defb 0ach,049h,003h	; a330
	defb 0b2h,033h,001h	; a333
	defb 0b3h,061h,007h	; a336
	defb 0b4h,011h,00bh	; a339
	defb 0c0h,021h,00dh	; a33c
	defb 0c6h,053h,001h	; a33f
	defb 0c9h,011h,00dh	; a342
	defb 0cch,089h,001h	; a345
	defb 0ceh,011h,001h	; a348
	defb 0cfh,059h,002h	; a34b
	defb 0d0h,029h,006h	; a34e
	defb 0d1h,071h,003h	; a351
	defb 0d7h,029h,006h	; a354
	defb 0d7h,011h,001h	; a357
	defb 0d8h,089h,001h	; a35a
	defb 0dbh,029h,006h	; a35d
	defb 0ffh,0ffh	; a360

; ----------------------------------------------------------------------
; DATOS objetos_fase_9: la lista de la fase 9 de p01:6AE0 (0xA2AC en la 3, la
;   tabla 0x6B7F en las 9-11; 0xE369 x 3): fichas [posicion lo][bit alto de la
;   posicion e Y][tipo], hasta FF FF; lo leen p01:6AFC (188 bytes)
;   0xa362..0xa41e  (188 bytes)
DATA_objetos_fase_9:
	defb 02ch,010h,00ch	; a362
	defb 02dh,042h,003h	; a365
	defb 030h,010h,00ch	; a368
	defb 030h,058h,003h	; a36b
	defb 030h,070h,006h	; a36e
	defb 034h,070h,006h	; a371
	defb 03bh,010h,001h	; a374
	defb 03ch,058h,003h	; a377
	defb 040h,028h,001h	; a37a
	defb 043h,070h,006h	; a37d
	defb 048h,068h,003h	; a380
	defb 050h,028h,001h	; a383
	defb 054h,060h,001h	; a386
	defb 056h,048h,002h	; a389
	defb 058h,032h,001h	; a38c
	defb 05ah,010h,00bh	; a38f
	defb 05ch,060h,007h	; a392
	defb 066h,010h,006h	; a395
	defb 066h,040h,005h	; a398
	defb 066h,060h,007h	; a39b
	defb 06ah,058h,001h	; a39e
	defb 06dh,088h,001h	; a3a1
	defb 06fh,070h,001h	; a3a4
	defb 072h,028h,001h	; a3a7
	defb 074h,040h,006h	; a3aa
	defb 077h,010h,001h	; a3ad
	defb 084h,068h,003h	; a3b0
	defb 084h,080h,005h	; a3b3
	defb 085h,030h,001h	; a3b6
	defb 085h,048h,005h	; a3b9
	defb 088h,010h,005h	; a3bc
	defb 088h,080h,005h	; a3bf
	defb 089h,048h,005h	; a3c2
	defb 08ch,080h,005h	; a3c5
	defb 093h,060h,003h	; a3c8
	defb 0a0h,028h,001h	; a3cb
	defb 0a0h,058h,003h	; a3ce
	defb 0a1h,010h,001h	; a3d1
	defb 0a2h,040h,001h	; a3d4
	defb 0a4h,088h,003h	; a3d7
	defb 0b2h,028h,001h	; a3da
	defb 0b4h,088h,001h	; a3dd
	defb 0b5h,040h,001h	; a3e0
	defb 0b6h,058h,001h	; a3e3
	defb 0b8h,070h,002h	; a3e6
	defb 0c6h,010h,003h	; a3e9
	defb 0cfh,028h,001h	; a3ec
	defb 0d5h,040h,001h	; a3ef
	defb 0d8h,058h,001h	; a3f2
	defb 0dch,070h,001h	; a3f5
	defb 0fah,028h,003h	; a3f8
	defb 0fch,040h,003h	; a3fb
	defb 000h,011h,001h	; a3fe
	defb 000h,059h,001h	; a401
	defb 008h,059h,001h	; a404
	defb 008h,089h,001h	; a407
	defb 00ah,071h,001h	; a40a
	defb 030h,029h,001h	; a40d
	defb 030h,059h,002h	; a410
	defb 032h,011h,003h	; a413
	defb 034h,041h,001h	; a416
	defb 036h,071h,006h	; a419
	defb 0ffh,0ffh	; a41c

; ----------------------------------------------------------------------
; DATOS objetos_fase_10: la lista de la fase 10 de p01:6AE0 (0xA2AC en la 3,
;   la tabla 0x6B7F en las 9-11; 0xE369 x 3): fichas [posicion lo][bit alto de
;   la posicion e Y][tipo], hasta FF FF; lo leen p01:6AFC (173 bytes)
;   0xa41e..0xa4cb  (173 bytes)
DATA_objetos_fase_10:
	defb 026h,058h,001h	; a41e
	defb 028h,040h,001h	; a421
	defb 028h,070h,001h	; a424
	defb 02ch,088h,002h	; a427
	defb 02dh,028h,003h	; a42a
	defb 038h,058h,002h	; a42d
	defb 03eh,010h,001h	; a430
	defb 040h,040h,003h	; a433
	defb 042h,028h,001h	; a436
	defb 048h,058h,001h	; a439
	defb 050h,028h,003h	; a43c
	defb 05ah,040h,002h	; a43f
	defb 05bh,088h,001h	; a442
	defb 05ch,070h,003h	; a445
	defb 05dh,058h,001h	; a448
	defb 06ah,042h,003h	; a44b
	defb 06ch,010h,00ch	; a44e
	defb 079h,088h,003h	; a451
	defb 084h,010h,001h	; a454
	defb 085h,040h,001h	; a457
	defb 088h,028h,001h	; a45a
	defb 088h,058h,002h	; a45d
	defb 094h,028h,002h	; a460
	defb 09ch,088h,003h	; a463
	defb 09eh,070h,001h	; a466
	defb 0a0h,058h,001h	; a469
	defb 0a2h,040h,002h	; a46c
	defb 0ach,070h,003h	; a46f
	defb 0b4h,010h,003h	; a472
	defb 0b6h,058h,001h	; a475
	defb 0b7h,028h,001h	; a478
	defb 0b8h,040h,002h	; a47b
	defb 0c4h,088h,001h	; a47e
	defb 0c8h,070h,001h	; a481
	defb 0d8h,010h,001h	; a484
	defb 0dch,028h,003h	; a487
	defb 0eah,060h,003h	; a48a
	defb 0fch,088h,003h	; a48d
	defb 000h,011h,001h	; a490
	defb 006h,071h,001h	; a493
	defb 00ah,011h,003h	; a496
	defb 00ah,059h,003h	; a499
	defb 00ch,029h,006h	; a49c
	defb 00eh,071h,006h	; a49f
	defb 019h,089h,002h	; a4a2
	defb 01ah,029h,003h	; a4a5
	defb 01ch,051h,002h	; a4a8
	defb 01ch,069h,005h	; a4ab
	defb 01dh,011h,003h	; a4ae
	defb 024h,069h,005h	; a4b1
	defb 026h,039h,003h	; a4b4
	defb 030h,069h,002h	; a4b7
	defb 032h,081h,005h	; a4ba
	defb 036h,081h,005h	; a4bd
	defb 036h,033h,001h	; a4c0
	defb 038h,011h,00bh	; a4c3
	defb 03ah,081h,005h	; a4c6
	defb 0ffh,0ffh	; a4c9

; ----------------------------------------------------------------------
; DATOS objetos_fase_11: la lista de la fase 11 de p01:6AE0 (0xA2AC en la 3,
;   la tabla 0x6B7F en las 9-11; 0xE369 x 3): fichas [posicion lo][bit alto de
;   la posicion e Y][tipo], hasta FF FF; lo leen p01:6AFC (150 bytes)
;   0xa4cb..0xa561  (150 bytes)
DATA_objetos_fase_11:
	defb 026h,010h,001h	; a4cb
	defb 028h,088h,003h	; a4ce
	defb 02ch,070h,003h	; a4d1
	defb 032h,032h,003h	; a4d4
	defb 034h,010h,00bh	; a4d7
	defb 043h,040h,003h	; a4da
	defb 045h,070h,001h	; a4dd
	defb 046h,010h,001h	; a4e0
	defb 048h,058h,001h	; a4e3
	defb 049h,088h,001h	; a4e6
	defb 054h,010h,003h	; a4e9
	defb 064h,020h,003h	; a4ec
	defb 06ch,088h,001h	; a4ef
	defb 070h,040h,001h	; a4f2
	defb 07ch,030h,002h	; a4f5
	defb 08ch,048h,003h	; a4f8
	defb 090h,010h,003h	; a4fb
	defb 09ch,028h,001h	; a4fe
	defb 0a4h,010h,001h	; a501
	defb 0a5h,040h,003h	; a504
	defb 0a6h,088h,001h	; a507
	defb 0a7h,028h,001h	; a50a
	defb 0a8h,058h,006h	; a50d
	defb 0b1h,010h,001h	; a510
	defb 0b1h,068h,001h	; a513
	defb 0b9h,020h,001h	; a516
	defb 0b9h,050h,001h	; a519
	defb 0c8h,010h,001h	; a51c
	defb 0c8h,038h,001h	; a51f
	defb 0c8h,060h,001h	; a522
	defb 0d0h,020h,002h	; a525
	defb 0d4h,048h,001h	; a528
	defb 0eah,018h,003h	; a52b
	defb 0edh,068h,001h	; a52e
	defb 0f0h,030h,001h	; a531
	defb 0f0h,080h,005h	; a534
	defb 0f1h,048h,005h	; a537
	defb 0f8h,058h,003h	; a53a
	defb 0fch,010h,001h	; a53d
	defb 0feh,030h,001h	; a540
	defb 010h,011h,007h	; a543
	defb 014h,011h,005h	; a546
	defb 014h,061h,005h	; a549
	defb 01ah,011h,007h	; a54c
	defb 01ah,051h,006h	; a54f
	defb 01ah,081h,005h	; a552
	defb 020h,069h,003h	; a555
	defb 022h,081h,005h	; a558
	defb 024h,043h,002h	; a55b
	defb 028h,011h,00ch	; a55e

; ----------------------------------------------------------------------
; DATOS tabla_A561: 17 pares (tipos 0 a 16) que p01:6B41 copia (ldi, ldi) con
;   el tipo de la ficha x 2; el ultimo es tambien la entrada 0 de 0xA581; lo
;   leen p01:6B47 (34 bytes)
;   0xa561..0xa583  (34 bytes)
DATA_tabla_A561:
	defb 0ffh,0ffh	; a561
	defb 003h,008h	; a563
	defb 003h,010h	; a565
	defb 003h,00ch	; a567
	defb 003h,014h	; a569
	defb 004h,004h	; a56b
	defb 006h,004h	; a56d
	defb 008h,004h	; a56f
	defb 004h,004h	; a571
	defb 006h,004h	; a573
	defb 008h,004h	; a575
	defb 004h,004h	; a577
	defb 006h,004h	; a579
	defb 008h,004h	; a57b
	defb 004h,004h	; a57d
	defb 006h,004h	; a57f
	defb 008h,004h	; a581

; ----------------------------------------------------------------------
; DATOS piezas_A581: 16 punteros (A de 1 a 16: p01:6D11 lee 0xA581 + 2 x A con
;   L_4B60, y la 0 es el ultimo par de 0xA561): piezas que L_5327 pinta en la
;   tabla de nombres; lo leen p01:6D14 (32 bytes)
;   0xa583..0xa5a3  (32 bytes)
DATA_piezas_A581:
	defw 0a5a3h,0a5bbh,0a5ebh,0a60fh,0a64bh,0a65bh,0a673h,0a693h	; a583
	defw 0a6a3h,0a6bbh,0a64bh,0a65bh,0a673h,0a693h,0a6a3h,0a6bbh	; a593

; ----------------------------------------------------------------------
; DATOS piezas_A581_A5A3: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 0 de 0xA581; lo leen p01:6D23 (24 bytes)
;   0xa5a3..0xa5bb  (24 bytes)
DATA_piezas_A581_A5A3:
	defb 01fh,060h,061h,026h,027h,01fh,020h,01fh	; a5a3  .`a&'. .
	defb 062h,063h,064h,065h,062h,062h,065h,062h	; a5ab  bcdebbeb
	defb 020h,066h,03fh,020h,026h,027h,021h,01fh	; a5b3   f? &'!.

; ----------------------------------------------------------------------
; DATOS piezas_A581_A5BB: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 1 de 0xA581; lo leen p01:6D23 (48 bytes)
;   0xa5bb..0xa5eb  (48 bytes)
DATA_piezas_A581_A5BB:
	defb 01fh,020h,061h,026h,027h,01fh,020h,01fh	; a5bb  . a&'. .
	defb 01fh,026h,027h,01fh,01fh,020h,061h,026h	; a5c3  .&'.. a&
	defb 062h,062h,062h,065h,062h,062h,065h,062h	; a5cb  bbbebbeb
	defb 062h,062h,062h,062h,062h,063h,064h,065h	; a5d3  bbbbbcde
	defb 020h,066h,03fh,020h,060h,027h,021h,01fh	; a5db   f? `'!.
	defb 020h,03fh,01fh,01fh,020h,060h,021h,020h	; a5e3   ?.. `!

; ----------------------------------------------------------------------
; DATOS piezas_A581_A5EB: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 2 de 0xA581; lo leen p01:6D23 (36 bytes)
;   0xa5eb..0xa60f  (36 bytes)
DATA_piezas_A581_A5EB:
	defb 01fh,020h,061h,026h,027h,01fh,020h,01fh	; a5eb  . a&'. .
	defb 01fh,020h,061h,026h,062h,062h,062h,065h	; a5f3  . a&bbbe
	defb 062h,062h,065h,062h,062h,062h,063h,064h	; a5fb  bbebbbcd
	defb 020h,03fh,01fh,020h,066h,027h,03fh,01fh	; a603   ?. f'?.
	defb 020h,060h,021h,020h	; a60b

; ----------------------------------------------------------------------
; DATOS piezas_A581_A60F: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 3 de 0xA581; lo leen p01:6D23 (60 bytes)
;   0xa60f..0xa64b  (60 bytes)
DATA_piezas_A581_A60F:
	defb 01fh,020h,061h,026h,027h,01fh,020h,01fh	; a60f  . a&'. .
	defb 01fh,020h,061h,026h,027h,01fh,01fh,060h	; a617  . a&'..`
	defb 061h,026h,027h,01fh,062h,062h,062h,065h	; a61f  a&'.bbbe
	defb 062h,062h,065h,062h,062h,062h,063h,064h	; a627  bbebbbcd
	defb 065h,062h,062h,062h,063h,064h,065h,062h	; a62f  ebbbcdeb
	defb 020h,03fh,01fh,020h,066h,027h,03fh,01fh	; a637   ?. f'?.
	defb 020h,060h,021h,020h,066h,027h,020h,060h	; a63f   `! f' `
	defb 021h,020h,066h,03fh	; a647

; ----------------------------------------------------------------------
; DATOS piezas_A581_A64B: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 4, 10 de 0xA581; lo leen p01:6D23 (16
;   bytes)
;   0xa64b..0xa65b  (16 bytes)
DATA_piezas_A581_A64B:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a64b  ./0..12.
	defb 000h,033h,034h,000h,0c3h,03ah,03bh,0c4h	; a653  .34..:..

; ----------------------------------------------------------------------
; DATOS piezas_A581_A65B: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 5, 11 de 0xA581; lo leen p01:6D23 (24
;   bytes)
;   0xa65b..0xa673  (24 bytes)
DATA_piezas_A581_A65B:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a65b  ./0..12.
	defb 000h,035h,036h,000h,000h,035h,036h,000h	; a663  .56..56.
	defb 000h,035h,036h,000h,0c3h,03ah,03bh,0c4h	; a66b  .56..:..

; ----------------------------------------------------------------------
; DATOS piezas_A581_A673: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 6, 12 de 0xA581; lo leen p01:6D23 (32
;   bytes)
;   0xa673..0xa693  (32 bytes)
DATA_piezas_A581_A673:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a673  ./0..12.
	defb 000h,033h,034h,000h,000h,038h,03ch,000h	; a67b  .34..8<.
	defb 000h,035h,036h,000h,000h,035h,036h,000h	; a683  .56..56.
	defb 000h,035h,036h,000h,0c3h,03ah,03bh,0c4h	; a68b  .56..:..

; ----------------------------------------------------------------------
; DATOS piezas_A581_A693: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 7, 13 de 0xA581; lo leen p01:6D23 (16
;   bytes)
;   0xa693..0xa6a3  (16 bytes)
DATA_piezas_A581_A693:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a693  ./0..12.
	defb 000h,038h,039h,000h,0c3h,03ah,03bh,0c4h	; a69b  .89..:..

; ----------------------------------------------------------------------
; DATOS piezas_A581_A6A3: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 8, 14 de 0xA581; lo leen p01:6D23 (24
;   bytes)
;   0xa6a3..0xa6bb  (24 bytes)
DATA_piezas_A581_A6A3:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a6a3  ./0..12.
	defb 000h,038h,03ch,000h,000h,038h,039h,000h	; a6ab  .8<..89.
	defb 000h,037h,038h,000h,0c3h,03ah,03bh,0c4h	; a6b3  .78..:..

; ----------------------------------------------------------------------
; DATOS piezas_A581_A6BB: pieza de caracteres (filas x columnas de IX+04 e
;   IX+05, L_5327) de las entradas 9, 15 de 0xA581; lo leen p01:6D23 (32
;   bytes)
;   0xa6bb..0xa6db  (32 bytes)
DATA_piezas_A581_A6BB:
	defb 0c5h,02fh,030h,0c6h,000h,031h,032h,000h	; a6bb  ./0..12.
	defb 000h,033h,034h,000h,000h,038h,03ch,000h	; a6c3  .34..8<.
	defb 000h,038h,039h,000h,000h,038h,03ch,000h	; a6cb  .89..8<.
	defb 000h,037h,038h,000h,0c3h,03ah,03bh,0c4h	; a6d3  .78..:..

; ----------------------------------------------------------------------
; DATOS dibujos_A6DB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x556F (p00:4595); lo leen p00:4B29 (622
;   bytes)
;   0xa6db..0xa949  (622 bytes)
DATA_dibujos_A6DB:
	defb 0abh,007h,005h,007h,00eh,09ch,039h,073h,0edh,000h,01ch,0e6h,016h,08eh,0ceh,0e6h	; a6db  ......9s........
	defb 0e6h,0e0h,020h,080h,0c0h,0ebh,0ebh,0cbh,0ebh,003h,001h,001h,007h,0d7h,0d3h,0d7h	; a6eb  .. .............
	defb 0d7h,080h,0c0h,0a0h,0d0h,078h,03ch,09ah,0dbh,026h,03eh,04ch,003h,09ah,0e5h,04ch	; a6fb  .....x<..&>L...L
	defb 03fh,0bfh,0deh,0efh,0f7h,0f6h,0f7h,080h,04fh,0a0h,070h,0fch,0fch,018h,0e0h,000h	; a70b  ?.......O.p.....
	defb 0feh,000h,07fh,0beh,01dh,00bh,047h,08eh,01ch,0c6h,08eh,016h,07eh,0ffh,0feh,000h	; a71b  ......G.....~...
	defb 05dh,07dh,0a0h,09ch,07dh,038h,071h,0c3h,0a2h,0f0h,007h,05ch,058h,001h,043h,083h	; a72b  ]}..}8q....\X.C.
	defb 085h,0ffh,000h,03ch,0ffh,07eh,03ch,018h,03ch,0f8h,00ch,006h,002h,083h,0c1h,0c1h	; a73b  ...<.~<.<.......
	defb 0a1h,0e0h,07fh,000h,000h,075h,015h,015h,055h,045h,00eh,03fh,060h,018h,007h,000h	; a74b  .....u..UE.?`...
	defb 07fh,000h,080h,0d7h,0d7h,057h,000h,07fh,000h,015h,015h,055h,015h,055h,055h,0d5h	; a75b  .....W.....U.UU.
	defb 0d5h,080h,036h,06ch,005h,066h,0bfh,0e0h,07fh,000h,000h,075h,015h,015h,0d5h,0d0h	; a76b  ..6l.f.....u....
	defb 0c2h,0d9h,006h,00eh,01eh,02eh,018h,000h,03fh,080h,0cfh,0e0h,073h,038h,000h,080h	; a77b  ........?...s8..
	defb 0f0h,081h,0fch,086h,0f3h,099h,00ch,000h,0feh,07dh,0b8h,0d0h,0e2h,071h,038h,00ah	; a78b  .........}...q8.
	defb 0abh,00bh,000h,000h,038h,084h,0c1h,043h,084h,0f7h,0efh,06fh,0efh,001h,0f2h,000h	; a79b  ....8..C...o....
	defb 02fh,080h,06dh,080h,0d7h,0d0h,004h,0a0h,0c1h,0e0h,0f8h,0feh,0ffh,05dh,0d0h,0c2h	; a7ab  /.m..........]..
	defb 0d9h,005h,00eh,01eh,02fh,018h,03ch,02fh,000h,0fdh,01dh,020h,06fh,0f7h,0dbh,042h	; a7bb  ..../.</... o..B
	defb 0bdh,024h,03ch,03ch,042h,03ch,070h,008h,068h,048h,0aah,0bah,05dh,0ebh,03ch,042h	; a7cb  .$<<B<p.hH..].<B
	defb 03ch,0c3h,024h,0bdh,042h,0dbh,066h,02ah,04dh,06bh,076h,079h,065h,099h,0e0h,0e0h	; a7db  <.$.B.f*Mkvye...
	defb 0f0h,070h,078h,078h,07ch,03ch,0beh,0beh,0bfh,01fh,003h,05fh,089h,00fh,0f7h,078h	; a7eb  .pxx|<....._...x
	defb 0bbh,05ch,02dh,016h,00ah,005h,003h,02fh,081h,007h,003h,017h,0b3h,003h,060h,060h	; a7fb  .\-..../......``
	defb 070h,070h,078h,038h,05ch,06ch,0edh,073h,039h,09ch,00eh,007h,005h,007h,0e6h,0e6h	; a80b  ppx8\l.s9.......
	defb 0ceh,08eh,016h,0e6h,01ch,000h,0ebh,0cbh,0ebh,0ebh,0c0h,080h,020h,0e0h,0d7h,0d7h	; a81b  ............ ...
	defb 0d3h,0d7h,007h,001h,001h,003h,0dbh,09ah,03ch,078h,0d0h,0a0h,0c0h,080h,03fh,04ch	; a82b  ........<x....?L
	defb 003h,09ah,0e3h,04ch,03eh,026h,04fh,080h,0f7h,0f6h,0f7h,0efh,0deh,0bfh,0feh,000h	; a83b  ...L>&O.........
	defb 0e0h,018h,0fch,0fch,070h,0a0h,01ch,08eh,047h,00bh,01dh,0beh,07fh,000h,05dh,000h	; a84b  ....p...G.....].
	defb 0feh,0ffh,07eh,016h,08eh,0c6h,0a2h,0c3h,071h,038h,07dh,09ch,0a0h,07dh,085h,083h	; a85b  ..~.....q8}..}..
	defb 043h,001h,058h,05ch,007h,0f0h,03ch,018h,03ch,07eh,0ffh,03ch,000h,0ffh,0a1h,0c1h	; a86b  C.X\..<.<~.<....
	defb 0c1h,083h,002h,006h,00ch,0f8h,055h,015h,015h,075h,000h,000h,07fh,0e0h,07fh,000h	; a87b  ......U..u......
	defb 007h,018h,060h,03fh,00eh,045h,000h,07fh,000h,057h,0d7h,0d7h,080h,000h,0d5h,0d5h	; a88b  ..`?.E...W......
	defb 055h,055h,015h,055h,015h,015h,005h,066h,0ffh,06ch,036h,080h,0d5h,015h,015h,075h	; a89b  UU.U...f.l6....u
	defb 000h,000h,07fh,0e0h,018h,02eh,01eh,00eh,006h,0d9h,0c2h,0d0h,000h,038h,073h,0e0h	; a8ab  .............8s.
	defb 0cfh,080h,03fh,000h,00ch,099h,0f3h,086h,0fch,081h,0f0h,080h,038h,071h,0e2h,0d0h	; a8bb  ..?.........8q..
	defb 0b8h,07dh,0feh,000h,0c1h,084h,038h,000h,000h,00bh,0abh,00ah,0f2h,001h,0efh,06fh	; a8cb  .}....8........o
	defb 0efh,0f7h,084h,043h,000h,0d0h,0d7h,080h,06dh,080h,02fh,000h,05dh,000h,0feh,0f8h	; a8db  ...C....m./.]...
	defb 0e0h,000h,0a0h,000h,018h,02fh,01eh,00eh,005h,0d9h,0c2h,0d0h,0f7h,06fh,020h,01dh	; a8eb  ...../.......o .
	defb 0fdh,000h,02fh,03ch,03ch,042h,03ch,03ch,024h,0bdh,042h,0dbh,0ebh,05dh,0bah,0aah	; a8fb  ../<<B<<$.B..]..
	defb 048h,068h,008h,070h,0dbh,042h,0bdh,024h,0c3h,03ch,042h,03ch,099h,065h,079h,076h	; a90b  Hh.p.B.$.<B<.eyv
	defb 06bh,04dh,02ah,066h,03ch,07ch,078h,078h,085h,070h,0f0h,0e0h,0e0h,00fh,003h,05fh	; a91b  kM*f<|xx.p....._
	defb 08dh,01fh,0bfh,0beh,0beh,005h,00ah,016h,02dh,05ch,0bbh,078h,0f7h,003h,003h,017h	; a92b  ........-\.x....
	defb 081h,007h,003h,02fh,088h,06ch,05ch,038h,078h,070h,070h,060h,060h,000h	; a93b  .../.l\8xpp``.

; ----------------------------------------------------------------------
; DATOS dibujos_A949: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 112, ficha 1 de la lista 0x556F (p00:4595); lo leen p00:4B29 (282
;   bytes)
;   0xa949..0xaa63  (282 bytes)
DATA_dibujos_A949:
	defb 083h,080h,036h,06ch,005h,000h,083h,080h,036h,06ch,005h,006h,083h,080h,036h,06ch	; a949  ..6l....6l....6l
	defb 005h,066h,081h,0ffh,005h,000h,085h,0c0h,0f0h,007h,0c8h,007h,00bh,000h,089h,003h	; a959  .f..............
	defb 00fh,000h,000h,010h,000h,004h,002h,001h,006h,000h,083h,003h,00ch,030h,005h,002h	; a969  .............0..
	defb 083h,007h,002h,00fh,005h,000h,089h,007h,080h,038h,000h,001h,002h,004h,000h,010h	; a979  .........8......
	defb 007h,000h,08bh,018h,07ah,01bh,000h,000h,0f0h,000h,003h,00fh,03eh,0fdh,005h,000h	; a989  ....z.......>...
	defb 095h,0dch,0ddh,006h,080h,0c0h,060h,030h,018h,003h,00ch,030h,0c0h,000h,080h,0c0h	; a999  ......`0...0....
	defb 060h,060h,09ah,0dbh,002h,000h,006h,002h,082h,0c0h,080h,003h,000h,087h,06eh,0eeh	; a9a9  ``............n.
	defb 0eeh,001h,002h,002h,000h,003h,001h,007h,000h,002h,040h,003h,00bh,081h,001h,004h	; a9b9  ..........@.....
	defb 005h,088h,002h,004h,008h,030h,060h,01dh,05dh,05dh,007h,000h,081h,080h,005h,000h	; a9c9  .....0`.]]......
	defb 083h,06ch,036h,080h,005h,006h,083h,06ch,036h,080h,005h,066h,085h,06ch,036h,080h	; a9d9  .l6....l6..f.l6.
	defb 0f0h,0c0h,00bh,000h,085h,007h,0c8h,007h,00fh,003h,007h,000h,083h,001h,002h,004h	; a9e9  ................
	defb 004h,010h,083h,030h,00ch,003h,005h,000h,083h,00fh,002h,007h,005h,002h,083h,038h	; a9f9  ...0...........8
	defb 080h,007h,007h,000h,089h,010h,000h,004h,002h,001h,000h,01bh,07ah,018h,005h,000h	; aa09  ............z...
	defb 084h,0fdh,03eh,00fh,003h,004h,000h,083h,006h,0ddh,0dch,005h,000h,090h,030h,00ch	; aa19  ..>...........0.
	defb 003h,018h,030h,060h,0c0h,080h,0dbh,09ah,060h,060h,0c0h,080h,000h,0c0h,006h,002h	; aa29  ..0`....``......
	defb 085h,000h,002h,0eeh,0eeh,06eh,003h,000h,083h,080h,0c0h,000h,003h,001h,086h,000h	; aa39  .....n..........
	defb 002h,002h,001h,040h,040h,007h,000h,003h,005h,081h,001h,003h,00bh,002h,05dh,087h	; aa49  ...@@.........].
	defb 01dh,060h,030h,008h,004h,002h,080h,007h,000h,000h	; aa59  .`0.......

; ----------------------------------------------------------------------
; DATOS dibujos_AA63: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 109, ficha 2 de la lista 0x556F (p00:4595); lo leen p00:4B29 (26
;   bytes)
;   0xaa63..0xaa7d  (26 bytes)
DATA_dibujos_AA63:
	defb 098h,0f0h,007h,05ch,058h,001h,043h,083h,085h,000h,000h,03ch,000h,07eh,03ch,018h	; aa63  ...\X.C....<.~<.
	defb 03ch,0f8h,00ch,006h,002h,083h,0c1h,0c1h,0a1h,000h	; aa73  <.........

; ----------------------------------------------------------------------
; DATOS dibujos_AA7D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 192, ficha 3 de la lista 0x556F (p00:4595); lo leen p00:4B29 (26
;   bytes)
;   0xaa7d..0xaa97  (26 bytes)
DATA_dibujos_AA7D:
	defb 098h,085h,083h,043h,001h,058h,05ch,007h,0f0h,03ch,018h,03ch,07eh,000h,03ch,000h	; aa7d  ...C.X\..<.<~.<.
	defb 000h,0a1h,0c1h,0c1h,083h,002h,006h,00ch,0f8h,000h	; aa8d  ..........

; ----------------------------------------------------------------------
; DATOS dibujos_AA97: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 198, ficha 6 de la lista 0x556F (p00:4595); lo leen p00:4B29 (10
;   bytes)
;   0xaa97..0xaaa1  (10 bytes)
DATA_dibujos_AA97:
	defb 088h,077h,088h,000h,0f8h,08fh,000h,0eeh,0eeh,000h	; aa97  .w........

; ----------------------------------------------------------------------
; DATOS colores_AAA1: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 198, ficha 6 de la lista 0x556F (p00:4595); lo leen p00:4B29 (10
;   bytes)
;   0xaaa1..0xaaab  (10 bytes)
DATA_colores_AAA1:
	defb 088h,060h,06ah,000h,075h,075h,000h,0a6h,060h,000h	; aaa1  .`j.uu..`.

; ----------------------------------------------------------------------
; DATOS colores_AAAB: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 31, ficha 0 de la lista 0x556F (p00:4595); lo leen p00:4B29 (537
;   bytes)
;   0xaaab..0xacc4  (537 bytes)
DATA_colores_AAAB:
	defb 087h,030h,0c0h,040h,050h,0e0h,0e0h,050h,003h,040h,096h,050h,040h,040h,050h,070h	; aaab  .0.@P..P.@.P@@Pp
	defb 0f0h,040h,040h,020h,030h,0e4h,0f4h,0f5h,0e4h,0e0h,0e0h,020h,030h,0e4h,0f5h,0f5h	; aabb  .@@ 0...... 0...
	defb 0e4h,004h,0e0h,092h,0f0h,050h,0e0h,0f4h,040h,050h,0e0h,076h,0e8h,0f6h,0e0h,050h	; aacb  .....P..@P.v...P
	defb 040h,040h,050h,070h,0e0h,0f0h,003h,040h,002h,070h,085h,0e7h,0e5h,0f4h,050h,050h	; aadb  @@Pp...@.p....PP
	defb 003h,040h,002h,050h,003h,040h,099h,0e0h,050h,040h,0e5h,050h,070h,070h,0d0h,0e0h	; aaeb  .@.P.@..P@.Ppp..
	defb 050h,055h,0e0h,070h,040h,040h,0e5h,0e0h,050h,040h,050h,060h,060h,080h,090h,0eeh	; aafb  PU.p@@..P@P``...
	defb 003h,060h,084h,086h,098h,0f9h,0f9h,004h,0e0h,002h,060h,092h,080h,090h,075h,070h	; ab0b  .`........`...up
	defb 070h,050h,040h,050h,070h,0f0h,040h,050h,050h,075h,074h,074h,070h,050h,003h,040h	; ab1b  pP@Pp.@PPuttpP.@
	defb 085h,050h,070h,070h,060h,0f9h,008h,0f0h,089h,040h,050h,040h,000h,050h,070h,0e0h	; ab2b  .Ppp`....@P@.Pp.
	defb 0f0h,075h,003h,070h,09bh,040h,050h,070h,0f0h,040h,065h,040h,060h,040h,050h,070h	; ab3b  .u.p.@Pp.@e@`@Pp
	defb 040h,090h,090h,040h,080h,040h,060h,040h,040h,050h,094h,050h,080h,050h,060h,050h	; ab4b  @..@.@`@@P.P.P`P
	defb 004h,040h,002h,050h,003h,040h,082h,060h,090h,003h,060h,085h,040h,070h,040h,074h	; ab5b  .@.P.@.`..`.@p@t
	defb 074h,003h,050h,081h,070h,003h,040h,0a0h,0e0h,050h,040h,050h,070h,050h,000h,000h	; ab6b  t.P.p.@..P@PpP..
	defb 0b0h,000h,040h,050h,070h,000h,0d0h,040h,065h,040h,0e0h,040h,050h,070h,040h,040h	; ab7b  ..@Pp..@e@.@Pp@@
	defb 050h,050h,080h,040h,050h,050h,070h,0f4h,003h,0f0h,094h,075h,050h,040h,040h,050h	; ab8b  PP.@PPp....uP@@P
	defb 040h,060h,080h,090h,0a0h,0b0h,0f0h,050h,0f0h,050h,0e7h,0f0h,0e0h,0e0h,0f4h,007h	; ab9b  @`.....P.P......
	defb 0f0h,013h,0e0h,003h,0f0h,002h,0e0h,081h,0f0h,008h,0e0h,008h,0f0h,0a4h,040h,050h	; abab  ..............@P
	defb 0e0h,0e0h,050h,040h,0c0h,030h,0f0h,070h,050h,040h,040h,050h,040h,040h,0e4h,0f5h	; abbb  ..P@.0.pP@@P@@..
	defb 0f4h,0e4h,030h,020h,040h,040h,0e4h,0f5h,0f5h,0e4h,030h,020h,0e0h,0e0h,0f4h,0e0h	; abcb  ..0 @@....0 ....
	defb 050h,0f0h,004h,0e0h,087h,050h,0e0h,0f6h,0e8h,076h,0e0h,050h,003h,040h,08dh,0f0h	; abdb  P....P...v.P.@..
	defb 0e0h,070h,050h,040h,040h,050h,0f0h,0f4h,0e5h,0e7h,070h,070h,004h,040h,002h,050h	; abeb  .pP@@P....pp.@.P
	defb 003h,040h,09ch,0d0h,070h,070h,050h,0e5h,040h,050h,0e0h,0e5h,040h,040h,070h,0e0h	; abfb  .@..ppP.@P..@@p.
	defb 055h,050h,0e0h,090h,080h,060h,060h,050h,040h,050h,0e0h,0f9h,0f9h,098h,086h,003h	; ac0b  UP...``P@P......
	defb 060h,085h,0eeh,090h,080h,060h,060h,004h,0e0h,083h,0f0h,070h,050h,003h,040h,08fh	; ac1b  `....``....pP.@.
	defb 070h,075h,050h,050h,074h,074h,075h,050h,050h,040h,0f9h,060h,060h,070h,050h,003h	; ac2b  puPPttuPP@.``pP.
	defb 040h,009h,0f0h,08ah,0e0h,070h,050h,000h,040h,050h,040h,0f0h,070h,050h,003h,040h	; ac3b  @....pP.@P@.pP.@
	defb 089h,070h,075h,040h,070h,050h,040h,060h,040h,065h,003h,040h,08eh,060h,040h,080h	; ac4b  .pu@pP@`@e.@.`@.
	defb 040h,090h,090h,040h,050h,060h,050h,080h,050h,094h,050h,003h,040h,002h,050h,004h	; ac5b  @..@P`P.P.P.@.P.
	defb 040h,082h,070h,040h,003h,060h,085h,090h,060h,040h,040h,070h,003h,050h,002h,074h	; ac6b  @.p@.`..`@@p.P.t
	defb 09fh,000h,050h,070h,050h,040h,050h,0e0h,0e0h,0d0h,0d0h,070h,050h,040h,040h,0b0h	; ac7b  ..PpP@P....pP@@.
	defb 040h,040h,070h,050h,040h,0e0h,040h,065h,040h,070h,050h,050h,040h,080h,080h,050h	; ac8b  @@pP@.@e@pPP@..P
	defb 003h,040h,082h,050h,075h,003h,0f0h,092h,0f4h,0f0h,0b0h,0a0h,090h,080h,060h,040h	; ac9b  .@.Pu.........`@
	defb 050h,0f4h,0e0h,0e0h,0f0h,0e7h,050h,0f0h,050h,0e0h,007h,0f0h,010h,0e0h,083h,0f0h	; acab  P.....P.P.......
	defb 0e0h,0e0h,003h,0f0h,00ah,0e0h,008h,0f0h,000h	; acbb  .........

; ----------------------------------------------------------------------
; DATOS colores_ACC4: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 112, ficha 1 de la lista 0x556F (p00:4595); lo leen p00:4B29 (229
;   bytes)
;   0xacc4..0xada9  (229 bytes)
DATA_colores_ACC4:
	defb 082h,040h,050h,007h,040h,090h,050h,040h,000h,060h,090h,0e0h,0f0h,040h,050h,040h	; acc4  .@P.@.P@.`...@P@
	defb 000h,060h,090h,0e0h,0f0h,000h,006h,070h,002h,040h,081h,075h,009h,040h,004h,070h	; acd4  .`.....p.@.u.@.p
	defb 081h,040h,004h,0d0h,002h,060h,004h,050h,004h,020h,002h,040h,003h,0e0h,085h,0f0h	; ace4  .@...`.P. .@....
	defb 000h,0e0h,050h,0e0h,006h,020h,003h,070h,081h,050h,003h,040h,005h,050h,004h,0e0h	; acf4  ..P.. .p.P.@.P..
	defb 081h,0f0h,005h,0e0h,006h,040h,004h,0f0h,002h,0e0h,005h,0f0h,081h,020h,004h,040h	; ad04  .....@....... .@
	defb 002h,0e0h,084h,0f0h,050h,0e0h,0f4h,008h,0f0h,081h,030h,004h,020h,083h,050h,070h	; ad14  ....P.....0. .Pp
	defb 040h,008h,0e0h,008h,0f0h,007h,0e0h,082h,000h,080h,005h,040h,081h,070h,004h,0e0h	; ad24  @..........@.p..
	defb 005h,0b0h,006h,040h,093h,050h,040h,0f0h,0e0h,090h,060h,000h,040h,050h,040h,0f0h	; ad34  ...@.P@...`.@P@.
	defb 0e0h,090h,060h,000h,040h,050h,040h,040h,007h,070h,006h,040h,083h,075h,040h,040h	; ad44  ..`.@P@@.p.@.u@@
	defb 005h,070h,004h,050h,002h,060h,086h,000h,0d0h,000h,000h,040h,040h,006h,020h,085h	; ad54  .p.P.`.....@@. .
	defb 0e0h,050h,0e0h,000h,0f0h,003h,0e0h,002h,070h,006h,020h,004h,050h,002h,040h,002h	; ad64  .P......p. .P.@.
	defb 050h,082h,0e0h,0f0h,006h,0e0h,008h,040h,002h,0e0h,004h,0f0h,004h,040h,081h,020h	; ad74  P......@.....@.
	defb 005h,0f0h,084h,0f4h,0e0h,050h,0f0h,003h,0e0h,081h,040h,008h,0f0h,082h,040h,070h	; ad84  .....P....@...@p
	defb 004h,050h,082h,020h,030h,008h,0e0h,008h,0f0h,009h,0e0h,081h,070h,005h,040h,082h	; ad94  .P. 0.......p.@.
	defb 080h,0b0h,007h,000h,000h	; ada4

; ----------------------------------------------------------------------
; DATOS colores_ADA9: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 109, ficha 2 de la lista 0x556F (p00:4595); lo leen p00:4B29 (25
;   bytes)
;   0xada9..0xadc2  (25 bytes)
DATA_colores_ADA9:
	defb 090h,0e0h,050h,040h,050h,040h,040h,050h,070h,0eeh,000h,040h,044h,054h,075h,0f7h	; ada9  ..P@P@@Pp..@DTu.
	defb 0f7h,004h,0e0h,002h,040h,082h,050h,070h,000h	; adb9  ....@.Pp.

; ----------------------------------------------------------------------
; DATOS colores_ADC2: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 192, ficha 3 de la lista 0x556F (p00:4595); lo leen p00:4B29 (24
;   bytes)
;   0xadc2..0xadda  (24 bytes)
DATA_colores_ADC2:
	defb 094h,070h,050h,040h,040h,050h,040h,050h,0e0h,0f7h,0f7h,075h,054h,055h,050h,000h	; adc2  .pP@@P@P...uTUP.
	defb 0eeh,070h,050h,040h,040h,004h,0e0h,000h	; add2  .pP@@...

; ----------------------------------------------------------------------
; DATOS dibujos_ADDA: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 160, ficha 4 de la lista 0x556F (p00:4595); lo leen p00:4B29 (213
;   bytes)
;   0xadda..0xaeaf  (213 bytes)
DATA_dibujos_ADDA:
	defb 083h,07fh,03fh,07fh,003h,000h,082h,07fh,03fh,003h,0fbh,003h,000h,002h,0fbh,081h	; adda  ..?.....?.......
	defb 07fh,003h,000h,085h,07fh,03fh,07fh,000h,0fbh,003h,000h,003h,0fbh,084h,000h,07fh	; adea  .....?..........
	defb 0ffh,07fh,005h,000h,003h,0f5h,008h,000h,083h,07fh,0a0h,07fh,005h,000h,003h,0f5h	; adfa  ................
	defb 007h,000h,083h,07fh,0ffh,07fh,005h,000h,005h,0f5h,083h,07fh,0a0h,07fh,005h,000h	; ae0a  ................
	defb 003h,0f5h,004h,000h,091h,0fch,003h,000h,0f0h,00ch,007h,0f8h,000h,003h,0ech,010h	; ae1a  ................
	defb 02fh,0c0h,000h,000h,07ch,083h,003h,000h,0a8h,0fch,003h,000h,000h,080h,060h,010h	; ae2a  /...|.........`.
	defb 008h,006h,0c1h,03ch,000h,000h,080h,040h,030h,08eh,061h,01eh,0f0h,00fh,000h,007h	; ae3a  ...<...@0.a.....
	defb 078h,080h,0f0h,00fh,000h,087h,078h,080h,001h,00eh,0f0h,000h,003h,0f8h,007h,038h	; ae4a  x.....x........8
	defb 0c0h,003h,000h,097h,01eh,061h,08eh,030h,040h,080h,000h,000h,00fh,0f0h,080h,078h	; ae5a  .....a.0@......x
	defb 007h,000h,00fh,0f0h,000h,0f0h,00eh,001h,080h,078h,087h,004h,000h,08ch,0c0h,038h	; ae6a  .........x.....8
	defb 007h,0f8h,003h,0f8h,007h,00ch,0f0h,000h,003h,0fch,003h,000h,084h,0c0h,02fh,010h	; ae7a  ............../.
	defb 0ech,004h,003h,081h,0fch,003h,000h,08bh,083h,07ch,03ch,0c1h,006h,008h,010h,060h	; ae8a  .........|<....`
	defb 080h,000h,0ffh,00ch,000h,081h,0ffh,004h,000h,084h,0ffh,000h,000h,0ffh,004h,000h	; ae9a  ................
	defb 081h,0ffh,005h,000h,000h	; aeaa

; ----------------------------------------------------------------------
; DATOS colores_AEAF: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 160, ficha 4 de la lista 0x556F (p00:4595); lo leen p00:4B29 (177
;   bytes)
;   0xaeaf..0xaf60  (177 bytes)
DATA_colores_AEAF:
	defb 082h,080h,098h,005h,080h,083h,098h,080h,090h,005h,080h,081h,090h,005h,080h,081h	; aeaf  ................
	defb 098h,007h,080h,085h,090h,080h,080h,050h,077h,007h,050h,081h,070h,006h,050h,004h	; aebf  .......Pw.P.p.P.
	defb 060h,081h,0fbh,007h,060h,081h,0a0h,004h,060h,005h,050h,081h,077h,007h,050h,086h	; aecf  `...`...`.P.w.P.
	defb 070h,050h,000h,000h,060h,0fbh,007h,060h,081h,0a0h,004h,060h,004h,070h,002h,030h	; aedf  pP..`..`...`.p.0
	defb 081h,0f0h,003h,0a0h,002h,070h,082h,030h,0f0h,007h,0a0h,082h,030h,0f0h,007h,0a0h	; aeef  .....p.0....0...
	defb 002h,0f0h,081h,0a0h,003h,0f0h,081h,0a0h,003h,070h,003h,0a0h,002h,030h,081h,070h	; aeff  .........p...0.p
	defb 004h,0a0h,084h,0f0h,030h,0f0h,0f0h,006h,0a0h,004h,0f0h,003h,070h,081h,0a0h,004h	; af0f  ....0.......p...
	defb 0f0h,002h,0a0h,083h,070h,030h,030h,005h,0a0h,002h,0f0h,082h,030h,0f0h,005h,0a0h	; af1f  ....p00.....0...
	defb 081h,0f0h,005h,0a0h,081h,0f0h,003h,030h,005h,070h,088h,0f0h,030h,070h,070h,0a0h	; af2f  .......0.p..0pp.
	defb 000h,000h,0f0h,004h,030h,002h,0a0h,002h,0f0h,00bh,0a0h,081h,0a3h,004h,0a0h,084h	; af3f  ....0...........
	defb 0a7h,0a0h,0a0h,0a7h,004h,0a0h,081h,0a3h,004h,070h,004h,030h,004h,0f0h,081h,0fah	; af4f  .........p.0....
	defb 000h	; af5f

; ----------------------------------------------------------------------
; DATOS colores_AF60: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 199, ficha 5 de la lista 0x556F (p00:4595); lo leen p00:4B29 (15
;   bytes)
;   0xaf60..0xaf6f  (15 bytes)
DATA_colores_AF60:
	defb 003h,08ah,007h,000h,003h,08ah,007h,000h,003h,08ah,006h,000h,003h,08ah,000h	; af60  ...............

; ----------------------------------------------------------------------
; DATOS dibujos_AF6F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 199, ficha 5 de la lista 0x556F (p00:4595); lo leen p00:4B29 (15
;   bytes)
;   0xaf6f..0xaf7e  (15 bytes)
DATA_dibujos_AF6F:
	defb 003h,0aah,007h,000h,003h,0aah,007h,000h,003h,0aah,006h,000h,003h,0aah,000h	; af6f  ...............

; ----------------------------------------------------------------------
; DATOS dibujos_AF7E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 64, ficha 0 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (26
;   bytes)
;   0xaf7e..0xaf98  (26 bytes)
DATA_dibujos_AF7E:
	defb 004h,000h,083h,001h,003h,007h,004h,000h,085h,080h,0a0h,0bch,0bfh,01fh,006h,000h	; af7e  ................
	defb 082h,0c0h,0ffh,007h,000h,081h,0e0h,030h,000h,000h	; af8e  .......0..

; ----------------------------------------------------------------------
; DATOS dibujos_AF98: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 78, ficha 1 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (54
;   bytes)
;   0xaf98..0xafce  (54 bytes)
DATA_dibujos_AF98:
	defb 083h,003h,001h,001h,005h,000h,08bh,0a3h,0dch,0dfh,0efh,077h,077h,03bh,03dh,0ffh	; af98  ...........ww.=.
	defb 03fh,0c0h,007h,0ffh,082h,01fh,0e0h,007h,0ffh,081h,000h,004h,0ffh,095h,080h,0f0h	; afa8  ?...............
	defb 0fch,0feh,00dh,0f0h,0fdh,0ffh,000h,00fh,0ffh,0ffh,0f0h,00fh,0ffh,0ffh,03fh,0ffh	; afb8  ..............?.
	defb 0ffh,0c0h,03fh,003h,0ffh,000h	; afc8

; ----------------------------------------------------------------------
; DATOS dibujos_AFCE: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 94, ficha 2 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (127
;   bytes)
;   0xafce..0xb04d  (127 bytes)
DATA_dibujos_AFCE:
	defb 090h,01dh,01eh,00fh,007h,003h,001h,000h,000h,0ffh,0ffh,07fh,0bfh,0dfh,0e7h,0f8h	; afce  ................
	defb 03fh,007h,0ffh,093h,000h,0e0h,0f0h,0f8h,0fch,0feh,0ffh,000h,00fh,000h,000h,0ffh	; afde  ?...............
	defb 07fh,03fh,01fh,080h,0c0h,000h,000h,004h,0ffh,004h,000h,004h,0ffh,084h,001h,003h	; afee  .?..............
	defb 000h,000h,004h,03fh,084h,004h,00ch,000h,000h,004h,0fch,084h,03ch,07ch,000h,000h	; affe  ...?........<|..
	defb 004h,0ffh,084h,010h,030h,000h,000h,004h,0f3h,002h,0f0h,002h,000h,004h,0ffh,08ch	; b00e  ....0...........
	defb 043h,0c3h,000h,000h,0c1h,0c3h,0c7h,0cfh,0c1h,0c3h,000h,000h,004h,03ch,084h,004h	; b01e  C............<..
	defb 00ch,000h,000h,006h,03ch,08ch,004h,00fh,01fh,03fh,07fh,0ffh,0ffh,0f0h,017h,072h	; b02e  ....<....?.....r
	defb 075h,077h,003h,0ffh,089h,000h,07fh,07fh,07eh,07dh,0fbh,0e7h,01fh,0fch,000h	; b03e  uw......~}.....

; ----------------------------------------------------------------------
; DATOS dibujos_B04D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 114, ficha 3 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (79
;   bytes)
;   0xb04d..0xb09c  (79 bytes)
DATA_dibujos_B04D:
	defb 082h,00fh,003h,006h,000h,088h,0dfh,09fh,06fh,06fh,077h,03bh,01ch,00fh,007h,0ffh	; b04d  ........oow.....
	defb 002h,000h,087h,0ffh,000h,0ffh,000h,000h,0ffh,00fh,008h,0ffh,081h,007h,007h,00fh	; b05d  ................
	defb 081h,000h,004h,03fh,003h,00fh,083h,01ch,03dh,03fh,005h,03ch,083h,0f8h,0f0h,0e0h	; b06d  ...?....=?.<....
	defb 005h,03ch,081h,070h,004h,0ffh,003h,0f0h,081h,0f1h,007h,0f3h,008h,0c3h,081h,0c7h	; b07d  .<.p............
	defb 007h,0cfh,081h,01ch,00fh,03ch,081h,070h,004h,0ffh,004h,000h,007h,0f0h,000h	; b08d  .....<.p.......

; ----------------------------------------------------------------------
; DATOS dibujos_B09C: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 136, ficha 4 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (93
;   bytes)
;   0xb09c..0xb0f9  (93 bytes)
DATA_dibujos_B09C:
	defb 082h,007h,001h,006h,000h,088h,0efh,0d7h,037h,037h,03bh,01ch,00fh,007h,004h,000h	; b09c  ........77......
	defb 084h,0ffh,080h,000h,0bfh,008h,0ffh,005h,00fh,002h,000h,082h,0ffh,00fh,004h,0ffh	; b0ac  ................
	defb 002h,000h,081h,0ffh,005h,03ch,002h,000h,081h,0ffh,005h,0f0h,002h,000h,081h,0ffh	; b0bc  .....<..........
	defb 005h,0f3h,002h,000h,082h,0ffh,0c3h,003h,0ffh,08dh,0feh,000h,000h,0ffh,0cfh,0cfh	; b0cc  ................
	defb 08fh,00fh,00fh,000h,000h,0ffh,03ch,004h,03fh,002h,000h,082h,0ffh,03ch,004h,0fch	; b0dc  ......<.?....<..
	defb 002h,000h,083h,0ffh,000h,000h,003h,0ffh,002h,000h,081h,0ffh,000h	; b0ec  .............

; ----------------------------------------------------------------------
; DATOS dibujos_B0F9: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 155, ficha 5 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (57
;   bytes)
;   0xb0f9..0xb132  (57 bytes)
DATA_dibujos_B0F9:
	defb 088h,05fh,0efh,073h,03ch,01fh,00fh,003h,000h,003h,0ffh,081h,000h,005h,0ffh,002h	; b0f9  ._.s<...........
	defb 0e0h,081h,020h,003h,0e7h,085h,027h,0ffh,0ffh,000h,000h,005h,0ffh,003h,000h,088h	; b109  .. ...'.........
	defb 0ffh,000h,0ffh,040h,0ffh,0ffh,000h,000h,005h,0ffh,002h,001h,082h,000h,0feh,005h	; b119  ...@............
	defb 0ffh,086h,07fh,060h,01fh,08fh,0cfh,0c4h,000h	; b129  ...`.....

; ----------------------------------------------------------------------
; DATOS dibujos_B132: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 165, ficha 6 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (99
;   bytes)
;   0xb132..0xb195  (99 bytes)
DATA_dibujos_B132:
	defb 004h,027h,004h,020h,004h,0ffh,004h,000h,084h,0ffh,0fdh,0ffh,0ffh,004h,000h,002h	; b132  .'. ............
	defb 0ffh,086h,0d0h,0fch,001h,000h,000h,001h,008h,0ffh,008h,0e4h,002h,020h,086h,023h	; b142  ............. .#
	defb 027h,047h,04fh,08fh,09fh,005h,0ffh,083h,000h,017h,07fh,003h,0ffh,083h,002h,0ffh	; b152  'GO.............
	defb 0bfh,011h,0ffh,081h,0feh,004h,0e4h,084h,0c4h,0c8h,088h,010h,008h,09fh,008h,0ffh	; b162  ................
	defb 084h,080h,000h,000h,080h,004h,0ffh,081h,03fh,003h,001h,004h,0f9h,004h,09fh,002h	; b172  ........?.......
	defb 080h,082h,0ffh,000h,004h,0ffh,002h,000h,083h,0ffh,000h,03fh,007h,0ffh,004h,000h	; b182  ...........?....
	defb 004h,0ffh,000h	; b192

; ----------------------------------------------------------------------
; DATOS colores_B195: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 64, ficha 0 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (5
;   bytes)
;   0xb195..0xb19a  (5 bytes)
DATA_colores_B195:
	defb 020h,040h,030h,000h,000h	; b195

; ----------------------------------------------------------------------
; DATOS colores_B19A: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 78, ficha 1 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (56
;   bytes)
;   0xb19a..0xb1d2  (56 bytes)
DATA_colores_B19A:
	defb 084h,040h,0c0h,040h,0c0h,005h,040h,087h,0c0h,040h,0c0h,040h,0c0h,040h,0c0h,003h	; b19a  .@.@..@..@.@.@..
	defb 040h,085h,0c0h,040h,0c0h,040h,0c0h,003h,040h,085h,0c0h,040h,0c0h,040h,0c0h,005h	; b1aa  @..@.@..@..@.@..
	defb 040h,083h,0c0h,040h,0c0h,005h,040h,083h,0c0h,040h,0c0h,005h,040h,083h,0c0h,040h	; b1ba  @..@..@..@..@..@
	defb 0c0h,005h,040h,083h,0c0h,040h,0c0h,000h	; b1ca  ..@..@..

; ----------------------------------------------------------------------
; DATOS colores_B1D2: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 94, ficha 2 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (65
;   bytes)
;   0xb1d2..0xb213  (65 bytes)
DATA_colores_B1D2:
	defb 086h,040h,0c0h,040h,0c0h,050h,0c0h,003h,040h,097h,0c0h,040h,0c0h,050h,0c0h,050h	; b1d2  .@.@.P..@..@.P.P
	defb 0c0h,040h,0c0h,040h,0c0h,050h,0c0h,050h,040h,040h,0c0h,040h,0c0h,050h,0c0h,0c5h	; b1e2  .@.@.P.P@@.@.P..
	defb 0c0h,006h,060h,002h,0c0h,050h,060h,098h,040h,0c0h,040h,0c0h,050h,0c0h,050h,0c0h	; b1f2  ..`..P`.@.@.P.P.
	defb 040h,0c0h,040h,0c0h,050h,0c0h,050h,050h,040h,0c0h,040h,0c0h,050h,0c0h,050h,0c0h	; b202  @.@.P.PP@.@.P.P.
	defb 000h	; b212

; ----------------------------------------------------------------------
; DATOS colores_B213: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 114, ficha 3 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (40
;   bytes)
;   0xb213..0xb23b  (40 bytes)
DATA_colores_B213:
	defb 081h,050h,007h,0c0h,0a0h,050h,0c0h,070h,0c0h,070h,020h,070h,020h,050h,0c0h,070h	; b213  .P...P.p.p p P.p
	defb 0c0h,070h,020h,070h,070h,0c5h,0c4h,0c7h,0c5h,0c7h,052h,070h,020h,050h,0c0h,070h	; b223  .p pp.....Rp P.p
	defb 0c0h,070h,020h,070h,020h,060h,060h,000h	; b233  .p p ``.

; ----------------------------------------------------------------------
; DATOS colores_B23B: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 136, ficha 4 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (72
;   bytes)
;   0xb23b..0xb283  (72 bytes)
DATA_colores_B23B:
	defb 081h,070h,007h,020h,098h,070h,020h,070h,030h,070h,030h,070h,030h,0c7h,072h,0c7h	; b23b  .p. .p p0p0p0.r.
	defb 073h,072h,0a3h,020h,030h,070h,020h,070h,030h,070h,030h,070h,030h,007h,060h,081h	; b24b  sr. 0p p0p0p0.`.
	defb 030h,007h,060h,081h,030h,007h,060h,081h,030h,007h,060h,081h,030h,007h,060h,081h	; b25b  0.`.0.`.0.`.0.`.
	defb 030h,007h,060h,081h,030h,007h,060h,081h,030h,007h,060h,081h,030h,007h,060h,083h	; b26b  0.`.0.`.0.`.0.`.
	defb 030h,060h,0b6h,005h,060h,081h,030h,000h	; b27b  0`..`.0.

; ----------------------------------------------------------------------
; DATOS colores_B283: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 155, ficha 5 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (54
;   bytes)
;   0xb283..0xb2b9  (54 bytes)
DATA_colores_B283:
	defb 085h,070h,0b0h,0f0h,050h,050h,003h,040h,08bh,070h,0b0h,0f0h,040h,050h,040h,040h	; b283  .p..PP.@.p..@P@@
	defb 000h,070h,0b4h,0f0h,004h,040h,082h,050h,070h,006h,040h,08ah,050h,070h,074h,070h	; b293  .p...@.Pp.@.Pptp
	defb 070h,040h,074h,043h,054h,070h,007h,040h,082h,070h,0b4h,006h,040h,085h,070h,0b0h	; b2a3  p@tCTp.@.p..@.p.
	defb 0f4h,040h,050h,003h,040h,000h	; b2b3

; ----------------------------------------------------------------------
; DATOS colores_B2B9: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 165, ficha 6 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (96
;   bytes)
;   0xb2b9..0xb319  (96 bytes)
DATA_colores_B2B9:
	defb 084h,040h,050h,070h,0f0h,005h,040h,082h,050h,070h,005h,0f0h,083h,040h,054h,070h	; b2b9  .@Pp..@.Pp...@Tp
	defb 005h,0f0h,002h,040h,082h,074h,0f4h,021h,040h,083h,054h,074h,0f4h,003h,040h,085h	; b2c9  ...@.t.!@.Tt..@.
	defb 054h,040h,054h,070h,0f0h,003h,040h,085h,050h,040h,050h,070h,0f0h,003h,040h,085h	; b2d9  T@Tp..@.P@Pp..@.
	defb 050h,040h,050h,070h,0f0h,003h,040h,085h,050h,040h,050h,070h,0f0h,007h,040h,081h	; b2e9  P@Pp..@.P@Pp..@.
	defb 050h,007h,040h,081h,050h,007h,040h,081h,050h,007h,040h,085h,050h,040h,050h,070h	; b2f9  P.@.P.@.P.@.P@Pp
	defb 0f0h,005h,040h,082h,050h,070h,003h,0f0h,082h,040h,0f0h,00fh,040h,081h,050h,000h	; b309  ..@.Pp...@..@.P.

; ----------------------------------------------------------------------
; DATOS colores_B319: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 187, ficha 7 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (96
;   bytes)
;   0xb319..0xb379  (96 bytes)
DATA_colores_B319:
	defb 084h,030h,020h,070h,0f0h,005h,030h,082h,020h,070h,005h,0f0h,083h,030h,023h,070h	; b319  .0 p..0. p...0#p
	defb 005h,0f0h,002h,030h,082h,073h,0f3h,021h,030h,083h,023h,073h,0f3h,003h,030h,085h	; b329  ...0.s.!0.#s..0.
	defb 023h,030h,023h,070h,0f0h,003h,030h,085h,020h,030h,020h,070h,0f0h,003h,030h,085h	; b339  #0#p..0. 0 p..0.
	defb 020h,030h,020h,070h,0f0h,003h,030h,085h,020h,030h,020h,070h,0f0h,007h,030h,081h	; b349   0 p..0. 0 p..0.
	defb 020h,007h,030h,081h,020h,007h,030h,081h,020h,007h,030h,085h,020h,030h,020h,070h	; b359   .0. .0. .0. 0 p
	defb 0f0h,005h,030h,082h,020h,070h,003h,0f0h,082h,030h,0f0h,00fh,030h,081h,020h,000h	; b369  ..0. p...0..0. .

; ----------------------------------------------------------------------
; DATOS colores_B379: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 208, ficha 8 de la lista 0x55A7 (p00:4595); lo leen p01:6165 (54
;   bytes)
;   0xb379..0xb3af  (54 bytes)
DATA_colores_B379:
	defb 085h,070h,0b0h,0f0h,050h,050h,003h,030h,08bh,070h,0b0h,0f0h,030h,020h,030h,030h	; b379  .p..PP.0.p..0 00
	defb 000h,070h,0b3h,0f0h,004h,030h,082h,020h,070h,006h,030h,08ah,020h,070h,073h,070h	; b389  .p...0. p.0. psp
	defb 070h,030h,073h,033h,023h,070h,007h,030h,082h,070h,0b3h,006h,030h,085h,070h,0b0h	; b399  p0s3#p.0.p..0.p.
	defb 0f4h,040h,020h,003h,030h,000h	; b3a9

; ----------------------------------------------------------------------
; DATOS caracteres_B3AF: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p00:4C8B (13
;   bytes)
;   0xb3af..0xb3bc  (13 bytes)
DATA_caracteres_B3AF:
	defb 007h,0c5h,0b3h,01fh,025h,0b5h	; b3af
	defb 007h,04eh,0b4h,070h,0a2h,0b5h	; b3b5
	defb 000h	; b3bb

; ----------------------------------------------------------------------
; DATOS copias_B3BC: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:4C97 (9
;   bytes)
;   0xb3bc..0xb3c5  (9 bytes)
DATA_copias_B3BC:
	defb 01fh,031h,03fh,012h,070h,08eh,03fh,01dh,000h	; b3bc  .1?.p.?..

; ----------------------------------------------------------------------
; DATOS dibujos_B3C5: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0xB3AF (p00:4595); lo leen p00:4C8B (137
;   bytes)
;   0xb3c5..0xb44e  (137 bytes)
DATA_dibujos_B3C5:
	defb 090h,000h,038h,067h,068h,071h,073h,067h,067h,000h,01ch,0e6h,016h,08eh,0ceh,0e6h	; b3c5  ..8ghqsgg.......
	defb 0e6h,003h,000h,08dh,0fch,0aah,0f0h,000h,000h,002h,004h,008h,030h,060h,01dh,05dh	; b3d5  ............0`.]
	defb 05dh,003h,000h,081h,0edh,004h,06dh,09fh,00ah,0abh,00bh,000h,000h,038h,084h,0c1h	; b3e5  ].....m......8..
	defb 000h,07fh,0beh,01dh,00bh,047h,08eh,01ch,063h,071h,068h,07eh,000h,07fh,000h,07fh	; b3f5  .....G..cqh~....
	defb 06dh,06dh,0edh,06dh,000h,0d0h,0d0h,006h,000h,0afh,003h,00ch,030h,000h,007h,01fh	; b405  mm.m........0...
	defb 007h,03fh,0c0h,001h,0c2h,0bfh,0deh,0efh,0f7h,0f6h,0f7h,080h,04fh,0a2h,070h,0fch	; b415  .?..........O.p.
	defb 006h,018h,0e0h,000h,0feh,0c0h,000h,080h,0c0h,060h,030h,098h,0cch,0fch,0d0h,008h	; b425  .........`0.....
	defb 0fch,0fch,042h,0beh,069h,080h,036h,06ch,000h,004h,066h,084h,080h,036h,06ch,000h	; b435  ..B.i.6l..f..6l.
	defb 004h,006h,083h,080h,036h,06ch,005h,000h,000h	; b445  ....6l...

; ----------------------------------------------------------------------
; DATOS dibujos_B44E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 112, ficha 1 de la lista 0xB3AF (p00:4595); lo leen p00:4C8B (215
;   bytes)
;   0xb44e..0xb525  (215 bytes)
DATA_dibujos_B44E:
	defb 084h,03fh,0ffh,0ffh,03fh,004h,000h,004h,0f3h,008h,000h,084h,003h,00fh,03eh,0fdh	; b44e  .?..?.........>.
	defb 006h,000h,082h,003h,00fh,005h,000h,0b6h,007h,080h,038h,000h,001h,002h,004h,000h	; b45e  ..........8.....
	defb 010h,000h,000h,0c6h,08eh,016h,07eh,000h,0feh,000h,05dh,000h,0fch,078h,07dh,07eh	; b46e  ......~...]..x}~
	defb 07ch,000h,03bh,05dh,01ch,05eh,0afh,0d3h,069h,034h,01ah,03ch,07ah,0f7h,0eeh,0dch	; b47e  |..].^..i4.<z...
	defb 081h,07fh,000h,03fh,07fh,000h,057h,0d7h,0d7h,080h,000h,05dh,05dh,000h,003h,0f7h	; b48e  ...?..W....]]...
	defb 0efh,003h,001h,000h,07fh,03eh,081h,09ch,0ceh,0e7h,0f0h,000h,03fh,080h,0cfh,0e0h	; b49e  .....>......?...
	defb 073h,038h,000h,080h,0f0h,081h,0fch,086h,0f3h,099h,00ch,07dh,0a0h,063h,07dh,038h	; b4ae  s8.........}.c}8
	defb 071h,0c3h,0a2h,0f0h,007h,05ch,058h,001h,043h,083h,085h,000h,000h,03ch,000h,07eh	; b4be  q....\X.C....<.~
	defb 03ch,018h,03ch,0f8h,00ch,006h,002h,083h,0c1h,0c1h,0a1h,0e0h,07fh,000h,000h,075h	; b4ce  <.<............u
	defb 015h,015h,0d5h,07fh,07fh,000h,0beh,080h,0beh,080h,0beh,000h,0c0h,03ch,001h,03fh	; b4de  .............<.?
	defb 070h,01fh,03fh,0f0h,007h,05ch,058h,001h,043h,083h,085h,000h,000h,03ch,000h,07eh	; b4ee  p.?..\X.C....<.~
	defb 03ch,018h,03ch,0f8h,00ch,006h,002h,083h,0c1h,0c1h,0a1h,07dh,0a0h,063h,07dh,038h	; b4fe  <.<........}.c}8
	defb 003h,000h,089h,0f0h,007h,05ch,058h,000h,040h,080h,000h,0ffh,007h,000h,085h,0f8h	; b50e  .....\X.@.......
	defb 00ch,006h,002h,003h,003h,001h,000h	; b51e

; ----------------------------------------------------------------------
; DATOS colores_B525: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 31, ficha 0 de la lista 0xB3AF (p00:4595); lo leen p00:4C8B (125
;   bytes)
;   0xb525..0xb5a2  (125 bytes)
DATA_colores_B525:
	defb 002h,040h,08eh,050h,040h,040h,050h,070h,0f0h,040h,040h,050h,040h,040h,050h,070h	; b525  .@.P@@Pp.@@P@@Pp
	defb 0f0h,004h,040h,085h,080h,0c5h,044h,055h,080h,005h,040h,082h,070h,0e0h,004h,040h	; b535  ..@...DU..@.p..@
	defb 087h,050h,070h,0e0h,0f0h,060h,090h,060h,003h,040h,081h,070h,004h,040h,002h,050h	; b545  .Pp..`.`.@.p.@.P
	defb 003h,040h,08eh,0e0h,050h,040h,0e5h,055h,070h,040h,0d0h,0e0h,070h,050h,040h,010h	; b555  .@..P@.Up@..pP@.
	defb 070h,004h,050h,004h,020h,005h,040h,087h,054h,050h,040h,050h,054h,040h,040h,003h	; b565  p.P. .@.TP@PT@@.
	defb 050h,081h,070h,003h,040h,002h,050h,085h,075h,074h,074h,050h,050h,008h,040h,09ah	; b575  P.p.@.P.uttPP.@.
	defb 0e0h,050h,070h,040h,070h,040h,040h,0e6h,040h,050h,040h,040h,050h,070h,0e0h,0f0h	; b585  .Pp@p@@.@P@@Pp..
	defb 040h,050h,040h,040h,050h,070h,0e0h,0f0h,040h,050h,006h,040h,000h	; b595  @P@@Pp..@P.@.

; ----------------------------------------------------------------------
; DATOS colores_B5A2: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 112, ficha 1 de la lista 0xB3AF (p00:4595); lo leen p00:4C8B (191
;   bytes)
;   0xb5a2..0xb661  (191 bytes)
DATA_colores_B5A2:
	defb 083h,040h,0f0h,070h,006h,040h,082h,0f0h,070h,00dh,040h,007h,070h,081h,040h,006h	; b5a2  .@.p.@..p.@.p.@.
	defb 020h,003h,070h,081h,050h,003h,040h,003h,050h,08dh,0e0h,050h,040h,0e5h,055h,070h	; b5b2   .p.P.@.P..P@.Up
	defb 010h,0d0h,077h,040h,070h,040h,050h,003h,040h,083h,0f0h,070h,050h,003h,040h,082h	; b5c2  ..w@p@P.@..pP.@.
	defb 050h,070h,007h,040h,086h,044h,0a9h,060h,010h,070h,050h,003h,040h,085h,0a0h,060h	; b5d2  Pp.@.D.`.pP.@..`
	defb 010h,070h,050h,005h,040h,082h,050h,060h,005h,040h,0a7h,090h,040h,080h,040h,060h	; b5e2  .pP.@.P`.@..@.@`
	defb 040h,040h,050h,094h,050h,080h,050h,060h,050h,040h,0e0h,050h,055h,0e0h,070h,040h	; b5f2  @@P.P.P`P@.PU.p@
	defb 040h,0e5h,0e0h,050h,040h,050h,060h,060h,080h,090h,0eeh,000h,060h,066h,086h,098h	; b602  @..P@P``....`f..
	defb 0f9h,0f9h,004h,0e0h,002h,060h,0aah,080h,090h,075h,070h,000h,000h,040h,050h,070h	; b612  .....`...up..@Pp
	defb 0f0h,040h,070h,000h,040h,040h,050h,070h,0b0h,0eeh,0a5h,040h,040h,050h,070h,085h	; b622  .@p.@@Pp...@@Pp.
	defb 094h,0e0h,050h,040h,050h,040h,040h,050h,070h,0eeh,010h,040h,044h,054h,075h,0f7h	; b632  ..P@P@@Pp..@DTu.
	defb 0f7h,004h,0e0h,002h,040h,087h,050h,070h,0e0h,050h,055h,0e0h,070h,004h,0e0h,087h	; b642  ....@.Pp.PU.p...
	defb 050h,040h,050h,040h,040h,050h,070h,00ch,0e0h,002h,040h,082h,050h,070h,000h	; b652  P@P@@Pp...@.Pp.

; ----------------------------------------------------------------------
; DATOS formas_B661: 72 punteros que p01:6017 lee con IX+07 (L_4B67): formas
;   que p01:6040 copia a la tabla de nombres (IX+09 de ancho, IX+0A filas); lo
;   leen p01:601D (144 bytes)
;   0xb661..0xb6f1  (144 bytes)
DATA_formas_B661:
	defw 0b6f1h,0b70fh,0b732h,0b750h,0b76eh,0b78ch,0b7aah,0b7c8h	; b661
	defw 0b7e6h,0b804h,0b822h,0b840h,0b85eh,0b87ch,0b89ah,0b8b8h	; b671
	defw 0b8d6h,0b8eah,0b8feh,0b912h,0b912h,0b922h,0b934h,0b946h	; b681
	defw 0b958h,0b96ah,0b97ch,0b9a6h,0b9b8h,0b98eh,0b99ah,0b9cah	; b691
	defw 0b9fah,0ba2ah,0ba5ah,0ba8ah,0babah,0baeah,0bb1ah,0bb4ah	; b6a1
	defw 0bb7ah,0bbaah,0bbdah,0bc0ah,0bc3ah,0bc6ah,0bc9ah,0bccah	; b6b1
	defw 0bcceh,0bcd2h,0bcd6h,0bcdah,0bce6h,0b922h,0bcf2h,0bcf2h	; b6c1
	defw 0bcf2h,0bcfeh,0bd0ah,0bd16h,0bd22h,0bd2eh,0bd3ah,0bd46h	; b6d1
	defw 0bd52h,0bd5eh,0bd6ah,0bd76h,0bd82h,0bd8eh,0bd9ah,0bda6h	; b6e1

; ----------------------------------------------------------------------
; DATOS formas_B661_B6F1: forma de caracteres (de p01:6040) de las entradas 0
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb6f1..0xb70f  (30 bytes)
DATA_formas_B661_B6F1:
	defb 000h,000h,0ffh,000h,000h,000h,000h,000h	; b6f1  ........
	defb 000h,000h,022h,023h,024h,0b9h,000h,025h	; b6f9  .."#$..%
	defb 026h,027h,028h,000h,029h,02ah,02bh,02ch	; b701  &'(.)*+,
	defb 0bah,02dh,02eh,02fh,030h,031h	; b709

; ----------------------------------------------------------------------
; DATOS formas_B661_B70F: forma de caracteres (de p01:6040) de las entradas 1
;   de 0xB661; lo leen p01:6046 (35 bytes)
;   0xb70f..0xb732  (35 bytes)
DATA_formas_B661_B70F:
	defb 000h,000h,0ffh,000h,000h,000h,000h,000h	; b70f  ........
	defb 000h,000h,022h,023h,032h,0b9h,000h,025h	; b717  .."#2..%
	defb 033h,034h,028h,000h,029h,035h,036h,02ch	; b71f  34(.)56,
	defb 0bah,02dh,02eh,02fh,030h,031h,02dh,02eh	; b727  .-./01-.
	defb 02fh,030h,031h	; b72f

; ----------------------------------------------------------------------
; DATOS formas_B661_B732: forma de caracteres (de p01:6040) de las entradas 2
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb732..0xb750  (30 bytes)
DATA_formas_B661_B732:
	defb 000h,000h,0ffh,000h,000h,000h,000h,000h	; b732  ........
	defb 000h,000h,022h,037h,038h,0b9h,000h,025h	; b73a  .."78..%
	defb 039h,03ah,028h,000h,029h,03bh,03ch,02ch	; b742  9:(.).<,
	defb 0bah,02dh,02eh,02fh,030h,031h	; b74a

; ----------------------------------------------------------------------
; DATOS formas_B661_B750: forma de caracteres (de p01:6040) de las entradas 3
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb750..0xb76e  (30 bytes)
DATA_formas_B661_B750:
	defb 000h,000h,0ffh,000h,000h,000h,000h,000h	; b750  ........
	defb 000h,000h,022h,03dh,03eh,0b9h,000h,025h	; b758  .."=>..%
	defb 03fh,040h,041h,000h,029h,042h,043h,02ch	; b760  ?@A.)BC,
	defb 0bah,02dh,02eh,02fh,030h,031h	; b768

; ----------------------------------------------------------------------
; DATOS formas_B661_B76E: forma de caracteres (de p01:6040) de las entradas 4
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb76e..0xb78c  (30 bytes)
DATA_formas_B661_B76E:
	defb 000h,000h,000h,000h,000h,022h,03dh,03eh	; b76e  ....."=>
	defb 0b9h,000h,025h,03fh,040h,041h,000h,029h	; b776  ..%?@A.)
	defb 042h,043h,02ch,000h,044h,045h,046h,047h	; b77e  BC,.DEFG
	defb 0bah,02dh,02eh,02fh,030h,031h	; b786

; ----------------------------------------------------------------------
; DATOS formas_B661_B78C: forma de caracteres (de p01:6040) de las entradas 5
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb78c..0xb7aa  (30 bytes)
DATA_formas_B661_B78C:
	defb 022h,03dh,03eh,0b9h,000h,025h,03fh,040h	; b78c  "=>..%?@
	defb 041h,000h,029h,042h,043h,02ch,000h,044h	; b794  A.)BC,.D
	defb 045h,046h,047h,000h,048h,049h,04ah,04bh	; b79c  EFG.HIJK
	defb 0bah,02dh,02eh,02fh,030h,031h	; b7a4

; ----------------------------------------------------------------------
; DATOS formas_B661_B7AA: forma de caracteres (de p01:6040) de las entradas 6
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb7aa..0xb7c8  (30 bytes)
DATA_formas_B661_B7AA:
	defb 01fh,000h,000h,0bbh,000h,025h,020h,021h	; b7aa  .....% !
	defb 041h,000h,029h,042h,043h,02ch,000h,044h	; b7b2  A.)BC,.D
	defb 045h,046h,047h,000h,048h,049h,04ah,04bh	; b7ba  EFG.HIJK
	defb 0bah,02dh,02eh,02fh,030h,031h	; b7c2

; ----------------------------------------------------------------------
; DATOS formas_B661_B7C8: forma de caracteres (de p01:6040) de las entradas 7
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb7c8..0xb7e6  (30 bytes)
DATA_formas_B661_B7C8:
	defb 0feh,000h,000h,000h,000h,000h,000h,0ffh	; b7c8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,0bch	; b7d0  ........
	defb 0bdh,0beh,0bfh,000h,029h,042h,043h,02ch	; b7d8  ....)BC,
	defb 0bah,02dh,02eh,02fh,030h,031h	; b7e0

; ----------------------------------------------------------------------
; DATOS formas_B661_B7E6: forma de caracteres (de p01:6040) de las entradas 8
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb7e6..0xb804  (30 bytes)
DATA_formas_B661_B7E6:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,059h,058h	; b7e6  ^]\[Z.YX
	defb 057h,056h,000h,055h,054h,053h,052h,000h	; b7ee  WV.UTSR.
	defb 0c0h,051h,050h,04fh,000h,000h,000h,000h	; b7f6  .QPO....
	defb 000h,000h,000h,0ffh,000h,000h	; b7fe

; ----------------------------------------------------------------------
; DATOS formas_B661_B804: forma de caracteres (de p01:6040) de las entradas 9
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb804..0xb822  (30 bytes)
DATA_formas_B661_B804:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,059h,063h	; b804  ^]\[Z.Yc
	defb 062h,056h,000h,055h,061h,060h,052h,000h	; b80c  bV.Ua`R.
	defb 0c0h,05fh,050h,04fh,000h,000h,000h,000h	; b814  ._PO....
	defb 000h,000h,000h,0ffh,000h,000h	; b81c

; ----------------------------------------------------------------------
; DATOS formas_B661_B822: forma de caracteres (de p01:6040) de las entradas 10
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb822..0xb840  (30 bytes)
DATA_formas_B661_B822:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,059h,069h	; b822  ^]\[Z.Yi
	defb 068h,056h,000h,055h,067h,066h,052h,000h	; b82a  hV.UgfR.
	defb 0c0h,065h,064h,04fh,000h,000h,000h,000h	; b832  .edO....
	defb 000h,000h,000h,0ffh,000h,000h	; b83a

; ----------------------------------------------------------------------
; DATOS formas_B661_B840: forma de caracteres (de p01:6040) de las entradas 11
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb840..0xb85e  (30 bytes)
DATA_formas_B661_B840:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,059h,070h	; b840  ^]\[Z.Yp
	defb 06fh,056h,000h,06eh,06dh,06ch,052h,000h	; b848  oV.nmlR.
	defb 0c0h,06bh,06ah,04fh,000h,000h,000h,000h	; b850  .kjO....
	defb 000h,000h,000h,0ffh,000h,000h	; b858

; ----------------------------------------------------------------------
; DATOS formas_B661_B85E: forma de caracteres (de p01:6040) de las entradas 12
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb85e..0xb87c  (30 bytes)
DATA_formas_B661_B85E:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,074h,073h	; b85e  ^]\[Z.ts
	defb 072h,071h,000h,059h,070h,06fh,056h,000h	; b866  rq.YpoV.
	defb 06eh,06dh,06ch,052h,000h,0c0h,06bh,06ah	; b86e  nmlR..kj
	defb 04fh,000h,000h,000h,000h,000h	; b876

; ----------------------------------------------------------------------
; DATOS formas_B661_B87C: forma de caracteres (de p01:6040) de las entradas 13
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb87c..0xb89a  (30 bytes)
DATA_formas_B661_B87C:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,078h,077h	; b87c  ^]\[Z.xw
	defb 076h,075h,000h,074h,073h,072h,071h,000h	; b884  vu.tsrq.
	defb 059h,070h,06fh,056h,000h,06eh,06dh,06ch	; b88c  YpoV.nml
	defb 052h,000h,0c0h,06bh,06ah,04fh	; b894

; ----------------------------------------------------------------------
; DATOS formas_B661_B89A: forma de caracteres (de p01:6040) de las entradas 14
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb89a..0xb8b8  (30 bytes)
DATA_formas_B661_B89A:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,078h,077h	; b89a  ^]\[Z.xw
	defb 076h,075h,000h,074h,073h,072h,071h,000h	; b8a2  vu.tsrq.
	defb 059h,070h,06fh,056h,000h,06eh,04eh,04dh	; b8aa  YpoV.nNM
	defb 052h,000h,0c2h,000h,000h,04ch	; b8b2

; ----------------------------------------------------------------------
; DATOS formas_B661_B8B8: forma de caracteres (de p01:6040) de las entradas 15
;   de 0xB661; lo leen p01:6046 (30 bytes)
;   0xb8b8..0xb8d6  (30 bytes)
DATA_formas_B661_B8B8:
	defb 05eh,05dh,05ch,05bh,05ah,0c1h,059h,070h	; b8b8  ^]\[Z.Yp
	defb 06fh,056h,000h,0c6h,0c5h,0c4h,0c3h,000h	; b8c0  oV......
	defb 000h,000h,000h,000h,000h,000h,0ffh,000h	; b8c8  ........
	defb 000h,0feh,000h,000h,000h,000h	; b8d0

; ----------------------------------------------------------------------
; DATOS formas_B661_B8D6: forma de caracteres (de p01:6040) de las entradas 16
;   de 0xB661; lo leen p01:6046 (20 bytes)
;   0xb8d6..0xb8ea  (20 bytes)
DATA_formas_B661_B8D6:
	defb 000h,000h,000h,000h,000h,011h,012h,00eh	; b8d6  ........
	defb 00ch,009h,013h,014h,010h,00dh,096h,097h	; b8de  ........
	defb 000h,094h,095h,00ah	; b8e6

; ----------------------------------------------------------------------
; DATOS formas_B661_B8EA: forma de caracteres (de p01:6040) de las entradas 17
;   de 0xB661; lo leen p01:6046 (20 bytes)
;   0xb8ea..0xb8fe  (20 bytes)
DATA_formas_B661_B8EA:
	defb 000h,005h,006h,007h,008h,015h,016h,017h	; b8ea  ........
	defb 018h,019h,01ah,093h,004h,098h,099h,09ah	; b8f2  ........
	defb 000h,001h,002h,003h	; b8fa

; ----------------------------------------------------------------------
; DATOS formas_B661_B8FE: forma de caracteres (de p01:6040) de las entradas 18
;   de 0xB661; lo leen p01:6046 (20 bytes)
;   0xb8fe..0xb912  (20 bytes)
DATA_formas_B661_B8FE:
	defb 000h,011h,012h,00eh,00ch,009h,013h,014h	; b8fe  ........
	defb 010h,00dh,096h,097h,000h,094h,095h,00ah	; b906  ........
	defb 000h,000h,000h,000h	; b90e

; ----------------------------------------------------------------------
; DATOS formas_B661_B912: forma de caracteres (de p01:6040) de las entradas
;   19, 20 de 0xB661; lo leen p01:6046 (16 bytes)
;   0xb912..0xb922  (16 bytes)
DATA_formas_B661_B912:
	defb 013h,010h,012h,0b1h,01bh,01dh,097h,0bdh	; b912  ........
	defb 01ch,01eh,014h,0bch,096h,00ch,095h,0b1h	; b91a  ........

; ----------------------------------------------------------------------
; DATOS formas_B661_B922: forma de caracteres (de p01:6040) de las entradas
;   21, 53 de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb922..0xb934  (18 bytes)
DATA_formas_B661_B922:
	defb 000h,093h,094h,0a0h,09fh,000h,000h,095h	; b922  ........
	defb 096h,0a2h,0a1h,000h,000h,097h,098h,0a4h	; b92a  ........
	defb 0a3h,000h	; b932

; ----------------------------------------------------------------------
; DATOS formas_B661_B934: forma de caracteres (de p01:6040) de las entradas 22
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb934..0xb946  (18 bytes)
DATA_formas_B661_B934:
	defb 0bdh,099h,09ah,0a6h,0a5h,0bfh,0beh,09bh	; b934  ........
	defb 09ch,0a8h,0a7h,0c0h,000h,097h,098h,0a4h	; b93c  ........
	defb 0a3h,000h	; b944

; ----------------------------------------------------------------------
; DATOS formas_B661_B946: forma de caracteres (de p01:6040) de las entradas 23
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb946..0xb958  (18 bytes)
DATA_formas_B661_B946:
	defb 093h,094h,000h,000h,0a0h,09fh,095h,096h	; b946  ........
	defb 000h,000h,0a2h,0a1h,000h,097h,098h,0a4h	; b94e  ........
	defb 0a3h,000h	; b956

; ----------------------------------------------------------------------
; DATOS formas_B661_B958: forma de caracteres (de p01:6040) de las entradas 24
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb958..0xb96a  (18 bytes)
DATA_formas_B661_B958:
	defb 000h,097h,098h,0a4h,0a3h,000h,000h,095h	; b958  ........
	defb 096h,0a2h,0a1h,000h,000h,093h,094h,0a0h	; b960  ........
	defb 09fh,000h	; b968

; ----------------------------------------------------------------------
; DATOS formas_B661_B96A: forma de caracteres (de p01:6040) de las entradas 25
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb96a..0xb97c  (18 bytes)
DATA_formas_B661_B96A:
	defb 000h,097h,098h,0a4h,0a3h,000h,0beh,09bh	; b96a  ........
	defb 09ch,0a8h,0a7h,0c0h,0bdh,099h,09ah,0a6h	; b972  ........
	defb 0a5h,0bfh	; b97a

; ----------------------------------------------------------------------
; DATOS formas_B661_B97C: forma de caracteres (de p01:6040) de las entradas 26
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb97c..0xb98e  (18 bytes)
DATA_formas_B661_B97C:
	defb 000h,097h,098h,0a4h,0a3h,000h,095h,096h	; b97c  ........
	defb 000h,000h,0a2h,0a1h,093h,094h,000h,000h	; b984  ........
	defb 0a0h,09fh	; b98c

; ----------------------------------------------------------------------
; DATOS formas_B661_B98E: forma de caracteres (de p01:6040) de las entradas 29
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xb98e..0xb99a  (12 bytes)
DATA_formas_B661_B98E:
	defb 09bh,000h,000h,0a0h,09ch,09dh,07ch,07bh	; b98e  ......|{
	defb 09eh,09fh,07eh,07dh	; b996

; ----------------------------------------------------------------------
; DATOS formas_B661_B99A: forma de caracteres (de p01:6040) de las entradas 30
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xb99a..0xb9a6  (12 bytes)
DATA_formas_B661_B99A:
	defb 09eh,09fh,07eh,07dh,09ch,09dh,07ch,07bh	; b99a  ..~}..|{
	defb 09bh,000h,000h,0a0h	; b9a2

; ----------------------------------------------------------------------
; DATOS formas_B661_B9A6: forma de caracteres (de p01:6040) de las entradas 27
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb9a6..0xb9b8  (18 bytes)
DATA_formas_B661_B9A6:
	defb 093h,094h,000h,000h,0a0h,09fh,095h,096h	; b9a6  ........
	defb 000h,000h,0a2h,0a1h,000h,09dh,09eh,0aah	; b9ae  ........
	defb 0a9h,000h	; b9b6

; ----------------------------------------------------------------------
; DATOS formas_B661_B9B8: forma de caracteres (de p01:6040) de las entradas 28
;   de 0xB661; lo leen p01:6046 (18 bytes)
;   0xb9b8..0xb9ca  (18 bytes)
DATA_formas_B661_B9B8:
	defb 000h,09dh,09eh,0aah,0a9h,000h,095h,096h	; b9b8  ........
	defb 000h,000h,0a2h,0a1h,093h,094h,000h,000h	; b9c0  ........
	defb 0a0h,09fh	; b9c8

; ----------------------------------------------------------------------
; DATOS formas_B661_B9CA: forma de caracteres (de p01:6040) de las entradas 31
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xb9ca..0xb9fa  (48 bytes)
DATA_formas_B661_B9CA:
	defb 061h,044h,04ah,044h,045h,045h,047h,064h	; b9ca  aDJDEEGd
	defb 0b4h,0a3h,079h,08bh,07ch,07dh,0bah,000h	; b9d2  ..y.|}..
	defb 000h,0a2h,0a0h,000h,0a1h,000h,000h,000h	; b9da  ........
	defb 000h,000h,0b4h,000h,000h,000h,000h,000h	; b9e2  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b9ea  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b9f2  ........

; ----------------------------------------------------------------------
; DATOS formas_B661_B9FA: forma de caracteres (de p01:6040) de las entradas 32
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xb9fa..0xba2a  (48 bytes)
DATA_formas_B661_B9FA:
	defb 061h,065h,048h,050h,053h,052h,065h,06ch	; b9fa  aeHPSRel
	defb 0a9h,076h,056h,048h,053h,052h,07eh,078h	; ba02  .vVHSR~x
	defb 000h,0abh,0a9h,07ah,07bh,07ch,07dh,0bah	; ba0a  ...z{|}.
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba12  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba1a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba22  ........

; ----------------------------------------------------------------------
; DATOS formas_B661_BA2A: forma de caracteres (de p01:6040) de las entradas 33
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xba2a..0xba5a  (48 bytes)
DATA_formas_B661_BA2A:
	defb 061h,044h,045h,050h,04fh,04dh,04eh,064h	; ba2a  aDEPOMNd
	defb 0a3h,076h,057h,060h,052h,052h,062h,075h	; ba32  .vW`RRbu
	defb 0a2h,0a9h,069h,058h,067h,058h,067h,0a4h	; ba3a  ..iXgXg.
	defb 000h,0a2h,0a9h,0c3h,0c4h,0c5h,0c6h,0a7h	; ba42  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba4a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba52  ........

; ----------------------------------------------------------------------
; DATOS formas_B661_BA5A: forma de caracteres (de p01:6040) de las entradas 34
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xba5a..0xba8a  (48 bytes)
DATA_formas_B661_BA5A:
	defb 061h,044h,04ah,050h,04fh,052h,046h,047h	; ba5a  aDJPORFG
	defb 0a8h,0b5h,06bh,058h,057h,060h,051h,077h	; ba62  ..kXW`Qw
	defb 0b4h,0a0h,069h,068h,06ah,063h,049h,03ah	; ba6a  ..ihjcI:
	defb 000h,0abh,0a9h,076h,039h,066h,067h,0aah	; ba72  ...v9fg.
	defb 000h,000h,0a2h,0a3h,040h,041h,0afh,0c6h	; ba7a  ....@A..
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; ba82  ........

; ----------------------------------------------------------------------
; DATOS formas_B661_BA8A: forma de caracteres (de p01:6040) de las entradas 35
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xba8a..0xbaba  (48 bytes)
DATA_formas_B661_BA8A:
	defb 061h,061h,061h,044h,045h,053h,065h,06ch	; ba8a  aaaDESel
	defb 0b8h,078h,056h,080h,081h,082h,07eh,078h	; ba92  .xV...~x
	defb 000h,0a6h,06fh,043h,057h,060h,051h,077h	; ba9a  ..oCW`Qw
	defb 000h,0b8h,08bh,048h,07eh,066h,067h,0aeh	; baa2  ...H~fg.
	defb 0a8h,0b5h,056h,082h,082h,083h,06ah,0adh	; baaa  ..V...j.
	defb 000h,0b3h,079h,08bh,07ch,07dh,0bah,000h	; bab2  ..y.|}..

; ----------------------------------------------------------------------
; DATOS formas_B661_BABA: forma de caracteres (de p01:6040) de las entradas 36
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbaba..0xbaea  (48 bytes)
DATA_formas_B661_BABA:
	defb 061h,044h,048h,050h,053h,052h,065h,06ch	; baba  aDHPSRel
	defb 0b8h,03bh,056h,048h,053h,052h,07eh,078h	; bac2  ..VHSR~x
	defb 0abh,06fh,043h,082h,04ah,04ah,062h,0afh	; baca  .oC.JJb.
	defb 0a3h,056h,045h,048h,046h,064h,0aeh,0a2h	; bad2  .VEHFd..
	defb 0bbh,0bch,08bh,052h,082h,082h,083h,0b7h	; bada  ...R....
	defb 000h,0b3h,0a1h,07ah,07bh,07ch,07dh,0bah	; bae2  ...z{|}.

; ----------------------------------------------------------------------
; DATOS formas_B661_BAEA: forma de caracteres (de p01:6040) de las entradas 37
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbaea..0xbb1a  (48 bytes)
DATA_formas_B661_BAEA:
	defb 061h,044h,048h,050h,053h,052h,065h,06ch	; baea  aDHPSRel
	defb 0b8h,03bh,056h,048h,053h,052h,07eh,078h	; baf2  ..VHSR~x
	defb 0abh,06fh,043h,082h,04ah,04ah,062h,0afh	; bafa  .oC.JJb.
	defb 0a3h,056h,045h,048h,046h,064h,0aeh,0a2h	; bb02  .VEHFd..
	defb 0bbh,0bch,08bh,052h,082h,082h,083h,0b7h	; bb0a  ...R....
	defb 000h,0b3h,0a1h,07ah,07bh,07ch,07dh,0bah	; bb12  ...z{|}.

; ----------------------------------------------------------------------
; DATOS formas_B661_BB1A: forma de caracteres (de p01:6040) de las entradas 38
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbb1a..0xbb4a  (48 bytes)
DATA_formas_B661_BB1A:
	defb 061h,044h,045h,050h,04fh,046h,047h,064h	; bb1a  aDEPOFGd
	defb 0b8h,03bh,056h,04ah,052h,053h,07eh,0ach	; bb22  ..VJRS~.
	defb 0a8h,0b5h,06bh,058h,057h,060h,051h,077h	; bb2a  ..kXW`Qw
	defb 0b4h,0a0h,069h,068h,06ah,063h,049h,03ah	; bb32  ..ihjcI:
	defb 000h,0abh,0a9h,076h,039h,066h,067h,0aah	; bb3a  ...v9fg.
	defb 000h,000h,0a2h,0a3h,040h,041h,0afh,0c6h	; bb42  ....@A..

; ----------------------------------------------------------------------
; DATOS formas_B661_BB4A: forma de caracteres (de p01:6040) de las entradas 39
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbb4a..0xbb7a  (48 bytes)
DATA_formas_B661_BB4A:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bb4a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bb52  ........
	defb 000h,000h,0b4h,000h,000h,000h,000h,000h	; bb5a  ........
	defb 000h,0a2h,0a0h,000h,0a1h,000h,000h,000h	; bb62  ........
	defb 0b4h,0a3h,079h,08bh,07ch,07dh,0bah,000h	; bb6a  ..y.|}..
	defb 061h,044h,04ah,044h,045h,045h,047h,064h	; bb72  aDJDEEGd

; ----------------------------------------------------------------------
; DATOS formas_B661_BB7A: forma de caracteres (de p01:6040) de las entradas 40
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbb7a..0xbbaa  (48 bytes)
DATA_formas_B661_BB7A:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bb7a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bb82  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bb8a  ........
	defb 000h,0abh,0a9h,07ah,07bh,07ch,07dh,0bah	; bb92  ...z{|}.
	defb 0a9h,076h,056h,048h,053h,052h,07eh,078h	; bb9a  .vVHSR~x
	defb 061h,065h,048h,050h,053h,052h,065h,06ch	; bba2  aeHPSRel

; ----------------------------------------------------------------------
; DATOS formas_B661_BBAA: forma de caracteres (de p01:6040) de las entradas 41
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbbaa..0xbbda  (48 bytes)
DATA_formas_B661_BBAA:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbaa  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbb2  ........
	defb 000h,0a2h,0a9h,0c3h,0c4h,0c5h,0c6h,0a7h	; bbba  ........
	defb 0a2h,0a9h,069h,058h,067h,058h,067h,0a4h	; bbc2  ..iXgXg.
	defb 0a3h,076h,057h,060h,052h,052h,062h,075h	; bbca  .vW`RRbu
	defb 061h,044h,045h,050h,04fh,04dh,04eh,064h	; bbd2  aDEPOMNd

; ----------------------------------------------------------------------
; DATOS formas_B661_BBDA: forma de caracteres (de p01:6040) de las entradas 42
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbbda..0xbc0a  (48 bytes)
DATA_formas_B661_BBDA:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbda  ........
	defb 000h,000h,0a2h,0a3h,040h,041h,0afh,0c6h	; bbe2  ....@A..
	defb 000h,0abh,0a9h,076h,039h,066h,067h,0aah	; bbea  ...v9fg.
	defb 0b4h,0a0h,069h,068h,06ah,063h,049h,03ah	; bbf2  ..ihjcI:
	defb 0a8h,0b5h,06bh,058h,057h,060h,051h,077h	; bbfa  ..kXW`Qw
	defb 061h,044h,04ah,050h,04fh,052h,046h,047h	; bc02  aDJPORFG

; ----------------------------------------------------------------------
; DATOS formas_B661_BC0A: forma de caracteres (de p01:6040) de las entradas 43
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbc0a..0xbc3a  (48 bytes)
DATA_formas_B661_BC0A:
	defb 000h,0b3h,079h,08bh,07ch,07dh,0bah,000h	; bc0a  ..y.|}..
	defb 0a8h,0b5h,056h,082h,082h,083h,06ah,0adh	; bc12  ..V...j.
	defb 000h,0b8h,08bh,048h,07eh,066h,067h,0aeh	; bc1a  ...H~fg.
	defb 000h,0a6h,06fh,043h,057h,060h,051h,077h	; bc22  ..oCW`Qw
	defb 0b8h,078h,056h,080h,081h,082h,07eh,078h	; bc2a  .xV...~x
	defb 061h,061h,061h,044h,045h,053h,065h,06ch	; bc32  aaaDESel

; ----------------------------------------------------------------------
; DATOS formas_B661_BC3A: forma de caracteres (de p01:6040) de las entradas 44
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbc3a..0xbc6a  (48 bytes)
DATA_formas_B661_BC3A:
	defb 000h,0b3h,0a1h,07ah,07bh,07ch,07dh,0bah	; bc3a  ...z{|}.
	defb 0bbh,0bch,08bh,052h,082h,082h,083h,0b7h	; bc42  ...R....
	defb 0a3h,056h,045h,048h,046h,064h,0aeh,0a2h	; bc4a  .VEHFd..
	defb 0abh,06fh,043h,082h,04ah,04ah,062h,0afh	; bc52  .oC.JJb.
	defb 0b8h,03bh,056h,048h,053h,052h,07eh,078h	; bc5a  ..VHSR~x
	defb 061h,044h,048h,050h,053h,052h,065h,06ch	; bc62  aDHPSRel

; ----------------------------------------------------------------------
; DATOS formas_B661_BC6A: forma de caracteres (de p01:6040) de las entradas 45
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbc6a..0xbc9a  (48 bytes)
DATA_formas_B661_BC6A:
	defb 000h,000h,000h,0c3h,0c4h,0c5h,0c6h,0a7h	; bc6a  ........
	defb 000h,000h,08ah,076h,068h,066h,075h,0afh	; bc72  ...vhfu.
	defb 0a2h,0a5h,069h,058h,067h,058h,067h,0a4h	; bc7a  ..iXgXg.
	defb 0a9h,0b5h,067h,059h,057h,051h,062h,0b6h	; bc82  ..gYWQb.
	defb 0a3h,056h,057h,060h,052h,052h,062h,075h	; bc8a  .VW`RRbu
	defb 061h,044h,045h,050h,04fh,04dh,04eh,064h	; bc92  aDEPOMNd

; ----------------------------------------------------------------------
; DATOS formas_B661_BC9A: forma de caracteres (de p01:6040) de las entradas 46
;   de 0xB661; lo leen p01:6046 (48 bytes)
;   0xbc9a..0xbcca  (48 bytes)
DATA_formas_B661_BC9A:
	defb 000h,000h,0a2h,0a3h,040h,041h,0afh,0c6h	; bc9a  ....@A..
	defb 000h,0abh,0a9h,076h,039h,066h,067h,0aah	; bca2  ...v9fg.
	defb 0b4h,0a0h,069h,068h,06ah,063h,049h,03ah	; bcaa  ..ihjcI:
	defb 0a8h,0b5h,06bh,058h,057h,060h,051h,077h	; bcb2  ..kXW`Qw
	defb 0b8h,03bh,056h,04ah,052h,053h,07eh,0ach	; bcba  ..VJRS~.
	defb 061h,044h,045h,050h,04fh,046h,047h,064h	; bcc2  aDEPOFGd

; ----------------------------------------------------------------------
; DATOS formas_B661_BCCA: forma de caracteres (de p01:6040) de las entradas 47
;   de 0xB661; lo leen p01:6046 (4 bytes)
;   0xbcca..0xbcce  (4 bytes)
DATA_formas_B661_BCCA:
	defb 039h,046h,03ah,01fh	; bcca

; ----------------------------------------------------------------------
; DATOS formas_B661_BCCE: forma de caracteres (de p01:6040) de las entradas 48
;   de 0xB661; lo leen p01:6046 (4 bytes)
;   0xbcce..0xbcd2  (4 bytes)
DATA_formas_B661_BCCE:
	defb 050h,051h,03ah,01fh	; bcce

; ----------------------------------------------------------------------
; DATOS formas_B661_BCD2: forma de caracteres (de p01:6040) de las entradas 49
;   de 0xB661; lo leen p01:6046 (4 bytes)
;   0xbcd2..0xbcd6  (4 bytes)
DATA_formas_B661_BCD2:
	defb 000h,000h,052h,053h	; bcd2

; ----------------------------------------------------------------------
; DATOS formas_B661_BCD6: forma de caracteres (de p01:6040) de las entradas 50
;   de 0xB661; lo leen p01:6046 (4 bytes)
;   0xbcd6..0xbcda  (4 bytes)
DATA_formas_B661_BCD6:
	defb 000h,000h,054h,055h	; bcd6

; ----------------------------------------------------------------------
; DATOS formas_B661_BCDA: forma de caracteres (de p01:6040) de las entradas 51
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbcda..0xbce6  (12 bytes)
DATA_formas_B661_BCDA:
	defb 000h,000h,000h,000h,0b9h,000h,0b9h,0c4h	; bcda  ........
	defb 0c5h,0b6h,0c5h,0c6h	; bce2

; ----------------------------------------------------------------------
; DATOS formas_B661_BCE6: forma de caracteres (de p01:6040) de las entradas 52
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbce6..0xbcf2  (12 bytes)
DATA_formas_B661_BCE6:
	defb 000h,000h,000h,000h,000h,0c4h,000h,0b9h	; bce6  ........
	defb 000h,0c6h,000h,0c5h	; bcee

; ----------------------------------------------------------------------
; DATOS formas_B661_BCF2: forma de caracteres (de p01:6040) de las entradas
;   54, 55, 56 de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbcf2..0xbcfe  (12 bytes)
DATA_formas_B661_BCF2:
	defb 093h,000h,000h,098h,094h,095h,09ah,099h	; bcf2  ........
	defb 096h,097h,09ch,09bh	; bcfa

; ----------------------------------------------------------------------
; DATOS formas_B661_BCFE: forma de caracteres (de p01:6040) de las entradas 57
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbcfe..0xbd0a  (12 bytes)
DATA_formas_B661_BCFE:
	defb 096h,097h,09ch,09bh,094h,095h,09ah,099h	; bcfe  ........
	defb 093h,000h,000h,098h	; bd06

; ----------------------------------------------------------------------
; DATOS formas_B661_BD0A: forma de caracteres (de p01:6040) de las entradas 58
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd0a..0xbd16  (12 bytes)
DATA_formas_B661_BD0A:
	defb 000h,000h,000h,000h,08dh,08eh,09fh,09eh	; bd0a  ........
	defb 090h,091h,0a2h,0a1h	; bd12

; ----------------------------------------------------------------------
; DATOS formas_B661_BD16: forma de caracteres (de p01:6040) de las entradas 59
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd16..0xbd22  (12 bytes)
DATA_formas_B661_BD16:
	defb 000h,000h,000h,000h,08dh,08fh,0a0h,09eh	; bd16  ........
	defb 090h,091h,0a2h,0a1h	; bd1e

; ----------------------------------------------------------------------
; DATOS formas_B661_BD22: forma de caracteres (de p01:6040) de las entradas 60
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd22..0xbd2e  (12 bytes)
DATA_formas_B661_BD22:
	defb 000h,000h,000h,000h,08dh,08bh,09ch,09eh	; bd22  ........
	defb 090h,091h,0a2h,0a1h	; bd2a

; ----------------------------------------------------------------------
; DATOS formas_B661_BD2E: forma de caracteres (de p01:6040) de las entradas 61
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd2e..0xbd3a  (12 bytes)
DATA_formas_B661_BD2E:
	defb 000h,0bbh,0bfh,000h,08dh,08ch,09dh,09eh	; bd2e  ........
	defb 090h,091h,0a2h,0a1h	; bd36

; ----------------------------------------------------------------------
; DATOS formas_B661_BD3A: forma de caracteres (de p01:6040) de las entradas 62
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd3a..0xbd46  (12 bytes)
DATA_formas_B661_BD3A:
	defb 000h,092h,0a3h,000h,08dh,093h,0a4h,09eh	; bd3a  ........
	defb 090h,091h,0a2h,0a1h	; bd42

; ----------------------------------------------------------------------
; DATOS formas_B661_BD46: forma de caracteres (de p01:6040) de las entradas 63
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd46..0xbd52  (12 bytes)
DATA_formas_B661_BD46:
	defb 000h,094h,0a5h,000h,08dh,095h,0a6h,09eh	; bd46  ........
	defb 090h,091h,0a2h,0a1h	; bd4e

; ----------------------------------------------------------------------
; DATOS formas_B661_BD52: forma de caracteres (de p01:6040) de las entradas 64
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd52..0xbd5e  (12 bytes)
DATA_formas_B661_BD52:
	defb 000h,096h,0a7h,000h,08dh,097h,0a8h,09eh	; bd52  ........
	defb 090h,091h,0a2h,0a1h	; bd5a

; ----------------------------------------------------------------------
; DATOS formas_B661_BD5E: forma de caracteres (de p01:6040) de las entradas 65
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd5e..0xbd6a  (12 bytes)
DATA_formas_B661_BD5E:
	defb 006h,007h,007h,013h,003h,004h,011h,010h	; bd5e  ........
	defb 000h,000h,000h,000h	; bd66

; ----------------------------------------------------------------------
; DATOS formas_B661_BD6A: forma de caracteres (de p01:6040) de las entradas 66
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd6a..0xbd76  (12 bytes)
DATA_formas_B661_BD6A:
	defb 006h,007h,007h,013h,003h,005h,012h,010h	; bd6a  ........
	defb 000h,000h,000h,000h	; bd72

; ----------------------------------------------------------------------
; DATOS formas_B661_BD76: forma de caracteres (de p01:6040) de las entradas 67
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd76..0xbd82  (12 bytes)
DATA_formas_B661_BD76:
	defb 006h,007h,007h,013h,003h,001h,00eh,010h	; bd76  ........
	defb 000h,000h,000h,000h	; bd7e

; ----------------------------------------------------------------------
; DATOS formas_B661_BD82: forma de caracteres (de p01:6040) de las entradas 68
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd82..0xbd8e  (12 bytes)
DATA_formas_B661_BD82:
	defb 006h,007h,007h,013h,003h,002h,00fh,010h	; bd82  ........
	defb 000h,0c2h,0c3h,000h	; bd8a

; ----------------------------------------------------------------------
; DATOS formas_B661_BD8E: forma de caracteres (de p01:6040) de las entradas 69
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd8e..0xbd9a  (12 bytes)
DATA_formas_B661_BD8E:
	defb 006h,007h,007h,013h,003h,009h,016h,010h	; bd8e  ........
	defb 000h,008h,015h,000h	; bd96

; ----------------------------------------------------------------------
; DATOS formas_B661_BD9A: forma de caracteres (de p01:6040) de las entradas 70
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbd9a..0xbda6  (12 bytes)
DATA_formas_B661_BD9A:
	defb 006h,007h,007h,013h,003h,00bh,018h,010h	; bd9a  ........
	defb 000h,00ah,017h,000h	; bda2

; ----------------------------------------------------------------------
; DATOS formas_B661_BDA6: forma de caracteres (de p01:6040) de las entradas 71
;   de 0xB661; lo leen p01:6046 (12 bytes)
;   0xbda6..0xbdb2  (12 bytes)
DATA_formas_B661_BDA6:
	defb 006h,007h,007h,013h,003h,00dh,01ah,010h	; bda6  ........
	defb 000h,00ch,019h,000h	; bdae

; ----------------------------------------------------------------------
; DATOS tira_fase_2: la tira de la fase 2 (tabla p00:5F6D): pares que p00:5F46
;   lee con el contador 0xE1CB+2 (x 2); lo leen p00:5F5A (119 bytes)
;   0xbdb2..0xbe29  (119 bytes)
DATA_tira_fase_2:
	defb 0a1h,000h,008h,004h,00ah,006h,001h,002h,010h,000h,004h,005h,001h,001h,048h,000h	; bdb2  ..............H.
	defb 00ah,001h,01ch,000h,007h,008h,01ah,00ah,001h,008h,00dh,000h,016h,004h,00dh,000h	; bdc2  ................
	defb 020h,001h,03ah,000h,020h,008h,007h,000h,001h,004h,003h,005h,00fh,004h,017h,000h	; bdd2   .:. ...........
	defb 00fh,002h,00bh,006h,00bh,000h,00fh,008h,001h,000h,00ch,001h,00ah,005h,008h,001h	; bde2  ................
	defb 012h,000h,010h,002h,004h,000h,013h,002h,004h,00ah,00fh,000h,002h,004h,001h,005h	; bdf2  ................
	defb 006h,001h,00fh,009h,00ah,001h,005h,000h,014h,004h,011h,000h,016h,008h,00eh,00ah	; be02  ................
	defb 00dh,002h,001h,006h,00dh,004h,007h,000h,007h,004h,00bh,000h,007h,004h,029h,000h	; be12  ..............).
	defb 01eh,001h,007h,000h,00ch,004h,0ffh	; be22

; ----------------------------------------------------------------------
; DATOS tira_fase_3: la tira de la fase 3 (tabla p00:5F6D): pares que p00:5F46
;   lee con el contador 0xE1CB+2 (x 2); lo leen p00:5F5A (129 bytes)
;   0xbe29..0xbeaa  (129 bytes)
DATA_tira_fase_3:
	defb 0cch,000h,010h,008h,00ah,000h,017h,002h,034h,000h,007h,001h,016h,005h,0bch,000h	; be29  ........4.......
	defb 00bh,004h,009h,006h,003h,004h,009h,000h,00bh,001h,00ah,000h,007h,001h,007h,000h	; be39  ................
	defb 008h,008h,008h,000h,003h,001h,00eh,000h,017h,008h,00fh,000h,003h,008h,005h,00ah	; be49  ................
	defb 007h,002h,002h,006h,010h,004h,02eh,000h,00ch,002h,00bh,004h,016h,000h,008h,001h	; be59  ................
	defb 001h,009h,00ch,008h,01eh,000h,004h,001h,002h,009h,00eh,008h,009h,000h,012h,004h	; be69  ................
	defb 013h,000h,002h,002h,002h,006h,009h,004h,013h,000h,006h,001h,008h,000h,001h,001h	; be79  ................
	defb 006h,000h,011h,008h,022h,000h,004h,008h,001h,00ah,012h,002h,009h,006h,005h,000h	; be89  ...."...........
	defb 00ch,004h,029h,000h,008h,001h,00ah,005h,00fh,001h,004h,000h,01dh,008h,00ch,00ah	; be99  ..).............
	defb 0ffh	; bea9

; ----------------------------------------------------------------------
; DATOS tira_fase_4: la tira de la fase 4 (tabla p00:5F6D): pares que p00:5F46
;   lee con el contador 0xE1CB+2 (x 2); lo leen p00:5F5A (101 bytes)
;   0xbeaa..0xbf0f  (101 bytes)
DATA_tira_fase_4:
	defb 051h,000h,00bh,002h,03bh,000h,001h,002h,008h,00ah,007h,000h,004h,001h,007h,009h	; beaa  Q...............
	defb 006h,001h,012h,005h,02dh,000h,01eh,002h,024h,000h,00ch,001h,00eh,009h,004h,008h	; beba  ....-...$.......
	defb 007h,000h,001h,002h,00eh,006h,00dh,000h,007h,004h,00dh,005h,003h,001h,00bh,009h	; beca  ................
	defb 01ah,000h,001h,008h,014h,00ah,002h,002h,014h,000h,008h,001h,01bh,000h,020h,002h	; beda  .............. .
	defb 00fh,000h,011h,001h,002h,009h,001h,008h,072h,000h,008h,002h,012h,000h,009h,001h	; beea  ........r.......
	defb 048h,000h,00dh,008h,00ch,000h,017h,004h,01ah,000h,01ah,004h,04ah,000h,006h,002h	; befa  H...........J...
	defb 00bh,000h,02bh,008h,0ffh	; bf0a

; ----------------------------------------------------------------------
; DATOS tira_fase_5: la tira de la fase 5 (tabla p00:5F6D): pares que p00:5F46
;   lee con el contador 0xE1CB+2 (x 2); lo leen p00:5F5A (113 bytes)
;   0xbf0f..0xbf80  (113 bytes)
DATA_tira_fase_5:
	defb 059h,000h,004h,005h,008h,004h,008h,000h,002h,002h,004h,006h,003h,002h,021h,000h	; bf0f  Y.............!.
	defb 011h,008h,007h,00ah,001h,002h,01ah,000h,014h,001h,024h,000h,012h,002h,031h,000h	; bf1f  ..........$...1.
	defb 007h,001h,009h,009h,003h,001h,0a6h,000h,006h,005h,019h,004h,01fh,000h,007h,004h	; bf2f  ................
	defb 025h,000h,001h,002h,012h,006h,00eh,002h,005h,000h,00bh,008h,02ch,000h,010h,004h	; bf3f  %...........,...
	defb 037h,000h,002h,008h,016h,009h,009h,001h,010h,000h,00bh,008h,008h,000h,019h,004h	; bf4f  7...............
	defb 01fh,000h,00fh,002h,00ch,006h,001h,004h,00fh,000h,013h,001h,00bh,009h,003h,008h	; bf5f  ................
	defb 032h,000h,00ah,004h,001h,000h,01ah,002h,00dh,000h,006h,002h,00ah,000h,015h,001h	; bf6f  2...............
	defb 0ffh	; bf7f

; ----------------------------------------------------------------------
; DATOS tira_fase_6: la tira de la fase 6 (tabla p00:5F6D): pares que p00:5F46
;   lee con el contador 0xE1CB+2 (x 2); lo leen p00:5F5A (110 bytes)
;   0xbf80..0xbfee  (110 bytes)
DATA_tira_fase_6:
	defb 03eh,000h,00fh,001h,00eh,000h,005h,005h,00bh,000h,025h,002h,010h,000h,003h,002h	; bf80  >.........%.....
	defb 012h,000h,01dh,001h,03ah,000h,010h,002h,023h,000h,004h,002h,00eh,000h,006h,008h	; bf90  ....:...#.......
	defb 00ch,000h,016h,001h,00bh,000h,00ah,008h,001h,000h,00fh,002h,028h,000h,009h,002h	; bfa0  ............(...
	defb 013h,000h,012h,001h,026h,000h,00eh,004h,022h,000h,008h,004h,069h,000h,011h,008h	; bfb0  ....&..."...i...
	defb 019h,000h,01ch,004h,02fh,000h,006h,001h,003h,000h,00dh,002h,00bh,000h,007h,002h	; bfc0  ..../...........
	defb 051h,000h,007h,008h,007h,000h,010h,008h,00fh,000h,008h,004h,01ah,000h,00bh,004h	; bfd0  Q...............
	defb 044h,000h,01ch,008h,009h,009h,003h,001h,005h,000h,007h,004h,00dh,002h	; bfe0  D.............

; ----------------------------------------------------------------------
; DATOS relleno_ff: 18 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (18 bytes)
;   0xbfee..0xc000  (18 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfee  ................
	defb 0ffh,0ffh	; bffe

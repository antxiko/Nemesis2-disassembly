; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 07 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS caracteres_por_fase: 12 punteros, uno por fase (0xE201): las listas de
;   caracteres (p00:4595) de cada fase, p00:4528 con L_4B67; lo leen p00:452B
;   (24 bytes)
;   0x6000..0x6018  (24 bytes)
DATA_caracteres_por_fase:
	defw 06061h,06098h,060dbh,06106h,0614ah,06143h	; 6000
	defw 0616fh,0619ah,061ddh,06106h,06106h,06106h	; 600c

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018: 12 punteros, uno por fase (0xE201): listas de
;   copias de caracteres VRAM -> VRAM en espejo (0xF000 = 0: p00:4617 invierte
;   los bits), p00:4545 con L_4B67; lo leen p00:4548 (24 bytes)
;   0x6018..0x6030  (24 bytes)
DATA_copias_por_fase_6018:
	defw 06295h,0620eh,06224h,06230h,0625dh,062adh	; 6018
	defw 0626eh,06249h,06281h,06230h,06230h,06230h	; 6024

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030: 12 punteros, uno por fase (0xE201): listas de
;   copias de caracteres VRAM -> VRAM cabeza abajo (0xF000 = 1: p00:45EA
;   invierte las filas), p00:4545 con L_4B67; lo leen p00:4548 (24 bytes)
;   0x6030..0x6048  (24 bytes)
DATA_copias_por_fase_6030:
	defw 064b8h,062b2h,062d6h,062f2h,0630fh,06423h	; 6030
	defw 06466h,06326h,064a7h,062f2h,062f2h,062f2h	; 603c

; ----------------------------------------------------------------------
; DATOS caracteres_6048: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][dibujos][caracter][colores], 0 acaba; lo leen p00:4502,
;   p00:4522, p00:57D5 (25 bytes)
;   0x6048..0x6061  (25 bytes)
DATA_caracteres_6048:
	defb 001h,004h,06ch,00bh,09dh,082h	; 6048
	defb 007h,009h,070h,0cbh,0f7h,085h	; 604e
	defb 007h,03eh,06ch,0edh,0d5h,082h	; 6054
	defb 001h,02eh,06ch,01dh,0c8h,082h	; 605a
	defb 000h	; 6060

; ----------------------------------------------------------------------
; DATOS caracteres_fase_6061: lista de caracteres (p00:4595) de la fase 0:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (55 bytes)
;   0x6061..0x6098  (55 bytes)
DATA_caracteres_fase_6061:
	defb 006h,0a7h,069h,015h,0c6h,07fh	; 6061
	defb 007h,0b0h,06ah,01fh,098h,080h	; 6067
	defb 007h,054h,071h,073h,00eh,087h	; 606d
	defb 007h,054h,071h,07fh,080h,087h	; 6073
	defb 006h,057h,06bh,001h,0d4h,081h	; 6079
	defb 007h,0cfh,069h,06dh,0eeh,07fh	; 607f
	defb 007h,0fdh,069h,08bh,01ah,080h	; 6085
	defb 007h,05ah,06ah,0bbh,064h,080h	; 608b
	defb 007h,06bh,06ah,0c3h,076h,080h	; 6091
	defb 000h	; 6097

; ----------------------------------------------------------------------
; DATOS caracteres_fase_6098: lista de caracteres (p00:4595) de la fase 1:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (67 bytes)
;   0x6098..0x60db  (67 bytes)
DATA_caracteres_fase_6098:
	defb 007h,0a6h,06ch,088h,047h,083h	; 6098
	defb 007h,02dh,069h,020h,059h,083h	; 609e
	defb 007h,0b8h,06ch,038h,0cbh,083h	; 60a4
	defb 007h,0feh,064h,0b1h,00dh,07eh	; 60aa
	defb 006h,060h,065h,015h,0b3h,07dh	; 60b0
	defb 007h,074h,071h,08bh,09eh,087h	; 60b6
	defb 007h,0fbh,06dh,093h,0c3h,084h	; 60bc
	defb 007h,054h,071h,0abh,00eh,087h	; 60c2
	defb 007h,05dh,06eh,0bdh,00fh,085h	; 60c8
	defb 007h,0bah,065h,0c1h,0ebh,07dh	; 60ce
	defb 001h,099h,07ch,034h,0e9h,08fh	; 60d4
	defb 000h	; 60da

; ----------------------------------------------------------------------
; DATOS caracteres_fase_60DB: lista de caracteres (p00:4595) de la fase 2:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (43 bytes)
;   0x60db..0x6106  (43 bytes)
DATA_caracteres_fase_60DB:
	defb 007h,074h,071h,08bh,09eh,087h	; 60db
	defb 007h,06fh,06eh,01fh,016h,085h	; 60e1
	defb 007h,0d8h,06fh,0b9h,0dch,085h	; 60e7
	defb 007h,0e0h,077h,079h,0cbh,08bh	; 60ed
	defb 007h,073h,078h,093h,033h,08ch	; 60f3
	defb 007h,0b5h,078h,0afh,065h,08ch	; 60f9
	defb 007h,0d7h,078h,0b3h,085h,08ch	; 60ff
	defb 000h	; 6105

; ----------------------------------------------------------------------
; DATOS caracteres_fase_6106: lista de caracteres (p00:4595) de las fases 3,
;   9, 10, 11: fichas de 6 bytes [tercios][dibujos][caracter][colores], 0
;   acaba; lo leen p00:4531 (61 bytes)
;   0x6106..0x6143  (61 bytes)
DATA_caracteres_fase_6106:
	defb 007h,0e9h,072h,01fh,004h,089h	; 6106
	defb 007h,0bbh,07ch,060h,004h,090h	; 610c
	defb 007h,065h,074h,0c2h,04bh,08ah	; 6112
	defb 007h,0f4h,070h,073h,0b7h,086h	; 6118
	defb 007h,0f4h,070h,067h,02ch,087h	; 611e
	defb 007h,099h,07ch,05ch,0ceh,08fh	; 6124
	defb 007h,04eh,07ch,093h,091h,08fh	; 612a
	defb 007h,067h,06bh,0a0h,0a9h,07dh	; 6130
	defb 007h,0dch,064h,0a1h,065h,07dh	; 6136
	defb 007h,0dch,064h,0a5h,087h,07dh	; 613c
	defb 000h	; 6142

; ----------------------------------------------------------------------
; DATOS caracteres_fase_6143: lista de caracteres (p00:4595) de la fase 5:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (7 bytes)
;   0x6143..0x614a  (7 bytes)
DATA_caracteres_fase_6143:
	defb 007h,086h,074h,01fh,058h,08ah	; 6143
	defb 000h	; 6149

; ----------------------------------------------------------------------
; DATOS caracteres_fase_614A: lista de caracteres (p00:4595) de la fase 4:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (37 bytes)
;   0x614a..0x616f  (37 bytes)
DATA_caracteres_fase_614A:
	defb 007h,0e1h,065h,01fh,05bh,07eh	; 614a
	defb 007h,03fh,068h,08bh,034h,07fh	; 6150
	defb 007h,0b8h,068h,0adh,08ah,07fh	; 6156
	defb 007h,014h,069h,0c4h,0b7h,07fh	; 615c
	defb 007h,022h,071h,073h,0e1h,086h	; 6162
	defb 007h,022h,071h,07fh,056h,087h	; 6168
	defb 000h	; 616e

; ----------------------------------------------------------------------
; DATOS caracteres_fase_616F: lista de caracteres (p00:4595) de la fase 6:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (43 bytes)
;   0x616f..0x619a  (43 bytes)
DATA_caracteres_fase_616F:
	defb 007h,0f2h,07ch,073h,039h,090h	; 616f
	defb 007h,0f2h,07ch,07fh,057h,090h	; 6175
	defb 006h,0d2h,07bh,009h,00fh,08fh	; 617b
	defb 007h,0f6h,078h,01fh,0a1h,08ch	; 6181
	defb 007h,028h,07ah,053h,0aeh,08dh	; 6187
	defb 007h,0eah,07ah,0a9h,06ch,08eh	; 618d
	defb 007h,074h,071h,08bh,09eh,087h	; 6193
	defb 000h	; 6199

; ----------------------------------------------------------------------
; DATOS caracteres_fase_619A: lista de caracteres (p00:4595) de la fase 7:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (67 bytes)
;   0x619a..0x61dd  (67 bytes)
DATA_caracteres_fase_619A:
	defb 007h,054h,071h,07fh,00eh,087h	; 619a
	defb 007h,054h,071h,085h,080h,087h	; 61a0
	defb 007h,08eh,071h,01fh,0b8h,087h	; 61a6
	defb 007h,0e0h,071h,0a1h,00ah,088h	; 61ac
	defb 007h,074h,071h,08bh,09eh,087h	; 61b2
	defb 007h,04eh,07ch,09bh,091h,08fh	; 61b8
	defb 006h,037h,07ch,005h,07bh,08fh	; 61be
	defb 006h,0d2h,07bh,009h,00fh,08fh	; 61c4
	defb 006h,0e5h,07bh,011h,022h,08fh	; 61ca
	defb 007h,034h,07ch,093h,071h,08fh	; 61d0
	defb 006h,078h,07ch,01bh,0adh,08fh	; 61d6
	defb 000h	; 61dc

; ----------------------------------------------------------------------
; DATOS caracteres_fase_61DD: lista de caracteres (p00:4595) de la fase 8:
;   fichas de 6 bytes [tercios][dibujos][caracter][colores], 0 acaba; lo leen
;   p00:4531 (49 bytes)
;   0x61dd..0x620e  (49 bytes)
DATA_caracteres_fase_61DD:
	defb 006h,096h,06ah,013h,02ah,081h	; 61dd
	defb 007h,0b0h,06ah,01fh,042h,081h	; 61e3
	defb 006h,057h,06bh,001h,0d4h,081h	; 61e9
	defb 007h,0f4h,070h,073h,0b7h,086h	; 61ef
	defb 007h,0f4h,070h,07fh,02ch,087h	; 61f5
	defb 007h,071h,06bh,09dh,0e6h,081h	; 61fb
	defb 007h,071h,06bh,0a7h,029h,082h	; 6201
	defb 007h,0c3h,06bh,0b1h,06ch,082h	; 6207
	defb 000h	; 620d

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_620E: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 1; lo
;   leen p00:4548 (22 bytes)
;   0x620e..0x6224  (22 bytes)
DATA_copias_por_fase_6018_620E:
	defb 02ah,02fh,039h,005h	; 620e
	defb 038h,060h,039h,028h	; 6212
	defb 08bh,08eh,07fh,093h	; 6216
	defb 09fh,039h,00ch,0abh	; 621a
	defb 0afh,0b9h,0bdh,0bfh	; 621e
	defb 0b9h,000h	; 6222

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_6224: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 2; lo
;   leen p00:4548 (12 bytes)
;   0x6224..0x6230  (12 bytes)
DATA_copias_por_fase_6018_6224:
	defb 01fh,04ch,039h,02dh	; 6224
	defb 08bh,08eh,07fh,0b9h	; 6228
	defb 0c0h,039h,007h,000h	; 622c

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_6230: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de las fases 3, 9,
;   10, 11; lo leen p00:4548 (25 bytes)
;   0x6230..0x6249  (25 bytes)
DATA_copias_por_fase_6018_6230:
	defb 053h,057h,079h,053h	; 6230
	defb 05ah,079h,055h,05bh	; 6234
	defb 079h,073h,079h,039h	; 6238
	defb 006h,067h,06dh,039h	; 623c
	defb 006h,08bh,08eh,07fh	; 6240
	defb 093h,098h,039h,005h	; 6244
	defb 000h	; 6248

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_6249: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 7; lo
;   leen p00:4548 (20 bytes)
;   0x6249..0x625d  (20 bytes)
DATA_copias_por_fase_6018_6249:
	defb 009h,00bh,0b4h,09bh	; 6249
	defb 0a0h,079h,09ch,07bh	; 624d
	defb 039h,004h,07fh,083h	; 6251
	defb 0b9h,085h,089h,0b9h	; 6255
	defb 08bh,08eh,07fh,000h	; 6259

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_625D: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 4; lo
;   leen p00:4548 (17 bytes)
;   0x625d..0x626e  (17 bytes)
DATA_copias_por_fase_6018_625D:
	defb 0bah,0beh,039h,004h	; 625d
	defb 08bh,09ch,039h,011h	; 6261
	defb 073h,079h,039h,006h	; 6265
	defb 07fh,085h,039h,006h	; 6269
	defb 000h	; 626d

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_626E: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 6; lo
;   leen p00:4548 (19 bytes)
;   0x626e..0x6281  (19 bytes)
DATA_copias_por_fase_6018_626E:
	defb 009h,00bh,0b4h,031h	; 626e
	defb 046h,039h,00dh,073h	; 6272
	defb 079h,019h,006h,07fh	; 6276
	defb 085h,009h,006h,08bh	; 627a
	defb 08eh,07fh,000h	; 627e

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_6281: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 8; lo
;   leen p00:4548 (20 bytes)
;   0x6281..0x6295  (20 bytes)
DATA_copias_por_fase_6018_6281:
	defb 013h,016h,0f4h,025h	; 6281
	defb 035h,039h,010h,035h	; 6285
	defb 025h,031h,010h,073h	; 6289
	defb 079h,039h,006h,07fh	; 628d
	defb 085h,039h,006h,000h	; 6291

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_6295: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 0; lo
;   leen p00:4548 (24 bytes)
;   0x6295..0x62ad  (24 bytes)
DATA_copias_por_fase_6018_6295:
	defb 025h,035h,039h,010h	; 6295
	defb 08bh,097h,039h,00ch	; 6299
	defb 072h,0bdh,079h,073h	; 629d
	defb 077h,0b9h,079h,07dh	; 62a1
	defb 0b9h,07fh,083h,0b9h	; 62a5
	defb 085h,089h,0b9h,000h	; 62a9

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6018_62AD: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 5; lo
;   leen p00:4548 (5 bytes)
;   0x62ad..0x62b2  (5 bytes)
DATA_copias_por_fase_6018_62AD:
	defb 022h,095h,03fh,006h	; 62ad
	defb 000h	; 62b1

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_62B2: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 1; lo
;   leen p00:4548 (36 bytes)
;   0x62b2..0x62d6  (36 bytes)
DATA_copias_por_fase_6030_62B2:
	defb 020h,020h,021h,014h	; 62b2
	defb 088h,088h,0a1h,08bh	; 62b6
	defb 08fh,03fh,004h,093h	; 62ba
	defb 093h,021h,020h,0b3h	; 62be
	defb 0b3h,021h,014h,034h	; 62c2
	defb 034h,021h,004h,0abh	; 62c6
	defb 0abh,021h,006h,0c1h	; 62ca
	defb 0c1h,024h,006h,0c1h	; 62ce
	defb 0c1h,019h,006h,000h	; 62d2

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_62D6: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 2; lo
;   leen p00:4548 (28 bytes)
;   0x62d6..0x62f2  (28 bytes)
DATA_copias_por_fase_6030_62D6:
	defb 04ch,04ch,03ch,010h	; 62d6
	defb 05ch,05ch,03ch,01dh	; 62da
	defb 0c0h,0c0h,03ch,007h	; 62de
	defb 07fh,09bh,03ch,00ch	; 62e2
	defb 093h,0a7h,03ch,008h	; 62e6
	defb 0b3h,0b6h,0fch,08bh	; 62ea
	defb 08fh,03fh,004h,000h	; 62ee

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_62F2: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de las fases 3, 9,
;   10, 11; lo leen p00:4548 (29 bytes)
;   0x62f2..0x630f  (29 bytes)
DATA_copias_por_fase_6030_62F2:
	defb 040h,040h,024h,013h	; 62f2
	defb 073h,07fh,039h,00ch	; 62f6
	defb 073h,073h,021h,018h	; 62fa
	defb 067h,067h,021h,00ch	; 62fe
	defb 05ch,05ch,021h,004h	; 6302
	defb 093h,093h,021h,00ah	; 6306
	defb 08bh,08fh,03fh,004h	; 630a
	defb 000h	; 630e

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_630F: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 4; lo
;   leen p00:4548 (23 bytes)
;   0x630f..0x6326  (23 bytes)
DATA_copias_por_fase_6030_630F:
	defb 0bbh,0c2h,079h,0bfh	; 630f
	defb 0c3h,079h,08bh,001h	; 6313
	defb 031h,00dh,09ch,00eh	; 6317
	defb 031h,00dh,073h,073h	; 631b
	defb 021h,00ch,07fh,07fh	; 631f
	defb 031h,00ch,000h	; 6323

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_6326: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 7; lo
;   leen p00:4548 (253 bytes)
;   0x6326..0x6423  (253 bytes)
DATA_copias_por_fase_6030_6326:
	defb 005h,001h,036h,004h	; 6326
	defb 009h,00dh,036h,004h	; 632a
	defb 011h,094h,03eh,007h	; 632e
	defb 07bh,07bh,021h,004h	; 6332
	defb 08bh,08fh,03fh,004h	; 6336
	defb 01fh,02eh,089h,023h	; 633a
	defb 03eh,089h,022h,046h	; 633e
	defb 0c9h,022h,04ah,089h	; 6342
	defb 01fh,04ch,089h,020h	; 6346
	defb 051h,089h,01fh,054h	; 634a
	defb 089h,022h,05ch,089h	; 634e
	defb 026h,064h,089h,026h	; 6352
	defb 066h,089h,026h,068h	; 6356
	defb 089h,025h,070h,089h	; 635a
	defb 027h,073h,089h,01fh	; 635e
	defb 029h,049h,025h,02ah	; 6362
	defb 049h,024h,02bh,049h	; 6366
	defb 021h,02ch,049h,028h	; 636a
	defb 02dh,049h,022h,030h	; 636e
	defb 049h,024h,031h,049h	; 6372
	defb 021h,032h,049h,023h	; 6376
	defb 033h,049h,021h,034h	; 637a
	defb 049h,024h,035h,049h	; 637e
	defb 028h,036h,049h,025h	; 6382
	defb 037h,049h,022h,038h	; 6386
	defb 049h,025h,039h,049h	; 638a
	defb 023h,03ah,049h,025h	; 638e
	defb 03bh,049h,028h,03ch	; 6392
	defb 049h,027h,03dh,049h	; 6396
	defb 026h,040h,049h,024h	; 639a
	defb 041h,049h,028h,042h	; 639e
	defb 049h,021h,043h,049h	; 63a2
	defb 028h,044h,049h,025h	; 63a6
	defb 045h,049h,026h,049h	; 63aa
	defb 049h,023h,04eh,049h	; 63ae
	defb 025h,04fh,049h,027h	; 63b2
	defb 050h,049h,023h,053h	; 63b6
	defb 049h,026h,056h,049h	; 63ba
	defb 021h,057h,049h,028h	; 63be
	defb 058h,049h,022h,059h	; 63c2
	defb 049h,025h,05ah,049h	; 63c6
	defb 020h,05bh,049h,028h	; 63ca
	defb 05eh,049h,025h,05fh	; 63ce
	defb 049h,020h,060h,049h	; 63d2
	defb 026h,061h,049h,020h	; 63d6
	defb 062h,049h,023h,063h	; 63da
	defb 049h,024h,06ah,049h	; 63de
	defb 027h,06bh,049h,022h	; 63e2
	defb 06ch,049h,026h,06dh	; 63e6
	defb 049h,028h,06eh,049h	; 63ea
	defb 026h,06fh,049h,023h	; 63ee
	defb 072h,049h,025h,075h	; 63f2
	defb 049h,020h,076h,049h	; 63f6
	defb 023h,077h,049h,020h	; 63fa
	defb 078h,049h,027h,079h	; 63fe
	defb 049h,025h,07ah,049h	; 6402
	defb 029h,029h,039h,010h	; 6406
	defb 039h,039h,039h,010h	; 640a
	defb 049h,049h,039h,010h	; 640e
	defb 059h,059h,039h,010h	; 6412
	defb 069h,069h,039h,012h	; 6416
	defb 07fh,07fh,021h,00ch	; 641a
	defb 09bh,09bh,021h,006h	; 641e
	defb 000h	; 6422

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_6423: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 5; lo
;   leen p00:4548 (67 bytes)
;   0x6423..0x6466  (67 bytes)
DATA_copias_por_fase_6030_6423:
	defb 07fh,08ah,039h,00bh	; 6423
	defb 021h,0a0h,039h,018h	; 6427
	defb 0a0h,0a0h,039h,018h	; 642b
	defb 03ch,0b8h,039h,004h	; 642f
	defb 0b8h,0b8h,039h,004h	; 6433
	defb 074h,0bch,079h,0bch	; 6437
	defb 0bch,079h,085h,0bdh	; 643b
	defb 039h,005h,0bdh,0bdh	; 643f
	defb 039h,005h,090h,0c2h	; 6443
	defb 039h,005h,0c2h,0c2h	; 6447
	defb 039h,005h,01fh,01fh	; 644b
	defb 024h,020h,03fh,03fh	; 644f
	defb 024h,020h,05fh,05fh	; 6453
	defb 024h,020h,07fh,07fh	; 6457
	defb 024h,020h,09fh,09fh	; 645b
	defb 024h,020h,0bfh,0bfh	; 645f
	defb 024h,008h,000h	; 6463

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_6466: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 6; lo
;   leen p00:4548 (65 bytes)
;   0x6466..0x64a7  (65 bytes)
DATA_copias_por_fase_6030_6466:
	defb 009h,00dh,032h,004h	; 6466
	defb 0ach,001h,072h,0abh	; 646a
	defb 002h,072h,0aah,003h	; 646e
	defb 072h,05bh,004h,0f2h	; 6472
	defb 05fh,007h,072h,060h	; 6476
	defb 008h,072h,061h,011h	; 647a
	defb 072h,059h,012h,0b2h	; 647e
	defb 001h,001h,024h,00bh	; 6482
	defb 01fh,01fh,024h,010h	; 6486
	defb 02fh,02fh,024h,010h	; 648a
	defb 03fh,03fh,024h,010h	; 648e
	defb 04fh,04fh,024h,01ch	; 6492
	defb 0a9h,0a9h,024h,01eh	; 6496
	defb 073h,07fh,031h,00ch	; 649a
	defb 07fh,073h,021h,00ch	; 649e
	defb 08bh,08fh,03fh,004h	; 64a2
	defb 000h	; 64a6

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_64A7: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 8; lo
;   leen p00:4548 (17 bytes)
;   0x64a7..0x64b8  (17 bytes)
DATA_copias_por_fase_6030_64A7:
	defb 013h,019h,034h,006h	; 64a7
	defb 025h,045h,039h,020h	; 64ab
	defb 01fh,065h,039h,006h	; 64af
	defb 073h,073h,021h,018h	; 64b3
	defb 000h	; 64b7

; ----------------------------------------------------------------------
; DATOS copias_por_fase_6030_64B8: lista de copias VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba) de la fase 0; lo
;   leen p00:4548 (36 bytes)
;   0x64b8..0x64dc  (36 bytes)
DATA_copias_por_fase_6030_64B8:
	defb 025h,045h,039h,020h	; 64b8
	defb 01fh,065h,039h,006h	; 64bc
	defb 073h,079h,039h,006h	; 64c0
	defb 07fh,085h,039h,006h	; 64c4
	defb 015h,012h,0f2h,018h	; 64c8
	defb 01ah,0b2h,06dh,01ch	; 64cc
	defb 0f1h,08bh,0a3h,039h	; 64d0
	defb 018h,070h,0beh,0f9h	; 64d4
	defb 0bbh,0c1h,0f9h,000h	; 64d8

; ----------------------------------------------------------------------
; DATOS dibujos_64DC: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 161, ficha 8 de la lista 0x6106 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x64dc..0x64fe  (34 bytes)
DATA_dibujos_64DC:
	defb 0a0h,000h,080h,060h,077h,038h,010h,023h,0a7h,000h,001h,006h,0eeh,01ch,008h,0c4h	; 64dc  ...`w8.#........
	defb 0e5h,0a7h,023h,010h,038h,077h,060h,080h,000h,0e5h,0c4h,008h,01ch,0eeh,006h,001h	; 64ec  ..#.8w`.........
	defb 000h,000h	; 64fc

; ----------------------------------------------------------------------
; DATOS dibujos_64FE: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 177, ficha 3 de la lista 0x6098 (p00:4595); lo leen p00:4531 (98
;   bytes)
;   0x64fe..0x6560  (98 bytes)
DATA_dibujos_64FE:
	defb 0e0h,034h,06eh,05ah,000h,086h,0cch,0ebh,0f7h,034h,06eh,05ah,061h,086h,0cch,000h	; 64fe  .4nZ.....4nZa...
	defb 000h,024h,012h,040h,0b8h,0fch,0f9h,0fbh,0f9h,031h,083h,0f9h,0f6h,0c6h,082h,038h	; 650e  .$.@.....1.....8
	defb 07dh,007h,064h,076h,023h,013h,0bdh,0cfh,03fh,0c3h,00fh,007h,038h,07eh,05fh,0f7h	; 651e  }.dv#...?...8~_.
	defb 0ffh,07ch,0b2h,0c7h,078h,0c1h,00fh,03dh,014h,0d3h,00dh,013h,02fh,05fh,07fh,01fh	; 652e  .|..x..=..../_..
	defb 04fh,0e0h,026h,06eh,0c4h,0c8h,0bdh,0f3h,0fch,0c3h,0f0h,0e0h,01ch,07eh,0fah,0efh	; 653e  O.&n.........~..
	defb 0ffh,03eh,04dh,0e3h,01eh,083h,0f0h,0bch,028h,0cbh,0b0h,0c8h,0f4h,0fah,0feh,0f8h	; 654e  .>M.....(.......
	defb 0f2h,000h	; 655e

; ----------------------------------------------------------------------
; DATOS dibujos_6560: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 21, ficha 4 de la lista 0x6098 (p00:4595); lo leen p00:4531 (90
;   bytes)
;   0x6560..0x65ba  (90 bytes)
DATA_dibujos_6560:
	defb 0c8h,060h,068h,000h,020h,0fbh,036h,0cdh,010h,082h,0e6h,000h,025h,007h,0c8h,036h	; 6560  .`h. .6.....%..6
	defb 040h,0e0h,0f0h,014h,065h,071h,014h,005h,091h,000h,03ch,03eh,09eh,0cch,021h,015h	; 6570  @...eq....<>..!.
	defb 044h,01ch,002h,004h,06ch,006h,016h,012h,088h,098h,008h,02ah,03ah,01ah,08ah,0a2h	; 6580  D...l......*:...
	defb 032h,051h,013h,060h,0a8h,0c8h,0a8h,068h,069h,001h,0c0h,0c6h,040h,020h,006h,001h	; 6590  2Q.`...hi...@ ..
	defb 000h,048h,002h,022h,00ah,004h,000h,000h,004h,003h,000h,08dh,042h,004h,002h,008h	; 65a0  .H."........B...
	defb 014h,001h,000h,000h,031h,06fh,040h,01ch,0c2h,000h	; 65b0  ....1o@...

; ----------------------------------------------------------------------
; DATOS dibujos_65BA: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 193, ficha 9 de la lista 0x6098 (p00:4595); lo leen p00:4531 (39
;   bytes)
;   0x65ba..0x65e1  (39 bytes)
DATA_dibujos_65BA:
	defb 082h,0b9h,062h,006h,000h,085h,063h,073h,071h,03ah,01bh,003h,001h,083h,079h,07ch	; 65ba  ..b...csq:....y|
	defb 038h,005h,000h,083h,0fah,074h,020h,005h,000h,082h,09ch,00eh,006h,000h,085h,0c6h	; 65ca  8....t .........
	defb 0ceh,08eh,05ch,0d8h,003h,080h,000h	; 65da

; ----------------------------------------------------------------------
; DATOS dibujos_65E1: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x614A (p00:4595); lo leen p00:4531 (606
;   bytes)
;   0x65e1..0x683f  (606 bytes)
DATA_dibujos_65E1:
	defb 0b8h,0fdh,0ddh,0deh,0ceh,0eeh,0e7h,0e7h,0f7h,0fdh,0ddh,0deh,0ceh,0eeh,0e7h,0e7h	; 65e1  ................
	defb 0f7h,080h,0e0h,0e0h,0f0h,070h,078h,038h,0bch,0f3h,0b3h,0b9h,0bdh,0bdh,0deh,0dfh	; 65f1  .....px8........
	defb 0cfh,09eh,09fh,0dfh,0dfh,0efh,0ffh,0f7h,0f3h,0cfh,0e7h,0e3h,0e3h,0f0h,0f0h,0f8h	; 6601  ................
	defb 0feh,0f9h,0f9h,0fch,0fch,0feh,07fh,07fh,03fh,00ch,0ffh,002h,07fh,002h,03fh,0ach	; 6611  ........?.....?.
	defb 07fh,09fh,0cfh,0c7h,0e7h,0f3h,0fch,0feh,0f8h,0fch,0feh,0dfh,0e7h,061h,030h,008h	; 6621  .............a0.
	defb 0e0h,0d0h,0c0h,084h,040h,000h,002h,001h,0ffh,0f7h,0efh,0cfh,08fh,01dh,011h,000h	; 6631  ....@...........
	defb 0ffh,0ffh,0fbh,0fbh,0f1h,0f1h,0f0h,0e0h,09fh,09fh,083h,081h,003h,0c0h,092h,060h	; 6641  ...............`
	defb 0ffh,0dfh,0efh,0e3h,070h,018h,000h,000h,0c0h,0e0h,070h,098h,006h,001h,000h,000h	; 6651  ....p.....p.....
	defb 001h,003h,003h,003h,007h,081h,00fh,004h,000h,098h,008h,00ch,034h,0feh,001h,003h	; 6661  ............4...
	defb 00fh,01fh,03fh,03fh,07fh,0edh,00fh,01fh,01fh,03fh,03fh,07fh,0f7h,0e7h,0fdh,0e8h	; 6671  ..??.....??.....
	defb 050h,080h,00ch,000h,097h,0f7h,0cfh,09fh,07bh,0e7h,0ceh,098h,021h,0ffh,0ffh,0efh	; 6681  P.......{...!...
	defb 09fh,039h,023h,0feh,0fch,0f8h,0f0h,0c0h,080h,0ffh,0feh,0f8h,004h,000h,09ah,037h	; 6691  .9#............7
	defb 077h,0c8h,098h,098h,09ch,09ch,0bch,03ch,06ch,068h,068h,0eah,0dah,0d6h,0deh,0dch	; 66a1  w......<lhh.....
	defb 09ch,09ch,0bch,038h,08fh,0feh,0feh,0fch,0fch,003h,0f8h,082h,030h,020h,003h,060h	; 66b1  ...8........0 .`
	defb 098h,0e0h,0f0h,0f0h,0e1h,0c1h,087h,03fh,0fch,0fch,0f8h,0f8h,0f0h,0e8h,0e0h,0e0h	; 66c1  .......?........
	defb 070h,030h,008h,004h,0f0h,0e0h,0c0h,0c0h,080h,003h,000h,090h,00fh,01bh,017h,007h	; 66d1  p0..............
	defb 08dh,08bh,023h,0f1h,0f8h,0d2h,0b2h,061h,0ffh,0d7h,0e3h,0f1h,003h,000h,0cah,001h	; 66e1  ..#....a........
	defb 081h,088h,09ch,0beh,0fbh,0b3h,077h,0ffh,0feh,0ddh,03fh,07fh,0dbh,0b3h,0e7h,09fh	; 66f1  ......w...?.....
	defb 0feh,0feh,0fdh,0fbh,000h,000h,060h,060h,070h,0f0h,007h,0fbh,002h,047h,0cch,0ceh	; 6701  ......``p....G..
	defb 080h,090h,0b0h,079h,001h,007h,00fh,01fh,03fh,07fh,07fh,0ffh,0f8h,003h,001h,07fh	; 6711  ...y....?.......
	defb 03fh,0dfh,0e7h,0ffh,03fh,07fh,037h,04fh,019h,0bfh,07fh,03eh,001h,003h,007h,00bh	; 6721  ?...?.7O...>....
	defb 011h,0c2h,060h,018h,001h,003h,017h,03bh,07fh,003h,0ffh,084h,08fh,0cbh,0e7h,0fbh	; 6731  ..`.............
	defb 004h,0ffh,08dh,007h,00eh,01ch,060h,0feh,0f8h,0e0h,000h,008h,01ch,032h,048h,001h	; 6741  ......`......2H.
	defb 009h,000h,082h,088h,0d8h,005h,000h,090h,008h,018h,083h,000h,030h,0cah,010h,038h	; 6751  ............0..8
	defb 079h,068h,0eah,001h,084h,036h,04eh,0ceh,003h,0e7h,004h,000h,084h,023h,070h,06eh	; 6761  yh...6N......#pn
	defb 086h,004h,000h,084h,008h,0e2h,0d9h,025h,008h,000h,0c7h,080h,0e3h,0f7h,0f7h,0e0h	; 6771  .......%........
	defb 00eh,01fh,00eh,000h,01fh,0bfh,0dfh,0dfh,007h,030h,030h,00ch,09eh,0deh,0cdh,080h	; 6781  .........00.....
	defb 03eh,07eh,038h,003h,08fh,0dfh,05fh,09fh,0dfh,0cfh,080h,0c0h,0e1h,0f3h,0e0h,0cfh	; 6791  >~8..._.........
	defb 0dfh,01fh,00fh,0ffh,01fh,0bfh,0dfh,0dfh,007h,030h,030h,001h,03bh,09bh,063h,0f0h	; 67a1  .........00...c.
	defb 067h,007h,000h,080h,0e3h,0f7h,0f7h,0e0h,00eh,01fh,00eh,000h,010h,00ah,041h,083h	; 67b1  g.............A.
	defb 0a1h,040h,003h,000h,096h,010h,000h,04ah,00ch,084h,084h,000h,000h,008h,020h,092h	; 67c1  .@.....J...... .
	defb 0d1h,060h,068h,000h,010h,000h,002h,090h,089h,0adh,06fh,003h,000h,002h,00ah,08bh	; 67d1  .`h.......o.....
	defb 01ch,00eh,006h,000h,000h,010h,04ah,03bh,01eh,00eh,04fh,003h,000h,085h,080h,012h	; 67e1  ......J...O.....
	defb 0d1h,0f0h,06ch,003h,000h,09ah,008h,084h,007h,092h,0a2h,000h,000h,080h,084h,040h	; 67f1  ..l............@
	defb 049h,005h,007h,000h,004h,000h,08ah,012h,051h,021h,000h,063h,02bh,031h,011h,011h	; 6801  I.......Q!.c+1..
	defb 003h,000h,0a8h,026h,0a5h,0a2h,003h,042h,081h,081h,001h,016h,052h,021h,0a9h,090h	; 6811  ...&...B....R!..
	defb 010h,018h,018h,007h,087h,003h,001h,021h,021h,010h,014h,068h,038h,038h,092h,012h	; 6821  .......!!..h88..
	defb 011h,000h,020h,0e0h,048h,04ch,005h,002h,042h,080h,080h,008h,0c0h,000h	; 6831  .. .HL..B.....

; ----------------------------------------------------------------------
; DATOS dibujos_683F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 139, ficha 1 de la lista 0x614A (p00:4595); lo leen p00:4531 (121
;   bytes)
;   0x683f..0x68b8  (121 bytes)
DATA_dibujos_683F:
	defb 003h,001h,086h,013h,0f3h,0f0h,0ffh,0ffh,001h,003h,003h,081h,007h,007h,000h,081h	; 683f  ................
	defb 058h,003h,0d8h,003h,000h,081h,01fh,007h,0ffh,09ah,01eh,0feh,0feh,0ffh,0ffh,000h	; 684f  X...............
	defb 02dh,02dh,000h,004h,009h,012h,025h,000h,0bbh,0bbh,000h,0b7h,077h,0efh,0efh,001h	; 685f  --....%.....w...
	defb 00fh,03fh,07fh,07fh,003h,0ffh,002h,07fh,08bh,03fh,00fh,001h,000h,0ffh,0ffh,000h	; 686f  .?.......?......
	defb 003h,00fh,01fh,01fh,003h,03fh,002h,01fh,08bh,00fh,003h,000h,000h,0ffh,0ffh,000h	; 687f  .....?..........
	defb 001h,003h,007h,007h,003h,00fh,002h,007h,084h,003h,001h,000h,000h,00ah,0ffh,08dh	; 688f  ................
	defb 001h,03bh,09bh,063h,0f0h,067h,007h,000h,000h,060h,010h,005h,004h,003h,002h,088h	; 689f  ...c.g...`......
	defb 000h,080h,042h,021h,029h,010h,000h,000h,000h	; 68af  ..B!)....

; ----------------------------------------------------------------------
; DATOS dibujos_68B8: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 173, ficha 2 de la lista 0x614A (p00:4595); lo leen p00:4531 (92
;   bytes)
;   0x68b8..0x6914  (92 bytes)
DATA_dibujos_68B8:
	defb 002h,000h,003h,080h,003h,040h,003h,000h,08dh,080h,0c0h,0c0h,0e0h,0f0h,000h,080h	; 68b8  .....@..........
	defb 080h,040h,0a0h,098h,044h,020h,006h,000h,087h,058h,00fh,018h,004h,004h,003h,003h	; 68c8  .@..D ...X......
	defb 003h,001h,084h,056h,022h,022h,002h,004h,000h,081h,014h,003h,008h,007h,000h,002h	; 68d8  ...V""..........
	defb 001h,083h,003h,007h,007h,005h,000h,081h,007h,00ah,0ffh,010h,000h,005h,0ffh,002h	; 68e8  ................
	defb 0f7h,081h,0e3h,006h,0ffh,082h,002h,007h,003h,001h,002h,003h,086h,001h,000h,001h	; 68f8  ................
	defb 000h,018h,004h,007h,000h,083h,048h,022h,002h,003h,000h,000h	; 6908  ......H"....

; ----------------------------------------------------------------------
; DATOS dibujos_6914: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 196, ficha 3 de la lista 0x614A (p00:4595); lo leen p00:4531 (25
;   bytes)
;   0x6914..0x692d  (25 bytes)
DATA_dibujos_6914:
	defb 003h,000h,002h,008h,002h,01ch,091h,03ah,018h,01ch,02ah,038h,072h,041h,008h,0ffh	; 6914  .......:..*8rA..
	defb 01ch,034h,03ah,059h,072h,041h,008h,0ffh,000h	; 6924  .4:YrA...

; ----------------------------------------------------------------------
; DATOS dibujos_692D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 32, ficha 1 de la lista 0x6098 (p00:4595); lo leen p00:4531 (122
;   bytes)
;   0x692d..0x69a7  (122 bytes)
DATA_dibujos_692D:
	defb 09dh,00eh,03bh,077h,06ch,0a0h,06fh,067h,09fh,07eh,03fh,087h,0feh,00dh,07dh,0e0h	; 692d  ...wl.og.~?...}.
	defb 0fch,089h,064h,0f9h,0b1h,044h,083h,000h,000h,020h,075h,0f9h,04eh,044h,003h,009h	; 693d  ..d..D... u.ND..
	defb 0a5h,072h,073h,030h,058h,06eh,011h,000h,000h,01ch,07eh,0e1h,0c0h,0c1h,080h,001h	; 694d  .rs0Xn....~.....
	defb 082h,0c2h,08bh,03ch,0b9h,0fdh,0f9h,0fah,076h,0e0h,070h,0f8h,0b4h,0b7h,03eh,01eh	; 695d  ...<....v.p...>.
	defb 02ch,062h,09bh,066h,0b1h,044h,003h,00fh,0b0h,0a5h,099h,05ah,042h,018h,024h,018h	; 696d  ,b.f.D.....ZB.$.
	defb 0c3h,018h,0bdh,03dh,0bdh,03dh,0bdh,03dh,042h,03ch,03dh,078h,079h,0f0h,0f3h,0e0h	; 697d  ...=.=.=B<=xy...
	defb 018h,081h,0c2h,075h,079h,03ah,015h,00bh,08ch,000h,0a3h,0d9h,0adh,0a5h,0a5h,0abh	; 698d  ...uy:..........
	defb 04ah,015h,091h,00ah,08ah,088h,057h,024h,0c3h,000h	; 699d  J.....W$..

; ----------------------------------------------------------------------
; DATOS dibujos_69A7: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 21, ficha 0 de la lista 0x6061 (p00:4595); lo leen p00:4531 (40
;   bytes)
;   0x69a7..0x69cf  (40 bytes)
DATA_dibujos_69A7:
	defb 08fh,07ah,02bh,00ah,001h,0c3h,022h,01eh,003h,0c0h,01fh,04fh,0a1h,048h,0ach,0b8h	; 69a7  .z+..."....O.H..
	defb 004h,000h,08ah,02ah,0eah,0eah,02ah,000h,018h,0c0h,07fh,03fh,001h,003h,0afh,085h	; 69b7  ...*..*....?....
	defb 018h,003h,0feh,0fch,080h,003h,0f5h,000h	; 69c7  ........

; ----------------------------------------------------------------------
; DATOS dibujos_69CF: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 109, ficha 5 de la lista 0x6061 (p00:4595); lo leen p00:4531 (46
;   bytes)
;   0x69cf..0x69fd  (46 bytes)
DATA_dibujos_69CF:
	defb 09ch,0f9h,079h,07eh,01fh,0c3h,01fh,033h,040h,0c7h,0efh,07ch,083h,0bbh,07eh,0ffh	; 69cf  ..y~...3@..|..~.
	defb 07eh,03fh,03fh,0ffh,0f8h,0e0h,0f8h,0cch,002h,000h,07fh,000h,00fh,004h,000h,004h	; 69df  ~??.............
	defb 07bh,089h,0ffh,0f8h,006h,007h,0e7h,03fh,07fh,03fh,001h,003h,0afh,000h	; 69ef  {......?.?....

; ----------------------------------------------------------------------
; DATOS dibujos_69FD: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 139, ficha 6 de la lista 0x6061 (p00:4595); lo leen p00:4531 (93
;   bytes)
;   0x69fd..0x6a5a  (93 bytes)
DATA_dibujos_69FD:
	defb 088h,0f3h,0c0h,01fh,0f8h,0f6h,0cch,03ch,0f8h,004h,000h,0a8h,001h,00fh,01fh,0c0h	; 69fd  .......<........
	defb 000h,000h,001h,01eh,0f9h,0e7h,0dch,031h,006h,03ah,0bah,052h,0c6h,018h,070h,0c0h	; 6a0d  .......1.:.R..p.
	defb 003h,00fh,01ch,03bh,030h,047h,0fch,000h,0ddh,03bh,0f4h,081h,03fh,0e0h,000h,000h	; 6a1d  ....0G......?...
	defb 0c7h,0ceh,01ch,0f8h,007h,000h,0a5h,007h,01fh,040h,002h,07ah,000h,007h,0deh,0dch	; 6a2d  .........@.z....
	defb 083h,00fh,0fch,0f2h,0ffh,001h,003h,004h,001h,00ch,026h,060h,007h,01fh,03fh,07fh	; 6a3d  ..........&`..?.
	defb 07fh,00fh,07fh,017h,007h,01fh,03fh,07fh,07fh,00fh,07fh,017h,000h	; 6a4d  ......?......

; ----------------------------------------------------------------------
; DATOS dibujos_6A5A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 187, ficha 7 de la lista 0x6061 (p00:4595); lo leen p00:4531 (17
;   bytes)
;   0x6a5a..0x6a6b  (17 bytes)
DATA_dibujos_6A5A:
	defb 002h,000h,086h,018h,03ch,081h,0e7h,042h,07eh,004h,07bh,084h,000h,0f8h,006h,007h	; 6a5a  ....<..B~.{.....
	defb 000h	; 6a6a

; ----------------------------------------------------------------------
; DATOS dibujos_6A6B: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 195, ficha 8 de la lista 0x6061 (p00:4595); lo leen p00:4531 (43
;   bytes)
;   0x6a6b..0x6a96  (43 bytes)
DATA_dibujos_6A6B:
	defb 095h,000h,0bdh,0bdh,000h,0bdh,0bdh,081h,03ch,03ch,081h,0bdh,0bdh,000h,0bdh,0bdh	; 6a6b  ........<<......
	defb 000h,000h,0bdh,0bdh,081h,03ch,006h,000h,087h,03ch,081h,0bdh,0bdh,0ffh,000h,068h	; 6a7b  .....<...<.....h
	defb 005h,000h,081h,068h,004h,000h,081h,024h,003h,000h,000h	; 6a8b  ...h...$...

; ----------------------------------------------------------------------
; DATOS dibujos_6A96: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 19, ficha 0 de la lista 0x61DD (p00:4595); lo leen p00:4531 (26
;   bytes)
;   0x6a96..0x6ab0  (26 bytes)
DATA_dibujos_6A96:
	defb 098h,000h,0b5h,0fdh,001h,07dh,00dh,0e0h,0ffh,06dh,06dh,014h,07fh,080h,03fh,02ah	; 6a96  .....}...mm...?*
	defb 02ah,011h,008h,004h,003h,001h,003h,007h,00fh,000h	; 6aa6  *.........

; ----------------------------------------------------------------------
; DATOS dibujos_6AB0: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 1 de la lista 0x6061 (p00:4595); lo leen p00:4531 (167
;   bytes)
;   0x6ab0..0x6b57  (167 bytes)
DATA_dibujos_6AB0:
	defb 0aah,000h,06ah,062h,026h,015h,091h,049h,02ah,000h,055h,033h,099h,09fh,040h,02bh	; 6ab0  ..jb&..I*.U3..@+
	defb 054h,000h,0aah,0cch,099h,0f9h,002h,018h,0a2h,055h,054h,0aah,0a9h,064h,0c4h,095h	; 6ac0  T........UT..d..
	defb 093h,024h,0a4h,054h,054h,095h,0a5h,02ah,032h,000h,067h,003h,054h,08fh,080h,0feh	; 6ad0  .$.TT..*2.g.T...
	defb 0bah,01dh,037h,06eh,05dh,05dh,000h,02eh,05dh,0f7h,0ffh,07eh,0ddh,004h,0fdh,082h	; 6ae0  ..7n]]..]..~....
	defb 063h,01ch,005h,05dh,08ch,07fh,06eh,06eh,06ah,06eh,064h,064h,024h,022h,040h,05ch	; 6af0  c..]..nnjndd$"@\
	defb 040h,003h,05ch,0a7h,040h,07ch,03eh,000h,03fh,013h,00ch,05fh,018h,037h,01ch,000h	; 6b00  @.\.@|>.?.._.7..
	defb 0ddh,0dch,0dfh,000h,01ch,01ch,030h,035h,0c5h,030h,0b7h,0b1h,0b5h,035h,0b5h,035h	; 6b10  ......05.0...5.5
	defb 0b1h,0b7h,0c7h,030h,037h,037h,01ch,00fh,015h,015h,000h,003h,01ch,088h,06fh,000h	; 6b20  ...077........o.
	defb 055h,055h,01fh,03fh,07fh,000h,006h,05dh,08ah,05ch,05dh,0fdh,0fch,01dh,0f1h,015h	; 6b30  UU.?...].\].....
	defb 0f5h,0f1h,0f5h,008h,01ch,090h,032h,01dh,003h,026h,06dh,049h,05ah,0c3h,0fdh,0fch	; 6b40  ......2..&mIZ...
	defb 0fdh,0f1h,0f5h,0f5h,0f1h,0f5h,000h	; 6b50

; ----------------------------------------------------------------------
; DATOS dibujos_6B57: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 4 de la lista 0x6061 (p00:4595); lo leen p00:4531 (16
;   bytes)
;   0x6b57..0x6b67  (16 bytes)
DATA_dibujos_6B57:
	defb 082h,000h,071h,004h,000h,084h,071h,000h,000h,000h,004h,020h,082h,000h,000h,000h	; 6b57  ..q...q.... ....

; ----------------------------------------------------------------------
; DATOS dibujos_6B67: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 160, ficha 7 de la lista 0x6106 (p00:4595); lo leen p00:4531 (10
;   bytes)
;   0x6b67..0x6b71  (10 bytes)
DATA_dibujos_6B67:
	defb 088h,000h,03eh,07fh,07fh,07dh,07dh,07bh,03eh,000h	; 6b67  ..>..}}{>.

; ----------------------------------------------------------------------
; DATOS dibujos_6B71: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 157, ficha 5 de la lista 0x61DD (p00:4595); lo leen p00:4531 (82
;   bytes)
;   0x6b71..0x6bc3  (82 bytes)
DATA_dibujos_6B71:
	defb 0d0h,01fh,0e0h,001h,017h,04bh,03dh,044h,012h,0f8h,007h,060h,0d4h,004h,059h,054h	; 6b71  .....K=D...`..YT
	defb 0feh,043h,043h,067h,097h,08bh,09bh,0b5h,097h,004h,020h,084h,053h,00dh,05ah,03dh	; 6b81  .CCg...... .S.Z=
	defb 01eh,0a0h,080h,04ah,030h,0d4h,0fbh,0dah,0dch,002h,042h,082h,0e1h,0c1h,0a1h,0c1h	; 6b91  ...J0.....B.....
	defb 0d1h,09bh,08dh,085h,093h,09ah,04dh,040h,040h,03fh,03fh,08fh,01fh,006h,0afh,05bh	; 6ba1  ......M@@??....[
	defb 09ch,0aah,0f2h,0ech,0a0h,090h,0fch,0aah,0f4h,0f1h,0c1h,0c1h,0e1h,061h,042h,0a2h	; 6bb1  .............aB.
	defb 082h,000h	; 6bc1

; ----------------------------------------------------------------------
; DATOS dibujos_6BC3: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 177, ficha 7 de la lista 0x61DD (p00:4595); lo leen p00:4531 (65
;   bytes)
;   0x6bc3..0x6c04  (65 bytes)
DATA_dibujos_6BC3:
	defb 005h,000h,086h,01ch,001h,02ah,01ch,046h,021h,009h,000h,088h,011h,004h,0f0h,041h	; 6bc3  .....*.F!......A
	defb 016h,08ah,030h,045h,007h,000h,08ah,01ch,001h,02ah,008h,071h,0adh,00fh,01ch,046h	; 6bd3  ..0E.....*.q...F
	defb 021h,005h,000h,091h,011h,004h,0f0h,041h,034h,004h,06ch,001h,016h,08ah,030h,045h	; 6be3  !......A4.l...0E
	defb 000h,000h,060h,060h,020h,005h,000h,088h,02ah,049h,091h,015h,026h,062h,06ah,000h	; 6bf3  ..`` ...*I..&bj.
	defb 000h	; 6c03

; ----------------------------------------------------------------------
; DATOS dibujos_6C04: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 11, ficha 0 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (42 bytes)
;   0x6c04..0x6c2e  (42 bytes)
DATA_dibujos_6C04:
	defb 081h,0ffh,006h,07fh,002h,000h,006h,0fch,082h,000h,0ffh,006h,07fh,002h,000h,006h	; 6c04  ................
	defb 0fch,002h,0ffh,081h,07fh,004h,040h,084h,07fh,000h,000h,0fch,004h,004h,08ah,0fch	; 6c14  ......@.........
	defb 0ffh,0ffh,008h,008h,01ch,008h,02ah,07fh,06bh,000h	; 6c24  ......*.k.

; ----------------------------------------------------------------------
; DATOS dibujos_6C2E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 29, ficha 3 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (16 bytes)
;   0x6c2e..0x6c3e  (16 bytes)
DATA_dibujos_6C2E:
	defb 082h,0ffh,07fh,004h,040h,084h,07fh,000h,000h,0fch,004h,004h,082h,0fch,0ffh,000h	; 6c2e  ....@...........

; ----------------------------------------------------------------------
; DATOS dibujos_6C3E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 237, ficha 2 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (104 bytes)
;   0x6c3e..0x6ca6  (104 bytes)
DATA_dibujos_6C3E:
	defb 0a0h,0ffh,080h,060h,077h,038h,010h,023h,0a7h,000h,001h,006h,0eeh,01ch,008h,0c4h	; 6c3e  ...`w8.#........
	defb 0e5h,0a7h,023h,010h,038h,077h,060h,080h,0ffh,0e5h,0c4h,008h,01ch,0eeh,006h,001h	; 6c4e  ..#.8w`.........
	defb 000h,008h,055h,090h,034h,018h,02ch,018h,034h,018h,02ch,018h,06ah,058h,0cah,0a6h	; 6c5e  ..U.4.,.4.,.jX..
	defb 05ah,0ach,05ah,04eh,004h,000h,088h,06ah,058h,0cah,0a6h,05ah,0ach,05ah,04eh,004h	; 6c6e  Z.ZN...jX..Z.ZN.
	defb 000h,002h,066h,008h,000h,002h,066h,008h,000h,002h,066h,008h,000h,002h,066h,002h	; 6c7e  ..f...f...f...f.
	defb 0ffh,008h,000h,002h,0ffh,008h,000h,002h,0ffh,008h,000h,002h,0ffh,002h,000h,081h	; 6c8e  ................
	defb 020h,008h,000h,081h,002h,004h,000h,000h	; 6c9e   .......

; ----------------------------------------------------------------------
; DATOS dibujos_6CA6: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 136, ficha 0 de la lista 0x6098 (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x6ca6..0x6cb8  (18 bytes)
DATA_dibujos_6CA6:
	defb 090h,003h,00fh,01fh,03fh,07fh,0ffh,000h,000h,0c0h,0f0h,0f8h,0fch,0feh,080h,000h	; 6ca6  ....?...........
	defb 000h,000h	; 6cb6

; ----------------------------------------------------------------------
; DATOS dibujos_6CB8: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 56, ficha 2 de la lista 0x6098 (p00:4595); lo leen p00:4531 (323
;   bytes)
;   0x6cb8..0x6dfb  (323 bytes)
DATA_dibujos_6CB8:
	defb 0ffh,007h,00fh,028h,0a7h,08fh,028h,0a1h,08eh,06fh,06fh,0ffh,0a7h,0afh,0ffh,0bfh	; 6cb8  ...(..(..oo.....
	defb 01ch,0f6h,0f6h,0ffh,0e5h,0f7h,003h,049h,0b4h,0e0h,0f0h,014h,0e5h,0f1h,0f4h,0e5h	; 6cc8  .......I........
	defb 041h,03fh,07ch,063h,04fh,01fh,03eh,07ch,078h,06bh,087h,0afh,0b7h,077h,03ah,0c9h	; 6cd8  A?|cO.>|xk...w:.
	defb 0f5h,0b2h,0b9h,0bah,0b6h,016h,0cfh,0afh,037h,082h,0dch,0cch,0ach,064h,070h,0f4h	; 6ce8  ........7....dp.
	defb 0f4h,079h,071h,073h,038h,039h,01ch,04ch,046h,0f9h,0f3h,064h,0a8h,0c9h,0a9h,069h	; 6cf8  .yqs89.LF..d...i
	defb 069h,0eah,092h,064h,08ch,01ah,070h,0a2h,006h,063h,021h,030h,010h,008h,034h,07ah	; 6d08  i..d..p..c!0..4z
	defb 0bdh,024h,016h,043h,031h,010h,048h,00ch,067h,0f1h,063h,005h,08eh,0f6h,003h,038h	; 6d18  .$.C1.H.g.c....8
	defb 043h,08eh,0c4h,0a0h,072h,06ch,0c0h,012h,0e8h,0c0h,0feh,0f9h,077h,02fh,09ch,083h	; 6d28  C...rl......w/..
	defb 0b9h,00fh,047h,003h,0d0h,0d8h,0cch,014h,0d8h,0c8h,014h,0e8h,014h,008h,004h,010h	; 6d38  ..G.............
	defb 024h,02ch,04fh,04fh,004h,043h,007h,053h,05ah,028h,0edh,00dh,0e0h,0e8h,0edh,084h	; 6d48  $,OO.C.SZ(......
	defb 078h,0dch,060h,020h,020h,014h,011h,08bh,00dh,004h,04ch,048h,044h,04ch,024h,0a4h	; 6d58  x.`  .....LHDL$.
	defb 0c8h,0cch,061h,061h,014h,074h,076h,022h,0ffh,030h,004h,0b2h,0ffh,0bah,05ch,0ffh	; 6d68  ..aa.tv".0....\.
	defb 00ch,002h,041h,022h,0b7h,09ah,05dh,04fh,026h,00ah,0d2h,092h,012h,01ah,00ch,080h	; 6d78  ..A"..]O&.......
	defb 00ch,01fh,04fh,0b0h,0afh,06eh,01eh,001h,000h,083h,0f8h,0f8h,007h,0f8h,0f7h,0f7h	; 6d88  ..O..n..........
	defb 00fh,06fh,06fh,0ffh,0a7h,0afh,003h,009h,08ah,00dh,01dh,01dh,05dh,058h,051h,045h	; 6d98  .oo.........]XQE
	defb 04ch,0c6h,0e1h,0f5h,0edh,0eeh,05eh,09fh,0afh,059h,013h,064h,0a8h,0c9h,0a9h,069h	; 6da8  L.....^..Y.d...i
	defb 069h,017h,0c9h,0e6h,071h,038h,08eh,0c5h,0e0h,0f1h,062h,004h,08ah,0f7h,002h,038h	; 6db8  i...q8....b....8
	defb 043h,047h,003h,050h,058h,04ch,014h,058h,05ch,08ch,013h,02ch,050h,040h,080h,080h	; 6dc8  CG.PXL.X\..,P@..
	defb 0d0h,05dh,00dh,050h,058h,05dh,04ch,004h,039h,062h,024h,022h,011h,010h,095h,04bh	; 6dd8  .].PX]L.9b$"...K
	defb 04dh,04dh,044h,054h,055h,07dh,039h,001h,030h,006h,083h,008h,085h,009h,02dh,00dh	; 6de8  MMDTU}9.0.....-.
	defb 04ch,04eh,000h	; 6df8

; ----------------------------------------------------------------------
; DATOS dibujos_6DFB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 6 de la lista 0x6098 (p00:4595); lo leen p00:4531 (98
;   bytes)
;   0x6dfb..0x6e5d  (98 bytes)
DATA_dibujos_6DFB:
	defb 0e0h,004h,00eh,019h,032h,005h,00ah,015h,014h,003h,084h,0fbh,01ch,06dh,01ah,0d9h	; 6dfb  ....2........m..
	defb 034h,02bh,028h,057h,040h,05eh,081h,0ffh,000h,0b3h,06ch,063h,0d8h,0c7h,0a0h,09bh	; 6e0b  4+(W@^....lc....
	defb 000h,077h,03bh,0ffh,00bh,00bh,003h,076h,000h,0bdh,0deh,000h,077h,077h,000h,00fh	; 6e1b  .w.....v....ww..
	defb 0ffh,040h,0e8h,09fh,021h,056h,0a1h,05dh,043h,030h,040h,0b0h,0c0h,0d0h,0a0h,090h	; 6e2b  .@..!V.]C0@.....
	defb 040h,0bbh,086h,076h,00dh,0ech,01ah,0f9h,0ffh,030h,0c0h,030h,080h,070h,000h,0b0h	; 6e3b  @..v.....0.0.p..
	defb 000h,077h,03bh,0ffh,00bh,00bh,003h,076h,000h,0bdh,0deh,000h,077h,077h,0ffh,00fh	; 6e4b  .w.....v....ww..
	defb 0ffh,000h	; 6e5b

; ----------------------------------------------------------------------
; DATOS dibujos_6E5D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 189, ficha 8 de la lista 0x6098 (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x6e5d..0x6e6f  (18 bytes)
DATA_dibujos_6E5D:
	defb 002h,000h,08eh,001h,003h,000h,000h,001h,001h,002h,002h,005h,004h,005h,008h,00fh	; 6e5d  ................
	defb 000h,000h	; 6e6d

; ----------------------------------------------------------------------
; DATOS dibujos_6E6F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 1 de la lista 0x60DB (p00:4595); lo leen p00:4531 (361
;   bytes)
;   0x6e6f..0x6fd8  (361 bytes)
DATA_dibujos_6E6F:
	defb 098h,014h,00ah,00ah,00eh,014h,01dh,03ah,03ah,060h,0f0h,0f8h,078h,030h,080h,09ch	; 6e6f  .......::`..x0..
	defb 03eh,00ch,01eh,01eh,01ch,00bh,003h,009h,01ch,003h,000h,0aeh,003h,007h,00eh,01dh	; 6e7f  >...............
	defb 01ah,000h,01fh,0f0h,0cfh,030h,0c0h,006h,01fh,000h,0f0h,00ch,0e2h,01dh,002h,0e1h	; 6e8f  .....0..........
	defb 078h,03ah,034h,064h,074h,065h,055h,062h,052h,03fh,079h,076h,06ch,05ch,05eh,03eh	; 6e9f  x:4dteUbR?yvl\^>
	defb 03fh,0bch,0bah,0dbh,017h,017h,00fh,09fh,07eh,0a0h,003h,050h,004h,028h,0ffh,025h	; 6eaf  ?.......~..P.(.%
	defb 04ah,029h,02dh,014h,016h,00bh,003h,01fh,08fh,043h,0a0h,0d8h,067h,038h,09fh,0bch	; 6ebf  J)-......C..g8..
	defb 0dah,0e4h,0f8h,001h,002h,0fdh,003h,050h,050h,0b0h,0a0h,060h,0a0h,0f0h,0b0h,000h	; 6ecf  .......PP..`....
	defb 001h,0e5h,0fah,01dh,0e6h,0f9h,0feh,0dfh,0a7h,0f1h,0fch,01eh,0e7h,01bh,0e5h,0cfh	; 6edf  ................
	defb 0f0h,0fch,03fh,044h,0b1h,0deh,0efh,00fh,0f3h,01ch,0c3h,03ch,0e3h,04fh,0bfh,0e0h	; 6eef  ..?D.......<.O..
	defb 0b3h,05dh,0bbh,077h,0f7h,0efh,0dfh,000h,0f0h,00ch,0e2h,01dh,002h,0e1h,038h,038h	; 6eff  .].w..........88
	defb 073h,068h,043h,057h,057h,03bh,03ch,09ch,08eh,035h,095h,0d1h,083h,023h,04eh,01eh	; 6f0f  shCWW.<..5...#N.
	defb 08fh,043h,0a0h,0d8h,067h,038h,09fh,03ch,09ah,0e4h,0f8h,001h,002h,0fdh,003h,000h	; 6f1f  .C..g8.<........
	defb 01fh,0f0h,0cfh,030h,0c0h,006h,01ch,000h,0f0h,00ch,0e2h,01dh,002h,0e1h,0c2h,008h	; 6f2f  ...0............
	defb 031h,063h,048h,05bh,057h,047h,023h,030h,0c4h,09ah,03dh,09dh,0d8h,083h,031h,078h	; 6f3f  1cH[WG#0..=...1x
	defb 018h,08ch,043h,0a0h,0d8h,067h,038h,09fh,038h,012h,084h,0f8h,001h,002h,0fdh,003h	; 6f4f  ..C..g8.8.......
	defb 000h,01fh,0f0h,0cfh,030h,0c0h,01bh,007h,000h,0f0h,00ch,0e2h,01dh,002h,081h,0c0h	; 6f5f  ....0...........
	defb 067h,0f3h,0f8h,07bh,037h,087h,09bh,03ch,0cch,09eh,03eh,09ch,0dbh,083h,039h,07ch	; 6f6f  g..{7..<..>...9|
	defb 0a0h,003h,050h,0d4h,028h,0a8h,0a8h,028h,01ch,081h,04dh,0a6h,0d8h,067h,038h,09fh	; 6f7f  ..P.(..(..M..g8.
	defb 03ch,0dbh,0e7h,06ah,019h,002h,0fdh,003h,009h,01dh,01eh,038h,030h,060h,040h,000h	; 6f8f  <..j.......80`@.
	defb 0cfh,0e5h,0f9h,07eh,03fh,05fh,067h,033h,001h,0feh,055h,0aah,055h,0eah,0f3h,0fdh	; 6f9f  ...~?_g3..U.U...
	defb 058h,0b8h,078h,0b8h,074h,0f4h,0eeh,0e6h,010h,010h,018h,00ch,00fh,005h,003h,001h	; 6faf  X.x.t...........
	defb 03ch,01eh,00fh,017h,00bh,0d5h,0bah,077h,0feh,07fh,09eh,0edh,0f3h,0fch,07fh,03fh	; 6fbf  <......w.......?
	defb 053h,0b1h,071h,0e0h,0d0h,030h,0e0h,0c1h,000h	; 6fcf  S.q..0...

; ----------------------------------------------------------------------
; DATOS dibujos_6FD8: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 185, ficha 2 de la lista 0x60DB (p00:4595); lo leen p00:4531 (49
;   bytes)
;   0x6fd8..0x7009  (49 bytes)
DATA_dibujos_6FD8:
	defb 005h,000h,083h,080h,040h,0a0h,004h,000h,08ch,008h,018h,030h,0e0h,040h,080h,080h	; 6fd8  ....@......0.@..
	defb 040h,040h,0a0h,060h,0a0h,005h,000h,083h,018h,024h,0dah,003h,000h,085h,004h,06eh	; 6fe8  @@.`.....$.....n
	defb 0f5h,063h,009h,004h,000h,084h,070h,0bah,0d3h,08ch,005h,000h,083h,010h,026h,028h	; 6ff8  .c....p.......&(
	defb 000h	; 7008

; ----------------------------------------------------------------------
; DATOS dibujos_7009: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 203, ficha 1 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (235 bytes)
;   0x7009..0x70f4  (235 bytes)
DATA_dibujos_7009:
	defb 09ah,080h,040h,000h,000h,013h,00bh,0c3h,0c1h,040h,030h,030h,000h,00ch,08eh,0cfh	; 7009  ..@......@00....
	defb 0e3h,060h,0f0h,0f0h,060h,000h,000h,0e3h,0f7h,003h,003h,003h,070h,002h,000h,003h	; 7019  .`..`.......p...
	defb 007h,002h,00fh,098h,007h,003h,007h,00fh,08bh,0d3h,0d3h,056h,063h,0c1h,03ch,09dh	; 7029  ...........Vc.<.
	defb 0e9h,0e3h,0c0h,0c9h,001h,070h,0f8h,0f8h,00fh,00fh,0c7h,0e0h,003h,0f0h,0c0h,0e0h	; 7039  .....p..........
	defb 01fh,01fh,03fh,03fh,01fh,01fh,00dh,001h,01dh,03fh,03fh,00eh,03eh,040h,03ah,01eh	; 7049  ..??.....??.>@:.
	defb 03fh,03bh,0fch,07ch,079h,0c3h,007h,083h,008h,0ddh,0e9h,0c6h,086h,0cfh,0efh,0c6h	; 7059  ?..|y...........
	defb 007h,007h,003h,011h,038h,010h,000h,000h,0bfh,07eh,07fh,07fh,07eh,01ch,03eh,01ch	; 7069  ....8....~..~.>.
	defb 071h,0f8h,070h,0f8h,070h,000h,003h,001h,0c6h,080h,000h,010h,038h,010h,080h,006h	; 7079  q.p.p.......8...
	defb 000h,083h,060h,0f0h,0feh,006h,000h,002h,060h,083h,010h,03bh,017h,003h,007h,0abh	; 7089  ..`.....`.......
	defb 033h,078h,06fh,09fh,0eeh,0ceh,0d1h,01dh,01fh,07eh,000h,003h,063h,0f0h,0d0h,0c0h	; 7099  3xo......~..c...
	defb 0f0h,0f8h,079h,033h,003h,003h,001h,000h,000h,001h,010h,076h,07fh,07eh,0f6h,07fh	; 70a9  ..y3.......v.~..
	defb 039h,03eh,0ceh,0c4h,0c0h,0cch,09eh,01eh,00ch,000h,001h,003h,003h,081h,001h,003h	; 70b9  9>..............
	defb 000h,09ah,03eh,07eh,0fch,0f4h,0eeh,0c4h,000h,000h,003h,007h,007h,0bfh,07fh,019h	; 70c9  ..>~............
	defb 03ch,03bh,080h,0c0h,0c0h,0c4h,080h,0e0h,0f0h,0fah,01fh,03fh,003h,07eh,08bh,03eh	; 70d9  <..........?.~.>
	defb 00ch,03ch,0f8h,0f0h,0f6h,0efh,0cfh,006h,080h,080h,000h	; 70e9  .<.........

; ----------------------------------------------------------------------
; DATOS dibujos_70F4: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 3 de la lista 0x6106 (p00:4595); lo leen p00:4531 (46
;   bytes)
;   0x70f4..0x7122  (46 bytes)
DATA_dibujos_70F4:
	defb 005h,000h,083h,07dh,079h,007h,004h,000h,0a4h,0e0h,0e8h,09ch,06ch,000h,000h,020h	; 70f4  ...}y.......l..
	defb 070h,038h,01dh,009h,007h,000h,018h,018h,01ch,00ch,00dh,009h,007h,01eh,01fh,01fh	; 7104  p8..............
	defb 002h,02dh,02dh,012h,07fh,0e8h,000h,0f8h,040h,0b4h,0b4h,048h,0feh,000h	; 7114  .--.....@..H..

; ----------------------------------------------------------------------
; DATOS dibujos_7122: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 4 de la lista 0x614A (p00:4595); lo leen p00:4531 (50
;   bytes)
;   0x7122..0x7154  (50 bytes)
DATA_dibujos_7122:
	defb 002h,000h,099h,003h,00eh,001h,0fdh,0fah,000h,000h,070h,0ech,00eh,0e4h,01bh,04ah	; 7122  ..........p....J
	defb 0ech,000h,020h,073h,039h,01dh,00dh,002h,004h,018h,018h,01dh,003h,00dh,092h,002h	; 7132  .. s9...........
	defb 004h,005h,000h,016h,016h,008h,005h,00ch,039h,0c8h,000h,0dah,0dah,004h,0e8h,0cch	; 7142  ........9.......
	defb 027h,000h	; 7152

; ----------------------------------------------------------------------
; DATOS dibujos_7154: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 2 de la lista 0x6061 (p00:4595); lo leen p00:4531 (32
;   bytes)
;   0x7154..0x7174  (32 bytes)
DATA_dibujos_7154:
	defb 004h,000h,09ch,0e0h,0e8h,09ch,06ch,000h,018h,018h,01ch,00ch,00dh,009h,007h,01eh	; 7154  ......l.........
	defb 000h,01fh,002h,02dh,02dh,012h,07fh,0e8h,000h,0f8h,040h,0b4h,0b4h,048h,0feh,000h	; 7164  ...--.....@..H..

; ----------------------------------------------------------------------
; DATOS dibujos_7174: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 139, ficha 5 de la lista 0x6098 (p00:4595); lo leen p00:4531 (26
;   bytes)
;   0x7174..0x718e  (26 bytes)
DATA_dibujos_7174:
	defb 098h,03eh,01ch,000h,03ah,03ah,07dh,004h,075h,000h,01ch,01ch,000h,03eh,07fh,041h	; 7174  .>..::}.u....>.A
	defb 05dh,0feh,004h,05ch,05ch,09eh,0beh,010h,0d7h,000h	; 7184  ]..\\.....

; ----------------------------------------------------------------------
; DATOS dibujos_718E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 2 de la lista 0x619A (p00:4595); lo leen p00:4531 (82
;   bytes)
;   0x718e..0x71e0  (82 bytes)
DATA_dibujos_718E:
	defb 0d0h,0ffh,012h,036h,0ffh,02fh,0ffh,026h,00dh,0ffh,05ah,0dbh,0ffh,03ch,0ffh,05ah	; 718e  ...6./.&..Z..<.Z
	defb 0dbh,0ffh,048h,06ch,0ffh,0f4h,0ffh,064h,080h,012h,03bh,094h,03bh,012h,03bh,095h	; 719e  ..Hl...d........
	defb 03bh,07eh,05eh,041h,049h,049h,041h,0ddh,07eh,048h,0dch,029h,0dch,048h,0dch,0a9h	; 71ae  .~^AIIA.~H.).H..
	defb 0dch,003h,045h,054h,022h,003h,045h,055h,022h,066h,043h,05bh,05bh,001h,05ch,05dh	; 71be  ..ET".EU"fC[[.\]
	defb 05ch,066h,0c2h,0dah,0dah,080h,03ah,0bah,03ah,0c0h,0a2h,02ah,044h,0c0h,0a2h,0aah	; 71ce  \f....:.:..*D...
	defb 044h,000h	; 71de

; ----------------------------------------------------------------------
; DATOS dibujos_71E0: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 161, ficha 3 de la lista 0x619A (p00:4595); lo leen p00:4531 (265
;   bytes)
;   0x71e0..0x72e9  (265 bytes)
DATA_dibujos_71E0:
	defb 089h,029h,0d6h,016h,0f6h,006h,0aeh,0aeh,000h,063h,006h,06bh,082h,063h,0c6h,006h	; 71e0  .).......c.k.c..
	defb 0d6h,088h,0c6h,06bh,06bh,068h,06fh,060h,07fh,07fh,004h,0ffh,081h,008h,005h,0ffh	; 71f0  ...kkho`........
	defb 083h,07fh,0ffh,081h,004h,0ffh,002h,0d6h,09fh,016h,0f6h,006h,0feh,0feh,000h,0d6h	; 7200  ................
	defb 0d7h,0d7h,0d0h,0dfh,0c0h,07fh,0ffh,06bh,0ebh,0ebh,00bh,0fbh,003h,0feh,0ffh,0ffh	; 7210  .......k........
	defb 07fh,07fh,060h,06fh,068h,06bh,06bh,000h,003h,0ffh,081h,008h,007h,0ffh,09fh,081h	; 7220  ..`ohkk.........
	defb 0ffh,07fh,0ffh,000h,0feh,0feh,006h,0f6h,016h,0d6h,0d6h,0ffh,07fh,0c0h,0dfh,0d0h	; 7230  ................
	defb 0d7h,0d7h,0d6h,0ffh,0feh,003h,0fbh,00bh,0ebh,0ebh,06bh,0ffh,0e7h,024h,003h,0a5h	; 7240  ..........k..$..
	defb 089h,024h,0e7h,0ffh,0ebh,0e3h,0ebh,0ebh,0e3h,0ebh,011h,0ffh,008h,05ah,003h,034h	; 7250  .$...........Z.4
	defb 086h,03ch,034h,03ch,034h,04ah,0c6h,006h,0d6h,082h,0c6h,063h,006h,06bh,0a2h,063h	; 7260  .<4<4J.....c.k.c
	defb 05ah,042h,07eh,042h,07eh,042h,05ah,05ah,03ch,07eh,03ch,042h,042h,03ch,07eh,03ch	; 7270  ZB~B~BZZ<~<BB<~<
	defb 099h,042h,024h,099h,099h,024h,042h,099h,081h,07eh,04bh,0cah,03ch,081h,014h,0e8h	; 7280  .B$..$B..~K.<...
	defb 0ffh,003h,05eh,088h,081h,05eh,05eh,042h,042h,05eh,05eh,081h,003h,05eh,0c9h,000h	; 7290  ..^..^^BB^^..^..
	defb 05ah,024h,03ch,024h,066h,024h,03ch,066h,00ch,060h,00ch,06ch,04ch,04fh,047h,065h	; 72a0  Z$<$f$<f.`.lLOGe
	defb 0ffh,060h,07bh,060h,06fh,068h,06bh,094h,0ffh,032h,041h,0ffh,008h,0ffh,084h,009h	; 72b0  .`{`ohk..2A.....
	defb 0ffh,081h,0dfh,004h,0b5h,004h,07bh,028h,000h,0aeh,0aeh,006h,0f6h,016h,0d6h,029h	; 72c0  ......{(.......)
	defb 094h,06bh,068h,06fh,060h,07bh,060h,0ffh,009h,084h,0ffh,008h,0ffh,041h,032h,0ffh	; 72d0  .kho`{`......A2.
	defb 028h,07bh,004h,0b5h,004h,0dfh,081h,0ffh,000h	; 72e0  ({.......

; ----------------------------------------------------------------------
; DATOS dibujos_72E9: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x6106 (p00:4595); lo leen p00:4531 (380
;   bytes)
;   0x72e9..0x7465  (380 bytes)
DATA_dibujos_72E9:
	defb 0afh,03fh,07fh,07bh,027h,01fh,0feh,0feh,000h,0c2h,037h,07ah,07fh,07eh,0feh,0feh	; 72e9  .?.{'.....7z.~..
	defb 000h,001h,0c6h,09fh,07eh,0fch,0d0h,03eh,0ffh,0e6h,0f3h,02dh,09eh,0dfh,05fh,0eeh	; 72f9  ....~..>...-.._.
	defb 070h,000h,000h,005h,01eh,03eh,08eh,057h,000h,0b0h,03eh,0e3h,01eh,063h,06dh,069h	; 7309  p....>.W..>..cmi
	defb 003h,000h,0a2h,040h,078h,0eeh,07ah,08eh,000h,07eh,0fdh,0ffh,0fbh,07fh,09fh,0dfh	; 7319  ...@x.z..~......
	defb 0ffh,06ch,0cbh,0e7h,0dah,0d4h,0a6h,0cdh,0ffh,085h,07fh,0ffh,0eeh,061h,0feh,0dfh	; 7329  .l...........a..
	defb 0ffh,02eh,04dh,02dh,0adh,004h,06dh,082h,007h,049h,006h,0b6h,08ch,0deh,09bh,0dbh	; 7339  ..M-..m..I......
	defb 0cah,0c2h,042h,051h,050h,02eh,04dh,02dh,02dh,004h,06dh,0b1h,0feh,024h,0dbh,0dbh	; 7349  ..BQP.M--.m..$..
	defb 0cbh,05ah,05bh,05ah,005h,09ah,06ch,074h,0a2h,04ch,01eh,0b6h,0efh,0f6h,076h,04fh	; 7359  .Z[Z..lt.L....vO
	defb 0f4h,07bh,06dh,07bh,0fdh,06dh,0efh,0edh,0efh,01eh,0dah,0feh,000h,075h,06ah,07dh	; 7369  .{m{.m.......uj}
	defb 0c7h,03bh,0f7h,0bfh,000h,0eeh,056h,0dah,0cdh,0efh,0cah,0f6h,0b0h,007h,0b6h,081h	; 7379  ......V.........
	defb 00dh,007h,06dh,008h,0b6h,008h,06dh,0cch,0b6h,073h,02dh,09eh,0a5h,05fh,00fh,0f6h	; 7389  ..m...m..s-.._..
	defb 061h,0fah,064h,07ch,00eh,061h,06dh,06dh,076h,09ch,06ah,0a6h,0ceh,0b2h,0fch,0feh	; 7399  a.d|.ammv.j.....
	defb 0f0h,070h,078h,047h,0ffh,07bh,0f7h,0dfh,00fh,00eh,068h,068h,0bfh,09fh,0dfh,0e2h	; 73a9  .pxG.{....hh....
	defb 0f6h,00fh,05fh,0a5h,09eh,02dh,073h,0b6h,0ffh,070h,0c2h,09eh,077h,05eh,071h,000h	; 73b9  .._..-s..p..w^q.
	defb 00dh,07ch,0c7h,078h,0c6h,0b6h,096h,000h,07eh,0fch,0fbh,0fbh,07dh,09dh,0deh,000h	; 73c9  .|.x....~...}...
	defb 09fh,0bdh,0bfh,0bfh,004h,0ffh,084h,00eh,037h,07eh,0b9h,004h,0ffh,084h,027h,01dh	; 73d9  ........7~....'.
	defb 018h,0f7h,004h,000h,084h,064h,0fbh,024h,0dfh,004h,0ffh,084h,0cfh,0d7h,079h,0f7h	; 73e9  .....d.$......y.
	defb 004h,0ffh,084h,0feh,0dfh,0ebh,074h,004h,0ffh,084h,0b7h,01ah,081h,07fh,004h,000h	; 73f9  ......t.........
	defb 084h,0fah,085h,0ddh,038h,004h,000h,089h,0c0h,040h,0c0h,0c0h,09eh,07fh,0fch,0feh	; 7409  ....8....@......
	defb 0d0h,003h,0d8h,084h,058h,088h,0f6h,0f8h,005h,0ffh,082h,0d7h,06eh,006h,000h,0bbh	; 7419  ....X.......n...
	defb 0f0h,0f8h,0ffh,03fh,02dh,01eh,01eh,00eh,01eh,01ch,01eh,01ah,01ch,01eh,09eh,01eh	; 7429  ...?-...........
	defb 09ah,0bbh,037h,000h,0c0h,018h,0c6h,0d8h,0dah,05ah,0dah,05fh,0b6h,066h,066h,020h	; 7439  ..7......Z._.ff
	defb 0dfh,06fh,064h,0ffh,099h,066h,066h,0ffh,0dfh,0ffh,0f7h,0ffh,099h,066h,066h,020h	; 7449  .od..ff......ff
	defb 0dfh,010h,0e7h,0ffh,099h,066h,066h,020h,0dfh,06fh,0f6h,000h	; 7459  .....ff .o..

; ----------------------------------------------------------------------
; DATOS dibujos_7465: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 194, ficha 2 de la lista 0x6106 (p00:4595); lo leen p00:4531 (33
;   bytes)
;   0x7465..0x7486  (33 bytes)
DATA_dibujos_7465:
	defb 006h,000h,087h,006h,02dh,000h,000h,001h,000h,001h,003h,003h,002h,000h,083h,080h	; 7465  ....-...........
	defb 000h,080h,003h,0c0h,002h,003h,002h,001h,004h,000h,002h,0c0h,002h,080h,004h,000h	; 7475  ................
	defb 000h	; 7485

; ----------------------------------------------------------------------
; DATOS dibujos_7486: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x6143 (p00:4595); lo leen p00:4531 (855
;   bytes)
;   0x7486..0x77dd  (855 bytes)
DATA_dibujos_7486:
	defb 084h,0feh,0ffh,0edh,0efh,004h,000h,084h,086h,071h,0e3h,00eh,004h,000h,0ffh,024h	; 7486  .........q.....$
	defb 01ch,00eh,00fh,017h,00fh,04dh,087h,008h,01bh,017h,026h,0a8h,079h,09ah,04eh,000h	; 7496  .....M....&.y.N.
	defb 000h,008h,000h,020h,010h,010h,030h,023h,096h,0a7h,067h,03bh,01fh,00fh,05bh,088h	; 74a6  ... ..0#..g...[.
	defb 0d0h,0f4h,061h,0f6h,0ech,0fch,0fah,01fh,00fh,01fh,01bh,06bh,087h,017h,02fh,01fh	; 74b6  ..a........k../.
	defb 04fh,03fh,01bh,01fh,00fh,027h,057h,000h,008h,000h,010h,030h,020h,080h,000h,040h	; 74c6  O?...'W....0 ..@
	defb 020h,010h,018h,00eh,007h,003h,041h,012h,013h,020h,06ah,06dh,0f4h,07eh,03fh,0c0h	; 74d6   .....A.. jm.~?.
	defb 0d0h,0f8h,0ech,0fch,0eeh,0feh,0ffh,040h,061h,038h,01ch,00fh,015h,002h,08dh,0d4h	; 74e6  .......@a8......
	defb 0a8h,0f8h,0e1h,0c7h,08ch,018h,020h,0f2h,060h,060h,0e0h,0e4h,0c0h,0c8h,090h,098h	; 74f6  ...... .``......
	defb 090h,0b4h,021h,0e5h,0edh,0e1h,0f9h,068h,0bbh,037h,0f6h,0e8h,0f9h,0bah,082h,0eeh	; 7506  ..!....h.7......
	defb 01bh,003h,007h,089h,009h,000h,002h,000h,077h,065h,02ah,018h,001h,003h,000h,090h	; 7516  ........we*.....
	defb 0feh,0f6h,0dch,0f8h,0e1h,087h,00ch,000h,000h,040h,000h,003h,003h,00fh,027h,057h	; 7526  .........@....'W
	defb 003h,000h,0ffh,008h,011h,00ah,005h,051h,00fh,05bh,04fh,06fh,0efh,0f7h,001h,0ffh	; 7536  .......Q.[Oo....
	defb 0f0h,0f4h,0c4h,0cch,0b9h,0f0h,0f2h,0e0h,0d0h,0e2h,0c1h,090h,080h,082h,044h,0c4h	; 7546  ..............D.
	defb 072h,0dch,0c0h,0e4h,0cdh,0e3h,0bbh,0d4h,084h,084h,0f6h,0d6h,02eh,0b4h,030h,034h	; 7556  r.............04
	defb 043h,021h,033h,019h,003h,0a6h,03fh,05fh,047h,063h,031h,000h,001h,007h,074h,09fh	; 7566  C!3...?_Gc1...t.
	defb 004h,0ffh,008h,070h,0e0h,0c0h,000h,000h,014h,003h,080h,050h,0e0h,0f0h,07eh,0e6h	; 7576  ...p.......P..~.
	defb 000h,000h,0a0h,010h,008h,002h,001h,080h,03fh,01fh,03fh,000h,07fh,038h,031h,07eh	; 7586  ........?.?..81~
	defb 0f8h,090h,060h,081h,048h,03ch,0dfh,0bfh,01ch,0bdh,09eh,0aeh,07fh,020h,0bch,0aeh	; 7596  ..`.H<....... ..
	defb 05fh,04fh,01dh,037h,00fh,057h,00fh,063h,00ah,0b5h,09fh,0aeh,07fh,024h,08ah,0ffh	; 75a6  _O.7.W.c.....$..
	defb 0bfh,06fh,0ffh,0ddh,060h,0adh,033h,0ffh,0f7h,0e8h,010h,074h,0ffh,0feh,0edh,0ffh	; 75b6  .o..`.3....t....
	defb 0c5h,0e3h,0b1h,09eh,0aeh,07fh,02ah,0feh,0a0h,018h,007h,0bfh,062h,025h,067h,073h	; 75c6  ......*.....b%gs
	defb 03bh,070h,03ch,03ch,01ch,03ch,01eh,01eh,083h,017h,021h,02ch,0f3h,07fh,001h,001h	; 75d6  .p<<.<....!,....
	defb 003h,001h,022h,022h,062h,025h,067h,073h,03bh,0feh,0feh,0fch,0feh,0fdh,0ffh,0feh	; 75e6  ..""b%gs........
	defb 0feh,00dh,007h,003h,00bh,00fh,003h,03fh,037h,0f8h,0f8h,0f2h,0f4h,0f6h,0feh,0fah	; 75f6  .......?7.......
	defb 0fch,0f5h,0f6h,0f9h,0feh,0fdh,079h,0efh,0bfh,007h,017h,03fh,00fh,03fh,03fh,03eh	; 7606  ......y....?.??>
	defb 07eh,001h,028h,03ch,058h,078h,0f8h,0f0h,0e1h,000h,00bh,00fh,01bh,076h,0f8h,0f8h	; 7616  ~.(<Xx.......v..
	defb 0d0h,027h,0ffh,0deh,078h,0deh,0e8h,0d8h,090h,05fh,04fh,01dh,037h,00fh,057h,00fh	; 7626  .'..x...._O.7.W.
	defb 093h,0fch,0ffh,0f8h,0d1h,0b0h,0f2h,0f7h,0fch,0fch,034h,029h,011h,05ch,04eh,03dh	; 7636  ..........4).\N=
	defb 016h,00eh,060h,0c0h,0a1h,089h,043h,0b7h,0dfh,0ffh,080h,0c1h,0c3h,0e9h,0f7h,07bh	; 7646  ..`...C........{
	defb 06fh,03fh,00bh,007h,007h,023h,00bh,003h,01dh,003h,0bch,0b0h,0f8h,0b8h,062h,0e0h	; 7656  o?...#........b.
	defb 0c4h,0cch,0e8h,0fch,0f8h,0f0h,0e0h,0e2h,0e2h,0a4h,017h,003h,003h,013h,001h,07fh	; 7666  ................
	defb 005h,081h,042h,046h,02bh,005h,07fh,03fh,02fh,083h,0f0h,0a0h,0a4h,0d0h,07dh,0eah	; 7676  ..BF+..?/.....}.
	defb 0eah,09ah,0c3h,037h,0dfh,025h,04eh,004h,03dh,0dfh,09eh,0c5h,001h,08bh,0c7h,09bh	; 7686  ...7.%N.=.......
	defb 045h,03fh,0beh,03bh,0ceh,025h,04eh,004h,04dh,0bfh,0f2h,0f2h,0fch,0fdh,0fah,0c0h	; 7696  E?...%N.M.......
	defb 0f3h,089h,020h,082h,07ch,068h,0f1h,0d6h,004h,088h,03ch,0b9h,059h,0dah,0beh,0d9h	; 76a6  .. .|h....<.Y...
	defb 0b0h,0a0h,0ffh,03ch,0bfh,05bh,0dah,0beh,026h,0f3h,0bfh,000h,007h,060h,07fh,01fh	; 76b6  ...<.[..&....`..
	defb 001h,0d7h,018h,07ch,0dch,0feh,008h,002h,0a3h,0f1h,078h,03fh,004h,0ffh,018h,030h	; 76c6  ...|......x?...0
	defb 070h,040h,0c0h,001h,002h,008h,001h,005h,017h,01bh,06fh,0f0h,0e8h,0feh,0fbh,010h	; 76d6  p@........o.....
	defb 012h,020h,041h,00fh,087h,07bh,0afh,09fh,01fh,080h,020h,038h,08dh,079h,075h,0feh	; 76e6  . A..{.... 8.yu.
	defb 004h,00dh,005h,03fh,033h,0cah,027h,04eh,004h,03dh,0dfh,06bh,0c7h,088h,051h,072h	; 76f6  ...?3.'N.=.k..Qr
	defb 0dfh,08dh,0efh,042h,046h,02bh,005h,07fh,03fh,03fh,003h,009h,02bh,01fh,03fh,01bh	; 7706  ...BF+..??..+.?.
	defb 0bfh,00eh,0ffh,05fh,04fh,01dh,037h,00fh,057h,00fh,019h,0fah,0f2h,0b8h,0ech,0fch	; 7716  ..._O.7.W.......
	defb 0c0h,0f0h,098h,090h,0d4h,0f8h,0fch,0d8h,0ffh,070h,003h,000h,082h,090h,020h,0a9h	; 7726  .........p.... .
	defb 0f9h,041h,0ffh,0b0h,0d4h,0fah,010h,0f9h,0f7h,0b0h,0e0h,040h,018h,027h,003h,07fh	; 7736  .A.........@.'..
	defb 03fh,003h,013h,00fh,068h,090h,040h,0a0h,0c0h,0feh,0f6h,0f6h,058h,0dbh,074h,0bdh	; 7746  ?...h.@.....X.t.
	defb 018h,00ch,044h,001h,014h,06fh,007h,03fh,001h,07fh,005h,081h,001h,008h,001h,00fh	; 7756  ..D..o.?........
	defb 03fh,01bh,00fh,01bh,080h,003h,03dh,01dh,021h,067h,073h,03bh,001h,0c0h,0bch,0b8h	; 7766  ?.....=.!gs.....
	defb 084h,0e6h,0ceh,0dch,0f8h,005h,0e0h,000h,0f0h,0fch,080h,0dah,0fah,0fdh,0f8h,0e2h	; 7776  ................
	defb 0dch,0e8h,0c4h,004h,01fh,00fh,027h,057h,077h,065h,02ah,018h,03fh,03fh,001h,05bh	; 7786  ......'Wwe*.??.[
	defb 009h,02ah,001h,03fh,00fh,003h,017h,000h,0bfh,07fh,014h,085h,0f6h,0feh,0bah,0a0h	; 7796  .*.?............
	defb 0f2h,0c5h,0f6h,028h,0eah,0f0h,060h,0ffh,090h,0d6h,0e0h,0fch,0b1h,0ffh,081h,020h	; 77a6  ...(..`........
	defb 0deh,0e8h,086h,010h,000h,0e0h,080h,040h,0c0h,004h,000h,083h,01bh,0bfh,00eh,005h	; 77b6  .......@........
	defb 000h,084h,03ah,001h,00eh,01fh,004h,000h,084h,0fch,030h,0f5h,048h,004h,000h,084h	; 77c6  ..:.......0.H...
	defb 0e0h,082h,010h,001h,004h,000h,000h	; 77d6

; ----------------------------------------------------------------------
; DATOS ceros_77DD: 3 ceros entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (3 bytes)
;   0x77dd..0x77e0  (3 bytes)
DATA_ceros_77DD:
	defb 000h,000h,000h	; 77dd

; ----------------------------------------------------------------------
; DATOS dibujos_77E0: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 121, ficha 3 de la lista 0x60DB (p00:4595); lo leen p00:4531 (147
;   bytes)
;   0x77e0..0x7873  (147 bytes)
DATA_dibujos_77E0:
	defb 0ffh,000h,003h,01ch,023h,04fh,0bfh,000h,000h,0e5h,0fah,01dh,0e6h,0f9h,0feh,000h	; 77e0  ....#O..........
	defb 000h,0f1h,0fch,01eh,0e7h,01bh,0e5h,000h,000h,0fch,03fh,044h,0b1h,0deh,0efh,000h	; 77f0  ..........?D....
	defb 000h,01ch,0c3h,03ch,0e3h,04fh,0bfh,000h,000h,0e0h,0f8h,01ch,0e6h,0f9h,0feh,0ffh	; 7800  ...<.O..........
	defb 000h,000h,003h,00ch,003h,01ch,023h,04fh,0bfh,000h,003h,0e5h,0fah,01dh,0e6h,0f9h	; 7810  ......#O........
	defb 0feh,0dfh,0a7h,0f1h,0fch,01eh,0e7h,01bh,0e5h,0cfh,0f0h,0fch,03fh,044h,0b1h,0deh	; 7820  ............?D..
	defb 0efh,00fh,0f3h,01ch,0c3h,03ch,0e3h,04fh,0bfh,080h,0a0h,0f0h,0fch,01eh,0e6h,01bh	; 7830  .....<.O........
	defb 0e5h,006h,087h,007h,04bh,00ch,04fh,067h,031h,073h,039h,0cah,0f3h,079h,09ch,0e6h	; 7840  ....K.Og1s9..y..
	defb 0fbh,0e0h,0f8h,07ch,09eh,0e2h,0fch,07eh,09fh,00dh,01dh,05bh,0dbh,0d3h,0d6h,0ech	; 7850  ...|...~...[....
	defb 091h,0e9h,060h,040h,044h,010h,031h,038h,0b8h,0c8h,00ch,03eh,073h,0e0h,0c6h,0deh	; 7860  ..`@D.18...>s...
	defb 04fh,007h,000h	; 7870

; ----------------------------------------------------------------------
; DATOS dibujos_7873: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 4 de la lista 0x60DB (p00:4595); lo leen p00:4531 (66
;   bytes)
;   0x7873..0x78b5  (66 bytes)
DATA_dibujos_7873:
	defb 0c0h,000h,010h,080h,013h,027h,036h,038h,01ch,004h,038h,060h,0c3h,0ceh,05eh,03dh	; 7873  .....'68..8`..^=
	defb 031h,0e0h,063h,01fh,03fh,03eh,0b8h,0d3h,0c7h,000h,0c0h,0f1h,0dch,006h,082h,0d4h	; 7883  1.c.?>..........
	defb 0c0h,041h,0c6h,0ceh,06fh,087h,0c3h,038h,0f1h,0e7h,077h,093h,060h,0beh,0dfh,060h	; 7893  .A..o..8..w.`..`
	defb 087h,0c3h,08fh,01eh,03dh,03bh,0b8h,0cfh,030h,0eeh,09eh,03ch,0f0h,08ch,03eh,00fh	; 78a3  ....=...0..<..>.
	defb 0f3h,000h	; 78b3

; ----------------------------------------------------------------------
; DATOS dibujos_78B5: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 175, ficha 5 de la lista 0x60DB (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x78b5..0x78d7  (34 bytes)
DATA_dibujos_78B5:
	defb 0a0h,060h,0b0h,0f6h,06bh,00fh,066h,069h,006h,008h,034h,05ah,07ah,0b2h,044h,03bh	; 78b5  .`..k.fi..4Zz.D.
	defb 003h,03ch,042h,099h,0adh,0bdh,099h,042h,03ch,006h,06dh,06fh,006h,058h,0b4h,0bch	; 78c5  .<B....B<.mo.X..
	defb 058h,000h	; 78d5

; ----------------------------------------------------------------------
; DATOS dibujos_78D7: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 179, ficha 6 de la lista 0x60DB (p00:4595); lo leen p00:4531 (26
;   bytes)
;   0x78d7..0x78f1  (26 bytes)
DATA_dibujos_78D7:
	defb 098h,000h,046h,00dh,084h,038h,07ch,046h,001h,000h,000h,020h,0ffh,002h,010h,020h	; 78d7  ..F..8|F... ...
	defb 0a0h,008h,018h,03ch,03ch,01dh,01dh,009h,002h,000h	; 78e7  ...<<.....

; ----------------------------------------------------------------------
; DATOS ceros_78F1: 5 ceros entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (5 bytes)
;   0x78f1..0x78f6  (5 bytes)
DATA_ceros_78F1:
	defb 000h,000h,000h,000h,000h	; 78f1

; ----------------------------------------------------------------------
; DATOS dibujos_78F6: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 3 de la lista 0x616F (p00:4595); lo leen p00:4531 (306
;   bytes)
;   0x78f6..0x7a28  (306 bytes)
DATA_dibujos_78F6:
	defb 0c3h,020h,073h,057h,0d5h,0b4h,0ech,0d9h,05fh,09fh,00fh,09fh,099h,0b9h,0b1h,0bbh	; 78f6  . sW...._.......
	defb 0bfh,09eh,01ch,0beh,0b2h,0a2h,0b6h,0beh,09ch,07eh,03ch,07eh,0eeh,0c6h,0eeh,0feh	; 7906  .........~<~....
	defb 07ch,00fh,0e0h,030h,067h,00fh,01eh,03ch,07eh,00fh,070h,07ch,07eh,03eh,07ch,039h	; 7916  |..0g..<~.p|~>|9
	defb 07dh,003h,0cfh,0efh,0e7h,077h,033h,090h,0b9h,0ffh,0ceh,09eh,0bfh,01ch,09eh,00ch	; 7926  }....w3.........
	defb 0deh,06ch,0e6h,026h,005h,000h,0f5h,03ch,01eh,03fh,03ch,070h,0fdh,01ch,088h,098h	; 7936  .l.&...<.?<p....
	defb 0fch,0e2h,019h,07ah,037h,0b3h,090h,079h,07bh,03eh,05dh,030h,066h,017h,03bh,07ch	; 7946  ...z7..y{>]0f..|
	defb 000h,000h,066h,077h,07fh,03ch,080h,07fh,0ceh,09eh,0bfh,01ch,09eh,00ch,03fh,008h	; 7956  ..fw.<........?.
	defb 01ch,03ch,098h,07eh,03ch,07fh,01ch,0c2h,0e1h,0d6h,018h,010h,024h,00ah,004h,000h	; 7966  .<.~<.......$...
	defb 004h,000h,040h,0fah,0ech,0b0h,000h,004h,002h,010h,040h,060h,088h,099h,049h,0fbh	; 7976  ..@.......@`..I.
	defb 0f8h,0f6h,070h,0f0h,007h,03bh,09bh,0bch,01ch,009h,01fh,067h,063h,035h,096h,0e6h	; 7986  ..p........gc5..
	defb 0feh,0feh,0c4h,00eh,0eeh,0e6h,042h,01fh,0f8h,031h,00fh,023h,01fh,007h,0f7h,001h	; 7996  ......B..1.#....
	defb 06dh,0deh,03eh,07ch,038h,0fch,081h,06ch,0e6h,076h,070h,020h,003h,000h,08bh,0ddh	; 79a6  m.>|8..l.vp ....
	defb 0cch,000h,000h,030h,030h,002h,000h,007h,01fh,07fh,005h,003h,084h,01eh,03fh,09fh	; 79b6  ...00.........?.
	defb 0ceh,004h,000h,094h,0e4h,0ech,087h,0fbh,0feh,03fh,03fh,007h,002h,0cch,060h,017h	; 79c6  .........??...`.
	defb 07fh,00fh,03ch,0feh,070h,0f8h,0e3h,08dh,005h,000h,083h,067h,033h,092h,004h,000h	; 79d6  ..<.p......g3...
	defb 0c0h,003h,006h,018h,031h,0e2h,022h,044h,088h,08fh,0c3h,043h,08eh,032h,044h,049h	; 79e6  ....1."D...C.2DI
	defb 088h,021h,0a1h,0a2h,0d4h,054h,068h,078h,03ch,00ah,037h,06ch,039h,09eh,05ch,038h	; 79f6  .!...Thx<.7l9.\8
	defb 038h,008h,030h,0a0h,062h,076h,03ch,0f8h,078h,012h,022h,021h,041h,040h,090h,08ah	; 7a06  8.0.bv<.x."!A@..
	defb 089h,002h,00ch,010h,060h,0c0h,0c8h,0d0h,0f2h,00ah,037h,06ch,039h,09eh,05ch,038h	; 7a16  ....`.....7l9.\8
	defb 038h,000h	; 7a26

; ----------------------------------------------------------------------
; DATOS dibujos_7A28: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 83, ficha 4 de la lista 0x616F (p00:4595); lo leen p00:4531 (194
;   bytes)
;   0x7a28..0x7aea  (194 bytes)
DATA_dibujos_7A28:
	defb 08ah,0f0h,082h,02ch,012h,051h,088h,008h,014h,00dh,01dh,003h,03eh,0f5h,09ch,03fh	; 7a28  ...,.Q......>..?
	defb 01ch,0ech,0d6h,0b6h,07ah,0fah,0f8h,070h,07ch,080h,061h,03ah,00eh,007h,06fh,021h	; 7a38  ....z..p|.a:..o!
	defb 041h,09ch,008h,008h,09ch,0feh,0c2h,0e1h,0ech,090h,0a0h,0a0h,0e0h,071h,052h,052h	; 7a48  A............qRR
	defb 094h,001h,032h,070h,064h,01dh,007h,033h,011h,03ah,094h,058h,038h,069h,04ah,08ch	; 7a58  ..2pd..3.:.X8iJ.
	defb 098h,01fh,035h,035h,021h,046h,0eeh,094h,061h,0b6h,066h,06eh,00ch,0a5h,073h,0e7h	; 7a68  ..55!F..a.fn..s.
	defb 0c2h,030h,07eh,035h,01bh,06dh,06bh,035h,096h,080h,0b6h,07bh,07ch,03eh,01ch,03fh	; 7a78  .0~5.mk5...{|>.?
	defb 081h,0ffh,01ch,03eh,03fh,01eh,0a1h,011h,052h,070h,0f8h,0e3h,0adh,070h,038h,0fch	; 7a88  ...>?...Rp...p8.
	defb 0f0h,0fch,07eh,032h,090h,0efh,078h,082h,026h,0dch,033h,0d8h,006h,005h,0d8h,033h	; 7a98  ..~2..x.&.3....3
	defb 0dch,00dh,01dh,003h,03eh,0bbh,09ch,03fh,01ch,0ech,0d6h,0b6h,07ah,0fah,0f8h,070h	; 7aa8  ....>..?....z..p
	defb 07ch,080h,061h,03ah,00eh,007h,06fh,021h,041h,09ch,008h,008h,09ch,0feh,0c2h,0e1h	; 7ab8  |.a:..o!A.......
	defb 0ech,044h,03ah,07eh,05ch,05ch,06dh,0b2h,02ch,044h,03ah,07eh,01ch,01ch,06dh,0b2h	; 7ac8  .D:~\\m.,D:~..m.
	defb 02ch,044h,03ah,07eh,05ch,05ch,06dh,0b2h,02ch,044h,03ah,07eh,01ch,01ch,06dh,0b2h	; 7ad8  ,D:~\\m.,D:~..m.
	defb 02ch,000h	; 7ae8

; ----------------------------------------------------------------------
; DATOS dibujos_7AEA: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 169, ficha 5 de la lista 0x616F (p00:4595); lo leen p00:4531 (232
;   bytes)
;   0x7aea..0x7bd2  (232 bytes)
DATA_dibujos_7AEA:
	defb 0bdh,0a8h,0c2h,0e7h,0e2h,0e8h,0e0h,0e8h,0e1h,023h,019h,082h,031h,021h,000h,080h	; 7aea  .........#..1!..
	defb 008h,0e1h,0d8h,0ddh,088h,0a0h,031h,040h,008h,0ddh,0cch,062h,06eh,006h,010h,039h	; 7afa  ......1@...bn..9
	defb 010h,010h,000h,001h,030h,072h,020h,001h,000h,008h,040h,000h,000h,042h,000h,080h	; 7b0a  ....0r ...@..B..
	defb 000h,0c0h,020h,010h,008h,008h,004h,004h,002h,001h,002h,004h,004h,008h,003h,000h	; 7b1a  .. .............
	defb 002h,080h,092h,090h,081h,020h,004h,020h,020h,000h,0e0h,0d8h,0f4h,088h,0d8h,0ech	; 7b2a  ..... .  .......
	defb 0dch,000h,0c0h,0c0h,001h,004h,000h,0bch,021h,001h,081h,019h,014h,058h,005h,096h	; 7b3a  ........!....X..
	defb 082h,007h,042h,000h,094h,0c6h,0f1h,0fch,004h,0e1h,0d8h,0f4h,088h,0d8h,0ech,0dch	; 7b4a  ..B.............
	defb 010h,000h,001h,030h,072h,020h,005h,000h,008h,080h,000h,021h,031h,082h,011h,003h	; 7b5a  ...0r .....!1...
	defb 037h,04fh,01fh,062h,0c1h,0c8h,0d0h,0f2h,000h,007h,01bh,02fh,011h,01bh,037h,03bh	; 7b6a  7O.b......./..7.
	defb 000h,003h,003h,080h,004h,000h,092h,088h,049h,0e3h,046h,01fh,003h,00ch,010h,00ch	; 7b7a  ........I.F.....
	defb 075h,075h,021h,000h,008h,000h,000h,0ddh,0cch,009h,000h,002h,060h,0aeh,023h,007h	; 7b8a  uu!.........`.#.
	defb 003h,006h,004h,010h,060h,0c0h,0c8h,0d0h,0f2h,008h,030h,0a0h,062h,076h,03ch,0f8h	; 7b9a  ....`.....0.bv<.
	defb 078h,00ah,037h,06ch,039h,09eh,05ch,038h,038h,003h,032h,030h,002h,002h,001h,060h	; 7baa  x.7l9.\88.20...`
	defb 00fh,000h,002h,000h,060h,060h,004h,000h,003h,000h,000h,020h,005h,000h,088h,003h	; 7bba  ....``..... ....
	defb 008h,004h,003h,043h,0cfh,01fh,07fh,000h	; 7bca  ...C....

; ----------------------------------------------------------------------
; DATOS dibujos_7BD2: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 9, ficha 2 de la lista 0x616F (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x7bd2..0x7be4  (18 bytes)
DATA_dibujos_7BD2:
	defb 090h,000h,087h,05eh,03dh,07bh,0fah,089h,04ch,000h,080h,07dh,080h,060h,0f0h,0cdh	; 7bd2  ...^={..L..}.`..
	defb 0fah,000h	; 7be2

; ----------------------------------------------------------------------
; DATOS ceros_7BE4: 1 cero entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (1 bytes)
;   0x7be4..0x7be5  (1 bytes)
DATA_ceros_7BE4:
	defb 000h	; 7be4

; ----------------------------------------------------------------------
; DATOS dibujos_7BE5: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 17, ficha 8 de la lista 0x619A (p00:4595); lo leen p00:4531 (79
;   bytes)
;   0x7be5..0x7c34  (79 bytes)
DATA_dibujos_7BE5:
	defb 08ah,008h,007h,000h,007h,01fh,07fh,000h,03ah,000h,000h,004h,06bh,002h,077h,08bh	; 7be5  ........:...k.w.
	defb 05ah,081h,05ah,0c3h,03ch,042h,081h,03ch,080h,036h,06ch,005h,026h,0b0h,01fh,07fh	; 7bf5  Z.Z.<B.<.6l.&...
	defb 000h,03ah,000h,087h,05eh,03dh,06bh,06bh,077h,077h,05ah,081h,05ah,0c3h,080h,07dh	; 7c05  .:..^=kkwwZ.Z..}
	defb 080h,000h,080h,036h,06ch,000h,006h,00fh,0b3h,05fh,05fh,0b3h,00fh,006h,07bh,0fah	; 7c15  ...6l....__...{.
	defb 089h,04ch,04ch,089h,0fah,07bh,03ch,042h,081h,03ch,03ch,081h,042h,03ch,000h	; 7c25  .LL..{<B.<<.B<.

; ----------------------------------------------------------------------
; DATOS dibujos_7C34: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 9 de la lista 0x619A (p00:4595); lo leen p00:4531 (3
;   bytes)
;   0x7c34..0x7c37  (3 bytes)
DATA_dibujos_7C34:
	defb 008h,026h,000h	; 7c34

; ----------------------------------------------------------------------
; DATOS dibujos_7C37: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 5, ficha 6 de la lista 0x619A (p00:4595); lo leen p00:4531 (23
;   bytes)
;   0x7c37..0x7c4e  (23 bytes)
DATA_dibujos_7C37:
	defb 004h,000h,084h,008h,007h,000h,007h,006h,000h,006h,06bh,084h,0fah,0cdh,0f0h,060h	; 7c37  ..........k....`
	defb 005h,000h,083h,001h,0beh,001h,000h	; 7c47

; ----------------------------------------------------------------------
; DATOS dibujos_7C4E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 6 de la lista 0x6106 (p00:4595); lo leen p00:4531 (42
;   bytes)
;   0x7c4e..0x7c78  (42 bytes)
DATA_dibujos_7C4E:
	defb 002h,001h,002h,003h,002h,007h,0a2h,00fh,007h,00eh,01eh,096h,09bh,0cfh,0e7h,050h	; 7c4e  ...............P
	defb 06fh,037h,0eeh,022h,011h,0cch,020h,0d2h,0e5h,01dh,018h,031h,04bh,0b6h,0b4h,04ch	; 7c5e  o7.".. ....1K..L
	defb 00ch,044h,008h,0f8h,0f9h,086h,028h,0abh,086h,000h	; 7c6e  .D....(...

; ----------------------------------------------------------------------
; DATOS dibujos_7C78: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 27, ficha 10 de la lista 0x619A (p00:4595); lo leen p00:4531 (33
;   bytes)
;   0x7c78..0x7c99  (33 bytes)
DATA_dibujos_7C78:
	defb 086h,018h,001h,002h,004h,008h,008h,004h,011h,002h,008h,094h,004h,002h,001h,018h	; 7c78  ................
	defb 005h,00dh,03dh,07dh,0fdh,032h,072h,062h,062h,032h,01ah,0fdh,07dh,03dh,00dh,005h	; 7c88  ..=}.2rbb2..}=..
	defb 000h	; 7c98

; ----------------------------------------------------------------------
; DATOS dibujos_7C99: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 52, ficha 10 de la lista 0x6098 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x7c99..0x7cbb  (34 bytes)
DATA_dibujos_7C99:
	defb 0a0h,008h,02ah,02bh,029h,02ch,026h,04ah,092h,010h,054h,0d4h,094h,034h,064h,052h	; 7c99  ..*+),&J..T..4dR
	defb 049h,0a7h,088h,0a3h,0abh,0abh,08bh,030h,05dh,0e4h,011h,0c5h,0d5h,095h,065h,0b2h	; 7ca9  I......0].....e.
	defb 08dh,000h	; 7cb9

; ----------------------------------------------------------------------
; DATOS dibujos_7CBB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 96, ficha 1 de la lista 0x6106 (p00:4595); lo leen p00:4531 (55
;   bytes)
;   0x7cbb..0x7cf2  (55 bytes)
DATA_dibujos_7CBB:
	defb 092h,0c0h,035h,078h,075h,076h,0ech,0d8h,000h,001h,0c6h,09fh,07eh,0fch,0d0h,03eh	; 7cbb  ..5xuv......~..>
	defb 000h,0f8h,049h,006h,066h,0a0h,0e0h,0b4h,066h,062h,060h,061h,064h,06ch,0f8h,049h	; 7ccb  ..I.f...fb`adl.I
	defb 066h,066h,046h,046h,026h,026h,0f8h,0b6h,062h,066h,046h,022h,064h,066h,031h,073h	; 7cdb  ffFF&&..bfF"df1s
	defb 0f8h,0fah,078h,098h,0c1h,000h,000h	; 7ceb

; ----------------------------------------------------------------------
; DATOS dibujos_7CF2: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 0 de la lista 0x616F (p00:4595); lo leen p00:4531 (50
;   bytes)
;   0x7cf2..0x7d24  (50 bytes)
DATA_dibujos_7CF2:
	defb 0a0h,000h,003h,008h,010h,020h,020h,033h,03fh,000h,040h,020h,020h,070h,0f0h,0f8h	; 7cf2  .....  3?.@  p..
	defb 0fch,000h,000h,003h,00ch,01bh,01fh,00fh,00fh,000h,000h,080h,0c0h,060h,0e0h,0f0h	; 7d02  .............`..
	defb 0f8h,003h,01fh,002h,03fh,08bh,09fh,0b5h,05bh,0fch,0feh,0feh,000h,0beh,06fh,0feh	; 7d12  ....?...[.....o.
	defb 0dbh,000h	; 7d22

; ----------------------------------------------------------------------
; DATOS rachas_7D24: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (65 bytes)
;   0x7d24..0x7d65  (65 bytes)
DATA_rachas_7D24:
	defb 002h,000h,093h,001h,01ch,02fh,0f8h,003h,04fh,000h,000h,008h,090h,020h,0feh,080h	; 7d24  ...../..O.... ..
	defb 05fh,000h,003h,00fh,010h,06bh,003h,000h,085h,03fh,0feh,0c1h,036h,0cdh,003h,000h	; 7d34  _....k...?..6...
	defb 085h,03eh,0ffh,000h,0adh,080h,003h,000h,085h,0beh,000h,001h,07ch,0f0h,003h,000h	; 7d44  .>..........|...
	defb 085h,003h,022h,07dh,024h,007h,003h,000h,085h,080h,0d0h,0e8h,0f8h,0a0h,003h,000h	; 7d54  .."}$...........
	defb 000h	; 7d64

; ----------------------------------------------------------------------
; DATOS colores_7D65: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 161, ficha 8 de la lista 0x6106 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x7d65..0x7d87  (34 bytes)
DATA_colores_7D65:
	defb 0a0h,000h,0f0h,0e0h,0f0h,0e0h,0a0h,0a0h,0b0h,000h,0f0h,0e0h,0f0h,0e0h,0a0h,0a0h	; 7d65  ................
	defb 0b0h,0b0h,0a0h,0a0h,0e0h,0f0h,0e0h,0f0h,000h,0b0h,0a0h,0a0h,0e0h,0f0h,0e0h,0f0h	; 7d75  ................
	defb 000h,000h	; 7d85

; ----------------------------------------------------------------------
; DATOS colores_7D87: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 165, ficha 9 de la lista 0x6106 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x7d87..0x7da9  (34 bytes)
DATA_colores_7D87:
	defb 0a0h,000h,0f0h,0e0h,0f0h,0e0h,0c0h,020h,030h,000h,0f0h,0e0h,0f0h,0e0h,0c0h,020h	; 7d87  ....... 0......
	defb 030h,030h,020h,0c0h,0e0h,0f0h,0e0h,0f0h,000h,030h,020h,0c0h,0e0h,0f0h,0e0h,0f0h	; 7d97  00 ......0 .....
	defb 000h,000h	; 7da7

; ----------------------------------------------------------------------
; DATOS colores_7DA9: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 160, ficha 7 de la lista 0x6106 (p00:4595); lo leen p00:4531 (10
;   bytes)
;   0x7da9..0x7db3  (10 bytes)
DATA_colores_7DA9:
	defb 088h,060h,060h,080h,090h,090h,080h,060h,060h,000h	; 7da9  .``....``.

; ----------------------------------------------------------------------
; DATOS colores_7DB3: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 21, ficha 4 de la lista 0x6098 (p00:4595); lo leen p00:4531 (56
;   bytes)
;   0x7db3..0x7deb  (56 bytes)
DATA_colores_7DB3:
	defb 089h,030h,020h,030h,020h,030h,030h,020h,020h,030h,003h,020h,002h,030h,081h,020h	; 7db3  .0 0 00  0. .0.
	defb 00ch,0c0h,005h,020h,081h,0c0h,003h,020h,004h,030h,002h,0c0h,007h,020h,003h,030h	; 7dc3  ... ... .0... .0
	defb 003h,0a0h,006h,030h,002h,0a0h,008h,030h,081h,0f0h,005h,030h,084h,0c0h,020h,030h	; 7dd3  ...0...0...0.. 0
	defb 0f0h,004h,030h,083h,0c0h,020h,030h,000h	; 7de3  ..0.. 0.

; ----------------------------------------------------------------------
; DATOS colores_7DEB: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 193, ficha 9 de la lista 0x6098 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x7deb..0x7e0d  (34 bytes)
DATA_colores_7DEB:
	defb 081h,074h,007h,070h,081h,040h,003h,050h,086h,070h,030h,050h,070h,054h,075h,007h	; 7deb  .t.p.@.P.p0PpTu.
	defb 070h,007h,050h,082h,074h,070h,006h,050h,081h,040h,003h,050h,084h,070h,030h,050h	; 7dfb  p.P.tp.P.@.P.p0P
	defb 070h,000h	; 7e0b

; ----------------------------------------------------------------------
; DATOS colores_7E0D: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 177, ficha 3 de la lista 0x6098 (p00:4595); lo leen p00:4531 (78
;   bytes)
;   0x7e0d..0x7e5b  (78 bytes)
DATA_colores_7E0D:
	defb 004h,040h,081h,070h,006h,040h,083h,030h,070h,040h,004h,030h,002h,070h,08ch,050h	; 7e0d  .@.p.@.0p@.0.p.P
	defb 070h,050h,040h,040h,070h,050h,040h,040h,030h,070h,050h,004h,040h,002h,050h,005h	; 7e1d  pP@@pP@@0pP.@.P.
	defb 040h,083h,070h,050h,050h,005h,040h,083h,074h,075h,054h,003h,040h,083h,030h,070h	; 7e2d  @.pPP.@.tuT.@.0p
	defb 070h,003h,050h,005h,040h,002h,050h,005h,040h,083h,070h,050h,050h,005h,040h,083h	; 7e3d  p.P.@.P.@.pPP.@.
	defb 074h,075h,054h,003h,040h,083h,030h,070h,070h,003h,050h,081h,040h,000h	; 7e4d  tuT.@.0pp.P.@.

; ----------------------------------------------------------------------
; DATOS colores_7E5B: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 31, ficha 0 de la lista 0x614A (p00:4595); lo leen p00:4531 (217
;   bytes)
;   0x7e5b..0x7f34  (217 bytes)
DATA_colores_7E5B:
	defb 043h,040h,081h,044h,044h,040h,017h,0f0h,081h,0f7h,006h,0f0h,020h,0f7h,006h,074h	; 7e5b  C@.DD@...... ..t
	defb 004h,040h,004h,0f0h,081h,040h,013h,0f4h,081h,0f7h,02eh,0f4h,005h,074h,007h,040h	; 7e6b  .@...@.......t.@
	defb 082h,070h,040h,007h,0f4h,008h,0f7h,004h,0f4h,003h,0f0h,003h,040h,084h,0f4h,040h	; 7e7b  .p@.........@..@
	defb 0f0h,0f0h,006h,0f4h,002h,0f0h,006h,0f4h,083h,040h,074h,074h,005h,040h,002h,0f0h	; 7e8b  .........@tt.@..
	defb 003h,0f7h,003h,074h,082h,0f0h,070h,006h,040h,004h,0f0h,081h,070h,003h,077h,002h	; 7e9b  ...t..p.@...p.w.
	defb 0f4h,006h,074h,004h,0f7h,004h,074h,002h,050h,006h,040h,008h,0f0h,007h,040h,081h	; 7eab  ..t...t.P.@...@.
	defb 0f4h,003h,040h,003h,0f0h,002h,0f4h,008h,040h,006h,0f0h,081h,0e0h,006h,0f0h,081h	; 7ebb  ..@.....@.......
	defb 050h,00ah,040h,002h,0f0h,086h,070h,050h,040h,070h,050h,040h,003h,0f0h,08dh,070h	; 7ecb  P.@...pP@pP@...p
	defb 050h,040h,070h,040h,0f0h,0f0h,070h,070h,050h,070h,050h,040h,003h,0f0h,002h,070h	; 7edb  P@p@..ppPpP@...p
	defb 083h,050h,040h,040h,004h,0f0h,09bh,070h,050h,050h,040h,077h,0f0h,0f0h,070h,050h	; 7eeb  .P@@...pPP@w..pP
	defb 040h,070h,040h,0f7h,0f0h,070h,050h,0f0h,050h,040h,040h,0f7h,0f0h,070h,050h,040h	; 7efb  @p@..pP.P@@..pP@
	defb 070h,050h,006h,040h,003h,050h,007h,040h,081h,050h,03eh,040h,002h,050h,003h,040h	; 7f0b  pP.@.P.@.P>@.P.@
	defb 005h,050h,005h,040h,003h,050h,002h,040h,002h,050h,006h,040h,004h,050h,005h,040h	; 7f1b  .P.@.P.@.P.@.P.@
	defb 004h,050h,004h,040h,005h,050h,008h,0a0h,000h	; 7f2b  .P.@.P...

; ----------------------------------------------------------------------
; DATOS colores_7F34: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 139, ficha 1 de la lista 0x614A (p00:4595); lo leen p00:4531 (86
;   bytes)
;   0x7f34..0x7f8a  (86 bytes)
DATA_colores_7F34:
	defb 003h,0f0h,08dh,0e0h,070h,070h,055h,044h,0f0h,070h,070h,050h,040h,040h,055h,044h	; 7f34  ....ppUD.ppP@@UD
	defb 005h,0f0h,083h,0f7h,0e5h,0e4h,004h,0e0h,002h,070h,082h,050h,040h,003h,000h,095h	; 7f44  .........p.P@...
	defb 0e0h,070h,070h,055h,044h,0d0h,0d0h,080h,080h,050h,070h,040h,040h,0d0h,0d0h,080h	; 7f54  .ppUD....Pp@@...
	defb 080h,050h,070h,040h,040h,00eh,0a0h,082h,055h,044h,00eh,0b0h,082h,055h,044h,00eh	; 7f64  .Pp@@...UD...UD.
	defb 0f0h,082h,055h,044h,008h,000h,002h,0f0h,084h,070h,050h,0f0h,050h,009h,040h,081h	; 7f74  ..UD.....pP.P.@.
	defb 050h,005h,040h,003h,050h,000h	; 7f84

; ----------------------------------------------------------------------
; DATOS colores_7F8A: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 173, ficha 2 de la lista 0x614A (p00:4595); lo leen p00:4531 (45
;   bytes)
;   0x7f8a..0x7fb7  (45 bytes)
DATA_colores_7F8A:
	defb 024h,040h,004h,050h,002h,040h,00eh,050h,008h,0f0h,008h,070h,007h,000h,083h,040h	; 7f8a  $@.P.@.P...p...@
	defb 000h,000h,003h,0a0h,004h,000h,005h,0a0h,007h,000h,003h,00fh,006h,000h,006h,0f0h	; 7f9a  ................
	defb 002h,0e0h,002h,0f0h,002h,040h,006h,050h,003h,040h,005h,050h,000h	; 7faa  .....@.P.@.P.

; ----------------------------------------------------------------------
; DATOS colores_7FB7: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 196, ficha 3 de la lista 0x614A (p00:4595); lo leen p00:4531 (15
;   bytes)
;   0x7fb7..0x7fc6  (15 bytes)
DATA_colores_7FB7:
	defb 00ch,0f0h,002h,0e0h,082h,060h,040h,003h,0f0h,003h,0e0h,082h,060h,040h,000h	; 7fb7  .....`@.....`@.

; ----------------------------------------------------------------------
; DATOS colores_7FC6: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 21, ficha 0 de la lista 0x6061 (p00:4595); lo leen p00:4531 (40
;   bytes)
;   0x7fc6..0x7fee  (40 bytes)
DATA_colores_7FC6:
	defb 08fh,0d6h,080h,080h,050h,0e0h,0f0h,0f0h,0e0h,0f0h,070h,020h,0c6h,083h,020h,0c0h	; 7fc6  ....P.....p .. .
	defb 005h,080h,094h,096h,0a6h,080h,080h,064h,054h,050h,070h,0c0h,0c0h,020h,030h,064h	; 7fd6  .......dTPp.. 0d
	defb 054h,050h,070h,0c0h,0c0h,020h,030h,000h	; 7fe6  TPp.. 0.

; ----------------------------------------------------------------------
; DATOS colores_7FEE: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 109, ficha 5 de la lista 0x6061 (p00:4595) (sigue en el banco 8,
;   en 0x8000); lo leen p00:4531 (18 bytes)
;   0x7fee..0x8000  (18 bytes)
DATA_colores_7FEE:
	defb 092h,0cah,0c3h,0c3h,0c2h,0c2h,020h,020h,0a0h,0c8h,0c8h,0c3h,0c3h,0c0h,0c2h,022h	; 7fee  ......  ......."
	defb 020h,0cah	; 7ffe

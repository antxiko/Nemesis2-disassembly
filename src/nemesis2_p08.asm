; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 08 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS dibujos_7FEE_cola: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 109, ficha 5 de la lista 0x6061 (p00:4595) (sigue del banco 7);
;   lo leen p00:4531 (26 bytes)
;   0x8000..0x801a  (26 bytes)
DATA_dibujos_7FEE_cola:
	defb 0c3h,003h,0c2h,002h,020h,081h,0a0h,009h,0c0h,002h,020h,08dh,030h,000h,0c2h,020h	; 8000  .... ..... .0..
	defb 0e3h,0c6h,0c2h,020h,030h,0c0h,0c0h,020h,030h,000h	; 8010  ... 0.. 0.

; ----------------------------------------------------------------------
; DATOS dibujos_801A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 139, ficha 6 de la lista 0x6061 (p00:4595); lo leen p00:4531 (74
;   bytes)
;   0x801a..0x8064  (74 bytes)
DATA_dibujos_801A:
	defb 087h,0e0h,0f0h,050h,040h,040h,050h,070h,007h,0f0h,081h,070h,006h,0f0h,003h,070h	; 801a  ...P@@Pp...p...p
	defb 003h,0f0h,007h,070h,003h,050h,003h,040h,002h,070h,081h,050h,005h,040h,082h,070h	; 802a  ...p.P.@.p.P.@.p
	defb 050h,006h,040h,004h,050h,08fh,040h,020h,040h,050h,0f0h,0f0h,070h,050h,040h,050h	; 803a  P.@.P.@ @P..pP@P
	defb 050h,070h,000h,0a0h,030h,003h,020h,002h,0c0h,002h,080h,003h,090h,002h,0a9h,083h	; 804a  Pp..0. .........
	defb 0fah,0c0h,0c0h,003h,020h,002h,032h,081h,0f3h,000h	; 805a  .... .2...

; ----------------------------------------------------------------------
; DATOS dibujos_8064: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 187, ficha 7 de la lista 0x6061 (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x8064..0x8076  (18 bytes)
DATA_dibujos_8064:
	defb 002h,000h,08eh,080h,030h,0c0h,0c2h,0c2h,0c0h,0c0h,020h,020h,030h,0c0h,0c2h,020h	; 8064  ....0.....  0..
	defb 096h,000h	; 8074

; ----------------------------------------------------------------------
; DATOS dibujos_8076: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 195, ficha 8 de la lista 0x6061 (p00:4595); lo leen p00:4531 (34
;   bytes)
;   0x8076..0x8098  (34 bytes)
DATA_dibujos_8076:
	defb 002h,090h,08ch,060h,090h,090h,060h,090h,096h,096h,090h,060h,090h,060h,060h,004h	; 8076  ...`..`....`.``.
	defb 090h,083h,060h,090h,096h,006h,090h,085h,096h,090h,060h,090h,000h,008h,040h,008h	; 8086  ..`.......`...@.
	defb 060h,000h	; 8096

; ----------------------------------------------------------------------
; DATOS dibujos_8098: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 1 de la lista 0x6061 (p00:4595); lo leen p00:4531 (146
;   bytes)
;   0x8098..0x812a  (146 bytes)
DATA_dibujos_8098:
	defb 002h,020h,081h,0c0h,003h,060h,002h,080h,002h,040h,08fh,0c0h,024h,037h,034h,084h	; 8098  . ...`...@..$74.
	defb 084h,040h,040h,0c0h,024h,037h,034h,084h,084h,090h,004h,080h,002h,060h,081h,090h	; 80a8  .@@.$74......`..
	defb 004h,080h,005h,060h,08ch,040h,080h,0a0h,090h,0c0h,060h,020h,020h,040h,0c0h,070h	; 80b8  ...`.@....`  @.p
	defb 040h,004h,030h,088h,040h,020h,030h,0c0h,000h,030h,030h,080h,005h,020h,084h,040h	; 80c8  @.0.@ 0..00.. .@
	defb 020h,020h,060h,003h,020h,003h,0c0h,081h,020h,003h,030h,006h,020h,093h,030h,0c0h	; 80d8    `. ... .0. .0.
	defb 040h,020h,030h,030h,0c0h,0c0h,030h,020h,0c0h,0c0h,030h,070h,0c0h,070h,020h,0c0h	; 80e8  @ 00..0 ..0p.p .
	defb 030h,006h,020h,002h,030h,087h,080h,0c0h,020h,020h,000h,0c0h,070h,004h,020h,089h	; 80f8  0. .0...  ..p. .
	defb 030h,020h,020h,030h,03ch,0c4h,040h,040h,0c0h,007h,020h,081h,0c0h,005h,030h,082h	; 8108  0  0<.@@.. ...0.
	defb 0c0h,030h,008h,020h,002h,040h,004h,0c0h,083h,020h,030h,0c0h,005h,030h,082h,0c0h	; 8118  .0. .@... 0..0..
	defb 030h,000h	; 8128

; ----------------------------------------------------------------------
; DATOS dibujos_812A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 19, ficha 0 de la lista 0x61DD (p00:4595); lo leen p00:4531 (24
;   bytes)
;   0x812a..0x8142  (24 bytes)
DATA_dibujos_812A:
	defb 003h,0e0h,08dh,0e4h,0e0h,0e0h,0e4h,0e9h,0f0h,0f0h,0e4h,0f6h,065h,0e6h,0e8h,0e9h	; 812a  ............e...
	defb 004h,050h,002h,060h,082h,080h,090h,000h	; 813a  .P.`....

; ----------------------------------------------------------------------
; DATOS dibujos_8142: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 1 de la lista 0x61DD (p00:4595); lo leen p00:4531 (146
;   bytes)
;   0x8142..0x81d4  (146 bytes)
DATA_dibujos_8142:
	defb 002h,0e0h,081h,050h,003h,060h,002h,080h,002h,040h,08fh,050h,0e4h,0f7h,0f4h,084h	; 8142  ...P.`...@.P....
	defb 084h,040h,040h,050h,0e4h,0f7h,0f4h,084h,084h,090h,004h,080h,002h,060h,081h,090h	; 8152  .@@P.........`..
	defb 004h,080h,005h,060h,08ch,040h,080h,0a0h,090h,050h,060h,0e0h,0e0h,040h,050h,070h	; 8162  ...`.@...P`..@Pp
	defb 040h,004h,0f0h,088h,040h,0e0h,0f0h,050h,000h,0f0h,0f0h,080h,005h,0e0h,084h,040h	; 8172  @...@..P.......@
	defb 0e0h,0e0h,060h,003h,0e0h,003h,050h,081h,0e0h,003h,0f0h,006h,0e0h,093h,0f0h,050h	; 8182  ..`...P........P
	defb 040h,0e0h,0f0h,0f0h,050h,050h,0f0h,0e0h,050h,050h,0f0h,070h,050h,070h,0e0h,050h	; 8192  @...PP..PP.pPp.P
	defb 0f0h,006h,0e0h,002h,0f0h,087h,080h,050h,0e0h,0e0h,000h,050h,070h,004h,0e0h,089h	; 81a2  .......P...Pp...
	defb 0f0h,0e0h,0e0h,0f0h,0f5h,054h,040h,040h,050h,007h,0e0h,081h,050h,005h,0f0h,082h	; 81b2  .....T@@P...P...
	defb 050h,0f0h,008h,0e0h,002h,040h,004h,050h,083h,0e0h,0f0h,050h,005h,0f0h,082h,050h	; 81c2  P....@.P...P...P
	defb 0f0h,000h	; 81d2

; ----------------------------------------------------------------------
; DATOS dibujos_81D4: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 4 de la lista 0x6061 (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x81d4..0x81e6  (18 bytes)
DATA_dibujos_81D4:
	defb 090h,080h,090h,0a0h,0b0h,0a0h,090h,080h,060h,040h,050h,040h,030h,040h,050h,020h	; 81d4  ........`@P@0@P
	defb 0c0h,000h	; 81e4

; ----------------------------------------------------------------------
; DATOS dibujos_81E6: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 157, ficha 5 de la lista 0x61DD (p00:4595); lo leen p00:4531 (67
;   bytes)
;   0x81e6..0x8229  (67 bytes)
DATA_dibujos_81E6:
	defb 002h,0f0h,004h,060h,002h,098h,002h,0f0h,002h,060h,085h,080h,090h,080h,060h,060h	; 81e6  ...`.....`....``
	defb 004h,080h,087h,090h,080h,090h,0a8h,0a8h,0a9h,0a9h,004h,0f9h,08fh,0a6h,0a8h,0a8h	; 81f6  ................
	defb 0a9h,0a9h,0b9h,0f9h,0f9h,090h,060h,090h,080h,090h,080h,090h,007h,080h,002h,090h	; 8206  ......`.........
	defb 085h,0f9h,0f8h,0f8h,0a8h,0a8h,003h,080h,085h,0f9h,0f8h,0f8h,0a8h,0a8h,006h,080h	; 8216  ................
	defb 005h,060h,000h	; 8226

; ----------------------------------------------------------------------
; DATOS dibujos_8229: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 167, ficha 6 de la lista 0x61DD (p00:4595); lo leen p00:4531 (67
;   bytes)
;   0x8229..0x826c  (67 bytes)
DATA_dibujos_8229:
	defb 002h,0f0h,004h,0c0h,002h,032h,002h,0f0h,002h,0c0h,085h,020h,030h,020h,0c0h,0c0h	; 8229  .....2..... 0 ..
	defb 004h,020h,087h,030h,020h,030h,0a2h,0a2h,0a3h,0a3h,004h,0f3h,08fh,0cah,0a2h,0a2h	; 8239  . .0 0..........
	defb 0a3h,0a3h,0b3h,0f3h,0f3h,030h,0c0h,030h,020h,030h,020h,030h,007h,020h,002h,030h	; 8249  .....0.0 0 0. .0
	defb 085h,0f3h,0f2h,0f2h,0a2h,0a2h,003h,020h,085h,0f3h,0f2h,0f2h,0a2h,0a2h,006h,020h	; 8259  ....... .......
	defb 005h,0c0h,000h	; 8269

; ----------------------------------------------------------------------
; DATOS dibujos_826C: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 177, ficha 7 de la lista 0x61DD (p00:4595); lo leen p00:4531 (49
;   bytes)
;   0x826c..0x829d  (49 bytes)
DATA_dibujos_826C:
	defb 006h,040h,004h,054h,081h,050h,00ah,040h,002h,054h,003h,075h,081h,054h,009h,040h	; 826c  .@.T.P.@.T.u.T.@
	defb 002h,054h,004h,075h,002h,054h,002h,050h,005h,040h,002h,054h,002h,075h,003h,0f7h	; 827c  .T.u.T.P.@.T.u..
	defb 002h,075h,081h,054h,003h,040h,007h,0f0h,004h,020h,002h,0c0h,083h,050h,0e0h,000h	; 828c  .u.T.@... ...P..
	defb 000h	; 829c

; ----------------------------------------------------------------------
; DATOS dibujos_829D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 11, ficha 0 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (43 bytes)
;   0x829d..0x82c8  (43 bytes)
DATA_dibujos_829D:
	defb 082h,000h,070h,004h,040h,004h,070h,004h,040h,002h,070h,082h,000h,0f0h,004h,0a0h	; 829d  ..p.@.p.@.p.....
	defb 004h,0f0h,004h,0a0h,084h,0f0h,000h,000h,090h,004h,060h,004h,090h,004h,060h,08ah	; 82ad  ..........`...`.
	defb 090h,000h,000h,050h,0e0h,0e0h,030h,070h,050h,0f0h,000h	; 82bd  ...P..0pP..

; ----------------------------------------------------------------------
; DATOS dibujos_82C8: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 29, ficha 3 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (13 bytes)
;   0x82c8..0x82d5  (13 bytes)
DATA_dibujos_82C8:
	defb 082h,000h,0f0h,004h,0a0h,004h,0f0h,004h,0a0h,082h,0f0h,000h,000h	; 82c8  .............

; ----------------------------------------------------------------------
; DATOS dibujos_82D5: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 237, ficha 2 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (114 bytes)
;   0x82d5..0x8347  (114 bytes)
DATA_dibujos_82D5:
	defb 0b7h,000h,0f0h,0e0h,0f0h,0e0h,060h,080h,090h,090h,0f0h,0e0h,0f0h,0e0h,060h,080h	; 82d5  ......`.......`.
	defb 090h,090h,080h,060h,0e0h,0f0h,0e0h,0f0h,000h,090h,080h,060h,0e0h,0f0h,0e0h,0f0h	; 82e5  ...`.......`....
	defb 040h,073h,0bah,054h,000h,000h,073h,0bah,054h,070h,0f0h,070h,0f0h,070h,0f0h,070h	; 82f5  @s.T..s.Tp.p.p.p
	defb 0f0h,060h,096h,0b8h,0f9h,0f9h,0b8h,096h,006h,060h,086h,096h,0b8h,0f9h,0f9h,0b8h	; 8305  .`.......`......
	defb 096h,005h,060h,082h,030h,070h,008h,000h,082h,030h,070h,008h,000h,082h,030h,070h	; 8315  ..`.0p...0p...0p
	defb 008h,000h,084h,030h,070h,070h,050h,008h,000h,082h,070h,050h,008h,000h,084h,070h	; 8325  ...0ppP...pP...p
	defb 050h,070h,050h,006h,000h,085h,070h,050h,000h,000h,0b0h,008h,000h,081h,070h,004h	; 8335  PpP...pP......p.
	defb 000h,000h	; 8345

; ----------------------------------------------------------------------
; DATOS dibujos_8347: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 136, ficha 0 de la lista 0x6098 (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x8347..0x8359  (18 bytes)
DATA_dibujos_8347:
	defb 090h,070h,050h,050h,040h,040h,054h,000h,000h,070h,050h,050h,040h,040h,054h,000h	; 8347  .pPP@@T..pPP@@T.
	defb 000h,000h	; 8357

; ----------------------------------------------------------------------
; DATOS dibujos_8359: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 32, ficha 1 de la lista 0x6098 (p00:4595); lo leen p00:4531 (114
;   bytes)
;   0x8359..0x83cb  (114 bytes)
DATA_dibujos_8359:
	defb 093h,030h,020h,074h,075h,075h,054h,040h,040h,050h,043h,042h,070h,075h,050h,040h	; 8359  .0 tuuT@@PCBpuP@
	defb 040h,043h,042h,042h,003h,054h,004h,020h,089h,072h,075h,054h,054h,000h,000h,074h	; 8369  @CBB.T. .ruTT..t
	defb 052h,075h,003h,054h,003h,020h,081h,070h,007h,075h,083h,042h,040h,042h,004h,050h	; 8379  Ru.T. .p.u.B@B.P
	defb 08bh,070h,050h,040h,020h,042h,054h,054h,040h,040h,042h,042h,003h,054h,002h,000h	; 8389  .pP@ BTT@@BB.T..
	defb 0b0h,020h,040h,020h,043h,030h,042h,020h,043h,0c0h,0f7h,0c0h,0e5h,0c0h,074h,0c0h	; 8399  . @ C0B C.....t.
	defb 042h,0c0h,0f7h,0c0h,0e5h,0c0h,074h,0c0h,042h,070h,0a0h,070h,070h,050h,040h,040h	; 83a9  B.....t.Bp.ppP@@
	defb 087h,0f0h,0f0h,0e0h,070h,030h,042h,043h,0c0h,0f0h,070h,0f0h,070h,020h,030h,030h	; 83b9  ....p0BC..p.p 00
	defb 020h,000h	; 83c9

; ----------------------------------------------------------------------
; DATOS dibujos_83CB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 56, ficha 2 de la lista 0x6098 (p00:4595); lo leen p00:4531 (248
;   bytes)
;   0x83cb..0x84c3  (248 bytes)
DATA_dibujos_83CB:
	defb 008h,0c0h,08eh,030h,020h,000h,020h,030h,000h,0c0h,0c0h,030h,020h,000h,020h,030h	; 83cb  ...0 . 0...0 . 0
	defb 030h,006h,0c0h,002h,030h,082h,020h,0c0h,003h,020h,005h,030h,081h,0c0h,003h,020h	; 83db  0...0. .. .0...
	defb 004h,030h,004h,0c0h,081h,020h,003h,030h,002h,0c0h,002h,020h,00ah,030h,002h,020h	; 83eb  .0... .0... .0.
	defb 004h,030h,002h,0a0h,002h,030h,002h,020h,004h,030h,084h,0b0h,0f0h,020h,020h,003h	; 83fb  .0...0. .0...  .
	defb 0c0h,002h,020h,008h,030h,083h,020h,0f0h,0a0h,003h,030h,085h,0c0h,020h,030h,0a0h	; 840b  .. .0. ...0.. 0.
	defb 0a0h,003h,030h,084h,0c0h,020h,030h,032h,005h,0c0h,083h,030h,020h,020h,003h,030h	; 841b  ..0.. 02...0  .0
	defb 002h,0c0h,003h,030h,004h,020h,002h,0c0h,002h,020h,083h,0c0h,020h,030h,004h,0c0h	; 842b  ...0. ... .. 0..
	defb 08bh,020h,0c0h,030h,030h,020h,0c0h,0c0h,030h,0c0h,020h,030h,003h,020h,004h,0c0h	; 843b  . .00 ..0. 0. ..
	defb 002h,020h,00ah,0c0h,082h,000h,0c0h,003h,020h,084h,030h,020h,0c0h,000h,007h,0c0h	; 844b  . ...... .0 ....
	defb 003h,020h,084h,0c0h,020h,030h,020h,003h,0c0h,084h,030h,0c0h,0c0h,020h,005h,0c0h	; 845b  . .. 0 ...0.. ..
	defb 08eh,030h,0c3h,0c0h,030h,030h,020h,020h,030h,020h,000h,020h,030h,030h,020h,005h	; 846b  .0..00  0 . 00 .
	defb 0c0h,004h,020h,081h,0c0h,003h,020h,004h,030h,081h,020h,003h,030h,003h,0a0h,006h	; 847b  .. ... .0. .0...
	defb 030h,002h,0a0h,002h,0f0h,081h,0a0h,003h,030h,086h,0c0h,020h,030h,020h,030h,030h	; 848b  0.......0.. 0 00
	defb 004h,020h,002h,030h,002h,020h,003h,0c0h,082h,030h,0c0h,003h,020h,002h,030h,002h	; 849b  . .0. ...0.. .0.
	defb 020h,084h,030h,0c0h,020h,030h,004h,020h,081h,0c0h,003h,020h,082h,030h,020h,004h	; 84ab   .0. 0. ... .0 .
	defb 0c0h,081h,020h,003h,0c0h,003h,020h,000h	; 84bb  .. ... .

; ----------------------------------------------------------------------
; DATOS dibujos_84C3: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 6 de la lista 0x6098 (p00:4595); lo leen p00:4531 (76
;   bytes)
;   0x84c3..0x850f  (76 bytes)
DATA_dibujos_84C3:
	defb 083h,090h,0d0h,090h,005h,080h,083h,0f0h,0a0h,0d0h,005h,090h,002h,080h,006h,060h	; 84c3  ...............`
	defb 081h,090h,003h,080h,005h,060h,092h,040h,000h,050h,0d0h,050h,040h,040h,0d0h,050h	; 84d3  .....`.@.P.P@@.P
	defb 0d0h,020h,050h,090h,075h,000h,090h,0d0h,0d0h,005h,090h,083h,0f0h,0a0h,0d0h,005h	; 84e3  . P.u...........
	defb 090h,004h,080h,003h,060h,082h,000h,090h,003h,080h,006h,060h,083h,000h,060h,080h	; 84f3  ....`......`..`.
	defb 003h,060h,088h,0b0h,090h,090h,0a0h,090h,000h,0b9h,000h,000h	; 8503  .`..........

; ----------------------------------------------------------------------
; DATOS dibujos_850F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 189, ficha 8 de la lista 0x6098 (p00:4595); lo leen p00:4531 (7
;   bytes)
;   0x850f..0x8516  (7 bytes)
DATA_dibujos_850F:
	defb 003h,090h,007h,080h,006h,060h,000h	; 850f

; ----------------------------------------------------------------------
; DATOS dibujos_8516: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 1 de la lista 0x60DB (p00:4595); lo leen p00:4531 (198
;   bytes)
;   0x8516..0x85dc  (198 bytes)
DATA_dibujos_8516:
	defb 003h,0b0h,005h,030h,010h,0b0h,012h,030h,004h,020h,006h,030h,004h,020h,006h,030h	; 8516  ...0...0. .0. .0
	defb 002h,020h,002h,030h,006h,020h,002h,0c0h,002h,020h,081h,0c0h,00dh,020h,081h,0c0h	; 8526  . .0. ... ... ..
	defb 005h,030h,003h,020h,081h,0c0h,003h,030h,008h,020h,081h,0c0h,003h,030h,081h,020h	; 8536  .0. ...0. ...0.
	defb 004h,0c0h,002h,030h,003h,020h,004h,0c0h,002h,020h,081h,030h,003h,020h,087h,0c0h	; 8546  ...0. ... .0. ..
	defb 020h,020h,030h,030h,020h,020h,00ah,0c0h,002h,030h,004h,020h,005h,030h,003h,0b0h	; 8556    00  ...0. .0..
	defb 005h,030h,083h,0b0h,030h,030h,004h,020h,081h,0c0h,005h,030h,003h,020h,081h,0c0h	; 8566  .0..00. ...0. ..
	defb 003h,030h,081h,020h,00ah,030h,004h,020h,002h,030h,002h,0b0h,081h,030h,003h,0b0h	; 8576  .0. .0. .0...0..
	defb 083h,030h,020h,030h,004h,0b0h,086h,020h,0b0h,0b0h,020h,020h,0c0h,006h,030h,002h	; 8586  .0 0... ..  ..0.
	defb 020h,081h,0c0h,003h,030h,081h,020h,006h,030h,002h,0b0h,002h,030h,005h,020h,011h	; 8596   ...0. .0...0. .
	defb 0b0h,002h,0c0h,002h,020h,081h,0c0h,003h,020h,081h,0b0h,007h,030h,004h,0b0h,003h	; 85a6  .... ... ...0...
	defb 030h,002h,020h,002h,0c0h,002h,020h,003h,030h,002h,020h,002h,030h,003h,020h,085h	; 85b6  0. ... .0. .0. .
	defb 030h,0c3h,020h,0c0h,0c0h,004h,020h,008h,0c0h,005h,020h,004h,030h,006h,020h,081h	; 85c6  0. ... ... .0. .
	defb 030h,006h,020h,00ah,0c0h,000h	; 85d6

; ----------------------------------------------------------------------
; DATOS dibujos_85DC: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 185, ficha 2 de la lista 0x60DB (p00:4595); lo leen p00:4531 (27
;   bytes)
;   0x85dc..0x85f7  (27 bytes)
DATA_dibujos_85DC:
	defb 008h,0c0h,006h,030h,002h,020h,002h,030h,005h,020h,009h,0c0h,005h,060h,083h,080h	; 85dc  ...0. .0. ...`..
	defb 090h,090h,005h,060h,081h,080h,004h,090h,006h,0c0h,000h	; 85ec  ...`.......

; ----------------------------------------------------------------------
; DATOS dibujos_85F7: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 203, ficha 1 de la lista 0x6048 (p00:4595); lo leen p00:4502,
;   p00:4522, p00:57D5 (192 bytes)
;   0x85f7..0x86b7  (192 bytes)
DATA_dibujos_85F7:
	defb 081h,0f0h,004h,040h,096h,0f0h,070h,040h,070h,070h,040h,000h,070h,040h,040h,0f0h	; 85f7  ...@..p@pp@.p@@.
	defb 070h,0f0h,070h,040h,000h,000h,070h,0f0h,070h,040h,040h,005h,070h,083h,040h,0f0h	; 8607  p.p@..p.p@@.p.@.
	defb 0f0h,003h,070h,002h,040h,002h,0f4h,081h,0f7h,004h,074h,003h,0f7h,093h,0f4h,074h	; 8617  ..p.@.....t....t
	defb 074h,0f7h,0f4h,0f4h,0f0h,040h,040h,0f0h,0f0h,070h,070h,040h,070h,0f0h,0f0h,070h	; 8627  t....@@..pp@p..p
	defb 070h,003h,040h,004h,0f7h,085h,074h,0f4h,0f7h,0f7h,074h,005h,0f7h,002h,0f4h,084h	; 8637  p.@...t...t.....
	defb 0f0h,070h,040h,040h,004h,0f0h,081h,070h,003h,040h,084h,070h,040h,000h,000h,004h	; 8647  .p@@...p.@.p@...
	defb 0f4h,002h,074h,002h,040h,087h,074h,0f4h,0f4h,040h,040h,000h,070h,003h,040h,084h	; 8657  ..t.@.t..@@.p.@.
	defb 000h,040h,070h,040h,009h,0f0h,004h,070h,004h,0f0h,003h,070h,005h,040h,003h,070h	; 8667  .@p@...p...p.@.p
	defb 002h,0f4h,004h,074h,082h,000h,0f0h,003h,070h,003h,040h,081h,070h,007h,040h,004h	; 8677  ...t....p.@.p.@.
	defb 0f7h,08ah,074h,040h,074h,0f7h,0f0h,070h,040h,0f0h,070h,070h,00ah,040h,002h,0f4h	; 8687  ..t@t..p@.pp.@..
	defb 003h,070h,005h,040h,002h,0f0h,081h,070h,003h,0f4h,004h,040h,084h,070h,040h,070h	; 8697  .p.@...p...@.p@p
	defb 0f0h,005h,0f4h,002h,074h,081h,040h,003h,0f0h,081h,070h,003h,040h,081h,0f0h,000h	; 86a7  ....t.@...p.@...

; ----------------------------------------------------------------------
; DATOS dibujos_86B7: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 3 de la lista 0x6106 (p00:4595); lo leen p00:4531 (42
;   bytes)
;   0x86b7..0x86e1  (42 bytes)
DATA_dibujos_86B7:
	defb 006h,0f0h,006h,090h,084h,0e0h,0b0h,0b0h,090h,003h,0b0h,085h,0f0h,0a0h,090h,080h	; 86b7  ................
	defb 090h,003h,0f0h,08ch,0a0h,090h,090h,080h,090h,080h,000h,090h,060h,0e0h,080h,060h	; 86c7  ............`..`
	defb 003h,090h,086h,080h,060h,0e0h,080h,060h,080h,000h	; 86d7  ....`..`..

; ----------------------------------------------------------------------
; DATOS dibujos_86E1: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 4 de la lista 0x614A (p00:4595); lo leen p00:4531 (45
;   bytes)
;   0x86e1..0x870e  (45 bytes)
DATA_dibujos_86E1:
	defb 004h,0f0h,087h,090h,0b0h,090h,080h,0f0h,0f0h,0b0h,004h,090h,081h,080h,004h,0f0h	; 86e1  ................
	defb 084h,0b0h,090h,090h,080h,004h,0f0h,094h,0b0h,090h,090h,080h,060h,060h,090h,080h	; 86f1  ............``..
	defb 060h,0b0h,090h,080h,060h,060h,090h,080h,060h,0b0h,090h,080h,000h	; 8701  `...``..`....

; ----------------------------------------------------------------------
; DATOS dibujos_870E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 2 de la lista 0x6061 (p00:4595); lo leen p00:4531 (30
;   bytes)
;   0x870e..0x872c  (30 bytes)
DATA_dibujos_870E:
	defb 004h,090h,081h,0a0h,003h,090h,003h,0f0h,003h,090h,089h,080h,090h,080h,080h,090h	; 870e  ................
	defb 060h,0a0h,080h,060h,003h,090h,086h,080h,060h,0a0h,080h,060h,080h,000h	; 871e  `..`....`..`..

; ----------------------------------------------------------------------
; DATOS dibujos_872C: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 103, ficha 4 de la lista 0x6106 (p00:4595); lo leen p00:4531 (42
;   bytes)
;   0x872c..0x8756  (42 bytes)
DATA_dibujos_872C:
	defb 006h,0f0h,005h,070h,088h,0f0h,070h,070h,050h,070h,070h,0f0h,0f0h,003h,070h,082h	; 872c  ...p..ppPpp...p.
	defb 050h,070h,004h,0f0h,081h,0e0h,003h,070h,087h,050h,000h,070h,040h,0e0h,050h,040h	; 873c  Pp.....p.P.p@.P@
	defb 003h,070h,086h,050h,040h,0e0h,050h,040h,050h,000h	; 874c  .p.P@.P@P.

; ----------------------------------------------------------------------
; DATOS dibujos_8756: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 127, ficha 5 de la lista 0x614A (p00:4595); lo leen p00:4531 (42
;   bytes)
;   0x8756..0x8780  (42 bytes)
DATA_dibujos_8756:
	defb 004h,0f0h,086h,070h,0f0h,070h,050h,0f0h,0f0h,005h,070h,081h,050h,004h,0f0h,003h	; 8756  ...p.pP...p.P...
	defb 070h,081h,050h,004h,0f0h,003h,070h,091h,050h,040h,040h,070h,050h,040h,0f0h,070h	; 8766  p.P...p.P@@pP@.p
	defb 050h,040h,040h,070h,050h,040h,0f0h,070h,050h,000h	; 8776  P@@pP@.pP.

; ----------------------------------------------------------------------
; DATOS dibujos_8780: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 127, ficha 3 de la lista 0x6061 (p00:4595); lo leen p00:4531 (30
;   bytes)
;   0x8780..0x879e  (30 bytes)
DATA_dibujos_8780:
	defb 004h,070h,081h,0e0h,003h,070h,003h,0f0h,003h,070h,089h,050h,070h,050h,050h,070h	; 8780  .p...p...p.PpPPp
	defb 040h,0e0h,050h,040h,003h,070h,086h,050h,040h,0e0h,050h,040h,050h,000h	; 8790  @.P@.p.P@.P@P.

; ----------------------------------------------------------------------
; DATOS dibujos_879E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 139, ficha 5 de la lista 0x6098 (p00:4595); lo leen p00:4531 (26
;   bytes)
;   0x879e..0x87b8  (26 bytes)
DATA_dibujos_879E:
	defb 081h,070h,003h,050h,086h,070h,0e0h,0f0h,090h,070h,070h,003h,050h,08bh,070h,0e0h	; 879e  .p.P.p...pp.P.p.
	defb 060h,070h,050h,050h,070h,070h,0f0h,0e0h,0b0h,000h	; 87ae  `pPPpp....

; ----------------------------------------------------------------------
; DATOS dibujos_87B8: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 2 de la lista 0x619A (p00:4595); lo leen p00:4531 (82
;   bytes)
;   0x87b8..0x880a  (82 bytes)
DATA_dibujos_87B8:
	defb 0d0h,000h,080h,060h,000h,040h,000h,086h,060h,000h,090h,080h,000h,075h,000h,098h	; 87b8  ...`.@..`....u..
	defb 060h,000h,080h,060h,000h,040h,000h,086h,060h,0e0h,060h,098h,060h,0e0h,060h,098h	; 87c8  `..`.@..`.`.`.`.
	defb 060h,060h,0e8h,086h,096h,096h,086h,0e8h,060h,0e0h,060h,098h,060h,0e0h,060h,098h	; 87d8  ``......`.`.`.`.
	defb 060h,080h,060h,086h,060h,080h,060h,086h,060h,060h,0e6h,0f0h,090h,086h,0e0h,0f0h	; 87e8  `.`.`.`.``......
	defb 096h,060h,0e6h,0f0h,090h,086h,0e0h,0f0h,096h,080h,060h,086h,060h,080h,060h,086h	; 87f8  .`........`.`.`.
	defb 060h,000h	; 8808

; ----------------------------------------------------------------------
; DATOS dibujos_880A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 161, ficha 3 de la lista 0x619A (p00:4595); lo leen p00:4531 (250
;   bytes)
;   0x880a..0x8904  (250 bytes)
DATA_dibujos_880A:
	defb 087h,0ach,0c0h,0c0h,020h,0a0h,0c0h,0f0h,017h,0c0h,092h,030h,000h,0cch,020h,000h	; 880a  .... ......0.. .
	defb 03ch,000h,0cch,033h,000h,0cch,020h,000h,03ch,000h,0cch,033h,000h,006h,0c0h,081h	; 881a  <..3.. .<..3....
	defb 030h,007h,0c0h,081h,02ch,007h,0c0h,084h,02ch,0c0h,000h,030h,007h,0c0h,091h,033h	; 882a  0...,...,..0...3
	defb 0cch,000h,03ch,000h,020h,0cch,000h,033h,0cch,000h,03ch,000h,020h,0c0h,0c0h,030h	; 883a  ..<. ..3..<. ..0
	defb 007h,0c0h,081h,02ch,007h,0c0h,081h,02ch,006h,0c0h,097h,000h,030h,0c0h,0e0h,0f0h	; 884a  ...,...,....0...
	defb 0e0h,0c0h,0c0h,000h,0c0h,030h,0f0h,030h,020h,0c0h,000h,000h,0c0h,03ch,0f3h,032h	; 885a  .....0.0 ....<.2
	defb 02ch,0c0h,003h,000h,089h,0c0h,030h,020h,0c0h,000h,000h,0c0h,0c0h,030h,005h,0c0h	; 886a  ,.....0 .....0..
	defb 081h,020h,006h,0c0h,083h,0e0h,0c0h,020h,003h,0c0h,081h,0a0h,004h,0c0h,083h,0b0h	; 887a  . ..... ........
	defb 0c0h,0b0h,004h,0c0h,084h,0f0h,030h,020h,030h,005h,0c0h,002h,0fch,002h,03ch,002h	; 888a  ......0 0.....<.
	defb 0c0h,096h,032h,030h,0bch,0e0h,0e0h,0bch,030h,032h,0a0h,030h,02ch,02ch,0c0h,0c0h	; 889a  ..20....02.0,,..
	defb 0ach,0c0h,000h,030h,020h,0c0h,0c0h,020h,004h,0c0h,0a9h,020h,0c0h,0c0h,020h,030h	; 88aa  ...0 .. ... .. 0
	defb 0c0h,0fah,0b0h,03ch,0fch,020h,0b0h,03ch,02ch,0fch,0f0h,0e0h,03ch,030h,0fch,02ch	; 88ba  ...<. .<,...<0.,
	defb 03ch,000h,0f0h,0c0h,0a0h,020h,0c0h,020h,0ach,000h,0f3h,0e2h,000h,03ch,000h,0bch	; 88ca  <.... . .....<..
	defb 0cch,000h,0b3h,022h,003h,0c0h,09ch,020h,0ach,0a0h,0f0h,0c0h,0a0h,020h,0c0h,0c0h	; 88da  ..."... ..... ..
	defb 0ach,0ach,020h,0c0h,020h,0a0h,0c0h,0f0h,000h,0cch,0bch,000h,03ch,000h,0e2h,0f3h	; 88ea  .. . .......<...
	defb 000h,0ach,020h,003h,0c0h,083h,022h,0b3h,000h,000h	; 88fa  .. ..."...

; ----------------------------------------------------------------------
; DATOS dibujos_8904: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x6106 (p00:4595); lo leen p00:4531 (327
;   bytes)
;   0x8904..0x8a4b  (327 bytes)
DATA_dibujos_8904:
	defb 002h,0f0h,003h,0feh,081h,0e0h,003h,040h,002h,0f0h,002h,0f4h,082h,0f0h,040h,005h	; 8904  .......@......@.
	defb 0f0h,002h,0feh,087h,0e0h,000h,0f0h,0e0h,0e0h,0f0h,0f0h,005h,0e0h,004h,0f0h,081h	; 8914  ................
	defb 0e0h,004h,0f0h,003h,0e0h,007h,0f0h,002h,0e0h,005h,0f0h,085h,0feh,0f0h,050h,000h	; 8924  ..............P.
	defb 0e0h,005h,0f0h,0b4h,050h,000h,0e5h,0e5h,0e0h,0e0h,050h,0feh,0e0h,000h,050h,040h	; 8934  ....P.....P...P@
	defb 0e0h,0f0h,0e0h,0f0h,0e0h,050h,0feh,054h,0f0h,0f0h,0e0h,0e0h,0f0h,050h,0f0h,040h	; 8944  .....P.T.....P.@
	defb 0e0h,0f0h,0f0h,0e0h,0f0h,050h,0f0h,040h,0e0h,0f0h,0e0h,0f0h,0e0h,050h,0f0h,054h	; 8954  .....P.@.....P.T
	defb 0e0h,0f0h,0f0h,0e0h,0f0h,050h,050h,0e0h,003h,0f0h,002h,0e0h,090h,050h,0f0h,0feh	; 8964  .....PP......P..
	defb 0feh,0e0h,0f0h,050h,0f0h,0e0h,0f0h,0feh,0f0h,0feh,050h,0f0h,0f0h,004h,0e0h,08eh	; 8974  ...P......P.....
	defb 0f0h,054h,0feh,0feh,0e5h,0f0h,0e0h,0e0h,0f0h,054h,0feh,0feh,0e5h,0f0h,007h,0feh	; 8984  .T.......T......
	defb 081h,0f0h,018h,0feh,005h,0e0h,003h,0feh,082h,0e0h,0f0h,005h,0feh,003h,0e0h,092h	; 8994  ................
	defb 0f0h,0e0h,0f0h,0f0h,0e0h,054h,0feh,0feh,0e0h,0ffh,0feh,0feh,0e0h,054h,0feh,0feh	; 89a4  .....T.......T..
	defb 0e0h,0f0h,005h,0feh,005h,0e0h,083h,0feh,000h,0e0h,003h,0f0h,002h,0e0h,004h,0f0h	; 89b4  ................
	defb 003h,0e0h,006h,0f0h,088h,0feh,0f0h,050h,0f0h,0f5h,0f5h,0feh,0f5h,004h,000h,084h	; 89c4  .......P........
	defb 0e5h,0e4h,0f4h,0e5h,004h,000h,083h,0f5h,0feh,0feh,005h,0e0h,084h,0e5h,0f5h,0feh	; 89d4  ................
	defb 0e5h,004h,000h,004h,0feh,004h,000h,084h,0e4h,0e5h,0f5h,0f4h,004h,000h,002h,0f5h	; 89e4  ................
	defb 081h,0e5h,005h,040h,004h,0e5h,008h,0e0h,002h,0f0h,002h,0feh,002h,0f0h,002h,0e0h	; 89f4  ...@............
	defb 002h,0f0h,082h,0f4h,0e4h,005h,000h,081h,0f5h,004h,0e0h,004h,0f0h,092h,0e0h,000h	; 8a04  ................
	defb 0f0h,0e0h,050h,0f0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0f0h,040h,0e4h	; 8a14  ..P...........@.
	defb 005h,0f0h,002h,0e0h,084h,040h,0f0h,0e0h,0e0h,003h,0f0h,002h,0feh,08bh,000h,0feh	; 8a24  .....@..........
	defb 0e0h,0f0h,000h,0f5h,0e5h,0e4h,000h,0feh,0e0h,003h,0f0h,085h,0e5h,0e0h,000h,0feh	; 8a34  ................
	defb 0e0h,003h,0f0h,082h,0feh,050h,000h	; 8a44

; ----------------------------------------------------------------------
; DATOS dibujos_8A4B: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 194, ficha 2 de la lista 0x6106 (p00:4595); lo leen p00:4531 (13
;   bytes)
;   0x8a4b..0x8a58  (13 bytes)
DATA_dibujos_8A4B:
	defb 00ch,0e0h,083h,0f0h,0e0h,0f0h,005h,0e0h,002h,0f0h,012h,0e0h,000h	; 8a4b  .............

; ----------------------------------------------------------------------
; DATOS dibujos_8A58: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 0 de la lista 0x6143 (p00:4595); lo leen p00:4531 (368
;   bytes)
;   0x8a58..0x8bc8  (368 bytes)
DATA_dibujos_8A58:
	defb 084h,0fah,0f0h,0fah,0fah,004h,000h,004h,0fah,07fh,080h,033h,080h,081h,098h,007h	; 8a58  ...........3....
	defb 080h,003h,090h,081h,060h,006h,080h,018h,098h,006h,080h,088h,098h,090h,080h,000h	; 8a68  ....`...........
	defb 090h,090h,080h,080h,005h,090h,004h,080h,081h,098h,008h,080h,08ah,060h,086h,086h	; 8a78  .............`..
	defb 098h,080h,098h,0a8h,098h,060h,086h,006h,098h,005h,0a9h,009h,0fah,081h,0f9h,006h	; 8a88  .....`..........
	defb 0a9h,002h,0fah,081h,0ffh,003h,0a9h,003h,0fah,083h,0ffh,0fah,0a9h,003h,0fah,084h	; 8a98  ................
	defb 0f9h,0fah,0ffh,0fah,005h,0a9h,003h,0fah,003h,0a9h,005h,0fah,007h,0a9h,081h,0fah	; 8aa8  ................
	defb 005h,0a9h,05bh,0fah,035h,0a9h,081h,098h,006h,0a9h,003h,098h,005h,0a9h,081h,0a8h	; 8ab8  ..[.5...........
	defb 003h,0a9h,003h,098h,002h,0a9h,003h,0fah,081h,098h,005h,0a9h,002h,0fah,003h,098h	; 8ac8  ................
	defb 002h,0a9h,003h,0fah,081h,0a9h,003h,0a8h,086h,0a9h,0fah,0a9h,0fah,0f9h,0f9h,004h	; 8ad8  ................
	defb 098h,08fh,0f9h,0a9h,086h,098h,0a9h,0a8h,0a9h,0a9h,0fah,0fah,0a6h,0a8h,0a9h,0a8h	; 8ae8  ................
	defb 0a9h,003h,0fah,003h,0a9h,085h,098h,0a8h,0a8h,098h,0a9h,003h,098h,005h,0a9h,083h	; 8af8  ................
	defb 098h,0a9h,098h,005h,0a9h,003h,0a8h,009h,098h,004h,0a9h,006h,098h,002h,0a9h,081h	; 8b08  ................
	defb 096h,004h,0a9h,003h,0fah,085h,060h,096h,098h,0a9h,0a9h,003h,0fah,083h,060h,080h	; 8b18  ......`.......`.
	defb 0a8h,003h,0a9h,002h,0fah,004h,0a9h,002h,098h,082h,080h,090h,003h,0a9h,085h,098h	; 8b28  ................
	defb 090h,080h,080h,000h,004h,0fah,084h,0f9h,098h,098h,090h,004h,0fah,002h,0a9h,082h	; 8b38  ................
	defb 098h,080h,003h,0a9h,002h,098h,083h,088h,080h,090h,006h,080h,002h,0a8h,002h,080h	; 8b48  ................
	defb 083h,0a8h,080h,080h,003h,0a8h,002h,098h,083h,0a8h,080h,080h,004h,098h,081h,0f8h	; 8b58  ................
	defb 003h,0a8h,007h,080h,002h,098h,08ah,0a8h,0a9h,090h,080h,098h,098h,0a9h,098h,0a9h	; 8b68  ................
	defb 0a9h,005h,080h,002h,0a8h,085h,0a9h,080h,090h,098h,0a9h,004h,0fah,084h,080h,090h	; 8b78  ................
	defb 098h,0a9h,004h,0fah,003h,080h,085h,0a8h,098h,0a9h,0fah,0a9h,007h,0a8h,081h,098h	; 8b88  ................
	defb 008h,080h,002h,0a9h,081h,0fah,004h,0a9h,081h,098h,004h,0fah,004h,0a9h,004h,0fah	; 8b98  ................
	defb 007h,0a9h,084h,098h,0a9h,098h,098h,003h,080h,002h,098h,00ch,080h,081h,090h,007h	; 8ba8  ................
	defb 080h,002h,0a9h,081h,098h,005h,080h,002h,098h,009h,080h,081h,090h,004h,080h,000h	; 8bb8  ................

; ----------------------------------------------------------------------
; DATOS ceros_8BC8: 3 ceros entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (3 bytes)
;   0x8bc8..0x8bcb  (3 bytes)
DATA_ceros_8BC8:
	defb 000h,000h,000h	; 8bc8

; ----------------------------------------------------------------------
; DATOS dibujos_8BCB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 121, ficha 3 de la lista 0x60DB (p00:4595); lo leen p00:4531 (104
;   bytes)
;   0x8bcb..0x8c33  (104 bytes)
DATA_dibujos_8BCB:
	defb 084h,0c0h,030h,020h,020h,004h,0c0h,002h,020h,006h,0c0h,003h,020h,005h,0c0h,082h	; 8bcb  ..0  ... ... ...
	defb 020h,0c0h,003h,020h,003h,0c0h,002h,030h,002h,020h,004h,0c0h,002h,020h,004h,0c0h	; 8bdb   .. ...0. ... ..
	defb 081h,000h,006h,0c0h,081h,020h,003h,0c0h,003h,020h,004h,0c0h,003h,020h,005h,0c0h	; 8beb  ..... ... ... ..
	defb 002h,020h,003h,0c0h,002h,020h,08ch,0c0h,020h,020h,030h,030h,020h,020h,0c0h,0c0h	; 8bfb  . ... ..  00  ..
	defb 020h,0c0h,020h,005h,0c0h,002h,020h,008h,0c0h,081h,020h,005h,0c0h,085h,030h,020h	; 8c0b   . ... ... ...0
	defb 0c0h,0c0h,020h,003h,0c0h,002h,030h,002h,020h,007h,0c0h,002h,030h,085h,020h,0c0h	; 8c1b  .. ...0. ...0. .
	defb 0c0h,030h,020h,005h,0c0h,081h,020h,000h	; 8c2b  .0 ... .

; ----------------------------------------------------------------------
; DATOS dibujos_8C33: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 4 de la lista 0x60DB (p00:4595); lo leen p00:4531 (50
;   bytes)
;   0x8c33..0x8c65  (50 bytes)
DATA_dibujos_8C33:
	defb 003h,0c0h,002h,020h,003h,0c0h,002h,030h,003h,020h,003h,0c0h,084h,020h,030h,030h	; 8c33  ... ...0. ... 00
	defb 020h,005h,0c0h,002h,030h,081h,020h,003h,0c0h,083h,030h,0c0h,0c0h,003h,020h,002h	; 8c43   ...0. ...0... .
	defb 0c0h,081h,0c2h,007h,0c0h,083h,020h,030h,020h,005h,0c0h,003h,020h,004h,0c0h,002h	; 8c53  ...... 0 ... ...
	defb 020h,000h	; 8c63

; ----------------------------------------------------------------------
; DATOS dibujos_8C65: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 175, ficha 5 de la lista 0x60DB (p00:4595); lo leen p00:4531 (32
;   bytes)
;   0x8c65..0x8c85  (32 bytes)
DATA_dibujos_8C65:
	defb 002h,060h,002h,080h,002h,090h,004h,0a0h,08ch,090h,080h,060h,080h,090h,080h,0a0h	; 8c65  .`.........`....
	defb 0a0h,090h,090h,080h,080h,003h,060h,087h,080h,090h,090h,0b0h,0a0h,090h,080h,000h	; 8c75  ......`.........

; ----------------------------------------------------------------------
; DATOS dibujos_8C85: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 179, ficha 6 de la lista 0x60DB (p00:4595); lo leen p00:4531 (23
;   bytes)
;   0x8c85..0x8c9c  (23 bytes)
DATA_dibujos_8C85:
	defb 003h,0c0h,002h,020h,002h,0c0h,081h,030h,003h,0c0h,081h,000h,003h,0c0h,002h,030h	; 8c85  ... ...0.......0
	defb 081h,020h,005h,0c0h,081h,020h,000h	; 8c95

; ----------------------------------------------------------------------
; DATOS ceros_8C9C: 5 ceros entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (5 bytes)
;   0x8c9c..0x8ca1  (5 bytes)
DATA_ceros_8C9C:
	defb 000h,000h,000h,000h,000h	; 8c9c

; ----------------------------------------------------------------------
; DATOS dibujos_8CA1: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 31, ficha 3 de la lista 0x616F (p00:4595); lo leen p00:4531 (269
;   bytes)
;   0x8ca1..0x8dae  (269 bytes)
DATA_dibujos_8CA1:
	defb 002h,0f6h,081h,0f9h,004h,0b9h,085h,0a6h,065h,0f6h,0f6h,0f9h,003h,0b9h,084h,0a6h	; 8ca1  ........e.......
	defb 065h,0f6h,0f6h,003h,0b9h,088h,0b6h,0a6h,065h,0f6h,0f6h,0f9h,0b9h,0b9h,003h,0a6h	; 8cb1  e.......e.......
	defb 0a1h,096h,0a9h,0a6h,0f6h,0a9h,096h,060h,0a6h,096h,0f6h,0f9h,0a9h,096h,096h,060h	; 8cc1  .......`.......`
	defb 096h,096h,0a6h,0f6h,096h,096h,0a6h,060h,060h,096h,0a6h,0f6h,0a9h,096h,096h,060h	; 8cd1  .......``......`
	defb 080h,080h,006h,090h,089h,087h,085h,065h,096h,0f9h,0f9h,0a9h,098h,0a8h,005h,080h	; 8ce1  .......e........
	defb 002h,090h,004h,065h,002h,0f8h,098h,0b8h,0a8h,065h,098h,0a8h,0f8h,0a8h,0b8h,0b8h	; 8cf1  ...e.....e......
	defb 0a8h,064h,096h,0a6h,0f6h,0a9h,096h,096h,064h,0f8h,0f8h,0b8h,0a8h,064h,064h,005h	; 8d01  .d......d....dd.
	defb 040h,082h,054h,074h,003h,054h,084h,064h,074h,0f4h,074h,005h,040h,08bh,070h,040h	; 8d11  @.Tt.T.dt.t.@.p@
	defb 070h,050h,050h,040h,050h,0f8h,0b8h,0b8h,0a8h,003h,080h,081h,090h,003h,0a8h,004h	; 8d21  pPP@P...........
	defb 080h,081h,090h,003h,084h,08bh,0f8h,0b8h,0b8h,0a8h,0a8h,050h,054h,074h,054h,085h	; 8d31  ...........PTtT.
	defb 085h,005h,0f8h,002h,0b8h,081h,0a8h,004h,080h,008h,090h,086h,040h,060h,050h,050h	; 8d41  ............@`PP
	defb 070h,070h,003h,064h,081h,0a6h,004h,000h,003h,0b6h,081h,0a6h,005h,080h,089h,084h	; 8d51  pp.d............
	defb 076h,064h,065h,084h,085h,098h,074h,074h,003h,065h,084h,096h,0f6h,0b8h,0a8h,009h	; 8d61  vde...tt.e......
	defb 080h,006h,090h,08bh,064h,084h,084h,094h,0f4h,0a4h,094h,094h,040h,040h,060h,004h	; 8d71  ....d.......@@`.
	defb 084h,085h,094h,0b4h,094h,084h,084h,003h,085h,08bh,065h,094h,084h,094h,085h,085h	; 8d81  ..........e.....
	defb 065h,085h,065h,094h,094h,003h,095h,003h,085h,004h,094h,081h,0f5h,003h,065h,006h	; 8d91  e.e...........e.
	defb 084h,08ah,085h,065h,094h,084h,094h,084h,084h,065h,084h,064h,000h	; 8da1  ...e.....e.d.

; ----------------------------------------------------------------------
; DATOS dibujos_8DAE: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 83, ficha 4 de la lista 0x616F (p00:4595); lo leen p00:4531 (190
;   bytes)
;   0x8dae..0x8e6c  (190 bytes)
DATA_dibujos_8DAE:
	defb 002h,040h,0b2h,060h,064h,084h,094h,0f4h,0a4h,0b5h,0b5h,0f4h,0f4h,0b4h,0a4h,050h	; 8dae  .@.`d..........P
	defb 050h,0f5h,0a4h,0a4h,0f4h,0f4h,0b4h,0a4h,050h,0f0h,070h,050h,040h,050h,040h,0b5h	; 8dbe  P.......P.pP@P@.
	defb 0b5h,070h,070h,050h,050h,040h,0a4h,0f5h,0f4h,070h,070h,050h,040h,050h,070h,0f0h	; 8dce  .ppPP@...ppP@Pp.
	defb 0f0h,0b4h,064h,094h,094h,003h,040h,082h,050h,075h,004h,074h,002h,0f4h,094h,0f0h	; 8dde  ..d...@.Pu.t....
	defb 064h,084h,094h,0a4h,084h,080h,090h,040h,065h,085h,094h,094h,084h,084h,094h,090h	; 8dee  d......@e.......
	defb 0a8h,085h,085h,004h,084h,081h,094h,003h,0f8h,002h,0b8h,08ch,0a8h,085h,085h,064h	; 8dfe  ...............d
	defb 0a6h,0f6h,0b6h,0a6h,076h,076h,075h,0a8h,004h,085h,087h,084h,040h,040h,065h,085h	; 8e0e  ....vvu.....@@e.
	defb 094h,094h,004h,040h,08ah,070h,0f4h,0f5h,0fah,0f9h,0f5h,0f4h,070h,065h,085h,003h	; 8e1e  ...@.p......pe..
	defb 094h,086h,084h,050h,050h,095h,064h,084h,003h,094h,099h,084h,050h,0f0h,070h,050h	; 8e2e  ...PP.d.....P.pP
	defb 040h,050h,040h,065h,085h,070h,070h,050h,050h,040h,064h,085h,094h,0c0h,0c0h,020h	; 8e3e  @P@e.ppPP@d....
	defb 0f2h,032h,020h,020h,003h,0c0h,096h,020h,032h,032h,020h,020h,0c0h,040h,050h,070h	; 8e4e  .2  ... 22  .@Pp
	defb 0f7h,0f7h,070h,050h,040h,0c0h,0c0h,020h,032h,032h,020h,020h,0c0h,000h	; 8e5e  ..pP@.. 22  ..

; ----------------------------------------------------------------------
; DATOS dibujos_8E6C: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 169, ficha 5 de la lista 0x616F (p00:4595); lo leen p00:4531 (163
;   bytes)
;   0x8e6c..0x8f0f  (163 bytes)
DATA_dibujos_8E6C:
	defb 008h,040h,003h,070h,081h,040h,003h,050h,081h,070h,008h,040h,002h,094h,085h,090h	; 8e6c  .@.p.@.P.p.@....
	defb 080h,080h,040h,050h,004h,040h,083h,050h,040h,050h,00ah,040h,002h,0b0h,002h,0f0h	; 8e7c  ..@P.@.P@P.@....
	defb 002h,070h,002h,050h,083h,0b0h,0f0h,0f0h,005h,070h,004h,040h,083h,070h,050h,050h	; 8e8c  .p.P.....p.@.pPP
	defb 005h,040h,004h,084h,082h,080h,050h,009h,040h,086h,050h,040h,040h,050h,040h,050h	; 8e9c  .@....P.@.P@@P@P
	defb 003h,040h,081h,050h,007h,040h,004h,084h,008h,040h,081h,070h,003h,050h,007h,040h	; 8eac  .@.P.@...@.p.P.@
	defb 003h,084h,082h,085h,065h,004h,040h,004h,084h,002h,050h,006h,040h,002h,050h,003h	; 8ebc  ....e.@...P.@.P.
	defb 040h,002h,094h,085h,0f4h,060h,080h,090h,0a0h,004h,050h,008h,090h,004h,040h,087h	; 8ecc  @....`....P...@.
	defb 070h,050h,070h,050h,070h,040h,040h,004h,080h,081h,060h,005h,090h,093h,080h,084h	; 8edc  pPpPp@@...`.....
	defb 084h,090h,080h,090h,080h,080h,065h,084h,064h,050h,070h,050h,060h,080h,090h,070h	; 8eec  ......e.dPpP`..p
	defb 040h,004h,070h,082h,050h,070h,004h,050h,006h,070h,081h,060h,003h,090h,081h,070h	; 8efc  @.p.Pp.P.p.`...p
	defb 003h,040h,000h	; 8f0c

; ----------------------------------------------------------------------
; DATOS dibujos_8F0F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 9, ficha 2 de la lista 0x616F (p00:4595); lo leen p00:4531 (18
;   bytes)
;   0x8f0f..0x8f21  (18 bytes)
DATA_dibujos_8F0F:
	defb 002h,050h,08eh,090h,0e0h,050h,070h,095h,064h,0a0h,0a0h,0f4h,0c0h,060h,080h,094h	; 8f0f  .P...Pp.d....`..
	defb 064h,000h	; 8f1f

; ----------------------------------------------------------------------
; DATOS ceros_8F21: 1 cero entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (1 bytes)
;   0x8f21..0x8f22  (1 bytes)
DATA_ceros_8F21:
	defb 000h	; 8f21

; ----------------------------------------------------------------------
; DATOS dibujos_8F22: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 17, ficha 8 de la lista 0x619A (p00:4595); lo leen p00:4531 (79
;   bytes)
;   0x8f22..0x8f71  (79 bytes)
DATA_dibujos_8F22:
	defb 003h,0b0h,083h,040h,050h,070h,004h,0d0h,088h,060h,0a0h,080h,060h,090h,060h,076h	; 8f22  ...@Pp...`..`.`v
	defb 050h,003h,040h,081h,085h,003h,040h,0b1h,050h,040h,000h,060h,080h,090h,0a0h,050h	; 8f32  P.@...@.P@.`...P
	defb 070h,070h,0d0h,060h,050h,090h,0e0h,080h,060h,090h,060h,076h,050h,040h,040h,0c0h	; 8f42  pp.`P...`.`vP@@.
	defb 0f4h,0a0h,040h,040h,050h,040h,040h,060h,080h,094h,064h,064h,094h,080h,060h,050h	; 8f52  ..@@P@@`..dd..`P
	defb 070h,095h,064h,064h,095h,070h,050h,040h,085h,004h,040h,082h,085h,040h,000h	; 8f62  p.dd.pP@..@..@.

; ----------------------------------------------------------------------
; DATOS dibujos_8F71: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 9 de la lista 0x619A (p00:4595); lo leen p00:4531 (10
;   bytes)
;   0x8f71..0x8f7b  (10 bytes)
DATA_dibujos_8F71:
	defb 088h,060h,080h,090h,0a0h,0a0h,090h,080h,060h,000h	; 8f71  .`......`.

; ----------------------------------------------------------------------
; DATOS dibujos_8F7B: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 5, ficha 6 de la lista 0x619A (p00:4595); lo leen p00:4531 (22
;   bytes)
;   0x8f7b..0x8f91  (22 bytes)
DATA_dibujos_8F7B:
	defb 007h,0b0h,004h,040h,004h,060h,081h,0a0h,004h,000h,083h,064h,094h,080h,004h,060h	; 8f7b  ...@.`.....d...`
	defb 003h,0a0h,082h,0f4h,0c0h,000h	; 8f8b

; ----------------------------------------------------------------------
; DATOS dibujos_8F91: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 147, ficha 6 de la lista 0x6106 (p00:4595); lo leen p00:4531 (28
;   bytes)
;   0x8f91..0x8fad  (28 bytes)
DATA_dibujos_8F91:
	defb 003h,0f0h,002h,070h,083h,040h,0f0h,040h,010h,0f0h,088h,070h,0f0h,0e0h,0f0h,090h	; 8f91  ...p.@.@...p....
	defb 060h,0f0h,050h,003h,0f0h,002h,070h,002h,0f4h,081h,0f0h,000h	; 8fa1  `.P...p.....

; ----------------------------------------------------------------------
; DATOS dibujos_8FAD: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 27, ficha 10 de la lista 0x619A (p00:4595); lo leen p00:4531 (33
;   bytes)
;   0x8fad..0x8fce  (33 bytes)
DATA_dibujos_8FAD:
	defb 086h,050h,070h,0d0h,070h,0f0h,090h,004h,080h,092h,090h,0f0h,070h,0d0h,070h,050h	; 8fad  .Pp.p.......p.pP
	defb 075h,060h,060h,080h,080h,0a8h,0f8h,0a8h,0a8h,098h,098h,080h,003h,060h,081h,075h	; 8fbd  u``..........`.u
	defb 000h	; 8fcd

; ----------------------------------------------------------------------
; DATOS dibujos_8FCE: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 92, ficha 5 de la lista 0x6106 (p00:4595); lo leen p00:4531 (27
;   bytes)
;   0x8fce..0x8fe9  (27 bytes)
DATA_dibujos_8FCE:
	defb 003h,0c0h,004h,030h,082h,0c0h,020h,007h,030h,002h,0c0h,081h,030h,003h,0c0h,08ah	; 8fce  ...0.. .0...0...
	defb 0e0h,0efh,0c0h,030h,030h,0c0h,0c0h,0e0h,0e0h,0efh,000h	; 8fde  ...00......

; ----------------------------------------------------------------------
; DATOS dibujos_8FE9: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 52, ficha 10 de la lista 0x6098 (p00:4595); lo leen p00:4531 (27
;   bytes)
;   0x8fe9..0x9004  (27 bytes)
DATA_dibujos_8FE9:
	defb 003h,0c0h,004h,030h,082h,0c0h,020h,007h,030h,002h,0c0h,081h,030h,003h,0c0h,08ah	; 8fe9  ...0.. .0...0...
	defb 050h,054h,0c0h,030h,030h,0c0h,0c0h,050h,050h,054h,000h	; 8ff9  PT.00..PPT.

; ----------------------------------------------------------------------
; DATOS dibujos_9004: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 96, ficha 1 de la lista 0x6106 (p00:4595); lo leen p00:4531 (53
;   bytes)
;   0x9004..0x9039  (53 bytes)
DATA_dibujos_9004:
	defb 081h,050h,005h,0f0h,081h,040h,004h,0f0h,0a5h,0f5h,0feh,0feh,0e0h,0e0h,0feh,054h	; 9004  .P...@.........T
	defb 0f0h,0f0h,0e0h,0e0h,0f0h,050h,0f0h,040h,0f0h,0f0h,0e0h,0e0h,0f0h,050h,0feh,054h	; 9014  .....P.@.....P.T
	defb 0f0h,0f0h,0e0h,0e0h,0f0h,050h,0feh,040h,0f0h,0f0h,0e0h,0e0h,0f0h,050h,003h,0f0h	; 9024  .....P.@.....P..
	defb 003h,0e0h,002h,040h,000h	; 9034

; ----------------------------------------------------------------------
; DATOS dibujos_9039: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 115, ficha 0 de la lista 0x616F (p00:4595); lo leen p00:4531 (29
;   bytes)
;   0x9039..0x9056  (29 bytes)
DATA_dibujos_9039:
	defb 088h,000h,0f0h,0f0h,0a0h,0f0h,0a0h,090h,090h,004h,0a0h,015h,090h,002h,080h,003h	; 9039  ................
	defb 060h,082h,064h,084h,003h,080h,085h,066h,060h,064h,084h,064h,000h	; 9049  `.d....f`d.d.

; ----------------------------------------------------------------------
; DATOS ceros_9056: 1 cero entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (1 bytes)
;   0x9056..0x9057  (1 bytes)
DATA_ceros_9056:
	defb 000h	; 9056

; ----------------------------------------------------------------------
; DATOS dibujos_9057: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 127, ficha 1 de la lista 0x616F (p00:4595); lo leen p00:4531 (29
;   bytes)
;   0x9057..0x9074  (29 bytes)
DATA_dibujos_9057:
	defb 088h,000h,0f0h,0f0h,0a0h,0f0h,0a0h,030h,030h,004h,0a0h,015h,030h,002h,020h,003h	; 9057  .......00...0. .
	defb 0c0h,082h,064h,084h,003h,020h,085h,0cch,0c0h,064h,084h,064h,000h	; 9067  ..d.. ...d.d.

; ----------------------------------------------------------------------
; DATOS rachas_9074: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (36 bytes)
;   0x9074..0x9098  (36 bytes)
DATA_rachas_9074:
	defb 004h,0c0h,083h,0c8h,0c0h,020h,006h,0c0h,083h,020h,0c0h,020h,008h,0c0h,081h,080h	; 9074  ..... ... . ....
	defb 010h,0c0h,083h,050h,0f0h,020h,004h,0c0h,084h,040h,0f5h,0f5h,074h,006h,040h,081h	; 9084  ...P. ...@..t.@.
	defb 074h,005h,040h,000h	; 9094

; ----------------------------------------------------------------------
; DATOS armas_9098: 7 pares de punteros (C de 1 a 7 en p00:4319: la tabla
;   empieza en 0x9094 + 4, y lo de 0x9094 es el final de las rachas de
;   0x9074): dibujos (VRAM 0x2748) y colores (0x0748) en los tres tercios; lo
;   leen p00:431F (28 bytes)
;   0x9098..0x90b4  (28 bytes)
DATA_armas_9098:
	defw 090b4h,090d6h	; 9098  -> DATA_dibujos_1 DATA_colores_1
	defw 090e5h,09107h	; 909c  -> DATA_dibujos_2 DATA_colores_2
	defw 0911eh,0913eh	; 90a0  -> DATA_dibujos_3 DATA_colores_3
	defw 09152h,09174h	; 90a4  -> DATA_dibujos_4 DATA_colores_4
	defw 09192h,091b2h	; 90a8  -> DATA_dibujos_5 DATA_colores_5
	defw 091c9h,091ebh	; 90ac  -> DATA_dibujos_6 DATA_colores_6
	defw 091f6h,09218h	; 90b0  -> DATA_dibujos_7 DATA_colores_7

; ----------------------------------------------------------------------
; DATOS dibujos_1: rachas (p00:4A5B, los tres tercios) con los dibujos del 1
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (34 bytes)
;   0x90b4..0x90d6  (34 bytes)
DATA_dibujos_1:
	defb 0a0h,000h,007h,03fh,080h,00ch,01ch,03eh,07fh,0e0h,0f0h,0d8h,024h,0b2h,050h,006h	; 90b4  ...?...>....$.P.
	defb 02fh,03eh,01ch,00ch,080h,03fh,007h,000h,000h,006h,050h,092h,024h,098h,0f0h,0e0h	; 90c4  />...?....P.$...
	defb 000h,000h	; 90d4

; ----------------------------------------------------------------------
; DATOS colores_1: rachas (p00:4A5B, los tres tercios) con los colores del 1
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (15 bytes)
;   0x90d6..0x90e5  (15 bytes)
DATA_colores_1:
	defb 004h,0e0h,083h,0c0h,020h,0b0h,009h,0e0h,083h,0b0h,020h,0c0h,00dh,0e0h,000h	; 90d6  .... ..... ....

; ----------------------------------------------------------------------
; DATOS dibujos_2: rachas (p00:4A5B, los tres tercios) con los dibujos del 2
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (34 bytes)
;   0x90e5..0x9107  (34 bytes)
DATA_dibujos_2:
	defb 0a0h,006h,00ch,019h,019h,022h,005h,025h,035h,060h,030h,098h,098h,044h,0a0h,0a4h	; 90e5  .....".%5`0..D..
	defb 0ach,035h,025h,005h,022h,019h,019h,00ch,006h,0ach,0a4h,0a0h,044h,098h,098h,030h	; 90f5  .5%.".......D..0
	defb 060h,000h	; 9105

; ----------------------------------------------------------------------
; DATOS colores_2: rachas (p00:4A5B, los tres tercios) con los colores del 2
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (23 bytes)
;   0x9107..0x911e  (23 bytes)
DATA_colores_2:
	defb 002h,090h,005h,0b0h,083h,0f0h,090h,090h,005h,0b0h,002h,0f0h,005h,0b0h,002h,090h	; 9107  ................
	defb 081h,0f0h,005h,0b0h,002h,090h,000h	; 9117

; ----------------------------------------------------------------------
; DATOS dibujos_3: rachas (p00:4A5B, los tres tercios) con los dibujos del 3
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (32 bytes)
;   0x911e..0x913e  (32 bytes)
DATA_dibujos_3:
	defb 003h,000h,085h,079h,0fch,001h,078h,0fdh,003h,000h,08ah,09eh,03fh,080h,01eh,0bfh	; 911e  ...y..x.....?...
	defb 0fdh,078h,001h,0fch,079h,003h,000h,085h,0bfh,01eh,080h,03fh,09eh,003h,000h,000h	; 912e  .x..y......?....

; ----------------------------------------------------------------------
; DATOS colores_3: rachas (p00:4A5B, los tres tercios) con los colores del 3
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (20 bytes)
;   0x913e..0x9152  (20 bytes)
DATA_colores_3:
	defb 006h,0f0h,082h,0c0h,0a0h,006h,0f0h,084h,0c0h,0a0h,0a0h,0c0h,006h,0f0h,082h,0a0h	; 913e  ................
	defb 0c0h,006h,0f0h,000h	; 914e

; ----------------------------------------------------------------------
; DATOS dibujos_4: rachas (p00:4A5B, los tres tercios) con los dibujos del 4
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (34 bytes)
;   0x9152..0x9174  (34 bytes)
DATA_dibujos_4:
	defb 0a0h,003h,007h,000h,011h,053h,058h,0d3h,0d7h,0c0h,0e0h,000h,088h,0cah,01ah,0cbh	; 9152  .....SX.........
	defb 0ebh,0d7h,0d3h,058h,053h,011h,000h,007h,003h,0ebh,0cbh,01ah,0cah,088h,000h,0e0h	; 9162  ...XS...........
	defb 0c0h,000h	; 9172

; ----------------------------------------------------------------------
; DATOS colores_4: rachas (p00:4A5B, los tres tercios) con los colores del 4
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (30 bytes)
;   0x9174..0x9192  (30 bytes)
DATA_colores_4:
	defb 082h,070h,050h,004h,0f0h,084h,050h,070h,070h,050h,004h,0f0h,084h,050h,070h,070h	; 9174  .pP...PppP...Ppp
	defb 050h,004h,0f0h,084h,050h,070h,070h,050h,004h,0f0h,082h,050h,070h,000h	; 9184  P...PppP...Pp.

; ----------------------------------------------------------------------
; DATOS dibujos_5: rachas (p00:4A5B, los tres tercios) con los dibujos del 5
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (32 bytes)
;   0x9192..0x91b2  (32 bytes)
DATA_dibujos_5:
	defb 003h,000h,085h,012h,020h,067h,000h,09fh,003h,000h,08ah,048h,004h,0e6h,000h,0f9h	; 9192  .... g.....H....
	defb 09fh,000h,067h,020h,012h,003h,000h,085h,0f9h,000h,0e6h,004h,048h,003h,000h,000h	; 91a2  ..g ........H...

; ----------------------------------------------------------------------
; DATOS colores_5: rachas (p00:4A5B, los tres tercios) con los colores del 5
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (23 bytes)
;   0x91b2..0x91c9  (23 bytes)
DATA_colores_5:
	defb 003h,0f0h,083h,0e0h,0f0h,0e0h,005h,0f0h,083h,0e0h,0f0h,0e0h,004h,0f0h,003h,0e0h	; 91b2  ................
	defb 005h,0f0h,003h,0e0h,003h,0f0h,000h	; 91c2

; ----------------------------------------------------------------------
; DATOS dibujos_6: rachas (p00:4A5B, los tres tercios) con los dibujos del 6
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (34 bytes)
;   0x91c9..0x91eb  (34 bytes)
DATA_dibujos_6:
	defb 0a0h,040h,030h,038h,015h,000h,00bh,034h,076h,001h,006h,08eh,0d4h,000h,0e8h,016h	; 91c9  .@08...4v.......
	defb 0b7h,034h,00bh,000h,015h,038h,030h,040h,000h,016h,0e8h,000h,0d4h,08eh,006h,001h	; 91d9  .4...80@........
	defb 000h,000h	; 91e9

; ----------------------------------------------------------------------
; DATOS colores_6: rachas (p00:4A5B, los tres tercios) con los colores del 6
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (11 bytes)
;   0x91eb..0x91f6  (11 bytes)
DATA_colores_6:
	defb 007h,0e0h,081h,060h,007h,0e0h,081h,060h,010h,0e0h,000h	; 91eb  ...`...`...

; ----------------------------------------------------------------------
; DATOS dibujos_7: rachas (p00:4A5B, los tres tercios) con los dibujos del 7
;   (C de p00:4319) a la VRAM 0x2748; lo leen p00:4329 (34 bytes)
;   0x91f6..0x9218  (34 bytes)
DATA_dibujos_7:
	defb 0a0h,000h,040h,03fh,01fh,000h,00ch,021h,094h,000h,002h,0fch,0f8h,000h,030h,084h	; 91f6  ..@?...!......0.
	defb 029h,0d6h,094h,021h,00ch,000h,01fh,03fh,040h,06bh,029h,084h,030h,000h,0f8h,0fch	; 9206  )..!...?@k).0...
	defb 002h,000h	; 9216

; ----------------------------------------------------------------------
; DATOS colores_7: rachas (p00:4A5B, los tres tercios) con los colores del 7
;   (C de p00:4319) a la VRAM 0x0748; lo leen p00:4334 (34 bytes)
;   0x9218..0x923a  (34 bytes)
DATA_colores_7:
	defb 0a0h,0f0h,040h,040h,050h,0f0h,050h,070h,070h,0f0h,040h,040h,050h,0f0h,050h,070h	; 9218  ..@@P.Ppp.@@P.Pp
	defb 070h,0f0h,070h,070h,050h,0f0h,050h,040h,040h,0f0h,070h,070h,050h,0f0h,050h,040h	; 9228  p.ppP.P@@.ppP.P@
	defb 040h,000h	; 9238

; ----------------------------------------------------------------------
; DATOS colores_923A: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 199, ficha 0 de la lista 0x4358 (p00:4595); lo leen p00:4350 (34
;   bytes)
;   0x923a..0x925c  (34 bytes)
DATA_colores_923A:
	defb 0a0h,000h,03ch,040h,08fh,0a0h,003h,04fh,09fh,000h,03ch,002h,0f1h,005h,0c0h,0f2h	; 923a  ..<@...O..<.....
	defb 0f9h,09fh,04fh,003h,0a0h,08fh,040h,03ch,000h,0f9h,0f2h,0c0h,005h,0f1h,002h,03ch	; 924a  ..O...@<.......<
	defb 000h,000h	; 925a

; ----------------------------------------------------------------------
; DATOS dibujos_925C: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 199, ficha 0 de la lista 0x4358 (p00:4595); lo leen p00:4350 (23
;   bytes)
;   0x925c..0x9273  (23 bytes)
DATA_dibujos_925C:
	defb 005h,0f0h,002h,050h,081h,070h,005h,0f0h,002h,050h,002h,070h,002h,050h,005h,0f0h	; 925c  ...P.p...P.p.P..
	defb 083h,070h,050h,050h,005h,0f0h,000h	; 926c

; ----------------------------------------------------------------------
; DATOS dibujos_9273: 8 caracteres de dibujo (8 bytes cada uno) que no lee
;   nadie a la vista: no son rachas ni los apunta ninguna palabra del
;   cartucho; lo leen nadie (64 bytes)
;   0x9273..0x92b3  (64 bytes)
DATA_dibujos_9273:
	defb 000h,010h,028h,028h,028h,028h,010h,000h	; 9273  ..((((..
	defb 000h,000h,000h,010h,010h,000h,000h,000h	; 927b  ........
	defb 000h,000h,008h,020h,004h,010h,000h,000h	; 9283  ... ....
	defb 000h,008h,000h,080h,000h,002h,000h,020h	; 928b  .......
	defb 000h,020h,020h,020h,020h,020h,020h,000h	; 9293  .      .
	defb 000h,000h,000h,070h,070h,000h,000h,000h	; 929b  ...pp...
	defb 000h,000h,0b0h,0b0h,0a0h,0a0h,000h,000h	; 92a3  ........
	defb 000h,0f0h,000h,0f0h,000h,0a0h,000h,0a0h	; 92ab  ........

; ----------------------------------------------------------------------
; DATOS rachas_por_fase_92B3: 12 punteros, uno por fase (0xE201): listas
;   [n][rachas] de p00:44D1, que p00:44C7 lee con L_4B67; lo leen p00:44CD (24
;   bytes)
;   0x92b3..0x92cb  (24 bytes)
DATA_rachas_por_fase_92B3:
	defw 0933eh,092cbh,092deh,092e8h,0930eh,092f8h	; 92b3
	defw 09327h,09337h,0933ah,092e5h,092e5h,092e5h	; 92bf

; ----------------------------------------------------------------------
; DATOS lista_44D1_92CB: lista de p00:44D1 de la fase 1: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (19 bytes)
;   0x92cb..0x92de  (19 bytes)
DATA_lista_44D1_92CB:
	defb 0a4h,0a0h,09bh	; 92cb
	defb 0c4h,0a0h,098h	; 92ce
	defb 0dch,087h,097h	; 92d1
	defb 0ech,032h,09bh	; 92d4
	defb 0f0h,006h,098h	; 92d7
	defb 0f8h,0d1h,09ah	; 92da
	defb 000h	; 92dd

; ----------------------------------------------------------------------
; DATOS lista_44D1_92DE: lista de p00:44D1 de la fase 2: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (7 bytes)
;   0x92de..0x92e5  (7 bytes)
DATA_lista_44D1_92DE:
	defb 0b4h,048h,098h	; 92de
	defb 0c4h,0a0h,098h	; 92e1
	defb 000h	; 92e4

; ----------------------------------------------------------------------
; DATOS lista_44D1_92E5: lista de p00:44D1 de las fases 9, 10, 11: [n][rachas
;   lo hi] y 0 acaba; se solapan 2 bloques: (lista_44D1_92E8 92E8-92F8); lo
;   leen p00:44D1 (19 bytes)
;   0x92e5..0x92f8  (19 bytes)
DATA_lista_44D1_92E5:
	defb 094h,0b6h,0a0h	; 92e5
	defb 07ch,053h,099h	; 92e8
	defb 0e0h,087h,097h	; 92eb
	defb 0ech,002h,099h	; 92ee
	defb 074h,0d1h,09ah	; 92f1
	defb 0fch,013h,09bh	; 92f4
	defb 000h	; 92f7

; ----------------------------------------------------------------------
; DATOS lista_44D1_92F8: lista de p00:44D1 de la fase 5: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (22 bytes)
;   0x92f8..0x930e  (22 bytes)
DATA_lista_44D1_92F8:
	defb 074h,0a0h,09bh	; 92f8
	defb 0a4h,002h,099h	; 92fb
	defb 0b4h,048h,098h	; 92fe
	defb 090h,053h,099h	; 9301
	defb 0d0h,04dh,09bh	; 9304
	defb 0dch,022h,09ah	; 9307
	defb 0f4h,0e4h,099h	; 930a
	defb 000h	; 930d

; ----------------------------------------------------------------------
; DATOS lista_44D1_930E: lista de p00:44D1 de la fase 4: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (25 bytes)
;   0x930e..0x9327  (25 bytes)
DATA_lista_44D1_930E:
	defb 074h,0a0h,09bh	; 930e
	defb 0a4h,032h,09bh	; 9311
	defb 084h,048h,098h	; 9314
	defb 0b4h,053h,099h	; 9317
	defb 0d4h,07eh,09ah	; 931a
	defb 0ech,002h,099h	; 931d
	defb 0c4h,077h,09ch	; 9320
	defb 0e4h,0d7h,09ch	; 9323
	defb 000h	; 9326

; ----------------------------------------------------------------------
; DATOS lista_44D1_9327: lista de p00:44D1 de la fase 6: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (16 bytes)
;   0x9327..0x9337  (16 bytes)
DATA_lista_44D1_9327:
	defb 0a4h,0a0h,09bh	; 9327
	defb 074h,01bh,09ch	; 932a
	defb 0b4h,062h,096h	; 932d
	defb 0dch,022h,09ah	; 9330
	defb 0ech,002h,099h	; 9333
	defb 000h	; 9336

; ----------------------------------------------------------------------
; DATOS lista_44D1_9337: lista de p00:44D1 de la fase 7: [n][rachas lo hi] y 0
;   acaba; se solapan 2 bloques: (lista_44D1_933A 933A-933E); lo leen p00:44D1
;   (7 bytes)
;   0x9337..0x933e  (7 bytes)
DATA_lista_44D1_9337:
	defb 0b4h,048h,098h	; 9337
	defb 0fch,013h,09bh	; 933a
	defb 000h	; 933d

; ----------------------------------------------------------------------
; DATOS lista_44D1_933E: lista de p00:44D1 de la fase 0: [n][rachas lo hi] y 0
;   acaba; lo leen p00:44D1 (10 bytes)
;   0x933e..0x9348  (10 bytes)
DATA_lista_44D1_933E:
	defb 0a4h,0a0h,09bh	; 933e
	defb 0fch,013h,09bh	; 9341
	defb 0e4h,0c2h,099h	; 9344
	defb 000h	; 9347

; ----------------------------------------------------------------------
; DATOS copias_por_fase_9348: 12 punteros, uno por fase (0xE201): listas de
;   p00:43DA (fichas de 4 bytes), que p00:43CE lee con L_4B67; lo leen
;   p00:43D4 (24 bytes)
;   0x9348..0x9360  (24 bytes)
DATA_copias_por_fase_9348:
	defw 0936eh,09360h,0936eh,09365h,0936eh,0936eh	; 9348
	defw 0936ah,0936eh,0936eh,0936eh,0936eh,0936eh	; 9354

; ----------------------------------------------------------------------
; DATOS copias_por_fase_9348_9360: lista de p00:43DA (fichas
;   [tipo][cuantos][origen][destino], tipo 0 acaba) de la fase 1; lo leen
;   p00:43D4 (5 bytes)
;   0x9360..0x9365  (5 bytes)
DATA_copias_por_fase_9348_9360:
	defb 001h,004h,0dch,0b4h	; 9360
	defb 000h	; 9364

; ----------------------------------------------------------------------
; DATOS copias_por_fase_9348_9365: lista de p00:43DA (fichas
;   [tipo][cuantos][origen][destino], tipo 0 acaba) de la fase 3; lo leen
;   p00:43D4 (5 bytes)
;   0x9365..0x936a  (5 bytes)
DATA_copias_por_fase_9348_9365:
	defb 001h,004h,0dch,0b4h	; 9365
	defb 000h	; 9369

; ----------------------------------------------------------------------
; DATOS copias_por_fase_9348_936A: lista de p00:43DA (fichas
;   [tipo][cuantos][origen][destino], tipo 0 acaba) de la fase 6; se solapan 2
;   bloques: (copias_por_fase_9348_936E 936E-936F); lo leen p00:43D4 (5 bytes)
;   0x936a..0x936f  (5 bytes)
DATA_copias_por_fase_9348_936A:
	defb 001h,003h,074h,080h	; 936a
	defb 000h	; 936e

; ----------------------------------------------------------------------
; DATOS rachas_936F: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:4375 (81 bytes)
;   0x936f..0x93c0  (81 bytes)
DATA_rachas_936F:
	defb 086h,000h,080h,0e0h,070h,07fh,07fh,003h,0bfh,082h,078h,0e0h,00ah,000h,083h,088h	; 936f  ....p.....x.....
	defb 0ffh,0f8h,01ch,000h,082h,0c0h,070h,00dh,000h,084h,0b0h,0fch,07fh,07fh,003h,0bfh	; 937f  ......p.........
	defb 083h,07fh,078h,0e0h,008h,000h,085h,080h,018h,08fh,0fch,0e0h,01ch,000h,082h,0e0h	; 938f  ..x.............
	defb 070h,009h,000h,086h,080h,0e0h,070h,0ffh,01fh,001h,00dh,000h,083h,080h,0f0h,0ffh	; 939f  p.....p.........
	defb 00eh,000h,086h,0e0h,0feh,07fh,03fh,01eh,018h,00ch,000h,082h,0fch,0f0h,007h,000h	; 93af  ......?.........
	defb 000h	; 93bf

; ----------------------------------------------------------------------
; DATOS rachas_93C0: rachas a la VRAM 0x18C0: p00:4497 pone DE = 0x93C0 y cae
;   en L_449A, que salta a p00:4A8C; lo leen p00:4497 (46 bytes)
;   0x93c0..0x93ee  (46 bytes)
DATA_rachas_93C0:
	defb 087h,003h,007h,002h,000h,030h,070h,020h,019h,000h,083h,0beh,0bfh,0beh,01dh,000h	; 93c0  .....0p ........
	defb 087h,020h,060h,0d8h,03ch,01eh,00eh,002h,019h,000h,085h,0a0h,06eh,0efh,06eh,0a0h	; 93d0  . `.<.......n.n.
	defb 01bh,000h,088h,010h,008h,030h,0a4h,04ch,01eh,007h,003h,018h,000h,000h	; 93e0  .....0.L......

; ----------------------------------------------------------------------
; DATOS rachas_93EE: rachas a la VRAM 0x18C0 (p00:449A -> p00:4A8C); lo leen
;   p00:4488, p00:44BB (29 bytes)
;   0x93ee..0x940b  (29 bytes)
DATA_rachas_93EE:
	defb 08ch,009h,037h,06fh,06eh,0edh,071h,078h,0bbh,047h,07fh,03eh,009h,005h,000h,08ah	; 93ee  ..7on.qx.G.>....
	defb 0c0h,0e0h,020h,0d0h,0e0h,0e0h,070h,060h,060h,0c0h,005h,000h,000h	; 93fe  .. ...p``....

; ----------------------------------------------------------------------
; DATOS dibujos_940B: 4 caracteres de dibujo (8 bytes cada uno) que no lee
;   nadie a la vista: no son rachas ni los apunta ninguna palabra del
;   cartucho; lo leen nadie (32 bytes)
;   0x940b..0x942b  (32 bytes)
DATA_dibujos_940B:
	defb 009h,037h,06fh,06eh,0edh,071h,078h,0bbh	; 940b  .7on.qx.
	defb 047h,07fh,03eh,009h,000h,000h,000h,000h	; 9413  G.>.....
	defb 000h,0c0h,0e0h,020h,0d0h,0e0h,0e0h,070h	; 941b  ... ...p
	defb 060h,060h,0c0h,000h,000h,000h,000h,000h	; 9423  ``......

; ----------------------------------------------------------------------
; DATOS rachas_942B: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:437E (141 bytes)
;   0x942b..0x94b8  (141 bytes)
DATA_rachas_942B:
	defb 004h,000h,082h,0c0h,070h,00ah,000h,090h,066h,099h,081h,05ah,05ah,081h,099h,066h	; 942b  ....p...f..ZZ..f
	defb 066h,099h,081h,05ah,05ah,081h,099h,066h,004h,000h,082h,0c0h,070h,00ah,000h,090h	; 943b  f..ZZ..f....p...
	defb 018h,066h,042h,099h,099h,042h,066h,018h,018h,066h,042h,099h,099h,042h,066h,018h	; 944b  .fB..Bf..fB..Bf.
	defb 006h,000h,082h,0e0h,070h,008h,000h,090h,066h,099h,081h,05ah,05ah,081h,099h,066h	; 945b  ....p...f..ZZ..f
	defb 066h,099h,081h,05ah,05ah,081h,099h,066h,006h,000h,082h,0e0h,070h,008h,000h,090h	; 946b  f..ZZ..f....p...
	defb 018h,066h,042h,099h,099h,042h,066h,018h,018h,066h,042h,099h,099h,042h,066h,018h	; 947b  .fB..Bf..fB..Bf.
	defb 003h,000h,083h,003h,01fh,07fh,004h,0ffh,083h,07fh,01fh,003h,006h,000h,083h,0c0h	; 948b  ................
	defb 0f8h,0feh,004h,0ffh,083h,0feh,0f8h,0c0h,008h,000h,086h,007h,01fh,03fh,03fh,01fh	; 949b  .............??.
	defb 007h,00ah,000h,086h,0e0h,0f8h,0fch,0fch,0f8h,0e0h,005h,000h,000h	; 94ab  .............

; ----------------------------------------------------------------------
; DATOS rachas_94B8: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:44C4 (426 bytes)
;   0x94b8..0x9662  (426 bytes)
DATA_rachas_94B8:
	defb 0adh,080h,009h,000h,005h,035h,0a1h,01ah,007h,0abh,035h,00bh,035h,014h,063h,000h	; 94b8  .....5....5.5.c.
	defb 010h,010h,080h,002h,000h,030h,052h,0e0h,0c0h,0c0h,0e0h,0d0h,08ch,028h,026h,000h	; 94c8  .....0R......(&.
	defb 040h,000h,004h,004h,000h,018h,019h,001h,001h,00eh,01fh,02fh,01fh,02eh,005h,000h	; 94d8  @........../....
	defb 08ch,080h,058h,0fch,0f4h,0f0h,0f0h,0f6h,026h,070h,070h,020h,080h,006h,000h,088h	; 94e8  ..X.....&pp ....
	defb 001h,000h,001h,004h,000h,003h,007h,002h,00ah,000h,086h,050h,0e0h,040h,010h,040h	; 94f8  ...........P.@.@
	defb 040h,00ah,000h,084h,002h,004h,002h,002h,00bh,000h,084h,0c0h,020h,080h,020h,007h	; 9508  @........... . .
	defb 000h,084h,060h,0f0h,0f0h,060h,01ch,000h,0deh,005h,01ch,041h,015h,05ch,059h,06bh	; 9518  ..`..`.....A.\Yk
	defb 06bh,029h,00ch,021h,029h,00ah,00ch,004h,004h,040h,070h,004h,050h,074h,034h,0ach	; 9528  k).!)....@p.Pt4.
	defb 0ach,028h,060h,008h,028h,0a0h,060h,040h,040h,005h,00bh,020h,006h,036h,034h,034h	; 9538  .(`.(.`@@.. .644
	defb 014h,014h,006h,011h,017h,006h,002h,002h,001h,000h,040h,020h,080h,050h,090h,0c0h	; 9548  ..........@ .P..
	defb 0c0h,080h,020h,000h,0c0h,0c0h,080h,080h,000h,005h,015h,018h,015h,00dh,01dh,01dh	; 9558  .. .............
	defb 00dh,00ch,005h,002h,006h,006h,003h,001h,001h,040h,050h,030h,050h,060h,070h,070h	; 9568  .........@P0P`pp
	defb 060h,060h,040h,080h,0c0h,0c0h,080h,003h,000h,0ffh,002h,004h,001h,00ah,009h,003h	; 9578  ``@.............
	defb 003h,001h,004h,000h,003h,003h,001h,001h,000h,0a0h,0d0h,004h,060h,06ch,02ch,02ch	; 9588  ............`l,,
	defb 028h,028h,060h,088h,0e8h,060h,040h,040h,080h,00dh,01eh,00fh,017h,07ah,091h,04eh	; 9598  ((`..`@@.....z.N
	defb 0ddh,0ddh,04eh,091h,07ah,017h,00fh,01fh,00eh,0f8h,0ffh,0c0h,030h,0c8h,0f0h,01ch	; 95a8  ..N.z.......0...
	defb 0e2h,0e2h,01ch,0f0h,0c8h,030h,0c0h,07fh,0f8h,000h,00eh,002h,01ah,054h,04eh,074h	; 95b8  .....0.......TNt
	defb 001h,0f5h,0fah,0ebh,05ah,01dh,00eh,007h,001h,0e0h,0f0h,0e0h,0d8h,07ch,08eh,076h	; 95c8  ....Z........|.v
	defb 0abh,0d9h,090h,008h,0c8h,0b0h,000h,000h,080h,001h,007h,00eh,01dh,05ah,0ebh,0fah	; 95d8  .............Z..
	defb 0f5h,001h,074h,04eh,054h,01ah,002h,00eh,000h,080h,000h,000h,0b0h,0c8h,008h,090h	; 95e8  ..tNT...........
	defb 0d9h,0abh,076h,08eh,07ch,0d8h,0e0h,0f0h,0e0h,083h,037h,008h,003h,004h,000h,0d9h	; 95f8  ..v.|.....7.....
	defb 001h,004h,01bh,000h,0feh,006h,030h,01bh,001h,0d8h,0e0h,078h,09ah,040h,042h,00ch	; 9608  ......0....x.@B.
	defb 05ch,082h,0a9h,00ch,0e9h,08dh,02ah,084h,0d8h,000h,000h,03bh,01dh,006h,000h,001h	; 9618  \.....*.........
	defb 004h,01bh,000h,0feh,006h,030h,01bh,001h,000h,032h,019h,00eh,003h,0e0h,003h,05ch	; 9628  .....0...2.....\
	defb 082h,0a8h,00dh,0e9h,08dh,02ah,084h,0e8h,000h,0f4h,03ah,00ch,001h,000h,000h,003h	; 9638  .....*....:.....
	defb 004h,005h,009h,002h,027h,04eh,099h,036h,060h,0eah,04eh,034h,018h,004h,0c8h,09ah	; 9648  ....'N.6`.N4....
	defb 01ah,086h,058h,0ech,058h,030h,060h,000h,000h,000h	; 9658  ..X.X0`...

; ----------------------------------------------------------------------
; DATOS rachas_9662: rachas (p00:4A8C) a la VRAM 0x1DA0 (el 180) de la lista
;   0x9327 (p00:44D1, fase 6); lo leen p00:44D1 (293 bytes)
;   0x9662..0x9787  (293 bytes)
DATA_rachas_9662:
	defb 08ch,001h,007h,01fh,03fh,07fh,07fh,0ffh,0ffh,0feh,0f1h,07fh,03fh,004h,000h,082h	; 9662  ....?.......?...
	defb 0f0h,0f8h,004h,0fch,085h,0d8h,0b8h,070h,0e0h,0c0h,005h,000h,08ch,001h,003h,007h	; 9672  .......p........
	defb 037h,077h,07fh,0ffh,0fbh,0fdh,0f2h,07fh,03fh,004h,000h,082h,0f0h,0f8h,004h,0fch	; 9682  7w......?.......
	defb 085h,0d8h,0b8h,0f0h,0e0h,080h,006h,000h,08ch,001h,003h,003h,03bh,07bh,0fdh,0fdh	; 9692  .............{..
	defb 0feh,0f7h,06bh,076h,03ch,003h,000h,089h,0f0h,0f8h,0fch,0fch,0dch,0ach,0dch,0f8h	; 96a2  ..kv<...........
	defb 070h,008h,000h,081h,001h,004h,003h,096h,039h,07dh,0feh,0ffh,0efh,0f7h,0f9h,07fh	; 96b2  p.......9}......
	defb 03fh,01fh,0f0h,0f8h,0fch,0dch,0eeh,0f6h,0f6h,0feh,0feh,07ch,0b8h,080h,003h,0c0h	; 96c2  ?..........|....
	defb 088h,080h,001h,003h,007h,00fh,01fh,03fh,07fh,003h,0ffh,082h,07eh,03ch,004h,000h	; 96d2  .......?....~<..
	defb 082h,0e0h,0f0h,003h,0f8h,084h,0f0h,0e0h,0c0h,080h,007h,000h,08dh,001h,003h,00fh	; 96e2  ................
	defb 01fh,03fh,07fh,07fh,0ffh,0feh,0fdh,07ch,07fh,01ch,003h,000h,082h,0e0h,0f8h,004h	; 96f2  .?.....|........
	defb 0fch,085h,098h,058h,0b0h,060h,0c0h,005h,000h,08dh,003h,00fh,01fh,03fh,07fh,07eh	; 9702  ...X.`.......?.~
	defb 0fdh,0fbh,0f3h,0f1h,074h,079h,01eh,003h,000h,08ch,0e0h,0f0h,0f8h,0f8h,01ch,02ch	; 9712  ....ty.........,
	defb 08ch,0d8h,0d8h,0b0h,060h,0c0h,004h,000h,0adh,00fh,01fh,03fh,075h,068h,0f3h,0e7h	; 9722  ....`......?uh..
	defb 0e7h,0e3h,070h,075h,03fh,01fh,00fh,000h,000h,0c0h,0e0h,0f0h,078h,018h,01ch,09ch	; 9732  ..pu?.......x...
	defb 0bch,01ch,078h,038h,0f0h,0e0h,0c0h,000h,000h,001h,00eh,018h,036h,06fh,06fh,0c6h	; 9742  ..x8........6oo.
	defb 0d1h,0e3h,07fh,07fh,03fh,01fh,003h,000h,08ch,0e0h,078h,0b8h,03ch,03ch,07ch,0fch	; 9752  ....?.....x.<<|.
	defb 0f8h,0f8h,0f0h,0e0h,0c0h,004h,000h,08ch,001h,007h,018h,036h,06eh,06dh,0c3h,0efh	; 9762  ...........6nm..
	defb 0ffh,0ffh,07fh,03fh,004h,000h,08bh,0f0h,078h,03ch,0bch,07ch,0fch,0f8h,0f8h,0f0h	; 9772  ...?....x<.|....
	defb 0e0h,0c0h,005h,000h,000h	; 9782

; ----------------------------------------------------------------------
; DATOS rachas_9787: rachas (p00:4A8C) a la VRAM 0x1EE0 (el 220) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (127 bytes)
;   0x9787..0x9806  (127 bytes)
DATA_rachas_9787:
	defb 004h,000h,08ch,007h,03bh,07ch,0c9h,033h,051h,028h,015h,040h,05bh,00ch,003h,004h	; 9787  .....|.3Q(.@[...
	defb 000h,0ech,0e0h,0dch,03eh,093h,0cch,08ah,014h,0a8h,002h,0dah,030h,0c0h,000h,000h	; 9797  ....>.......0...
	defb 007h,018h,027h,05fh,000h,056h,02bh,015h,000h,00bh,040h,06eh,019h,007h,000h,000h	; 97a7  ..'_.V+...@n....
	defb 0e0h,038h,084h,01ah,038h,092h,044h,0a8h,000h,0d0h,002h,0eeh,030h,0c0h,000h,000h	; 97b7  .8..8.D.....0...
	defb 007h,01ch,021h,058h,01ch,049h,022h,015h,000h,00bh,040h,077h,00ch,003h,000h,000h	; 97c7  ..!X.I"...@w....
	defb 0e0h,018h,0e4h,0fah,000h,06ah,0d4h,0a8h,000h,0d0h,002h,076h,098h,0e0h,007h,03bh	; 97d7  .....j.....v....
	defb 05bh,0ech,033h,05dh,02ah,015h,000h,00bh,000h,009h,040h,05bh,00ch,003h,0e0h,0dch	; 97e7  [.3]*.....@[....
	defb 0dbh,036h,0cch,0bah,054h,0a8h,000h,0d0h,000h,090h,002h,0dah,030h,0c0h,000h	; 97f7  .6..T.......0..

; ----------------------------------------------------------------------
; DATOS rachas_9806: rachas (p00:4A8C) a la VRAM 0x1F80 (el 240) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (66 bytes)
;   0x9806..0x9848  (66 bytes)
DATA_rachas_9806:
	defb 0a2h,000h,003h,007h,004h,015h,010h,07fh,0ffh,000h,02bh,068h,0ebh,0e4h,0e5h,013h	; 9806  ..........+h....
	defb 003h,000h,0c0h,0e0h,020h,0a8h,008h,0feh,0ffh,000h,0d4h,016h,0d7h,027h,0a7h,0c8h	; 9816  .... ........'..
	defb 0c0h,000h,003h,003h,007h,08dh,001h,07fh,0ffh,000h,01dh,001h,00dh,001h,005h,003h	; 9826  ................
	defb 003h,000h,0c0h,003h,0e0h,08bh,080h,0feh,0ffh,000h,0b8h,080h,0b0h,080h,0a0h,0c0h	; 9836  ................
	defb 0c0h,000h	; 9846

; ----------------------------------------------------------------------
; DATOS rachas_9848: rachas (p00:4A8C) a la VRAM 0x1DA0 (el 180) de la lista
;   0x92DE (p00:44D1, fase 2); lo leen p00:44D1 (88 bytes)
;   0x9848..0x98a0  (88 bytes)
DATA_rachas_9848:
	defb 0a0h,003h,00fh,017h,038h,05dh,06ch,0e3h,0ebh,0ebh,0e3h,04ch,01dh,038h,017h,00fh	; 9848  ....8]l....L.8..
	defb 003h,0c0h,0e0h,0c8h,01ch,0bah,036h,0c7h,0d7h,0d7h,0c7h,032h,0b8h,01ch,0c8h,0e0h	; 9858  ......6....2....
	defb 0c0h,003h,000h,08ah,007h,018h,05dh,0e8h,0e3h,0d8h,0bbh,078h,017h,007h,006h,000h	; 9868  ......]....x....
	defb 08ah,0e0h,018h,0bah,017h,0c7h,01bh,0ddh,01eh,0e8h,0e0h,008h,000h,086h,00fh,030h	; 9878  ...............0
	defb 0dbh,0c8h,030h,00fh,00ah,000h,086h,0f0h,00ch,0dbh,013h,00ch,0f0h,00ch,000h,002h	; 9888  ..0.............
	defb 0ffh,00eh,000h,002h,0ffh,007h,000h,000h	; 9898  ........

; ----------------------------------------------------------------------
; DATOS rachas_98A0: rachas (p00:4A8C) a la VRAM 0x1E20 (el 196) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (98 bytes)
;   0x98a0..0x9902  (98 bytes)
DATA_rachas_98A0:
	defb 0e0h,000h,00ch,01fh,017h,016h,015h,01bh,038h,022h,03bh,03dh,01dh,006h,007h,003h	; 98a0  ........8".=....
	defb 000h,070h,0f8h,0cch,03eh,0ffh,0f9h,0c7h,03fh,0feh,07eh,09eh,0e6h,0fch,0f8h,080h	; 98b0  .p..>...?.~.....
	defb 000h,038h,06fh,06fh,06eh,036h,036h,035h,038h,07bh,075h,036h,00fh,007h,007h,003h	; 98c0  .8oon6658{u6....
	defb 000h,0e0h,0f0h,070h,0f0h,0f8h,0feh,086h,07eh,09ch,0e8h,078h,09ch,0ech,0bch,018h	; 98d0  ...p....~..x....
	defb 000h,070h,0fch,0efh,077h,037h,016h,015h,018h,03bh,065h,0deh,0beh,0f6h,063h,003h	; 98e0  .p..w7....e...c.
	defb 003h,060h,0f0h,0b0h,0beh,07fh,0f1h,0cfh,03eh,0d8h,0e8h,078h,0bch,0ceh,0b7h,09bh	; 98f0  .`......>..x....
	defb 00eh,000h	; 9900

; ----------------------------------------------------------------------
; DATOS rachas_9902: rachas (p00:4A8C) a la VRAM 0x1F60 (el 236) de la lista
;   0x92E5 (p00:44D1, fase 9, 10, 11); lo leen p00:44D1 (81 bytes)
;   0x9902..0x9953  (81 bytes)
DATA_rachas_9902:
	defb 003h,000h,088h,001h,00fh,07eh,0ffh,03fh,080h,07fh,007h,006h,000h,08ah,00ch,01ch	; 9902  .....~.?........
	defb 0c0h,074h,0fbh,007h,0fch,053h,08ch,074h,006h,000h,085h,00eh,03eh,07eh,0ffh,007h	; 9912  .t...S.t....>~..
	defb 004h,000h,095h,007h,0ffh,07eh,03eh,00eh,000h,000h,080h,0f2h,0fbh,004h,0f8h,002h	; 9922  .....~>.........
	defb 056h,057h,002h,0f8h,007h,0fbh,0f2h,080h,006h,000h,087h,006h,07fh,080h,03fh,0ffh	; 9932  VW............?.
	defb 07eh,00eh,009h,000h,08bh,0f4h,08ch,053h,0fch,007h,0fbh,0e4h,000h,01ch,00ch,000h	; 9942  ~......S........
	defb 000h	; 9952

; ----------------------------------------------------------------------
; DATOS rachas_9953: rachas (p00:4A8C) a la VRAM 0x1BE0 (el 124) de la lista
;   0x92E5 (p00:44D1, fase 9, 10, 11); lo leen p00:44D1 (111 bytes)
;   0x9953..0x99c2  (111 bytes)
DATA_rachas_9953:
	defb 09fh,000h,003h,00fh,03fh,078h,0c7h,02bh,0e5h,02bh,0c7h,078h,03fh,00fh,003h,000h	; 9953  ....?x.+.+.x?...
	defb 000h,0d4h,0b7h,0b0h,060h,0e0h,070h,080h,0beh,080h,070h,0e0h,060h,0b0h,0b7h,0d4h	; 9963  ....`.p...p.`...
	defb 003h,000h,08bh,003h,00fh,03eh,0c5h,02bh,0f4h,0feh,0ffh,07fh,01fh,007h,005h,000h	; 9973  .....>.+........
	defb 08bh,0b0h,0b4h,067h,080h,0b0h,076h,0f0h,060h,0a7h,0b4h,0b0h,008h,000h,087h,005h	; 9983  ...g..v.`.......
	defb 03eh,0ffh,0ffh,07fh,03eh,005h,009h,000h,087h,0e0h,0f0h,07fh,074h,077h,0f0h,0e0h	; 9993  >...>.......tw..
	defb 007h,000h,08bh,007h,01fh,07fh,0ffh,0feh,0f4h,02bh,0c5h,03eh,00fh,003h,005h,000h	; 99a3  .........+.>....
	defb 08dh,0b0h,0b4h,0a7h,060h,0f0h,076h,0b0h,080h,067h,0b4h,0b0h,000h,000h,000h	; 99b3  ....`.v..g.....

; ----------------------------------------------------------------------
; DATOS rachas_99C2: rachas (p00:4A8C) a la VRAM 0x1F20 (el 228) de la lista
;   0x933E (p00:44D1, fase 0); lo leen p00:44D1 (34 bytes)
;   0x99c2..0x99e4  (34 bytes)
DATA_rachas_99C2:
	defb 0a0h,000h,003h,00fh,030h,0ffh,000h,015h,035h,015h,000h,0ffh,030h,00fh,003h,000h	; 99c2  ....0...5...0...
	defb 000h,0f0h,0b8h,05ch,046h,0ffh,060h,0f6h,0f4h,0f6h,060h,0ffh,046h,05ch,0b8h,0f0h	; 99d2  ...\F.`...`.F\..
	defb 000h,000h	; 99e2

; ----------------------------------------------------------------------
; DATOS rachas_99E4: rachas (p00:4A8C) a la VRAM 0x1FA0 (el 244) de la lista
;   0x92F8 (p00:44D1, fase 5); lo leen p00:44D1 (62 bytes)
;   0x99e4..0x9a22  (62 bytes)
DATA_rachas_99E4:
	defb 090h,0c0h,0f8h,0bfh,09fh,04fh,047h,043h,021h,021h,022h,012h,014h,014h,009h,00ah	; 99e4  .....OGC!!".....
	defb 00ch,003h,000h,08ah,0e0h,0fch,0ffh,0fah,0c4h,008h,010h,020h,040h,080h,004h,000h	; 99f4  ........... @...
	defb 084h,004h,007h,007h,005h,004h,008h,004h,010h,093h,020h,027h,038h,000h,000h,080h	; 9a04  .......... '8...
	defb 0f8h,0ffh,0ffh,07fh,03fh,01fh,00fh,007h,003h,007h,078h,080h,000h,000h	; 9a14  ....?.....x...

; ----------------------------------------------------------------------
; DATOS rachas_9A22: rachas (p00:4A8C) a la VRAM 0x1EE0 (el 220) de la lista
;   0x92F8 (p00:44D1, fase 5); lo leen p00:44D1 (92 bytes)
;   0x9a22..0x9a7e  (92 bytes)
DATA_rachas_9A22:
	defb 0adh,001h,01eh,02eh,01eh,000h,017h,000h,007h,007h,000h,017h,000h,01eh,02eh,01eh	; 9a22  ................
	defb 001h,000h,0f0h,0e8h,0f0h,000h,0d0h,000h,0c0h,0c0h,000h,0d0h,000h,0f0h,0e8h,0f0h	; 9a32  ................
	defb 000h,000h,007h,02dh,00eh,03dh,07bh,056h,06ch,013h,003h,000h,000h,001h,006h,000h	; 9a42  ...-.={Vl.......
	defb 08ch,080h,000h,000h,0c0h,0c8h,036h,06ah,0deh,0bch,070h,0b4h,0e0h,003h,000h,08bh	; 9a52  ......6j..p.....
	defb 020h,054h,070h,075h,075h,085h,075h,075h,070h,054h,020h,005h,000h,08bh,004h,02ah	; 9a62   Tpuu.uupT ....*
	defb 00eh,0aeh,0aeh,0a1h,0aeh,0aeh,00eh,02ah,004h,003h,000h,000h	; 9a72  .......*....

; ----------------------------------------------------------------------
; DATOS rachas_9A7E: rachas (p00:4A8C) a la VRAM 0x1EA0 (el 212) de la lista
;   0x930E (p00:44D1, fase 4); lo leen p00:44D1 (83 bytes)
;   0x9a7e..0x9ad1  (83 bytes)
DATA_rachas_9A7E:
	defb 09ch,000h,001h,002h,002h,007h,00fh,01dh,01eh,017h,017h,00eh,008h,004h,002h,001h	; 9a7e  ................
	defb 000h,000h,080h,0c0h,0f0h,0b8h,07ch,07ch,0fch,01ch,0c8h,0f0h,0f0h,003h,060h,08eh	; 9a8e  ......||......`.
	defb 0c0h,000h,000h,006h,00dh,038h,07eh,05eh,0cfh,056h,035h,01eh,007h,003h,006h,000h	; 9a9e  .....8~^.V5.....
	defb 089h,0e0h,050h,038h,05eh,04fh,062h,0cch,0f8h,0c0h,00ah,000h,088h,001h,002h,004h	; 9aae  ..P8^Ob.........
	defb 00fh,00dh,002h,002h,001h,008h,000h,08ah,0f0h,0bch,07eh,0fah,0b4h,0c8h,0f0h,040h	; 9abe  ..........~....@
	defb 000h,000h,000h	; 9ace

; ----------------------------------------------------------------------
; DATOS rachas_9AD1: rachas (p00:4A8C) a la VRAM 0x1FC0 (el 248) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (66 bytes)
;   0x9ad1..0x9b13  (66 bytes)
DATA_rachas_9AD1:
	defb 0c0h,000h,001h,003h,003h,00ah,028h,068h,003h,05dh,052h,02bh,009h,002h,002h,000h	; 9ad1  ......(h.]R+....
	defb 000h,080h,0c0h,0e0h,060h,0a8h,08ah,08bh,060h,0ddh,025h,06ah,0c8h,0a0h,0a0h,080h	; 9ae1  ....`...`.%j....
	defb 080h,000h,000h,002h,002h,009h,02bh,052h,05dh,003h,068h,028h,00ah,003h,003h,001h	; 9af1  ......+R].h(....
	defb 000h,080h,080h,0a0h,0a0h,0c8h,06ah,025h,0ddh,060h,08bh,08ah,0a8h,060h,0e0h,0c0h	; 9b01  ......j%.`...`..
	defb 080h,000h	; 9b11

; ----------------------------------------------------------------------
; DATOS rachas_9B13: rachas (p00:4A8C) a la VRAM 0x1FE0 (el 252) de la lista
;   0x92E5 (p00:44D1, fase 9, 10, 11); lo leen p00:44D1 (31 bytes)
;   0x9b13..0x9b32  (31 bytes)
DATA_rachas_9B13:
	defb 08dh,000h,001h,001h,011h,009h,006h,007h,00fh,06dh,00ah,005h,009h,010h,006h,000h	; 9b13  .........m......
	defb 08dh,008h,050h,0a0h,0c0h,0f4h,0f0h,0d0h,0a0h,090h,008h,080h,080h,000h,000h	; 9b23  ..P............

; ----------------------------------------------------------------------
; DATOS rachas_9B32: rachas (p00:4A8C) a la VRAM 0x1F60 (el 236) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (27 bytes)
;   0x9b32..0x9b4d  (27 bytes)
DATA_rachas_9B32:
	defb 081h,000h,003h,001h,087h,002h,00ah,004h,019h,004h,00ah,002h,003h,001h,006h,000h	; 9b32  ................
	defb 087h,080h,0a0h,040h,030h,040h,0a0h,080h,005h,000h,000h	; 9b42  ...@0@.....

; ----------------------------------------------------------------------
; DATOS rachas_9B4D: rachas (p00:4A8C) a la VRAM 0x1E80 (el 208) de la lista
;   0x92F8 (p00:44D1, fase 5); lo leen p00:44D1 (83 bytes)
;   0x9b4d..0x9ba0  (83 bytes)
DATA_rachas_9B4D:
	defb 0a0h,003h,031h,04fh,01ah,077h,025h,05bh,0d5h,0abh,055h,067h,0bah,015h,03fh,046h	; 9b4d  ..1O.w%[..Ug..?F
	defb 011h,0a0h,0c8h,038h,0d0h,0fdh,0f4h,0feh,0fch,0f6h,0fdh,0eah,0bch,0f2h,068h,084h	; 9b5d  ...8..........h.
	defb 030h,004h,000h,08bh,003h,014h,017h,00dh,02ah,00ch,01bh,00dh,017h,001h,006h,004h	; 9b6d  0.......*.......
	defb 000h,08ch,040h,010h,0a0h,0e8h,0f4h,0f0h,0f8h,0f4h,0b8h,0e0h,0a8h,020h,007h,000h	; 9b7d  ..@.......... ..
	defb 085h,005h,003h,006h,009h,002h,00ah,000h,087h,080h,020h,0c0h,0c0h,0d0h,080h,040h	; 9b8d  .......... ....@
	defb 004h,000h,000h	; 9b9d

; ----------------------------------------------------------------------
; DATOS rachas_9BA0: rachas (p00:4A8C) a la VRAM 0x1D20 (el 164) de la lista
;   0x92CB (p00:44D1, fase 1); lo leen p00:44D1 (123 bytes)
;   0x9ba0..0x9c1b  (123 bytes)
DATA_rachas_9BA0:
	defb 09fh,000h,00fh,033h,07dh,0feh,00eh,024h,06ah,06ah,024h,00eh,0feh,07dh,033h,00fh	; 9ba0  ...3}..$jj$..}3.
	defb 000h,000h,070h,0beh,0d0h,0e0h,010h,08ch,0bdh,0bdh,08ch,010h,0e0h,0d0h,0beh,070h	; 9bb0  ..p............p
	defb 003h,000h,08ch,003h,03dh,07eh,0c4h,0aah,06ah,000h,0fch,0feh,07eh,03dh,003h,004h	; 9bc0  ....=~..j...~=..
	defb 000h,08dh,084h,0d0h,0eeh,010h,08ch,0bdh,0bdh,004h,0f0h,0eeh,0d0h,0b4h,004h,006h	; 9bd0  ................
	defb 000h,087h,00dh,03bh,077h,0f7h,077h,03bh,00dh,006h,000h,08dh,004h,00ch,008h,0e0h	; 9be0  ....w.w.........
	defb 0d6h,0b8h,0bfh,0b8h,0d6h,0e0h,008h,00ch,004h,003h,000h,08ch,003h,03dh,07eh,0feh	; 9bf0  .............=~.
	defb 0fch,000h,06ah,0aah,0c4h,07eh,03dh,003h,003h,000h,08fh,004h,0b4h,0d0h,0eeh,0f0h	; 9c00  ..j..~=.........
	defb 004h,0bdh,0bdh,08ch,010h,0eeh,0d0h,084h,000h,000h,000h	; 9c10  ...........

; ----------------------------------------------------------------------
; DATOS rachas_9C1B: rachas (p00:4A8C) a la VRAM 0x1BA0 (el 116) de la lista
;   0x9327 (p00:44D1, fase 6); lo leen p00:44D1 (92 bytes)
;   0x9c1b..0x9c77  (92 bytes)
DATA_rachas_9C1B:
	defb 08ch,002h,02bh,01fh,01fh,07fh,03fh,07fh,0bfh,07dh,0ffh,089h,080h,004h,000h,08ch	; 9c1b  ..+...?..}......
	defb 0a0h,0c8h,0f0h,0fah,0fch,0fch,0fdh,0feh,0eeh,01bh,0b1h,040h,007h,000h,002h,001h	; 9c2b  ...........@....
	defb 08bh,005h,00ah,00ah,01dh,02fh,0dfh,0ffh,07fh,01fh,023h,00ch,004h,000h,0a7h,040h	; 9c3b  ...../....#....@
	defb 020h,0a8h,0e8h,0ech,0fch,0fbh,0ffh,0feh,0c8h,0cch,020h,001h,001h,000h,002h,005h	; 9c4b   ......... .....
	defb 005h,006h,006h,00dh,00fh,02fh,02fh,01fh,01fh,00fh,003h,000h,000h,080h,080h,0c0h	; 9c5b  .....//.........
	defb 060h,060h,0b4h,0f4h,0f4h,0fch,003h,0f8h,082h,0f0h,0e0h,000h	; 9c6b  ``..........

; ----------------------------------------------------------------------
; DATOS rachas_9C77: rachas (p00:4A8C) a la VRAM 0x1E20 (el 196) de la lista
;   0x930E (p00:44D1, fase 4); lo leen p00:44D1 (96 bytes)
;   0x9c77..0x9cd7  (96 bytes)
DATA_rachas_9C77:
	defb 002h,000h,08ch,014h,026h,00fh,03fh,01fh,00eh,001h,00bh,01ah,01ah,01dh,00ch,004h	; 9c77  ....&.?.........
	defb 000h,08ch,098h,024h,062h,072h,07ch,0b8h,0d0h,0e8h,02ch,02eh,0deh,01ch,003h,000h	; 9c87  ...$br|...,.....
	defb 09eh,003h,004h,007h,007h,037h,070h,077h,02fh,013h,021h,021h,012h,00dh,001h,000h	; 9c97  .....7pw/.!!....
	defb 000h,080h,040h,0c0h,0d0h,0c0h,0beh,079h,0b9h,0b9h,0beh,040h,0c0h,0c0h,080h,003h	; 9ca7  ..@....y...@....
	defb 000h,08ch,00ch,01dh,01ah,01ah,00bh,001h,00eh,01fh,03fh,00fh,026h,014h,004h,000h	; 9cb7  ..........?.&...
	defb 08eh,01ch,0deh,02eh,02ch,0e8h,0d0h,0b8h,07ch,072h,062h,024h,098h,000h,000h,000h	; 9cc7  ....,...|rb$....

; ----------------------------------------------------------------------
; DATOS rachas_9CD7: rachas (p00:4A8C) a la VRAM 0x1F20 (el 228) de la lista
;   0x930E (p00:44D1, fase 4); lo leen p00:44D1 (64 bytes)
;   0x9cd7..0x9d17  (64 bytes)
DATA_rachas_9CD7:
	defb 002h,000h,08ch,00ah,00dh,00eh,00fh,00fh,017h,00bh,01ch,03eh,000h,006h,004h,004h	; 9cd7  ...........>....
	defb 000h,08dh,020h,068h,0d8h,028h,050h,038h,07ch,09eh,0c0h,0e8h,0e0h,060h,020h,003h	; 9ce7  .. h.(P8|....` .
	defb 000h,08ch,002h,003h,003h,01ch,02eh,017h,000h,00fh,00eh,00dh,00ah,004h,004h,000h	; 9cf7  ................
	defb 08eh,010h,020h,050h,0b0h,0b0h,024h,04eh,070h,078h,038h,098h,0c8h,080h,000h,000h	; 9d07  .. P..$Npx8.....

; ----------------------------------------------------------------------
; DATOS rachas_9D17: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:4304 (81 bytes)
;   0x9d17..0x9d68  (81 bytes)
DATA_rachas_9D17:
	defb 014h,000h,082h,0c0h,070h,00bh,000h,085h,080h,0e0h,070h,07fh,07fh,003h,0bfh,082h	; 9d17  ....p.....p.....
	defb 078h,0e0h,00ah,000h,083h,088h,0ffh,0f8h,01fh,000h,002h,0f0h,008h,000h,08eh,060h	; 9d27  x..............`
	defb 078h,07eh,03fh,03ah,03fh,06fh,06fh,03fh,03ah,03fh,07eh,078h,060h,006h,000h,086h	; 9d37  x~?:?oo?:?~x`...
	defb 060h,0f8h,0ffh,0ffh,0f8h,060h,01fh,000h,082h,070h,0c0h,009h,000h,082h,0e0h,078h	; 9d47  `....`...p.....x
	defb 003h,0bfh,002h,07fh,083h,070h,0e0h,080h,009h,000h,083h,0f8h,0ffh,088h,005h,000h	; 9d57  .....p..........
	defb 000h	; 9d67

; ----------------------------------------------------------------------
; DATOS rachas_9D68: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:430D (61 bytes)
;   0x9d68..0x9da5  (61 bytes)
DATA_rachas_9D68:
	defb 009h,000h,087h,001h,01fh,0ffh,078h,060h,0c0h,080h,009h,000h,082h,0ffh,0f0h,00ah	; 9d68  ......x`........
	defb 000h,086h,018h,01fh,01fh,03eh,066h,0e0h,00ch,000h,082h,0f0h,0fch,008h,000h,086h	; 9d78  .....>f.........
	defb 080h,0e0h,070h,0ffh,01fh,001h,00dh,000h,083h,080h,0f0h,0ffh,00eh,000h,086h,0e0h	; 9d88  ..p.............
	defb 0feh,07fh,03fh,01eh,018h,00ch,000h,082h,0fch,0f0h,007h,000h,000h	; 9d98  ..?..........

; ----------------------------------------------------------------------
; DATOS piezas_por_cuadro: 126 punteros, uno por cuadro (IX+32), que p00:52B8
;   lee con L_4B60; lo leen p00:52CB (252 bytes)
;   0x9da5..0x9ea1  (252 bytes)
DATA_piezas_por_cuadro:
	defw 09ea1h,09ea9h,09ea9h,09ea9h,09ea9h,09ea9h,09eadh,09eadh	; 9da5
	defw 09eadh,09eb1h,09eb1h,09eb1h,09eb1h,09eb1h,09eb1h,09eb5h	; 9db5
	defw 09eb5h,09eb5h,09eb9h,09eb9h,09eb9h,09ebdh,09ebdh,09ebdh	; 9dc5
	defw 09ec1h,09ec5h,09ec9h,09ecdh,09ed1h,09ed5h,09ed9h,09ef0h	; 9dd5
	defw 09ef0h,09ef0h,09ef4h,09ef8h,09efch,09f00h,09f00h,09f00h	; 9de5
	defw 09f04h,09f04h,09f04h,09f08h,09f08h,09f08h,09f0ch,09f0ch	; 9df5
	defw 09f0ch,09f10h,09f10h,09f10h,09f14h,09f14h,09f14h,09f18h	; 9e05
	defw 09f18h,09f18h,09f1ch,09f20h,09f20h,09f20h,09f24h,09f24h	; 9e15
	defw 09f24h,09f28h,09f28h,09f28h,09f2ch,09f2ch,09f2ch,09f30h	; 9e25
	defw 09f34h,09f38h,09f3ch,09f40h,09f44h,09f48h,09f4ch,09f50h	; 9e35
	defw 09f54h,09f58h,09f5ch,09f60h,09f64h,09f68h,09f6ch,09f70h	; 9e45
	defw 09f74h,09f78h,09f7ch,09f80h,09f84h,09f88h,09f88h,09f88h	; 9e55
	defw 09f88h,09f8ch,09f90h,09f94h,09f98h,09f9ch,09fa0h,09fa4h	; 9e65
	defw 09fa8h,09fach,09fb0h,09fb4h,09fb8h,09fbch,09fc0h,09fc4h	; 9e75
	defw 09fc8h,09fcch,09fd0h,09fd2h,09fd4h,09fd6h,09fd8h,09fdah	; 9e85
	defw 09fdch,09fe0h,09fe4h,09fe8h,09fech,09ff0h	; 9e95

; ----------------------------------------------------------------------
; DATOS piezas_de_enemigos: las piezas de caracteres de 0x9DA5 que p00:52ED
;   copia a la tabla de nombres de la RAM (IX+13 filas de IX+14 caracteres,
;   recortadas por el borde); lo leen p00:52F1 (339 bytes)
;   0x9ea1..0x9ff4  (339 bytes)
DATA_piezas_de_enemigos:
	defb 0c0h,0c2h,0c1h,0c3h,0c4h,0c6h,0c5h,0a1h	; 9ea1  ........
	defb 07bh,07ch,07ah,079h,07bh,07ch,07dh,07eh	; 9ea9  {|zy{|}~
	defb 0adh,0aeh,0ach,0abh,0adh,0aeh,0afh,0b0h	; 9eb1  ........
	defb 0ach,0abh,0adh,0aeh,0afh,0b0h,0adh,0aeh	; 9eb9  ........
	defb 073h,074h,077h,078h,075h,074h,077h,078h	; 9ec1  stwxutwx
	defb 076h,074h,077h,078h,07ah,07ch,07eh,07dh	; 9ec9  vtwxz|~}
	defb 07ah,07bh,07eh,07dh,07ah,079h,07eh,07dh	; 9ed1  z{~}zy~}
	defb 06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh	; 9ed9  oooooooo
	defb 06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh	; 9ee1  oooooooo
	defb 06fh,06fh,06fh,06fh,06fh,06fh,06fh,08bh	; 9ee9  ooooooo.
	defb 000h,08fh,000h,08ch,000h,090h,000h,08eh	; 9ef1  ........
	defb 000h,092h,000h,08dh,000h,091h,000h,080h	; 9ef9  ........
	defb 07fh,081h,082h,083h,084h,081h,082h,081h	; 9f01  ........
	defb 082h,080h,07fh,081h,082h,083h,084h,087h	; 9f09  ........
	defb 088h,086h,085h,087h,088h,089h,08ah,00ch	; 9f11  ........
	defb 00bh,010h,00fh,009h,00ah,00dh,00eh,086h	; 9f19  ........
	defb 085h,087h,088h,089h,08ah,087h,088h,074h	; 9f21  .......t
	defb 073h,075h,076h,077h,078h,075h,076h,077h	; 9f29  suvwxuvw
	defb 078h,073h,074h,077h,078h,075h,076h,07eh	; 9f31  xstwxuv~
	defb 07dh,07ah,079h,07eh,07dh,07ch,07bh,083h	; 9f39  }zy~}|{.
	defb 084h,07fh,080h,083h,084h,081h,080h,083h	; 9f41  ........
	defb 084h,082h,080h,08ah,089h,086h,088h,08ah	; 9f49  ........
	defb 089h,086h,087h,08ah,089h,086h,085h,067h	; 9f51  .......g
	defb 068h,06bh,06ch,069h,068h,06bh,06ch,06ah	; 9f59  hklihklj
	defb 068h,06bh,06ch,06eh,070h,072h,071h,06eh	; 9f61  hklnprqn
	defb 06fh,072h,071h,06eh,06dh,072h,071h,06bh	; 9f69  orqnmrqk
	defb 06ch,067h,068h,06bh,06ch,069h,068h,06bh	; 9f71  lghklihk
	defb 06ch,06ah,068h,072h,071h,06eh,070h,072h	; 9f79  ljhrqnpr
	defb 071h,06eh,06fh,072h,071h,06eh,06dh,07fh	; 9f81  qnorqnm.
	defb 080h,083h,084h,081h,082h,083h,084h,086h	; 9f89  ........
	defb 085h,08ah,089h,088h,087h,08ah,089h,073h	; 9f91  .......s
	defb 074h,077h,078h,075h,076h,077h,078h,07ah	; 9f99  twxuvwxz
	defb 079h,07eh,07dh,07ch,07bh,07eh,07dh,083h	; 9fa1  y~}|{~}.
	defb 084h,07fh,080h,083h,084h,081h,082h,08ah	; 9fa9  ........
	defb 089h,086h,085h,08ah,089h,088h,087h,077h	; 9fb1  .......w
	defb 078h,073h,074h,077h,078h,075h,074h,077h	; 9fb9  xstwxutw
	defb 078h,076h,074h,07eh,07dh,07ah,07ch,07eh	; 9fc1  xvt~}z|~
	defb 07dh,07ah,07bh,07eh,07dh,07ah,079h,0a4h	; 9fc9  }z{~}zy.
	defb 0a5h,0a6h,0a7h,0aah,0abh,0a8h,0a9h,070h	; 9fd1  .......p
	defb 071h,08eh,08fh,07fh,080h,083h,084h,081h	; 9fd9  q.......
	defb 080h,083h,084h,082h,080h,083h,084h,086h	; 9fe1  ........
	defb 088h,08ah,089h,086h,087h,08ah,089h,086h	; 9fe9  ........
	defb 085h,08ah,089h	; 9ff1

; ----------------------------------------------------------------------
; DATOS rachas_9FF4: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba) (sigue en el banco 9, en 0xA000); lo leen p00:42E6
;   (12 bytes)
;   0x9ff4..0xa000  (12 bytes)
DATA_rachas_9FF4:
	defb 006h,000h,083h,001h,01fh,001h,00bh,000h,087h,001h,00eh,0f0h	; 9ff4  ............

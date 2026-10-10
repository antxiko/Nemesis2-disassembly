; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS rachas_9FF4_cola: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80
;   destino, >0x80 copia, 0 acaba) (sigue del banco 8); lo leen p00:42E6 (99
;   bytes)
;   0xa000..0xa063  (99 bytes)
DATA_rachas_9FF4_cola:
	defb 000h,0f0h,00eh,001h,00ah,000h,085h,001h,00ch,0c0h,00ch,001h,00bh,000h,085h,080h	; a000  ................
	defb 030h,003h,030h,080h,00ch,000h,083h,003h,03fh,003h,00dh,000h,083h,0c0h,0fch,0c0h	; a010  0.0.....?.......
	defb 00dh,000h,083h,007h,03fh,007h,009h,000h,08bh,003h,01ch,030h,0e0h,080h,000h,080h	; a020  ....?......0....
	defb 0e0h,030h,01ch,003h,006h,000h,089h,003h,00eh,018h,070h,0e0h,070h,018h,00eh,003h	; a030  .0........p.p...
	defb 007h,000h,089h,0c0h,070h,018h,00eh,007h,00eh,018h,070h,0c0h,008h,000h,087h,001h	; a040  ....p.....p.....
	defb 007h,00fh,01fh,00fh,007h,001h,009h,000h,087h,080h,0e0h,0f0h,0f8h,0f0h,0e0h,080h	; a050  ................
	defb 005h,000h,000h	; a060

; ----------------------------------------------------------------------
; DATOS rachas_A063: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:42EF (83 bytes)
;   0xa063..0xa0b6  (83 bytes)
DATA_rachas_A063:
	defb 005h,000h,085h,001h,002h,078h,002h,001h,009h,000h,002h,080h,087h,040h,020h,00fh	; a063  .....x.......@ .
	defb 020h,040h,080h,080h,00ah,000h,083h,001h,006h,001h,00ch,000h,085h,080h,040h,030h	; a073   @............@0
	defb 040h,080h,00dh,000h,081h,001h,00eh,000h,083h,080h,0c0h,080h,00bh,000h,087h,080h	; a083  @...............
	defb 070h,00fh,000h,00fh,070h,080h,00bh,000h,083h,080h,0f8h,080h,009h,000h,08bh,0c0h	; a093  p...p...........
	defb 038h,00ch,007h,001h,000h,001h,007h,00ch,038h,0c0h,009h,000h,083h,0e0h,0fch,0e0h	; a0a3  8.......8.......
	defb 007h,000h,000h	; a0b3

; ----------------------------------------------------------------------
; DATOS rachas_A0B6: rachas (p00:4A8C) a la VRAM 0x1CA0 (el 148) de la lista
;   0x92E5 (p00:44D1, fase 9, 10, 11); lo leen p00:44D1 (141 bytes)
;   0xa0b6..0xa143  (141 bytes)
DATA_rachas_A0B6:
	defb 083h,000h,04ah,0cah,003h,04ah,081h,044h,00ah,000h,086h,0c0h,0a0h,0a0h,0c0h,080h	; a0b6  ..J..J.D........
	defb 080h,009h,000h,082h,002h,006h,005h,002h,00ah,000h,081h,06ch,004h,092h,081h,06ch	; a0c6  ...........l...l
	defb 009h,000h,087h,00ch,012h,002h,004h,008h,010h,01eh,00ah,000h,081h,06ch,004h,092h	; a0d6  .............l..
	defb 081h,06ch,009h,000h,087h,01eh,010h,01ch,002h,002h,012h,00ch,00ah,000h,081h,06ch	; a0e6  .l.............l
	defb 004h,092h,081h,06ch,009h,000h,082h,010h,033h,004h,014h,081h,013h,00ah,000h,081h	; a0f6  ...l....3.......
	defb 06ch,004h,092h,081h,06ch,009h,000h,087h,030h,049h,00ah,012h,022h,042h,079h,00ah	; a106  l...l...0I.."By.
	defb 000h,081h,0b6h,004h,049h,081h,0b6h,009h,000h,087h,078h,041h,072h,04ah,00ah,04ah	; a116  ....I.....xArJ.J
	defb 031h,00ah,000h,081h,0b6h,004h,049h,081h,0b6h,009h,000h,082h,040h,0cdh,004h,052h	; a126  1.....I.....@..R
	defb 081h,04dh,00ah,000h,081h,0b6h,004h,049h,081h,0b6h,009h,000h,000h	; a136  .M.....I.....

; ----------------------------------------------------------------------
; DATOS caracteres_A143: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p00:5EE8 (25
;   bytes)
;   0xa143..0xa15c  (25 bytes)
DATA_caracteres_A143:
	defb 006h,0c9h,0aah,001h,07ah,0afh	; a143
	defb 006h,00bh,0abh,011h,0a4h,0afh	; a149
	defb 006h,046h,0abh,021h,0bbh,0afh	; a14f
	defb 006h,086h,0abh,031h,0dfh,0afh	; a155
	defb 000h	; a15b

; ----------------------------------------------------------------------
; DATOS copias_A15C: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:5EF3
;   (17 bytes)
;   0xa15c..0xa16d  (17 bytes)
DATA_copias_A15C:
	defb 001h,009h,034h,008h,011h,019h,034h,008h,021h,029h,034h,008h,031h,039h,034h,008h	; a15c  ..4...4.!)4.194.
	defb 000h	; a16c

; ----------------------------------------------------------------------
; DATOS caracteres_A16D: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p01:69D5 (7 bytes)
;   0xa16d..0xa174  (7 bytes)
DATA_caracteres_A16D:
	defb 006h,03ch,0a2h,001h,03dh,0ach	; a16d
	defb 000h	; a173

; ----------------------------------------------------------------------
; DATOS copias_A174: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p01:69E0
;   (19 bytes)
;   0xa174..0xa187  (19 bytes)
DATA_copias_A174:
	defb 001h,027h,0b4h,007h,029h,074h,009h,02ah,074h,00ch,02bh,0f4h,011h,02eh,0f4h,026h	; a174  .'..)t.*t.+....&
	defb 031h,074h,000h	; a184

; ----------------------------------------------------------------------
; DATOS copias_A187: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p01:69EC (4
;   bytes)
;   0xa187..0xa18b  (4 bytes)
DATA_copias_A187:
	defb 025h,032h,074h,000h	; a187

; ----------------------------------------------------------------------
; DATOS caracteres_A18B: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p01:69FF (121
;   bytes)
;   0xa18b..0xa204  (121 bytes)
DATA_caracteres_A18B:
	defb 006h,053h,0a3h,001h,0d7h,0ach	; a18b
	defb 006h,07dh,0a3h,010h,0e4h,0ach	; a191
	defb 006h,0a7h,0a3h,015h,0f2h,0ach	; a197
	defb 006h,0ffh,0a3h,020h,01eh,0adh	; a19d
	defb 006h,033h,0a4h,029h,030h,0adh	; a1a3
	defb 006h,06dh,0a4h,030h,069h,0adh	; a1a9
	defb 006h,0a7h,0a4h,039h,080h,0adh	; a1af
	defb 006h,0ddh,0a4h,040h,08fh,0adh	; a1b5
	defb 006h,014h,0a5h,047h,0abh,0adh	; a1bb
	defb 006h,05eh,0a5h,050h,0ceh,0adh	; a1c1
	defb 006h,0a8h,0a5h,060h,0f1h,0adh	; a1c7
	defb 006h,007h,0a6h,070h,029h,0aeh	; a1cd
	defb 006h,072h,0a6h,080h,050h,0aeh	; a1d3
	defb 006h,0f8h,0a6h,096h,07fh,0aeh	; a1d9
	defb 006h,043h,0a7h,0a0h,0b0h,0aeh	; a1df
	defb 006h,0bbh,0a7h,0b1h,0d9h,0aeh	; a1e5
	defb 006h,035h,0a8h,0c0h,0f2h,0aeh	; a1eb
	defb 006h,0adh,0a8h,0d3h,00eh,0afh	; a1f1
	defb 006h,00eh,0a9h,0e0h,015h,0afh	; a1f7
	defb 006h,06fh,0a9h,0f0h,03fh,0afh	; a1fd
	defb 000h	; a203

; ----------------------------------------------------------------------
; DATOS copias_A204: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p01:6A0A
;   (16 bytes)
;   0xa204..0xa214  (16 bytes)
DATA_copias_A204:
	defb 0c1h,0d1h,074h,0c0h,0d2h,074h,0eah,0edh,074h,0ebh,0eeh,074h,0e0h,0efh,074h,000h	; a204  ..t..t..t..t..t.

; ----------------------------------------------------------------------
; DATOS caracteres_A214: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p00:5EB0 (13
;   bytes)
;   0xa214..0xa221  (13 bytes)
DATA_caracteres_A214:
	defb 006h,0dch,0a9h,001h,044h,0afh	; a214
	defb 006h,0b1h,0aah,02ah,073h,0afh	; a21a
	defb 000h	; a220

; ----------------------------------------------------------------------
; DATOS caracteres_A221: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p00:5ED4 (7 bytes)
;   0xa221..0xa228  (7 bytes)
DATA_caracteres_A221:
	defb 006h,018h,0ach,001h,03ah,0ach	; a221
	defb 000h	; a227

; ----------------------------------------------------------------------
; DATOS copias_A228: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:5EBB (7
;   bytes)
;   0xa228..0xa22f  (7 bytes)
DATA_copias_A228:
	defb 01fh,024h,0b4h,005h,026h,074h,000h	; a228

; ----------------------------------------------------------------------
; DATOS copias_A22F: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:5EC7
;   (13 bytes)
;   0xa22f..0xa23c  (13 bytes)
DATA_copias_A22F:
	defb 024h,027h,074h,01fh,028h,074h,021h,029h,074h,022h,02dh,074h,000h	; a22f  $'t.(t!)t"-t.

; ----------------------------------------------------------------------
; DATOS colores_A23C: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 1, ficha 0 de la lista 0xA16D (p00:4595); lo leen p01:69D5 (279
;   bytes)
;   0xa23c..0xa353  (279 bytes)
DATA_colores_A23C:
	defb 002h,000h,002h,080h,085h,0c0h,080h,000h,000h,0c0h,003h,080h,004h,000h,002h,0ffh	; a23c  ................
	defb 082h,0feh,078h,004h,000h,082h,0c0h,080h,006h,000h,082h,007h,003h,006h,000h,08ch	; a24c  ..x.............
	defb 0c0h,0e2h,0f0h,0ech,0bch,04eh,014h,000h,088h,0f8h,0f0h,0e0h,003h,0c0h,089h,0e0h	; a25c  .....N..........
	defb 082h,0e6h,0ceh,03dh,013h,000h,0dbh,044h,003h,080h,0a4h,0c0h,0e0h,0fah,0fch,04eh	; a26c  ...=...D.......N
	defb 007h,01fh,007h,03dh,01fh,007h,0e7h,01fh,007h,0ffh,087h,03bh,0ffh,0ffh,0b7h,00ch	; a27c  ...=............
	defb 007h,09fh,0f7h,0f9h,0ffh,0cfh,0e7h,03fh,0e0h,0f8h,0e0h,0c0h,0e0h,0f0h,080h,003h	; a28c  .......?........
	defb 000h,090h,004h,00bh,05fh,079h,010h,03fh,000h,000h,007h,00fh,00fh,007h,0c1h,0c1h	; a29c  ...._y.?........
	defb 0c0h,080h,003h,000h,0aeh,003h,006h,00fh,0c0h,060h,0a3h,0f9h,0f9h,07eh,0e3h,00dh	; a2ac  .........`...~..
	defb 0d7h,0cah,0fch,0a7h,08ah,0a1h,0c1h,0c1h,03fh,00fh,0bbh,066h,0afh,050h,0a0h,00dh	; a2bc  ........?..f.P..
	defb 041h,067h,073h,0bch,0c8h,000h,0dbh,022h,00ch,00eh,007h,083h,0f0h,0bch,0feh,01fh	; a2cc  Ags...."........
	defb 02ch,01fh,007h,005h,000h,003h,00ch,089h,014h,01eh,01eh,03eh,037h,01eh,00bh,01eh	; a2dc  ,..........>7...
	defb 038h,004h,000h,090h,007h,03fh,01fh,007h,000h,000h,070h,000h,0fdh,0f3h,098h,0feh	; a2ec  8....?....p.....
	defb 0f8h,0f0h,0c0h,080h,003h,000h,002h,040h,083h,062h,04fh,0f1h,003h,000h,082h,003h	; a2fc  .......@.bO.....
	defb 00eh,003h,000h,0abh,02dh,0d2h,00dh,00dh,002h,001h,002h,002h,01dh,003h,01ah,001h	; a30c  ....-...........
	defb 003h,002h,002h,000h,000h,01ah,02ch,00eh,002h,004h,000h,000h,001h,016h,06dh,003h	; a31c  ......,.......m.
	defb 002h,001h,000h,000h,010h,060h,0a0h,0c0h,0d0h,0a0h,060h,040h,020h,040h,040h,007h	; a32c  .....`....`@ @@.
	defb 000h,081h,080h,003h,000h,08ah,040h,0c0h,000h,018h,070h,063h,0ddh,03eh,0a6h,0a6h	; a33c  ......@...pc.>..
	defb 007h,000h,081h,0ffh,008h,001h,000h	; a34c

; ----------------------------------------------------------------------
; DATOS colores_A353: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 1, ficha 0 de la lista 0xA18B (p00:4595); lo leen p01:69FF (21
;   bytes)
;   0xa353..0xa368  (21 bytes)
DATA_colores_A353:
	defb 004h,000h,084h,001h,00fh,03fh,0fah,004h,000h,084h,0ffh,0b7h,0dah,00dh,005h,000h	; a353  .....?..........
	defb 083h,0e0h,0fch,0dbh,000h	; a363

; ----------------------------------------------------------------------
; DATOS rachas_A368: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (21 bytes)
;   0xa368..0xa37d  (21 bytes)
DATA_rachas_A368:
	defb 004h,000h,084h,001h,00fh,03fh,0fah,004h,000h,084h,0ffh,0b7h,0dah,00dh,005h,000h	; a368  .....?..........
	defb 083h,0e0h,0fch,0dbh,000h	; a378

; ----------------------------------------------------------------------
; DATOS colores_A37D: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 16, ficha 1 de la lista 0xA18B (p00:4595); lo leen p01:69FF (42
;   bytes)
;   0xa37d..0xa3a7  (42 bytes)
DATA_colores_A37D:
	defb 0a8h,003h,00fh,01fh,03fh,07fh,0ech,0f8h,0d4h,0f4h,0e9h,090h,040h,012h,081h,083h	; a37d  ....?.......@...
	defb 083h,080h,0e0h,0f8h,0fch,0feh,0feh,0fbh,0deh,02fh,0b7h,06bh,00eh,095h,01bh,00fh	; a38d  ........./.k....
	defb 00eh,040h,042h,040h,090h,0e0h,0b0h,0eah,0a4h,000h	; a39d  .@B@......

; ----------------------------------------------------------------------
; DATOS colores_A3A7: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 21, ficha 2 de la lista 0xA18B (p00:4595); lo leen p01:69FF (88
;   bytes)
;   0xa3a7..0xa3ff  (88 bytes)
DATA_colores_A3A7:
	defb 003h,0c0h,003h,080h,0d2h,000h,080h,027h,05fh,0bbh,05bh,07eh,03ch,055h,0bah,08bh	; a3a7  .......'_.[~<U..
	defb 003h,07eh,043h,01fh,00fh,03fh,0f5h,038h,083h,068h,0f0h,07fh,056h,028h,01dh,0bfh	; a3b7  .~C..?.8.h..V(..
	defb 05fh,0cfh,0efh,02dh,006h,01bh,01eh,0f4h,0fah,0ffh,0edh,0fah,0bfh,0d4h,0cbh,006h	; a3c7  _..-............
	defb 004h,020h,0c0h,0aah,0d5h,06fh,0deh,0e4h,0c8h,003h,002h,011h,01dh,027h,06fh,03fh	; a3d7  . ...o.......'o?
	defb 08fh,05dh,03fh,02bh,04eh,01fh,02fh,0f0h,003h,02eh,056h,0bch,06ch,034h,08ah,00ah	; a3e7  .]?+N./...V.l4..
	defb 025h,08ah,055h,06bh,0b6h,09fh,0f5h,000h	; a3f7  %.Uk....

; ----------------------------------------------------------------------
; DATOS colores_A3FF: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 32, ficha 3 de la lista 0xA18B (p00:4595); lo leen p01:69FF (52
;   bytes)
;   0xa3ff..0xa433  (52 bytes)
DATA_colores_A3FF:
	defb 005h,001h,085h,003h,023h,013h,000h,000h,006h,080h,0a8h,0f8h,0e8h,0d0h,0aah,0f0h	; a3ff  ....#...........
	defb 0d0h,0e8h,0d1h,018h,04ah,066h,03ch,0c1h,067h,041h,0dah,0f9h,0f4h,0f8h,0d1h,0a4h	; a40f  ....Jf<.gA......
	defb 0f0h,090h,002h,03bh,015h,03eh,02bh,05dh,017h,05fh,0b5h,0f5h,0fah,0d5h,0feh,0bah	; a41f  .....>+]._......
	defb 0ddh,0afh,0fdh,000h	; a42f

; ----------------------------------------------------------------------
; DATOS colores_A433: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 41, ficha 4 de la lista 0xA18B (p00:4595); lo leen p01:69FF (58
;   bytes)
;   0xa433..0xa46d  (58 bytes)
DATA_colores_A433:
	defb 0b8h,0f0h,003h,02eh,056h,0bch,06ch,034h,08ah,0eah,0f5h,00fh,028h,02ch,030h,019h	; a433  ....V.l4....(,0.
	defb 00eh,058h,0a0h,053h,0feh,040h,00ch,00eh,003h,01fh,0f2h,0c4h,02ch,0c6h,00eh,01ch	; a443  .X.S.@......,...
	defb 0f8h,0eah,0f5h,00fh,028h,02ch,030h,019h,00eh,058h,0a0h,053h,0feh,040h,00ch,00eh	; a453  ....(,0..X.S.@..
	defb 003h,01fh,0f2h,0c4h,02ch,0c6h,00eh,01ch,0f8h,000h	; a463  ....,.....

; ----------------------------------------------------------------------
; DATOS colores_A46D: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 48, ficha 5 de la lista 0xA18B (p00:4595); lo leen p01:69FF (58
;   bytes)
;   0xa46d..0xa4a7  (58 bytes)
DATA_colores_A46D:
	defb 085h,01bh,01dh,01dh,00fh,00bh,003h,007h,0b0h,0f8h,0e8h,0d0h,0aah,0f0h,0d0h,0e8h	; a46d  ................
	defb 0d1h,018h,04ah,066h,03ch,0c1h,067h,041h,0dah,0f9h,0f4h,0f8h,0d1h,0a4h,0f0h,090h	; a47d  ..Jf<.gA........
	defb 002h,03bh,015h,03eh,02bh,05dh,017h,05fh,0b5h,0f5h,0fah,0d5h,0feh,0bah,0ddh,0afh	; a48d  ...>+]._........
	defb 0fdh,002h,086h,086h,08ah,0dah,0d6h,0b6h,0aeh,000h	; a49d  ..........

; ----------------------------------------------------------------------
; DATOS colores_A4A7: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 57, ficha 6 de la lista 0xA18B (p00:4595); lo leen p01:69FF (54
;   bytes)
;   0xa4a7..0xa4dd  (54 bytes)
DATA_colores_A4A7:
	defb 090h,05ch,0ech,0f4h,0f8h,0f8h,0fch,07ch,0bch,0d8h,0d8h,068h,068h,0b0h,0b0h,0d0h	; a4a7  .\.....|...hh...
	defb 0c0h,004h,000h,084h,040h,020h,030h,078h,003h,000h,085h,080h,0c0h,060h,078h,03eh	; a4b7  ....@ 0x.....`x>
	defb 005h,000h,083h,001h,00fh,07fh,004h,000h,08ch,003h,007h,019h,05eh,01fh,02fh,077h	; a4c7  ............^./w
	defb 0f3h,06bh,09dh,0bdh,07eh,000h	; a4d7

; ----------------------------------------------------------------------
; DATOS colores_A4DD: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 64, ficha 7 de la lista 0xA18B (p00:4595); lo leen p01:69FF (55
;   bytes)
;   0xa4dd..0xa514  (55 bytes)
DATA_colores_A4DD:
	defb 004h,007h,003h,003h,0b1h,001h,0feh,0fah,0f5h,0ech,0fah,0bfh,0d4h,0cbh,018h,04ah	; a4dd  ...............J
	defb 066h,03ch,0c1h,067h,041h,0dah,0c0h,0b6h,050h,088h,00bh,0b6h,09fh,0f5h,05bh,06fh	; a4ed  f<.gA...P.....[o
	defb 0bfh,07fh,0ebh,057h,0abh,007h,0b6h,0d5h,028h,0d0h,0a8h,054h,089h,07ah,064h,0ech	; a4fd  ...W....(..T.zd.
	defb 0d4h,0cch,0b4h,034h,054h,088h,000h	; a50d

; ----------------------------------------------------------------------
; DATOS colores_A514: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 71, ficha 8 de la lista 0xA18B (p00:4595); lo leen p01:69FF (74
;   bytes)
;   0xa514..0xa55e  (74 bytes)
DATA_colores_A514:
	defb 0c8h,000h,003h,00fh,03fh,0dfh,0ech,0f3h,0cfh,0feh,07fh,07fh,0bfh,0beh,0d8h,0d8h	; a514  ....?...........
	defb 0e0h,01ch,0ebh,0f7h,0cfh,03fh,0feh,0f0h,0c0h,01dh,03eh,07fh,0dbh,0b1h,064h,0c8h	; a524  .....?....>...d.
	defb 091h,022h,005h,08bh,0d7h,0efh,0feh,0fch,0f8h,0f0h,0e0h,080h,000h,030h,01ch,00eh	; a534  ."...........0..
	defb 03fh,010h,000h,080h,000h,001h,003h,007h,00fh,0c0h,0c0h,080h,003h,05fh,03fh,013h	; a544  ?............_?.
	defb 0c8h,004h,040h,000h,001h,001h,002h,007h,00bh,000h	; a554  ..@.......

; ----------------------------------------------------------------------
; DATOS colores_A55E: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 80, ficha 9 de la lista 0xA18B (p00:4595); lo leen p01:69FF (74
;   bytes)
;   0xa55e..0xa5a8  (74 bytes)
DATA_colores_A55E:
	defb 091h,0f8h,078h,0b0h,0c0h,0a0h,040h,040h,0c0h,0bfh,05fh,0cfh,0efh,0edh,0c6h,01bh	; a55e  ..x...@@.._.....
	defb 01eh,001h,005h,000h,002h,001h,0a0h,027h,05fh,03bh,05bh,07eh,03ch,055h,0bah,058h	; a56e  .......'_.[~<U.X
	defb 0a0h,053h,0ech,05fh,0f1h,007h,003h,01dh,0efh,0f6h,0bch,0f0h,006h,00ch,0f8h,0eah	; a57e  .S._............
	defb 0f5h,01fh,00fh,033h,030h,018h,00eh,005h,000h,002h,080h,081h,0c0h,005h,000h,002h	; a58e  ...30...........
	defb 040h,081h,0c0h,005h,000h,083h,080h,040h,040h,000h	; a59e  @......@@.

; ----------------------------------------------------------------------
; DATOS colores_A5A8: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 96, ficha 10 de la lista 0xA18B (p00:4595); lo leen p01:69FF (95
;   bytes)
;   0xa5a8..0xa607  (95 bytes)
DATA_colores_A5A8:
	defb 004h,0c0h,09ah,040h,080h,040h,080h,038h,07eh,0bdh,0f4h,079h,07eh,0bdh,0dfh,0feh	; a5a8  ...@.@.8~..y~...
	defb 06dh,08bh,03fh,0dfh,07fh,0bfh,0feh,0c0h,0e0h,0d3h,02ah,07dh,07ah,003h,03eh,09fh	; a5b8  m.?.......*}z.>.
	defb 0bdh,03ch,03dh,07ah,079h,07bh,086h,0f0h,003h,02eh,056h,0bch,06ch,034h,08ah,018h	; a5c8  .<=zy{....V.l4..
	defb 038h,070h,0f0h,0e0h,0e0h,0c0h,0c0h,000h,020h,010h,018h,01ch,00eh,00eh,000h,004h	; a5d8  8p...... .......
	defb 0c0h,08ch,0c1h,0c3h,0c7h,0cfh,0c0h,0e1h,0e1h,0f3h,0f3h,0f7h,0e7h,00fh,003h,000h	; a5e8  ................
	defb 08dh,0a0h,054h,0eah,042h,0bah,028h,02ch,023h,02dh,026h,029h,026h,02fh,000h	; a5f8  ..T.B.(,#-&)&/.

; ----------------------------------------------------------------------
; DATOS colores_A607: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 112, ficha 11 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (107 bytes)
;   0xa607..0xa672  (107 bytes)
DATA_colores_A607:
	defb 002h,00ch,081h,004h,005h,000h,0a0h,0fah,0fdh,0fah,0dch,0f4h,0f8h,068h,0d0h,08ah	; a607  .............h..
	defb 065h,0f2h,0d0h,0f4h,0c6h,01fh,07fh,077h,0cdh,07fh,0beh,057h,02bh,007h,01bh,08fh	; a617  e......w...W+...
	defb 097h,04bh,069h,0f3h,062h,087h,07eh,005h,000h,002h,002h,081h,003h,005h,000h,002h	; a627  .Ki.b.~.........
	defb 001h,08bh,003h,02eh,059h,047h,059h,05eh,0b9h,0a7h,09fh,00fh,00fh,006h,000h,090h	; a637  ....YGY^........
	defb 09fh,03fh,07fh,000h,0feh,0feh,07ch,038h,05dh,0edh,0c5h,0b9h,07ch,092h,0eeh,0d6h	; a647  .?....|8]...|...
	defb 005h,000h,093h,001h,002h,002h,080h,080h,000h,000h,001h,007h,01fh,07fh,000h,000h	; a657  ................
	defb 01ch,078h,0f0h,0e0h,0c0h,080h,004h,000h,004h,080h,000h	; a667  .x.........

; ----------------------------------------------------------------------
; DATOS colores_A672: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 128, ficha 12 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (134 bytes)
;   0xa672..0xa6f8  (134 bytes)
DATA_colores_A672:
	defb 09bh,08eh,08dh,0dch,0cbh,0d4h,0c8h,0b0h,060h,038h,0c0h,078h,0f0h,07fh,056h,028h	; a672  ........`8.x..V(
	defb 01dh,0f1h,00eh,0feh,043h,01fh,00fh,03fh,0f5h,0a0h,040h,080h,005h,000h,088h,018h	; a682  ....C..?..@.....
	defb 01ch,00eh,00fh,007h,007h,003h,003h,006h,000h,082h,007h,03fh,003h,000h,085h,003h	; a692  ...........?....
	defb 01eh,0fch,0f8h,0f0h,004h,003h,084h,083h,0c3h,0e3h,0f3h,003h,001h,003h,002h,082h	; a6a2  ................
	defb 005h,004h,008h,040h,0a0h,03bh,0fdh,0feh,030h,0fch,07bh,097h,0efh,03fh,05ch,06bh	; a6b2  ...@....0.{..?\k
	defb 0f7h,0c9h,0beh,07fh,01ch,0f8h,0feh,0fch,0f8h,0f0h,0e0h,0c0h,080h,003h,087h,087h	; a6c2  ................
	defb 0cfh,0cfh,0efh,0e7h,0f0h,003h,000h,098h,005h,02ah,057h,042h,05dh,014h,034h,0c4h	; a6d2  .........*WB].4.
	defb 0b4h,064h,094h,064h,0f4h,000h,004h,008h,018h,038h,070h,070h,000h,001h,007h,01fh	; a6e2  .d.d.....8pp....
	defb 003h,03fh,082h,01fh,00fh,000h	; a6f2

; ----------------------------------------------------------------------
; DATOS colores_A6F8: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 150, ficha 13 de la lista 0xA18B (p00:4595); lo leen p01:69FF (75
;   bytes)
;   0xa6f8..0xa743  (75 bytes)
DATA_colores_A6F8:
	defb 002h,01fh,003h,03fh,087h,07fh,0ffh,0ffh,003h,081h,0c1h,0c1h,003h,0e1h,004h,0f1h	; a6f8  ...?............
	defb 087h,0e1h,0e3h,0c3h,0c3h,087h,0f0h,0f8h,003h,0fch,002h,0feh,082h,0ffh,00fh,005h	; a708  ................
	defb 01fh,002h,03fh,003h,0e0h,002h,060h,084h,020h,030h,010h,018h,003h,01ch,084h,01eh	; a718  ..?...`. 0......
	defb 00eh,01fh,00fh,004h,087h,081h,08fh,003h,00fh,002h,0ffh,08eh,00fh,007h,001h,003h	; a728  ................
	defb 0fah,0fdh,001h,008h,010h,030h,060h,060h,0e0h,0e0h,000h	; a738  .....0``...

; ----------------------------------------------------------------------
; DATOS colores_A743: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 160, ficha 14 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (120 bytes)
;   0xa743..0xa7bb  (120 bytes)
DATA_colores_A743:
	defb 084h,02fh,01fh,00fh,007h,004h,000h,082h,0c0h,080h,006h,000h,084h,04bh,0a5h,0cfh	; a743  ./...........K..
	defb 0f8h,004h,000h,08ah,0f9h,0fch,0feh,0ffh,07fh,07fh,03eh,01ch,0f0h,0f0h,00ah,000h	; a753  ..........>.....
	defb 004h,001h,082h,004h,005h,003h,00bh,002h,017h,081h,014h,003h,0a0h,088h,020h,0a0h	; a763  .............. .
	defb 0a0h,020h,0a0h,0e0h,0c0h,080h,005h,000h,097h,097h,079h,0feh,070h,03ch,018h,0fch	; a773  . ........y.p<..
	defb 033h,0bah,0b7h,0a3h,09dh,03eh,049h,077h,06bh,000h,000h,038h,01eh,00fh,007h,003h	; a783  3....>Iwk..8....
	defb 003h,001h,002h,000h,088h,080h,0e0h,0f8h,0feh,001h,00fh,03fh,07fh,005h,0ffh,097h	; a793  ...........?....
	defb 0fch,0c0h,0ffh,0feh,0fch,0f8h,0f0h,074h,09ah,0e2h,09ah,07ah,09dh,0e5h,0f9h,038h	; a7a3  .......t...z...8
	defb 07eh,0bdh,0d3h,0efh,0d3h,03ch,018h,000h	; a7b3  ~....<..

; ----------------------------------------------------------------------
; DATOS colores_A7BB: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 177, ficha 15 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (122 bytes)
;   0xa7bb..0xa835  (122 bytes)
DATA_colores_A7BB:
	defb 0b9h,068h,0fbh,0c9h,078h,074h,0dch,0c7h,061h,01eh,038h,038h,062h,0c1h,003h,007h	; a7bb  .h..xt..a.88b...
	defb 00fh,03fh,03fh,07fh,07eh,07eh,0fch,0fch,0f8h,0f8h,0f0h,0e0h,0e1h,0c3h,087h,007h	; a7cb  .??.~~..........
	defb 01fh,01fh,03fh,07eh,0fah,0f8h,0e0h,0c0h,080h,0eeh,070h,03ah,069h,0a0h,0e0h,000h	; a7db  ..?~......p:i...
	defb 048h,0fch,0f0h,0f0h,0aah,0c0h,080h,050h,000h,000h,003h,002h,084h,001h,003h,001h	; a7eb  H......P........
	defb 001h,003h,007h,002h,003h,002h,001h,0b1h,000h,0e0h,060h,038h,004h,007h,001h,000h	; a7fb  ..........`8....
	defb 000h,080h,0c0h,0c0h,0e0h,0e0h,0f0h,0f8h,0fch,07ch,03eh,00eh,007h,001h,081h,0c0h	; a80b  .........|>.....
	defb 0c0h,00fh,0f6h,0feh,0f4h,0f8h,070h,0e8h,070h,0f8h,0fch,0feh,0feh,000h,080h,0e0h	; a81b  ......p.p.......
	defb 0fch,0feh,0ffh,0ffh,07fh,01fh,007h,001h,03fh,000h	; a82b  ........?.

; ----------------------------------------------------------------------
; DATOS colores_A835: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 192, ficha 16 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (120 bytes)
;   0xa835..0xa8ad  (120 bytes)
DATA_colores_A835:
	defb 003h,000h,085h,0c0h,078h,03fh,01fh,00fh,006h,000h,085h,0e0h,0fch,080h,0e0h,0f8h	; a835  ....x?..........
	defb 003h,0fch,082h,0f8h,0f0h,008h,002h,003h,080h,003h,040h,082h,0a0h,020h,003h,0a0h	; a845  ..........@.. ..
	defb 081h,020h,003h,0a0h,095h,020h,02bh,027h,02fh,053h,05ch,0bfh,0bch,0b3h,0dch,0bfh	; a855  . ... +'/S\.....
	defb 07fh,00ch,03fh,0deh,0e9h,0f7h,07fh,07fh,03fh,00eh,004h,000h,083h,0e0h,0c0h,080h	; a865  ..?.....?.......
	defb 005h,000h,090h,0cfh,033h,0fch,018h,0fch,07eh,018h,000h,00ch,070h,0fch,0f3h,0cfh	; a875  ....3...~...p...
	defb 03fh,0cfh,0f3h,003h,008h,003h,004h,002h,002h,002h,001h,086h,002h,004h,008h,010h	; a885  ?...............
	defb 020h,040h,006h,000h,092h,03ch,07eh,01ch,07eh,0bdh,0cbh,0f7h,0cbh,03ch,018h,01fh	; a895   @...<~.~....<..
	defb 07fh,03fh,01fh,00fh,007h,003h,001h,000h	; a8a5  .?......

; ----------------------------------------------------------------------
; DATOS colores_A8AD: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 211, ficha 17 de la lista 0xA18B (p00:4595); lo leen p01:69FF (97
;   bytes)
;   0xa8ad..0xa90e  (97 bytes)
DATA_colores_A8AD:
	defb 081h,01fh,007h,00fh,004h,000h,08ch,080h,0c0h,0f0h,0fch,000h,000h,0c0h,0a0h,070h	; a8ad  ...............p
	defb 098h,018h,00eh,004h,000h,08ch,080h,0c0h,0e0h,0f0h,000h,020h,018h,00eh,00fh,007h	; a8bd  ........... ....
	defb 087h,087h,003h,000h,088h,080h,0e0h,030h,01ch,01eh,087h,00fh,00fh,003h,01fh,002h	; a8cd  .......0........
	defb 03fh,096h,0ffh,07fh,0ffh,0ffh,0dfh,0feh,0fch,0f4h,00fh,01eh,03fh,07ah,0fah,0c1h	; a8dd  ?...........?z..
	defb 0d0h,080h,0e1h,0e1h,0c3h,087h,007h,00fh,003h,01fh,087h,03fh,07eh,0ffh,0fdh,0eeh	; a8ed  ...........?~...
	defb 0f2h,0e6h,005h,0ffh,08bh,0fbh,0f7h,0feh,07fh,03ch,01eh,00eh,007h,001h,003h,001h	; a8fd  .........<......
	defb 000h	; a90d

; ----------------------------------------------------------------------
; DATOS colores_A90E: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 224, ficha 18 de la lista 0xA18B (p00:4595); lo leen p01:69FF (97
;   bytes)
;   0xa90e..0xa96f  (97 bytes)
DATA_colores_A90E:
	defb 083h,007h,003h,001h,005h,000h,003h,005h,085h,004h,005h,005h,004h,005h,003h,001h	; a90e  ................
	defb 004h,002h,08bh,005h,0e9h,09eh,07fh,00eh,03ch,018h,03fh,0cch,020h,0a0h,003h,0d0h	; a91e  ........<.?. ...
	defb 002h,0e8h,081h,028h,005h,0a0h,0a7h,020h,0a0h,0a0h,06fh,05fh,03fh,0bfh,0dfh,0efh	; a92e  ...(... ..o_?...
	defb 0f7h,0fbh,0fch,038h,0feh,078h,0fch,0fbh,0f7h,0efh,0fch,033h,0cfh,033h,0fch,000h	; a93e  ...8.x.....3.3..
	defb 038h,0feh,030h,00eh,03fh,0cfh,0f3h,0fch,0f3h,0cfh,080h,0f0h,0fch,0feh,005h,0ffh	; a94e  8.0.?...........
	defb 08fh,03fh,003h,0ffh,07fh,03fh,01fh,00fh,034h,076h,006h,060h,06eh,02ch,07eh,03ch	; a95e  .?...?..4v.`n,~<
	defb 000h	; a96e

; ----------------------------------------------------------------------
; DATOS colores_A96F: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 240, ficha 19 de la lista 0xA18B (p00:4595); lo leen p01:69FF
;   (109 bytes)
;   0xa96f..0xa9dc  (109 bytes)
DATA_colores_A96F:
	defb 002h,000h,082h,008h,003h,009h,000h,085h,001h,003h,007h,001h,001h,003h,003h,085h	; a96f  ................
	defb 007h,00fh,01eh,01ch,002h,003h,000h,082h,0c0h,010h,005h,000h,002h,008h,002h,018h	; a97f  ................
	defb 088h,050h,010h,080h,000h,000h,001h,003h,007h,004h,000h,084h,080h,0c0h,0e0h,030h	; a98f  .P.............0
	defb 004h,000h,089h,003h,006h,018h,000h,00eh,03eh,07ch,0e0h,080h,003h,000h,084h,01eh	; a99f  ........>|......
	defb 078h,0e0h,080h,009h,000h,089h,080h,0c0h,0f0h,0a0h,0c0h,050h,040h,008h,008h,005h	; a9af  x..........P@...
	defb 000h,085h,0c0h,03ch,00fh,007h,007h,003h,000h,085h,001h,003h,00eh,018h,060h,006h	; a9bf  ...<..........`.
	defb 000h,08ah,007h,038h,000h,000h,002h,008h,030h,0c0h,000h,000h,000h	; a9cf  ...8....0....

; ----------------------------------------------------------------------
; DATOS colores_A9DC: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 1, ficha 0 de la lista 0xA214 (p00:4595); lo leen p00:5EB0 (213
;   bytes)
;   0xa9dc..0xaab1  (213 bytes)
DATA_colores_A9DC:
	defb 092h,0f7h,084h,0b7h,095h,094h,0f4h,000h,0ffh,0bdh,0a5h,0bdh,025h,0a5h,0a5h,000h	; a9dc  ............%...
	defb 0ffh,08ah,04ah,003h,02ah,093h,0ebh,000h,0ffh,05eh,050h,05eh,042h,042h,0deh,000h	; a9ec  ..J.*....^P^BB..
	defb 0ffh,000h,000h,001h,002h,004h,008h,010h,0e0h,004h,000h,084h,060h,0f0h,0f0h,060h	; a9fc  ............`..`
	defb 007h,000h,08ah,0ffh,07ah,042h,07ah,00ah,00ah,07ah,000h,0ffh,0f0h,005h,090h,08dh	; aa0c  ....zBz..z......
	defb 000h,0fch,007h,004h,007h,000h,000h,007h,000h,01fh,0bdh,025h,0bdh,003h,0a5h,090h	; aa1c  ...........%....
	defb 000h,0ffh,0ech,02ah,0e9h,049h,029h,02fh,000h,0ffh,000h,000h,00ch,01eh,01eh,00ch	; aa2c  ...*.I)/........
	defb 006h,000h,085h,060h,0f0h,0f0h,060h,01ch,003h,03eh,081h,01ch,006h,000h,083h,007h	; aa3c  ...`..`..>......
	defb 078h,080h,007h,000h,085h,007h,078h,080h,078h,080h,00ah,000h,087h,018h,03ch,03ch	; aa4c  x.....x.x.....<<
	defb 018h,0e0h,060h,0a0h,009h,000h,091h,008h,004h,002h,001h,080h,040h,020h,010h,008h	; aa5c  ..`.........@ ..
	defb 004h,002h,001h,080h,040h,028h,018h,038h,005h,000h,08bh,001h,002h,00ch,010h,060h	; aa6c  ....@(.8.......`
	defb 080h,003h,004h,018h,020h,0c0h,003h,000h,083h,030h,040h,080h,00ah,000h,086h,001h	; aa7c  .... ....0@.....
	defb 006h,008h,034h,040h,080h,007h,000h,004h,080h,004h,000h,004h,001h,002h,000h,081h	; aa8c  ..4@............
	defb 0ffh,00fh,080h,081h,0ffh,007h,000h,081h,03ch,007h,000h,088h,03ch,06eh,02ch,01eh	; aa9c  ........<...<n,.
	defb 07ch,034h,076h,03ch,000h	; aaac

; ----------------------------------------------------------------------
; DATOS colores_AAB1: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 42, ficha 1 de la lista 0xA214 (p00:4595); lo leen p00:5EB0 (24
;   bytes)
;   0xaab1..0xaac9  (24 bytes)
DATA_colores_AAB1:
	defb 004h,000h,094h,060h,0f0h,0f0h,060h,000h,000h,00ch,01eh,01eh,00ch,000h,007h,000h	; aab1  ...`..`.........
	defb 007h,078h,080h,018h,03ch,03ch,018h,000h	; aac1  .x..<<..

; ----------------------------------------------------------------------
; DATOS colores_AAC9: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 1, ficha 0 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (66
;   bytes)
;   0xaac9..0xab0b  (66 bytes)
DATA_colores_AAC9:
	defb 08ah,0edh,0dah,0bah,0bah,075h,075h,0f5h,015h,03dh,07ah,003h,074h,0b3h,034h,038h	; aac9  .....uu..=z.t.48
	defb 018h,003h,007h,00fh,01fh,03fh,001h,074h,0f6h,004h,01fh,039h,017h,02fh,05ch,03ah	; aad9  .....?.t...9./\:
	defb 054h,04fh,03fh,0efh,026h,01fh,019h,021h,004h,082h,0e0h,0f8h,0feh,03fh,00fh,05eh	; aae9  TO?.&..!.....?.^
	defb 093h,007h,003h,001h,020h,008h,0cch,060h,029h,0fdh,03eh,08fh,0c7h,063h,03dh,01fh	; aaf9  .... ..`).>..c=.
	defb 003h,000h	; ab09

; ----------------------------------------------------------------------
; DATOS colores_AB0B: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 17, ficha 1 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (59
;   bytes)
;   0xab0b..0xab46  (59 bytes)
DATA_colores_AB0B:
	defb 083h,0c6h,0e6h,0e2h,005h,0f3h,085h,098h,088h,088h,040h,040h,003h,0a0h,003h,0eeh	; ab0b  ..........@@....
	defb 002h,0deh,003h,0beh,09bh,000h,083h,000h,020h,000h,012h,032h,062h,072h,080h,0bdh	; ab1b  ........ ..2br..
	defb 018h,024h,080h,004h,01ch,008h,000h,020h,008h,000h,000h,040h,080h,004h,010h,001h	; ab2b  .$..... ...@....
	defb 004h,000h,085h,008h,000h,000h,002h,008h,004h,000h,000h	; ab3b  ...........

; ----------------------------------------------------------------------
; DATOS colores_AB46: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 33, ficha 2 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (64
;   bytes)
;   0xab46..0xab86  (64 bytes)
DATA_colores_AB46:
	defb 002h,0f9h,08eh,099h,0a9h,0b0h,0bch,0cch,070h,0d0h,0d0h,0e8h,0f4h,0f4h,0fah,0fah	; ab46  ........p.......
	defb 0fdh,003h,038h,0a5h,01ch,00eh,003h,070h,0cah,000h,000h,001h,000h,040h,020h,042h	; ab56  ..8....p.....@ B
	defb 0c6h,00bh,036h,042h,028h,010h,015h,001h,002h,05eh,0e6h,0fah,07ch,01eh,006h,0e0h	; ab66  ..6B(....^..|...
	defb 03ch,0c8h,00ch,00eh,01fh,03ch,0f0h,00ah,010h,004h,001h,003h,003h,081h,002h,000h	; ab76  <....<..........

; ----------------------------------------------------------------------
; DATOS colores_AB86: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 49, ficha 3 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (65
;   bytes)
;   0xab86..0xabc7  (65 bytes)
DATA_colores_AB86:
	defb 090h,002h,0f0h,0ech,0d9h,0b9h,073h,0f3h,0e7h,03ch,01eh,086h,040h,0b0h,0dch,0eeh	; ab86  ......s..<..@...
	defb 0f7h,004h,07eh,0ach,07dh,03dh,03bh,03bh,080h,080h,0c0h,0e0h,070h,0b8h,0dch,0efh	; ab96  ..~.}=......p...
	defb 008h,000h,027h,057h,015h,010h,00bh,002h,004h,050h,0c2h,02dh,0feh,0b7h,03ch,0e2h	; aba6  ..'W.....P.-..<.
	defb 01ch,038h,0f1h,042h,090h,001h,005h,01dh,002h,005h,015h,035h,065h,0ebh,0ebh,0cbh	; abb6  .8.B.......5e...
	defb 000h	; abc6

; ----------------------------------------------------------------------
; DATOS rachas_ABC7: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (81 bytes)
;   0xabc7..0xac18  (81 bytes)
DATA_rachas_ABC7:
	defb 086h,000h,080h,0e0h,070h,07fh,07fh,003h,0bfh,082h,078h,0e0h,00ah,000h,083h,088h	; abc7  ....p.....x.....
	defb 0ffh,0f8h,01ch,000h,082h,0c0h,070h,00dh,000h,084h,0b0h,0fch,07fh,07fh,003h,0bfh	; abd7  ......p.........
	defb 083h,07fh,078h,0e0h,008h,000h,085h,080h,018h,08fh,0fch,0e0h,01ch,000h,082h,0e0h	; abe7  ..x.............
	defb 070h,009h,000h,086h,080h,0e0h,070h,0ffh,01fh,001h,00dh,000h,083h,080h,0f0h,0ffh	; abf7  p.....p.........
	defb 00eh,000h,086h,0e0h,0feh,07fh,03fh,01eh,018h,00ch,000h,082h,0fch,0f0h,007h,000h	; ac07  ......?.........
	defb 000h	; ac17

; ----------------------------------------------------------------------
; DATOS colores_AC18: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 1, ficha 0 de la lista 0xA221 (p00:4595); lo leen p00:5ED4 (34
;   bytes)
;   0xac18..0xac3a  (34 bytes)
DATA_colores_AC18:
	defb 0a0h,097h,0d4h,0b7h,094h,094h,097h,000h,0ffh,0a2h,036h,02ah,022h,022h,0a2h,000h	; ac18  ..........6*""..
	defb 0ffh,0f7h,084h,0e7h,080h,080h,0f7h,000h,0ffh,0afh,028h,0afh,0a1h,0a1h,0afh,000h	; ac28  ..........(.....
	defb 0ffh,000h	; ac38

; ----------------------------------------------------------------------
; DATOS dibujos_AC3A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 0 de la lista 0xA221 (p00:4595); lo leen p00:5ED4 (3
;   bytes)
;   0xac3a..0xac3d  (3 bytes)
DATA_dibujos_AC3A:
	defb 020h,070h,000h	; ac3a

; ----------------------------------------------------------------------
; DATOS dibujos_AC3D: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 0 de la lista 0xA16D (p00:4595); lo leen p01:69D5 (154
;   bytes)
;   0xac3d..0xacd7  (154 bytes)
DATA_dibujos_AC3D:
	defb 002h,000h,00eh,090h,008h,060h,009h,080h,082h,060h,090h,005h,080h,089h,060h,090h	; ac3d  .....`...`....`.
	defb 090h,080h,080h,060h,080h,090h,096h,004h,060h,005h,090h,004h,098h,082h,086h,096h	; ac4d  ...`....`.......
	defb 007h,090h,002h,096h,002h,098h,004h,096h,002h,098h,085h,099h,096h,096h,099h,099h	; ac5d  ................
	defb 006h,096h,083h,099h,096h,096h,003h,098h,006h,096h,005h,090h,002h,098h,081h,060h	; ac6d  ...............`
	defb 004h,090h,081h,080h,003h,060h,005h,080h,082h,090h,060h,003h,090h,008h,096h,003h	; ac7d  .....`....`.....
	defb 098h,003h,096h,004h,098h,081h,086h,003h,096h,002h,090h,004h,098h,086h,086h,096h	; ac8d  ................
	defb 090h,080h,080h,060h,003h,090h,002h,096h,007h,080h,004h,090h,003h,080h,002h,090h	; ac9d  ...`............
	defb 007h,080h,082h,096h,080h,004h,060h,082h,080h,060h,003h,098h,081h,080h,008h,060h	; acad  ......`..`.....`
	defb 084h,080h,090h,090h,098h,010h,0e0h,081h,0f0h,017h,0e0h,005h,0f0h,011h,0e0h,005h	; acbd  ................
	defb 050h,085h,0e0h,0f0h,0f0h,0f4h,0f4h,010h,040h,000h	; accd  P.......@.

; ----------------------------------------------------------------------
; DATOS dibujos_ACD7: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 0 de la lista 0xA18B (p00:4595); lo leen p01:69FF (13
;   bytes)
;   0xacd7..0xace4  (13 bytes)
DATA_dibujos_ACD7:
	defb 007h,0c0h,081h,0c2h,004h,0c0h,004h,0c2h,007h,0c0h,081h,0c2h,000h	; acd7  .............

; ----------------------------------------------------------------------
; DATOS dibujos_ACE4: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 16, ficha 1 de la lista 0xA18B (p00:4595); lo leen p01:69FF (14
;   bytes)
;   0xace4..0xacf2  (14 bytes)
DATA_dibujos_ACE4:
	defb 005h,0c0h,008h,0c2h,082h,0c3h,032h,007h,0c0h,00ah,0c2h,008h,032h,000h	; ace4  ......2.....2.

; ----------------------------------------------------------------------
; DATOS dibujos_ACF2: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 21, ficha 2 de la lista 0xA18B (p00:4595); lo leen p01:69FF (44
;   bytes)
;   0xacf2..0xad1e  (44 bytes)
DATA_dibujos_ACF2:
	defb 010h,0c0h,088h,0c2h,020h,0c0h,0c2h,0c2h,0c0h,0c0h,0c2h,003h,0c0h,081h,0c2h,004h	; acf2  .... ...........
	defb 0c0h,002h,0c3h,002h,0c2h,004h,0c0h,007h,0c2h,083h,0c3h,032h,032h,008h,0c2h,00eh	; ad02  ...........22...
	defb 032h,083h,0e0h,0c0h,0c3h,004h,032h,008h,0c2h,081h,0c3h,000h	; ad12  2.....2.....

; ----------------------------------------------------------------------
; DATOS dibujos_AD1E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 32, ficha 3 de la lista 0xA18B (p00:4595); lo leen p01:69FF (18
;   bytes)
;   0xad1e..0xad30  (18 bytes)
DATA_dibujos_AD1E:
	defb 010h,0c0h,008h,0c2h,088h,050h,070h,0f0h,0b0h,030h,032h,0c3h,0c2h,007h,032h,011h	; ad1e  .....Pp..02...2.
	defb 0c2h,000h	; ad2e

; ----------------------------------------------------------------------
; DATOS dibujos_AD30: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 41, ficha 4 de la lista 0xA18B (p00:4595); lo leen p01:69FF (57
;   bytes)
;   0xad30..0xad69  (57 bytes)
DATA_dibujos_AD30:
	defb 083h,0b0h,0c0h,0c3h,004h,032h,0b1h,0c2h,0c3h,0c2h,0c0h,080h,090h,0a0h,0b0h,0b0h	; ad30  .....2..........
	defb 032h,0c2h,0c2h,0c0h,0c0h,080h,0a0h,0b0h,0c2h,0c0h,0c0h,080h,090h,0a0h,0b0h,0b0h	; ad40  2...............
	defb 0c3h,0c2h,0c0h,050h,070h,0e0h,0f0h,0e0h,032h,0c2h,0c2h,0c0h,0c0h,050h,0e0h,0f0h	; ad50  ...Pp...2....P..
	defb 0c2h,0c0h,0c0h,050h,070h,0f0h,0f0h,0e0h,000h	; ad60  ...Pp....

; ----------------------------------------------------------------------
; DATOS dibujos_AD69: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 48, ficha 5 de la lista 0xA18B (p00:4595); lo leen p01:69FF (23
;   bytes)
;   0xad69..0xad80  (23 bytes)
DATA_dibujos_AD69:
	defb 008h,0c0h,008h,0c2h,088h,050h,070h,0f0h,0b0h,030h,032h,0c3h,0c2h,007h,032h,011h	; ad69  .....Pp..02...2.
	defb 0c2h,082h,020h,030h,006h,020h,000h	; ad79

; ----------------------------------------------------------------------
; DATOS dibujos_AD80: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 57, ficha 6 de la lista 0xA18B (p00:4595); lo leen p01:69FF (15
;   bytes)
;   0xad80..0xad8f  (15 bytes)
DATA_dibujos_AD80:
	defb 020h,0e0h,007h,0f0h,081h,0f4h,007h,0f0h,083h,0f4h,0f0h,0f0h,006h,0f4h,000h	; ad80   ..............

; ----------------------------------------------------------------------
; DATOS dibujos_AD8F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 64, ficha 7 de la lista 0xA18B (p00:4595); lo leen p01:69FF (28
;   bytes)
;   0xad8f..0xadab  (28 bytes)
DATA_dibujos_AD8F:
	defb 009h,0c0h,006h,0c2h,088h,0c3h,050h,070h,0f0h,0b0h,030h,032h,0c3h,008h,0c2h,081h	; ad8f  ......Pp..02....
	defb 0c3h,006h,0c2h,081h,0c3h,008h,0c2h,081h,0c0h,008h,020h,000h	; ad9f  .......... .

; ----------------------------------------------------------------------
; DATOS dibujos_ADAB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 71, ficha 8 de la lista 0xA18B (p00:4595); lo leen p01:69FF (35
;   bytes)
;   0xadab..0xadce  (35 bytes)
DATA_dibujos_ADAB:
	defb 004h,0f0h,004h,0f4h,081h,0e0h,003h,0e4h,004h,0e0h,005h,0f4h,003h,0feh,003h,0f0h	; adab  ................
	defb 008h,0f6h,002h,0e6h,007h,0e0h,008h,060h,004h,0f0h,003h,0e0h,008h,060h,002h,0e0h	; adbb  .......`.....`..
	defb 003h,0f0h,000h	; adcb

; ----------------------------------------------------------------------
; DATOS dibujos_ADCE: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 80, ficha 9 de la lista 0xA18B (p00:4595); lo leen p01:69FF (35
;   bytes)
;   0xadce..0xadf1  (35 bytes)
DATA_dibujos_ADCE:
	defb 002h,020h,006h,0c0h,002h,0c3h,002h,0c2h,014h,0c0h,081h,032h,003h,0c2h,002h,0c0h	; adce  . .........2....
	defb 002h,090h,002h,0c2h,003h,0c0h,085h,080h,090h,090h,0c3h,0c2h,003h,0c0h,013h,090h	; adde  ................
	defb 008h,060h,000h	; adee

; ----------------------------------------------------------------------
; DATOS dibujos_ADF1: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 96, ficha 10 de la lista 0xA18B (p00:4595); lo leen p01:69FF (56
;   bytes)
;   0xadf1..0xae29  (56 bytes)
DATA_dibujos_ADF1:
	defb 009h,0c0h,088h,0c2h,0c3h,0c2h,0c2h,0c3h,0c2h,0c0h,0c0h,006h,0c2h,003h,0c0h,084h	; adf1  ................
	defb 020h,032h,020h,020h,003h,0c0h,006h,020h,084h,0c2h,090h,0c0h,0c3h,004h,032h,081h	; ae01   2  ... ......2.
	defb 0c2h,00ch,090h,004h,080h,004h,090h,004h,080h,002h,090h,006h,080h,005h,060h,003h	; ae11  ..............`.
	defb 080h,003h,060h,004h,080h,081h,090h,000h	; ae21  ..`.....

; ----------------------------------------------------------------------
; DATOS dibujos_AE29: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 112, ficha 11 de la lista 0xA18B (p00:4595); lo leen p01:69FF (39
;   bytes)
;   0xae29..0xae50  (39 bytes)
DATA_dibujos_AE29:
	defb 013h,0c0h,081h,020h,004h,0c0h,002h,0c2h,006h,0c0h,003h,0c2h,003h,032h,081h,0c2h	; ae29  ... .........2..
	defb 004h,0c0h,013h,090h,00dh,080h,081h,098h,005h,080h,003h,090h,008h,080h,004h,060h	; ae39  ...............`
	defb 004h,080h,00bh,090h,009h,080h,000h	; ae49

; ----------------------------------------------------------------------
; DATOS dibujos_AE50: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 128, ficha 12 de la lista 0xA18B (p00:4595); lo leen p01:69FF (47
;   bytes)
;   0xae50..0xae7f  (47 bytes)
DATA_dibujos_AE50:
	defb 00bh,0c0h,081h,0c2h,007h,0c0h,002h,0c2h,002h,0c0h,081h,0c2h,008h,0c0h,01ch,090h	; ae50  ................
	defb 017h,080h,081h,098h,00bh,080h,002h,098h,007h,080h,002h,090h,006h,080h,005h,060h	; ae60  ...............`
	defb 003h,080h,003h,060h,004h,080h,005h,090h,004h,080h,002h,090h,006h,080h,000h	; ae70  ...`...........

; ----------------------------------------------------------------------
; DATOS dibujos_AE7F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 150, ficha 13 de la lista 0xA18B (p00:4595); lo leen p01:69FF (49
;   bytes)
;   0xae7f..0xaeb0  (49 bytes)
DATA_dibujos_AE7F:
	defb 081h,090h,003h,080h,006h,060h,003h,080h,006h,090h,004h,080h,002h,060h,003h,080h	; ae7f  .....`.......`..
	defb 005h,090h,004h,080h,003h,060h,081h,090h,004h,080h,003h,060h,002h,080h,003h,090h	; ae8f  .....`.....`....
	defb 006h,080h,007h,090h,004h,098h,002h,060h,081h,0c0h,004h,060h,002h,080h,081h,090h	; ae9f  .......`...`....
	defb 000h	; aeaf

; ----------------------------------------------------------------------
; DATOS dibujos_AEB0: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 160, ficha 14 de la lista 0xA18B (p00:4595); lo leen p01:69FF (41
;   bytes)
;   0xaeb0..0xaed9  (41 bytes)
DATA_dibujos_AEB0:
	defb 010h,0c0h,003h,0c2h,005h,0c0h,033h,080h,003h,098h,003h,080h,003h,090h,004h,080h	; aeb0  ......3.........
	defb 007h,090h,005h,080h,007h,090h,005h,080h,083h,090h,098h,098h,005h,080h,006h,090h	; aec0  ................
	defb 002h,080h,081h,098h,006h,080h,081h,098h,000h	; aed0  .........

; ----------------------------------------------------------------------
; DATOS dibujos_AED9: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 177, ficha 15 de la lista 0xA18B (p00:4595); lo leen p01:69FF (25
;   bytes)
;   0xaed9..0xaef2  (25 bytes)
DATA_dibujos_AED9:
	defb 03dh,060h,004h,080h,007h,060h,002h,080h,006h,060h,002h,080h,00ch,060h,002h,080h	; aed9  =`...`...`...`..
	defb 081h,086h,00bh,060h,00bh,098h,081h,086h,000h	; aee9  ...`.....

; ----------------------------------------------------------------------
; DATOS dibujos_AEF2: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 192, ficha 16 de la lista 0xA18B (p00:4595); lo leen p01:69FF (28
;   bytes)
;   0xaef2..0xaf0e  (28 bytes)
DATA_dibujos_AEF2:
	defb 012h,090h,029h,080h,081h,098h,017h,080h,007h,098h,005h,080h,00bh,060h,003h,080h	; aef2  ..)..........`..
	defb 00ah,060h,082h,080h,098h,006h,080h,002h,098h,007h,080h,000h	; af02  .`..........

; ----------------------------------------------------------------------
; DATOS dibujos_AF0E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 211, ficha 17 de la lista 0xA18B (p00:4595); lo leen p01:69FF (7
;   bytes)
;   0xaf0e..0xaf15  (7 bytes)
DATA_dibujos_AF0E:
	defb 003h,080h,005h,090h,060h,060h,000h	; af0e

; ----------------------------------------------------------------------
; DATOS dibujos_AF15: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 224, ficha 18 de la lista 0xA18B (p00:4595); lo leen p01:69FF (42
;   bytes)
;   0xaf15..0xaf3f  (42 bytes)
DATA_dibujos_AF15:
	defb 01bh,080h,003h,098h,00fh,080h,00ch,060h,003h,096h,009h,060h,085h,086h,096h,096h	; af15  .......`...`....
	defb 098h,098h,005h,080h,081h,060h,003h,090h,006h,080h,002h,098h,081h,086h,004h,080h	; af25  .....`..........
	defb 088h,0a8h,0b8h,0f6h,0f6h,0b8h,0a8h,060h,060h,000h	; af35  .......``.

; ----------------------------------------------------------------------
; DATOS dibujos_AF3F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 240, ficha 19 de la lista 0xA18B (p00:4595); lo leen p01:69FF (5
;   bytes)
;   0xaf3f..0xaf44  (5 bytes)
DATA_dibujos_AF3F:
	defb 07fh,060h,081h,060h,000h	; af3f

; ----------------------------------------------------------------------
; DATOS dibujos_AF44: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 0 de la lista 0xA214 (p00:4595); lo leen p00:5EB0 (47
;   bytes)
;   0xaf44..0xaf73  (47 bytes)
DATA_dibujos_AF44:
	defb 038h,070h,007h,030h,081h,070h,007h,030h,081h,070h,007h,090h,081h,070h,007h,090h	; af44  8p.0.p.0.p...p..
	defb 081h,070h,006h,090h,009h,070h,006h,060h,002h,080h,002h,060h,003h,080h,020h,060h	; af54  .p...p.`...`.. `
	defb 004h,070h,044h,0c0h,006h,060h,02eh,040h,002h,054h,004h,075h,002h,054h,000h	; af64  .pD..`.@.T.u.T.

; ----------------------------------------------------------------------
; DATOS dibujos_AF73: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 42, ficha 1 de la lista 0xA214 (p00:4595); lo leen p00:5EB0 (7
;   bytes)
;   0xaf73..0xaf7a  (7 bytes)
DATA_dibujos_AF73:
	defb 00fh,020h,005h,060h,004h,020h,000h	; af73

; ----------------------------------------------------------------------
; DATOS dibujos_AF7A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 1, ficha 0 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (42
;   bytes)
;   0xaf7a..0xafa4  (42 bytes)
DATA_dibujos_AF7A:
	defb 008h,0e0h,008h,0f0h,006h,0e0h,082h,0f0h,0f4h,006h,040h,002h,050h,002h,054h,005h	; af7a  ..........@.P.T.
	defb 040h,082h,050h,040h,004h,050h,083h,054h,040h,040h,003h,0e0h,002h,040h,003h,050h	; af8a  @.P@.P.T@@...@.P
	defb 002h,0f0h,086h,0b0h,0a0h,090h,080h,090h,0a0h,000h	; af9a  ..........

; ----------------------------------------------------------------------
; DATOS dibujos_AFA4: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 17, ficha 1 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (23
;   bytes)
;   0xafa4..0xafbb  (23 bytes)
DATA_dibujos_AFA4:
	defb 010h,0e0h,008h,0f4h,00eh,040h,082h,050h,0e0h,006h,040h,084h,090h,0f0h,050h,040h	; afa4  .....@.P..@...P@
	defb 004h,050h,004h,040h,006h,050h,000h	; afb4

; ----------------------------------------------------------------------
; DATOS dibujos_AFBB: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 33, ficha 2 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (36
;   bytes)
;   0xafbb..0xafdf  (36 bytes)
DATA_dibujos_AFBB:
	defb 010h,0e0h,006h,0f0h,006h,040h,002h,050h,009h,040h,081h,050h,003h,0f4h,003h,0f0h	; afbb  .....@.P.@.P....
	defb 002h,040h,090h,080h,0f0h,0f5h,0f4h,0f0h,0f0h,040h,040h,0e0h,0f0h,020h,070h,020h	; afcb  .@.......@@.. p
	defb 020h,070h,020h,000h	; afdb

; ----------------------------------------------------------------------
; DATOS dibujos_AFDF: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 49, ficha 3 de la lista 0xA143 (p00:4595); lo leen p00:5EE8 (25
;   bytes)
;   0xafdf..0xaff8  (25 bytes)
DATA_dibujos_AFDF:
	defb 081h,040h,007h,0f0h,003h,0e0h,005h,0f0h,010h,0e0h,015h,040h,08bh,020h,070h,070h	; afdf  .@.........@. pp
	defb 020h,070h,020h,020h,070h,020h,020h,070h,000h	; afef   p  p  p.

; ----------------------------------------------------------------------
; DATOS caracteres_AFF8: 0x3D8 bytes de dibujos de caracteres que p00:5E20
;   copia tal cual (LDIRVM) a la VRAM 0x2130 en los tres tercios; lo leen
;   p00:5E2C (984 bytes)
;   0xaff8..0xb3d0  (984 bytes)
DATA_caracteres_AFF8:
	defb 000h,020h,02eh,071h,021h,027h,069h,026h	; aff8  . .q!'i&
	defb 000h,020h,07fh,021h,022h,020h,020h,01fh	; b000  . .!"  .
	defb 000h,07fh,001h,002h,024h,018h,008h,004h	; b008  ....$...
	defb 005h,022h,07fh,022h,022h,002h,004h,018h	; b010  .".""...
	defb 000h,005h,012h,028h,044h,002h,001h,000h	; b018  ...(D...
	defb 000h,07fh,001h,001h,001h,001h,07fh,001h	; b020  ........
	defb 00ah,03dh,022h,052h,00ch,004h,008h,030h	; b028  .="R...0
	defb 000h,03ch,000h,07ch,002h,002h,004h,018h	; b030  .<.|....
	defb 002h,05dh,044h,05eh,044h,04ch,056h,02ch	; b038  .]D^DLV,
	defb 005h,012h,014h,07fh,008h,010h,010h,00ch	; b040  ........
	defb 005h,020h,026h,018h,020h,040h,040h,03eh	; b048  . &. @@>
	defb 000h,041h,02eh,032h,055h,049h,049h,032h	; b050  .A.2UII2
	defb 000h,010h,07eh,008h,07eh,004h,040h,03ch	; b058  ..~.~.@<
	defb 005h,010h,07eh,008h,07eh,004h,040h,03ch	; b060  ..~.~.@<
	defb 002h,009h,07eh,004h,01ch,01ch,004h,018h	; b068  ..~.....
	defb 000h,008h,07eh,004h,01ch,01ch,004h,018h	; b070  ..~.....
	defb 000h,024h,01fh,075h,011h,012h,008h,008h	; b078  .$.u....
	defb 000h,010h,078h,012h,071h,070h,021h,01eh	; b080  ..x.qp!.
	defb 000h,000h,000h,000h,000h,020h,050h,020h	; b088  ..... P
	defb 000h,000h,000h,018h,018h,000h,000h,000h	; b090  ........
	defb 00fh,007h,007h,010h,013h,03bh,03bh,039h	; b098  .......9
	defb 03dh,01dh,01dh,005h,000h,000h,000h,000h	; b0a0  =.......
	defb 0f8h,0f8h,0f0h,004h,0e4h,0eeh,0eeh,0ceh	; b0a8  ........
	defb 0deh,0dch,0dch,0d0h,080h,080h,080h,000h	; b0b0  ........
	defb 000h,07eh,042h,05eh,050h,050h,070h,000h	; b0b8  .~B^PPp.
	defb 000h,000h,007h,005h,005h,03dh,021h,03fh	; b0c0  .....=!?
	defb 000h,008h,07fh,049h,049h,07fh,008h,008h	; b0c8  ...II...
	defb 008h,07fh,049h,03eh,01ch,03eh,014h,063h	; b0d0  ..I>.>.c
	defb 004h,0eeh,0a4h,0ffh,0a2h,0bfh,0eah,006h	; b0d8  ........
	defb 014h,077h,077h,077h,014h,02ah,051h,04eh	; b0e0  .www.*QN
	defb 008h,048h,07fh,048h,03eh,008h,008h,07fh	; b0e8  .H.H>...
	defb 01ch,022h,07fh,000h,077h,055h,077h,004h	; b0f0  ."..wUw.
	defb 000h,049h,049h,07fh,008h,049h,049h,07fh	; b0f8  .II..II.
	defb 008h,07fh,049h,07fh,028h,018h,014h,063h	; b100  ..I.(..c
	defb 020h,077h,071h,07fh,008h,078h,059h,077h	; b108   wq..xYw
	defb 004h,03fh,02eh,024h,03fh,026h,024h,04ch	; b110  .?.$?&$L
	defb 008h,07fh,022h,022h,014h,008h,014h,063h	; b118  ..""...c
	defb 000h,03fh,011h,00ah,004h,00ah,011h,03fh	; b120  .?.....?
	defb 000h,0feh,054h,054h,054h,054h,054h,0feh	; b128  ..TTTTT.
	defb 008h,07fh,041h,03eh,008h,07fh,008h,018h	; b130  ..A>....
	defb 008h,07fh,049h,03eh,02ah,03eh,02ah,03eh	; b138  ..I>*>*>
	defb 000h,07fh,052h,07fh,07bh,05eh,05eh,09eh	; b140  ..R.{^^.
	defb 020h,03eh,048h,03eh,028h,07fh,008h,008h	; b148   >H>(...
	defb 008h,03eh,014h,07fh,049h,03eh,02ah,008h	; b150  .>..I>*.
	defb 000h,07fh,05dh,049h,05dh,04bh,05dh,07fh	; b158  ..]I]K].
	defb 012h,066h,02ah,0f2h,02fh,072h,0a2h,022h	; b160  .f*./r."
	defb 02ah,07fh,041h,03eh,00ch,07fh,008h,018h	; b168  *.A>....
	defb 004h,03fh,020h,03fh,024h,024h,044h,04ch	; b170  .? ?$$DL
	defb 03eh,03ch,03eh,03ch,07fh,022h,02ch,033h	; b178  ><><.",3
	defb 008h,07fh,041h,03eh,03eh,020h,03eh,03eh	; b180  ..A>> >>
	defb 000h,01fh,022h,054h,008h,01fh,069h,00fh	; b188  .."T..i.
	defb 07ah,02dh,036h,063h,01ch,03eh,015h,067h	; b190  z-6c.>.g
	defb 008h,03eh,03eh,03eh,000h,03eh,01ch,07fh	; b198  .>>>.>..
	defb 002h,04ch,010h,0dfh,054h,054h,064h,0dfh	; b1a0  .L..TTd.
	defb 000h,02ah,02ah,07fh,02ah,02eh,020h,03fh	; b1a8  .**.*. ?
	defb 000h,07fh,014h,035h,05eh,034h,025h,043h	; b1b0  ...5^4%C
	defb 008h,028h,03eh,048h,07fh,008h,014h,063h	; b1b8  .(>H...c
	defb 074h,057h,079h,055h,075h,072h,026h,059h	; b1c0  tWyUur&Y
	defb 004h,07fh,034h,032h,07dh,000h,055h,04eh	; b1c8  ..42}.UN
	defb 03eh,03eh,03eh,028h,03eh,07eh,008h,07fh	; b1d0  >>>(>~..
	defb 008h,05eh,01eh,0d0h,05eh,05eh,060h,0dfh	; b1d8  .^..^^`.
	defb 024h,077h,029h,035h,055h,012h,036h,069h	; b1e0  $w)5U.6i
	defb 002h,025h,024h,05fh,0a4h,024h,025h,023h	; b1e8  .%$_.$%#
	defb 000h,008h,03eh,008h,07fh,008h,012h,03dh	; b1f0  ..>....=
	defb 000h,02eh,040h,01fh,022h,062h,022h,026h	; b1f8  ..@."b"&
	defb 008h,008h,07fh,010h,01eh,012h,02ah,044h	; b200  ......*D
	defb 000h,07fh,008h,018h,02ch,04bh,008h,008h	; b208  ....,K..
	defb 000h,077h,055h,077h,055h,077h,005h,009h	; b210  .wUwUw..
	defb 00ah,07fh,059h,07fh,056h,076h,05ah,05bh	; b218  ..Y.VvZ[
	defb 000h,04ah,01bh,0cah,05bh,04ah,071h,0dfh	; b220  .J..[Jq.
	defb 000h,008h,008h,07fh,020h,020h,020h,01eh	; b228  ....   .
	defb 008h,07fh,03eh,03eh,03eh,000h,07fh,022h	; b230  ..>>>.."
	defb 000h,02fh,069h,02bh,022h,022h,022h,022h	; b238  ./i+""""
	defb 000h,026h,069h,029h,029h,029h,029h,026h	; b240  .&i))))&
	defb 002h,072h,05fh,066h,055h,065h,049h,042h	; b248  .r_fUeIB
	defb 008h,02ah,04dh,018h,03eh,05eh,012h,01eh	; b250  .*M.>^..
	defb 000h,008h,04fh,015h,004h,02ch,04ah,011h	; b258  ..O..,J.
	defb 040h,0efh,045h,0f5h,04fh,069h,0cfh,0bfh	; b260  @.E.Oi..
	defb 000h,021h,03eh,044h,0dfh,044h,044h,05fh	; b268  .!>D.DD_
	defb 008h,07fh,055h,024h,043h,03eh,008h,07fh	; b270  ..U$C>..
	defb 000h,077h,077h,041h,07fh,055h,07fh,055h	; b278  .wwA.U.U
	defb 044h,06eh,074h,0afh,022h,06fh,0aah,026h	; b280  Dnt."o.&
	defb 070h,055h,075h,045h,075h,055h,091h,033h	; b288  pUuEuU.3
	defb 000h,008h,008h,07fh,008h,008h,014h,063h	; b290  .......c
	defb 000h,024h,03fh,044h,0cfh,04ah,052h,06fh	; b298  .$?D.JRo
	defb 008h,014h,063h,03eh,008h,03eh,008h,03eh	; b2a0  ..c>.>.>
	defb 005h,084h,03fh,0a4h,03dh,052h,05ah,0a5h	; b2a8  ..?.=RZ.
	defb 000h,07fh,02ah,02ah,07fh,008h,008h,008h	; b2b0  ..**....
	defb 010h,070h,02fh,0f9h,029h,079h,0a9h,02fh	; b2b8  .p/.)y./
	defb 000h,07fh,049h,03eh,03eh,008h,07fh,008h	; b2c0  ..I>>...
	defb 000h,07eh,010h,07eh,07eh,05ah,0ffh,042h	; b2c8  .~.~~Z.B
	defb 008h,07fh,041h,03eh,000h,07fh,014h,067h	; b2d0  ..A>...g
	defb 000h,07fh,002h,00ch,008h,008h,008h,018h	; b2d8  ........
	defb 008h,02fh,057h,027h,067h,029h,026h,02dh	; b2e0  ./W'g)&-
	defb 000h,02fh,029h,029h,02fh,029h,029h,02fh	; b2e8  ./))/))/
	defb 077h,06dh,076h,009h,034h,01ah,03eh,02ah	; b2f0  wmv.4.>*
	defb 03eh,044h,03eh,01eh,03eh,009h,055h,04eh	; b2f8  >D>.>.UN
	defb 010h,064h,07fh,075h,075h,075h,029h,072h	; b300  .d.uuu)r
	defb 044h,05fh,0e4h,05fh,05fh,05fh,04ah,046h	; b308  D_.___JF
	defb 000h,008h,008h,07fh,008h,008h,008h,03eh	; b310  .......>
	defb 044h,00eh,0dfh,04eh,055h,04eh,055h,0bfh	; b318  D..NUNU.
	defb 045h,0eeh,044h,07fh,0d5h,05fh,05dh,055h	; b320  E.D.._]U
	defb 008h,07fh,022h,01ch,063h,03eh,03eh,042h	; b328  ..".c>>B
	defb 05eh,004h,0deh,05eh,05eh,05eh,052h,0bfh	; b330  ^..^^^R.
	defb 024h,03fh,04eh,0aeh,020h,02eh,02ah,02eh	; b338  $?N. .*.
	defb 008h,03eh,008h,03eh,01eh,07fh,03eh,008h	; b340  .>.>..>.
	defb 014h,05eh,054h,084h,07fh,044h,044h,044h	; b348  .^T..DDD
	defb 020h,03fh,062h,0dah,05ah,05ah,042h,046h	; b350   ?b.ZZBF
	defb 008h,03eh,00ah,07fh,010h,03eh,05ah,01eh	; b358  .>...>Z.
	defb 000h,000h,000h,07fh,000h,000h,000h,000h	; b360  ........
	defb 000h,077h,055h,077h,055h,077h,005h,009h	; b368  .wUwUw..
	defb 029h,0b5h,065h,0f5h,025h,0f1h,023h,021h	; b370  ).e.%.#!
	defb 01bh,049h,01bh,0dbh,04eh,05fh,06ah,0dfh	; b378  .I..N_j.
	defb 006h,058h,0f5h,04ah,064h,0dfh,04eh,055h	; b380  .X.Jd.NU
	defb 001h,01eh,044h,01fh,044h,01fh,031h,05fh	; b388  ..D.D.1_
	defb 002h,01ch,004h,07fh,004h,03fh,004h,018h	; b390  .....?..
	defb 008h,09eh,04ah,0bfh,04ch,014h,052h,0a1h	; b398  ..J.L.R.
	defb 000h,04eh,02ah,06eh,0aah,06eh,0aah,05fh	; b3a0  .N*n.n._
	defb 000h,03eh,000h,07fh,014h,014h,025h,047h	; b3a8  .>....%G
	defb 000h,07fh,008h,00ch,00ah,008h,008h,008h	; b3b0  ........
	defb 000h,026h,069h,029h,026h,029h,029h,026h	; b3b8  .&i)&))&
	defb 004h,05fh,004h,0dfh,05fh,04eh,055h,0bfh	; b3c0  ._.._NU.
	defb 004h,05fh,0eah,05fh,07fh,0cah,046h,059h	; b3c8  ._._..FY

; ----------------------------------------------------------------------
; DATOS caracteres_B3D0: lista de caracteres (p00:4595): fichas de 6 bytes
;   [tercios][colores][caracter][dibujos], 0 acaba; lo leen p00:5DA7 (25
;   bytes)
;   0xb3d0..0xb3e9  (25 bytes)
DATA_caracteres_B3D0:
	defb 004h,010h,0b4h,009h,04fh,0b6h	; b3d0
	defb 002h,0a7h,0b4h,02dh,05eh,0b6h	; b3d6
	defb 002h,062h,0b5h,070h,0c2h,0b6h	; b3dc
	defb 002h,011h,0b5h,050h,08ah,0b6h	; b3e2
	defb 000h	; b3e8

; ----------------------------------------------------------------------
; DATOS ceros_B3E9: 1 cero entre bloques: rachas vacias (un 0 acaba), sin
;   lector a la vista; lo leen nadie (1 bytes)
;   0xb3e9..0xb3ea  (1 bytes)
DATA_ceros_B3E9:
	defb 000h	; b3e9

; ----------------------------------------------------------------------
; DATOS copias_B3EA: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:5DB2
;   (17 bytes)
;   0xb3ea..0xb3fb  (17 bytes)
DATA_copias_B3EA:
	defb 00ch,01fh,024h,013h,02dh,03dh,012h,010h,050h,05ah,012h,00ah,072h,08dh,012h,01bh	; b3ea  ..$.-=..PZ..r...
	defb 000h	; b3fa

; ----------------------------------------------------------------------
; DATOS copias_B3FB: lista de copias de caracteres VRAM -> VRAM (p00:454E: 4
;   bytes, 3 si el tercero lleva los bits altos; 0 acaba); lo leen p00:5DBE
;   (21 bytes)
;   0xb3fb..0xb410  (21 bytes)
DATA_copias_B3FB:
	defb 020h,032h,024h,001h,00bh,033h,024h,001h,00dh,034h,024h,001h,041h,04dh,012h,001h	; b3fb   2$..3$..4$.AM..
	defb 031h,04eh,012h,001h,000h	; b40b

; ----------------------------------------------------------------------
; DATOS colores_B410: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 9, ficha 0 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (151
;   bytes)
;   0xb410..0xb4a7  (151 bytes)
DATA_colores_B410:
	defb 004h,000h,084h,0ffh,000h,000h,0ffh,005h,000h,084h,0ffh,000h,000h,0ffh,007h,000h	; b410  ................
	defb 08ch,001h,002h,004h,008h,010h,020h,040h,080h,0c0h,030h,00ch,003h,009h,000h,088h	; b420  ...... @..0.....
	defb 0ffh,006h,001h,0c0h,020h,018h,004h,003h,008h,000h,086h,080h,060h,010h,00ch,002h	; b430  .... .......`...
	defb 001h,004h,000h,089h,0ffh,000h,000h,080h,040h,030h,008h,006h,0ffh,003h,000h,091h	; b440  ........@0......
	defb 001h,000h,003h,000h,000h,041h,089h,091h,012h,022h,002h,004h,004h,005h,00ah,00ch	; b450  .....A..."......
	defb 008h,003h,010h,094h,020h,001h,003h,005h,00ah,012h,022h,044h,084h,0c0h,030h,00ch	; b460  .... ....."D..0.
	defb 023h,048h,050h,090h,080h,00ch,002h,001h,007h,000h,088h,080h,040h,030h,008h,006h	; b470  #HP.........@0..
	defb 001h,020h,020h,003h,040h,003h,080h,081h,004h,003h,008h,003h,010h,089h,020h,0c0h	; b480  .  .@......... .
	defb 030h,00ch,003h,008h,00ah,002h,002h,004h,000h,08ch,0ffh,042h,081h,080h,0c0h,020h	; b490  0..........B...
	defb 018h,004h,0ffh,000h,000h,0ffh,000h	; b4a0

; ----------------------------------------------------------------------
; DATOS colores_B4A7: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 45, ficha 1 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (106
;   bytes)
;   0xb4a7..0xb511  (106 bytes)
DATA_colores_B4A7:
	defb 08ah,0ffh,081h,0ffh,0ffh,0feh,098h,098h,0ffh,0ffh,081h,003h,0ffh,002h,098h,08dh	; b4a7  ................
	defb 0ffh,0feh,082h,0feh,0ffh,0fch,08ch,08ch,0fch,005h,00ah,00ch,008h,003h,010h,003h	; b4b7  ................
	defb 020h,003h,040h,003h,080h,081h,004h,003h,008h,003h,010h,085h,020h,000h,000h,0f0h	; b4c7   .@......... ...
	defb 00fh,008h,000h,084h,0f0h,00fh,000h,00ch,004h,000h,083h,0f0h,00fh,0c0h,007h,000h	; b4d7  ................
	defb 084h,0f0h,00fh,000h,003h,00bh,000h,083h,00ch,01eh,00ch,005h,000h,088h,00ch,01eh	; b4e7  ................
	defb 00ch,0c0h,030h,00ch,003h,040h,003h,000h,090h,001h,002h,004h,008h,010h,020h,040h	; b4f7  ..0..@........ @
	defb 080h,001h,003h,005h,00ah,012h,022h,044h,084h,000h	; b507  ......"D..

; ----------------------------------------------------------------------
; DATOS colores_B511: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 80, ficha 3 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (81
;   bytes)
;   0xb511..0xb562  (81 bytes)
DATA_colores_B511:
	defb 098h,000h,004h,010h,027h,01eh,07fh,0b1h,076h,0a2h,02ah,0ffh,05bh,03fh,0dfh,0ffh	; b511  ....'...v.*.[?..
	defb 017h,000h,090h,064h,078h,0e4h,07bh,0feh,0f7h,004h,000h,09bh,080h,000h,0a0h,0c0h	; b521  ...dx.{.........
	defb 0feh,03fh,00fh,007h,003h,001h,001h,000h,080h,0a8h,0d0h,0e0h,0e4h,0b0h,0f4h,0d2h	; b531  .?..............
	defb 0f4h,0fah,07ch,07dh,03ah,06ch,014h,003h,000h,086h,0c0h,070h,07fh,03fh,097h,025h	; b541  ..|}:l.....p.?.%
	defb 003h,000h,08dh,001h,0fah,0ffh,0bdh,0f7h,015h,03eh,07bh,0feh,0b6h,0fch,0e0h,088h	; b551  .........>{.....
	defb 000h	; b561

; ----------------------------------------------------------------------
; DATOS colores_B562: rachas (p00:4A8C) con los colores de los caracteres
;   desde el 112, ficha 2 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (226
;   bytes)
;   0xb562..0xb644  (226 bytes)
DATA_colores_B562:
	defb 088h,000h,018h,03ch,03ch,024h,018h,0ffh,081h,004h,000h,095h,0c3h,0e7h,0dbh,042h	; b562  ...<<$.........B
	defb 0ffh,081h,0ffh,000h,00dh,007h,000h,003h,0ffh,081h,0ffh,000h,06dh,0c7h,000h,083h	; b572  ............m...
	defb 0ffh,006h,000h,091h,080h,000h,008h,00ch,006h,006h,003h,001h,001h,0c0h,0c0h,060h	; b582  ...............`
	defb 030h,030h,018h,01ch,00ch,003h,000h,002h,001h,09bh,003h,006h,00ch,000h,040h,07fh	; b592  00............@.
	defb 0bfh,041h,030h,00fh,07fh,00eh,006h,0e6h,0b2h,00ch,0f1h,0f9h,0fch,03fh,040h,0a0h	; b5a2  .A0..........?@.
	defb 090h,088h,084h,003h,0c7h,003h,000h,002h,001h,0a7h,002h,03ah,0f8h,003h,00fh,03fh	; b5b2  ...........:...?
	defb 0feh,0fdh,003h,00fh,0c0h,078h,0b7h,088h,0e3h,09fh,07ch,0f1h,0c7h,0fdh,05dh,0fch	; b5c2  .....x....|...].
	defb 0bdh,0fch,0beh,0ddh,0edh,03dh,022h,04dh,07ch,0c7h,040h,03fh,005h,070h,01eh,007h	; b5d2  .....="M|.@?.p..
	defb 001h,006h,000h,085h,0e0h,0feh,03fh,007h,001h,003h,000h,092h,001h,03fh,0e0h,080h	; b5e2  ......?......?..
	defb 0e0h,0ffh,003h,03fh,0c0h,0c0h,0feh,000h,024h,03ch,0f8h,0fch,0fch,0feh,004h,000h	; b5f2  ...?....$<......
	defb 0b1h,0fch,0fbh,07ch,00fh,001h,001h,000h,000h,007h,0e0h,080h,0ffh,000h,07eh,081h	; b602  ...|..........~.
	defb 000h,0e2h,011h,018h,0f0h,080h,080h,03eh,00fh,03bh,07dh,084h,0bdh,0a8h,05bh,002h	; b612  .......>..}...[.
	defb 0a8h,0ffh,081h,0ffh,020h,033h,030h,045h,030h,0ffh,081h,0ffh,004h,0cch,00ch,0aah	; b622  .... 30E0.......
	defb 00ch,010h,003h,000h,08ch,004h,007h,00fh,008h,000h,017h,02fh,02fh,00fh,0ech,0edh	; b632  ...........//...
	defb 001h,000h	; b642

; ----------------------------------------------------------------------
; DATOS rachas_B644: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (11 bytes)
;   0xb644..0xb64f  (11 bytes)
DATA_rachas_B644:
	defb 009h,0ffh,087h,0e7h,0ffh,0e7h,0e7h,0ffh,0e7h,0c3h,000h	; b644  ...........

; ----------------------------------------------------------------------
; DATOS dibujos_B64F: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 9, ficha 0 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (15
;   bytes)
;   0xb64f..0xb65e  (15 bytes)
DATA_dibujos_B64F:
	defb 054h,040h,004h,020h,01fh,040h,081h,020h,027h,040h,004h,020h,00dh,040h,000h	; b64f  T@. .@. '@. .@.

; ----------------------------------------------------------------------
; DATOS dibujos_B65E: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 45, ficha 1 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (44
;   bytes)
;   0xb65e..0xb68a  (44 bytes)
DATA_dibujos_B65E:
	defb 098h,070h,040h,050h,000h,040h,040h,050h,055h,077h,040h,055h,000h,044h,040h,050h	; b65e  .p@P.@@PUw@U.D@P
	defb 055h,070h,040h,050h,000h,040h,040h,050h,050h,026h,040h,004h,020h,004h,040h,004h	; b66e  Up@P.@@PP&@. .@.
	defb 020h,006h,040h,008h,020h,008h,060h,008h,0a0h,018h,040h,000h	; b67e   .@. .`...@.

; ----------------------------------------------------------------------
; DATOS dibujos_B68A: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 80, ficha 3 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (56
;   bytes)
;   0xb68a..0xb6c2  (56 bytes)
DATA_dibujos_B68A:
	defb 004h,060h,002h,080h,082h,098h,080h,004h,060h,084h,086h,080h,088h,080h,005h,060h	; b68a  .`......`......`
	defb 007h,080h,081h,060h,008h,080h,003h,090h,007h,080h,086h,090h,080h,080h,090h,080h	; b69a  ...`............
	defb 090h,005h,080h,002h,090h,003h,080h,081h,060h,004h,090h,087h,098h,088h,080h,060h	; b6aa  ........`......`
	defb 090h,080h,090h,003h,080h,002h,060h,000h	; b6ba  ......`.

; ----------------------------------------------------------------------
; DATOS dibujos_B6C2: rachas (p00:4A8C) con los dibujos de los caracteres
;   desde el 112, ficha 2 de la lista 0xB3D0 (p00:4595); lo leen p00:5DA7 (208
;   bytes)
;   0xb6c2..0xb792  (208 bytes)
DATA_dibujos_B6C2:
	defb 003h,090h,003h,080h,082h,060h,0a0h,005h,0f0h,088h,075h,040h,030h,070h,040h,050h	; b6c2  .....`....u@0p@P
	defb 050h,040h,003h,050h,085h,070h,040h,050h,040h,040h,003h,050h,081h,005h,008h,0f0h	; b6d2  P@.P.p@P@@.P....
	defb 08fh,080h,0f0h,0f0h,0e0h,0f0h,070h,0f0h,070h,0e0h,070h,0e0h,070h,0e0h,070h,0f0h	; b6e2  ......p.p.p.p.p.
	defb 004h,050h,003h,070h,08ah,040h,000h,0a0h,050h,070h,085h,040h,070h,0f0h,070h,003h	; b6f2  .P.p.@..Pp.@p.p.
	defb 050h,08ch,040h,0f0h,0f0h,070h,0f0h,070h,0f0h,070h,0f0h,070h,0f0h,070h,004h,080h	; b702  P.@..p.p.p.p.p..
	defb 084h,0f0h,050h,050h,0f0h,003h,070h,08ah,075h,076h,0f5h,070h,050h,0f5h,075h,095h	; b712  ..PP..p.uv.pP.u.
	defb 070h,0f0h,003h,0f7h,090h,050h,070h,070h,050h,070h,070h,075h,075h,0f0h,097h,0f0h	; b722  p....PppPppuu...
	defb 070h,0c7h,0ech,040h,040h,003h,0f0h,004h,050h,004h,0f0h,082h,070h,0f0h,004h,050h	; b732  p..@@...P...p..P
	defb 003h,0f0h,088h,0f7h,075h,050h,000h,0f0h,0f0h,0f7h,075h,003h,040h,084h,050h,0f0h	; b742  ....uP....u.@.P.
	defb 070h,050h,005h,040h,08bh,050h,042h,042h,040h,080h,070h,0a0h,0a0h,0f0h,050h,064h	; b752  pP.@.PBB@.p...Pd
	defb 003h,040h,088h,0a7h,000h,0c7h,085h,040h,040h,080h,074h,003h,040h,005h,050h,087h	; b762  .@.....@@.t.@.P.
	defb 0a0h,040h,077h,040h,050h,040h,040h,003h,050h,085h,070h,040h,050h,040h,040h,003h	; b772  .@w@P@@.P.p@P@@.
	defb 050h,004h,080h,084h,030h,080h,060h,0a0h,003h,090h,003h,080h,082h,060h,070h,000h	; b782  P...0.`......`p.

; ----------------------------------------------------------------------
; DATOS rachas_B792: 1 tira de rachas (el formato de p00:4A8C) que acaba justo
;   antes de lo siguiente: sin lector a la vista; lo leen nadie (13 bytes)
;   0xb792..0xb79f  (13 bytes)
DATA_rachas_B792:
	defb 081h,000h,005h,040h,083h,000h,050h,000h,006h,040h,081h,050h,000h	; b792  ...@..P..@.P.

; ----------------------------------------------------------------------
; DATOS rachas_d_B79F: [destino en la VRAM] y rachas (p00:4A86 -> p00:4A8C);
;   lo leen p01:6243 (354 bytes)
;   0xb79f..0xb901  (354 bytes)
DATA_rachas_d_B79F:
	defb 000h,02ah,018h,000h,002h,007h,003h,00fh,002h,01fh,081h,03fh,008h,0ffh,002h,0f8h	; b79f  .*.........?....
	defb 003h,0f0h,003h,0e0h,07fh,000h,00dh,000h,087h,001h,003h,00fh,07fh,03fh,07fh,07fh	; b7af  .............?..
	defb 00ah,0ffh,082h,0fch,0f0h,003h,0c0h,002h,080h,07fh,000h,083h,001h,003h,007h,003h	; b7bf  ................
	defb 00fh,081h,03fh,009h,0ffh,087h,0feh,0fch,0f8h,0f8h,0f0h,0f8h,0c0h,00bh,000h,002h	; b7cf  ..?.............
	defb 001h,083h,003h,07fh,07fh,00bh,0ffh,002h,0feh,083h,0fch,080h,080h,006h,000h,002h	; b7df  ................
	defb 03ch,002h,078h,092h,079h,0f3h,0f7h,0ffh,01fh,03eh,07ch,0f9h,0f3h,0e3h,0c3h,087h	; b7ef  <.x.y....>|.....
	defb 01fh,07fh,0f8h,0f0h,0e0h,0e0h,003h,0c0h,084h,0f0h,0f8h,078h,078h,003h,079h,002h	; b7ff  ...........xx.y.
	defb 07fh,083h,0ffh,0f7h,0f7h,003h,0e7h,002h,00fh,003h,01eh,003h,03ch,088h,003h,007h	; b80f  ............<...
	defb 00fh,00eh,01eh,03ch,038h,078h,005h,0e0h,003h,0e1h,002h,07eh,083h,0feh,0f6h,0f6h	; b81f  ...<8x.....~....
	defb 003h,0eeh,002h,00fh,088h,01fh,01dh,03dh,03bh,07bh,073h,0f1h,0f1h,003h,0e3h,003h	; b82f  .......=.{s.....
	defb 0c7h,002h,0e0h,003h,0c0h,003h,080h,008h,000h,003h,01fh,003h,03fh,002h,07fh,008h	; b83f  ............?...
	defb 0ffh,083h,0f0h,0e0h,0e0h,003h,0c0h,002h,080h,007h,000h,087h,007h,003h,007h,007h	; b84f  ................
	defb 00fh,01fh,03fh,009h,0ffh,089h,0f8h,0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h,003h	; b85f  ..?.............
	defb 001h,003h,003h,002h,007h,088h,0efh,0e7h,0e7h,0c7h,0c7h,0c3h,083h,083h,003h,087h	; b86f  ................
	defb 003h,0c7h,092h,0e3h,0e0h,080h,080h,081h,081h,083h,0c7h,0ffh,0feh,0fbh,0f3h,0f3h	; b87f  ................
	defb 0f7h,0e7h,0c7h,08fh,00fh,003h,0c7h,003h,087h,002h,007h,002h,078h,088h,079h,0f1h	; b88f  ............x.y.
	defb 0f3h,0f7h,0e7h,0efh,070h,0f0h,003h,0ffh,002h,081h,081h,001h,003h,0e3h,003h,0e7h	; b89f  ....p...........
	defb 002h,0efh,002h,0ceh,081h,0cfh,003h,08fh,002h,00fh,088h,0f7h,0e7h,0c7h,0cfh,08fh	; b8af  ................
	defb 08fh,01eh,01eh,003h,08fh,003h,01eh,002h,03ch,090h,007h,008h,017h,014h,017h,014h	; b8bf  ........<.......
	defb 008h,007h,080h,040h,020h,0a0h,020h,0a0h,040h,080h,011h,000h,085h,003h,00fh,01fh	; b8cf  ...@ . .@.......
	defb 03fh,07fh,00bh,0ffh,086h,0fch,0f0h,0e0h,0c0h,080h,080h,07fh,000h,00ah,000h,003h	; b8df  ?...............
	defb 001h,003h,003h,002h,007h,009h,0ffh,002h,0feh,003h,0fch,002h,0f8h,07fh,000h,009h	; b8ef  ................
	defb 000h,000h	; b8ff

; ----------------------------------------------------------------------
; DATOS animados_por_fase: 9 punteros, uno por fase de la 0 a la 8 (0 =
;   ninguno), que p01:6A4A lee con L_4B60; lo leen p01:6A50 (18 bytes)
;   0xb901..0xb913  (18 bytes)
DATA_animados_por_fase:
	defw 0b93ch,00000h,0ba60h,00000h,0b913h,00000h,0b979h,00000h,0b93ch	; b901

; ----------------------------------------------------------------------
; DATOS animados_B913: caracteres animados de la fase 4: [cuantos (bit 7: cada
;   2 cuadros)] y fichas de 10 bytes [caracter][tercios][8 de dibujo] que
;   p01:6A57 pasa por turno (0xE3BB) a la VRAM; lo leen p01:6A8D (41 bytes)
;   0xb913..0xb93c  (41 bytes)
DATA_animados_B913:
	defb 004h,0b7h,007h,000h,000h,000h,008h,000h,000h,000h	; b913  ..........
	defb 000h,0b8h,007h,000h,000h,000h,008h,000h,000h,000h	; b91d  ..........
	defb 000h,0b7h,007h,000h,000h,008h,01ch,008h,000h,000h	; b927  ..........
	defb 000h,0b8h,007h,000h,000h,008h,01ch,008h,000h,000h	; b931  ..........
	defb 000h	; b93b

; ----------------------------------------------------------------------
; DATOS animados_B93C: caracteres animados de las fases 0, 8: [cuantos (bit 7:
;   cada 2 cuadros)] y fichas de 10 bytes [caracter][tercios][8 de dibujo] que
;   p01:6A57 pasa por turno (0xE3BB) a la VRAM; lo leen p01:6A8D (61 bytes)
;   0xb93c..0xb979  (61 bytes)
DATA_animados_B93C:
	defb 006h,001h,003h,081h,000h,000h,000h,000h,000h,000h	; b93c  ..........
	defb 081h,001h,003h,000h,042h,000h,000h,000h,000h,042h	; b946  ....B....B
	defb 000h,001h,003h,000h,000h,024h,000h,000h,024h,000h	; b950  .....$..$.
	defb 000h,001h,003h,000h,000h,000h,018h,018h,000h,000h	; b95a  ..........
	defb 000h,001h,003h,000h,000h,024h,000h,000h,024h,000h	; b964  .....$..$.
	defb 000h,001h,003h,000h,042h,000h,000h,000h,000h,042h	; b96e  ....B....B
	defb 000h	; b978

; ----------------------------------------------------------------------
; DATOS animados_B979: caracteres animados de la fase 6: [cuantos (bit 7: cada
;   2 cuadros)] y fichas de 10 bytes [caracter][tercios][8 de dibujo] que
;   p01:6A57 pasa por turno (0xE3BB) a la VRAM; lo leen p01:6A8D (231 bytes)
;   0xb979..0xba60  (231 bytes)
DATA_animados_B979:
	defb 017h,0c0h,006h,006h,004h,010h,060h,0c0h,0c8h,0d0h	; b979  ......`...
	defb 0f2h,0c1h,006h,008h,030h,0a0h,062h,076h,03ch,0f8h	; b983  ....0.bv<.
	defb 078h,0c2h,006h,00ah,037h,06ch,039h,09eh,05ch,038h	; b98d  x...7l9.\8
	defb 038h,0c0h,001h,0f2h,0d0h,0c8h,0c0h,060h,010h,004h	; b997  8......`..
	defb 006h,0c1h,001h,078h,0f8h,03ch,076h,062h,0a0h,030h	; b9a1  ...x.<vb.0
	defb 008h,0c2h,001h,038h,038h,05ch,09eh,039h,06ch,037h	; b9ab  ...88\.9l7
	defb 00ah,0c0h,006h,006h,004h,010h,030h,060h,060h,0c8h	; b9b5  ......0``.
	defb 0f2h,0c1h,006h,020h,040h,0c0h,0e0h,073h,03eh,0fch	; b9bf  ... @..s>.
	defb 078h,0c2h,006h,006h,06ch,0c8h,06ah,03ch,09ch,078h	; b9c9  x...l.j<.x
	defb 038h,0c0h,001h,0f2h,0c8h,060h,060h,030h,010h,004h	; b9d3  8....``0..
	defb 006h,0c1h,001h,078h,0fch,03eh,073h,0e0h,0c0h,040h	; b9dd  ...x.>s..@
	defb 020h,0c2h,001h,038h,078h,09ch,03ch,06ah,0c8h,06ch	; b9e7   ..8x.<j.l
	defb 006h,0c0h,006h,006h,004h,008h,010h,030h,062h,0cch	; b9f1  .......0b.
	defb 0f8h,0c1h,006h,020h,040h,084h,0c2h,0e2h,076h,0feh	; b9fb  ... @...v.
	defb 07ch,0c2h,006h,00ch,018h,090h,0dah,07ch,038h,07ch	; ba05  |......|8|
	defb 01ch,0c0h,001h,0f8h,0cch,062h,030h,010h,080h,040h	; ba0f  .....b0..@
	defb 060h,0c1h,001h,07ch,0feh,076h,0e2h,0c2h,084h,040h	; ba19  `..|.v...@
	defb 020h,0c2h,001h,01ch,07ch,038h,07ch,0dah,090h,018h	; ba23   ...|8|...
	defb 00ch,0c1h,006h,000h,060h,0c0h,068h,064h,076h,03eh	; ba2d  ....`.hdv>
	defb 07ch,0c2h,006h,050h,0e8h,030h,0b0h,079h,03ah,01ch	; ba37  |..P.0.y:.
	defb 01ch,0c0h,001h,0f2h,0c8h,060h,060h,030h,010h,004h	; ba41  .....``0..
	defb 006h,0c1h,001h,07ch,03eh,076h,064h,068h,0c0h,060h	; ba4b  ...|>vdh.`
	defb 000h,0c2h,001h,01ch,01ch,03ah,079h,0b0h,030h,0e8h	; ba55  .....:y.0.
	defb 050h	; ba5f

; ----------------------------------------------------------------------
; DATOS animados_BA60: caracteres animados de la fase 2: [cuantos (bit 7: cada
;   2 cuadros)] y fichas de 10 bytes [caracter][tercios][8 de dibujo] que
;   p01:6A57 pasa por turno (0xE3BB) a la VRAM; lo leen p01:6A8D (161 bytes)
;   0xba60..0xbb01  (161 bytes)
DATA_animados_BA60:
	defb 010h,0afh,007h,060h,0b0h,0f6h,06bh,00fh,066h,069h	; ba60  ...`..k.fi
	defb 006h,0afh,007h,008h,034h,05ah,07ah,0b2h,044h,03bh	; ba6a  ....4Zz.D.
	defb 003h,0afh,007h,03ch,042h,099h,0adh,0bdh,099h,042h	; ba74  ...<B....B
	defb 03ch,0afh,007h,006h,06dh,06fh,006h,058h,0b4h,0bch	; ba7e  <...mo.X..
	defb 058h,0b0h,007h,060h,0b0h,0f6h,06bh,00fh,066h,069h	; ba88  X..`..k.fi
	defb 006h,0b0h,007h,008h,034h,05ah,07ah,0b2h,044h,03bh	; ba92  ....4Zz.D.
	defb 003h,0b0h,007h,03ch,042h,099h,0adh,0bdh,099h,042h	; ba9c  ...<B....B
	defb 03ch,0b0h,007h,006h,06dh,06fh,006h,058h,0b4h,0bch	; baa6  <...mo.X..
	defb 058h,0b1h,007h,060h,0b0h,0f6h,06bh,00fh,066h,069h	; bab0  X..`..k.fi
	defb 006h,0b1h,007h,008h,034h,05ah,07ah,0b2h,044h,03bh	; baba  ....4Zz.D.
	defb 003h,0b1h,007h,03ch,042h,099h,0adh,0bdh,099h,042h	; bac4  ...<B....B
	defb 03ch,0b1h,007h,006h,06dh,06fh,006h,058h,0b4h,0bch	; bace  <...mo.X..
	defb 058h,0b2h,007h,060h,0b0h,0f6h,06bh,00fh,066h,069h	; bad8  X..`..k.fi
	defb 006h,0b2h,007h,008h,034h,05ah,07ah,0b2h,044h,03bh	; bae2  ....4Zz.D.
	defb 003h,0b2h,007h,03ch,042h,099h,0adh,0bdh,099h,042h	; baec  ...<B....B
	defb 03ch,0b2h,007h,006h,06dh,06fh,006h,058h,0b4h,0bch	; baf6  <...mo.X..
	defb 058h	; bb00

; ----------------------------------------------------------------------
; DATOS fichas_BB01: 32 punteros que p01:6816 lee con A (L_4B60); lo leen
;   p01:681A (64 bytes)
;   0xbb01..0xbb41  (64 bytes)
DATA_fichas_BB01:
	defw 0bb41h,0bb4bh,0bb55h,0bb5fh,0bb69h,0bb73h,0bb7dh,0bb87h	; bb01
	defw 0bb91h,0bb9bh,0bba3h,0bbabh,0bbb3h,0bbbbh,0bbc3h,0bbcbh	; bb11
	defw 0bbd3h,0bc4dh,0bcf7h,0bdf9h,0bebbh,0bec3h,0becbh,0bf25h	; bb21
	defw 0bf2dh,0bf35h,0bf3dh,0bf45h,0bf4dh,0bf55h,0bf5dh,0bf65h	; bb31

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB41: lo que p01:681E lee de las entradas 0 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb41..0xbb4b  (10 bytes)
DATA_fichas_BB01_BB41:
	defb 002h,004h,070h,070h,070h,070h,087h,087h,087h,087h	; bb41  ..pppp....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB4B: lo que p01:681E lee de las entradas 1 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb4b..0xbb55  (10 bytes)
DATA_fichas_BB01_BB4B:
	defb 002h,004h,070h,070h,070h,071h,087h,087h,087h,088h	; bb4b  ..pppq....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB55: lo que p01:681E lee de las entradas 2 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb55..0xbb5f  (10 bytes)
DATA_fichas_BB01_BB55:
	defb 002h,004h,070h,070h,070h,072h,087h,087h,087h,089h	; bb55  ..pppr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB5F: lo que p01:681E lee de las entradas 3 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb5f..0xbb69  (10 bytes)
DATA_fichas_BB01_BB5F:
	defb 002h,004h,070h,070h,071h,072h,087h,087h,088h,089h	; bb5f  ..ppqr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB69: lo que p01:681E lee de las entradas 4 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb69..0xbb73  (10 bytes)
DATA_fichas_BB01_BB69:
	defb 002h,004h,070h,070h,072h,072h,087h,087h,089h,089h	; bb69  ..pprr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB73: lo que p01:681E lee de las entradas 5 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb73..0xbb7d  (10 bytes)
DATA_fichas_BB01_BB73:
	defb 002h,004h,070h,071h,072h,072h,087h,088h,089h,089h	; bb73  ..pqrr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB7D: lo que p01:681E lee de las entradas 6 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb7d..0xbb87  (10 bytes)
DATA_fichas_BB01_BB7D:
	defb 002h,004h,070h,072h,072h,072h,087h,089h,089h,089h	; bb7d  ..prrr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB87: lo que p01:681E lee de las entradas 7 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb87..0xbb91  (10 bytes)
DATA_fichas_BB01_BB87:
	defb 002h,004h,071h,072h,072h,072h,088h,089h,089h,089h	; bb87  ..qrrr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB91: lo que p01:681E lee de las entradas 8 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (10 bytes)
;   0xbb91..0xbb9b  (10 bytes)
DATA_fichas_BB01_BB91:
	defb 002h,004h,072h,072h,072h,072h,089h,089h,089h,089h	; bb91  ..rrrr....

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BB9B: lo que p01:681E lee de las entradas 9 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbb9b..0xbba3  (8 bytes)
DATA_fichas_BB01_BB9B:
	defb 002h,003h,070h,070h,070h,087h,087h,087h	; bb9b  ..ppp...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBA3: lo que p01:681E lee de las entradas 10 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbba3..0xbbab  (8 bytes)
DATA_fichas_BB01_BBA3:
	defb 002h,003h,070h,070h,071h,087h,087h,088h	; bba3  ..ppq...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBAB: lo que p01:681E lee de las entradas 11 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbbab..0xbbb3  (8 bytes)
DATA_fichas_BB01_BBAB:
	defb 002h,003h,070h,070h,072h,087h,087h,089h	; bbab  ..ppr...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBB3: lo que p01:681E lee de las entradas 12 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbbb3..0xbbbb  (8 bytes)
DATA_fichas_BB01_BBB3:
	defb 002h,003h,070h,071h,072h,087h,088h,089h	; bbb3  ..pqr...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBBB: lo que p01:681E lee de las entradas 13 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbbbb..0xbbc3  (8 bytes)
DATA_fichas_BB01_BBBB:
	defb 002h,003h,070h,072h,072h,087h,089h,089h	; bbbb  ..prr...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBC3: lo que p01:681E lee de las entradas 14 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbbc3..0xbbcb  (8 bytes)
DATA_fichas_BB01_BBC3:
	defb 002h,003h,071h,072h,072h,088h,089h,089h	; bbc3  ..qrr...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBCB: lo que p01:681E lee de las entradas 15 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbbcb..0xbbd3  (8 bytes)
DATA_fichas_BB01_BBCB:
	defb 002h,003h,072h,072h,072h,089h,089h,089h	; bbcb  ..rrr...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BBD3: lo que p01:681E lee de las entradas 16 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (122 bytes)
;   0xbbd3..0xbc4d  (122 bytes)
DATA_fichas_BB01_BBD3:
	defb 00ah,00ch,000h,000h,000h,000h,000h,000h,000h,000h,07bh,000h,000h,000h,000h,000h	; bbd3  ..........{.....
	defb 000h,000h,000h,000h,000h,07ch,01fh,07dh,000h,000h,074h,03bh,07eh,000h,07bh,000h	; bbe3  .....|.}..t.~.{.
	defb 01fh,020h,021h,022h,023h,000h,000h,024h,025h,025h,025h,026h,027h,028h,081h,01fh	; bbf3  . !"#..$%%%&'(..
	defb 096h,07eh,000h,07ah,072h,072h,072h,072h,029h,02ah,02bh,02ch,029h,07eh,000h,091h	; bc03  .~.zrrrr)*+,)~..
	defb 089h,089h,089h,089h,050h,051h,052h,053h,050h,096h,000h,04bh,04ch,04ch,04ch,04dh	; bc13  ....PQRSP..KLLLM
	defb 04eh,04fh,050h,046h,07eh,095h,08bh,062h,096h,000h,092h,000h,046h,047h,048h,049h	; bc23  NOPF~..b....FGHI
	defb 04ah,000h,000h,000h,000h,000h,000h,000h,000h,093h,046h,094h,000h,000h,000h,000h	; bc33  J.........F.....
	defb 000h,000h,000h,000h,000h,000h,092h,000h,000h,000h	; bc43  ..........

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BC4D: lo que p01:681E lee de las entradas 17 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (170 bytes)
;   0xbc4d..0xbcf7  (170 bytes)
DATA_fichas_BB01_BC4D:
	defb 00ch,00eh,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bc4d  ................
	defb 079h,02dh,02eh,02fh,07bh,000h,077h,000h,000h,000h,000h,000h,000h,000h,000h,030h	; bc5d  y-./{.w........0
	defb 029h,031h,032h,033h,07fh,000h,000h,000h,000h,080h,000h,000h,000h,057h,050h,058h	; bc6d  )123.........WPX
	defb 059h,028h,034h,035h,085h,000h,000h,078h,086h,000h,090h,054h,055h,056h,092h,000h	; bc7d  Y(45...x...TUV..
	defb 075h,027h,036h,037h,038h,039h,03ah,077h,000h,000h,000h,000h,000h,07ah,072h,072h	; bc8d  u'6789:w.....zrr
	defb 072h,029h,02ah,02bh,02ch,07fh,000h,000h,000h,000h,000h,091h,089h,089h,089h,050h	; bc9d  r)*+,..........P
	defb 051h,052h,053h,096h,079h,02dh,02eh,02fh,07bh,000h,08ch,04eh,05dh,05eh,05fh,060h	; bcad  QRS.y-./{..N]^_`
	defb 061h,08eh,000h,030h,029h,031h,032h,04fh,05bh,05ch,09ch,000h,000h,08fh,09dh,000h	; bcbd  a..0)12O[\......
	defb 000h,057h,050h,058h,059h,05ah,096h,000h,000h,000h,000h,097h,000h,000h,090h,054h	; bccd  .WPXYZ.........T
	defb 055h,056h,092h,000h,08eh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,097h	; bcdd  UV..............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bced  ..........

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BCF7: lo que p01:681E lee de las entradas 18 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (258 bytes)
;   0xbcf7..0xbdf9  (258 bytes)
DATA_fichas_BB01_BCF7:
	defb 010h,010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,076h,000h,000h,082h,041h	; bcf7  ...........v...A
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,082h,041h,000h,000h,042h	; bd07  ............A..B
	defb 083h,000h,000h,000h,000h,000h,000h,000h,000h,080h,000h,000h,042h,083h,000h,044h	; bd17  ............B..D
	defb 045h,000h,000h,000h,000h,000h,000h,000h,000h,080h,000h,000h,044h,045h,000h,084h	; bd27  E...........DE..
	defb 040h,000h,000h,000h,000h,000h,000h,000h,000h,078h,000h,000h,084h,040h,000h,000h	; bd37  @........x...@..
	defb 03eh,000h,000h,07bh,02dh,02eh,02fh,07bh,073h,03bh,07fh,077h,000h,03eh,000h,01fh	; bd47  >..{-./{s..w.>..
	defb 096h,000h,000h,054h,055h,029h,031h,032h,038h,039h,039h,03ah,01fh,096h,07ch,020h	; bd57  ...TU)12899:..|
	defb 07fh,08dh,074h,000h,08dh,072h,072h,072h,02ah,02bh,02ch,021h,03bh,025h,026h,021h	; bd67  ..t..rrr*+,!.%&!
	defb 022h,03eh,08bh,000h,076h,089h,089h,089h,051h,052h,053h,048h,062h,04ch,04dh,048h	; bd77  ">..v...QRSHbLMH
	defb 049h,065h,000h,02dh,02eh,050h,058h,059h,05fh,060h,060h,061h,046h,07fh,093h,047h	; bd87  Ie.-.PXY_``aF..G
	defb 096h,076h,000h,092h,054h,055h,056h,092h,08ah,062h,096h,08eh,000h,066h,000h,046h	; bd97  .v..TUV..b...f.F
	defb 07fh,000h,000h,000h,000h,000h,000h,000h,000h,08fh,000h,000h,09bh,067h,000h,000h	; bda7  .............g..
	defb 066h,000h,000h,000h,000h,000h,000h,000h,000h,097h,000h,000h,06bh,06ch,000h,09bh	; bdb7  f...........kl..
	defb 067h,000h,000h,000h,000h,000h,000h,000h,000h,097h,000h,000h,069h,09ah,000h,06bh	; bdc7  g...........i..k
	defb 06ch,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,099h,068h,000h,000h,069h	; bdd7  l...........h..i
	defb 09ah,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,08dh,000h,000h,099h,068h	; bde7  ...............h
	defb 000h,000h	; bdf7

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BDF9: lo que p01:681E lee de las entradas 19 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (194 bytes)
;   0xbdf9..0xbebb  (194 bytes)
DATA_fichas_BB01_BDF9:
	defb 010h,00ch,000h,000h,000h,000h,000h,000h,000h,083h,000h,000h,000h,000h,000h,000h	; bdf9  ................
	defb 000h,000h,000h,08bh,080h,045h,080h,000h,000h,000h,000h,000h,000h,000h,092h,047h	; be09  .....E.........G
	defb 05bh,05ch,078h,000h,000h,000h,000h,000h,000h,000h,000h,03ch,02dh,09bh,096h,000h	; be19  [\x........<-...
	defb 000h,000h,000h,000h,000h,000h,000h,043h,03dh,06bh,045h,000h,000h,000h,000h,000h	; be29  .......C=kE.....
	defb 000h,000h,07bh,020h,034h,069h,040h,07fh,077h,000h,000h,079h,054h,02fh,025h,028h	; be39  ..{ 4i@.w..yT/%(
	defb 032h,038h,039h,039h,07fh,000h,074h,08ah,074h,072h,072h,072h,072h,02ah,02bh,02ch	; be49  2899..t.trrrr*+,
	defb 039h,03ah,08bh,073h,08bh,089h,089h,089h,089h,051h,052h,053h,060h,061h,000h,090h	; be59  9:.s.....QRS`a..
	defb 02dh,056h,04ch,04fh,059h,05fh,060h,060h,096h,000h,000h,000h,000h,000h,092h,047h	; be69  -VLOY_``.......G
	defb 05bh,042h,067h,096h,08eh,000h,000h,000h,000h,000h,000h,06ah,064h,044h,06ch,000h	; be79  [Bg........jdDl.
	defb 000h,000h,000h,000h,000h,000h,000h,063h,054h,084h,07fh,000h,000h,000h,000h,000h	; be89  .......cT.......
	defb 000h,000h,07bh,020h,034h,035h,08fh,000h,000h,000h,000h,000h,000h,000h,000h,074h	; be99  ..{ 45.........t
	defb 097h,06ch,097h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,09ah,000h,000h	; bea9  .l..............
	defb 000h,000h	; beb9

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BEBB: lo que p01:681E lee de las entradas 20 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbebb..0xbec3  (8 bytes)
DATA_fichas_BB01_BEBB:
	defb 002h,003h,02ah,02bh,02ch,051h,052h,053h	; bebb  ..*+,QRS

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BEC3: lo que p01:681E lee de las entradas 21 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbec3..0xbecb  (8 bytes)
DATA_fichas_BB01_BEC3:
	defb 002h,003h,06dh,06eh,06fh,0c0h,0c1h,0c2h	; bec3  ..mno...

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BECB: lo que p01:681E lee de las entradas 22 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (90 bytes)
;   0xbecb..0xbf25  (90 bytes)
DATA_fichas_BB01_BECB:
	defb 008h,00bh,000h,000h,000h,000h,072h,01fh,020h,021h,022h,023h,000h,000h,000h,073h	; becb  ......r. !"#...s
	defb 024h,025h,026h,076h,077h,078h,027h,028h,074h,029h,02ah,02bh,079h,07ah,07bh,07ch	; bedb  $%&vwx'(t)*+yz{|
	defb 07dh,07eh,02ch,075h,000h,000h,000h,000h,000h,000h,083h,084h,085h,02dh,093h,000h	; beeb  }~,u.........-..
	defb 000h,000h,000h,000h,000h,0a1h,0a2h,0a3h,03fh,092h,03bh,03ch,03dh,097h,098h,099h	; befb  ........?..<=...
	defb 09ah,09bh,09ch,03eh,000h,000h,091h,036h,037h,038h,094h,095h,096h,039h,03ah,000h	; bf0b  ...>...678...9:.
	defb 000h,000h,000h,090h,031h,032h,033h,034h,035h,000h	; bf1b  ....12345.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF25: lo que p01:681E lee de las entradas 23 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf25..0xbf2d  (8 bytes)
DATA_fichas_BB01_BF25:
	defb 002h,003h,030h,030h,089h,042h,042h,0a7h	; bf25  ..00.BB.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF2D: lo que p01:681E lee de las entradas 24 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf2d..0xbf35  (8 bytes)
DATA_fichas_BB01_BF2D:
	defb 002h,003h,030h,030h,07fh,042h,042h,09dh	; bf2d  ..00.BB.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF35: lo que p01:681E lee de las entradas 25 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf35..0xbf3d  (8 bytes)
DATA_fichas_BB01_BF35:
	defb 002h,003h,030h,02fh,07fh,042h,041h,09dh	; bf35  ..0/.BA.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF3D: lo que p01:681E lee de las entradas 26 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf3d..0xbf45  (8 bytes)
DATA_fichas_BB01_BF3D:
	defb 002h,003h,030h,02eh,07fh,042h,040h,09dh	; bf3d  ..0..B@.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF45: lo que p01:681E lee de las entradas 27 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf45..0xbf4d  (8 bytes)
DATA_fichas_BB01_BF45:
	defb 002h,003h,02fh,02eh,07fh,041h,040h,09dh	; bf45  ../..A@.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF4D: lo que p01:681E lee de las entradas 28 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf4d..0xbf55  (8 bytes)
DATA_fichas_BB01_BF4D:
	defb 002h,003h,02eh,02eh,07fh,040h,040h,09dh	; bf4d  .....@@.

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF55: lo que p01:681E lee de las entradas 29 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf55..0xbf5d  (8 bytes)
DATA_fichas_BB01_BF55:
	defb 002h,003h,086h,087h,088h,0a4h,0a5h,0a6h	; bf55  ........

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF5D: lo que p01:681E lee de las entradas 30 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf5d..0xbf65  (8 bytes)
DATA_fichas_BB01_BF5D:
	defb 002h,003h,080h,081h,082h,09eh,09fh,0a0h	; bf5d  ........

; ----------------------------------------------------------------------
; DATOS fichas_BB01_BF65: lo que p01:681E lee de las entradas 31 de 0xBB01:
;   [C][B] y lo que sigue; lo leen p01:681E (8 bytes)
;   0xbf65..0xbf6d  (8 bytes)
DATA_fichas_BB01_BF65:
	defb 002h,003h,08ah,08bh,08ch,0a8h,0a9h,0aah	; bf65  ........

; ----------------------------------------------------------------------
; DATOS rachas_BF6D: rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino,
;   >0x80 copia, 0 acaba); lo leen p00:4B5A (118 bytes)
;   0xbf6d..0xbfe3  (118 bytes)
DATA_rachas_BF6D:
	defb 086h,060h,098h,006h,001h,006h,018h,00dh,000h,084h,0e0h,010h,010h,00fh,00ah,000h	; bf6d  .`..............
	defb 086h,038h,004h,03ch,0c3h,080h,080h,004h,000h,085h,070h,00ch,003h,004h,018h,005h	; bf7d  .8.<......p.....
	defb 000h,089h,080h,040h,043h,044h,038h,008h,010h,060h,080h,004h,000h,085h,001h,0c1h	; bf8d  ...@CD8..`......
	defb 03eh,008h,008h,003h,010h,081h,0e0h,005h,000h,083h,001h,00eh,0f0h,004h,020h,082h	; bf9d  >............. .
	defb 040h,080h,007h,000h,002h,008h,082h,006h,003h,006h,000h,082h,033h,0cch,008h,000h	; bfad  @...........3...
	defb 082h,080h,040h,003h,020h,087h,030h,090h,070h,010h,008h,008h,007h,003h,000h,082h	; bfbd  ..@. .0.p.......
	defb 00ch,033h,004h,000h,002h,001h,084h,00eh,008h,010h,0f0h,004h,000h,083h,0ech,013h	; bfcd  .3..............
	defb 060h,003h,080h,007h,000h,000h	; bfdd

; ----------------------------------------------------------------------
; DATOS relleno_ff: 29 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (29 bytes)
;   0xbfe3..0xc000  (29 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe3  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff3  .............

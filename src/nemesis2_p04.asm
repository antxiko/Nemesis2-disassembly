; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 04 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS ondas: 64 punteros a las formas de onda del SCC (orden 0xF8 de la
;   partitura, p04:6EE2); de la 0x30 a la 0x3F apuntan a 0x6480, que es
;   codigo: no las pide ninguna partitura; lo leen p04:6EE5 (128 bytes)
;   0x6000..0x6080  (128 bytes)
DATA_ondas:
	defw 06080h,060a0h,060c0h,060e0h,06100h,06120h,06140h,06160h	; 6000
	defw 06180h,061a0h,061c0h,061e0h,06200h,06220h,06240h,06240h	; 6010
	defw 06240h,06260h,06280h,062a0h,062c0h,062e0h,06300h,06320h	; 6020
	defw 06340h,06360h,06380h,06380h,06380h,06380h,063a0h,063c0h	; 6030
	defw 063c0h,063e0h,063e0h,06400h,06400h,06400h,06400h,06420h	; 6040
	defw 06420h,06440h,06460h,06460h,06460h,06460h,06460h,06460h	; 6050
	defw 06480h,06480h,06480h,06480h,06480h,06480h,06480h,06480h	; 6060
	defw 06480h,06480h,06480h,06480h,06480h,06480h,06480h,06480h	; 6070

; ----------------------------------------------------------------------
; DATOS onda_00: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6080..0x60a0  (32 bytes)
DATA_onda_00:
	defb 07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh	; 6080  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,000h	; 6090  ................

; ----------------------------------------------------------------------
; DATOS onda_01: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x60a0..0x60c0  (32 bytes)
DATA_onda_01:
	defb 07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,080h,080h,080h,080h,080h,080h,080h,080h	; 60a0  ................
	defb 07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,080h,080h,080h,080h,080h,080h,080h,080h	; 60b0  ................

; ----------------------------------------------------------------------
; DATOS onda_02: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x60c0..0x60e0  (32 bytes)
DATA_onda_02:
	defb 000h,0f8h,0f0h,0e8h,0e0h,0d8h,0d0h,0c8h,0c0h,0b8h,0b0h,0a8h,0a0h,098h,090h,088h	; 60c0  ................
	defb 080h,078h,070h,068h,060h,058h,050h,048h,040h,038h,030h,028h,020h,018h,010h,008h	; 60d0  .xph`XPH@80( ...

; ----------------------------------------------------------------------
; DATOS onda_03: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x60e0..0x6100  (32 bytes)
DATA_onda_03:
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,070h,060h,050h,040h,030h,020h,010h	; 60e0  .........p`P@0 .
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,070h,060h,050h,040h,030h,020h,010h	; 60f0  .........p`P@0 .

; ----------------------------------------------------------------------
; DATOS onda_04: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6100..0x6120  (32 bytes)
DATA_onda_04:
	defb 000h,04eh,062h,06dh,075h,07ah,07dh,07eh,07fh,07eh,07dh,07ah,075h,06dh,062h,04eh	; 6100  .Nbmuz}~.~}zumbN
	defb 000h,0b1h,09dh,092h,08ah,085h,082h,081h,080h,081h,082h,085h,08ah,092h,09dh,0b1h	; 6110  ................

; ----------------------------------------------------------------------
; DATOS onda_05: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6120..0x6140  (32 bytes)
DATA_onda_05:
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h	; 6120  ..1GZju}.}ujZG1.
	defb 000h,0e7h,0cfh,0b9h,0a6h,096h,08bh,083h,080h,083h,08bh,096h,0a6h,0b9h,0cfh,0e7h	; 6130  ................

; ----------------------------------------------------------------------
; DATOS onda_06: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6140..0x6160  (32 bytes)
DATA_onda_06:
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,090h,0a0h,0b0h,0c0h,0d0h,0e0h,0f0h	; 6140  ................
	defb 000h,010h,020h,030h,040h,050h,060h,070h,07fh,070h,060h,050h,040h,030h,020h,010h	; 6150  .. 0@P`p.p`P@0 .

; ----------------------------------------------------------------------
; DATOS onda_07: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6160..0x6180  (32 bytes)
DATA_onda_07:
	defb 000h,0e0h,0c0h,0a0h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,07fh,060h,040h,020h	; 6160  ......... @`.`@
	defb 000h,0e0h,0c0h,0a0h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,07fh,060h,040h,020h	; 6170  ......... @`.`@

; ----------------------------------------------------------------------
; DATOS onda_08: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal (ninguna partitura la pide); lo leen
;   p04:7241 (32 bytes)
;   0x6180..0x61a0  (32 bytes)
DATA_onda_08:
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h	; 6180  ..1GZju}.}ujZG1.
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,090h,0a0h,0b0h,0c0h,0d0h,0e0h,0f0h	; 6190  ................

; ----------------------------------------------------------------------
; DATOS onda_09: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x61a0..0x61c0  (32 bytes)
DATA_onda_09:
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h	; 61a0  ..1GZju}.}ujZG1.
	defb 000h,0e0h,0c0h,0a0h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,07fh,060h,040h,020h	; 61b0  ......... @`.`@

; ----------------------------------------------------------------------
; DATOS onda_10: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x61c0..0x61e0  (32 bytes)
DATA_onda_10:
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h	; 61c0  ..1GZju}.}ujZG1.
	defb 080h,090h,0a0h,0b0h,0c0h,0d0h,0e0h,0f0h,000h,010h,020h,030h,040h,050h,060h,070h	; 61d0  .......... 0@P`p

; ----------------------------------------------------------------------
; DATOS onda_11: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x61e0..0x6200  (32 bytes)
DATA_onda_11:
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h	; 61e0  ..1GZju}.}ujZG1.
	defb 080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h	; 61f0  ..... @`..... @`

; ----------------------------------------------------------------------
; DATOS onda_12: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6200..0x6220  (32 bytes)
DATA_onda_12:
	defb 001h,02ah,040h,050h,05ch,068h,070h,078h,07fh,078h,070h,068h,05ch,050h,040h,02ah	; 6200  .*@P\hpx.xph\P@*
	defb 0ffh,0d6h,0c0h,0b0h,0a4h,098h,090h,088h,081h,088h,090h,098h,0a4h,0b0h,0c0h,0d6h	; 6210  ................

; ----------------------------------------------------------------------
; DATOS onda_13: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6220..0x6240  (32 bytes)
DATA_onda_13:
	defb 000h,040h,07fh,040h,001h,0c0h,081h,0c0h,001h,040h,07fh,040h,001h,0c0h,001h,040h	; 6220  .@.@.....@.@...@
	defb 001h,0e0h,001h,020h,001h,0f0h,001h,010h,001h,0ffh,0ffh,0ffh,0ffh,040h,040h,040h	; 6230  ... .........@@@

; ----------------------------------------------------------------------
; DATOS onda_14: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6240..0x6260  (32 bytes)
DATA_onda_14:
	defb 000h,040h,07fh,040h,001h,010h,020h,02dh,037h,044h,04eh,059h,063h,06ch,073h,078h	; 6240  .@.@.. -7DNYclsx
	defb 07ch,07fh,07ch,078h,073h,06ch,059h,04eh,044h,037h,02dh,020h,010h,003h,002h,001h	; 6250  |.|xslYND7- ....

; ----------------------------------------------------------------------
; DATOS onda_15: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6260..0x6280  (32 bytes)
DATA_onda_15:
	defb 000h,040h,07fh,040h,010h,001h,0eah,0d6h,0c3h,0b9h,0afh,0a4h,09ch,095h,08fh,08ah	; 6260  .@.@............
	defb 086h,083h,081h,083h,086h,08ah,08fh,095h,09ch,0a4h,0afh,0b9h,0c3h,0d6h,0eah,0ffh	; 6270  ................

; ----------------------------------------------------------------------
; DATOS onda_16: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6280..0x62a0  (32 bytes)
DATA_onda_16:
	defb 000h,040h,07fh,040h,000h,0c0h,0ffh,0c0h,005h,0ebh,0d6h,0c3h,0b9h,0afh,0a4h,09ch	; 6280  .@.@............
	defb 095h,08fh,089h,084h,081h,084h,089h,08fh,095h,09ch,0a4h,0afh,0b9h,0c3h,0d6h,0eah	; 6290  ................

; ----------------------------------------------------------------------
; DATOS onda_17: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x62a0..0x62c0  (32 bytes)
DATA_onda_17:
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,080h,080h,080h,080h,080h,080h,080h	; 62a0  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,07fh,070h,060h,050h,040h,030h,020h,010h	; 62b0  .........p`P@0 .

; ----------------------------------------------------------------------
; DATOS onda_18: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x62c0..0x62e0  (32 bytes)
DATA_onda_18:
	defb 000h,030h,050h,060h,070h,060h,050h,030h,000h,0d0h,0b0h,0a0h,090h,0a0h,0b0h,0d0h	; 62c0  .0P`p`P0........
	defb 000h,040h,060h,070h,060h,040h,000h,0c0h,0a0h,090h,0a0h,0c0h,000h,070h,000h,090h	; 62d0  .@`p`@.......p..

; ----------------------------------------------------------------------
; DATOS onda_19: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x62e0..0x6300  (32 bytes)
DATA_onda_19:
	defb 030h,050h,050h,030h,000h,000h,010h,040h,060h,070h,060h,030h,0f0h,0e0h,0e0h,000h	; 62e0  0PP0...@`p`0....
	defb 020h,020h,010h,0c0h,0a0h,090h,0a0h,0c0h,000h,000h,0d0h,0b0h,0b0h,0d0h,000h,000h	; 62f0    ..............

; ----------------------------------------------------------------------
; DATOS onda_20: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6300..0x6320  (32 bytes)
DATA_onda_20:
	defb 0a0h,090h,090h,0a0h,0a0h,0b0h,0b0h,0b0h,0c0h,0c0h,0d0h,0d0h,0e0h,0e0h,0f0h,0f0h	; 6300  ................
	defb 000h,000h,010h,010h,020h,020h,030h,030h,040h,040h,050h,050h,060h,060h,060h,050h	; 6310  ....  00@@PP```P

; ----------------------------------------------------------------------
; DATOS onda_21: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6320..0x6340  (32 bytes)
DATA_onda_21:
	defb 000h,07fh,000h,080h,0a0h,0c0h,0d8h,0f0h,008h,020h,030h,040h,050h,060h,070h,078h	; 6320  ......... 0@P`px
	defb 07ch,07fh,07ch,078h,070h,060h,050h,040h,030h,020h,008h,0f0h,0d8h,0c0h,0a0h,080h	; 6330  |.|xp`P@0 ......

; ----------------------------------------------------------------------
; DATOS onda_22: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6340..0x6360  (32 bytes)
DATA_onda_22:
	defb 07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h	; 6340  ................
	defb 07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h,07fh,080h	; 6350  ................

; ----------------------------------------------------------------------
; DATOS onda_23: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6360..0x6380  (32 bytes)
DATA_onda_23:
	defb 07fh,080h,07fh,080h,07fh,080h,07fh,080h,000h,000h,000h,000h,000h,000h,000h,000h	; 6360  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,07fh,080h,07fh,080h,07fh,080h,07fh,080h	; 6370  ................

; ----------------------------------------------------------------------
; DATOS onda_24: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6380..0x63a0  (32 bytes)
DATA_onda_24:
	defb 000h,070h,050h,020h,050h,070h,030h,000h,050h,07fh,060h,010h,030h,040h,000h,0b0h	; 6380  .pP Pp0.P.`.0@..
	defb 010h,060h,000h,0e0h,0f0h,000h,0b0h,090h,0c0h,010h,0e0h,0a0h,0c0h,0f0h,0c0h,0a0h	; 6390  .`..............

; ----------------------------------------------------------------------
; DATOS onda_25: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x63a0..0x63c0  (32 bytes)
DATA_onda_25:
	defb 080h,088h,090h,098h,0a0h,0b0h,0b0h,0b8h,0c0h,0c8h,0d0h,0d8h,0e0h,0e8h,0f0h,0f8h	; 63a0  ................
	defb 000h,008h,010h,018h,020h,028h,030h,038h,040h,048h,050h,058h,060h,068h,070h,078h	; 63b0  .... (08@HPX`hpx

; ----------------------------------------------------------------------
; DATOS onda_26: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x63c0..0x63e0  (32 bytes)
DATA_onda_26:
	defb 000h,000h,000h,000h,000h,078h,078h,000h,000h,080h,080h,080h,000h,000h,000h,000h	; 63c0  .....xx.........
	defb 078h,078h,078h,000h,080h,080h,000h,000h,000h,000h,078h,078h,000h,000h,080h,080h	; 63d0  xxx.......xx....

; ----------------------------------------------------------------------
; DATOS onda_27: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x63e0..0x6400  (32 bytes)
DATA_onda_27:
	defb 078h,078h,078h,078h,078h,078h,078h,078h,080h,080h,080h,080h,080h,080h,080h,080h	; 63e0  xxxxxxxx........
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 63f0  ................

; ----------------------------------------------------------------------
; DATOS onda_28: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6400..0x6420  (32 bytes)
DATA_onda_28:
	defb 000h,000h,000h,080h,000h,070h,070h,070h,000h,000h,000h,080h,000h,000h,000h,080h	; 6400  .....ppp........
	defb 080h,080h,080h,000h,080h,000h,000h,000h,000h,080h,080h,080h,000h,080h,080h,080h	; 6410  ................

; ----------------------------------------------------------------------
; DATOS onda_29: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6420..0x6440  (32 bytes)
DATA_onda_29:
	defb 070h,070h,070h,070h,070h,070h,070h,070h,080h,080h,080h,080h,080h,080h,080h,080h	; 6420  pppppppp........
	defb 070h,070h,070h,080h,080h,080h,070h,070h,070h,070h,080h,080h,080h,080h,080h,080h	; 6430  ppp...pppp......

; ----------------------------------------------------------------------
; DATOS onda_30: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6440..0x6460  (32 bytes)
DATA_onda_30:
	defb 0a0h,090h,090h,090h,0a0h,0a0h,0b0h,0b0h,0c0h,0c0h,0d0h,0d0h,0e0h,0e0h,0f0h,0f0h	; 6440  ................
	defb 000h,000h,010h,010h,020h,020h,030h,030h,040h,040h,050h,050h,060h,060h,060h,050h	; 6450  ....  00@@PP```P

; ----------------------------------------------------------------------
; DATOS onda_31: forma de onda del SCC: 32 muestras con signo que p04:7236
;   copia a 0x9800 + 0x20 x canal; lo leen p04:7241 (32 bytes)
;   0x6460..0x6480  (32 bytes)
DATA_onda_31:
	defb 0f8h,0f0h,0e8h,0e0h,0d8h,0d0h,0c8h,0c0h,0b8h,0b0h,0a8h,0a0h,098h,090h,088h,080h	; 6460  ................
	defb 078h,070h,068h,060h,058h,050h,048h,040h,038h,030h,028h,020h,018h,010h,008h,000h	; 6470  xph`XPH@80( ....

; ======================================================================
; CODIGO 0x6480..0x657d  (253 bytes)
; ======================================================================


L_6480:
	ld c,a			;6480
	cp 0f0h		;6481
	jp z,L_658D		;6483
	cp 0f1h		;6486
	jp z,L_6594		;6488
	cp 0f2h		;648b
	jp z,L_65A1		;648d
	cp 0f3h		;6490
	call z,L_65DE		;6492
	ld hl,0e078h		;6495
	ld a,c			;6498
	cp 005h		;6499
	jr nz,L_64A0		;649b
	ld a,(hl)			;649d
	cp c			;649e
	ret z			;649f
L_64A0:
	ld a,c			;64a0
	cp 012h		;64a1
	jr nz,L_64A8		;64a3
	ld a,(hl)			;64a5
	cp c			;64a6
	ret z			;64a7
L_64A8:
	ld a,c			;64a8
	cp 014h		;64a9
	jr nz,L_64B0		;64ab
	ld a,(hl)			;64ad
	cp c			;64ae
	ret z			;64af
L_64B0:
	ld hl,0e191h		;64b0
	ld (hl),c			;64b3
	ld hl,06612h		;64b4
	ld a,c			;64b7
	add a,c			;64b8
	ld e,a			;64b9
	ld d,000h		;64ba
	add hl,de			;64bc
	ld e,(hl)			;64bd
	inc hl			;64be
	ld d,(hl)			;64bf
	ex de,hl			;64c0
	ld de,0e192h		;64c1
	ld bc,00012h		;64c4
	ldir		;64c7
	ld ix,0e194h		;64c9
	ld hl,0e192h		;64cd
	bit 7,(hl)		;64d0
	jr z,L_64E0		;64d2
	inc hl			;64d4
	ld a,(hl)			;64d5
	ld hl,0e001h		;64d6
	call L_655D		;64d9
	inc ix		;64dc
	inc ix		;64de
L_64E0:
	ld hl,0e192h		;64e0
	bit 6,(hl)		;64e3
	jr z,L_64F3		;64e5
	inc hl			;64e7
	ld a,(hl)			;64e8
	ld hl,0e029h		;64e9
	call L_655D		;64ec
	inc ix		;64ef
	inc ix		;64f1
L_64F3:
	ld hl,0e192h		;64f3
	bit 5,(hl)		;64f6
	jr z,L_6506		;64f8
	inc hl			;64fa
	ld a,(hl)			;64fb
	ld hl,0e051h		;64fc
	call L_655D		;64ff
	inc ix		;6502
	inc ix		;6504
L_6506:
	ld hl,0e192h		;6506
	bit 4,(hl)		;6509
	jr z,L_6519		;650b
	inc hl			;650d
	ld a,(hl)			;650e
	ld hl,0e079h		;650f
	call L_655D		;6512
	inc ix		;6515
	inc ix		;6517
L_6519:
	ld hl,0e192h		;6519
	bit 3,(hl)		;651c
	jr z,L_652C		;651e
	inc hl			;6520
	ld a,(hl)			;6521
	ld hl,0e0a1h		;6522
	call L_655D		;6525
	inc ix		;6528
	inc ix		;652a
L_652C:
	ld hl,0e192h		;652c
	bit 2,(hl)		;652f
	jr z,L_653F		;6531
	inc hl			;6533
	ld a,(hl)			;6534
	ld hl,0e0c9h		;6535
	call L_655D		;6538
	inc ix		;653b
	inc ix		;653d
L_653F:
	ld hl,0e192h		;653f
	bit 1,(hl)		;6542
	jr z,L_6552		;6544
	inc hl			;6546
	ld a,(hl)			;6547
	ld hl,0e0f1h		;6548
	call L_655D		;654b
	inc ix		;654e
	inc ix		;6550
L_6552:
	ld hl,0e192h		;6552
	bit 0,(hl)		;6555
	ret z			;6557
	inc hl			;6558
	ld a,(hl)			;6559
	ld hl,0e119h		;655a
L_655D:
	ld b,(hl)			;655d
	cp b			;655e
	ret c			;655f
	ex de,hl			;6560
	ld (de),a			;6561
	dec de			;6562
	ld hl,0e191h		;6563
	ld a,(hl)			;6566
	ld (de),a			;6567
	inc de			;6568
	inc de			;6569
	ld a,(ix+000h)		;656a
	ld (de),a			;656d
	inc de			;656e
	ld a,(ix+001h)		;656f
	ld (de),a			;6572
	inc de			;6573
	ld hl,0657dh		;6574
	ld bc,00010h		;6577
	ldir		;657a
	ret			;657c

; ----------------------------------------------------------------------
; DATOS canal_nuevo: 16 bytes que p04:6574 copia a IX+04..IX+13 de un canal al
;   arrancarlo: la cuenta a 1 y lo demas a 0; lo leen p04:6574 (16 bytes)
;   0x657d..0x658d  (16 bytes)
DATA_canal_nuevo:
	defb 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 657d  ................

; ======================================================================
; CODIGO 0x658d..0x6614  (135 bytes)
; ======================================================================


L_658D:
	ld hl,0e190h		;658d   ; apunta a el estado del sonido (bit 0)
	res 0,(hl)		;6590
	jr L_6599		;6592
L_6594:
	ld hl,0e190h		;6594   ; apunta a el estado del sonido (bit 0)
	set 0,(hl)		;6597
L_6599:
	ld hl,0e1a4h		;6599
	xor a			;659c
	ld (hl),a			;659d
	inc hl			;659e
	ld (hl),a			;659f
	ret			;65a0
L_65A1:
	ld hl,0e190h		;65a1   ; apunta a el estado del sonido (bit 0)
	res 1,(hl)		;65a4
	bit 3,(hl)		;65a6
	jr z,L_65AE		;65a8
	res 3,(hl)		;65aa
	set 0,(hl)		;65ac
L_65AE:
	ld hl,0e140h		;65ae
	ld de,0e000h		;65b1   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call L_660E		;65b4
	ld a,(0e1c0h)		;65b7   ; lee el estado del juego (0-10, p00:5615)
	ld e,a			;65ba
	ld a,03fh		;65bb
	ld (09000h),a		;65bd   ; el mapper: pone en 0x8000 el banco de A
	ld a,e			;65c0
	ld (0988fh),a		;65c1
	ld a,005h		;65c4
	ld (09000h),a		;65c6   ; el mapper: pone en 0x8000 el banco de A
	ld a,0ffh		;65c9
	ld hl,0e1aeh		;65cb
	ld (hl),a			;65ce
	inc hl			;65cf
	ld (hl),a			;65d0
	call L_71AE		;65d1
	ld hl,0e05dh		;65d4
	ld a,(hl)			;65d7
	rrca			;65d8
	rrca			;65d9
	rrca			;65da
	rrca			;65db
	ld (hl),a			;65dc
	ret			;65dd
L_65DE:
	ld hl,0e190h		;65de   ; apunta a el estado del sonido (bit 0)
	set 1,(hl)		;65e1
	bit 0,(hl)		;65e3
	jr z,L_65EB		;65e5
	res 0,(hl)		;65e7
	set 3,(hl)		;65e9
L_65EB:
	ld hl,0e000h		;65eb   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	ld de,0e140h		;65ee
	call L_660E		;65f1
	ld a,03fh		;65f4
	ld (09000h),a		;65f6   ; el mapper: pone en 0x8000 el banco de A
	xor a			;65f9
	ld (0988fh),a		;65fa
	ld a,005h		;65fd
	ld (09000h),a		;65ff   ; el mapper: pone en 0x8000 el banco de A
	ld hl,0e05dh		;6602
	ld a,(hl)			;6605
	rlca			;6606
	rlca			;6607
	rlca			;6608
	rlca			;6609
	ld (hl),a			;660a
	ld c,00dh		;660b
	ret			;660d
L_660E:
	ld bc,00050h		;660e
	ldir		;6611
	ret			;6613

; ----------------------------------------------------------------------
; DATOS sonidos: 67 punteros, uno por sonido del 1 al 0x43 (A en p04:6480,
;   tabla en 0x6612 + 2 x A): su cabecera [canales][prioridad][una palabra por
;   canal]. La entrada 0 serian los bytes B0 C9 de `ldir / ret` (p04:6611): no
;   hay sonido 0; lo leen p04:64B4 (134 bytes)
;   0x6614..0x669a  (134 bytes)
DATA_sonidos:
	defw 0669ah,066a0h,066a6h,066ach,066b2h,066b8h,066beh,066c4h	; 6614
	defw 066cah,066d0h,066d6h,066dch,066e2h,066e8h,066eeh,066f4h	; 6624
	defw 066fah,06700h,06706h,0670ch,06712h,06718h,0671eh,06724h	; 6634
	defw 0672ah,06730h,06736h,0673ch,06742h,06748h,0674eh,06754h	; 6644
	defw 0675ah,06760h,06766h,0676ch,06772h,06778h,0677eh,06784h	; 6654
	defw 0678ah,06798h,067a6h,067b4h,067c2h,067d0h,067deh,067ech	; 6664
	defw 067fah,06808h,06816h,06824h,06832h,06840h,0684eh,06860h	; 6674
	defw 06872h,06884h,06896h,068a8h,068bah,068cch,068deh,068f0h	; 6684
	defw 068feh,06910h,06922h	; 6694  -> DATA_cabecera_41 DATA_cabecera_42 DATA_cabecera_43

; ----------------------------------------------------------------------
; DATOS cabecera_01: cabecera del sonido 0x01: canales 0x90, prioridad 0x02 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x669a..0x66a0  (6 bytes)
DATA_cabecera_01:
	defb 090h,002h,0dch,072h,0e8h,072h	; 669a

; ----------------------------------------------------------------------
; DATOS cabecera_02: cabecera del sonido 0x02: canales 0x90, prioridad 0x03 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66a0..0x66a6  (6 bytes)
DATA_cabecera_02:
	defb 090h,003h,011h,073h,015h,073h	; 66a0

; ----------------------------------------------------------------------
; DATOS cabecera_03: cabecera del sonido 0x03: canales 0x90, prioridad 0x03 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66a6..0x66ac  (6 bytes)
DATA_cabecera_03:
	defb 090h,003h,045h,073h,06ah,073h	; 66a6

; ----------------------------------------------------------------------
; DATOS cabecera_04: cabecera del sonido 0x04: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66ac..0x66b2  (6 bytes)
DATA_cabecera_04:
	defb 090h,00ah,0afh,073h,0b6h,073h	; 66ac

; ----------------------------------------------------------------------
; DATOS cabecera_05: cabecera del sonido 0x05: canales 0x90, prioridad 0x08 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66b2..0x66b8  (6 bytes)
DATA_cabecera_05:
	defb 090h,008h,0e0h,073h,0f8h,073h	; 66b2

; ----------------------------------------------------------------------
; DATOS cabecera_06: cabecera del sonido 0x06: canales 0x90, prioridad 0x0D y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66b8..0x66be  (6 bytes)
DATA_cabecera_06:
	defb 090h,00dh,020h,074h,024h,074h	; 66b8

; ----------------------------------------------------------------------
; DATOS cabecera_07: cabecera del sonido 0x07: canales 0x90, prioridad 0x08 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66be..0x66c4  (6 bytes)
DATA_cabecera_07:
	defb 090h,008h,063h,074h,067h,074h	; 66be

; ----------------------------------------------------------------------
; DATOS cabecera_08: cabecera del sonido 0x08: canales 0x90, prioridad 0x08 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66c4..0x66ca  (6 bytes)
DATA_cabecera_08:
	defb 090h,008h,0a4h,074h,0cbh,074h	; 66c4

; ----------------------------------------------------------------------
; DATOS cabecera_09: cabecera del sonido 0x09: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66ca..0x66d0  (6 bytes)
DATA_cabecera_09:
	defb 090h,012h,0f7h,074h,0fbh,074h	; 66ca

; ----------------------------------------------------------------------
; DATOS cabecera_0A: cabecera del sonido 0x0A: canales 0x90, prioridad 0x0C y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66d0..0x66d6  (6 bytes)
DATA_cabecera_0A:
	defb 090h,00ch,03fh,075h,04bh,075h	; 66d0

; ----------------------------------------------------------------------
; DATOS cabecera_0B: cabecera del sonido 0x0B: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66d6..0x66dc  (6 bytes)
DATA_cabecera_0B:
	defb 090h,012h,094h,075h,098h,075h	; 66d6

; ----------------------------------------------------------------------
; DATOS cabecera_0C: cabecera del sonido 0x0C: canales 0x90, prioridad 0x22 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66dc..0x66e2  (6 bytes)
DATA_cabecera_0C:
	defb 090h,022h,0c9h,075h,0ech,075h	; 66dc

; ----------------------------------------------------------------------
; DATOS cabecera_0D: cabecera del sonido 0x0D: canales 0xC0, prioridad 0x70 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66e2..0x66e8  (6 bytes)
DATA_cabecera_0D:
	defb 0c0h,070h,06eh,076h,070h,076h	; 66e2

; ----------------------------------------------------------------------
; DATOS cabecera_0E: cabecera del sonido 0x0E: canales 0x90, prioridad 0x04 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66e8..0x66ee  (6 bytes)
DATA_cabecera_0E:
	defb 090h,004h,086h,076h,08ah,076h	; 66e8

; ----------------------------------------------------------------------
; DATOS cabecera_0F: cabecera del sonido 0x0F: canales 0x90, prioridad 0x0F y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66ee..0x66f4  (6 bytes)
DATA_cabecera_0F:
	defb 090h,00fh,0c0h,076h,002h,077h	; 66ee

; ----------------------------------------------------------------------
; DATOS cabecera_10: cabecera del sonido 0x10: canales 0x90, prioridad 0x0F y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66f4..0x66fa  (6 bytes)
DATA_cabecera_10:
	defb 090h,00fh,07fh,077h,09ch,077h	; 66f4

; ----------------------------------------------------------------------
; DATOS cabecera_11: cabecera del sonido 0x11: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x66fa..0x6700  (6 bytes)
DATA_cabecera_11:
	defb 090h,00ah,0fdh,077h,022h,078h	; 66fa

; ----------------------------------------------------------------------
; DATOS cabecera_12: cabecera del sonido 0x12: canales 0x90, prioridad 0x04 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6700..0x6706  (6 bytes)
DATA_cabecera_12:
	defb 090h,004h,045h,078h,067h,078h	; 6700

; ----------------------------------------------------------------------
; DATOS cabecera_13: cabecera del sonido 0x13: canales 0x90, prioridad 0x0B y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6706..0x670c  (6 bytes)
DATA_cabecera_13:
	defb 090h,00bh,099h,078h,0aeh,078h	; 6706

; ----------------------------------------------------------------------
; DATOS cabecera_14: cabecera del sonido 0x14: canales 0x90, prioridad 0x04 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x670c..0x6712  (6 bytes)
DATA_cabecera_14:
	defb 090h,004h,013h,079h,02dh,079h	; 670c

; ----------------------------------------------------------------------
; DATOS cabecera_15: cabecera del sonido 0x15: canales 0x90, prioridad 0x04 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6712..0x6718  (6 bytes)
DATA_cabecera_15:
	defb 090h,004h,059h,079h,062h,079h	; 6712

; ----------------------------------------------------------------------
; DATOS cabecera_16: cabecera del sonido 0x16: canales 0x90, prioridad 0x09 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6718..0x671e  (6 bytes)
DATA_cabecera_16:
	defb 090h,009h,091h,079h,091h,079h	; 6718

; ----------------------------------------------------------------------
; DATOS cabecera_17: cabecera del sonido 0x17: canales 0x90, prioridad 0x09 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x671e..0x6724  (6 bytes)
DATA_cabecera_17:
	defb 090h,009h,0d2h,079h,021h,07ah	; 671e

; ----------------------------------------------------------------------
; DATOS cabecera_18: cabecera del sonido 0x18: canales 0x90, prioridad 0x09 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6724..0x672a  (6 bytes)
DATA_cabecera_18:
	defb 090h,009h,0a8h,07ah,0ach,07ah	; 6724

; ----------------------------------------------------------------------
; DATOS cabecera_19: cabecera del sonido 0x19: canales 0x90, prioridad 0x09 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x672a..0x6730  (6 bytes)
DATA_cabecera_19:
	defb 090h,009h,0f8h,07ch,001h,07dh	; 672a

; ----------------------------------------------------------------------
; DATOS cabecera_1A: cabecera del sonido 0x1A: canales 0x90, prioridad 0x05 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6730..0x6736  (6 bytes)
DATA_cabecera_1A:
	defb 090h,005h,0f2h,07ah,01eh,07bh	; 6730

; ----------------------------------------------------------------------
; DATOS cabecera_1B: cabecera del sonido 0x1B: canales 0x90, prioridad 0x07 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6736..0x673c  (6 bytes)
DATA_cabecera_1B:
	defb 090h,007h,048h,07bh,06ch,07bh	; 6736

; ----------------------------------------------------------------------
; DATOS cabecera_1C: cabecera del sonido 0x1C: canales 0x90, prioridad 0x07 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x673c..0x6742  (6 bytes)
DATA_cabecera_1C:
	defb 090h,007h,0a6h,07bh,0e7h,07bh	; 673c

; ----------------------------------------------------------------------
; DATOS cabecera_1D: cabecera del sonido 0x1D: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6742..0x6748  (6 bytes)
DATA_cabecera_1D:
	defb 090h,00ah,015h,07ch,015h,07ch	; 6742

; ----------------------------------------------------------------------
; DATOS cabecera_1E: cabecera del sonido 0x1E: canales 0x90, prioridad 0x0E y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6748..0x674e  (6 bytes)
DATA_cabecera_1E:
	defb 090h,00eh,05ah,07ch,05ah,07ch	; 6748

; ----------------------------------------------------------------------
; DATOS cabecera_1F: cabecera del sonido 0x1F: canales 0x90, prioridad 0x0C y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x674e..0x6754  (6 bytes)
DATA_cabecera_1F:
	defb 090h,00ch,0a2h,07ch,0c0h,07ch	; 674e

; ----------------------------------------------------------------------
; DATOS cabecera_20: cabecera del sonido 0x20: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6754..0x675a  (6 bytes)
DATA_cabecera_20:
	defb 090h,00ah,06ch,07dh,075h,07dh	; 6754

; ----------------------------------------------------------------------
; DATOS cabecera_21: cabecera del sonido 0x21: canales 0x90, prioridad 0x0B y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x675a..0x6760  (6 bytes)
DATA_cabecera_21:
	defb 090h,00bh,038h,07dh,03ch,07dh	; 675a

; ----------------------------------------------------------------------
; DATOS cabecera_22: cabecera del sonido 0x22: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6760..0x6766  (6 bytes)
DATA_cabecera_22:
	defb 090h,012h,009h,07eh,01bh,07eh	; 6760

; ----------------------------------------------------------------------
; DATOS cabecera_23: cabecera del sonido 0x23: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6766..0x676c  (6 bytes)
DATA_cabecera_23:
	defb 090h,012h,090h,07dh,099h,07dh	; 6766

; ----------------------------------------------------------------------
; DATOS cabecera_24: cabecera del sonido 0x24: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x676c..0x6772  (6 bytes)
DATA_cabecera_24:
	defb 090h,012h,041h,076h,04ch,076h	; 676c

; ----------------------------------------------------------------------
; DATOS cabecera_25: cabecera del sonido 0x25: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6772..0x6778  (6 bytes)
DATA_cabecera_25:
	defb 090h,00ah,06ch,07eh,08eh,07eh	; 6772

; ----------------------------------------------------------------------
; DATOS cabecera_26: cabecera del sonido 0x26: canales 0x90, prioridad 0x0A y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6778..0x677e  (6 bytes)
DATA_cabecera_26:
	defb 090h,00ah,0cfh,07dh,0dah,07dh	; 6778

; ----------------------------------------------------------------------
; DATOS cabecera_27: cabecera del sonido 0x27: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x677e..0x6784  (6 bytes)
DATA_cabecera_27:
	defb 090h,012h,0b8h,07eh,0edh,07eh	; 677e

; ----------------------------------------------------------------------
; DATOS cabecera_28: cabecera del sonido 0x28: canales 0x90, prioridad 0x12 y
;   2 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (6
;   bytes)
;   0x6784..0x678a  (6 bytes)
DATA_cabecera_28:
	defb 090h,012h,024h,07fh,035h,07fh	; 6784

; ----------------------------------------------------------------------
; DATOS cabecera_29: cabecera del sonido 0x29: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x678a..0x6798  (14 bytes)
DATA_cabecera_29:
	defb 06fh,016h,0b0h,0a3h,0eeh,0a3h,06eh,0a4h,0d6h,0a4h,037h,0a5h,09fh,0a5h	; 678a  o.....n...7...

; ----------------------------------------------------------------------
; DATOS cabecera_2A: cabecera del sonido 0x2A: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6798..0x67a6  (14 bytes)
DATA_cabecera_2A:
	defb 06fh,016h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h	; 6798  o.............

; ----------------------------------------------------------------------
; DATOS cabecera_2B: cabecera del sonido 0x2B: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67a6..0x67b4  (14 bytes)
DATA_cabecera_2B:
	defb 06fh,016h,0a6h,084h,0eeh,084h,0c8h,085h,038h,086h,007h,087h,073h,087h	; 67a6  o.......8...s.

; ----------------------------------------------------------------------
; DATOS cabecera_2C: cabecera del sonido 0x2C: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67b4..0x67c2  (14 bytes)
DATA_cabecera_2C:
	defb 06fh,016h,0dch,087h,01fh,088h,0ech,088h,06fh,089h,0f2h,089h,0a4h,08ah	; 67b4  o.......o.....

; ----------------------------------------------------------------------
; DATOS cabecera_2D: cabecera del sonido 0x2D: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67c2..0x67d0  (14 bytes)
DATA_cabecera_2D:
	defb 06fh,016h,0f3h,08bh,051h,08bh,020h,08ch,07bh,08ch,0a8h,08dh,086h,08eh	; 67c2  o...Q. .{.....

; ----------------------------------------------------------------------
; DATOS cabecera_2E: cabecera del sonido 0x2E: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67d0..0x67de  (14 bytes)
DATA_cabecera_2E:
	defb 06fh,016h,061h,08fh,0f2h,08fh,091h,090h,024h,091h,0a2h,091h,058h,092h	; 67d0  o.a.....$...X.

; ----------------------------------------------------------------------
; DATOS cabecera_2F: cabecera del sonido 0x2F: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67de..0x67ec  (14 bytes)
DATA_cabecera_2F:
	defb 06fh,016h,09ch,092h,09ch,092h,09ch,092h,09ch,092h,09ch,092h,09ch,092h	; 67de  o.............

; ----------------------------------------------------------------------
; DATOS cabecera_30: cabecera del sonido 0x30: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67ec..0x67fa  (14 bytes)
DATA_cabecera_30:
	defb 06fh,016h,09dh,092h,0f9h,092h,07ch,093h,094h,094h,088h,095h,011h,096h	; 67ec  o.....|.......

; ----------------------------------------------------------------------
; DATOS cabecera_31: cabecera del sonido 0x31: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x67fa..0x6808  (14 bytes)
DATA_cabecera_31:
	defb 06fh,016h,097h,096h,0ffh,096h,0c8h,097h,03bh,098h,012h,099h,0cdh,099h	; 67fa  o.............

; ----------------------------------------------------------------------
; DATOS cabecera_32: cabecera del sonido 0x32: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6808..0x6816  (14 bytes)
DATA_cabecera_32:
	defb 06fh,016h,065h,09ah,0a5h,09ah,0f8h,09ah,008h,09ch,091h,09ch,028h,09dh	; 6808  o.e.........(.

; ----------------------------------------------------------------------
; DATOS cabecera_33: cabecera del sonido 0x33: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6816..0x6824  (14 bytes)
DATA_cabecera_33:
	defb 06fh,016h,0d1h,09dh,0ddh,09dh,07dh,09eh,053h,09fh,000h,0a0h,06dh,0a0h	; 6816  o.....}.S...m.

; ----------------------------------------------------------------------
; DATOS cabecera_34: cabecera del sonido 0x34: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6824..0x6832  (14 bytes)
DATA_cabecera_34:
	defb 06fh,016h,085h,0a7h,098h,0a7h,0ech,0a7h,01dh,0a8h,0c9h,0a8h,01ch,0a9h	; 6824  o.............

; ----------------------------------------------------------------------
; DATOS cabecera_35: cabecera del sonido 0x35: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6832..0x6840  (14 bytes)
DATA_cabecera_35:
	defb 06fh,016h,08dh,0a6h,0a3h,0a6h,0c4h,0a6h,000h,0a7h,03eh,0a7h,059h,0a7h	; 6832  o.........>.Y.

; ----------------------------------------------------------------------
; DATOS cabecera_36: cabecera del sonido 0x36: canales 0x6F, prioridad 0x16 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x6840..0x684e  (14 bytes)
DATA_cabecera_36:
	defb 06fh,016h,0d4h,0a0h,0f5h,0a0h,094h,0a1h,011h,0a2h,0e1h,0a2h,011h,0a3h	; 6840  o.............

; ----------------------------------------------------------------------
; DATOS cabecera_37: cabecera del sonido 0x37: canales 0xFF, prioridad 0x46 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x684e..0x6860  (18 bytes)
DATA_cabecera_37:
	defb 0ffh,046h,061h,07fh,061h,07fh,061h,07fh,061h,07fh,062h,07fh,076h,07fh,08bh,07fh,098h,07fh	; 684e  .Fa.a.a.a.b.v.....

; ----------------------------------------------------------------------
; DATOS cabecera_38: cabecera del sonido 0x38: canales 0xFF, prioridad 0x46 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6860..0x6872  (18 bytes)
DATA_cabecera_38:
	defb 0ffh,046h,0e1h,07fh,0e1h,07fh,0e1h,07fh,0a3h,07fh,0e2h,07fh,052h,080h,088h,080h,088h,080h	; 6860  .F..........R.....

; ----------------------------------------------------------------------
; DATOS cabecera_39: cabecera del sonido 0x39: canales 0xFF, prioridad 0x46 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6872..0x6884  (18 bytes)
DATA_cabecera_39:
	defb 0ffh,046h,088h,080h,088h,080h,088h,080h,089h,080h,0a3h,080h,0c1h,080h,0cfh,080h,0e8h,080h	; 6872  .F................

; ----------------------------------------------------------------------
; DATOS cabecera_3A: cabecera del sonido 0x3A: canales 0xFF, prioridad 0x3B y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6884..0x6896  (18 bytes)
DATA_cabecera_3A:
	defb 0ffh,03bh,001h,081h,001h,081h,0fah,080h,002h,081h,03bh,081h,04eh,081h,061h,081h,06dh,081h	; 6884  ............N.a.m.

; ----------------------------------------------------------------------
; DATOS cabecera_3B: cabecera del sonido 0x3B: canales 0xFF, prioridad 0x46 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6896..0x68a8  (18 bytes)
DATA_cabecera_3B:
	defb 0ffh,046h,094h,081h,0f7h,081h,001h,082h,002h,082h,090h,082h,0a3h,082h,0adh,082h,0b8h,082h	; 6896  .F................

; ----------------------------------------------------------------------
; DATOS cabecera_3C: cabecera del sonido 0x3C: canales 0xFF, prioridad 0x46 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x68a8..0x68ba  (18 bytes)
DATA_cabecera_3C:
	defb 0ffh,046h,0dch,082h,0dch,082h,0dch,082h,0dch,082h,0e1h,082h,0f7h,082h,00ch,083h,022h,083h	; 68a8  .F..............".

; ----------------------------------------------------------------------
; DATOS cabecera_3D: cabecera del sonido 0x3D: canales 0xFF, prioridad 0x47 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x68ba..0x68cc  (18 bytes)
DATA_cabecera_3D:
	defb 0ffh,047h,01bh,084h,030h,084h,03fh,084h,04eh,084h,063h,084h,07ah,084h,087h,084h,096h,084h	; 68ba  .G..0.?.N.c.z.....

; ----------------------------------------------------------------------
; DATOS cabecera_3E: cabecera del sonido 0x3E: canales 0xFF, prioridad 0x48 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x68cc..0x68de  (18 bytes)
DATA_cabecera_3E:
	defb 0ffh,048h,03fh,0beh,08fh,0beh,0ech,0beh,01dh,0bfh,056h,0bfh,07fh,0bfh,0a9h,0bfh,0c8h,0bfh	; 68cc  .H?.......V.......

; ----------------------------------------------------------------------
; DATOS cabecera_3F: cabecera del sonido 0x3F: canales 0xFF, prioridad 0x48 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x68de..0x68f0  (18 bytes)
DATA_cabecera_3F:
	defb 0ffh,048h,03bh,0b6h,042h,0b5h,0cch,0b6h,053h,0b7h,0d4h,0b7h,0bah,0b8h,03ah,0b9h,0beh,0b9h	; 68de  .H..B...S.....:...

; ----------------------------------------------------------------------
; DATOS cabecera_40: cabecera del sonido 0x40: canales 0x6F, prioridad 0x48 y
;   6 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (14
;   bytes)
;   0x68f0..0x68fe  (14 bytes)
DATA_cabecera_40:
	defb 06fh,048h,0a2h,0aah,02eh,0abh,0dfh,0abh,05ch,0adh,033h,0aeh,0dch,0aeh	; 68f0  oH......\.3...

; ----------------------------------------------------------------------
; DATOS cabecera_41: cabecera del sonido 0x41: canales 0xFF, prioridad 0x48 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x68fe..0x6910  (18 bytes)
DATA_cabecera_41:
	defb 0ffh,048h,09ah,0afh,049h,0b0h,0f9h,0b0h,051h,0b1h,06bh,0b2h,039h,0b3h,01bh,0b4h,0bbh,0b4h	; 68fe  .H..I...Q.k.9.....

; ----------------------------------------------------------------------
; DATOS cabecera_42: cabecera del sonido 0x42: canales 0xFF, prioridad 0x70 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6910..0x6922  (18 bytes)
DATA_cabecera_42:
	defb 0ffh,070h,0fdh,0a9h,005h,0aah,00ah,0aah,019h,0aah,02dh,0aah,03dh,0aah,047h,0aah,051h,0aah	; 6910  .p........-.=.G.Q.

; ----------------------------------------------------------------------
; DATOS cabecera_43: cabecera del sonido 0x43: canales 0xFF, prioridad 0x80 y
;   8 partituras (p04:64B4 copia 18 bytes a 0xE192); lo leen p04:64B4 (18
;   bytes)
;   0x6922..0x6934  (18 bytes)
DATA_cabecera_43:
	defb 0ffh,080h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h,0a4h,084h	; 6922  ..................

; ======================================================================
; CODIGO 0x6934..0x6a32  (254 bytes)
; ======================================================================


L_6934:
	ld a,(0e1a6h)		;6934
	call L_702D		;6937
	ld hl,0e190h		;693a   ; apunta a el estado del sonido (bit 0)
	bit 1,(hl)		;693d
	jp nz,L_6979		;693f
	ld a,(0e190h)		;6942   ; lee el estado del sonido (bit 0)
	bit 0,a		;6945
	call nz,L_6B1C		;6947
	ld ix,0e000h		;694a   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	exx			;694e
	ld de,00028h		;694f
	ld b,008h		;6952
	ld c,001h		;6954
	ld a,c			;6956
L_6957:
	exx			;6957
	ld (0e1a7h),a		;6958
	call L_6969		;695b
	exx			;695e
	add ix,de		;695f
	ld a,c			;6961
	add a,c			;6962
	djnz L_6957		;6963
	call L_6F6A		;6965
	ret			;6968
L_6969:
	ld a,(ix+000h)		;6969
	or a			;696c
	call nz,L_699A		;696d
	ld hl,0e190h		;6970   ; apunta a el estado del sonido (bit 0)
	bit 0,(hl)		;6973
	call nz,L_6B79		;6975
	ret			;6978
L_6979:
	ld a,001h		;6979
	ld (0e1a7h),a		;697b
	ld ix,0e000h		;697e   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call L_6969		;6982
	ld a,002h		;6985
	ld (0e1a7h),a		;6987
	ld ix,0e028h		;698a
	call L_6969		;698e
	ld a,0bch		;6991
	ld (0e1a6h),a		;6993
	call L_6F71		;6996
	ret			;6999
L_699A:
	dec (ix+004h)		;699a
	jp nz,L_6BFA		;699d
	ld l,(ix+002h)		;69a0
	ld h,(ix+003h)		;69a3
L_69A6:
	ld a,(hl)			;69a6
	cp 0ffh		;69a7
	jp z,L_6AE3		;69a9
	cp 0d0h		;69ac
	jr c,L_69B7		;69ae
	call L_6D12		;69b0
	inc hl			;69b3
	jp L_69A6		;69b4
L_69B7:
	bit 0,(ix+009h)		;69b7
	call nz,L_69CD		;69bb
	bit 1,(ix+009h)		;69be
	call nz,L_6A3F		;69c2
	bit 2,(ix+009h)		;69c5
	call nz,L_6AAA		;69c9
	ret			;69cc
L_69CD:
	ld a,(hl)			;69cd
	and 00fh		;69ce
	ld b,a			;69d0
	ld a,(ix+014h)		;69d1
	jr z,L_69DA		;69d4
	ld e,a			;69d6
L_69D7:
	add a,e			;69d7
	djnz L_69D7		;69d8
L_69DA:
	ld (ix+004h),a		;69da
	ld a,(hl)			;69dd
	and 0f0h		;69de
	rrca			;69e0
	rrca			;69e1
	rrca			;69e2
	rrca			;69e3
	call L_6ADB		;69e4
	bit 3,(ix+009h)		;69e7
	ret nz			;69eb
	cp 00ch		;69ec
	jr nc,L_6A2D		;69ee
	ld hl,06a32h		;69f0
	ld e,a			;69f3
	ld d,000h		;69f4
	add hl,de			;69f6
	ld l,(hl)			;69f7
	ld h,000h		;69f8
	ld a,(ix+016h)		;69fa
	or a			;69fd
	jr z,L_6A04		;69fe
	ld b,a			;6a00
L_6A01:
	add hl,hl			;6a01
	djnz L_6A01		;6a02
L_6A04:
	ld (ix+010h),l		;6a04
	ld (ix+011h),h		;6a07
	ld e,(ix+015h)		;6a0a
	ld a,(0e190h)		;6a0d   ; lee el estado del sonido (bit 0)
	bit 0,a		;6a10
	call nz,L_6A20		;6a12
	ld (ix+012h),e		;6a15
	ld (ix+00dh),002h		;6a18
	call L_6BAB		;6a1c
	ret			;6a1f
L_6A20:
	ld a,(0e1a5h)		;6a20
	ld d,a			;6a23
	ld a,e			;6a24
	sub d			;6a25
	ld e,a			;6a26
	cp 008h		;6a27
	ret nc			;6a29
	ld e,009h		;6a2a
	ret			;6a2c
L_6A2D:
	ld (ix+00dh),000h		;6a2d
	ret			;6a31

; ----------------------------------------------------------------------
; DATOS notas_psg: 13 bytes: el divisor de cada nota (de do a do) que p04:69F0
;   lee con el indice < 12; el 13 no lo lee nadie; lo leen p04:69F0 (13 bytes)
;   0x6a32..0x6a3f  (13 bytes)
DATA_notas_psg:
	defb 06ah,064h,05eh,059h,054h,04fh,04ah,046h,042h,03fh,03bh,038h,035h	; 6a32  jd^YTOJFB?.85

; ======================================================================
; CODIGO 0x6a3f..0x6d27  (744 bytes)
; ======================================================================


L_6A3F:
	ld a,(ix+00dh)		;6a3f
	and 003h		;6a42
	jr z,L_6A9B		;6a44
	cp 001h		;6a46
	jr z,L_6A80		;6a48
	ld a,(hl)			;6a4a
	bit 7,(ix+00eh)		;6a4b
	jr nz,L_6A6C		;6a4f
	bit 5,(ix+00eh)		;6a51
	jr nz,L_6A71		;6a55
	and 0f0h		;6a57
	ld b,a			;6a59
	xor (hl)			;6a5a
	ld d,a			;6a5b
	inc hl			;6a5c
	ld a,(hl)			;6a5d
	ld (ix+010h),a		;6a5e
	ld (ix+011h),d		;6a61
	ld a,b			;6a64
	rrca			;6a65
	rrca			;6a66
	rrca			;6a67
	rrca			;6a68
	ld b,a			;6a69
	jr L_6A84		;6a6a
L_6A6C:
	ld (ix+010h),a		;6a6c
	jr L_6A98		;6a6f
L_6A71:
	and 0f0h		;6a71
	rrca			;6a73
	rrca			;6a74
	rrca			;6a75
	rrca			;6a76
	ld b,a			;6a77
	ld a,(hl)			;6a78
	and 00fh		;6a79
	ld (ix+011h),a		;6a7b
	jr L_6A84		;6a7e
L_6A80:
	ld a,(hl)			;6a80
	and 00fh		;6a81
	ld b,a			;6a83
L_6A84:
	ld a,(0e1a7h)		;6a84
	cp 008h		;6a87
	jr nc,L_6A93		;6a89
	bit 2,(ix+00dh)		;6a8b
	jr z,L_6A93		;6a8f
	ld b,010h		;6a91
L_6A93:
	inc b			;6a93
	inc b			;6a94
	ld (ix+012h),b		;6a95
L_6A98:
	call L_6BAB		;6a98
L_6A9B:
	bit 3,(ix+009h)		;6a9b
	ret nz			;6a9f
	call L_6ADB		;6aa0
	ld a,(ix+013h)		;6aa3
	ld (ix+004h),a		;6aa6
	ret			;6aa9
L_6AAA:
	ld (ix+009h),009h		;6aaa
	call L_69CD		;6aae
	ld hl,07255h		;6ab1
	add a,a			;6ab4
	ld e,a			;6ab5
	ld d,000h		;6ab6
	add hl,de			;6ab8
	ld e,(hl)			;6ab9
	inc hl			;6aba
	ld d,(hl)			;6abb
	ex de,hl			;6abc
	ld a,(hl)			;6abd
	set 0,(ix+00eh)		;6abe
L_6AC2:
	ld (ix+009h),00ah		;6ac2
	call L_69A6		;6ac6
	ld a,(ix+013h)		;6ac9
	ld (ix+019h),a		;6acc
	inc hl			;6acf
	ld (ix+017h),l		;6ad0
	ld (ix+018h),h		;6ad3
	ld (ix+009h),004h		;6ad6
	ret			;6ada
L_6ADB:
	inc hl			;6adb
	ld (ix+002h),l		;6adc
	ld (ix+003h),h		;6adf
	ret			;6ae2
L_6AE3:
	xor a			;6ae3
	ld (ix+000h),a		;6ae4
	ld (ix+001h),a		;6ae7
	ld (ix+005h),a		;6aea
	ld (ix+006h),a		;6aed
	ld (ix+00ah),a		;6af0
	ld (ix+00bh),a		;6af3
	ld (ix+00ch),a		;6af6
	ld (ix+00dh),a		;6af9
	ld (ix+00eh),a		;6afc
	ld (ix+00fh),a		;6aff
	ld a,(0e1a7h)		;6b02
	cp 008h		;6b05
	ret nc			;6b07
	cp 001h		;6b08
	ld hl,0e1aah		;6b0a
	jr nz,L_6B19		;6b0d
	res 1,(hl)		;6b0f
	bit 3,(hl)		;6b11
	ret z			;6b13
	res 3,(hl)		;6b14
	set 2,(hl)		;6b16
	ret			;6b18
L_6B19:
	res 3,(hl)		;6b19
	ret			;6b1b
L_6B1C:
	ld hl,0e1a4h		;6b1c
	inc (hl)			;6b1f
	ld a,(0e0a0h)		;6b20   ; lee la musica que suena
	ld a,(hl)			;6b23
	cp 060h		;6b24
	ret nz			;6b26
	ld (hl),000h		;6b27
	inc hl			;6b29
	inc (hl)			;6b2a
	ld a,(hl)			;6b2b
	cp 002h		;6b2c
	ret nz			;6b2e
	xor a			;6b2f
	ld hl,0e190h		;6b30   ; apunta a el estado del sonido (bit 0)
	res 0,(hl)		;6b33
	ld hl,0e1a4h		;6b35
	ld (hl),a			;6b38
	inc hl			;6b39
	ld (hl),a			;6b3a
	ld a,(0e000h)		;6b3b   ; lee la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	ld e,a			;6b3e
	ld a,(0e028h)		;6b3f
	cp e			;6b42
	jr nz,L_6B53		;6b43
	ld ix,0e000h		;6b45   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call L_6AE3		;6b49
	ld ix,0e078h		;6b4c
	call L_6AE3		;6b50
L_6B53:
	ld de,00028h		;6b53
	ld ix,0e028h		;6b56
	call L_6AE3		;6b5a
	add ix,de		;6b5d
	call L_6AE3		;6b5f
	ld ix,0e0a0h		;6b62   ; apunta a la musica que suena
	call L_6AE3		;6b66
	add ix,de		;6b69
	call L_6AE3		;6b6b
	add ix,de		;6b6e
	call L_6AE3		;6b70
	add ix,de		;6b73
	call L_6AE3		;6b75
	ret			;6b78
L_6B79:
	ld a,(0e000h)		;6b79   ; lee la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	ld e,a			;6b7c
	ld a,(0e028h)		;6b7d
	cp e			;6b80
	jr z,L_6B8E		;6b81
	ld a,(0e1a7h)		;6b83
	and 0f6h		;6b86
	ret z			;6b88
	bit 1,(ix+009h)		;6b89
	ret nz			;6b8d
L_6B8E:
	bit 2,(ix+00dh)		;6b8e
	jr nz,L_6BA6		;6b92
	bit 4,(ix+00fh)		;6b94
	ret nz			;6b98
	ld a,(0e1a5h)		;6b99
	ld e,a			;6b9c
	ld a,(ix+00ch)		;6b9d
	sub e			;6ba0
	ret m			;6ba1
	ld (ix+00ch),a		;6ba2
	ret			;6ba5
L_6BA6:
	ld (ix+00ch),000h		;6ba6
	ret			;6baa
L_6BAB:
	call L_6C2C		;6bab
	res 4,(ix+00eh)		;6bae
	ld a,(ix+00fh)		;6bb2
	and 0e7h		;6bb5
	ld (ix+00fh),a		;6bb7
	xor a			;6bba
	ld (ix+01dh),a		;6bbb
	ld (ix+01eh),a		;6bbe
	ld (ix+01fh),a		;6bc1
	ld (ix+020h),a		;6bc4
	set 2,(ix+00fh)		;6bc7
	ld a,(ix+012h)		;6bcb
	bit 6,(ix+00eh)		;6bce
	jr z,L_6BDB		;6bd2
	ld e,(ix+015h)		;6bd4
	sub e			;6bd7
	call m,L_6BF8		;6bd8
L_6BDB:
	ld (ix+00ch),a		;6bdb
	ld a,(0e1a7h)		;6bde
	cp 008h		;6be1
	jr nc,L_6BEA		;6be3
	bit 2,(ix+00dh)		;6be5
	ret nz			;6be9
L_6BEA:
	bit 1,(ix+00fh)		;6bea
	ret z			;6bee
	ld (ix+00ch),008h		;6bef
	res 2,(ix+00fh)		;6bf3
	ret			;6bf7
L_6BF8:
	xor a			;6bf8
	ret			;6bf9
L_6BFA:
	bit 0,(ix+00eh)		;6bfa
	call nz,L_6C10		;6bfe
	bit 2,(ix+00eh)		;6c01
	call nz,L_6C47		;6c05
	bit 0,(ix+00fh)		;6c08
	call nz,L_6C95		;6c0c
	ret			;6c0f
L_6C10:
	dec (ix+019h)		;6c10
	ret nz			;6c13
	ld l,(ix+017h)		;6c14
	ld h,(ix+018h)		;6c17
	ld a,(hl)			;6c1a
	cp 0ffh		;6c1b
	jr z,L_6C23		;6c1d
	call L_6AC2		;6c1f
	ret			;6c22
L_6C23:
	res 0,(ix+00eh)		;6c23
	ld (ix+00dh),000h		;6c27
	ret			;6c2b
L_6C2C:
	ld e,(ix+010h)		;6c2c
	ld d,(ix+011h)		;6c2f
	bit 1,(ix+00eh)		;6c32
	jr z,L_6C40		;6c36
	ld a,(ix+025h)		;6c38
	add a,e			;6c3b
	ld e,a			;6c3c
	jr nc,L_6C40		;6c3d
	inc d			;6c3f
L_6C40:
	ld (ix+00ah),e		;6c40
	ld (ix+00bh),d		;6c43
	ret			;6c46
L_6C47:
	inc (ix+01eh)		;6c47
	ld a,(ix+01eh)		;6c4a
	ld b,(ix+00eh)		;6c4d
	bit 4,b		;6c50
	jr nz,L_6C66		;6c52
	bit 3,b		;6c54
	jr z,L_6C66		;6c56
	cp (ix+01ah)		;6c58
	ret nz			;6c5b
	ld (ix+01eh),000h		;6c5c
	set 4,(ix+00eh)		;6c60
	jr L_6C6A		;6c64
L_6C66:
	cp (ix+01bh)		;6c66
	ret nz			;6c69
L_6C6A:
	ld e,(ix+00ah)		;6c6a
	ld d,(ix+00bh)		;6c6d
	ld b,(ix+01ch)		;6c70
	ld a,(ix+01dh)		;6c73
	cpl			;6c76
	ld (ix+01dh),a		;6c77
	and a			;6c7a
	ld a,e			;6c7b
	jr nz,L_6C85		;6c7c
	add a,b			;6c7e
	ld e,a			;6c7f
	jr nc,L_6C8A		;6c80
	inc d			;6c82
	jr L_6C8A		;6c83
L_6C85:
	sub b			;6c85
	ld e,a			;6c86
	jr nc,L_6C8A		;6c87
	dec d			;6c89
L_6C8A:
	ld (ix+00ah),e		;6c8a
	ld (ix+00bh),d		;6c8d
	ld (ix+01eh),000h		;6c90
	ret			;6c94
L_6C95:
	ld a,(0e1a7h)		;6c95
	cp 008h		;6c98
	jr nc,L_6CA1		;6c9a
	bit 2,(ix+00dh)		;6c9c
	ret nz			;6ca0
L_6CA1:
	call L_6CA8		;6ca1
	ld (ix+00ch),e		;6ca4
	ret			;6ca7
L_6CA8:
	ld e,(ix+00ch)		;6ca8
	inc (ix+01fh)		;6cab
	ld b,(ix+01fh)		;6cae
	bit 4,(ix+00fh)		;6cb1
	jr nz,L_6D06		;6cb5
	bit 3,(ix+00fh)		;6cb7
	jr nz,L_6CEA		;6cbb
	bit 2,(ix+00fh)		;6cbd
	jr nz,L_6CD6		;6cc1
	ld a,e			;6cc3
	inc a			;6cc4
	ld e,a			;6cc5
	cp (ix+012h)		;6cc6
	ret c			;6cc9
	set 2,(ix+00fh)		;6cca
	ld e,(ix+012h)		;6cce
	ld (ix+01fh),000h		;6cd1
	ret			;6cd5
L_6CD6:
	ld a,e			;6cd6
	dec a			;6cd7
	jp m,L_6CDC		;6cd8
	ld e,a			;6cdb
L_6CDC:
	ld a,b			;6cdc
	cp (ix+021h)		;6cdd
	ret c			;6ce0
	ld (ix+01fh),000h		;6ce1
	set 3,(ix+00fh)		;6ce5
	ret			;6ce9
L_6CEA:
	ld a,b			;6cea
	cp (ix+022h)		;6ceb
	ret nz			;6cee
	ld a,e			;6cef
	dec a			;6cf0
	ret m			;6cf1
	ld e,a			;6cf2
	inc (ix+020h)		;6cf3
	ld a,(ix+020h)		;6cf6
	cp (ix+023h)		;6cf9
	ld (ix+01fh),000h		;6cfc
	ret nz			;6d00
	set 4,(ix+00fh)		;6d01
	ret			;6d05
L_6D06:
	ld a,(ix+004h)		;6d06
	cp (ix+024h)		;6d09
	ret nc			;6d0c
	ld a,e			;6d0d
	dec a			;6d0e
	ret m			;6d0f
	ld e,a			;6d10
	ret			;6d11
L_6D12:
	cp 0e0h		;6d12
	jp c,L_6F55		;6d14
	and 01fh		;6d17
	push hl			;6d19
	ld hl,06d27h		;6d1a
	add a,a			;6d1d
	ld e,a			;6d1e
	ld d,000h		;6d1f
	add hl,de			;6d21
	ld e,(hl)			;6d22
	inc hl			;6d23
	ld d,(hl)			;6d24
	ex de,hl			;6d25
	jp (hl)			;6d26

; ----------------------------------------------------------------------
; DATOS ordenes: 31 destinos, uno por orden de la partitura de 0xE0 a 0xFE
;   (p04:6D12: HL = 0x6D27 + 2 x (orden & 0x1F); jp (hl) en p04:6D26); el 0xFF
;   no llega aqui (lo mira antes p04:69A7); lo leen p04:6D26 (62 bytes)
;   0x6d27..0x6d65  (62 bytes)
DATA_ordenes:
	defw 06d65h,06d7bh,06d65h,06d7bh,06d98h,06dc2h,06dd5h,06de4h	; 6d27
	defw 06df6h,06e05h,06e0ch,06e13h,06e30h,06e36h,06e7bh,06e81h	; 6d37
	defw 06e8ch,06e92h,06eadh,06eb7h,06ec6h,06ecch,06ed2h,06edch	; 6d47
	defw 06ee2h,06efch,06f07h,06f0fh,06f29h,06f3eh,06f41h	; 6d57

; ======================================================================
; CODIGO 0x6d65..0x703e  (729 bytes)
; ======================================================================


L_6D65:
	pop hl			;6d65
L_6D66:
	res 7,(ix+00eh)		;6d66
	ld a,(hl)			;6d6a
	and 003h		;6d6b
	ld (ix+00dh),a		;6d6d
	ld b,a			;6d70
	inc hl			;6d71
	ld a,(hl)			;6d72
	ld (ix+013h),a		;6d73
	ld a,b			;6d76
	or a			;6d77
	ret nz			;6d78
	dec hl			;6d79
	ret			;6d7a
L_6D7B:
	pop hl			;6d7b
	ld a,(0e1a7h)		;6d7c
	cp 001h		;6d7f
	ld a,(0e1aah)		;6d81
	jr nz,L_6D8F		;6d84
	set 0,a		;6d86
	res 1,a		;6d88
	ld (0e1aah),a		;6d8a
	jr L_6D66		;6d8d
L_6D8F:
	set 2,a		;6d8f
	res 3,a		;6d91
	ld (0e1aah),a		;6d93
	jr L_6D66		;6d96
L_6D98:
	pop hl			;6d98
	inc hl			;6d99
	ld a,(hl)			;6d9a
	and 01fh		;6d9b
	ld b,a			;6d9d
	ld a,(0e1a7h)		;6d9e
	cp 001h		;6da1
	ld a,b			;6da3
	jr nz,L_6DB4		;6da4
	ld (0e1a8h),a		;6da6
	ld a,(0e1aah)		;6da9
	set 0,a		;6dac
	res 1,a		;6dae
	ld (0e1aah),a		;6db0
	ret			;6db3
L_6DB4:
	ld (0e1a9h),a		;6db4
	ld a,(0e1aah)		;6db7
	set 2,a		;6dba
	res 3,a		;6dbc
	ld (0e1aah),a		;6dbe
	ret			;6dc1
L_6DC2:
	pop hl			;6dc2
	inc hl			;6dc3
	res 3,(ix+00dh)		;6dc4
	ld a,(hl)			;6dc8
	ld (0e1abh),a		;6dc9
	ld de,0e1aah		;6dcc
	ld a,(de)			;6dcf
	set 5,a		;6dd0
	ld (de),a			;6dd2
	jr L_6DD6		;6dd3
L_6DD5:
	pop hl			;6dd5
L_6DD6:
	inc hl			;6dd6
	ld a,(hl)			;6dd7
	ld (0e1adh),a		;6dd8
	ld de,0e1aah		;6ddb
	ld a,(de)			;6dde
	set 6,a		;6ddf
	ld (de),a			;6de1
	jr L_6DE5		;6de2
L_6DE4:
	pop hl			;6de4
L_6DE5:
	inc hl			;6de5
	ld a,(hl)			;6de6
	ld (0e1ach),a		;6de7
	ld de,0e1aah		;6dea
	ld a,(de)			;6ded
	set 7,a		;6dee
	ld (de),a			;6df0
	set 2,(ix+00dh)		;6df1
	ret			;6df5
L_6DF6:
	pop hl			;6df6
	ld de,0e1aah		;6df7
	xor a			;6dfa
	ld (de),a			;6dfb
	ld a,(ix+00dh)		;6dfc
	and 0f3h		;6dff
	ld (ix+00dh),a		;6e01
	ret			;6e04
L_6E05:
	pop hl			;6e05
	inc hl			;6e06
	ld a,(hl)			;6e07
	ld (ix+014h),a		;6e08
	ret			;6e0b
L_6E0C:
	pop hl			;6e0c
	inc hl			;6e0d
	ld a,(hl)			;6e0e
	ld (ix+015h),a		;6e0f
	ret			;6e12
L_6E13:
	pop hl			;6e13
	inc hl			;6e14
	ld a,(ix+005h)		;6e15
	inc a			;6e18
	cp (hl)			;6e19
	jr z,L_6E2A		;6e1a
	ld (ix+005h),a		;6e1c
	inc hl			;6e1f
	ld a,(hl)			;6e20
	ld e,a			;6e21
	ld a,l			;6e22
	sub e			;6e23
	ld l,a			;6e24
	jr nc,L_6E28		;6e25
	dec h			;6e27
L_6E28:
	dec hl			;6e28
	ret			;6e29
L_6E2A:
	inc hl			;6e2a
	ld (ix+005h),000h		;6e2b
	ret			;6e2f
L_6E30:
	pop hl			;6e30
	res 6,(ix+00eh)		;6e31
	ret			;6e35
L_6E36:
	pop hl			;6e36
	inc hl			;6e37
	ld a,(ix+00fh)		;6e38
	and 080h		;6e3b
	ld (ix+00fh),a		;6e3d
	ld a,(hl)			;6e40
	and 0f0h		;6e41
	rrca			;6e43
	rrca			;6e44
	rrca			;6e45
	rrca			;6e46
	cp 008h		;6e47
	jr nc,L_6E4F		;6e49
	set 2,(ix+00fh)		;6e4b
L_6E4F:
	res 3,a		;6e4f
	inc a			;6e51
	bit 2,(ix+00fh)		;6e52
	jr nz,L_6E5C		;6e56
	set 1,(ix+00fh)		;6e58
L_6E5C:
	ld (ix+021h),a		;6e5c
	ld a,(hl)			;6e5f
	and 00fh		;6e60
	ld (ix+022h),a		;6e62
	inc hl			;6e65
	ld a,(hl)			;6e66
	and 0f0h		;6e67
	rrca			;6e69
	rrca			;6e6a
	rrca			;6e6b
	rrca			;6e6c
	ld (ix+023h),a		;6e6d
	ld a,(hl)			;6e70
	and 00fh		;6e71
	ld (ix+024h),a		;6e73
	set 0,(ix+00fh)		;6e76
	ret			;6e7a
L_6E7B:
	pop hl			;6e7b
	res 0,(ix+00fh)		;6e7c
	ret			;6e80
L_6E81:
	pop hl			;6e81
	inc hl			;6e82
	ld a,(hl)			;6e83
	ld (ix+025h),a		;6e84
	set 1,(ix+00eh)		;6e87
	ret			;6e8b
L_6E8C:
	pop hl			;6e8c
	res 1,(ix+00eh)		;6e8d
	ret			;6e91
L_6E92:
	pop hl			;6e92
	inc hl			;6e93
	ld a,(ix+00eh)		;6e94
	or 014h		;6e97
	ld (ix+00eh),a		;6e99
	ld a,(hl)			;6e9c
	and 00fh		;6e9d
	ld (ix+01ch),a		;6e9f
	ld a,(hl)			;6ea2
	and 0f0h		;6ea3
	rrca			;6ea5
	rrca			;6ea6
	rrca			;6ea7
	rrca			;6ea8
	ld (ix+01bh),a		;6ea9
	ret			;6eac
L_6EAD:
	pop hl			;6ead
	ld a,(ix+00eh)		;6eae
	and 0e2h		;6eb1
	ld (ix+00eh),a		;6eb3
	ret			;6eb6
L_6EB7:
	pop hl			;6eb7
	inc hl			;6eb8
	ld a,(hl)			;6eb9
	ld (ix+01ah),a		;6eba
	ld a,(ix+00eh)		;6ebd
	or 00ch		;6ec0
	ld (ix+00eh),a		;6ec2
	ret			;6ec5
L_6EC6:
	pop hl			;6ec6
	res 3,(ix+00eh)		;6ec7
	ret			;6ecb
L_6ECC:
	pop hl			;6ecc
	set 7,(ix+00eh)		;6ecd
	ret			;6ed1
L_6ED2:
	pop hl			;6ed2
	ld a,(ix+00eh)		;6ed3
	and 05fh		;6ed6
	ld (ix+00eh),a		;6ed8
	ret			;6edb
L_6EDC:
	pop hl			;6edc
	set 5,(ix+00eh)		;6edd
	ret			;6ee1
L_6EE2:
	pop hl			;6ee2
	inc hl			;6ee3
	ld a,(hl)			;6ee4
	ld de,06000h		;6ee5
	add a,a			;6ee8
	add a,e			;6ee9
	ld e,a			;6eea
	jr nc,L_6EEE		;6eeb
	inc d			;6eed
L_6EEE:
	ld a,(de)			;6eee
	ld (ix+026h),a		;6eef
	inc de			;6ef2
	ld a,(de)			;6ef3
	ld (ix+027h),a		;6ef4
	set 7,(ix+00fh)		;6ef7
	ret			;6efb
L_6EFC:
	pop hl			;6efc
	call L_6F1B		;6efd
	ld (ix+007h),e		;6f00
	ld (ix+008h),d		;6f03
	ret			;6f06
L_6F07:
	pop hl			;6f07
	ld l,(ix+007h)		;6f08
	ld h,(ix+008h)		;6f0b
	ret			;6f0e
L_6F0F:
	pop hl			;6f0f
	inc hl			;6f10
	ld a,(ix+005h)		;6f11
	inc a			;6f14
	cp (hl)			;6f15
	jr z,L_6F22		;6f16
	ld (ix+005h),a		;6f18
L_6F1B:
	inc hl			;6f1b
	ld e,(hl)			;6f1c
	inc hl			;6f1d
	ld d,(hl)			;6f1e
	ex de,hl			;6f1f
	dec hl			;6f20
	ret			;6f21
L_6F22:
	inc hl			;6f22
	inc hl			;6f23
	ld (ix+005h),000h		;6f24
	ret			;6f28
L_6F29:
	pop hl			;6f29
	inc hl			;6f2a
	ld a,(ix+006h)		;6f2b
	inc a			;6f2e
	cp (hl)			;6f2f
	jr z,L_6F37		;6f30
	ld (ix+006h),a		;6f32
	jr L_6F1B		;6f35
L_6F37:
	inc hl			;6f37
	inc hl			;6f38
	ld (ix+006h),000h		;6f39
	ret			;6f3d
L_6F3E:
	pop hl			;6f3e
	jr L_6F1B		;6f3f
L_6F41:
	pop hl			;6f41
	inc hl			;6f42
	ld a,(hl)			;6f43
	ld (ix+009h),a		;6f44
	cp 004h		;6f47
	ret nz			;6f49
	xor a			;6f4a
	ld (ix+00dh),a		;6f4b
	ld (ix+00eh),a		;6f4e
	ld (ix+00fh),a		;6f51
	ret			;6f54
L_6F55:
	ld a,(hl)			;6f55
	and 00fh		;6f56
	cp 006h		;6f58
	jr nc,L_6F60		;6f5a
	ld (ix+016h),a		;6f5c
	ret			;6f5f
L_6F60:
	set 6,(ix+00eh)		;6f60
	sub 005h		;6f64
	ld (ix+015h),a		;6f66
	ret			;6f69
L_6F6A:
	call L_6F71		;6f6a
	call L_704A		;6f6d
	ret			;6f70
L_6F71:
	call L_6F7E		;6f71
	call L_6FB3		;6f74
	call L_6FDC		;6f77
	call L_700A		;6f7a
	ret			;6f7d
L_6F7E:
	ld b,000h		;6f7e
	ld c,008h		;6f80
	ld hl,0e00ah		;6f82
	call L_6F95		;6f85
	ld hl,0e032h		;6f88
	call L_6F95		;6f8b
	ld hl,0e05ah		;6f8e
	call L_6F95		;6f91
	ret			;6f94
L_6F95:
	ld e,(hl)			;6f95
	ld a,b			;6f96
	call 00093h		;6f97   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6f9a
	inc b			;6f9b
	ld e,(hl)			;6f9c
	ld a,b			;6f9d
	call 00093h		;6f9e   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6fa1
	ld e,(hl)			;6fa2
	ld a,c			;6fa3
	inc b			;6fa4
	inc c			;6fa5
	inc hl			;6fa6
	bit 3,(hl)		;6fa7
	ret nz			;6fa9
	call 00093h		;6faa   ; BIOS WRTPSG - Writes data to PSG-register
	bit 2,(hl)		;6fad
	ret z			;6faf
	set 3,(hl)		;6fb0
	ret			;6fb2
L_6FB3:
	ld hl,0e1aah		;6fb3
	bit 0,(hl)		;6fb6
	jr z,L_6FC8		;6fb8
	res 0,(hl)		;6fba
	set 1,(hl)		;6fbc
	ld a,(0e1a8h)		;6fbe
	ld e,a			;6fc1
	ld a,006h		;6fc2
	call 00093h		;6fc4   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6fc7
L_6FC8:
	bit 1,(hl)		;6fc8
	ret nz			;6fca
	bit 2,(hl)		;6fcb
	ret z			;6fcd
	res 2,(hl)		;6fce
	set 3,(hl)		;6fd0
	ld a,(0e1a9h)		;6fd2
	ld e,a			;6fd5
	ld a,006h		;6fd6
	call 00093h		;6fd8   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6fdb
L_6FDC:
	ld hl,0e1aah		;6fdc
	bit 7,(hl)		;6fdf
	ret z			;6fe1
	res 7,(hl)		;6fe2
	ld a,(0e1ach)		;6fe4
	ld e,a			;6fe7
	ld a,00bh		;6fe8
	call 00093h		;6fea   ; BIOS WRTPSG - Writes data to PSG-register
	bit 6,(hl)		;6fed
	ret z			;6fef
	res 6,(hl)		;6ff0
	ld a,(0e1adh)		;6ff2
	ld e,a			;6ff5
	ld a,00ch		;6ff6
	call 00093h		;6ff8   ; BIOS WRTPSG - Writes data to PSG-register
	bit 5,(hl)		;6ffb
	ret z			;6ffd
	res 5,(hl)		;6ffe
	ld a,(0e1abh)		;7000
	ld e,a			;7003
	ld a,00dh		;7004
	call 00093h		;7006   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;7009
L_700A:
	ld hl,0e00dh		;700a
	ld a,(hl)			;700d
	ld hl,0703eh		;700e
	call L_7037		;7011
	ld b,(hl)			;7014
	ld hl,0e035h		;7015
	ld a,(hl)			;7018
	ld hl,07042h		;7019
	call L_7037		;701c
	ld c,(hl)			;701f
	ld hl,0e05dh		;7020
	ld a,(hl)			;7023
	ld hl,07046h		;7024
	call L_7037		;7027
	ld a,(hl)			;702a
	or b			;702b
	or c			;702c
L_702D:
	ld e,a			;702d
	ld (0e1a6h),a		;702e
	ld a,007h		;7031
	call 00093h		;7033   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;7036
L_7037:
	and 003h		;7037
	ld e,a			;7039
	ld d,000h		;703a
	add hl,de			;703c
	ret			;703d

; ----------------------------------------------------------------------
; DATOS mezclador: tres tablas de 4 bytes, una por canal del PSG, con los bits
;   del registro 7 (tono/ruido) segun el modo; p04:700E/7019/7024 + IX+0D & 3;
;   lo leen p04:7037 (12 bytes)
;   0x703e..0x704a  (12 bytes)
DATA_mezclador:
	defb 089h,081h,088h,080h	; 703e
	defb 092h,082h,090h,080h	; 7042
	defb 0a4h,084h,0a0h,080h	; 7046

; ======================================================================
; CODIGO 0x704a..0x7255  (523 bytes)
; ======================================================================


L_704A:
	call L_7057		;704a
	call L_715C		;704d
	call L_71AE		;7050
	call L_71E2		;7053
	ret			;7056
L_7057:
	ld ix,0e1aeh		;7057
	ld bc,0e1bah		;705b
	ld de,0e1b0h		;705e
	ld hl,0e082h		;7061
	ld a,(de)			;7064
	res 0,(ix+000h)		;7065
	cp (hl)			;7069
	jr z,L_7072		;706a
	set 0,(ix+000h)		;706c
	ld a,(hl)			;7070
	ld (de),a			;7071
L_7072:
	inc de			;7072
	inc hl			;7073
	ld a,(de)			;7074
	res 1,(ix+000h)		;7075
	cp (hl)			;7079
	jr z,L_7082		;707a
	set 1,(ix+000h)		;707c
	ld a,(hl)			;7080
	ld (de),a			;7081
L_7082:
	inc de			;7082
	inc hl			;7083
	res 2,(ix+001h)		;7084
	ld a,(bc)			;7088
	cp (hl)			;7089
	jr z,L_7092		;708a
	set 2,(ix+001h)		;708c
	ld a,(hl)			;7090
	ld (bc),a			;7091
L_7092:
	inc bc			;7092
	ld hl,0e0aah		;7093
	ld a,(de)			;7096
	res 2,(ix+000h)		;7097
	cp (hl)			;709b
	jr z,L_70A4		;709c
	set 2,(ix+000h)		;709e
	ld a,(hl)			;70a2
	ld (de),a			;70a3
L_70A4:
	inc de			;70a4
	inc hl			;70a5
	ld a,(de)			;70a6
	res 3,(ix+000h)		;70a7
	cp (hl)			;70ab
	jr z,L_70B4		;70ac
	set 3,(ix+000h)		;70ae
	ld a,(hl)			;70b2
	ld (de),a			;70b3
L_70B4:
	inc de			;70b4
	inc hl			;70b5
	res 3,(ix+001h)		;70b6
	ld a,(bc)			;70ba
	cp (hl)			;70bb
	jr z,L_70C4		;70bc
	set 3,(ix+001h)		;70be
	ld a,(hl)			;70c2
	ld (bc),a			;70c3
L_70C4:
	inc bc			;70c4
	ld hl,0e0d2h		;70c5
	ld a,(de)			;70c8
	res 4,(ix+000h)		;70c9
	cp (hl)			;70cd
	jr z,L_70D6		;70ce
	set 4,(ix+000h)		;70d0
	ld a,(hl)			;70d4
	ld (de),a			;70d5
L_70D6:
	inc de			;70d6
	inc hl			;70d7
	ld a,(de)			;70d8
	res 5,(ix+000h)		;70d9
	cp (hl)			;70dd
	jr z,L_70E6		;70de
	set 5,(ix+000h)		;70e0
	ld a,(hl)			;70e4
	ld (de),a			;70e5
L_70E6:
	inc de			;70e6
	inc hl			;70e7
	res 4,(ix+001h)		;70e8
	ld a,(bc)			;70ec
	cp (hl)			;70ed
	jr z,L_70F6		;70ee
	set 4,(ix+001h)		;70f0
	ld a,(hl)			;70f4
	ld (bc),a			;70f5
L_70F6:
	inc bc			;70f6
	ld hl,0e0fah		;70f7
	ld a,(de)			;70fa
	res 6,(ix+000h)		;70fb
	cp (hl)			;70ff
	jr z,L_7108		;7100
	set 6,(ix+000h)		;7102
	ld a,(hl)			;7106
	ld (de),a			;7107
L_7108:
	inc de			;7108
	inc hl			;7109
	ld a,(de)			;710a
	res 7,(ix+000h)		;710b
	cp (hl)			;710f
	jr z,L_7118		;7110
	set 7,(ix+000h)		;7112
	ld a,(hl)			;7116
	ld (de),a			;7117
L_7118:
	inc de			;7118
	inc hl			;7119
	res 5,(ix+001h)		;711a
	ld a,(bc)			;711e
	cp (hl)			;711f
	jr z,L_7128		;7120
	set 5,(ix+001h)		;7122
	ld a,(hl)			;7126
	ld (bc),a			;7127
L_7128:
	inc bc			;7128
	ld hl,0e122h		;7129
	ld a,(de)			;712c
	res 0,(ix+001h)		;712d
	cp (hl)			;7131
	jr z,L_713A		;7132
	set 0,(ix+001h)		;7134
	ld a,(hl)			;7138
	ld (de),a			;7139
L_713A:
	inc de			;713a
	inc hl			;713b
	ld a,(de)			;713c
	res 1,(ix+001h)		;713d
	cp (hl)			;7141
	jr z,L_714A		;7142
	set 1,(ix+001h)		;7144
	ld a,(hl)			;7148
	ld (de),a			;7149
L_714A:
	inc de			;714a
	inc hl			;714b
	res 6,(ix+001h)		;714c
	ld a,(bc)			;7150
	cp (hl)			;7151
	jr z,L_715A		;7152
	set 6,(ix+001h)		;7154
	ld a,(hl)			;7158
	ld (bc),a			;7159
L_715A:
	inc bc			;715a
	ret			;715b
L_715C:
	ld e,000h		;715c
	ld hl,0e085h		;715e
	ld c,001h		;7161
	ld a,(hl)			;7163
	or a			;7164
	jr z,L_7168		;7165
	ld a,c			;7167
L_7168:
	or e			;7168
	ld e,a			;7169
	ld hl,0e0adh		;716a
	sla c		;716d
	ld a,(hl)			;716f
	or a			;7170
	jr z,L_7174		;7171
	ld a,c			;7173
L_7174:
	or e			;7174
	ld e,a			;7175
	ld hl,0e0d5h		;7176
	sla c		;7179
	ld a,(hl)			;717b
	or a			;717c
	jr z,L_7180		;717d
	ld a,c			;717f
L_7180:
	or e			;7180
	ld e,a			;7181
	ld hl,0e0fdh		;7182
	sla c		;7185
	ld a,(hl)			;7187
	or a			;7188
	jr z,L_718C		;7189
	ld a,c			;718b
L_718C:
	or e			;718c
	ld e,a			;718d
	ld hl,0e125h		;718e
	sla c		;7191
	ld a,(hl)			;7193
	or a			;7194
	jr z,L_7198		;7195
	ld a,c			;7197
L_7198:
	or e			;7198
	ld e,a			;7199
	ld hl,0e1bfh		;719a
	ld a,(hl)			;719d
	cp e			;719e
	jr z,L_71A8		;719f
	ld (hl),e			;71a1
	ld hl,0e1afh		;71a2
	set 7,(hl)		;71a5
	ret			;71a7
L_71A8:
	ld hl,0e1afh		;71a8
	res 7,(hl)		;71ab
	ret			;71ad
L_71AE:
	ld ix,0e1aeh		;71ae
	ld hl,0e1b0h		;71b2
	ld de,09880h		;71b5
	ld b,010h		;71b8
	ld c,001h		;71ba
L_71BC:
	ld a,(ix+000h)		;71bc
	and c			;71bf
	push bc			;71c0
	call nz,L_71D3		;71c1
	pop bc			;71c4
	inc hl			;71c5
	inc de			;71c6
	rlc c		;71c7
	ld a,b			;71c9
	cp 009h		;71ca
	jr nz,L_71D0		;71cc
	inc ix		;71ce
L_71D0:
	djnz L_71BC		;71d0
	ret			;71d2
L_71D3:
	ld a,(hl)			;71d3
	ld c,a			;71d4
	ld a,03fh		;71d5
	ld (09000h),a		;71d7   ; el mapper: pone en 0x8000 el banco de A
	ld a,c			;71da
	ld (de),a			;71db
	ld a,002h		;71dc
	ld (09000h),a		;71de   ; el mapper: pone en 0x8000 el banco de A
	ret			;71e1
L_71E2:
	ld hl,0e087h		;71e2
	bit 7,(hl)		;71e5
	jr z,L_71F8		;71e7
	res 7,(hl)		;71e9
	ld hl,0e09eh		;71eb
	ld e,(hl)			;71ee
	inc hl			;71ef
	ld d,(hl)			;71f0
	ex de,hl			;71f1
	ld de,09800h		;71f2
	call L_7236		;71f5
L_71F8:
	ld hl,0e0afh		;71f8
	bit 7,(hl)		;71fb
	jr z,L_720E		;71fd
	res 7,(hl)		;71ff
	ld hl,0e0c6h		;7201
	ld e,(hl)			;7204
	inc hl			;7205
	ld d,(hl)			;7206
	ex de,hl			;7207
	ld de,09820h		;7208
	call L_7236		;720b
L_720E:
	ld hl,0e0d7h		;720e
	bit 7,(hl)		;7211
	jr z,L_7224		;7213
	res 7,(hl)		;7215
	ld hl,0e0eeh		;7217
	ld e,(hl)			;721a
	inc hl			;721b
	ld d,(hl)			;721c
	ex de,hl			;721d
	ld de,09840h		;721e
	call L_7236		;7221
L_7224:
	ld hl,0e0ffh		;7224
	bit 7,(hl)		;7227
	ret z			;7229
	res 7,(hl)		;722a
	ld hl,0e116h		;722c
	ld e,(hl)			;722f
	inc hl			;7230
	ld d,(hl)			;7231
	ex de,hl			;7232
	ld de,09860h		;7233
L_7236:
	ld a,03fh		;7236
	ld (09000h),a		;7238   ; el mapper: pone en 0x8000 el banco de A
	xor a			;723b
	ld (0988fh),a		;723c
	ld b,020h		;723f
L_7241:
	ld a,(hl)			;7241
	ld (de),a			;7242
	inc hl			;7243
	inc de			;7244
	djnz L_7241		;7245
	ld hl,0988fh		;7247
	ld de,0e1bfh		;724a
	ld a,(de)			;724d
	ld (hl),a			;724e
	ld a,002h		;724f
	ld (09000h),a		;7251   ; el mapper: pone en 0x8000 el banco de A
	ret			;7254

; ----------------------------------------------------------------------
; DATOS golpes: 10 punteros a los golpes de bateria (p04:6AB1: la cifra alta
;   de la nota en modo 4); van de 0x7269 a 0x72C9. p04:6AAA no mira el indice:
;   las notas 0xB0 (sonido 0x40) y 0xC0 (0x34) leen como puntero los bytes de
;   0x726B y 0x726D, que ya son partitura, y caen en 0x00E4 (la BIOS) y 0xFF07
;   (los ganchos de la RAM); lo leen p04:6AB1 (20 bytes)
;   0x7255..0x7269  (20 bytes)
DATA_golpes:
	defw 07269h,0726fh,0727ch,0728bh,072a0h,072b9h,072b9h,072b9h,072bah,072c9h	; 7255

; ----------------------------------------------------------------------
; DATOS partitura_7269: partitura (p04:699A: ordenes 0xD0-0xFF y notas) de los
;   sonidos 0x01, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E y otros; 28 bytes los leen dos
;   canales con distinto largo de nota (uno con el volumen en modo 0, otro en
;   modo 2: ver 0x7E09 y 0x7E1B, sonido 0x22) (sigue en el banco 5, en
;   0x8000); lo leen p04:69A6 (3479 bytes)
;   0x7269..0x8000  (3479 bytes)
DATA_partitura_7269:
	defb 0e1h,001h,0e4h,000h,007h,0ffh,0e3h,001h,0e4h,000h,08ah,000h,0e1h,004h,006h,005h	; 7269  ................
	defb 004h,003h,0ffh,0e3h,001h,0e4h,006h,081h,0a0h,0e2h,001h,082h,000h,052h,070h,033h	; 7279  .............Rp3
	defb 030h,0ffh,0e1h,001h,0e4h,014h,007h,0e2h,001h,072h,000h,0e1h,002h,0e4h,010h,003h	; 7289  0........r......
	defb 002h,0e1h,001h,0e4h,006h,002h,0ffh,0e2h,001h,0e5h,00ah,000h,042h,0c1h,0b0h,0e8h	; 7299  ............B...
	defb 0e1h,001h,0e4h,008h,008h,007h,006h,005h,004h,003h,002h,002h,001h,001h,000h,0ffh	; 72a9  ................
	defb 0ffh,0e2h,001h,0e5h,009h,003h,000h,093h,0d0h,096h,000h,097h,000h,098h,000h,0ffh	; 72b9  ................
	defb 0e2h,001h,0a1h,080h,0e5h,00ah,000h,0b8h,0e1h,001h,0e4h,004h,007h,005h,004h,003h	; 72c9  ................
	defb 002h,001h,0ffh,0feh,002h,0e0h,001h,0d7h,0f9h,0f3h,072h,0f9h,0feh,072h,0ffh,0feh	; 72d9  ..........r..r..
	defb 002h,0f8h,003h,0f9h,0f3h,072h,0f9h,0feh,072h,0ffh,0e2h,001h,080h,020h,0f5h,028h	; 72e9  .....r..r.... .(
	defb 030h,040h,050h,0f6h,0fah,070h,060h,050h,070h,040h,060h,040h,040h,030h,020h,030h	; 72f9  0@P..p`Pp@`@@0 0
	defb 030h,020h,040h,010h,050h,000h,060h,0fah,0feh,002h,0e0h,001h,0feh,002h,0f8h,015h	; 7309  0 @.P.`.........
	defb 0e2h,001h,080h,030h,090h,040h,080h,050h,080h,060h,080h,070h,0ebh,002h,00eh,080h	; 7319  ...0.@.P.`.p....
	defb 080h,070h,090h,050h,0a0h,040h,0b0h,030h,0c0h,030h,030h,030h,040h,030h,050h,030h	; 7329  .p.P.@.0.000@0P0
	defb 060h,030h,070h,020h,080h,020h,090h,010h,0a0h,010h,0b0h,0ffh,0feh,002h,0e2h,001h	; 7339  `0p . ..........
	defb 000h,000h,070h,050h,070h,058h,0ebh,008h,006h,020h,050h,020h,058h,020h,050h,020h	; 7349  ..pPpX... P X P
	defb 058h,010h,050h,010h,058h,010h,050h,010h,058h,000h,050h,000h,058h,0ebh,004h,006h	; 7359  X.P.X.P.X.P.X...
	defb 0ffh,0feh,002h,0f8h,010h,0e2h,001h,080h,050h,0f5h,058h,0f8h,011h,050h,058h,0f8h	; 7369  ........P.X..PX.
	defb 015h,050h,058h,0f8h,016h,050h,058h,0f8h,002h,050h,058h,0f8h,014h,050h,058h,0f8h	; 7379  .PX..PX..PX..PX.
	defb 012h,050h,058h,050h,058h,0f8h,015h,0f6h,020h,050h,0f5h,058h,0f8h,016h,050h,058h	; 7389  .PXPX... P.X..PX
	defb 0f8h,002h,0f6h,010h,050h,0f5h,058h,0f8h,014h,050h,058h,0f6h,0f8h,012h,000h,050h	; 7399  ....P.X..PX....P
	defb 000h,058h,0ebh,004h,008h,0ffh,0feh,002h,0d8h,0f9h,0beh,073h,0ffh,0feh,002h,0f8h	; 73a9  .X.........s....
	defb 015h,0f9h,0beh,073h,0ffh,0e2h,001h,0b0h,090h,0b1h,000h,0b1h,060h,0b2h,000h,0f7h	; 73b9  ...s........`...
	defb 0b3h,0b5h,0f8h,006h,0b3h,0b2h,0a1h,0f6h,090h,0e0h,080h,0c0h,070h,0a0h,060h,090h	; 73c9  ............p.`.
	defb 050h,080h,040h,070h,030h,060h,0fah,0feh,002h,0e2h,001h,080h,020h,080h,040h,080h	; 73d9  P.@p0`...... .@.
	defb 080h,081h,000h,082h,000h,083h,000h,0a0h,040h,060h,020h,0f9h,00fh,074h,0ffh,0feh	; 73e9  ........@` ..t..
	defb 002h,0f8h,002h,0e2h,001h,080h,040h,080h,080h,081h,000h,0f7h,082h,084h,088h,0f6h	; 73f9  ......@.........
	defb 070h,020h,0f9h,00fh,074h,0ffh,060h,01fh,0e2h,002h,050h,01eh,040h,01dh,030h,01ch	; 7409  p ..t.`...P.@.0.
	defb 020h,01bh,010h,01ah,000h,019h,0fah,0feh,002h,0e0h,002h,0feh,002h,0f8h,01dh,0e2h	; 7419   ...............
	defb 001h,0f9h,051h,074h,0f9h,05ah,074h,0d7h,0f9h,051h,074h,0d7h,0f9h,05ah,074h,0d9h	; 7429  ..Qt.Zt..Qt..Zt.
	defb 0f9h,051h,074h,0d9h,0f9h,05ah,074h,0dah,0f9h,051h,074h,0dah,0f9h,05ah,074h,0ddh	; 7439  .Qt..Zt..Qt..Zt.
	defb 0f9h,051h,074h,0ddh,0f9h,05ah,074h,0ffh,0a0h,040h,0f5h,041h,042h,041h,040h,0f6h	; 7449  .Qt..Zt..@.ABA@.
	defb 0fah,0a0h,01dh,0f5h,01eh,01fh,01eh,01dh,0f6h,0fah,0feh,002h,0e0h,004h,0feh,002h	; 7459  ................
	defb 0f8h,00ch,0e2h,001h,0f9h,08ch,074h,0f9h,095h,074h,0d9h,0f9h,08ch,074h,0d8h,0f9h	; 7469  ......t..t...t..
	defb 095h,074h,0dch,0f9h,08ch,074h,0dah,0f9h,095h,074h,0ddh,0f9h,08ch,074h,0dah,0f9h	; 7479  .t...t...t...t..
	defb 095h,074h,0ffh,090h,020h,0f5h,035h,047h,057h,070h,0f6h,0fah,060h,07eh,060h,083h	; 7489  .t.. .5GWp..`~`.
	defb 050h,050h,050h,030h,040h,026h,000h,000h,000h,000h,0fah,0feh,002h,0e0h,001h,0e2h	; 7499  PPP0@&..........
	defb 001h,061h,080h,061h,0c0h,062h,000h,062h,070h,000h,000h,0ebh,004h,00ch,063h,000h	; 74a9  .a.a.b.bp.....c.
	defb 063h,080h,064h,000h,058h,000h,043h,000h,033h,080h,024h,000h,018h,000h,0ebh,002h	; 74b9  c.d.X.C.3.$.....
	defb 008h,0ffh,0feh,002h,0f8h,01ah,0e2h,001h,0c1h,080h,0c1h,0c0h,0c2h,000h,0c2h,070h	; 74c9  ...............p
	defb 000h,000h,0ebh,003h,00ch,0e2h,002h,0a3h,000h,0a3h,080h,0a4h,000h,0f7h,0a5h,0a6h	; 74d9  ................
	defb 0a8h,0f6h,073h,000h,063h,080h,054h,000h,0f7h,055h,046h,048h,0f6h,0ffh,0feh,002h	; 74e9  ..s.c.T..UFH....
	defb 0e0h,001h,0feh,002h,0f8h,028h,0e2h,001h,0b1h,040h,0b1h,090h,0b1h,0fdh,0b2h,071h	; 74f9  .....(...@.....q
	defb 0b3h,00dh,0b3h,0d0h,0b4h,0c4h,0b5h,0f5h,000h,000h,0ebh,002h,014h,0f9h,02ah,075h	; 7509  ..............*u
	defb 0d6h,0f9h,02ah,075h,0d8h,0f9h,02ah,075h,0dah,0f9h,02ah,075h,0dch,0f9h,02ah,075h	; 7519  ..*u..*u..*u..*u
	defb 0ffh,0b0h,078h,0b0h,0bbh,0b0h,0eah,0b1h,024h,0b1h,06eh,0b1h,0c9h,0b3h,000h,0b4h	; 7529  ..x.....$.n.....
	defb 030h,0b6h,000h,0b8h,000h,0fah,0feh,002h,0e0h,002h,0d8h,0f9h,056h,075h,0f9h,078h	; 7539  0...........Vu.x
	defb 075h,0ffh,0feh,002h,0f8h,015h,0f9h,056h,075h,0f9h,078h,075h,0ffh,0e2h,001h,0c1h	; 7549  u......Vu.xu....
	defb 000h,0f5h,010h,020h,030h,040h,000h,0f6h,0c0h,0f0h,0c0h,0e0h,0c0h,0c0h,0c0h,0b0h	; 7559  ... 0@..........
	defb 0c0h,0e0h,0c0h,0d0h,0f5h,0c0h,0b0h,0a0h,0c0h,0b0h,0a0h,090h,080h,0f6h,0fah,041h	; 7569  ...............A
	defb 000h,040h,0f0h,040h,0e0h,040h,0c0h,040h,0b0h,040h,0e0h,040h,0d0h,040h,0c0h,040h	; 7579  .@.@.@.@.@.@.@.@
	defb 0b0h,030h,0a0h,0f5h,0c0h,0b0h,0a0h,090h,080h,0f6h,0fah,0feh,002h,0e0h,002h,0feh	; 7589  .0..............
	defb 002h,0f8h,017h,0e2h,001h,0b2h,080h,0b2h,000h,0b1h,0a0h,0b1h,060h,0f9h,0bah,075h	; 7599  ............`..u
	defb 0d6h,0f9h,0bah,075h,0d7h,0f9h,0bah,075h,0d8h,0f9h,0bah,075h,0dah,0f9h,0bah,075h	; 75a9  ...u...u...u...u
	defb 0ffh,0b1h,020h,0b0h,0e0h,0f5h,0a0h,070h,050h,030h,028h,020h,018h,010h,0f6h,0fah	; 75b9  .. ....pP0( ....
	defb 0feh,002h,0e2h,003h,0f9h,0e1h,075h,0d6h,0f9h,0e1h,075h,0d7h,0f9h,0e1h,075h,0d8h	; 75c9  ......u...u...u.
	defb 0f9h,0e1h,075h,0d9h,0f9h,0e1h,075h,0ffh,0b2h,000h,0b1h,000h,0b0h,080h,0f5h,040h	; 75d9  ..u...u........@
	defb 020h,0f6h,0fah,0feh,002h,0f8h,004h,0e2h,001h,0b0h,080h,0b0h,0a0h,0b0h,0b0h,0b1h	; 75e9   ...............
	defb 000h,0b1h,080h,0b2h,000h,0b2h,080h,0b3h,000h,0f8h,00ah,0b2h,000h,0b1h,0e0h,0b1h	; 75f9  ................
	defb 0f0h,0f5h,0c0h,0b0h,0a0h,090h,080h,070h,060h,050h,040h,030h,020h,010h,000h,0f6h	; 7609  .......p`P@0 ...
	defb 0b0h,0f4h,0b0h,0f0h,0b0h,0e0h,0b0h,0d0h,0f5h,0c0h,0b0h,0a0h,098h,090h,088h,080h	; 7619  ................
	defb 078h,070h,068h,060h,058h,050h,04ch,048h,044h,040h,03ch,038h,034h,030h,02eh,02ch	; 7629  xph`XPLHD@<840.,
	defb 02ah,028h,026h,024h,022h,020h,0f6h,0ffh,0feh,002h,0e3h,001h,0e4h,00fh,0d7h,0f9h	; 7639  *(&$" ..........
	defb 056h,076h,0ffh,0feh,002h,0f8h,00dh,0e2h,001h,0f9h,056h,076h,0ffh,0b0h,080h,0a0h	; 7649  Vv........Vv....
	defb 040h,090h,080h,070h,020h,0c2h,001h,0c2h,000h,0f7h,0b4h,0b5h,0b6h,0b7h,0b8h,0b9h	; 7659  @..p ...........
	defb 0bah,0abh,0ach,0f6h,0fah,0efh,002h,0feh,001h,0e9h,001h,0eah,00ch,0d1h,0ech,000h	; 7669  ................
	defb 0edh,001h,088h,004h,074h,044h,074h,0edh,001h,023h,0d0h,009h,0ffh,0feh,002h,0e0h	; 7679  ....tDt..#......
	defb 002h,0feh,002h,0f8h,015h,0e2h,001h,060h,058h,060h,060h,080h,069h,0f5h,070h,078h	; 7689  .......`X``.i.px
	defb 080h,070h,078h,080h,088h,090h,080h,0f6h,070h,088h,060h,090h,060h,098h,060h,0a0h	; 7699  .px.....p.`.`.`.
	defb 050h,090h,050h,098h,050h,0a0h,040h,0a8h,040h,0b0h,030h,0b8h,030h,0c0h,020h,0c8h	; 76a9  P.P.P.@.@.0.0. .
	defb 020h,0d0h,010h,0d8h,010h,0e0h,0ffh,0feh,002h,0e2h,001h,0a2h,0f0h,0a2h,0d0h,0f5h	; 76b9   ...............
	defb 0c0h,0b0h,070h,050h,090h,070h,050h,030h,0f6h,0b2h,010h,0b1h,0f0h,0b1h,0e0h,0b1h	; 76c9  ..pP.pP0........
	defb 0d0h,0f5h,0c0h,0b0h,0a0h,090h,080h,0f6h,0ebh,003h,01fh,0f9h,03eh,077h,082h,050h	; 76d9  ............>w.P
	defb 082h,030h,0f9h,04ch,077h,0f9h,055h,077h,0d6h,0f9h,03eh,077h,072h,050h,072h,030h	; 76e9  .0.Lw.Uw..>wrPr0
	defb 0d8h,0f9h,04ch,077h,0dbh,0f9h,055h,077h,0ffh,0feh,002h,0f8h,00ah,0e2h,001h,0c2h	; 76f9  ..Lw..Uw........
	defb 0d0h,0f5h,0c0h,0a0h,080h,060h,040h,020h,0f6h,0c1h,0f0h,0c1h,0e0h,0c1h,0d0h,0c1h	; 7709  .....`@ ........
	defb 0c0h,0c1h,0d0h,0f5h,0c0h,0b0h,0a0h,090h,080h,070h,060h,0f6h,0ebh,003h,021h,0f9h	; 7719  .........p`...!.
	defb 05eh,077h,0f9h,06bh,077h,0f9h,076h,077h,0d8h,0f9h,05eh,077h,0d9h,0f9h,06bh,077h	; 7729  ^w.kw.vw..^w..kw
	defb 0dah,0f9h,076h,077h,0ffh,082h,0f0h,082h,0d0h,082h,0b0h,0f5h,090h,070h,050h,090h	; 7739  ..vw.........pP.
	defb 070h,0f6h,0fah,092h,010h,091h,0f0h,091h,0e0h,091h,0d0h,0fah,091h,0c0h,0f5h,0b0h	; 7749  p...............
	defb 0a0h,090h,080h,0f6h,0fah,0a2h,0d0h,0f5h,0c0h,0a0h,080h,060h,040h,020h,0f6h,0a1h	; 7759  ...........`@ ..
	defb 0f0h,0fah,0a1h,0e0h,0a1h,0d0h,0f5h,0c0h,0b0h,0a0h,090h,0f6h,0fah,0a1h,080h,0f5h	; 7769  ................
	defb 070h,060h,050h,040h,0f6h,0fah,0feh,002h,0e3h,008h,0e4h,000h,090h,040h,0f5h,03fh	; 7779  p`P@.........@.?
	defb 03eh,03dh,03ch,03bh,03ah,039h,038h,0f6h,080h,037h,070h,036h,060h,035h,050h,034h	; 7789  >=<.:98..7p6`5P4
	defb 040h,033h,0ffh,0feh,001h,0f8h,020h,0e9h,001h,0eah,00fh,0d3h,090h,0f9h,0e4h,077h	; 7799  @3.... ........w
	defb 050h,040h,030h,020h,010h,000h,0d3h,0b0h,0f9h,0e4h,077h,030h,020h,010h,000h,0d3h	; 77a9  P@0 ......w0 ...
	defb 0b0h,0d2h,000h,010h,020h,030h,040h,030h,020h,010h,000h,0ebh,004h,00eh,0f9h,0edh	; 77b9  .... 0@0 .......
	defb 077h,0eah,00eh,0f9h,0edh,077h,0eah,00dh,0f9h,0edh,077h,0eah,00bh,0f9h,0edh,077h	; 77c9  w....w....w....w
	defb 0eah,00ah,0f9h,0f6h,077h,0eah,008h,0f9h,0f6h,077h,0ffh,0a0h,0b0h,0d2h,000h,010h	; 77d9  ....w....w......
	defb 020h,030h,040h,0fah,010h,020h,030h,040h,030h,020h,010h,000h,0fah,010h,020h,030h	; 77e9   0@.. 0@0 .... 0
	defb 040h,030h,020h,0fah,0feh,002h,0e2h,001h,0d8h,0f9h,015h,078h,0d6h,0f9h,015h,078h	; 77f9  @0 ........x...x
	defb 0f9h,015h,078h,0d7h,0f9h,015h,078h,0dah,0f9h,015h,078h,0ffh,073h,040h,073h,000h	; 7809  ..x...x...x.s@s.
	defb 092h,0c0h,092h,080h,092h,040h,082h,000h,0fah,0feh,002h,0f8h,006h,0e2h,001h,0d7h	; 7819  .....@..........
	defb 0f9h,038h,078h,0f9h,038h,078h,0d6h,0f9h,038h,078h,0dah,0f9h,038h,078h,0ffh,0b2h	; 7829  .8x.8x..8x..8x..
	defb 000h,0b1h,0d0h,0c1h,0a0h,0c1h,080h,0b1h,060h,0b1h,040h,0fah,0feh,002h,0e2h,001h	; 7839  ........`.@.....
	defb 0d6h,0f9h,085h,078h,071h,000h,0d8h,0f9h,085h,078h,0e1h,003h,0e4h,011h,005h,0e4h	; 7849  ...xq....x......
	defb 015h,006h,0e4h,019h,008h,0e4h,01bh,007h,0e4h,01fh,006h,005h,002h,0ffh,0feh,002h	; 7859  ................
	defb 0f8h,003h,0f9h,085h,078h,0f8h,005h,091h,000h,0f9h,085h,078h,0e2h,001h,0f8h,004h	; 7869  ....x......x....
	defb 081h,000h,0f7h,082h,074h,088h,071h,072h,064h,068h,0f6h,0ffh,0e2h,001h,091h,050h	; 7879  ....t.qrdh.....P
	defb 091h,0a0h,092h,000h,0f5h,040h,080h,0c0h,0f6h,093h,000h,093h,080h,094h,000h,0fah	; 7889  .....@..........
	defb 0feh,002h,0e3h,001h,0e4h,008h,0d8h,0f9h,0c0h,078h,0d9h,0f9h,0cfh,078h,0e3h,002h	; 7899  .........x...x..
	defb 0d9h,0f9h,0e0h,078h,0ffh,0feh,002h,0f8h,022h,0e2h,001h,0f9h,0c0h,078h,0f9h,0cfh	; 78a9  ...x...."....x..
	defb 078h,0e2h,002h,0f9h,0e0h,078h,0ffh,0a1h,000h,0f7h,0a2h,0a3h,094h,095h,096h,087h	; 78b9  x....x..........
	defb 078h,0f6h,0ebh,002h,009h,0fah,0b6h,000h,0b2h,080h,0b3h,000h,0b3h,080h,0a4h,000h	; 78c9  x...............
	defb 0a4h,080h,0a5h,000h,0a5h,080h,0fah,0b3h,000h,0f5h,040h,080h,0c0h,0f6h,094h,000h	; 78d9  ..........@.....
	defb 0f5h,040h,080h,0c0h,0f6h,075h,000h,075h,040h,065h,080h,065h,0c0h,056h,000h,056h	; 78e9  .@...u.u@e.e.V.V
	defb 040h,056h,080h,046h,0c0h,047h,000h,037h,060h,037h,080h,037h,0c0h,028h,000h,028h	; 78f9  @V.F.G.7`7.7.(.(
	defb 040h,018h,080h,018h,0c0h,009h,000h,009h,040h,0fah,0feh,002h,0e2h,002h,050h,020h	; 7909  @.......@.....P
	defb 040h,040h,040h,030h,040h,020h,040h,020h,0ebh,002h,00ch,0e2h,004h,030h,020h,0e2h	; 7919  @@@0@ @ .....0 .
	defb 009h,010h,020h,0ffh,0feh,002h,0f8h,018h,0e2h,001h,051h,000h,050h,040h,051h,000h	; 7929  .. .......Q.P@Q.
	defb 052h,000h,050h,060h,0ebh,002h,00ch,062h,000h,0f9h,04eh,079h,0d6h,0f9h,04eh,079h	; 7939  R.P`...b..Ny..Ny
	defb 011h,080h,000h,0c0h,0ffh,041h,080h,040h,0c0h,030h,080h,050h,060h,053h,000h,0fah	; 7949  .....A.@.0.P`S..
	defb 0feh,002h,0e0h,001h,0d7h,0f9h,06ah,079h,0ffh,0feh,002h,0f8h,00dh,0f9h,06ah,079h	; 7959  ......jy......jy
	defb 0ffh,0e2h,001h,0c1h,040h,0c1h,090h,0c1h,0f0h,0c2h,071h,0c3h,00dh,0c3h,0d0h,0c4h	; 7969  ....@.....q.....
	defb 0c4h,0c5h,0f5h,0b5h,0f5h,0a5h,0f5h,095h,0f5h,085h,0f5h,081h,040h,081h,090h,081h	; 7979  ............@...
	defb 0f0h,082h,071h,083h,00dh,083h,0d0h,0fah,0feh,002h,0f8h,019h,0e2h,001h,0a1h,040h	; 7989  ..q............@
	defb 0a1h,090h,0a1h,0f0h,0a2h,071h,0a3h,00dh,0a3h,0d0h,0a4h,0c4h,0a5h,0f5h,095h,000h	; 7999  .....q..........
	defb 0e2h,002h,085h,0f5h,085h,000h,075h,0f5h,075h,030h,065h,0f5h,065h,030h,055h,0f5h	; 79a9  ......u.u0e.e0U.
	defb 055h,030h,045h,0f5h,045h,030h,035h,0f5h,035h,030h,025h,0f5h,025h,030h,015h,0f5h	; 79b9  U0E.E05.50%.%0..
	defb 015h,030h,005h,0f5h,005h,030h,005h,0f5h,0ffh,0feh,002h,0e3h,001h,0f9h,047h,07ah	; 79c9  .0...0........Gz
	defb 0e4h,00ah,0a3h,000h,0f9h,047h,07ah,0e4h,00ah,0a3h,000h,0e4h,01ah,0f9h,05eh,07ah	; 79d9  .....Gz.......^z
	defb 0a4h,00ah,093h,000h,0f9h,047h,07ah,0c4h,00ah,0f9h,05eh,07ah,0e4h,013h,080h,04ch	; 79e9  .....Gz...^z...L
	defb 080h,038h,080h,04eh,0e2h,001h,084h,000h,0e3h,001h,0e4h,00ah,0f9h,073h,07ah,0e3h	; 79f9  .8.N.........sz.
	defb 001h,0e4h,00ah,0d6h,0f9h,073h,07ah,0e3h,001h,0e4h,00ah,0d9h,0f9h,073h,07ah,0e3h	; 7a09  .....sz......sz.
	defb 001h,0e4h,00ah,0dah,0f9h,073h,07ah,0ffh,0feh,002h,0f8h,028h,0e2h,001h,0f9h,086h	; 7a19  .....sz....(....
	defb 07ah,0f9h,086h,07ah,0d6h,0f9h,097h,07ah,0f9h,086h,07ah,0f9h,097h,07ah,0f9h,097h	; 7a29  z..z...z..z..z..
	defb 07ah,0d9h,0f9h,097h,07ah,0dah,0f9h,097h,07ah,0dbh,0f9h,097h,07ah,0ffh,0e4h,00ah	; 7a39  z...z...z...z...
	defb 0b3h,000h,0e4h,015h,090h,038h,0e4h,013h,090h,04ch,090h,038h,090h,04eh,0e2h,001h	; 7a49  .....8...L.8.N..
	defb 094h,000h,0e3h,001h,0fah,0a3h,000h,0e4h,015h,080h,038h,0e4h,013h,080h,04ch,080h	; 7a59  ..........8...L.
	defb 038h,080h,04eh,0e2h,001h,084h,000h,0e3h,001h,0fah,093h,000h,0e4h,015h,070h,038h	; 7a69  8.N...........p8
	defb 0e4h,013h,070h,04ch,070h,038h,070h,04eh,0e2h,001h,074h,000h,0fah,093h,000h,071h	; 7a79  ..pLp8pN..t....q
	defb 038h,071h,04ch,072h,038h,073h,04eh,074h,000h,083h,000h,065h,038h,0fah,073h,000h	; 7a89  8qLr8sNt...e8.s.
	defb 061h,038h,061h,04ch,062h,038h,063h,04eh,054h,000h,063h,000h,055h,038h,0fah,0feh	; 7a99  a8aLb8cNT.c.U8..
	defb 002h,0e0h,001h,0feh,002h,0f8h,028h,0e2h,001h,091h,040h,091h,090h,091h,0f0h,092h	; 7aa9  ......(...@.....
	defb 071h,093h,00dh,093h,0d0h,094h,0c4h,095h,0f5h,000h,000h,085h,0f5h,082h,050h,081h	; 7ab9  q.............P.
	defb 040h,0ebh,008h,008h,065h,0f5h,062h,050h,061h,040h,0ebh,006h,008h,045h,0f5h,042h	; 7ac9  @...e.bPa@...E.B
	defb 050h,041h,040h,0ebh,004h,008h,035h,0f5h,032h,050h,031h,040h,0ebh,002h,008h,015h	; 7ad9  PA@...5.2P1@....
	defb 0f5h,012h,050h,011h,040h,0ebh,002h,008h,0ffh,0feh,002h,0e3h,001h,0e4h,000h,080h	; 7ae9  ..P.@...........
	defb 01ch,080h,024h,080h,034h,070h,024h,070h,022h,070h,036h,080h,03ch,080h,040h,070h	; 7af9  ..$.4p$p"p6.<.@p
	defb 01ch,0ebh,003h,014h,060h,024h,060h,034h,050h,024h,050h,022h,050h,036h,060h,03ch	; 7b09  ....`$`4P$P"P6`<
	defb 060h,040h,030h,01ch,0ffh,0feh,002h,0f8h,015h,0e2h,001h,0f9h,037h,07bh,0d8h,0f9h	; 7b19  `@0.........7{..
	defb 037h,07bh,0f9h,037h,07bh,0d8h,0f9h,037h,07bh,0dbh,0f9h,037h,07bh,0ffh,0a1h,026h	; 7b29  7{.7{..7{..7{..&
	defb 0a1h,09fh,0a2h,01dh,091h,059h,091h,0bdh,092h,03dh,0a1h,0b6h,0a2h,09eh,0fah,0feh	; 7b39  .....Y...=......
	defb 002h,0e2h,001h,082h,0ach,082h,0e1h,083h,03ah,092h,03fh,092h,067h,000h,000h,0f9h	; 7b49  ........:.?.g...
	defb 093h,07bh,0d7h,0f9h,093h,07bh,0d8h,0f9h,093h,07bh,0d8h,0f9h,093h,07bh,0d9h,0f9h	; 7b59  .{...{...{...{..
	defb 093h,07bh,0ffh,0feh,002h,0f8h,019h,0e2h,001h,072h,09ch,072h,0e1h,063h,03ah,072h	; 7b69  .{.......r.r.c:r
	defb 03fh,072h,067h,000h,000h,0d8h,0f9h,093h,07bh,0dah,0f9h,093h,07bh,0dbh,0f9h,093h	; 7b79  ?rg.....{...{...
	defb 07bh,0dbh,0f9h,093h,07bh,0dch,0f9h,093h,07bh,0ffh,072h,0ach,072h,0e1h,063h,03ah	; 7b89  {...{...{.r.r.c:
	defb 062h,03fh,052h,067h,092h,0abh,092h,00fh,091h,0efh,000h,000h,0fah,0feh,002h,0e3h	; 7b99  b?Rg............
	defb 001h,0e4h,013h,053h,000h,0e4h,014h,062h,000h,0e4h,015h,073h,000h,0e4h,016h,072h	; 7ba9  ...S...b...s...r
	defb 000h,0e4h,017h,073h,000h,0e4h,018h,063h,000h,0e4h,01dh,072h,000h,0e4h,01eh,073h	; 7bb9  ...s...c...r...s
	defb 000h,0e4h,01ch,091h,080h,0e3h,003h,0e4h,01fh,073h,000h,071h,080h,082h,000h,092h	; 7bc9  .........s.q....
	defb 080h,061h,080h,052h,000h,0e4h,01fh,051h,0c0h,042h,060h,033h,000h,0ffh,0feh,002h	; 7bd9  .a.R...Q.B`3....
	defb 0f8h,00ch,0e2h,001h,0a3h,000h,0f7h,0b2h,0a3h,0a2h,0a3h,0b3h,0c2h,0c3h,0f6h,0c1h	; 7be9  ................
	defb 080h,0f9h,002h,07ch,0d9h,0f9h,002h,07ch,0ffh,0c3h,000h,0c1h,080h,0c2h,000h,0c2h	; 7bf9  ...|...|........
	defb 080h,0b1h,080h,0a2h,000h,0a1h,0c0h,092h,060h,081h,060h,0fah,0feh,002h,0f8h,015h	; 7c09  ........`.`.....
	defb 0e2h,001h,0f9h,03ch,07ch,000h,000h,0d6h,0f9h,03ch,07ch,0f9h,047h,07ch,0d6h,0f9h	; 7c19  ...<|....<|.G|..
	defb 047h,07ch,0d8h,0f9h,047h,07ch,021h,03fh,011h,067h,041h,0abh,041h,00fh,040h,0efh	; 7c29  G|..G|!?.gA.A.@.
	defb 041h,01eh,0ffh,0a1h,0ach,0a1h,0e1h,0a2h,03ah,0b1h,03fh,0b1h,067h,0fah,091h,0abh	; 7c39  A.......:.?.g...
	defb 091h,00fh,090h,0efh,091h,01eh,071h,0ach,071h,0e1h,062h,03ah,061h,03fh,051h,067h	; 7c49  ......q.q.b:a?Qg
	defb 0fah,0feh,002h,0f8h,014h,0e2h,001h,0c4h,08ch,0b4h,015h,0b4h,08ch,0a4h,015h,0a4h	; 7c59  ................
	defb 08ch,084h,015h,0c2h,026h,0c2h,09fh,0c3h,01dh,0b2h,059h,0b2h,0bdh,0b3h,03dh,0c2h	; 7c69  ....&.....Y...=.
	defb 0b6h,0c3h,09eh,0c4h,0e9h,0f9h,095h,07ch,0f9h,095h,07ch,0d7h,0f9h,095h,07ch,0d8h	; 7c79  .......|..|...|.
	defb 0f9h,095h,07ch,0d9h,0f9h,095h,07ch,0dbh,0f9h,095h,07ch,0ffh,0c2h,0e9h,0c3h,0ceh	; 7c89  ..|...|...|.....
	defb 0c5h,034h,0c2h,0b6h,0c3h,09eh,0c4h,0e9h,0fah,0feh,002h,0e2h,002h,0b4h,000h,0b3h	; 7c99  .4..............
	defb 080h,0b3h,000h,0b2h,080h,0b2h,000h,0b1h,0e0h,0b1h,0c0h,0f9h,0ebh,07ch,070h,0f0h	; 7ca9  .............|p.
	defb 070h,0e0h,060h,0d0h,050h,0c0h,0ffh,0feh,002h,0e2h,002h,0f8h,00ah,0c3h,0d0h,0c3h	; 7cb9  p.`.P...........
	defb 060h,0b2h,0e0h,0b2h,060h,0b1h,0e0h,0b1h,0c0h,0b1h,0a0h,0a1h,080h,0a1h,060h,091h	; 7cc9  `...`.........`.
	defb 040h,091h,020h,091h,000h,090h,0f0h,080h,0d0h,080h,0b0h,080h,0a0h,0d8h,0f9h,0ebh	; 7cd9  @. .............
	defb 07ch,0ffh,0a1h,0a0h,0a1h,080h,0a1h,060h,091h,040h,091h,020h,081h,000h,0fah,0feh	; 7ce9  |......`.@. ....
	defb 002h,0e0h,001h,0d7h,0f9h,009h,07dh,0ffh,0feh,002h,0f8h,028h,0f9h,009h,07dh,0ffh	; 7cf9  ......}....(..}.
	defb 0e2h,001h,092h,0d0h,0a2h,060h,0b1h,0e0h,0c1h,060h,0ebh,004h,00ah,062h,0d0h,072h	; 7d09  .....`...`...b.r
	defb 060h,081h,0e0h,091h,060h,0ebh,002h,00ah,042h,0d0h,052h,060h,061h,0e0h,071h,060h	; 7d19  `...`...B.R`a.q`
	defb 0ebh,002h,00ah,012h,0d0h,012h,060h,011h,0e0h,011h,060h,0ebh,002h,00ah,0fah,0feh	; 7d29  ......`...`.....
	defb 002h,0e0h,002h,0feh,002h,0f8h,015h,0e2h,002h,063h,040h,072h,0c0h,082h,040h,091h	; 7d39  .........c@r..@.
	defb 0f0h,091h,0b0h,091h,070h,091h,030h,091h,022h,091h,028h,0ebh,003h,006h,043h,040h	; 7d49  ....p.0.".(...C@
	defb 042h,0c0h,032h,040h,031h,0f0h,021h,0b0h,021h,070h,021h,030h,011h,022h,011h,028h	; 7d59  B.2@1.!.!p!0.".(
	defb 0ebh,004h,006h,0feh,002h,0e0h,004h,0d8h,0f9h,07dh,07dh,0ffh,0feh,002h,0f8h,015h	; 7d69  .........}}.....
	defb 0f9h,07dh,07dh,0ffh,0e2h,002h,050h,060h,060h,05ch,080h,05eh,080h,060h,030h,060h	; 7d79  .}}...P``\.^.`0`
	defb 040h,05ch,050h,05eh,040h,060h,0fah,0feh,002h,0e0h,003h,0d9h,0f9h,0a1h,07dh,0ffh	; 7d89  @\P^@`........}.
	defb 0feh,002h,0f8h,00ch,0f9h,0a1h,07dh,0ffh,0e2h,001h,0a0h,0e2h,0b0h,0aah,0c0h,08fh	; 7d99  ......}.........
	defb 0c0h,086h,0ebh,004h,006h,0b0h,08fh,0b0h,086h,0ebh,002h,006h,0c0h,071h,0c0h,055h	; 7da9  .............q.U
	defb 0c0h,047h,0c0h,042h,0ebh,004h,006h,090h,047h,090h,042h,0ebh,002h,006h,060h,047h	; 7db9  .G.B....G.B...`G
	defb 060h,042h,0ebh,004h,006h,0fah,0feh,002h,0e0h,003h,0e2h,001h,0d8h,0f9h,0e4h,07dh	; 7dc9  `B.............}
	defb 0ffh,0feh,002h,0f8h,028h,0e2h,001h,0f9h,0e4h,07dh,0ffh,0c0h,040h,0c0h,090h,0c0h	; 7dd9  ....(....}..@...
	defb 0f0h,0c1h,071h,0c2h,00dh,0c2h,0d0h,0c3h,0c4h,0c4h,0f5h,000h,000h,0a3h,0f5h,0a1h	; 7de9  ..q.............
	defb 050h,0a1h,040h,0ebh,006h,008h,013h,0f5h,011h,050h,011h,040h,0ebh,006h,008h,0fah	; 7df9  P.@......P.@....
	defb 0feh,002h,0e0h,004h,0dah,0f9h,02bh,07eh,0ddh,0f9h,043h,07eh,0dfh,00ah,0f9h,059h	; 7e09  ......+~..C~...Y
	defb 07eh,0ffh,0feh,002h,0f8h,015h,0e2h,001h,0f9h,02bh,07eh,0f9h,043h,07eh,0f9h,059h	; 7e19  ~........+~.C~.Y
	defb 07eh,0ffh,0c1h,0f0h,0c1h,0e0h,0c1h,0d0h,0f5h,0c0h,0b0h,090h,070h,050h,030h,010h	; 7e29  ~...........pP0.
	defb 0f6h,0c0h,0eeh,0c0h,0ddh,0c0h,0cch,0c0h,0cch,0fah,071h,0f0h,071h,0e0h,071h,0d0h	; 7e39  ..........q.q.q.
	defb 0f5h,0c0h,0b0h,090h,070h,050h,030h,010h,0f6h,070h,0eeh,070h,0ddh,070h,0cch,0fah	; 7e49  ....pP0..p.p.p..
	defb 070h,0cch,0e2h,002h,021h,0f0h,021h,0d0h,021h,0b0h,021h,070h,021h,030h,020h,0eeh	; 7e59  p...!.!.!.!p!0 .
	defb 020h,0cch,0fah,0feh,002h,0e3h,001h,0e4h,003h,070h,018h,070h,030h,000h,000h,0ebh	; 7e69   ........p.p0...
	defb 006h,008h,040h,018h,040h,030h,000h,000h,0ebh,006h,008h,030h,018h,030h,030h,000h	; 7e79  ..@.@0.....0.00.
	defb 000h,0ebh,004h,008h,0ffh,0feh,002h,0f8h,014h,0e2h,001h,0a2h,078h,0a2h,0a0h,000h	; 7e89  ............x...
	defb 000h,0f9h,0aeh,07eh,0d8h,0f9h,0aeh,07eh,0dbh,0f9h,0aeh,07eh,0deh,0f9h,0aeh,07eh	; 7e99  ...~...~...~...~
	defb 0dfh,0f9h,0aeh,07eh,0ffh,0c2h,048h,0c2h,070h,000h,000h,0ebh,003h,008h,0fah,0feh	; 7ea9  ...~..H.p.......
	defb 002h,0e2h,001h,0b0h,060h,0b0h,0e0h,0b6h,000h,0b4h,0e0h,092h,0e0h,000h,000h,0ebh	; 7eb9  ....`...........
	defb 002h,00eh,095h,0e0h,09eh,0e0h,074h,0e0h,000h,000h,000h,000h,080h,060h,080h,0e0h	; 7ec9  ......t......`..
	defb 086h,000h,084h,0e0h,072h,0e0h,000h,000h,000h,000h,0ebh,002h,010h,065h,000h,054h	; 7ed9  ....r........e.T
	defb 0e0h,042h,0e0h,0ffh,0feh,002h,0f8h,014h,0e2h,001h,0c2h,001h,0c2h,040h,0c2h,0f0h	; 7ee9  .B...........@..
	defb 0c3h,0f0h,0c5h,0e0h,000h,000h,0ebh,002h,00eh,0c7h,0e0h,0cbh,0e0h,0ceh,0e0h,000h	; 7ef9  ................
	defb 000h,000h,000h,052h,001h,052h,040h,052h,0f0h,053h,0f0h,055h,0e0h,000h,000h,000h	; 7f09  ...R.R@R.S.U....
	defb 000h,0ebh,002h,010h,047h,0e0h,03bh,0e0h,02eh,0e0h,0ffh,0feh,002h,0e0h,002h,0d8h	; 7f19  ....G...........
	defb 0f9h,045h,07fh,0d8h,0f9h,045h,07fh,0dah,0f9h,045h,07fh,0ffh,0feh,002h,0f8h,00dh	; 7f29  .E...E...E......
	defb 0f9h,045h,07fh,0d7h,0f9h,045h,07fh,0dch,0f9h,045h,07fh,0ffh,0e2h,001h,092h,080h	; 7f39  .E...E...E......
	defb 0a2h,060h,0b2h,030h,0c2h,010h,0c2h,000h,0c1h,0d0h,0e2h,00eh,0c1h,080h,0e2h,004h	; 7f49  .`.0............
	defb 0b1h,080h,091h,080h,0ebh,008h,01ah,0fah,0ffh,0feh,001h,0f8h,004h,0e9h,002h,0eah	; 7f59  ................
	defb 00ah,0d2h,070h,080h,090h,0a0h,0b0h,0a0h,090h,080h,0fdh,06bh,07fh,0feh,001h,0f8h	; 7f69  ..p........k....
	defb 012h,0e9h,002h,0eah,009h,0d2h,0efh,005h,090h,080h,070h,080h,090h,0a0h,0b0h,0fdh	; 7f79  ..........p.....
	defb 081h,07fh,0feh,001h,0f8h,005h,0e9h,006h,0eah,00bh,0d2h,08fh,0fdh,094h,07fh,0feh	; 7f89  ................
	defb 001h,0e9h,006h,0eah,00bh,0d2h,07fh,0fdh,09fh,07fh,0feh,002h,0f8h,005h,0e2h,002h	; 7f99  ................
	defb 0c2h,000h,0c1h,0d0h,0f5h,0a0h,080h,060h,040h,020h,0f6h,0ebh,00ch,00dh,072h,000h	; 7fa9  .......`@ ....r.
	defb 071h,0d0h,0f5h,0a0h,080h,060h,040h,020h,0f6h,0ebh,004h,00dh,032h,000h,031h,0d0h	; 7fb9  q....`@ ....2.1.
	defb 0f5h,0a0h,080h,060h,040h,020h,0f6h,0ebh,002h,00dh,002h,000h,001h,0d0h,0f5h,0a0h	; 7fc9  ...`@ ..........
	defb 080h,060h,040h,020h,0f6h,0ebh,002h,00dh,0ffh,0feh,002h,0f8h,00ch,0e2h,004h,0c5h	; 7fd9  .`@ ............
	defb 000h,0c4h,080h,0c4h,000h,0e2h,001h,0c3h,000h,0e2h,004h,0c3h,000h,0e2h,004h,0c3h	; 7fe9  ................
	defb 080h,0c3h,000h,0c2h,080h,0ebh,002h	; 7ff9

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


pide_sonido:		; el sonido A: 0xF0/0xF1 sin/con fundido, 0xF2 sale de la pausa, 0xF3 entra; si no, su cabecera (p04:6612) y cada canal que pide, si su prioridad no es menor que la que suena
	ld c,a			;6480   ; C = el sonido
	cp 0f0h		;6481   ; 0xF0: sin fundido
	jp z,sin_fundido		;6483   ; sin_fundido: 0xE190 bit 0 = 0 y la cuenta del fundido a cero
	cp 0f1h		;6486   ; 0xF1: con fundido
	jp z,con_fundido		;6488   ; con_fundido: 0xE190 bit 0 = 1 (fundido de salida) y su cuenta a cero
	cp 0f2h		;648b   ; 0xF2: sale de la pausa
	jp z,sale_de_la_pausa		;648d   ; sale_de_la_pausa: devuelve los canales guardados (0xE140 a 0xE000), los canales del SCC encendidos y el SCC entero de nuevo
	cp 0f3h		;6490   ; 0xF3: entra en pausa
	call z,entra_en_pausa		;6492   ; entra_en_pausa: 0xE190 bit 1, guarda los canales (0xE000 a 0xE140), apaga el SCC y los canales del PSG
	ld hl,0e078h		;6495   ; el sonido del canal 1 del SCC
	ld a,c			;6498
	cp 005h		;6499   ; el 5 no vuelve a empezar si ya suena
	jr nz,L_64A0		;649b
	ld a,(hl)			;649d
	cp c			;649e
	ret z			;649f
L_64A0:
	ld a,c			;64a0
	cp 012h		;64a1   ; ni el 0x12
	jr nz,L_64A8		;64a3
	ld a,(hl)			;64a5
	cp c			;64a6
	ret z			;64a7
L_64A8:
	ld a,c			;64a8
	cp 014h		;64a9   ; ni el 0x14
	jr nz,L_64B0		;64ab
	ld a,(hl)			;64ad
	cp c			;64ae
	ret z			;64af
L_64B0:
	ld hl,0e191h		;64b0   ; el sonido pedido
	ld (hl),c			;64b3
	ld hl,06612h		;64b4   ; su cabecera en p04:6612
	ld a,c			;64b7
	add a,c			;64b8
	ld e,a			;64b9
	ld d,000h		;64ba
	add hl,de			;64bc
	ld e,(hl)			;64bd
	inc hl			;64be
	ld d,(hl)			;64bf
	ex de,hl			;64c0
	ld de,0e192h		;64c1   ; 18 bytes a 0xE192
	ld bc,00012h		;64c4
	ldir		;64c7
	ld ix,0e194h		;64c9   ; IX = sus partituras
	ld hl,0e192h		;64cd   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 7,(hl)		;64d0   ; bit 7: el canal 1 del PSG
	jr z,L_64E0		;64d2
	inc hl			;64d4
	ld a,(hl)			;64d5   ; la prioridad
	ld hl,0e001h		;64d6   ; apunta a la prioridad del canal 1 del PSG (los canales son de 40 bytes desde 0xE000)
	call pon_canal		;64d9   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;64dc   ; la partitura siguiente
	inc ix		;64de
L_64E0:
	ld hl,0e192h		;64e0   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 6,(hl)		;64e3   ; bit 6: el canal 2 del PSG
	jr z,L_64F3		;64e5
	inc hl			;64e7
	ld a,(hl)			;64e8
	ld hl,0e029h		;64e9   ; apunta a la prioridad del canal 2 del PSG
	call pon_canal		;64ec   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;64ef
	inc ix		;64f1
L_64F3:
	ld hl,0e192h		;64f3   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 5,(hl)		;64f6   ; bit 5: el canal 3 del PSG
	jr z,L_6506		;64f8
	inc hl			;64fa
	ld a,(hl)			;64fb
	ld hl,0e051h		;64fc   ; apunta a la prioridad del canal 3 del PSG
	call pon_canal		;64ff   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;6502
	inc ix		;6504
L_6506:
	ld hl,0e192h		;6506   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 4,(hl)		;6509   ; bit 4: el canal 1 del SCC
	jr z,L_6519		;650b
	inc hl			;650d
	ld a,(hl)			;650e
	ld hl,0e079h		;650f   ; apunta a la prioridad del canal 1 del SCC
	call pon_canal		;6512   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;6515
	inc ix		;6517
L_6519:
	ld hl,0e192h		;6519   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 3,(hl)		;651c   ; bit 3: el 2 del SCC
	jr z,L_652C		;651e
	inc hl			;6520
	ld a,(hl)			;6521
	ld hl,0e0a1h		;6522   ; apunta a la prioridad del canal 2 del SCC
	call pon_canal		;6525   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;6528
	inc ix		;652a
L_652C:
	ld hl,0e192h		;652c   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 2,(hl)		;652f   ; bit 2: el 3 del SCC
	jr z,L_653F		;6531
	inc hl			;6533
	ld a,(hl)			;6534
	ld hl,0e0c9h		;6535   ; apunta a la prioridad del canal 3 del SCC
	call pon_canal		;6538   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;653b
	inc ix		;653d
L_653F:
	ld hl,0e192h		;653f   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 1,(hl)		;6542   ; bit 1: el 4 del SCC
	jr z,L_6552		;6544
	inc hl			;6546
	ld a,(hl)			;6547
	ld hl,0e0f1h		;6548   ; apunta a la prioridad del canal 4 del SCC
	call pon_canal		;654b   ; pon_canal: si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	inc ix		;654e
	inc ix		;6550
L_6552:
	ld hl,0e192h		;6552   ; apunta a la cabecera del sonido pedido: [canales][prioridad][partituras]
	bit 0,(hl)		;6555   ; bit 0: el 5 del SCC
	ret z			;6557
	inc hl			;6558
	ld a,(hl)			;6559
	ld hl,0e119h		;655a   ; apunta a la prioridad del canal 5 del SCC
pon_canal:		; si la prioridad A no es menor que la del canal HL: el sonido, la prioridad, la partitura (IX) y el estado de salida (p04:657D)
	ld b,(hl)			;655d   ; la prioridad que tiene el canal
	cp b			;655e
	ret c			;655f   ; menor: no entra
	ex de,hl			;6560
	ld (de),a			;6561   ; la prioridad nueva
	dec de			;6562
	ld hl,0e191h		;6563   ; apunta a el sonido que se pide
	ld a,(hl)			;6566   ; el sonido
	ld (de),a			;6567
	inc de			;6568
	inc de			;6569
	ld a,(ix+000h)		;656a   ; la partitura
	ld (de),a			;656d
	inc de			;656e
	ld a,(ix+001h)		;656f
	ld (de),a			;6572
	inc de			;6573
	ld hl,0657dh		;6574   ; y 16 bytes de salida
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


sin_fundido:		; 0xE190 bit 0 = 0 y la cuenta del fundido a cero
	ld hl,0e190h		;658d   ; apunta a el estado del sonido (bit 0)
	res 0,(hl)		;6590   ; sin fundido
	jr L_6599		;6592
con_fundido:		; 0xE190 bit 0 = 1 (fundido de salida) y su cuenta a cero
	ld hl,0e190h		;6594   ; apunta a el estado del sonido (bit 0)
	set 0,(hl)		;6597   ; con fundido
L_6599:
	ld hl,0e1a4h		;6599   ; la cuenta a cero
	xor a			;659c
	ld (hl),a			;659d
	inc hl			;659e
	ld (hl),a			;659f
	ret			;65a0
sale_de_la_pausa:		; devuelve los canales guardados (0xE140 a 0xE000), los canales del SCC encendidos y el SCC entero de nuevo
	ld hl,0e190h		;65a1   ; apunta a el estado del sonido (bit 0)
	res 1,(hl)		;65a4   ; sin pausa
	bit 3,(hl)		;65a6   ; con el fundido parado por la pausa, vuelve
	jr z,L_65AE		;65a8
	res 3,(hl)		;65aa
	set 0,(hl)		;65ac
L_65AE:
	ld hl,0e140h		;65ae   ; los canales guardados
	ld de,0e000h		;65b1   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call copia_canales		;65b4   ; copia_canales: copia 80 bytes de HL a DE
	ld a,(0e1c0h)		;65b7   ; los canales del SCC con 0xE1C0
	ld e,a			;65ba
	ld a,03fh		;65bb   ; el SCC en 0x8000
	ld (09000h),a		;65bd   ; el mapper: pone en 0x8000 el banco de A
	ld a,e			;65c0
	ld (0988fh),a		;65c1
	ld a,005h		;65c4   ; y el banco 5 otra vez
	ld (09000h),a		;65c6   ; el mapper: pone en 0x8000 el banco de A
	ld a,0ffh		;65c9   ; todos los registros del SCC cambiados
	ld hl,0e1aeh		;65cb   ; apunta a los registros del SCC que han cambiado (16 bits)
	ld (hl),a			;65ce
	inc hl			;65cf
	ld (hl),a			;65d0
	call escribe_el_scc		;65d1   ; al SCC
	ld hl,0e05dh		;65d4   ; los canales del PSG, como antes
	ld a,(hl)			;65d7
	rrca			;65d8
	rrca			;65d9
	rrca			;65da
	rrca			;65db
	ld (hl),a			;65dc
	ret			;65dd
entra_en_pausa:		; 0xE190 bit 1, guarda los canales (0xE000 a 0xE140), apaga el SCC y los canales del PSG
	ld hl,0e190h		;65de   ; apunta a el estado del sonido (bit 0)
	set 1,(hl)		;65e1   ; en pausa
	bit 0,(hl)		;65e3   ; con fundido, se para
	jr z,L_65EB		;65e5
	res 0,(hl)		;65e7
	set 3,(hl)		;65e9
L_65EB:
	ld hl,0e000h		;65eb   ; guarda los canales
	ld de,0e140h		;65ee   ; apunta a la copia de los canales durante la pausa
	call copia_canales		;65f1   ; copia_canales: copia 80 bytes de HL a DE
	ld a,03fh		;65f4   ; el SCC en 0x8000
	ld (09000h),a		;65f6   ; el mapper: pone en 0x8000 el banco de A
	xor a			;65f9   ; canales apagados
	ld (0988fh),a		;65fa
	ld a,005h		;65fd   ; y el banco 5 otra vez
	ld (09000h),a		;65ff   ; el mapper: pone en 0x8000 el banco de A
	ld hl,0e05dh		;6602   ; el modo del canal 3 del PSG, guardado
	ld a,(hl)			;6605
	rlca			;6606
	rlca			;6607
	rlca			;6608
	rlca			;6609
	ld (hl),a			;660a
	ld c,00dh		;660b   ; C = 13
	ret			;660d
copia_canales:		; copia 80 bytes de HL a DE
	ld bc,00050h		;660e   ; 2 canales
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


sonido_del_cuadro:		; el mezclador del PSG; en pausa solo los canales 1-2; si no, el fundido, los 8 canales (0xE000, 40 bytes cada uno) y los registros del PSG y el SCC
	ld a,(0e1a6h)		;6934   ; el mezclador del PSG
	call pon_mezclador		;6937   ; pon_mezclador: el registro 7 del PSG con A (y su copia 0xE1A6)
	ld hl,0e190h		;693a   ; apunta a el estado del sonido (bit 0)
	bit 1,(hl)		;693d   ; en pausa?
	jp nz,canales_de_pausa		;693f   ; canales_de_pausa: en la pausa: los dos primeros canales del PSG, el mezclador 0xBC y los registros del PSG
	ld a,(0e190h)		;6942   ; con fundido
	bit 0,a		;6945
	call nz,fundido		;6947   ; fundido: 0xE1A4 + 1; cada 96 cuadros 0xE1A5 + 1; al segundo, se apagan todos los canales
	ld ix,0e000h		;694a   ; 8 canales de 40 bytes
	exx			;694e
	ld de,00028h		;694f
	ld b,008h		;6952
	ld c,001h		;6954   ; el canal 1 (bit 0)
	ld a,c			;6956
L_6957:
	exx			;6957
	ld (0e1a7h),a		;6958   ; el canal que se toca
	call un_canal		;695b   ; un_canal: el canal IX si suena y, con fundido, baja su volumen
	exx			;695e
	add ix,de		;695f
	ld a,c			;6961   ; el bit siguiente
	add a,c			;6962
	djnz L_6957		;6963
	call registros_de_sonido		;6965   ; y los registros
	ret			;6968
un_canal:		; el canal IX si suena y, con fundido, baja su volumen
	ld a,(ix+000h)		;6969   ; suena?
	or a			;696c
	call nz,paso_de_canal		;696d   ; paso_de_canal: la nota sigue (efectos) o, al acabar, lee la partitura: 0xFF acaba, 0xD0-0xFF ordenes, el resto notas segun el modo (IX+09)
	ld hl,0e190h		;6970   ; con fundido, baja
	bit 0,(hl)		;6973
	call nz,baja_volumen		;6975   ; baja_volumen: con fundido, el volumen del canal IX menos 0xE1A5 (salvo con envolvente)
	ret			;6978
canales_de_pausa:		; en la pausa: los dos primeros canales del PSG, el mezclador 0xBC y los registros del PSG
	ld a,001h		;6979   ; el canal 1 del PSG
	ld (0e1a7h),a		;697b   ; guarda el canal que se esta tocando (1, 2, 4, 8...)
	ld ix,0e000h		;697e   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call un_canal		;6982   ; un_canal: el canal IX si suena y, con fundido, baja su volumen
	ld a,002h		;6985   ; y el 2
	ld (0e1a7h),a		;6987   ; guarda el canal que se esta tocando (1, 2, 4, 8...)
	ld ix,0e028h		;698a   ; apunta a el canal 2 del PSG
	call un_canal		;698e   ; un_canal: el canal IX si suena y, con fundido, baja su volumen
	ld a,0bch		;6991   ; mezclador: tono en A y B, sin ruido
	ld (0e1a6h),a		;6993   ; guarda el registro 7 del PSG (mezclador)
	call registros_del_psg		;6996   ; los registros del PSG
	ret			;6999
paso_de_canal:		; la nota sigue (efectos) o, al acabar, lee la partitura: 0xFF acaba, 0xD0-0xFF ordenes, el resto notas segun el modo (IX+09)
	dec (ix+004h)		;699a   ; la nota sigue
	jp nz,efectos_de_canal		;699d   ; efectos_de_canal: mientras suena la nota: la bateria, el vibrato y la envolvente de volumen
	ld l,(ix+002h)		;69a0   ; la partitura
	ld h,(ix+003h)		;69a3
lee_partitura:		; lee la partitura en HL hasta la siguiente nota
	ld a,(hl)			;69a6   ; 0xFF: se acabo
	cp 0ffh		;69a7
	jp z,canal_acaba		;69a9   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	cp 0d0h		;69ac   ; una orden
	jr c,L_69B7		;69ae
	call orden		;69b0   ; orden: la orden 0xE0-0xFE de la partitura (p04:6D27); de 0xD0 a 0xDF, la octava o el volumen (p04:6F55)
	inc hl			;69b3
	jp lee_partitura		;69b4   ; lee_partitura: lee la partitura en HL hasta la siguiente nota
L_69B7:
	bit 0,(ix+009h)		;69b7   ; segun el modo
	call nz,nota		;69bb   ; nota: la duracion (cifra baja x tempo IX+14) y la nota (cifra alta): su divisor (p04:6A32) por la octava IX+16 y el volumen IX+15 (menos el fundido)
	bit 1,(ix+009h)		;69be
	call nz,volumen_de_nota		;69c2   ; volumen_de_nota: el volumen de la nota segun el modo IX+0D (y el periodo directo con IX+0E bit 7)
	bit 2,(ix+009h)		;69c5
	call nz,golpe_de_bateria		;69c9   ; golpe_de_bateria: modo 4: la nota y el golpe de bateria de su cifra alta (p04:7255) en marcha
	ret			;69cc
nota:		; la duracion (cifra baja x tempo IX+14) y la nota (cifra alta): su divisor (p04:6A32) por la octava IX+16 y el volumen IX+15 (menos el fundido)
	ld a,(hl)			;69cd   ; la cifra baja
	and 00fh		;69ce
	ld b,a			;69d0
	ld a,(ix+014h)		;69d1   ; x el tempo
	jr z,L_69DA		;69d4
	ld e,a			;69d6
L_69D7:
	add a,e			;69d7
	djnz L_69D7		;69d8
L_69DA:
	ld (ix+004h),a		;69da   ; la duracion
	ld a,(hl)			;69dd   ; la cifra alta: la nota
	and 0f0h		;69de
	rrca			;69e0
	rrca			;69e1
	rrca			;69e2
	rrca			;69e3
	call avanza_partitura		;69e4   ; avanza_partitura: IX+02/IX+03 = HL + 1
	bit 3,(ix+009h)		;69e7   ; sin tono
	ret nz			;69eb
	cp 00ch		;69ec   ; 12 o mas: silencio
	jr nc,silencio		;69ee
	ld hl,06a32h		;69f0   ; el divisor de la nota
	ld e,a			;69f3
	ld d,000h		;69f4
	add hl,de			;69f6
	ld l,(hl)			;69f7
	ld h,000h		;69f8
	ld a,(ix+016h)		;69fa   ; desplazado por la octava
	or a			;69fd
	jr z,L_6A04		;69fe
	ld b,a			;6a00
L_6A01:
	add hl,hl			;6a01
	djnz L_6A01		;6a02
L_6A04:
	ld (ix+010h),l		;6a04   ; el periodo
	ld (ix+011h),h		;6a07
	ld e,(ix+015h)		;6a0a   ; el volumen
	ld a,(0e190h)		;6a0d   ; con fundido, menos
	bit 0,a		;6a10
	call nz,volumen_con_fundido		;6a12   ; volumen_con_fundido: E = el volumen menos el fundido (0xE1A5), como poco 9
	ld (ix+012h),e		;6a15   ; el volumen de la nota
	ld (ix+00dh),002h		;6a18   ; tono
	call empieza_nota		;6a1c   ; empieza_nota: el periodo, los efectos a cero, la envolvente y el volumen de salida
	ret			;6a1f
volumen_con_fundido:		; E = el volumen menos el fundido (0xE1A5), como poco 9
	ld a,(0e1a5h)		;6a20   ; lo que ha bajado
	ld d,a			;6a23
	ld a,e			;6a24
	sub d			;6a25
	ld e,a			;6a26
	cp 008h		;6a27   ; como poco 9
	ret nc			;6a29
	ld e,009h		;6a2a
	ret			;6a2c
silencio:		; IX+0D = 0: sin sonido
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


volumen_de_nota:		; el volumen de la nota segun el modo IX+0D (y el periodo directo con IX+0E bit 7)
	ld a,(ix+00dh)		;6a3f   ; el modo
	and 003h		;6a42
	jr z,L_6A9B		;6a44
	cp 001h		;6a46
	jr z,L_6A80		;6a48
	ld a,(hl)			;6a4a
	bit 7,(ix+00eh)		;6a4b   ; periodo directo?
	jr nz,L_6A6C		;6a4f
	bit 5,(ix+00eh)		;6a51   ; o volumen en la cifra baja?
	jr nz,L_6A71		;6a55
	and 0f0h		;6a57   ; el periodo: 12 bits
	ld b,a			;6a59
	xor (hl)			;6a5a
	ld d,a			;6a5b
	inc hl			;6a5c
	ld a,(hl)			;6a5d
	ld (ix+010h),a		;6a5e
	ld (ix+011h),d		;6a61
	ld a,b			;6a64   ; la cifra alta: el volumen
	rrca			;6a65
	rrca			;6a66
	rrca			;6a67
	rrca			;6a68
	ld b,a			;6a69
	jr L_6A84		;6a6a
L_6A6C:
	ld (ix+010h),a		;6a6c   ; periodo directo
	jr L_6A98		;6a6f
L_6A71:
	and 0f0h		;6a71   ; el volumen en la cifra alta
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
	ld a,(hl)			;6a80   ; modo 1: el volumen en la cifra baja
	and 00fh		;6a81
	ld b,a			;6a83
L_6A84:
	ld a,(0e1a7h)		;6a84   ; en el PSG con envolvente, 16
	cp 008h		;6a87
	jr nc,L_6A93		;6a89
	bit 2,(ix+00dh)		;6a8b
	jr z,L_6A93		;6a8f
	ld b,010h		;6a91
L_6A93:
	inc b			;6a93   ; + 2
	inc b			;6a94
	ld (ix+012h),b		;6a95
L_6A98:
	call empieza_nota		;6a98   ; empieza_nota: el periodo, los efectos a cero, la envolvente y el volumen de salida
L_6A9B:
	bit 3,(ix+009h)		;6a9b   ; sin duracion propia
	ret nz			;6a9f
	call avanza_partitura		;6aa0   ; avanza_partitura: IX+02/IX+03 = HL + 1
	ld a,(ix+013h)		;6aa3   ; la duracion de IX+13
	ld (ix+004h),a		;6aa6
	ret			;6aa9
golpe_de_bateria:		; modo 4: la nota y el golpe de bateria de su cifra alta (p04:7255) en marcha
	ld (ix+009h),009h		;6aaa   ; modo de bateria
	call nota		;6aae   ; la nota
	ld hl,07255h		;6ab1   ; el golpe (p04:7255)
	add a,a			;6ab4
	ld e,a			;6ab5
	ld d,000h		;6ab6
	add hl,de			;6ab8
	ld e,(hl)			;6ab9
	inc hl			;6aba
	ld d,(hl)			;6abb
	ex de,hl			;6abc
	ld a,(hl)			;6abd
	set 0,(ix+00eh)		;6abe   ; bateria en marcha
sigue_bateria:		; lee el siguiente paso del golpe de bateria y guarda donde sigue (IX+17) y su espera (IX+19)
	ld (ix+009h),00ah		;6ac2
	call lee_partitura		;6ac6   ; su primer paso
	ld a,(ix+013h)		;6ac9   ; su espera
	ld (ix+019h),a		;6acc
	inc hl			;6acf
	ld (ix+017h),l		;6ad0   ; donde sigue
	ld (ix+018h),h		;6ad3
	ld (ix+009h),004h		;6ad6   ; modo 4 otra vez
	ret			;6ada
avanza_partitura:		; IX+02/IX+03 = HL + 1
	inc hl			;6adb
	ld (ix+002h),l		;6adc
	ld (ix+003h),h		;6adf
	ret			;6ae2
canal_acaba:		; el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	xor a			;6ae3   ; el canal a cero
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
	ld a,(0e1a7h)		;6b02   ; en el SCC, nada mas
	cp 008h		;6b05
	ret nc			;6b07
	cp 001h		;6b08   ; el ruido del canal 1 o del 2
	ld hl,0e1aah		;6b0a   ; apunta a las banderas de ruido y envolvente del PSG
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
fundido:		; 0xE1A4 + 1; cada 96 cuadros 0xE1A5 + 1; al segundo, se apagan todos los canales
	ld hl,0e1a4h		;6b1c   ; un cuadro mas
	inc (hl)			;6b1f
	ld a,(0e0a0h)		;6b20   ; lee la musica que suena
	ld a,(hl)			;6b23
	cp 060h		;6b24   ; cada 96
	ret nz			;6b26
	ld (hl),000h		;6b27
	inc hl			;6b29
	inc (hl)			;6b2a   ; un paso mas
	ld a,(hl)			;6b2b
	cp 002h		;6b2c   ; al segundo, se acabo
	ret nz			;6b2e
	xor a			;6b2f
	ld hl,0e190h		;6b30   ; sin fundido
	res 0,(hl)		;6b33
	ld hl,0e1a4h		;6b35   ; apunta a la cuenta de cuadros del fundido
	ld (hl),a			;6b38
	inc hl			;6b39
	ld (hl),a			;6b3a
	ld a,(0e000h)		;6b3b   ; si los dos primeros canales tocan lo mismo, tambien el 1 y el SCC 1
	ld e,a			;6b3e
	ld a,(0e028h)		;6b3f   ; lee el canal 2 del PSG
	cp e			;6b42
	jr nz,L_6B53		;6b43
	ld ix,0e000h		;6b45   ; apunta a la RAM del juego (0xE000-0xEFFF, que INIT pone a cero)
	call canal_acaba		;6b49   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	ld ix,0e078h		;6b4c   ; apunta a el canal 1 del SCC (el sonido que suena)
	call canal_acaba		;6b50   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
L_6B53:
	ld de,00028h		;6b53   ; y los demas
	ld ix,0e028h		;6b56   ; apunta a el canal 2 del PSG
	call canal_acaba		;6b5a   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	add ix,de		;6b5d
	call canal_acaba		;6b5f   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	ld ix,0e0a0h		;6b62   ; apunta a la musica que suena
	call canal_acaba		;6b66   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	add ix,de		;6b69
	call canal_acaba		;6b6b   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	add ix,de		;6b6e
	call canal_acaba		;6b70   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	add ix,de		;6b73
	call canal_acaba		;6b75   ; canal_acaba: el canal IX se apaga; en los dos primeros, el ruido vuelve a su estado (0xE1AA)
	ret			;6b78
baja_volumen:		; con fundido, el volumen del canal IX menos 0xE1A5 (salvo con envolvente)
	ld a,(0e000h)		;6b79   ; los dos primeros tocan lo mismo?
	ld e,a			;6b7c
	ld a,(0e028h)		;6b7d   ; lee el canal 2 del PSG
	cp e			;6b80
	jr z,L_6B8E		;6b81
	ld a,(0e1a7h)		;6b83   ; solo la musica
	and 0f6h		;6b86
	ret z			;6b88
	bit 1,(ix+009h)		;6b89
	ret nz			;6b8d
L_6B8E:
	bit 2,(ix+00dh)		;6b8e   ; con envolvente del PSG, a cero
	jr nz,L_6BA6		;6b92
	bit 4,(ix+00fh)		;6b94   ; con su envolvente, nada
	ret nz			;6b98
	ld a,(0e1a5h)		;6b99   ; el volumen menos el fundido
	ld e,a			;6b9c
	ld a,(ix+00ch)		;6b9d
	sub e			;6ba0
	ret m			;6ba1   ; sin bajar de 0
	ld (ix+00ch),a		;6ba2
	ret			;6ba5
L_6BA6:
	ld (ix+00ch),000h		;6ba6
	ret			;6baa
empieza_nota:		; el periodo, los efectos a cero, la envolvente y el volumen de salida
	call periodo_con_desafino		;6bab   ; el periodo
	res 4,(ix+00eh)		;6bae
	ld a,(ix+00fh)		;6bb2   ; la envolvente desde el principio
	and 0e7h		;6bb5
	ld (ix+00fh),a		;6bb7
	xor a			;6bba   ; los contadores a cero
	ld (ix+01dh),a		;6bbb
	ld (ix+01eh),a		;6bbe
	ld (ix+01fh),a		;6bc1
	ld (ix+020h),a		;6bc4
	set 2,(ix+00fh)		;6bc7
	ld a,(ix+012h)		;6bcb   ; el volumen
	bit 6,(ix+00eh)		;6bce   ; con volumen relativo, menos IX+15
	jr z,L_6BDB		;6bd2
	ld e,(ix+015h)		;6bd4
	sub e			;6bd7
	call m,cero		;6bd8   ; cero: A = 0
L_6BDB:
	ld (ix+00ch),a		;6bdb   ; a IX+0C
	ld a,(0e1a7h)		;6bde   ; lee el canal que se esta tocando (1, 2, 4, 8...)
	cp 008h		;6be1
	jr nc,L_6BEA		;6be3
	bit 2,(ix+00dh)		;6be5   ; con envolvente del PSG, nada mas
	ret nz			;6be9
L_6BEA:
	bit 1,(ix+00fh)		;6bea   ; con IX+0F bit 1, el volumen empieza en 8
	ret z			;6bee
	ld (ix+00ch),008h		;6bef
	res 2,(ix+00fh)		;6bf3
	ret			;6bf7
cero:		; A = 0
	xor a			;6bf8
	ret			;6bf9
efectos_de_canal:		; mientras suena la nota: la bateria, el vibrato y la envolvente de volumen
	bit 0,(ix+00eh)		;6bfa   ; bateria
	call nz,paso_de_bateria		;6bfe   ; paso_de_bateria: al acabar la espera, el siguiente paso del golpe; 0xFF acaba
	bit 2,(ix+00eh)		;6c01   ; vibrato
	call nz,vibrato		;6c05   ; vibrato: cada IX+1B cuadros (IX+1A la primera vez) el periodo sube o baja IX+1C
	bit 0,(ix+00fh)		;6c08   ; envolvente de volumen
	call nz,envolvente		;6c0c   ; envolvente: el volumen de la envolvente (p04:6CA8) en IX+0C
	ret			;6c0f
paso_de_bateria:		; al acabar la espera, el siguiente paso del golpe; 0xFF acaba
	dec (ix+019h)		;6c10   ; la espera
	ret nz			;6c13
	ld l,(ix+017h)		;6c14   ; donde sigue
	ld h,(ix+018h)		;6c17
	ld a,(hl)			;6c1a
	cp 0ffh		;6c1b   ; 0xFF: se acabo
	jr z,L_6C23		;6c1d
	call sigue_bateria		;6c1f   ; sigue_bateria: lee el siguiente paso del golpe de bateria y guarda donde sigue (IX+17) y su espera (IX+19)
	ret			;6c22
L_6C23:
	res 0,(ix+00eh)		;6c23   ; sin bateria y sin tono
	ld (ix+00dh),000h		;6c27
	ret			;6c2b
periodo_con_desafino:		; IX+0A/IX+0B = el periodo IX+10/IX+11 (+ IX+25 con IX+0E bit 1)
	ld e,(ix+010h)		;6c2c   ; el periodo
	ld d,(ix+011h)		;6c2f
	bit 1,(ix+00eh)		;6c32   ; con desafino
	jr z,L_6C40		;6c36
	ld a,(ix+025h)		;6c38
	add a,e			;6c3b
	ld e,a			;6c3c
	jr nc,L_6C40		;6c3d
	inc d			;6c3f
L_6C40:
	ld (ix+00ah),e		;6c40   ; al periodo final
	ld (ix+00bh),d		;6c43
	ret			;6c46
vibrato:		; cada IX+1B cuadros (IX+1A la primera vez) el periodo sube o baja IX+1C
	inc (ix+01eh)		;6c47   ; la cuenta
	ld a,(ix+01eh)		;6c4a
	ld b,(ix+00eh)		;6c4d
	bit 4,b		;6c50   ; con espera la primera vez
	jr nz,L_6C66		;6c52
	bit 3,b		;6c54
	jr z,L_6C66		;6c56
	cp (ix+01ah)		;6c58   ; la espera
	ret nz			;6c5b
	ld (ix+01eh),000h		;6c5c
	set 4,(ix+00eh)		;6c60
	jr L_6C6A		;6c64
L_6C66:
	cp (ix+01bh)		;6c66   ; el periodo del vibrato
	ret nz			;6c69
L_6C6A:
	ld e,(ix+00ah)		;6c6a   ; el periodo
	ld d,(ix+00bh)		;6c6d
	ld b,(ix+01ch)		;6c70   ; la amplitud
	ld a,(ix+01dh)		;6c73   ; cada vez hacia un lado
	cpl			;6c76
	ld (ix+01dh),a		;6c77
	and a			;6c7a
	ld a,e			;6c7b
	jr nz,L_6C85		;6c7c
	add a,b			;6c7e   ; sube
	ld e,a			;6c7f
	jr nc,L_6C8A		;6c80
	inc d			;6c82
	jr L_6C8A		;6c83
L_6C85:
	sub b			;6c85   ; o baja
	ld e,a			;6c86
	jr nc,L_6C8A		;6c87
	dec d			;6c89
L_6C8A:
	ld (ix+00ah),e		;6c8a
	ld (ix+00bh),d		;6c8d
	ld (ix+01eh),000h		;6c90
	ret			;6c94
envolvente:		; el volumen de la envolvente (p04:6CA8) en IX+0C
	ld a,(0e1a7h)		;6c95   ; en el PSG con envolvente, nada
	cp 008h		;6c98
	jr nc,L_6CA1		;6c9a
	bit 2,(ix+00dh)		;6c9c
	ret nz			;6ca0
L_6CA1:
	call paso_de_envolvente		;6ca1   ; paso_de_envolvente: E = el volumen: sube hasta IX+12, baja, se sostiene y cae segun IX+0F e IX+21-IX+24
	ld (ix+00ch),e		;6ca4
	ret			;6ca7
paso_de_envolvente:		; E = el volumen: sube hasta IX+12, baja, se sostiene y cae segun IX+0F e IX+21-IX+24
	ld e,(ix+00ch)		;6ca8   ; el volumen
	inc (ix+01fh)		;6cab   ; la cuenta
	ld b,(ix+01fh)		;6cae
	bit 4,(ix+00fh)		;6cb1   ; bit 4: cae
	jr nz,L_6D06		;6cb5
	bit 3,(ix+00fh)		;6cb7   ; bit 3: se sostiene
	jr nz,L_6CEA		;6cbb
	bit 2,(ix+00fh)		;6cbd   ; bit 2: baja
	jr nz,L_6CD6		;6cc1
	ld a,e			;6cc3   ; sube hasta el de la nota
	inc a			;6cc4
	ld e,a			;6cc5
	cp (ix+012h)		;6cc6
	ret c			;6cc9
	set 2,(ix+00fh)		;6cca   ; arriba: a bajar
	ld e,(ix+012h)		;6cce
	ld (ix+01fh),000h		;6cd1
	ret			;6cd5
L_6CD6:
	ld a,e			;6cd6   ; baja uno
	dec a			;6cd7
	jp m,L_6CDC		;6cd8
	ld e,a			;6cdb
L_6CDC:
	ld a,b			;6cdc   ; durante IX+21 cuadros
	cp (ix+021h)		;6cdd
	ret c			;6ce0
	ld (ix+01fh),000h		;6ce1
	set 3,(ix+00fh)		;6ce5   ; luego se sostiene
	ret			;6ce9
L_6CEA:
	ld a,b			;6cea   ; cada IX+22 cuadros
	cp (ix+022h)		;6ceb
	ret nz			;6cee
	ld a,e			;6cef   ; uno menos
	dec a			;6cf0
	ret m			;6cf1
	ld e,a			;6cf2
	inc (ix+020h)		;6cf3   ; IX+23 veces
	ld a,(ix+020h)		;6cf6
	cp (ix+023h)		;6cf9
	ld (ix+01fh),000h		;6cfc
	ret nz			;6d00
	set 4,(ix+00fh)		;6d01   ; luego cae
	ret			;6d05
L_6D06:
	ld a,(ix+004h)		;6d06   ; al final de la nota (IX+24 cuadros antes)
	cp (ix+024h)		;6d09
	ret nc			;6d0c
	ld a,e			;6d0d   ; uno menos por cuadro
	dec a			;6d0e
	ret m			;6d0f
	ld e,a			;6d10
	ret			;6d11
orden:		; la orden 0xE0-0xFE de la partitura (p04:6D27); de 0xD0 a 0xDF, la octava o el volumen (p04:6F55)
	cp 0e0h		;6d12   ; 0xD0-0xDF aparte
	jp c,octava_o_volumen		;6d14   ; octava_o_volumen: 0xD0-0xD5: la octava (IX+16); 0xD6-0xDF: el volumen relativo
	and 01fh		;6d17   ; 0xE0-0xFE
	push hl			;6d19
	ld hl,06d27h		;6d1a   ; en p04:6D27
	add a,a			;6d1d
	ld e,a			;6d1e
	ld d,000h		;6d1f
	add hl,de			;6d21
	ld e,(hl)			;6d22
	inc hl			;6d23
	ld d,(hl)			;6d24
	ex de,hl			;6d25
	jp (hl)			;6d26   ; a la orden

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


orden_e0:		; 0xE0/0xE2: el modo IX+0D (bits 0-1) y la duracion IX+13
	pop hl			;6d65   ; HL = la partitura (la empujo p04:6D19)
modo_y_duracion:		; IX+0D = (HL) & 3 e IX+13 = el byte siguiente
	res 7,(ix+00eh)		;6d66   ; sin periodo directo
	ld a,(hl)			;6d6a   ; el modo
	and 003h		;6d6b
	ld (ix+00dh),a		;6d6d
	ld b,a			;6d70
	inc hl			;6d71   ; el byte siguiente
	ld a,(hl)			;6d72   ; la duracion
	ld (ix+013h),a		;6d73
	ld a,b			;6d76
	or a			;6d77   ; modo 0: el byte se vuelve a leer
	ret nz			;6d78
	dec hl			;6d79
	ret			;6d7a
orden_e1:		; 0xE1/0xE3: como 0xE0 y el ruido del canal en 0xE1AA
	pop hl			;6d7b   ; HL = la partitura (la empujo p04:6D19)
	ld a,(0e1a7h)		;6d7c   ; el canal 1 o el 2
	cp 001h		;6d7f
	ld a,(0e1aah)		;6d81   ; lee las banderas de ruido y envolvente del PSG
	jr nz,L_6D8F		;6d84
	set 0,a		;6d86   ; ruido en el 1
	res 1,a		;6d88
	ld (0e1aah),a		;6d8a   ; guarda las banderas de ruido y envolvente del PSG
	jr modo_y_duracion		;6d8d
L_6D8F:
	set 2,a		;6d8f   ; ruido en el 2
	res 3,a		;6d91
	ld (0e1aah),a		;6d93   ; guarda las banderas de ruido y envolvente del PSG
	jr modo_y_duracion		;6d96
orden_e4:		; 0xE4: el periodo del ruido (0xE1A8 o 0xE1A9)
	pop hl			;6d98   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6d99   ; el byte siguiente
	ld a,(hl)			;6d9a   ; el periodo del ruido
	and 01fh		;6d9b
	ld b,a			;6d9d
	ld a,(0e1a7h)		;6d9e   ; lee el canal que se esta tocando (1, 2, 4, 8...)
	cp 001h		;6da1
	ld a,b			;6da3
	jr nz,L_6DB4		;6da4
	ld (0e1a8h),a		;6da6   ; el del canal 1
	ld a,(0e1aah)		;6da9   ; lee las banderas de ruido y envolvente del PSG
	set 0,a		;6dac
	res 1,a		;6dae
	ld (0e1aah),a		;6db0   ; guarda las banderas de ruido y envolvente del PSG
	ret			;6db3
L_6DB4:
	ld (0e1a9h),a		;6db4   ; el del canal 2
	ld a,(0e1aah)		;6db7   ; lee las banderas de ruido y envolvente del PSG
	set 2,a		;6dba
	res 3,a		;6dbc
	ld (0e1aah),a		;6dbe   ; guarda las banderas de ruido y envolvente del PSG
	ret			;6dc1
orden_e5:		; 0xE5: la forma de la envolvente del PSG (0xE1AB) y sus dos bytes
	pop hl			;6dc2   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6dc3   ; el byte siguiente
	res 3,(ix+00dh)		;6dc4
	ld a,(hl)			;6dc8   ; la forma
	ld (0e1abh),a		;6dc9   ; guarda la forma de la envolvente del PSG
	ld de,0e1aah		;6dcc   ; apunta a las banderas de ruido y envolvente del PSG
	ld a,(de)			;6dcf   ; marcada
	set 5,a		;6dd0
	ld (de),a			;6dd2
	jr L_6DD6		;6dd3
orden_e6:		; 0xE6: el byte alto del periodo de la envolvente (0xE1AD) y el bajo
	pop hl			;6dd5   ; HL = la partitura (la empujo p04:6D19)
L_6DD6:
	inc hl			;6dd6   ; el byte siguiente
	ld a,(hl)			;6dd7   ; el byte alto
	ld (0e1adh),a		;6dd8   ; guarda el periodo de la envolvente (alto)
	ld de,0e1aah		;6ddb   ; apunta a las banderas de ruido y envolvente del PSG
	ld a,(de)			;6dde
	set 6,a		;6ddf
	ld (de),a			;6de1
	jr L_6DE5		;6de2
orden_e7:		; 0xE7: el byte bajo del periodo de la envolvente (0xE1AC) y la envolvente en el canal
	pop hl			;6de4   ; HL = la partitura (la empujo p04:6D19)
L_6DE5:
	inc hl			;6de5   ; el byte siguiente
	ld a,(hl)			;6de6   ; el byte bajo
	ld (0e1ach),a		;6de7   ; guarda el periodo de la envolvente (bajo)
	ld de,0e1aah		;6dea   ; apunta a las banderas de ruido y envolvente del PSG
	ld a,(de)			;6ded
	set 7,a		;6dee
	ld (de),a			;6df0
	set 2,(ix+00dh)		;6df1   ; con envolvente
	ret			;6df5
orden_e8:		; 0xE8: sin envolvente
	pop hl			;6df6   ; HL = la partitura (la empujo p04:6D19)
	ld de,0e1aah		;6df7   ; todo a cero
	xor a			;6dfa
	ld (de),a			;6dfb
	ld a,(ix+00dh)		;6dfc   ; sin envolvente
	and 0f3h		;6dff
	ld (ix+00dh),a		;6e01
	ret			;6e04
orden_e9:		; 0xE9: el tempo (IX+14)
	pop hl			;6e05   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e06   ; el byte siguiente
	ld a,(hl)			;6e07   ; el tempo
	ld (ix+014h),a		;6e08
	ret			;6e0b
orden_ea:		; 0xEA: el volumen (IX+15)
	pop hl			;6e0c   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e0d   ; el byte siguiente
	ld a,(hl)			;6e0e   ; el volumen
	ld (ix+015h),a		;6e0f
	ret			;6e12
orden_eb:		; 0xEB: repite hacia atras (veces, salto) con la cuenta IX+05
	pop hl			;6e13   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e14   ; el byte siguiente
	ld a,(ix+005h)		;6e15   ; la cuenta
	inc a			;6e18
	cp (hl)			;6e19   ; las veces?
	jr z,L_6E2A		;6e1a
	ld (ix+005h),a		;6e1c   ; una mas
	inc hl			;6e1f   ; el byte siguiente
	ld a,(hl)			;6e20   ; HL - el salto
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
	inc hl			;6e2a   ; acabado: sigue
	ld (ix+005h),000h		;6e2b
	ret			;6e2f
orden_ec:		; 0xEC: sin volumen relativo
	pop hl			;6e30   ; HL = la partitura (la empujo p04:6D19)
	res 6,(ix+00eh)		;6e31
	ret			;6e35
orden_ed:		; 0xED: la envolvente de volumen (IX+21-IX+24)
	pop hl			;6e36   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e37   ; el byte siguiente
	ld a,(ix+00fh)		;6e38   ; la envolvente desde el principio
	and 080h		;6e3b
	ld (ix+00fh),a		;6e3d
	ld a,(hl)			;6e40   ; la cifra alta: la subida
	and 0f0h		;6e41
	rrca			;6e43
	rrca			;6e44
	rrca			;6e45
	rrca			;6e46
	cp 008h		;6e47   ; de 8 en adelante, sin subida
	jr nc,L_6E4F		;6e49
	set 2,(ix+00fh)		;6e4b
L_6E4F:
	res 3,a		;6e4f
	inc a			;6e51
	bit 2,(ix+00fh)		;6e52
	jr nz,L_6E5C		;6e56
	set 1,(ix+00fh)		;6e58
L_6E5C:
	ld (ix+021h),a		;6e5c   ; IX+21
	ld a,(hl)			;6e5f   ; IX+22
	and 00fh		;6e60
	ld (ix+022h),a		;6e62
	inc hl			;6e65   ; el byte siguiente
	ld a,(hl)			;6e66   ; IX+23
	and 0f0h		;6e67
	rrca			;6e69
	rrca			;6e6a
	rrca			;6e6b
	rrca			;6e6c
	ld (ix+023h),a		;6e6d
	ld a,(hl)			;6e70   ; IX+24
	and 00fh		;6e71
	ld (ix+024h),a		;6e73
	set 0,(ix+00fh)		;6e76   ; en marcha
	ret			;6e7a
orden_ee:		; 0xEE: sin envolvente de volumen
	pop hl			;6e7b   ; HL = la partitura (la empujo p04:6D19)
	res 0,(ix+00fh)		;6e7c
	ret			;6e80
orden_ef:		; 0xEF: el desafino (IX+25)
	pop hl			;6e81   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e82   ; el byte siguiente
	ld a,(hl)			;6e83   ; el desafino
	ld (ix+025h),a		;6e84
	set 1,(ix+00eh)		;6e87
	ret			;6e8b
orden_f0:		; 0xF0: sin desafino
	pop hl			;6e8c   ; HL = la partitura (la empujo p04:6D19)
	res 1,(ix+00eh)		;6e8d
	ret			;6e91
orden_f1:		; 0xF1: el vibrato (periodo IX+1B, amplitud IX+1C)
	pop hl			;6e92   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6e93   ; el byte siguiente
	ld a,(ix+00eh)		;6e94   ; vibrato con espera
	or 014h		;6e97
	ld (ix+00eh),a		;6e99
	ld a,(hl)			;6e9c   ; la amplitud
	and 00fh		;6e9d
	ld (ix+01ch),a		;6e9f
	ld a,(hl)			;6ea2   ; el periodo
	and 0f0h		;6ea3
	rrca			;6ea5
	rrca			;6ea6
	rrca			;6ea7
	rrca			;6ea8
	ld (ix+01bh),a		;6ea9
	ret			;6eac
orden_f2:		; 0xF2: sin vibrato
	pop hl			;6ead   ; HL = la partitura (la empujo p04:6D19)
	ld a,(ix+00eh)		;6eae   ; sin vibrato
	and 0e2h		;6eb1
	ld (ix+00eh),a		;6eb3
	ret			;6eb6
orden_f3:		; 0xF3: la espera del vibrato (IX+1A)
	pop hl			;6eb7   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6eb8   ; el byte siguiente
	ld a,(hl)			;6eb9   ; la espera
	ld (ix+01ah),a		;6eba
	ld a,(ix+00eh)		;6ebd
	or 00ch		;6ec0
	ld (ix+00eh),a		;6ec2
	ret			;6ec5
orden_f4:		; 0xF4: el vibrato sin espera
	pop hl			;6ec6   ; HL = la partitura (la empujo p04:6D19)
	res 3,(ix+00eh)		;6ec7
	ret			;6ecb
orden_f5:		; 0xF5: notas con periodo directo
	pop hl			;6ecc   ; HL = la partitura (la empujo p04:6D19)
	set 7,(ix+00eh)		;6ecd
	ret			;6ed1
orden_f6:		; 0xF6: sin periodo directo
	pop hl			;6ed2   ; HL = la partitura (la empujo p04:6D19)
	ld a,(ix+00eh)		;6ed3
	and 05fh		;6ed6
	ld (ix+00eh),a		;6ed8
	ret			;6edb
orden_f7:		; 0xF7: IX+0E bit 5
	pop hl			;6edc   ; HL = la partitura (la empujo p04:6D19)
	set 5,(ix+00eh)		;6edd
	ret			;6ee1
orden_f8:		; 0xF8: la forma de onda del SCC (p04:6000) en IX+26
	pop hl			;6ee2   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6ee3   ; el byte siguiente
	ld a,(hl)			;6ee4   ; la onda
	ld de,06000h		;6ee5   ; en p04:6000
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
	set 7,(ix+00fh)		;6ef7   ; la onda nueva
	ret			;6efb
orden_f9:		; 0xF9: llama a otro trozo de partitura (vuelta en IX+07)
	pop hl			;6efc   ; HL = la partitura (la empujo p04:6D19)
	call salto		;6efd   ; la direccion
	ld (ix+007h),e		;6f00   ; la vuelta
	ld (ix+008h),d		;6f03
	ret			;6f06
orden_fa:		; 0xFA: vuelve de la llamada
	pop hl			;6f07   ; HL = la partitura (la empujo p04:6D19)
	ld l,(ix+007h)		;6f08   ; de vuelta
	ld h,(ix+008h)		;6f0b
	ret			;6f0e
orden_fb:		; 0xFB: repite (veces, direccion) con la cuenta IX+05
	pop hl			;6f0f   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6f10   ; el byte siguiente
	ld a,(ix+005h)		;6f11   ; la cuenta
	inc a			;6f14
	cp (hl)			;6f15   ; las veces?
	jr z,L_6F22		;6f16
	ld (ix+005h),a		;6f18
salto:		; HL = la direccion que va detras, menos 1
	inc hl			;6f1b   ; el byte siguiente
	ld e,(hl)			;6f1c   ; la direccion
	inc hl			;6f1d   ; el byte siguiente
	ld d,(hl)			;6f1e
	ex de,hl			;6f1f
	dec hl			;6f20
	ret			;6f21
L_6F22:
	inc hl			;6f22   ; acabado: sigue
	inc hl			;6f23   ; el byte siguiente
	ld (ix+005h),000h		;6f24
	ret			;6f28
orden_fc:		; 0xFC: repite (veces, direccion) con la cuenta IX+06
	pop hl			;6f29   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6f2a   ; el byte siguiente
	ld a,(ix+006h)		;6f2b   ; la otra cuenta
	inc a			;6f2e
	cp (hl)			;6f2f
	jr z,L_6F37		;6f30
	ld (ix+006h),a		;6f32
	jr salto		;6f35
L_6F37:
	inc hl			;6f37   ; el byte siguiente
	inc hl			;6f38   ; el byte siguiente
	ld (ix+006h),000h		;6f39
	ret			;6f3d
orden_fd:		; 0xFD: salta a la direccion que va detras
	pop hl			;6f3e   ; HL = la partitura (la empujo p04:6D19)
	jr salto		;6f3f
orden_fe:		; 0xFE: el modo IX+09 (4: bateria, todo a cero)
	pop hl			;6f41   ; HL = la partitura (la empujo p04:6D19)
	inc hl			;6f42   ; el byte siguiente
	ld a,(hl)			;6f43   ; el modo
	ld (ix+009h),a		;6f44
	cp 004h		;6f47   ; 4: todo a cero
	ret nz			;6f49
	xor a			;6f4a
	ld (ix+00dh),a		;6f4b
	ld (ix+00eh),a		;6f4e
	ld (ix+00fh),a		;6f51
	ret			;6f54
octava_o_volumen:		; 0xD0-0xD5: la octava (IX+16); 0xD6-0xDF: el volumen relativo
	ld a,(hl)			;6f55   ; la cifra baja
	and 00fh		;6f56
	cp 006h		;6f58   ; 0-5: la octava
	jr nc,L_6F60		;6f5a
	ld (ix+016h),a		;6f5c
	ret			;6f5f
L_6F60:
	set 6,(ix+00eh)		;6f60   ; 6-15: volumen relativo
	sub 005h		;6f64
	ld (ix+015h),a		;6f66
	ret			;6f69
registros_de_sonido:		; los del PSG y los del SCC
	call registros_del_psg		;6f6a   ; registros_del_psg: tonos y volumenes, el ruido, la envolvente y el mezclador
	call registros_del_scc		;6f6d   ; registros_del_scc: los cambios de los 5 canales del SCC: periodos y volumenes, canales encendidos y formas de onda
	ret			;6f70
registros_del_psg:		; tonos y volumenes, el ruido, la envolvente y el mezclador
	call tonos_del_psg		;6f71   ; tonos_del_psg: los periodos y volumenes de los 3 canales del PSG (0xE00A, 0xE032, 0xE05A)
	call ruido_del_psg		;6f74   ; ruido_del_psg: el registro 6 (ruido) con 0xE1A8 o 0xE1A9 si han cambiado
	call envolvente_del_psg		;6f77   ; envolvente_del_psg: los registros 11, 12 y 13 (la envolvente) si han cambiado
	call mezclador_del_psg		;6f7a   ; mezclador_del_psg: el registro 7 (tono y ruido de los 3 canales) segun el modo de cada uno (p04:703E)
	ret			;6f7d
tonos_del_psg:		; los periodos y volumenes de los 3 canales del PSG (0xE00A, 0xE032, 0xE05A)
	ld b,000h		;6f7e   ; registros 0, 1 y 8
	ld c,008h		;6f80
	ld hl,0e00ah		;6f82
	call tono_de_un_canal		;6f85   ; tono_de_un_canal: registros B y B + 1 (periodo) y C (volumen) del canal HL; con envolvente, el volumen una vez
	ld hl,0e032h		;6f88   ; 2, 3 y 9
	call tono_de_un_canal		;6f8b   ; tono_de_un_canal: registros B y B + 1 (periodo) y C (volumen) del canal HL; con envolvente, el volumen una vez
	ld hl,0e05ah		;6f8e   ; 4, 5 y 10
	call tono_de_un_canal		;6f91   ; tono_de_un_canal: registros B y B + 1 (periodo) y C (volumen) del canal HL; con envolvente, el volumen una vez
	ret			;6f94
tono_de_un_canal:		; registros B y B + 1 (periodo) y C (volumen) del canal HL; con envolvente, el volumen una vez
	ld e,(hl)			;6f95   ; el periodo, byte bajo
	ld a,b			;6f96
	call 00093h		;6f97   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6f9a
	inc b			;6f9b
	ld e,(hl)			;6f9c   ; el alto
	ld a,b			;6f9d
	call 00093h		;6f9e   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6fa1
	ld e,(hl)			;6fa2   ; el volumen
	ld a,c			;6fa3
	inc b			;6fa4
	inc c			;6fa5
	inc hl			;6fa6
	bit 3,(hl)		;6fa7   ; con envolvente ya puesto, no
	ret nz			;6fa9
	call 00093h		;6faa   ; BIOS WRTPSG - Writes data to PSG-register
	bit 2,(hl)		;6fad   ; con envolvente, una vez
	ret z			;6faf
	set 3,(hl)		;6fb0
	ret			;6fb2
ruido_del_psg:		; el registro 6 (ruido) con 0xE1A8 o 0xE1A9 si han cambiado
	ld hl,0e1aah		;6fb3   ; el ruido del canal 1
	bit 0,(hl)		;6fb6
	jr z,L_6FC8		;6fb8
	res 0,(hl)		;6fba
	set 1,(hl)		;6fbc
	ld a,(0e1a8h)		;6fbe   ; al registro 6
	ld e,a			;6fc1
	ld a,006h		;6fc2
	call 00093h		;6fc4   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6fc7
L_6FC8:
	bit 1,(hl)		;6fc8   ; el del canal 2
	ret nz			;6fca
	bit 2,(hl)		;6fcb
	ret z			;6fcd
	res 2,(hl)		;6fce
	set 3,(hl)		;6fd0
	ld a,(0e1a9h)		;6fd2   ; al registro 6
	ld e,a			;6fd5
	ld a,006h		;6fd6
	call 00093h		;6fd8   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6fdb
envolvente_del_psg:		; los registros 11, 12 y 13 (la envolvente) si han cambiado
	ld hl,0e1aah		;6fdc   ; la envolvente ha cambiado?
	bit 7,(hl)		;6fdf
	ret z			;6fe1
	res 7,(hl)		;6fe2
	ld a,(0e1ach)		;6fe4   ; el byte bajo, registro 11
	ld e,a			;6fe7
	ld a,00bh		;6fe8
	call 00093h		;6fea   ; BIOS WRTPSG - Writes data to PSG-register
	bit 6,(hl)		;6fed
	ret z			;6fef
	res 6,(hl)		;6ff0
	ld a,(0e1adh)		;6ff2   ; el alto, registro 12
	ld e,a			;6ff5
	ld a,00ch		;6ff6
	call 00093h		;6ff8   ; BIOS WRTPSG - Writes data to PSG-register
	bit 5,(hl)		;6ffb
	ret z			;6ffd
	res 5,(hl)		;6ffe
	ld a,(0e1abh)		;7000   ; la forma, registro 13
	ld e,a			;7003
	ld a,00dh		;7004
	call 00093h		;7006   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;7009
mezclador_del_psg:		; el registro 7 (tono y ruido de los 3 canales) segun el modo de cada uno (p04:703E)
	ld hl,0e00dh		;700a   ; el modo del canal 1
	ld a,(hl)			;700d
	ld hl,0703eh		;700e
	call mezcla_del_modo		;7011   ; mezcla_del_modo: HL + IX+0D & 3
	ld b,(hl)			;7014
	ld hl,0e035h		;7015   ; el del 2
	ld a,(hl)			;7018
	ld hl,07042h		;7019
	call mezcla_del_modo		;701c   ; mezcla_del_modo: HL + IX+0D & 3
	ld c,(hl)			;701f
	ld hl,0e05dh		;7020   ; el del 3
	ld a,(hl)			;7023
	ld hl,07046h		;7024
	call mezcla_del_modo		;7027   ; mezcla_del_modo: HL + IX+0D & 3
	ld a,(hl)			;702a   ; los tres juntos
	or b			;702b
	or c			;702c
pon_mezclador:		; el registro 7 del PSG con A (y su copia 0xE1A6)
	ld e,a			;702d
	ld (0e1a6h),a		;702e   ; la copia
	ld a,007h		;7031   ; al registro 7
	call 00093h		;7033   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;7036
mezcla_del_modo:		; HL + IX+0D & 3
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


registros_del_scc:		; los cambios de los 5 canales del SCC: periodos y volumenes, canales encendidos y formas de onda
	call cambios_del_scc		;704a   ; cambios_del_scc: compara cada periodo y volumen de los canales del SCC con sus copias (0xE1B0, 0xE1BA) y marca los que cambian (0xE1AE-0xE1AF)
	call canales_del_scc		;704d   ; canales_del_scc: los canales del SCC que suenan (bits en 0xE1BF); 0xE1AF bit 7 si cambian
	call escribe_el_scc		;7050   ; escribe_el_scc: los 16 registros del SCC (0x9880-0x988F) que han cambiado
	call ondas_del_scc		;7053   ; ondas_del_scc: las formas de onda nuevas de los canales 1-4 del SCC (0x9800-0x987F)
	ret			;7056
cambios_del_scc:		; compara cada periodo y volumen de los canales del SCC con sus copias (0xE1B0, 0xE1BA) y marca los que cambian (0xE1AE-0xE1AF)
	ld ix,0e1aeh		;7057   ; los cambios
	ld bc,0e1bah		;705b   ; apunta a la copia de los volumenes del SCC
	ld de,0e1b0h		;705e   ; apunta a la copia de los periodos y volumenes del SCC
	ld hl,0e082h		;7061   ; el canal 1 del SCC
	ld a,(de)			;7064   ; periodo bajo
	res 0,(ix+000h)		;7065   ; sin cambio de momento
	cp (hl)			;7069   ; igual que la copia?
	jr z,L_7072		;706a
	set 0,(ix+000h)		;706c   ; ha cambiado
	ld a,(hl)			;7070   ; el valor nuevo
	ld (de),a			;7071   ; la copia nueva
L_7072:
	inc de			;7072
	inc hl			;7073
	ld a,(de)			;7074   ; periodo alto
	res 1,(ix+000h)		;7075   ; sin cambio de momento
	cp (hl)			;7079   ; igual que la copia?
	jr z,L_7082		;707a
	set 1,(ix+000h)		;707c   ; ha cambiado
	ld a,(hl)			;7080   ; el valor nuevo
	ld (de),a			;7081   ; la copia nueva
L_7082:
	inc de			;7082
	inc hl			;7083
	res 2,(ix+001h)		;7084   ; sin cambio de momento
	ld a,(bc)			;7088   ; volumen
	cp (hl)			;7089   ; igual que la copia?
	jr z,L_7092		;708a
	set 2,(ix+001h)		;708c   ; ha cambiado
	ld a,(hl)			;7090   ; el valor nuevo
	ld (bc),a			;7091   ; la copia nueva
L_7092:
	inc bc			;7092
	ld hl,0e0aah		;7093   ; el canal 2
	ld a,(de)			;7096
	res 2,(ix+000h)		;7097   ; sin cambio de momento
	cp (hl)			;709b   ; igual que la copia?
	jr z,L_70A4		;709c
	set 2,(ix+000h)		;709e   ; ha cambiado
	ld a,(hl)			;70a2   ; el valor nuevo
	ld (de),a			;70a3   ; la copia nueva
L_70A4:
	inc de			;70a4
	inc hl			;70a5
	ld a,(de)			;70a6
	res 3,(ix+000h)		;70a7   ; sin cambio de momento
	cp (hl)			;70ab   ; igual que la copia?
	jr z,L_70B4		;70ac
	set 3,(ix+000h)		;70ae   ; ha cambiado
	ld a,(hl)			;70b2   ; el valor nuevo
	ld (de),a			;70b3   ; la copia nueva
L_70B4:
	inc de			;70b4
	inc hl			;70b5
	res 3,(ix+001h)		;70b6   ; sin cambio de momento
	ld a,(bc)			;70ba
	cp (hl)			;70bb   ; igual que la copia?
	jr z,L_70C4		;70bc
	set 3,(ix+001h)		;70be   ; ha cambiado
	ld a,(hl)			;70c2   ; el valor nuevo
	ld (bc),a			;70c3   ; la copia nueva
L_70C4:
	inc bc			;70c4
	ld hl,0e0d2h		;70c5   ; el canal 3
	ld a,(de)			;70c8
	res 4,(ix+000h)		;70c9   ; sin cambio de momento
	cp (hl)			;70cd   ; igual que la copia?
	jr z,L_70D6		;70ce
	set 4,(ix+000h)		;70d0   ; ha cambiado
	ld a,(hl)			;70d4   ; el valor nuevo
	ld (de),a			;70d5   ; la copia nueva
L_70D6:
	inc de			;70d6
	inc hl			;70d7
	ld a,(de)			;70d8
	res 5,(ix+000h)		;70d9   ; sin cambio de momento
	cp (hl)			;70dd   ; igual que la copia?
	jr z,L_70E6		;70de
	set 5,(ix+000h)		;70e0   ; ha cambiado
	ld a,(hl)			;70e4   ; el valor nuevo
	ld (de),a			;70e5   ; la copia nueva
L_70E6:
	inc de			;70e6
	inc hl			;70e7
	res 4,(ix+001h)		;70e8   ; sin cambio de momento
	ld a,(bc)			;70ec
	cp (hl)			;70ed   ; igual que la copia?
	jr z,L_70F6		;70ee
	set 4,(ix+001h)		;70f0   ; ha cambiado
	ld a,(hl)			;70f4   ; el valor nuevo
	ld (bc),a			;70f5   ; la copia nueva
L_70F6:
	inc bc			;70f6
	ld hl,0e0fah		;70f7   ; el canal 4
	ld a,(de)			;70fa
	res 6,(ix+000h)		;70fb   ; sin cambio de momento
	cp (hl)			;70ff   ; igual que la copia?
	jr z,L_7108		;7100
	set 6,(ix+000h)		;7102   ; ha cambiado
	ld a,(hl)			;7106   ; el valor nuevo
	ld (de),a			;7107   ; la copia nueva
L_7108:
	inc de			;7108
	inc hl			;7109
	ld a,(de)			;710a
	res 7,(ix+000h)		;710b   ; sin cambio de momento
	cp (hl)			;710f   ; igual que la copia?
	jr z,L_7118		;7110
	set 7,(ix+000h)		;7112   ; ha cambiado
	ld a,(hl)			;7116   ; el valor nuevo
	ld (de),a			;7117   ; la copia nueva
L_7118:
	inc de			;7118
	inc hl			;7119
	res 5,(ix+001h)		;711a   ; sin cambio de momento
	ld a,(bc)			;711e
	cp (hl)			;711f   ; igual que la copia?
	jr z,L_7128		;7120
	set 5,(ix+001h)		;7122   ; ha cambiado
	ld a,(hl)			;7126   ; el valor nuevo
	ld (bc),a			;7127   ; la copia nueva
L_7128:
	inc bc			;7128
	ld hl,0e122h		;7129   ; el canal 5
	ld a,(de)			;712c
	res 0,(ix+001h)		;712d   ; sin cambio de momento
	cp (hl)			;7131   ; igual que la copia?
	jr z,L_713A		;7132
	set 0,(ix+001h)		;7134   ; ha cambiado
	ld a,(hl)			;7138   ; el valor nuevo
	ld (de),a			;7139   ; la copia nueva
L_713A:
	inc de			;713a
	inc hl			;713b
	ld a,(de)			;713c
	res 1,(ix+001h)		;713d   ; sin cambio de momento
	cp (hl)			;7141   ; igual que la copia?
	jr z,L_714A		;7142
	set 1,(ix+001h)		;7144   ; ha cambiado
	ld a,(hl)			;7148   ; el valor nuevo
	ld (de),a			;7149   ; la copia nueva
L_714A:
	inc de			;714a
	inc hl			;714b
	res 6,(ix+001h)		;714c   ; sin cambio de momento
	ld a,(bc)			;7150
	cp (hl)			;7151   ; igual que la copia?
	jr z,L_715A		;7152
	set 6,(ix+001h)		;7154   ; ha cambiado
	ld a,(hl)			;7158   ; el valor nuevo
	ld (bc),a			;7159   ; la copia nueva
L_715A:
	inc bc			;715a
	ret			;715b
canales_del_scc:		; los canales del SCC que suenan (bits en 0xE1BF); 0xE1AF bit 7 si cambian
	ld e,000h		;715c   ; los canales que suenan
	ld hl,0e085h		;715e   ; el 1 (bit 0)
	ld c,001h		;7161
	ld a,(hl)			;7163   ; su volumen
	or a			;7164
	jr z,L_7168		;7165
	ld a,c			;7167   ; suena: su bit
L_7168:
	or e			;7168
	ld e,a			;7169
	ld hl,0e0adh		;716a   ; el 2
	sla c		;716d   ; el bit siguiente
	ld a,(hl)			;716f   ; su volumen
	or a			;7170
	jr z,L_7174		;7171
	ld a,c			;7173   ; suena: su bit
L_7174:
	or e			;7174
	ld e,a			;7175
	ld hl,0e0d5h		;7176   ; el 3
	sla c		;7179   ; el bit siguiente
	ld a,(hl)			;717b   ; su volumen
	or a			;717c
	jr z,L_7180		;717d
	ld a,c			;717f   ; suena: su bit
L_7180:
	or e			;7180
	ld e,a			;7181
	ld hl,0e0fdh		;7182   ; el 4
	sla c		;7185   ; el bit siguiente
	ld a,(hl)			;7187   ; su volumen
	or a			;7188
	jr z,L_718C		;7189
	ld a,c			;718b   ; suena: su bit
L_718C:
	or e			;718c
	ld e,a			;718d
	ld hl,0e125h		;718e   ; el 5
	sla c		;7191   ; el bit siguiente
	ld a,(hl)			;7193   ; su volumen
	or a			;7194
	jr z,L_7198		;7195
	ld a,c			;7197   ; suena: su bit
L_7198:
	or e			;7198
	ld e,a			;7199
	ld hl,0e1bfh		;719a   ; han cambiado?
	ld a,(hl)			;719d
	cp e			;719e
	jr z,L_71A8		;719f
	ld (hl),e			;71a1
	ld hl,0e1afh		;71a2
	set 7,(hl)		;71a5   ; marcado
	ret			;71a7
L_71A8:
	ld hl,0e1afh		;71a8
	res 7,(hl)		;71ab
	ret			;71ad
escribe_el_scc:		; los 16 registros del SCC (0x9880-0x988F) que han cambiado
	ld ix,0e1aeh		;71ae   ; los 16 registros
	ld hl,0e1b0h		;71b2   ; apunta a la copia de los periodos y volumenes del SCC
	ld de,09880h		;71b5   ; desde 0x9880
	ld b,010h		;71b8
	ld c,001h		;71ba
L_71BC:
	ld a,(ix+000h)		;71bc
	and c			;71bf   ; ha cambiado?
	push bc			;71c0
	call nz,un_registro_del_scc		;71c1   ; un_registro_del_scc: el registro DE del SCC con (HL): el SCC en 0x8000 (0x3F) y luego el banco 2
	pop bc			;71c4
	inc hl			;71c5
	inc de			;71c6
	rlc c		;71c7   ; el siguiente bit
	ld a,b			;71c9   ; a los 8, el otro byte de cambios
	cp 009h		;71ca
	jr nz,L_71D0		;71cc
	inc ix		;71ce
L_71D0:
	djnz L_71BC		;71d0
	ret			;71d2
un_registro_del_scc:		; el registro DE del SCC con (HL): el SCC en 0x8000 (0x3F) y luego el banco 2
	ld a,(hl)			;71d3
	ld c,a			;71d4
	ld a,03fh		;71d5   ; el SCC en 0x8000
	ld (09000h),a		;71d7   ; el mapper: pone en 0x8000 el banco de A
	ld a,c			;71da
	ld (de),a			;71db   ; el registro
	ld a,002h		;71dc   ; y el banco 2 en 0x8000 (no el 5)
	ld (09000h),a		;71de   ; el mapper: pone en 0x8000 el banco de A
	ret			;71e1
ondas_del_scc:		; las formas de onda nuevas de los canales 1-4 del SCC (0x9800-0x987F)
	ld hl,0e087h		;71e2   ; la onda nueva del canal 1?
	bit 7,(hl)		;71e5
	jr z,L_71F8		;71e7
	res 7,(hl)		;71e9   ; atendida
	ld hl,0e09eh		;71eb   ; su puntero
	ld e,(hl)			;71ee   ; el puntero de la onda
	inc hl			;71ef
	ld d,(hl)			;71f0
	ex de,hl			;71f1   ; HL = la onda
	ld de,09800h		;71f2   ; a 0x9800
	call pon_onda		;71f5   ; pon_onda: 32 bytes de HL a la forma de onda DE del SCC, con los canales apagados mientras
L_71F8:
	ld hl,0e0afh		;71f8   ; la del canal 2
	bit 7,(hl)		;71fb
	jr z,L_720E		;71fd
	res 7,(hl)		;71ff   ; atendida
	ld hl,0e0c6h		;7201
	ld e,(hl)			;7204   ; el puntero de la onda
	inc hl			;7205
	ld d,(hl)			;7206
	ex de,hl			;7207   ; HL = la onda
	ld de,09820h		;7208   ; a 0x9820
	call pon_onda		;720b   ; pon_onda: 32 bytes de HL a la forma de onda DE del SCC, con los canales apagados mientras
L_720E:
	ld hl,0e0d7h		;720e   ; la del canal 3
	bit 7,(hl)		;7211
	jr z,L_7224		;7213
	res 7,(hl)		;7215   ; atendida
	ld hl,0e0eeh		;7217
	ld e,(hl)			;721a   ; el puntero de la onda
	inc hl			;721b
	ld d,(hl)			;721c
	ex de,hl			;721d   ; HL = la onda
	ld de,09840h		;721e   ; a 0x9840
	call pon_onda		;7221   ; pon_onda: 32 bytes de HL a la forma de onda DE del SCC, con los canales apagados mientras
L_7224:
	ld hl,0e0ffh		;7224   ; la del canal 4
	bit 7,(hl)		;7227
	ret z			;7229
	res 7,(hl)		;722a   ; atendida
	ld hl,0e116h		;722c
	ld e,(hl)			;722f   ; el puntero de la onda
	inc hl			;7230
	ld d,(hl)			;7231
	ex de,hl			;7232   ; HL = la onda
	ld de,09860h		;7233   ; a 0x9860
pon_onda:		; 32 bytes de HL a la forma de onda DE del SCC, con los canales apagados mientras
	ld a,03fh		;7236   ; el SCC en 0x8000
	ld (09000h),a		;7238   ; el mapper: pone en 0x8000 el banco de A
	xor a			;723b   ; canales apagados
	ld (0988fh),a		;723c
	ld b,020h		;723f   ; 32 muestras
L_7241:
	ld a,(hl)			;7241
	ld (de),a			;7242
	inc hl			;7243
	inc de			;7244
	djnz L_7241		;7245
	ld hl,0988fh		;7247   ; los canales como estaban
	ld de,0e1bfh		;724a   ; apunta a los canales del SCC que suenan
	ld a,(de)			;724d
	ld (hl),a			;724e
	ld a,002h		;724f   ; y el banco 2
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

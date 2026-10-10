; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 13 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS metabloques_comunes: los 4 metabloques comunes (16 bytes, 4 x 4
;   caracteres por filas), numeros 0-3 en todas las fases salvo la 0 y la 8
;   (p00:48DD); lo leen p00:48DD (64 bytes)
;   0x6000..0x6040  (64 bytes)
DATA_metabloques_comunes:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h	; 6000  ................
	defb 000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,0feh	; 6010  ................
	defb 000h,000h,000h,000h,0feh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6020  ................
	defb 000h,000h,000h,0ffh,000h,000h,000h,000h,0feh,000h,000h,000h,000h,000h,000h,000h	; 6030  ................

; ----------------------------------------------------------------------
; DATOS metabloques_6040: 23 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 1; lo leen p00:490A (368 bytes)
;   0x6040..0x61b0  (368 bytes)
DATA_metabloques_6040:
	defb 0ffh,000h,000h,000h,000h,000h,000h,02ch,000h,02ch,031h,02bh,0ffh,02ah,02dh,032h	; 6040  .......,.,1+.*-2
	defb 000h,000h,000h,000h,031h,000h,0feh,000h,030h,02ch,031h,000h,02dh,032h,02fh,000h	; 6050  ....1...0,1.-2/.
	defb 024h,022h,023h,024h,020h,021h,026h,027h,000h,020h,025h,000h,000h,000h,000h,000h	; 6060  $"#$ !&'. %.....
	defb 024h,022h,023h,024h,020h,021h,020h,025h,000h,0c1h,000h,000h,000h,000h,000h,000h	; 6070  $"#$ ! %........
	defb 000h,000h,000h,000h,000h,0feh,000h,000h,000h,000h,02ch,031h,000h,000h,02ah,02dh	; 6080  ..........,1..*-
	defb 000h,000h,000h,0ffh,0feh,000h,000h,000h,02bh,029h,029h,030h,032h,02dh,032h,02dh	; 6090  ........+))02-2-
	defb 000h,000h,000h,000h,000h,000h,000h,0ffh,02ch,031h,000h,000h,032h,02fh,000h,000h	; 60a0  ........,1..2/..
	defb 024h,023h,023h,022h,02ch,02bh,033h,02eh,000h,02ah,02dh,032h,000h,02ch,029h,031h	; 60b0  $##",+3..*-2.,)1
	defb 022h,024h,023h,024h,033h,02eh,030h,031h,02dh,032h,02fh,000h,02ch,029h,031h,000h	; 60c0  "$#$3.01-2/.,)1.
	defb 000h,000h,000h,000h,000h,000h,0feh,000h,000h,000h,000h,000h,000h,0c5h,025h,000h	; 60d0  ..............%.
	defb 023h,022h,024h,028h,033h,02eh,033h,02eh,02bh,029h,029h,030h,02ch,02bh,030h,031h	; 60e0  #"$(3.3.+))0,+01
	defb 000h,000h,000h,000h,000h,000h,000h,000h,038h,054h,015h,017h,01ah,018h,07eh,016h	; 60f0  ........8T....~.
	defb 057h,01ch,01eh,01bh,01dh,01eh,01fh,06ch,05ah,05bh,083h,082h,018h,05dh,085h,01ah	; 6100  W......lZ[...]..
	defb 05eh,07dh,087h,086h,023h,024h,028h,024h,000h,000h,000h,000h,000h,000h,000h,000h	; 6110  ^}..#$($........
	defb 028h,020h,024h,021h,01ch,05fh,087h,07dh,01eh,015h,016h,017h,018h,019h,01ah,01bh	; 6120  ( $!._.}........
	defb 041h,058h,080h,07fh,0b3h,045h,081h,06ch,0b4h,0b3h,083h,082h,0b7h,0b1h,085h,0bbh	; 6130  AX...E.l........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,038h,054h,062h,060h,055h,03eh,07eh,07dh	; 6140  ........8Tb`U>~}
	defb 023h,023h,024h,023h,041h,058h,080h,07fh,044h,045h,081h,06ch,05ah,05bh,083h,082h	; 6150  ##$#AX..DE.lZ[..
	defb 05ch,05dh,085h,084h,05eh,05fh,087h,086h,052h,053h,07bh,07ah,000h,000h,000h,000h	; 6160  \]..^_..RS{z....
	defb 023h,024h,023h,024h,026h,020h,025h,027h,057h,01eh,025h,06ch,05ah,05bh,083h,06ch	; 6170  #$#$& %'W.%lZ[.l
	defb 023h,024h,024h,024h,020h,020h,021h,026h,000h,000h,020h,026h,000h,000h,000h,020h	; 6180  #$$$  !&.. &...
	defb 024h,023h,028h,023h,021h,025h,000h,000h,025h,000h,000h,000h,000h,000h,000h,000h	; 6190  $#(#!%..%.......
	defb 023h,024h,024h,023h,05eh,05fh,017h,063h,052h,053h,016h,07ah,000h,000h,000h,000h	; 61a0  #$$#^_.cRS.z....

; ----------------------------------------------------------------------
; DATOS medios_6040: 28 metabloques de 8 bytes de la fase 1 (del 23 al 50;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (224 bytes)
;   0x61b0..0x6290  (224 bytes)
DATA_medios_6040:
	defb 000h,000h,0c1h,000h,088h,024h,022h,024h	; 61b0  .....$"$
	defb 000h,000h,0c1h,0c3h,023h,028h,022h,024h	; 61b8  ....#("$
	defb 020h,021h,026h,027h,022h,024h,024h,024h	; 61c0   !&'"$$$
	defb 0c5h,0c4h,000h,000h,022h,024h,028h,023h	; 61c8  ...."$(#
	defb 000h,000h,000h,0c5h,024h,028h,024h,022h	; 61d0  ....$($"
	defb 000h,0c4h,0c3h,000h,028h,024h,022h,089h	; 61d8  ....($".
	defb 02ch,02bh,02eh,033h,022h,028h,023h,024h	; 61e0  ,+.3"(#$
	defb 02eh,033h,030h,031h,028h,024h,024h,028h	; 61e8  .301($$(
	defb 000h,02ch,02bh,033h,028h,024h,023h,022h	; 61f0  .,+3($#"
	defb 02eh,033h,02eh,033h,024h,024h,023h,028h	; 61f8  .3.3$$#(
	defb 02eh,030h,031h,000h,024h,023h,024h,022h	; 6200  .01.$#$"
	defb 088h,024h,022h,023h,000h,0c5h,0c5h,000h	; 6208  .$"#....
	defb 028h,022h,023h,022h,000h,0c4h,000h,0c5h	; 6210  ("#"....
	defb 024h,023h,024h,024h,000h,000h,000h,0c3h	; 6218  $#$$....
	defb 022h,024h,023h,028h,0c4h,000h,000h,000h	; 6220  "$#(....
	defb 023h,022h,024h,024h,000h,0c5h,0c1h,0c3h	; 6228  #"$$....
	defb 022h,024h,028h,089h,0c5h,0c1h,000h,000h	; 6230  "$(.....
	defb 024h,022h,023h,028h,000h,000h,000h,000h	; 6238  $"#(....
	defb 024h,022h,023h,022h,000h,000h,0ffh,0c3h	; 6240  $"#"....
	defb 0c5h,000h,0c5h,000h,022h,024h,024h,024h	; 6248  ...."$$$
	defb 000h,0feh,000h,000h,028h,024h,023h,024h	; 6250  ....($#$
	defb 057h,025h,080h,07fh,024h,024h,023h,024h	; 6258  W%..$$#$
	defb 05eh,05fh,017h,086h,052h,053h,016h,07ah	; 6260  ^_..RS.z
	defb 020h,020h,021h,0c1h,024h,024h,022h,028h	; 6268    !.$$"(
	defb 020h,027h,000h,0c2h,022h,023h,024h,022h	; 6270   '.."#$"
	defb 0b6h,0b8h,0bch,0bah,022h,023h,024h,023h	; 6278  ...."#$#
	defb 026h,020h,021h,027h,024h,022h,023h,024h	; 6280  & !'$"#$
	defb 05eh,05fh,017h,086h,052h,053h,016h,079h	; 6288  ^_..RS.y

; ----------------------------------------------------------------------
; DATOS metabloques_6290: 46 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 2; lo leen p00:490A (736 bytes)
;   0x6290..0x6570  (736 bytes)
DATA_metabloques_6290:
	defb 09ch,09dh,09eh,09fh,0a8h,0a9h,0aah,0abh,0b8h,0a8h,0adh,0aeh,000h,0b6h,0b7h,0b8h	; 6290  ................
	defb 09ch,09dh,09eh,09fh,0a8h,0a1h,0a2h,0a3h,0a8h,0a9h,0a0h,0b7h,0a6h,0a5h,000h,000h	; 62a0  ................
	defb 09ch,09dh,09eh,09fh,0a6h,0a4h,0ach,0adh,0a7h,0b6h,0a8h,0a9h,0b6h,0b8h,0a4h,0a5h	; 62b0  ................
	defb 09ch,09dh,09eh,09fh,0aeh,0a8h,0a4h,0a5h,0aah,0adh,0aeh,0b7h,0a8h,0a9h,0aah,000h	; 62c0  ................
	defb 09ch,09dh,09eh,09fh,0a1h,0a2h,0a3h,0a7h,0b8h,0a4h,0a5h,000h,000h,000h,0b7h,000h	; 62d0  ................
	defb 000h,0a7h,0abh,0ach,000h,0b6h,0b8h,0a9h,000h,0a6h,0a1h,0a4h,000h,000h,0b8h,0b6h	; 62e0  ................
	defb 0adh,0aeh,0a8h,0b7h,0aah,0adh,0aeh,000h,0a3h,0a4h,0a5h,000h,0b7h,0a7h,000h,000h	; 62f0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b3h,0b4h,000h,0b5h,088h,089h	; 6300  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0b3h,000h,0b3h,0b5h,08ah,093h,094h,095h,096h	; 6310  ................
	defb 094h,095h,096h,0b4h,0b5h,09ah,093h,09ah,0b3h,099h,09ah,096h,093h,094h,097h,0b4h	; 6320  ................
	defb 093h,085h,086h,0b5h,0b5h,095h,099h,09ah,0b6h,0adh,0aeh,096h,094h,09ah,08ah,0b4h	; 6330  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0b4h,0b4h,0b5h,088h,089h,093h,097h,09ah,087h	; 6340  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0b5h,000h,0b4h,095h,096h,099h,089h	; 6350  ................
	defb 000h,0b3h,089h,0b4h,0b3h,094h,095h,096h,08ah,085h,088h,094h,0b3h,09fh,083h,089h	; 6360  ................
	defb 0b8h,09dh,09eh,0a8h,0b6h,0a9h,0aah,0a2h,0a7h,097h,099h,09ah,0b6h,0a3h,0a7h,0b7h	; 6370  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0b4h,000h,0b5h,088h,089h,07fh,080h,081h,082h	; 6380  ................
	defb 000h,000h,000h,000h,000h,000h,0b3h,0b4h,0b3h,094h,095h,096h,083h,080h,081h,082h	; 6390  ................
	defb 000h,000h,0b3h,089h,000h,094h,095h,096h,093h,097h,098h,099h,083h,080h,081h,082h	; 63a0  ................
	defb 000h,000h,000h,000h,08ah,000h,000h,0b4h,09ah,0b5h,089h,093h,083h,080h,081h,082h	; 63b0  ................
	defb 000h,000h,0b4h,000h,0b5h,088h,089h,094h,085h,086h,087h,097h,083h,080h,081h,082h	; 63c0  ................
	defb 0b5h,089h,0b4h,000h,095h,096h,093h,000h,098h,099h,09ah,0b4h,083h,080h,081h,082h	; 63d0  ................
	defb 000h,000h,000h,000h,000h,0b4h,000h,000h,093h,08ah,089h,0b3h,083h,080h,081h,082h	; 63e0  ................
	defb 000h,000h,000h,000h,000h,0b3h,0b4h,000h,0b5h,088h,089h,000h,083h,080h,081h,084h	; 63f0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0b5h,000h,0b3h,0b5h,088h,0b5h,0b4h,08ah,095h	; 6400  ................
	defb 000h,000h,000h,000h,0b4h,000h,000h,000h,089h,000h,0b3h,0b4h,096h,0b5h,088h,089h	; 6410  ................
	defb 0a6h,0a8h,0abh,0a7h,0b6h,0adh,0aeh,0b8h,0b8h,0abh,0ach,0aah,0a7h,0a8h,0a9h,0aah	; 6420  ................
	defb 0adh,0aeh,0a3h,0a7h,0b6h,0ach,0a9h,0b7h,0b8h,0adh,0a6h,0aah,0b6h,0a6h,09ah,0b7h	; 6430  ................
	defb 085h,087h,094h,099h,0b5h,087h,089h,08ah,085h,086h,087h,094h,083h,080h,081h,082h	; 6440  ................
	defb 09ah,085h,087h,0b5h,099h,097h,098h,09ah,095h,096h,08ah,097h,083h,080h,081h,082h	; 6450  ................
	defb 000h,093h,0b4h,000h,0b3h,09ah,094h,0b5h,093h,094h,095h,096h,083h,080h,081h,082h	; 6460  ................
	defb 000h,000h,000h,0b4h,000h,0b3h,088h,089h,08ah,085h,086h,087h,083h,080h,081h,082h	; 6470  ................
	defb 09ch,09dh,09eh,09fh,0b6h,0a6h,0a1h,0a2h,000h,0b7h,0b1h,0a4h,000h,0afh,0b0h,0b2h	; 6480  ................
	defb 09ch,09dh,09eh,09fh,0a3h,0a7h,0a8h,0aah,0b0h,0a8h,0a7h,0b7h,0afh,0b2h,0aah,000h	; 6490  ................
	defb 0b8h,09dh,09eh,0a8h,0b6h,0b8h,0b0h,0afh,0afh,0b1h,0b2h,0b2h,0b1h,0afh,0b1h,0b2h	; 64a0  ................
	defb 000h,0b0h,0b2h,0afh,000h,0b1h,0afh,0b2h,000h,000h,0b2h,0b0h,000h,000h,000h,0b1h	; 64b0  ................
	defb 0b0h,000h,000h,000h,0afh,0b1h,000h,000h,0b2h,0b0h,0b2h,000h,0b0h,0b1h,0afh,000h	; 64c0  ................
	defb 0b2h,0b1h,0b0h,0b2h,0b0h,0afh,0b2h,0afh,0afh,0b2h,0b1h,0b2h,0b1h,0afh,0b2h,0b1h	; 64d0  ................
	defb 0afh,0b0h,0afh,000h,0b0h,0afh,0b1h,000h,0afh,0b2h,000h,000h,0b1h,000h,000h,000h	; 64e0  ................
	defb 000h,000h,000h,0b2h,000h,000h,0b0h,0afh,000h,093h,094h,099h,095h,096h,097h,098h	; 64f0  ................
	defb 0b0h,0afh,0b2h,0b0h,0b2h,0b1h,0b0h,0afh,0b1h,097h,08ah,0b5h,097h,094h,097h,08ah	; 6500  ................
	defb 000h,000h,0afh,0b0h,000h,0b1h,0afh,0b2h,000h,0afh,0b0h,0b1h,0b0h,0b2h,0b1h,0afh	; 6510  ................
	defb 0b2h,000h,000h,000h,0afh,0b0h,000h,000h,0b1h,0b5h,0b2h,0b4h,095h,096h,099h,089h	; 6520  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0b2h,000h,000h,0b1h,0afh,000h,000h,0afh,0b0h	; 6530  ................
	defb 0afh,0b2h,0b1h,0b2h,0b2h,0b0h,0b2h,093h,0b5h,088h,089h,08ah,083h,080h,081h,082h	; 6540  ................
	defb 000h,000h,000h,000h,097h,000h,000h,000h,094h,095h,096h,000h,083h,080h,081h,082h	; 6550  ................
	defb 000h,000h,000h,0afh,000h,0b3h,0b1h,0b2h,093h,094h,097h,09ah,083h,080h,081h,082h	; 6560  ................

; ----------------------------------------------------------------------
; DATOS medios_6290: 14 metabloques de 8 bytes de la fase 2 (del 46 al 59;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (112 bytes)
;   0x6570..0x65e0  (112 bytes)
DATA_medios_6290:
	defb 09bh,09ch,09eh,09fh,000h,0b6h,000h,0b7h	; 6570  ........
	defb 09ch,09dh,09eh,09fh,000h,0b8h,0b7h,0b6h	; 6578  ........
	defb 09ch,09dh,09eh,09fh,0a7h,0a3h,0b7h,0a7h	; 6580  ........
	defb 09ch,09dh,09eh,09fh,0a9h,0aah,0b6h,0b7h	; 6588  ........
	defb 09ch,09dh,09eh,0a0h,0b6h,0b7h,0b8h,000h	; 6590  ........
	defb 000h,0b4h,0b3h,000h,079h,07ah,07bh,07ch	; 6598  ....yz{|
	defb 0b5h,095h,096h,0b4h,07dh,07ah,07bh,07ch	; 65a0  ....}z{|
	defb 08ah,0b5h,088h,089h,07dh,07ah,07bh,07ch	; 65a8  ....}z{|
	defb 0b3h,000h,0b3h,089h,07dh,07ah,07bh,07ch	; 65b0  ....}z{|
	defb 0b3h,085h,086h,087h,07dh,07ah,07bh,07ch	; 65b8  ....}z{|
	defb 097h,098h,099h,09ah,07dh,07ah,07bh,07ch	; 65c0  ....}z{|
	defb 094h,095h,096h,086h,07dh,07ah,07bh,07ch	; 65c8  ....}z{|
	defb 0a3h,085h,086h,087h,07dh,07ah,07bh,07ch	; 65d0  ....}z{|
	defb 0b6h,0b8h,0a8h,0b7h,000h,000h,0b7h,000h	; 65d8  ........

; ----------------------------------------------------------------------
; DATOS metabloques_65E0: 18 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 3 y 9 y 10 y 11; lo leen p00:490A (288 bytes)
;   0x65e0..0x6700  (288 bytes)
DATA_metabloques_65E0:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,04ah,04ch,000h,000h,04ch,04dh,04eh,04bh	; 65e0  ........JL..LMNK
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,04ch,000h,000h,000h	; 65f0  ............L...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,04bh,000h,000h,04ah,049h,04eh,04ah	; 6600  .........K..JINJ
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6610  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,04ah,048h,000h,04bh	; 6620  ............JH.K
	defb 000h,000h,000h,000h,000h,000h,000h,000h,04ch,04ah,000h,000h,04dh,04fh,049h,04eh	; 6630  ........LJ..MOIN
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,023h,024h,025h,04bh	; 6640  ............#$%K
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,04ah,04ch,000h,04ah,049h,04dh	; 6650  ..........JL.JIM
	defb 044h,040h,042h,043h,051h,050h,050h,04fh,000h,04dh,04eh,049h,000h,04ch,000h,000h	; 6660  D@BCQPPO.MNI.L..
	defb 041h,044h,040h,042h,04dh,052h,04eh,04fh,04ch,000h,000h,000h,000h,000h,000h,000h	; 6670  AD@BMRNOL.......
	defb 040h,040h,043h,040h,050h,051h,04fh,04fh,000h,000h,000h,000h,000h,000h,000h,000h	; 6680  @@C@PQOO........
	defb 047h,043h,040h,043h,030h,02ah,03eh,03fh,04eh,050h,051h,051h,000h,04ah,024h,04eh	; 6690  GC@C0*>?NPQQ.J$N
	defb 040h,044h,042h,040h,04dh,04eh,049h,050h,052h,04fh,050h,049h,04ch,04eh,04ah,000h	; 66a0  @DB@MNIPROPILNJ.
	defb 041h,044h,045h,047h,049h,04dh,049h,04eh,02bh,04fh,02bh,051h,052h,051h,04fh,052h	; 66b0  ADEGIMIN+O+QRQOR
	defb 044h,043h,046h,043h,04ah,04dh,04dh,04dh,04eh,04ch,04ch,04ch,051h,050h,02bh,051h	; 66c0  DCFCJMMMNLLLQP+Q
	defb 040h,044h,040h,044h,04dh,04dh,049h,04ch,04ch,04ah,04bh,000h,04eh,000h,000h,000h	; 66d0  @D@DMMILLJK.N...
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h	; 66e0  ................
	defb 040h,040h,043h,040h,050h,051h,04fh,04fh,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h	; 66f0  @@C@PQOO........

; ----------------------------------------------------------------------
; DATOS medios_65E0: 13 metabloques de 8 bytes de la fase 3 y 9 y 10 y 11 (del
;   18 al 30; p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (104 bytes)
;   0x6700..0x6768  (104 bytes)
DATA_medios_65E0:
	defb 049h,048h,04ah,04bh,040h,041h,040h,041h	; 6700  IHJK@A@A
	defb 04dh,04ah,049h,048h,044h,040h,045h,046h	; 6708  MJIHD@EF
	defb 04eh,04ah,04bh,04bh,047h,044h,040h,040h	; 6710  NJKKGD@@
	defb 04fh,050h,052h,051h,040h,044h,040h,040h	; 6718  OPRQ@D@@
	defb 050h,04fh,049h,052h,043h,043h,040h,044h	; 6720  POIRCC@D
	defb 04ah,04ah,050h,051h,044h,040h,044h,042h	; 6728  JJPQD@DB
	defb 04ah,048h,049h,04ah,045h,046h,047h,043h	; 6730  JHIJEFGC
	defb 020h,021h,024h,025h,041h,044h,040h,044h	; 6738   !$%AD@D
	defb 029h,02bh,02ch,028h,043h,040h,043h,040h	; 6740  )+,(C@C@
	defb 040h,041h,044h,040h,000h,000h,000h,052h	; 6748  @AD@...R
	defb 043h,045h,046h,047h,050h,050h,049h,04fh	; 6750  CEFGPPIO
	defb 043h,044h,040h,045h,02fh,04eh,02ah,02bh	; 6758  CD@E/N*+
	defb 000h,000h,000h,049h,000h,000h,000h,000h	; 6760  ...I....

; ----------------------------------------------------------------------
; DATOS metabloques_6768: 29 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 4; lo leen p00:490A (464 bytes)
;   0x6768..0x6938  (464 bytes)
DATA_metabloques_6768:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,030h,000h,000h,000h,033h,03bh	; 6768  ..........0...3.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0adh,000h,000h,01fh,021h,000h,000h	; 6778  .............!..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b9h,0b9h,000h,0b6h,0c5h,0c5h	; 6788  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0c4h,000h,000h,0b4h,0c6h,0b5h,04ch,04dh	; 6798  ..............LM
	defb 000h,000h,000h,000h,000h,0bah,0b4h,047h,043h,04ah,041h,044h,034h,035h,035h,034h	; 67a8  .......GCJAD4554
	defb 000h,032h,03ch,03dh,048h,045h,03eh,03fh,036h,037h,040h,026h,04eh,038h,02bh,02ch	; 67b8  .2<=HE>?67@&N8+,
	defb 022h,023h,0aeh,031h,024h,025h,049h,042h,027h,028h,028h,029h,02dh,02eh,02eh,02fh	; 67c8  "#.1$%IB'(()-../
	defb 000h,000h,000h,000h,0afh,0beh,000h,000h,04bh,02ah,000h,000h,000h,000h,04fh,0b0h	; 67d8  ........K*....O.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0c4h,0b9h,000h,000h,0c6h,0c5h,0b6h,000h	; 67e8  ................
	defb 05ch,05dh,05eh,099h,060h,061h,062h,062h,0b2h,0b2h,069h,06ah,000h,000h,000h,000h	; 67f8  \]^.`abb..ij....
	defb 05ah,05bh,058h,059h,063h,064h,061h,065h,06bh,06ch,06ah,06dh,0b3h,0b3h,069h,06ah	; 6808  Z[XYcdaekljm..ij
	defb 099h,057h,05ah,05bh,066h,066h,067h,068h,06eh,0b2h,0b2h,0bdh,0ach,0c0h,000h,000h	; 6818  .WZ[ffghn.......
	defb 000h,000h,000h,000h,000h,000h,0b8h,000h,0b7h,000h,000h,000h,000h,000h,000h,000h	; 6828  ................
	defb 000h,000h,000h,0b8h,0b7h,000h,000h,000h,000h,000h,000h,000h,000h,0b8h,000h,000h	; 6838  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0c4h,0c4h,0b9h,0c4h,0c6h,0c6h,0c5h,0c6h	; 6848  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0c4h,000h,0b9h,0b6h,0c6h,0b6h,0c5h	; 6858  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0b9h,000h,0b9h,0c4h,0c5h,0b6h,0c5h,0c6h	; 6868  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b9h,000h,000h,0b6h,0c5h,0b6h	; 6878  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0c4h,0c4h,000h,000h,0c6h,0c6h,0b6h,000h	; 6888  ................
	defb 05eh,05ch,05dh,05ch,060h,061h,062h,062h,0b2h,0b2h,069h,06ah,000h,000h,000h,000h	; 6898  ^\]\`abb..ij....
	defb 05ch,05dh,05dh,05ch,063h,064h,061h,065h,06bh,06ch,06ah,06dh,0b3h,0b3h,069h,06ah	; 68a8  \]]\cdaekljm..ij
	defb 05eh,05ch,05dh,05ch,066h,066h,067h,068h,06eh,0b2h,0b2h,0bdh,0ach,0c0h,000h,000h	; 68b8  ^\]\ffghn.......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bah,0b4h,0b4h,043h,04ah,041h	; 68c8  .............CJA
	defb 000h,000h,000h,000h,000h,000h,000h,000h,047h,0afh,031h,000h,044h,03dh,042h,0afh	; 68d8  ........G.1.D=B.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,039h,047h,039h,046h	; 68e8  ............9G9F
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0b9h,000h,0bah,0b6h,0c5h,043h,04ah	; 68f8  ..............CJ
	defb 000h,000h,000h,030h,000h,000h,000h,033h,0b4h,047h,048h,037h,041h,044h,036h,03dh	; 6908  ...0...3.GH7AD6=
	defb 03bh,03dh,03ah,01fh,044h,03fh,03bh,022h,03bh,026h,027h,024h,02bh,02ch,02dh,02eh	; 6918  .=:.D?.".&'$+,-.
	defb 0adh,000h,000h,000h,021h,000h,000h,000h,027h,0aeh,031h,000h,028h,049h,042h,0afh	; 6928  ....!...'.1.(IB.

; ----------------------------------------------------------------------
; DATOS medios_6768: 9 metabloques de 8 bytes de la fase 4 (del 29 al 37;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (72 bytes)
;   0x6938..0x6980  (72 bytes)
DATA_medios_6768:
	defb 099h,05dh,05eh,05dh,000h,000h,0bch,0bdh	; 6938  .]^]....
	defb 05eh,05ch,05dh,05dh,09ah,09bh,05fh,060h	; 6940  ^\]].._`
	defb 059h,05ah,05bh,057h,0ach,0abh,0bdh,0c0h	; 6948  YZ[W....
	defb 05ch,05dh,05eh,0aah,0c0h,0c0h,000h,000h	; 6950  \]^.....
	defb 05eh,05dh,05ch,05dh,0ach,0abh,0bdh,0c0h	; 6958  ^]\]....
	defb 099h,05ch,05dh,05eh,000h,000h,099h,05ah	; 6960  .\]^...Z
	defb 05ch,05eh,05ch,05dh,05ah,058h,059h,05ah	; 6968  \^\]ZXYZ
	defb 05eh,05dh,05eh,05ch,059h,05bh,05ah,058h	; 6970  ^]^\Y[ZX
	defb 05ch,05dh,05eh,0aah,059h,0aah,000h,000h	; 6978  \]^.Y...

; ----------------------------------------------------------------------
; DATOS metabloques_6980: 22 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 5; lo leen p00:490A (352 bytes)
;   0x6980..0x6ae0  (352 bytes)
DATA_metabloques_6980:
	defb 000h,000h,0c6h,000h,000h,0a1h,0b2h,0b9h,0a1h,0a9h,0a4h,0c6h,078h,079h,08eh,0bch	; 6980  ............xy..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b4h,0b3h,0c5h,0c6h	; 6990  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0abh,000h,000h,0a2h,0c6h,0b3h,0a1h	; 69a0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0c6h,0c6h,000h,0a7h,0b3h,0b8h,0afh,0bah	; 69b0  ................
	defb 000h,0a2h,0c6h,0a2h,0a2h,0b4h,0abh,0c6h,0c6h,0a1h,0a4h,0afh,0bch,078h,078h,08eh	; 69c0  .............xx.
	defb 000h,000h,000h,000h,000h,000h,0c6h,000h,0a7h,0c6h,0b3h,0b7h,0bch,078h,0b5h,0bch	; 69d0  .............x..
	defb 020h,01fh,020h,01fh,061h,045h,062h,044h,0bch,078h,078h,08eh,0c6h,0a1h,0a4h,0afh	; 69e0   . .aEbD.xx.....
	defb 020h,01fh,020h,01fh,06ch,04ah,048h,047h,0b3h,0b8h,0afh,0bah,0c6h,0c6h,000h,0a7h	; 69f0   . .lJHG........
	defb 01fh,020h,01fh,020h,06eh,06eh,05eh,064h,0b4h,0b3h,0c5h,0c6h,000h,000h,000h,000h	; 6a00  . . nn^d........
	defb 01fh,020h,01fh,020h,06eh,06eh,05eh,064h,0a2h,0c6h,0b3h,0a1h,000h,0abh,000h,000h	; 6a10  . . nn^d........
	defb 020h,01fh,020h,01fh,061h,045h,062h,044h,078h,079h,08eh,0bch,0a1h,0a9h,0a4h,0c6h	; 6a20   . .aEbDxy......
	defb 020h,01fh,020h,01fh,061h,045h,062h,044h,0bch,078h,0b5h,0bch,0a7h,0c6h,0b3h,0b7h	; 6a30   . .aEbD.x......
	defb 01fh,01fh,020h,01fh,061h,044h,045h,050h,0b8h,03bh,056h,04ah,0a8h,0b5h,06bh,058h	; 6a40  .. .aDEP..VJ..kX
	defb 020h,020h,01fh,020h,04ch,04fh,046h,047h,04dh,04fh,062h,075h,054h,055h,058h,0aeh	; 6a50    . LOFGMObuTUX.
	defb 000h,000h,000h,000h,000h,0abh,069h,068h,0a8h,0b5h,06bh,058h,0b8h,03bh,056h,04ah	; 6a60  ......ih..kX..VJ
	defb 000h,000h,000h,000h,04dh,04eh,05eh,0adh,054h,055h,058h,0aeh,04dh,04fh,062h,075h	; 6a70  ....MN^.TUX.MObu
	defb 020h,01fh,01fh,01fh,06ch,060h,061h,044h,0bch,078h,0b8h,03bh,000h,0c6h,0a8h,0b5h	; 6a80   ...l`aD.x......
	defb 020h,01fh,020h,020h,045h,050h,04ch,04fh,056h,04ah,04dh,04fh,06bh,058h,054h,055h	; 6a90   .  EPLOVJMOkXTU
	defb 01fh,020h,01fh,01fh,046h,047h,05ah,08bh,062h,075h,078h,08eh,058h,0aeh,0a4h,0afh	; 6aa0  . ..FGZ.bux.X...
	defb 000h,000h,000h,000h,000h,000h,000h,0abh,0c6h,0c6h,0a8h,0b5h,0b3h,0b8h,0b8h,03bh	; 6ab0  ................
	defb 000h,000h,000h,000h,069h,068h,04dh,04eh,06bh,058h,054h,055h,056h,04ah,04dh,04fh	; 6ac0  ....ihMNkXTUVJMO
	defb 000h,000h,000h,000h,05eh,0adh,0c6h,000h,058h,0aeh,0b3h,0b7h,062h,075h,078h,0bch	; 6ad0  ....^...X...bux.

; ----------------------------------------------------------------------
; DATOS medios_6980: 19 metabloques de 8 bytes de la fase 5 (del 22 al 40;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (152 bytes)
;   0x6ae0..0x6b78  (152 bytes)
DATA_medios_6980:
	defb 0c3h,0c4h,07ah,07bh,0beh,0beh,0bfh,070h	; 6ae0  ..z{...p
	defb 06ch,04ah,048h,047h,020h,01fh,020h,01fh	; 6ae8  lJHG . .
	defb 061h,045h,062h,044h,01fh,020h,01fh,01fh	; 6af0  aEbD. ..
	defb 0a2h,0b4h,0abh,0c6h,000h,0a2h,0c6h,0a2h	; 6af8  ........
	defb 000h,0a1h,0b2h,0b9h,000h,000h,0c6h,000h	; 6b00  ........
	defb 0beh,0beh,0bfh,070h,0c3h,0c4h,07ah,07bh	; 6b08  ...p..z{
	defb 06eh,06eh,05eh,064h,01fh,020h,020h,01fh	; 6b10  nn^d.  .
	defb 075h,0bch,0c6h,0a7h,070h,083h,084h,0c1h	; 6b18  u...p...
	defb 070h,083h,084h,0c1h,075h,0bch,0c6h,0a7h	; 6b20  p...u...
	defb 000h,0abh,069h,068h,000h,000h,000h,000h	; 6b28  ..ih....
	defb 04dh,04eh,05eh,0adh,000h,000h,000h,000h	; 6b30  MN^.....
	defb 061h,044h,045h,050h,01fh,01fh,020h,01fh	; 6b38  aDEP.. .
	defb 04ch,04fh,046h,047h,020h,020h,01fh,020h	; 6b40  LOFG  .
	defb 000h,0ffh,000h,0abh,000h,000h,000h,000h	; 6b48  ........
	defb 069h,068h,04dh,04eh,000h,000h,000h,000h	; 6b50  ihMN....
	defb 05eh,0adh,000h,000h,000h,000h,000h,000h	; 6b58  ^.......
	defb 061h,045h,061h,044h,01fh,020h,01fh,01fh	; 6b60  aEaD. ..
	defb 045h,050h,04ch,04fh,020h,01fh,020h,020h	; 6b68  EPLO .
	defb 046h,047h,048h,047h,01fh,020h,020h,01fh	; 6b70  FGHG.  .

; ----------------------------------------------------------------------
; DATOS metabloques_6B78: 60 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 6; lo leen p00:490A (960 bytes)
;   0x6b78..0x6f38  (960 bytes)
DATA_metabloques_6B78:
	defb 02bh,035h,031h,029h,0bdh,027h,0beh,0b3h,000h,0bfh,0c4h,0c5h,000h,000h,000h,000h	; 6b78  +51).'..........
	defb 036h,037h,0b3h,04ch,0c5h,0b3h,0c5h,0c4h,000h,0c4h,000h,0c5h,000h,000h,000h,0c5h	; 6b88  67.L............
	defb 02dh,02fh,02dh,0b3h,0c4h,030h,0c5h,0c4h,000h,0c4h,0c5h,0bfh,000h,0c5h,000h,000h	; 6b98  -/-..0..........
	defb 000h,0c5h,000h,000h,000h,0c4h,000h,0bbh,0bfh,000h,000h,000h,000h,0c0h,0c3h,0c1h	; 6ba8  ................
	defb 000h,000h,0c5h,000h,000h,0c4h,000h,0c3h,0c4h,0c1h,0c0h,0c2h,0c2h,028h,02ah,02bh	; 6bb8  .............(*+
	defb 000h,0c5h,000h,000h,0c1h,0c4h,0c0h,0c2h,028h,034h,02ah,02ah,035h,031h,029h,032h	; 6bc8  ........(4**51)2
	defb 000h,0c4h,000h,000h,0bfh,000h,0c5h,0c4h,0b2h,030h,0bah,034h,033h,02eh,048h,047h	; 6bd8  .........0.43.HG
	defb 000h,0c4h,000h,0c5h,000h,000h,000h,0bbh,0b3h,000h,0c4h,0c5h,0bbh,000h,0c5h,000h	; 6be8  ................
	defb 000h,0c4h,0c4h,0bfh,000h,000h,0c5h,000h,000h,0c5h,0c5h,0c5h,000h,000h,0c4h,000h	; 6bf8  ................
	defb 000h,000h,0c5h,000h,0c1h,0c3h,0c1h,0c0h,02ah,049h,028h,02ah,046h,046h,04ah,02bh	; 6c08  ........*I(*FFJ+
	defb 0c4h,000h,0c3h,0c1h,0c1h,0c0h,0c2h,028h,028h,02ah,02bh,035h,035h,031h,029h,036h	; 6c18  .......((*+551)6
	defb 0c4h,0c2h,0c2h,034h,034h,02bh,035h,04ah,031h,029h,0bdh,036h,037h,0c5h,0b3h,0c4h	; 6c28  ...44+5J1).67...
	defb 02ah,02ah,0b2h,030h,031h,032h,033h,02eh,037h,0b3h,02dh,02fh,0bfh,000h,0bfh,030h	; 6c38  **.0123.7.-/...0
	defb 000h,0c5h,000h,000h,0c4h,000h,0b3h,000h,0bfh,000h,000h,000h,000h,0c4h,0c5h,0c3h	; 6c48  ................
	defb 000h,000h,000h,0c4h,000h,0c5h,000h,000h,000h,0c4h,0c5h,0bbh,0c4h,0c1h,0bfh,0b3h	; 6c58  ................
	defb 0c4h,0c0h,0c1h,034h,034h,02ah,01fh,022h,031h,032h,023h,026h,036h,037h,0bdh,0beh	; 6c68  ...44*."12#&67..
	defb 028h,02ah,0b2h,0c0h,01fh,020h,021h,01fh,023h,024h,025h,023h,0bdh,0beh,052h,0bdh	; 6c78  (*... !.#$%#..R.
	defb 0bah,034h,050h,0b2h,020h,021h,022h,021h,024h,025h,026h,025h,03dh,04ch,03ch,0bdh	; 6c88  .4P. !"!$%&%=L<.
	defb 034h,028h,0b2h,0c2h,022h,01fh,020h,021h,026h,023h,024h,025h,03dh,03ch,036h,052h	; 6c98  4(..". !&#$%=<6R
	defb 0b2h,0bfh,000h,0c4h,02ah,0b2h,0bah,034h,032h,033h,022h,024h,04ch,02dh,025h,02dh	; 6ca8  ....*..423"$L-%-
	defb 0c6h,03ah,050h,028h,03bh,022h,026h,047h,047h,03ch,03dh,0bbh,0beh,0c5h,0c4h,0b3h	; 6cb8  .:P(."&GG<=.....
	defb 0c1h,0c0h,0c4h,0c0h,022h,02ah,050h,028h,026h,047h,046h,024h,0c5h,037h,04bh,029h	; 6cc8  ...."*P(&GF$.7K)
	defb 000h,000h,000h,000h,0b2h,0c0h,0c0h,0bch,022h,033h,028h,02ah,046h,026h,04ah,023h	; 6cd8  ........"3(*F&J#
	defb 0c5h,000h,0c5h,000h,0bfh,000h,0b3h,000h,0b4h,0bfh,000h,0c5h,0c4h,0bbh,0c5h,000h	; 6ce8  ................
	defb 0c4h,0c5h,0c4h,0bfh,0b5h,0bbh,0c5h,0bbh,02ah,0b2h,030h,0c4h,032h,033h,02eh,030h	; 6cf8  ........*.0.23.0
	defb 0c5h,000h,000h,0c4h,000h,0c4h,0c4h,0c2h,030h,0c6h,034h,02ah,02eh,048h,031h,032h	; 6d08  ........0.4*.H12
	defb 02fh,02dh,04ch,04bh,030h,0b3h,000h,0c4h,0c4h,0c4h,0c5h,0b3h,000h,0bfh,000h,0bbh	; 6d18  /-LK0...........
	defb 036h,02dh,02fh,030h,0bfh,030h,0c4h,0c4h,000h,0c4h,0c5h,0bfh,000h,0bfh,0bbh,000h	; 6d28  6-/0.0..........
	defb 038h,039h,03ch,03dh,0c6h,03ah,03bh,028h,000h,0c0h,0c3h,0c1h,0c5h,000h,0c4h,0c5h	; 6d38  89<=.:.(........
	defb 0bdh,027h,0beh,0b3h,02bh,035h,031h,029h,0c2h,028h,02ah,02bh,0c4h,0c1h,0c0h,0c2h	; 6d48  .'..+51).(*+....
	defb 0c5h,0b3h,0c5h,0c4h,036h,037h,0b3h,04ch,035h,031h,029h,032h,028h,034h,02ah,02ah	; 6d58  ....67.L51)2(4**
	defb 0bfh,0c4h,0bbh,0c3h,0bdh,0beh,0bdh,0beh,031h,032h,023h,026h,034h,02ah,01fh,022h	; 6d68  ........12#&4*."
	defb 0c5h,030h,0c4h,0c5h,0bdh,0beh,052h,0bdh,023h,024h,025h,026h,01fh,020h,021h,022h	; 6d78  .0....R.#$%&. !"
	defb 0bdh,037h,04bh,029h,04ah,047h,046h,024h,022h,02ah,050h,028h,0c1h,0c0h,030h,0bch	; 6d88  .7K)JGF$"*P(..0.
	defb 0c1h,0c4h,0c0h,0c2h,0b3h,0bfh,000h,000h,000h,0c4h,0c5h,0c5h,000h,000h,0c5h,000h	; 6d98  ................
	defb 030h,0c3h,0c2h,030h,0c4h,000h,0c5h,0c4h,000h,0c5h,0b3h,0c5h,000h,000h,0c4h,000h	; 6da8  0..0............
	defb 032h,025h,023h,024h,02ah,01fh,022h,021h,0c0h,0c2h,02ah,0b2h,000h,000h,0c0h,030h	; 6db8  2%#$*."!..*....0
	defb 023h,024h,025h,026h,01fh,020h,022h,022h,030h,0c6h,0c1h,0c0h,000h,000h,000h,000h	; 6dc8  #$%&. ""0.......
	defb 033h,02eh,048h,035h,0b2h,030h,0bah,02bh,030h,0c4h,0bbh,0c2h,0c4h,0c5h,0c5h,0c4h	; 6dd8  3.H5.0.+0.......
	defb 023h,022h,050h,030h,02ah,0b2h,0c4h,0c5h,0b5h,0c4h,000h,0bbh,0abh,000h,0c4h,000h	; 6de8  #"P0*...........
	defb 0bah,0b2h,0c2h,0b2h,0c5h,0b3h,0c4h,0b3h,000h,0bbh,0c5h,000h,0c4h,000h,000h,0c5h	; 6df8  ................
	defb 053h,0b5h,0b7h,0c4h,043h,044h,045h,0b6h,022h,033h,028h,02ah,046h,026h,04ah,023h	; 6e08  S...CDE."3(*F&J#
	defb 0b8h,0bch,03eh,03fh,0b9h,040h,041h,042h,028h,02bh,02ah,02bh,035h,031h,029h,032h	; 6e18  ..>?.@AB(+*+51)2
	defb 0c4h,0adh,0ach,059h,000h,000h,0aeh,0afh,0aeh,0b0h,0afh,056h,0b3h,0adh,0b4h,054h	; 6e28  ...Y.......V...T
	defb 05ah,0abh,0adh,0aeh,058h,0b7h,0aeh,0c5h,057h,0c4h,000h,0c4h,055h,0b1h,0b7h,0b3h	; 6e38  Z...X...W...U...
	defb 0b3h,000h,000h,0b7h,000h,0b8h,0aeh,003h,0c4h,0b8h,0c4h,062h,0b3h,0c5h,0b7h,0aah	; 6e48  ...........b....
	defb 0b8h,0adh,001h,012h,004h,005h,006h,023h,02ch,05eh,022h,025h,05bh,05ch,05dh,023h	; 6e58  .......#,^"%[\]#
	defb 013h,002h,0aeh,0c4h,007h,008h,011h,002h,022h,023h,022h,0a9h,05fh,060h,061h,0abh	; 6e68  ........"#"._`a.
	defb 0b8h,0bch,03eh,03fh,0c4h,0b7h,0b4h,054h,0b3h,0b0h,0afh,056h,0c4h,0aeh,0b3h,0afh	; 6e78  ..>?...T...V....
	defb 053h,0b5h,0b7h,0c4h,055h,0b1h,000h,0c5h,057h,000h,0aeh,000h,058h,0c4h,000h,0bfh	; 6e88  S...U...W...X...
	defb 0bdh,027h,0beh,0b3h,023h,035h,031h,029h,02bh,028h,02ah,02bh,0b9h,040h,041h,042h	; 6e98  .'..#51)+(*+.@AB
	defb 04ch,0bdh,04bh,029h,032h,04ah,023h,024h,022h,02ah,050h,028h,043h,044h,045h,0b6h	; 6ea8  L.K)2J#$"*P(CDE.
	defb 069h,069h,069h,069h,069h,069h,069h,069h,069h,068h,069h,069h,069h,069h,068h,069h	; 6eb8  iiiiiiiiihiiiihi
	defb 0b1h,069h,069h,069h,000h,0c4h,069h,069h,0c5h,000h,069h,069h,0aeh,000h,0c5h,069h	; 6ec8  .iii..ii..ii...i
	defb 000h,0c4h,069h,069h,0aeh,069h,069h,069h,0b1h,069h,068h,069h,069h,069h,069h,069h	; 6ed8  ..ii.iii.ihiiiii
	defb 069h,068h,069h,0c4h,069h,069h,069h,000h,068h,069h,0c5h,000h,069h,0b1h,000h,0aeh	; 6ee8  ihi.iii.hi..i...
	defb 068h,069h,0b7h,0aeh,069h,069h,069h,0c5h,069h,069h,069h,069h,069h,068h,069h,069h	; 6ef8  hi..iii.iiiiihii
	defb 032h,025h,023h,024h,02ah,01fh,022h,021h,069h,0c2h,02ah,0b2h,069h,068h,069h,030h	; 6f08  2%#$*."!i.*.ihi0
	defb 0bdh,037h,04bh,029h,04ah,047h,046h,024h,022h,02ah,050h,028h,0c1h,069h,069h,068h	; 6f18  .7K)JGF$"*P(.iih
	defb 02ah,02ah,069h,069h,031h,032h,033h,068h,069h,069h,02dh,069h,069h,068h,069h,069h	; 6f28  **ii123hii-iihii

; ----------------------------------------------------------------------
; DATOS medios_6B78: 3 metabloques de 8 bytes de la fase 6 (del 60 al 62;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (24 bytes)
;   0x6f38..0x6f50  (24 bytes)
DATA_medios_6B78:
	defb 0c6h,03ah,03bh,028h,038h,039h,03ch,03dh	; 6f38  .:.(89<=
	defb 04ch,04ch,04bh,0bdh,000h,0c5h,0c5h,0b3h	; 6f40  LLK.....
	defb 027h,0bdh,0b3h,0c5h,0c5h,000h,000h,0c5h	; 6f48  '.......

; ----------------------------------------------------------------------
; DATOS metabloques_6F50: 89 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 7; lo leen p00:490A (1424 bytes)
;   0x6f50..0x74e0  (1424 bytes)
DATA_metabloques_6F50:
	defb 046h,03ah,072h,03fh,05fh,049h,050h,05eh,01fh,020h,020h,021h,025h,026h,027h,028h	; 6f50  F:r?_IP^.  !%&'(
	defb 037h,068h,065h,06eh,075h,061h,079h,05eh,025h,026h,027h,028h,022h,023h,023h,024h	; 6f60  7henuay^%&'("##$
	defb 039h,071h,073h,03ch,029h,060h,062h,052h,059h,053h,05dh,06ah,02ah,064h,069h,05eh	; 6f70  9qs<)`bRYS]j*di^
	defb 03bh,040h,03dh,03ch,052h,049h,050h,04ch,06ah,047h,05dh,046h,04fh,064h,069h,05eh	; 6f80  .@=<RIPLjG]FOdi^
	defb 03bh,040h,03dh,042h,054h,055h,051h,057h,04ah,05dh,04bh,02bh,05ch,04eh,05dh,02bh	; 6f90  .@=BTUQWJ]K+\N]+
	defb 070h,073h,071h,03ch,06ch,05dh,05dh,048h,04ch,055h,055h,052h,054h,060h,062h,052h	; 6fa0  psq<l]]HLUURT`bR
	defb 029h,062h,05bh,02ch,02ah,066h,065h,058h,02ah,061h,050h,02dh,05ah,06dh,069h,058h	; 6fb0  )b[,*feX*aP-ZmiX
	defb 038h,03ah,03eh,041h,02ah,068h,069h,02dh,02ah,066h,067h,058h,029h,04dh,04dh,02ch	; 6fc0  8:>A*hi-*fgX)MM,
	defb 039h,03dh,06fh,074h,05ah,064h,06bh,05eh,022h,023h,023h,024h,01fh,020h,020h,021h	; 6fd0  9=otZdk^"##$.  !
	defb 07ah,06fh,065h,03ch,06ch,05dh,063h,048h,01fh,020h,020h,021h,022h,023h,023h,024h	; 6fe0  zoe<l]cH.  !"##$
	defb 03bh,040h,03dh,03ch,04ch,05bh,05bh,052h,022h,023h,023h,024h,022h,023h,023h,024h	; 6ff0  .@=<L[[R"##$"##$
	defb 022h,023h,023h,024h,025h,026h,027h,028h,025h,026h,027h,028h,01fh,020h,020h,021h	; 7000  "##$%&'(%&'(.  !
	defb 04ah,04eh,04bh,06ah,04ch,04dh,060h,052h,022h,023h,023h,024h,022h,023h,023h,024h	; 7010  JNKjLM`R"##$"##$
	defb 05ch,053h,053h,048h,05fh,049h,050h,05eh,025h,026h,027h,028h,025h,026h,027h,028h	; 7020  \SSH_IP^%&'(%&'(
	defb 025h,026h,027h,028h,025h,026h,027h,028h,039h,040h,073h,03ch,059h,072h,04bh,048h	; 7030  %&'(%&'(9@s<YrKH
	defb 025h,026h,027h,028h,025h,026h,027h,028h,03bh,040h,073h,03ch,054h,062h,051h,052h	; 7040  %&'(%&'(.@s<TbQR
	defb 025h,026h,027h,028h,025h,026h,027h,028h,03bh,040h,03dh,03ch,04ah,063h,04eh,06ah	; 7050  %&'(%&'(.@=<JcNj
	defb 01fh,020h,020h,021h,022h,023h,023h,024h,03bh,040h,03dh,042h,04fh,049h,050h,058h	; 7060  .  !"##$.@=BOIPX
	defb 038h,03eh,03ah,03fh,029h,051h,051h,052h,037h,049h,050h,05eh,046h,05dh,05dh,048h	; 7070  8>:?)QQR7IP^F]]H
	defb 054h,051h,051h,057h,05fh,064h,065h,02dh,04fh,049h,050h,058h,04ch,04dh,04dh,02ch	; 7080  TQQW_de-OIPXLMM,
	defb 037h,064h,06bh,036h,05fh,064h,065h,06eh,01fh,020h,020h,021h,022h,023h,023h,024h	; 7090  7dk6_den.  !"##$
	defb 025h,026h,027h,028h,01fh,020h,020h,021h,038h,03ah,03ah,041h,05ah,064h,065h,058h	; 70a0  %&'(.  !8::AZdeX
	defb 037h,064h,065h,06eh,046h,063h,05dh,06ah,04ah,04eh,04bh,06ah,075h,064h,073h,074h	; 70b0  7denFc]jJNKjudst
	defb 037h,064h,050h,02dh,070h,071h,073h,02dh,046h,047h,047h,02bh,075h,068h,069h,036h	; 70c0  7dP-pqs-FGG+uhi6
	defb 059h,05dh,05dh,06ah,02eh,02fh,078h,032h,022h,023h,023h,024h,022h,023h,023h,024h	; 70d0  Y]]j./x2"##$"##$
	defb 04ch,04dh,04dh,052h,030h,077h,033h,031h,025h,026h,027h,028h,025h,026h,027h,028h	; 70e0  LMMR0w31%&'(%&'(
	defb 05fh,064h,065h,05eh,030h,033h,033h,031h,025h,026h,027h,028h,025h,026h,027h,028h	; 70f0  _de^0331%&'(%&'(
	defb 054h,051h,05bh,052h,030h,033h,077h,031h,022h,023h,023h,024h,022h,023h,023h,024h	; 7100  TQ[R03w1"##$"##$
	defb 05ch,047h,047h,048h,045h,049h,050h,05eh,029h,051h,051h,052h,02eh,02fh,02fh,032h	; 7110  \GGHEIP^)QQR.//2
	defb 04ah,04eh,04bh,048h,05fh,064h,065h,05eh,04ch,060h,04dh,052h,030h,033h,033h,031h	; 7120  JNKH_de^L`MR0331
	defb 05fh,06dh,065h,05eh,04fh,049h,069h,05eh,04fh,049h,050h,05eh,030h,033h,077h,031h	; 7130  _me^OIi^OIP^03w1
	defb 05fh,064h,065h,02dh,04ah,04eh,04eh,02bh,054h,062h,062h,057h,030h,033h,033h,035h	; 7140  _de-JNN+TbbW0335
	defb 04fh,049h,050h,05eh,05fh,049h,050h,06eh,046h,05dh,05dh,048h,054h,051h,051h,043h	; 7150  OIP^_IPnF]]HTQQC
	defb 05fh,068h,065h,05eh,04ah,04eh,04eh,048h,04ah,04bh,04eh,048h,045h,049h,050h,05eh	; 7160  _he^JNNHJKNHEIP^
	defb 04ch,060h,04dh,052h,054h,062h,062h,043h,054h,051h,05bh,02ch,030h,033h,033h,035h	; 7170  L`MRTbbCTQ[,0335
	defb 05fh,053h,053h,02dh,030h,077h,033h,035h,022h,023h,023h,024h,022h,023h,023h,024h	; 7180  _SS-0w35"##$"##$
	defb 059h,053h,04bh,02bh,029h,05bh,05bh,02ch,02ah,049h,050h,058h,02eh,02fh,02fh,034h	; 7190  YSK+)[[,*IPX.//4
	defb 05fh,064h,06bh,05eh,054h,051h,051h,052h,04ah,04bh,04eh,048h,045h,064h,065h,044h	; 71a0  _dk^TQQRJKNHEdeD
	defb 029h,055h,055h,043h,029h,055h,055h,02ch,02ah,05dh,05dh,02dh,02eh,033h,033h,034h	; 71b0  )UUC)UU,*]]-.334
	defb 029h,062h,05bh,052h,02ah,049h,050h,05eh,02ah,068h,069h,05eh,02eh,02fh,02fh,032h	; 71c0  )b[R*IP^*hi^.//2
	defb 05ch,063h,063h,02bh,046h,04bh,04eh,02bh,04ah,05dh,053h,02bh,045h,066h,067h,02dh	; 71d0  \cc+FKN+J]S+Efg-
	defb 04ah,04eh,04eh,048h,054h,051h,05bh,043h,04ah,04eh,04eh,02bh,046h,053h,05dh,02bh	; 71e0  JNNHTQ[CJNN+FS]+
	defb 029h,051h,051h,052h,02ah,066h,067h,06eh,02ah,068h,069h,06eh,059h,04bh,04bh,048h	; 71f0  )QQR*fgn*hinYKKH
	defb 04ah,04eh,04eh,06ah,05ch,053h,05dh,048h,04ah,053h,053h,06ah,06ch,04bh,04eh,06ah	; 7200  JNNj\S]HJSSjlKNj
	defb 022h,023h,023h,024h,025h,026h,027h,028h,01fh,020h,020h,021h,025h,026h,027h,028h	; 7210  "##$%&'(.  !%&'(
	defb 025h,026h,027h,028h,025h,026h,027h,028h,022h,023h,023h,024h,022h,023h,023h,024h	; 7220  %&'(%&'("##$"##$
	defb 025h,026h,027h,028h,01fh,020h,020h,021h,022h,023h,023h,024h,025h,026h,027h,028h	; 7230  %&'(.  !"##$%&'(
	defb 022h,023h,023h,024h,01fh,020h,020h,021h,01fh,020h,020h,021h,01fh,020h,020h,021h	; 7240  "##$.  !.  !.  !
	defb 01fh,024h,024h,021h,01fh,020h,020h,021h,022h,023h,023h,024h,022h,023h,023h,024h	; 7250  .$$!.  !"##$"##$
	defb 020h,021h,01fh,020h,027h,028h,025h,026h,023h,024h,022h,023h,01fh,020h,020h,021h	; 7260   !. '(%&#$"#.  !
	defb 01fh,020h,020h,021h,025h,026h,027h,028h,025h,026h,027h,028h,025h,026h,027h,028h	; 7270  .  !%&'(%&'(%&'(
	defb 022h,023h,023h,024h,025h,026h,027h,028h,025h,026h,027h,028h,01fh,020h,020h,021h	; 7280  "##$%&'(%&'(.  !
	defb 022h,023h,023h,024h,022h,023h,023h,024h,01fh,020h,020h,021h,022h,023h,023h,024h	; 7290  "##$"##$.  !"##$
	defb 025h,026h,027h,028h,025h,026h,027h,028h,022h,023h,023h,024h,025h,026h,027h,028h	; 72a0  %&'(%&'("##$%&'(
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,01fh,020h,020h,021h	; 72b0  .............  !
	defb 000h,000h,000h,000h,000h,000h,000h,000h,01fh,020h,020h,021h,025h,026h,027h,028h	; 72c0  .........  !%&'(
	defb 022h,023h,023h,024h,022h,023h,023h,024h,01fh,020h,020h,021h,000h,000h,000h,000h	; 72d0  "##$"##$.  !....
	defb 000h,000h,000h,000h,01fh,020h,020h,021h,022h,023h,023h,024h,022h,023h,023h,024h	; 72e0  .....  !"##$"##$
	defb 0aah,0c1h,0c2h,0abh,0a2h,0bah,0bbh,0b3h,0b7h,0b3h,0b8h,0beh,0a2h,0bbh,0bdh,0b8h	; 72f0  ................
	defb 0abh,0ach,0abh,0abh,0b3h,0b1h,0b2h,0b1h,0beh,0b0h,0b8h,0b0h,0b2h,0bbh,0bdh,0b8h	; 7300  ................
	defb 0abh,0ach,0abh,0adh,0b3h,0b4h,0b3h,0b6h,0b1h,0b8h,0b1h,0a3h,0b8h,0b2h,0b8h,0a3h	; 7310  ................
	defb 0c1h,0c2h,0c1h,0abh,0bfh,0b8h,0b8h,0b0h,0b1h,0b4h,0b4h,0b3h,0b3h,0bah,0bbh,0b3h	; 7320  ................
	defb 0a2h,0bbh,0b8h,0a3h,0a2h,0bch,0bbh,0b6h,0a2h,0bah,0b2h,0a3h,0b7h,0bfh,0bdh,0b6h	; 7330  ................
	defb 0aah,0abh,0ach,0adh,0a2h,0bdh,0bdh,0a3h,0a2h,0bch,0bch,0b6h,0a2h,0b2h,0b2h,0a3h	; 7340  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0aah,0ach,0c2h,0abh,0b7h,0c2h,0b1h,0b0h	; 7350  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0abh,0ach,0c2h,0abh,0b3h,0bbh,0b3h,0b3h	; 7360  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0abh,0ach,0abh,0abh,0b1h,0bbh,0b2h,0beh	; 7370  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0abh,0ach,0abh,0adh,0b2h,0b1h,0b2h,0b6h	; 7380  ................
	defb 0aah,0ach,0abh,0ach,0a2h,0b3h,0b3h,0b3h,0a9h,0b1h,0b2h,0b8h,0b0h,0b8h,0b8h,0b0h	; 7390  ................
	defb 0b3h,0b3h,0b3h,0b6h,0b9h,0bbh,0bbh,0a3h,0b2h,0b1h,0b2h,0b6h,0b1h,0b2h,0b2h,0a3h	; 73a0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0aah,0abh,0abh,0adh,0b7h,0bbh,0bbh,0b6h	; 73b0  ................
	defb 0a9h,0bbh,0bbh,0b8h,0b0h,0bbh,0b8h,0beh,0b1h,0b2h,0b1h,0beh,0c4h,0bbh,0c2h,0c2h	; 73c0  ................
	defb 0a9h,0bbh,0b2h,0a3h,0c1h,0c1h,0c2h,0a3h,0b0h,0b0h,0b0h,0a3h,0c4h,0bdh,0bdh,0a3h	; 73d0  ................
	defb 0b8h,0b0h,0b0h,0b0h,0afh,0b1h,0b2h,0b8h,0a2h,0b3h,0b3h,0b3h,0a4h,0a5h,0a5h,0a6h	; 73e0  ................
	defb 0b1h,0b2h,0b1h,0b0h,0b9h,0bbh,0bbh,0b8h,0b1h,0bah,0b2h,0b3h,0a5h,0a6h,0a6h,0a5h	; 73f0  ................
	defb 0b9h,0bfh,0bbh,0b8h,0b2h,0b1h,0bdh,0b8h,0b2h,0b1h,0b2h,0b8h,0a5h,0a6h,0c5h,0a5h	; 7400  ................
	defb 0b9h,0bbh,0bbh,0a3h,0b1h,0b2h,0b2h,0a3h,0b3h,0bbh,0bbh,0b6h,0a5h,0a6h,0a6h,0a7h	; 7410  ................
	defb 0b2h,0b1h,0b2h,0b8h,0b9h,0b1h,0b2h,0bfh,0b0h,0b8h,0b8h,0b0h,0b3h,0b3h,0b3h,0aeh	; 7420  ................
	defb 0b9h,0bdh,0bbh,0b8h,0b1h,0b2h,0b2h,0b0h,0b1h,0b1h,0b2h,0b0h,0afh,0b1h,0b2h,0b8h	; 7430  ................
	defb 0b1h,0bah,0b2h,0b3h,0b3h,0bbh,0bbh,0aeh,0b3h,0b3h,0b8h,0a3h,0a5h,0a6h,0a6h,0a7h	; 7440  ................
	defb 0b9h,0b3h,0b3h,0a3h,0a5h,0c5h,0a6h,0a7h,000h,000h,000h,000h,000h,000h,000h,000h	; 7450  ................
	defb 0b7h,0b3h,0b1h,0a3h,0a2h,0b8h,0b8h,0a3h,0a2h,0b1h,0b2h,0b6h,0a4h,0a5h,0a5h,0a7h	; 7460  ................
	defb 0b9h,0bbh,0beh,0b8h,0b3h,0b3h,0b3h,0b3h,0b1h,0b1h,0b2h,0b0h,0afh,0bbh,0bbh,0aeh	; 7470  ................
	defb 0a2h,0b4h,0b4h,0aeh,0a2h,0b4h,0b4h,0a3h,0a2h,0b8h,0b8h,0a3h,0c4h,0a6h,0a6h,0a1h	; 7480  ................
	defb 0a2h,0bbh,0b8h,0b3h,0a2h,0b1h,0b2h,0b8h,0a2h,0bdh,0bdh,0b8h,0a4h,0a5h,0a5h,0a6h	; 7490  ................
	defb 0b8h,0bdh,0bdh,0a3h,0b0h,0b1h,0b2h,0a3h,0b1h,0b8h,0b3h,0a3h,0afh,0bch,0bch,0a3h	; 74a0  ................
	defb 0b1h,0b2h,0b2h,0b0h,0b3h,0b3h,0b8h,0aeh,0b1h,0b2h,0b2h,0a3h,0b0h,0b3h,0b8h,0a3h	; 74b0  ................
	defb 0a2h,0b3h,0b3h,0b3h,0a2h,0bch,0bch,0bfh,0a2h,0bdh,0bdh,0bfh,0b7h,0b1h,0b1h,0b0h	; 74c0  ................
	defb 0b1h,0b2h,0b2h,0beh,0b8h,0b3h,0b8h,0b0h,0b1h,0b3h,0b3h,0beh,0bfh,0b1h,0b2h,0beh	; 74d0  ................

; ----------------------------------------------------------------------
; DATOS medios_6F50: 15 metabloques de 8 bytes de la fase 7 (del 89 al 103;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (120 bytes)
;   0x74e0..0x7558  (120 bytes)
DATA_medios_6F50:
	defb 01fh,020h,020h,021h,000h,000h,000h,000h	; 74e0  .  !....
	defb 022h,023h,023h,024h,01fh,020h,020h,021h	; 74e8  "##$.  !
	defb 0b0h,0abh,0c2h,0ach,0b9h,0b1h,0b2h,0b8h	; 74f0  ........
	defb 0a9h,0bdh,0bbh,0bfh,0c4h,0bah,0a1h,0b8h	; 74f8  ........
	defb 0aah,0abh,0c0h,0c2h,0b7h,0bbh,0beh,0b8h	; 7500  ........
	defb 0c3h,0c0h,0bbh,0a8h,0bfh,0b8h,0bbh,0b0h	; 7508  ........
	defb 0abh,0ach,0abh,0abh,0b1h,0b8h,0b8h,0b3h	; 7510  ........
	defb 0b1h,0b2h,0b1h,0beh,0b1h,0b2h,0bah,0b3h	; 7518  ........
	defb 0b8h,0b3h,0b3h,0b0h,0b9h,0b1h,0b2h,0b8h	; 7520  ........
	defb 0a9h,0bbh,0beh,0a8h,0b9h,0bbh,0bbh,0bfh	; 7528  ........
	defb 0b7h,0b8h,0b8h,0beh,0a4h,0a5h,0c6h,0a6h	; 7530  ........
	defb 0b1h,0b2h,0b2h,0b3h,0a5h,0c5h,0a6h,0a5h	; 7538  ........
	defb 0b9h,0bbh,0bbh,0b8h,0a5h,0a6h,0a6h,0a5h	; 7540  ........
	defb 0b3h,0b3h,0b8h,0b3h,0a5h,0a6h,0c5h,0a5h	; 7548  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 7550  ........

; ----------------------------------------------------------------------
; DATOS metabloques_7558: 53 metabloques de 16 bytes (4 x 4 caracteres) de la
;   fase 0 y 8; lo leen p00:490A (848 bytes)
;   0x7558..0x78a8  (848 bytes)
DATA_metabloques_7558:
	defb 000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,000h,002h,000h,001h,000h,000h	; 7558  ................
	defb 028h,09dh,09eh,038h,09fh,0a0h,0a1h,0a2h,0a3h,0a4h,0a5h,0a6h,048h,065h,065h,058h	; 7568  (..8........HeeX
	defb 025h,026h,036h,035h,030h,034h,044h,040h,027h,028h,038h,037h,032h,022h,023h,042h	; 7578  %&6504D@'(872"#B
	defb 025h,026h,036h,035h,027h,028h,038h,037h,029h,02ah,03ah,039h,02bh,02ch,03ch,03bh	; 7588  %&65'(87)*:9+,<.
	defb 025h,026h,036h,035h,030h,034h,044h,040h,029h,020h,021h,039h,032h,022h,023h,042h	; 7598  %&6504D@) !92"#B
	defb 025h,026h,036h,035h,030h,041h,031h,040h,027h,028h,038h,037h,029h,033h,043h,039h	; 75a8  %&650A1@'(87)3C9
	defb 029h,033h,043h,039h,02ch,03dh,02dh,03ch,030h,031h,041h,040h,030h,054h,064h,040h	; 75b8  )3C9,=-<01A@0Td@
	defb 029h,02dh,03dh,039h,02eh,02fh,03fh,03eh,025h,026h,036h,035h,027h,028h,038h,037h	; 75c8  )-=9./?>%&65'(87
	defb 032h,023h,022h,042h,027h,028h,038h,037h,029h,033h,043h,039h,032h,022h,023h,042h	; 75d8  2#"B'(87)3C92"#B
	defb 025h,026h,036h,035h,027h,028h,038h,037h,05dh,03ch,02ch,04dh,02ah,04fh,05fh,03ah	; 75e8  %&65'(87]<,M*O_:
	defb 027h,024h,024h,037h,029h,022h,023h,039h,045h,046h,056h,055h,027h,033h,043h,037h	; 75f8  '$$7)"#9EFVU'3C7
	defb 025h,026h,036h,035h,028h,020h,021h,038h,02ah,02fh,03fh,03ah,064h,051h,061h,054h	; 7608  %&65( !8*/?:dQaT
	defb 027h,028h,038h,037h,025h,026h,036h,035h,029h,020h,021h,039h,025h,026h,036h,035h	; 7618  '(87%&65) !9%&65
	defb 000h,000h,000h,000h,000h,000h,000h,000h,025h,026h,036h,035h,03dh,044h,034h,02dh	; 7628  ........%&65=D4-
	defb 052h,068h,068h,062h,047h,048h,058h,057h,050h,054h,064h,060h,045h,046h,056h,055h	; 7638  RhhbGHXWPTd`EFVU
	defb 044h,031h,041h,034h,04ah,04fh,05fh,05ah,048h,066h,067h,058h,045h,046h,056h,055h	; 7648  D1A4JO_ZHfgXEFVU
	defb 045h,046h,056h,055h,049h,066h,067h,059h,04eh,04dh,05dh,05eh,047h,048h,058h,057h	; 7658  EFVUIfgYNM]^GHXW
	defb 050h,034h,044h,060h,050h,051h,061h,060h,04ch,04dh,05dh,05ch,049h,053h,063h,059h	; 7668  P4D`PQa`LM]\IScY
	defb 047h,048h,058h,057h,045h,046h,056h,055h,04eh,04fh,05fh,05eh,049h,04dh,05dh,059h	; 7678  GHXWEFVUNO_^IM]Y
	defb 052h,068h,069h,062h,049h,053h,063h,059h,047h,048h,058h,057h,052h,068h,069h,062h	; 7688  RhibIScYGHXWRhib
	defb 04ah,02fh,03fh,05ah,03dh,05ch,04ch,02dh,027h,048h,058h,037h,045h,046h,056h,055h	; 7698  J/?Z=\L-'HX7EFVU
	defb 047h,053h,063h,057h,025h,026h,036h,035h,049h,068h,069h,059h,047h,06ah,06ah,057h	; 76a8  GScW%&65IhiYGjjW
	defb 04bh,04ch,05ch,05bh,049h,04ah,05ah,059h,047h,048h,058h,057h,045h,046h,056h,055h	; 76b8  KL\[IJZYGHXWEFVU
	defb 052h,022h,023h,062h,049h,066h,067h,059h,050h,054h,064h,060h,045h,046h,056h,055h	; 76c8  R"#bIfgYPTd`EFVU
	defb 049h,053h,063h,059h,027h,048h,058h,037h,050h,061h,051h,060h,045h,046h,056h,055h	; 76d8  IScY'HX7PaQ`EFVU
	defb 000h,000h,000h,000h,000h,000h,0feh,000h,000h,000h,000h,000h,000h,000h,0beh,0bbh	; 76e8  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0bbh,0beh,0bbh,01ch,01dh,072h,071h,0c0h,0bfh	; 76f8  ............rq..
	defb 000h,000h,000h,000h,000h,000h,0feh,0beh,01eh,072h,0bch,0bch,071h,0c2h,0c2h,0c2h	; 7708  .........r..q...
	defb 000h,0ffh,000h,000h,0bbh,0beh,0bbh,01ch,0bch,0bch,0bch,0c0h,0c2h,0c2h,0c3h,0bdh	; 7718  ................
	defb 0bbh,0beh,0bbh,072h,01dh,01eh,0bdh,0c0h,0bfh,071h,0bbh,0bfh,0c1h,072h,0bfh,0bfh	; 7728  ...r.....q...r..
	defb 071h,0c0h,0bfh,071h,0bdh,070h,0c1h,072h,0c3h,0beh,0bbh,0c0h,0bfh,072h,071h,0bfh	; 7738  q..q.p.r.....rq.
	defb 000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,0beh,018h,070h,0c1h,0c0h,071h	; 7748  ............p..q
	defb 000h,000h,000h,000h,000h,000h,000h,000h,019h,0beh,000h,0feh,071h,0c3h,0beh,0bbh	; 7758  ............q...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,018h,019h,0beh,0bbh	; 7768  ................
	defb 000h,000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,0bbh,018h,019h	; 7778  ................
	defb 0c0h,0bfh,072h,071h,070h,0c1h,06dh,06eh,000h,000h,000h,0c1h,000h,0ffh,000h,000h	; 7788  ..rqp.mn........
	defb 0bfh,0bch,0bch,0bch,06fh,0c0h,0c2h,0c2h,000h,000h,000h,070h,000h,000h,000h,000h	; 7798  ....o......p....
	defb 0bch,0bch,0bdh,0c3h,0c2h,0c2h,0c2h,072h,0c1h,070h,0c1h,06dh,000h,000h,0ffh,000h	; 77a8  .......r.p.m....
	defb 0bbh,0c0h,071h,071h,071h,0bfh,0c1h,071h,06eh,06fh,0c3h,072h,0c1h,070h,0c1h,0c0h	; 77b8  ..qqq..qno.r.p..
	defb 014h,013h,08dh,08eh,09eh,09dh,0a8h,0bbh,012h,093h,08bh,095h,015h,0abh,0a3h,0adh	; 77c8  ................
	defb 09ah,099h,098h,000h,0a0h,09dh,09ch,09bh,0a1h,097h,09fh,09eh,0b9h,0afh,0b7h,0b6h	; 77d8  ................
	defb 094h,028h,069h,068h,000h,02eh,065h,069h,000h,0c1h,058h,065h,000h,094h,053h,02fh	; 77e8  .(ih..ei..Xe..S/
	defb 022h,023h,038h,0a0h,023h,065h,03eh,000h,065h,048h,0c1h,000h,03fh,063h,0a0h,000h	; 77f8  "#8.#e>.eH..?c..
	defb 0b6h,0b5h,090h,0c1h,017h,016h,0a5h,0a6h,000h,0ach,033h,04fh,000h,0bbh,038h,01fh	; 7808  ..........3O..8.
	defb 0b8h,0b5h,0b4h,0b3h,0b2h,0b1h,0b0h,000h,05fh,043h,0b8h,000h,01fh,028h,0bbh,000h	; 7818  ........_C...(..
	defb 050h,028h,038h,060h,049h,033h,043h,059h,0ach,071h,0bdh,048h,000h,0c2h,020h,021h	; 7828  P(8`I3CY.q.H.. !
	defb 050h,028h,038h,060h,049h,033h,043h,059h,058h,072h,071h,0b8h,020h,021h,0c2h,000h	; 7838  P(8`I3CYXrq. !..
	defb 000h,04eh,01fh,022h,0ach,048h,068h,023h,000h,0bch,066h,067h,094h,0bfh,0c3h,028h	; 7848  .N.".Hh#..fg...(
	defb 068h,01fh,05eh,000h,022h,023h,058h,0b8h,066h,067h,0bch,000h,038h,0c0h,0bfh,0a0h	; 7858  h.^."#X.fg..8...
	defb 053h,013h,016h,063h,015h,014h,017h,018h,01bh,01ah,01dh,01eh,033h,019h,01ch,043h	; 7868  S..c........3..C
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h	; 7878  ................
	defb 000h,000h,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,0feh	; 7888  ................
	defb 000h,000h,000h,0ffh,000h,000h,000h,000h,0feh,000h,000h,000h,000h,000h,000h,000h	; 7898  ................

; ----------------------------------------------------------------------
; DATOS medios_7558: 11 metabloques de 8 bytes de la fase 0 y 8 (del 53 al 63;
;   p00:48F1 los copia a 0xEAA8); lo leen p00:48FD (88 bytes)
;   0x78a8..0x7900  (88 bytes)
DATA_medios_7558:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 78a8  ........
	defb 03ah,04ah,05ah,02ah,045h,046h,056h,055h	; 78b0  :JZ*EFVU
	defb 04dh,064h,054h,05dh,045h,046h,056h,055h	; 78b8  MdT]EFVU
	defb 041h,04dh,05dh,031h,045h,046h,056h,055h	; 78c0  AM]1EFVU
	defb 0beh,0bbh,072h,0bfh,000h,000h,070h,01ah	; 78c8  ..r...p.
	defb 0bfh,0bdh,070h,0c1h,01bh,070h,000h,000h	; 78d0  ..p..p..
	defb 01ah,01bh,070h,0c1h,000h,000h,0feh,000h	; 78d8  ..p.....
	defb 000h,0c1h,01ah,01bh,000h,000h,000h,000h	; 78e0  ........
	defb 000h,000h,070h,0c1h,000h,000h,000h,000h	; 78e8  ..p.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 78f0  ........
	defb 000h,000h,000h,000h,0feh,000h,000h,000h	; 78f8  ........

; ----------------------------------------------------------------------
; DATOS columnas_por_fase: 12 punteros (uno por fase) a las columnas del mapa
;   (p00:48A0 con L_4B67); lo leen p00:48A6 (24 bytes)
;   0x7900..0x7918  (24 bytes)
DATA_columnas_por_fase:
	defw 07918h,07bb8h,07d98h,07fa8h,08398h,081e8h	; 7900
	defw 085d8h,087e8h,08ba8h,08c98h,08e48h,08ff8h	; 790c

; ----------------------------------------------------------------------
; DATOS columnas_fase_0: las 112 columnas de la fase 0: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (672 bytes)
;   0x7918..0x7bb8  (672 bytes)
DATA_columnas_fase_0:
	defb 032h,033h,032h,033h,034h,032h	; 7918
	defb 034h,032h,034h,032h,03fh,032h	; 791e
	defb 032h,03fh,033h,032h,033h,032h	; 7924
	defb 033h,032h,03fh,034h,032h,033h	; 792a
	defb 032h,034h,032h,03fh,034h,032h	; 7930
	defb 032h,032h,033h,034h,032h,03fh	; 7936
	defb 034h,032h,03fh,032h,03fh,034h	; 793c
	defb 032h,034h,033h,032h,03fh,032h	; 7942
	defb 035h,019h,039h,01fh,03dh,035h	; 7948
	defb 035h,01ah,03ah,020h,023h,035h	; 794e
	defb 035h,01bh,03bh,021h,024h,035h	; 7954
	defb 035h,01ch,03bh,021h,025h,035h	; 795a
	defb 019h,01dh,03ch,022h,026h,03dh	; 7960
	defb 01ah,01eh,039h,01fh,01eh,023h	; 7966
	defb 01bh,01eh,03ah,020h,01eh,024h	; 796c
	defb 01ch,01eh,03ch,022h,01eh,025h	; 7972
	defb 01dh,012h,039h,01fh,012h,026h	; 7978
	defb 01eh,011h,03ah,020h,007h,01eh	; 797e
	defb 015h,038h,035h,035h,00dh,006h	; 7984
	defb 036h,000h,035h,000h,035h,002h	; 798a
	defb 037h,035h,035h,035h,035h,003h	; 7990
	defb 038h,000h,000h,000h,035h,004h	; 7996
	defb 038h,035h,035h,035h,035h,00bh	; 799c
	defb 036h,000h,035h,000h,035h,009h	; 79a2
	defb 013h,017h,035h,004h,008h,00ch	; 79a8
	defb 038h,000h,000h,000h,00dh,007h	; 79ae
	defb 037h,035h,035h,035h,035h,002h	; 79b4
	defb 036h,000h,035h,000h,035h,003h	; 79ba
	defb 038h,035h,035h,035h,00dh,007h	; 79c0
	defb 036h,000h,000h,000h,035h,003h	; 79c6
	defb 037h,035h,035h,035h,035h,002h	; 79cc
	defb 037h,000h,035h,000h,035h,002h	; 79d2
	defb 037h,035h,035h,035h,035h,003h	; 79d8
	defb 036h,000h,000h,000h,035h,005h	; 79de
	defb 016h,035h,035h,035h,035h,00bh	; 79e4
	defb 036h,000h,035h,000h,035h,009h	; 79ea
	defb 037h,035h,035h,035h,035h,005h	; 79f0
	defb 036h,000h,000h,000h,00dh,007h	; 79f6
	defb 013h,013h,017h,035h,004h,008h	; 79fc
	defb 038h,000h,035h,000h,035h,005h	; 7a02
	defb 036h,000h,000h,000h,035h,004h	; 7a08
	defb 037h,035h,035h,035h,035h,002h	; 7a0e
	defb 037h,000h,035h,000h,035h,003h	; 7a14
	defb 017h,035h,004h,008h,00ch,006h	; 7a1a
	defb 037h,000h,000h,000h,005h,011h	; 7a20
	defb 038h,035h,035h,00dh,014h,00ch	; 7a26
	defb 016h,035h,035h,035h,035h,002h	; 7a2c
	defb 037h,000h,035h,000h,035h,003h	; 7a32
	defb 018h,035h,035h,035h,035h,005h	; 7a38
	defb 036h,000h,000h,000h,00dh,007h	; 7a3e
	defb 038h,035h,035h,035h,035h,003h	; 7a44
	defb 037h,000h,035h,000h,035h,002h	; 7a4a
	defb 017h,035h,004h,017h,035h,004h	; 7a50
	defb 036h,000h,00dh,018h,035h,002h	; 7a56
	defb 037h,035h,035h,003h,036h,003h	; 7a5c
	defb 011h,012h,038h,005h,038h,005h	; 7a62
	defb 016h,011h,036h,009h,037h,009h	; 7a68
	defb 007h,016h,035h,005h,038h,005h	; 7a6e
	defb 011h,018h,00dh,007h,036h,003h	; 7a74
	defb 012h,016h,000h,000h,035h,009h	; 7a7a
	defb 016h,035h,035h,035h,035h,002h	; 7a80
	defb 018h,000h,035h,000h,00dh,007h	; 7a86
	defb 018h,035h,035h,035h,035h,003h	; 7a8c
	defb 036h,000h,000h,000h,035h,002h	; 7a92
	defb 038h,035h,035h,035h,00dh,006h	; 7a98
	defb 037h,000h,035h,000h,035h,003h	; 7a9e
	defb 011h,013h,017h,035h,004h,006h	; 7aa4
	defb 037h,000h,000h,000h,035h,002h	; 7aaa
	defb 038h,035h,035h,035h,035h,005h	; 7ab0
	defb 036h,000h,035h,000h,035h,009h	; 7ab6
	defb 017h,035h,004h,008h,006h,00ah	; 7abc
	defb 037h,000h,035h,000h,035h,009h	; 7ac2
	defb 016h,035h,035h,035h,035h,002h	; 7ac8
	defb 036h,000h,000h,000h,00dh,007h	; 7ace
	defb 037h,035h,035h,035h,035h,009h	; 7ad4
	defb 010h,013h,017h,000h,004h,008h	; 7ada
	defb 037h,035h,035h,035h,035h,005h	; 7ae0
	defb 016h,000h,035h,000h,035h,009h	; 7ae6
	defb 037h,035h,035h,035h,035h,002h	; 7aec
	defb 036h,003h,037h,000h,00dh,007h	; 7af2
	defb 037h,000h,003h,038h,035h,009h	; 7af8
	defb 016h,00dh,013h,036h,00dh,00ah	; 7afe
	defb 016h,00dh,014h,000h,035h,002h	; 7b04
	defb 036h,00dh,036h,035h,00dh,006h	; 7b0a
	defb 037h,002h,017h,000h,004h,008h	; 7b10
	defb 037h,00dh,036h,035h,035h,003h	; 7b16
	defb 014h,035h,035h,035h,035h,002h	; 7b1c
	defb 036h,000h,000h,000h,035h,002h	; 7b22
	defb 015h,013h,008h,036h,00dh,00ah	; 7b28
	defb 018h,035h,035h,035h,035h,003h	; 7b2e
	defb 010h,036h,035h,035h,035h,002h	; 7b34
	defb 018h,000h,035h,000h,035h,005h	; 7b3a
	defb 013h,017h,035h,004h,008h,00ch	; 7b40
	defb 036h,035h,035h,035h,035h,009h	; 7b46
	defb 015h,013h,008h,036h,00dh,00ah	; 7b4c
	defb 037h,000h,000h,000h,035h,002h	; 7b52
	defb 037h,035h,035h,035h,035h,005h	; 7b58
	defb 017h,035h,004h,008h,008h,00ah	; 7b5e
	defb 036h,035h,035h,035h,035h,004h	; 7b64
	defb 037h,000h,035h,000h,035h,003h	; 7b6a
	defb 037h,035h,035h,035h,00dh,007h	; 7b70
	defb 038h,000h,000h,000h,003h,006h	; 7b76
	defb 038h,035h,035h,035h,035h,009h	; 7b7c
	defb 037h,000h,035h,000h,035h,00bh	; 7b82
	defb 013h,017h,035h,004h,015h,008h	; 7b88
	defb 016h,000h,000h,000h,00dh,007h	; 7b8e
	defb 018h,035h,035h,035h,00dh,012h	; 7b94
	defb 036h,000h,035h,000h,035h,003h	; 7b9a
	defb 037h,035h,035h,035h,035h,002h	; 7ba0
	defb 02dh,029h,027h,02bh,02fh,018h	; 7ba6
	defb 02eh,02ah,028h,02ch,030h,018h	; 7bac
	defb 037h,000h,000h,000h,035h,003h	; 7bb2

; ----------------------------------------------------------------------
; DATOS columnas_fase_1: las 80 columnas de la fase 1: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (480 bytes)
;   0x7bb8..0x7d98  (480 bytes)
DATA_columnas_fase_1:
	defb 026h,003h,000h,003h,000h,01bh	; 7bb8
	defb 027h,000h,002h,002h,000h,01ch	; 7bbe
	defb 006h,000h,000h,000h,00dh,01dh	; 7bc4
	defb 028h,002h,002h,003h,000h,01eh	; 7bca
	defb 007h,000h,002h,001h,000h,01fh	; 7bd0
	defb 029h,001h,000h,000h,000h,02eh	; 7bd6
	defb 02ah,002h,000h,000h,002h,02fh	; 7bdc
	defb 027h,000h,001h,003h,000h,01ch	; 7be2
	defb 007h,000h,000h,002h,001h,02eh	; 7be8
	defb 028h,000h,001h,002h,00dh,01dh	; 7bee
	defb 00bh,002h,000h,014h,013h,034h	; 7bf4
	defb 00ch,000h,000h,000h,014h,035h	; 7bfa
	defb 007h,002h,001h,002h,000h,01eh	; 7c00
	defb 02ah,000h,000h,001h,000h,01fh	; 7c06
	defb 027h,000h,002h,000h,00dh,032h	; 7c0c
	defb 018h,002h,000h,000h,014h,035h	; 7c12
	defb 017h,036h,000h,002h,000h,01ch	; 7c18
	defb 01ah,000h,001h,002h,002h,02eh	; 7c1e
	defb 006h,001h,000h,000h,003h,02fh	; 7c24
	defb 029h,002h,002h,001h,000h,01fh	; 7c2a
	defb 007h,001h,001h,000h,00dh,032h	; 7c30
	defb 028h,000h,002h,000h,014h,01dh	; 7c36
	defb 006h,002h,000h,014h,013h,035h	; 7c3c
	defb 027h,000h,000h,014h,013h,034h	; 7c42
	defb 007h,000h,001h,002h,014h,035h	; 7c48
	defb 029h,001h,000h,000h,000h,02eh	; 7c4e
	defb 028h,002h,002h,000h,000h,032h	; 7c54
	defb 018h,000h,001h,000h,002h,02fh	; 7c5a
	defb 017h,036h,000h,002h,001h,01eh	; 7c60
	defb 007h,000h,001h,002h,00dh,01dh	; 7c66
	defb 028h,000h,002h,014h,013h,034h	; 7c6c
	defb 027h,002h,000h,000h,00dh,01dh	; 7c72
	defb 006h,001h,000h,001h,002h,01ch	; 7c78
	defb 029h,000h,000h,000h,000h,01fh	; 7c7e
	defb 027h,003h,002h,002h,000h,033h	; 7c84
	defb 028h,000h,003h,000h,014h,035h	; 7c8a
	defb 018h,000h,00fh,010h,013h,034h	; 7c90
	defb 017h,031h,003h,014h,013h,034h	; 7c96
	defb 015h,016h,000h,000h,014h,035h	; 7c9c
	defb 017h,031h,002h,000h,000h,01ch	; 7ca2
	defb 019h,000h,002h,000h,000h,02eh	; 7ca8
	defb 028h,003h,000h,003h,001h,02fh	; 7cae
	defb 029h,000h,002h,000h,000h,01dh	; 7cb4
	defb 02ah,000h,001h,003h,00dh,01dh	; 7cba
	defb 018h,002h,003h,000h,000h,02fh	; 7cc0
	defb 015h,016h,000h,001h,000h,01eh	; 7cc6
	defb 006h,003h,001h,000h,002h,02fh	; 7ccc
	defb 02ch,000h,000h,002h,000h,02eh	; 7cd2
	defb 028h,002h,000h,002h,008h,021h	; 7cd8
	defb 007h,001h,002h,000h,00ah,022h	; 7cde
	defb 017h,036h,002h,003h,001h,01fh	; 7ce4
	defb 015h,010h,031h,000h,002h,02fh	; 7cea
	defb 00bh,003h,000h,001h,000h,01eh	; 7cf0
	defb 00eh,001h,000h,002h,002h,02eh	; 7cf6
	defb 00ch,002h,002h,002h,000h,02fh	; 7cfc
	defb 029h,003h,001h,000h,002h,02eh	; 7d02
	defb 027h,000h,000h,001h,000h,033h	; 7d08
	defb 02ah,001h,003h,00fh,013h,034h	; 7d0e
	defb 028h,000h,003h,001h,014h,01dh	; 7d14
	defb 028h,002h,000h,001h,002h,032h	; 7d1a
	defb 007h,000h,000h,002h,000h,02eh	; 7d20
	defb 027h,000h,002h,000h,002h,02fh	; 7d26
	defb 029h,000h,000h,001h,000h,01fh	; 7d2c
	defb 00bh,000h,003h,001h,008h,023h	; 7d32
	defb 00eh,000h,000h,003h,009h,024h	; 7d38
	defb 00ch,001h,002h,000h,00ah,025h	; 7d3e
	defb 02ah,000h,000h,002h,00dh,01dh	; 7d44
	defb 028h,001h,002h,000h,001h,02eh	; 7d4a
	defb 00bh,000h,001h,000h,008h,023h	; 7d50
	defb 00ch,000h,003h,001h,00ah,025h	; 7d56
	defb 029h,003h,002h,003h,000h,02eh	; 7d5c
	defb 00bh,001h,001h,000h,004h,023h	; 7d62
	defb 00eh,001h,002h,001h,009h,024h	; 7d68
	defb 00ch,002h,000h,000h,005h,025h	; 7d6e
	defb 02ah,003h,002h,003h,000h,02eh	; 7d74
	defb 00bh,002h,000h,003h,008h,023h	; 7d7a
	defb 00ch,000h,003h,001h,00ah,025h	; 7d80
	defb 00bh,000h,000h,000h,008h,023h	; 7d86
	defb 00ch,000h,001h,003h,00ah,025h	; 7d8c
	defb 02bh,000h,000h,003h,001h,020h	; 7d92

; ----------------------------------------------------------------------
; DATOS columnas_fase_2: las 88 columnas de la fase 2: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (528 bytes)
;   0x7d98..0x7fa8  (528 bytes)
DATA_columnas_fase_2:
	defb 032h,003h,000h,001h,003h,037h	; 7d98
	defb 008h,001h,001h,001h,000h,038h	; 7d9e
	defb 004h,000h,003h,000h,002h,03ah	; 7da4
	defb 005h,001h,001h,001h,000h,039h	; 7daa
	defb 033h,000h,003h,000h,00bh,03ch	; 7db0
	defb 008h,001h,001h,002h,00fh,03dh	; 7db6
	defb 035h,002h,000h,000h,002h,039h	; 7dbc
	defb 033h,002h,003h,000h,000h,038h	; 7dc2
	defb 034h,000h,000h,002h,000h,039h	; 7dc8
	defb 035h,001h,000h,001h,002h,03ah	; 7dce
	defb 008h,000h,000h,000h,001h,038h	; 7dd4
	defb 034h,001h,001h,000h,000h,039h	; 7dda
	defb 004h,000h,000h,002h,00bh,03bh	; 7de0
	defb 004h,001h,002h,000h,00ch,03ch	; 7de6
	defb 005h,000h,000h,002h,010h,03eh	; 7dec
	defb 035h,001h,002h,002h,000h,03ah	; 7df2
	defb 033h,002h,000h,000h,002h,03ah	; 7df8
	defb 034h,001h,000h,002h,000h,038h	; 7dfe
	defb 035h,003h,000h,000h,00ch,039h	; 7e04
	defb 033h,001h,003h,000h,010h,03eh	; 7e0a
	defb 008h,000h,000h,001h,000h,038h	; 7e10
	defb 005h,000h,002h,000h,002h,039h	; 7e16
	defb 033h,001h,000h,000h,00bh,03ch	; 7e1c
	defb 034h,000h,002h,000h,02ah,03ch	; 7e22
	defb 034h,003h,02eh,02ch,02bh,03ch	; 7e28
	defb 023h,02ch,028h,029h,02dh,03dh	; 7e2e
	defb 024h,029h,000h,002h,00ch,03ch	; 7e34
	defb 008h,000h,003h,000h,010h,03dh	; 7e3a
	defb 033h,001h,001h,002h,000h,039h	; 7e40
	defb 034h,000h,000h,002h,00bh,03eh	; 7e46
	defb 035h,001h,001h,003h,002h,038h	; 7e4c
	defb 023h,026h,013h,032h,000h,03ah	; 7e52
	defb 024h,027h,02fh,004h,000h,038h	; 7e58
	defb 035h,000h,015h,035h,001h,039h	; 7e5e
	defb 008h,002h,016h,034h,010h,03dh	; 7e64
	defb 034h,000h,014h,023h,02ch,039h	; 7e6a
	defb 035h,001h,017h,024h,029h,038h	; 7e70
	defb 033h,002h,01ah,036h,002h,039h	; 7e76
	defb 034h,001h,000h,000h,00fh,03ch	; 7e7c
	defb 035h,003h,000h,002h,000h,038h	; 7e82
	defb 023h,026h,013h,032h,001h,03ah	; 7e88
	defb 024h,027h,02fh,008h,002h,038h	; 7e8e
	defb 004h,000h,016h,034h,010h,03dh	; 7e94
	defb 005h,002h,015h,023h,02ch,03ch	; 7e9a
	defb 008h,001h,031h,024h,029h,03ah	; 7ea0
	defb 023h,02ch,02fh,033h,001h,039h	; 7ea6
	defb 024h,029h,01ah,036h,00bh,03bh	; 7eac
	defb 035h,002h,001h,000h,010h,03dh	; 7eb2
	defb 034h,000h,001h,000h,002h,03ah	; 7eb8
	defb 008h,003h,000h,000h,003h,038h	; 7ebe
	defb 034h,001h,000h,002h,000h,039h	; 7ec4
	defb 035h,002h,000h,001h,00fh,03dh	; 7eca
	defb 033h,001h,003h,000h,010h,03ch	; 7ed0
	defb 034h,000h,002h,003h,000h,039h	; 7ed6
	defb 035h,003h,000h,003h,001h,038h	; 7edc
	defb 033h,001h,000h,001h,000h,03ah	; 7ee2
	defb 034h,000h,002h,000h,00bh,03bh	; 7ee8
	defb 035h,001h,000h,002h,00ch,03ch	; 7eee
	defb 033h,000h,002h,000h,010h,03dh	; 7ef4
	defb 004h,002h,000h,003h,00bh,03ch	; 7efa
	defb 006h,03fh,001h,000h,00ch,03ch	; 7f00
	defb 005h,003h,000h,000h,010h,03dh	; 7f06
	defb 008h,001h,002h,003h,00fh,03ch	; 7f0c
	defb 035h,000h,001h,000h,01ch,03bh	; 7f12
	defb 004h,003h,000h,002h,001h,03ah	; 7f18
	defb 006h,03fh,002h,002h,01bh,03ch	; 7f1e
	defb 005h,001h,000h,001h,01ch,03eh	; 7f24
	defb 008h,003h,011h,025h,02bh,03ch	; 7f2a
	defb 008h,000h,001h,000h,00fh,03ch	; 7f30
	defb 006h,002h,000h,002h,00ch,03ch	; 7f36
	defb 005h,001h,000h,001h,010h,03ch	; 7f3c
	defb 035h,001h,000h,003h,010h,03dh	; 7f42
	defb 033h,002h,000h,001h,01ch,03dh	; 7f48
	defb 034h,011h,012h,002h,01bh,03ch	; 7f4e
	defb 035h,000h,002h,010h,00dh,03bh	; 7f54
	defb 033h,001h,001h,003h,00fh,03ch	; 7f5a
	defb 034h,001h,000h,000h,00bh,03bh	; 7f60
	defb 008h,000h,011h,012h,000h,03ah	; 7f66
	defb 004h,003h,001h,002h,003h,038h	; 7f6c
	defb 006h,03fh,001h,001h,003h,039h	; 7f72
	defb 006h,01eh,03fh,002h,000h,03ah	; 7f78
	defb 005h,003h,000h,001h,02ah,03ch	; 7f7e
	defb 008h,001h,02eh,02ch,02fh,03ch	; 7f84
	defb 023h,028h,028h,028h,02bh,03dh	; 7f8a
	defb 024h,029h,027h,029h,02dh,03ch	; 7f90
	defb 036h,000h,001h,003h,000h,03ah	; 7f96
	defb 000h,003h,000h,002h,000h,001h	; 7f9c
	defb 003h,000h,000h,003h,002h,001h	; 7fa2

; ----------------------------------------------------------------------
; DATOS columnas_fase_3: las 96 columnas de la fase 3: 6 bytes cada una, un
;   metabloque por fila (p00:48CF) (sigue en el banco 14, en 0x8000); lo leen
;   p00:48CF (88 bytes)
;   0x7fa8..0x8000  (88 bytes)
DATA_columnas_fase_3:
	defb 00dh,000h,001h,000h,000h,01bh	; 7fa8
	defb 020h,001h,000h,003h,000h,016h	; 7fae
	defb 021h,002h,000h,000h,002h,018h	; 7fb4
	defb 00fh,003h,000h,002h,000h,01ch	; 7fba
	defb 011h,000h,003h,000h,007h,01ah	; 7fc0
	defb 012h,000h,000h,001h,000h,01ah	; 7fc6
	defb 012h,022h,002h,000h,000h,01bh	; 7fcc
	defb 011h,000h,000h,003h,004h,019h	; 7fd2
	defb 013h,001h,000h,000h,007h,01ah	; 7fd8
	defb 021h,002h,000h,002h,000h,01bh	; 7fde
	defb 020h,000h,000h,003h,006h,019h	; 7fe4
	defb 00ch,000h,002h,000h,000h,01ah	; 7fea
	defb 020h,003h,000h,003h,001h,019h	; 7ff0
	defb 020h,000h,001h,000h,000h,01bh	; 7ff6
	defb 00dh,003h,000h,002h	; 7ffc

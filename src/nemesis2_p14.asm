; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS columnas_fase_3_cola: las 96 columnas de la fase 3: 6 bytes cada una,
;   un metabloque por fila (p00:48CF) (sigue del banco 13); lo leen p00:48CF
;   (488 bytes)
;   0x8000..0x81e8  (488 bytes)
DATA_columnas_fase_3_cola:
	defb 000h,016h,00eh,002h,000h,000h	; 8000
	defb 003h,017h,021h,000h,002h,000h	; 8006
	defb 000h,018h,00fh,003h,000h,002h	; 800c
	defb 000h,01bh,013h,000h,001h,000h	; 8012
	defb 005h,019h,00eh,000h,000h,001h	; 8018
	defb 007h,019h,00dh,003h,000h,002h	; 801e
	defb 000h,01bh,020h,002h,000h,000h	; 8024
	defb 005h,01ah,01fh,000h,001h,000h	; 802a
	defb 006h,019h,00fh,000h,000h,002h	; 8030
	defb 000h,016h,012h,000h,003h,000h	; 8036
	defb 001h,018h,010h,002h,000h,002h	; 803c
	defb 003h,01bh,011h,022h,002h,001h	; 8042
	defb 000h,01dh,011h,002h,000h,000h	; 8048
	defb 009h,019h,012h,000h,003h,000h	; 804e
	defb 00bh,01eh,012h,003h,000h,002h	; 8054
	defb 001h,01eh,012h,000h,001h,001h	; 805a
	defb 000h,01bh,012h,000h,002h,000h	; 8060
	defb 00ah,01ah,013h,001h,002h,000h	; 8066
	defb 004h,019h,00ch,000h,000h,001h	; 806c
	defb 005h,017h,00dh,000h,002h,000h	; 8072
	defb 000h,01ah,020h,001h,000h,003h	; 8078
	defb 000h,01bh,00eh,000h,003h,000h	; 807e
	defb 000h,019h,00eh,000h,000h,001h	; 8084
	defb 006h,019h,021h,002h,003h,000h	; 808a
	defb 003h,01ah,00dh,000h,001h,002h	; 8090
	defb 000h,01bh,000h,001h,000h,001h	; 8096
	defb 003h,000h,003h,000h,003h,000h	; 809c
	defb 002h,000h,000h,002h,001h,000h	; 80a2
	defb 001h,000h,001h,000h,002h,003h	; 80a8
	defb 000h,001h,000h,003h,000h,002h	; 80ae
	defb 003h,000h,000h,000h,001h,003h	; 80b4
	defb 000h,002h,003h,000h,002h,000h	; 80ba
	defb 002h,003h,000h,003h,001h,000h	; 80c0
	defb 002h,000h,000h,001h,001h,003h	; 80c6
	defb 000h,000h,003h,000h,002h,003h	; 80cc
	defb 001h,000h,000h,003h,001h,002h	; 80d2
	defb 000h,001h,002h,000h,003h,001h	; 80d8
	defb 001h,000h,000h,001h,000h,000h	; 80de
	defb 003h,000h,001h,000h,001h,002h	; 80e4
	defb 000h,002h,000h,002h,003h,000h	; 80ea
	defb 001h,000h,000h,000h,001h,003h	; 80f0
	defb 000h,003h,01fh,001h,000h,001h	; 80f6
	defb 000h,01bh,00eh,000h,002h,000h	; 80fc
	defb 003h,01ah,021h,001h,003h,002h	; 8102
	defb 000h,01bh,020h,000h,003h,000h	; 8108
	defb 005h,01ah,00eh,002h,000h,001h	; 810e
	defb 008h,01eh,021h,002h,003h,000h	; 8114
	defb 005h,017h,00dh,000h,001h,003h	; 811a
	defb 000h,018h,01fh,000h,001h,002h	; 8120
	defb 000h,01bh,01fh,000h,001h,001h	; 8126
	defb 000h,018h,020h,000h,002h,003h	; 812c
	defb 001h,016h,00ch,002h,000h,003h	; 8132
	defb 000h,017h,00eh,000h,001h,000h	; 8138
	defb 002h,018h,00fh,003h,000h,002h	; 813e
	defb 004h,01ah,012h,000h,000h,001h	; 8144
	defb 000h,01bh,011h,000h,003h,002h	; 814a
	defb 006h,01eh,013h,000h,002h,000h	; 8150
	defb 001h,019h,00dh,002h,002h,000h	; 8156
	defb 003h,01bh,020h,000h,003h,001h	; 815c
	defb 000h,01ch,00eh,000h,003h,000h	; 8162
	defb 005h,017h,00eh,001h,000h,002h	; 8168
	defb 001h,01ah,00fh,000h,003h,000h	; 816e
	defb 002h,01bh,012h,002h,001h,000h	; 8174
	defb 003h,01bh,012h,003h,000h,003h	; 817a
	defb 000h,019h,013h,000h,002h,000h	; 8180
	defb 00bh,019h,00eh,000h,000h,003h	; 8186
	defb 009h,01eh,021h,001h,000h,000h	; 818c
	defb 00ah,01eh,00dh,000h,001h,003h	; 8192
	defb 000h,01dh,00ch,003h,002h,000h	; 8198
	defb 002h,01bh,021h,000h,003h,000h	; 819e
	defb 001h,01ah,020h,001h,000h,002h	; 81a4
	defb 000h,019h,011h,000h,001h,000h	; 81aa
	defb 003h,01ch,012h,000h,002h,002h	; 81b0
	defb 000h,016h,010h,000h,001h,002h	; 81b6
	defb 000h,017h,012h,003h,000h,003h	; 81bc
	defb 000h,018h,013h,000h,002h,000h	; 81c2
	defb 001h,019h,021h,000h,000h,001h	; 81c8
	defb 002h,01bh,020h,001h,003h,000h	; 81ce
	defb 000h,01bh,00dh,002h,002h,000h	; 81d4
	defb 00bh,01ah,021h,000h,001h,003h	; 81da
	defb 000h,019h,021h,000h,002h,002h	; 81e0
	defb 000h,01eh	; 81e6

; ----------------------------------------------------------------------
; DATOS columnas_fase_5: las 72 columnas de la fase 5: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (432 bytes)
;   0x81e8..0x8398  (432 bytes)
DATA_columnas_fase_5:
	defb 01fh,000h,001h,001h,003h,01ah	; 81e8
	defb 00bh,001h,001h,000h,005h,020h	; 81ee
	defb 00eh,01eh,002h,001h,009h,01ch	; 81f4
	defb 00ah,01dh,001h,003h,004h,01ch	; 81fa
	defb 00eh,01dh,003h,002h,009h,01bh	; 8200
	defb 00bh,001h,001h,001h,008h,01ch	; 8206
	defb 00fh,000h,002h,000h,009h,01bh	; 820c
	defb 00eh,001h,000h,003h,007h,01bh	; 8212
	defb 00eh,000h,001h,002h,006h,020h	; 8218
	defb 00dh,001h,001h,001h,007h,01bh	; 821e
	defb 00ch,000h,003h,002h,009h,01ch	; 8224
	defb 00fh,000h,002h,001h,004h,01ch	; 822a
	defb 00ah,01eh,001h,001h,008h,01ch	; 8230
	defb 00fh,000h,000h,000h,009h,01ch	; 8236
	defb 00eh,01dh,001h,001h,007h,01bh	; 823c
	defb 00dh,001h,003h,000h,004h,01ch	; 8242
	defb 00ch,002h,000h,000h,009h,01bh	; 8248
	defb 00eh,01eh,000h,003h,008h,01ch	; 824e
	defb 00ah,01dh,001h,001h,009h,01ch	; 8254
	defb 00fh,001h,002h,002h,009h,01bh	; 825a
	defb 00ch,002h,001h,003h,007h,01ch	; 8260
	defb 010h,023h,000h,001h,012h,025h	; 8266
	defb 011h,024h,002h,000h,013h,026h	; 826c
	defb 00dh,000h,001h,003h,005h,020h	; 8272
	defb 00fh,003h,001h,000h,006h,020h	; 8278
	defb 00ah,01dh,000h,000h,007h,01ch	; 827e
	defb 00eh,01eh,001h,002h,009h,01ch	; 8284
	defb 00fh,001h,002h,001h,008h,01ch	; 828a
	defb 00dh,000h,000h,002h,009h,01ch	; 8290
	defb 00fh,003h,001h,001h,004h,01ch	; 8296
	defb 00ch,001h,000h,003h,007h,020h	; 829c
	defb 00dh,002h,000h,002h,008h,01bh	; 82a2
	defb 00ah,01dh,001h,003h,009h,01ch	; 82a8
	defb 00fh,001h,000h,001h,007h,01bh	; 82ae
	defb 00ch,000h,000h,000h,009h,01ch	; 82b4
	defb 00eh,01eh,003h,001h,004h,01ch	; 82ba
	defb 00dh,001h,001h,000h,009h,01bh	; 82c0
	defb 00eh,01dh,002h,001h,007h,01ch	; 82c6
	defb 010h,023h,002h,000h,012h,025h	; 82cc
	defb 011h,024h,001h,001h,013h,026h	; 82d2
	defb 00dh,000h,001h,000h,008h,01bh	; 82d8
	defb 00eh,01eh,000h,001h,004h,01ch	; 82de
	defb 00dh,000h,000h,003h,007h,01bh	; 82e4
	defb 00fh,002h,002h,001h,006h,020h	; 82ea
	defb 00eh,01dh,001h,000h,005h,020h	; 82f0
	defb 014h,027h,002h,000h,017h,02ah	; 82f6
	defb 015h,028h,001h,002h,018h,02bh	; 82fc
	defb 016h,029h,001h,003h,019h,02ch	; 8302
	defb 00fh,01dh,000h,001h,008h,01ch	; 8308
	defb 00eh,01dh,001h,003h,009h,01ch	; 830e
	defb 00ah,01eh,000h,002h,007h,01bh	; 8314
	defb 00fh,000h,001h,001h,005h,020h	; 831a
	defb 00ch,001h,003h,002h,009h,01bh	; 8320
	defb 00bh,003h,003h,000h,004h,01ch	; 8326
	defb 00fh,000h,001h,001h,008h,01ch	; 832c
	defb 00eh,01eh,003h,000h,009h,01bh	; 8332
	defb 014h,027h,001h,003h,017h,02ah	; 8338
	defb 015h,028h,000h,001h,018h,02bh	; 833e
	defb 016h,029h,001h,000h,019h,02ch	; 8344
	defb 00bh,001h,003h,001h,009h,01bh	; 834a
	defb 010h,023h,003h,000h,012h,025h	; 8350
	defb 011h,024h,001h,002h,013h,026h	; 8356
	defb 00fh,01dh,003h,001h,007h,01ch	; 835c
	defb 00eh,01eh,001h,002h,008h,01ch	; 8362
	defb 00dh,001h,001h,002h,009h,01ch	; 8368
	defb 00fh,003h,000h,001h,004h,01bh	; 836e
	defb 00ch,002h,000h,000h,009h,01bh	; 8374
	defb 00bh,000h,001h,000h,007h,020h	; 837a
	defb 00ah,01dh,002h,002h,008h,01bh	; 8380
	defb 00eh,01eh,001h,000h,009h,01bh	; 8386
	defb 00ch,000h,000h,002h,007h,020h	; 838c
	defb 022h,001h,000h,001h,000h,021h	; 8392

; ----------------------------------------------------------------------
; DATOS columnas_fase_4: las 96 columnas de la fase 4: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (576 bytes)
;   0x8398..0x85d8  (576 bytes)
DATA_columnas_fase_4:
	defb 001h,002h,011h,001h,000h,003h	; 8398
	defb 000h,000h,015h,021h,010h,000h	; 839e
	defb 003h,010h,012h,022h,000h,001h	; 83a4
	defb 003h,003h,016h,024h,002h,011h	; 83aa
	defb 011h,000h,011h,000h,010h,000h	; 83b0
	defb 015h,021h,000h,003h,002h,000h	; 83b6
	defb 012h,025h,003h,000h,006h,021h	; 83bc
	defb 013h,025h,010h,002h,014h,022h	; 83c2
	defb 016h,024h,010h,000h,013h,025h	; 83c8
	defb 011h,000h,001h,000h,00ch,024h	; 83ce
	defb 003h,011h,010h,015h,021h,000h	; 83d4
	defb 010h,000h,003h,01ah,022h,010h	; 83da
	defb 002h,015h,021h,01bh,017h,000h	; 83e0
	defb 011h,016h,024h,01ah,019h,011h	; 83e6
	defb 021h,001h,011h,01bh,025h,003h	; 83ec
	defb 022h,010h,001h,016h,024h,010h	; 83f2
	defb 025h,015h,021h,003h,000h,010h	; 83f8
	defb 024h,01dh,022h,011h,000h,000h	; 83fe
	defb 010h,01eh,018h,000h,006h,021h	; 8404
	defb 01ch,01fh,019h,003h,016h,024h	; 840a
	defb 011h,020h,025h,002h,000h,000h	; 8410
	defb 010h,016h,024h,011h,015h,026h	; 8416
	defb 000h,000h,000h,002h,014h,027h	; 841c
	defb 003h,000h,010h,011h,012h,028h	; 8422
	defb 000h,000h,003h,010h,00ch,029h	; 8428
	defb 010h,000h,001h,001h,000h,011h	; 842e
	defb 000h,003h,011h,003h,006h,021h	; 8434
	defb 026h,011h,001h,003h,01dh,022h	; 843a
	defb 028h,010h,001h,010h,01eh,018h	; 8440
	defb 027h,001h,011h,01ch,01fh,019h	; 8446
	defb 029h,000h,001h,003h,020h,025h	; 844c
	defb 003h,000h,010h,000h,00ch,024h	; 8452
	defb 000h,011h,000h,010h,000h,001h	; 8458
	defb 026h,001h,000h,003h,015h,026h	; 845e
	defb 027h,000h,002h,011h,01ah,027h	; 8464
	defb 029h,011h,000h,002h,01bh,028h	; 846a
	defb 000h,015h,026h,001h,00ch,029h	; 8470
	defb 011h,016h,029h,010h,000h,010h	; 8476
	defb 006h,026h,010h,003h,000h,002h	; 847c
	defb 01ah,028h,000h,011h,002h,011h	; 8482
	defb 01bh,028h,000h,010h,000h,011h	; 8488
	defb 016h,029h,002h,010h,015h,026h	; 848e
	defb 000h,000h,003h,001h,012h,028h	; 8494
	defb 011h,010h,002h,002h,016h,029h	; 849a
	defb 003h,003h,002h,010h,000h,002h	; 84a0
	defb 011h,002h,000h,006h,021h,010h	; 84a6
	defb 000h,010h,002h,007h,022h,010h	; 84ac
	defb 002h,011h,000h,008h,00dh,000h	; 84b2
	defb 000h,010h,004h,009h,00eh,011h	; 84b8
	defb 002h,001h,005h,00ah,00fh,000h	; 84be
	defb 011h,000h,000h,00bh,023h,003h	; 84c4
	defb 026h,003h,010h,00ch,024h,010h	; 84ca
	defb 027h,000h,011h,002h,000h,000h	; 84d0
	defb 028h,001h,002h,001h,011h,008h	; 84d6
	defb 029h,010h,000h,000h,004h,009h	; 84dc
	defb 000h,002h,011h,000h,005h,00ah	; 84e2
	defb 015h,021h,001h,011h,000h,00bh	; 84e8
	defb 016h,024h,006h,021h,002h,000h	; 84ee
	defb 000h,000h,007h,022h,000h,010h	; 84f4
	defb 011h,002h,008h,00dh,015h,021h	; 84fa
	defb 000h,004h,009h,00eh,013h,022h	; 8500
	defb 010h,005h,00ah,00fh,012h,025h	; 8506
	defb 000h,000h,00bh,023h,00ch,024h	; 850c
	defb 002h,011h,016h,024h,011h,002h	; 8512
	defb 003h,011h,000h,002h,010h,000h	; 8518
	defb 015h,021h,006h,021h,000h,003h	; 851e
	defb 007h,022h,00ch,024h,015h,021h	; 8524
	defb 008h,00dh,011h,000h,01dh,022h	; 852a
	defb 009h,00eh,000h,010h,01eh,022h	; 8530
	defb 00ah,00fh,003h,01ch,01fh,025h	; 8536
	defb 00bh,023h,011h,000h,020h,023h	; 853c
	defb 016h,024h,010h,002h,016h,024h	; 8542
	defb 000h,010h,003h,015h,026h,000h	; 8548
	defb 026h,000h,001h,00ch,029h,011h	; 854e
	defb 029h,006h,026h,002h,000h,000h	; 8554
	defb 000h,01ah,027h,010h,003h,008h	; 855a
	defb 010h,01bh,028h,011h,004h,009h	; 8560
	defb 001h,016h,029h,003h,005h,00ah	; 8566
	defb 026h,002h,002h,010h,000h,00bh	; 856c
	defb 028h,011h,000h,000h,002h,011h	; 8572
	defb 029h,000h,011h,015h,021h,011h	; 8578
	defb 006h,021h,003h,007h,022h,002h	; 857e
	defb 00ch,024h,001h,008h,00dh,001h	; 8584
	defb 010h,000h,004h,009h,00eh,010h	; 858a
	defb 021h,003h,005h,00ah,00fh,000h	; 8590
	defb 022h,010h,000h,00bh,023h,010h	; 8596
	defb 025h,011h,001h,00ch,024h,002h	; 859c
	defb 024h,000h,002h,003h,000h,011h	; 85a2
	defb 006h,026h,000h,010h,015h,021h	; 85a8
	defb 01ah,027h,001h,003h,015h,022h	; 85ae
	defb 01bh,028h,011h,000h,013h,025h	; 85b4
	defb 00ch,029h,002h,001h,00ch,024h	; 85ba
	defb 026h,000h,003h,000h,011h,008h	; 85c0
	defb 028h,010h,000h,000h,004h,009h	; 85c6
	defb 027h,015h,021h,003h,005h,00ah	; 85cc
	defb 029h,016h,024h,011h,001h,00bh	; 85d2

; ----------------------------------------------------------------------
; DATOS columnas_fase_6: las 88 columnas de la fase 6: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (528 bytes)
;   0x85d8..0x87e8  (528 bytes)
DATA_columnas_fase_6:
	defb 020h,00bh,000h,001h,007h,040h	; 85d8
	defb 021h,00ch,00bh,000h,008h,004h	; 85de
	defb 022h,026h,000h,000h,009h,005h	; 85e4
	defb 022h,026h,00bh,003h,009h,042h	; 85ea
	defb 023h,027h,00ch,000h,01ah,041h	; 85f0
	defb 024h,026h,00bh,00bh,00eh,042h	; 85f6
	defb 024h,02ch,000h,011h,013h,00bh	; 85fc
	defb 024h,026h,000h,012h,014h,00ch	; 8602
	defb 022h,026h,00bh,011h,015h,00bh	; 8608
	defb 023h,026h,00bh,012h,016h,00bh	; 860e
	defb 024h,02ch,00ch,01bh,017h,00bh	; 8614
	defb 024h,03ah,038h,039h,013h,00ch	; 861a
	defb 03eh,03bh,03ch,038h,016h,00bh	; 8620
	defb 03dh,039h,03ah,038h,017h,01bh	; 8626
	defb 029h,03ch,038h,03bh,01ah,041h	; 862c
	defb 029h,00bh,000h,00bh,00eh,042h	; 8632
	defb 028h,01bh,00bh,011h,00fh,00ch	; 8638
	defb 02ah,01bh,00bh,00bh,017h,00bh	; 863e
	defb 028h,00bh,000h,00ch,01ah,041h	; 8644
	defb 029h,000h,001h,00bh,009h,005h	; 864a
	defb 029h,000h,000h,00bh,00ah,006h	; 8650
	defb 028h,00bh,00ch,000h,009h,041h	; 8656
	defb 02ah,01bh,00bh,00ch,01ah,041h	; 865c
	defb 021h,000h,00bh,011h,00eh,042h	; 8662
	defb 022h,026h,003h,011h,013h,00bh	; 8668
	defb 023h,027h,000h,012h,014h,00ch	; 866e
	defb 024h,02ch,001h,011h,015h,00bh	; 8674
	defb 024h,02ch,00bh,012h,016h,00bh	; 867a
	defb 022h,026h,000h,011h,015h,00bh	; 8680
	defb 025h,00bh,00ch,011h,015h,00ch	; 8686
	defb 028h,00bh,000h,012h,016h,00bh	; 868c
	defb 02ah,00ch,000h,012h,014h,00ch	; 8692
	defb 025h,000h,00bh,01bh,017h,00bh	; 8698
	defb 021h,03ah,039h,03ah,00fh,03ah	; 869e
	defb 03eh,038h,038h,038h,03fh,038h	; 86a4
	defb 03dh,03ch,038h,038h,038h,03bh	; 86aa
	defb 029h,00bh,03ch,038h,03bh,040h	; 86b0
	defb 028h,000h,000h,00ch,008h,004h	; 86b6
	defb 02ah,00ch,000h,00bh,009h,005h	; 86bc
	defb 029h,01bh,00bh,000h,00ah,006h	; 86c2
	defb 029h,000h,00bh,000h,00dh,041h	; 86c8
	defb 028h,01bh,000h,011h,00eh,042h	; 86ce
	defb 02ah,000h,000h,011h,017h,00bh	; 86d4
	defb 021h,000h,00bh,012h,018h,00ch	; 86da
	defb 022h,026h,000h,012h,010h,040h	; 86e0
	defb 023h,027h,000h,01bh,008h,004h	; 86e6
	defb 024h,02ch,000h,00bh,009h,005h	; 86ec
	defb 024h,026h,00bh,000h,00eh,042h	; 86f2
	defb 024h,02ch,00bh,03ah,00fh,000h	; 86f8
	defb 024h,02ch,03ah,038h,03fh,039h	; 86fe
	defb 022h,03ah,038h,03bh,017h,03ch	; 8704
	defb 03eh,038h,038h,012h,018h,00bh	; 870a
	defb 022h,03ch,03bh,008h,004h,00bh	; 8710
	defb 022h,026h,01bh,009h,005h,00ch	; 8716
	defb 023h,027h,000h,01ah,041h,00bh	; 871c
	defb 024h,028h,00bh,00eh,042h,01bh	; 8722
	defb 024h,029h,011h,013h,007h,040h	; 8728
	defb 022h,02ah,012h,014h,008h,004h	; 872e
	defb 024h,028h,011h,015h,009h,005h	; 8734
	defb 025h,021h,011h,019h,00ah,006h	; 873a
	defb 021h,022h,01bh,01ah,00dh,041h	; 8740
	defb 025h,023h,00bh,00eh,00eh,042h	; 8746
	defb 028h,024h,01bh,015h,00fh,00bh	; 874c
	defb 021h,022h,00bh,017h,010h,03ah	; 8752
	defb 022h,03eh,039h,00fh,03ah,038h	; 8758
	defb 023h,03dh,038h,03fh,03bh,040h	; 875e
	defb 024h,029h,03ch,03bh,008h,004h	; 8764
	defb 022h,02ah,00ch,00ch,009h,005h	; 876a
	defb 024h,02ah,000h,00bh,00ah,006h	; 8770
	defb 023h,02ah,00bh,00ch,01ch,01fh	; 8776
	defb 022h,02ah,000h,01bh,01dh,01eh	; 877c
	defb 023h,02ah,01bh,000h,00ah,006h	; 8782
	defb 024h,02bh,00bh,00ch,00eh,01fh	; 8788
	defb 022h,026h,01bh,000h,019h,01bh	; 878e
	defb 024h,02ch,00bh,00ch,00dh,042h	; 8794
	defb 022h,026h,00ch,00bh,01ah,006h	; 879a
	defb 022h,027h,00bh,000h,01ch,01fh	; 87a0
	defb 025h,00bh,00bh,011h,01dh,01eh	; 87a6
	defb 03dh,039h,00ch,00bh,01ah,041h	; 87ac
	defb 02ah,03ch,03ah,039h,01ch,01fh	; 87b2
	defb 029h,00bh,03ch,03ch,03bh,040h	; 87b8
	defb 021h,039h,03ah,039h,008h,004h	; 87be
	defb 03eh,038h,038h,03bh,009h,005h	; 87c4
	defb 021h,03ch,03bh,000h,00dh,041h	; 87ca
	defb 025h,01bh,031h,00bh,01ah,005h	; 87d0
	defb 036h,034h,032h,02fh,02eh,041h	; 87d6
	defb 037h,035h,033h,030h,02dh,041h	; 87dc
	defb 02bh,00ch,000h,00bh,01ch,01fh	; 87e2

; ----------------------------------------------------------------------
; DATOS columnas_fase_7: las 160 columnas de la fase 7: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (960 bytes)
;   0x87e8..0x8ba8  (960 bytes)
DATA_columnas_fase_7:
	defb 067h,06bh,06bh,06bh,06bh,03eh	; 87e8
	defb 04dh,06bh,06bh,03eh,05bh,04bh	; 87ee
	defb 053h,06bh,06bh,040h,049h,062h	; 87f4
	defb 068h,06bh,06bh,06bh,06bh,063h	; 87fa
	defb 068h,06bh,06bh,06bh,06bh,063h	; 8800
	defb 068h,06bh,06bh,06bh,06bh,063h	; 8806
	defb 06ah,06bh,06bh,06bh,06bh,03fh	; 880c
	defb 04dh,06bh,06bh,06bh,06bh,03fh	; 8812
	defb 04fh,06bh,06bh,06bh,03eh,060h	; 8818
	defb 053h,06bh,06bh,04ah,04ch,062h	; 881e
	defb 054h,06bh,06bh,06bh,06bh,063h	; 8824
	defb 042h,055h,06bh,06bh,06bh,03fh	; 882a
	defb 067h,06bh,06bh,06bh,04ah,066h	; 8830
	defb 068h,06bh,06bh,06bh,06bh,063h	; 8836
	defb 068h,06bh,06bh,06bh,043h,066h	; 883c
	defb 04dh,06bh,06bh,06bh,06bh,03fh	; 8842
	defb 052h,058h,06bh,06bh,04ah,066h	; 8848
	defb 05ch,053h,06bh,06bh,06bh,03fh	; 884e
	defb 049h,054h,06bh,06bh,06bh,03fh	; 8854
	defb 067h,06bh,06bh,06bh,044h,060h	; 885a
	defb 068h,06bh,06bh,06bh,045h,064h	; 8860
	defb 069h,06bh,06bh,06bh,046h,065h	; 8866
	defb 054h,06bh,06bh,06bh,048h,065h	; 886c
	defb 055h,06bh,06bh,06bh,040h,050h	; 8872
	defb 058h,06bh,06bh,06bh,044h,05bh	; 8878
	defb 059h,055h,06bh,06bh,045h,064h	; 887e
	defb 067h,06bh,06bh,06bh,048h,051h	; 8884
	defb 068h,06bh,06bh,06bh,041h,064h	; 888a
	defb 06ah,06bh,06bh,06bh,040h,062h	; 8890
	defb 04dh,06bh,06bh,06bh,06bh,063h	; 8896
	defb 053h,06bh,06bh,06bh,06bh,03fh	; 889c
	defb 054h,06bh,06bh,06bh,06bh,040h	; 88a2
	defb 01ch,03ch,06bh,06bh,03ah,03ch	; 88a8
	defb 020h,034h,038h,05dh,03dh,00ch	; 88ae
	defb 021h,035h,032h,036h,030h,00eh	; 88b4
	defb 025h,01ch,036h,034h,012h,005h	; 88ba
	defb 02fh,020h,038h,038h,013h,011h	; 88c0
	defb 02fh,029h,028h,036h,014h,010h	; 88c6
	defb 024h,023h,033h,031h,016h,00dh	; 88cc
	defb 026h,05eh,03ah,032h,009h,010h	; 88d2
	defb 01eh,05dh,06bh,036h,008h,023h	; 88d8
	defb 01dh,05eh,03bh,030h,032h,016h	; 88de
	defb 01fh,036h,034h,03ch,03ah,004h	; 88e4
	defb 01eh,00fh,036h,05eh,03bh,007h	; 88ea
	defb 01eh,031h,03ah,00bh,00ah,018h	; 88f0
	defb 01dh,05eh,06bh,03bh,038h,004h	; 88f6
	defb 01dh,031h,05dh,03ah,034h,00eh	; 88fc
	defb 01fh,033h,05eh,06bh,03dh,004h	; 8902
	defb 01eh,036h,033h,03bh,038h,007h	; 8908
	defb 01dh,034h,031h,039h,019h,018h	; 890e
	defb 020h,038h,036h,036h,05dh,004h	; 8914
	defb 029h,028h,032h,035h,03ah,00eh	; 891a
	defb 021h,00fh,038h,033h,006h,005h	; 8920
	defb 026h,036h,032h,006h,01ah,010h	; 8926
	defb 01eh,034h,00bh,01bh,017h,018h	; 892c
	defb 01fh,032h,031h,00fh,031h,004h	; 8932
	defb 020h,03ch,03bh,039h,019h,018h	; 8938
	defb 025h,02bh,06bh,03bh,019h,018h	; 893e
	defb 02dh,02ch,028h,033h,038h,007h	; 8944
	defb 01dh,05eh,06bh,03bh,019h,018h	; 894a
	defb 01eh,03ch,06bh,03ah,038h,00eh	; 8950
	defb 01fh,033h,036h,038h,036h,004h	; 8956
	defb 01dh,036h,006h,01ch,033h,007h	; 895c
	defb 01eh,037h,009h,01dh,037h,00eh	; 8962
	defb 01eh,034h,008h,027h,034h,00eh	; 8968
	defb 020h,031h,05eh,03bh,036h,004h	; 896e
	defb 026h,031h,05dh,03ah,039h,00eh	; 8974
	defb 01dh,038h,00bh,00ah,00ah,018h	; 897a
	defb 01eh,035h,06bh,06bh,03ah,004h	; 8980
	defb 01fh,031h,05eh,06bh,03bh,00eh	; 8986
	defb 020h,033h,037h,06bh,03ah,007h	; 898c
	defb 021h,037h,031h,039h,019h,018h	; 8992
	defb 022h,036h,034h,035h,032h,004h	; 8998
	defb 029h,00ah,028h,019h,00ah,018h	; 899e
	defb 026h,031h,036h,03ch,06bh,004h	; 89a4
	defb 01eh,034h,033h,05eh,03ah,007h	; 89aa
	defb 01dh,030h,036h,031h,036h,00eh	; 89b0
	defb 01dh,05eh,03dh,05dh,03bh,00eh	; 89b6
	defb 01dh,05dh,012h,02bh,034h,007h	; 89bc
	defb 020h,036h,016h,026h,03ah,004h	; 89c2
	defb 026h,031h,008h,027h,03bh,004h	; 89c8
	defb 01eh,05eh,03dh,034h,012h,005h	; 89ce
	defb 01fh,05dh,03ah,037h,014h,011h	; 89d4
	defb 068h,06bh,06bh,03bh,016h,010h	; 89da
	defb 06ah,06bh,06bh,06bh,040h,062h	; 89e0
	defb 069h,06bh,06bh,06bh,06bh,05fh	; 89e6
	defb 04dh,06bh,06bh,06bh,043h,066h	; 89ec
	defb 04fh,06bh,06bh,06bh,06bh,05fh	; 89f2
	defb 050h,06bh,06bh,06bh,06bh,041h	; 89f8
	defb 067h,06bh,06bh,06bh,06bh,03fh	; 89fe
	defb 069h,06bh,06bh,06bh,06bh,05fh	; 8a04
	defb 068h,06bh,06bh,06bh,06bh,05fh	; 8a0a
	defb 06ah,06bh,06bh,06bh,06bh,03fh	; 8a10
	defb 04dh,06bh,06bh,06bh,06bh,03fh	; 8a16
	defb 059h,055h,06bh,06bh,03eh,060h	; 8a1c
	defb 055h,06bh,06bh,06bh,040h,049h	; 8a22
	defb 055h,06bh,06bh,06bh,06bh,048h	; 8a28
	defb 067h,06bh,06bh,06bh,06bh,05fh	; 8a2e
	defb 069h,06bh,06bh,06bh,03eh,060h	; 8a34
	defb 04dh,06bh,06bh,06bh,03fh,065h	; 8a3a
	defb 053h,06bh,06bh,06bh,040h,062h	; 8a40
	defb 069h,06bh,06bh,06bh,06bh,063h	; 8a46
	defb 068h,06bh,06bh,06bh,06bh,063h	; 8a4c
	defb 068h,06bh,06bh,06bh,04ah,04bh	; 8a52
	defb 06ah,06bh,06bh,06bh,06bh,041h	; 8a58
	defb 06ah,06bh,06bh,06bh,043h,066h	; 8a5e
	defb 054h,06bh,06bh,06bh,06bh,05fh	; 8a64
	defb 067h,06bh,06bh,06bh,06bh,03fh	; 8a6a
	defb 054h,06bh,06bh,06bh,06bh,041h	; 8a70
	defb 042h,055h,044h,05bh,058h,03fh	; 8a76
	defb 05bh,058h,045h,05ch,04fh,063h	; 8a7c
	defb 05ch,053h,045h,05ch,04fh,063h	; 8a82
	defb 04ch,054h,045h,05ch,04eh,05fh	; 8a88
	defb 043h,055h,046h,05ch,04fh,041h	; 8a8e
	defb 05bh,058h,015h,049h,050h,03fh	; 8a94
	defb 05ch,04fh,036h,03eh,058h,063h	; 8a9a
	defb 055h,04eh,037h,040h,050h,03fh	; 8aa0
	defb 05ch,053h,019h,042h,042h,066h	; 8aa6
	defb 04ch,054h,044h,05bh,058h,03fh	; 8aac
	defb 043h,055h,046h,05ch,04eh,040h	; 8ab2
	defb 03eh,058h,045h,05ch,052h,058h	; 8ab8
	defb 040h,050h,047h,049h,049h,050h	; 8abe
	defb 067h,06bh,06bh,06bh,06bh,061h	; 8ac4
	defb 068h,06bh,06bh,06bh,06bh,03fh	; 8aca
	defb 04dh,06bh,06bh,06bh,06bh,03fh	; 8ad0
	defb 04fh,06bh,06bh,04ah,042h,066h	; 8ad6
	defb 050h,06bh,06bh,06bh,06bh,063h	; 8adc
	defb 058h,06bh,06bh,06bh,06bh,03fh	; 8ae2
	defb 056h,055h,06bh,06bh,06bh,063h	; 8ae8
	defb 053h,06bh,06bh,06bh,043h,066h	; 8aee
	defb 068h,06bh,06bh,06bh,06bh,063h	; 8af4
	defb 06ah,06bh,06bh,06bh,06bh,063h	; 8afa
	defb 06ah,06bh,06bh,06bh,06bh,03fh	; 8b00
	defb 04dh,06bh,06bh,06bh,06bh,063h	; 8b06
	defb 04fh,06bh,06bh,06bh,03eh,060h	; 8b0c
	defb 053h,06bh,06bh,06bh,03fh,064h	; 8b12
	defb 054h,06bh,06bh,06bh,040h,062h	; 8b18
	defb 055h,06bh,06bh,06bh,06bh,040h	; 8b1e
	defb 01ch,05dh,06bh,06bh,06bh,03eh	; 8b24
	defb 01dh,03ch,06bh,06bh,03ah,007h	; 8b2a
	defb 027h,037h,06bh,06bh,03bh,007h	; 8b30
	defb 037h,03ch,06bh,06bh,036h,009h	; 8b36
	defb 01ch,012h,058h,06bh,03dh,008h	; 8b3c
	defb 027h,013h,053h,06bh,03bh,006h	; 8b42
	defb 02bh,015h,054h,06bh,03bh,009h	; 8b48
	defb 022h,03ch,06bh,03dh,030h,007h	; 8b4e
	defb 022h,037h,03ah,019h,00ah,018h	; 8b54
	defb 026h,033h,03ah,037h,036h,009h	; 8b5a
	defb 027h,032h,031h,032h,038h,007h	; 8b60
	defb 01ch,031h,030h,030h,037h,00eh	; 8b66
	defb 027h,030h,032h,037h,037h,00eh	; 8b6c
	defb 028h,00bh,028h,019h,00ah,018h	; 8b72
	defb 067h,06bh,06bh,06bh,06bh,040h	; 8b78
	defb 069h,06bh,06bh,06bh,06bh,03eh	; 8b7e
	defb 068h,06bh,06bh,06bh,06bh,05fh	; 8b84
	defb 04dh,06bh,06bh,06bh,044h,060h	; 8b8a
	defb 04fh,06bh,06bh,06bh,046h,064h	; 8b90
	defb 052h,067h,06bh,06bh,048h,064h	; 8b96
	defb 049h,054h,06bh,06bh,040h,049h	; 8b9c
	defb 055h,06bh,06bh,06bh,04ah,042h	; 8ba2

; ----------------------------------------------------------------------
; DATOS columnas_fase_8: las 40 columnas de la fase 8: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (240 bytes)
;   0x8ba8..0x8c98  (240 bytes)
DATA_columnas_fase_8:
	defb 037h,035h,035h,035h,035h,002h	; 8ba8
	defb 00fh,035h,035h,035h,035h,003h	; 8bae
	defb 016h,035h,035h,035h,00dh,006h	; 8bb4
	defb 038h,000h,035h,000h,00dh,007h	; 8bba
	defb 036h,035h,035h,035h,004h,008h	; 8bc0
	defb 038h,000h,000h,000h,005h,007h	; 8bc6
	defb 037h,035h,035h,035h,005h,006h	; 8bcc
	defb 014h,000h,035h,000h,009h,005h	; 8bd2
	defb 017h,035h,035h,035h,002h,006h	; 8bd8
	defb 016h,035h,035h,003h,007h,00bh	; 8bde
	defb 015h,038h,035h,004h,008h,00ch	; 8be4
	defb 00fh,035h,035h,005h,011h,006h	; 8bea
	defb 018h,000h,035h,00dh,016h,011h	; 8bf0
	defb 012h,036h,035h,035h,009h,00ah	; 8bf6
	defb 012h,016h,035h,035h,00dh,007h	; 8bfc
	defb 013h,037h,035h,035h,035h,004h	; 8c02
	defb 017h,000h,035h,000h,035h,00bh	; 8c08
	defb 00eh,035h,035h,035h,035h,009h	; 8c0e
	defb 010h,013h,017h,035h,035h,003h	; 8c14
	defb 012h,016h,036h,035h,00dh,00ch	; 8c1a
	defb 014h,000h,035h,000h,035h,00bh	; 8c20
	defb 037h,035h,035h,035h,035h,002h	; 8c26
	defb 037h,035h,000h,035h,035h,003h	; 8c2c
	defb 036h,035h,000h,035h,00dh,012h	; 8c32
	defb 038h,035h,000h,035h,003h,007h	; 8c38
	defb 00eh,035h,000h,035h,004h,016h	; 8c3e
	defb 038h,035h,000h,00dh,007h,010h	; 8c44
	defb 036h,035h,035h,004h,013h,00ch	; 8c4a
	defb 037h,000h,000h,000h,003h,007h	; 8c50
	defb 018h,035h,035h,035h,002h,006h	; 8c56
	defb 007h,016h,035h,003h,005h,00ch	; 8c5c
	defb 015h,018h,031h,005h,006h,007h	; 8c62
	defb 018h,035h,035h,035h,005h,007h	; 8c68
	defb 036h,000h,035h,000h,035h,005h	; 8c6e
	defb 037h,035h,035h,035h,035h,005h	; 8c74
	defb 038h,000h,000h,000h,035h,005h	; 8c7a
	defb 013h,017h,001h,004h,013h,008h	; 8c80
	defb 037h,000h,035h,000h,035h,005h	; 8c86
	defb 036h,035h,035h,035h,035h,005h	; 8c8c
	defb 018h,000h,000h,000h,005h,007h	; 8c92

; ----------------------------------------------------------------------
; DATOS columnas_fase_9: las 72 columnas de la fase 9: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (432 bytes)
;   0x8c98..0x8e48  (432 bytes)
DATA_columnas_fase_9:
	defb 01fh,003h,000h,001h,000h,016h	; 8c98
	defb 020h,001h,000h,003h,000h,019h	; 8c9e
	defb 00ch,000h,003h,000h,003h,01bh	; 8ca4
	defb 00eh,000h,001h,001h,001h,01ah	; 8caa
	defb 020h,001h,000h,003h,000h,019h	; 8cb0
	defb 00dh,014h,000h,002h,001h,01ah	; 8cb6
	defb 00eh,014h,014h,001h,00bh,01eh	; 8cbc
	defb 020h,014h,014h,000h,003h,019h	; 8cc2
	defb 021h,001h,014h,002h,000h,01ah	; 8cc8
	defb 00eh,000h,014h,000h,001h,019h	; 8cce
	defb 01fh,001h,014h,003h,002h,017h	; 8cd4
	defb 00ch,000h,014h,000h,014h,018h	; 8cda
	defb 00fh,002h,014h,001h,014h,016h	; 8ce0
	defb 010h,000h,014h,014h,014h,01eh	; 8ce6
	defb 00eh,001h,002h,014h,014h,019h	; 8cec
	defb 020h,002h,000h,001h,002h,01ah	; 8cf2
	defb 010h,000h,002h,000h,008h,01ah	; 8cf8
	defb 021h,001h,002h,000h,001h,01bh	; 8cfe
	defb 00eh,000h,000h,001h,000h,01ah	; 8d04
	defb 00ch,003h,002h,000h,003h,017h	; 8d0a
	defb 020h,002h,000h,000h,001h,019h	; 8d10
	defb 021h,001h,001h,000h,000h,01bh	; 8d16
	defb 01fh,002h,000h,001h,006h,019h	; 8d1c
	defb 020h,000h,001h,000h,004h,01ah	; 8d22
	defb 020h,001h,001h,002h,001h,019h	; 8d28
	defb 00dh,002h,000h,001h,000h,01bh	; 8d2e
	defb 021h,001h,003h,002h,001h,01ah	; 8d34
	defb 01fh,014h,014h,001h,003h,01ch	; 8d3a
	defb 00eh,014h,014h,000h,006h,01ah	; 8d40
	defb 021h,014h,014h,002h,000h,01dh	; 8d46
	defb 01fh,014h,014h,001h,00bh,019h	; 8d4c
	defb 020h,014h,014h,000h,004h,01eh	; 8d52
	defb 021h,000h,001h,002h,005h,017h	; 8d58
	defb 00eh,001h,002h,014h,014h,019h	; 8d5e
	defb 015h,002h,000h,014h,014h,017h	; 8d64
	defb 015h,000h,001h,000h,000h,01ah	; 8d6a
	defb 021h,001h,000h,001h,001h,01bh	; 8d70
	defb 00dh,002h,001h,000h,002h,01ch	; 8d76
	defb 00eh,014h,002h,000h,000h,01dh	; 8d7c
	defb 020h,014h,014h,014h,001h,019h	; 8d82
	defb 01fh,014h,014h,014h,000h,01ah	; 8d88
	defb 00eh,014h,014h,014h,000h,01bh	; 8d8e
	defb 021h,014h,014h,014h,014h,017h	; 8d94
	defb 020h,014h,014h,014h,014h,016h	; 8d9a
	defb 00eh,001h,014h,014h,014h,018h	; 8da0
	defb 01fh,000h,014h,014h,014h,01bh	; 8da6
	defb 00ch,003h,002h,014h,014h,019h	; 8dac
	defb 00eh,001h,002h,001h,014h,01ch	; 8db2
	defb 020h,001h,000h,002h,014h,01eh	; 8db8
	defb 021h,000h,000h,001h,000h,01dh	; 8dbe
	defb 00ch,002h,000h,002h,000h,017h	; 8dc4
	defb 00dh,001h,001h,000h,001h,019h	; 8dca
	defb 01fh,000h,000h,001h,000h,01bh	; 8dd0
	defb 020h,001h,001h,000h,000h,01ah	; 8dd6
	defb 021h,000h,003h,000h,001h,018h	; 8ddc
	defb 00eh,001h,002h,000h,003h,019h	; 8de2
	defb 020h,001h,000h,014h,014h,01eh	; 8de8
	defb 021h,000h,001h,014h,014h,01ah	; 8dee
	defb 00eh,014h,014h,014h,014h,01bh	; 8df4
	defb 021h,014h,014h,000h,002h,019h	; 8dfa
	defb 020h,014h,014h,014h,014h,017h	; 8e00
	defb 00eh,014h,014h,014h,014h,018h	; 8e06
	defb 021h,014h,014h,014h,014h,01bh	; 8e0c
	defb 020h,014h,014h,014h,014h,01ch	; 8e12
	defb 01fh,014h,014h,014h,014h,01eh	; 8e18
	defb 021h,014h,014h,014h,014h,017h	; 8e1e
	defb 020h,014h,014h,014h,014h,016h	; 8e24
	defb 00eh,000h,014h,014h,014h,01ah	; 8e2a
	defb 021h,000h,000h,000h,000h,018h	; 8e30
	defb 020h,000h,000h,000h,000h,019h	; 8e36
	defb 00eh,000h,000h,000h,000h,01bh	; 8e3c
	defb 020h,000h,000h,000h,000h,01dh	; 8e42

; ----------------------------------------------------------------------
; DATOS columnas_fase_10: las 72 columnas de la fase 10: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (432 bytes)
;   0x8e48..0x8ff8  (432 bytes)
DATA_columnas_fase_10:
	defb 01fh,001h,000h,001h,002h,018h	; 8e48
	defb 020h,002h,000h,002h,000h,019h	; 8e4e
	defb 020h,001h,003h,001h,002h,01bh	; 8e54
	defb 00eh,002h,000h,002h,000h,017h	; 8e5a
	defb 021h,003h,001h,000h,001h,018h	; 8e60
	defb 020h,001h,002h,001h,003h,01ah	; 8e66
	defb 00eh,000h,000h,014h,014h,016h	; 8e6c
	defb 01fh,001h,003h,014h,014h,01bh	; 8e72
	defb 020h,000h,001h,014h,014h,01ah	; 8e78
	defb 021h,000h,000h,014h,014h,01ch	; 8e7e
	defb 00eh,001h,002h,014h,014h,018h	; 8e84
	defb 01fh,000h,014h,014h,014h,01bh	; 8e8a
	defb 00dh,002h,014h,014h,014h,01ah	; 8e90
	defb 021h,001h,000h,001h,002h,017h	; 8e96
	defb 020h,000h,000h,002h,001h,018h	; 8e9c
	defb 00eh,001h,003h,002h,000h,01ah	; 8ea2
	defb 01fh,000h,001h,002h,000h,016h	; 8ea8
	defb 020h,002h,000h,014h,014h,019h	; 8eae
	defb 00eh,001h,014h,014h,014h,01ah	; 8eb4
	defb 021h,000h,014h,014h,014h,01bh	; 8eba
	defb 01fh,001h,014h,014h,014h,017h	; 8ec0
	defb 00dh,002h,000h,000h,001h,019h	; 8ec6
	defb 020h,001h,002h,001h,002h,016h	; 8ecc
	defb 021h,002h,000h,000h,001h,019h	; 8ed2
	defb 00dh,000h,000h,003h,000h,016h	; 8ed8
	defb 00eh,002h,001h,000h,001h,019h	; 8ede
	defb 021h,001h,002h,014h,014h,01eh	; 8ee4
	defb 021h,003h,014h,014h,014h,01dh	; 8eea
	defb 01fh,001h,014h,014h,014h,017h	; 8ef0
	defb 00eh,003h,014h,014h,014h,019h	; 8ef6
	defb 00dh,000h,000h,001h,002h,018h	; 8efc
	defb 021h,001h,001h,003h,000h,01bh	; 8f02
	defb 020h,001h,002h,000h,001h,017h	; 8f08
	defb 015h,014h,000h,001h,000h,018h	; 8f0e
	defb 015h,014h,003h,000h,000h,01ah	; 8f14
	defb 015h,014h,014h,014h,000h,019h	; 8f1a
	defb 01fh,001h,000h,001h,014h,017h	; 8f20
	defb 021h,003h,000h,000h,014h,019h	; 8f26
	defb 020h,001h,003h,014h,014h,01ah	; 8f2c
	defb 00eh,000h,000h,001h,000h,01bh	; 8f32
	defb 01fh,000h,001h,000h,001h,01eh	; 8f38
	defb 020h,003h,014h,014h,014h,019h	; 8f3e
	defb 021h,001h,000h,000h,001h,01dh	; 8f44
	defb 00eh,000h,001h,000h,002h,01ah	; 8f4a
	defb 00dh,001h,003h,000h,001h,019h	; 8f50
	defb 020h,000h,002h,000h,000h,01ah	; 8f56
	defb 021h,014h,014h,014h,014h,017h	; 8f5c
	defb 00eh,001h,014h,014h,014h,016h	; 8f62
	defb 020h,014h,014h,014h,014h,019h	; 8f68
	defb 021h,014h,014h,014h,014h,01bh	; 8f6e
	defb 00eh,014h,014h,014h,014h,017h	; 8f74
	defb 020h,014h,014h,014h,014h,01eh	; 8f7a
	defb 021h,014h,014h,014h,014h,01ch	; 8f80
	defb 021h,014h,014h,014h,014h,01ah	; 8f86
	defb 00eh,014h,014h,014h,014h,019h	; 8f8c
	defb 020h,000h,002h,001h,002h,01bh	; 8f92
	defb 01fh,001h,001h,000h,001h,01eh	; 8f98
	defb 00eh,001h,000h,001h,000h,01ah	; 8f9e
	defb 020h,000h,000h,000h,001h,018h	; 8fa4
	defb 021h,001h,002h,000h,002h,017h	; 8faa
	defb 020h,014h,014h,000h,000h,019h	; 8fb0
	defb 00eh,002h,000h,001h,003h,016h	; 8fb6
	defb 020h,001h,002h,000h,001h,01bh	; 8fbc
	defb 021h,000h,014h,003h,000h,01ah	; 8fc2
	defb 020h,001h,014h,001h,000h,01bh	; 8fc8
	defb 01fh,000h,014h,000h,002h,019h	; 8fce
	defb 00eh,000h,000h,000h,001h,01ah	; 8fd4
	defb 020h,001h,000h,001h,000h,017h	; 8fda
	defb 00dh,002h,002h,000h,002h,016h	; 8fe0
	defb 021h,000h,000h,002h,000h,01eh	; 8fe6
	defb 020h,001h,000h,001h,000h,01ah	; 8fec
	defb 021h,000h,002h,000h,001h,01dh	; 8ff2

; ----------------------------------------------------------------------
; DATOS columnas_fase_11: las 72 columnas de la fase 11: 6 bytes cada una, un
;   metabloque por fila (p00:48CF); lo leen p00:48CF (432 bytes)
;   0x8ff8..0x91a8  (432 bytes)
DATA_columnas_fase_11:
	defb 01fh,001h,000h,000h,001h,018h	; 8ff8
	defb 020h,000h,001h,000h,000h,019h	; 8ffe
	defb 00eh,001h,002h,000h,001h,01ah	; 9004
	defb 021h,000h,002h,001h,000h,01bh	; 900a
	defb 00eh,001h,001h,002h,000h,01ah	; 9010
	defb 020h,002h,003h,000h,001h,017h	; 9016
	defb 021h,001h,001h,002h,000h,01ch	; 901c
	defb 021h,000h,000h,000h,002h,01eh	; 9022
	defb 01fh,001h,000h,002h,000h,01bh	; 9028
	defb 020h,000h,001h,003h,000h,017h	; 902e
	defb 021h,014h,000h,000h,001h,016h	; 9034
	defb 00eh,000h,003h,000h,000h,018h	; 903a
	defb 00dh,001h,000h,001h,001h,01bh	; 9040
	defb 021h,000h,001h,000h,007h,019h	; 9046
	defb 00eh,003h,000h,001h,000h,01ch	; 904c
	defb 020h,001h,000h,000h,001h,019h	; 9052
	defb 021h,000h,001h,000h,002h,019h	; 9058
	defb 020h,000h,000h,000h,001h,018h	; 905e
	defb 00ch,001h,000h,001h,000h,017h	; 9064
	defb 013h,000h,001h,000h,001h,01bh	; 906a
	defb 021h,000h,003h,000h,000h,019h	; 9070
	defb 01fh,001h,000h,002h,000h,01ah	; 9076
	defb 020h,000h,003h,000h,001h,01ch	; 907c
	defb 00eh,002h,001h,001h,000h,01eh	; 9082
	defb 020h,002h,000h,001h,000h,01bh	; 9088
	defb 021h,001h,000h,000h,002h,01ch	; 908e
	defb 00dh,000h,001h,001h,004h,01eh	; 9094
	defb 00eh,001h,001h,000h,006h,019h	; 909a
	defb 021h,000h,000h,001h,000h,01ah	; 90a0
	defb 01fh,001h,002h,000h,001h,018h	; 90a6
	defb 020h,001h,000h,001h,000h,019h	; 90ac
	defb 021h,000h,000h,002h,001h,017h	; 90b2
	defb 01fh,000h,001h,000h,007h,01ah	; 90b8
	defb 020h,001h,000h,001h,000h,01bh	; 90be
	defb 00eh,002h,000h,000h,014h,01ch	; 90c4
	defb 00dh,000h,002h,000h,000h,018h	; 90ca
	defb 021h,000h,001h,003h,008h,019h	; 90d0
	defb 020h,001h,000h,001h,001h,01ch	; 90d6
	defb 021h,000h,002h,000h,002h,01bh	; 90dc
	defb 01fh,003h,001h,003h,006h,019h	; 90e2
	defb 020h,000h,000h,001h,000h,016h	; 90e8
	defb 00eh,001h,002h,000h,001h,01ah	; 90ee
	defb 021h,000h,002h,000h,000h,019h	; 90f4
	defb 01fh,000h,001h,001h,000h,01bh	; 90fa
	defb 020h,001h,000h,000h,001h,017h	; 9100
	defb 021h,002h,000h,002h,000h,01ah	; 9106
	defb 00eh,000h,000h,001h,002h,01ch	; 910c
	defb 020h,001h,001h,000h,001h,018h	; 9112
	defb 01fh,000h,001h,000h,007h,01ah	; 9118
	defb 020h,001h,000h,001h,000h,01bh	; 911e
	defb 00eh,002h,000h,000h,014h,01ch	; 9124
	defb 00dh,000h,002h,000h,000h,018h	; 912a
	defb 021h,000h,001h,003h,008h,019h	; 9130
	defb 020h,001h,000h,001h,001h,01ch	; 9136
	defb 021h,000h,002h,000h,002h,01bh	; 913c
	defb 01fh,003h,001h,003h,006h,019h	; 9142
	defb 00eh,001h,000h,001h,002h,018h	; 9148
	defb 00dh,000h,002h,000h,001h,01ah	; 914e
	defb 021h,001h,001h,001h,002h,01bh	; 9154
	defb 015h,014h,014h,014h,014h,019h	; 915a
	defb 015h,014h,014h,014h,014h,017h	; 9160
	defb 015h,014h,014h,014h,014h,01eh	; 9166
	defb 015h,014h,014h,014h,014h,01dh	; 916c
	defb 015h,014h,014h,014h,014h,017h	; 9172
	defb 015h,014h,014h,014h,014h,019h	; 9178
	defb 015h,014h,014h,014h,014h,017h	; 917e
	defb 015h,014h,014h,014h,014h,01ah	; 9184
	defb 021h,014h,014h,014h,014h,016h	; 918a
	defb 020h,014h,014h,014h,014h,01eh	; 9190
	defb 01fh,000h,014h,014h,014h,018h	; 9196
	defb 021h,001h,002h,014h,014h,019h	; 919c
	defb 00dh,002h,000h,001h,014h,01dh	; 91a2

; ----------------------------------------------------------------------
; DATOS rachas_f_91A8: rachas a la VRAM por filas (p10:A67B: <0x80 repite,
;   0x80 serie [cuantos][primero], >0x80 copia, 0 acaba; los ceros no se
;   escriben); lo leen p10:BBFF (122 bytes)
;   0x91a8..0x9222  (122 bytes)
DATA_rachas_f_91A8:
	defb 084h,048h,049h,056h,04ch,00ah,000h,09bh,05eh,068h,05bh,05ah,04fh,04bh,04ah,047h	; 91a8  .HIVL...^h[ZOKJG
	defb 051h,040h,053h,054h,055h,067h,066h,065h,064h,063h,059h,05ch,05dh,061h,050h,04dh	; 91b8  Q@STUgfedcY\]aPM
	defb 046h,04eh,045h,008h,026h,089h,057h,060h,058h,05fh,062h,053h,054h,059h,052h,00ah	; 91c8  FNE.&.W`X_bSTYR.
	defb 000h,088h,06fh,076h,071h,070h,05ah,05bh,055h,04dh,00ah,000h,088h,06ah,072h,078h	; 91d8  ..ovqpZ[UM...jrx
	defb 077h,057h,058h,04eh,050h,00ah,000h,088h,06dh,06bh,075h,074h,05eh,05ch,04fh,051h	; 91e8  wWXNP...mkut^\OQ
	defb 00ah,02dh,08ah,06eh,06ch,079h,07bh,05fh,056h,05dh,064h,065h,066h,003h,067h,003h	; 91f8  .-.nly{_V]def.g.
	defb 084h,08ch,083h,082h,081h,07ah,073h,07ch,060h,03ah,000h,062h,063h,068h,003h,069h	; 9208  .....zs|`:.bch.i
	defb 003h,086h,086h,085h,080h,07fh,000h,087h,07dh,000h	; 9218  ........}.

; ----------------------------------------------------------------------
; DATOS textos_9222: 5 punteros que p10:B9CF lee con 0xE496 (L_4B67): listas a
;   la VRAM, y la que empieza por 0 (0x94C3) acaba; lo leen p10:B9C0 (10
;   bytes)
;   0x9222..0x922c  (10 bytes)
DATA_textos_9222:
	defw 0922ch,09241h,09251h,09267h,094c3h	; 9222

; ----------------------------------------------------------------------
; DATOS lista_922C: lista a la VRAM (p00:4A6B) de la tabla 0x9222, entrada 0;
;   lo leen p10:B9DA (21 bytes)
;   0x922c..0x9241  (21 bytes)
DATA_lista_922C:
	defb 027h,03ah,03eh,0b7h,0afh,0c0h,060h,061h,0d7h,0eah,0c0h,000h,036h,0c7h,0b1h,032h	; 922c  ':>...`a....6..2
	defb 0a2h,02fh,024h,03fh,0ffh	; 923c

; ----------------------------------------------------------------------
; DATOS lista_9241: lista a la VRAM (p00:4A6B) de la tabla 0x9222, entrada 1;
;   lo leen p10:B9DA (16 bytes)
;   0x9241..0x9251  (16 bytes)
DATA_lista_9241:
	defb 069h,03ah,03eh,0f4h,0f5h,0f6h,0f7h,0a4h,030h,0a9h,0a5h,039h,039h,039h,03fh,0ffh	; 9241  i:>.....0..999?.

; ----------------------------------------------------------------------
; DATOS lista_9251: lista a la VRAM (p00:4A6B) de la tabla 0x9222, entrada 2;
;   lo leen p10:B9DA (22 bytes)
;   0x9251..0x9267  (22 bytes)
DATA_lista_9251:
	defb 0a6h,03ah,03eh,0cbh,0b2h,0a3h,0afh,024h,0dah,093h,02ch,093h,0a4h,0c4h,0a8h,02dh	; 9251  .:>....$..,....-
	defb 0bch,0abh,0afh,024h,03fh,0ffh	; 9261

; ----------------------------------------------------------------------
; DATOS lista_9267: lista a la VRAM (p00:4A6B) de la tabla 0x9222, entrada 3;
;   lo leen p10:B9DA (26 bytes)
;   0x9267..0x9281  (26 bytes)
DATA_lista_9267:
	defb 0e4h,03ah,03eh,039h,039h,039h,0f4h,0f5h,0f6h,0f7h,0a4h,030h,0a9h,0c0h,066h,0c7h	; 9267  .:>999.....0..f.
	defb 0b1h,0a3h,0b9h,0c7h,0a2h,0c4h,0a5h,024h,03fh,0ffh	; 9277  .......$?.

; ----------------------------------------------------------------------
; DATOS textos_9281: 6 punteros que p10:B9CF lee con 0xE496 (L_4B67): listas a
;   la VRAM, y la que empieza por 0 (0x94C3) acaba; lo leen p10:BA1C (12
;   bytes)
;   0x9281..0x928d  (12 bytes)
DATA_textos_9281:
	defw 0928dh,092aeh,092bdh,094c3h,092f1h,0930eh	; 9281

; ----------------------------------------------------------------------
; DATOS lista_928D: lista a la VRAM (p00:4A6B) de la tabla 0x9281, entrada 0;
;   lo leen p10:B9DA (33 bytes)
;   0x928d..0x92ae  (33 bytes)
DATA_lista_928D:
	defb 021h,03ah,03eh,0a9h,0c8h,0aeh,075h,07fh,02bh,0eah,0edh,0d3h,093h,0d6h,027h,0eah	; 928d  !:>...u.+.....'.
	defb 0f9h,093h,000h,0e7h,0f9h,0e8h,0e9h,0eah,0cbh,02dh,0b0h,02dh,0bfh,0b5h,024h,03fh	; 929d  .........-.-..$?
	defb 0ffh	; 92ad

; ----------------------------------------------------------------------
; DATOS lista_92AE: lista a la VRAM (p00:4A6B) de la tabla 0x9281, entrada 1;
;   lo leen p10:B9DA (15 bytes)
;   0x92ae..0x92bd  (15 bytes)
DATA_lista_92AE:
	defb 06ah,03ah,03eh,0a9h,0c8h,0aeh,000h,0e7h,0f9h,0e8h,0e9h,0eah,024h,03fh,0ffh	; 92ae  j:>.........$?.

; ----------------------------------------------------------------------
; DATOS lista_92BD: lista a la VRAM (p00:4A6B) de la tabla 0x9281, entrada 2;
;   lo leen p10:B9DA (52 bytes)
;   0x92bd..0x92f1  (52 bytes)
DATA_lista_92BD:
	defb 0a6h,03ah,03eh,0f4h,0f5h,0f6h,0f7h,0bch,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h	; 92bd  .:>.....`a......
	defb 0c0h,086h,09fh,0a0h,05bh,040h,024h,0feh,0e4h,03ah,0e7h,0f9h,0e8h,0e9h,0eah,0a4h	; 92cd  ....[@$..:......
	defb 0fbh,0a2h,0a5h,0c8h,0c0h,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,0c0h,0b4h,030h	; 92dd  .....`a........0
	defb 0ach,024h,03fh,0ffh	; 92ed

; ----------------------------------------------------------------------
; DATOS lista_92F1: lista a la VRAM (p00:4A6B) de la tabla 0x9281, entrada 4;
;   lo leen p10:B9DA (29 bytes)
;   0x92f1..0x930e  (29 bytes)
DATA_lista_92F1:
	defb 023h,03ah,03eh,0e7h,0f9h,0e8h,0e9h,0eah,0a4h,0fbh,0a2h,0a5h,0c8h,0c0h,060h,061h	; 92f1  #:>...........`a
	defb 0eeh,0efh,0f0h,0f1h,0f2h,0f3h,0c0h,0b4h,030h,0ach,024h,03fh,0ffh	; 9301  ........0.$?.

; ----------------------------------------------------------------------
; DATOS lista_930E: lista a la VRAM (p00:4A6B) de la tabla 0x9281, entrada 5;
;   lo leen p10:B9DA (9 bytes)
;   0x930e..0x9317  (9 bytes)
DATA_lista_930E:
	defb 06dh,03ah,03eh,0abh,0c0h,0c7h,024h,03fh,0ffh	; 930e  m:>...$?.

; ----------------------------------------------------------------------
; DATOS lista_9317: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:BA31 (74 bytes)
;   0x9317..0x9361  (74 bytes)
DATA_lista_9317:
	defb 024h,03ah,03eh,0e7h,0f9h,0e8h,0e9h,0eah,0bch,060h,061h,0d7h,0eah,0c0h,037h,0a6h	; 9317  $:>......`a...7.
	defb 0b1h,0a0h,05bh,040h,0c6h,0bdh,0b3h,0a9h,0b0h,0a7h,0feh,064h,03ah,0a3h,0c7h,0a2h	; 9327  ..[@.......d:...
	defb 0f4h,0f5h,0f6h,0f7h,0a4h,0fbh,0cah,034h,0b2h,0aeh,028h,029h,093h,0d7h,0dfh,0ech	; 9337  .......4..()....
	defb 0c0h,0a8h,0b6h,0a9h,0cah,0feh,0a4h,03ah,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h	; 9347  .......:`a......
	defb 0c0h,037h,0b2h,0c7h,0b1h,0afh,0a2h,038h,03fh,0ffh	; 9357  .7.....8?.

; ----------------------------------------------------------------------
; DATOS lista_9361: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:BA67 (83 bytes)
;   0x9361..0x93b4  (83 bytes)
DATA_lista_9361:
	defb 023h,03ah,03eh,0f4h,0f5h,0f6h,0f7h,0a4h,0fbh,035h,0c6h,0c0h,060h,061h,0eeh,0efh	; 9361  #:>......5..`a..
	defb 0f0h,0f1h,0f2h,0f3h,0c0h,0a0h,05bh,040h,0c6h,0bdh,0b3h,0feh,064h,03ah,0b0h,0a8h	; 9371  ......[@....d:..
	defb 08dh,08eh,0a7h,02dh,0a6h,0a2h,0e7h,0f9h,0e8h,0e9h,0eah,0a4h,0fbh,0a2h,0a5h,0c8h	; 9381  ...-............
	defb 0c0h,0f4h,0f5h,0f6h,0f7h,0a7h,0feh,0a4h,03ah,0cbh,0afh,0fbh,060h,061h,0eeh,0efh	; 9391  ........:...`a..
	defb 0f0h,0f1h,0f2h,0f3h,0c0h,037h,0a6h,0b1h,086h,09fh,059h,087h,0a7h,066h,0c7h,0a2h	; 93a1  .....7....Y..f..
	defb 038h,03fh,0ffh	; 93b1

; ----------------------------------------------------------------------
; DATOS textos_93B4: 8 punteros que p10:B9CF lee con 0xE496 (L_4B67): listas a
;   la VRAM, y la que empieza por 0 (0x94C3) acaba; lo leen p10:BAFF (16
;   bytes)
;   0x93b4..0x93c4  (16 bytes)
DATA_textos_93B4:
	defw 093c4h,093e4h,093fch,0940dh,0942dh,09486h,094a1h,094c3h	; 93b4

; ----------------------------------------------------------------------
; DATOS lista_93C4: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 0;
;   lo leen p10:B9DA (32 bytes)
;   0x93c4..0x93e4  (32 bytes)
DATA_lista_93C4:
	defb 021h,03ah,03eh,0a9h,0c8h,0aeh,0e7h,0f9h,0e8h,0e9h,0eah,0fbh,04dh,04eh,075h,07fh	; 93c4  !:>.........MNu.
	defb 02bh,0eah,0edh,0d3h,093h,0d6h,027h,0eah,0f9h,093h,030h,02dh,02fh,038h,03fh,0ffh	; 93d4  +.....'...0-/8?.

; ----------------------------------------------------------------------
; DATOS lista_93E4: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 1;
;   lo leen p10:B9DA (24 bytes)
;   0x93e4..0x93fc  (24 bytes)
DATA_lista_93E4:
	defb 065h,03ah,03eh,0a2h,0c7h,0a2h,0afh,0b9h,0fbh,0f4h,0f5h,0f6h,0f7h,07fh,07bh,07ch	; 93e4  e:>...........{|
	defb 0c0h,0bah,0beh,0a3h,0a2h,038h,03fh,0ffh	; 93f4  .....8?.

; ----------------------------------------------------------------------
; DATOS lista_93FC: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 2;
;   lo leen p10:B9DA (17 bytes)
;   0x93fc..0x940d  (17 bytes)
DATA_lista_93FC:
	defb 0a9h,03ah,03eh,0cbh,031h,0c6h,0b0h,02dh,024h,0d4h,0f5h,0e1h,0f7h,0f3h,024h,03fh	; 93fc  .:>.1..-$.....$?
	defb 0ffh	; 940c

; ----------------------------------------------------------------------
; DATOS lista_940D: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 3;
;   lo leen p10:B9DA (32 bytes)
;   0x940d..0x942d  (32 bytes)
DATA_lista_940D:
	defb 0e1h,03ah,03eh,0a9h,0ach,0c6h,060h,061h,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,0c0h,080h	; 940d  .:>...`a........
	defb 0c9h,07dh,07eh,0bch,0b4h,030h,0c7h,0b1h,0b8h,0b3h,0a5h,0fch,02dh,038h,03fh,0ffh	; 941d  .}~..0......-8?.

; ----------------------------------------------------------------------
; DATOS lista_942D: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 4;
;   lo leen p10:B9DA (89 bytes)
;   0x942d..0x9486  (89 bytes)
DATA_lista_942D:
	defb 02ah,03ah,03eh,0bbh,02dh,026h,0bch,0afh,0a2h,0afh,026h,038h,0feh,062h,03ah,0a3h	; 942d  *:>.-&....&8.b:.
	defb 0b2h,0a3h,0fbh,0b9h,0a5h,000h,0e0h,0f8h,0d1h,0e8h,0d0h,0eah,07fh,07bh,07ch,0c0h	; 943d  .............{|.
	defb 0bah,0beh,0a3h,0a2h,0a1h,0a6h,0c6h,0a4h,0abh,0afh,038h,0feh,0a8h,03ah,039h,039h	; 944d  ..........8..:99
	defb 039h,081h,07bh,0abh,07dh,07eh,0bch,0cbh,0b0h,034h,0ach,0b3h,0a8h,0a4h,0fbh,0feh	; 945d  9.{.}~...4......
	defb 0e5h,03ah,0e0h,0f8h,0d1h,0e8h,0d0h,0eah,0a7h,04dh,04eh,0b2h,0aeh,07ch,02eh,0a3h	; 946d  .:.......MN..|..
	defb 0a2h,0b0h,032h,0a5h,0a6h,0a5h,038h,03fh,0ffh	; 947d  ..2...8?.

; ----------------------------------------------------------------------
; DATOS lista_9486: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 5;
;   lo leen p10:B9DA (27 bytes)
;   0x9486..0x94a1  (27 bytes)
DATA_lista_9486:
	defb 024h,03ah,03eh,039h,039h,039h,0bbh,0a8h,0b0h,032h,0c0h,0a4h,0fbh,0b9h,0a2h,046h	; 9486  $:>999...2.....F
	defb 087h,0a3h,0b1h,0b8h,0ach,0b3h,0b2h,0afh,038h,03fh,0ffh	; 9496  ........8?.

; ----------------------------------------------------------------------
; DATOS lista_94A1: lista a la VRAM (p00:4A6B) de la tabla 0x93B4, entrada 6;
;   lo leen p10:B9DA (34 bytes)
;   0x94a1..0x94c3  (34 bytes)
DATA_lista_94A1:
	defb 06ch,03ah,03eh,0bbh,02dh,0a5h,0abh,039h,039h,039h,0feh,0a7h,03ah,0d3h,0dfh,0f8h	; 94a1  l:>.-..999..:...
	defb 0c6h,0b4h,036h,0b6h,0abh,0bch,0aeh,0b2h,0c4h,0bch,0c3h,0b1h,0cah,0b3h,0b5h,038h	; 94b1  ..6............8
	defb 03fh,0ffh	; 94c1

; ----------------------------------------------------------------------
; DATOS lista_vacia: un 0: la lista vacia con la que p10:B9D5 sabe que se
;   acabaron las tablas de 0x9222, 0x9281 y 0x93B4; lo leen p10:B9D5 (1 bytes)
;   0x94c3..0x94c4  (1 bytes)
DATA_lista_vacia:
	defb 000h	; 94c3

; ----------------------------------------------------------------------
; DATOS lista_94C4: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:B9FF, p10:BA86, p10:BA89 (13 bytes)
;   0x94c4..0x94d1  (13 bytes)
DATA_lista_94C4:
	defb 02bh,039h,0a4h,0ach,0a4h,0b1h,0a6h,0a4h,0adh,0a2h,0b8h,0bdh,0ffh	; 94c4  +9...........

; ----------------------------------------------------------------------
; DATOS lista_94D1: lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro
;   destino; 0xFF acaba); lo leen p10:BA96, p10:BA99 (62 bytes)
;   0x94d1..0x950f  (62 bytes)
DATA_lista_94D1:
	defb 022h,03ah,00ah,018h,021h,01ch,00bh,014h,015h,013h,000h,00fh,019h,000h,00ch,007h	; 94d1  ":..!...........
	defb 019h,01ah,000h,007h,016h,016h,018h,015h,007h,009h,00eh,00fh,014h,00dh,0feh,062h	; 94e1  ...............b
	defb 03ah,014h,00bh,013h,00bh,019h,00fh,019h,024h,000h,018h,00bh,01ah,01bh,018h,014h	; 94f1  :.......$.......
	defb 000h,00fh,013h,013h,00bh,00ah,00fh,007h,01ah,00bh,012h,01fh,024h,0ffh	; 9501  ............$.

; ----------------------------------------------------------------------
; DATOS lista_950F: lista a la VRAM (p00:4A6B) que p10:BBC0 pinta en un MSX
;   japones (0x002B & 0x0F = 0); en los demas, la de 0xBC23 del banco 10; lo
;   leen p10:BBCD (69 bytes)
;   0x950f..0x9554  (69 bytes)
DATA_lista_950F:
	defb 003h,03ah,04dh,04eh,04fh,000h,003h,003h,003h,003h,050h,000h,0e3h,0e1h,0e2h,093h	; 950f  .:MNO.....P.....
	defb 0f3h,0e4h,093h,0f3h,0e5h,0e6h,0e1h,0f9h,093h,039h,0e7h,0f9h,0e8h,0feh,04dh,03ah	; 951f  .........9....M:
	defb 0e9h,0eah,0fbh,0f4h,0f5h,0f6h,0f7h,07bh,07ch,0c0h,0bah,0beh,038h,060h,061h,0eeh	; 952f  .......{|...8`a.
	defb 0efh,0feh,08dh,03ah,0f0h,0f1h,0f2h,0f3h,0c0h,080h,0c9h,07dh,07eh,0bch,0b5h,0cah	; 953f  ...:.......}~...
	defb 0bch,0c3h,0b3h,038h,0ffh	; 954f

; ----------------------------------------------------------------------
; DATOS guion_9554: 12 punteros, uno por fase (0xE201): las listas que
;   p01:657C lee con 0xE358 (L_4C32); lo leen p01:6585 (24 bytes)
;   0x9554..0x956c  (24 bytes)
DATA_guion_9554:
	defw 0956ch,0966dh,0969ah,0969ch,096ddh,096dbh	; 9554
	defw 0976ch,097d1h,098c3h,0991ch,09951h,09980h	; 9560

; ----------------------------------------------------------------------
; DATOS guion_9554_fichas: las listas de guion_9554: fichas [posicion lo
;   hi][dato]; las de varias fases comparten fichas y acaban en la de posicion
;   0xFFFF; el dato de la ultima ficha 0xFFFF (que se lee pero no se usa) son
;   los 1 primeros bytes de lo que va detras, en 0x99C7; lo leen p01:6585
;   (1115 bytes)
;   0x956c..0x99c7  (1115 bytes)
DATA_guion_9554_fichas:
	defb 020h,000h,029h	; 956c
	defb 020h,000h,00dh	; 956f
	defb 023h,000h,06ah	; 9572
	defb 023h,000h,04ch	; 9575
	defb 02ch,000h,069h	; 9578
	defb 02ch,000h,04dh	; 957b
	defb 032h,000h,029h	; 957e
	defb 032h,000h,00dh	; 9581
	defb 037h,000h,06ah	; 9584
	defb 037h,000h,04ch	; 9587
	defb 03eh,000h,069h	; 958a
	defb 03eh,000h,04dh	; 958d
	defb 043h,000h,02ah	; 9590
	defb 043h,000h,00ch	; 9593
	defb 054h,000h,062h	; 9596
	defb 054h,000h,012h	; 9599
	defb 056h,000h,022h	; 959c
	defb 056h,000h,052h	; 959f
	defb 05eh,000h,062h	; 95a2
	defb 05eh,000h,012h	; 95a5
	defb 070h,000h,010h	; 95a8
	defb 072h,000h,050h	; 95ab
	defb 07ch,000h,022h	; 95ae
	defb 07eh,000h,062h	; 95b1
	defb 088h,000h,024h	; 95b4
	defb 088h,000h,052h	; 95b7
	defb 08ah,000h,064h	; 95ba
	defb 092h,000h,052h	; 95bd
	defb 096h,000h,062h	; 95c0
	defb 096h,000h,010h	; 95c3
	defb 0a8h,000h,022h	; 95c6
	defb 0a8h,000h,012h	; 95c9
	defb 0aah,000h,062h	; 95cc
	defb 0aah,000h,052h	; 95cf
	defb 0b4h,000h,00ch	; 95d2
	defb 0b6h,000h,04ch	; 95d5
	defb 0b8h,000h,024h	; 95d8
	defb 0bah,000h,064h	; 95db
	defb 010h,001h,062h	; 95de
	defb 012h,001h,052h	; 95e1
	defb 014h,001h,022h	; 95e4
	defb 016h,001h,012h	; 95e7
	defb 01eh,001h,062h	; 95ea
	defb 020h,001h,024h	; 95ed
	defb 022h,001h,024h	; 95f0
	defb 022h,001h,052h	; 95f3
	defb 024h,001h,062h	; 95f6
	defb 024h,001h,010h	; 95f9
	defb 026h,001h,010h	; 95fc
	defb 028h,001h,052h	; 95ff
	defb 030h,001h,022h	; 9602
	defb 030h,001h,012h	; 9605
	defb 032h,001h,012h	; 9608
	defb 034h,001h,064h	; 960b
	defb 038h,001h,062h	; 960e
	defb 03ch,001h,02ah	; 9611
	defb 03ch,001h,010h	; 9614
	defb 03eh,001h,06ah	; 9617
	defb 03eh,001h,050h	; 961a
	defb 040h,001h,006h	; 961d
	defb 048h,001h,02ch	; 9620
	defb 048h,001h,012h	; 9623
	defb 04ah,001h,06ch	; 9626
	defb 04ah,001h,052h	; 9629
	defb 04ch,001h,02ah	; 962c
	defb 04ch,001h,010h	; 962f
	defb 04eh,001h,044h	; 9632
	defb 04eh,001h,06ah	; 9635
	defb 04eh,001h,050h	; 9638
	defb 054h,001h,02ah	; 963b
	defb 056h,001h,062h	; 963e
	defb 05eh,001h,062h	; 9641
	defb 064h,001h,012h	; 9644
	defb 068h,001h,066h	; 9647
	defb 06ch,001h,024h	; 964a
	defb 06eh,001h,052h	; 964d
	defb 08ch,001h,052h	; 9650
	defb 090h,001h,050h	; 9653
	defb 092h,001h,050h	; 9656
	defb 094h,001h,062h	; 9659
	defb 094h,001h,04eh	; 965c
	defb 096h,001h,062h	; 965f
	defb 098h,001h,062h	; 9662
	defb 09eh,001h,062h	; 9665
	defb 09eh,001h,052h	; 9668
	defb 0ffh,0ffh,0b4h	; 966b
	defb 000h,053h,0bah	; 966e
	defb 000h,061h,0cch	; 9671
	defb 000h,053h,0d4h	; 9674
	defb 000h,061h,0d6h	; 9677
	defb 000h,061h,002h	; 967a
	defb 001h,053h,004h	; 967d
	defb 001h,053h,005h	; 9680
	defb 001h,061h,007h	; 9683
	defb 001h,061h,028h	; 9686
	defb 001h,052h,02ah	; 9689
	defb 001h,052h,05ch	; 968c
	defb 001h,053h,05eh	; 968f
	defb 001h,053h,06eh	; 9692
	defb 001h,061h,070h	; 9695
	defb 001h,053h,0ffh	; 9698
	defb 0ffh,073h,000h	; 969b
	defb 052h,075h,000h	; 969e
	defb 052h,099h,000h	; 96a1
	defb 022h,09bh,000h	; 96a4
	defb 062h,09ch,000h	; 96a7
	defb 052h,0a0h,000h	; 96aa
	defb 012h,0abh,000h	; 96ad
	defb 062h,0b1h,000h	; 96b0
	defb 022h,0b3h,000h	; 96b3
	defb 062h,0c9h,000h	; 96b6
	defb 052h,0ceh,000h	; 96b9
	defb 011h,0eeh,000h	; 96bc
	defb 062h,0f0h,000h	; 96bf
	defb 062h,081h,001h	; 96c2
	defb 022h,083h,001h	; 96c5
	defb 062h,08ch,001h	; 96c8
	defb 052h,094h,001h	; 96cb
	defb 04fh,09ah,001h	; 96ce
	defb 064h,0a4h,001h	; 96d1
	defb 00ch,0bah,001h	; 96d4
	defb 064h,0bch,001h	; 96d7
	defb 064h,0ffh,0ffh	; 96da
	defb 087h,000h,04ah	; 96dd
	defb 089h,000h,04ah	; 96e0
	defb 08ch,000h,04ah	; 96e3
	defb 095h,000h,065h	; 96e6
	defb 09ah,000h,052h	; 96e9
	defb 09ch,000h,012h	; 96ec
	defb 0a1h,000h,012h	; 96ef
	defb 0a3h,000h,052h	; 96f2
	defb 0a9h,000h,04eh	; 96f5
	defb 0abh,000h,04eh	; 96f8
	defb 0c1h,000h,029h	; 96fb
	defb 0c1h,000h,061h	; 96fe
	defb 0cah,000h,052h	; 9701
	defb 0cch,000h,012h	; 9704
	defb 0d4h,000h,029h	; 9707
	defb 0e8h,000h,052h	; 970a
	defb 0eah,000h,052h	; 970d
	defb 0f6h,000h,062h	; 9710
	defb 0f8h,000h,062h	; 9713
	defb 010h,001h,029h	; 9716
	defb 012h,001h,02ah	; 9719
	defb 020h,001h,066h	; 971c
	defb 022h,001h,066h	; 971f
	defb 026h,001h,012h	; 9722
	defb 028h,001h,012h	; 9725
	defb 02ah,001h,052h	; 9728
	defb 02ch,001h,052h	; 972b
	defb 035h,001h,04eh	; 972e
	defb 04dh,001h,0ceh	; 9731
	defb 050h,001h,062h	; 9734
	defb 052h,001h,062h	; 9737
	defb 064h,001h,04ah	; 973a
	defb 066h,001h,04ah	; 973d
	defb 06eh,001h,012h	; 9740
	defb 070h,001h,052h	; 9743
	defb 076h,001h,052h	; 9746
	defb 078h,001h,012h	; 9749
	defb 07dh,001h,04ah	; 974c
	defb 09ch,001h,0e5h	; 974f
	defb 0a0h,001h,04eh	; 9752
	defb 0a6h,001h,062h	; 9755
	defb 0a8h,001h,062h	; 9758
	defb 0c0h,001h,04eh	; 975b
	defb 0c2h,001h,04eh	; 975e
	defb 0d9h,001h,04eh	; 9761
	defb 0eah,001h,026h	; 9764
	defb 0ech,001h,026h	; 9767
	defb 0ffh,0ffh,063h	; 976a
	defb 000h,022h,066h	; 976d
	defb 000h,011h,066h	; 9770
	defb 000h,063h,068h	; 9773
	defb 000h,024h,068h	; 9776
	defb 000h,050h,077h	; 9779
	defb 000h,04fh,07eh	; 977c
	defb 000h,024h,086h	; 977f
	defb 000h,064h,089h	; 9782
	defb 000h,050h,08bh	; 9785
	defb 000h,04fh,09dh	; 9788
	defb 000h,010h,0f4h	; 978b
	defb 000h,022h,0f6h	; 978e
	defb 000h,051h,0f8h	; 9791
	defb 000h,050h,0fdh	; 9794
	defb 000h,022h,001h	; 9797
	defb 001h,022h,005h	; 979a
	defb 001h,010h,009h	; 979d
	defb 001h,010h,00bh	; 97a0
	defb 001h,04fh,00dh	; 97a3
	defb 001h,04eh,01ch	; 97a6
	defb 001h,064h,01eh	; 97a9
	defb 001h,064h,023h	; 97ac
	defb 001h,064h,02fh	; 97af
	defb 001h,04eh,032h	; 97b2
	defb 001h,04dh,034h	; 97b5
	defb 001h,04ch,03ch	; 97b8
	defb 001h,026h,047h	; 97bb
	defb 001h,066h,04eh	; 97be
	defb 001h,04bh,052h	; 97c1
	defb 001h,068h,052h	; 97c4
	defb 001h,04ch,05dh	; 97c7
	defb 001h,068h,05dh	; 97ca
	defb 001h,04ch,0ffh	; 97cd
	defb 0ffh,060h,000h	; 97d0
	defb 062h,060h,000h	; 97d3
	defb 052h,062h,000h	; 97d6
	defb 022h,062h,000h	; 97d9
	defb 012h,068h,000h	; 97dc
	defb 024h,068h,000h	; 97df
	defb 04ah,06ah,000h	; 97e2
	defb 024h,06ah,000h	; 97e5
	defb 00ah,07ch,000h	; 97e8
	defb 0d2h,07eh,000h	; 97eb
	defb 064h,086h,000h	; 97ee
	defb 024h,086h,000h	; 97f1
	defb 04ch,08eh,000h	; 97f4
	defb 092h,092h,000h	; 97f7
	defb 050h,096h,000h	; 97fa
	defb 022h,096h,000h	; 97fd
	defb 012h,098h,000h	; 9800
	defb 062h,0aah,000h	; 9803
	defb 052h,0ach,000h	; 9806
	defb 0d0h,0b2h,000h	; 9809
	defb 022h,0b4h,000h	; 980c
	defb 022h,0b6h,000h	; 980f
	defb 062h,0b8h,000h	; 9812
	defb 04eh,0c6h,000h	; 9815
	defb 050h,0c8h,000h	; 9818
	defb 00eh,0d8h,000h	; 981b
	defb 064h,0d9h,000h	; 981e
	defb 012h,0dah,000h	; 9821
	defb 024h,0dbh,000h	; 9824
	defb 052h,0ddh,000h	; 9827
	defb 012h,028h,001h	; 982a
	defb 052h,02ah,001h	; 982d
	defb 052h,030h,001h	; 9830
	defb 064h,032h,001h	; 9833
	defb 064h,088h,001h	; 9836
	defb 052h,08ah,001h	; 9839
	defb 052h,0b2h,001h	; 983c
	defb 062h,0b4h,001h	; 983f
	defb 062h,0b6h,001h	; 9842
	defb 062h,0c8h,001h	; 9845
	defb 062h,0cah,001h	; 9848
	defb 062h,0d8h,001h	; 984b
	defb 04eh,0dah,001h	; 984e
	defb 04eh,0e4h,001h	; 9851
	defb 052h,0e6h,001h	; 9854
	defb 052h,0e8h,001h	; 9857
	defb 062h,0eah,001h	; 985a
	defb 062h,0f8h,001h	; 985d
	defb 052h,0f8h,001h	; 9860
	defb 0e2h,0fah,001h	; 9863
	defb 052h,0feh,001h	; 9866
	defb 050h,002h,002h	; 9869
	defb 052h,006h,002h	; 986c
	defb 04eh,008h,002h	; 986f
	defb 062h,00ah,002h	; 9872
	defb 062h,00bh,002h	; 9875
	defb 052h,012h,002h	; 9878
	defb 062h,012h,002h	; 987b
	defb 052h,04ch,002h	; 987e
	defb 062h,04eh,002h	; 9881
	defb 062h,050h,002h	; 9884
	defb 052h,052h,002h	; 9887
	defb 0d2h,054h,002h	; 988a
	defb 064h,054h,002h	; 988d
	defb 04ch,056h,002h	; 9890
	defb 064h,056h,002h	; 9893
	defb 04ch,05eh,002h	; 9896
	defb 064h,05eh,002h	; 9899
	defb 052h,062h,002h	; 989c
	defb 052h,066h,002h	; 989f
	defb 04eh,06ch,002h	; 98a2
	defb 062h,06ch,002h	; 98a5
	defb 052h,072h,002h	; 98a8
	defb 062h,078h,002h	; 98ab
	defb 04eh,07dh,002h	; 98ae
	defb 064h,082h,002h	; 98b1
	defb 062h,082h,002h	; 98b4
	defb 04eh,086h,002h	; 98b7
	defb 064h,086h,002h	; 98ba
	defb 052h,088h,002h	; 98bd
	defb 052h,0ffh,0ffh	; 98c0
	defb 00eh,000h,010h	; 98c3
	defb 010h,000h,00eh	; 98c6
	defb 01ah,000h,022h	; 98c9
	defb 01ch,000h,024h	; 98cc
	defb 022h,000h,00eh	; 98cf
	defb 026h,000h,024h	; 98d2
	defb 028h,000h,026h	; 98d5
	defb 028h,000h,00ah	; 98d8
	defb 02ah,000h,026h	; 98db
	defb 02ah,000h,00ah	; 98de
	defb 032h,000h,064h	; 98e1
	defb 032h,000h,00ch	; 98e4
	defb 036h,000h,026h	; 98e7
	defb 036h,000h,00eh	; 98ea
	defb 03ah,000h,050h	; 98ed
	defb 044h,000h,064h	; 98f0
	defb 046h,000h,052h	; 98f3
	defb 048h,000h,012h	; 98f6
	defb 04ah,000h,012h	; 98f9
	defb 04eh,000h,010h	; 98fc
	defb 058h,000h,022h	; 98ff
	defb 058h,000h,052h	; 9902
	defb 05ah,000h,062h	; 9905
	defb 05ah,000h,012h	; 9908
	defb 05ch,000h,010h	; 990b
	defb 066h,000h,00eh	; 990e
	defb 06ah,000h,062h	; 9911
	defb 076h,000h,024h	; 9914
	defb 076h,000h,00eh	; 9917
	defb 0ffh,0ffh,022h	; 991a
	defb 000h,062h,024h	; 991d
	defb 000h,062h,024h	; 9920
	defb 000h,052h,026h	; 9923
	defb 000h,062h,026h	; 9926
	defb 000h,052h,02bh	; 9929
	defb 000h,052h,02eh	; 992c
	defb 000h,052h,06ah	; 992f
	defb 000h,062h,072h	; 9932
	defb 000h,062h,07ch	; 9935
	defb 000h,052h,07eh	; 9938
	defb 000h,052h,080h	; 993b
	defb 000h,062h,080h	; 993e
	defb 000h,052h,082h	; 9941
	defb 000h,062h,082h	; 9944
	defb 000h,052h,0e4h	; 9947
	defb 000h,062h,0e6h	; 994a
	defb 000h,062h,0ffh	; 994d
	defb 0ffh,024h,000h	; 9950
	defb 062h,024h,000h	; 9953
	defb 052h,026h,000h	; 9956
	defb 052h,026h,000h	; 9959
	defb 062h,028h,000h	; 995c
	defb 062h,02ah,000h	; 995f
	defb 062h,080h,000h	; 9962
	defb 04fh,0c8h,000h	; 9965
	defb 062h,0cah,000h	; 9968
	defb 062h,0d0h,000h	; 996b
	defb 062h,0d2h,000h	; 996e
	defb 062h,0d4h,000h	; 9971
	defb 062h,0d4h,000h	; 9974
	defb 052h,0d6h,000h	; 9977
	defb 062h,0d6h,000h	; 997a
	defb 052h,0ffh,0ffh	; 997d
	defb 026h,000h,052h	; 9980
	defb 028h,000h,04fh	; 9983
	defb 02eh,000h,04ch	; 9986
	defb 030h,000h,04ch	; 9989
	defb 030h,000h,062h	; 998c
	defb 036h,000h,052h	; 998f
	defb 038h,000h,052h	; 9992
	defb 03ch,000h,062h	; 9995
	defb 03eh,000h,062h	; 9998
	defb 044h,000h,062h	; 999b
	defb 044h,000h,052h	; 999e
	defb 045h,000h,04ch	; 99a1
	defb 046h,000h,052h	; 99a4
	defb 060h,000h,052h	; 99a7
	defb 062h,000h,052h	; 99aa
	defb 074h,000h,062h	; 99ad
	defb 078h,000h,062h	; 99b0
	defb 07ah,000h,052h	; 99b3
	defb 08ch,000h,062h	; 99b6
	defb 09ah,000h,052h	; 99b9
	defb 0e6h,000h,052h	; 99bc
	defb 0e8h,000h,052h	; 99bf
	defb 00ah,001h,062h	; 99c2
	defb 0ffh,0ffh	; 99c5

; ----------------------------------------------------------------------
; DATOS sucesos_por_fase: 9 punteros, uno por fase de la 0 a la 8, que
;   p01:6DC2 lee con L_4B60; lo leen p01:6DCB (18 bytes)
;   0x99c7..0x99d9  (18 bytes)
DATA_sucesos_por_fase:
	defw 099d9h,099e9h,099f9h,09a09h,09a29h,09a19h,09a39h,09a49h,09a61h	; 99c7

; ----------------------------------------------------------------------
; DATOS sucesos: por fase, un byte por cada 32 de scroll (p01:6DCE: 0x99xx +
;   (0xE203 / 32)): sus dos cifras son dos sucesos de la tabla de p01:6E07 (la
;   baja solo con 0xE228 >= 10); lo leen p01:6DE0 (142 bytes)
;   0x99d9..0x9a67  (142 bytes)
DATA_sucesos:
	defb 000h,000h,000h,007h,020h,020h,010h,010h,030h,030h,020h,020h,070h,000h,000h,000h	; 99d9  ....  ..00  p...
	defb 000h,000h,001h,030h,003h,021h,000h,000h,001h,000h,000h,030h,000h,000h,000h,000h	; 99e9  ...0.!.....0....
	defb 000h,000h,010h,014h,000h,000h,000h,000h,000h,040h,004h,000h,0a0h,0a0h,000h,000h	; 99f9  .........@......
	defb 000h,000h,010h,010h,010h,060h,060h,000h,060h,060h,000h,006h,000h,000h,000h,000h	; 9a09  .....``.``......
	defb 000h,000h,055h,044h,000h,060h,000h,055h,000h,064h,064h,060h,000h,000h,000h,000h	; 9a19  ..UD.`.U.dd`....
	defb 000h,000h,000h,090h,090h,000h,010h,094h,000h,030h,090h,000h,090h,009h,000h,090h	; 9a29  .........0......
	defb 000h,000h,030h,080h,080h,08bh,08bh,000h,000h,0b0h,0b0h,0b0h,0b8h,000h,000h,000h	; 9a39  ..0.............
	defb 000h,010h,010h,010h,040h,020h,020h,040h,000h,000h,000h,000h,040h,000h,020h,020h	; 9a49  ....@  @....@.
	defb 040h,000h,000h,000h,000h,000h,000h,000h,020h,000h,000h,000h,000h,000h	; 9a59  @....... .....

; ----------------------------------------------------------------------
; DATOS guion_9A67: 9 punteros, uno por fase (0xE201): las listas que p01:6F64
;   lee con 0xE37C (p01:6F9A, fases 0 a 8); lo leen p01:6F6D (18 bytes)
;   0x9a67..0x9a79  (18 bytes)
DATA_guion_9A67:
	defw 09a79h,09abbh,09af3h,09af5h,09b45h,09b45h	; 9a67
	defw 09b45h,09b47h,09b99h	; 9a73

; ----------------------------------------------------------------------
; DATOS guion_9A67_fichas: las listas de guion_9A67: fichas [posicion lo
;   hi][dos datos]; las de varias fases comparten fichas y acaban en la de
;   posicion 0xFFFF; el dato de la ultima ficha 0xFFFF (que se lee pero no se
;   usa) son los 2 primeros bytes de lo que va detras, en 0x9BD3; lo leen
;   p01:6F6D (346 bytes)
;   0x9a79..0x9bd3  (346 bytes)
DATA_guion_9A67_fichas:
	defb 080h,000h,00eh,000h	; 9a79
	defb 080h,000h,00eh,0a0h	; 9a7d
	defb 080h,004h,00eh,000h	; 9a81
	defb 080h,004h,00eh,0a0h	; 9a85
	defb 0a0h,000h,00eh,000h	; 9a89
	defb 0a0h,000h,00eh,0a0h	; 9a8d
	defb 0a0h,004h,00eh,000h	; 9a91
	defb 0a0h,004h,00eh,0a0h	; 9a95
	defb 0a0h,008h,00eh,000h	; 9a99
	defb 0a0h,008h,00eh,0a0h	; 9a9d
	defb 0a0h,001h,00eh,000h	; 9aa1
	defb 0a0h,001h,00eh,0a0h	; 9aa5
	defb 0a0h,005h,00eh,000h	; 9aa9
	defb 0a0h,005h,00eh,0a0h	; 9aad
	defb 0a0h,009h,00eh,000h	; 9ab1
	defb 0a0h,009h,00eh,0a0h	; 9ab5
	defb 0ffh,0ffh,084h,004h	; 9ab9
	defb 003h,008h,084h,000h	; 9abd
	defb 003h,098h,08eh,000h	; 9ac1
	defb 003h,098h,098h,004h	; 9ac5
	defb 003h,008h,0a6h,004h	; 9ac9
	defb 002h,018h,0a8h,004h	; 9acd
	defb 002h,020h,0afh,004h	; 9ad1
	defb 002h,020h,028h,005h	; 9ad5
	defb 003h,008h,03eh,001h	; 9ad9
	defb 042h,088h,040h,001h	; 9add
	defb 042h,080h,046h,001h	; 9ae1
	defb 042h,080h,048h,001h	; 9ae5
	defb 042h,088h,054h,001h	; 9ae9
	defb 003h,098h,072h,001h	; 9aed
	defb 043h,098h,0ffh,0ffh	; 9af1
	defb 078h,000h,002h,030h	; 9af5
	defb 086h,000h,002h,080h	; 9af9
	defb 09fh,004h,08eh,0a0h	; 9afd
	defb 0a1h,004h,00eh,000h	; 9b01
	defb 030h,001h,00eh,000h	; 9b05
	defb 030h,001h,00eh,0a0h	; 9b09
	defb 032h,005h,00eh,0a0h	; 9b0d
	defb 032h,005h,00eh,000h	; 9b11
	defb 03ah,001h,00eh,0a0h	; 9b15
	defb 03ah,001h,00eh,000h	; 9b19
	defb 03ch,005h,00eh,0a0h	; 9b1d
	defb 03ch,005h,00eh,000h	; 9b21
	defb 069h,001h,002h,080h	; 9b25
	defb 0a0h,001h,002h,070h	; 9b29
	defb 0c0h,001h,00eh,000h	; 9b2d
	defb 0c1h,001h,00eh,098h	; 9b31
	defb 0c8h,005h,00eh,000h	; 9b35
	defb 0c9h,005h,00eh,098h	; 9b39
	defb 0d0h,001h,00eh,000h	; 9b3d
	defb 0d1h,005h,00eh,098h	; 9b41
	defb 0ffh,0ffh,0e0h,001h	; 9b45
	defb 00eh,000h,0e0h,001h	; 9b49
	defb 00eh,090h,0e0h,001h	; 9b4d
	defb 04eh,000h,0e0h,001h	; 9b51
	defb 04eh,090h,020h,006h	; 9b55
	defb 01bh,040h,028h,002h	; 9b59
	defb 01bh,040h,030h,002h	; 9b5d
	defb 01bh,040h,034h,006h	; 9b61
	defb 01bh,040h,060h,002h	; 9b65
	defb 00eh,000h,060h,002h	; 9b69
	defb 00eh,098h,060h,006h	; 9b6d
	defb 00eh,000h,060h,00ah	; 9b71
	defb 00eh,098h,060h,00ah	; 9b75
	defb 00eh,000h,0c0h,002h	; 9b79
	defb 020h,010h,0c4h,006h	; 9b7d
	defb 020h,090h,0c8h,006h	; 9b81
	defb 020h,010h,0cch,002h	; 9b85
	defb 020h,080h,0d0h,006h	; 9b89
	defb 020h,020h,0d4h,002h	; 9b8d
	defb 020h,030h,0d8h,006h	; 9b91
	defb 020h,070h,0ffh,0ffh	; 9b95
	defb 028h,000h,00eh,090h	; 9b99
	defb 028h,000h,00eh,000h	; 9b9d
	defb 028h,004h,00eh,090h	; 9ba1
	defb 028h,004h,00eh,010h	; 9ba5
	defb 038h,000h,00eh,090h	; 9ba9
	defb 038h,000h,00eh,000h	; 9bad
	defb 038h,004h,00eh,090h	; 9bb1
	defb 038h,004h,00eh,010h	; 9bb5
	defb 060h,000h,00eh,000h	; 9bb9
	defb 060h,000h,00eh,090h	; 9bbd
	defb 060h,004h,00eh,000h	; 9bc1
	defb 060h,004h,08eh,090h	; 9bc5
	defb 060h,008h,00eh,010h	; 9bc9
	defb 060h,008h,00eh,090h	; 9bcd
	defb 0ffh,0ffh	; 9bd1

; ----------------------------------------------------------------------
; DATOS cifras_grandes: 26 punteros (p00:5409, A de 1 a 25 con L_4B67) a
;   dibujos de 8 filas de 6 bytes; lo leen p00:540C (52 bytes)
;   0x9bd3..0x9c07  (52 bytes)
DATA_cifras_grandes:
	defw 09fc7h,09f97h,09de7h,09e17h,09e47h,09c67h,09c07h,09e77h	; 9bd3
	defw 09cc7h,09c37h,09d27h,09d57h,09d87h,09db7h,09f37h,09f67h	; 9be3
	defw 09cf7h,09c97h,09ea7h,09ed7h,09f07h,09fc7h,09ff7h,0a027h	; 9bf3
	defw 0a057h,0a087h	; 9c03

; ----------------------------------------------------------------------
; DATOS cifras_grandes_dibujos: dibujos de 48 bytes (8 filas de 6) que
;   p00:541B saca al VDP fila a fila, con un byte de borde a cada lado (0xFF,
;   o 0x00 desde el 0x14) (sigue en el banco 15, en 0xA000); lo leen p00:5420
;   (1017 bytes)
;   0x9c07..0xa000  (1017 bytes)
DATA_cifras_grandes_dibujos:
	defb 0feh,0feh,0feh,0feh,0feh,0feh	; 9c07
	defb 018h,0dbh,00bh,0e8h,0ebh,00bh	; 9c0d
	defb 020h,0afh,0afh,02fh,0afh,0a0h	; 9c13
	defb 0b7h,0b7h,083h,0bbh,0bbh,0bbh	; 9c19
	defb 00ch,06dh,004h,075h,075h,004h	; 9c1f
	defb 010h,0f7h,017h,0f0h,0f7h,017h	; 9c25
	defb 040h,05bh,05bh,05bh,05bh,05bh	; 9c2b
	defb 07fh,07fh,07fh,07fh,07fh,07fh	; 9c31
	defb 082h,0beh,082h,0beh,0beh,0beh	; 9c37
	defb 082h,0bah,082h,0b6h,0b6h,0b2h	; 9c3d
	defb 00ch,0fdh,00ch,0fdh,0fdh,00ch	; 9c43
	defb 037h,0b7h,017h,0d7h,0d7h,010h	; 9c49
	defb 0c1h,0ddh,0ddh,0c1h,0ddh,05dh	; 9c4f
	defb 004h,07fh,007h,0f7h,0f7h,007h	; 9c55
	defb 010h,077h,070h,077h,077h,070h	; 9c5b
	defb 041h,0ddh,041h,0dbh,0dbh,059h	; 9c61
	defb 082h,0bah,0bah,0bah,0bah,0bah	; 9c67
	defb 008h,0ebh,0e8h,00bh,0ebh,0ebh	; 9c6d
	defb 020h,0aeh,02eh,0e0h,0eeh,0eeh	; 9c73
	defb 0bch,0bdh,0bdh,0bdh,0bdh,085h	; 9c79
	defb 007h,0b6h,0b6h,0b6h,0b6h,0b6h	; 9c7f
	defb 0ffh,00ah,0aah,0aah,0abh,0aah	; 9c85
	defb 0ffh,022h,0eeh,022h,0bah,022h	; 9c8b
	defb 0ffh,0b1h,0b7h,0b1h,0b7h,081h	; 9c91
	defb 0ddh,0ddh,0ddh,0d1h,0d7h,0c7h	; 9c97
	defb 004h,07dh,005h,07dh,07dh,004h	; 9c9d
	defb 008h,0feh,0feh,0feh,0feh,00eh	; 9ca3
	defb 020h,0efh,0efh,0efh,0efh,0e0h	; 9ca9
	defb 040h,05eh,040h,05dh,05dh,05ch	; 9caf
	defb 0dch,0ddh,0ddh,0dch,0ddh,0c5h	; 9cb5
	defb 044h,05dh,044h,075h,075h,044h	; 9cbb
	defb 043h,0dbh,043h,0d7h,0d7h,053h	; 9cc1
	defb 0e0h,0eeh,0e0h,0edh,0edh,0ech	; 9cc7
	defb 082h,0beh,082h,0beh,0beh,082h	; 9ccd
	defb 00bh,0fbh,00bh,0fbh,0fbh,0f8h	; 9cd3
	defb 0c1h,0dfh,0c1h,0dfh,0dfh,041h	; 9cd9
	defb 039h,093h,0c7h,0c7h,093h,039h	; 9cdf
	defb 0c1h,0ddh,0c1h,0dbh,0dbh,0d9h	; 9ce5
	defb 041h,05dh,05dh,05dh,05dh,05dh	; 9ceb
	defb 007h,07fh,047h,077h,077h,007h	; 9cf1
	defb 0c1h,0dfh,0c1h,0dfh,0dfh,0c1h	; 9cf7
	defb 038h,093h,0c7h,0c7h,093h,039h	; 9cfd
	defb 008h,0bbh,0b8h,0bbh,0bbh,0b8h	; 9d03
	defb 020h,0eeh,02eh,0eeh,0eeh,02eh	; 9d09
	defb 087h,0b3h,0b9h,0bdh,0bdh,081h	; 9d0f
	defb 0dch,0ddh,0ddh,0dch,0ddh,0c5h	; 9d15
	defb 044h,05dh,044h,075h,075h,044h	; 9d1b
	defb 043h,0dbh,043h,0d7h,0d7h,053h	; 9d21
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f0h	; 9d27
	defb 040h,05eh,040h,05fh,05fh,05fh	; 9d2d
	defb 0dfh,0dfh,0dfh,0dfh,0dfh,0c1h	; 9d33
	defb 004h,075h,074h,007h,077h,074h	; 9d39
	defb 010h,0f7h,010h,0d7h,0d7h,010h	; 9d3f
	defb 040h,0deh,040h,0ddh,0ddh,05ch	; 9d45
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9d4b
	defb 00fh,0cfh,0cfh,0cfh,0cfh,0cfh	; 9d51
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f0h	; 9d57
	defb 040h,05eh,040h,05fh,05fh,05fh	; 9d5d
	defb 0dfh,0dfh,0dfh,0dfh,0dfh,0c1h	; 9d63
	defb 004h,075h,074h,007h,077h,074h	; 9d69
	defb 010h,0f7h,010h,0d7h,0d7h,010h	; 9d6f
	defb 040h,0deh,040h,0ddh,0ddh,05ch	; 9d75
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9d7b
	defb 00fh,0efh,00fh,07fh,00fh,00fh	; 9d81
	defb 0c7h,0d3h,0d9h,0ddh,0ddh,0c1h	; 9d87
	defb 005h,075h,075h,075h,075h,004h	; 9d8d
	defb 050h,056h,056h,056h,056h,016h	; 9d93
	defb 0dch,0ddh,0ddh,0dch,0ddh,0c5h	; 9d99
	defb 044h,05dh,044h,075h,075h,044h	; 9d9f
	defb 043h,0dbh,043h,0d7h,0d7h,053h	; 9da5
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9dab
	defb 00fh,0cfh,0cfh,0cfh,0cfh,0cfh	; 9db1
	defb 0c7h,0d3h,0d9h,0ddh,0ddh,0c1h	; 9db7
	defb 005h,075h,075h,075h,075h,004h	; 9dbd
	defb 050h,056h,056h,056h,056h,016h	; 9dc3
	defb 0dch,0ddh,0ddh,0dch,0ddh,0c5h	; 9dc9
	defb 044h,05dh,044h,075h,075h,044h	; 9dcf
	defb 043h,0dbh,043h,0d7h,0d7h,053h	; 9dd5
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9ddb
	defb 00fh,0efh,00fh,07fh,00fh,00fh	; 9de1
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9de7
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ded
	defb 082h,0beh,082h,0fah,0fah,082h	; 9df3
	defb 008h,0ebh,008h,0fbh,0fbh,0f8h	; 9df9
	defb 020h,0efh,020h,0efh,0efh,020h	; 9dff
	defb 087h,0b3h,0b9h,0bdh,0bdh,081h	; 9e05
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e0b
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e11
	defb 0f8h,0fbh,0fbh,0fbh,0fbh,0fbh	; 9e17
	defb 00ah,06ah,06ah,06bh,06bh,06ah	; 9e1d
	defb 008h,0fbh,008h,0efh,0efh,008h	; 9e23
	defb 02bh,0ebh,02bh,0abh,0abh,028h	; 9e29
	defb 0e8h,0ebh,0e8h,0ebh,0ebh,028h	; 9e2f
	defb 01fh,0ffh,01fh,0ffh,0ffh,01fh	; 9e35
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9e3b
	defb 00fh,0cfh,0cfh,0cfh,0cfh,0cfh	; 9e41
	defb 0f8h,0fbh,0fbh,0fbh,0fbh,0fbh	; 9e47
	defb 00ah,06ah,06ah,06bh,06bh,06ah	; 9e4d
	defb 008h,0fbh,008h,0efh,0efh,008h	; 9e53
	defb 02bh,0ebh,02bh,0abh,0abh,028h	; 9e59
	defb 0e8h,0ebh,0e8h,0ebh,0ebh,028h	; 9e5f
	defb 01fh,0ffh,01fh,0ffh,0ffh,01fh	; 9e65
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9e6b
	defb 00fh,0efh,00fh,07fh,00fh,00fh	; 9e71
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e77
	defb 0f8h,0fbh,0fbh,0fbh,0fbh,0f8h	; 9e7d
	defb 070h,037h,097h,0d7h,0d7h,010h	; 9e83
	defb 02fh,0afh,0afh,0afh,0afh,020h	; 9e89
	defb 043h,05bh,041h,05dh,05dh,041h	; 9e8f
	defb 07ch,07dh,07ch,07dh,07dh,004h	; 9e95
	defb 01fh,0ffh,01fh,0ffh,0ffh,01fh	; 9e9b
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ea1
	defb 0f8h,0fbh,0fbh,0fbh,0fbh,0f8h	; 9ea7
	defb 010h,0d7h,0d0h,0d7h,0d7h,017h	; 9ead
	defb 020h,0bbh,03bh,0fbh,0fbh,0fbh	; 9eb3
	defb 0a0h,0afh,0afh,0afh,0afh,0a0h	; 9eb9
	defb 040h,05eh,05eh,05eh,05eh,05eh	; 9ebf
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ec5
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9ecb
	defb 00fh,0cfh,0cfh,0cfh,0cfh,0cfh	; 9ed1
	defb 0f8h,0fbh,0fbh,0fbh,0fbh,0f8h	; 9ed7
	defb 010h,0d7h,0d0h,0d7h,0d7h,017h	; 9edd
	defb 020h,0bbh,03bh,0fbh,0fbh,0fbh	; 9ee3
	defb 0a0h,0afh,0afh,0afh,0afh,0a0h	; 9ee9
	defb 040h,05eh,05eh,05eh,05eh,05eh	; 9eef
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ef5
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9efb
	defb 00fh,0efh,00fh,07fh,00fh,00fh	; 9f01
	defb 0e0h,0efh,0e0h,0efh,0efh,0efh	; 9f07
	defb 082h,0bah,0bah,0bah,0bah,082h	; 9f0d
	defb 008h,0ebh,00bh,0dbh,0dbh,0c8h	; 9f13
	defb 020h,0efh,0e0h,0efh,0efh,020h	; 9f19
	defb 0e0h,0efh,0e0h,0efh,0efh,0efh	; 9f1f
	defb 0a0h,0afh,0a0h,0afh,0afh,0a0h	; 9f25
	defb 0beh,0beh,0beh,0beh,0beh,082h	; 9f2b
	defb 01fh,0cfh,0e7h,0f7h,0f7h,007h	; 9f31
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f37
	defb 0beh,0beh,0beh,0beh,0beh,082h	; 9f3d
	defb 008h,0ebh,0e8h,00fh,0efh,0e8h	; 9f43
	defb 020h,0efh,020h,0afh,0afh,020h	; 9f49
	defb 081h,0bdh,081h,0bbh,0bbh,0b9h	; 9f4f
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f55
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9f5b
	defb 00fh,0cfh,0cfh,0cfh,0cfh,0cfh	; 9f61
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f67
	defb 0beh,0beh,0beh,0beh,0beh,082h	; 9f6d
	defb 008h,0ebh,0e8h,00fh,0efh,0e8h	; 9f73
	defb 020h,0efh,020h,0afh,0afh,020h	; 9f79
	defb 081h,0bdh,081h,0bbh,0bbh,0b9h	; 9f7f
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f85
	defb 0ebh,0c1h,0ebh,0c1h,0ebh,0ffh	; 9f8b
	defb 00fh,0efh,00fh,07fh,00fh,00fh	; 9f91
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f97
	defb 0c3h,0dbh,0c1h,0ddh,0ddh,0c1h	; 9f9d
	defb 004h,075h,075h,005h,075h,074h	; 9fa3
	defb 016h,0f6h,0f0h,0f7h,0f7h,017h	; 9fa9
	defb 0ffh,0ffh,07fh,07fh,07fh,060h	; 9faf
	defb 0eeh,0eeh,0eeh,0eeh,0eeh,0e0h	; 9fb5
	defb 083h,0bbh,083h,0bfh,0bfh,0bfh	; 9fbb
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fc1
	defb 000h,03fh,020h,020h,020h,03fh	; 9fc7
	defb 000h,0f8h,000h,000h,000h,0f8h	; 9fcd
	defb 000h,0f7h,084h,0f4h,084h,0f4h	; 9fd3
	defb 000h,0dfh,051h,05fh,051h,051h	; 9fd9
	defb 000h,079h,049h,07dh,045h,07dh	; 9fdf
	defb 000h,00fh,008h,00fh,008h,0efh	; 9fe5
	defb 000h,01fh,000h,000h,000h,01fh	; 9feb
	defb 000h,0fch,004h,004h,004h,0fch	; 9ff1
	defb 07eh,040h,040h,040h,040h,07eh	; 9ff7
	defb 078h,048h,078h	; 9ffd

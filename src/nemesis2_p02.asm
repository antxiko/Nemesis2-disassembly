; ==========================================================================
; NEMESIS 2 - Konami (1987) - MSX - MegaROM RC-751 de 128 KB (Konami SCC) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l97b8h:	equ 0x097b8

; ----------------------------------------------------------------------
; DATOS partida_8000: el operando (0xE20F) de `ld a,(nn)`, la instruccion que
;   empieza en p01:7FFF; el codigo sigue en 0x8002; lo leen p01:7FFF (2 bytes)
;   0x8000..0x8002  (2 bytes)
DATA_partida_8000:
	defb 00fh,0e2h	; 8000

; ======================================================================
; CODIGO 0x8002..0x806d  (107 bytes)
; ======================================================================


L_8002:
	cp 004h		;8002   ; de 2 a 3 capturadas, nada
	ret c			;8004
	cp 006h		;8005   ; 4 o 5: p01:7FC2
	jr c,$-74		;8007
	jr $-15		;8009   ; 6 o 7: p01:7FFA
suelta_doble:		; segun las armas capturadas: con una, 0xE336; de 2 a 5, 0xE338 y 0xE336; con 6 o mas, 0xE339, 0xE337 y 0xE336 a cero
	ld a,(0e20fh)		;800b   ; lee las armas capturadas (0-7)
	cp 001h		;800e   ; con una, solo 0xE336
	jr z,L_801D		;8010
	cp 006h		;8012   ; de 2 a 5
	jr c,L_8022		;8014
	call 07fbdh		;8016   ; con 6 o 7
L_8019:
	xor a			;8019
	ld (0e337h),a		;801a   ; guarda la casilla 4 del medidor
L_801D:
	xor a			;801d
	ld (0e336h),a		;801e   ; guarda la casilla 3 del medidor
	ret			;8021
L_8022:
	xor a			;8022
	ld (0e338h),a		;8023   ; guarda la casilla 5 del medidor
	jr L_801D		;8026
suelta_laser:		; con 2 o mas armas capturadas, 0xE337, 0xE336 y 0xE335 a cero (y 0xE338 con 6 o mas)
	ld a,(0e20fh)		;8028   ; lee las armas capturadas (0-7)
	cp 002h		;802b   ; 0 o 1, nada
	ret c			;802d
	cp 006h		;802e   ; de 6 en adelante, tambien 0xE338
	jr c,L_8036		;8030
	xor a			;8032
	ld (0e338h),a		;8033   ; guarda la casilla 5 del medidor
L_8036:
	xor a			;8036
	ld (0e337h),a		;8037   ; guarda la casilla 4 del medidor
	ld (0e336h),a		;803a   ; guarda la casilla 3 del medidor
	ld (0e335h),a		;803d   ; guarda la casilla 2 del medidor
	ret			;8040
suelta_arma:		; con 6 o mas armas capturadas, 0xE337 y 0xE336 a cero; si no, solo 0xE336
	ld a,(0e20fh)		;8041   ; lee las armas capturadas (0-7)
	cp 006h		;8044
	jr c,L_801D		;8046
	jr L_8019		;8048
tope_de_casilla:		; C = el tope de la casilla 0xE33D con estas armas capturadas (p02:8074, 9 por cuenta)
	ld a,(0e20fh)		;804a   ; lee las armas capturadas (0-7)
	ld c,a			;804d   ; las armas capturadas x 9
	add a,a			;804e
	add a,a			;804f
	add a,a			;8050
	add a,c			;8051
	ld c,a			;8052
	ld a,(0e33dh)		;8053   ; mas la casilla
	add a,c			;8056
	ld c,a			;8057
	ld b,000h		;8058
	ld hl,08074h		;805a   ; en p02:8074
	add hl,bc			;805d
	ld c,(hl)			;805e
	ret			;805f
casillas_por_capturas:		; 0xE331 = las casillas del medidor con estas armas capturadas (p02:806D)
	ld hl,0806dh		;8060   ; las casillas segun las capturadas
	ld a,(0e20fh)		;8063   ; lee las armas capturadas (0-7)
	call 05ca6h		;8066   ; byte_a: A = el byte A de la tabla HL
	ld (0e331h),a		;8069   ; guarda cuantas casillas tiene el medidor
	ret			;806c

; ----------------------------------------------------------------------
; DATOS tabla_806D: 8 bytes, uno por cada cuenta de armas capturadas (0xE20F),
;   que p02:8060 pone en 0xE331; el octavo es el primero de 0x8074; lo leen
;   p02:8066 (7 bytes)
;   0x806d..0x8074  (7 bytes)
DATA_tabla_806D:
	defb 007h,008h,009h,009h,009h,009h,00ah	; 806d

; ----------------------------------------------------------------------
; DATOS tabla_8074: 8 filas de 9 bytes, una por cada cuenta de armas
;   capturadas: p02:804A lee 0x8074 + 9 x 0xE20F + 0xE33D; lo leen p02:805D
;   (72 bytes)
;   0x8074..0x80bc  (72 bytes)
DATA_tabla_8074:
	defb 00ah,007h,002h,001h,002h,002h,001h,000h,000h	; 8074  .........
	defb 000h,007h,002h,001h,002h,002h,002h,001h,000h	; 807d  .........
	defb 000h,007h,002h,001h,002h,002h,002h,001h,001h	; 8086  .........
	defb 000h,007h,003h,001h,002h,002h,002h,001h,001h	; 808f  .........
	defb 000h,007h,003h,002h,002h,002h,002h,001h,001h	; 8098  .........
	defb 000h,007h,003h,002h,002h,002h,003h,002h,001h	; 80a1  .........
	defb 000h,007h,003h,001h,002h,002h,002h,003h,002h	; 80aa  .........
	defb 001h,007h,003h,001h,003h,002h,002h,003h,002h	; 80b3  .........

; ----------------------------------------------------------------------
; DATOS tabla_8074_cola: el byte de detras de las 8 filas de 0x8074: la
;   casilla 9 de la fila 7, si 0xE33D llegara a 9; lo leen p02:805D (1 bytes)
;   0x80bc..0x80bd  (1 bytes)
DATA_tabla_8074_cola:
	defb 001h	; 80bc

; ======================================================================
; CODIGO 0x80bd..0x8148  (139 bytes)
; ======================================================================


captura_armas:		; captura A armas (0xE20F + A, como mucho 7), rehace el medidor y lo pinta
	call captura_a_armas		;80bd   ; captura_a_armas: A veces: una arma capturada mas (sin pasar de 7) y el medidor de nuevo (p02:80D8)
	call casillas_por_capturas		;80c0   ; casillas_por_capturas: 0xE331 = las casillas del medidor con estas armas capturadas (p02:806D)
	jp 05387h		;80c3   ; pinta_el_medidor: el recuadro del rotulo (caracteres 0x15-0x1C), las casillas del medidor y el rotulo
captura_a_armas:		; A veces: una arma capturada mas (sin pasar de 7) y el medidor de nuevo (p02:80D8)
	ld b,a			;80c6   ; B veces
L_80C7:
	ld hl,0e20fh		;80c7   ; apunta a las armas capturadas (0-7)
	ld a,(hl)			;80ca   ; una arma capturada mas
	inc a			;80cb
	cp 008h		;80cc   ; como mucho 7
	ret nc			;80ce
	ld (hl),a			;80cf
	push bc			;80d0
	call rehace_el_medidor		;80d1   ; y el medidor nuevo
	pop bc			;80d4
	djnz L_80C7		;80d5
	ret			;80d7
rehace_el_medidor:		; las casillas del medidor segun las armas capturadas (p02:8146: pares [de][a]); las que se estrenan, encendidas
	ld hl,0f010h		;80d8   ; 0xF010-0xF018 a cero
	ld de,0f011h		;80db
	ld bc,00008h		;80de
	ld (hl),000h		;80e1
	ldir		;80e3
	ld a,(0e20fh)		;80e5   ; los pares de esta cuenta
	ld hl,08146h		;80e8
	call 04b67h		;80eb   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;80ee
L_80EF:
	ld a,(hl)			;80ef   ; 0 acaba
	or a			;80f0
	jr z,L_8107		;80f1   ; 0 acaba
	inc hl			;80f3
	ld c,(hl)			;80f4   ; [de][a]
	inc hl			;80f5
	push hl			;80f6
	ld hl,0e333h		;80f7   ; la casilla de antes
	add a,l			;80fa   ; la casilla [de]
	ld l,a			;80fb
	ld de,0f00fh		;80fc   ; a la casilla nueva (0xF00F + a)
	ld a,c			;80ff
	add a,e			;8100
	ld e,a			;8101
	ldi		;8102   ; a la [a] de las nuevas
	pop hl			;8104
	jr L_80EF		;8105   ; el par siguiente
L_8107:
	ld hl,0f010h		;8107   ; el medidor nuevo
	ld de,0e334h		;810a   ; apunta a las 9 casillas del medidor
	ld bc,00009h		;810d
	ldir		;8110
	ld a,(0e20fh)		;8112   ; la que se estrena con 3, 4, 5 o 7 capturadas
	cp 003h		;8115   ; 3 capturadas
	jr z,L_813F		;8117
	cp 004h		;8119   ; 4
	jr z,L_8136		;811b
	cp 005h		;811d   ; 5
	jr z,L_812D		;811f
	cp 007h		;8121   ; 7
	ret nz			;8123
	ld hl,0e337h		;8124   ; con 7: la 4, si estaba gastada
	ld a,(hl)			;8127
	inc a			;8128   ; gastada (0xFF)?
	ret nz			;8129
	ld (hl),002h		;812a   ; vuelve a 2
	ret			;812c
L_812D:
	ld hl,0e339h		;812d   ; con 5: la 6
	ld a,(hl)			;8130
	inc a			;8131   ; gastada?
	ret nz			;8132
	ld (hl),002h		;8133   ; vuelve a 2
	ret			;8135
L_8136:
	ld hl,0e336h		;8136   ; con 4: la 3
	ld a,(hl)			;8139
	inc a			;813a   ; gastada?
	ret nz			;813b
	ld (hl),001h		;813c   ; vuelve a 1
	ret			;813e
L_813F:
	ld hl,0e335h		;813f   ; con 3: la 2
	ld a,(hl)			;8142
	inc a			;8143   ; gastada?
	ret nz			;8144
	ld (hl),002h		;8145   ; vuelve a 2
	ret			;8147

; ----------------------------------------------------------------------
; DATOS listas_por_capturas: 7 punteros (de 1 a 7 armas capturadas: p02:80E5
;   lee 0x8146 + 2 x 0xE20F con L_4B67, y la 0 caeria en el `ret` de delante)
;   a listas [casilla][valor]; lo leen p02:80EB (14 bytes)
;   0x8148..0x8156  (14 bytes)
DATA_listas_por_capturas:
	defw 08156h,08163h,08174h,08174h,08174h,08185h,08172h	; 8148

; ----------------------------------------------------------------------
; DATOS listas_8156: las listas de p02:80EF: pares [casilla de 0xE333][valor]
;   hasta un 0 (0x8156, 0x8163, 0x8172, 0x8174 y 0x8185, que comparten
;   finales); lo leen p02:80EF (64 bytes)
;   0x8156..0x8196  (64 bytes)
DATA_listas_8156:
	defb 006h,007h,005h,006h,004h,005h,003h,003h,002h,002h,001h,001h,000h,007h,008h,006h	; 8156  ................
	defb 007h,005h,006h,004h,004h,003h,003h,002h,002h,001h,001h,000h,009h,009h,008h,008h	; 8166  ................
	defb 007h,007h,006h,006h,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h,000h,008h	; 8176  ................
	defb 009h,007h,008h,006h,007h,005h,006h,004h,005h,003h,004h,002h,002h,001h,001h,000h	; 8186  ................

; ======================================================================
; CODIGO 0x8196..0x81ca  (52 bytes)
; ======================================================================


equipo_de_demo:		; la demo sale con 7 armas capturadas, 10 casillas, el medidor y las armas de p02:81CA
	ld a,007h		;8196   ; 7 armas capturadas
	ld (0e20fh),a		;8198   ; guarda las armas capturadas (0-7)
	ld a,00ah		;819b   ; 10 casillas
	ld (0e331h),a		;819d   ; guarda cuantas casillas tiene el medidor
	ld hl,081cah		;81a0   ; el medidor de la demo
	ld de,0e334h		;81a3   ; apunta a las 9 casillas del medidor
	ld bc,00009h		;81a6
	ldir		;81a9
	ld de,0e430h		;81ab   ; y sus armas
	ld bc,00007h		;81ae
	ldir		;81b1
	ld c,07fh		;81b3   ; escudo de 127 golpes
escudo_y_opciones:		; escudo de C golpes, velocidad 2 y dos opciones; y el medidor
	ld hl,0e400h		;81b5   ; apunta a la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ld (hl),002h		;81b8   ; con escudo
	inc l			;81ba
	ld (hl),c			;81bb   ; los golpes
	inc l			;81bc
	ld (hl),002h		;81bd   ; velocidad 2
	ld a,002h		;81bf   ; dos opciones
	ld (0e40bh),a		;81c1   ; guarda las opciones
	call 07e13h		;81c4   ; dos_opciones: 0xE40B = 2 opciones, con p03:AA43 para cada una
	jp 053a3h		;81c7   ; casillas_del_medidor: las 9 casillas del medidor (0xE334) en la fila 22 y el rotulo de la casilla 0xE330

; ----------------------------------------------------------------------
; DATOS inicio_E334: 9 bytes que p02:81A0 copia a 0xE334 y 7 a 0xE430; lo leen
;   p02:81A0 (16 bytes)
;   0x81ca..0x81da  (16 bytes)
DATA_inicio_E334:
	defb 002h,0ffh,000h,000h,0ffh,000h,002h,0ffh,0ffh,000h,000h,002h,003h,002h,000h,000h	; 81ca  ................

; ======================================================================
; CODIGO 0x81da..0x81fb  (33 bytes)
; ======================================================================


mueve_disparos:		; los 9 disparos de la nave (0xE470, 16 bytes; IY): lo de su tipo (p02:81FB)
	exx			;81da
	ld a,(0e305h)		;81db   ; C' = el primer caracter que no es mapa
	ld c,a			;81de
	exx			;81df
	ld iy,0e470h		;81e0   ; 9 disparos de 16 bytes
	ld b,009h		;81e4
L_81E6:
	push bc			;81e6
	call disparo_por_tipo		;81e7   ; disparo_por_tipo: la rutina del tipo IY+00 del disparo
	ld bc,00010h		;81ea   ; el siguiente
	add iy,bc		;81ed
	pop bc			;81ef
	djnz L_81E6		;81f0
L_81F2:
	ret			;81f2
disparo_por_tipo:		; la rutina del tipo IY+00 del disparo
	ld a,(iy+000h)		;81f3   ; libre
	dec a			;81f6
	ret m			;81f7
	call 04084h		;81f8   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_81FB: 15 destinos del despachador p00:4084 (call en p02:81F8, el
;   indice en A): 8219, 8227, 8219, 824A, 824A, 81F2, 827C, 827C, 8308, 82D8,
;   82D8, 82D8, 82D8, 8366, 827C; lo leen p02:81F8 (30 bytes)
;   0x81fb..0x8219  (30 bytes)
DATA_tabla_81FB:
	defw 08219h,08227h,08219h,0824ah,0824ah,081f2h,0827ch,0827ch	; 81fb
	defw 08308h,082d8h,082d8h,082d8h,082d8h,08366h,0827ch	; 820b

; ======================================================================
; CODIGO 0x8219..0x84ca  (689 bytes)
; ======================================================================


disparo_toca_mapa_2:		; el disparo mira el mapa en su sitio y 8 pixeles a la izquierda; al tocarlo se quita
	ld a,(iy+005h)		;8219   ; 8 pixeles a la izquierda
	sub 008h		;821c
	ld h,a			;821e
	call disparo_toca_mapa_en		;821f   ; disparo_toca_mapa_en: el disparo IY mira el mapa en H (X), IY+03 (Y)
	ld a,(iy+000h)		;8222   ; ya se quito?
	or a			;8225
	ret z			;8226
disparo_toca_mapa:		; el disparo IY mira el mapa en IY+05 (X), IY+03 (Y): al tocarlo se quita, y con objeto de caracteres lo golpea (p02:8481)
	ld h,(iy+005h)		;8227
disparo_toca_mapa_en:		; el disparo IY mira el mapa en H (X), IY+03 (Y)
	ld l,(iy+003h)		;822a   ; L = Y
	call toca_mapa_hl		;822d   ; toca_mapa_hl: C si en H (X), L (Y) o en el caracter de la derecha hay mapa
	ret nc			;8230   ; no toca
	ld (iy+000h),000h		;8231   ; se quita
	ld a,(0e340h)		;8235   ; sin jefe, golpea el objeto de caracteres
	or a			;8238
	jp z,rompe_mapa		;8239   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
ruido_de_choque:		; con jefe, el sonido 5 una vez por cuadro (0xE309)
	ld a,(0e309h)		;823c   ; una vez por cuadro
	or a			;823f
	ret nz			;8240
	inc a			;8241
	ld (0e309h),a		;8242   ; guarda la marca del ruido de choque en este cuadro
	ld a,005h		;8245   ; suena 5
	jp 04ae4h		;8247   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparo_toca_mapa_b:		; como p02:8227, y sin jefe en la fase 5 suena 0x12; si no toca, mira 8 pixeles mas abajo
	ld h,(iy+005h)		;824a
	ld l,(iy+003h)		;824d
	call toca_mapa_hl		;8250   ; toca_mapa_hl: C si en H (X), L (Y) o en el caracter de la derecha hay mapa
	jr nc,L_826B		;8253   ; no toca
	ld (iy+000h),000h		;8255   ; se quita
	ld a,(0e340h)		;8259   ; lee el tipo de jefe (1-5; 0 sin jefe)
	or a			;825c
	jp nz,ruido_de_choque		;825d   ; ruido_de_choque: con jefe, el sonido 5 una vez por cuadro (0xE309)
	ld a,(0e201h)		;8260   ; en la fase 5, suena 0x12
	cp 005h		;8263
	ret nz			;8265
	ld a,012h		;8266
	jp 04ae4h		;8268   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_826B:
	ld a,(0e340h)		;826b   ; con jefe, nada mas
	or a			;826e
	ret nz			;826f
	ld h,(iy+005h)		;8270
	ld a,(iy+003h)		;8273   ; 8 pixeles mas abajo
	add a,008h		;8276
	ld l,a			;8278
	jp toca_mapa_hl		;8279   ; toca_mapa_hl: C si en H (X), L (Y) o en el caracter de la derecha hay mapa
laser_toca_mapa:		; el laser (IY+0A caracteres de largo) contra el mapa: se recorta hasta el choque y golpea el objeto
	ld h,(iy+005h)		;827c
	ld l,(iy+003h)		;827f
	call 05c92h		;8282   ; el sitio en la pantalla de RAM
	ex de,hl			;8285
	ld a,(iy+00ah)		;8286   ; IY+0A: el largo
	or a			;8289
	ret z			;828a
	ld b,a			;828b
L_828C:
	call es_mapa		;828c   ; mapa?
	jr nc,L_829C		;828f
	ld a,(0e340h)		;8291   ; con jefe, se corta
	or a			;8294
	jr nz,L_82A0		;8295
	call rompe_mapa		;8297   ; si no, golpea el objeto
	jr nc,L_82A0		;829a
L_829C:
	inc de			;829c   ; el caracter siguiente
	djnz L_828C		;829d
	ret			;829f
L_82A0:
	ld a,(iy+00ah)		;82a0   ; el largo hasta el choque
	inc b			;82a3
	sub b			;82a4
	jp c,0ae02h		;82a5   ; nada: se quita (p03:AE02)
	jp z,0ae02h		;82a8
	ld (iy+00ah),a		;82ab   ; recortado
	ld a,(iy+000h)		;82ae   ; IY+01 = 1 el tipo 15, 2 los demas
	cp 00fh		;82b1
	ld a,001h		;82b3
	jr z,L_82B8		;82b5
	inc a			;82b7
L_82B8:
	ld (iy+001h),a		;82b8
	ret			;82bb
es_mapa:		; C si el caracter de DE es mapa: en las fases 0, 7 y 8 de 9 a 0xE305; en las demas, de 1 a 0xE305
	ld a,(0e201h)		;82bc   ; fases 0, 7 y 8: de 9 en adelante
	or a			;82bf
	jr z,L_82CF		;82c0   ; fase 0
	sub 007h		;82c2   ; fases 7 y 8
	cp 002h		;82c4
	jr c,L_82CF		;82c6
	ld a,(de)			;82c8   ; las demas: cualquiera que no sea 0
	and a			;82c9
	ret z			;82ca   ; vacio: no
	exx			;82cb   ; por debajo de 0xE305
	cp c			;82cc
	exx			;82cd
	ret			;82ce
L_82CF:
	ld a,(de)			;82cf   ; de 9
	cp 009h		;82d0
	ccf			;82d2   ; por debajo de 9: no
	ret nc			;82d3
	exx			;82d4   ; a 0xE305
	cp c			;82d5
	exx			;82d6
	ret			;82d7
disparo_largo_toca_mapa:		; los IY+0A caracteres del disparo contra el mapa: al chocar, p03:AE02
	ld h,(iy+005h)		;82d8   ; H = X
	ld l,(iy+003h)		;82db   ; L = Y
	call 05c92h		;82de   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;82e1
	ld a,(iy+00ah)		;82e2   ; IY+0A: el largo
	or a			;82e5
	ret z			;82e6
	ld b,a			;82e7
L_82E8:
	call es_mapa		;82e8   ; mapa?
	jr nc,L_82FA		;82eb
	ld a,(0e340h)		;82ed   ; con jefe, se quita
	or a			;82f0
	jp nz,0ae02h		;82f1
	call rompe_mapa		;82f4   ; si no, golpea el objeto
	jp nc,0ae02h		;82f7
L_82FA:
	inc de			;82fa   ; el caracter siguiente
	djnz L_82E8		;82fb
	ret			;82fd
largo_en_pixeles:		; IY+0C = IY+0A x 8
	ld a,(iy+00ah)		;82fe   ; el largo
	add a,a			;8301   ; x 8
	add a,a			;8302
	add a,a			;8303
	ld (iy+00ch),a		;8304   ; IY+0C: en pixeles
	ret			;8307
disparo_vertical_toca_mapa:		; el disparo de IY+0A caracteres de alto contra el mapa, en su columna y (con scroll) en la de la izquierda; IY+0D = alto x 8
	ld h,(iy+005h)		;8308
	ld l,(iy+003h)		;830b
	call 05c92h		;830e   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0f000h),hl		;8311   ; 0xF000 = el sitio
	ex de,hl			;8314
	ld a,(iy+00ah)		;8315   ; IY+0A: el alto
	or a			;8318
	jr z,L_835C		;8319
	ld b,a			;831b
L_831C:
	call es_mapa		;831c   ; mapa?
	jr nc,L_832E		;831f
	ld a,(0e340h)		;8321   ; lee el tipo de jefe (1-5; 0 sin jefe)
	or a			;8324
	jp nz,0ae02h		;8325
	call rompe_mapa		;8328   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
	jp nc,0ae02h		;832b
L_832E:
	ld a,020h		;832e   ; la fila de abajo
	call 0407fh		;8330   ; de_mas_a: DE = DE + A
	djnz L_831C		;8333
	ld a,(0e320h)		;8335   ; con scroll, tambien la columna de la izquierda
	or a			;8338
	jr z,L_835C		;8339
	ld de,(0f000h)		;833b   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	dec de			;833f
	ld b,(iy+00ah)		;8340
L_8343:
	call es_mapa		;8343   ; es_mapa: C si el caracter de DE es mapa: en las fases 0, 7 y 8 de 9 a 0xE305; en las demas, de 1 a 0xE305
	jr nc,L_8355		;8346
	ld a,(0e340h)		;8348   ; lee el tipo de jefe (1-5; 0 sin jefe)
	or a			;834b
	jp nz,0ae02h		;834c
	call rompe_mapa		;834f   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
	jp nc,0ae02h		;8352
L_8355:
	ld a,020h		;8355
	call 0407fh		;8357   ; de_mas_a: DE = DE + A
	djnz L_8343		;835a
L_835C:
	ld a,(iy+00ah)		;835c   ; IY+0D = el alto x 8
	add a,a			;835f   ; x 8
	add a,a			;8360
	add a,a			;8361
	ld (iy+00dh),a		;8362
	ret			;8365
disparo_2x_toca_mapa:		; dos caracteres seguidos del disparo contra el mapa
	ld h,(iy+005h)		;8366
	ld l,(iy+003h)		;8369
	call 05c92h		;836c   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;836f
	ld b,002h		;8370   ; dos caracteres
L_8372:
	call es_mapa		;8372   ; es_mapa: C si el caracter de DE es mapa: en las fases 0, 7 y 8 de 9 a 0xE305; en las demas, de 1 a 0xE305
	jr nc,L_8384		;8375
	ld a,(0e340h)		;8377   ; lee el tipo de jefe (1-5; 0 sin jefe)
	or a			;837a
	jp nz,0ae02h		;837b
	call rompe_mapa		;837e   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
	jp nc,0ae02h		;8381
L_8384:
	inc de			;8384
	djnz L_8372		;8385
	ret			;8387
toca_mapa_hl:		; C si en H (X), L (Y) o en el caracter de la derecha hay mapa
	call 05c92h		;8388   ; el sitio en la pantalla de RAM
	ex de,hl			;838b
	call es_mapa_de		;838c   ; mapa?
	ret c			;838f
	inc de			;8390   ; y el de la derecha, si no es fin de fila
	ld a,e			;8391
	and 01fh		;8392
	ret z			;8394
es_mapa_de:		; C si el caracter de DE es mapa (como p02:82BC)
	ld a,(0e201h)		;8395   ; lee la fase (0-11)
	or a			;8398
	jr z,L_83A8		;8399   ; fase 0
	sub 007h		;839b   ; fases 7 y 8
	cp 002h		;839d
	jr c,L_83A8		;839f
	ld a,(de)			;83a1   ; las demas
	and a			;83a2
	ret z			;83a3   ; vacio: no
	exx			;83a4
	cp c			;83a5   ; por debajo de 0xE305
	exx			;83a6
	ret			;83a7
L_83A8:
	ld a,(de)			;83a8   ; fases 0, 7 y 8
	cp 009h		;83a9   ; por debajo de 9: no
	ccf			;83ab
	ret nc			;83ac
	exx			;83ad   ; por debajo de 0xE305
	cp c			;83ae
	exx			;83af
	ret			;83b0
mapa_encima:		; C si hay mapa en los 6 caracteres de la fila de encima del enemigo IX
	ld a,(ix+004h)		;83b1   ; la fila de encima
	sub 008h		;83b4
	ld l,a			;83b6
L_83B7:
	ld h,(ix+006h)		;83b7
	call 05c92h		;83ba   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld a,(0e305h)		;83bd   ; el primer caracter que no es mapa
	ld c,a			;83c0
	ld b,006h		;83c1   ; 6 caracteres
L_83C3:
	ld a,(hl)			;83c3   ; un caracter
	inc l			;83c4
	and a			;83c5   ; vacio: nada
	ret z			;83c6
	cp c			;83c7   ; mapa: C
	ret c			;83c8
	djnz L_83C3		;83c9   ; los 6
	xor a			;83cb   ; ninguno
	ret			;83cc
mapa_debajo:		; C si hay mapa en los 6 caracteres de 48 pixeles por debajo del enemigo IX (o se sale por abajo)
	ld a,(ix+004h)		;83cd   ; 48 pixeles mas abajo
	add a,030h		;83d0
	cp 0a0h		;83d2   ; fuera por abajo: C
	ccf			;83d4
	ret c			;83d5
	ld l,a			;83d6
	jr L_83B7		;83d7
toca_mapa_fase_1:		; C si en H (X), L (Y) o a su derecha hay mapa de 9 a 0x8A (0x67 fuera de la fase 1)
	call 05c92h		;83d9   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld c,08ah		;83dc   ; en la fase 1, hasta 0x8A
	ld a,(0e201h)		;83de   ; lee la fase (0-11)
	dec a			;83e1
	jr z,L_83F2		;83e2
	ld c,067h		;83e4   ; en las demas, hasta 0x67
	jr L_83F2		;83e6
toca_mapa_e305:		; C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305); el sitio en 0xE3BC
	call 05c92h		;83e8   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0e3bch),hl		;83eb   ; el sitio
toca_mapa_e305_de:		; lo mismo desde el sitio HL
	ld a,(0e305h)		;83ee   ; lee dato de la fase de p01:697A
	ld c,a			;83f1
L_83F2:
	call es_mapa_hl		;83f2   ; mapa?
	ret c			;83f5
	inc hl			;83f6   ; y el de la derecha, si no es fin de fila
	ld a,l			;83f7
	and 01fh		;83f8
	ret z			;83fa
es_mapa_hl:		; C si el caracter de HL es mapa (como p02:82BC)
	ld a,(0e201h)		;83fb   ; fases 0, 7 y 8: de 9 en adelante
	or a			;83fe
	jr z,L_840C		;83ff   ; fase 0
	sub 007h		;8401   ; fases 7 y 8
	cp 002h		;8403
	jr c,L_840C		;8405
	ld a,(hl)			;8407   ; las demas: cualquiera que no sea 0
	and a			;8408
	ret z			;8409   ; vacio: no
	cp c			;840a   ; por debajo de 0xE305
	ret			;840b
L_840C:
	ld a,(hl)			;840c   ; fases 0, 7 y 8
	cp 009h		;840d   ; por debajo de 9: no
	ccf			;840f
	ret nc			;8410
	cp c			;8411   ; por debajo de 0xE305
	ret			;8412
nave_contra_el_mapa:		; si la nave toca el mapa cae (p02:8E7C); el R.DRILL rompe lo que se puede romper (p02:8481) y solo cae con lo demas
	ld a,(0e400h)		;8413   ; sin nave, nada
	dec a			;8416
	ret m			;8417
	ld a,(0e3d0h)		;8418   ; ni con 0xE3D0
	or a			;841b
	ret nz			;841c
	exx			;841d
	ld a,(0e305h)		;841e   ; C' = el primer caracter que no es mapa
	ld c,a			;8421
	exx			;8422
	call nave_toca_mapa		;8423   ; toca?
	ret nc			;8426
	ld a,(0e400h)		;8427   ; sin R.DRILL, cae
	cp 003h		;842a
	jp nz,nave_cae		;842c   ; nave_cae: la nave cae: con Maze of Galious al lado (0xF0F5 bit 3) se guarda el equipo en 0xE210 para la vida siguiente; suena 0x3D y la explosion (p03:A993)
	call rompe_mapa		;842f   ; el R.DRILL lo rompe, o cae
	jp nc,nave_cae		;8432   ; nave_cae: la nave cae: con Maze of Galious al lado (0xF0F5 bit 3) se guarda el equipo en 0xE210 para la vida siguiente; suena 0x3D y la explosion (p03:A993)
	ld a,(0e404h)		;8435   ; y tambien los dos caracteres siguientes
	add a,008h		;8438
	ld l,a			;843a
	ld a,(0e406h)		;843b
	ld h,a			;843e
	call 05c92h		;843f   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;8442
	call rompe_mapa		;8443   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
	inc de			;8446
	jp rompe_mapa		;8447   ; rompe_mapa: C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
nave_toca_mapa:		; C si en el sitio de la nave (Y + 8) o en el caracter de la derecha (con X & 7 >= 4) hay mapa
	ld a,(0e404h)		;844a   ; la Y de la nave + 8
	add a,008h		;844d
	ld l,a			;844f
	ld a,(0e406h)		;8450
	ld h,a			;8453   ; su X
	and 007h		;8454   ; en la mitad derecha del caracter, solo el siguiente
	cp 004h		;8456
	push af			;8458
	call 05c92h		;8459   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ex de,hl			;845c
	pop af			;845d
	jr nc,L_8464		;845e
	call es_mapa_de_b		;8460   ; el caracter de la nave
	ret c			;8463
L_8464:
	inc de			;8464   ; el de la derecha
es_mapa_de_b:		; C si el caracter de DE es mapa (como p02:82BC)
	ld a,(0e201h)		;8465   ; lee la fase (0-11)
	or a			;8468
	jr z,L_8478		;8469   ; fase 0
	sub 007h		;846b   ; fases 7 y 8
	cp 002h		;846d
	jr c,L_8478		;846f
	ld a,(de)			;8471   ; las demas
	or a			;8472
	ret z			;8473   ; vacio: no
	exx			;8474
	cp c			;8475   ; por debajo de 0xE305
	exx			;8476
	ret			;8477
L_8478:
	ld a,(de)			;8478   ; fases 0, 7 y 8
	cp 009h		;8479   ; por debajo de 9: no
	ccf			;847b
	ret nc			;847c
	exx			;847d   ; por debajo de 0xE305
	cp c			;847e
	exx			;847f
	ret			;8480
rompe_mapa:		; C si el caracter de DE se puede romper y lo rompe: fase 2 los 0xAF-0xB2, fase 6 los 0x67-0x6A, fase 7 los 0x1F-0x7A (por p02:84CA), fases 9-11 el 0xA0
	ld hl,0af04h		;8481   ; fase 2: 0xAF-0xB2
	ld a,(0e201h)		;8484   ; lee la fase (0-11)
	sub 002h		;8487
	jr z,L_849F		;8489
	ld h,067h		;848b   ; fase 6: 0x67-0x6A
	sub 004h		;848d
	jr z,L_849F		;848f
	dec a			;8491   ; fase 7: tabla
	jr z,L_84AA		;8492
	ld hl,0a001h		;8494   ; fases 9-11: 0xA0
	sub 002h		;8497
	cp 003h		;8499
	jr c,L_849F		;849b
	xor a			;849d   ; las demas: nada se rompe
	ret			;849e
L_849F:
	ld a,(de)			;849f   ; en su tramo?
	sub h			;84a0
	cp l			;84a1
	ret nc			;84a2
	xor a			;84a3   ; roto: vacio
	ld (de),a			;84a4
	call ruido_de_rotura		;84a5   ; ruido_de_rotura: el sonido 4 una vez por cuadro (0xE308)
	scf			;84a8
	ret			;84a9
L_84AA:
	ld a,(de)			;84aa   ; de 0x1F a 0x7A
	sub 01fh		;84ab
	cp 05ch		;84ad
	ret nc			;84af
	ld hl,084cah		;84b0   ; se cambia por el de p02:84CA
	call 05ca6h		;84b3   ; byte_a: A = el byte A de la tabla HL
	ld (de),a			;84b6
	call ruido_de_rotura		;84b7   ; ruido_de_rotura: el sonido 4 una vez por cuadro (0xE308)
	scf			;84ba
	ret			;84bb
ruido_de_rotura:		; el sonido 4 una vez por cuadro (0xE308)
	ld a,(0e308h)		;84bc   ; una vez por cuadro
	or a			;84bf
	ret nz			;84c0
	inc a			;84c1
	ld (0e308h),a		;84c2   ; guarda la marca del ruido de rotura en este cuadro
	ld a,004h		;84c5   ; suena 4
	jp 04ae4h		;84c7   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros

; ----------------------------------------------------------------------
; DATOS tabla_84CA: 92 bytes que p02:84AA lee con (DE) - 0x1F < 0x5C (L_5CA6);
;   lo leen p02:84B3 (92 bytes)
;   0x84ca..0x8526  (92 bytes)
DATA_tabla_84CA:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0a2h,0a2h,0a3h,0a3h,0a3h,0a4h	; 84ca  ................
	defb 0a5h,0a5h,0a5h,0a6h,0a6h,0a7h,0a7h,0a8h,0a9h,0aah,0aah,0abh,0abh,0abh,0abh,0ach	; 84da  ................
	defb 0ach,0ach,0adh,0adh,0aeh,0aeh,0afh,0b0h,0b0h,0b0h,0b1h,0b1h,0b1h,0b1h,0b2h,0b2h	; 84ea  ................
	defb 0b2h,0b2h,0b3h,0b3h,0b3h,0b3h,0b4h,0b5h,0b6h,0b6h,0b7h,0b7h,0b8h,0b8h,0b8h,0b8h	; 84fa  ................
	defb 0b9h,0bah,0bah,0bbh,0bbh,0bbh,0bbh,0bch,0bch,0bdh,0bdh,0beh,0beh,0bfh,0bfh,0bfh	; 850a  ................
	defb 0c0h,0c1h,0c1h,0c2h,0c2h,0c2h,0c4h,0c4h,0c5h,0c6h,0a1h,0c3h	; 851a  ............

; ======================================================================
; CODIGO 0x8526..0x8762  (572 bytes)
; ======================================================================


capsula_con_el_scroll:		; la capsula especial del mapa se corre 8 pixeles con el scroll; al salir, desaparece
	ld a,(0ea60h)		;8526   ; sin capsula, nada
	or a			;8529
	ret z			;852a
	ld a,(0e320h)		;852b   ; solo con scroll
	or a			;852e
	ret z			;852f
	ld a,(0ea62h)		;8530   ; 8 pixeles a la izquierda
	sub 008h		;8533
	ld (0ea62h),a		;8535   ; guarda la X de la capsula especial
	ret nc			;8538
	xor a			;8539   ; ha salido
	ld (0ea60h),a		;853a   ; guarda la capsula especial del mapa: [clase][Y][X]
	ret			;853d
pinta_capsula:		; la capsula especial: 2x2 caracteres desde el 0xE9 en la pantalla de RAM (sitio en 0xEA63)
	ld a,(0ea60h)		;853e   ; lee la capsula especial del mapa: [clase][Y][X]
	or a			;8541
	ret z			;8542
	ld hl,(0ea61h)		;8543   ; L = Y, H = X
	ld a,h			;8546
	cp 0f8h		;8547   ; en el borde derecho no se pinta
	ret nc			;8549
	call 05c92h		;854a   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (0ea63h),hl		;854d   ; el sitio
	ld c,0e9h		;8550   ; desde el caracter 0xE9
	jp 05227h		;8552   ; bloque_2x2: 2x2 caracteres desde C en HL; en las fases 3, 9, 10 y 11 sin tapar los del mapa (0x1F-0x66)
borra_capsula:		; borra los 2x2 caracteres de la capsula especial
	ld a,(0ea60h)		;8555   ; lee la capsula especial del mapa: [clase][Y][X]
	or a			;8558
	ret z			;8559   ; sin capsula, nada
	ld hl,(0ea61h)		;855a   ; lee la Y de la capsula especial y el byte siguiente (16 bits)
	ld a,h			;855d   ; en el borde derecho no se pinto
	cp 0f8h		;855e
	ret nc			;8560
	ld hl,(0ea63h)		;8561   ; el sitio
	xor a			;8564   ; 2x2 ceros
	ld (hl),a			;8565   ; la fila de arriba
	inc l			;8566
	ld (hl),a			;8567
	ld bc,0001fh		;8568   ; la de abajo
	add hl,bc			;856b
	ld (hl),a			;856c
	inc l			;856d
	ld (hl),a			;856e
	ret			;856f
aparece_el_nucleo:		; en el interior, en la columna 0x7F: el nucleo (0xEA90) en Y 0x40, X 0xE0, con 24 golpes
	ld a,(0e201h)		;8570   ; solo en el interior
	cp 008h		;8573
	ret nz			;8575   ; solo en el interior
	ld a,(0e320h)		;8576   ; lee la marca de scroll hecho en este cuadro
	or a			;8579
	ret z			;857a   ; y con scroll
	ld hl,(0e203h)		;857b   ; en la columna 0x7F
	ld de,0007fh		;857e   ; la columna 0x7F
	rst 20h			;8581
	ret nz			;8582
	ld hl,0ea90h		;8583   ; [1][Y 0x40][X 0xE0][24 golpes]
	ld (hl),001h		;8586   ; entero
	inc l			;8588
	ld (hl),040h		;8589   ; Y 0x40
	inc l			;858b
	ld (hl),0e0h		;858c   ; X 0xE0
	inc l			;858e
	ld (hl),018h		;858f   ; 24 golpes
	ret			;8591
nucleo_con_el_scroll:		; el nucleo del interior se corre 8 pixeles con el scroll; al salir, desaparece
	ld hl,0ea90h		;8592   ; sin nucleo, nada
	ld a,(hl)			;8595
	or a			;8596
	ret z			;8597
	ld a,(0e320h)		;8598   ; lee la marca de scroll hecho en este cuadro
	or a			;859b
	ret z			;859c
	inc l			;859d   ; la X
	inc l			;859e
	ld a,(hl)			;859f
	sub 008h		;85a0
	ld (hl),a			;85a2
	ret nc			;85a3
	xor a			;85a4   ; ha salido
	ld (0ea90h),a		;85a5   ; guarda el nucleo del interior (0 no, 1 entero, 2 roto)
	ret			;85a8
disparos_al_nucleo:		; cada disparo de la nave contra el nucleo del interior (p02:85C6)
	ld a,(0ea90h)		;85a9   ; solo con el nucleo entero
	dec a			;85ac
	ret nz			;85ad
	ld iy,0e470h		;85ae   ; 9 disparos
	ld b,009h		;85b2
L_85B4:
	push bc			;85b4   ; el disparo
	ld a,(iy+000h)		;85b5
	or a			;85b8
	call nz,disparo_al_nucleo		;85b9   ; disparo_al_nucleo: C si el disparo IY cae en el nucleo (32 pixeles por un lado, su largo por el otro) y lo golpea
	pop bc			;85bc
	ret c			;85bd   ; C: ya ha golpeado uno
	ld de,00010h		;85be   ; el siguiente
	add iy,de		;85c1
	djnz L_85B4		;85c3
	ret			;85c5
disparo_al_nucleo:		; C si el disparo IY cae en el nucleo (32 pixeles por un lado, su largo por el otro) y lo golpea
	cp 006h		;85c6   ; el tipo 6 no
	ret z			;85c8
	ld hl,0ea91h		;85c9   ; la Y del nucleo menos la del disparo
	ld a,(hl)			;85cc
	sub (iy+003h)		;85cd
	jp nc,L_85DB		;85d0
	neg		;85d3   ; por encima: 32 pixeles
	cp 020h		;85d5
	jp c,L_85DF		;85d7
	ret			;85da
L_85DB:
	cp (iy+00dh)		;85db   ; por debajo: el alto del disparo
	ret nc			;85de
L_85DF:
	inc l			;85df   ; la X del nucleo menos la del disparo
	ld a,(hl)			;85e0
	sub (iy+005h)		;85e1
	jp nc,L_85EF		;85e4
	neg		;85e7   ; por la izquierda: 32 pixeles
	cp 020h		;85e9
	jp c,L_85F3		;85eb
	ret			;85ee
L_85EF:
	cp (iy+00ch)		;85ef   ; por la derecha: el largo del disparo
	ret nc			;85f2
L_85F3:
	call golpe_al_nucleo		;85f3   ; golpe_al_nucleo: el disparo se va; el nucleo pierde un golpe y suelta un 0x33 (suena 5); sin golpes, se rompe: explosion, suena 9 y 0x0050 puntos
	scf			;85f6
	ret			;85f7
golpe_al_nucleo:		; el disparo se va; el nucleo pierde un golpe y suelta un 0x33 (suena 5); sin golpes, se rompe: explosion, suena 9 y 0x0050 puntos
	ld a,(iy+000h)		;85f8   ; el tipo 5 (p02:8A0C)
	cp 005h		;85fb
	jr nz,L_8605		;85fd
	call disparo_estalla		;85ff   ; disparo_estalla: el disparo 5 se convierte en una explosion de 24 x 24 (tipo 6, dibujo 0x44, color 15); en la fase 5 solo se va
	jp L_8609		;8602
L_8605:
	ld (iy+000h),000h		;8605   ; los demas se van
L_8609:
	ld hl,0ea93h		;8609   ; un golpe menos
	dec (hl)			;860c
	jp m,L_8626		;860d
	ld e,(iy+003h)		;8610   ; la Y del disparo
	ld a,r		;8613   ; la X del nucleo + un azar de 0 a 15
	and 00fh		;8615
	dec l			;8617
	add a,(hl)			;8618
	ld d,a			;8619
	ld a,033h		;861a   ; un 0x33
	ld c,000h		;861c
	call 04d1eh		;861e   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
	ld a,005h		;8621   ; suena 5
	jp 04ae4h		;8623   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_8626:
	ld a,002h		;8626   ; roto
	ld (0ea90h),a		;8628   ; guarda el nucleo del interior (0 no, 1 entero, 2 roto)
	ld hl,(0ea91h)		;862b   ; lee la Y del nucleo y el byte siguiente (16 bits)
	call 05c92h		;862e   ; sus 4x4 caracteres a cero
	xor a			;8631
	ld de,0001ch		;8632
	ld c,004h		;8635
L_8637:
	ld b,004h		;8637
L_8639:
	ld (hl),a			;8639
	inc l			;863a
	djnz L_8639		;863b
	add hl,de			;863d
	dec c			;863e
	jr nz,L_8637		;863f
	ld de,(0ea91h)		;8641   ; la explosion
	call crea_explosion		;8645   ; crea_explosion: una explosion de 4x4 caracteres en D (X), E (Y), si esta en pantalla y hay hueco en 0xEA40
	ld a,009h		;8648   ; suena 9
	call 04ae4h		;864a   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld de,00050h		;864d   ; 0x0050 puntos (BCD)
	jp 05b04h		;8650   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
nave_pasa_el_nucleo:		; al pasar la nave la X del nucleo, empieza el final del interior (0xE3C0 = 1), sin enemigos y suena 0xF1
	ld a,(0ea90h)		;8653   ; sin nucleo, nada
	or a			;8656
	ret z			;8657
	ld a,(0e400h)		;8658   ; ni sin nave
	dec a			;865b
	ret m			;865c
	ld a,(0e3c0h)		;865d   ; ni ya en el final
	or a			;8660
	ret nz			;8661
	ld a,(0ea92h)		;8662   ; la nave ha pasado la X del nucleo?
	ld b,a			;8665
	ld a,(0e406h)		;8666
	cp b			;8669
	ret c			;866a
	ld a,001h		;866b   ; el final del interior
	ld (0e3c0h),a		;866d   ; guarda el paso del final del interior (0 nada)
	call 07918h		;8670   ; fuera los enemigos
	ld a,0f1h		;8673   ; suena 0xF1
	jp 04ae4h		;8675   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
mueve_explosiones:		; las 4 explosiones de 4x4 caracteres de 0xEA40 (8 bytes): cada 4 cuadros un paso, y el scroll
	ld ix,0ea40h		;8678   ; 4 explosiones de 8 bytes
	ld de,00008h		;867c
	ld b,004h		;867f
L_8681:
	ld a,(ix+000h)		;8681   ; libre
	and a			;8684
	call nz,mueve_explosion		;8685   ; mueve_explosion: el paso de la explosion IX y 8 pixeles a la izquierda con el scroll; al salir, libre
	add ix,de		;8688   ; la siguiente
	djnz L_8681		;868a
	ret			;868c
mueve_explosion:		; el paso de la explosion IX y 8 pixeles a la izquierda con el scroll; al salir, libre
	call paso_de_explosion		;868d   ; paso_de_explosion: cada 4 cuadros IX+06 - 1; al acabar, libre
	ld a,(0e320h)		;8690   ; solo con scroll
	and a			;8693
	ret z			;8694
	ld a,(ix+003h)		;8695   ; 8 pixeles a la izquierda
	sub 008h		;8698
	jr c,L_86AC		;869a
	ld (ix+003h),a		;869c
	ret			;869f
paso_de_explosion:		; cada 4 cuadros IX+06 - 1; al acabar, libre
	dec (ix+001h)		;86a0   ; cada 4 cuadros
	ret nz			;86a3
	ld (ix+001h),004h		;86a4
	dec (ix+006h)		;86a8   ; un paso menos
	ret p			;86ab
L_86AC:
	ld (ix+000h),000h		;86ac   ; se acabo
	ret			;86b0
guarda_fondo_explosiones:		; el fondo de 4x4 caracteres bajo cada explosion a 0xECC0 (16 bytes cada una) y su sitio
	ld ix,0ea40h		;86b1   ; apunta a las 4 explosiones de 4x4 caracteres (8 bytes)
	ld iy,0ecc0h		;86b5   ; su fondo en 0xECC0
	ld b,004h		;86b9
L_86BB:
	push bc			;86bb   ; la explosion
	call guarda_fondo		;86bc   ; guarda_fondo: los 4x4 caracteres de la pantalla de RAM bajo la explosion IX a IY
	ld bc,00008h		;86bf
	add ix,bc		;86c2
	ld c,010h		;86c4   ; 16 bytes por explosion
	add iy,bc		;86c6   ; 16 bytes de fondo
	pop bc			;86c8
	djnz L_86BB		;86c9
	ret			;86cb
guarda_fondo:		; los 4x4 caracteres de la pantalla de RAM bajo la explosion IX a IY
	ld a,(ix+000h)		;86cc
	or a			;86cf
	ret z			;86d0
	ld l,(ix+002h)		;86d1   ; L = Y, H = X
	ld h,(ix+003h)		;86d4
	call 05c92h		;86d7   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld (ix+004h),l		;86da   ; el sitio en IX+04/IX+05
	ld (ix+005h),h		;86dd
	push iy		;86e0
	pop de			;86e2
	ld a,004h		;86e3   ; 4 filas de 4
L_86E5:
	ld bc,00004h		;86e5   ; 4 caracteres
	ldir		;86e8
	ld c,01ch		;86ea   ; la fila siguiente (28 + 4 = 32)
	add hl,bc			;86ec
	dec a			;86ed   ; 4 filas
	jr nz,L_86E5		;86ee
	ret			;86f0
repone_fondo_explosiones:		; devuelve el fondo de 0xECC0 bajo cada explosion
	ld ix,0ea40h		;86f1   ; apunta a las 4 explosiones de 4x4 caracteres (8 bytes)
	ld iy,0ecc0h		;86f5   ; apunta a el fondo bajo las explosiones (4 x 16 bytes)
	ld b,004h		;86f9
L_86FB:
	push bc			;86fb
	call repone_fondo		;86fc   ; repone_fondo: los 4x4 caracteres de IY a la pantalla de RAM bajo la explosion IX
	ld bc,00008h		;86ff   ; la siguiente
	add ix,bc		;8702
	ld c,010h		;8704
	add iy,bc		;8706
	pop bc			;8708
	djnz L_86FB		;8709
	ret			;870b
repone_fondo:		; los 4x4 caracteres de IY a la pantalla de RAM bajo la explosion IX
	ld a,(ix+000h)		;870c
	or a			;870f
	ret z			;8710
	ld e,(ix+004h)		;8711   ; el sitio
	ld d,(ix+005h)		;8714
	push iy		;8717
	pop hl			;8719
	ld a,004h		;871a   ; 4 filas de 4
L_871C:
	ld bc,00004h		;871c   ; 4 caracteres
	ldir		;871f
	ld c,01ch		;8721   ; la fila siguiente
	ex de,hl			;8723
	add hl,bc			;8724
	ex de,hl			;8725
	dec a			;8726   ; 4 filas
	jr nz,L_871C		;8727
	ret			;8729
pinta_explosiones:		; cada explosion: los 4x4 caracteres de su paso (p02:8762) en la pantalla de RAM
	ld ix,0ea40h		;872a   ; apunta a las 4 explosiones de 4x4 caracteres (8 bytes)
	ld b,004h		;872e
L_8730:
	push bc			;8730
	call pinta_explosion		;8731   ; pinta_explosion: los 4x4 caracteres del paso IX+06 en su sitio
	ld bc,00008h		;8734   ; la siguiente
	add ix,bc		;8737
	pop bc			;8739
	djnz L_8730		;873a
	ret			;873c
pinta_explosion:		; los 4x4 caracteres del paso IX+06 en su sitio
	ld a,(ix+000h)		;873d
	and a			;8740
	ret z			;8741
	ld a,(ix+006h)		;8742   ; los caracteres de su paso
	ld hl,08762h		;8745
	call 04b67h		;8748   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ex de,hl			;874b
	ld e,(ix+004h)		;874c   ; el sitio
	ld d,(ix+005h)		;874f
	ld a,004h		;8752   ; 4 filas de 4
L_8754:
	ld bc,00004h		;8754   ; 4 caracteres
	ldir		;8757
	ld c,01ch		;8759   ; la fila siguiente
	ex de,hl			;875b
	add hl,bc			;875c
	ex de,hl			;875d
	dec a			;875e   ; 4 filas
	jr nz,L_8754		;875f
	ret			;8761

; ----------------------------------------------------------------------
; DATOS tabla_8762: 3 punteros que p02:873D lee con IX+06 (L_4B67); lo leen
;   p02:8748 (6 bytes)
;   0x8762..0x8768  (6 bytes)
DATA_tabla_8762:
	defw 08768h,08778h,08788h	; 8762  -> DATA_filas_8768 0x8778 0x8788

; ----------------------------------------------------------------------
; DATOS filas_8768: 3 filas de 16 bytes (las de 0x8762), que p02:874B recorre;
;   lo leen p02:874B (48 bytes)
;   0x8768..0x8798  (48 bytes)
DATA_filas_8768:
	defb 000h,000h,000h,000h,000h,0e5h,0e6h,000h,000h,0e7h,0e8h,000h,000h,000h,000h,000h	; 8768  ................
	defb 000h,000h,0dbh,0dch,000h,0ddh,0deh,0dfh,000h,0e0h,0e1h,0e2h,000h,0e3h,0e4h,000h	; 8778  ................
	defb 0cbh,0cch,0cdh,0ceh,0cfh,0d0h,0d1h,0d2h,0d3h,0d4h,0d5h,0d6h,0d7h,0d8h,0d9h,0dah	; 8788  ................

; ======================================================================
; CODIGO 0x8798..0x882c  (148 bytes)
; ======================================================================


apariciones_de_objetos:		; lo que trae cada columna (p02:87B4) hasta ponerse al dia (0xE359)
	call aparicion_de_objeto		;8798   ; aparicion_de_objeto: la siguiente ficha de objetos de la fase (p02:8879): si es su columna, crea el objeto
	jr z,apariciones_de_objetos		;879b   ; Z: creado; a por el siguiente
	ret c			;879d   ; C: todavia no
	ld hl,0e359h		;879e   ; pasado: el siguiente
	inc (hl)			;87a1
	jr apariciones_de_objetos		;87a2
apariciones_de_objetos_scroll:		; si el scroll avanzo (0xE320), lo de la columna nueva (X = 0xF8)
	ld a,(0e320h)		;87a4   ; lee la marca de scroll hecho en este cuadro
	and a			;87a7
	ret z			;87a8
	ld a,0f8h		;87a9   ; por el borde derecho
	ld (0f004h),a		;87ab   ; guarda variable de paso
L_87AE:
	call aparicion_de_objeto		;87ae   ; aparicion_de_objeto: la siguiente ficha de objetos de la fase (p02:8879): si es su columna, crea el objeto
	jr z,L_87AE		;87b1
	ret			;87b3
aparicion_de_objeto:		; la siguiente ficha de objetos de la fase (p02:8879): si es su columna, crea el objeto
	call ficha_de_objeto		;87b4   ; no es su columna
	ret nz			;87b7
	ld hl,0e359h		;87b8   ; gastada
	inc (hl)			;87bb
	call crea_objeto_de_ficha		;87bc   ; crea_objeto_de_ficha: el objeto de la ficha: Y de B, X 0xF004, clase C & 0x1F y C bits 5-6; con el bit 7 solo con 0xE20A
	xor a			;87bf
	ret			;87c0
crea_objeto_de_ficha:		; el objeto de la ficha: Y de B, X 0xF004, clase C & 0x1F y C bits 5-6; con el bit 7 solo con 0xE20A
	bit 7,c		;87c1   ; con el bit 7, solo con 0xE20A
	jr z,L_87CA		;87c3
	ld a,(0e20ah)		;87c5   ; lee la vuelta (bit 0: las fases bajan)
	or a			;87c8
	ret z			;87c9
L_87CA:
	ld a,b			;87ca   ; la Y: bits 3-7 de B
	and 0f8h		;87cb
	ld e,a			;87cd
	ld a,(0f004h)		;87ce   ; la X
	ld d,a			;87d1
	ld a,c			;87d2   ; los bits 5-6 de C
	rlca			;87d3
	rlca			;87d4
	rlca			;87d5
	and 003h		;87d6
	ld b,a			;87d8
	ld a,c			;87d9   ; la clase: bits 0-4
	and 01fh		;87da
crea_objeto:		; un objeto de caracteres de la clase A en la primera ficha libre de 0xE500 (8 de 16 bytes), en D (X), E (Y)
	ld (0f010h),a		;87dc   ; 0xF010 = la clase, 0xF011 = los bits
	ld a,b			;87df
	ld (0f011h),a		;87e0
	ld (0f012h),de		;87e3   ; 0xF012 = X e Y
	ld hl,0e500h		;87e7   ; 8 fichas de 16 bytes
	ld de,00010h		;87ea
	xor a			;87ed
	ld b,008h		;87ee
L_87F0:
	cp (hl)			;87f0   ; la primera libre
	jr z,L_87F8		;87f1
	add hl,de			;87f3
	djnz L_87F0		;87f4
	xor a			;87f6   ; ninguna libre
	ret			;87f7
L_87F8:
	push hl			;87f8
	pop ix		;87f9
	ld a,(0f010h)		;87fb   ; lee variable de paso: la lista
	ld (hl),a			;87fe   ; IX+00 = la clase
	push af			;87ff
	inc l			;8800   ; IX+01 = 0
	ld (hl),000h		;8801
	ld de,(0f012h)		;8803   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	inc l			;8807
	ld a,d			;8808   ; IX+02 = 0 en el borde derecho, 0xFF si no
	cp 0f8h		;8809
	ld a,000h		;880b
	jr z,L_8810		;880d
	dec a			;880f
L_8810:
	ld (hl),a			;8810   ; IX+02
	inc l			;8811
	xor a			;8812   ; IX+03 = 0, IX+04 = Y
	ld (hl),a			;8813
	inc l			;8814
	ld (hl),e			;8815   ; IX+04 = Y
	inc l			;8816
	ld (hl),a			;8817   ; IX+05 = 0, IX+06 = X
	inc l			;8818
	ld (hl),d			;8819   ; IX+06 = X
	ld a,l			;881a   ; a IX+0B
	add a,005h		;881b
	ld l,a			;881d
	ld a,(0f011h)		;881e   ; IX+0B = los bits de la ficha
	ld (hl),a			;8821
	pop af			;8822
	call objeto_por_clase		;8823   ; y lo de su clase
	scf			;8826   ; C: creado
L_8827:
	ret			;8827
objeto_por_clase:		; lo propio de la clase A al crearse (16, p02:882C)
	dec a			;8828
	call 04084h		;8829   ; despacha: salta a la palabra A de la tabla que va pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS tabla_882C: 16 destinos del despachador p00:4084 (call en p02:8829, el
;   indice en A): B719, 8827, 8827, B885, BA13, BB90, A119, 8827, B448, B74D,
;   885E, 8867, 8870, 884C, 8827, 8855; lo leen p02:8829 (32 bytes)
;   0x882c..0x884c  (32 bytes)
DATA_tabla_882C:
	defw 0b719h,08827h,08827h,0b885h,0ba13h,0bb90h,0a119h,08827h	; 882c
	defw 0b448h,0b74dh,0885eh,08867h,08870h,0884ch,08827h,08855h	; 883c

; ======================================================================
; CODIGO 0x884c..0x8f71  (1829 bytes)
; ======================================================================


clase_be49:		; con el banco 11, p11:BE49
	call 04137h		;884c   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0be49h		;884f
	jp 04157h		;8852   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_badc:		; con el banco 11, p11:BADC
	call 04137h		;8855   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0badch		;8858
	jp 04157h		;885b   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a3ab:		; con el banco 11, p11:A3AB
	call 04137h		;885e   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a3abh		;8861
	jp 04157h		;8864   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a4d1:		; con el banco 11, p11:A4D1
	call 04137h		;8867   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a4d1h		;886a
	jp 04157h		;886d   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
clase_a811:		; con el banco 11, p11:A811
	call 04137h		;8870   ; banco_11: pone el banco 11 en 0xA000 (y 0xF0F3)
	call 0a811h		;8873
	jp 04157h		;8876   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
ficha_de_objeto:		; con el banco 12, la ficha 0xE359 de la lista de objetos de la fase (p12:BA12, 3 bytes): DE la columna (11 bits), B y C; compara con el scroll
	call 0413bh		;8879   ; la lista en el banco 12
	ld a,(0e201h)		;887c   ; lee la fase (0-11)
	ld hl,0ba12h		;887f
	call 04b67h		;8882   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(0e359h)		;8885   ; 3 bytes por ficha
	ld b,a			;8888
	add a,a			;8889
	add a,b			;888a
	call 0407fh		;888b   ; de_mas_a: DE = DE + A
	ex de,hl			;888e
	ld e,(hl)			;888f   ; la columna: un byte y los bits 0-2 del siguiente
	inc hl			;8890
	ld a,(hl)			;8891
	ld b,a			;8892
	and 007h		;8893
	ld d,a			;8895
	inc hl			;8896
	ld c,(hl)			;8897   ; C
	ld hl,(0e203h)		;8898   ; la compara con el scroll
	rst 20h			;889b
	push af			;889c
	call 04157h		;889d   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000 (y 0xF0F2-0xF0F3)
	pop af			;88a0
	ret			;88a1
disparos_a_enemigos:		; cada enemigo que se puede tocar (IX+10 bit 1) contra los 9 disparos de la nave
	ld ix,0e600h		;88a2   ; 12 enemigos
	ld b,00ch		;88a6
L_88A8:
	push bc			;88a8
	bit 1,(ix+010h)		;88a9   ; IX+10 bit 1: se le puede dar
	jr z,L_88C5		;88ad
	ld iy,0e470h		;88af   ; 9 disparos
	ld de,00010h		;88b3
	ld b,009h		;88b6
L_88B8:
	ld a,(iy+000h)		;88b8
	or a			;88bb
	call nz,disparo_al_enemigo		;88bc   ; disparo_al_enemigo: C si el disparo IY cae en la caja del enemigo IX (IX+0E/IX+0F por un lado, el largo del disparo por el otro) y lo golpea
	jr c,L_88C5		;88bf   ; C: ya le ha dado uno
	add iy,de		;88c1
	djnz L_88B8		;88c3
L_88C5:
	ld de,00040h		;88c5   ; el enemigo siguiente
	add ix,de		;88c8   ; el siguiente enemigo
	pop bc			;88ca
	djnz L_88A8		;88cb
	ret			;88cd
disparo_al_enemigo:		; C si el disparo IY cae en la caja del enemigo IX (IX+0E/IX+0F por un lado, el largo del disparo por el otro) y lo golpea
	ld a,(ix+004h)		;88ce   ; la Y del enemigo menos la del disparo
	sub (iy+003h)		;88d1
	jp nc,L_88E1		;88d4
	neg		;88d7   ; por encima: su alto (IX+0E)
	dec a			;88d9
	cp (ix+00eh)		;88da
	jp c,L_88E5		;88dd
	ret			;88e0
L_88E1:
	cp (iy+00dh)		;88e1   ; por debajo: el del disparo
	ret nc			;88e4
L_88E5:
	ld a,(ix+006h)		;88e5   ; la X del enemigo menos la del disparo
	sub (iy+005h)		;88e8
	jp nc,L_88F7		;88eb
	neg		;88ee   ; por la izquierda: su ancho (IX+0F)
	cp (ix+00fh)		;88f0
	jp c,L_88FB		;88f3
	ret			;88f6
L_88F7:
	cp (iy+00ch)		;88f7   ; por la derecha: el largo del disparo
	ret nc			;88fa
L_88FB:
	call golpe_al_enemigo		;88fb   ; golpe_al_enemigo: el disparo se gasta (el 5 estalla, del 6 en adelante atraviesan); el enemigo pierde un golpe (IX+0D) o no le hace nada (IX+10 bit 4); sin golpes, cae
	scf			;88fe
	ret			;88ff
golpe_al_enemigo:		; el disparo se gasta (el 5 estalla, del 6 en adelante atraviesan); el enemigo pierde un golpe (IX+0D) o no le hace nada (IX+10 bit 4); sin golpes, cae
	ld a,(iy+000h)		;8900   ; del tipo 6 en adelante atraviesan
	cp 006h		;8903
	jr nc,L_8915		;8905
	cp 005h		;8907   ; el 5 estalla
	jr nz,L_8911		;8909
	call disparo_estalla		;890b   ; disparo_estalla: el disparo 5 se convierte en una explosion de 24 x 24 (tipo 6, dibujo 0x44, color 15); en la fase 5 solo se va
	jp L_8915		;890e
L_8911:
	ld (iy+000h),000h		;8911   ; los demas se van
L_8915:
	ld a,(ix+000h)		;8915   ; el 0x0F
	cp 00fh		;8918
	jp z,tipo_0f_cae		;891a   ; tipo_0f_cae: el tipo 0x0F cae y, con los disparos 7 u 8, deja un 0x3B o 0x3C en su sitio (suena 0x20)
	bit 4,(ix+010h)		;891d   ; IX+10 bit 4: no le hace nada
	jp nz,enemigo_blindado		;8921   ; enemigo_blindado: el disparo se gasta sin hacerle nada: suena 0x14 el 0x19, si no el ruido de choque
	dec (ix+00dh)		;8924   ; un golpe menos
	ret nz			;8927
enemigo_cae:		; el enemigo IX cae: puntos (no el 0x32), su sonido, su grupo, se quita y deja un 0x26 en su sitio (salvo algunos tipos); el 0x2E se convierte en 0x28 + IX+0C
	ld a,(ix+000h)		;8928   ; el 0x2E cambia
	cp 02eh		;892b
	jp z,tipo_2e_cambia		;892d   ; tipo_2e_cambia: el tipo 0x2E se convierte en el 0x28 + IX+0C en su sitio
	cp 032h		;8930   ; el 0x32 no da puntos
	jr z,L_893A		;8932
	ld de,00001h		;8934   ; 0x0001 puntos (BCD)
	call 05b04h		;8937   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
L_893A:
	ld a,(ix+000h)		;893a
	ld b,012h		;893d   ; 0x30 y 0x25 suenan 0x12
	cp 030h		;893f   ; 0x30 y 0x25
	jr z,L_8957		;8941
	cp 025h		;8943
	jr z,L_8957		;8945
	ld b,008h		;8947   ; 1, 3 y 5 suenan 8
	cp 001h		;8949   ; 1, 3 y 5
	jr z,L_8957		;894b
	cp 003h		;894d
	jr z,L_8957		;894f
	cp 005h		;8951
	jr z,L_8957		;8953
	ld b,007h		;8955   ; los demas, 7
L_8957:
	ld a,b			;8957   ; su sonido
	call 04ae4h		;8958   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call grupo_del_caido		;895b   ; C: lo que deja
	ld a,(ix+000h)		;895e
	push af			;8961
	push bc			;8962
	call 06514h		;8963   ; se quita
	pop bc			;8966
	pop af			;8967
	sub 01dh		;8968   ; el 0x1D no deja nada
	ret z			;896a
	sub 005h		;896b   ; ni los 0x22-0x24
	cp 003h		;896d
	ret c			;896f
	sub 016h		;8970   ; ni los 0x3A-0x3C
	cp 003h		;8972
	ret c			;8974
	sub 009h		;8975   ; ni el 0x45
	ret z			;8977
	ld a,026h		;8978   ; los demas dejan un 0x26 con C
	ld e,(ix+004h)		;897a
	ld d,(ix+006h)		;897d
	jp 04d16h		;8980   ; crea_enemigo_ix: crea_enemigo conservando IX
suena_9:		; el sonido 9
	ld a,009h		;8983
	jp 04ae4h		;8985   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
grupo_del_caido:		; C = IX+0C; si es de un grupo, uno menos en el grupo y C = 1 al caer el ultimo (2 si su dato & 7 es 0)
	ld c,(ix+00ch)		;8988   ; C = IX+0C
	ld a,(ix+016h)		;898b   ; sin grupo, eso
	and a			;898e
	ret z			;898f
	ld c,000h		;8990
	ld a,(ix+017h)		;8992   ; su grupo
	call busca_grupo		;8995   ; busca_grupo: HL = el grupo A en 0xEA80 (4 de 3 bytes); C si no esta
	ret c			;8998
	ld a,(hl)			;8999
	inc l			;899a
	inc l			;899b
	dec (hl)			;899c   ; uno menos
	ret nz			;899d
	dec l			;899e
	dec l			;899f
	ld (hl),000h		;89a0   ; el ultimo: el grupo libre
	inc c			;89a2   ; C = 1, o 2 si su dato & 7 es 0
	and 007h		;89a3
	ret nz			;89a5
	inc c			;89a6
	ret			;89a7
busca_grupo:		; HL = el grupo A en 0xEA80 (4 de 3 bytes); C si no esta
	ld hl,0ea80h		;89a8   ; 4 grupos de 3 bytes
	ld b,004h		;89ab
L_89AD:
	cp (hl)			;89ad   ; el grupo?
	ret z			;89ae
	inc l			;89af   ; 3 bytes por grupo
	inc l			;89b0
	inc l			;89b1
	djnz L_89AD		;89b2
	scf			;89b4   ; no esta
	ret			;89b5
tipo_0f_cae:		; el tipo 0x0F cae y, con los disparos 7 u 8, deja un 0x3B o 0x3C en su sitio (suena 0x20)
	call enemigo_cae		;89b6   ; enemigo_cae: el enemigo IX cae: puntos (no el 0x32), su sonido, su grupo, se quita y deja un 0x26 en su sitio (salvo algunos tipos); el 0x2E se convierte en 0x28 + IX+0C
	ld a,(iy+000h)		;89b9   ; el disparo se gasta
	ld (iy+000h),000h		;89bc
	sub 007h		;89c0   ; solo con los disparos 7 y 8
	cp 002h		;89c2
	ret nc			;89c4
	ld b,a			;89c5
	ld a,(ix+006h)		;89c6   ; no en el borde izquierdo
	cp 010h		;89c9
	ret c			;89cb
	ld d,a			;89cc
	ld a,b			;89cd   ; la Y del disparo (7) o la del enemigo (8)
	or a			;89ce
	jr nz,L_89D6		;89cf
	ld e,(iy+003h)		;89d1
	jr L_89D9		;89d4
L_89D6:
	ld e,(ix+004h)		;89d6
L_89D9:
	ld c,000h		;89d9
	ld a,03bh		;89db   ; el 0x3B o el 0x3C
	add a,b			;89dd
	ld b,00ch		;89de
	call 04d16h		;89e0   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld a,020h		;89e3   ; suena 0x20
	jp 04ae4h		;89e5   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
tipo_2e_cambia:		; el tipo 0x2E se convierte en el 0x28 + IX+0C en su sitio
	ld a,(ix+00ch)		;89e8   ; IX+0C
	push af			;89eb
	call 06514h		;89ec   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	pop af			;89ef
	add a,028h		;89f0   ; el 0x28 + IX+0C en su sitio
	ld e,(ix+004h)		;89f2
	ld d,(ix+006h)		;89f5
	jp 04d16h		;89f8   ; crea_enemigo_ix: crea_enemigo conservando IX
enemigo_blindado:		; el disparo se gasta sin hacerle nada: suena 0x14 el 0x19, si no el ruido de choque
	ld (iy+000h),000h		;89fb   ; el disparo se gasta
	ld a,(ix+000h)		;89ff
	cp 019h		;8a02
	jp nz,ruido_de_choque		;8a04   ; ruido_de_choque: con jefe, el sonido 5 una vez por cuadro (0xE309)
	ld a,014h		;8a07   ; el 0x19 suena 0x14
	jp 04ae4h		;8a09   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparo_estalla:		; el disparo 5 se convierte en una explosion de 24 x 24 (tipo 6, dibujo 0x44, color 15); en la fase 5 solo se va
	ld a,(0e201h)		;8a0c   ; en la fase 5 solo se va
	cp 005h		;8a0f   ; en la fase 5
	jr nz,L_8A18		;8a11
	ld (iy+000h),000h		;8a13   ; se va
	ret			;8a17
L_8A18:
	push iy		;8a18
	pop hl			;8a1a
	ld (hl),006h		;8a1b   ; tipo 6, paso 0
	inc l			;8a1d   ; paso 0
	ld (hl),000h		;8a1e
	ld a,l			;8a20   ; a IY+05
	add a,004h		;8a21
	ld l,a			;8a23
	ld a,(hl)			;8a24   ; la X, sin pasar de 0xF7
	cp 0f8h		;8a25
	jr c,L_8A2C		;8a27
	ld a,0f7h		;8a29   ; 0xF7
	ld (hl),a			;8a2b
L_8A2C:
	inc l			;8a2c
	ld (hl),044h		;8a2d   ; dibujo 0x44, color 15
	inc l			;8a2f
	ld (hl),00fh		;8a30
	inc l			;8a32
	ld (hl),000h		;8a33   ; IY+08 = 0
	inc l			;8a35
	ld (hl),001h		;8a36   ; IX+09 = 1
	inc l			;8a38
	ld (hl),000h		;8a39   ; IY+0A = 0
	inc l			;8a3b
	inc l			;8a3c
	ld (hl),018h		;8a3d   ; 24 x 24
	inc l			;8a3f
	ld (hl),018h		;8a40   ; de alto
	ret			;8a42
disparos_a_objetos:		; sin jefe, cada objeto de caracteres de 0xE500 contra los 9 disparos de la nave
	ld a,(0e340h)		;8a43   ; con jefe, nada
	or a			;8a46
	ret nz			;8a47
	ld a,(0e3b2h)		;8a48   ; cuantas fichas de objetos
	and a			;8a4b
	ret z			;8a4c
	ld b,a			;8a4d
	ld ix,0e500h		;8a4e   ; apunta a las fichas de 16 bytes de los objetos de caracteres
L_8A52:
	push bc			;8a52
	ld a,(ix+000h)		;8a53   ; libre
	and a			;8a56
	jr z,L_8A6F		;8a57
	ld iy,0e470h		;8a59   ; 9 disparos
	ld de,00010h		;8a5d
	ld b,009h		;8a60
L_8A62:
	ld a,(iy+000h)		;8a62
	or a			;8a65
	call nz,disparo_al_objeto		;8a66   ; disparo_al_objeto: C si el disparo IY cae en el objeto IX (su caja de p15:B2F9 segun IX+0D, o su tamano) y lo golpea; los disparos 4-6 no tocan la clase 7
	jr c,L_8A6F		;8a69   ; C: ya le ha dado uno
	add iy,de		;8a6b
	djnz L_8A62		;8a6d
L_8A6F:
	ld de,00010h		;8a6f
	add ix,de		;8a72   ; el siguiente objeto
	pop bc			;8a74
	djnz L_8A52		;8a75
	ret			;8a77
disparo_al_objeto:		; C si el disparo IY cae en el objeto IX (su caja de p15:B2F9 segun IX+0D, o su tamano) y lo golpea; los disparos 4-6 no tocan la clase 7
	sub 004h		;8a78   ; los disparos 4-6
	cp 003h		;8a7a
	jr nc,L_8A87		;8a7c
	ld a,(ix+000h)		;8a7e   ; no tocan la clase 7
	sub 007h		;8a81
	cp 001h		;8a83
	ccf			;8a85
	ret nc			;8a86
L_8A87:
	ld a,(ix+00dh)		;8a87   ; IX+0D: la caja (negativo: no se toca; 0: su tamano)
	or a			;8a8a
	ret m			;8a8b
	jr z,L_8ACF		;8a8c
	add a,a			;8a8e   ; 4 bytes por caja en p15:B2F9
	add a,a			;8a8f
	ld hl,0b2f9h		;8a90
	call 0407ah		;8a93   ; hl_mas_a: HL = HL + A
	ld (0f000h),hl		;8a96   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld a,(ix+004h)		;8a99   ; Y + el desplazamiento de la caja, menos la del disparo
	add a,(hl)			;8a9c
	sub (iy+003h)		;8a9d
	jp nc,L_8AAD		;8aa0
	neg		;8aa3   ; por encima: el alto de la caja
	dec a			;8aa5
	inc hl			;8aa6
	inc hl			;8aa7
	cp (hl)			;8aa8
	jp c,L_8AB1		;8aa9
	ret			;8aac
L_8AAD:
	cp (iy+00dh)		;8aad   ; por debajo: el del disparo
	ret nc			;8ab0
L_8AB1:
	ld hl,(0f000h)		;8ab1   ; lee variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	inc hl			;8ab4
	ld a,(ix+006h)		;8ab5   ; X + el desplazamiento, menos la del disparo
	add a,(hl)			;8ab8
	sub (iy+005h)		;8ab9
	jp nc,L_8AC8		;8abc
	neg		;8abf   ; por la izquierda: el ancho de la caja
	inc hl			;8ac1
	inc hl			;8ac2
	cp (hl)			;8ac3
	jp c,L_8B0A		;8ac4
	ret			;8ac7
L_8AC8:
	cp (iy+00ch)		;8ac8   ; por la derecha: el largo del disparo
	jp c,L_8B0A		;8acb
	ret			;8ace
L_8ACF:
	ld a,(ix+004h)		;8acf   ; sin caja: el tamano del objeto
	sub (iy+003h)		;8ad2
	jp nc,L_8AE9		;8ad5   ; por debajo
	neg		;8ad8   ; por encima
	dec a			;8ada
	ld c,(ix+00ah)		;8adb   ; su alto (IX+0A) x 8
	sla c		;8ade
	sla c		;8ae0
	sla c		;8ae2
	cp c			;8ae4   ; su alto en pixeles
	jp c,L_8AED		;8ae5
	ret			;8ae8
L_8AE9:
	cp (iy+00dh)		;8ae9
	ret nc			;8aec
L_8AED:
	ld a,(ix+006h)		;8aed   ; la X del objeto menos la del disparo
	sub (iy+005h)		;8af0
	jp nc,L_8B06		;8af3   ; por la derecha
	neg		;8af6   ; por la izquierda
	ld c,(ix+009h)		;8af8   ; su ancho (IX+09) x 8
	sla c		;8afb
	sla c		;8afd
	sla c		;8aff
	cp c			;8b01   ; su ancho en pixeles
	jp c,L_8B0A		;8b02
	ret			;8b05
L_8B06:
	cp (iy+00ch)		;8b06
	ret nc			;8b09
L_8B0A:
	call golpe_al_objeto		;8b0a   ; golpe_al_objeto: el disparo se gasta; el objeto pierde un golpe (IX+08) y al acabarlos se rompe: puntos, sonido y explosion
	scf			;8b0d
	ret			;8b0e
golpe_al_objeto:		; el disparo se gasta; el objeto pierde un golpe (IX+08) y al acabarlos se rompe: puntos, sonido y explosion
	ld a,(iy+000h)		;8b0f   ; del tipo 6 en adelante atraviesan
	cp 006h		;8b12
	jr nc,L_8B24		;8b14
	cp 005h		;8b16   ; el 5 estalla
	jr nz,L_8B20		;8b18
	call disparo_estalla		;8b1a   ; disparo_estalla: el disparo 5 se convierte en una explosion de 24 x 24 (tipo 6, dibujo 0x44, color 15); en la fase 5 solo se va
	jp L_8B24		;8b1d
L_8B20:
	ld (iy+000h),000h		;8b20   ; los demas se van
L_8B24:
	call 06070h		;8b24   ; tocado
	dec (ix+008h)		;8b27   ; un golpe menos
	ret nz			;8b2a
	ld a,(ix+000h)		;8b2b   ; la clase 7 aparte
	cp 007h		;8b2e
	jp z,clase_7_rota		;8b30   ; clase_7_rota: la clase 7 rota: IX+01 = 5, IX+0D = 0xFF, IX+02 = 1, 0x0010 puntos y suena 0x13
	cp 006h		;8b33   ; las clases 6 y 15: 0xE38D = 1 y 0x0050 puntos
	jr z,L_8B3B		;8b35
	cp 00fh		;8b37
	jr nz,L_8B45		;8b39
L_8B3B:
	ld a,001h		;8b3b
	ld (0e38dh),a		;8b3d   ; guarda la marca de fin de la fase 7
	ld de,00050h		;8b40
	jr L_8B48		;8b43
L_8B45:
	ld de,00010h		;8b45   ; las demas, 0x0010
L_8B48:
	call 05b04h		;8b48   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld c,03bh		;8b4b   ; suena 0x3B la 15, 9 las 5 y 6, 0x13 las demas
	ld a,(ix+000h)		;8b4d
	cp 00fh		;8b50   ; la clase 15: 0x3B
	jr z,L_8B5E		;8b52
	ld c,009h		;8b54   ; las 5 y 6: 9
	sub 005h		;8b56
	cp 002h		;8b58
	jr c,L_8B5E		;8b5a
	ld c,013h		;8b5c   ; las demas: 0x13
L_8B5E:
	ld a,c			;8b5e
	call 04ae4h		;8b5f   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	call 0609eh		;8b62   ; rota
	ld e,(ix+004h)		;8b65   ; la explosion: en su sitio (la clase 14, 8 pixeles antes)
	ld d,(ix+006h)		;8b68
	ld hl,0f8f8h		;8b6b
	ld a,(ix+000h)		;8b6e
	cp 00eh		;8b71
	jr z,L_8B8C		;8b73
	ld a,(ix+007h)		;8b75   ; o desplazada segun su forma (p15:B375)
	push de			;8b78
	cp 035h		;8b79
	jr c,L_8B81		;8b7b
	sub 035h		;8b7d
	add a,01fh		;8b7f
L_8B81:
	ld hl,0b375h		;8b81   ; el desplazamiento de la forma
	call 0407ah		;8b84   ; hl_mas_a: HL = HL + A
	ld d,000h		;8b87
	ld e,(hl)			;8b89   ; HL = el desplazamiento
	ex de,hl			;8b8a
	pop de			;8b8b
L_8B8C:
	ld a,l			;8b8c   ; la Y
	add a,e			;8b8d   ; Y + el desplazamiento
	ld e,a			;8b8e
	ld c,d			;8b8f
	ld a,h			;8b90   ; la X, sin salirse de 0-0xE0
	add a,d			;8b91   ; X + el desplazamiento
	ld d,a			;8b92
	cp 0e0h		;8b93   ; dentro de la pantalla
	jr c,crea_explosion		;8b95
	bit 7,c		;8b97   ; se sale: al borde por el que salio
	ld d,0e0h		;8b99
	jr nz,crea_explosion		;8b9b
	ld d,000h		;8b9d
	jr crea_explosion		;8b9f
crea_explosion:		; una explosion de 4x4 caracteres en D (X), E (Y), si esta en pantalla y hay hueco en 0xEA40
	ld a,d			;8ba1   ; fuera de la pantalla, nada
	cp 0e8h		;8ba2
	ret nc			;8ba4
	ld a,e			;8ba5
	cp 0a8h		;8ba6
	ret nc			;8ba8
	ld hl,0ea40h		;8ba9   ; 4 explosiones de 8 bytes
	ld b,004h		;8bac
L_8BAE:
	ld a,(hl)			;8bae   ; libre?
	and a			;8baf
	jr z,L_8BBA		;8bb0
	ld a,008h		;8bb2   ; 8 bytes por explosion
	add a,l			;8bb4
	ld l,a			;8bb5
	djnz L_8BAE		;8bb6
	xor a			;8bb8   ; sin hueco
	ret			;8bb9
L_8BBA:
	ld a,005h		;8bba   ; [numero][4][Y][X]
	sub b			;8bbc
	ld (hl),a			;8bbd   ; el numero (1-4)
	inc l			;8bbe
	ld (hl),004h		;8bbf   ; 4 cuadros por paso
	inc l			;8bc1
	ld (hl),e			;8bc2   ; Y
	inc l			;8bc3
	ld (hl),d			;8bc4   ; X
	inc l			;8bc5
	inc l			;8bc6
	inc l			;8bc7
	ld (hl),002h		;8bc8   ; IX+06 = 2 pasos
	scf			;8bca
	ret			;8bcb
clase_7_rota:		; la clase 7 rota: IX+01 = 5, IX+0D = 0xFF, IX+02 = 1, 0x0010 puntos y suena 0x13
	ld (ix+001h),005h		;8bcc
	ld (ix+00dh),0ffh		;8bd0
	ld (ix+002h),001h		;8bd4
	ld de,00010h		;8bd8   ; 0x0010 puntos
	call 05b04h		;8bdb   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld a,013h		;8bde   ; suena 0x13
	jp 04ae4h		;8be0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparos_a_piezas:		; sin jefe, en las fases 3 y 9-11, las piezas de 0xE580 contra los disparos
	ld a,(0e340h)		;8be3   ; con jefe, nada
	or a			;8be6
	ret nz			;8be7
	ld a,(0e201h)		;8be8   ; solo en las fases 3 y 9-11
	cp 003h		;8beb   ; fase 3
	jr z,L_8BF4		;8bed
	sub 009h		;8bef   ; o 9-11
	cp 003h		;8bf1
	ret nc			;8bf3
L_8BF4:
	ld ix,0e580h		;8bf4   ; 16 piezas
	ld b,010h		;8bf8
L_8BFA:
	push bc			;8bfa
	ld a,(ix+000h)		;8bfb
	cp 005h		;8bfe   ; las clases 0-4, no
	jr c,L_8C20		;8c00
	ld iy,0e470h		;8c02   ; 9 disparos
	ld de,00010h		;8c06
	ld b,009h		;8c09
L_8C0B:
	ld a,(iy+000h)		;8c0b
	or a			;8c0e
	jr z,L_8C1C		;8c0f
	sub 004h		;8c11   ; los 4-6, no
	cp 003h		;8c13
	jr c,L_8C1C		;8c15
	call disparo_a_la_pieza		;8c17   ; disparo_a_la_pieza: C si el disparo IY cae en la pieza IX (su ancho y alto en caracteres) y la golpea
	jr c,L_8C20		;8c1a   ; C: ya le ha dado uno
L_8C1C:
	add iy,de		;8c1c
	djnz L_8C0B		;8c1e
L_8C20:
	ld bc,00008h		;8c20   ; la pieza siguiente
	add ix,bc		;8c23   ; la pieza siguiente
	pop bc			;8c25
	djnz L_8BFA		;8c26
	ret			;8c28
disparo_a_la_pieza:		; C si el disparo IY cae en la pieza IX (su ancho y alto en caracteres) y la golpea
	ld a,(ix+003h)		;8c29   ; fuera de la pantalla por la derecha, no
	cp 0e8h		;8c2c   ; fuera de la pantalla
	ret nc			;8c2e
	sub (iy+005h)		;8c2f   ; la X de la pieza menos la del disparo
	jp nc,L_8C45		;8c32
	neg		;8c35
	ld c,(ix+005h)		;8c37   ; por la izquierda: su ancho x 8
	sla c		;8c3a   ; x 8
	sla c		;8c3c
	sla c		;8c3e
	cp c			;8c40   ; su ancho
	jp c,L_8C49		;8c41
	ret			;8c44
L_8C45:
	cp (iy+00ch)		;8c45   ; por la derecha: el largo del disparo
	ret nc			;8c48
L_8C49:
	ld a,(ix+002h)		;8c49   ; la Y de la pieza menos la del disparo
	sub (iy+003h)		;8c4c
	jp nc,L_8C63		;8c4f
	neg		;8c52
	dec a			;8c54
	ld c,(ix+004h)		;8c55   ; por encima: su alto x 8
	sla c		;8c58   ; x 8
	sla c		;8c5a
	sla c		;8c5c
	cp c			;8c5e   ; su alto
	jp c,L_8C67		;8c5f
	ret			;8c62
L_8C63:
	cp (iy+00dh)		;8c63   ; por debajo: el alto del disparo
	ret nc			;8c66
L_8C67:
	call golpe_a_la_pieza		;8c67   ; golpe_a_la_pieza: el disparo se gasta (del 6 en adelante atraviesan); la pieza pierde un golpe; sin golpes, se rompe y da 0x0010 puntos
	scf			;8c6a
	ret			;8c6b
golpe_a_la_pieza:		; el disparo se gasta (del 6 en adelante atraviesan); la pieza pierde un golpe; sin golpes, se rompe y da 0x0010 puntos
	ld a,(iy+000h)		;8c6c   ; del 6 en adelante atraviesan
	cp 006h		;8c6f
	jr nc,L_8C77		;8c71
	ld (iy+000h),000h		;8c73
L_8C77:
	dec (ix+006h)		;8c77   ; un golpe menos
	jp nz,ruido_de_choque		;8c7a   ; ruido_de_choque: con jefe, el sonido 5 una vez por cuadro (0xE309)
	call 06d26h		;8c7d   ; sin golpes: rota
	ld de,00010h		;8c80   ; 0x0010 puntos
	jp 05b04h		;8c83   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
disparos_a_piezas_fase_5:		; sin jefe, en la fase 5, las dos piezas de 0xE580 y 0xE590 contra los disparos
	ld a,(0e340h)		;8c86   ; lee el tipo de jefe (1-5; 0 sin jefe)
	or a			;8c89
	ret nz			;8c8a
	ld a,(0e201h)		;8c8b   ; solo en la fase 5
	cp 005h		;8c8e
	ret nz			;8c90
	ld ix,0e580h		;8c91   ; la primera pieza
	call disparos_a_una_pieza		;8c95   ; disparos_a_una_pieza: la pieza IX contra los 9 disparos (no los 4-6)
	ld ix,0e590h		;8c98   ; y la segunda
disparos_a_una_pieza:		; la pieza IX contra los 9 disparos (no los 4-6)
	ld a,(ix+000h)		;8c9c
	or a			;8c9f   ; libre
	ret z			;8ca0
	ld iy,0e470h		;8ca1   ; 9 disparos
	ld de,00010h		;8ca5
	ld b,009h		;8ca8
L_8CAA:
	ld a,(iy+000h)		;8caa
	or a			;8cad
	jr z,L_8CBA		;8cae
	sub 004h		;8cb0   ; los 4-6, no
	cp 003h		;8cb2
	jr c,L_8CBA		;8cb4
	call disparo_a_pieza_fase_5		;8cb6   ; disparo_a_pieza_fase_5: C si el disparo cae en la pieza IX (32 pixeles de alto) y la golpea
	ret c			;8cb9
L_8CBA:
	add iy,de		;8cba
	djnz L_8CAA		;8cbc
	ret			;8cbe
disparo_a_pieza_fase_5:		; C si el disparo cae en la pieza IX (32 pixeles de alto) y la golpea
	ld a,(ix+003h)		;8cbf   ; la X de la pieza menos la del disparo
	sub (iy+005h)		;8cc2
	jp nc,L_8CD1		;8cc5
	neg		;8cc8   ; por la izquierda: IX+05
	cp (ix+005h)		;8cca
	jp c,L_8CD5		;8ccd
	ret			;8cd0
L_8CD1:
	cp (iy+00ch)		;8cd1
	ret nc			;8cd4
L_8CD5:
	ld a,(ix+002h)		;8cd5   ; la Y
	sub (iy+003h)		;8cd8
	jp nc,L_8CE7		;8cdb
	neg		;8cde
	dec a			;8ce0   ; por encima: 32 pixeles
	cp 020h		;8ce1
	jp c,L_8CEB		;8ce3
	ret			;8ce6
L_8CE7:
	cp (iy+00dh)		;8ce7
	ret nc			;8cea
L_8CEB:
	call golpe_a_pieza_fase_5		;8ceb   ; golpeada
	call se_gasta_si_rota		;8cee   ; se_gasta_si_rota: con la pieza aun entera (IX+06 < 4), el disparo se gasta (salvo el 15)
	call pieza_suelta		;8cf1   ; pieza_suelta: sin romper, una vez de cada 16 al azar suelta un 0x30
	scf			;8cf4
	ret			;8cf5
se_gasta_si_rota:		; con la pieza aun entera (IX+06 < 4), el disparo se gasta (salvo el 15)
	ld a,(ix+006h)		;8cf6   ; rota: los disparos pasan
	cp 004h		;8cf9   ; rota del todo: no
	ret nc			;8cfb
	ld a,(iy+000h)		;8cfc   ; el 15 atraviesa
	cp 00fh		;8cff
	ret z			;8d01
	ld (iy+000h),000h		;8d02   ; los demas se gastan
	ret			;8d06
golpe_a_pieza_fase_5:		; IX+07 = 24; cada 4 golpes un paso de rotura (IX+06, hasta 4); si no, suena 0x12
	ld (ix+007h),018h		;8d07   ; IX+07 = 24
	dec (ix+008h)		;8d0b   ; cada 4 golpes
	jp nz,L_8D2E		;8d0e
	ld (ix+008h),004h		;8d11
	ld a,(ix+001h)		;8d15   ; IX+01 = 1
	ld (ix+001h),001h		;8d18
	or a			;8d1c
	jr z,L_8D29		;8d1d
	ld a,(ix+006h)		;8d1f   ; un paso mas de rotura, hasta 4
	cp 004h		;8d22
	ret nc			;8d24
	inc (ix+006h)		;8d25
	ret			;8d28
L_8D29:
	ld (ix+006h),000h		;8d29   ; el primero: paso 0
	ret			;8d2d
L_8D2E:
	ld a,(ix+006h)		;8d2e   ; sin romper, suena 0x12
	cp 004h		;8d31
	ret nc			;8d33
	ld a,012h		;8d34
	jp 04ae4h		;8d36   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
pieza_suelta:		; sin romper, una vez de cada 16 al azar suelta un 0x30
	ld a,(ix+006h)		;8d39
	cp 004h		;8d3c
	ret nc			;8d3e
	call 04c24h		;8d3f   ; una vez de cada 16
	and 00fh		;8d42
	ret nz			;8d44
	ld a,(ix+003h)		;8d45   ; no en los bordes
	sub 010h		;8d48
	cp 0e0h		;8d4a
	ret nc			;8d4c
	add a,010h		;8d4d
	ld d,a			;8d4f
	ld a,(ix+002h)		;8d50   ; Y + 8
	add a,008h		;8d53
	ld e,a			;8d55
	ld bc,00000h		;8d56
	ld a,030h		;8d59   ; un 0x30
	jp 04d16h		;8d5b   ; crea_enemigo_ix: crea_enemigo conservando IX
nave_contra_balas:		; si una de las 10 balas de 0xE900 toca a la nave (12 x 8 pixeles), la bala se va y la nave cae
	ld a,(0e400h)		;8d5e   ; sin nave, nada
	dec a			;8d61
	ret m			;8d62
	ld a,(0e3d0h)		;8d63   ; ni con 0xE3D0
	or a			;8d66
	ret nz			;8d67
	ld ix,0e900h		;8d68   ; 10 balas
	ld l,00ah		;8d6c
	ld bc,00202h		;8d6e   ; caja de 2 x 2 de la nave
	call bala_toca		;8d71   ; bala_toca: NZ/C si alguna de las L fichas desde IX cae en la caja de la nave
	ret nc			;8d74
	ld (ix+000h),000h		;8d75   ; la bala se va
	jp nave_cae_si_juega		;8d79   ; nave_cae_si_juega: jugando y sin 0xE446, la nave cae
bala_toca:		; NZ/C si alguna de las L fichas desde IX cae en la caja de la nave
	ld a,(0e404h)		;8d7c   ; la Y de la nave + 4
	add a,004h		;8d7f
	ld e,a			;8d81
	ld a,(0e406h)		;8d82   ; la X + 1
	inc a			;8d85
	ld d,a			;8d86
	exx			;8d87
	ld de,00010h		;8d88   ; 16 bytes por ficha; caja de 12 x 8
	ld bc,00c08h		;8d8b
	exx			;8d8e
L_8D8F:
	ld a,(ix+000h)		;8d8f   ; libre
	or a			;8d92
	jr z,L_8DAB		;8d93   ; libre
	ld a,(ix+004h)		;8d95   ; la Y de la bala contra la de la nave
	sub e			;8d98   ; menos la Y de la nave
	exx			;8d99
	cp c			;8d9a
	exx			;8d9b
	jr c,L_8DA1		;8d9c
	add a,c			;8d9e   ; en el tramo C
	jr nc,L_8DAB		;8d9f
L_8DA1:
	ld a,(ix+006h)		;8da1   ; la X
	sub d			;8da4   ; menos la X de la nave
	exx			;8da5
	cp b			;8da6
	exx			;8da7
	ret c			;8da8
	add a,b			;8da9   ; en el tramo B
	ret c			;8daa
L_8DAB:
	exx			;8dab   ; la siguiente
	add ix,de		;8dac
	exx			;8dae
	dec l			;8daf
	jr nz,L_8D8F		;8db0
	xor a			;8db2   ; ninguna
	ret			;8db3
escudo_contra_balas:		; con escudo, las balas que llegan por delante se quedan en el y le quitan un golpe
	ld a,(0e400h)		;8db4   ; solo con escudo
	cp 002h		;8db7
	ret nz			;8db9
	ld a,(0e3d0h)		;8dba   ; lee la velocidad del scroll (1 parado, 2 cada cuadro, si no uno de cada dos)
	or a			;8dbd
	ret nz			;8dbe
	ld a,(0e404h)		;8dbf   ; el escudo va 12 pixeles por delante
	ld l,a			;8dc2
	ld a,(0e406h)		;8dc3
	add a,00ch		;8dc6
	ld h,a			;8dc8
	ld ix,0e900h		;8dc9   ; 10 balas
	ld de,00010h		;8dcd
	ld b,00ah		;8dd0
L_8DD2:
	ld a,(ix+000h)		;8dd2   ; libre
	and a			;8dd5
	jp z,L_8DED		;8dd6
	ld a,l			;8dd9   ; la Y: de -16 a +3
	sub (ix+004h)		;8dda
	add a,010h		;8ddd
	cp 013h		;8ddf
	jr nc,L_8DED		;8de1   ; fuera
	ld a,h			;8de3   ; la X: de -12 a -2
	sub (ix+006h)		;8de4
	add a,00ch		;8de7
	cp 00bh		;8de9
	jr c,L_8DF2		;8deb   ; dentro
L_8DED:
	add ix,de		;8ded
	djnz L_8DD2		;8def
	ret			;8df1
L_8DF2:
	ld (ix+000h),000h		;8df2   ; la bala se queda en el escudo
	jp golpe_al_escudo		;8df6   ; golpe_al_escudo: un golpe menos al escudo; sin golpes, la nave vuelve a ser normal y la casilla del arma se vacia
escudo_contra_enemigos:		; con escudo, el enemigo que lo toca cae y le quita un golpe; los que no caen (0x20, bloques, 0x22-0x24, 0x38-0x3C) se lo llevan entero
	ld a,(0e400h)		;8df9   ; solo con escudo
	cp 002h		;8dfc
	ret nz			;8dfe
	ld a,(0e3d0h)		;8dff   ; lee la velocidad del scroll (1 parado, 2 cada cuadro, si no uno de cada dos)
	or a			;8e02
	ret nz			;8e03
	ld a,(0e404h)		;8e04   ; 12 pixeles por delante de la nave
	ld e,a			;8e07
	ld a,(0e406h)		;8e08
	add a,00ch		;8e0b
	ld d,a			;8e0d
	ld hl,00c10h		;8e0e   ; caja de 16 x 12
	call enemigo_en_la_caja		;8e11   ; enemigo_en_la_caja: IX = el enemigo que toca la nave (IX+10 bit 0) en la caja E (Y), D (X) de L x H; NC si ninguno; el 0x38 tambien con sus otros sprites
	ret nc			;8e14
	ld a,(ix+000h)		;8e15   ; el enemigo que toca
	ld b,a			;8e18
	cp 020h		;8e19   ; el 0x20 se lleva el escudo
	jr z,se_va_el_escudo		;8e1b
	sub 029h		;8e1d   ; los recogibles no
	cp 006h		;8e1f
	ret c			;8e21
	push bc			;8e22
	call enemigo_cae		;8e23   ; los demas caen
	pop af			;8e26
	sub 022h		;8e27   ; los 0x22-0x24 se llevan el escudo
	cp 003h		;8e29
	jr c,se_va_el_escudo		;8e2b
	sub 016h		;8e2d   ; y los 0x38-0x3C
	cp 005h		;8e2f
	jr c,se_va_el_escudo		;8e31
golpe_al_escudo:		; un golpe menos al escudo; sin golpes, la nave vuelve a ser normal y la casilla del arma se vacia
	ld hl,0e401h		;8e33   ; un golpe menos
	dec (hl)			;8e36
	ret nz			;8e37
se_va_el_escudo:		; sin escudo: 0xE401 = 0, 0xE400 = 1 y la casilla del arma vacia
	xor a			;8e38   ; sin escudo
	ld (0e401h),a		;8e39   ; guarda los golpes que le quedan al escudo
	inc a			;8e3c
	ld (0e400h),a		;8e3d   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	jp 0553eh		;8e40   ; vacia_casilla_de_arma: pone a cero la casilla de 0xE3xx del arma capturada 0xE20F (p00:554F) y repinta el medidor
nave_contra_enemigos:		; el enemigo que toca a la nave: los 0x29-0x2E se recogen (p02:8F67), los demas caen y la nave tambien
	ld a,(0e400h)		;8e43   ; sin nave (0xFF), nada
	inc a			;8e46
	ret z			;8e47
	ld a,(0e3d0h)		;8e48   ; ni con 0xE3D0
	or a			;8e4b
	ret nz			;8e4c
	ld a,(0e404h)		;8e4d   ; la caja de la nave: Y + 4, X + 2, de 8 x 6
	add a,004h		;8e50
	ld e,a			;8e52
	ld a,(0e406h)		;8e53
	add a,002h		;8e56
	ld d,a			;8e58
	ld hl,00806h		;8e59
	call enemigo_en_la_caja		;8e5c   ; enemigo_en_la_caja: IX = el enemigo que toca la nave (IX+10 bit 0) en la caja E (Y), D (X) de L x H; NC si ninguno; el 0x38 tambien con sus otros sprites
	ret nc			;8e5f
	ld a,(ix+000h)		;8e60   ; el enemigo que toca
	cp 020h		;8e63   ; el 0x20 no cae
	jr z,nave_cae_si_juega		;8e65
	sub 029h		;8e67   ; los 0x29-0x2E se recogen
	cp 006h		;8e69
	jp c,recoge		;8e6b   ; recoge: lo recogido 0x29 + A (6, p02:8F71); los 0x29 y 0x2A desaparecen al cogerlos
	call enemigo_cae		;8e6e   ; los demas caen
nave_cae_si_juega:		; jugando y sin 0xE446, la nave cae
	ld a,(0e1c2h)		;8e71   ; en la demo no cae
	bit 6,a		;8e74
	ret z			;8e76
	ld a,(0e446h)		;8e77   ; ni con 0xE446
	or a			;8e7a
	ret nz			;8e7b
nave_cae:		; la nave cae: con Maze of Galious al lado (0xF0F5 bit 3) se guarda el equipo en 0xE210 para la vida siguiente; suena 0x3D y la explosion (p03:A993)
	ld a,(0e3c0h)		;8e7c   ; en el final del interior no
	or a			;8e7f
	ret nz			;8e80
	xor a			;8e81   ; nada guardado
	ld (0e20bh),a		;8e82   ; guarda la marca de equipo guardado (Galious)
	ld a,(0f0f5h)		;8e85   ; con Maze of Galious al lado se guarda el equipo
	bit 3,a		;8e88
	jr nz,L_8E94		;8e8a
	ld a,(0e330h)		;8e8c   ; si no, solo la casilla encendida
	ld (0e20dh),a		;8e8f   ; guarda la casilla encendida al caer
	jr L_8ECE		;8e92
L_8E94:
	ld hl,0e334h		;8e94   ; medidor vacio?
	ld b,009h		;8e97
	xor a			;8e99
L_8E9A:
	cp (hl)			;8e9a
	jr nz,L_8EA8		;8e9b
	inc hl			;8e9d
	djnz L_8E9A		;8e9e
	ld a,(0e330h)		;8ea0   ; lee la casilla iluminada del medidor
	ld (0e20dh),a		;8ea3   ; guarda la casilla encendida al caer
	jr L_8ECE		;8ea6
L_8EA8:
	ld a,001h		;8ea8   ; equipo guardado
	ld (0e20bh),a		;8eaa   ; guarda la marca de equipo guardado (Galious)
	ld de,0e210h		;8ead   ; el medidor
	ld hl,0e330h		;8eb0   ; apunta a la casilla iluminada del medidor
	ld bc,0000dh		;8eb3
	ldir		;8eb6
	ld hl,0e430h		;8eb8   ; las armas
	ld bc,00007h		;8ebb
	ldir		;8ebe
	ld a,(0e401h)		;8ec0   ; el escudo
	ld (de),a			;8ec3
	inc e			;8ec4
	ld a,(0e402h)		;8ec5   ; la velocidad
	ld (de),a			;8ec8
	inc e			;8ec9
	ld a,(0e40bh)		;8eca   ; y las opciones
	ld (de),a			;8ecd
L_8ECE:
	ld a,03dh		;8ece   ; suena 0x3D y 0xF0
	call 04ae4h		;8ed0   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,0f0h		;8ed3
	call 04ae4h		;8ed5   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	xor a			;8ed8   ; sin capsula especial ni cuenta atras
	ld (0e439h),a		;8ed9   ; guarda la capsula especial en marcha (con cuenta atras)
	ld (0e1d5h),a		;8edc   ; guarda la marca de la cuenta atras (1: un segundo menos, 2: se acabo)
	jp 0a993h		;8edf   ; p03:A993: la explosion de la nave
enemigo_en_la_caja:		; IX = el enemigo que toca la nave (IX+10 bit 0) en la caja E (Y), D (X) de L x H; NC si ninguno; el 0x38 tambien con sus otros sprites
	ld ix,0e600h		;8ee2   ; 12 enemigos
	ld b,00ch		;8ee6   ; 12 enemigos de 64 bytes
	exx			;8ee8
	ld de,00040h		;8ee9
	exx			;8eec
L_8EED:
	bit 0,(ix+010h)		;8eed   ; IX+10 bit 0: toca a la nave
	jr z,L_8F19		;8ef1
	ld a,(ix+004h)		;8ef3   ; la Y del enemigo menos E
	sub e			;8ef6
	jp nc,L_8F05		;8ef7
	neg		;8efa   ; por encima: su alto
	cp (ix+00eh)		;8efc
	jp c,L_8F08		;8eff
	jp L_8F19		;8f02
L_8F05:
	cp l			;8f05   ; por debajo: L
	jr nc,L_8F19		;8f06
L_8F08:
	ld a,(ix+006h)		;8f08   ; la X del enemigo menos D
	sub d			;8f0b
	jp nc,L_8F17		;8f0c
	neg		;8f0f   ; por la izquierda: su ancho
	cp (ix+00fh)		;8f11
	jr nc,L_8F19		;8f14
	ret			;8f16   ; toca: NC... con IX
L_8F17:
	cp h			;8f17   ; por la derecha: H
	ret c			;8f18
L_8F19:
	ld a,(ix+000h)		;8f19   ; el 0x38 lleva otros sprites
	cp 038h		;8f1c
	jr nz,L_8F24		;8f1e
	call partes_del_38		;8f20   ; partes_del_38: C si alguno de los otros 3 sprites del enemigo 0x38 cae en la caja
	ret c			;8f23
L_8F24:
	exx			;8f24   ; el siguiente
	add ix,de		;8f25
	exx			;8f27
	djnz L_8EED		;8f28
	xor a			;8f2a   ; ninguno
	ret			;8f2b
partes_del_38:		; C si alguno de los otros 3 sprites del enemigo 0x38 cae en la caja
	push bc			;8f2c
	push ix		;8f2d   ; sus sprites de IX+34
	pop bc			;8f2f
	ld a,034h		;8f30   ; IX+34: los otros sprites
	add a,c			;8f32
	ld c,a			;8f33
	exx			;8f34
	ld c,003h		;8f35   ; 3 sprites
	exx			;8f37
L_8F38:
	ld a,(bc)			;8f38   ; la Y del sprite menos E
	inc c			;8f39   ; [Y][X][dibujo][color]
	inc c			;8f3a
	sub e			;8f3b   ; la Y menos E
	jp nc,L_8F48		;8f3c
	neg		;8f3f   ; por encima
	cp 008h		;8f41   ; por encima: 8 pixeles
	jp c,L_8F4B		;8f43
	jr L_8F5D		;8f46
L_8F48:
	cp l			;8f48   ; por debajo: L
	jr nc,L_8F5D		;8f49
L_8F4B:
	dec c			;8f4b   ; la X
	ld a,(bc)			;8f4c
	inc c			;8f4d
	sub d			;8f4e   ; la X menos D
	jp nc,L_8F5A		;8f4f
	neg		;8f52   ; por la izquierda
	cp 010h		;8f54   ; por la izquierda: 16 pixeles
	jr nc,L_8F5D		;8f56
L_8F58:
	pop bc			;8f58
	ret			;8f59
L_8F5A:
	cp h			;8f5a   ; por la derecha: H
	jr c,L_8F58		;8f5b
L_8F5D:
	inc c			;8f5d   ; el siguiente
	inc c			;8f5e
	exx			;8f5f
	dec c			;8f60   ; los 3
	exx			;8f61
	jr nz,L_8F38		;8f62
	pop bc			;8f64
	xor a			;8f65   ; ninguno
	ret			;8f66
recoge:		; lo recogido 0x29 + A (6, p02:8F71); los 0x29 y 0x2A desaparecen al cogerlos
	push af			;8f67   ; los 0x29 y 0x2A desaparecen
	cp 002h		;8f68
	call c,06514h		;8f6a   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	pop af			;8f6d
	call 04084h		;8f6e   ; por tipo (6)

; ----------------------------------------------------------------------
; DATOS tabla_8F71: 6 destinos del despachador p00:4084 (call en p02:8F6E, el
;   indice en A): 8F7D, 8F9C, 8FE6, 8FD1, 8FD1, 89E8; lo leen p02:8F6E (12
;   bytes)
;   0x8f71..0x8f7d  (12 bytes)
DATA_tabla_8F71:
	defw 08f7dh,08f9ch,08fe6h,08fd1h,08fd1h,089e8h	; 8f71

; ======================================================================
; CODIGO 0x8f7d..0x9026  (169 bytes)
; ======================================================================


recoge_capsula:		; el 0x29: la casilla del medidor siguiente se enciende (de vuelta a la 1), 0x0005 puntos y suena 0x0A
	xor a			;8f7d   ; lo guardado ya no vale
	ld (0e20bh),a		;8f7e   ; guarda la marca de equipo guardado (Galious)
	ld hl,0e330h		;8f81   ; la casilla siguiente
	ld a,(hl)			;8f84
	inc a			;8f85
	inc l			;8f86   ; pasada la ultima, la 1
	cp (hl)			;8f87
	jr c,L_8F8C		;8f88
	ld a,001h		;8f8a
L_8F8C:
	dec l			;8f8c
	ld (hl),a			;8f8d
	ld de,00005h		;8f8e   ; 0x0005 puntos
	call 05b04h		;8f91   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld a,00ah		;8f94   ; suena 0x0A
	call 04ae4h		;8f96   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	jp 053a3h		;8f99   ; casillas_del_medidor: las 9 casillas del medidor (0xE334) en la fila 22 y el rotulo de la casilla 0xE330
recoge_bomba:		; el 0x2A: 0x0005 puntos y caen todos los enemigos en pantalla
	ld de,00005h		;8f9c   ; 0x0005 puntos
	call 05b04h		;8f9f   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
caen_todos:		; caen todos los enemigos (no los 0x1D, 0x20, 0x26 ni 0x29-0x2E) y suena 0x0B
	ld ix,0e8c0h		;8fa2   ; los 12 enemigos, del ultimo al primero
	ld b,00ch		;8fa6
L_8FA8:
	push bc			;8fa8
	ld a,(ix+000h)		;8fa9   ; libre
	or a			;8fac
	jr z,L_8FC4		;8fad   ; libre
	cp 01dh		;8faf   ; estos no caen
	jr z,L_8FC4		;8fb1
	cp 020h		;8fb3   ; el 0x20
	jr z,L_8FC4		;8fb5
	cp 026h		;8fb7   ; el 0x26
	jr z,L_8FC4		;8fb9
	sub 029h		;8fbb   ; los recogibles
	cp 006h		;8fbd
	jr c,L_8FC4		;8fbf
	call enemigo_cae		;8fc1   ; cae
L_8FC4:
	ld bc,0ffc0h		;8fc4   ; el anterior
	add ix,bc		;8fc7
	pop bc			;8fc9
	djnz L_8FA8		;8fca
	ld a,00bh		;8fcc   ; suena 0x0B
	jp 04ae4h		;8fce   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
recoge_2c:		; los 0x2C y 0x2D: pasan a 0x2F con el dibujo 0x94 + 4 x 0xE357, p02:900D y suena 0x23
	call pasa_a_2f		;8fd1   ; pasa_a_2f: el recogido pasa a ser el tipo 0x2F (el de antes en IX+28)
	call puntos_de_2c		;8fd4   ; puntos_de_2c: la cuenta 0xE357 + 1 (hasta 7) y los puntos de p02:9024 que le tocan
	ld a,(0e357h)		;8fd7   ; el dibujo segun 0xE357
	add a,a			;8fda
	add a,a			;8fdb
	add a,094h		;8fdc
	ld (ix+030h),a		;8fde
	ld a,023h		;8fe1   ; suena 0x23
	jp 04ae4h		;8fe3   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
recoge_vida:		; el 0x2B: pasa a 0x2F con el dibujo 0x94 y una vida mas
	call pasa_a_2f		;8fe6   ; pasa_a_2f: el recogido pasa a ser el tipo 0x2F (el de antes en IX+28)
	ld (ix+030h),094h		;8fe9   ; el dibujo 0x94
	jp 05b92h		;8fed   ; una vida mas
pasa_a_2f:		; el recogido pasa a ser el tipo 0x2F (el de antes en IX+28)
	ld a,(ix+000h)		;8ff0   ; el tipo de antes, en IX+28
	ld (ix+028h),a		;8ff3
	ld (ix+000h),02fh		;8ff6   ; ahora es un 0x2F
	ld a,(ix+004h)		;8ffa
	ld (ix+029h),a		;8ffd
	ld (ix+00bh),081h		;9000   ; IX+0B = 0x81: un sprite
	ld (ix+010h),008h		;9004   ; IX+10 = 8: con el scroll
	ld (ix+002h),00ah		;9008   ; IX+02 = 10
	ret			;900c
puntos_de_2c:		; la cuenta 0xE357 + 1 (hasta 7) y los puntos de p02:9024 que le tocan
	call cuenta_e357		;900d   ; cuenta_e357: 0xE357 + 1, como mucho 7
	ld hl,L_9024		;9010   ; los puntos que tocan
	call 04b67h		;9013   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	jp 05b04h		;9016   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
cuenta_e357:		; 0xE357 + 1, como mucho 7
	ld hl,0e357h		;9019   ; apunta a la marca de los tipos 0x2C-0x2F
	ld a,(hl)			;901c
	inc a			;901d
	cp 008h		;901e   ; como mucho 7
	jr c,L_9024		;9020
	ld a,007h		;9022
L_9024:
	ld (hl),a			;9024
	ret			;9025

; ----------------------------------------------------------------------
; DATOS tabla_9026: 7 palabras (0xE357 de 1 a 7; p02:900D lee 0x9024 + 2 x A
;   con L_4B67, y la 0 caeria en el `ld (hl),a / ret` de delante); lo leen
;   p02:9013 (14 bytes)
;   0x9026..0x9034  (14 bytes)
DATA_tabla_9026:
	defw 00001h,00002h,00005h,00010h,00020h,00050h,00100h	; 9026

; ======================================================================
; CODIGO 0x9034..0x94d9  (1189 bytes)
; ======================================================================


recoge_capsula_especial:		; la nave coge la capsula especial del mapa (clase 3 o mas): suena 0x1F, 0x0030 puntos y 15 segundos de D.VARRIOR (3), R.DRILL (4), E.SLOW (5) o VECTOR (7)
	ld a,(0e340h)		;9034   ; con jefe, nada
	or a			;9037
	ret nz			;9038
	ld a,(0ea60h)		;9039   ; las clases 0 y 1 no se cogen
	sub 002h		;903c
	ret c			;903e
	ld a,(0e400h)		;903f   ; sin nave, nada
	dec a			;9042
	ret m			;9043
	ld a,(0e404h)		;9044   ; la caja de la nave
	add a,004h		;9047   ; la Y de la nave + 4
	ld e,a			;9049
	ld a,(0e406h)		;904a
	inc a			;904d   ; la X de la nave + 1
	ld d,a			;904e
	ld a,(0ea61h)		;904f   ; la Y de la capsula
	sub e			;9052
	cp 008h		;9053   ; de -15 a 7
	jr c,L_905A		;9055
	add a,00fh		;9057
	ret nc			;9059
L_905A:
	ld a,(0ea62h)		;905a   ; la X
	sub d			;905d   ; la X menos la de la nave
	cp 00bh		;905e   ; de -15 a 10
	jr c,L_9065		;9060
	add a,00fh		;9062
	ret nc			;9064
L_9065:
	ld a,01fh		;9065   ; suena 0x1F
	call 04ae4h		;9067   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld de,00030h		;906a   ; 0x0030 puntos
	call 05b04h		;906d   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
	ld hl,0ea60h		;9070   ; se la lleva
	ld a,(hl)			;9073
	ld (hl),000h		;9074
	sub 003h		;9076   ; la 3
	jr z,L_908A		;9078
	dec a			;907a   ; la 4
	jr z,L_90A1		;907b
	dec a			;907d   ; la 5
	jr z,L_90BF		;907e
	sub 002h		;9080   ; la 7
	ret nz			;9082
	ld hl,01507h		;9083   ; VECTOR, 15 segundos
	ld b,017h		;9086
	jr empieza_cuenta_atras		;9088
L_908A:
	ld a,00fh		;908a   ; la 3: suena 0x0F, D.VARRIOR, 15 segundos
	call 04ae4h		;908c   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld hl,01503h		;908f
	ld b,019h		;9092
empieza_cuenta_atras:		; 0xE439 = L (la capsula), 0xE43A = H segundos (BCD), 60 cuadros y el rotulo B en el recuadro
	di			;9094
	ld (0e439h),hl		;9095   ; la capsula y sus segundos
	ld a,03ch		;9098   ; 60 cuadros
	ld (0e43bh),a		;909a   ; guarda los cuadros del segundo (de 60 a 0)
	ei			;909d
	jp 054c7h		;909e   ; y su rotulo
L_90A1:
	ld a,003h		;90a1   ; la 4: la nave es el R.DRILL
	ld (0e400h),a		;90a3   ; guarda la forma de la nave (1 normal, 2 con escudo, 3 R.DRILL)
	ld hl,00001h		;90a6
	ld (0e440h),hl		;90a9   ; guarda la marca del R.DRILL y el byte siguiente (16 bits)
	ld hl,01504h		;90ac   ; 15 segundos y su rotulo
	ld b,016h		;90af
	call empieza_cuenta_atras		;90b1   ; empieza_cuenta_atras: 0xE439 = L (la capsula), 0xE43A = H segundos (BCD), 60 cuadros y el rotulo B en el recuadro
	call 0a7f2h		;90b4   ; p03:A7F2
	call 042f5h		;90b7   ; sus dibujos
	ld a,010h		;90ba   ; suena 0x10
	jp 04ae4h		;90bc   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_90BF:
	ld hl,01505h		;90bf   ; la 5: E.SLOW, 15 segundos
	ld b,018h		;90c2
	jr empieza_cuenta_atras		;90c4
disparos_al_suceso:		; con el suceso de 0xE34B, sus dos piezas contra los disparos
	ld a,(0e34bh)		;90c6   ; sin suceso, nada
	or a			;90c9
	ret z			;90ca
	ld hl,0ea70h		;90cb   ; la primera pieza
	call disparos_a_pieza_del_suceso		;90ce   ; disparos_a_pieza_del_suceso: la pieza de 8 bytes HL contra los 9 disparos (caja de 16)
	ld hl,0ea78h		;90d1   ; y la segunda
disparos_a_pieza_del_suceso:		; la pieza de 8 bytes HL contra los 9 disparos (caja de 16)
	ld a,(hl)			;90d4
	or a			;90d5
	ret z			;90d6   ; sin pieza
	ld iy,0e470h		;90d7   ; 9 disparos, caja de 16
	ld de,00010h		;90db
	ld bc,00910h		;90de   ; 9 disparos, caja de 16
L_90E1:
	ld a,(iy+000h)		;90e1
	or a			;90e4
	jr z,L_90ED		;90e5
	push hl			;90e7
	call disparo_a_pieza_del_suceso		;90e8   ; disparo_a_pieza_del_suceso: C si el disparo cae en la pieza; la golpea y el disparo se va
	pop hl			;90eb
	ret c			;90ec   ; C: ya le ha dado uno
L_90ED:
	add iy,de		;90ed
	djnz L_90E1		;90ef
	ret			;90f1
disparo_a_pieza_del_suceso:		; C si el disparo cae en la pieza; la golpea y el disparo se va
	inc l			;90f2   ; la Y de la pieza menos la del disparo
	ld a,(hl)			;90f3
	sub (iy+003h)		;90f4   ; la Y de la pieza menos la del disparo
	jp nc,L_9101		;90f7
	neg		;90fa   ; por encima: 16
	cp c			;90fc
	jp c,L_9105		;90fd
	ret			;9100
L_9101:
	cp (iy+00dh)		;9101   ; por debajo: el alto del disparo
	ret nc			;9104
L_9105:
	inc l			;9105   ; la X
	ld a,(hl)			;9106
	sub (iy+005h)		;9107   ; la X de la pieza menos la del disparo
	jp nc,L_9114		;910a
	neg		;910d   ; por la izquierda: 16
	cp c			;910f
	jp c,L_9118		;9110
	ret			;9113
L_9114:
	cp (iy+00ch)		;9114   ; por la derecha: el largo del disparo
	ret nc			;9117
L_9118:
	call golpe_a_pieza_del_suceso		;9118   ; golpe_a_pieza_del_suceso: un golpe menos: cada 4 suelta un 0x33 cerca; sin golpes, explota y queda una menos (0xE34C); sin ninguna, 0xE34F = 1 y suena 0x3B
	ld (iy+000h),000h		;911b   ; el disparo se va
	scf			;911f
	ret			;9120
golpe_a_pieza_del_suceso:		; un golpe menos: cada 4 suelta un 0x33 cerca; sin golpes, explota y queda una menos (0xE34C); sin ninguna, 0xE34F = 1 y suena 0x3B
	inc l			;9121   ; un golpe menos
	dec (hl)			;9122
	jr z,L_9142		;9123
	ld a,(hl)			;9125   ; cada 4
	and 003h		;9126
	ret nz			;9128
	dec l			;9129   ; un 0x33 a +-7 pixeles
	ld a,r		;912a   ; la X + de -7 a 8
	and 00fh		;912c
	sub 007h		;912e
	add a,(hl)			;9130
	ld d,a			;9131
	ld a,r		;9132   ; la Y + de -7 a 8
	and 00fh		;9134
	sub 007h		;9136
	dec l			;9138
	add a,(hl)			;9139
	ld e,a			;913a
	ld a,033h		;913b   ; un 0x33
	ld c,000h		;913d
	jp 04d1eh		;913f   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
L_9142:
	dec l			;9142   ; sin golpes: la explosion 8 pixeles antes
	ld a,(hl)			;9143
	sub 008h		;9144
	ld d,a			;9146
	dec l			;9147
	ld a,(hl)			;9148
	sub 008h		;9149
	ld e,a			;914b
	dec l			;914c
	ld (hl),000h		;914d   ; la pieza ya no esta
	call crea_explosion		;914f   ; crea_explosion: una explosion de 4x4 caracteres en D (X), E (Y), si esta en pantalla y hay hueco en 0xEA40
	ld hl,0e34ch		;9152   ; una menos
	dec (hl)			;9155
	jr z,L_915D		;9156
	ld a,009h		;9158   ; suena 9
	jp 04ae4h		;915a   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
L_915D:
	ld a,001h		;915d   ; sin piezas, acabado
	ld (0e34fh),a		;915f   ; guarda la marca de jefe o suceso acabado
	ld a,03bh		;9162
	jp 04ae4h		;9164   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
disparos_al_jefe:		; las partes que se pueden golpear del jefe (0xEA00, y 0xEA20 con el 5) contra los disparos
	ld a,(0e340h)		;9167   ; el jefe 5 tiene dos partes
	cp 005h		;916a
	jr nz,L_917B		;916c
	ld ix,0ea00h		;916e   ; apunta a la ficha del jefe
	call disparos_a_la_parte		;9172   ; disparos_a_la_parte: la parte IX del jefe contra los 9 disparos
	ld ix,0ea20h		;9175   ; apunta a la segunda ficha del jefe (el 5)
	jr disparos_a_la_parte		;9179
L_917B:
	call 06878h		;917b   ; los demas, si tienen partes
	ret z			;917e
	ld a,(0e345h)		;917f   ; y no estan vencidos
	and a			;9182
	ret nz			;9183
	ld ix,0ea00h		;9184   ; apunta a la ficha del jefe
disparos_a_la_parte:		; la parte IX del jefe contra los 9 disparos
	ld a,(ix+000h)		;9188
	and a			;918b
	ret z			;918c   ; sin parte
	ld iy,0e470h		;918d   ; 9 disparos
	ld b,009h		;9191   ; 9 disparos
L_9193:
	push bc			;9193
	ld a,(iy+000h)		;9194   ; libre
	or a			;9197
	call nz,disparo_a_la_parte		;9198   ; disparo_a_la_parte: el nucleo de la parte (IX+13 Y, IX+14 X) en 0xE3D7 y la caja de 16 x 16 (p02:91B3)
	ld de,00010h		;919b   ; el siguiente
	add iy,de		;919e
	pop bc			;91a0
	djnz L_9193		;91a1
	ret			;91a3
disparo_a_la_parte:		; el nucleo de la parte (IX+13 Y, IX+14 X) en 0xE3D7 y la caja de 16 x 16 (p02:91B3)
	ld l,(ix+013h)		;91a4   ; el nucleo de la parte
	ld h,(ix+014h)		;91a7
	ld (0e3d7h),hl		;91aa   ; guarda la caja del nucleo del jefe (Y, X) y el byte siguiente (16 bits)
	ld hl,0e3d7h		;91ad   ; apunta a la caja del nucleo del jefe (Y, X)
	ld bc,01010h		;91b0   ; caja de 16 x 16
disparo_al_nucleo_del_jefe:		; C si el disparo IY cae en la caja de (HL) de C x B: el disparo se va y el jefe pierde un golpe (IX+12); sin golpes, vencido
	cp 006h		;91b3   ; el disparo 6 no
	ret z			;91b5
	ld a,(0e345h)		;91b6   ; vencido: nada
	and a			;91b9
	ret nz			;91ba
	ld a,(hl)			;91bb   ; la Y menos la del disparo
	inc a			;91bc   ; la Y del nucleo + 1, menos la del disparo
	sub (iy+003h)		;91bd
	jp nc,L_91CA		;91c0
	neg		;91c3   ; por encima: C
	cp c			;91c5
	jp c,L_91CE		;91c6
	ret			;91c9
L_91CA:
	cp (iy+00dh)		;91ca   ; por debajo: el alto del disparo
	ret nc			;91cd
L_91CE:
	inc l			;91ce   ; la X
	ld a,(hl)			;91cf   ; la X del nucleo menos la del disparo
	sub (iy+005h)		;91d0
	jp nc,L_91DD		;91d3
	neg		;91d6   ; por la izquierda: B
	cp b			;91d8
	jp c,L_91E1		;91d9
	ret			;91dc
L_91DD:
	cp (iy+00ch)		;91dd   ; por la derecha: el largo del disparo
	ret nc			;91e0
L_91E1:
	ld a,(iy+000h)		;91e1   ; el 5 estalla
	cp 005h		;91e4
	jr nz,L_91EE		;91e6
	call disparo_estalla		;91e8   ; disparo_estalla: el disparo 5 se convierte en una explosion de 24 x 24 (tipo 6, dibujo 0x44, color 15); en la fase 5 solo se va
	jp L_91F2		;91eb
L_91EE:
	ld (iy+000h),000h		;91ee   ; los demas se van
L_91F2:
	dec (ix+012h)		;91f2   ; un golpe menos
	jp m,jefe_vencido_premio		;91f5   ; jefe_vencido_premio: el jefe 5 pierde una parte (IX+1F); los demas, vencidos: 0xE345, el premio por cuadros de pelea (0xE444: menos de 300 dos armas, de 900 una), 0x0100 puntos y suena 0x3A
	ld a,(0e34dh)		;91f8   ; el nucleo de la fase 0 aparte
	cp 003h		;91fb
	jr z,golpe_al_nucleo_de_fase_0		;91fd
	ld a,027h		;91ff   ; suena 0x27
	call 04ae4h		;9201   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld e,(ix+013h)		;9204   ; un 0x26 a su derecha
	ld a,(ix+014h)		;9207
	add a,010h		;920a
	jr nc,L_9210		;920c
	ld a,0f0h		;920e
L_9210:
	ld d,a			;9210
	ld a,026h		;9211
	ld c,000h		;9213
	jp 04d16h		;9215   ; crea_enemigo_ix: crea_enemigo conservando IX
jefe_vencido_premio:		; el jefe 5 pierde una parte (IX+1F); los demas, vencidos: 0xE345, el premio por cuadros de pelea (0xE444: menos de 300 dos armas, de 900 una), 0x0100 puntos y suena 0x3A
	ld a,(0e340h)		;9218   ; el 5 pierde una parte
	cp 005h		;921b
	jr nz,L_9224		;921d
	ld (ix+01fh),001h		;921f   ; IX+1F: parte rota
	ret			;9223
L_9224:
	ld a,001h		;9224   ; vencido
	ld (0e345h),a		;9226   ; guarda la marca de nucleo destruido
	ld a,(0e34dh)		;9229   ; el nucleo de la fase 0 no da premio
	cp 003h		;922c
	ret z			;922e
	ld a,001h		;922f   ; 0xE22C = 1
	ld (0e22ch),a		;9231   ; guarda la marca de volver a la fase de p01:7C59
	ld hl,(0e346h)		;9234   ; los cuadros de pelea
	ld de,0012ch		;9237   ; menos de 300: dos armas
	rst 20h			;923a
	ld b,002h		;923b
	jr c,L_924A		;923d
	ld de,00384h		;923f   ; menos de 900: una
	rst 20h			;9242
	ld b,001h		;9243
	jr c,L_924A		;9245
	xor a			;9247   ; si no, nada
	jr L_925C		;9248
L_924A:
	ld hl,0e20fh		;924a   ; con 7 capturadas, nada
	ld a,(hl)			;924d
	cp 007h		;924e   ; 7 o mas
	ld c,000h		;9250
	jr nc,L_925B		;9252
	cp 006h		;9254   ; con 6, una como mucho
	ld c,b			;9256   ; menos de 6: lo que dio el tiempo
	jr c,L_925B		;9257
	ld c,001h		;9259   ; 6: una
L_925B:
	ld a,c			;925b
L_925C:
	ld (0e444h),a		;925c   ; el premio
	ld a,03ah		;925f   ; suena 0x3A
	call 04ae4h		;9261   ; sonido: pide el sonido A al controlador del banco 4 (p04:6480) con los bancos 4-5-6 y devuelve los de antes; conserva todos los registros
	ld a,001h		;9264
	ld (0e34fh),a		;9266   ; guarda la marca de jefe o suceso acabado
	ld de,00100h		;9269   ; 0x0100 puntos
	jp 05b04h		;926c   ; suma_puntos: jugando, suma DE (BCD) a los puntos del jugador en turno; vida extra al pasar 0xE207 y record (0xE1F1) si no esta la ranura de 0xF0F5 bit 1
golpe_al_nucleo_de_fase_0:		; cada golpe al nucleo de la fase 0 suelta un 0x38
	ld de,(0ea99h)		;926f   ; en el nucleo
	ld c,000h		;9273
	ld a,038h		;9275
	jp 04d1eh		;9277   ; crea_enemigo: busca ficha libre en 0xE600 y pone el enemigo de tipo A en D (X), E (Y), con B y C; A = 0 si no hay sitio o sprites (0xE355, maximo 12)
disparos_al_nucleo_de_fase_0:		; con el final de la fase 0 en marcha, su nucleo (0xEA99) contra los disparos
	ld hl,0ea98h		;927a   ; sin el final de la fase 0, nada
	ld a,(hl)			;927d
	or a			;927e
	ret z			;927f
	ld iy,0e470h		;9280   ; 9 disparos
	ld b,009h		;9284
L_9286:
	push bc			;9286
	ld a,(iy+000h)		;9287   ; libre
	or a			;928a
	call nz,disparo_al_nucleo_de_fase_0		;928b   ; disparo_al_nucleo_de_fase_0: el disparo IY contra el nucleo de 0xEA99, caja de 16 x 16
	ld de,00010h		;928e   ; el siguiente
	add iy,de		;9291
	pop bc			;9293
	djnz L_9286		;9294
	ret			;9296
disparo_al_nucleo_de_fase_0:		; el disparo IY contra el nucleo de 0xEA99, caja de 16 x 16
	ld ix,0ea00h		;9297   ; apunta a la ficha del jefe
	ld hl,0ea99h		;929b   ; el nucleo, caja de 16 x 16
	ld bc,01010h		;929e
	jp disparo_al_nucleo_del_jefe		;92a1   ; disparo_al_nucleo_del_jefe: C si el disparo IY cae en la caja de (HL) de C x B: el disparo se va y el jefe pierde un golpe (IX+12); sin golpes, vencido
nave_entra_al_jefe:		; si la nave esta junto a la entrada del jefe (0xEA0E, 0xEA10), 0xE22B = 1: al interior
	ld hl,0ea0eh		;92a4   ; la Y de la entrada
	ld a,(0e404h)		;92a7   ; la de la nave, a +-16
	sub (hl)			;92aa
	add a,010h		;92ab
	cp 020h		;92ad
	ret nc			;92af
	inc l			;92b0
	inc l			;92b1
	ld a,(0e406h)		;92b2   ; la X, a -24/+15
	sub (hl)			;92b5
	add a,018h		;92b6
	cp 028h		;92b8
	ret nc			;92ba
	ld a,001h		;92bb   ; dentro: al interior
	ld (0e22bh),a		;92bd   ; guarda la marca de jefe vencido: al interior
	ret			;92c0
mueve_balas:		; las 10 balas de 0xE900 (con E.SLOW, cuadro si cuadro no): suman su velocidad; fuera de la pantalla, libres
	ld a,(0e439h)		;92c1   ; con E.SLOW, cuadro si cuadro no
	cp 005h		;92c4
	jr nz,L_92CD		;92c6
	ld a,(0e1c3h)		;92c8   ; lee la cuenta de cuadros
	rra			;92cb
	ret c			;92cc
L_92CD:
	ld ix,0e900h		;92cd   ; 10 balas
	ld b,00ah		;92d1
L_92D3:
	ld a,(ix+000h)		;92d3
	and a			;92d6
	jr z,L_92EE		;92d7
	cp 082h		;92d9   ; el tipo 0x82, p11:B70B
	call z,0b70bh		;92db
	call 064e1h		;92de   ; suma su velocidad
	jr nc,L_92EA		;92e1
	ld a,(ix+006h)		;92e3   ; fuera por la derecha
	cp 0f0h		;92e6
	jr c,L_92EE		;92e8
L_92EA:
	ld (ix+000h),000h		;92ea   ; libre
L_92EE:
	ld de,00010h		;92ee   ; la siguiente bala
	add ix,de		;92f1
	djnz L_92D3		;92f3
	ret			;92f5
balas_contra_el_mapa:		; las balas (sin el bit 7 en el tipo) que tocan el mapa desaparecen
	ld ix,0e900h		;92f6   ; 10 balas
	ld b,00ah		;92fa
L_92FC:
	ld a,(ix+000h)		;92fc
	and a			;92ff
	jr z,L_930F		;9300
	bit 7,a		;9302   ; bit 7: no chocan
	jr nz,L_930F		;9304
	call toca_mapa_ix		;9306   ; toca el mapa?
	jr nc,L_930F		;9309
	ld (ix+000h),000h		;930b   ; libre
L_930F:
	ld de,00010h		;930f   ; la siguiente bala
	add ix,de		;9312
	djnz L_92FC		;9314
	ret			;9316
toca_mapa_ix:		; C si en IX+04 (Y), IX+06 (X) hay mapa
	ld l,(ix+004h)		;9317   ; L = Y
	ld h,(ix+006h)		;931a   ; H = X
	call 05c92h		;931d   ; su sitio en la pantalla de RAM
	ld a,(0e201h)		;9320   ; fases 0, 7 y 8: de 9 en adelante
	or a			;9323
	jr z,L_9335		;9324   ; fase 0
	sub 007h		;9326   ; fases 7 y 8
	cp 002h		;9328
	jr c,L_9335		;932a
es_mapa_hl_b:		; C si el caracter de HL es mapa (de 1 a 0xE305)
	ld a,(hl)			;932c   ; vacio: no
	and a			;932d
	ret z			;932e
L_932F:
	ld a,(0e305h)		;932f   ; de 1 a 0xE305
	cp (hl)			;9332
	ccf			;9333
	ret			;9334
L_9335:
	ld a,(hl)			;9335   ; fases 0, 7 y 8
	cp 009h		;9336   ; por debajo de 9: no
	ccf			;9338
	ret nc			;9339
	jp L_932F		;933a   ; por debajo de 0xE305
tipo_rumbo_50:		; IX+07-IX+0A = la velocidad hacia la nave con rapidez 0x50
	ld a,050h		;933d   ; rapidez 0x50
	ld (0f00fh),a		;933f   ; guarda la rapidez del disparo
	ld e,(ix+004h)		;9342
	ld d,(ix+006h)		;9345
	call rumbo_f00f		;9348   ; la velocidad hacia la nave
	ld de,(0f012h)		;934b   ; lee la velocidad Y calculada (16 bits) y el byte siguiente (16 bits)
	call 04efbh		;934f   ; pon_vy: IX+07/IX+08 = DE
	ld de,(0f014h)		;9352   ; lee la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	jp 04f02h		;9356   ; pon_vx: IX+09/IX+0A = DE
tipo_contra_el_mapa:		; el enemigo se quita si toca el mapa delante o debajo (p02:9360)
	call toca_mapa_delante		;9359   ; toca_mapa_delante: C si hay mapa en el sitio del enemigo (8 pixeles mas alla si va a la derecha) o debajo
	ret nc			;935c
	jp 06514h		;935d   ; toca: se quita
toca_mapa_delante:		; C si hay mapa en el sitio del enemigo (8 pixeles mas alla si va a la derecha) o debajo
	ld l,(ix+004h)		;9360   ; L = Y
	ld a,(ix+006h)		;9363   ; X
	bit 7,(ix+00ah)		;9366   ; a la izquierda, su sitio; a la derecha, 8 mas alla
	jr nz,L_936E		;936a
	add a,008h		;936c   ; a la derecha: 8 mas alla
L_936E:
	ld h,a			;936e
	call 05c92h		;936f   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	call es_mapa_hl_b		;9372   ; delante
	ret c			;9375
	ld de,00020h		;9376   ; debajo
	add hl,de			;9379
	jp es_mapa_hl_b		;937a   ; es_mapa_hl_b: C si el caracter de HL es mapa (de 1 a 0xE305)
dispara_bala_con:		; una bala desde D/E + 8 con la velocidad BC (Y) y HL (X), si no esta 0xF00E
	ld (0f012h),bc		;937d   ; la velocidad que viene
	ld (0f014h),hl		;9381   ; guarda la velocidad X calculada (16 bits) y el byte siguiente (16 bits)
	ld a,e			;9384   ; Y + 8
	add a,008h		;9385
	ld e,a			;9387
	ld a,(0f00eh)		;9388   ; con 0xF00E, nada
	and a			;938b
	ret nz			;938c
	jr pon_bala		;938d
dispara_bala:		; una bala desde D (X), E (Y) + 8 hacia la nave, con rapidez 0x50 + 2 x nivel (como mucho 0x60); no en la espera de salida
	ld a,e			;938f   ; Y + 8
	add a,008h		;9390
	ld e,a			;9392
	ld a,(0e228h)		;9393   ; rapidez 0x50 + 2 x nivel
	add a,a			;9396
	add a,050h		;9397
	cp 060h		;9399
	jr c,L_939F		;939b
	ld a,060h		;939d   ; como mucho 0x60
L_939F:
	ld (0f00fh),a		;939f   ; guarda la rapidez del disparo
	push de			;93a2
	call rumbo_f00f		;93a3   ; hacia la nave
	pop de			;93a6
	ld a,(0f00eh)		;93a7   ; con 0xF00E, nada
	and a			;93aa
	ret nz			;93ab
	ld a,(0e354h)		;93ac   ; ni en la espera de salida
	and a			;93af
	ret nz			;93b0
pon_bala:		; la primera ficha libre de 0xE900: tipo 1, en D/E, velocidad 0xF012/0xF014, dibujo 0x54 color 9; 0xE307 = 1
	ld hl,0e900h		;93b1   ; 10 balas
	ld b,00ah		;93b4
L_93B6:
	ld a,(hl)			;93b6   ; la primera libre
	and a			;93b7   ; libre?
	jr z,L_93C1		;93b8
	ld a,010h		;93ba   ; 16 bytes por bala
	add a,l			;93bc
	ld l,a			;93bd
	djnz L_93B6		;93be
	ret			;93c0   ; ninguna libre
L_93C1:
	ld a,001h		;93c1   ; alguien ha disparado
	ld (0e307h),a		;93c3   ; guarda la marca de disparo en este cuadro (uno solo)
	ld (hl),a			;93c6   ; tipo 1
	inc l			;93c7
	inc l			;93c8
	inc l			;93c9
	xor a			;93ca   ; Y
	ld (hl),a			;93cb
	inc l			;93cc
	ld (hl),e			;93cd
	inc l			;93ce
	ld (hl),a			;93cf   ; X
	inc l			;93d0
	ld (hl),d			;93d1
	inc l			;93d2
	ld de,(0f012h)		;93d3   ; la velocidad Y
	ld (hl),e			;93d7
	inc l			;93d8
	ld (hl),d			;93d9
	ld de,(0f014h)		;93da   ; la X
	inc l			;93de
	ld (hl),e			;93df
	inc l			;93e0
	ld (hl),d			;93e1
	inc l			;93e2
	ld (hl),054h		;93e3   ; dibujo 0x54, color 9
	inc l			;93e5
	ld (hl),009h		;93e6
	ret			;93e8
rumbo_sin_error:		; la velocidad hacia la nave desde D/E con rapidez A, sin el error de los niveles altos
	ld (0f00fh),a		;93e9   ; guarda la rapidez del disparo
	call angulo_a_la_nave		;93ec   ; angulo_a_la_nave: el angulo desde D (X), E (Y) hasta la nave (0xF017 y los signos en 0xF010-0xF011)
	ld d,001h		;93ef   ; D = 1: sin error
	jr rumbo_del_angulo_d		;93f1
rumbo_80:		; la velocidad hacia la nave con rapidez 0x80
	ld a,080h		;93f3
rumbo_a:		; la velocidad hacia la nave con rapidez A
	ld (0f00fh),a		;93f5   ; guarda la rapidez del disparo
rumbo_f00f:		; la velocidad hacia la nave desde D/E con rapidez 0xF00F
	call angulo_a_la_nave		;93f8   ; angulo_a_la_nave: el angulo desde D (X), E (Y) hasta la nave (0xF017 y los signos en 0xF010-0xF011)
rumbo_del_angulo:		; la velocidad del angulo ya calculado (0xF017), con error del nivel 7 en adelante
	ld d,000h		;93fb   ; D = 0: con error
rumbo_del_angulo_d:		; lo mismo con D = 1 para no poner error
	ld a,(0f017h)		;93fd   ; el angulo
	ld e,a			;9400
	ld a,(0e228h)		;9401   ; del nivel 7 en adelante, error
	cp 007h		;9404
	jr c,L_9425		;9406
	dec d			;9408   ; con D = 1, sin error
	jr z,L_9425		;9409
	ld a,r		;940b   ; un error al azar de 0 a 15
	ld b,a			;940d
	and 00fh		;940e
	bit 6,b		;9410   ; hacia un lado
	jr z,L_941D		;9412
	ld b,a			;9414   ; restado
	ld a,c			;9415
	sub b			;9416
	jr nc,L_941A		;9417
	xor a			;9419
L_941A:
	ld e,a			;941a   ; como mucho 0
	jr L_9425		;941b
L_941D:
	add a,e			;941d   ; o hacia el otro, hasta 63
	cp 03fh		;941e
	jr c,L_9424		;9420
	ld a,03fh		;9422
L_9424:
	ld e,a			;9424
L_9425:
	ld d,000h		;9425   ; la componente de un lado (p02:95D9)
	ld a,e			;9427
	sub 03fh		;9428
	neg		;942a
	ld hl,095d9h		;942c
	push hl			;942f
	add hl,de			;9430
	ld c,(hl)			;9431
	pop hl			;9432
	ld e,a			;9433   ; y la del otro (63 - angulo)
	add hl,de			;9434
	ld a,(hl)			;9435
	ld (0f016h),a		;9436   ; guarda el angulo de la otra componente
	ld e,c			;9439
	call por_rapidez		;943a   ; por la rapidez
	ld a,(0f010h)		;943d   ; con su signo
	and a			;9440
	call nz,05cadh		;9441   ; menos_de: DE = - DE
	ld (0f012h),de		;9444   ; la velocidad Y
	ld a,(0f016h)		;9448   ; lee el angulo de la otra componente
	ld e,a			;944b
	call por_rapidez		;944c   ; por_rapidez: DE = E x la rapidez 0xF00F / 32
	ld a,(0f011h)		;944f
	and a			;9452
	call nz,05cadh		;9453   ; menos_de: DE = - DE
	ld (0f014h),de		;9456   ; la velocidad X
	ret			;945a
angulo_a_la_nave:		; el angulo desde D (X), E (Y) hasta la nave (0xF017 y los signos en 0xF010-0xF011)
	ld a,(0e404h)		;945b   ; la nave como destino
	ld (0f000h),a		;945e   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero
	ld a,(0e406h)		;9461
	ld (0f001h),a		;9464   ; guarda variable de paso: cuantos bytes
angulo_a_f000:		; el angulo desde D/E hasta 0xF000 (Y), 0xF001 (X)
	ld hl,0f010h		;9467   ; 0xF010: el signo de la Y
	ld (hl),000h		;946a
	ld a,(0f000h)		;946c   ; la distancia en Y
	sub e			;946f
	jr nc,L_9475		;9470
	neg		;9472
	inc (hl)			;9474
L_9475:
	inc hl			;9475   ; 0xF011: el signo de la X
	ld (hl),000h		;9476
	and 0f0h		;9478   ; la distancia Y / 16
	ld e,a			;947a
	ld a,(0f001h)		;947b   ; la distancia en X
	sub d			;947e   ; la distancia en X
	jr nc,L_9484		;947f
	neg		;9481   ; en valor absoluto
	inc (hl)			;9483   ; y su signo
L_9484:
	ld d,a			;9484
	ld hl,0f00eh		;9485   ; 0xF00E = 1 si esta muy cerca (menos de 48)
	ld (hl),000h		;9488
	add a,e			;948a   ; la suma de las dos
	jr c,L_9492		;948b
	cp 030h		;948d   ; cerca: 0xF00E = 1
	jr nc,L_9492		;948f
	inc (hl)			;9491
L_9492:
	ld a,d			;9492   ; la proporcion: la distancia mayor / 16 + la menor
	rra			;9493
	rra			;9494
	rra			;9495
	rra			;9496
	and 00fh		;9497
	add a,e			;9499
	ld hl,094d9h		;949a   ; el angulo de p02:94D9
	call 0407ah		;949d   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;94a0
	ld (0f017h),a		;94a1   ; guarda el angulo calculado (0-63)
	ld c,a			;94a4
	ld hl,(0f010h)		;94a5   ; el cuadrante por los signos
	ld a,h			;94a8
	ld b,000h		;94a9
	and a			;94ab
	jr z,L_94B0		;94ac
	ld b,080h		;94ae
L_94B0:
	cp l			;94b0   ; los dos signos iguales?
	ld a,c			;94b1
	jr z,L_94B6		;94b2
	neg		;94b4   ; si no, el angulo al reves
L_94B6:
	add a,b			;94b6   ; 0xF018: el angulo de 0 a 255
	ld (0f018h),a		;94b7   ; guarda el angulo calculado
	ret			;94ba
por_rapidez:		; DE = E x la rapidez 0xF00F / 32
	ld a,(0f00fh)		;94bb   ; la rapidez
	ld h,a			;94be   ; H = la rapidez
	call multiplica_8		;94bf   ; multiplica_8: HL = H x E (8 x 8 bits)
	xor a			;94c2   ; / 32
	add hl,hl			;94c3   ; x 8 en 24 bits
	adc a,a			;94c4
	add hl,hl			;94c5
	adc a,a			;94c6
	add hl,hl			;94c7
	adc a,a			;94c8
	ld l,h			;94c9   ; y se queda con los dos de arriba
	ld h,a			;94ca
	ex de,hl			;94cb
	ret			;94cc
multiplica_8:		; HL = H x E (8 x 8 bits)
	ld b,008h		;94cd   ; 8 bits
	ld l,000h		;94cf
	ld d,l			;94d1
L_94D2:
	add hl,hl			;94d2   ; desplaza a la izquierda
	jr nc,L_94D6		;94d3
	add hl,de			;94d5   ; y suma si el bit era 1
L_94D6:
	djnz L_94D2		;94d6
	ret			;94d8

; ----------------------------------------------------------------------
; DATOS arcotangente: 16 x 16 bytes: el angulo (0x00-0x3F) para cada par
;   |dx|/16, |dy|/16 que p02:9492 calcula (0x94D9 + 16 x fila + columna); lo
;   leen p02:949D (256 bytes)
;   0x94d9..0x95d9  (256 bytes)
DATA_arcotangente:
	defb 020h,00dh,008h,006h,004h,004h,003h,003h,002h,002h,002h,002h,001h,001h,001h,001h	; 94d9   ...............
	defb 033h,020h,016h,010h,00dh,00bh,009h,008h,007h,006h,006h,005h,005h,004h,004h,004h	; 94e9  3 ..............
	defb 038h,02ah,020h,019h,015h,011h,00fh,00dh,00ch,00ah,009h,009h,008h,007h,007h,006h	; 94f9  8* .............
	defb 03ah,02fh,027h,020h,01bh,017h,014h,012h,010h,00eh,00dh,00ch,00bh,00ah,00ah,009h	; 9509  :/' ............
	defb 03bh,033h,02bh,025h,020h,01ch,019h,016h,014h,012h,010h,00fh,00eh,00dh,00ch,00bh	; 9519  .3+% ...........
	defb 03ch,035h,02eh,029h,024h,020h,01ch,01ah,017h,015h,014h,012h,011h,010h,00fh,00eh	; 9529  <5.)$ ..........
	defb 03dh,037h,031h,02ch,027h,023h,020h,01dh,01ah,018h,016h,015h,013h,012h,011h,010h	; 9539  =71,'# .........
	defb 03dh,038h,033h,02eh,02ah,026h,023h,020h,01dh,01bh,019h,017h,016h,015h,013h,012h	; 9549  =83.*&# ........
	defb 03dh,039h,034h,030h,02ch,028h,025h,022h,020h,01eh,01ch,01ah,018h,017h,015h,014h	; 9559  =940,(%" .......
	defb 03eh,039h,035h,031h,02eh,02ah,027h,025h,022h,020h,01eh,01ch,01ah,019h,017h,016h	; 9569  >951.*'%" ......
	defb 03eh,03ah,036h,033h,02fh,02ch,029h,027h,024h,022h,020h,01eh,01ch,01bh,019h,018h	; 9579  >:63/,)'$" .....
	defb 03eh,03bh,037h,034h,031h,02eh,02bh,028h,026h,024h,022h,020h,01eh,01dh,01bh,01ah	; 9589  >.741.+(&$" ....
	defb 03eh,03bh,038h,035h,032h,02fh,02ch,02ah,028h,025h,023h,022h,020h,01eh,01dh,01ch	; 9599  >.852/,*(%#" ...
	defb 03eh,03bh,038h,036h,033h,030h,02eh,02bh,029h,027h,025h,023h,021h,020h,01eh,01dh	; 95a9  >.8630.+)'%#! ..
	defb 03eh,03ch,039h,036h,034h,031h,02fh,02ch,02ah,028h,026h,025h,023h,021h,020h,01eh	; 95b9  ><9641/,*(&%#! .
	defb 03fh,03ch,039h,037h,034h,032h,030h,02dh,02bh,029h,028h,026h,024h,023h,021h,020h	; 95c9  ?<97420-+)(&$#!

; ----------------------------------------------------------------------
; DATOS seno: 64 bytes que suben de 0x00 a 0xFF: p02:9425 lee 0x95D9 + (0x3F -
;   E) y 0x95D9 + E; lo leen p02:942C (64 bytes)
;   0x95d9..0x9619  (64 bytes)
DATA_seno:
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; 95d9  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; 95e9  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; 95f9  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 9609  ................

; ----------------------------------------------------------------------
; DATOS tabla_9619: 4 pares que p02:9644 lee con (IX+02 / 2) & 6 y pone en
;   IX+30 e IX+31; lo leen p02:9654 (8 bytes)
;   0x9619..0x9621  (8 bytes)
DATA_tabla_9619:
	defb 044h,00fh	; 9619
	defb 048h,009h	; 961b
	defb 04ch,006h	; 961d
	defb 050h,00dh	; 961f

; ----------------------------------------------------------------------
; DATOS tabla_9621: 4 palabras que p02:963F y p03:B204 leen con L_4B67; lo
;   leen p02:963F (8 bytes)
;   0x9621..0x9629  (8 bytes)
DATA_tabla_9621:
	defw 00f44h,00f48h,00f44h,00f48h	; 9621

; ======================================================================
; CODIGO 0x9629..0x97b9  (400 bytes)
; ======================================================================


tipo_26_empieza:		; los tipos 0x26, 0x33 y 0x36: paso 0 y con el scroll (IX+10 = 8)
	ld (ix+002h),000h		;9629   ; paso 0
	ld (ix+010h),008h		;962d   ; con el scroll
	ret			;9631
tipo_36:		; el tipo 0x36: 4 dibujos de p02:9621 y se va
	ld a,(ix+002h)		;9632   ; 4 pasos
	inc a			;9635
	cp 004h		;9636
	jp nc,06514h		;9638   ; al acabar, se va
	ld (ix+002h),a		;963b
	add a,a			;963e   ; dos bytes por paso
	ld hl,09621h		;963f
	jr L_9654		;9642
tipo_26:		; los tipos 0x26 y 0x33: 8 dibujos de p02:9619 (dos cuadros cada uno) y luego, segun IX+0C, nada, un 0x29 o un 0x2A en su sitio
	ld a,(ix+002h)		;9644   ; 16 cuadros
	cp 010h		;9647
	jr nc,deja_capsula		;9649
	inc (ix+002h)		;964b
	rra			;964e   ; el dibujo, uno cada dos cuadros
	and 006h		;964f
	ld hl,09619h		;9651
L_9654:
	call 05ca6h		;9654   ; dibujo y color
	ld (ix+030h),a		;9657   ; el dibujo
	inc hl			;965a
	ld a,(hl)			;965b
	ld (ix+031h),a		;965c   ; el color
	ret			;965f
deja_capsula:		; sin dato (IX+0C = 0) se va; con 1 pasa a ser el 0x29 y con 2 el 0x2A: de caracteres, 2 x 2, en la rejilla de 8
	xor a			;9660   ; sin grupo
	ld (ix+016h),a		;9661
	ld a,(ix+00ch)		;9664   ; IX+0C: lo que deja
	dec a			;9667
	jp m,06514h		;9668   ; nada: se va
	ld bc,02901h		;966b   ; 1: el 0x29, caracter 1
	jr z,L_9672		;966e
	inc b			;9670   ; 2: el 0x2A, caracter 2
	inc c			;9671
L_9672:
	ld (ix+000h),b		;9672
	ld (ix+032h),c		;9675
	ld hl,0e355h		;9678   ; ya no gasta sprite
	dec (hl)			;967b
	ld (ix+00bh),0c0h		;967c   ; de caracteres y se ve
	call tipo_29_empieza		;9680   ; tipo_29_empieza: los tipos 0x29 y 0x2A: IX+10 = 9 y 2 x 2
	ld a,(ix+004h)		;9683   ; a la rejilla de 8
	and 0f8h		;9686
	ld (ix+004h),a		;9688
	ld a,(ix+006h)		;968b
	and 0f8h		;968e
	ld (ix+006h),a		;9690
	ret			;9693
tipo_29_empieza:		; los tipos 0x29 y 0x2A: IX+10 = 9 y 2 x 2
	ld a,009h		;9694
tamano_2x2:		; IX+10 = A y 2 x 2 caracteres
	ld (ix+010h),a		;9696   ; IX+10
	ld a,002h		;9699   ; 2 x 2
	ld (ix+013h),a		;969b
	ld (ix+014h),a		;969e
L_96A1:
	ret			;96a1
tipo_2e_empieza:		; el tipo 0x2E: sin dibujo y IX+10 = 0x0B
	ld (ix+00bh),000h		;96a2
	ld a,00bh		;96a6
	jr tamano_2x2		;96a8
tipo_2b_empieza:		; el tipo 0x2B: de caracteres desde 0x37, 2 x 2, y borra lo que hay debajo
	ld (ix+00bh),0c0h		;96aa
	ld c,037h		;96ae   ; caracteres desde 0x37
	jr L_96C1		;96b0
tipo_2d_empieza:		; el tipo 0x2D: 8 veces (IX+2A), de caracteres desde 0x38
	ld b,008h		;96b2
	jr L_96B8		;96b4
tipo_2c_empieza:		; el tipo 0x2C: una vez (IX+2A), de caracteres desde 0x38
	ld b,001h		;96b6
L_96B8:
	ld (ix+02ah),b		;96b8
	ld (ix+00bh),0c0h		;96bb
	ld c,038h		;96bf   ; caracteres desde 0x38
L_96C1:
	ld (ix+032h),c		;96c1   ; los caracteres desde C
	ld a,009h		;96c4
	call tamano_2x2		;96c6   ; tamano_2x2: IX+10 = A y 2 x 2 caracteres
	ld l,(ix+004h)		;96c9   ; borra los 2 x 2 de la pantalla de RAM
	ld h,(ix+006h)		;96cc
	call 05c92h		;96cf   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	xor a			;96d2   ; borra los 2 x 2
	ld (hl),a			;96d3
	inc hl			;96d4
	ld (hl),a			;96d5
	ld bc,0001fh		;96d6   ; la fila de abajo
	add hl,bc			;96d9
	ld (hl),a			;96da
	inc hl			;96db
	ld (hl),a			;96dc
	ret			;96dd
tipo_2f:		; el tipo 0x2F (lo recogido): sube IX+02 cuadros; luego se va (el 0x2B, o al gastar IX+2A) o vuelve a ser un 0x2D en su Y
	ld a,(ix+004h)		;96de   ; sube hasta arriba
	or a			;96e1
	jp z,L_96E8		;96e2
	dec (ix+004h)		;96e5
L_96E8:
	dec (ix+002h)		;96e8   ; mientras dure
	ret nz			;96eb
	ld a,(ix+028h)		;96ec   ; era un 0x2B: se va
	cp 02bh		;96ef
	jp z,06514h		;96f1   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	dec (ix+02ah)		;96f4   ; se gasta una vez
	jp z,06514h		;96f7   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld (ix+000h),02dh		;96fa   ; vuelve a ser un 0x2D
	ld (ix+00bh),0c0h		;96fe
	set 0,(ix+010h)		;9702   ; que toca a la nave
	ld a,(ix+029h)		;9706   ; en su Y de antes
	ld (ix+004h),a		;9709
L_970C:
	ret			;970c
tipo_3a_empieza:		; el tipo 0x3A: el caracter 0xC6, en la rejilla de 8
	ld a,0c6h		;970d
	call caracter_en_rejilla		;970f   ; caracter_en_rejilla: IX+32 = A y la Y a la rejilla de 8
	jr L_9725		;9712
caracter_en_rejilla:		; IX+32 = A y la Y a la rejilla de 8
	ld (ix+032h),a		;9714   ; el caracter
	ld a,(ix+004h)		;9717   ; Y a la rejilla de 8
	and 0f8h		;971a   ; a la rejilla de 8
	ld (ix+004h),a		;971c
	ret			;971f
tipo_39_empieza:		; el tipo 0x39: el caracter 0xC7 + (Y / 2) & 3
	ld c,0c7h		;9720
	call caracter_por_y		;9722   ; caracter_por_y: IX+32 = C + (Y / 2) & 3
L_9725:
	ld a,(ix+00ch)		;9725   ; IX+02 = IX+0C
	ld (ix+002h),a		;9728
fila_empieza:		; IX+0C = 0, IX+10 = 1, 1 x 1 y la X a la rejilla de 8
	ld (ix+00ch),000h		;972b   ; sin dato
	ld a,001h		;972f
	ld (ix+010h),a		;9731   ; IX+10 = 1 y 1 x 1
	ld (ix+013h),a		;9734
	ld (ix+014h),a		;9737
	ld a,(ix+006h)		;973a   ; X a la rejilla de 8
	and 0f8h		;973d
	ld (ix+006h),a		;973f
	ret			;9742
caracter_por_y:		; IX+32 = C + (Y / 2) & 3
	ld a,(ix+004h)		;9743   ; el caracter segun la Y
	rra			;9746   ; (Y / 2) & 3
	and 003h		;9747
	add a,c			;9749   ; mas el primero
	ld (ix+032h),a		;974a
	ret			;974d
tipo_39:		; los tipos 0x39 y 0x3A: una fila de caracteres que crece hacia la izquierda (IX+14, hasta IX+19) hasta tocar el mapa; luego se encoge y se va
	ld a,(ix+001h)		;974e   ; el paso
	dec a			;9751
	jr z,$+107		;9752
	dec a			;9754
	jr z,$+125		;9755
	jp p,fila_se_va		;9757   ; fila_se_va: un caracter menos y con el scroll; sin ninguno, se va
	ld a,(ix+006h)		;975a   ; 8 pixeles a la izquierda
	sub 008h		;975d
	ld (ix+006h),a		;975f
	jr z,$+107		;9762
	ld a,(0e340h)		;9764   ; con jefe, a la altura de su parte (0xEA03 + p02:97B8)
	or a			;9767
	jr z,L_978E		;9768
	ld hl,l97b8h		;976a
	ld a,(ix+002h)		;976d
	call 05ca6h		;9770   ; byte_a: A = el byte A de la tabla HL
	ld a,(0ea03h)		;9773
	add a,(hl)			;9776
	ld (ix+004h),a		;9777
	cp 0b0h		;977a   ; fuera por abajo: se va
	jp nc,06514h		;977c   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld a,(ix+000h)		;977f
	cp 039h		;9782
	jr z,L_978E		;9784
	ld a,(ix+004h)		;9786   ; a la rejilla de 8 (salvo el 0x39)
	and 0f8h		;9789
	ld (ix+004h),a		;978b
L_978E:
	call fila_toca_mapa		;978e   ; toca el mapa?
	jr c,L_97AC		;9791
	inc (ix+014h)		;9793   ; un caracter mas
	ld a,(ix+014h)		;9796
	cp (ix+019h)		;9799   ; hasta IX+19
	jr c,ancho_en_pixeles		;979c
	ld (ix+001h),001h		;979e   ; al paso 1
ancho_en_pixeles:		; IX+0F = IX+14 x 8
	ld a,(ix+014h)		;97a2   ; su ancho en pixeles
	add a,a			;97a5   ; x 8
	add a,a			;97a6
	add a,a			;97a7
	ld (ix+00fh),a		;97a8   ; IX+0F: su ancho en pixeles
	ret			;97ab
L_97AC:
	ld a,(ix+006h)		;97ac   ; vuelve atras y al paso 3
	add a,008h		;97af
	ld (ix+006h),a		;97b1
	ld (ix+001h),003h		;97b4
L_97B8:
	ret			;97b8

; ----------------------------------------------------------------------
; DATOS tabla_97B9: 4 bytes (IX+02 de 1 a 4: p02:976A lee 0x97B8 + IX+02 con
;   L_5CA6, y la 0 caeria en el codigo de delante); lo leen p02:9770 (4 bytes)
;   0x97b9..0x97bd  (4 bytes)
DATA_tabla_97B9:
	defb 010h,02eh,050h,06eh	; 97b9

; ======================================================================
; CODIGO 0x97bd..0x9998  (475 bytes)
; ======================================================================


fila_avanza:		; 8 pixeles a la izquierda; al tocar el mapa vuelve atras
	ld a,(ix+006h)		;97bd   ; 8 pixeles a la izquierda
	sub 008h		;97c0
	ld (ix+006h),a		;97c2
	jr z,L_97CD		;97c5
	call fila_toca_mapa		;97c7   ; toca el mapa?
	jr c,$-30		;97ca
	ret			;97cc
L_97CD:
	ld (ix+001h),002h		;97cd   ; al paso 2
	ret			;97d1
fila_encoge:		; un caracter menos (IX+14); sin ninguno, se va
	dec (ix+014h)		;97d2
	jr nz,$-51		;97d5
	jp 06514h		;97d7   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
fila_se_va:		; un caracter menos y con el scroll; sin ninguno, se va
	dec (ix+014h)		;97da   ; un caracter menos
	jp z,06514h		;97dd   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	call ancho_en_pixeles		;97e0   ; ancho_en_pixeles: IX+0F = IX+14 x 8
	ld a,(0e320h)		;97e3   ; con el scroll
	or a			;97e6
	ret z			;97e7
	ld a,(ix+006h)		;97e8
	sub 008h		;97eb
	ld (ix+006h),a		;97ed
	ret nz			;97f0
	jr L_97CD		;97f1
fila_toca_mapa:		; sin jefe, C si en su sitio hay mapa (de 1 a 0xE305)
	ld a,(0e340h)		;97f3   ; con jefe, nunca
	or a			;97f6
	ret nz			;97f7
	ld l,(ix+004h)		;97f8
	ld h,(ix+006h)		;97fb
	call 05c92h		;97fe   ; sitio_en_pantalla: HL = 0xED00 + el caracter de la pantalla de RAM bajo L (Y) y H (X)
	ld a,(hl)			;9801   ; vacio: no
	or a			;9802
	ret z			;9803
	ld hl,0e305h		;9804   ; de 1 a 0xE305
	cp (hl)			;9807
	ret			;9808
tipo_3b_empieza:		; el tipo 0x3B: el caracter 0xFA + (Y / 2) & 3
	ld c,0fah		;9809
	call caracter_por_y		;980b   ; caracter_por_y: IX+32 = C + (Y / 2) & 3
	jp fila_empieza		;980e   ; fila_empieza: IX+0C = 0, IX+10 = 1, 1 x 1 y la X a la rejilla de 8
tipo_3b:		; los tipos 0x3B y 0x3C: una fila que crece 4 caracteres por cuadro (IX+19 de largo) y luego se encoge
	ld a,(ix+001h)		;9811   ; el paso
	dec a			;9814
	jr z,L_9841		;9815
	dec a			;9817
	jr z,L_9852		;9818
	jp p,L_9840		;981a
	ld b,004h		;981d   ; 4 caracteres por cuadro
L_981F:
	ld a,(ix+006h)		;981f   ; 8 pixeles a la izquierda
	sub 008h		;9822
	ld (ix+006h),a		;9824
	jp z,L_983C		;9827
	inc (ix+014h)		;982a   ; uno mas
	dec (ix+019h)		;982d   ; hasta su largo
	jr z,L_9837		;9830
	djnz L_981F		;9832
	jp ancho_en_pixeles		;9834   ; ancho_en_pixeles: IX+0F = IX+14 x 8
L_9837:
	ld (ix+001h),001h		;9837   ; al paso 1
	ret			;983b
L_983C:
	ld (ix+001h),002h		;983c   ; al borde izquierdo: paso 2
L_9840:
	ret			;9840
L_9841:
	ld b,004h		;9841   ; paso 1: avanza 4 caracteres sin crecer
L_9843:
	ld a,(ix+006h)		;9843   ; 8 pixeles a la izquierda
	sub 008h		;9846
	ld (ix+006h),a		;9848
	jr z,L_983C		;984b   ; al borde izquierdo: paso 2
	djnz L_9843		;984d
	jp ancho_en_pixeles		;984f   ; ancho_en_pixeles: IX+0F = IX+14 x 8
L_9852:
	ld b,004h		;9852   ; paso 2: se encoge 4 por cuadro
L_9854:
	dec (ix+014h)		;9854   ; uno menos
	jp z,06514h		;9857   ; sin ninguno, se va
	djnz L_9854		;985a
	jp ancho_en_pixeles		;985c   ; ancho_en_pixeles: IX+0F = IX+14 x 8
tipo_3c_empieza:		; el tipo 0x3C: el caracter 0xF1, en la rejilla de 8
	ld a,0f1h		;985f
	call caracter_en_rejilla		;9861   ; caracter_en_rejilla: IX+32 = A y la Y a la rejilla de 8
	jp fila_empieza		;9864   ; fila_empieza: IX+0C = 0, IX+10 = 1, 1 x 1 y la X a la rejilla de 8
tipo_03_empieza:		; el tipo 3: hacia la izquierda (vx 0xFE80), sin velocidad propia, espera de disparo 8; con B, el dibujo 0xB4
	ld (ix+024h),006h		;9867   ; IX+24 = 6
	ld (ix+027h),000h		;986b
	res 2,(ix+010h)		;986f   ; sin velocidad propia
	call 04f1ch		;9873   ; vy = 0
	ld de,0fe80h		;9876   ; vx = 0xFE80: a la izquierda
	call 04f02h		;9879   ; pon_vx: IX+09/IX+0A = DE
	ld (ix+015h),008h		;987c   ; espera de disparo
	ld a,(ix+019h)		;9880   ; con B, el dibujo 0xB4
	and a			;9883
	ret z			;9884
	ld (ix+030h),0b4h		;9885
	ret			;9889
tipo_03:		; el tipo 3: anda por el suelo o el techo (IX+19 bit 0), salta los escalones, se da la vuelta y dispara (p11:BB44)
	call tipo_03_dibujo		;988a   ; su dibujo
	ld a,(ix+001h)		;988d   ; el paso
	dec a			;9890
	jr z,L_98CC		;9891
	dec a			;9893
	jr z,L_9904		;9894
	dec a			;9896
	jp z,L_9918		;9897
	ld bc,00408h		;989a   ; paso 0: busca suelo en 4 columnas, de 8 en 8
L_989D:
	push bc			;989d
	ld a,(ix+006h)		;989e
	sub c			;98a1
	ld h,a			;98a2
	ld a,(ix+004h)		;98a3
	bit 0,(ix+019h)		;98a6   ; en el techo (bit 0 de B) o en el suelo
	jr nz,L_98AE		;98aa
	add a,008h		;98ac
L_98AE:
	ld l,a			;98ae
	call toca_mapa_fase_1		;98af   ; toca_mapa_fase_1: C si en H (X), L (Y) o a su derecha hay mapa de 9 a 0x8A (0x67 fuera de la fase 1)
	pop bc			;98b2
	jr c,L_98C3		;98b3   ; encontrado: paso 3, con el scroll
	ld a,c			;98b5
	add a,008h		;98b6
	ld c,a			;98b8
	djnz L_989D		;98b9
	set 2,(ix+010h)		;98bb   ; sin suelo: se mueve solo y al paso 1
	inc (ix+001h)		;98bf
	ret			;98c2
L_98C3:
	ld (ix+001h),003h		;98c3
	set 3,(ix+010h)		;98c7
	ret			;98cb
L_98CC:
	call tipo_03_pared		;98cc   ; paso 1: pared delante, se da la vuelta
	call c,04f2ch		;98cf   ; invierte_vx: IX+09/IX+0A = - IX+09/IX+0A
	call tipo_03_suelo		;98d2   ; suelo?
	jr c,L_98F7		;98d5
	inc (ix+001h)		;98d7   ; sin suelo: al paso 2, guarda su vx
	ld d,(ix+00ah)		;98da
	ld e,(ix+009h)		;98dd
	ld (ix+026h),d		;98e0
	ld (ix+025h),e		;98e3
	ld hl,0fc00h		;98e6   ; y salta (vy 0xFC00 arriba o 0x0400 abajo)
	ld a,(ix+019h)		;98e9
	and a			;98ec
	jr nz,L_98F1		;98ed
	ld h,004h		;98ef
L_98F1:
	ld de,00100h		;98f1
	call 04f26h		;98f4   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
L_98F7:
	dec (ix+015h)		;98f7   ; la espera de disparo
	ret nz			;98fa
	call espera_disparo_por_nivel		;98fb   ; la siguiente
	ld (ix+015h),a		;98fe
	jp 0bb44h		;9901   ; p11:BB44: dispara
L_9904:
	call tipo_03_suelo		;9904   ; paso 2: en el aire hasta tocar suelo
	ret nc			;9907
	ld e,(ix+026h)		;9908   ; recupera su vx
	ld d,(ix+025h)		;990b
	call 04f02h		;990e   ; pon_vx: IX+09/IX+0A = DE
	ld (ix+001h),001h		;9911   ; paso 1 otra vez
	jp 04f1ch		;9915   ; vy_cero: IX+07/IX+08 = 0
L_9918:
	ld a,(ix+006h)		;9918   ; paso 3: hasta la X 0xC0
	cp 0c0h		;991b
	ret nz			;991d
	ld (ix+001h),001h		;991e   ; y de vuelta
	ld (ix+010h),007h		;9922
	jp 04f2ch		;9926   ; invierte_vx: IX+09/IX+0A = - IX+09/IX+0A
tipo_03_suelo:		; C si tiene suelo (o techo) debajo; si no, a caer (vx 0x0180)
	bit 0,(ix+019h)		;9929   ; debajo o encima segun su lado
	ld a,010h		;992d
	jr z,L_9933		;992f
	ld a,0ffh		;9931
L_9933:
	ld h,(ix+006h)		;9933
	add a,(ix+004h)		;9936
	ld l,a			;9939
	push hl			;993a
	call toca_mapa_fase_1		;993b   ; mapa?
	pop hl			;993e
	jr c,L_9956		;993f
	ld a,(ix+004h)		;9941   ; cerca del borde de abajo o de arriba
	add a,068h		;9944
	cp 071h		;9946
	jr nc,L_9956		;9948
L_994A:
	ld de,00180h		;994a   ; a caer: vx 0x0180
	call 04f02h		;994d   ; pon_vx: IX+09/IX+0A = DE
	scf			;9950
	ret			;9951
L_9952:
	cp 018h		;9952
	jr nc,L_994A		;9954
L_9956:
	ld a,h			;9956   ; y el caracter de la derecha
	add a,008h		;9957
	ld h,a			;9959
	jp toca_mapa_fase_1		;995a   ; toca_mapa_fase_1: C si en H (X), L (Y) o a su derecha hay mapa de 9 a 0x8A (0x67 fuera de la fase 1)
tipo_03_pared:		; C si delante (segun hacia donde va) hay mapa o el borde
	bit 0,(ix+019h)		;995d
	ld a,(ix+004h)		;9961   ; su Y, mas 8 en el suelo
	jr nz,L_9968		;9964
	add a,008h		;9966
L_9968:
	ld l,a			;9968
	ld a,(ix+006h)		;9969   ; a la izquierda o a la derecha
	bit 7,(ix+00ah)		;996c
	jr z,L_997B		;9970
	cp 008h		;9972   ; en el borde izquierdo: C
	ccf			;9974
	ret nc			;9975
	dec a			;9976   ; el caracter de la izquierda
	ld h,a			;9977
	jp toca_mapa_fase_1		;9978   ; toca_mapa_fase_1: C si en H (X), L (Y) o a su derecha hay mapa de 9 a 0x8A (0x67 fuera de la fase 1)
L_997B:
	add a,008h		;997b   ; el de la derecha
	ld h,a			;997d
	call toca_mapa_fase_1		;997e   ; toca_mapa_fase_1: C si en H (X), L (Y) o a su derecha hay mapa de 9 a 0x8A (0x67 fuera de la fase 1)
	ret c			;9981
	ld a,(ix+006h)		;9982   ; en el borde derecho: C
	cp 0f0h		;9985
	ccf			;9987
	ret			;9988
tipo_03_dibujo:		; el dibujo del tipo 3 (p02:9998 o p02:999C) segun su lado (p02:9B31)
	bit 0,(ix+019h)		;9989
	ld hl,09998h		;998d   ; en el suelo o en el techo
	jr z,L_9995		;9990
	ld hl,0999ch		;9992
L_9995:
	jp animacion_4		;9995   ; animacion_4: el dibujo de la tabla HL: un paso cada 4 cuadros (IX+24), 4 pasos

; ----------------------------------------------------------------------
; DATOS tabla_9998: dos tablas de 4 bytes (0x9998 y 0x999C) que p02:9989 pasa
;   a L_9B31 segun el bit 0 de IX+19; lo leen p02:9995 (8 bytes)
;   0x9998..0x99a0  (8 bytes)
DATA_tabla_9998:
	defb 0dch,0e0h,0e8h,0e4h	; 9998
	defb 0b4h,0b8h,0c0h,0bch	; 999c

; ======================================================================
; CODIGO 0x99a0..0x9aaa  (266 bytes)
; ======================================================================


tipo_08_empieza:		; el tipo 8: 34 cuadros; sin B, una direccion de salida al azar; con B, el dibujo 0xC4 y la direccion de B
	ld (ix+002h),022h		;99a0   ; 34 cuadros
	ld a,(ix+019h)		;99a4   ; con B, su direccion
	and a			;99a7
	jr nz,L_99C5		;99a8
	ld (ix+02ah),006h		;99aa   ; sin B: direccion 6, o 14 desde el borde izquierdo
	ld a,r		;99ae
	and 001h		;99b0
	jr z,L_99BC		;99b2
	ld (ix+02ah),00eh		;99b4
	ld (ix+006h),004h		;99b8
L_99BC:
	ld a,(ix+02ah)		;99bc   ; dos direcciones mas alla
	inc a			;99bf
	inc a			;99c0
	and 00fh		;99c1
	jr L_99EB		;99c3
L_99C5:
	ld (ix+030h),0c4h		;99c5   ; con B: el dibujo 0xC4
	inc (ix+001h)		;99c9
	ld a,(ix+019h)		;99cc   ; su direccion, de B
	bit 7,a		;99cf
	jr z,L_99D4		;99d1
	xor a			;99d3
L_99D4:
	ld (ix+026h),018h		;99d4   ; 24 cuadros
	jr L_99EF		;99d8
rumbo_al_azar_cerca:		; una direccion al azar cerca de IX+2A (0-3 mas)
	call 0637bh		;99da   ; cerca de IX+2A
	and 003h		;99dd   ; 0-3
	add a,(ix+02ah)		;99df
	and 00fh		;99e2
	jr L_99EB		;99e4
rumbo_al_azar:		; una direccion al azar (0-15)
	call 0637bh		;99e6   ; azar_rapido: A = R rotado XOR la cuenta de cuadros
	and 00fh		;99e9
L_99EB:
	ld (ix+026h),010h		;99eb   ; 16 cuadros
L_99EF:
	ld (ix+025h),a		;99ef   ; la direccion
	ld c,a			;99f2
	ld a,(0e228h)		;99f3   ; rapidez 1, 2 del nivel 6
	ld b,001h		;99f6
	cp 006h		;99f8
	jr c,L_99FD		;99fa
	inc b			;99fc
L_99FD:
	ld a,c			;99fd
	call 04cb7h		;99fe   ; la velocidad de esa direccion
	jp 04f26h		;9a01   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
tipo_0c_empieza:		; el tipo 0x0C: espera 32 cuadros quieto (IX+27), animacion de 4
	ld (ix+027h),020h		;9a04   ; espera 32
	ld (ix+024h),004h		;9a08   ; animacion de 4
	ld (ix+028h),000h		;9a0c   ; quieto
	jp 04f17h		;9a10   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
tipo_08:		; el tipo 8: parpadea, rebota arriba y abajo; al acabar su espera se parte en dos tipo 8 y luego se para y sale hacia la nave, una y otra vez
	ld a,(ix+031h)		;9a13   ; parpadea
	xor 005h		;9a16
	ld (ix+031h),a		;9a18
	call rebota_arriba_abajo		;9a1b   ; rebota y su dibujo
	call tipo_08_dibujo		;9a1e   ; tipo_08_dibujo: el dibujo segun la espera (0xB4, 0xB8, 0xBC, 0xC0) o, partido, de 0xC4 a 0xD8 cada 4 cuadros
	ld a,(ix+001h)		;9a21   ; el paso
	dec a			;9a24
	jr z,L_9A74		;9a25
	dec a			;9a27
	jr z,L_9A8A		;9a28
	dec (ix+002h)		;9a2a   ; paso 0: espera
	jr nz,L_9A6D		;9a2d
	ld c,000h		;9a2f   ; se parte: un tipo 8 en su direccion + 2
	ld d,(ix+006h)		;9a31
	ld e,(ix+004h)		;9a34
	ld a,(ix+025h)		;9a37
	add a,002h		;9a3a
	and 00fh		;9a3c
	jr nz,L_9A42		;9a3e
	ld a,080h		;9a40
L_9A42:
	ld b,a			;9a42
	ld a,008h		;9a43   ; el tipo 8
	push de			;9a45
	push bc			;9a46
	call 04d16h		;9a47   ; crea_enemigo_ix: crea_enemigo conservando IX
	pop bc			;9a4a
	pop de			;9a4b
	ld a,b			;9a4c   ; y otro en la direccion - 4
	sub 004h		;9a4d
	and 00fh		;9a4f
	jr nz,L_9A55		;9a51
	ld a,080h		;9a53
L_9A55:
	ld b,a			;9a55
	ld a,008h		;9a56   ; el otro
	ld c,000h		;9a58
	call 04d16h		;9a5a   ; crea_enemigo_ix: crea_enemigo conservando IX
	ld (ix+030h),0c4h		;9a5d   ; partido
	inc (ix+001h)		;9a61
	ld (ix+019h),0ffh		;9a64   ; IX+19 = 0xFF
	ld (ix+026h),010h		;9a68   ; 16 cuadros
	ret			;9a6c
L_9A6D:
	dec (ix+026h)		;9a6d   ; cada 16 cuadros, otra direccion cerca
	ret nz			;9a70
	jp rumbo_al_azar_cerca		;9a71   ; rumbo_al_azar_cerca: una direccion al azar cerca de IX+2A (0-3 mas)
L_9A74:
	ld a,(ix+019h)		;9a74   ; paso 1: sin dato, cambia de direccion
	or a			;9a77
	jr z,L_9A6D		;9a78
	dec (ix+026h)		;9a7a
	ret nz			;9a7d
	res 2,(ix+010h)		;9a7e   ; se para y al paso 2
	inc (ix+001h)		;9a82
	ld (ix+026h),008h		;9a85
	ret			;9a89
L_9A8A:
	dec (ix+026h)		;9a8a   ; paso 2: espera 8
	ret nz			;9a8d
	dec (ix+001h)		;9a8e   ; vuelve a moverse, 40 cuadros
	set 2,(ix+010h)		;9a91
	ld (ix+026h),028h		;9a95
	ld a,(0e228h)		;9a99   ; hacia la nave con la rapidez de p02:9AAA
	srl a		;9a9c
	srl a		;9a9e
	ld hl,09aaah		;9aa0
	call 0407ah		;9aa3   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;9aa6
	jp 04ecah		;9aa7   ; rumbo_ix_93e9: IX+07-IX+0A con p02:93E9 desde IX+04/IX+06

; ----------------------------------------------------------------------
; DATOS tabla_9AAA: 4 bytes que p02:9A99 lee con 0xE228 / 4; lo leen p02:9AA3
;   (4 bytes)
;   0x9aaa..0x9aae  (4 bytes)
DATA_tabla_9AAA:
	defb 020h,030h,040h,050h	; 9aaa

; ======================================================================
; CODIGO 0x9aae..0x9b48  (154 bytes)
; ======================================================================


rebota_arriba_abajo:		; da la vuelta a la velocidad Y en los bordes de arriba (8) y abajo (0xA0)
	bit 7,(ix+008h)		;9aae   ; subiendo: en el borde de arriba, baja
	ld a,(ix+004h)		;9ab2
	jr z,L_9ABD		;9ab5
	cp 008h		;9ab7
	jp c,04f3ch		;9ab9   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
	ret			;9abc
L_9ABD:
	cp 0a0h		;9abd   ; bajando: en el de abajo, sube
	jp nc,04f3ch		;9abf   ; invierte_vy: IX+07/IX+08 = - IX+07/IX+08
	ret			;9ac2
tipo_08_dibujo:		; el dibujo segun la espera (0xB4, 0xB8, 0xBC, 0xC0) o, partido, de 0xC4 a 0xD8 cada 4 cuadros
	ld a,(ix+001h)		;9ac3   ; partido: otra animacion
	or a			;9ac6
	jr nz,L_9AE4		;9ac7
	ld b,0b4h		;9ac9   ; 0xB4 con mas de 20 cuadros
	ld a,(ix+002h)		;9acb
	cp 014h		;9ace
	jr nc,L_9AE0		;9ad0
	ld b,0b8h		;9ad2   ; 0xB8 con 15 o mas
	cp 00fh		;9ad4
	jr nc,L_9AE0		;9ad6
	ld b,0bch		;9ad8   ; 0xBC con 4 o mas
	cp 004h		;9ada
	jr nc,L_9AE0		;9adc
	ld b,0c0h		;9ade   ; 0xC0 al final
L_9AE0:
	ld (ix+030h),b		;9ae0
	ret			;9ae3
L_9AE4:
	ld a,(0e1c3h)		;9ae4   ; cada 4 cuadros
	and 003h		;9ae7
	ret nz			;9ae9
	ld a,(ix+030h)		;9aea
	add a,004h		;9aed   ; el siguiente dibujo
	cp 0dch		;9aef
	jr nz,L_9AF5		;9af1
	ld a,0c4h		;9af3   ; despues de 0xD8, otra vez 0xC4
L_9AF5:
	ld (ix+030h),a		;9af5
	ret			;9af8
tipo_0c:		; el tipo 0x0C: va hacia la izquierda con el scroll; tras su espera, a ratos sale en una direccion al azar y se para
	dec (ix+006h)		;9af9   ; con el scroll
	call tipo_0c_dibujo		;9afc   ; tipo_0c_dibujo: la animacion de p02:9B48
	ld a,(ix+001h)		;9aff
	dec a			;9b02
	jr z,L_9B14		;9b03
	dec a			;9b05
	jr z,L_9B1F		;9b06
	dec (ix+027h)		;9b08   ; paso 0: la espera
	ret nz			;9b0b
	ld (ix+026h),001h		;9b0c
	inc (ix+001h)		;9b10
	ret			;9b13
L_9B14:
	dec (ix+026h)		;9b14   ; paso 1: una direccion al azar
	ret nz			;9b17
	call rumbo_al_azar		;9b18   ; rumbo_al_azar: una direccion al azar (0-15)
	inc (ix+001h)		;9b1b
	ret			;9b1e
L_9B1F:
	dec (ix+026h)		;9b1f   ; paso 2: se para 8 cuadros
	ret nz			;9b22
	ld (ix+026h),008h		;9b23
	call 04f17h		;9b27   ; vx_cero_y_vy: IX+09/IX+0A = 0 y luego IX+07/IX+08 = DE
	dec (ix+001h)		;9b2a
	ret			;9b2d
tipo_0c_dibujo:		; la animacion de p02:9B48
	ld hl,09b48h		;9b2e
animacion_4:		; el dibujo de la tabla HL: un paso cada 4 cuadros (IX+24), 4 pasos
	ld c,000h		;9b31
animacion_c:		; lo mismo, cada 8 cuadros con C = 1
	dec (ix+024h)		;9b33   ; un paso cada 4 cuadros
	ld a,(ix+024h)		;9b36   ; cada 8 cuadros
	rra			;9b39
	rra			;9b3a
	dec c			;9b3b
	jr nz,L_9B3F		;9b3c
	rra			;9b3e
L_9B3F:
	and 003h		;9b3f   ; 4 pasos
	call 05ca6h		;9b41   ; byte_a: A = el byte A de la tabla HL
	ld (ix+030h),a		;9b44
	ret			;9b47

; ----------------------------------------------------------------------
; DATOS tabla_9B48: 4 bytes que p02:9B2E pasa a L_9B31; lo leen p02:9B2E (4
;   bytes)
;   0x9b48..0x9b4c  (4 bytes)
DATA_tabla_9B48:
	defb 0c4h,0c8h,0cch,0c8h	; 9b48

; ======================================================================
; CODIGO 0x9b4c..0x9b98  (76 bytes)
; ======================================================================


tipo_09_empieza:		; el tipo 9: hacia la izquierda (vx 0xFD00), espera de disparo 8
	ld (ix+02bh),008h		;9b4c   ; espera de disparo
	ld de,0fd00h		;9b50   ; vx 0xFD00
	call 04f02h		;9b53   ; pon_vx: IX+09/IX+0A = DE
	jp 04f1ch		;9b56   ; vy_cero: IX+07/IX+08 = 0
tipo_09:		; el tipo 9: animado, dispara y se acerca en vertical a la nave
	call tipo_09_dibujo		;9b59   ; tipo_09_dibujo: 7 dibujos de p02:9B98 (p02:9B9F en la fase 4), uno cada 4 cuadros
	call 06770h		;9b5c   ; dispara_al_acabar: IX+15 - 1 y, al llegar a 0, p01:6774
	call tipo_09_dispara		;9b5f   ; tipo_09_dispara: con la nave delante, al acabar IX+2B dispara (p11:BB44)
hacia_la_y_de_la_nave:		; la velocidad Y + o - 0x16 hacia la Y de la nave
	ld a,(0e404h)		;9b62   ; por encima o por debajo de la nave
	ld de,00016h		;9b65
	cp (ix+004h)		;9b68
	call c,05cadh		;9b6b   ; menos_de: DE = - DE
	ex de,hl			;9b6e
	call 04f10h		;9b6f   ; mas la velocidad Y
	add hl,de			;9b72
	ex de,hl			;9b73
	jp 04efbh		;9b74   ; pon_vy: IX+07/IX+08 = DE
tipo_09_dispara:		; con la nave delante, al acabar IX+2B dispara (p11:BB44)
	ld a,(0e406h)		;9b77   ; la nave por delante?
	cp (ix+006h)		;9b7a
	ret c			;9b7d
	dec (ix+02bh)		;9b7e
	ret nz			;9b81
	jp 0bb44h		;9b82   ; dispara
tipo_09_dibujo:		; 7 dibujos de p02:9B98 (p02:9B9F en la fase 4), uno cada 4 cuadros
	ld hl,09b98h		;9b85
	ld a,(0e201h)		;9b88   ; lee la fase (0-11)
	cp 004h		;9b8b
	jr nz,L_9B92		;9b8d   ; en la fase 4, otra animacion
	ld hl,09b9fh		;9b8f
L_9B92:
	ld bc,00307h		;9b92   ; 7 pasos, cada 4 cuadros
	jp 06361h		;9b95   ; anima: cada (0xE1C3 & B) = 0, IX+26 + 1 (de 0 a C - 1) y el dibujo IX+30 = IX+32 = HL[IX+26]

; ----------------------------------------------------------------------
; DATOS tabla_9B98: dos tablas de 7 bytes (0x9B98, y 0x9B9F en la fase 4) que
;   p02:9B85 pasa a L_6361; lo leen p02:9B92 (14 bytes)
;   0x9b98..0x9ba6  (14 bytes)
DATA_tabla_9B98:
	defb 0a4h,0a8h,0ach,0b0h,0ach,0a8h,0a4h	; 9b98
	defb 074h,078h,07ch,080h,07ch,078h,074h	; 9b9f

; ======================================================================
; CODIGO 0x9ba6..0x9bc1  (27 bytes)
; ======================================================================


tipo_0d_empieza:		; el tipo 0x0D: hacia la nave con la rapidez de p02:9BC1 segun el nivel; en la fase 4 el dibujo 0x84
	ld a,(0e201h)		;9ba6   ; lee la fase (0-11)
	cp 004h		;9ba9
	jr nz,sale_hacia_la_nave		;9bab
	ld (ix+030h),084h		;9bad
sale_hacia_la_nave:		; la velocidad hacia la nave con la rapidez de p02:9BC1 (nivel / 4)
	ld a,(0e228h)		;9bb1   ; la rapidez segun el nivel / 4
	srl a		;9bb4
	srl a		;9bb6
	ld hl,09bc1h		;9bb8
	call 05ca6h		;9bbb   ; byte_a: A = el byte A de la tabla HL
	jp 04ecah		;9bbe   ; hacia la nave

; ----------------------------------------------------------------------
; DATOS tabla_9BC1: 4 bytes que p02:9BB1 lee con 0xE228 / 4; lo leen p02:9BBB
;   (4 bytes)
;   0x9bc1..0x9bc5  (4 bytes)
DATA_tabla_9BC1:
	defb 070h,090h,0a0h,0c0h	; 9bc1

; ======================================================================
; CODIGO 0x9bc5..0x9beb  (38 bytes)
; ======================================================================


tipo_0d:		; el tipo 0x0D: 6 dibujos de p02:9BEB (p02:9BF1 en la fase 4), uno cada 4 cuadros
	ld a,(0e1c3h)		;9bc5   ; cada 4 cuadros
	and 003h		;9bc8
	ret nz			;9bca
	ld hl,09bebh		;9bcb
	ld a,(0e201h)		;9bce   ; lee la fase (0-11)
	cp 004h		;9bd1
	jr nz,L_9BD8		;9bd3
	ld hl,09bf1h		;9bd5
L_9BD8:
	ld a,(ix+025h)		;9bd8   ; 6 pasos
	inc a			;9bdb
	cp 006h		;9bdc
	jr c,L_9BE1		;9bde
	xor a			;9be0
L_9BE1:
	ld (ix+025h),a		;9be1
	call 05ca6h		;9be4   ; byte_a: A = el byte A de la tabla HL
	ld (ix+030h),a		;9be7
	ret			;9bea

; ----------------------------------------------------------------------
; DATOS tabla_9BEB: dos tablas de 6 bytes (0x9BEB, y 0x9BF1 en la fase 4) que
;   p02:9BCB lee con IX+25; lo leen p02:9BD8 (12 bytes)
;   0x9beb..0x9bf7  (12 bytes)
DATA_tabla_9BEB:
	defb 0b4h,0b8h,0bch,0c0h,0bch,0b8h	; 9beb
	defb 084h,088h,08ch,090h,08ch,088h	; 9bf1

; ======================================================================
; CODIGO 0x9bf7..0x9c3c  (69 bytes)
; ======================================================================


tipo_0f_empieza:		; el tipo 0x0F: hacia la izquierda (vx 0xFE80) y hacia el centro (vy 0x0800 o 0xF800)
	ld de,0fe80h		;9bf7   ; vx 0xFE80
	call 04f02h		;9bfa   ; pon_vx: IX+09/IX+0A = DE
	ld de,00800h		;9bfd   ; hacia abajo, o hacia arriba si esta abajo
	ld a,(ix+004h)		;9c00
	cp 060h		;9c03
	jr c,L_9C09		;9c05
	ld d,0f8h		;9c07
L_9C09:
	jp 04efbh		;9c09   ; pon_vy: IX+07/IX+08 = DE
tipo_0f:		; el tipo 0x0F: al llegar a Y 0x48 se queda oscilando alrededor; del nivel 6 en adelante dispara
	call dispara_por_nivel		;9c0c   ; dispara_por_nivel: del nivel 6 en adelante, al acabar IX+15 dispara (p11:BB44) y la espera de nuevo
	call tipo_0f_dibujo		;9c0f   ; tipo_0f_dibujo: la animacion de p02:9C3C
	ld a,(ix+001h)		;9c12   ; paso 0: hasta Y 0x48
	dec a			;9c15
	jr z,L_9C22		;9c16
	ld a,048h		;9c18
	cp (ix+004h)		;9c1a
	ret nz			;9c1d
	inc (ix+001h)		;9c1e
	ret			;9c21
L_9C22:
	ld de,00080h		;9c22   ; paso 1: oscila alrededor de 0x48
	ld a,048h		;9c25
oscila_en_y:		; la velocidad Y + o - DE hacia la Y A
	cp (ix+004h)		;9c27   ; por encima o por debajo
	call c,05cadh		;9c2a   ; menos_de: DE = - DE
	ex de,hl			;9c2d
	call 04f10h		;9c2e   ; lee_vy: DE = IX+07/IX+08
	add hl,de			;9c31
	ex de,hl			;9c32
	jp 04efbh		;9c33   ; pon_vy: IX+07/IX+08 = DE
tipo_0f_dibujo:		; la animacion de p02:9C3C
	ld hl,09c3ch		;9c36
	jp animacion_4		;9c39   ; animacion_4: el dibujo de la tabla HL: un paso cada 4 cuadros (IX+24), 4 pasos

; ----------------------------------------------------------------------
; DATOS tabla_9C3C: 4 bytes que p02:9C36 pasa a L_9B31; lo leen p02:9C36 (4
;   bytes)
;   0x9c3c..0x9c40  (4 bytes)
DATA_tabla_9C3C:
	defb 0f4h,0f8h,0f4h,0f8h	; 9c3c

; ======================================================================
; CODIGO 0x9c40..0x9c87  (71 bytes)
; ======================================================================


dispara_por_nivel:		; del nivel 6 en adelante, al acabar IX+15 dispara (p11:BB44) y la espera de nuevo
	ld a,(0e228h)		;9c40   ; del nivel 6 en adelante
	cp 006h		;9c43
	ret c			;9c45
	dec (ix+015h)		;9c46
	ret nz			;9c49
	call 04e93h		;9c4a   ; la espera, al azar
	jp 0bb44h		;9c4d
tipo_14_empieza:		; el tipo 0x14: 32 cuadros sin tocar a la nave, ya con su velocidad hacia ella
	ld (ix+025h),020h		;9c50   ; 32 cuadros
	ld (ix+010h),002h		;9c54   ; todavia no toca a la nave
	jp sale_hacia_la_nave		;9c58   ; sale_hacia_la_nave: la velocidad hacia la nave con la rapidez de p02:9BC1 (nivel / 4)
tipo_14:		; el tipo 0x14: parpadea (p02:9C87) mientras espera; luego color 5 y ya toca
	ld a,(ix+001h)		;9c5b   ; paso 0
	and a			;9c5e
	ret nz			;9c5f
	dec (ix+025h)		;9c60   ; la espera
	jr nz,L_9C71		;9c63
	inc (ix+001h)		;9c65   ; acabada: color 5 y toca
	ld (ix+031h),005h		;9c68
	ld (ix+010h),007h		;9c6c
	ret			;9c70
L_9C71:
	ld hl,09c87h		;9c71   ; parpadea: el color de p02:9C87
	ld a,(ix+027h)		;9c74
	inc a			;9c77
	cp 006h		;9c78
	jr c,L_9C7D		;9c7a
	xor a			;9c7c
L_9C7D:
	ld (ix+027h),a		;9c7d
	call 05ca6h		;9c80   ; byte_a: A = el byte A de la tabla HL
	ld (ix+031h),a		;9c83
	ret			;9c86

; ----------------------------------------------------------------------
; DATOS tabla_9C87: 6 bytes que p02:9C71 lee con IX+27 (de 0 a 5); lo leen
;   p02:9C80 (6 bytes)
;   0x9c87..0x9c8d  (6 bytes)
DATA_tabla_9C87:
	defb 004h,005h,007h,00fh,007h,005h	; 9c87

; ======================================================================
; CODIGO 0x9c8d..0x9cbb  (46 bytes)
; ======================================================================


tipo_11_empieza:		; el tipo 0x11: hacia la izquierda (vx 0xFC00, 0xFA00 del nivel 6) y su espera de disparo
	ld (ix+024h),008h		;9c8d   ; animacion de 8
	ld (ix+02bh),000h		;9c91
	ld a,(0e228h)		;9c95   ; vx 0xFA00 del nivel 6, si no 0xFC00
	cp 006h		;9c98
	ld de,0fa00h		;9c9a
	jr nc,L_9CA1		;9c9d
	ld d,0fch		;9c9f
L_9CA1:
	ld (ix+02ah),d		;9ca1
	call 04f02h		;9ca4   ; pon_vx: IX+09/IX+0A = DE
	call 04f1ch		;9ca7   ; vy_cero: IX+07/IX+08 = 0
espera_de_disparo_11:		; IX+2C = p02:9CBB segun el nivel / 4
	ld a,(0e228h)		;9caa   ; la espera segun el nivel / 4
	srl a		;9cad
	srl a		;9caf
	ld hl,09cbbh		;9cb1
	call 05ca6h		;9cb4   ; byte_a: A = el byte A de la tabla HL
	ld (ix+02ch),a		;9cb7
	ret			;9cba

; ----------------------------------------------------------------------
; DATOS tabla_9CBB: 4 bytes que p02:9CAA lee con 0xE228 / 4; lo leen p02:9CB4
;   (4 bytes)
;   0x9cbb..0x9cbf  (4 bytes)
DATA_tabla_9CBB:
	defb 028h,020h,018h,010h	; 9cbb

; ======================================================================
; CODIGO 0x9cbf..0x9d63  (164 bytes)
; ======================================================================


tipo_11:		; el tipo 0x11: avanza, a la X de p02:9D6B da una vuelta (16 direcciones) y sigue, y luego acelera hacia la izquierda; dispara
	ld a,(ix+006h)		;9cbf   ; en el borde izquierdo, se va
	cp 008h		;9cc2
	jp c,06514h		;9cc4   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	call tipo_11_dispara		;9cc7   ; dispara
	ld hl,09d63h		;9cca   ; su animacion (p02:9D67 en la fase 5)
	ld a,(0e201h)		;9ccd   ; lee la fase (0-11)
	cp 005h		;9cd0
	jr nz,L_9CD7		;9cd2
	ld hl,09d67h		;9cd4
L_9CD7:
	ld c,001h		;9cd7
	call animacion_c		;9cd9   ; animacion_c: lo mismo, cada 8 cuadros con C = 1
	ld a,(ix+001h)		;9cdc   ; el paso
	dec a			;9cdf
	jr z,L_9D16		;9ce0
	dec a			;9ce2
	jr z,L_9D4D		;9ce3
	ld hl,09d6bh		;9ce5   ; paso 0: hasta la X de la vuelta (p02:9D6B)
	ld a,(ix+02bh)		;9ce8
	ld c,a			;9ceb
	call 05ca6h		;9cec   ; byte_a: A = el byte A de la tabla HL
	cp (ix+006h)		;9cef
	ret c			;9cf2
	inc c			;9cf3   ; la vuelta siguiente
	ld (ix+02bh),c		;9cf4
	inc (ix+001h)		;9cf7
	ld a,(ix+004h)		;9cfa   ; gira hacia abajo o hacia arriba segun la Y
	cp 058h		;9cfd
	ld a,001h		;9cff
	jr c,L_9D05		;9d01
	ld a,0ffh		;9d03
L_9D05:
	ld (ix+028h),a		;9d05
	ld (ix+002h),002h		;9d08   ; un paso cada 2 cuadros
	ld a,008h		;9d0c   ; desde la direccion 8, rapidez 4
	ld b,004h		;9d0e
	ld (ix+027h),a		;9d10
	jp 04cb7h		;9d13   ; velocidad_en_direccion: para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
L_9D16:
	dec (ix+002h)		;9d16   ; paso 1: la vuelta
	ret nz			;9d19
	ld (ix+002h),002h		;9d1a
	ld a,(ix+027h)		;9d1e   ; la siguiente direccion
	add a,(ix+028h)		;9d21
	and 00fh		;9d24
	cp 008h		;9d26   ; vuelta completa
	jr z,L_9D35		;9d28
	ld (ix+027h),a		;9d2a
	ld b,004h		;9d2d
	call 04cb7h		;9d2f   ; velocidad_en_direccion: para la direccion A (0-15) y la rapidez B: HL = B x p00:4CF6[A] y DE = B x p00:4CD6[A]
	jp 04f26h		;9d32   ; pon_vx_y_vy: IX+09/IX+0A = DE y IX+07/IX+08 = HL
L_9D35:
	call 04f1ch		;9d35   ; sigue recto con su vx
	ld d,(ix+02ah)		;9d38
	ld e,000h		;9d3b
	call 04f02h		;9d3d   ; pon_vx: IX+09/IX+0A = DE
	ld (ix+001h),e		;9d40
	ld a,(ix+02bh)		;9d43   ; tras la ultima vuelta, al paso 2
	dec a			;9d46
	ret z			;9d47
	ld (ix+001h),002h		;9d48
	ret			;9d4c
L_9D4D:
	ld de,0ffc8h		;9d4d   ; paso 2: acelera hacia la izquierda
suma_a_vx:		; la velocidad X + DE
	ex de,hl			;9d50
	call 04f09h		;9d51   ; lee_vx: DE = IX+09/IX+0A
	add hl,de			;9d54
	ex de,hl			;9d55
	jp 04f02h		;9d56   ; pon_vx: IX+09/IX+0A = DE
tipo_11_dispara:		; al acabar IX+2C, dispara (p11:BB44) y la espera de nuevo
	dec (ix+02ch)		;9d59   ; la espera de disparo
	ret nz			;9d5c
	call espera_de_disparo_11		;9d5d   ; dispara
	jp 0bb44h		;9d60

; ----------------------------------------------------------------------
; DATOS tablas_9D63: dos tablas de 4 bytes (0x9D63, y 0x9D67 en la fase 5) que
;   p02:9CCA lee, y 2 bytes en 0x9D6B que lee p02:9CE5; lo leen p02:9CCA (10
;   bytes)
;   0x9d63..0x9d6d  (10 bytes)
DATA_tablas_9D63:
	defb 0ech,0f0h,0f4h,0f0h	; 9d63
	defb 0a4h,0a8h,0ach,0a8h	; 9d67
	defb 090h,068h	; 9d6b

; ======================================================================
; CODIGO 0x9d6d..0x9f18  (427 bytes)
; ======================================================================


tipo_05_empieza:		; el tipo 5: arriba o abajo (dibujo 0x98 o 0x8C), hacia la derecha (vx 0x0200) y una espera al azar
	ld a,(ix+004h)		;9d6d   ; arriba o abajo
	cp 060h		;9d70
	ld bc,00098h		;9d72
	jr c,L_9D7A		;9d75
	ld bc,0018ch		;9d77
L_9D7A:
	ld (ix+027h),b		;9d7a
	ld (ix+030h),c		;9d7d
	ld (ix+025h),00ah		;9d80   ; 10
	call 04f1ch		;9d84   ; vy 0, vx 0x0200
	ld de,00200h		;9d87
	call 04f02h		;9d8a   ; pon_vx: IX+09/IX+0A = DE
espera_al_azar_2d:		; IX+02 = de 0x2D a 0x4C al azar
	ld a,r		;9d8d   ; 0x2D-0x4C
	and 01fh		;9d8f
	add a,02dh		;9d91
	ld (ix+002h),a		;9d93
	ret			;9d96
tipo_05:		; el tipo 5: anda, se para y dispara, y se va cuando toca (p01:6311)
	call tipo_05_tocado_fase_0		;9d97   ; tocado?
	jp c,L_893A		;9d9a
	call tipo_05_tapado		;9d9d   ; se ha salido?
	jp c,06514h		;9da0   ; quita_enemigo: quita el enemigo IX: uno menos (0xE352), devuelve sus sprites (0xE355), 0xE36D si es 0x2A, y descuenta su grupo (IX+16, IX+17, p02:89A8)
	ld a,(ix+001h)		;9da3   ; el paso
	dec a			;9da6
	jr z,L_9DE1		;9da7
	jp p,tipo_05_se_va		;9da9   ; tipo_05_se_va: animado y pegado al suelo mientras se va
	call 06311h		;9dac   ; paso 0: hora de irse?
	jr c,L_9DD3		;9daf
	dec (ix+002h)		;9db1   ; la espera
	jr z,L_9DBC		;9db4
	call pegado_al_suelo		;9db6   ; anda
	jp tipo_05_dibujo		;9db9   ; tipo_05_dibujo: la animacion de p02:9F18 segun hacia donde va y su lado
L_9DBC:
	inc (ix+001h)		;9dbc   ; al paso 1: 90 cuadros quieto
	ld (ix+002h),05ah		;9dbf
	call tipo_05_mira		;9dc3   ; tipo_05_mira: el dibujo mirando a la nave (0x94/0x88 arriba, 0xA0/0x7C abajo)
	call pegado_al_suelo_1		;9dc6   ; pegado_al_suelo_1: p02:9E1C con 0xE366 = 1 (sigue buscando hasta tocar)
	call espera_disparo_por_nivel		;9dc9   ; espera_disparo_por_nivel: IX+15 = 60 - 2 x nivel
	ld (ix+010h),00bh		;9dcc   ; IX+10 = 0x0B
	jp 04f21h		;9dd0   ; vx_cero: IX+09/IX+0A = 0
L_9DD3:
	ld (ix+010h),007h		;9dd3   ; se va hacia la izquierda (vx 0xFE00)
	ld (ix+001h),002h		;9dd7
	ld de,0fe00h		;9ddb
	jp 04f02h		;9dde   ; pon_vx: IX+09/IX+0A = DE
L_9DE1:
	call 06311h		;9de1   ; paso 1
	jr c,L_9DD3		;9de4
	dec (ix+002h)		;9de6   ; la espera
	jr z,L_9DF6		;9de9
	call tipo_05_dispara		;9deb   ; tipo_05_dispara: al acabar IX+15, su dibujo y, si la nave esta de su lado y en angulo, dispara
	ld a,(0e201h)		;9dee   ; lee la fase (0-11)
	or a			;9df1
	ret nz			;9df2
	jp pegado_al_suelo		;9df3   ; pegado_al_suelo: sube o baja (segun su lado, IX+27 bit 0) hasta quedar pegado al mapa; si no hay, da la vuelta
L_9DF6:
	ld a,(0e406h)		;9df6   ; hacia donde esta la nave
	cp (ix+006h)		;9df9
	ld de,00200h		;9dfc   ; a la derecha
	jr nc,L_9E04		;9dff
	ld de,0fe00h		;9e01   ; o a la izquierda
L_9E04:
	call 04f02h		;9e04   ; pon_vx: IX+09/IX+0A = DE
tipo_05_anda:		; IX+10 = 7, paso 0 y otra espera al azar
	ld (ix+010h),007h		;9e07   ; anda
	ld (ix+001h),000h		;9e0b
	jp espera_al_azar_2d		;9e0f   ; espera_al_azar_2d: IX+02 = de 0x2D a 0x4C al azar
tipo_05_se_va:		; animado y pegado al suelo mientras se va
	call tipo_05_dibujo		;9e12   ; tipo_05_dibujo: la animacion de p02:9F18 segun hacia donde va y su lado
	jr pegado_al_suelo		;9e15
pegado_al_suelo_1:		; p02:9E1C con 0xE366 = 1 (sigue buscando hasta tocar)
	ld a,001h		;9e17
	jr L_9E1C		;9e19
pegado_al_suelo:		; sube o baja (segun su lado, IX+27 bit 0) hasta quedar pegado al mapa; si no hay, da la vuelta
	xor a			;9e1b
L_9E1C:
	ld (0e366h),a		;9e1c   ; guarda la marca de buscar suelo
	ld a,(ix+004h)		;9e1f   ; guarda la Y
	ld (ix+028h),a		;9e22
	bit 0,(ix+027h)		;9e25   ; en el techo o en el suelo
	jr z,L_9E74		;9e29
L_9E2B:
	ld h,(ix+006h)		;9e2b   ; mira debajo
	ld a,(ix+004h)		;9e2e
	add a,010h		;9e31
	ld l,a			;9e33
	call toca_mapa_e305		;9e34   ; toca_mapa_e305: C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305); el sitio en 0xE3BC
	jr nc,L_9E62		;9e37   ; nada: baja
L_9E39:
	ld hl,(0e3bch)		;9e39   ; mapa: sube mientras siga habiendo
	ld bc,0ffe0h		;9e3c
	add hl,bc			;9e3f
	ld (0e3bch),hl		;9e40   ; guarda el sitio del ultimo choque con el mapa y el byte siguiente (16 bits)
	call toca_mapa_e305_de		;9e43   ; toca_mapa_e305_de: lo mismo desde el sitio HL
	ret nc			;9e46
	ld a,(ix+004h)		;9e47
	sub 008h		;9e4a
	ld (ix+004h),a		;9e4c
	cp 010h		;9e4f   ; hasta arriba
	jr nc,L_9E39		;9e51
L_9E53:
	call 062fbh		;9e53   ; sin sitio: da la vuelta, a la Y de antes
	ld (ix+025h),005h		;9e56
	ld a,(ix+028h)		;9e5a
	ld (ix+004h),a		;9e5d
	jr tipo_05_anda		;9e60
L_9E62:
	ld a,(ix+004h)		;9e62   ; baja 8, hasta 0x98
	cp 098h		;9e65
	ret nc			;9e67
	add a,008h		;9e68
	ld (ix+004h),a		;9e6a
	ld a,(0e366h)		;9e6d   ; buscando, otra vez
	or a			;9e70
	jr nz,L_9E2B		;9e71
	ret			;9e73
L_9E74:
	ld h,(ix+006h)		;9e74   ; en el techo: mira su sitio
	ld l,(ix+004h)		;9e77
	call toca_mapa_e305		;9e7a   ; toca_mapa_e305: C si en H (X), L (Y) o a su derecha hay mapa (hasta 0xE305); el sitio en 0xE3BC
	jr nc,L_9E8D		;9e7d
	ld a,(ix+004h)		;9e7f   ; mapa: baja, hasta 0x80
	add a,008h		;9e82
	ld (ix+004h),a		;9e84
	cp 080h		;9e87
	jr c,L_9E74		;9e89
	jr L_9E53		;9e8b
L_9E8D:
	ld hl,(0e3bch)		;9e8d   ; nada: sube hasta tocar
	ld bc,0ffe0h		;9e90
	add hl,bc			;9e93
	ld (0e3bch),hl		;9e94   ; guarda el sitio del ultimo choque con el mapa y el byte siguiente (16 bits)
	call toca_mapa_e305_de		;9e97   ; toca_mapa_e305_de: lo mismo desde el sitio HL
	ret c			;9e9a
	ld a,(ix+004h)		;9e9b
	cp 009h		;9e9e
	ret c			;9ea0
	ld a,(ix+004h)		;9ea1
	sub 008h		;9ea4
	ld (ix+004h),a		;9ea6
	ld a,(0e366h)		;9ea9   ; lee la marca de buscar suelo
	or a			;9eac
	jr nz,L_9E8D		;9ead
	ret			;9eaf
espera_disparo_por_nivel:		; IX+15 = 60 - 2 x nivel
	ld a,(0e228h)		;9eb0   ; 60 - 2 x nivel
	add a,a			;9eb3
	sub 03ch		;9eb4
	neg		;9eb6
	ld (ix+015h),a		;9eb8
	ret			;9ebb
tipo_05_dispara:		; al acabar IX+15, su dibujo y, si la nave esta de su lado y en angulo, dispara
	dec (ix+015h)		;9ebc   ; la espera
	ret nz			;9ebf
	call espera_disparo_por_nivel		;9ec0   ; espera_disparo_por_nivel: IX+15 = 60 - 2 x nivel
	call tipo_05_mira		;9ec3   ; tipo_05_mira: el dibujo mirando a la nave (0x94/0x88 arriba, 0xA0/0x7C abajo)
	bit 0,(ix+027h)		;9ec6   ; la nave de su lado?
	jr z,L_9ED5		;9eca
	ld a,(0e404h)		;9ecc
	cp (ix+004h)		;9ecf
	ret nc			;9ed2
	jr L_9EDC		;9ed3
L_9ED5:
	ld a,(0e404h)		;9ed5
	cp (ix+004h)		;9ed8
	ret c			;9edb
L_9EDC:
	ld e,(ix+004h)		;9edc   ; el angulo a la nave
	ld d,(ix+006h)		;9edf
	call angulo_a_la_nave		;9ee2   ; angulo_a_la_nave: el angulo desde D (X), E (Y) hasta la nave (0xF017 y los signos en 0xF010-0xF011)
	ld a,(0f018h)		;9ee5   ; lee el angulo calculado
	cp 080h		;9ee8
	jr c,L_9EEE		;9eea
	neg		;9eec
L_9EEE:
	cp 040h		;9eee   ; en el tramo bueno de angulos
	jr c,L_9EF4		;9ef0
	sub 040h		;9ef2
L_9EF4:
	sub 008h		;9ef4
	cp 030h		;9ef6
	ret nc			;9ef8
	jp 06774h		;9ef9   ; dispara
tipo_05_dibujo:		; la animacion de p02:9F18 segun hacia donde va y su lado
	ld a,(ix+00ah)		;9efc   ; hacia donde va
	or a			;9eff
	ld hl,09f18h		;9f00
	jp p,L_9F08		;9f03
	inc hl			;9f06
	inc hl			;9f07
L_9F08:
	bit 0,(ix+027h)		;9f08   ; y su lado
	jr z,L_9F12		;9f0c
	ld bc,00004h		;9f0e
	add hl,bc			;9f11
L_9F12:
	ld bc,00302h		;9f12   ; 3 pasos, cada 4 cuadros
	jp 06361h		;9f15   ; anima: cada (0xE1C3 & B) = 0, IX+26 + 1 (de 0 a C - 1) y el dibujo IX+30 = IX+32 = HL[IX+26]

; ----------------------------------------------------------------------
; DATOS tabla_9F18: 4 pares que p02:9EFC lee (0x9F18 o 0x9F1A segun IX+0A, y
;   el bit 0 de IX+27); lo leen p02:9F00 (8 bytes)
;   0x9f18..0x9f20  (8 bytes)
DATA_tabla_9F18:
	defb 098h,09ch	; 9f18
	defb 074h,078h	; 9f1a
	defb 08ch,090h	; 9f1c
	defb 080h,084h	; 9f1e

; ======================================================================
; CODIGO 0x9f20..0x9fcd  (173 bytes)
; ======================================================================


tipo_05_mira:		; el dibujo mirando a la nave (0x94/0x88 arriba, 0xA0/0x7C abajo)
	bit 0,(ix+027h)		;9f20   ; en el techo: 0x94 o 0x88
	jr z,L_9F36		;9f24
	ld b,094h		;9f26
	ld a,(0e406h)		;9f28
	cp (ix+006h)		;9f2b
	jr nc,L_9F32		;9f2e
	ld b,088h		;9f30
L_9F32:
	ld (ix+030h),b		;9f32
	ret			;9f35
L_9F36:
	ld b,0a0h		;9f36   ; en el suelo: 0xA0 o 0x7C
	ld a,(0e406h)		;9f38
	cp (ix+006h)		;9f3b
	jr nc,L_9F42		;9f3e
	ld b,07ch		;9f40
L_9F42:
	ld (ix+030h),b		;9f42
	ret			;9f45
tipo_05_tocado_fase_0:		; en la fase 0, C si bajo el tipo 5 hay caracteres 0xC3-0xC4 (o el de la derecha)
	ld a,(0e201h)		;9f46   ; solo en la fase 0
	or a			;9f49
	ret nz			;9f4a
	ld l,(ix+004h)		;9f4b
	ld h,(ix+006h)		;9f4e
	call 05c92h		;9f51   ; su sitio
	ld (0f000h),hl		;9f54   ; guarda variable de paso: el sentido de la vuelta (0 espejo, 1 cabeza abajo) o un puntero y el byte siguiente (16 bits)
	ld (0f002h),hl		;9f57   ; guarda variable de paso: el puntero del mapa y el byte siguiente (16 bits)
	ld de,002c3h		;9f5a   ; los caracteres 0xC3 y 0xC4
	ld bc,00020h		;9f5d
	call caracter_c3		;9f60   ; caracter_c3: C si el caracter de HL o el de debajo esta entre E y E + D
	ret c			;9f63
	ld hl,(0f000h)		;9f64   ; y los de la derecha
	ld a,l			;9f67
	and 01fh		;9f68
	ret z			;9f6a
	inc hl			;9f6b
caracter_c3:		; C si el caracter de HL o el de debajo esta entre E y E + D
	ld a,(hl)			;9f6c   ; este o el de debajo
	sub e			;9f6d   ; entre E y E + D
	cp d			;9f6e
	ret nc			;9f6f
	add hl,bc			;9f70   ; el de debajo
	ld a,(hl)			;9f71
	sub e			;9f72
	cp d			;9f73
	ret			;9f74
tipo_05_tapado:		; en la fase 0 sin scroll, C si en los 2 x 2 de su sitio hay mapa
	ld a,(0e201h)		;9f75   ; solo en la fase 0
	or a			;9f78
	ret nz			;9f79
	ld a,(0e320h)		;9f7a   ; y sin scroll
	or a			;9f7d
	ret nz			;9f7e
	ld a,(0e305h)		;9f7f   ; lee dato de la fase de p01:697A
	ld c,a			;9f82
	ld hl,(0f002h)		;9f83   ; los 2 x 2 de su sitio
	call es_mapa_c		;9f86   ; es_mapa_c: C si el caracter de HL es mapa (de 1 a C)
	ret nc			;9f89
	inc hl			;9f8a
	call es_mapa_c		;9f8b   ; es_mapa_c: C si el caracter de HL es mapa (de 1 a C)
	ret nc			;9f8e
	ld de,0001fh		;9f8f
	add hl,de			;9f92
	call es_mapa_c		;9f93   ; es_mapa_c: C si el caracter de HL es mapa (de 1 a C)
	ret nc			;9f96
	inc hl			;9f97
es_mapa_c:		; C si el caracter de HL es mapa (de 1 a C)
	ld a,(hl)			;9f98   ; vacio: no
	or a			;9f99
	ret z			;9f9a
	cp c			;9f9b   ; de 1 a C
	ret			;9f9c
tipo_25_empieza:		; el tipo 0x25: una velocidad al azar de p02:9FCD (vy hacia el centro, vx a un lado) y una aceleracion de 0x88 hacia el otro
	ld a,r		;9f9d   ; una de 8 al azar
	and 007h		;9f9f
	add a,a			;9fa1
	ld hl,09fcdh		;9fa2
	call 04b67h		;9fa5   ; palabra_a: DE = la palabra A de la tabla HL (HL apunta a su byte alto)
	ld a,(ix+004h)		;9fa8   ; hacia el centro
	or a			;9fab
	call m,05cadh		;9fac   ; menos_de: DE = - DE
	call 04efbh		;9faf   ; pon_vy: IX+07/IX+08 = DE
	inc hl			;9fb2   ; la vx
	ld e,(hl)			;9fb3
	inc hl			;9fb4
	ld d,(hl)			;9fb5
	ld a,r		;9fb6   ; a un lado o al otro
	and 001h		;9fb8
	call nz,05cadh		;9fba   ; menos_de: DE = - DE
	call 04f02h		;9fbd   ; pon_vx: IX+09/IX+0A = DE
	ld de,00088h		;9fc0   ; la aceleracion, hacia el otro lado
	ld a,(ix+004h)		;9fc3
	or a			;9fc6
	call p,05cadh		;9fc7   ; menos_de: DE = - DE
	jp 062a8h		;9fca   ; pon_aceleracion: IX+20/IX+21 = DE

; ----------------------------------------------------------------------
; DATOS tabla_9FCD: 8 fichas de 4 bytes que p02:9F9D elige al azar (ld a,r &
;   7) con L_4B67; lo leen p02:9FA5 (32 bytes)
;   0x9fcd..0x9fed  (32 bytes)
DATA_tabla_9FCD:
	defb 000h,00bh,080h,001h	; 9fcd
	defb 080h,00ah,000h,002h	; 9fd1
	defb 080h,00bh,000h,004h	; 9fd5
	defb 000h,00ah,090h,001h	; 9fd9
	defb 080h,00ah,0b0h,001h	; 9fdd
	defb 040h,00bh,000h,003h	; 9fe1
	defb 070h,00ah,080h,002h	; 9fe5
	defb 060h,00ah,040h,002h	; 9fe9

; ======================================================================
; CODIGO 0x9fed..0x9ffe  (17 bytes)
; ======================================================================


L_9FED:
	call 062c2h		;9fed   ; la velocidad Y + la aceleracion
	call 0a002h		;9ff0   ; p02:A002
	ld a,(0e1c3h)		;9ff3   ; cada 4 cuadros
	and 003h		;9ff6
	ret nz			;9ff8
	ld a,(ix+030h)		;9ff9   ; cambia de dibujo
	xor 004h		;9ffc

; ----------------------------------------------------------------------
; DATOS partida_9FFE: `ld (ix+d),a` (DD 77), que acaba en el banco 3: el
;   desplazamiento (0x30) es el primer byte de p03:A000, y el codigo sigue en
;   p03:A001; lo leen p02:9FFE (2 bytes)
;   0x9ffe..0xa000  (2 bytes)
DATA_partida_9FFE:
	defb 0ddh,077h	; 9ffe

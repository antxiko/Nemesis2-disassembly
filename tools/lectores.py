#!/usr/bin/env python3
"""Los lectores de datos de Nemesis 2 y sus formatos, para tools/bloques.py.

Cada recorredor hace con los bytes lo mismo que la rutina del cartucho que
lo lee, y devuelve donde acaba. Las rutinas, con su direccion en NUESTRO
listado:

  p00:4A8C  rachas a la VRAM (HL = destino, DE = origen): n == 0 acaba;
            n < 0x80 repite el byte siguiente n veces; n == 0x80 trae otro
            destino (2 bytes, p00:4A86); n > 0x80 copia n & 0x7F bytes.
            p00:4A5B lo mismo tres veces (los tres tercios, +0x800).
  p00:4A86  igual, con el destino delante (2 bytes).
  p00:4A6B  lista a la VRAM: [destino lo hi] y bytes; 0xFE trae otro destino
            (2 bytes); 0xFF acaba. p00:4A82 lo mismo escribiendo ceros
            (C = 0: borra lo que la lista dibujaria). p00:4A73 sin el
            destino delante (lo pone quien llama en HL).
  p00:4595  lista de caracteres (IX): fichas de 6 bytes [tercios][colores
            lo hi][caracter][dibujos lo hi], cada puntero a unas rachas de
            p00:4A8C; 0 en el primer byte acaba.
  p00:454E  lista de copias VRAM -> VRAM (IX): fichas de 4 bytes, o de 3 si
            los dos bits altos del tercer byte no son cero; 0 acaba.
  p10:A67B  rachas a la VRAM con salto de fila (HL = origen, DE = destino,
            C = ancho): n == 0 acaba; n < 0x80 repite el byte siguiente;
            n == 0x80 [cuantos][primero] escribe una serie que sube de uno
            en uno; n > 0x80 copia n & 0x7F bytes. Los ceros no se escriben.
  p10:A6EB  rachas a la RAM (HL = destino, DE = origen), como p00:4A8C.
"""
import bloques as B


# ---------------------------------------------------------------- formatos

def rachas(v, a):
    """p00:4A8C. Devuelve el final (detras del 0)."""
    while True:
        n = v(a)
        a += 1
        if n == 0:
            return a
        if n < 0x80:
            a += 1
        elif n == 0x80:
            a += 2
        else:
            a += n & 0x7F


def rachas_con_destino(v, a):
    """p00:4A86: [destino lo hi] y rachas."""
    return rachas(v, a + 2)


def lista_vram(v, a, con_destino=True):
    """p00:4A6B / p00:4A82 / p00:4A73."""
    if con_destino:
        a += 2
    while True:
        x = v(a)
        a += 1
        if x == 0xFF:
            return a
        if x == 0xFE:
            a += 2


def rachas_serie(v, a):
    """p10:A67B: como las rachas, pero 0x80 [cuantos][primero] es una serie."""
    while True:
        n = v(a)
        a += 1
        if n == 0:
            return a
        if n < 0x80:
            a += 1
        elif n == 0x80:
            a += 2
        else:
            a += n & 0x7F


def lista_caracteres(v, a, sitio):
    """p00:4595: fichas de 6 bytes hasta un 0; declara las rachas de cada una."""
    ini = a
    k = 0
    while v(a) != 0:
        col, dib = v.w(a + 1), v.w(a + 4)
        for q, que in ((col, "colores"), (dib, "dibujos")):
            B.declara(v, q, rachas(v, q), "%s_%04X" % (que, q),
                      "rachas (p00:4A8C) con los %s de los caracteres desde el %d, "
                      "ficha %d de la lista 0x%04X (p00:4595)" % (que, v(a + 3), k, ini),
                      sitio)
        a += 6
        k += 1
    return a + 1


def lista_copias(v, a):
    """p00:454E: fichas de 4 bytes (3 si (ix+2) >> 6 no es cero) hasta un 0."""
    while v(a) != 0:
        a += 3 if (v(a + 2) >> 6) else 4
    return a + 1


# ------------------------------------------------------------- el sonido
#
# p04:6480 arranca el sonido A: la tabla de p04:6612 da su cabecera
# [canales][prioridad] y una palabra por cada bit de canales (de 7 a 0: los
# tres del PSG y los cinco del SCC), que es donde empieza la partitura de ese
# canal. p04:699A la interpreta cada cuadro (bancos 4-5-6 puestos):
#   0xFF          acaba el canal (p04:6AE3)
#   0xD0-0xDF     1 byte (p04:6F55: octava, o volumen si la cifra es >= 6)
#   0xE0-0xFE     por la tabla de p04:6D27; su largo en LARGO_ORDEN. 0xF9
#                 [lo hi] llama a una subpartitura y 0xFA vuelve; 0xFB/0xFC
#                 [veces][lo hi] y 0xEB [veces][atras] repiten; 0xFD [lo hi]
#                 salta; 0xFE [modo] pone IX+09; 0xF8 [n] la forma de onda
#                 del SCC (tabla p04:6000); 0xE0-0xE3 el modo de volumen
#                 (IX+0D), con un byte mas si no es 0xE0.
#   < 0xD0        una nota, cuyo largo depende del canal: con el bit 0 del
#                 modo, 1 byte (p04:69CD); con el bit 1, 1 byte (2 si el modo
#                 de volumen es 2 o 3 y IX+0E no lleva los bits 7 ni 5:
#                 p04:6A3F), y otro mas si es el bit 0 el que lo ha leido;
#                 con el bit 2 (bateria), 1 byte y la cifra alta elige un
#                 golpe de la tabla p04:7255 (p04:6AAA).

LARGO_ORDEN = {0xE4: 2, 0xE5: 2, 0xE6: 2, 0xE7: 2, 0xE8: 1, 0xE9: 2, 0xEA: 2,
               0xEB: 3, 0xEC: 1, 0xED: 3, 0xEE: 1, 0xEF: 2, 0xF0: 1, 0xF1: 2,
               0xF2: 1, 0xF3: 2, 0xF4: 1, 0xF5: 1, 0xF6: 1, 0xF7: 1, 0xF8: 2,
               0xF9: 3, 0xFA: 1, 0xFB: 4, 0xFC: 4, 0xFD: 3, 0xFE: 2}


def largo_nota(modo, d, e):
    """Bytes de una nota con el estado del canal; None si el modo no lee.

    Con el bit 3 (un golpe de bateria en curso, IX+09 = 0x0A: p04:6AC2) la
    nota no avanza en p04:6A9B, pero p04:6ACF suma uno al guardar donde va."""
    if modo & 4:
        return 1
    n = 0
    if modo & 1:
        n += 1
    if modo & 2:
        if (d & 3) >= 2 and not (e & 0xA0):
            n += 1
        n += 1
    return n or None


def orden(x, q, modo, d, e):
    """(largo, modo, d, e) tras la orden x (0xD0-0xFE) con operando q."""
    if 0xD0 <= x < 0xE0:
        return 1, modo, d, (e | 0x40) if (x & 0x0F) >= 6 else e
    if x <= 0xE3:
        d = x & 3
        return (1 if d == 0 else 2), modo, d, e & 0x7F
    n = LARGO_ORDEN[x]
    if x == 0xE5:
        d &= ~8
    elif x == 0xE7:
        d |= 4
    elif x == 0xE8:
        d &= 0xF3
    elif x == 0xEC:
        e &= ~0x40
    elif x == 0xEF:
        e |= 2
    elif x == 0xF0:
        e &= ~2
    elif x == 0xF1:
        e |= 0x14
    elif x == 0xF2:
        e &= 0xE2
    elif x == 0xF3:
        e |= 0x0C
    elif x == 0xF4:
        e &= ~8
    elif x == 0xF5:
        e |= 0x80
    elif x == 0xF6:
        e &= 0x5F
    elif x == 0xF7:
        e |= 0x20
    elif x == 0xFE:
        modo = q
        if q == 4:
            d = e = 0
    return n, modo, d, e & 0xFF


class Partituras:
    """Recorre canales apuntando cada byte leido (y con que largo)."""

    def __init__(self, v):
        self.v = v
        self.usados = {}           # direccion -> (inicio de la instruccion, largo)
        self.dos = set()           # bytes leidos con dos largos distintos
        self.golpes = set()
        self.ondas = set()
        self.avisos = []
        self.memo = {}

    def apunta(self, a, n):
        for k in range(n):
            if a + k in self.usados and self.usados[a + k] != (a, n):
                self.dos.add(a + k)
            self.usados[a + k] = (a, n)

    def recorre(self, a, estado, hondo=0):
        """Estados con los que se sale por un 0xFA (vacio si acaba en 0xFF)."""
        clave = (a, estado)
        if clave in self.memo:
            return self.memo[clave]
        self.memo[clave] = set()
        salidas = set()
        pila = [(a, estado)]
        vistos = set()
        v = self.v
        while pila:
            a, (modo, d, e) = pila.pop()
            while True:
                if (a, (modo, d, e)) in vistos:
                    break
                vistos.add((a, (modo, d, e)))
                x = v(a)
                if x == 0xFF:
                    self.apunta(a, 1)
                    break
                if x == 0xFA:
                    self.apunta(a, 1)
                    salidas.add((modo, d, e))
                    break
                if x >= 0xD0:
                    q = v(a + 1)
                    n, modo, d, e = orden(x, q, modo, d, e)
                    self.apunta(a, n)
                    if x == 0xF8:
                        self.ondas.add(q)
                    if x == 0xFD:
                        a = v.w(a + 1)
                        continue
                    if x == 0xF9:
                        tras = self.recorre(v.w(a + 1), (modo, d, e), hondo + 1) if hondo < 8 else set()
                        for est in tras:
                            pila.append((a + 3, est))
                        break
                    a += n
                    continue
                n = largo_nota(modo, d, e)
                if n is None:
                    self.avisos.append("%04X: nota con el modo %02X" % (a, modo))
                    break
                if modo & 4:
                    self.golpes.add(x >> 4)
                self.apunta(a, n)
                a += n
        self.memo[clave] = salidas
        return salidas


def tramos(conjunto):
    """[(ini, fin)] de un conjunto de direcciones."""
    out = []
    for x in sorted(conjunto):
        if out and out[-1][1] == x:
            out[-1][1] = x + 1
        else:
            out.append([x, x + 1])
    return [tuple(t) for t in out]


def sonido():
    v = B.Ventana((4, 5, 6))
    lec = "p04:64B4"
    B.declara(v, 0x6614, 0x669A, "sonidos", "67 punteros, uno por sonido del 1 al 0x43 (A en "
              "p04:6480, tabla en 0x6612 + 2 x A): su cabecera [canales][prioridad][una palabra "
              "por canal]. La entrada 0 serian los bytes B0 C9 de `ldir / ret` (p04:6611): no hay "
              "sonido 0", lec, F="w8")
    cab = [v.w(0x6612 + 2 * k) for k in range(68)]
    P = Partituras(v)
    de_quien = {}
    for k, c in enumerate(cab):
        if not 0x4000 <= c < 0xC000 or k == 0:
            continue
        m = v(c)
        canales = [b for b in range(7, -1, -1) if m >> b & 1]
        B.declara(v, c, c + 2 + 2 * len(canales), "cabecera_%02X" % k,
                  "cabecera del sonido 0x%02X: canales 0x%02X, prioridad 0x%02X y %d "
                  "partituras (p04:64B4 copia 18 bytes a 0xE192)" % (k, m, v(c + 1), len(canales)),
                  lec, F=2 + 2 * len(canales))
        for j, b in enumerate(canales):
            ini = v.w(c + 2 + 2 * j)
            antes = set(P.usados)
            P.recorre(ini, (0, 0, 0))
            for x in set(P.usados) - antes:
                de_quien[x] = k
    # la bateria: p04:6AAA elige un golpe por la cifra alta de la nota
    dir_golpes = [v.w(0x7255 + 2 * k) for k in range(10)]
    B.declara(v, 0x7255, 0x7269, "golpes", "10 punteros a los golpes de bateria (p04:6AB1: "
              "la cifra alta de la nota en modo 4); van de 0x7269 a 0x72C9. p04:6AAA no mira el "
              "indice: las notas 0xB0 (sonido 0x40) y 0xC0 (0x34) leen como puntero los bytes de "
              "0x726B y 0x726D, que ya son partitura, y caen en 0x00E4 (la BIOS) y 0xFF07 (los "
              "ganchos de la RAM)", "p04:6AB1", F="w10")
    for k, g in enumerate(dir_golpes):
        antes = set(P.usados)
        P.recorre(g, (0x0A, 0, 0))
        for x in set(P.usados) - antes:
            de_quien[x] = "golpe %d" % k
    usados, avisos, golpes, ondas = P.usados, P.avisos, P.golpes, P.ondas
    for ini, fin in tramos(usados):
        ks = sorted({de_quien[x] for x in range(ini, fin)}, key=str)
        q = ", ".join("0x%02X" % x if isinstance(x, int) else x for x in ks[:6])
        dos = [x for x in P.dos if ini <= x < fin]
        B.declara(v, ini, fin, "partitura_%04X" % ini,
                  "partitura (p04:699A: ordenes 0xD0-0xFF y notas) de %s%s%s" % (
                      "los sonidos " if isinstance(ks[0], int) else "", q + (" y otros" if len(ks) > 6 else ""),
                      "; %d bytes los leen dos canales con distinto largo de nota (uno con el "
                      "volumen en modo 0, otro en modo 2: ver 0x7E09 y 0x7E1B, sonido 0x22)"
                      % len(set(dos)) if dos else ""),
                  "p04:69A6", F=16)
    # lo que queda entre partituras: el 0xFF de cierre detras de un 0xFD (no
    # se llega nunca a el) y alguna subpartitura que no llama nadie
    tr = tramos(usados)
    for (i0, f0), (i1, f1) in zip(tr, tr[1:]):
        if f0 >= i1:
            continue
        bs = [v(x) for x in range(f0, i1)]
        if all(x == 0xFF for x in bs):
            txt = ("%d byte%s 0xFF de cierre que no se alcanza: la partitura de delante acaba "
                   "saltando con 0xFD" % (len(bs), "" if len(bs) == 1 else "s"))
            if v(f0 - 3) != 0xFD:
                txt = "%d bytes 0xFF sueltos entre partituras: no los lee nadie" % len(bs)
        elif bs[-1] == 0xFA:
            txt = ("subpartitura de %d bytes que acaba en 0xFA, como las que se llaman con "
                   "0xF9, pero no la llama ninguna: sin lector a la vista" % len(bs))
        else:
            txt = "%d bytes entre partituras que no lee nadie" % len(bs)
        B.declara(v, f0, i1, "suelto_%04X" % f0, txt, "nadie", F=16)
    usadas = sorted({v.w(0x6000 + 2 * n) for n in ondas})
    B.declara(v, 0x6000, 0x6080, "ondas", "64 punteros a las formas de onda del SCC (orden 0xF8 "
              "de la partitura, p04:6EE2); de la 0x30 a la 0x3F apuntan a 0x6480, que es codigo: "
              "no las pide ninguna partitura", "p04:6EE5", F="w8")
    for k in range(32):
        a = 0x6080 + 0x20 * k
        B.declara(v, a, a + 0x20, "onda_%02d" % k, "forma de onda del SCC: 32 muestras con signo "
                  "que p04:7236 copia a 0x9800 + 0x20 x canal%s" % ("" if a in usadas else
                                                                    " (ninguna partitura la pide)"),
                  "p04:7241", F=16)
    B.declara(v, 0x6D27, 0x6D65, "ordenes", "31 destinos, uno por orden de la partitura de 0xE0 "
              "a 0xFE (p04:6D12: HL = 0x6D27 + 2 x (orden & 0x1F); jp (hl) en p04:6D26); el 0xFF "
              "no llega aqui (lo mira antes p04:69A7)", "p04:6D26", F="w8")
    B.declara(v, 0x657D, 0x658D, "canal_nuevo", "16 bytes que p04:6574 copia a IX+04..IX+13 de "
              "un canal al arrancarlo: la cuenta a 1 y lo demas a 0", "p04:6574", F=16)
    B.declara(v, 0x6A32, 0x6A3F, "notas_psg", "13 bytes: el divisor de cada nota (de do a do) "
              "que p04:69F0 lee con el indice < 12; el 13 no lo lee nadie", "p04:69F0", F=13)
    B.declara(v, 0x703E, 0x704A, "mezclador", "tres tablas de 4 bytes, una por canal del PSG, con "
              "los bits del registro 7 (tono/ruido) segun el modo; p04:700E/7019/7024 + IX+0D & 3",
              "p04:7037", F=4)
    for c in avisos:
        B.AVISOS.append("sonido: " + c)
    print("sonido: %d bytes de partitura, golpes %s, ondas %s, %d leidos de dos maneras" % (
        len(usados), sorted(golpes), sorted(ondas), len(P.dos)))
    return usados


# --------------------------------------------------------------- el mapa
#
# p00:4889 mete una columna nueva en el mapa de la RAM (22 filas en 0xED00,
# p00:4870 lo corre). Con los bancos 13-14-15 puestos:
#   0x7900[fase]   donde empiezan las columnas de la fase (12 fases, 0xE201)
#   columna        6 bytes, un metabloque por fila de metabloques: los cinco
#                  primeros dan 4 filas de caracteres y el sexto 2 (22)
#   0x5557[fase]   (banco 0) los metabloques de la fase; 0x494A[fase] el
#                  umbral T: los T primeros son de 16 bytes (4 x 4
#                  caracteres) y los siguientes de 8 (p00:48F1 los copia a
#                  0xEAA8). Salvo en las fases 0 y 8, los numeros 0-3 son los
#                  cuatro comunes de 0x6000 y a los demas se les resta 4.
# Las tablas de metabloques encadenan: cada una acaba (16 x T + 8 x las de
# mas, hasta el mayor numero que usan sus columnas) justo donde empieza la
# siguiente, y la ultima en 0x7900. Lo comprueba tests/test_mapa.py.

FASES = 12


def mapa():
    v0 = B.ventana_de(0)
    v = B.Ventana((13, 14, 15))
    col = [v.w(0x7900 + 2 * k) for k in range(FASES)]
    met = [v0.w(0x5557 + 2 * k) for k in range(FASES)]
    umbral = [v0(0x494A + k) for k in range(FASES)]
    B.declara(v0, 0x5557, 0x556F, "metabloques_por_fase", "12 punteros (uno por fase, 0xE201) a "
              "los metabloques del banco 13; p00:48C3 los lee con L_4B67", "p00:48C6", F="w6")
    B.declara(v0, 0x494A, 0x4956, "umbral_por_fase", "12 bytes, uno por fase: cuantos metabloques "
              "de 16 bytes hay antes de los de 8 (p00:48E7)", "p00:48EA", F=12)
    B.declara(v, 0x7900, 0x7918, "columnas_por_fase", "12 punteros (uno por fase) a las columnas "
              "del mapa (p00:48A0 con L_4B67)", "p00:48A6", F="w6")
    B.declara(v, 0x6000, 0x6040, "metabloques_comunes", "los 4 metabloques comunes (16 bytes, "
              "4 x 4 caracteres por filas), numeros 0-3 en todas las fases salvo la 0 y la 8 "
              "(p00:48DD)", "p00:48DD", F=16)
    fins = sorted(col) + [0x91A8]
    for k in range(FASES):
        a = col[k]
        f = fins[fins.index(a) + 1]
        B.declara(v, a, f, "columnas_fase_%d" % k, "las %d columnas de la fase %d: 6 bytes cada una, "
                  "un metabloque por fila (p00:48CF)" % ((f - a) // 6, k), "p00:48CF", F=6)
    por_tabla = {}
    for k in range(FASES):
        a = col[k]
        f = fins[fins.index(a) + 1]
        ns = [v(x) for x in range(a, f)]
        idx = ns if k in (0, 8) else [n - 4 for n in ns if n >= 4]
        por_tabla.setdefault(met[k], []).append((k, max(idx), umbral[k]))
    for m, fs in sorted(por_tabla.items()):
        t = fs[0][2]
        mx = max(x[1] for x in fs)
        fin = m + 16 * t + 8 * (mx - t + 1)
        B.declara(v, m, m + 16 * t, "metabloques_%04X" % m,
                  "%d metabloques de 16 bytes (4 x 4 caracteres) de la fase %s" % (
                      t, " y ".join(str(x[0]) for x in fs)), "p00:490A", F=16)
        B.declara(v, m + 16 * t, fin, "medios_%04X" % m,
                  "%d metabloques de 8 bytes de la fase %s (del %d al %d; p00:48F1 los copia "
                  "a 0xEAA8)" % (mx - t + 1, " y ".join(str(x[0]) for x in fs), t, mx),
                  "p00:48FD", F=8)


# --------------------------------------------- tablas indexadas por fase

def por_fase(v, tabla, n, nom, que, lector, recorre=None, texto_bloque=None, F_bloque=None):
    """Una tabla de n punteros (uno por fase) y, si se da recorre, el bloque
    al que apunta cada uno (los repetidos una sola vez)."""
    B.declara(v, tabla, tabla + 2 * n, nom, "%d punteros, uno por fase (0xE201): %s" % (n, que),
              lector, F="w6")
    if recorre is None:
        return
    ps = {}
    for k in range(n):
        ps.setdefault(v.w(tabla + 2 * k), []).append(k)
    for a, ks in sorted(ps.items()):
        fin = recorre(v, a)
        B.declara(v, a, fin, "%s_%04X" % (nom, a), texto_bloque % (
            "la fase " if len(ks) == 1 else "las fases ") + ", ".join(map(str, ks)), lector, F=F_bloque)


def banco7():
    """Los caracteres de cada fase (p00:44F7, con los bancos 7-8-9)."""
    v = B.Ventana((7, 8, 9))
    for tabla, que in ((0x6018, "sin voltear (0xF000 = 0)"), (0x6030, "volteados (0xF000 = 1)")):
        por_fase(v, tabla, 12, "copias_por_fase_%04X" % tabla,
                 "listas de copias de caracteres VRAM -> VRAM %s, p00:4545 con L_4B67" % que,
                 "p00:4548", lista_copias,
                 "lista de copias VRAM -> VRAM (p00:454E: 4 bytes, 3 si el tercero lleva los "
                 "bits altos; 0 acaba) de %s", F_bloque=4)
    B.declara(v, 0x6000, 0x6018, "caracteres_por_fase", "12 punteros, uno por fase (0xE201): las "
              "listas de caracteres (p00:4595) de cada fase, p00:4528 con L_4B67", "p00:452B", F="w6")
    ps = {}
    for k in range(12):
        ps.setdefault(v.w(0x6000 + 2 * k), []).append(k)
    for a, ks in sorted(ps.items()):
        sitio = "p00:4531"
        B.declara(v, a, lista_caracteres(v, a, sitio), "caracteres_fase_%04X" % a,
                  "lista de caracteres (p00:4595) de la%s fase%s %s: fichas de 6 bytes "
                  "[tercios][colores][caracter][dibujos], 0 acaba" % (
                      "s" if len(ks) > 1 else "", "s" if len(ks) > 1 else "",
                      ", ".join(map(str, ks))), sitio, F=6)


def lista_sprites(v, a, sitio, quien):
    """p00:44D1: [n][rachas lo hi] hasta un 0; cada puntero, unas rachas que
    van a la VRAM 0x1800 + 8 x n."""
    ini = a
    while v(a) != 0:
        q = v.w(a + 1)
        B.declara(v, q, rachas(v, q), "rachas_%04X" % q,
                  "rachas (p00:4A8C) a la VRAM 0x%04X (el %d) de la lista 0x%04X (p00:44D1, %s)"
                  % (0x1800 + 8 * v(a), v(a), ini, quien), sitio)
        a += 3
    return a + 1


def lista_43da(v, a):
    """p00:43DA: fichas de 4 bytes [tipo][cuantos][origen][destino] hasta un
    tipo 0; el 1 copia con volteo (p00:43EE) y los demas tal cual (p00:445E)."""
    while v(a) != 0:
        a += 4
    return a + 1


def banco8():
    v = B.Ventana((7, 8, 9))
    # p00:4319: C (1-7) elige un par de rachas que p00:4A5B pinta en los tres
    # tercios: dibujos en 0x2748 y colores en 0x0748
    B.declara(v, 0x9098, 0x90B4, "armas_9098", "7 pares de punteros (C de 1 a 7 en p00:4319: la "
              "tabla empieza en 0x9094 + 4, y lo de 0x9094 es el final de las rachas de "
              "0x9074): dibujos (VRAM 0x2748) y colores (0x0748) en los tres tercios", "p00:431F",
              F="w2")
    for c in range(1, 8):
        for k, (vram, que) in enumerate(((0x2748, "dibujos"), (0x0748, "colores"))):
            q = v.w(0x9094 + 4 * c + 2 * k)
            B.declara(v, q, rachas(v, q), "%s_%d" % (que, c),
                      "rachas (p00:4A5B, los tres tercios) con los %s del %d (C de p00:4319) a "
                      "la VRAM 0x%04X" % (que, c, vram), "p00:4329" if k == 0 else "p00:4334")
    por_fase(v, 0x92B3, 12, "rachas_por_fase_92B3", "listas [n][rachas] de p00:44D1, que p00:44C7 "
             "lee con L_4B67", "p00:44CD")
    ps = {}
    for k in range(12):
        ps.setdefault(v.w(0x92B3 + 2 * k), []).append(k)
    for a, ks in sorted(ps.items()):
        B.declara(v, a, lista_sprites(v, a, "p00:44D1", "fase " + ", ".join(map(str, ks))),
                  "lista_44D1_%04X" % a, "lista de p00:44D1 de la%s fase%s %s: [n][rachas lo hi] "
                  "y 0 acaba" % ("s" if len(ks) > 1 else "", "s" if len(ks) > 1 else "",
                                 ", ".join(map(str, ks))), "p00:44D1", F=3)
    por_fase(v, 0x9348, 12, "copias_por_fase_9348", "listas de p00:43DA (fichas de 4 bytes), que "
             "p00:43CE lee con L_4B67", "p00:43D4", lista_43da,
             "lista de p00:43DA (fichas [tipo][cuantos][origen][destino], tipo 0 acaba) de %s",
             F_bloque=4)
    v0 = B.ventana_de(0)
    B.declara(v0, 0x44EA, lista_43da(v0, 0x44EA), "copias_44EA", "lista de p00:43DA (fichas "
              "[tipo][cuantos][origen][destino], tipo 0 acaba) que p00:43C4 pasa en IX", "p00:43C8",
              F=4)
    v11 = B.Ventana((1, 2, 11))
    B.declara(v11, 0xBFBF, lista_caracteres(v11, 0xBFBF, "p00:4350"), "caracteres_BFBF",
              "lista de caracteres (p00:4595) que p00:4343 pasa con el banco 11 puesto (si el bit 2 "
              "de 0xF0F5)", "p00:4350", F=6)


# ------------------------------------- tablas sueltas en los bancos de codigo
#
# (banco, inicio, fin, nombre, que es y como se lee, lector, F). El final sale
# del rango del indice que se ve en el codigo del lector, y donde no se ve,
# del codigo o el bloque que empieza detras (se dice).

TABLAS = [
    (0, 0x4000, 0x4010, "cabecera", "cabecera del cartucho: \"AB\", INIT = 0x4090 y STATEMENT, "
     "DEVICE y TEXT a cero; la lee la BIOS al arrancar", "BIOS", 16),
    (0, 0x4010, 0x4023, "cabecera_game_master", "la segunda cabecera de Konami: \"CD\", 0x07 0x51 "
     "(RC-751) y 15 bytes que lee el Game Master desde la otra ranura; el propio cartucho la "
     "busca en el vecino (p03:BD06: Galious, Penguin Adventure y Q*bert la llevan)", "p03:BD06", 16),
    (0, 0x49E0, 0x49E8, "pares_49E0", "4 pares de bytes que p00:497A lee con (0xE1C3 & 6)",
     "p00:4986", 2),
    (0, 0x49E8, 0x4A08, "tabla_49E8", "32 bytes que p00:4956 lee con (0xE203 & 0x1F): la scroll "
     "en curso", "p00:495E", 16),
    (0, 0x4BE8, 0x4C24, "bloque_4BE8", "4 filas de 15 caracteres que p00:4B8E copia a la tabla de "
     "nombres de la RAM alineadas a la derecha (IX+14 de ancho, IX+13 filas)", "p00:4BA2", 15),
    (0, 0x4CD6, 0x4CF6, "tabla_4CD6", "16 palabras con signo (una por direccion) que p00:4CC8 lee "
     "con L_4B67 y suma IX+?? veces", "p00:4CCB", "w8"),
    (0, 0x4CF6, 0x4D16, "tabla_4CF6", "16 palabras con signo (una por direccion) que p00:4CB8 lee "
     "con L_4B67", "p00:4CBB", "w8"),
    (0, 0x4EA4, 0x4EB4, "tabla_4EA4", "16 bytes que p00:4E94 lee con 0xE228 y a los que suma un "
     "azar de 0 a 7 (ld a,r)", "p00:4E9A", 16),
    (0, 0x4F4C, 0x5113, "fichas_de_tipo", "65 fichas de 7 bytes, una por tipo de enemigo (0xE350 "
     "o IX+00), del 1 al 65: p00:4D42 y p01:6514 las leen en 0x4F45 + 7 x tipo (la del 0 caeria "
     "en el codigo de delante)", "p00:4D51", 7),
    (0, 0x5265, 0x526A, "tabla_5265", "5 bytes que p00:5219 lee con C (L_5CA6)", "p00:521D", 5),
    (0, 0x5462, 0x54C7, "tablas_5462", "8 punteros, uno por vuelta (0xE20F), a tablas de "
     "punteros (indice B en p00:53E7) a tiras de bytes que acaban en 0x54AE-0x54C6; las lee "
     "p00:53DC con L_4B67 dos veces", "p00:53E2", 16),
    (0, 0x554F, 0x5557, "tabla_554F", "8 bytes, uno por vuelta (0xE20F): la casilla 0xE3xx que "
     "p00:553E pone a cero", "p00:5544", 8),
    (0, 0x5AD8, 0x5ADA, "inicio_E200", "2 bytes que p00:5AB1 copia a 0xE200-0xE201 (la fase de "
     "arranque)", "p00:5AB1", 2),
    (0, 0x5D1D, 0x5D25, "registros_vdp", "los 8 registros del VDP que p00:5D0C escribe (WRTVDP): "
     "SCREEN 2, nombres en 0x3800, colores en 0x0000, dibujos en 0x2000, atributos de sprite en "
     "0x3B00 y sus dibujos en 0x1800", "p00:5D13", 8),
    (0, 0x5F6D, 0x5F77, "tabla_5F6D", "5 punteros (fases 2 a 6) al banco 15 que p00:5F4D lee en "
     "0x5F69 + 2 x fase con L_4B67; las fases 0 y 1 caerian en el `jr` de delante",
     "p00:5F53", "w5"),
    (3, 0xBD55, 0xBD67, "firmas_del_vecino", "lo que p03:BCF0 busca en la otra ranura (RDSLT): "
     "00 30 31 13 35 AA en 0x7FFA (bit 1 de 0xF0F5), y en 0x4010 \"CD 07 49\" (RC-749, Maze of "
     "Galious: bit 3), \"CD 07 43\" (RC-743, Penguin Adventure: bit 2) y \"CD 07 46\" (RC-746, "
     "Q*bert: bit 0 y 0xE229 = 1)", "p03:BD40", 6),
]


TABLAS += [
    (1, 0x66C0, 0x66D0, "tabla_66C0", "16 bytes que p01:6667 lee con 0xE228 (con 0xE206 = 1, como "
     "mucho el 2)", "p01:6679", 16),
    (1, 0x66D0, 0x6700, "tabla_66D0", "4 filas de 12 bytes (IX+26 x 12 + fase) que p01:660A suma "
     "a C para IX+32", "p01:6615", 12),
    (1, 0x676C, 0x6770, "tabla_676C", "4 bytes que p01:673A lee con IX+26", "p01:6740", 4),
    (1, 0x67C8, 0x67CE, "tabla_67C8", "6 bytes que p01:67CE pasa a L_67EC (3 pares, destino "
     "0xEA07)", "p01:67CE", 6),
    (1, 0x694A, 0x6962, "tabla_694A", "12 palabras, una por fase, que p01:6920 lee con L_4B67",
     "p01:6923", "w6"),
    (1, 0x6962, 0x6971, "inicio_E400", "15 bytes que p01:6888 copia a 0xE400", "p01:6888", 15),
    (1, 0x6971, 0x697A, "inicio_E430", "9 bytes que p01:6893 copia a 0xE430", "p01:6893", 9),
    (1, 0x697A, 0x6986, "tabla_697A", "12 bytes, uno por fase, que p01:68F8 pone en 0xE305",
     "p01:68FE", 12),
    (1, 0x6986, 0x69CE, "limites_por_fase", "12 fichas de 6 bytes, una por fase, que p01:6908 "
     "copia a 0xE321 (los limites del scroll que mira p00:4889)", "p01:6912", 6),
    (1, 0x6B7C, 0x6B7F, "tabla_6B7C", "3 bytes que p01:6B5E lee con el indice de 0 a 2",
     "p01:6B62", 3),
    (1, 0x6B7F, 0x6B85, "tabla_6B7F", "3 punteros (fases 9, 10 y 11) al banco 15 que p01:6AED "
     "lee con fase - 9 (la 3 usa 0xA2AC)", "p01:6AF2", "w3"),
    (1, 0x6EC1, 0x6EC9, "tabla_6EC1", "8 bytes, uno por fase de la 0 a la 7, que p01:6E76 "
     "compara con el scroll", "p01:6E7C", 8),
    (1, 0x6EF2, 0x6EFF, "tabla_6EF2", "13 bytes, uno por fase, que p01:6E9A pone en 0xE393 (el "
     "13 no lo pide ninguna)", "p01:6EA0", 13),
    (1, 0x6F22, 0x6F32, "tabla_6F22", "16 bytes que p01:6F17 lee con 0xE356 & 0x0F (desde "
     "p01:6EFF y p01:6F0F)", "p01:6F1C", 16),
    (1, 0x6F32, 0x6F42, "tabla_6F32", "16 bytes que p01:6F17 lee con 0xE356 & 0x0F (desde "
     "p01:6F07)", "p01:6F1C", 16),
    (1, 0x7006, 0x700A, "tabla_7006", "4 bytes que p01:6FD6 lee con (HL) & 3", "p01:6FDC", 4),
    (1, 0x700A, 0x701A, "tabla_700A", "16 bytes que p01:6FE7 lee con 0xE228", "p01:6FED", 16),
    (1, 0x7055, 0x7065, "tabla_7055", "dos tablas de 8 bytes (0x7055 y 0x705D) que p01:7040 lee "
     "con B", "p01:7041", 8),
    (1, 0x7097, 0x709F, "tabla_7097", "8 bytes que p01:706E lee con (HL) & 7", "p01:7074", 8),
    (1, 0x70C6, 0x70CE, "tabla_70C6", "8 bytes que p01:70B1 lee con A & 7", "p01:70B6", 8),
    (1, 0x7141, 0x7151, "tabla_7141", "8 palabras que p01:7124 lee en 0x713F + 2 x B (B de 8 a "
     "1)", "p01:7129", "w8"),
    (1, 0x7240, 0x7248, "tabla_7240", "8 bytes que p01:7226 lee con 0xE35B", "p01:722F", 8),
    (1, 0x730E, 0x731E, "inicio_EA70", "16 bytes que p01:72EC copia a 0xEA70", "p01:72EC", 16),
    (1, 0x73B8, 0x73D8, "tabla_73B8", "16 palabras que p01:7344 y p01:7375 leen al azar (ld a,r "
     "& 0x1E)", "p01:734B", "w8"),
    (1, 0x73D8, 0x73E0, "tabla_73D8", "4 palabras que p01:7360 lee al azar (ld a,r & 6)",
     "p01:736A", "w4"),
    (1, 0x7417, 0x7427, "tabla_7417", "4 fichas de 4 bytes que p01:7401 copia con ldi",
     "p01:7406", 4),
    (1, 0x7565, 0x7569, "tabla_7565", "4 bytes que p01:7543 lee con 0xE3C4", "p01:7552", 4),
    (1, 0x7725, 0x7731, "inicio_EF0A", "12 bytes que p01:7587 copia a 0xEF0A", "p01:7587", 12),
    (1, 0x7731, 0x7738, "inicio_EF4C", "7 bytes que p01:75A4 copia a 0xEF4C", "p01:75A4", 7),
    (1, 0x7738, 0x7758, "tabla_7738", "4 fichas de 8 bytes que p01:74EC copia a 0xEE2C y 0xEE4C",
     "p01:74F2", 8),
    (1, 0x7758, 0x77A8, "tabla_7758", "10 fichas de 8 bytes que p01:751D copia a 0xEE10",
     "p01:7523", 8),
    (1, 0x77A8, 0x77AE, "tabla_77A8", "6 bytes que p01:769A lee con la vuelta (0xE20F)",
     "p01:76A0", 6),
    (1, 0x77AE, 0x77B6, "tabla_77AE", "8 bytes, uno por vuelta (0xE20F), que p01:76CF lee",
     "p01:76D5", 8),
    (1, 0x786A, 0x7872, "tabla_786A", "8 bytes que p01:7853 copia de dos en dos a la tabla de "
     "nombres de la RAM", "p01:7853", 8),
    (1, 0x7D8D, 0x7D9D, "saltos_por_vuelta", "8 punteros, uno por vuelta (0xE20F), a las tablas "
     "de destinos de p01:7D85 (L_4085: HL = tabla, A = 0xE33D)", "p01:7D7E", "w8"),
    (1, 0x7D9D, 0x7DD9, "destinos_7D9B", "las tablas de destinos de p01:7D85: 0x7D9B (6, su "
     "primera palabra es la ultima de 0x7D8D), 0x7DA7 (7), 0x7DB5 (8) y 0x7DC5 (10)", "p01:7D85",
     "w8"),
]


TABLAS += [
    (1, 0x7FFF, 0x8000, "partida_7FFF", "el primer byte (0x3A) de `ld a,(0xE20F)`, la instruccion "
     "de p01:7FFF que acaba en el banco 2: su operando son 0x8000-0x8001 del banco que haya en "
     "0x8000 (el 2: p01:7E90 la llama con los bancos 1-2-3), y sigue en p02:8002", "p01:7E90", 1),
    (2, 0x8000, 0x8002, "partida_8000", "el operando (0xE20F) de `ld a,(nn)`, la instruccion que "
     "empieza en p01:7FFF; el codigo sigue en 0x8002", "p01:7FFF", 2),
    (2, 0x9FFE, 0xA000, "partida_9FFE", "`ld (ix+d),a` (DD 77), que acaba en el banco 3: el "
     "desplazamiento (0x30) es el primer byte de p03:A000, y el codigo sigue en p03:A001",
     "p02:9FFE", 2),
    (3, 0xA000, 0xA001, "partida_A000", "el desplazamiento (0x30) de `ld (ix+0x30),a`, la "
     "instruccion que empieza en p02:9FFE; detras, p03:A001 es su `ret`", "p02:9FFE", 1),
    (2, 0x806D, 0x8074, "tabla_806D", "8 bytes, uno por vuelta (0xE20F), que p02:8060 pone en "
     "0xE331; el octavo es el primero de 0x8074", "p02:8066", 7),
    (2, 0x8074, 0x80BC, "tabla_8074", "8 filas de 9 bytes, una por vuelta: p02:804A lee 0x8074 + "
     "9 x 0xE20F + 0xE33D", "p02:805D", 9),
    (2, 0x8148, 0x8156, "listas_por_vuelta", "7 punteros (vueltas 1 a 7: p02:80E5 lee 0x8146 + 2 x "
     "0xE20F con L_4B67, y la 0 caeria en el `ret` de delante) a listas [casilla][valor]",
     "p02:80EB", "w7"),
    (2, 0x8156, 0x8196, "listas_8156", "las listas de p02:80EF: pares [casilla de 0xE333][valor] "
     "hasta un 0 (0x8156, 0x8163, 0x8172, 0x8174 y 0x8185, que comparten finales)", "p02:80EF", 16),
    (2, 0x81CA, 0x81DA, "inicio_E334", "9 bytes que p02:81A0 copia a 0xE334 y 7 a 0xE430",
     "p02:81A0", 16),
    (2, 0x84CA, 0x8526, "tabla_84CA", "92 bytes que p02:84AA lee con (DE) - 0x1F < 0x5C (L_5CA6)",
     "p02:84B3", 16),
    (2, 0x8762, 0x8768, "tabla_8762", "3 punteros que p02:873D lee con IX+06 (L_4B67)", "p02:8748",
     "w3"),
    (2, 0x8768, 0x8798, "filas_8768", "3 filas de 16 bytes (las de 0x8762), que p02:874B recorre",
     "p02:874B", 16),
    (2, 0x9026, 0x9034, "tabla_9026", "7 palabras (0xE357 de 1 a 7; p02:900D lee 0x9024 + 2 x A "
     "con L_4B67, y la 0 caeria en el `ld (hl),a / ret` de delante)", "p02:9013", "w7"),
    (2, 0x94D9, 0x95D9, "arcotangente", "16 x 16 bytes: el angulo (0x00-0x3F) para cada par "
     "|dx|/16, |dy|/16 que p02:9492 calcula (0x94D9 + 16 x fila + columna)", "p02:949D", 16),
    (2, 0x95D9, 0x9619, "seno", "64 bytes que suben de 0x00 a 0xFF: p02:9425 lee 0x95D9 + "
     "(0x3F - E) y 0x95D9 + E", "p02:942C", 16),
    (2, 0x9619, 0x9621, "tabla_9619", "4 pares que p02:9644 lee con (IX+02 / 2) & 6 y pone en "
     "IX+30 e IX+31", "p02:9654", 2),
    (2, 0x9621, 0x9629, "tabla_9621", "4 palabras que p02:963F y p03:B204 leen con L_4B67",
     "p02:963F", "w4"),
    (2, 0x97B9, 0x97BD, "tabla_97B9", "4 bytes (IX+02 de 1 a 4: p02:976A lee 0x97B8 + IX+02 con "
     "L_5CA6, y la 0 caeria en el codigo de delante)", "p02:9770", 4),
    (2, 0x9998, 0x99A0, "tabla_9998", "dos tablas de 4 bytes (0x9998 y 0x999C) que p02:9989 pasa "
     "a L_9B31 segun el bit 0 de IX+19", "p02:9995", 4),
    (2, 0x9AAA, 0x9AAE, "tabla_9AAA", "4 bytes que p02:9A99 lee con 0xE228 / 4", "p02:9AA3", 4),
    (2, 0x9B48, 0x9B4C, "tabla_9B48", "4 bytes que p02:9B2E pasa a L_9B31", "p02:9B2E", 4),
    (2, 0x9B98, 0x9BA6, "tabla_9B98", "dos tablas de 7 bytes (0x9B98, y 0x9B9F en la fase 4) que "
     "p02:9B85 pasa a L_6361", "p02:9B92", 7),
    (2, 0x9BC1, 0x9BC5, "tabla_9BC1", "4 bytes que p02:9BB1 lee con 0xE228 / 4", "p02:9BBB", 4),
    (2, 0x9BEB, 0x9BF7, "tabla_9BEB", "dos tablas de 6 bytes (0x9BEB, y 0x9BF1 en la fase 4) que "
     "p02:9BCB lee con IX+25", "p02:9BD8", 6),
    (2, 0x9C3C, 0x9C40, "tabla_9C3C", "4 bytes que p02:9C36 pasa a L_9B31", "p02:9C36", 4),
    (2, 0x9C87, 0x9C8D, "tabla_9C87", "6 bytes que p02:9C71 lee con IX+27 (de 0 a 5)",
     "p02:9C80", 6),
    (2, 0x9CBB, 0x9CBF, "tabla_9CBB", "4 bytes que p02:9CAA lee con 0xE228 / 4", "p02:9CB4", 4),
    (2, 0x9D63, 0x9D6D, "tablas_9D63", "dos tablas de 4 bytes (0x9D63, y 0x9D67 en la fase 5) que "
     "p02:9CCA lee, y 2 bytes en 0x9D6B que lee p02:9CE5", "p02:9CCA", 4),
    (2, 0x9F18, 0x9F20, "tabla_9F18", "4 pares que p02:9EFC lee (0x9F18 o 0x9F1A segun IX+0A, y "
     "el bit 0 de IX+27)", "p02:9F00", 2),
    (2, 0x9FCD, 0x9FED, "tabla_9FCD", "8 fichas de 4 bytes que p02:9F9D elige al azar (ld a,r & 7) "
     "con L_4B67", "p02:9FA5", 4),
]


TABLAS += [
    (2, 0x80BC, 0x80BD, "tabla_8074_cola", "el byte de detras de las 8 filas de 0x8074: la casilla "
     "9 de la fila 7, si 0xE33D llegara a 9", "p02:805D", 1),
    (3, 0xA013, 0xA017, "tabla_A013", "4 bytes que p03:A002 lee con (0xE1C3 / 4) & 3 y pone en "
     "IX+31", "p03:A00C", 4),
    (3, 0xA0FC, 0xA108, "tabla_A0FC", "6 palabras que p03:A0DC lee con B (3 mas si el bit 0 de "
     "0xE38B) con L_4B67", "p03:A0EB", "w6"),
    (3, 0xA245, 0xA255, "tabla_A245", "16 bytes que p03:A22F lee en 0xA226 + IX+07 (de 0x1F a "
     "0x2E) con L_5CA6 y pone en IX+0D", "p03:A23F", 16),
    (3, 0xA43F, 0xA447, "tabla_A43F", "8 bytes que p03:A40E lee con IX+26", "p03:A414", 8),
    (3, 0xA485, 0xA48D, "tabla_A485", "8 bytes delante de 0xA48D que no lee nadie a la vista (las "
     "referencias a 0xA485 y 0xA488 son del banco 10)", "nadie", 8),
    (3, 0xA48D, 0xA495, "tabla_A48D", "8 bytes que p03:A456 lee al azar (ld a,r & 7) y a los que "
     "suma 2 x 0xE228", "p03:A45D", 8),
    (3, 0xA62C, 0xA63C, "tabla_A62C", "8 palabras que p03:A621 lee con 0xE228 / 2 (L_4B67)",
     "p03:A629", "w8"),
    (3, 0xA70D, 0xA711, "tabla_A70D", "4 bytes que p03:A704 pasa a L_6361 (BC = 0x0304)",
     "p03:A707", 4),
    (3, 0xA741, 0xA759, "tabla_A741", "4 fichas de 6 bytes que p03:A71B elige con L_4C24 & 6",
     "p03:A72A", 6),
    (3, 0xA879, 0xA8C5, "fichas_E407", "fichas de 4 bytes que p03:A7C1 copia a 0xE407: 0xA879 y "
     "0xA881 (2 cada una, segun el bit 7 de 0xE1C2 y el 3 de 0xE1C3), 0xA889 (3), 0xA895 (6) y "
     "0xA8AD (6, una por paso de 0xE441)", "p03:A7C1", 4),
    (3, 0xA94E, 0xA98E, "tabla_A94E", "16 fichas de 4 bytes que p03:A902 lee con 0xE1C9 & 0x0F",
     "p03:A90C", 4),
    (3, 0xA9F4, 0xA9FC, "tabla_A9F4", "4 punteros (0xE44E de 0 a 3) que p03:A9B8 lee con L_4B67",
     "p03:A9BB", "w4"),
    (3, 0xA9FC, 0xAA2F, "fichas_A9FC", "3 fichas de 17 bytes: la cuenta (a 0xE44F) y cuatro "
     "grupos de 4 que p03:A9E1 suma a la posicion y copia a 0xE418, 0xE41C, 0xE428 y 0xE42C",
     "p03:A9BF", 17),
    (3, 0xAA93, 0xAA9B, "tabla_AA93", "4 pares que p03:AA82 lee con 0xE40D & 3 y copia a DE",
     "p03:AA8B", 2),
    (3, 0xAB72, 0xAB92, "tabla_AB72", "16 pares (dx, dy) que p03:AB39 lee con 0xE1C3 & 0x0F, y "
     "suma a 0xE404", "p03:AB4B", 2),
    (3, 0xB1F0, 0xB1F8, "tabla_B1F0", "4 pares (dx, dy) que p03:B1D3 lee con IY+08 & 3",
     "p03:B1DC", 2),
    (3, 0xB2FD, 0xB375, "fichas_B2FD", "30 fichas de 4 bytes (IX+0D de 1 a 30: p02:8A87 lee "
     "0xB2F9 + 4 x IX+0D, y la 0 caeria en el codigo de delante)", "p02:8A93", 4),
    (3, 0xB375, 0xB3A7, "tabla_B375", "50 bytes que p02:8B78 lee con A (si es 0x35 o mas, A - "
     "0x16)", "p02:8B84", 10),
    (3, 0xB4FB, 0xB50B, "tabla_B4FB", "16 bytes que p03:B4ED lee con IX+07 y pone en IX+0D (0xFF: "
     "nada)", "p03:B4F3", 16),
    (3, 0xB6D1, 0xB6D5, "tabla_B6D1", "4 bytes que p03:B68C lee con 0xE35C", "p03:B692", 4),
    (3, 0xB6D5, 0xB6E1, "tabla_B6D5", "6 pares que p03:B673 lee con IX+0D - 1", "p03:B67B", 2),
    (3, 0xB98C, 0xB992, "tabla_B98C", "6 bytes que p03:B976 lee con IX+02 (de 0 a 5) y pone en "
     "IX+31", "p03:B985", 6),
    (3, 0xBB78, 0xBB84, "tablas_BB78", "tres tablas de 4 bytes que p03:BB50 pasa a L_9B31: 0xBB78, "
     "0xBB7C en la fase 5 y 0xBB80 en la 3", "p03:BB66", 4),
    (3, 0xBB84, 0xBB90, "tabla_BB84", "12 bytes que p03:BB24 lee con IX+19", "p03:BB2A", 12),
    (3, 0xBC5D, 0xBC63, "tabla_BC5D", "3 pares que p03:BC3D recorre", "p03:BC44", 2),
    (3, 0xBE07, 0xBE87, "inicio_por_vuelta", "8 filas de 16 bytes, una por vuelta (0xE20F): "
     "p03:BDD8 copia 9 a 0xE334 y 7 a 0xE430", "p03:BDE2", 16),
    (3, 0xBEAA, 0xBEB0, "palabras_clave", "3 punteros (C en p03:BDB9, con L_4B67) a las palabras "
     "que se comparan con lo tecleado en 0xE3E8", "p03:BDBD", "w3"),
    (3, 0xBEB0, 0xBECA, "textos_clave", "las tres palabras, acabadas en 0x0D: LARS18TH, NEMESIS "
     "y METALION", "p03:BDC3", 9),
    (3, 0xBEF2, 0xBF3A, "teclado", "9 filas de 8: el caracter de cada tecla de la matriz del "
     "teclado (p03:BEDE: 0xBEF2 + 8 x fila + bit), del 0 a la Z", "p03:BEE6", 8),
    (3, 0xBFF6, 0xC000, "relleno_ff", "10 bytes a 0xFF hasta el final del banco: relleno",
     "nadie", 10),
]


def listas_dos_caminos():
    """Listas de p00:4A6B / p00:4A82 cuyo DE llega por dos caminos (el
    trazador no lo sabe): p00:5BAC o p00:5BB2, y p00:5734 o p00:5739."""
    v = B.ventana_de(3)
    for a, sitio in ((0xB250, "p00:5BB5"), (0xB25A, "p00:573E")):
        B.declara(v, a, lista_vram(v, a), "lista_%04X" % a,
                  "lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro destino; 0xFF acaba)",
                  sitio)


TABLAS += [
    (11, 0xA44D, 0xA4D1, "filas_A44D", "33 filas de 4 caracteres que p11:A412 copia (IX+0C filas) a "
     "la tabla de nombres de la RAM", "p11:A41D", 4),
    (11, 0xA566, 0xA56C, "tabla_A566", "3 punteros (IX+0B) que p11:A55E lee con L_4B60", "p11:A561",
     "w3"),
    (11, 0xA56C, 0xA5F0, "dibujos_A56C", "3 bloques de 44 bytes (0xA56C, 0xA598 y 0xA5C4), los de "
     "0xA566", "p11:A564", 16),
    (11, 0xA634, 0xA644, "tabla_A634", "16 bytes que p11:A619 lee con IX+2B & 0x0F y pone en "
     "IX+31, +37, +3B y +3F", "p11:A624", 16),
    (11, 0xA73A, 0xA744, "tabla_A73A", "10 bytes que p11:A703 recorre (B = 5) comparando con la "
     "distancia en X", "p11:A706", 10),
    (11, 0xA75C, 0xA766, "tablas_A75C", "dos tablas de 5 bytes (0xA75C y 0xA761) que p11:A74C y "
     "p11:A756 leen con L_5CA6", "p11:A74F", 5),
    (11, 0xA788, 0xA78B, "tabla_A788", "3 bytes que p11:A766 lee con IX+25 - 1", "p11:A76D", 3),
    (11, 0xA7BF, 0xA811, "filas_A7BF", "filas de 8 bytes que p11:A71E lee con C x 8: la primera "
     "va a IX+30 y la direccion del resto a IX+26/27", "p11:A725", 8),
    (11, 0xA82A, 0xA82E, "tabla_A82A", "4 bytes que p11:A81D lee con IX+0B", "p11:A823", 4),
    (11, 0xA875, 0xA8B5, "piezas_A875", "4 piezas de 4 x 4 caracteres (IX+0C de 1 a 4: p11:A84B "
     "lee 0xA865 + 16 x IX+0C, y la 0 caeria en el codigo de delante)", "p11:A852", 4),
    (11, 0xA900, 0xA90A, "objeto_A900", "10 bytes que p11:A8D3 pasa a L_A8E1 (con A = 0x11)",
     "p11:A8D6", 10),
    (11, 0xAAF9, 0xAAFD, "tabla_AAF9", "4 bytes que p11:AAB0 lee con 0xE340 - 1", "p11:AAB7", 4),
    (11, 0xABBA, 0xABD2, "tabla_ABBA", "6 fichas de 4 bytes que p11:AB7B recorre", "p11:AB80", 4),
    (11, 0xAC49, 0xAC53, "objeto_AC49", "10 bytes que p11:AC39 pasa a L_A8E1 (con A = 0x22)",
     "p11:AC3E", 10),
    (11, 0xAD53, 0xAD5D, "objeto_AD53", "10 bytes que p11:AD47 pasa a L_A8E1 (con A = 0x1A)",
     "p11:AD4A", 10),
    (11, 0xAE21, 0xAE29, "tabla_AE21", "4 palabras (B de 1 a 4: p11:ADEC lee 0xAE1F + 2 x B, y la "
     "0 caeria en el codigo de delante)", "p11:ADEF", "w4"),
    (11, 0xAE58, 0xAE62, "objeto_AE58", "10 bytes que p11:AE48 pasa a L_A8E1 (con A = 0x37)",
     "p11:AE4D", 10),
    (11, 0xAFFE, 0xB008, "objeto_AFFE", "10 bytes que p11:AFD9 copia a IX (ldir)", "p11:AFDF", 10),
    (11, 0xB080, 0xB088, "tabla_B080", "8 bytes que p11:B070 lee con 0xE228 / 2", "p11:B078", 8),
    (11, 0xB0F9, 0xB109, "tabla_B0F9", "4 fichas de 4 bytes que p11:B0F1 pasa a L_AB80",
     "p11:B0F6", 4),
    (11, 0xB179, 0xB193, "guion_B179", "fichas de 3 bytes que p11:B124 lee con 0xE377 x 3, y "
     "FF FF acaba", "p11:B12D", 3),
    (11, 0xB2A8, 0xB2B8, "tabla_B2A8", "16 bytes que p11:B225 lee con 0xE228 (+8 con el bit 6 de "
     "IX+00, y como mucho 15)", "p11:B239", 16),
    (11, 0xB35C, 0xB362, "tabla_B35C", "6 bytes que p11:B20A lee con IX+02 (de 0 a 5)",
     "p11:B219", 6),
    (11, 0xB362, 0xB368, "tabla_B362", "3 punteros que p11:B2E8 lee con L_4B60", "p11:B2EB", "w3"),
    (11, 0xB368, 0xB410, "bloques_B368", "3 bloques de 56 bytes (0xB368, 0xB3A0 y 0xB3D8), los de "
     "0xB362", "p11:B2EE", 8),
    (11, 0xB49E, 0xB4AA, "posiciones_B49E", "5 posiciones del scroll y 0xFFFF que p11:B432 lee "
     "con 0xE36B (L_4B67)", "p11:B438", "w6"),
    (11, 0xB5D5, 0xB5DF, "tabla_B5D5", "5 punteros que p11:B562 lee con IX+06 (L_4B67)",
     "p11:B568", "w5"),
    (11, 0xB5DF, 0xB66B, "piezas_B5DF", "5 piezas de 4 filas de 7 caracteres (las de 0xB5D5) que "
     "p11:B56F copia a la tabla de nombres", "p11:B588", 7),
    (11, 0xB66B, 0xB6CD, "filas_B66B", "14 filas de 7 caracteres: p11:B5B8 copia 12 desde "
     "0xB66B + 7 x IX+0C", "p11:B5CF", 7),
    (11, 0xB77B, 0xB77F, "texto_B77B", "3 letras y un 0 que p11:B758 escribe en la VRAM 0x3090",
     "p11:B75E", 4),
    (11, 0xB7A4, 0xB7B4, "textos_B7A4", "dos textos acabados en 0 (letras numeradas desde la A = "
     "1) que p11:B793 y p11:B79C escriben en 0x35D8 y 0x34D8", "p11:B75E", 16),
    (11, 0xB7B4, 0xB81C, "fuente_cifras", "13 caracteres de 8 bytes (las cifras y tres signos) que "
     "p11:B6CD, B6F0, B713 y B74C copian a la VRAM", "p11:B6D6", 8),
    (11, 0xB81C, 0xB8F4, "fuente_letras", "27 caracteres de 8 bytes (las letras) que p11:B6D9 y "
     "los de al lado copian a la VRAM, y p11:B76B saca de uno en uno", "p11:B6E2", 8),
    (11, 0xB987, 0xB997, "tablas_B987", "tablas de 4 bytes (0xB987 y 0xB98B segun IX+32) que "
     "p11:B959 lee", "p11:B965", 4),
    (11, 0xB997, 0xB9A0, "tabla_B997", "9 bytes que p11:B941 lee con L_5CA6", "p11:B941", 9),
    (11, 0xBABB, 0xBAC1, "tabla_BABB", "6 bytes que p11:BA96 recorre (B = 6)", "p11:BA9B", 6),
    (11, 0xBF0B, 0xBF10, "tabla_BF0B", "5 bytes que p11:BEE6 lee con IX+19 - 1", "p11:BEED", 5),
    (11, 0xBFFF, 0xC000, "relleno_ff", "un 0xFF al final del banco: relleno", "nadie", 1),
]


def musica_por_scroll(v, a):
    """p01:7CC2: fichas [posicion lo hi][sonido] hasta la posicion 0xFFFF."""
    while v.w(a) != 0xFFFF:
        a += 3
    return a + 3


def tablas_de_codigo():
    v = B.ventana_de(1)
    por_fase(v, 0x7CE6, 12, "musica_por_fase", "listas [posicion del scroll][sonido] que "
             "p01:7CB4 lee con L_4B67", "p01:7CBA", musica_por_scroll,
             "lista de p01:7CC2 de %s: fichas [posicion del scroll lo hi][sonido]; al pasar por "
             "la posicion suena el sonido (p00:4AE4), y la 0xFFFF acaba", F_bloque=3)

    listas_dos_caminos()
    for b, ini, fin, nom, texto, lector, F in TABLAS:
        B.declara(B.ventana_de(b), ini, fin, nom, texto, lector, F=F)


# ------------------------------------------------ guiones de las fases
#
# Las fases se cuentan por la posicion del scroll (0xE203). Varias listas
# por fase dicen que pasa al llegar a cada posicion; un contador por lista
# (0xE37D, 0xE37C, 0xE358, 0xE359) avanza ficha a ficha. Una ficha con la
# posicion 0xFFFF no se alcanza nunca: acaba la lista. Muchas listas comparten
# la cola con la de otra fase, y el ultimo byte de una (el dato de la ficha
# 0xFFFF, que no se lee) es a veces el primero de lo que va detras.


def fichas_hasta_ffff(v, a, largo):
    """Fichas de `largo` bytes con la posicion en las dos primeras, hasta la
    de posicion 0xFFFF (incluida)."""
    while v.w(a) != 0xFFFF:
        a += largo
    return a + largo


def listas_por_fase(v, tabla, n, largo, nom, que, lector, recorre_ficha, hasta=None):
    B.declara(v, tabla, tabla + 2 * n, nom, "%d punteros, uno por fase (0xE201): %s" % (n, que),
              lector, F="w6")
    ps = sorted({v.w(tabla + 2 * k) for k in range(n)})
    fin = max(fichas_hasta_ffff(v, q, largo) for q in ps)
    nota = ""
    if hasta is not None and hasta < fin:
        nota = ("; el dato de la ultima ficha 0xFFFF (que se lee pero no se usa) son los %d "
                "primeros bytes de lo que va detras, en 0x%04X" % (fin - hasta, hasta))
        fin = hasta
    B.declara(v, ps[0], fin, nom + "_fichas", "las listas de %s: %s; las de varias fases comparten "
              "fichas y acaban en la de posicion 0xFFFF%s" % (nom, recorre_ficha, nota), lector, F=largo)
    return fin


def guiones():
    v12 = B.Ventana((1, 2, 12))
    v14 = B.Ventana((13, 14, 15))
    # banco 12
    B.declara(v12, 0xBA12, 0xBA2A, "guion_BA12", "12 punteros, uno por fase, a las listas que "
              "p02:8879 lee con 0xE359 x 3 (L_4B67 y L_407F)", "p02:8882", F="w6")
    B.declara(v12, 0xBA2A, 0xBB72, "guion_BA12_fichas", "las listas de 0xBA12: fichas de 3 bytes "
              "[posicion lo][posicion hi (3 bits) y marcas][dato] que p02:888F compara con el scroll; "
              "acaban en una de posicion 0xFFFF, cuyo dato es a veces el primer byte de la lista de "
              "otra fase (0xBA53) o de la tabla de 0xBB72", "p02:888F", F=3)
    listas_por_fase(v12, 0xBB72, 12, 3, "enemigos_BB72", "las oleadas de enemigos que p00:5130 "
                    "crea al pasar por cada posicion (0xE37D, L_4C32)", "p00:5139",
                    "fichas [posicion lo hi][tipo y cuantos]", hasta=0xBBB9)
    B.declara(v12, 0xBBB9, 0xBC09, "tabla_BBB9", "8 fichas de 10 bytes que p00:5C48 lee con "
              "(0xE1C3 & 7) x 10", "p00:5C59", F=10)
    B.declara(v12, 0xBC09, 0xBEF1, "caracteres_BC09", "0x2E8 bytes de dibujos de caracteres que "
              "p00:5E32 copia tal cual (LDIRVM) a la VRAM 0x2508 en los tres tercios", "p00:5E3B",
              F=8)
    B.declara(v12, 0xBEF1, 0xBF19, "caracteres_BEF1", "0x28 bytes de dibujos de caracteres que "
              "p00:5E3E copia tal cual a la VRAM 0x2108 en los tres tercios", "p00:5E47", F=8)
    v9 = B.Ventana((1, 2, 9))
    B.declara(v9, 0xAFF8, 0xB3D0, "caracteres_AFF8", "0x3D8 bytes de dibujos de caracteres que "
              "p00:5E20 copia tal cual (LDIRVM) a la VRAM 0x2130 en los tres tercios", "p00:5E2C",
              F=8)
    # banco 14
    listas_por_fase(v14, 0x9554, 12, 3, "guion_9554", "las listas que p01:657C lee con 0xE358 "
                    "(L_4C32)", "p01:6585", "fichas [posicion lo hi][dato]", hasta=0x99C7)
    listas_por_fase(v14, 0x9A67, 9, 4, "guion_9A67", "las listas que p01:6F64 lee con 0xE37C "
                    "(p01:6F9A, fases 0 a 8)", "p01:6F6D", "fichas [posicion lo hi][dos datos]",
                    hasta=0x9BD3)
    B.declara(v14, 0x99C7, 0x99D9, "sucesos_por_fase", "9 punteros, uno por fase de la 0 a la 8, "
              "que p01:6DC2 lee con L_4B60", "p01:6DCB", F="w9")
    B.declara(v14, 0x99D9, 0x9A67, "sucesos", "por fase, un byte por cada 32 de scroll (p01:6DCE: "
              "0x99xx + (0xE203 / 32)): sus dos cifras son dos sucesos de la tabla de p01:6E07 "
              "(la baja solo con 0xE228 >= 10)", "p01:6DE0", F=16)
    for tabla, n, sitio in ((0x9222, 5, "p10:B9C0"), (0x9281, 6, "p10:BA1C"), (0x93B4, 8, "p10:BAFF")):
        B.declara(v14, tabla, tabla + 2 * n, "textos_%04X" % tabla, "%d punteros que p10:B9CF lee "
                  "con 0xE496 (L_4B67): listas a la VRAM, y la que empieza por 0 (0x94C3) acaba"
                  % n, sitio, F="w8")
        for k in range(n):
            q = v14.w(tabla + 2 * k)
            if v14(q):
                B.declara(v14, q, lista_vram(v14, q), "lista_%04X" % q, "lista a la VRAM (p00:4A6B) "
                          "de la tabla 0x%04X, entrada %d" % (tabla, k), "p10:B9DA")
    B.declara(v14, 0x94C3, 0x94C4, "lista_vacia", "un 0: la lista vacia con la que p10:B9D5 sabe "
              "que se acabaron las tablas de 0x9222, 0x9281 y 0x93B4", "p10:B9D5", 1)
    B.declara(v14, 0x950F, lista_vram(v14, 0x950F), "lista_950F", "lista a la VRAM (p00:4A6B) que "
              "p10:BBC0 pinta en un MSX japones (0x002B & 0x0F = 0); en los demas, la de 0xBC23 "
              "del banco 10", "p10:BBCD")
    B.declara(v14, 0x9BD3, 0x9C07, "cifras_grandes", "26 punteros (p00:5409, A de 1 a 25 con "
              "L_4B67) a dibujos de 8 filas de 6 bytes", "p00:540C", F="w8")
    B.declara(v14, 0x9C07, 0xA0B7, "cifras_grandes_dibujos", "dibujos de 48 bytes (8 filas de 6) "
              "que p00:541B saca al VDP fila a fila, con un byte de borde a cada lado (0xFF, o "
              "0x00 desde el 0x14)", "p00:5420", F=6)


def de_puntero_en_puntero(v, tabla, n, hasta, nom, texto_tabla, texto_bloque, lector,
                          lector_bloque, F_tabla="w8", F_bloque=16):
    """Tabla de n punteros a bloques que van seguidos: cada uno acaba donde
    empieza el siguiente (ordenados) y el ultimo en `hasta`."""
    B.declara(v, tabla, tabla + 2 * n, nom, texto_tabla, lector, F=F_tabla)
    ps = sorted({v.w(tabla + 2 * k) for k in range(n)} - {0})
    for a, f in zip(ps, ps[1:] + [hasta]):
        ks = [k for k in range(n) if v.w(tabla + 2 * k) == a]
        B.declara(v, a, f, "%s_%04X" % (nom, a), texto_bloque % ", ".join(map(str, ks)),
                  lector_bloque, F=F_bloque)


def banco15():
    v = B.Ventana((13, 14, 15))
    for a, f, fase in ((0xA0B7, 0xA0DB, 7), (0xA0DB, 0xA14D, 9), (0xA14D, 0xA1E0, 10),
                       (0xA1E0, 0xA2AC, 11)):
        B.declara(v, a, f, "guion_fase_%d" % fase, "la lista de la fase %d que p01:7248 da a "
                  "p01:72B2 (0xE3B1 x 3): fichas [dato][posicion lo][posicion hi (3 bits) e Y], "
                  "hasta FF FF FF" % fase, "p01:72C3", F=3)
    for a, f, fase in ((0xA2AC, 0xA362, 3), (0xA362, 0xA41E, 9), (0xA41E, 0xA4CB, 10),
                       (0xA4CB, 0xA561, 11)):
        B.declara(v, a, f, "objetos_fase_%d" % fase, "la lista de la fase %d de p01:6AE0 (0xA2AC "
                  "en la 3, la tabla 0x6B7F en las 9-11; 0xE369 x 3): fichas [posicion lo][bit alto "
                  "de la posicion e Y][tipo], hasta FF FF" % fase, "p01:6AFC", F=3)
    B.declara(v, 0xA561, 0xA583, "tabla_A561", "17 pares (tipos 0 a 16) que p01:6B41 copia (ldi, "
              "ldi) con el tipo de la ficha x 2; el ultimo es tambien la entrada 0 de 0xA581",
              "p01:6B47", F=2)
    de_puntero_en_puntero(v, 0xA583, 16, 0xA6DB, "piezas_A581", "16 punteros (A de 1 a 16: "
                          "p01:6D11 lee 0xA581 + 2 x A con L_4B60, y la 0 es el ultimo par de "
                          "0xA561): piezas que L_5327 pinta en la tabla de nombres",
                          "pieza de caracteres (filas x columnas de IX+04 e IX+05, L_5327) de "
                          "las entradas %s de 0xA581", "p01:6D14", "p01:6D23", F_bloque=8)
    de_puntero_en_puntero(v, 0xB661, 72, 0xBDB2, "formas_B661", "72 punteros que p01:6017 lee "
                          "con IX+07 (L_4B67): formas que p01:6040 copia a la tabla de nombres "
                          "(IX+09 de ancho, IX+0A filas)",
                          "forma de caracteres (de p01:6040) de las entradas %s de 0xB661",
                          "p01:601D", "p01:6046", F_bloque=8)
    ps = [0xBDB2, 0xBE29, 0xBEAA, 0xBF0F, 0xBF80]
    for k, (a, f) in enumerate(zip(ps, ps[1:] + [0xBFEE])):
        B.declara(v, a, f, "tira_fase_%d" % (k + 2), "la tira de la fase %d (tabla p00:5F6D): "
                  "pares que p00:5F46 lee con el contador 0xE1CB+2 (x 2)" % (k + 2), "p00:5F5A",
                  F=16)


def banco9():
    v = B.Ventana((1, 2, 9))
    B.declara(v, 0xB901, 0xB913, "animados_por_fase", "9 punteros, uno por fase de la 0 a la 8 "
              "(0 = ninguno), que p01:6A4A lee con L_4B60", "p01:6A50", F="w9")
    ps = sorted({v.w(0xB901 + 2 * k) for k in range(9)} - {0})
    for a in ps:
        n = v(a) & 0x7F
        ks = [k for k in range(9) if v.w(0xB901 + 2 * k) == a]
        B.declara(v, a, a + 1 + 10 * n, "animados_%04X" % a, "caracteres animados de la%s fase%s %s: "
                  "[cuantos (bit 7: cada 2 cuadros)] y fichas de 10 bytes [caracter][tercios][8 de "
                  "dibujo] que p01:6A57 pasa por turno (0xE3BB) a la VRAM" % (
                      "s" if len(ks) > 1 else "", "s" if len(ks) > 1 else "",
                      ", ".join(map(str, ks))), "p01:6A8D", F=10)
    de_puntero_en_puntero(v, 0xBB01, 32, 0xBF6D, "fichas_BB01", "32 punteros que p01:6816 lee "
                          "con A (L_4B60)", "lo que p01:681E lee de las entradas %s de 0xBB01: "
                          "[C][B] y lo que sigue", "p01:681A", "p01:681E")


def rachas_ed20(v, a):
    """p10:BFD5: n == 0 acaba; con el bit 7, repite el byte siguiente n & 0x7F
    veces; sin el, copia n bytes."""
    while True:
        n = v(a)
        a += 1
        if n == 0:
            return a
        a += 1 if n & 0x80 else n


def banco10():
    v = B.Ventana((1, 2, 10))
    jp = "en un MSX japones (0x002B & 0x0F = 0)"
    for a, otra, sitio in ((0xA933, 0xB151, "p10:A0B4"), (0xBC85, 0xBD1A, "p10:BB69"),
                           (0xB94F, 0x622D, "p01:61DE")):
        B.declara(v, a, lista_vram(v, a), "lista_%04X" % a, "lista a la VRAM (p00:4A6B) que %s "
                  "pinta %s; en los demas, la de 0x%04X" % (sitio, jp, otra), sitio)
        if otra >= 0xA000:
            B.declara(v, otra, lista_vram(v, otra), "lista_%04X" % otra, "lista a la VRAM "
                      "(p00:4A6B) que %s pinta en los MSX no japoneses (en los japoneses, la de "
                      "0x%04X)" % (sitio, a), sitio)
    for a in (0xB832, 0xB7A1):
        B.declara(v, a, rachas_serie(v, a), "rachas_f_%04X" % a, "rachas a la VRAM por filas "
                  "(p10:A67B) que p10:B641 elige: 0xB832 %s, 0xB7A1 en los demas" % jp, "p10:B63E")
    for a in (0xB0AB, 0xB0B1):
        B.declara(v, a, rachas_serie(v, a), "rachas_f_%04X" % a, "rachas a la VRAM por filas "
                  "(p10:A67B) que p10:A10C alterna cada 8 cuadros (0xB0AB y 0xB0B1)", "p10:A121")
    B.declara(v, 0xB461, rachas_ed20(v, 0xB461), "rachas_ED20", "rachas a la RAM 0xED20 (p10:BFCF: "
              "0 acaba; con el bit 7 repite el byte siguiente; sin el, copia n bytes)", "p10:BFD5")
    for a, f, texto, sitio in (
            (0xA352, 0xA35D, "11 bytes que p10:A2E7 lee con el paso 0xE496", "p10:A2ED"),
            (0xB0B7, 0xB0CB, "10 palabras (el paso 0xE496 de 0 a 9) que p10:A3A1 lee con L_4B60",
             "p10:A3A7"),
            (0xB0CB, 0xB0D5, "10 bytes, uno por paso (0xE496), que p10:A3AB pasa en B a L_A717",
             "p10:A3B1"),
            (0xB0D5, 0xB151, "fichas de 3 bytes por paso (0xE496 x 3): [cuantos][puntero] que leen "
             "p10:B700 (0xB0DB, por 0xF000/0xF006) y p10:A4E2 (0xB0E1)", "p10:B700"),
            (0xB5EC, 0xB604, "dos listas de 4 fichas de 3 bytes [dy][dx][dibujo] que p10:BF1E suma a "
             "las posiciones 0x7870 y 0x7890 y copia a 0xE280 y 0xE290", "p10:BF42"),
            (0xB604, 0xB610, "dos listas de 2 fichas de 3 bytes (0xB604 y 0xB60A) que p10:BEAC y "
             "p10:BEBC pasan a L_BF42", "p10:BF42"),
            (0xB8D7, 0xB8F5, "fichas de 3 bytes por paso (0xE496 x 3), [cuantos][puntero], que "
             "p10:B668 deja en 0xF006 (0xB8D7) y 0xF000 (0xB8E6) para L_B700", "p10:B700"),
            (0xB8F5, 0xB904, "la lista que p01:61B9 pasa a p10:A24C (DE = 0xB8F5): bytes hasta un 0",
             "p10:A256"),
            (0xBFF3, 0xC000, "13 bytes a 0xFF hasta el final del banco: relleno", "nadie")):
        B.declara(v, a, f, "tabla_%04X" % a, texto, sitio, F=16)
    B.declara(v, 0xA981, 0xACAB, "listas_A981", "11 listas a la VRAM (p00:4A6B) seguidas, de "
              "0xA981 a 0xACAB: la primera la pinta p10:A0EC %s (en los demas, 0xB1AA), y "
              "p10:A1C5 pasa 0xAB29, de dentro de una de ellas, a L_A245" % jp, "p10:A0F4", F=16)
    B.declara(v, 0xB92B, lista_vram(v, 0xB92B), "lista_2players", "lista a la VRAM sin lector a "
              "la vista: el texto 2PLAYERS en 0x3A6D, la fila de debajo del 1PLAYER de la lista "
              "de 0xB904. El juego es de un jugador y no lo pinta nadie", "nadie")
    for a in (0xB904, 0xB936):
        B.declara(v, a, lista_vram(v, a), "lista_%04X" % a, "lista a la VRAM (p00:4A6B) que pinta "
                  "p01:61C1 (0xB904 con 0xE1C0 < 2; si no, 0xB936)", "p01:61CE")


def piezas_de_enemigos():
    v = B.Ventana((7, 8, 9))
    B.declara(v, 0x9DA5, 0x9EA1, "piezas_por_cuadro", "126 punteros, uno por cuadro (IX+32), que "
              "p00:52B8 lee con L_4B60", "p00:52CB", F="w8")
    B.declara(v, 0x9EA1, 0x9FF4, "piezas_de_enemigos", "las piezas de caracteres de 0x9DA5 que "
              "p00:52ED copia a la tabla de nombres de la RAM (IX+13 filas de IX+14 caracteres, "
              "recortadas por el borde)", "p00:52F1", F=8)


def sin_lector(bancos_=(7, 8, 9)):
    """Lo que queda en los bancos de datos tras todo lo demas: si son rachas
    enteras (el formato de p00:4A8C, acabando justo en el hueco) o ceros, se
    dice asi y sin lector a la vista; si no, se avisa."""
    from paginas import ORG as _ORG
    for b in bancos_:
        v = B.ventana_de(b)
        cod = B.codigo_trazado(b)
        ocupado = bytearray(cod)
        for x in B.BLOQUES:
            if x["p"] == b:
                for i in range(x["ini"] - _ORG[b], x["fin"] - _ORG[b]):
                    ocupado[i] = 1
        i = 0
        while i < 0x2000:
            if ocupado[i]:
                i += 1
                continue
            j = i
            while j < 0x2000 and not ocupado[j]:
                j += 1
            a, f = _ORG[b] + i, _ORG[b] + j
            bs = [v(x) for x in range(a, f)]
            if f == _ORG[b] + 0x2000 and all(x == 0xFF for x in bs):
                i = j
                continue                  # la cola de 0xFF: la declara relleno()
            if all(x == 0 for x in bs):
                B.declara(v, a, f, "ceros_%04X" % a, "%d cero%s entre bloques: rachas vacias (un "
                          "0 acaba), sin lector a la vista" % (len(bs), "" if len(bs) == 1 else "s"),
                          "nadie", F=16)
            else:
                q, n, bien = a, 0, True
                while q < f and bien:
                    # rachas() sin salirse del hueco: tiene que acabar en su 0
                    bien = False
                    while q < f:
                        c = v(q)
                        q += 1
                        if c == 0:
                            bien = True
                            break
                        q += 1 if c < 0x80 else 2 if c == 0x80 else c & 0x7F
                    n += 1
                if bien and q == f:
                    B.declara(v, a, f, "rachas_%04X" % a, "%d tira%s de rachas (el formato de "
                              "p00:4A8C) que acaba%s justo antes de lo siguiente: sin lector a la "
                              "vista" % (n, "" if n == 1 else "s", "" if n == 1 else "n"), "nadie",
                              F=16)
                else:
                    B.AVISOS.append("p%02d %04X-%04X sin explicar: ni ceros ni rachas" % (b, a, f))
            i = j


# ------------------------------------------------------------------ todo

def automaticos():
    """Los punteros que el trazador ve llegar a cada lector."""
    B.por_lector(0x4A8C, "DE", rachas, "rachas",
                 "rachas a la VRAM (p00:4A8C: <0x80 repite, 0x80 destino, >0x80 copia, 0 acaba)")
    B.por_lector(0x4A5B, "DE", rachas, "rachas3",
                 "rachas a la VRAM en los tres tercios (p00:4A5B -> p00:4A8C)")
    B.por_lector(0x4A86, "DE", rachas_con_destino, "rachas_d",
                 "[destino en la VRAM] y rachas (p00:4A86 -> p00:4A8C)")
    for lec in (0x4A6B, 0x4A82):
        B.por_lector(lec, "DE", lista_vram, "lista",
                     "lista a la VRAM (p00:4A6B: [destino] y bytes; 0xFE otro destino; 0xFF acaba)")
    B.por_lector(0x4A73, "DE", lambda v, a: lista_vram(v, a, False), "lista_s",
                 "lista a la VRAM sin destino delante (p00:4A73; 0xFE otro destino; 0xFF acaba)")
    for a, v, sitio in B.punteros(0x4595, "IX"):
        B.declara(v, a, lista_caracteres(v, a, sitio), "caracteres_%04X" % a,
                  "lista de caracteres (p00:4595): fichas de 6 bytes [tercios][colores]"
                  "[caracter][dibujos], 0 acaba", sitio, F=6)
    B.por_lector(0x454E, "IX", lista_copias, "copias",
                 "lista de copias de caracteres VRAM -> VRAM (p00:454E: 4 bytes, 3 si "
                 "el tercero lleva los bits altos; 0 acaba)")
    B.por_lector(0xA67B, "HL", rachas_serie, "rachas_f",
                 "rachas a la VRAM por filas (p10:A67B: <0x80 repite, 0x80 serie "
                 "[cuantos][primero], >0x80 copia, 0 acaba; los ceros no se escriben)")
    B.por_lector(0xA6EB, "DE", rachas, "rachas_ram",
                 "rachas a la RAM (p10:A6EB, el mismo formato que p00:4A8C)")


def todo():
    automaticos()
    sonido()
    mapa()
    banco7()
    banco8()
    tablas_de_codigo()
    guiones()
    banco15()
    banco9()
    banco10()
    piezas_de_enemigos()
    B.por_lector(0x449A, "DE", rachas, "rachas",
                 "rachas a la VRAM 0x18C0 (p00:449A -> p00:4A8C)")
    v8 = B.Ventana((7, 8, 9))
    B.declara(v8, 0x93C0, rachas(v8, 0x93C0), "rachas_93C0", "rachas a la VRAM 0x18C0: p00:4497 "
              "pone DE = 0x93C0 y cae en L_449A, que salta a p00:4A8C", "p00:4497")
    for a, n in ((0x9273, 8), (0x940B, 4)):
        B.declara(v8, a, a + 8 * n, "dibujos_%04X" % a, "%d caracteres de dibujo (8 bytes cada uno) "
                  "que no lee nadie a la vista: no son rachas ni los apunta ninguna palabra del "
                  "cartucho" % n, "nadie", F=8)
    sin_lector()

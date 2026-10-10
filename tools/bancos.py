#!/usr/bin/env python3
"""Trazador de CARTUCHO ENTERO: sigue el flujo saltando de banco a banco.

Por que hace falta, y por que no basta con trazar cada banco por separado:
en un MegaROM la direccion 0x8123 no quiere decir nada por si sola. Segun lo
ultimo que se haya escrito en el registro 0x8000, ahi puede estar el banco 2,
el 5, el 7, el 9 o el 11. Un trazador que mire un banco aislado se para en
cuanto el codigo sale de sus 8 KB, y hay que darle a mano cada destino.

Este trazador lleva la cuenta de que banco hay en cada ranura. Las rutinas
del banco 0 que cambian de banco y vuelven estan en PONE_BANCOS (de
tools/cartucho.py, que es donde vive todo lo de ESTE cartucho), para que el
flujo siga tras el `call` con el reparto nuevo; dentro basta con seguir el
acumulador. Lo que se propaga por cada camino es:

    (pc, banco en 0x6000/0x8000/0xA000, copia en RAM, A, HL, DE)

La copia en RAM (SOMBRA) hace falta porque la interrupcion mete sus bancos
SIN tocarla y luego los devuelve leyendola: sin llevarle la cuenta, el
trazador se queda con el banco de la interrupcion puesto y sigue leyendo el
cartucho por donde no es.

LAS TABLAS DEL DESPACHADOR. Konami pega la tabla de destinos JUSTO DETRAS del
`call` al despachador, asi que el flujo no continua en la instruccion siguiente y hay
que adivinar cuantas palabras tiene. El criterio "hasta el destino mas bajo"
solo, se pasa de largo: tragandose el codigo que va detras. Aqui el
tamano sale de DOS topes a la vez -el destino mas bajo, y el primer byte que
YA se sabe que es codigo por otro camino- y se recalcula en varias pasadas
hasta que deja de moverse. Cada pasada solo puede ACORTAR tablas, nunca
alargarlas, de modo que la contaminacion no se realimenta. Lo que quede mal se
pone a mano en src/tablas.txt.

NO es el trazador que genera el listado -eso lo hace tools/z80trace.py banco a
banco, con las entradas ya escritas y justificadas en src/pNN.entries-. Este
es el que AVERIGUA esas entradas.

Uso:
    bancos.py <rom> informe [dir_src]    cobertura, puntos ciegos, sin resolver
    bancos.py <rom> entradas [dir_src]   las semillas por banco, con su porque
    bancos.py <rom> tablas [dir_src]     las tablas del despachador
    bancos.py <rom> nocode [dir_src]     las tablas en formato .nocode
    bancos.py <rom> escribe [dir_src]    escribe dir_src/pNN.entries y .nocode
"""
import io
import os
import sys
from collections import defaultdict

from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre

# ---------------------------------------------------------------- tablas Z80
BASE_LEN = [1] * 256
for _op, _n in {
    0x01: 3, 0x11: 3, 0x21: 3, 0x31: 3,
    0x22: 3, 0x2A: 3, 0x32: 3, 0x3A: 3,
    0x06: 2, 0x0E: 2, 0x16: 2, 0x1E: 2,
    0x26: 2, 0x2E: 2, 0x36: 2, 0x3E: 2,
    0x10: 2, 0x18: 2, 0x20: 2, 0x28: 2, 0x30: 2, 0x38: 2,
    0xC6: 2, 0xCE: 2, 0xD6: 2, 0xDE: 2,
    0xE6: 2, 0xEE: 2, 0xF6: 2, 0xFE: 2,
    0xD3: 2, 0xDB: 2,
    0xC2: 3, 0xC3: 3, 0xC4: 3, 0xCA: 3, 0xCC: 3, 0xCD: 3,
    0xD2: 3, 0xD4: 3, 0xDA: 3, 0xDC: 3,
    0xE2: 3, 0xE4: 3, 0xEA: 3, 0xEC: 3,
    0xF2: 3, 0xF4: 3, 0xFA: 3, 0xFC: 3,
}.items():
    BASE_LEN[_op] = _n

ED_LEN4 = {0x43, 0x53, 0x63, 0x73, 0x4B, 0x5B, 0x6B, 0x7B}
IDX_DISP = ({0x34, 0x35, 0x36}
            | {0x46, 0x4E, 0x56, 0x5E, 0x66, 0x6E, 0x7E}
            | {0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x77}
            | {0x86, 0x8E, 0x96, 0x9E, 0xA6, 0xAE, 0xB6, 0xBE})
JP_CC = {0xC2, 0xCA, 0xD2, 0xDA, 0xE2, 0xEA, 0xF2, 0xFA}
CALL_CC = {0xC4, 0xCC, 0xD4, 0xDC, 0xE4, 0xEC, 0xF4, 0xFC}
JR_CC = {0x20, 0x28, 0x30, 0x38}
RST = {0xC7, 0xCF, 0xD7, 0xDF, 0xE7, 0xEF, 0xF7, 0xFF}

# Opcodes de un byte que NO tocan el acumulador. Todo lo que no este aqui se
# da por perdido (A pasa a "desconocido"): equivocarse por ese lado solo deja
# un cambio de banco sin resolver, y eso se ve en el informe; equivocarse por
# el otro inventaria un banco, que es justo lo que no puede pasar.
NO_TOCA_A = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x09, 0x0B, 0x0C, 0x0D,
             0x0E, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x18, 0x19, 0x1B,
             0x1C, 0x1D, 0x1E, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x28,
             0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x30, 0x31, 0x32, 0x33, 0x34,
             0x35, 0x36, 0x37, 0x38, 0x39, 0x3B, 0x3F}
NO_TOCA_A |= set(range(0x40, 0x78))          # ld r,r' con destino distinto de A
NO_TOCA_A |= set(range(0xB8, 0xC0))          # cp r
NO_TOCA_A |= {0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC7, 0xC8, 0xC9, 0xCA,
              0xCC, 0xCD, 0xCF,
              0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD7, 0xD8, 0xD9, 0xDA,
              0xDC, 0xDF,
              0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE7, 0xE8, 0xE9, 0xEA,
              0xEB, 0xEC, 0xEF,
              0xF0, 0xF2, 0xF3, 0xF4, 0xF5, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB,
              0xFC, 0xFE, 0xFF}
ED_TOCA_A = {0x44, 0x4C, 0x54, 0x5C, 0x64, 0x6C, 0x74, 0x7C,   # neg y sus alias
             0x57, 0x5F, 0x67, 0x6F, 0x78}

# Lo mismo para HL, que hace falta para ver los `ld (hl),a` con los que INIT
# apunta en RAM que banco ha puesto en cada ranura.
TOCA_HL = {0x09, 0x19, 0x21, 0x23, 0x24, 0x25, 0x26, 0x29, 0x2A, 0x2B, 0x2C,
           0x2D, 0x2E, 0x39, 0xD9, 0xE1, 0xE3, 0xEB}
TOCA_DE = {0x11, 0x13, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x14, 0x15, 0x16, 0xD1,
           0xD9, 0xEB}
TOCA_DE |= set(range(0x50, 0x60))            # ld d,r / ld e,r
ED_TOCA_DE = {0x5B}
ED_TOCA_DE |= set(range(0xA0, 0xC0))         # ldir y compania mueven DE
TOCA_HL |= set(range(0x60, 0x70))            # ld h,r / ld l,r
ED_TOCA_HL = {0x42, 0x52, 0x62, 0x72, 0x4A, 0x5A, 0x6A, 0x7A, 0x6B}
ED_TOCA_HL |= set(range(0xA0, 0xC0))         # ldir, cpir, ...

# Todo lo de ESTE cartucho: ver tools/cartucho.py.
from cartucho import (DESPACHADOR, DESPACHADORES, RANURA_REG, SOMBRA,
                      SOMBRA_RANURA, PONE_ZONA, DEVUELVE_ZONA, PONE_BANCOS,
                      semillas_iniciales)


def pone_bancos(t, s, sombra):
    """El reparto (y la copia en RAM) que deja la subrutina t al volver.

    Si el cartucho tiene banco de zona (cartucho.PONE_ZONA), las que lo
    eligen lo apuntan ademas en la casilla 5 de la sombra, y las que
    devuelven (cartucho.DEVUELVE_ZONA) ponen en 0xA000 lo que haya ahi: si
    el trazador no lo sabe (None) o es cero, se queda el de PONE_BANCOS.
    """
    nuevo = PONE_BANCOS[t]
    s = tuple(n if n is not None else v for n, v in zip(nuevo, s))
    resto = list(sombra[3:])
    if t in PONE_ZONA:
        resto[2] = nuevo[2]
    if t in DEVUELVE_ZONA and resto[2]:
        s = (s[0], s[1], resto[2])
    sombra = tuple(s) + tuple(resto)
    return s, sombra


class Cartucho:
    """Los 128 KB con el mapper puesto: leer un byte exige saber las ranuras."""

    def __init__(self, rom):
        self.rom = rom

    @staticmethod
    def banco(addr, s):
        if 0x4000 <= addr < 0x6000:
            return 0
        if 0x6000 <= addr < 0x8000:
            return s[0]
        if 0x8000 <= addr < 0xA000:
            return s[1]
        if 0xA000 <= addr < 0xC000:
            return s[2]
        return None

    def leer(self, addr, s):
        b = self.banco(addr, s)
        if b is None or b >= N_PAGINAS:
            return None
        return self.rom[b * TAM_PAGINA + (addr & 0x1FFF)]


MIN_RELLENO = 16


def carga_datos(ruta):
    """Los bancos que son biblioteca de datos: 'pNN  # por que'.

    El trazador no puede deducirlos solo, porque el juego cambia de banco con
    las interrupciones abiertas y se protege con un semaforo en RAM que este
    trazador no modela. Ver src/datos.txt, que lleva la justificacion de cada
    uno.
    """
    fuera = {}
    if not ruta or not os.path.exists(ruta):
        return fuera
    for ln in io.open(ruta, encoding="utf-8"):
        crudo, _, coment = ln.partition("#")
        crudo = crudo.strip()
        if crudo.startswith("p") and crudo[1:].isdigit():
            fuera[int(crudo[1:], 10)] = coment.strip() or "declarado en datos.txt"
    return fuera


def relleno_de_cola(rom):
    """Los bytes 0xFF con los que acaba cada banco, cuando son bastantes.

    No es una suposicion: seis de los dieciseis bancos acaban en una tira de
    0xFF -158 bytes el 1, 567 el 6, 321 el 9, 771 el 11, 807 el 13 y 18 el 0-
    y ahi no hay nada que ejecutar. Importa porque 0xFF es `rst 38h`, o sea
    una instruccion valida de un solo byte: un trazador que se meta en el
    relleno lo recorre entero, se sale por el final del banco y aparece en
    medio del banco que hubiera en la ranura siguiente. Es exactamente lo que
    pasaba aqui -el relleno del banco 1 desembocaba en el 12, que son datos- y
    de ahi salian 14 KB de codigo inventado.

    El minimo de 16 bytes deja fuera las colas cortas, donde una tira de 0xFF
    puede ser un dato de verdad (el banco 15 acaba en dos y se quedan como
    estan).

    Devuelve {banco: primera direccion de ejecucion del relleno}.
    """
    fuera = {}
    for b in range(N_PAGINAS):
        blq = rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
        i = len(blq)
        while i > 0 and blq[i - 1] == 0xFF:
            i -= 1
        if len(blq) - i >= MIN_RELLENO:
            fuera[b] = ORG[b] + i
    return fuera


def carga_sitios(ruta):
    """Sitios con el reparto FORZADO: 'pNN 0xPC b6000 b8000 bA000  # por que'.

    El trazador junta en una misma instruccion todos los repartos con los que
    llega a ella por algun camino, y en este cartucho eso sobra: tras elegir
    un banco de zona (p00:4913-4925) la sombra 0xF0F6 lo guarda para siempre,
    y cualquier `call p00:4198` posterior lo devuelve a 0xA000, de modo que el
    trazador acaba entrando en el codigo de los actores (banco 3) con el 6, el
    12 o el 15 puestos y lee graficos y textos como instrucciones. En la
    maquina eso no pasa: esos manejadores corren siempre con el 3. Cada linea
    de src/sitios.txt dice que reparto hay DE VERDAD en esa instruccion, y de
    donde sale (medida de openMSX o el listado de Manuel Pazos, que es de este
    mismo binario).
    """
    fuera = {}
    if not ruta or not os.path.exists(ruta):
        return fuera
    for ln in open(ruta, encoding="utf-8"):
        crudo = ln.partition("#")[0].split()
        if len(crudo) >= 7 and crudo[0] == "entrada":
            # 'entrada pNN 0xCALL k b6000 b8000 bA000': la entrada k de la
            # tabla del despachador de ese call se sigue con ese reparto
            fuera[("entrada", int(crudo[1][1:], 10), int(crudo[2], 0), int(crudo[3], 0))] = (
                int(crudo[4], 0), int(crudo[5], 0), int(crudo[6], 0))
        elif len(crudo) >= 5 and crudo[0].startswith("p"):
            fuera[(int(crudo[0][1:], 10), int(crudo[1], 0))] = (
                int(crudo[2], 0), int(crudo[3], 0), int(crudo[4], 0))
    return fuera


class TrazadorDeBancos:
    def __init__(self, rom, tam_tablas=None, sin_tablas=False,
                 bancos_datos=None, sitios=None):
        self.c = Cartucho(rom)
        self.rom = rom
        self.sitios = dict(sitios or {})
        self.marcado = [bytearray(TAM_PAGINA) for _ in range(N_PAGINAS)]
        self.arranques = set()                 # (banco, addr) inicio de instruccion
        self.entradas = defaultdict(set)       # banco -> {addr}
        self.porque = {}                       # (banco, addr) -> justificacion
        self.ciegos = set()                    # (banco, addr, clase)
        self.externos = defaultdict(set)       # destino -> {(banco, addr)}
        self.sin_resolver = set()              # (banco, addr, registro)
        self.cambios = set()                   # (banco, addr, registro, valor)
        self.tablas = {}                       # (banco, call) -> (tab, n, destinos)
        self.tam_tablas = dict(tam_tablas or {})
        self.sin_tablas = sin_tablas
        self.configs = set()                   # repartos de banco vistos
        self.partidas = set()                  # instrucciones a caballo de dos bancos
        self.llamadas = []                     # (destino, banco, pc, ranuras, HL, DE)
        self.config_de = defaultdict(set)      # (banco, pc) -> repartos con los que se ejecuta
        self.vistos = set()
        self.relleno = relleno_de_cola(rom)
        self.bancos_datos = dict(bancos_datos or {})
        self._efectos = {}                     # (banco, t, s) -> efecto
        self.resumidas = set()                 # (banco, pc, t, reparto) tras call
        self.ambiguas = set()                  # subrutinas con vueltas distintas

    # ---------------------------------------------------------------- lectura
    def byte(self, addr, s):
        return self.c.leer(addr, s)

    def word(self, addr, s):
        lo, hi = self.byte(addr, s), self.byte(addr + 1, s)
        if lo is None or hi is None:
            return None
        return lo | (hi << 8)

    def ilen(self, addr, s):
        op = self.byte(addr, s)
        if op is None:
            return 0
        if op == 0xCB:
            return 2
        if op == 0xED:
            return 4 if self.byte(addr + 1, s) in ED_LEN4 else 2
        if op in (0xDD, 0xFD):
            o2 = self.byte(addr + 1, s)
            if o2 is None:
                return 0
            if o2 == 0xCB:
                return 4
            if o2 in (0xDD, 0xFD, 0xED):
                return 1
            return 1 + BASE_LEN[o2] + (1 if o2 in IDX_DISP else 0)
        return BASE_LEN[op]

    def toca_a(self, addr, s):
        op = self.byte(addr, s)
        if op == 0xCB:
            o2 = self.byte(addr + 1, s)
            if o2 is None or 0x40 <= o2 < 0x80:
                return o2 is None
            return (o2 & 7) == 7
        if op == 0xED:
            return self.byte(addr + 1, s) in ED_TOCA_A
        if op in (0xDD, 0xFD):
            o2 = self.byte(addr + 1, s)
            if o2 is None:
                return True
            return False if o2 == 0xCB else o2 not in NO_TOCA_A
        return op not in NO_TOCA_A

    def toca_hl(self, addr, s):
        op = self.byte(addr, s)
        if op == 0xCB:
            o2 = self.byte(addr + 1, s)
            if o2 is None:
                return True
            if 0x40 <= o2 < 0x80:
                return False
            return (o2 & 7) in (4, 5)
        if op == 0xED:
            return self.byte(addr + 1, s) in ED_TOCA_HL
        if op in (0xDD, 0xFD):
            return self.byte(addr + 1, s) in (0x66, 0x6E)
        return op in TOCA_HL

    def toca_de(self, addr, s):
        op = self.byte(addr, s)
        if op == 0xCB:
            o2 = self.byte(addr + 1, s)
            if o2 is None:
                return True
            if 0x40 <= o2 < 0x80:
                return False
            return (o2 & 7) in (2, 3)
        if op == 0xED:
            return self.byte(addr + 1, s) in ED_TOCA_DE
        if op in (0xDD, 0xFD):
            return self.byte(addr + 1, s) in (0x56, 0x5E)
        return op in TOCA_DE

    # ---------------------------------------------------------------- trazado
    def traza(self, semillas):
        """semillas: lista de (addr, (b6000, b8000, bA000), justificacion)."""
        pila = []
        for addr, s, just in semillas:
            s = tuple(s)
            b = self.c.banco(addr, s)
            if b is not None:
                self.entradas[b].add(addr)
                self.porque.setdefault((b, addr), just)
            # las casillas de la sombra que no son ranura arrancan sin valor
            extra = (None,) * (len(SOMBRA) - 3)
            pila.append((addr, s, tuple(s) + extra, None, None, None))
        while pila:
            pc, s, sombra, a, hl, de = pila.pop()
            while True:
                b = self.c.banco(pc, s)
                if b is None or b >= N_PAGINAS:
                    break
                if b in self.bancos_datos:
                    break                      # banco de datos: ver src/datos.txt
                r = self.relleno.get(b)
                if r is not None and pc >= r:
                    break                      # relleno 0xFF de cola: no es codigo
                if (b, pc) in self.sitios:     # reparto forzado: src/sitios.txt
                    s = self.sitios[(b, pc)]
                    sombra = tuple(s) + tuple(sombra[3:])
                    if self.c.banco(pc, s) != b:
                        continue               # otro banco: se mira de nuevo con el
                clave = (pc, s, sombra)
                if clave in self.vistos:
                    break
                self.vistos.add(clave)
                self.configs.add(s)
                n = self.ilen(pc, s)
                if n == 0:
                    break
                if (pc & 0x1FFF) + n > TAM_PAGINA:
                    # instruccion partida entre bancos: se decodifica entera
                    # con el reparto puesto (un `ld a,(nn)` en el ultimo byte
                    # de un banco lleva su nn en los dos primeros del banco
                    # que haya en la ranura siguiente)
                    self.partidas.add((b, pc, n))
                    d2 = self.c.banco(pc + n - 1, s)
                    if d2 is None or d2 >= N_PAGINAS:
                        break
                # Los bytes de una instruccion partida NO se marcan como
                # codigo: el trazador de un solo banco (z80trace) no puede
                # verla entera, y check_bancos exige que los dos digan lo
                # mismo. En el listado van como D con su explicacion.
                if (pc & 0x1FFF) + n <= TAM_PAGINA:
                    off = pc & 0x1FFF
                    for i in range(n):
                        self.marcado[b][off + i] = 1
                self.arranques.add((b, pc))
                self.config_de[(b, pc)].add(s)
                op = self.byte(pc, s)
                nxt = pc + n
                para = False

                # --- que pasa con A
                if op == 0x3E:                                  # ld a,n
                    nueva_a = self.byte(pc + 1, s)
                elif op == 0x3C and a is not None:               # inc a
                    nueva_a = (a + 1) & 0xFF
                elif op == 0x3D and a is not None:               # dec a
                    nueva_a = (a - 1) & 0xFF
                elif op == 0xAF:                                 # xor a
                    nueva_a = 0
                elif op == 0x3A and self.word(pc + 1, s) in SOMBRA:
                    nueva_a = sombra[SOMBRA[self.word(pc + 1, s)]]
                elif not self.toca_a(pc, s):
                    nueva_a = a
                else:
                    nueva_a = None

                # --- que pasa con HL
                if op == 0x21:                                   # ld hl,nn
                    nuevo_hl = self.word(pc + 1, s)
                elif op == 0x23 and hl is not None:               # inc hl
                    nuevo_hl = (hl + 1) & 0xFFFF
                elif op == 0x2B and hl is not None:               # dec hl
                    nuevo_hl = (hl - 1) & 0xFFFF
                elif op == 0xEB:                                  # ex de,hl
                    nuevo_hl = de
                elif not self.toca_hl(pc, s):
                    nuevo_hl = hl
                else:
                    nuevo_hl = None

                # --- que pasa con DE
                if op == 0x11:                                   # ld de,nn
                    nuevo_de = self.word(pc + 1, s)
                elif op == 0x13 and de is not None:               # inc de
                    nuevo_de = (de + 1) & 0xFFFF
                elif op == 0x1B and de is not None:               # dec de
                    nuevo_de = (de - 1) & 0xFFFF
                elif op == 0xEB:                                  # ex de,hl
                    nuevo_de = hl
                elif not self.toca_de(pc, s):
                    nuevo_de = de
                else:
                    nuevo_de = None

                # --- escrituras a los registros del mapper y a su copia en RAM
                destino_ld = None
                if op == 0x32:                                   # ld (nn),a
                    destino_ld = self.word(pc + 1, s)
                elif op == 0x77 and hl is not None:               # ld (hl),a
                    destino_ld = hl
                if destino_ld in RANURA_REG:
                    k = RANURA_REG[destino_ld]
                    if a is None:
                        self.sin_resolver.add((b, pc, destino_ld))
                    elif a == 0:
                        # el unico camino que llega aqui con cero es p00:41A3
                        # con 0xF0F6 sin estrenar, y p00:419F lo salta con
                        # `and a / jr z`: no se escribe el registro
                        self.cambios.add((b, pc, destino_ld, a))
                    else:
                        self.cambios.add((b, pc, destino_ld, a))
                        if a < N_PAGINAS:
                            s = tuple(a if j == k else s[j] for j in range(3))
                elif destino_ld in SOMBRA and a is not None:
                    k = SOMBRA[destino_ld]
                    sombra = tuple(a if j == k else sombra[j]
                                   for j in range(len(sombra)))

                # --- flujo
                # `llamadas` guarda tambien los saltos: un puente que acaba en
                # `jp pinta` le pasa el guion igual que uno que hace `call`, y
                # tools/bloques.py necesita los dos.
                if op == 0xC3:                                   # jp nn
                    t = self.word(pc + 1, s)
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "jp")
                    para = True
                elif op in JP_CC:
                    t = self.word(pc + 1, s)
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "jp cc")
                elif op == 0xCD:                                 # call nn
                    t = self.word(pc + 1, s)
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "call")
                    if t in DESPACHADORES:
                        self._despacha(b, pc, nxt, s, sombra, pila)
                        para = True
                    elif t in PONE_BANCOS:
                        s, sombra = pone_bancos(t, s, sombra)
                    else:
                        s, sombra = self._tras_llamada(t, s, sombra, b, pc)
                elif op in CALL_CC:
                    t = self.word(pc + 1, s)
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "call cc")
                    if t in PONE_BANCOS:
                        s2, sombra2 = pone_bancos(t, s, sombra)
                    else:
                        s2, sombra2 = self._tras_llamada(t, s, sombra, b, pc)
                    if s2 != s:
                        # si la llamada se hace, se sigue con el reparto nuevo;
                        # si no, con el de antes: se apuntan los dos caminos
                        pila.append((nxt, s2, sombra2, None, None, None))
                elif op == 0x18:                                 # jr e
                    t = nxt + self._s8(self.byte(pc + 1, s))
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "jr")
                    para = True
                elif op in JR_CC or op == 0x10:
                    t = nxt + self._s8(self.byte(pc + 1, s))
                    self.llamadas.append((t, b, pc, s, hl, de))
                    self._ir(t, s, sombra, pila, b, pc, "jr cc")
                elif op == 0xC9:
                    para = True
                elif op == 0xE9:
                    self.ciegos.add((b, pc, "JP (HL)"))
                    para = True
                elif op in (0xDD, 0xFD) and self.byte(pc + 1, s) == 0xE9:
                    self.ciegos.add((b, pc, "JP (IX/IY)"))
                    para = True
                elif op == 0xED and self.byte(pc + 1, s) in (0x45, 0x4D):
                    para = True

                if para:
                    break
                # El codigo puede SEGUIR DE LARGO de un banco al de al lado:
                # 0x5FFF (banco 0) da a 0x6000, y 0x9FFF a 0xA000. Pasa de
                # verdad en este cartucho -hay un bucle repartido entre el
                # banco 0 y el 1- y para el trazador de una sola pagina eso es
                # una entrada que no puede deducir.
                if (nxt & 0xE000) != (pc & 0xE000):
                    d = self.c.banco(nxt, s)
                    if d is not None and d < N_PAGINAS and nxt not in self.entradas[d]:
                        self.entradas[d].add(nxt)
                        self.porque[(d, nxt)] = (
                            "%s:%04X sigue de largo (el codigo cruza la "
                            "frontera de banco)" % (nombre(b), pc))
                # Tras una llamada no se sabe que traen A, HL ni DE: la rutina
                # los puede haber cambiado (p00:42A6 lee DE de una tabla con
                # `call 0x4D81 / ex de,hl`, y seguir con el HL de antes del
                # call daba un rle que no existe en 0x6000 del banco 13). Las
                # que cambian de banco ya han dejado su reparto en `s`.
                if op == 0xCD or op in CALL_CC or op in RST:
                    nueva_a = nuevo_hl = nuevo_de = None
                pc, a, hl, de = nxt, nueva_a, nuevo_hl, nuevo_de

    # ------------------------------------------------ resumen de subrutinas
    def _tras_llamada(self, t, s, sombra, b, pc):
        """El reparto con el que se sigue tras `call t`.

        Una subrutina cualquiera puede acabar cambiando de banco sin estar en
        PONE_BANCOS: basta con que su ultima instruccion sea `jp` a una de
        ellas (p.ej. `call 0x4108 / jp 0x4133`). Sin esto el trazador sigue
        tras el `call` con el reparto de antes y lee el cartucho por donde no
        es. efecto() recorre la subrutina y, si TODOS sus caminos de vuelta
        dejan el mismo reparto, ese es el que se usa; si no coinciden, se
        apunta en self.ambiguas y se sigue con el de antes.
        """
        e = self.efecto(t, s)
        if e is None or e == "X":
            return s, sombra
        s2 = tuple(n if n is not None else v for n, v in zip(e, s))
        if s2 != s:
            self.resumidas.add((b, pc, t, s2))
        return s2, tuple(s2) + tuple(sombra[3:])

    def efecto(self, t, s, prof=0):
        """Lo que la subrutina t (llamada con el reparto s) deja en las tres
        ranuras al volver: tupla con el banco de cada una (None = la deja
        como estaba), None si no cambia ninguna, o "X" si no se puede saber.

        Recorre la subrutina siguiendo A, las escrituras a los registros del
        mapper (RANURA_REG), la copia en RAM (SOMBRA: `ld a,(0xF0F1)` lee lo
        que hay apuntado) y las llamadas a PONE_BANCOS y a otras subrutinas
        (resumidas igual, hasta 6 de hondo; las que no se pueden resumir se
        dan por neutras). Si sus caminos de vuelta no coinciden, se apunta en
        self.ambiguas.
        """
        d = self.c.banco(t, s)
        if d is None or d >= N_PAGINAS:
            return None
        clave = (d, t, s)
        if clave in self._efectos:
            return self._efectos[clave]
        self._efectos[clave] = None             # contra la recursion
        res = set()
        vistos = set()
        sh0 = tuple(s) + (None,) * (len(SOMBRA) - 3)
        pila = [(t, tuple(s), sh0, None)]
        pasos = 0

        def aplica(cs, sh, n):
            cs = tuple(x if x is not None else y for x, y in zip(n, cs))
            return cs, tuple(cs) + tuple(sh[3:])

        while pila and "X" not in res:
            pc, cs, sh, a = pila.pop()
            while True:
                pasos += 1
                if pasos > 6000:
                    res.add("X")
                    break
                if (pc, cs, sh, a) in vistos:
                    break
                vistos.add((pc, cs, sh, a))
                bb = self.c.banco(pc, cs)
                if bb is None or bb >= N_PAGINAS or bb in self.bancos_datos:
                    res.add("X")
                    break
                n = self.ilen(pc, cs)
                if n == 0:
                    res.add("X")
                    break
                op = self.byte(pc, cs)
                nxt = pc + n
                # A
                if op == 0x3E:
                    na = self.byte(pc + 1, cs)
                elif op == 0x3C and isinstance(a, int):
                    na = (a + 1) & 0xFF
                elif op == 0xAF:
                    na = 0
                elif op == 0x3A and self.word(pc + 1, cs) in SOMBRA:
                    na = sh[SOMBRA[self.word(pc + 1, cs)]]
                elif op in (0xF1, 0xC1, 0xD1, 0xE1) or not self.toca_a(pc, cs):
                    na = a if op != 0xF1 else None
                else:
                    na = None
                # escrituras al mapper y a su copia
                if op == 0x32:
                    w = self.word(pc + 1, cs)
                    if w in RANURA_REG:
                        if a is None:
                            res.add("X")
                            break
                        if a < N_PAGINAS:
                            k = RANURA_REG[w]
                            cs = tuple(a if q == k else cs[q] for q in range(3))
                    elif w in SOMBRA:
                        k = SOMBRA[w]
                        sh = tuple(a if q == k else sh[q] for q in range(len(sh)))
                if op == 0xC9 or (op == 0xED and self.byte(pc + 1, cs) in (0x45, 0x4D)):
                    res.add(cs)
                    break
                if op in (0xC0, 0xC8, 0xD0, 0xD8, 0xE0, 0xE8, 0xF0, 0xF8):
                    res.add(cs)
                elif op == 0xE9 or (op in (0xDD, 0xFD) and self.byte(pc + 1, cs) == 0xE9):
                    res.add("X")
                    break
                elif op in (0xC3, 0xCD) or op in JP_CC or op in CALL_CC:
                    w = self.word(pc + 1, cs)
                    llama = op == 0xCD or op in CALL_CC
                    if w in DESPACHADORES:
                        res.add("X")
                        break
                    if w in PONE_BANCOS:
                        cs2, sh2 = aplica(cs, sh, PONE_BANCOS[w])
                        if op == 0xC3:
                            res.add(cs2)
                            break
                        if op in JP_CC:
                            res.add(cs2)
                        elif op == 0xCD:
                            cs, sh, na = cs2, sh2, None
                        else:
                            pila.append((nxt, cs2, sh2, None))
                            na = None
                    elif llama:
                        # una subrutina que no se puede resumir (un `jp (hl)`
                        # dentro, el sonido) se da por neutra: lo que venga
                        # detras -p.ej. devolver 0xF0F1-3- manda
                        sub = self.efecto(w, cs, prof + 1) if prof < 6 else None
                        if sub not in (None, "X"):
                            cs2, sh2 = aplica(cs, sh, sub)
                            if op == 0xCD:
                                cs, sh = cs2, sh2
                            else:
                                pila.append((nxt, cs2, sh2, None))
                        na = None
                    elif op == 0xC3:
                        pc, a = w, na
                        continue
                    else:
                        pila.append((w, cs, sh, na))
                elif op == 0x18:
                    pc, a = nxt + self._s8(self.byte(pc + 1, cs)), na
                    continue
                elif op in JR_CC or op == 0x10:
                    pila.append((nxt + self._s8(self.byte(pc + 1, cs)), cs, sh, na))
                pc, a = nxt, na
        if "X" in res:
            r = "X"
        elif len(res) > 1:
            r = "X"
            self.ambiguas.add((d, t, tuple(sorted(map(str, res)))))
        elif not res:
            r = None
        else:
            fin = res.pop()
            r = tuple(x if x != y else None for x, y in zip(fin, s))
            if r == (None, None, None):
                r = None
        self._efectos[clave] = r
        return r

    def _despacha(self, b, pc_call, tab, s, sombra, pila):
        """La tabla de palabras pegada detras de un `call` al despachador."""
        n = self.tam_tablas.get((b, pc_call), 0)
        destinos = []
        for k in range(n):
            w = self.word(tab + 2 * k, s)
            if w is None:
                break
            destinos.append(w)
        self.tablas[(b, pc_call)] = (tab, len(destinos), destinos, s)
        if self.sin_tablas:
            return
        for i, w in enumerate(destinos):
            si = self.sitios.get(("entrada", b, pc_call, i), s)
            self._ir(w, si, tuple(si) + tuple(sombra[3:]), pila, b, pc_call,
                     "entrada %d de la tabla de 0x%04X (call 0x%04X en 0x%04X)"
                     % (i, tab, DESPACHADOR, pc_call))

    def _ir(self, destino, s, sombra, pila, b, pc, clase):
        if destino is None:
            return
        d = self.c.banco(destino, s)
        if (d, destino) in self.sitios:
            # reparto forzado en el destino: la entrada es del banco que dice
            # src/sitios.txt, no del que hay puesto al saltar
            s = self.sitios[(d, destino)]
            d = self.c.banco(destino, s)
        if d is None or d >= N_PAGINAS:
            self.externos[destino].add((b, pc))
            return
        if destino not in self.entradas[d]:
            self.entradas[d].add(destino)
            self.porque[(d, destino)] = "%s:%04X %s" % (nombre(b), pc, clase)
        pila.append((destino, s, sombra, None, None, None))

    @staticmethod
    def _s8(x):
        return x - 256 if x > 127 else x

    def cobertura(self):
        return {p: sum(self.marcado[p]) for p in range(N_PAGINAS)}


def sitios_despachador(rom):
    """Todos los `call` al despachador del cartucho: (banco, direccion de ejecucion)."""
    fuera = []
    for i in range(len(rom) - 2):
        if rom[i] == 0xCD and any(rom[i + 1] == (d & 0xFF) and rom[i + 2] == (d >> 8)
                                  for d in DESPACHADORES):
            b = i // TAM_PAGINA
            fuera.append((b, ORG[b] + (i % TAM_PAGINA)))
    return fuera


def calcula_tam(rom, arranques, sitios, forzadas, repartos=None):
    """Cuantas palabras tiene la tabla de cada `call` al despachador.

    Se leen palabras UNA A UNA mientras cada una sea una direccion del cartucho
    (0x4000-0xBFFF), y la tabla se corta en el destino mas bajo visto hasta ese
    momento DE LOS QUE CAEN EN LA MISMA RANURA. Lo de "misma ranura" importa:
    hay tablas que reparten a otro banco -la de p00:5DFA manda casi todas sus
    31 entradas a 0x8000 y 0xA000- y exigir que el destino este en la propia
    pagina las dejaba en cero. Coger de golpe el minimo de todas las palabras hasta el final
    de la ranura no vale: se cuelan palabras leidas de codigo que hay mucho mas
    abajo y el minimo sale disparatado (en p00:4AC7 daba una sola palabra de
    diez que son).

    Ademas se corta en el primer byte que YA se sabe que es codigo por otro
    camino, que es donde la tabla tiene que haber acabado.
    """
    tam = {}
    for b, pc in sitios:
        if (b, pc) in forzadas:
            tam[(b, pc)] = forzadas[(b, pc)]
            continue
        tab = pc + 3
        base = tab & 0xE000
        fin_pagina = base + TAM_PAGINA
        # la tabla puede caer en la ranura siguiente (el `call` de p00:5FFE
        # esta partido y su tabla empieza en p01:6001): su banco es el que
        # hay en esa ranura con el reparto con el que se ejecuta el call
        bt = b
        if base != (pc & 0xE000):
            s = (repartos or {}).get((b, pc), (1, 2, 3))
            bt = Cartucho.banco(tab, s)
        limite = fin_pagina
        for x in range(tab, fin_pagina):
            if (bt, x) in arranques:
                limite = x
                break
        n = 0
        while tab + 2 * n + 1 < limite:
            o = bt * TAM_PAGINA + ((tab + 2 * n) & 0x1FFF)
            w = rom[o] | (rom[o + 1] << 8)
            if not 0x4000 <= w < 0xC000:
                break                       # ni siquiera es una direccion del cartucho
            if tab < w < fin_pagina:
                limite = min(limite, w)     # solo acorta lo que cae en la ranura
            n += 1
        tam[(b, pc)] = n
    return tam


def carga_tablas(ruta):
    """Tamanos de tabla puestos a mano: 'pNN 0xCALL n  # por que'."""
    fuera = {}
    if not ruta or not os.path.exists(ruta):
        return fuera
    for ln in open(ruta, encoding="utf-8"):
        p = ln.split("#")[0].split()
        if len(p) >= 3:
            fuera[(int(p[0][1:], 10), int(p[1], 0))] = int(p[2], 0)
    return fuera


def carga_extra(ruta):
    """Semillas a mano: 'pNN 0xADDR b6000 b8000 bA000  # por que'."""
    fuera = []
    if not ruta or not os.path.exists(ruta):
        return fuera
    for ln in open(ruta, encoding="utf-8"):
        crudo, _, coment = ln.partition("#")
        p = crudo.split()
        if len(p) >= 5:
            fuera.append((int(p[1], 0),
                          (int(p[2], 0), int(p[3], 0), int(p[4], 0)),
                          coment.strip() or "a mano"))
    return fuera


def traza_completa(rom, src, pasadas=8):
    """Traza, recalcula los tamanos de tabla y repite hasta que no se mueven."""
    forzadas = carga_tablas(os.path.join(src, "tablas.txt"))
    extra = carga_extra(os.path.join(src, "semillas.txt"))
    datos = carga_datos(os.path.join(src, "datos.txt"))
    forzados = carga_sitios(os.path.join(src, "sitios.txt"))
    sitios = sitios_despachador(rom)

    # Pasada 0: sin seguir ninguna tabla. Da un mapa de codigo limpio.
    t = TrazadorDeBancos(rom, tam_tablas={}, sin_tablas=True,
                         bancos_datos=datos, sitios=forzados)
    t.traza(semillas_iniciales(rom) + extra)
    repartos = {k: v[3] for k, v in t.tablas.items()}
    tam = calcula_tam(rom, t.arranques, sitios, forzadas, repartos)

    for _ in range(pasadas):
        t = TrazadorDeBancos(rom, tam_tablas=tam, bancos_datos=datos,
                             sitios=forzados)
        t.traza(semillas_iniciales(rom) + extra)
        repartos = {k: v[3] for k, v in t.tablas.items()}
        n2 = calcula_tam(rom, t.arranques, sitios, forzadas, repartos)
        if n2 == tam:
            break
        tam = n2
    return t, tam


CAB_ENTRIES = """# Puntos de entrada del banco %d (se ejecuta en %#06x).
#
# Cada uno lleva la instruccion que lo justifica. Los que ponen "pNN:XXXX"
# vienen de OTRO banco: el trazador de una sola pagina no puede seguirlos,
# porque en esa direccion -segun lo que haya en el registro del mapper- puede
# estar cualquiera de seis bancos. Los que ponen "tabla" salen de una tabla
# del despachador (cartucho.DESPACHADOR), que va pegada detras de su `call` y esta declarada
# como datos en el .nocode: el trazador tampoco puede seguirla.
#
# Los saltos y llamadas DENTRO del propio banco no se ponen aqui: los
# encuentra tools/z80trace.py solo, siguiendo el flujo.
#
# Este fichero lo regenera `make semillas` (tools/bancos.py escribe).
"""

CAB_NOCODE = """# Zonas que el trazador NO puede entrar a desensamblar como codigo.
#
# La tabla de destinos del despachador de Konami (cartucho.DESPACHADOR) va pegada JUSTO
# DETRAS de su `call`: sin declararla, el trazador sigue de largo y se la come
# como instrucciones, y ademas sigue desde ahi. Es la contaminacion mas facil
# de este cartucho.
#
# Este fichero lo regenera `make semillas` (tools/bancos.py escribe).
"""


def escribe_ficheros(t, src):
    """Escribe src/pNN.entries y src/pNN.nocode con lo que se ha averiguado."""
    propias = {}
    for p in range(N_PAGINAS):
        fuera = []
        if p in t.bancos_datos:
            # Banco declarado como biblioteca de datos en src/datos.txt: ni una
            # entrada, aunque el trazador haya llegado a apuntar alguna. Pasa
            # porque una misma rutina se ejecuta con dos repartos distintos y
            # el trazador se queda con el que no toca: p01:6DF5 hace
            # `call 0x9417`, que con los bancos 2 y 3 puestos -que es como se
            # ejecuta de verdad- cae en el banco 2, donde 0x9417 es el pintor
            # de dos cifras BCD; en el banco 12 esos mismos bytes son basura.
            propias[p] = fuera
            continue
        for a in sorted(t.entradas[p]):
            just = t.porque.get((p, a), "?")
            de_otro = just.startswith("p") and just[:3] != nombre(p)
            de_tabla = "tabla" in just
            raiz = not just.startswith("p")
            if de_otro or de_tabla or raiz:
                fuera.append((a, just))
        propias[p] = fuera

    # Los call/jp cuyo destino cae en la ventana del propio banco pero, con
    # el reparto con el que se ejecutan, en OTRO banco: el trazador de un
    # solo banco no lo puede saber y se meteria en sus propios bytes.
    destinos = defaultdict(set)
    for t_, b, pc, s, hl, de in t.llamadas:
        if t_ is not None and ORG[b] <= t_ < ORG[b] + TAM_PAGINA:
            destinos[(b, pc, t_)].add(Cartucho.banco(t_, s))
    ajenos = defaultdict(list)
    for (b, pc, t_), bs in sorted(destinos.items()):
        if b not in bs:
            ajenos[b].append((pc, t_, sorted(bs)))
        elif len(bs) > 1:
            print("AVISO %s:%04X -> %04X se ejecuta con bancos %s"
                  % (nombre(b), pc, t_, sorted(bs)))

    for p in range(N_PAGINAS):
        ruta = os.path.join(src, nombre(p) + ".entries")
        with open(ruta, "w", encoding="utf-8") as f:
            f.write(CAB_ENTRIES % (p, ORG[p]))
            if not propias[p]:
                f.write("#\n# Este banco no lleva ni un byte de codigo al que\n"
                        "# se pueda llegar: es todo datos (o relleno 0xFF).\n")
            for a, just in propias[p]:
                f.write("0x%04X   # %s\n" % (a, just))
            for pc, t_, bs in ajenos.get(p, []):
                f.write("!ajeno 0x%04X   # va a %04X del banco %s\n"
                        % (pc, t_, "/".join(nombre(x) for x in bs)))
        print("%s: %d entradas" % (ruta, len(propias[p])))

    por_pagina = defaultdict(list)
    for (b, pc), (tab, n, dest, ss) in sorted(t.tablas.items()):
        if not n:
            continue
        fin = tab + 2 * n
        frontera = (tab & 0xE000) + TAM_PAGINA
        # el banco de la TABLA, que no es siempre el del call: la de
        # p00:5FFE empieza en p01:6001
        bt = Cartucho.banco(tab, ss)
        if fin <= frontera:
            por_pagina[bt].append((tab, fin, pc, n))
        else:
            # la tabla cruza al banco que haya en la ranura siguiente:
            # cada trozo va al .nocode de SU banco
            por_pagina[bt].append((tab, frontera, pc, n))
            otro = Cartucho.banco(frontera, ss)
            por_pagina[otro].append((frontera, fin, pc, n))
    for p in range(N_PAGINAS):
        ruta = os.path.join(src, nombre(p) + ".nocode")
        with open(ruta, "w", encoding="utf-8") as f:
            f.write(CAB_NOCODE)
            if p in t.bancos_datos:
                f.write("#\n# BANCO DE DATOS entero, declarado en"
                        " src/datos.txt:\n# %s\n" % t.bancos_datos[p])
                f.write("0x%04X 0x%04X   el banco entero es datos\n"
                        % (ORG[p], ORG[p] + TAM_PAGINA))
            for tab, fin, pc, n in sorted(por_pagina.get(p, [])):
                f.write("0x%04X 0x%04X   tabla de %d palabras del despachador "
                        "(call 0x%04X en 0x%04X)\n" % (tab, fin, n, DESPACHADOR, pc))
        print("%s: %d tablas" % (ruta, len(por_pagina.get(p, []))))



def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    rom = open(sys.argv[1], "rb").read()
    modo = sys.argv[2]
    aqui = os.path.dirname(os.path.abspath(__file__))
    src = sys.argv[3] if len(sys.argv) > 3 else os.path.join(aqui, "..", "src")
    t, tam = traza_completa(rom, src)

    if modo == "informe":
        cob = t.cobertura()
        total = sum(cob.values())
        print("cobertura del trazado de cartucho entero")
        for p in range(N_PAGINAS):
            print("  %s org %#06x  %5d / %d bytes  %5.1f %%  %3d entradas" % (
                nombre(p), ORG[p], cob[p], TAM_PAGINA,
                100.0 * cob[p] / TAM_PAGINA, len(t.entradas[p])))
        print("  TOTAL %d / %d bytes  %.1f %%" % (total, len(rom),
                                                  100.0 * total / len(rom)))
        print("\nrepartos de banco vistos: %d" % len(t.configs))
        for s in sorted(t.configs):
            print("    0x6000=%-2d 0x8000=%-2d 0xA000=%d" % s)
        print("\ncambios de banco resueltos: %d" % len(t.cambios))
        print("cambios de banco SIN resolver (A desconocido): %d"
              % len(t.sin_resolver))
        for b, pc, dst in sorted(t.sin_resolver):
            print("    %s:%04X -> ld (%#06x),a" % (nombre(b), pc, dst))
        print("\ninstrucciones a caballo de dos bancos: %d" % len(t.partidas))
        for b, pc, n in sorted(t.partidas):
            print("    %s:%04X  %d bytes" % (nombre(b), pc, n))
        print("\nsaltos indirectos (puntos ciegos): %d" % len(t.ciegos))
        for b, pc, k in sorted(t.ciegos):
            print("    %s:%04X  %s" % (nombre(b), pc, k))
        print("\ndestinos fuera del cartucho: %d" % len(t.externos))
        for d in sorted(t.externos):
            orig = sorted(t.externos[d])[:4]
            print("    %04X  <- %s" % (d, " ".join("%s:%04X" % (nombre(b), a)
                                                   for b, a in orig)))
    elif modo == "tablas":
        for (b, pc), (tab, n, dest, s) in sorted(t.tablas.items()):
            print("%s call despachador en %04X: tabla %04X..%04X, %d palabras "
                  "(bancos %s)" % (nombre(b), pc, tab, tab + 2 * n - 1, n, s))
            for i, w in enumerate(dest):
                print("        [%2d] %04X" % (i, w))
    elif modo == "entradas":
        for p in range(N_PAGINAS):
            if not t.entradas[p]:
                continue
            print("# ---- %s (org %#06x) ----" % (nombre(p), ORG[p]))
            for a in sorted(t.entradas[p]):
                print("0x%04X   # %s" % (a, t.porque.get((p, a), "?")))
    elif modo == "nocode":
        por_pagina = defaultdict(list)
        for (b, pc), (tab, n, dest, s) in sorted(t.tablas.items()):
            if n:
                por_pagina[b].append((tab, tab + 2 * n, pc, n))
        for p in sorted(por_pagina):
            print("# ---- %s ----" % nombre(p))
            for tab, fin, pc, n in sorted(por_pagina[p]):
                print("0x%04X 0x%04X   tabla de %d palabras del despachador "
                      "(call 0x%04X en 0x%04X)" % (tab, fin, n, DESPACHADOR, pc))
    elif modo == "huecos":
        rom_b = rom
        for p in range(N_PAGINAS):
            m = t.marcado[p]
            o = ORG[p]
            ini = None
            filas = []
            for i in range(TAM_PAGINA + 1):
                v = m[i] if i < TAM_PAGINA else 1
                if not v and ini is None:
                    ini = i
                elif v and ini is not None:
                    filas.append((ini, i))
                    ini = None
            if not filas:
                continue
            print("# ---- %s (org %#06x): %d huecos, %d bytes ----" % (
                nombre(p), o, len(filas), sum(b - a for a, b in filas)))
            for a, b in filas:
                tr = rom_b[p * TAM_PAGINA + a:p * TAM_PAGINA + b]
                ff = sum(1 for c in tr if c == 0xFF)
                cero = sum(1 for c in tr if c == 0)
                print("   %04X..%04X  %5d B   FF=%d 00=%d   %s" % (
                    o + a, o + b - 1, b - a, ff, cero,
                    " ".join("%02x" % c for c in tr[:12])))
    elif modo == "escribe":
        escribe_ficheros(t, src)
    elif modo == "lee":
        # Quien lee un banco de datos: instrucciones con un inmediato que cae
        # en la ventana de ese banco Y que se ejecutan con ese banco puesto.
        # Sin la segunda condicion la lista no vale para nada: en 0x8000 hay
        # cinco bancos distintos segun el momento.
        objetivo = int(sys.argv[4], 0)
        ventana = ORG[objetivo]
        ranura = {0x4000: 0, 0x6000: 0, 0x8000: 1, 0xA000: 2}[ventana]
        print("quien lee el banco %d (ventana %#06x..%#06x)"
              % (objetivo, ventana, ventana + TAM_PAGINA - 1))
        vistas = []
        for b, pc in sorted(t.arranques):
            o = b * TAM_PAGINA + (pc & 0x1FFF)
            op = rom[o]
            largo, w = 0, None
            if op in (0x01, 0x11, 0x21, 0x31, 0x22, 0x2A, 0x32, 0x3A)                     and (pc & 0x1FFF) + 3 <= TAM_PAGINA:
                largo, w = 3, rom[o + 1] | (rom[o + 2] << 8)
            elif op in (0xDD, 0xFD) and (pc & 0x1FFF) + 4 <= TAM_PAGINA                     and rom[o + 1] in (0x21, 0x22, 0x2A):
                largo, w = 4, rom[o + 2] | (rom[o + 3] << 8)
            if not largo or not (ventana <= w < ventana + TAM_PAGINA):
                continue
            cfgs = {c[ranura] for c in t.config_de[(b, pc)]}
            if objetivo in cfgs:
                vistas.append((w, b, pc, op))
        for w, b, pc, op in sorted(vistas):
            print("    %04X  <- %s:%04X  (opcode %02X)" % (w, nombre(b), pc, op))
        print("  %d instrucciones" % len(vistas))
    elif modo == "apunta":
        objetivos = [int(x, 0) for x in sys.argv[4:]] or [0]
        ini, fin = objetivos[0], (objetivos[1] if len(objetivos) > 1
                                  else objetivos[0] + 1)
        print("quien apunta a %04X..%04X" % (ini, fin - 1))
        print("  desde instrucciones YA trazadas (inmediato de 16 bits):")
        for b, pc in sorted(t.arranques):
            s_ = (1, 2, 3)
            o = b * TAM_PAGINA + (pc & 0x1FFF)
            op = rom[o]
            if op in (0x01, 0x11, 0x21, 0x31, 0x22, 0x2A, 0x32, 0x3A,
                      0xC3, 0xCD) or op in JP_CC or op in CALL_CC:
                if (pc & 0x1FFF) + 3 > TAM_PAGINA:
                    continue
                w = rom[o + 1] | (rom[o + 2] << 8)
                if ini <= w < fin:
                    print("    %s:%04X  op %02X -> %04X" % (nombre(b), pc, op, w))
            if op in (0xDD, 0xFD) and (pc & 0x1FFF) + 4 <= TAM_PAGINA:
                if rom[o + 1] in (0x21, 0x22, 0x2A):
                    w = rom[o + 2] | (rom[o + 3] << 8)
                    if ini <= w < fin:
                        print("    %s:%04X  op %02X%02X -> %04X"
                              % (nombre(b), pc, op, rom[o + 1], w))
        print("  palabras crudas en zonas NO trazadas (posibles tablas):")
        for b in range(N_PAGINAS):
            for i in range(TAM_PAGINA - 1):
                if t.marcado[b][i] or t.marcado[b][i + 1]:
                    continue
                w = rom[b * TAM_PAGINA + i] | (rom[b * TAM_PAGINA + i + 1] << 8)
                if ini <= w < fin:
                    print("    %s:%04X (offset %05X) -> %04X"
                          % (nombre(b), ORG[b] + i, b * TAM_PAGINA + i, w))
    else:
        sys.exit(__doc__)
    return 0


if __name__ == "__main__":
    sys.exit(main())

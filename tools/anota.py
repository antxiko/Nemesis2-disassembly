#!/usr/bin/env python3
"""Anota lo que ya esta identificado: rutinas con nombre, RAM y cambios de banco.

Una vez se sabe que 0xC130 es la sala no tiene merito -ni fiabilidad- escribir
a mano "la sala" las cien veces que aparece. Esto lo hace de una vez y sin
equivocarse, en una seccion delimitada de src/pNN.notes que reescribe entera
cada vez.

- RUTINAS: el nombre de cada rutina (directiva L) y, en cada `call`/`jp` que
  va a ella, un comentario con lo que hace.
- RAM: en cada instruccion que nombra una direccion de la tabla, que es.
- CAMPOS: en cada `(ix+n)` de un tramo en el que IX es una ficha conocida
  (los actores, los proyectiles: FICHAS en anotaciones.py).
- Los cambios de banco (`ld (0x6000/0x8000/0xA000),a`).

A QUE BANCO VA UNA LLAMADA. Una `call 0xA123` desde otro banco no dice a cual
de seis bancos va. Se mira, por este orden: el banco 0 (0x4000-0x5FFF, fijo),
el propio banco si cae en su ventana, lo que midio el trazador de cartucho
entero (los comentarios "pNN:XXXX" de src/pMM.entries: esa instruccion va al
banco MM) y, si no, el reparto que hay en ese momento (el trio del banco,
cambiado por las llamadas de CAMBIOS_DE_BANCO).

CADA ENTRADA DE LA TABLA LLEVA DE DONDE SALE. Lo que no se sabe no esta en la
tabla. Donde ya hay un comentario escrito a mano no se pone otro.

Lo propio del juego (rutinas, RAM, campos) esta en tools/anotaciones.py: aqui
solo la maquinaria.

Uso: anota.py              informa de cuantos pondria
     anota.py --escribe    y los escribe
"""
import glob
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from paginas import ORG                                    # noqa: E402
from anotaciones import (BANCOS, CAMBIOS_DE_BANCO, FICHAS,  # noqa: E402
                         RAM, RAM16, RUTINAS, trio)
try:
    # el mapper de cada juego: registro -> ventana que cambia
    from anotaciones import REGISTROS_MAPPER                  # noqa: E402
except ImportError:
    REGISTROS_MAPPER = {0x6000: "0x6000", 0x8000: "0x8000", 0xA000: "0xA000"}

INI = "# --- ANOTACIONES AUTOMATICAS (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de las anotaciones de anota.py ---"

RAM_DESDE = 0xC000


def ruta_listado(b):
    """src/<juego>_pNN.asm: el nombre del juego sale del propio fichero."""
    hallados = glob.glob(os.path.join(RAIZ, "src", "*_p%02d.asm" % b))
    if len(hallados) != 1:
        raise SystemExit("no hay un solo src/*_p%02d.asm: %s" % (b, hallados))
    return hallados[0]


def listado(b):
    filas = []
    for ln in open(ruta_listado(b), encoding="utf-8"):
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})", ln)
        if m and not ln.startswith(("\tdefb", "\tdefw")):
            filas.append((int(m.group(2), 16), m.group(1).strip()))
    return filas


def medidas():
    """(banco, pc) -> banco de destino, de los comentarios de src/pMM.entries."""
    fuera = {}
    for ruta in glob.glob(os.path.join(RAIZ, "src", "p[0-9][0-9].entries")):
        mm = int(os.path.basename(ruta)[1:3])
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"^0x[0-9A-Fa-f]+\s+#\s+p(\d\d):([0-9A-Fa-f]{4}) (?:call|jp|jr)", ln)
            if m:
                fuera[(int(m.group(1)), int(m.group(2), 16))] = mm
    return fuera


def a_mano(b):
    """Direcciones con C escrita fuera de la seccion, y los L ya puestos."""
    ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
    cs, ls, dentro = set(), set(), False
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(INI):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("C "):
            cs.add(int(ln.split()[1], 0))
        elif not dentro and ln.startswith("L "):
            ls.add(int(ln.split()[1], 0))
    return cs, ls


def num(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def fichas_de(filas, b=None):
    """Para cada instruccion, los campos de la ficha a la que apunta IX (o
    None). Cada ficha de FICHAS vale desde un `ld ix,nn` con nn en sus cargas
    hasta el siguiente `ld ix` con otra cosa, un `ret` o un `jp`; un tramo sin
    carga de IX no cuenta, salvo dentro de los tramos de la ficha."""
    fuera = {}
    for cargas, por_banco, campos in FICHAS:
        tramos = por_banco.get(b, ())

        def defecto(a):
            return any(i <= a < f for i, f in tramos)

        # cargado: lo que dejo el ultimo `ld ix`/`pop ix` del tramo; sin el,
        # manda el tramo de la tabla en el que cae cada instruccion
        cargado = None
        for k, (a, t) in enumerate(filas):
            m = re.match(r"ld ix,0([0-9a-f]{4})h$", t)
            if m:
                cargado = int(m.group(1), 16) in cargas
            elif t.startswith(("ld ix", "pop ix")):
                cargado = False
            if (defecto(a) if cargado is None else cargado) and k not in fuera:
                fuera[k] = campos
            if t.startswith(("ret", "jp ")) and not re.match(r"ret [a-z]", t):
                cargado = None
    return fuera


def ventanas_de(filas, b):
    """Para cada instruccion, {ventana: banco} visible: el trio del banco al
    empezar cada tramo (tras `ret` o `jp`), cambiado por las llamadas a las
    rutinas de CAMBIOS_DE_BANCO."""
    # una vez bautizadas, las rutinas del mapper salen en el listado por su
    # nombre (las del banco 0 y las del propio banco), no como L_xxxx
    por_nombre = {nom: aa for (bb, aa), (nom, _) in RUTINAS.items() if bb in (0, b)}
    fuera, ahora = {}, trio(b)
    for k, (a, t) in enumerate(filas):
        fuera[k] = dict(ahora)
        m = re.match(r"(?:call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h|([a-z_][a-z0-9_]*))$", t)
        if m:
            d = int(m.group(1) or m.group(2), 16) if not m.group(3) else por_nombre.get(m.group(3))
            ahora.update(CAMBIOS_DE_BANCO.get(d, {}))
        if t == "ret" or (t.startswith("jp ") and "," not in t):
            ahora = trio(b)
    return fuera


def destino_de(b, a, dest, k, ventanas, medido):
    if dest < 0x6000:
        return 0
    if b and ORG[b] <= dest < ORG[b] + 0x2000:
        return b
    if (b, a) in medido:
        return medido[(b, a)]
    return (ventanas or {}).get(k, {}).get(dest & 0xE000)


def comentario(b, filas, k, fichas, ventanas=None, medido=None):
    a, t = filas[k]
    # llamadas y saltos a rutinas con nombre: si el listado ya lleva el nombre
    # puesto (las del propio banco), basta con decir que hace
    m = re.match(r"(?:call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?([a-z_][a-z0-9_]*)$", t)
    if m and not re.match(r"^(?:hl|ix|iy)$", m.group(1)):
        for (bb, aa), (nom, que) in RUTINAS.items():
            if nom == m.group(1) and bb in (0, b):
                return "%s: %s" % (nom, que)
    m = re.match(r"(call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h)$", t)
    if m:
        dest = int(m.group(2) or m.group(3), 16)
        banco = destino_de(b, a, dest, k, ventanas, medido or {})
        hecho = RUTINAS.get((banco, dest)) if banco is not None else None
        if hecho:
            return "%s: %s" % hecho
    # los campos de la ficha del actor
    if fichas.get(k):
        mm = re.search(r"\(ix\+0?([0-9a-f]+)h?\)", t)
        if mm:
            n = int(mm.group(1), 16)
            que = fichas[k].get(n)
            if que:
                op = t.split()[0]
                if op == "ld" and t.startswith("ld (ix"):
                    v = t.split(",", 1)[1]
                    if re.match(r"^[a-z]$", v):
                        return "guarda %s" % que
                    v = "0x%02X" % num(v) if re.match(r"^[0-9a-f]+h$", v) else v
                    return "%s = %s" % (que, v)
                if op == "ld":
                    return "lee %s" % que
                if op in ("inc", "dec"):
                    return ("sube " if op == "inc" else "baja ") + que
                if op == "bit":
                    return "mira el bit %s de %s" % (t.split()[1].split(",")[0], que)
                if op in ("set", "res"):
                    return "%s el bit %s de %s" % ("pone a uno" if op == "set" else "pone a cero",
                                                   t.split()[1].split(",")[0], que)
                if op in ("cp", "sub", "add", "adc", "sbc", "and", "or", "xor"):
                    return {"cp": "compara con ", "sub": "le resta ", "add": "le suma ",
                            "adc": "le suma ", "sbc": "le resta ", "and": "AND con ", "or": "OR con ",
                            "xor": "XOR con "}[op] + que
    # cambios de banco
    m = re.match(r"ld \(0([0-9a-f]{4})h\),a$", t)
    if m and int(m.group(1), 16) in REGISTROS_MAPPER:
        return "el mapper: pone en %s el banco de A" % REGISTROS_MAPPER[int(m.group(1), 16)]
    # RAM
    m16 = re.match(r"ld (?:(hl|de|bc|ix|iy|sp),\(0([c-f][0-9a-f]{3})h\)|\(0([c-f][0-9a-f]{3})h\),(hl|de|bc|ix|iy))$", t)
    if m16:
        v = int(m16.group(2) or m16.group(3), 16)
        if v in RAM16:
            return ("lee " if m16.group(1) else "guarda ") + RAM16[v]
        if v in RAM:
            # si la descripcion ya dice que es de 16 bits, no se repite
            resto = "" if "16 bits" in RAM[v][0] else " y el byte siguiente (16 bits)"
            return ("lee " if m16.group(1) else "guarda ") + RAM[v][0] + resto
    for x in re.findall(r"\b0([c-f][0-9a-f]{3})h\b", t):
        v = int(x, 16)
        if v in RAM and v >= RAM_DESDE:
            que = RAM[v][0]
            if re.match(r"ld \(0%04xh\)," % v, t):
                return "guarda %s" % que
            if re.match(r"ld [a-z]+,\(0%04xh\)$" % v, t):
                return "lee %s" % que
            if re.match(r"ld (hl|de|bc|ix|iy),0%04xh$" % v, t):
                return "apunta a %s" % que
            return que
    return None


def main(argv):
    total = 0
    medido = medidas()
    for b in BANCOS:
        filas = listado(b)
        cs, ls = a_mano(b)
        fichas = fichas_de(filas, b)
        ventanas = ventanas_de(filas, b)
        lineas = []
        for (bb, aa), (nom, que) in sorted(RUTINAS.items()):
            if bb == b and aa not in ls:
                lineas.append("L 0x%04X %s %s" % (aa, nom, que))
        n = 0
        for k, (a, t) in enumerate(filas):
            if a in cs:
                continue
            c = comentario(b, filas, k, fichas, ventanas, medido)
            if c:
                lineas.append("C 0x%04X %s" % (a, c))
                n += 1
        total += n
        print("p%02d: %d comentarios, %d nombres" % (b, n, sum(1 for x in lineas if x.startswith("L "))))
        if "--escribe" in argv:
            ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
            viejas = open(ruta, encoding="utf-8").read().split("\n")
            nuevas, dentro = [], False
            for ln in viejas:
                if ln.startswith(INI):
                    dentro = True
                    continue
                if ln.startswith(FIN):
                    dentro = False
                    continue
                if not dentro:
                    nuevas.append(ln)
            while nuevas and not nuevas[-1].strip():
                nuevas.pop()
            nuevas += ["", INI] + lineas + [FIN, ""]
            open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas))
    print("en total: %d comentarios" % total)


if __name__ == "__main__":
    main(sys.argv)

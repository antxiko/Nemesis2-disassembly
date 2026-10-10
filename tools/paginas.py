#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Nemesis 2 (Konami, RC-751, 1987) es un cartucho de 128 KB con el mapper Konami
CON SCC: 16 bancos de 8 KB que se eligen escribiendo el numero de banco en
0x5000 (para 0x4000-0x5FFF), 0x7000 (0x6000-0x7FFF), 0x9000 (0x8000-0x9FFF)
y 0xB000 (0xA000-0xBFFF). Escribir 0x3F en 0x9000 no pone un banco: enciende
el SCC en 0x9800-0x9FFF.

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez):
  - 0x5000 solo lo escribe INIT (p00:40AD), con un 0: el banco 0 se queda
    fijo en 0x4000.
  - Los trios se meten con `ld a,N` / `inc a` / `inc a` (p00:4108..4131):
    1-2-3, 4-5-6, 7-8-9 y 13-14-15 llenan de golpe 0x6000-0xBFFF.
  - Los bancos 10 y 11 NO van en trio: p00:4133 y p00:4137 los meten solos
    en 0xA000 (por p00:414E), y nadie los pone en otra ranura. Por eso se
    ejecutan en 0xA000 y no en 0x6000/0x8000 como su trio de numero.

Uso como programa:
    paginas.py org <n>               imprime el org del banco n
    paginas.py lista                 imprime "n org" para los 16
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada banco
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16

# banco -> direccion de ejecucion. Medido, no supuesto: ver reconocimiento.py.
ORG = {0: 0x4000}
for _b in range(1, 16):
    ORG[_b] = (0x6000, 0x8000, 0xA000)[(_b - 1) % 3]
ORG[10] = ORG[11] = 0xA000      # p00:4133 y p00:4137, solos en 0xA000

# Registro del mapper -> ranura que gobierna (Konami con SCC).
REGISTROS = {0x5000: 0x4000, 0x7000: 0x6000, 0x9000: 0x8000, 0xB000: 0xA000}

# Los registros del OTRO mapper Konami: tienen que estar a cero.
AJENOS = (0x6000, 0x8000, 0xA000)

# Valores escritos en un registro que no son un banco: (registro, valor).
NO_BANCO = {(0x9000, 0x3F): "enciende el SCC en 0x9800"}

# Escrituras al mapper que ponen un banco fuera de su ranura, medidas en
# reconocimiento.py: (banco, pc de la escritura) -> ranura.
EXCEPCIONES = {}

# Todos los bancos los selecciona alguien: aqui no hay ninguno huerfano.
NUNCA_MAPEADOS = ()


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p15."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("16 bancos de %d bytes en %s/" % (TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)

#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Un test que se salta no comprueba nada y en verde daria la impresion
contraria. Quien clone esto sin poner su copia del cartucho vera fallar este
fichero con un mensaje que dice exactamente que falta.

Cada una corresponde a una afirmacion de la web o de las notas, y todas leen
el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOLS = os.path.join(RAIZ, "tools")
sys.path.insert(0, TOOLS)

from paginas import ORG   # noqa: E402

ROM = os.path.join(RAIZ, "nemesis2.rom")
SHA = "227113f94d9900cb48d2f9e88627224dd8cc3d9504614a01e94cf6b23ba508dc"

FALTA = ("falta nemesis2.rom en la raiz del repo. Son los 131.072 bytes de "
         "Nemesis 2 (Konami, RC-751, 1987, MSX) y no se distribuyen aqui: pon tu "
         "copia. El sha256 tiene que ser %s" % SHA)


def leer_rom():
    if not os.path.exists(ROM):
        raise AssertionError(FALTA)
    with open(ROM, "rb") as f:
        return f.read()


def b(rom, banco, a, n=1):
    """n bytes del banco en la direccion a (con su org)."""
    o = banco * 0x2000 + (a - ORG[banco])
    return rom[o:o + n]


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.rom = leer_rom()

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x4090 y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        self.assertEqual(self.rom[2] | (self.rom[3] << 8), 0x4090)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_segunda_cabecera_del_game_master(self):
        """0x4010: 'CD', 0x07 y 0x51, o sea RC-751."""
        self.assertEqual(self.rom[0x10:0x14], bytes([0x43, 0x44, 0x07, 0x51]))

    def test_mapper_konami_con_scc(self):
        """Escrituras a 0x7000, 0x9000 y 0xB000 y ni una a 0x6000/0x8000/0xA000."""
        for reg in (0x7000, 0x9000, 0xB000):
            self.assertIn(bytes([0x32, reg & 0xFF, reg >> 8]), self.rom)
        for reg in (0x6000, 0x8000, 0xA000):
            self.assertNotIn(bytes([0x32, reg & 0xFF, reg >> 8]), self.rom)

    def test_regla_banco_org(self):
        """tools/reconocimiento.py: toda escritura con banco conocido lo pone en
        la ranura que dice tools/paginas.py (exit 0)."""
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "reconocimiento.py"), ROM],
                           capture_output=True, text=True, cwd=TOOLS)
        self.assertEqual(r.returncode, 0, r.stdout)
        self.assertIn("OK: la regla banco -> org", r.stdout)

    def test_bancos_10_y_11_solos_en_0xa000(self):
        """p00:4133 y p00:4137: `ld a,10` / `ld a,11` y saltan a p00:414E, que
        solo escribe 0xB000 y su copia 0xF0F3."""
        self.assertEqual(b(self.rom, 0, 0x4133, 8), bytes([0x3E, 0x0A, 0x18, 0x17,
                                                           0x3E, 0x0B, 0x18, 0x13]))
        self.assertEqual(b(self.rom, 0, 0x414E, 9), bytes([0xF3, 0x32, 0x00, 0xB0,
                                                           0x32, 0xF3, 0xF0, 0xFB, 0xC9]))
        self.assertEqual(ORG[10], 0xA000)
        self.assertEqual(ORG[11], 0xA000)

    def test_gancho_de_interrupcion(self):
        """INIT engancha 0x4023 en H.KEYI (0xFD9A) y se queda en `jr $`."""
        self.assertEqual(b(self.rom, 0, 0x4093, 11), bytes([
            0x3E, 0xC3, 0x32, 0x9A, 0xFD, 0x21, 0x23, 0x40, 0x22, 0x9B, 0xFD]))
        self.assertEqual(b(self.rom, 0, 0x40E7, 2), bytes([0x18, 0xFE]))

    def test_registros_del_vdp(self):
        """p00:5D1D: SCREEN 2 con nombres en 0x3800, colores en 0x0000, dibujos
        en 0x2000, atributos de sprite en 0x3B00 y sus dibujos en 0x1800."""
        self.assertEqual(b(self.rom, 0, 0x5D1D, 8),
                         bytes([0x02, 0xE2, 0x0E, 0x7F, 0x07, 0x76, 0x03, 0xE4]))

    def test_firmas_del_vecino(self):
        """p03:BD55: lo que se busca en la otra ranura (Galious, Penguin
        Adventure y Q*bert por su cabecera de 0x4010)."""
        self.assertEqual(b(self.rom, 3, 0xBD55, 18), bytes([
            0x00, 0x30, 0x31, 0x13, 0x35, 0xAA,
            0x43, 0x44, 0x07, 0x49, 0x43, 0x44, 0x07, 0x43, 0x43, 0x44, 0x07, 0x46]))

    def test_palabras_clave(self):
        """p03:BEAA: tres punteros a LARS18TH, NEMESIS y METALION (con 0x0D)."""
        ps = [b(self.rom, 3, 0xBEAA + 2 * k)[0] | b(self.rom, 3, 0xBEAB + 2 * k)[0] << 8
              for k in range(3)]
        textos = []
        for p in ps:
            t = b"".join(b(self.rom, 3, p + i) for i in range(12))
            textos.append(t[:t.index(b"\x0d")].decode("ascii"))
        self.assertEqual(textos, ["LARS18TH", "NEMESIS", "METALION"])


if __name__ == "__main__":
    unittest.main()

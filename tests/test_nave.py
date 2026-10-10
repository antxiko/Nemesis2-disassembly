#!/usr/bin/env python3
"""La nave (tools/nave.py) y los rotulos, comprobados por como encadenan.

Necesitan la ROM (fallan si no esta).
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

if not os.path.exists(os.path.join(RAIZ, "nemesis2.rom")):
    raise AssertionError("falta nemesis2.rom en la raiz del repo (ver test_cartucho.py)")

import bloques as B      # noqa: E402
import vram as V         # noqa: E402
import nave as N         # noqa: E402


class Nave(unittest.TestCase):

    def test_las_fichas_llenan_su_hueco(self):
        """Las fichas de los cuatro grupos, de 4 bytes, cubren 0xA879-0xA8C4
        sin huecos ni repetidas: detras empieza el codigo de p03:A8C5."""
        todas = sorted(a for _, _, fichas, _ in N.GRUPOS for a in fichas)
        self.assertEqual(todas, list(range(N.FICHAS, 0xA8C5, 4)))

    def test_las_listas_de_dibujos_acaban_donde_empieza_la_siguiente(self):
        """Cada lista de rachas de sprite (p00:4A8C) acaba justo donde empieza
        la que va detras en la ROM: el formato esta bien leido."""
        vram = bytearray(0x4000)
        v = B.Ventana((7, 8, 9))
        v12 = B.Ventana((7, 8, 12))
        for ventana, a, b in ((v, 0x936F, 0x93C0), (v, 0x93C0, 0x93EE),
                              (v, 0x9D17, 0x9D68), (v12, 0xBF19, 0xBF82)):
            self.assertEqual(V.rachas(vram, ventana, a, 0x1800), b, "%04X" % a)

    def test_cada_caso_cambia_los_dibujos_de_la_nave(self):
        """R.DRILL y Penguin Adventure en el otro slot (0xF0F5 bit 2) dejan
        otros dibujos en 0x1800 (los de la nave, 0x00-0x17)."""
        normal = N.vram_normal()[V.SPRITES:V.SPRITES + 0xC0]
        self.assertNotEqual(normal, N.vram_drill()[V.SPRITES:V.SPRITES + 0xC0])
        self.assertNotEqual(normal, N.vram_vecino()[V.SPRITES:V.SPRITES + 0xC0])


if __name__ == "__main__":
    unittest.main()

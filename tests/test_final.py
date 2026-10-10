#!/usr/bin/env python3
"""El final de la fase 8 (tools/final.py), comprobado contra lo que dice otra
cosa: el largo del mapa, las letras que carga p11:B77F y la tabla siguiente.

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
import dibuja as D       # noqa: E402
import final as F        # noqa: E402


class Final(unittest.TestCase):

    def test_el_scroll_para_en_la_ultima_columna_del_mapa(self):
        """0xE325 de la fase 8 (0x6986 + 6 x 8 + 4) es la ultima columna de
        las que da 0x7900 (40 columnas de metabloques de 4)."""
        v = B.ventana_de(1)
        self.assertEqual(v.w(0x6986 + 6 * F.FASE + 4) + 1, len(D.filas_del_mapa(F.FASE)[0]))

    def test_los_textos_solo_usan_letras_cargadas(self):
        """Los bytes de 0x7725 y 0x7731 son 0 o caracteres que p11:B77F carga
        (0xBB-0xC6 con 0xB7A4 y 0x9B-0x9C con 0xB7B1)."""
        v11 = B.ventana_de(11)
        cargados = set(range(0xBB, 0xBB + len(F.texto_de(v11, 0xB7A4))))
        cargados |= set(range(0x9B, 0x9B + len(F.texto_de(v11, 0xB7B1))))
        v1 = B.ventana_de(1)
        for a, n in ((0x7725, 12), (0x7731, 7)):
            for i in range(n):
                self.assertIn(v1(a + i), cargados | {0}, "%04X" % (a + i))

    def test_la_septima_captura_lee_la_tabla_de_al_lado(self):
        """0x77A8 son 6 bytes (empieza 0x77AE justo detras); con 0xE20F = 6
        (p02:9259 da 1) se lee el primero de 0x77AE, y es un rotulo valido."""
        n = F.arma(6)
        self.assertEqual(n, B.ventana_de(1)(0x77AE))
        self.assertTrue(1 <= n <= 25)
        self.assertNotIn(n, [F.arma(k) for k in range(6)])

    def test_los_rotulos_caben_en_sus_huecos(self):
        """Cada rotulo son 8 x 6 bytes: los punteros de 0x9BD3 que se usan
        distan al menos 48 del siguiente."""
        v = B.Ventana((1, 14, 15))
        p = sorted(set(v.w(0x9BD3 + 2 * k) for k in range(1, 26)))
        for a, b in zip(p, p[1:]):
            self.assertGreaterEqual(b - a, 48)


if __name__ == "__main__":
    unittest.main()

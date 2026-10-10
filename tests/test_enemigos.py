"""Los enemigos y lo que se recoge, desde sus fichas (tools/enemigos.py).

Necesitan la ROM (fallan si no esta).
"""
import os
import sys
import unittest

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(AQUI, "..", "tools"))

if not os.path.exists(os.path.join(AQUI, "..", "nemesis2.rom")):
    raise AssertionError("falta nemesis2.rom en la raiz del repo (ver test_cartucho.py)")


class TestEnemigos(unittest.TestCase):
    def test_ficha_de_la_torreta(self):
        import enemigos as E
        # p00:4F4C: el tipo 1 es de caracteres (bit 6) y se ve (bit 7)
        self.assertEqual(E.ficha(1)[0], 0xC0)

    def test_tipos_de_la_fase_1(self):
        import enemigos as E
        t = E.tipos_de_la_fase(1)
        # la lista p14:9A67 trae el 2 y el 3; las torretas, el 1; la oleada, el 0x0B
        for tipo in (1, 2, 3, 0x0B):
            self.assertIn(tipo, t)

    def test_las_fases_secretas_no_tienen_lista(self):
        import enemigos as E
        # p01:6D54: de la fase 9 en adelante no salen enemigos de lista
        for fase in (9, 10, 11):
            self.assertEqual(E.tipos_de_la_fase(fase), {})

    def test_capsulas(self):
        import bloques as B
        # p00:5265: el primer caracter de 0x29-0x2D
        v = B.ventana_de(0)
        self.assertEqual([v(0x5265 + k) for k in range(5)], [0xED, 0xC7, 0xA5, 0xA1, 0xA1])


if __name__ == "__main__":
    unittest.main()

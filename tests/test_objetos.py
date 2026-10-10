#!/usr/bin/env python3
"""Los objetos de caracteres y los jefes, comprobados por como encadenan.

Los tamanos de tools/objetos.py salen del codigo (las rutinas de arranque);
aqui se comparan con lo que dice OTRA cosa: la distancia entre las formas de
0xB661 y entre las fichas de 0xBB01, y las listas de objetos de 0xBA12, que
tienen que acabar justo donde empieza la siguiente.

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
import objetos as O      # noqa: E402


def distancias(v, tabla, n, fin):
    """{puntero: bytes hasta el siguiente puntero distinto}"""
    p = [v.w(tabla + 2 * i) for i in range(n)]
    s = sorted(set(p)) + [fin]
    return p, {a: s[s.index(a) + 1] - a for a in set(p)}


class Objetos(unittest.TestCase):

    def test_cada_forma_cabe_en_su_hueco(self):
        """ancho x filas (de la rutina de arranque) es lo que hay entre la forma
        y la siguiente, salvo la 1 (35 bytes: 5 de cola que no lee)."""
        v = B.Ventana((13, 14, 15))
        p, d = distancias(v, 0xB661, 72, 0xBDB2)
        for clase, ancho, filas, formas, _ in O.FAMILIAS:
            todas = sum(formas.values(), []) if isinstance(formas, dict) else list(formas)
            for n in todas:
                hueco = d[p[n]]
                if n == 1:
                    self.assertEqual(hueco, ancho * filas + 5)
                else:
                    self.assertEqual(hueco, ancho * filas, "forma %d de la clase %d" % (n, clase))

    def test_las_listas_de_objetos_encadenan(self):
        """3 bytes por objeto y 0xFFFF al final: cada lista de 0xBA12 acaba donde
        empieza la siguiente. Las de las fases 0 y 7 no llevan final propio:
        usan el de la lista vacia que va detras (0xBA51, la de la fase 8, y
        0xBB70, la de las fases 9-11)."""
        v = B.Ventana((1, 2, 12))
        ini = sorted({v.w(0xBA12 + 2 * f) for f in range(12)})
        for f in range(12):
            a = v.w(0xBA12 + 2 * f)
            fin = a + 3 * len(O.lista_de_la_fase(f))
            sig = [x for x in ini if x > a]
            if not sig:
                continue
            if fin == sig[0]:
                self.assertIn(f, (0, 7))
                self.assertEqual(v.w(fin), 0xFFFF)
                self.assertIn(fin, [v.w(0xBA12 + 2 * k) for k in (8, 9, 10, 11)])
            else:
                self.assertEqual(fin + 2, sig[0], "fase %d" % f)

    def test_las_fichas_de_jefe_miden_lo_que_dicen(self):
        """[filas][columnas] + filas x columnas = distancia a la ficha siguiente."""
        v = B.Ventana((7, 8, 9))
        p, d = distancias(v, 0xBB01, 32, 0xBF6D)
        for n in range(31):
            a = p[n]
            self.assertEqual(v(a) * v(a + 1) + 2, d[a], "ficha %d" % n)

    def test_los_jefes_arrancan_con_sus_fichas(self):
        """Las piezas de JEFES son las de la ficha de 10 bytes que copia cada
        rutina a 0xEA00."""
        v = B.Ventana((1, 2, 11))
        for t in O.JEFES:
            self.assertEqual(v(t[1]), t[0])
            self.assertEqual((v(t[1] + 7), v(t[1] + 8), v(t[1] + 9)), t[3:6])


if __name__ == "__main__":
    unittest.main()

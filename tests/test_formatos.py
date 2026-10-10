#!/usr/bin/env python3
"""Los formatos leidos, comprobados por como encadenan.

Si un formato esta bien leido, recorrerlo como lo recorre el cartucho tiene
que acabar justo donde empieza lo siguiente. Estos tests no comparan nada con
una constante sacada del propio formato: comparan el final que da el
recorrido con el principio que da OTRA tabla.

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
sys.modules.setdefault("bloques", B)
import lectores as L     # noqa: E402


class Mapa(unittest.TestCase):

    def test_las_tablas_de_metabloques_encadenan(self):
        """16 bytes por metabloque hasta el umbral de 0x494A y 8 despues, hasta
        el mayor que usan sus columnas: cada tabla acaba donde empieza la
        siguiente, y la ultima en 0x7900 (la tabla de columnas)."""
        v0 = B.ventana_de(0)
        v = B.Ventana((13, 14, 15))
        col = [v.w(0x7900 + 2 * k) for k in range(12)]
        met = [v0.w(0x5557 + 2 * k) for k in range(12)]
        umbral = [v0(0x494A + k) for k in range(12)]
        fins = sorted(col) + [0x91A8]
        mayor = {}
        for k in range(12):
            a = col[k]
            f = fins[fins.index(a) + 1]
            self.assertEqual((f - a) % 6, 0, "las columnas de la fase %d no son de 6 bytes" % k)
            ns = [v(x) for x in range(a, f)]
            idx = ns if k in (0, 8) else [n - 4 for n in ns if n >= 4]
            mayor[met[k]] = max(mayor.get(met[k], 0), max(idx))
            t = umbral[k]
        tablas = sorted(mayor)
        for m, siguiente in zip(tablas, tablas[1:] + [0x7900]):
            t = umbral[met.index(m)]
            self.assertEqual(m + 16 * t + 8 * (mayor[m] - t + 1), siguiente,
                             "los metabloques de 0x%04X no acaban en 0x%04X" % (m, siguiente))
        self.assertEqual(tablas[0], 0x6040, "los 4 comunes de 0x6000 son 64 bytes")


class Listas(unittest.TestCase):

    def test_listas_del_banco_14_encadenan(self):
        """Las listas a la VRAM de 0x9222, 0x9281 y 0x93B4 (p00:4A6B) acaban
        cada una donde empieza la siguiente, y en la lista vacia 0x94C3."""
        v = B.Ventana((13, 14, 15))
        for tabla, n, fin in ((0x9222, 4, 0x9281), (0x9281, 3, 0x92F1), (0x93B4, 7, 0x94C3)):
            a = v.w(tabla)
            for k in range(n):
                self.assertEqual(L.lista_vram(v, a), v.w(tabla + 2 * k + 2) if k + 1 < n else fin)
                a = v.w(tabla + 2 * k + 2) if k + 1 < n else a
        self.assertEqual(v(0x94C3), 0)
        self.assertEqual(L.lista_vram(v, 0x950F), 0x9554)

    def test_once_listas_seguidas_del_banco_10(self):
        """De 0xA981 a 0xACAB, once listas a la VRAM sin un byte de mas."""
        v = B.Ventana((1, 2, 10))
        a, n = 0xA981, 0
        while a < 0xACAB:
            a = L.lista_vram(v, a)
            n += 1
        self.assertEqual((a, n), (0xACAB, 11))


class Sonido(unittest.TestCase):

    def test_todas_las_partituras_se_leen(self):
        """Los 67 sonidos de p04:6614 y los 10 golpes de bateria se recorren
        con la gramatica de p04:699A sin una sola nota en un modo que no lee."""
        v = B.Ventana((4, 5, 6))
        P = L.Partituras(v)
        for k in range(1, 68):
            c = v.w(0x6612 + 2 * k)
            canales = bin(v(c)).count("1")
            for j in range(canales):
                P.recorre(v.w(c + 2 + 2 * j), (0, 0, 0))
        for k in range(10):
            P.recorre(v.w(0x7255 + 2 * k), (0x0A, 0, 0))
        self.assertEqual(P.avisos, [])
        self.assertGreater(len(P.usados), 19000)

    def test_la_tabla_de_sonidos_empieza_con_codigo(self):
        """La entrada 0 de 0x6612 son los bytes B0 C9 de `ldir / ret`."""
        v = B.Ventana((4, 5, 6))
        self.assertEqual((v(0x6611), v(0x6612), v(0x6613)), (0xED, 0xB0, 0xC9))


class Despachadores(unittest.TestCase):

    def test_la_tabla_de_p03_abbf_tiene_15(self):
        """Los 15 destinos de 0xABC2 son del banco 3, y el byte siguiente
        (0xABE0) ya es codigo: `xor a`."""
        v = B.ventana_de(3)
        ds = [v.w(0xABC2 + 2 * k) for k in range(15)]
        self.assertTrue(all(0xA000 <= d < 0xC000 for d in ds))
        self.assertEqual(v(0xABE0), 0xAF)

    def test_el_tipo_35_es_del_banco_11(self):
        """La entrada 34 de la tabla de p00:4DF3 es 0xABD2; el banco 11 crea
        ese tipo (`ld a,0x23 / call 0x4D16` en p11:ABA8)."""
        v0 = B.ventana_de(0)
        self.assertEqual(v0.w(0x4DF3 + 2 * 34), 0xABD2)
        v11 = B.ventana_de(11)
        self.assertEqual([v11(0xABA8 + i) for i in range(5)], [0x3E, 0x23, 0xCD, 0x16, 0x4D])


if __name__ == "__main__":
    unittest.main()

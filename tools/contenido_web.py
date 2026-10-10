#!/usr/bin/env python3
"""EL CONTENIDO de la web de este cartucho: lo unico que es de este juego.

md2html.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui. Asi no se puede colar el texto de otro
cartucho al copiar la maquinaria.

Todas las cifras de aqui estan medidas sobre este cartucho, con las
herramientas de tools/: CODIGO y DATOS los imprime tools/presupuesto.py
(make sanity) y RUTINAS, INSTRUCCIONES y COMENTARIOS son la suma de los
bancos con codigo en tools/densidad.py (make densidad). tests/test_web.py
las vuelve a medir.
"""

NOMBRE = "Nemesis 2"
CATALOGO = "RC-751"
ANIO = 1987
REPOSITORIO = "https://github.com/antxiko/Nemesis2-disassembly"

CODIGO = 41242
DATOS = 89830
RUTINAS = 2630
INSTRUCCIONES = 19811
COMENTARIOS = 8602

# Los bancos con codigo, para volver a medir la densidad (tests/test_web.py)
BANCOS_CON_CODIGO = ("00", "01", "02", "03", "04", "10", "11")


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


# El pie legal de cada pagina. Este cartucho no lleva la marca oculta de la
# casa (tools/marca_konami.py: "sin marca").
PIE_LEGAL = {
    "es": "<em>Nemesis 2</em> lo public&oacute; Konami para MSX en 1987; su "
          "n&uacute;mero de cat&aacute;logo es RC-751 y son 128 KB. Todos los "
          "derechos sobre el juego siguen siendo de sus titulares. Este trabajo "
          "es de preservaci&oacute;n, estudio y documentaci&oacute;n, y la "
          "imagen del cartucho no se distribuye.",
    "en": "<em>Nemesis 2</em> was published by Konami for the MSX in 1987; "
          "its catalogue number is RC-751 and it is 128 KB. All rights in the "
          "game remain with their holders. This is preservation, study and "
          "documentation work, and the cartridge image is not distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Nemesis 2 - desensamblado comentado",
        claim="Las doce fases montadas desde sus mapas, los cinco jefes desde "
              "sus fichas, la nave con sus armas y las siete que se capturan, "
              "la vuelta por los planetas, las tres fases secretas y lo que "
              "cambia segun el cartucho del otro slot. Todo dibujado desde la ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "Cartucho <b>RC-751</b>, MegaROM de 128 KB (Konami con SCC)",
               "<b>MSX</b>", "Volcado <b>227113f9...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las "
              "im&aacute;genes est&aacute;n <b>dibujadas desde los bytes de la "
              "ROM</b> con las tablas del cartucho: el t&iacute;tulo, los "
              "mapas, los enemigos, los objetos, los jefes, la nave, los "
              "r&oacute;tulos del medidor y el final del interior. <b>El cotejo "
              "contra la VRAM de openMSX est&aacute; pendiente.</b> El listado "
              "se reensambla <b>byte a byte</b> con <code>make</code>.",
    ),
    "en": dict(
        titulo="Nemesis 2 - a commented disassembly",
        claim="The twelve stages built from their maps, the five bosses from "
              "their records, the ship with its weapons and the seven that can "
              "be captured, the way back through the planets, the three secret "
              "stages and what changes with the cartridge in the other slot. "
              "All drawn from the ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "An <b>RC-751</b> cartridge, a 128 KB MegaROM (Konami with SCC)",
               "<b>MSX</b>", "Dump <b>227113f9...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b> with the cartridge's own tables: the title, "
              "the maps, the enemies, the items, the bosses, the ship, the "
              "power meter labels and the ending of the interior. <b>The check "
              "against the openMSX VRAM is still to be done.</b> The listing "
              "reassembles <b>byte for byte</b> with <code>make</code>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("Tres palabras en la pausa, con Q*bert al lado",
         "<p>Con F1 se para el juego y se puede teclear (<code>p03:BD7C</code>), "
         "pero solo si en el otro slot est&aacute; <em>Q*bert</em> "
         "(<code>0xF0F5</code> bit 0). <b>LARS18TH</b> da el medidor y las armas "
         "enteras con escudo y dos opciones, <b>NEMESIS</b> salta a la fase "
         "siguiente y <b>METALION</b> deja la nave intocable 30 veces 32 "
         "cuadros.</p><p>Le&iacute;do en el c&oacute;digo.</p>"),
        ("El otro cartucho cuenta",
         "<p>Al arrancar se miran los cuatro slots (<code>p03:BCB1</code>). Con "
         "<em>Maze of Galious</em> al lado, al caer se guarda el equipo y la "
         "casilla BACK UP lo devuelve (<code>p02:8E7C</code>, <code>p01:7DD9</code>). "
         "Con <em>Penguin Adventure</em> la nave es un ping&uuml;ino.</p>"
         "<p>Le&iacute;do en el c&oacute;digo.</p>"),
        ("Tres fases secretas",
         "<p>En las fases 3, 6 y 10 hay una entrada escondida en una columna "
         "fija (<code>p03:BF3A</code>): el scroll se para 64 cuadros y luego "
         "corre a doble velocidad hasta las fases 9, 10 y 11.</p>"
         "<p>Le&iacute;do en el c&oacute;digo.</p>"),
        ("Al jefe hay que entrarle",
         "<p>Vencido, su boca queda abierta 300 cuadros (<code>p11:A93F</code>): "
         "si la nave no entra, estalla y no hay interior ni arma "
         "capturada.</p><p>Le&iacute;do en el c&oacute;digo.</p>"),
        ("La vuelta",
         "<p>La fase que sigue sube de la 1 a la 7 y luego baja de la 6 a la 0 "
         "(<code>p01:7C59</code>), con <code>0xE20A</code> impar y m&aacute;s "
         "enemigos. Tras el jefe de la 7 sale DR.VENOM IS FAST APPROACHING "
         "NEMESIS, RETURN IMMEDIATELY! (<code>p14:94D1</code>).</p>"
         "<p>Le&iacute;do en el c&oacute;digo.</p>"),
    ],
    "en": [
        ("Three words in the pause, with Q*bert alongside",
         "<p>F1 stops the game and lets you type (<code>p03:BD7C</code>), but "
         "only if <em>Q*bert</em> is in the other slot (<code>0xF0F5</code> "
         "bit 0). <b>LARS18TH</b> fills the power meter and the weapons with a "
         "shield and two options, <b>NEMESIS</b> skips to the next stage and "
         "<b>METALION</b> makes the ship untouchable for 30 times 32 "
         "frames.</p><p>Read in the code.</p>"),
        ("The other cartridge matters",
         "<p>At start-up the four slots are checked (<code>p03:BCB1</code>). "
         "With <em>Maze of Galious</em> alongside, the equipment is kept when "
         "the ship is lost and the BACK UP box gives it back "
         "(<code>p02:8E7C</code>, <code>p01:7DD9</code>). With <em>Penguin "
         "Adventure</em> the ship is a penguin.</p><p>Read in the code.</p>"),
        ("Three secret stages",
         "<p>Stages 3, 6 and 10 hide an entrance at a fixed column "
         "(<code>p03:BF3A</code>): the scroll stops for 64 frames and then "
         "runs at double speed into stages 9, 10 and 11.</p>"
         "<p>Read in the code.</p>"),
        ("You have to go into the boss",
         "<p>Once beaten, its mouth stays open for 300 frames "
         "(<code>p11:A93F</code>): if the ship does not go in, it blows up and "
         "there is no interior and no captured weapon.</p>"
         "<p>Read in the code.</p>"),
        ("The way back",
         "<p>The next stage goes up from 1 to 7 and then down from 6 to 0 "
         "(<code>p01:7C59</code>), with <code>0xE20A</code> odd and more "
         "enemies. After the stage 7 boss comes DR.VENOM IS FAST APPROACHING "
         "NEMESIS, RETURN IMMEDIATELY! (<code>p14:94D1</code>).</p>"
         "<p>Read in the code.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "El t&iacute;tulo, montado como lo hace el cartucho (<code>p01:615B</code>, "
     "<code>p01:61C1</code>); en un MSX japon&eacute;s dice GRADIUS.",
     "The title, built as the cartridge does it (<code>p01:615B</code>, "
     "<code>p01:61C1</code>); on a Japanese MSX it reads GRADIUS."),
    ("fase_01.png",
     "La fase 1 entera, desde su mapa de metabloques (<code>p13:7900</code>).",
     "Stage 1 in full, from its metablock map (<code>p13:7900</code>)."),
    ("jefe_3.png",
     "El jefe 3, montado desde su ficha (<code>p09:BB01</code>).",
     "Boss 3, built from its record (<code>p09:BB01</code>)."),
    ("enemigos_f01.png",
     "Los tipos de enemigo de la fase 1 con el dibujo de su ficha "
     "(<code>p00:4F4C</code>) y los dibujos de sprite de la fase.",
     "The enemy types of stage 1 with the drawing from their record "
     "(<code>p00:4F4C</code>) and the stage's sprite patterns."),
    ("recogidas.png",
     "Las c&aacute;psulas: la del medidor, la que hace caer a todos, la vida, "
     "las de puntos y las cuatro especiales (<code>p00:5265</code>, "
     "<code>p08:9094</code>).",
     "The capsules: the power meter one, the one that destroys everything, "
     "the extra life, the point ones and the four specials "
     "(<code>p00:5265</code>, <code>p08:9094</code>)."),
    ("nave.png",
     "La nave: normal, con escudo, el R.DRILL y el ping&uuml;ino "
     "(<code>p03:A879</code>).",
     "The ship: normal, with the shield, the R.DRILL and the penguin "
     "(<code>p03:A879</code>)."),
    ("final_dos.png",
     "El final del interior con dos armas capturadas (<code>p01:74A2</code>).",
     "The end of the interior with two captured weapons (<code>p01:74A2</code>)."),
]

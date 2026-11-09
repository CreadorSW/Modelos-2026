#import "@preview/peace-of-posters:0.6.0": *
#import "@preview/cades:0.3.1": qr-code
#import "@preview/meander:0.4.4"


#set text(font: "New Computer Modern", fill: black, size: 20pt)
#set par(justify: true)

#set page("a1", margin: 1cm)

#let box-spacing = 0.5cm
#set columns(gutter: box-spacing)
#update-poster-layout(title-size: 40pt, heading-size: 25pt, body-size: 26pt)

#let pu-color = rgb("#CFB991")
#let pu-theme = (
  "body-box-args": (
    fill: white,
    inset: 1em,
    stroke: pu-color,
    width: 100%
  ),
  "heading-box-args": (
    inset: 0.7em,
    fill: pu-color,
    width: 100%
  ),
  "heading-text-args": (fill: black, ),
  "title-text-args": (
    weight: "regular",
  ),
  "title-box-args": (
    fill: white,
    stroke: none
  ),
)
#set-theme(pu-theme)


// Title Section: grid to place title in between QR code and logos, plus center it
#grid(
  columns: (auto, auto, auto),
  column-gutter: 10pt,
align(left)[
    #image("logounahur_recortado.png", width: 5cm)
  ],
align(center)[
  #set par(leading: 0.9cm, spacing: 0.9cm)
  #title-box(
    [#smallcaps[el problema de la cuota futura]],
    subtitle: [#text(50pt)[Una experiencia de modelado con matemática financiera]],
    // background: image(),
    // authors: [Isaac Wheeler, Vivek Narsimhan, Alina Alexeenko\*   alexeenk\@purdue.edu],

    // institutes: "Purdue University, Davidson School of Chemical Engineering",
  )
  #line(length: 90%)
  Sofía Barraza, Nicolás Brugnoni, Sofía Calcagno, Tomás Castillo, Micaela Gómez, Javier García, Santiago Gutiérrez, Mariela López, Ayelén Martínez.\
  //*Universidad Nacional de Hurlingham*
  ],
  align(right)[
    #image("logounahur_recortado.png", width: 5cm)
  ],
)

#column-box(heading: [Objetivos])[
  - Poner en juego el proceso de modelado matemático en un contexto financiero.
  - Comprender el concepto clave de valor presente mediante la resolución de un problema económico real.
  - Validar la teoría mediante la implementación de código, contrastando resultados y comportamientos esperados.
]

#column-box(heading: [Contexto])[Melina compró un terreno y lo está pagando en cuotas. El plan firmado tiene 120 cuotas mensuales que
se pagan en forma regresiva: primero se paga la 120, luego la 119, y así sucesivamente hasta la cuota 1.
Las cuotas se pagan por adelantado al inicio de cada mes: la cuota 120 vence en el momento de la firma
$t=0$ y la cuota 1 vence en el mes 119 $t = 119$. El valor base de la cuota hoy es 100000 pesos ($C =
100$), pero las cuotas no son fijas: se actualizan periódicamente según un índice de actualización salarial,
y el valor que ese índice va a tomar en el futuro no se conoce.]

#columns(2, gutter: 1.5em)[
  #column-box(heading: "Caso base: concepto de anualidad")[*Valor presente individual* ($C$ pagada en el mes $t$):

$ "PV"_t = C / (1+r)^t $

*Plan completo* ($C = 100$, $t = 0, dots, 119$):

$ "PV"_A &= sum_(t=0)^(119) 100/(1+r)^t
         = 100 sum_(t=0)^(119) (1/(1+r))^t\ &= 100 ( (1 - (1/(1+r))^(120)) / (1 - 1/(1+r)) ) \
         &= 100 (1+r) (1 - (1+r)^(-120)) / r
$


//$ &= 100 ( (1 - (1/(1+r))^(120)) / (1 - 1/(1+r)) ) $


//#align(center)[
//  #box(stroke: 0.6pt, inset: 8pt)[
 //   $ "PV"_A = 100 (1+r) (1 - (1+r)^(-120)) / r $
 // ]
//]
  ]
#column-box(heading: "Tasa variable")[

   ¿Qué cambia? Ahora la tasa $r$ de descuento del mercado es variable, fluctúa mes a mes. Por eso, el valor presente debe calcularse considerando la trayectoria de las tasas.


  #grid(
    columns: (6em, 9em, 11em),
    rows: (auto),
    gutter: 20pt,
    [$"PV"_1=C/(1+r_1)$,],
    [$"PV"_2=C/((1+r_1)(1+r_2))$,],
    [$"PV"_3=C/((1+r_1)(1+r_2)(1+r_3))$],
  )

  $ P V = sum_(t=0)^(119) frac(C, product_(k=1)^t (1+r_k)) $

  #grid(
   columns:(5em,20em),
   rows:(auto),
   gutter:20pt,
   [#image("qr_tasa_variable.png",width: 100%)],
   [¿Qué cambia en el código? Mientras que antes usábamos una tasa única, ahora el código procesa una serie de tasas escogidas con algún criterio.]

  )]




   #column-box(heading: [Tasa de indiferencia, $r$ constante, $N = 5$.])[
    #image("grafico_tasa_7.93.pdf", width: 26cm)



  ]

  // ========================================
  // Después del colbreak están los bloques de la columna derecha
  #colbreak()
  // ========================================

  #column-box(heading: "Adelanto de bloques")[
  *Hipótesis:* $C$ y $r$ constantes, $N in {4, ..., 8}$ cuotas por bloque y la cuota #box[$N+1$] bonificada.


  *Tasa de indiferencia $r^*$ para pagos secuenciales* planteamos $"PV"_A = "PV"_B$ con $q = 1\/(1+r)$. Usando $"PV"_A$ como antes y

  $ "PV"_B &= sum_(k=0)^floor(120/(N+1)) N ·C · q^(k(N+1)) + "(cuotas restantes)" $

  $ 100(1-q^120)/(1-q^#hide[120]) = N thin 100 (1-q^120)/(1-q^(N+1))   $
  $ => 1 + q + q^2 + dots + q^N = N $

  #grid(
  columns: (5em, 1fr, 1fr),
  rows: (auto, auto),
  gutter: 15pt,
  align: (col, row) => (
    if col == 0 { horizon + center }
    else { left + horizon }
  ),

  // Fila 1 & 2, Columna 1: Imagen (2 filas de alto x 1 columna de ancho)
  grid.cell(
    rowspan: 2,
    image("qr_adelanto_de_bloques.png", width: 100%),
  ),

  // Fila 1, Columnas 2 & 3: Título de la regla (1 fila de alto x 2 columnas de ancho)
  grid.cell(
    colspan: 2,
    [*Regla de decisión* (vale para cualquier mes de adelanto):],
  ),

  // Fila 2, Columna 2: Primer caso
  [$r < r^* => "adelantar"$],

  // Fila 2, Columna 3: Segundo caso
  [$r > r^* => "mes a mes"$],
)
  ]

  #column-box(heading: "Tasa variable e indexación salarial")[
  #set par(justify: true)

  Con *$g$ y $r$ constantes* para un momento $t$ tenemos $"PV"_t = (1+g)^t\/ (1+r)^t$. Llamando $Q = (1+g)\/(1+r)$ y armando las sumatorias de forma análoga se plantea $"PV"_A &= "PV"_B$ y se llega a

  $ 1 + Q + Q^2 + dots + Q^N = N $



   *Con $g$ y $r$ variables.*
   $ "PV"_t = C · product_(tau=1)^t ((1+g_tau)/(1+r_tau)) $

   $ "PV" = sum_(t=1)^(119) ( C product_(tau=1)^t ((1+g_tau)/(1+r_tau))) $
  ]

  #column-box(heading: "Reflexión Final")[
      La naturaleza del problema nos convocó a articular saberes matemáticos con la producción de código, de modo que este último jugó un rol indispensable en el desarrollo del modelado. Esto nos permite apreciar la importancia de combinar la matemática y la programación para facilitar y profundizar la comprensión de un problema potente y rico en análisis.

     //#v(1em)
      #align(right)[
        #grid(
          columns: (auto, auto),
          gutter: 10pt,
          align: (right + horizon, center + horizon),
          [
            #text(size: 15pt, fill: luma(70))[
              *Contacto*\
              javierpedro.garcia\@unahur.edu.ar
            ]
          ],
          qr-code("mailto:javierpedro.garcia@unahur.edu.ar", width: 2cm)
        )
      ]

  ]
]

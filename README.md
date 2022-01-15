
<!-- README.md is generated from README.Rmd. Please edit that file -->
Insurance Analysis
==================

<!-- badges: start -->
<!-- badges: end -->
Se obtuvieron datos de las reclamaciones de una aseguradora en Monterrey. De acuerdo a los datos obtenidos es posible combinar los riesgos del portafolio de la aseguradora. Este reporte se crea como un soporte para el Comité de Riesgo para conocer la estructura de los riesgos así como la influencia de las reclamaciones con las variables que se conocen.

Esta es la base de datos con la que trabajaremos

    #>   Kilometres Zone Bonus Make Insured Claims Payment
    #> 1          1    1     1    1  455.13    108  392491
    #> 2          1    1     1    2   69.17     19   46221
    #> 3          1    1     1    3   72.88     13   15694
    #> 4          1    1     1    4 1292.39    124  422201
    #> 5          1    1     1    5  191.01     40  119373
    #> 6          1    1     1    6  477.66     57  170913

1.  kilometros. variable para describir la categoría que representa el número de kilómetros recorridos por asegurado.

Hay 5 categorías 1-5 con los siguientes kilometros: 1: &lt; 1,000 kilómetros 2: 1,000-15,000 kilómetros 3: 15,000-20,000 kilómetros 4: 20,000-25,000 kilómetros 5: 25,000 kilómetros

1.  zona. variable para definir el municipio al que pertenece dicho asegurado. 1: Monterrey 2: San Pedro 3: San Nicolás 4: Escobedo

5: Guadalupe 6: Garcia 7: Otros

1.  Bonus: Número de años desde que dicho asegurado presentó una reclamación más un año adicional.

2.  modelo. Modelo del carro asegurado del 1-8 representamos 8 distintos modelos y en el 9 representa todos los demás.

3.  asegurados. Número de asegurados por cada año de póliza, es decir, si tienes una flotilla de 100 carros y llevan asegurados 3 años exactos el número que representara a estos asegurados sera 300

4.  Reclamaciones. Número de reclamaciones realizadas por el lote o asegurado.

5.  Pagos. Valor en dólares del pago realizado para cubrir reclamaciones

![](README_files/figure-markdown_github/pressure-1.png)

In that case, don't forget to commit and push the resulting figure files, so they display on GitHub.

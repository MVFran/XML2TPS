<br> <img src="images\xml2tps-logo.png" align="left" width="124">

<br>

# **xml2tps**

## <br>

Este es un pequeño programa útil para realizar transformaciones de los
archivos de salida de [Ml-Morph](https://github.com/agporto/ml-morph),
generados con la extensión “.xml” a “.tps”. En otras palabras, un
conversor de xml a tps.

Ml-Morph es una herramienta informática basada en aprendizaje-máquina
que permite la obtención de la forma (shape) de los individuos de
interés mediante coordenadas colocadas automáticamente. Con dichas
formas, el investigador puede realizar subsecuentes análisis de
**Morfometría Geométrica**. Aunque es una herramienta poderosa y con un
alto grado de precisión, en ocasiones el investigador querrá ajustar la
posición de algún landmark en particular, agregar curvas para capturar
esa variación o incluir escala en cada uno de sus individuos para
explorar los efectos de la alometría en su dataset.

Esta pequeña aplicación es multiplataforma ya que está desarrollada en
los lenguajes de ***python*** y ***r***. Su ejecución e instalación son
sencillas; hemos agregado instrucciones para su uso, así como listado
las librerías necesarias para que se ejecute exitosamente en cualquiera
de los lenguajes. <br> <br> <br> **Autores**:  
Francisco Miranda Vázquez  
email: <francisco55555mv@ciencias.unam.mx>

Angel Angeles Cortés  
email: <angel_10@ciencias.unam.mx>

Dr. Jesús Alberto Díaz-Cruz  
email: <vertebrata.j@ciencias.unam.mx> <br><br>

## Python dependencies

- pandas >= 2.0.3

Además, las librerias:
- os
- csv
- xml.etree.ElementTree

son modulos estandar de la biblioteca de python, por lo que vienen instaladas por defecto. <br><br>

## Uso

Para usarlo de forma sencilla, se descarga el archivo _xml2tps.py_ en la misma ruta donde se encuentre el archivo _xml_ que se desea transformar, una vez descargado se abre el archivo, y sobre la última linea se añade la función:

_xml2tps(xmlfile, tpsfile, fname = '', LM = 0)_ <br><br>

**Argumentos**

_xmlfile_ aquí debe añadirse (entre comillas dobles o simples) el nombre del archivo _xml_ que se desea transformar (junto a su extensión _.xml_).

_tpsfile_ aquí se añade el nombre con el que se desea guardar el archivo _tps_ (de igual forma debe añadirse entre comillas justo a la extensión _.tps_).

_fname = ''_ Si sucede que, los datos del archivo _xml_ en donde se encuentran las imagenes contienen el nombre de la carpeta en la que se encuentran, debe de añadirse entre comillas el nombre de la carpeta para que el archivo _tps_ pueda reconocer las imagenes.

_LM_ Aquí se colocan la cantidad de landmarks que contiene el archivo (contando unicamente un eje), por ejemplo: Solo se coloca la cantidad de landmarks que hay en el eje _X_. <br><br>

## Ejecución desde la terminal

Una vez añadidos los datos, se abre la terminal y debemos dirigirnos a la carpeta en donde esta guardado el programa, para ejecutar el siguiente comando:

_python xml2tps.py_

El cual va a ejecutar la función además de realizar la conversión del archivo _xml_ a un archivo _tps_.

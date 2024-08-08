# Manual de Uso

## Dependencias de Python

Debemos tener previamente instalada la libreria:
- pandas >= 2.0.3
- pillow >= 10.0.1

Además, las librerias:
- os
- csv
- xml.etree.ElementTree

son modulos estandar de la biblioteca de python, por lo que vienen instaladas por defecto. <br><br>


## Uso

Para usarlo de forma sencilla, se descarga el archivo [`xml2tps.py`](/Spanish/Python/xml2tps.py) en la misma ruta donde se encuentre el archivo `xml` que se desea transformar.

![imagen01](/images/imagen01.jpeg)

Una vez descargado, podemos abrirlo con el block de notas o con algún IDE:

![imagen02](/images/imagen02.jpeg)

Vamos a la ultima linea y escribimos la función: 

    xml2tps(xmlfile, tpsfile, images, fname = '', LM = 0)

![imagen03](/images/imagen03.jpeg)
    
Ahora, es necesario modificar los argumentos.
<br><br>

**Argumentos**

`xmlfile` aquí debe añadirse (entre comillas dobles o simples) el nombre del archivo _xml_ que se desea transformar (junto a su extensión .xml), por ejemplo, el archivo `prueba.xml`.

`tpsfile` aquí se añade el nombre con el que se desea guardar el archivo _tps_ (de igual forma debe añadirse entre comillas justo a la extensión _.tps_), por ejemplo, queremos que se guarde como `resultado.tps`.

`images` aquí debe colocarse el nombre de la carpeta en la que esten almacenadas las imagenes que necesitamos para nuestro estudio, este argumento se necesita pues el programa [Ml-Morph](https://github.com/agporto/ml-morph) modifica los valores en el eje _Y_, entonces es necesario ajustar nuevamente esos valores para que se coloquen de manera adecuada los landmarks.

`fname = ''` Si sucede que, los datos del archivo _xml_ en donde se encuentran las imagenes contienen el nombre de la carpeta en la que se encuentran, debe de añadirse entre comillas el nombre de la carpeta para que el archivo _tps_ pueda reconocer las imagenes, en nuestro ejemplo podemos ver que se encuentra el nombre _**"train\\"**_ antes de el nombre original de la imagen.

![imagen04](/images/imagen04.jpeg)

`LM` Aquí se colocan la cantidad de landmarks que contiene el archivo (contando unicamente un eje), por ejemplo: Solo se coloca la cantidad de landmarks que hay en el eje _X_, en nuestro ejemplo tenemos **12** landmarks. 

Por lo que, tras agregar la función, se tiene:

    xml2tps("prueba.xml", "resultado.tps", "imagenes", fname = 'train\\', LM = 12)

![imagen05](/images/imagen05.jpeg)

Finalmente, guardamos los cambios en el documento.
 
Y si estamos en un IDLE, podemos ejecutarlo de una vez desde el interprete que se este usando.

<br><br>

## Ejecución desde la terminal

Una vez añadidos y guardados los datos, se abre una terminal para ejecutar el programa, para esto debemos de ubicarnos en la carpeta en la que se descargó previamente el programa `xml2tps`.

![imagen06](/images/imagen06.jpeg)

Una vez aquí, se debe ejecutar el siguiente comando:

    python xml2tps.py

![imagen07](/images/imagen07.jpeg)

El cual va a ejecutar la función además de realizar la conversión del archivo `xml` que colocamos a un archivo `tps`.

Finalmente, podemos ver como se creó correctamente el archivo `resultado.tps`

![imagen08](/images/imagen08.jpeg)
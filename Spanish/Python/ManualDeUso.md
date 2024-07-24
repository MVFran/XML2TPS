# Manual de Uso

## Dependencias de Python

Debemos tener previamente instalada la libreria:
- pandas >= 2.0.3

Además, las librerias:
- os
- csv
- xml.etree.ElementTree

son modulos estandar de la biblioteca de python, por lo que vienen instaladas por defecto. <br><br>


## Uso

Para usarlo de forma sencilla, se descarga el archivo `xml2tps.py` en la misma ruta donde se encuentre el archivo `xml` que se desea transformar.

![Imagen01](/images/Imagen01.jpeg)

Una vez descargado, podemos abrirlo con el block de notas o con algún IDE:

![Imagen02](/images/Imagen02.jpeg)

Vamos a la ultima linea y escribimos la función: 

    xml2tps(xmlfile, tpsfile, fname = '', LM = 0, top = 0) 

![Imagen03](/images/Imagen03.jpeg)
    
Ahora, es necesario modificar los argumentos.
<br><br>

**Argumentos**

`xmlfile` aquí debe añadirse (entre comillas dobles o simples) el nombre del archivo _xml_ que se desea transformar (junto a su extensión .xml), por ejemplo, el archivo `prueba.xml`.

`tpsfile` aquí se añade el nombre con el que se desea guardar el archivo _tps_ (de igual forma debe añadirse entre comillas justo a la extensión _.tps_), por ejemplo, queremos que se guarde como `resultado.tps`.

`fname = ''` Si sucede que, los datos del archivo _xml_ en donde se encuentran las imagenes contienen el nombre de la carpeta en la que se encuentran, debe de añadirse entre comillas el nombre de la carpeta para que el archivo _tps_ pueda reconocer las imagenes, en nuestro ejemplo podemos ver que se encuentra el nombre _**"train\\"**_ antes de el nombre original de la imagen.

![Imagen04](/images/Imagen04.jpeg)

`LM` Aquí se colocan la cantidad de landmarks que contiene el archivo (contando unicamente un eje), por ejemplo: Solo se coloca la cantidad de landmarks que hay en el eje _X_, en nuestro ejemplo tenemos **12** landmarks. 

`top` Este argumento es porque el programa [Ml-Morph](https://github.com/agporto/ml-morph) modifica los valores en el eje _Y_, por lo que, es necesario acomodar dichos valores, para esto, top recibe como argumento la altura (en pixeles) de las imagenes, por lo que debemos acceder a las propiedades de cualquier imagen y ver el alto, en nuestro caso es de **2000**.

![Imagen05](/images/Imagen05.jpeg)

Por lo que, tras agregar la función, se tiene:

    xml2tps("prueba.xml", "resultado.tps", fname = "train\\", LM = 12, top = 2000)

![Imagen06](/images/Imagen06.jpeg)

Finalmente, guardamos los cambios en el documento.

<br><br>

## Ejecución desde la terminal

Una vez añadidos y guardamos los datos, se abre la terminal, para esto se usa el comando `windows + r`, lo cual nos abre una ventana, donde debemos escribir `cmd` y seleccionar `aceptar`.

![Imagen07](/images/Imagen07.jpeg)

Aquí, debemos dirigirnos a la carpeta en donde esta guardado el programa que editamos previamente, para ejecutar el siguiente comando:

    python xml2tps.py

![Imagen08](/images/Imagen08.jpeg)

El cual va a ejecutar la función además de realizar la conversión del archivo `xml` que colocamos a un archivo `tps`.

Finalmente, podemos ver como se creó correctamente el archivo `resultado.tps`

![Imagen9](/images/Imagen9.jpeg)
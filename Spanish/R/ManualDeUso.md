# Manual de Usuario para `xml2tps`

## Descripción

La función `xml2tps` convierte datos de un archivo XML a un formato TPS. Esta función es útil para procesar datos de imágenes y coordenadas almacenadas en archivos XML y convertirlas a un formato adecuado para análisis en sistemas que utilicen archivos TPS.
Este paquete funciona para versiones de Rstudio menores a 4.4.0

## Guía de instalación 

1. Instala "devtools" si no lo tienes ya instalado:
   ~~~ r
   install.packages("devtools")
   ~~~
2. Importa "devtools" y usa install_github() para instalar el paquete desde GitHub:
   ~~~
   library(devtools)
   install_github("MVFran/XML2TPS")
   ~~~
3. Importa el paquete xml2tps:
   ~~~
   library(xml2tps)
   ~~~

## Parametros

- xmlfile: (Obligatorio) Ruta al archivo XML de entrada que contiene los datos a convertir.
- tpsfile: (Obligatorio) Ruta al archivo TPS de salida donde se guardarán los datos convertidos.
- LM: (Opcional) Número de landmarks (puntos de referencia) que se espera encontrar en cada imagen.
 Por defecto es 0.
- fname: (Opcional) Nombre del archivo o parte del nombre que se debe eliminar de las rutas de los
archivos de imagen en el XML. Por defecto es una cadena vacía ("").
- img_dir: (Obligatorio) Directorio donde se encuentran las imágenes mencionadas en el archivo XML.
 Si se proporciona, la función leerá las alturas de las imágenes desde este directorio.

## Funcionalidades

### Lectura de imágenes
Puede leer los siguientes formatos de imágenes:
- PNG
- BMP
- TIFF
- JPEG
  
Lee las alturas de las imagenes para corregir las coordenadas y reflejar los puntos de las imágenes en el archivo XML.

### Procesamiento de Coordenadas
La función extrae y corrige las coordenadas de los landmarks de las imágenes, reflejándolas si es necesario, y las escribe en el archivo TPS.

### Identificación de Imágenes
Cada imagen procesada recibe un ID único en el archivo TPS generado. Esto facilita la referencia cruzada de imágenes con sus datos correspondientes.

## Consideraciones
- "No se encontró la altura en el archivo JPEG/PNG/BMP/TIFF": Este error ocurre si la función no puede encontrar o leer correctamente la altura de una imagen. Verifica que las imágenes estén en un formato válido y que la ruta proporcionada sea correcta.
- "Formato de imagen no soportado": Se produce si la función encuentra una imagen en un formato que no es JPEG, PNG, BMP o TIFF. Asegúrate de que todas las imágenes estén en uno de los formatos soportados.
- Formato de nombres: Si estás utilizando el parámetro fname, asegúrate de que solo contenga la parte de los nombres de archivo que deseas eliminar. Eliminar incorrectamente partes del nombre de archivo puede llevar a errores.
- Compatibilidad de formatos: Actualmente, la función solo soporta imágenes en los formatos mencionados anteriormente. Si utilizas otros formatos, es necesario convertirlos antes de ejecutar la función.
## Ejemplo de uso
~~~
library(xml2tps)
xml2tps("datos.xml", "salida.tps", LM = 5, fname = "image/", img_dir = "imagenes/")
~~~


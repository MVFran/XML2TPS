# Conversión de archivos XML a TPS

## Descripción

Este script en R permite convertir un archivo XML a formato TPS, utilizando información de imágenes y coordenadas de puntos. El código incluye la instalación de paquetes necesarios, la definición de funciones auxiliares y la ejecución de la conversión.

### Requisitos para Utilizar el Programa `xml2tps`

Para utilizar el programa `xml2tps` y asegurar su correcto funcionamiento, es necesario cumplir con los siguientes requisitos:

### 1. Instalación de R

Asegúrate de tener instalado R en tu sistema (versión 4.0.0 o superior). Puedes descargarlo e instalarlo desde la página oficial de R:

- [Descargar R](https://cran.r-project.org/)

### 2. Instalación de los Paquetes Necesarios

Este programa requiere los siguientes paquetes de R con las versiones mínimas indicadas:

- `magick` (2.7.0 o superior)
- `dplyr` (1.0.0 o superior)
- `XML` (3.99-0.5 o superior)
- `stringr` (1.4.0 o superior)
- `data.table` (1.12.8 o superior)


### 3. Instalación de paquetes necesarios

```r
if (!requireNamespace("magick", quietly = TRUE)) install.packages("magick")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("XML", quietly = TRUE)) install.packages("XML")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
if (!requireNamespace("data.table", quietly = TRUE)) install.packages("data.table")

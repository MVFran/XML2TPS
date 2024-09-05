#' XML2TPS
#'
#' @param xmlfile Name of the xml file
#' @param tpsfile Name of the tps file it will return
#' @param fname  Part of the images name it will erase
#' @param LM Number of landmarks you wish to work
#' @param image_directory Directory of the images archive you will work
#'
#' @return A tps file with all the data specified in the xml file
#' @export
#'
#'

xml2tps<- function(xmlfile, tpsfile, LM = 0, fname = "", img_dir = "") {


  leer_altura_jpeg <- function(ruta_archivo) {
    con <- file(ruta_archivo, "rb")
    contenido <- readBin(con, what = raw(), n = file.info(ruta_archivo)$size)
    close(con)

    for (i in 1:(length(contenido) - 1)) {
      if (contenido[i] == as.raw(0xFF) && contenido[i + 1] == as.raw(0xC0)) {
        altura <- as.integer(contenido[i + 5]) * 256 + as.integer(contenido[i + 6])
        return(altura)
      }
    }

    stop("No se encontró la altura en el archivo JPEG")
  }


  leer_altura_png <- function(ruta_archivo) {
    con <- file(ruta_archivo, "rb")
    contenido <- readBin(con, what = raw(), n = 24)
    close(con)

    altura <- as.integer(contenido[21]) * 256^3 +
      as.integer(contenido[22]) * 256^2 +
      as.integer(contenido[23]) * 256 +
      as.integer(contenido[24])

    return(altura)
  }


  leer_altura_bmp <- function(ruta_archivo) {
    con <- file(ruta_archivo, "rb")
    contenido <- readBin(con, what = raw(), n = 26)
    close(con)

    altura <- as.integer(contenido[23]) +
      as.integer(contenido[24]) * 256 +
      as.integer(contenido[25]) * 256^2 +
      as.integer(contenido[26]) * 256^3

    return(altura)
  }


  leer_altura_tiff <- function(ruta_archivo) {
    con <- file(ruta_archivo, "rb")
    contenido <- readBin(con, what = raw(), n = 500)  # Leer una cantidad suficiente de bytes
    close(con)


    if (!(contenido[1] == as.raw(0x49) && contenido[2] == as.raw(0x49)) &&  # Little endian
        !(contenido[1] == as.raw(0x4D) && contenido[2] == as.raw(0x4D))) {  # Big endian
      stop("No es un archivo TIFF válido")
    }

    .
    endian <- ifelse(contenido[1] == as.raw(0x49), "little", "big")


    ifd_offset <- as.integer(readBin(contenido[5:8], what = integer(), size = 4, endian = endian))


    num_entries <- as.integer(readBin(contenido[(ifd_offset + 1):(ifd_offset + 2)], what = integer(), size = 2, endian = endian))


    for (i in 1:num_entries) {
      entry_offset <- ifd_offset + 2 + (i - 1) * 12
      tag <- as.integer(readBin(contenido[(entry_offset + 1):(entry_offset + 2)], what = integer(), size = 2, endian = endian))


      if (tag == 256) {
        altura <- as.integer(readBin(contenido[(entry_offset + 9):(entry_offset + 12)], what = integer(), size = 4, endian = endian))
        return(altura)
      }
    }

    stop("No se encontró la altura en el archivo TIFF")
  }


  leer_altura_imagen <- function(ruta_archivo) {
    if (grepl("\\.jpg$|\\.jpeg$", ruta_archivo, ignore.case = TRUE)) {
      return(leer_altura_jpeg(ruta_archivo))
    } else if (grepl("\\.png$", ruta_archivo, ignore.case = TRUE)) {
      return(leer_altura_png(ruta_archivo))
    } else if (grepl("\\.bmp$", ruta_archivo, ignore.case = TRUE)) {
      return(leer_altura_bmp(ruta_archivo))
    } else if (grepl("\\.tiff$", ruta_archivo, ignore.case = TRUE)) {
      return(leer_altura_tiff(ruta_archivo))
    } else {
      stop("Formato de imagen no soportado")
    }
  }


  leer_alturas_directorio <- function(directorio) {
    archivos_imagenes <- list.files(directorio, pattern = "\\.(jpg|jpeg|png|bmp|tiff)$", full.names = TRUE, ignore.case = TRUE)
    alturas <- sapply(archivos_imagenes, leer_altura_imagen)
    names(alturas) <- basename(archivos_imagenes)  # Asignar nombres a las alturas
    return(alturas)
  }


  xml_content <- readLines(xmlfile)


  con <- file(tpsfile, open = "wt")

  row <- NULL
  img_id_counter <- 0  # Contador de ID de imágenes


  alturas_imagenes <- list()
  if (img_dir != "") {
    alturas_imagenes <- leer_alturas_directorio(img_dir)
  }

  for (i in seq_along(xml_content)) {
    if (grepl("<image", xml_content[i])) {
      img_file <- sub(".*file=\"([^\"]+)\".*", "\\1", xml_content[i])

      if (fname != "") {
        img_file <- sub(fname, "", img_file)
      }


      img_height <- NA
      if (img_file %in% names(alturas_imagenes)) {
        img_height <- alturas_imagenes[img_file]
      }

      row <- NULL  # Reiniciar la fila para la nueva imagen
    }

    if (grepl("<box", xml_content[i])) {

      top <- as.numeric(sub(".*top=\"([^\"]+)\".*", "\\1", xml_content[i]))
    }

    if (grepl("<part", xml_content[i])) {
      x <- as.numeric(sub(".*x=\"([^\"]+)\".*", "\\1", xml_content[i]))
      y <- as.numeric(sub(".*y=\"([^\"]+)\".*", "\\1", xml_content[i]))


      if (!is.na(img_height)) {
        y <- img_height - y
      }

      row <- c(row, x, y)
    }

    if (length(row) == 2 * LM) {
      cat(paste("LM=", LM, sep = ""), file = con)
      for (j in seq(1, length(row), by = 2)) {
        cat(paste("\n", row[j], row[j + 1], sep = " "), file = con)
      }
      cat(paste("\nIMAGE=", img_file, sep = ""), file = con)
      cat(paste("\nID=", img_id_counter, sep = ""), file = con)
      cat("\n", file = con)  # Separador para la siguiente entrada
      img_id_counter <- img_id_counter + 1
      row <- NULL  # Reiniciar la fila para la siguiente imagen
    }
  }
  close(con)
}

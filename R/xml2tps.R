
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
xml2tps <- function(xmlfile, tpsfile, fname = "", LM = 0, image_directory = "") {

  get_image_heights <- function(directory) {
    image_files <- list.files(directory, full.names = TRUE)
    image_files <- image_files[grepl("\\.(jpg|jpeg|png|gif|bmp)$", image_files, ignore.case = TRUE)]
    image_data <- data.frame(file = character(), height = numeric(), stringsAsFactors = FALSE)
    for (file in image_files) {
      img <- image_read(file)
      info <- image_info(img)
      image_data <- image_data %>% add_row(file = basename(file), height = info$height)
    }
    return(image_data)
  }
  if (image_directory != "") {
    image_heights <- get_image_heights(image_directory)
  }

  xml_data <- xmlParse(xmlfile)
  images <- getNodeSet(xml_data, "//image")
  csvfile <- "output.csv"
  csv_con <- file(csvfile, open = "wt")

  header <- c("id")
  for (i in 0:(LM - 1)) {
    header <- c(header, paste0("X", i), paste0("Y", i))
  }
  writeLines(paste(header, collapse = ","), csv_con)

  img_id_counter <- 0

  for (image in images) {
    img_file <- xmlGetAttr(image, "file")
    img_file <- str_replace(img_file, fname, "")

    if (image_directory != "") {
      img_height <- image_heights %>% filter(file == img_file) %>% select(height) %>% pull()
      top <- img_height
    }

    boxes <- getNodeSet(image, "box")

    for (box in boxes) {
      row <- c(img_file)
      parts <- getNodeSet(box, "part")
      for (part in parts) {
        x <- xmlGetAttr(part, "x")
        y <- as.numeric(xmlGetAttr(part, "y"))
        y <- abs(top - y)
        row <- c(row, x, y)
      }

      writeLines(paste(row, collapse = ","), csv_con)
      img_id_counter <- img_id_counter + 1
    }
  }

  close(csv_con)
  archivo <- fread(csvfile)
  matrix <- as.matrix(archivo)
  nombres <- matrix[, 1]
  coordenadas <- matrix[, -1]
  valoresX <- coordenadas[, seq(1, ncol(coordenadas), by = 2)]
  valoresY <- coordenadas[, seq(2, ncol(coordenadas), by = 2)]
  con <- file(tpsfile, open = "wt")

  for (i in 1:nrow(matrix)) {
    cat(paste("LM=", LM, sep = ""), file = con)
    for (j in 1:ncol(valoresX)) {
      cat(paste("\n", valoresX[i, j], valoresY[i, j], sep = " "), file = con)
    }

    cat(paste("\nIMAGE=", nombres[i], sep = ""), file = con)
    cat(paste("\nID=", i - 1, sep = ""), file = con)

    if (i < nrow(matrix)) {
      cat("\n", file = con)
    }
  }

  close(con)
  unlink(csvfile)
}

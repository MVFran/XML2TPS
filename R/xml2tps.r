library(XML)
library(stringr)
library(data.table)

xml2tps <- function(xmlfile, tpsfile, fname = "", LM = 0, top = 0) {
  
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

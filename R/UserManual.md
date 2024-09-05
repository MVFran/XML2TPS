

if (!requireNamespace("magick", quietly = TRUE)) install.packages("magick")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("XML", quietly = TRUE)) install.packages("XML")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
if (!requireNamespace("data.table", quietly = TRUE)) install.packages("data.table")




xml2tps("output.xml", "test01.tps", fname = "train\\\\", LM = 12, image_directory = "train")

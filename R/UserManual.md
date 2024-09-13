# User Manual for `xml2tps`

## Description

The `xml2tps` function converts data from an XML file into TPS format. This function is useful for processing image and coordinate data stored in XML files and converting them to a format suitable for analysis in systems that use TPS files.  
This package works for RStudio versions below 4.4.0.

## Installation Guide

1. Install "devtools" if you don't have it installed already:
   ```r
   install.packages("devtools")
   ```
2. Import "devtools" and use `install_github()` to install the package from GitHub:
   ```r
   library(devtools)
   install_github("MVFran/XML2TPS")
   ```
3. Import the `xml2tps` package:
   ```r
   library(xml2tps)
   ```

## Parameters

- **xmlfile**: (Required) Path to the input XML file containing the data to be converted.
- **tpsfile**: (Required) Path to the output TPS file where the converted data will be saved.
- **LM**: (Optional) Number of landmarks (reference points) expected in each image. The default is 0.
- **fname**: (Optional) Filename or part of the filename to be removed from the image file paths in the XML. The default is an empty string (`""`).
- **img_dir**: (Required) Directory where the images referenced in the XML file are located. If provided, the function will read the image heights from this directory.

## Features

### Image Reading
It can read the following image formats:
- PNG
- BMP
- TIFF
- JPEG

It reads the heights of the images to correct the coordinates and reflect the points from the images in the XML file.

### Coordinate Processing
The function extracts and corrects the coordinates of the landmarks from the images and writes them into the TPS file.

### Image Identification
Each processed image receives a unique ID in the generated TPS file, which facilitates the reference of images with their corresponding data.

## Considerations

- **"Height not found in JPEG/PNG/BMP/TIFF file"**: This error occurs if the function cannot find or correctly read the height of an image. Check that the images are in a valid format and that the provided path is correct.
- **"Unsupported image format"**: This error occurs if the function encounters an image in a format that is not JPEG, PNG, BMP, or TIFF. Ensure all images are in one of the supported formats.
- **Filename format**: If you are using the `fname` parameter, make sure it only contains the part of the filename you want to remove. Incorrectly removing parts of the filename may cause errors.
- **Format compatibility**: Currently, the function only supports images in the formats mentioned above. If you are using other formats, you need to convert them before running the function.

## Example usage

```r
library(xml2tps)
xml2tps("data.xml", "output.tps", LM = 5, fname = "image/", img_dir = "images/")
```


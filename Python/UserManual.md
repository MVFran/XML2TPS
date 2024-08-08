# User Manual

## Python dependencies 
We need to have the library :
- pandas >= 2.0.3
- pillow >= 10.0.1

The packages:
- os
- csv
- xml.etree.ElementTree
are standard packages of Python and come pre-instaled. <br><br>

## Use

To use it easily, download the [`xml2tps.py`](/Python/xml2tps.py) file to the same directory as the `xml` file you want to transform.

![imagen01](/images/imagen01.jpeg)

Once downloaded, you can open it with Notepad or any IDE.

![imagen02](/images/imagen02.jpeg)

Go to the last line and write the function:

    xml2tps(xmlfile, tpsfile, images, fname = '', LM = 0)

![imagen03](/images/imagen03.jpeg)

Now, it is necessary to modify the arguments.  <br><br>

**Arguments**

`xmlfile` here should include (in double or single quotes) the name of the XML file you wish to transform (including its .xml extension), for example, the file `prueba.xml`.

`tpsfile` here you add the desired name for the TPS file (also enclosed in quotes along with the `.tps` extension), for example, if you want to save it as `resultado.tps`.

`images` here you should place the name of the folder where the images we need for our study are stored. This argument is necessary because the [Ml-Morph](https://github.com/agporto/ml-morph) program modifies the values on the _Y_ axis, so it is necessary to readjust these values to properly position the landmarks.

`fname = ''` If the _xml_ file data includes the folder name where the images are located, you should add the folder name in quotes so that the _tps_ file can recognize the images. In our example, we can see that the folder name _**"train\\"**_ precedes the original image name.

![imagen04](/images/imagen04.jpeg)

`LM` Here you enter the number of landmarks contained in the file (counting only one axis). For example: You only enter the number of landmarks on the _X_ axis. In our example, we have **12** landmarks.

So, after adding the function, you have:

    xml2tps("prueba.xml", "resultado.tps", "imagenes", fname = 'train\\', LM = 12)

![imagen05](/images/imagen05.jpeg)

Finally, save the changes to the document.

And if we are in an IDLE, we can run it directly from the interpreter being used.

> **Note**
> In the fname argument, two backslashes were used where the files only contained a single backslash. This is because Python recognizes the backslash as an escape character, so if only one is used, the program will encounter an error. Therefore, if your folders contain a backslash, you must use another one for Python to work correctly.

<br><br>

## Execution from the terminal

Once the data has been added and saved, open a terminal to run the program. To do this, navigate to the folder where the `xml2tps` program was previously downloaded.

![imagen06](/images/imagen06.jpeg)

Here, the following command should be executed:

    python xml2tps.py

![imagen07](/images/imagen07.jpeg)

Which will execute the function and convert the `xml` file we placed to a `tps` file.

Finally, you can see that the `resultado.tps` file has been created successfully.

![imagen08](/images/imagen08.jpeg)
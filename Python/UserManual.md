# User Manual

## Python dependencies 
We need to have the library :
- pandas >= 2.0.3

The packages:
- os
- csv
- xml.etree.ElementTree
are standard packages of Python and come pre-instaled. <br><br>

## Use

To use it easily, download the `xml2tps.py` file to the same directory as the `xml` file you want to transform.

![Imagen01](/images/Imagen01.jpeg)

Once downloaded, you can open it with Notepad or any IDE.

![Imagen02](/images/Imagen02.jpeg)

Go to the last line and write the function:

    xml2tps(xmlfile, tpsfile, fname = '', LM = 0, top = 0) 

![Imagen03](/images/Imagen03.jpeg)

Now, it is necessary to modify the arguments.  <br><br>

**Arguments**

`xmlfile` here should include (in double or single quotes) the name of the XML file you wish to transform (including its .xml extension), for example, the file `prueba.xml`.

`tpsfile` here you add the desired name for the TPS file (also enclosed in quotes along with the `.tps` extension), for example, if you want to save it as `resultado.tps`.

`fname = ''` If the _xml_ file data includes the folder name where the images are located, you should add the folder name in quotes so that the _tps_ file can recognize the images. In our example, we can see that the folder name _**"train\\"**_ precedes the original image name.

![Imagen04](/images/Imagen04.jpeg)

`LM` Here you enter the number of landmarks contained in the file (counting only one axis). For example: You only enter the number of landmarks on the _X_ axis. In our example, we have **12** landmarks.

`top` This argument is because the [Ml-Morph](https://github.com/agporto/ml-morph) program modifies values on the _Y_ axis, so it's necessary to adjust these values accordingly. top takes as its argument the height (in pixels) of the images. You can check the height property of any image; in our case, it is **2000** pixels.

![Imagen05](/images/Imagen05.jpeg)

So, after adding the function, you have:

    xml2tps("prueba.xml", "resultado.tps", fname = "train\\", LM = 12, top = 2000)

![Imagen06](/images/Imagen06.jpeg)

Finally, save the changes to the document.

<br><br>

## Execution from the terminal

Once you've added and saved the data, open the terminal. On Windows, you can do this by pressing `Windows + R`, which opens a window. Type `cmd` and click `OK` to open the Command Prompt.

![Imagen07](/images/Imagen07.jpeg)

Here, you need to navigate to the folder where the program you edited earlier is saved, to execute the following command:

    python xml2tps.py

![Imagen08](/images/Imagen08.jpeg)

which will execute the function and convert the `xml` file we placed to a `tps` file.

Finally, you can see that the `resultado.tps` file has been created successfully.

![Imagen9](/images/Imagen9.jpeg)
def xml2tps(xmlfile, tpsfile, images, fname = '', LM = 0):   
    import os
    import pandas as pd 
    import xml.etree.ElementTree as ET
    import csv
    from PIL import Image

    image_sizes = {}
    valid_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff')  # Image's extensions

    for filename in os.listdir(images):
        if filename.lower().endswith(valid_extensions):
            image_path = os.path.join(images, filename)
            with Image.open(image_path) as img:
                image_sizes[filename] = img.size  
    
    alturas = []
    for size in image_sizes.items():
        alturas.append(size[1][1])
    
    tree = ET.parse(xmlfile)
    root = tree.getroot()

    with open("output.csv", "w", newline = "") as csvfile:
        csvwriter = csv.writer(csvfile)
        
        ID = ["id"]
        coordenadas = []
        for i in range(LM):
            valoresx, valoresy = f"X{i}", f"Y{i}"
            coordenadas.append(valoresx)
            coordenadas.append(valoresy)
        valores = ID + coordenadas
        csvwriter.writerow(valores)
    
        for image in root.find('images').findall('image'):
            file_id = image.get('file')
            box = image.find('box')
            parts = box.findall('part')
            coordinates = []
            for part in parts:
                x = part.get('x')
                y = part.get('y')
                coordinates.extend([x, y])

            row = [file_id] + coordinates
            csvwriter.writerow(row)
    
    archivo = pd.read_csv("output.csv")
    
    archivo["id"] = archivo["id"].str.replace(f"{fname}", "")
        
    matrix = archivo.to_numpy()
    nombres = []
    coordenadas = []
    valoresX = matrix[:, 1::2]
    valoresY = matrix[:, 2::2]

    for i in matrix:
        nombres.append(i[0])
    for i in range(len(valoresX)):
        lista_tuplas = list(zip(valoresX[i], abs(alturas[i] - valoresY[i])))
        coordenadas.append(lista_tuplas)
    data = {'id': nombres, 'landmarks': coordenadas}

    with open(tpsfile, 'w') as file:
        contador = 0
        for idx, id in enumerate(data['id']):
            file.write(f"LM={int(len(valoresX[0]))}\n")
            for (x, y) in data['landmarks'][idx]:
                file.write(f"{x} {y}\n")
            file.write(f"IMAGE={id}\n")
            file.write(f"ID={contador}\n")
            contador += 1
    with open(tpsfile, 'w') as file:
        contador = 0
        for idx, id in enumerate(data['id']):
            file.write(f"LM={int(len(valoresX[0]))}\n")
            for (x, y) in data['landmarks'][idx]:
                file.write(f"{x} {y}\n")
            file.write(f"IMAGE={id}\n")
            file.write(f"ID={contador}\n")
            contador += 1

    os.remove("output.csv")
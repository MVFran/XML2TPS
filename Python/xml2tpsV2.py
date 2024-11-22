def xml2tps(xmlfile, tpsfile, images, fname='', LM=0):   
    import os
    import pandas as pd 
    import xml.etree.ElementTree as ET
    import csv
    from PIL import Image

    tree = ET.parse(xmlfile)
    root = tree.getroot()

    image_heights = {}
    valid_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff')

    for filename in os.listdir(images):
        if filename.lower().endswith(valid_extensions):
            image_path = os.path.join(images, filename)
            with Image.open(image_path) as img:
                image_heights[os.path.basename(filename)] = img.size[1]  

    with open("output.csv", "w", newline="") as csvfile:
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
    archivo["id"] = archivo["id"].str.replace(f"{fname}", "")  # Limpiar nombres de ID
        
    matrix = archivo.to_numpy()
    nombres = []
    coordenadas = []
    valoresX = matrix[:, 1::2]
    valoresY = matrix[:, 2::2]

    for i in matrix:
        nombres.append(i[0])

    for i, nombre in enumerate(nombres):
        altura = image_heights.get(nombre, 0) 
        lista_tuplas = list(zip(valoresX[i], abs(altura - valoresY[i])))
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

    os.remove("output.csv")
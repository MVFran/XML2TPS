def csv2tps(csvfile, tpsfile, images, mlmformat = True, fname = ''):
    import pandas as pd 
    archivo = pd.read_csv(f"{csvfile}") 
    if mlmformat == True:
        archivo = archivo.drop(columns = ["box_id","box_top", "box_left", "box_width", "box_height"], axis = 1)
        archivo["id"] = archivo["id"].str.replace(f"{fname}", "")
        
    matrix = archivo.to_numpy()
    nombres = []
    coordenadas = []
    valoresX = matrix[:, 1::2]
    valoresY = matrix[:, 2::2]
 
    from PIL import Image
    import os
    image_sizes = {}
    valid_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff')

    for filename in os.listdir(images):
        if filename.lower().endswith(valid_extensions):
            image_path = os.path.join(images, filename)
            with Image.open(image_path) as img:
                image_sizes[filename] = img.size
    
    alturas = []
    for size in image_sizes.items():
        alturas.append(size[1][1])

    for i in matrix:
        nombres.append(i[0])
    for i in range(len(valoresX)):
        lista_tuplas = list(zip(valoresX[i],(abs(alturas[i] - valoresY[i]))))
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
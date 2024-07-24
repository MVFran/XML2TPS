def csv2tps(csvfile, tpsfile, mlmformat = True, fname = '', top = 0):
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

    for i in matrix:
        nombres.append(i[0])
    for i in range(len(valoresX)):
        lista_tuplas = list(zip(valoresX[i],(abs(top - valoresY[i]))))
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
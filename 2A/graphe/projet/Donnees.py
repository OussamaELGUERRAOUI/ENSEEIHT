import pandas as pd


# Charger les données de mobilité pour les trois configurations de densité
file_low = 'topology_low.csv'
file_avg = 'topology_avg.csv'
file_high = 'topology_high.csv'



# créer un tableau de données pour chaque configuration pour récupérer les coordonnées de chaque satellite

def recuDonnees(File) :
    
    return pd.read_csv(File)

def GetPoint(indice,df):
    return [df.loc[indice,'x'], df.loc[indice,'y'], df.loc[indice,'z']]

def AllPosition(df):
    L = []
    for i in range(len(df)):
        L.append((df.loc[i,'x'],df.loc[i,'y']))
    return L
        
        

#def GetY(indice,df):
    #return df.loc[indice,'y']/1000

#def GetZ(indice,df):
    #return df.loc[indice,'z']/1000
    
    
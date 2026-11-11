import json
from pathlib import Path

# Nom du fichier contenant les quartiers de Nantes
fichier = Path(__file__).resolve().parent / "244400404_quartiers-de-la-ville-de-nantes.geojson"
# Lecture du fichier GeoJSON
with fichier.open("r", encoding="utf-8") as f:
    donnees = json.load(f)

# Extraction des quartiers
quartiers = donnees["features"]

print("Nombre de quartiers :", len(quartiers))
print("\nListe des quartiers :")

for numero, quartier in enumerate(quartiers, start=1):
    nom = quartier["properties"]["nom"]
    print(numero, "-", nom)

    import pandas as pd

# Création de la table DimQuartier
dim_quartier = pd.DataFrame({
    "id_quartier": range(1, len(quartiers) + 1),
    "nom_quartier": [
        quartier["properties"]["nom"]
        for quartier in quartiers
    ]
})

print("\nTable DimQuartier :")
print(dim_quartier)


# Export de DimQuartier vers un fichier CSV
dim_quartier.to_csv(
    Path(__file__).resolve().parent / "DimQuartier.csv",
    index=False,
    encoding="utf-8"
)

print("Fichier DimQuartier.csv créé avec succès.")


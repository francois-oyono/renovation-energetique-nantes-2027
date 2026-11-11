import pandas as pd

from pathlib import Path

df = pd.read_csv(Path(__file__).parent / "dpe_nantes.csv", nrows=5)

for numero, colonne in enumerate(df.columns, start=1):
    print(numero, colonne)

print(df["surface_habitable_logement"].isna().sum())
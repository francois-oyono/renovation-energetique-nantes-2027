# Rénovation énergétique à Nantes — Stratégie commerciale 2027

** Projet final de formation Data Analyst & Intelligence Artificielle

 OYONO DATA & IA | BTP • Data Analysis • IA générative

## 1. Contexte et problématique métier

 Une entreprise fictive spécialisée dans la rénovation énergétique souhaite identifier les opportunités commerciales sur le territoire de Nantes afin de préparer sa stratégie de développement pour 2027.

** Problématique : Comment exploiter les données de performance énergétique des bâtiments pour identifier les besoins de rénovation, segmenter le marché et orienter les décisions commerciales ?

## 2. Objectifs du projet

- Analyser les diagnostics de performance énergétique (DPE) de Nantes.

- Étudier les différences entre maisons individuelles et appartements.

- Identifier les caractéristiques techniques des logements : surface, période de construction et chauffage.

- Analyser la répartition territoriale des besoins dans les 11 quartiers de Nantes.

- Simuler plusieurs scénarios de potentiel commercial pour 2027.

- Évaluer l'apport de l'IA générative à la production et au contrôle des analyses.

## 3. Technologies utilisées

| Outil | Utilisation |
|---|---|
| MySQL | Stockage, requêtes et contrôles des données |
| Python / Pandas | Nettoyage, préparation et analyse |
| GeoPandas | Rattachement géographique aux quartiers |
| Power BI / DAX | Indicateurs et tableaux de bord décisionnels |
| Excel | Simulation de scénarios commerciaux |
| IA générative | Assistance à la production de tableaux de bord, de simulations et de recommandations |

## 4. Données analysées

L'étude porte sur **133 234 diagnostics DPE**, répartis entre :

- **11 323** diagnostics de maisons individuelles.
- **118 888** diagnostics d'appartements.
- **3 023** diagnostics d'immeubles.

**Précaution méthodologique :** ces volumes correspondent à des diagnostics et non nécessairement à des logements distincts.
## 5. Principaux résultats

- **Maisons individuelles :** 29,42 % des diagnostics sont classés E, F ou G.
- **Appartements :** 15,56 % des diagnostics sont classés E, F ou G.
- **Volume du marché :** les appartements représentent la majorité des diagnostics étudiés.
- **Priorité commerciale 2027 :** les maisons individuelles constituent la cible privilégiée, notamment en raison des possibilités d'intervention sur l'enveloppe thermique (toiture, façades, planchers bas et menuiseries) et d'une prise de décision généralement plus directe.
- **Marché complémentaire :** les appartements conservent un potentiel important, mais certaines interventions peuvent dépendre de décisions collectives en copropriété.

**Limite :** cette priorisation est une recommandation technique et commerciale. Elle ne constitue pas une démonstration de rentabilité.
## 6. Simulation commerciale 2027

Trois scénarios exploratoires ont été construits dans Excel avec l'assistance de l'IA générative :

| Scénario | Chantiers simulés | Chiffre d'affaires simulé |
|---|---:|---:|
| Prudent | 125 | 4 375 000 € |
| Central | 377 | 13 195 000 € |
| Ambitieux | 722 | 25 270 000 € |

**Hypothèses :** taux de captation commerciale variables selon les scénarios et chiffre d'affaires moyen fictif de 35 000 € par chantier.

**Précaution :** ces simulations sont exploratoires et ne constituent pas des prévisions garanties. Elles ne démontrent pas la rentabilité des chantiers.

## 7. Apport de l'intelligence artificielle

Une expérimentation complémentaire a permis de produire, avec l'assistance de l'IA générative :

- Un tableau de bord Power BI à partir des données préparées.
- Une seconde page d'analyse Power BI.
- Un tableau de bord Excel.
- Un simulateur Excel comportant trois scénarios commerciaux pour 2027.

### Résultats de l'expérimentation

| Réalisation assistée par l'IA | Temps de production |
|---|---:|
| Tableau de bord Power BI initial | 11 min 01 s |
| Deuxième page Power BI | 3 min 55 s |
| Tableau de bord Excel | 3 min 07 s |
| Simulateur commercial Excel | 1 min 27 s |

### Contrôle et validation

Les résultats produits avec l'IA ont été confrontés aux analyses réalisées avec MySQL et Power BI.

**Enseignement principal :** l'IA accélère la production des analyses, tandis que le Data Analyst conserve la responsabilité du cadrage métier, de l'interprétation et de la validation des résultats.

## 8. Recommandation commerciale

Pour préparer la stratégie commerciale 2027, quatre orientations sont proposées :

1. **Prioriser les maisons individuelles énergivores**, notamment les classes E, F et G, pour les possibilités de rénovation de l'enveloppe thermique : toiture, façades, planchers bas et menuiseries.

2. **Conserver les appartements comme marché complémentaire**, compte tenu de leur volume important, tout en intégrant les contraintes techniques et les décisions collectives en copropriété.

3. **Réaliser des études technico-économiques préalables** pour évaluer les coûts des travaux, les marges potentielles et les conditions réelles de réalisation des chantiers.

4. **Utiliser les tableaux de bord Power BI et les simulations Excel** comme outils d'aide à la décision, sans assimiler le chiffre d'affaires simulé à une rentabilité démontrée.
   
## 9. Livrables du projet

Les livrables prévus dans le cadre de ce projet sont :

- Base de données et analyses SQL.
- Scripts de préparation et de nettoyage Python.
- Tableau de bord décisionnel Power BI.
- Simulateur commercial Excel.
- Note de recommandations au directeur général.
- Présentation de soutenance.
- Expérimentation documentée de l'IA générative.

**Publication :** les fichiers correspondants seront ajoutés progressivement à ce dépôt, selon leur disponibilité et leur aptitude à être publiés.

**Auteur :** François Oyono

**Portfolio :** [OYONO DATA & IA](https://francois-oyono.github.io/portfolio-btp-data/)

**Positionnement :** Ingénierie BTP • Data Analysis • Intelligence artificielle générative

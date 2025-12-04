# Graph vs Relational Databases – MovieLens Benchmark

Projet comparatif entre **base de données relationnelle** et **base de données graphe (Neo4j)**, réalisé à partir du dataset MovieLens.  
L’objectif est d’évaluer les performances, l’expressivité et la pertinence de chaque modèle via un ensemble commun de requêtes.

---

## 📌 Sommaire

- [Graph vs Relational Databases – MovieLens Benchmark](#graph-vs-relational-databases--movielens-benchmark)
  - [📌 Sommaire](#-sommaire)
  - [🎯 Objectif du projet](#-objectif-du-projet)
  - [📂 Données utilisées](#-données-utilisées)
  - [✨ Fonctionnalités](#-fonctionnalités)
  - [🧩 Structure du projet / Architecture](#-structure-du-projet--architecture)
  - [📊 Types de requêtes testées](#-types-de-requêtes-testées)
    - [1. Sélection](#1-sélection)
    - [2. Agrégation](#2-agrégation)
    - [3. Path / Traversée](#3-path--traversée)
    - [4. Métriques graphes](#4-métriques-graphes)
  - [🚀 Installation \& Exécution](#-installation--exécution)
    - [Étapes d’installation](#étapes-dinstallation)
  - [🛠️ Technologies \& Outils utilisés](#️-technologies--outils-utilisés)
  - [👥 Auteur \& Licence](#-auteur--licence)

---

## 🎯 Objectif du projet

Le but de ce projet est de **comparer objectivement** une base de données relationnelle et une base de données graphe :

- Mesurer leurs performances sur un **ensemble identique de données** (MovieLens).  
- Vérifier leur comportement sur plusieurs familles de requêtes : sélection, agrégation, parcours, métriques graphes.  
- Évaluer la difficulté d’expression d’une requête en SQL vs Cypher.  
- Analyser l’impact du modèle de données sur :
  - la rapidité d’exécution  
  - la lisibilité des requêtes  
  - la facilité de modélisation  
  - les cas d’usage adaptés à chaque technologie  

Pour garantir l’équité, **les mêmes données sont chargées dans les deux bases** et le benchmark est exécuté dans le même environnement matériel.

---

## 📂 Données utilisées

Les données proviennent du dataset **MovieLens** publié par **GroupLens Research** :  
👉 [https://grouplens.org/datasets/movielens/](https://grouplens.org/datasets/movielens/)

Le projet utilise les fichiers CSV suivants (provenant et/ou adaptés du dataset) :

- `movies.csv` — Informations sur les films  
- `users.csv` — Utilisateurs  
- `actors.csv`  
- `directors.csv`  
- `movies2actors.csv`  
- `movies2directors.csv`  
- `follow.csv` — Relations utilisateur–utilisateur  
- `u2base.csv` — Notes (ratings)

Ces fichiers alimentent :

- **une base relationnelle** via `creation.sql`
- **une base graphe Neo4j** via `Script Graph.txt`

---

## ✨ Fonctionnalités

- Création automatique de la **base relationnelle** (tables + clés)  
- Création automatique de la **base graphe** (labels + relations)  
- Chargement identique des mêmes données dans les deux systèmes  
- Exécution d’un ensemble d’une **dizaine de requêtes de comparaison**  
- Comparaison SQL ↔ Cypher pour chaque requête  
- Analyse des cas où chaque modèle est plus adapté  
- Benchmark de performance

---

## 🧩 Structure du projet / Architecture

```text
graph_or_relational/
├── actors.csv
├── directors.csv
├── follow.csv
├── movies.csv
├── movies2actors.csv
├── movies2directors.csv
├── users.csv
├── u2base.csv
│
├── creation.sql # Script création base relationnelle
├── Script Graph.txt # Script création base Neo4j
│
├── queries.txt # Ensemble complet (SQL + Cypher)
└── selected.sql # Les 10 requêtes sélectionnées
```

---

## 📊 Types de requêtes testées

Le fichier `queries.txt` contient de nombreuses requêtes en **SQL** et en **Cypher**, couvrant différentes catégories :

### 1. Sélection

Exemple :  
> récupérer tous les utilisateurs ayant noté un film

### 2. Agrégation

Exemple :  
> trouver le film qui possède le plus de notes

### 3. Path / Traversée

Exemple :  
> trouver les films notés par des utilisateurs ayant eux-mêmes peu de notes

### 4. Métriques graphes

Exemple :  
> utilisateurs ayant le plus interagi avec les films d’un même réalisateur

Les **10 requêtes retenues** pour la comparaison finale sont disponibles dans `selected.sql`.

---

## 🚀 Installation & Exécution

### Étapes d’installation  

1. Cloner le dépôt :

   ```bash
   git clone https://github.com/nchrismant/graph_or_relational.git
   cd graph_or_relational
   ```

2. Importer la base de données MySQL à partir du fichier `ddl.sql`.
3. Importer la base de données Graph (Neo4j) à partir du fichier `Script Graph.txt`.
4. Exécuter les requêtes de comparaison: Toutes les requêtes : `queries.txt`, Top 10 requêtes pour benchmarking : `selected.sql`.

---

## 🛠️ Technologies & Outils utilisés

| Technologie         | Rôle              |
| ------------------- | ----------------- |
| **MySQL**           | Base de données relationnelle |
| **Neo4j**      | Base de données Graph |

---

## 👥 Auteur & Licence

- **Auteur** : Nathan Chrismant — Étudiant M1 Informatique, Cergy Paris Université.

Projet distribué sous licence **Open Source**.

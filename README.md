# 🌟 API Pokémon en Gleam 🌟

[![Gleam](https://img.shields.io/badge/Gleam-FFD54F?style=for-the-badge&logo=gleam&logoColor=black)](https://gleam.run/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![API](https://img.shields.io/badge/API-REST-009688?style=for-the-badge)](https://restfulapi.net/)
[![Licence](https://img.shields.io/badge/Licence-MIT-blue?style=for-the-badge)](https://opensource.org/licenses/MIT)

Une API simple permettant de récupérer des informations sur les Pokémon via leur ID ou leur nom.

## ✨ Fonctionnalités

L'API expose les routes suivantes :

- `GET /` - La homepage avec tout les pokemons affiché
- `GET /pokemon/{id}` - Récupère les informations d'un Pokémon via son ID et affiche la page d'information
- `GET /id/{id du pokemon}` - Récupère les informations d'un Pokémon via son ID
- `GET /name/{nom du pokemon}` - Récupère les informations d'un Pokémon via son nom
- `GET /all/` - Récupère les informations de tout les Pokémons
- `GET /search/{nom du pokemon}` - Récupère les informations d'un Pokémon via son le début de son nom

## 📋 Prérequis

- 🐳 Docker
- 🛠️ Make

## 🚀 Installation et lancement

1. Clonez ce dépôt :

```bash
git clone https://github.com/RedginaldGodeau/pokedex-gleam.git
cd pokedex-gleam
```

2. Créer le .env.local :

Copier le .env et nommé le .env.local et ajouter les différantes valeurs.

3. Lancez le projet avec Make :

```bash
make run
```

Cela va construire et démarrer les conteneurs Docker nécessaires au fonctionnement de l'API.

## 🔍 Exemples d'utilisation

```bash
# Récupérer tous les pokemons
curl http://localhost:8080/all

# Récupérer les informations du Pokémon avec l'ID 25 (Pikachu)
curl http://localhost:8080/id/25

# Récupérer les informations du Pokémon nommé "Charizard"
curl http://localhost:8080/name/charizard

# Récupérer les informations des Pokémon qui commence par  "char"
curl http://localhost:8080/name/char
```

## 📊 Source des données

Les données Pokémon utilisées dans ce projet ont été récupérées depuis :
https://gist.github.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6

## 🔮 Axes d'amélioration

Voici quelques axes d'amélioration envisagés pour ce projet :

### 🖥️ Ajouter du css & du js ou un front-end externe avec lustre

- intergré le static file pour ajouter le main.css
- refaire le front-end à part du projet

### ⚠️ Optimisation des erreurs

- Améliorer la gestion des erreurs avec des messages plus explicites
- Mettre en place un système de logging détaillé
- Développer une documentation d'API avec des codes d'erreur standardisés

## 👤 Auteur

Redginald Godeau

---

⭐ N'hésitez pas à star le projet si vous l'appréciez ! ⭐

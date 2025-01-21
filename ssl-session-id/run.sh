#!/bin/bash

# Vérifier si Python est installé
if ! command -v python3 &> /dev/null; then
    echo "Python3 n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Vérifier si pip est installé
if ! command -v pip3 &> /dev/null; then
    echo "pip3 n'est pas installé. Installation de pip3..."
    python3 -m ensurepip --upgrade
    if [ $? -ne 0 ]; then
        echo "Échec de l'installation de pip. Veuillez vérifier votre configuration Python."
        exit 1
    fi
fi

# Mettre à jour pip
echo "Mise à jour de pip..."
pip3 install --upgrade pip

# Installer les dépendances
echo "Installation des dépendances Python : requests et pyOpenSSL..."
pip3 install requests pyOpenSSL

# Vérifier si les installations ont réussi
if [ $? -eq 0 ]; then
    echo "Toutes les dépendances ont été installées avec succès !"
else
    echo "Erreur lors de l'installation des dépendances. Veuillez vérifier votre environnement."
    exit 1
fi

# Quickdyn-island

# Projet de Barre type dynamic island pour hyprland

## Dynamic Island

Cette barre de shell implémente une logique de Dynamic Island inspirée d'iOS :
- **Affichage par défaut** : L'horloge est affichée au centre de la barre
- **Interactions** : Lors d'un changement de luminosité ou de volume (via les raccourcis Hyprland), la barre se transforme dynamiquement :
  - L'horloge est remplacée par une jauge de contrôle
  - Une icône correspondante apparaît à gauche (soleil pour luminosité, haut-parleur pour volume)
  - Le pourcentage est affiché à droite de la jauge
- **Retour automatique** : Après un délai d'inactivité, la barre revient à l'affichage de l'horloge

### Technologies utilisées
- **Quickshell** : Framework principal pour la barre Wayland
- **Hyprland** : Gestionnaire de fenêtres avec raccourcis clavier pour le contrôle du volume et de la luminosité
- **APIs natives Quickshell** : Pour la lecture en temps réel des valeurs système

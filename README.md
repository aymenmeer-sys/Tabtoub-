# Tabtoub Fly

Suivi de vols en direct (OpenSky + OpenStreetMap), météo des aéroports (Open-Meteo),
abonnements simulés (shared_preferences).

## Obtenir l'APK sans coder
1. Créer un dépôt GitHub et y envoyer **tout le contenu de ce dossier** (y compris `.github/`).
2. Onglet **Actions** → le workflow « Build APK » se lance à chaque push (ou « Run workflow »).
3. Après ~5-8 min, l'APK est dans **Releases** (`app-release.apk`). L'installer sur Android
   (autoriser les sources inconnues).

## Notes
- Les données viennent de l'API anonyme d'OpenSky : limitée en requêtes (30 s d'intervalle OK).
  Elle peut répondre 429 si on rafraîchit trop souvent ; le bouton « Réessayer » relance.
- Seuls les vols de la zone visible de la carte sont chargés (plafond 700 marqueurs).
- Les plans Silver/Gold/Business sont une **simulation** : aucun paiement, aucune fonction verrouillée.
- APK signé avec la clé debug (suffisant pour installer en test).

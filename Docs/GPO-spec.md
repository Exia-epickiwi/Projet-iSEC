# Spécifications GPO

Les GPO requises dans l'AD iSEC

* Configurer les groupes et utilisateurs pour le domaine (group.local)
* Configurer les groupes et utilisateurs pour le domaine (isec-telecom.local)
* Pour chaque service, un partage spécifique monté sur le disque réseau `S:`
* Pour la filliale group, configurer un partage monté dans `G:`
* Pour la filliale Telecom, configurer un partage monté dans `T:`
* Pour chaque utilisateur, configurer un partage personnel et y définir le dossier personnel de chaque utilisateur
* Créer des imprimantes PDF et les mettre à disposition de toute l'entreprise
* Fond d'écran par service
* Mot de passe
  * Renouvelé apres 90 jours
  * Pas de complexité élevée
  * 8 carractères
  * Vérouillage apres 3 essais
* Pas d'éxécution automatique des périphériques amovibles
  * La lecture est toujours possible
* Installer l'application 7zip sur tout les postes a l'aide des GPO

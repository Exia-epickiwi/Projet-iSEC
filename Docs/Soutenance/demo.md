# Démonsration iSEC

5 min de présentation
15 min de démo
10 min de questions

## Matériel

* PC de Baptiste
    * Présentation

* PC de Jean Guillaume
    * 1 VM Windows 7 connectée au réseau `isec-group.local`
    * 1 VM Windows 10 connectée au réseau `isec-telecom.local`

* PC de Tanguy le babe
    * 1 VM Windows 8.1 connectée au réseau `isec-telecom.local` !! A CHANGER !!
    * 1 VM Windows 7 connectée au réseau `isec-group.local` 
    * 1 client vSphere Windows Server master

* OnePlus 3 <3 de Tanguy <3
    * Partage de connexion (Quatre)

* Commutateur de type celui qu'on a 

## Scénario

**Aller lentement et exposer le fonctionnement de chaque GPO**

* **Présentateur** : Tanguy
* **Manipulateur** : Jean-Guillaume
* **Complice & présentation Centreon** : Baptiste

1. **Connexion avec `ldeget` (W 7 Jean Guillaume)**
    * On montre le fond d'écran personnalisé, où ils sont stockés et par quels moyens on les paramètrent
2. **On insère un CD dans le système**
    * On montre la désactivation de l'AutoRun
3. **On ouvre `Ce PC` et on présente chacun des partages**
4. **Un complice `bcolmard` (W 7 Tanguy) glisse une archive `.7z` contenant la présentation HTML dans le dossier de partage du service `S:`**
5. **Sur le compte `ldeget`**
    * Grace a 7z préinstallé, on peut ouvrir l'archive
    * On extrait la présentation dans les documents
6. **On se deconnecte de la première machine (`ldeget`)**
7. **Tanguy** devient **manipulateur**, **Jean-Guillaume** devient **présentateur**
8. **`ldeget` se connecte sur la machine du complice (W 7 Tanguy)**
    * On découvre *avec stupéfaction* que les documents sont synchronisés
9. **On imprime la présentation décompressée pour un max de swag**
    * On vérifie sur le serveur (manque la license PDFCreator pour auto save) (PC Tanguy)
10. **On bloque le compte de `ldeget` par 3 faux mot de passe successifs**
11. **On se connecte sur `bsaclier` (W 7 Tanguy), un compte du groupe télécom depuis le pc présent sur `isec-group.local`**
    * Cela ne fonctionne pas car on a une relation d'approbation unidirectionnelle
12. **On se connecte sur un PC de `isec-telecom.local` (W 8.1 Tanguy) avec `bsaclier`**
13. **On se connecte avec `hleleu` sur un ordinateur (W 8.1 Tanguy) de `isec-telecom.local` Bonjour -> Panic button**
14. **Centreon avec poller et le complice éteint le serveur Windows Master (PC Baptiste)**
    * Présentation des différents hosts
    * Présentation des services et leur utilité
    * Présentation du reporting et du SLA
    * Présentation du poller distant
15. **Reconnexion pour montrer le bon fonctionnement réplica avec `bcolmard` (W 7 Jean Guillaume)**
16. **On finit par dire que tout n'est pas démontrable mais qu'on peut montrer les GPOs si besoin pdt les questions**
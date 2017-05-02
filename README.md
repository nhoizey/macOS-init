**⚠️ Ce script a été conçu pour mes besoins. Avant de l'utiliser pensez bien [à le modifier](https://github.com/nhoizey/macOS-post-installation#comment-lutiliser) en fonction de vos besoins ! ⚠️**

## Présentation

Ce script initialement très largement inspiré de [celui de Nicolas Furno](https://github.com/nicolinuxfr/macOS-post-installation), qu'il a [décrit dans un article MacGénération](https://www.macg.co/logiciels/2017/01/un-script-pour-configurer-automatiquement-un-nouveau-mac-96652), est maintenant passé à l'utilisation de [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) grâce à la suggestion de [Thomas Parisot](https://twitter.com/oncletom), et me permet d'installer les logiciels que j'utilise et de configurer quelques paramètres automatiquement après l'installation de macOS.

Ce script exploite exclusivement des lignes de commande Shell et il n'a ainsi aucune dépendance. Quelques pré-requis toutefois :

- Il faut être administrateur du Mac pour l'utiliser (il exploite la commande `sudo`) ;
- Il faut s'être connecté au préalable dans le Mac App Store ;
- Les apps à installer depuis la boutique d'Apple doivent déjà être associées à votre compte iTunes Store, donc avoir déjà été achetées, ou téléchargées au moins une fois si elles sont gratuites.

Le script exploite [Homebrew](http://brew.sh "Homebrew — The missing package manager for macOS"), [Cask](https://caskroom.github.io) et [mas](https://github.com/mas-cli/mas) pour installer les apps, [mackup](https://github.com/lra/mackup) pour restaurer des préférences depuis une installation précédente ou un autre Mac. Plus de nombreuses idées piochées [à droite et à gauche](https://github.com/nicolinuxfr/macOS-post-installation#inspirations).

*Testé avec macOS Sierra.*

## Comment l'utiliser ?

Voici comment utiliser les deux scripts :

### Installation initiale de l'OS vierge

1. Installez macOS
1. Lancez le Mac App Store et connectez-vous à votre compte

### Première étape

1. Téléchargez la dernière version du projet ([lien direct](https://github.com/nhoizey/macOS-init/archive/master.zip)) ;
1. Ouvrez les fichiers `post-install.sh` et `Brewfile`, et modifiez ce qui est installé par défaut ;
1. Pensez à changer la ligne `open -a Dropbox` de [`post-install.sh`](https://github.com/nhoizey/macOS-init/blob/master/post-install.sh) en fonction du service Cloud utilisé, ou alors à la supprimer si vous ne voulez pas en utilisez ;
1. À partir de la ligne `## *************** CONFIGURATION ***************`, le script configure quelques réglages par défaut, à modifier selon vos besoins ;
1. [Ouvrez ensuite le Terminal de macOS](http://fr.wikihow.com/ouvrir-le-Terminal-sur-un-Mac), glissez le fichier `post-install.sh` depuis le Finder vers le Terminal, et appuyez sur la touche <kbd>Entrée</kbd> et accrochez votre ceinture ;

Le script fonctionnera largement sans votre intervention, sauf :

  - pour valider l'installation de Homebrew ;
  - pour saisir le mot de passe administrateur pour Homebrew ;
  - pour le mot de passe administrateur nécessaire pour Cask ;
  - pour certains logiciels qui nécessitent un accès admin ;

Si tout va bien, il se terminera normalement sans erreur, mais en cas d'erreur, vous pourrez relancer le script et seul ce qui n'a pas déjà été installé, sera installé ;

### Seconde étape

Quand le premier script est terminé, et quand vos données sont synchronisées depuis le cloud :

1. Ouvrez le fichier `post-cloud.sh` et modifiez la [ligne 8](https://github.com/nhoizey/macOS-init/blob/master/post-cloud.sh#L8) en fonction du service de Cloud choisi, ou laissez-la en commentaire si vous utilisez Dropbox (choix par défaut) ;
1. Glissez le fichier `post-cloud.sh` du Finder vers le Terminal, et appuyez sur la touche <kbd>Entrée</kbd> pour finir l'installation.

## TL;DR réservé à Nicolas

Cette automatisation supplémentaire lance directement l'installation de **ma propre sélection** d'applications :

```shell
$ curl -sfL https://nhoizey.github.io/macOS-init/run.sh | sh
```

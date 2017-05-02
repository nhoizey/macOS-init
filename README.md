**⚠️ Ce script a été conçu pour mes besoins. Avant de l'utiliser pensez bien [à le modifier](https://github.com/nhoizey/macOS-post-installation#comment-lutiliser) en fonction de vos besoins ! ⚠️**

## Présentation

Ce script initialement très largement inspiré de [celui de Nicolas Furno](https://github.com/nicolinuxfr/macOS-post-installation), qu'il a [décrit dans un article MacGénération](https://www.macg.co/logiciels/2017/01/un-script-pour-configurer-automatiquement-un-nouveau-mac-96652), est maintenant passé à l'utilisation de [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) grâce à la suggestion de [Thomas Parisot](https://twitter.com/oncletom), et me permet d'installer les logiciels que j'utilise et de configurer quelques paramètres automatiquement après l'installation de macOS.

Ce script exploite exclusivement des lignes de commande Shell et il n'a ainsi aucune dépendance. Quelques pré-requis toutefois :

- Il faut être administrateur du Mac pour l'utiliser ;
- Il faut s'être connecté au préalable dans le Mac App Store ;
- les apps à installer depuis la boutique d'Apple doivent déjà être associées à votre compte iTunes Store.

Le script exploite [Homebrew](http://brew.sh "Homebrew — The missing package manager for macOS"), [Cask](https://caskroom.github.io) et [mas](https://github.com/mas-cli/mas) pour installer les apps, [mackup](https://github.com/lra/mackup) pour restaurer des préférences depuis un autre Mac. Plus de nombreuses idées piochées [à droite et à gauche](https://github.com/nicolinuxfr/macOS-post-installation#inspirations).

*Testé avec macOS Sierra.*

## Comment l'utiliser ?

Voici comment utiliser les deux scripts :

- Téléchargez la dernière version du projet ([lien direct](https://github.com/nhoizey/macOS-init/archive/master.zip)) ;
- ouvrez les fichiers `post-install.sh` et `Brewfile`, et modifiez ce qui est installé par défaut ;
- pensez à changer la ligne `open -a Dropbox` de [`post-install.sh`](https://github.com/nhoizey/macOS-init/blob/master/post-install.sh) en fonction du service de Cloud utilisé, ou alors à la supprimer si vous ne voulez pas en utilisez un ;
- à partir de la ligne `## *************** CONFIGURATION ***************`, le script configure quelques réglages par défaut, à modifier selon vos besoins ;
- ouvrez ensuite le Terminal de macOS, glissez le fichier `post-install.sh` appuyez sur la touche entrée et accrochez votre ceinture ;
- le script fonctionnera largement sans votre intervention, sauf :
  - pour valider l'installation de Homebrew ;
  - pour saisir le mot de passe administrateur pour Homebrew ;
  - pour le mot de passe administrateur nécessaire pour Cask ;
  - pour certains logiciels qui nécessitent un accès admin ;
- si tout va bien, il se terminera normalement sans erreur, mais en cas d'erreur, vous pourrez relancer le script et seul ce qui n'a pas déjà été installé, sera installé ;
- quand le premier script est terminé, et quand vos données sont synchronisées depuis le cloud, ouvrez le fichier `post-cloud.sh` :
  - [ligne 8](https://github.com/nhoizey/macOS-init/blob/master/post-cloud.sh#L8), modifiez cette ligne en fonction du service de Cloud choisi, ou laissez-la en commentaire si vous utilisez Dropbox (choix par défaut) ;
- toujours dans le Terminal, glissez le fichier `post-cloud.sh` avant de valider avec la touche entrée pour finir l'installation.

## TL;DR réservé à Nicolas

```shell
$ curl -sfL https://nhoizey.github.io/macOS-init/run.sh | sh
```
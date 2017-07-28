**⚠️ Ce script a été conçu pour mes besoins. Avant de l'utiliser pensez bien [à le modifier](https://github.com/nhoizey/macOS-init#comment-lutiliser) en fonction de vos besoins ! ⚠️**

## Présentation

Voir la présentation détaillée dans mon billet de blog « [automatiser l'installation des applications sur un nouveau Mac](https://nicolas-hoizey.com/2017/05/automatiser-l-installation-des-applications-sur-un-nouveau-mac.html) ».

## Utilisation

### Installation initiale de l'OS vierge

1. Installez macOS
1. Lancez le Mac App Store et connectez-vous à votre compte

⚠️ Attention, si vous migrez depuis une autre machine ou faites une réinstallation complète, utilisez tant que possible le même *username*, sinon Mackup ne fera pas les bonnes actions pour récupérer les paramètres des applications.

### Première étape

1. Téléchargez la dernière version du projet ([lien direct](https://github.com/nhoizey/macOS-init/archive/master.zip)) ;
1. Ouvrez les fichiers `post-install.sh` et `Brewfile`, et modifiez ce qui est installé par défaut ;
1. Pensez à changer les lignes `brew cask install dropbox` et `open -a Dropbox` de [`post-install.sh`](https://github.com/nhoizey/macOS-init/blob/master/post-install.sh) en fonction du service Cloud utilisé, ou alors à la supprimer si vous ne voulez pas en utilisez ;
1. À partir de la ligne `## *** CONFIGURATION ***`, le script configure quelques réglages par défaut, à modifier selon vos besoins ;
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

Voilà, c'est opérationnel.

### Mises à jour ultérieures

1. Lancez le script `update.sh` pour mettre à jour toutes les applications qui le nécessitent.

## TL;DR réservé à Nicolas

Cette automatisation supplémentaire lance directement l'installation de **ma propre sélection** d'applications :

```shell
$ curl -sfL https://nhoizey.github.io/macOS-init/run.sh | sh
```

Bootstrap 3
===========

Module intégrant le framework CSS Twitter Bootstrap 3.
http://getbootstrap.com/getting-started/

Grille CSS
----------

Il y a trois types de composants:

-   **[bootstrap3:container]** Pour le conteneur CSS
-   **[bootstrap3:row]** La ligne, point de départ vertical dans le flux HTML
-   **[bootstrap3:column]** La colonne, point de départ horizontal dans le flux HTML

Voici le code pour obtenir une grille comme le montre l’image ci-dessous

      <div class="container">
          <div class="col-xs-1"></div> <!-- x12 -->
          <div class="col-xs-4"></div> <div class="col-xs-4"></div> <div class="col-xs-4"></div>
          <div class="col-xs-4"></div> <div class="col-xs-8"></div>
          <div class="col-xs-6"></div> <div class="col-xs-6"></div>
          <div class="col-xs-12"></div>
       </div>

Les colonnes utilisent les classes **.col-xs-*** puisque ce sont les seules classes fonctionnant sans Media Queries.
L’ajout d’une colonne laisse le choix de ne pas utiliser une classe de répartition mais simplement une classe de positionnement telle que **.pull-right** ou **.pull-left**.

Listes de contenu
-----------------

3 vues supplémentaires paramétrables ont été ajoutées pour les listes de contenu Jahia **[jmix:list]**.

### Liste tabulaire

La liste tabulaire correspond à la vue **linkTabs**

http://getbootstrap.com/components/#nav-tabs

### Liste en colonnes

La liste en colonnes correspond à la vue **columns** dans laquelle ont peux spécifier :

-   **j:columns** le nombre de colonne par ligne

### Carousel

La liste en colonnes correspond à la vue **carousel** ou l’ou peux règler :

-   **jcr:title** : le titre du carousel
-   **displayControls** : l’affichage des boutons de contrôle droit et gauche
-   **numberToDisplay** : le nombre d‘éléments visibles pour chaque itération
-   **interval** : la vitesse de défilement

http://getbootstrap.com/javascript/#carousel


Installation
------------

### Maven

Le module est disponible sur le repository maven :
    <repository>
        <id>smile-github-repository</id>
        <name>Smile Github repository</name>
        <url>http://smile-sa.github.com/maven-repository/releases</url>
    </repository>

L'artifact est :    
    
        <dependency>
            <groupId>org.jahia.modules</groupId>
            <artifactId>bootstrap3</artifactId>
            <version>2.1</version>
            <type>jar</type>
        </dependency>
        

    

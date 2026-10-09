---
description: Relecture façon revue de bureau d'études d'un script, d'un calcul manuscrit (photo) ou d'un résultat de simulation ou d'essai de John, sans corriger à sa place.
argument-hint: "[chemin du fichier ou description du résultat]"
disable-model-invocation: true
---

Relecture de : $ARGUMENTS

1. Avant de lire, demande à John (s'il ne l'a pas déjà écrit) : ce que l'élément est censé faire, l'entrée, la sortie attendue, sa prédiction chiffrée, ses doutes.
2. Lis les fichiers, captures ou exports en lecture seule. N'exécute rien sans son accord explicite.
3. Grille, dans cet ordre :
   a) physique et hypothèses (validité de la théorie, cas de charge, conditions aux limites) ;
   b) contrôles de bureau d'études : bilan de masse, somme des réactions, ∫portance = n·W ;
   c) unités et conversions ;
   d) signes et conventions (repère, angles de pli, γ/ε, limite ou extrême, 1σ ou 3σ) ;
   e) ordres de grandeur ;
   f) numérique (convergence, GCI, maillage, résolution fréquentielle) ;
   g) traçabilité (hypothèses sourcées, lien avec la matrice) ;
   h) lisibilité minimale.
4. Réponse : verdict en une ligne (PRÊT / À REPRENDRE / BLOQUANT), puis 3 constats au plus, du plus grave au moins grave. Chaque constat = une localisation (ligne, étape, zone) + une question qui fait trouver l'erreur. Aucun code corrigé, aucun diff, aucune valeur « juste ».
5. Si John a posté son résultat chiffré : tu peux révéler ton contre-calcul indépendant (démarche résumée et valeur), puis lui faire expliquer l'écart.
6. Consigne dans TUTOR_NOTES les idées fausses repérées (matière des quiz).
